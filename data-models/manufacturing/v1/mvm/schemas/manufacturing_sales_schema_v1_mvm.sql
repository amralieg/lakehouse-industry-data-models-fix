-- Schema for Domain: sales | Business: Manufacturing | Version: v1_mvm
-- Generated on: 2026-05-06 09:42:37

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `manufacturing_ecm`.`sales` COMMENT 'Sales and commercial domain managing the revenue pipeline including opportunities, quotes, proposals, contracts, order intake, sales pipeline tracking, territory management, and commercial KPIs for industrial automation and electrification products via Salesforce Sales Cloud.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `manufacturing_ecm`.`sales`.`opportunity` (
    `opportunity_id` BIGINT COMMENT 'Unique identifier for the sales opportunity record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer account associated with this opportunity.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: In industrial manufacturing, opportunities target a specific customer plant (e.g., upgrading a production line at Plant X). Linking opportunity to account_site enables site-level pipeline reporting, c',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Pipeline reporting by legal entity: industrial manufacturers with multiple subsidiaries track opportunities per company code for revenue forecasting, transfer pricing compliance, and entity-level P&L ',
    `contract_id` BIGINT COMMENT 'Reference to the resulting contract or order if the opportunity was won and converted.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pipeline forecasting allocates expected costs to cost centers for budgeting purposes.',
    `customer_contact_id` BIGINT COMMENT 'Reference to the primary contact person at the customer account for this opportunity.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Opportunity tracking of a specific material enables demand forecasting and aligns inventory planning.',
    `price_book_id` BIGINT COMMENT 'Foreign key linking to sales.price_book. Business justification: In industrial automation sales, an opportunity is worked against a specific price book (standard, customer-specific, or regional). Linking opportunity to price_book establishes which pricing framework',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Opportunity reporting by product family is essential for portfolio performance analysis and strategic sales planning.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Opportunity stage forecasts profit per profit center, supporting sales‑finance alignment.',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: New product opportunities trigger an engineering project; linking enables tracking of project initiation and status.',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Opportunity is owned by a sales rep; adding sales_rep_id FK enables proper ownership tracking.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Opportunity pipeline and forecasting require linking each opportunity to the exact SKU being pursued, enabling accurate demand planning and revenue projection.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Opportunity stores territory as free text; adding opportunity_territory_id creates a proper link to sales.territory, enabling consistent reporting and removing redundant string column.',
    `amount` DECIMAL(18,2) COMMENT 'Total estimated revenue value of the opportunity in the base currency. Represents the gross deal size before discounts.',
    `close_date` DATE COMMENT 'Target date by which the opportunity is expected to close (win or loss decision).',
    `closed_date` DATE COMMENT 'Actual date when the opportunity was marked as closed (won or lost). Null if still open.',
    `competitor_name` STRING COMMENT 'Name of the primary competitor identified in this sales opportunity.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the opportunity location.. Valid values are `^[A-Z]{3}$`',
    `created_date` TIMESTAMP COMMENT 'Timestamp when the opportunity record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the opportunity amount (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `delivery_installation_status` STRING COMMENT 'Current status of product delivery and installation for won opportunities. Tracks post-sale fulfillment.. Valid values are `not_started|in_progress|completed|on_hold`',
    `discount_percent` DECIMAL(18,2) COMMENT 'Total discount percentage applied to the opportunity amount. Used for pricing and margin analysis.',
    `expected_revenue` DECIMAL(18,2) COMMENT 'Probability-weighted revenue calculated as amount multiplied by probability percentage. Used for forecast accuracy.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter in which the opportunity is expected to close (e.g., Q1 FY2024). Used for quota and forecast alignment.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the opportunity is expected to close. Used for annual revenue planning.',
    `forecast_category` STRING COMMENT 'Sales forecast classification indicating confidence level for revenue planning and quota tracking.. Valid values are `pipeline|best_case|commit|closed`',
    `has_open_activity` BOOLEAN COMMENT 'Boolean indicator whether there are open tasks or activities associated with this opportunity. Used for pipeline health monitoring.',
    `industry_segment` STRING COMMENT 'Target industry vertical or market segment for this opportunity (e.g., automotive, food and beverage, pharmaceuticals).',
    `is_closed` BOOLEAN COMMENT 'Boolean indicator whether the opportunity has reached a final closed state (won or lost).',
    `is_private` BOOLEAN COMMENT 'Boolean indicator whether the opportunity is marked as private with restricted visibility.',
    `is_won` BOOLEAN COMMENT 'Boolean indicator whether the opportunity was closed as won (deal successfully secured).',
    `last_activity_date` DATE COMMENT 'Date of the most recent sales activity (call, meeting, email) logged against this opportunity.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when the opportunity record was last updated.',
    `lead_source` STRING COMMENT 'Original source or channel through which the opportunity was generated.. Valid values are `web|trade_show|referral|partner|cold_call|campaign`',
    `loss_reason` STRING COMMENT 'Primary reason why the opportunity was lost. Used for win/loss analysis and competitive intelligence.. Valid values are `price|competitor|no_decision|timing|product_fit|budget`',
    `next_step` STRING COMMENT 'Description of the next planned action or milestone to advance the opportunity.',
    `opportunity_description` STRING COMMENT 'Detailed narrative description of the opportunity including customer needs, solution scope, and strategic context.',
    `opportunity_name` STRING COMMENT 'Business-friendly name or title of the sales opportunity describing the potential deal.',
    `opportunity_number` STRING COMMENT 'Externally-visible unique business identifier for the opportunity used in sales communications and reporting.',
    `opportunity_type` STRING COMMENT 'Classification of the opportunity based on customer relationship status (new customer acquisition vs existing customer expansion).. Valid values are `new_business|existing_customer|renewal|upgrade`',
    `order_number` STRING COMMENT 'Reference to the order number generated when the opportunity was converted to a sales order in the ERP (Enterprise Resource Planning) system.',
    `probability_percent` DECIMAL(18,2) COMMENT 'Estimated probability of winning this opportunity expressed as a percentage (0-100). Used for weighted pipeline forecasting.',
    `product_line` STRING COMMENT 'Primary product line or business unit category for the opportunity (e.g., automation systems, electrification solutions, smart infrastructure).',
    `project_end_date` DATE COMMENT 'Planned or actual completion date for project delivery if the opportunity is won.',
    `project_start_date` DATE COMMENT 'Planned or actual start date for project delivery if the opportunity is won.',
    `region` STRING COMMENT 'Geographic region classification for the opportunity (e.g., North America, EMEA, APAC).',
    `sales_cycle_days` STRING COMMENT 'Number of days from opportunity creation to close date. Used for sales velocity analysis.',
    `stage` STRING COMMENT 'Current stage of the opportunity in the sales pipeline lifecycle indicating progression toward close. [ENUM-REF-CANDIDATE: prospecting|qualification|needs_analysis|proposal|negotiation|closed_won|closed_lost — 7 candidates stripped; promote to reference product]',
    `stage_changed_date` TIMESTAMP COMMENT 'Timestamp when the opportunity stage was last changed. Used for stage duration and velocity analysis.',
    CONSTRAINT pk_opportunity PRIMARY KEY(`opportunity_id`)
) COMMENT 'Core sales opportunity record representing a potential deal for industrial automation, electrification, or smart infrastructure products. Tracks the full revenue pipeline from initial identification through close, including estimated value, probability, stage progression, expected close date, product lines of interest, competitive landscape, win/loss outcome, and primary loss reason. Sourced from Salesforce Sales Cloud Opportunity object. SSOT for all pipeline, forecast, and win/loss analysis data.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`sales`.`quote` (
    `quote_id` BIGINT COMMENT 'Unique identifier for the commercial quotation record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer account (prospective or existing) to whom this quote is issued.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Industrial manufacturing quotes are frequently site-specific — quoting automation equipment for a particular plant. Linking quote to account_site enables site-level quote pipeline reporting, installed',
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.bom. Business justification: In ETO/CTO industrial manufacturing, a quote is priced against a specific BOM that defines the configured product. Sales teams reference the engineering BOM for cost rollup and configuration validatio',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Quotes in multi-entity industrial manufacturers must be issued from a specific legal entity for correct VAT/tax calculation, intercompany pricing, and statutory reporting. Company code drives pricing ',
    `contract_id` BIGINT COMMENT 'Reference to the formal contract record created when the quote is accepted and converted to an order.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Quote budgeting ties estimated costs to a cost center for cost‑control before order conversion.',
    `customer_contact_id` BIGINT COMMENT 'Reference to the primary customer contact person to whom the quote is addressed.',
    `previous_quote_id` BIGINT COMMENT 'Reference to the prior version of this quote if this is a revision or amendment.',
    `price_book_id` BIGINT COMMENT 'Foreign key linking to sales.price_book. Business justification: A commercial quotation is generated from a specific price book that defines the applicable list prices, discount policies, and currency for the customer segment and region. This FK is essential for tr',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Quote profitability analysis requires profit center linkage to calculate expected margin.',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: In ETO industrial manufacturing, a quote is prepared against a specific engineering project scope and cost estimate. Quote-to-project linkage enables sales to align pricing with engineering cost estim',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative responsible for creating and managing this quote.',
    `territory_id` BIGINT COMMENT 'Reference to the sales territory to which this quote is assigned for pipeline tracking and commission purposes.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Quotes in industrial manufacturing CPQ processes specify a validated ship-to address for freight cost calculation, incoterms selection, and tax determination. A FK to customer.address enables accurate',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Quotes are generated based on a designated suppliers pricing; linking supports price validation, supplier cost analysis, and compliance with approved supplier lists.',
    `accepted_date` DATE COMMENT 'Date on which the customer formally accepted the quote, triggering order creation.',
    `approval_date` DATE COMMENT 'Date on which the quote received final internal approval.',
    `approval_status` STRING COMMENT 'Status of internal approval workflow for the quote, particularly for non-standard pricing or terms.. Valid values are `not_required|pending|approved|rejected`',
    `competitor_name` STRING COMMENT 'Name of the primary competitor identified in the sales opportunity for this quote.',
    `configuration_summary` STRING COMMENT 'High-level summary of the product configuration details included in the quote (e.g., system specifications, key components, customization notes).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quote record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the quote is denominated (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `delivery_lead_time_days` STRING COMMENT 'Estimated number of days from order confirmation to delivery of the quoted products.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total monetary value of all discounts applied to the quote (standard and non-standard).',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Overall discount rate applied to the quote, expressed as a percentage of the subtotal.',
    `incoterm` STRING COMMENT 'International Commercial Terms (Incoterms) defining the responsibilities of buyer and seller for delivery, insurance, and risk transfer. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the quote record was last updated or modified.',
    `non_standard_discount_flag` BOOLEAN COMMENT 'Indicates whether the quote includes discounts that exceed standard approval thresholds and require special authorization.',
    `notes` STRING COMMENT 'Internal notes and comments related to the quote, including negotiation history, customer feedback, and special considerations.',
    `payment_terms` STRING COMMENT 'Contractual payment terms offered to the customer (e.g., Net 30, 50% upfront / 50% on delivery, Letter of Credit).',
    `presented_date` DATE COMMENT 'Date on which the quote was formally presented to the customer.',
    `quote_date` DATE COMMENT 'Date on which the quote was formally issued to the customer.',
    `quote_name` STRING COMMENT 'Descriptive name or title of the quote, typically reflecting the project or product scope (e.g., Factory Automation System - Plant 5).',
    `quote_number` STRING COMMENT 'Externally visible business identifier for the quote. Used in customer communications and contract references.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `quote_status` STRING COMMENT 'Current lifecycle status of the quote in the sales workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|presented|accepted|rejected|expired — 7 candidates stripped; promote to reference product]',
    `quote_type` STRING COMMENT 'Classification of the quote based on the nature of the commercial transaction.. Valid values are `new_business|renewal|amendment|upsell|replacement`',
    `rejected_date` DATE COMMENT 'Date on which the customer formally rejected or declined the quote.',
    `rejection_reason` STRING COMMENT 'Explanation or reason provided by the customer for rejecting the quote (e.g., Price too high, Lead time unacceptable, Competitor selected).',
    `service_level_agreement` STRING COMMENT 'Service level commitments included in the quote (e.g., response time, uptime guarantees, maintenance windows).',
    `shipping_handling_amount` DECIMAL(18,2) COMMENT 'Estimated cost for shipping and handling of the quoted products to the customer site.',
    `shipping_method` STRING COMMENT 'Planned method of shipment for the quoted products (e.g., Air Freight, Ocean Freight, Ground Transport, Courier).',
    `special_terms_conditions` STRING COMMENT 'Additional contractual terms, conditions, or clauses specific to this quote that deviate from standard terms.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Total value of all quoted line items before discounts, taxes, and adjustments.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount calculated on the quote based on applicable tax jurisdictions and rates.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final total value of the quote including all line items, discounts, taxes, and fees.',
    `valid_from_date` DATE COMMENT 'Date from which the quoted prices and terms become effective.',
    `valid_until_date` DATE COMMENT 'Expiration date after which the quote is no longer valid and prices/terms may change.',
    `version` STRING COMMENT 'Version number of the quote, incremented when revisions are made to pricing, terms, or configuration.',
    `warranty_terms` STRING COMMENT 'Description of warranty coverage included with the quoted products (duration, scope, exclusions).',
    `win_probability_percentage` DECIMAL(18,2) COMMENT 'Estimated probability (0-100%) that this quote will be accepted and converted to an order, based on sales assessment.',
    CONSTRAINT pk_quote PRIMARY KEY(`quote_id`)
) COMMENT 'Commercial quotation issued to a prospective or existing industrial customer for automation systems, electrification solutions, or smart infrastructure components. Captures quoted price, discount structure (including approved non-standard discounts), validity period, payment terms, delivery lead time, configuration details, and approval status. Linked to an opportunity and may progress to a formal proposal or order. Sourced from Salesforce CPQ / Sales Cloud Quote object.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`sales`.`quote_line` (
    `quote_line_id` BIGINT COMMENT 'Unique identifier for the quote line item. Primary key.',
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.bom. Business justification: Each quote line for a configured industrial assembly references the BOM used to derive cost and validate configuration. The BOM drives cost rollup at the line level. quote_line already has component_i',
    `bundle_parent_line_id` BIGINT COMMENT 'Reference to the parent quote line if this line is part of a product bundle. Enables hierarchical quote structures for complex system quotes.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Quote creation requires exact component master data for pricing, lead time, and compliance; linking ensures accurate component reference.',
    `configuration_id` BIGINT COMMENT 'Reference to the product configuration record for complex configurable products. Links to CPQ (Configure Price Quote) configuration details.',
    `engineering_revision_id` BIGINT COMMENT 'Foreign key linking to engineering.revision. Business justification: Quotes must specify the component revision being sold to guarantee correct version delivery and regulatory compliance.',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_specification. Business justification: A quote line for a custom industrial product commits to specific engineering specifications (performance, compliance, material standards). The spec IS the product definition in ETO quoting. quote_line',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue account determination at line level: industrial manufacturing ERP assigns GL accounts per quote line for product-specific revenue classification (product revenue vs. service revenue vs. spare ',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Quote line must reference internal material master for cost, inventory availability, and production planning.',
    `price_book_entry_id` BIGINT COMMENT 'Foreign key linking to sales.price_book_entry. Business justification: A quote line is priced from a specific price book entry (SKU-price association). Adding price_book_entry_id to quote_line establishes the authoritative pricing reference used when the line was quoted.',
    `sku_master_id` BIGINT COMMENT 'Reference to the product master record. Identifies the specific SKU (Stock Keeping Unit), product configuration, or service offering being quoted.',
    `purchase_info_record_id` BIGINT COMMENT 'Foreign key linking to supplier.purchase_info_record. Business justification: Cost-based quoting at line level: in industrial manufacturing, each quote lines unit cost and lead time is derived from the purchase info record (vendor price list per material/supplier). This link e',
    `quote_id` BIGINT COMMENT 'Reference to the parent commercial quotation header. Links this line item to its containing quote document.',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative responsible for this line item. Used for commission calculation and territory management.',
    `serialized_unit_id` BIGINT COMMENT 'Foreign key linking to inventory.serialized_unit. Business justification: In industrial manufacturing, quoting specific serialized units (e.g., a particular drive or transformer in stock) is standard for capital equipment availability confirmation. Sales engineers reference',
    `supplier_id` BIGINT COMMENT 'Reference to the preferred supplier or vendor for this line item. Used for procurement planning and supply chain management.',
    `approval_level` STRING COMMENT 'The approval authority level required for this line item based on discount depth or special terms. Escalates based on business rules.. Valid values are `none|sales_manager|regional_director|vp_sales|cfo`',
    `commission_percent` DECIMAL(18,2) COMMENT 'The commission rate applicable to this line item for sales compensation. Business confidential.',
    `committed_delivery_date` DATE COMMENT 'The delivery date committed by the manufacturer for this line item. Based on production schedule and capacity planning.',
    `configuration_summary` STRING COMMENT 'Human-readable summary of the product configuration options selected. Describes customizations, options, and specifications for this line item.',
    `cost_amount` DECIMAL(18,2) COMMENT 'The total cost to manufacture or procure the items on this line. Used for margin analysis and profitability calculations. Business confidential.',
    `created_date` TIMESTAMP COMMENT 'The timestamp when this quote line record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary amounts on this line (e.g., USD, EUR, GBP, CNY).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The absolute monetary discount amount applied to this line item. Alternative to percentage-based discounts.',
    `discount_percent` DECIMAL(18,2) COMMENT 'The percentage discount applied to the list price. Represents negotiated price concessions or promotional discounts.',
    `is_bundle_parent` BOOLEAN COMMENT 'Indicates whether this line item is a parent bundle that contains child line items. True for bundle headers, false for standalone or child items.',
    `is_optional` BOOLEAN COMMENT 'Indicates whether this line item is optional or required. Optional items may be removed by the customer without affecting the core quote.',
    `last_modified_date` TIMESTAMP COMMENT 'The timestamp when this quote line record was last modified. Audit trail for change tracking.',
    `lead_time_days` STRING COMMENT 'The estimated lead time in days from order placement to delivery for this line item. Critical for production planning and customer expectations.',
    `line_number` STRING COMMENT 'Sequential line number within the quote. Determines the display order of line items on the quote document.',
    `line_status` STRING COMMENT 'The current status of this quote line item in the approval workflow. Tracks the lifecycle state of individual line items.. Valid values are `draft|pending_approval|approved|rejected|cancelled`',
    `line_type` STRING COMMENT 'Classification of the quote line item type. Distinguishes between hardware products, software, installation services, commissioning, and ongoing support services.. Valid values are `product|service|installation|commissioning|maintenance|spare_parts`',
    `list_price` DECIMAL(18,2) COMMENT 'The standard catalog or list price per unit before any discounts. Base price from the product master or price book.',
    `manufacturer_part_number` STRING COMMENT 'The original equipment manufacturer (OEM) part number for this item. Used for procurement and supply chain traceability.',
    `margin_amount` DECIMAL(18,2) COMMENT 'The gross margin amount for this line item. Calculated as subtotal amount minus cost amount. Business confidential.',
    `margin_percent` DECIMAL(18,2) COMMENT 'The gross margin percentage for this line item. Calculated as margin amount divided by subtotal amount. Business confidential.',
    `notes` STRING COMMENT 'Internal notes or comments about this quote line item. Used for collaboration between sales, engineering, and operations teams.',
    `product_family` STRING COMMENT 'The product family or category classification. Groups related products for reporting and analysis (e.g., Automation Systems, Electrification Solutions, Smart Infrastructure).',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of units being quoted for this line item. Supports fractional quantities for materials sold by weight or volume.',
    `requested_delivery_date` DATE COMMENT 'The customer-requested delivery date for this line item. May differ from the committed delivery date based on production capacity.',
    `special_terms` STRING COMMENT 'Any special terms, conditions, or notes specific to this line item. May include warranty extensions, service level agreements, or custom provisions.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'The extended line amount before taxes and fees. Calculated as quantity multiplied by unit price.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount applicable to this line item. May include VAT, sales tax, or other applicable taxes based on jurisdiction.',
    `total_amount` DECIMAL(18,2) COMMENT 'The total line amount including all taxes and fees. Final amount for this line item that contributes to the quote total.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quoted quantity. Defines how the product or service is quantified (e.g., each, kilogram, meter, hour for services). [ENUM-REF-CANDIDATE: each|kg|meter|liter|hour|day|month|year|set — 9 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'The actual selling price per unit after applying discounts and adjustments. This is the negotiated price for this specific quote.',
    CONSTRAINT pk_quote_line PRIMARY KEY(`quote_line_id`)
) COMMENT 'Individual line item within a commercial quotation, representing a specific SKU, product configuration, or service offering with its own quantity, unit price, discount, and extended amount. Supports multi-line complex industrial system quotes including hardware, software, installation, and commissioning services. Sourced from Salesforce CPQ Quote Line object.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`sales`.`contract` (
    `contract_id` BIGINT COMMENT 'Unique identifier for the sales contract. Primary key for the sales contract entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer account that is the counterparty to this sales contract. Links to the customer master data for billing, shipping, and relationship management.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Industrial manufacturing contracts govern supply or service to a specific customer plant site. Linking sales_contract to account_site enables site-level contract reporting, installed-base management, ',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Multi-entity industrial manufacturers assign every sales contract to a legal entity (company code) for statutory revenue reporting, VAT determination, and intercompany accounting. This is a fundamenta',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Contract accounting requires mapping contract revenue/costs to a cost center for internal cost tracking.',
    `credit_profile_id` BIGINT COMMENT 'Foreign key linking to customer.credit_profile. Business justification: Linking contracts to credit profiles enables automated credit risk checks required for contract approval in manufacturing.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Sales contracts in industrial manufacturing specify a validated delivery address governing incoterms, tax jurisdiction, and logistics obligations. delivery_location is a denormalized text field; a F',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse. Business justification: Industrial manufacturing sales contracts (frame agreements, blanket orders) specify the fulfilling warehouse for delivery scheduling and SLA compliance. Contract managers and logistics planners use th',
    `price_book_id` BIGINT COMMENT 'Foreign key linking to sales.price_book. Business justification: An executed sales contract in industrial manufacturing locks in pricing terms for the contract duration, typically referencing a specific price book (often a customer-specific or contracted price book',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Contracts often cover entire product families; linking enables compliance checks, warranty terms, and pricing rules per family.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit center assignment enables profit margin reporting per contract (mandatory for management reporting).',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: Long-term sales contracts for industrial automation systems are tied to specific engineering projects that deliver the contracted scope. Contract-to-project linkage supports milestone-based billing, c',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative or account manager responsible for negotiating and managing this sales contract. Links to employee or sales team master data.',
    `territory_id` BIGINT COMMENT 'Reference to the geographic or organizational sales territory to which this contract is assigned. Used for territory management, quota tracking, and commission calculation.',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.customer_contact. Business justification: Contract lifecycle management and legal audit trails require identifying the specific customer contact who signed the contract. customer_signatory_name is a denormalized text field; a FK to customer',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Sales contracts often reference a supplier responsible for warranty or service parts; linking enables warranty claim routing and supplier performance monitoring.',
    `approval_date` DATE COMMENT 'Date when the sales contract received final internal approval and was authorized for execution. Marks completion of internal review and sign-off process.',
    `compliance_certifications_required` STRING COMMENT 'List of mandatory certifications, standards, or regulatory approvals that products or services must meet under the sales contract. Examples: CE marking, UL certification, ISO 9001, IEC 61131, OSHA compliance.',
    `confidentiality_clause` STRING COMMENT 'Contractual provisions protecting proprietary information, trade secrets, technical specifications, and business data shared between parties. Defines confidential information, permitted uses, and disclosure restrictions.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the sales contract. Used for customer communication, legal reference, and cross-system tracking.. Valid values are `^[A-Z0-9]{8,20}$`',
    `contract_status` STRING COMMENT 'Current lifecycle status of the sales contract. Draft contracts are being prepared; pending approval contracts await internal or customer sign-off; active contracts are in force; suspended contracts are temporarily on hold; completed contracts have fulfilled all obligations; terminated contracts ended early by mutual agreement; cancelled contracts were voided before activation. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|completed|terminated|cancelled — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the sales contract based on commercial structure. Standard contracts use pre-approved terms; custom contracts are negotiated; framework contracts establish terms for multiple orders; blanket contracts cover recurring purchases; spot contracts are one-time transactions; turnkey contracts include design, supply, and commissioning.. Valid values are `standard|custom|framework|blanket|spot|turnkey`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales contract record was first created in the system. Part of audit trail for data lineage and compliance.',
    `delivery_schedule` STRING COMMENT 'Detailed timeline and milestones for delivery of products, systems, or services under the sales contract. May include phased deliveries, installation schedules, and commissioning dates.',
    `dispute_resolution_method` STRING COMMENT 'Agreed mechanism for resolving disputes arising from the sales contract. Litigation involves court proceedings; arbitration uses neutral arbitrators; mediation involves facilitated negotiation; negotiation is direct party-to-party resolution.. Valid values are `litigation|arbitration|mediation|negotiation`',
    `document_url` STRING COMMENT 'Uniform Resource Locator (URL) or file path to the digitally stored executed sales contract document. Links to document management system or secure repository.',
    `effective_date` DATE COMMENT 'Date when the sales contract becomes legally binding and enforceable. Marks the start of the contract period and triggers obligations for both parties.',
    `expiration_date` DATE COMMENT 'Date when the sales contract ends and obligations cease. Nullable for open-ended contracts or contracts with indefinite terms subject to termination clauses.',
    `force_majeure_clause` STRING COMMENT 'Contractual provisions excusing non-performance due to unforeseeable events beyond parties control such as natural disasters, war, pandemics, or government actions. Defines qualifying events and relief procedures.',
    `governing_law` STRING COMMENT 'Legal jurisdiction and body of law that governs the interpretation, enforcement, and dispute resolution of the sales contract. Typically specifies country and state/province.',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the responsibilities, costs, and risks between buyer and seller for delivery of goods. Examples: EXW (Ex Works), FOB (Free On Board), CIF (Cost Insurance and Freight), DDP (Delivered Duty Paid). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_requirements` STRING COMMENT 'Mandatory insurance coverage that the supplier or customer must maintain during contract performance. May include general liability, professional indemnity, product liability, or cargo insurance with specified coverage limits.',
    `intellectual_property_terms` STRING COMMENT 'Provisions defining ownership, licensing, and usage rights for intellectual property including patents, designs, software, documentation, and technical know-how. Specifies IP ownership and license grants.',
    `liability_cap_amount` DECIMAL(18,2) COMMENT 'Maximum financial liability amount that either party can be held responsible for under the sales contract. Limits exposure for damages, losses, or claims arising from contract performance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales contract record was last updated in the system. Part of audit trail for change tracking and compliance.',
    `net_contract_value` DECIMAL(18,2) COMMENT 'Net monetary value of the sales contract after applying discounts, rebates, and before taxes. Represents the actual revenue to be recognized.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about the sales contract. Used for internal communication and knowledge transfer.',
    `payment_method` STRING COMMENT 'Instrument or mechanism through which the customer will remit payment. Wire transfer for electronic bank transfers; letter of credit for trade finance; bank guarantee for secured payments; check for paper-based payments; credit card for card payments; direct debit for automated withdrawals.. Valid values are `wire_transfer|letter_of_credit|bank_guarantee|check|credit_card|direct_debit`',
    `payment_terms` STRING COMMENT 'Detailed description of payment conditions including milestones, due dates, installment schedules, and payment triggers. Examples: Net 30, 50% upfront 50% on delivery, milestone-based payments.',
    `penalty_clause` STRING COMMENT 'Contractual provisions defining financial penalties or liquidated damages for non-performance, late delivery, or breach of SLA commitments. Specifies penalty amounts, triggers, and caps.',
    `renewal_terms` STRING COMMENT 'Provisions governing automatic renewal, renewal options, or renegotiation terms at contract expiration. Defines renewal notice periods, pricing adjustments, and renewal conditions.',
    `signature_date` DATE COMMENT 'Date when the sales contract was signed by both parties and became legally executed. May differ from effective date if contract has a future start date.',
    `sla_resolution_time_hours` STRING COMMENT 'Maximum number of hours within which the supplier must resolve customer issues or restore service under the contract. Part of SLA commitments for uptime and availability.',
    `sla_response_time_hours` STRING COMMENT 'Maximum number of hours within which the supplier must respond to customer service requests or incidents under the contract. Part of SLA commitments for support and maintenance.',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'Guaranteed minimum uptime or availability percentage for systems, equipment, or services covered by the sales contract. Expressed as a percentage (e.g., 99.5% uptime).',
    `supplier_signatory_name` STRING COMMENT 'Full name of the authorized representative who signed the sales contract on behalf of the supplier. Used for legal verification and audit trail.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to the sales contract. Includes VAT, GST, sales tax, or other applicable taxes based on jurisdiction and product classification.',
    `termination_clause` STRING COMMENT 'Contractual provisions defining conditions, notice periods, and procedures under which either party may terminate the sales contract. Includes termination for cause, convenience, or force majeure.',
    `value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the sales contract representing the gross revenue commitment. Includes all line items, products, services, and deliverables before adjustments.',
    `value_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the contract value. Defines the currency in which all financial terms, payments, and penalties are denominated.. Valid values are `^[A-Z]{3}$`',
    `warranty_period_months` STRING COMMENT 'Duration in months for which the supplier provides warranty coverage for products, systems, or equipment delivered under the sales contract. Covers defects in materials and workmanship.',
    `warranty_terms` STRING COMMENT 'Detailed description of warranty provisions including coverage scope, exclusions, repair or replacement terms, and customer obligations. Defines what is covered and what is not under warranty.',
    CONSTRAINT pk_contract PRIMARY KEY(`contract_id`)
) COMMENT 'Executed commercial sales contract governing the terms and conditions for supply of industrial automation, electrification, or infrastructure products and systems. Captures contract value, duration, payment milestones, delivery schedule, SLA commitments, warranty provisions, penalty clauses, governing law, and Incoterms. Distinct from procurement contracts (owned by procurement domain) and service contracts (owned by service domain). SSOT for commercial sales agreement terms only.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`sales`.`territory` (
    `territory_id` BIGINT COMMENT 'Primary key for territory',
    `parent_territory_id` BIGINT COMMENT 'Reference to the parent territory in the hierarchical territory structure. Null for top-level territories.',
    `price_book_id` BIGINT COMMENT 'Foreign key linking to sales.price_book. Business justification: Sales territories in industrial manufacturing are often associated with a default price book that governs pricing for all deals originating in that territory (e.g., EMEA territory uses EUR price book,',
    `account_count` STRING COMMENT 'Total number of customer accounts assigned to this territory. Used for territory balance and coverage analysis.',
    `annual_revenue_quota` DECIMAL(18,2) COMMENT 'Target annual revenue quota assigned to this territory in the base currency. Used for quota attainment tracking and sales performance measurement.',
    `approval_status` STRING COMMENT 'Approval workflow status for territory definition changes: draft (being edited), pending_approval (submitted for review), approved (finalized), or rejected (not approved).. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the sales leader or executive who approved this territory definition. Used for governance and audit trail.',
    `approved_date` DATE COMMENT 'Date when the territory definition was formally approved. Used for compliance and change tracking.',
    `assignment_rule` STRING COMMENT 'Business rule or criteria used to assign accounts or opportunities to this territory (e.g., Postal codes 10000-19999, Annual revenue > $1M in automotive sector). Free-text description of assignment logic.',
    `commission_plan_code` STRING COMMENT 'Reference code to the commission or incentive compensation plan applicable to sales representatives in this territory. Links to compensation management system.',
    `country_codes` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes covered by this territory (e.g., USA,CAN,MEX or DEU,AUT,CHE).',
    `coverage_model` STRING COMMENT 'Sales coverage approach for this territory: direct (direct sales force), channel (partner/distributor), hybrid (combination), inside_sales (remote/phone), or field_sales (on-site visits).. Valid values are `direct|channel|hybrid|inside_sales|field_sales`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this territory record was first created in the system. Used for audit trail and data lineage.',
    `effective_end_date` DATE COMMENT 'Date when this territory definition expires or is superseded. Null for currently active territories with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this territory definition becomes active and operational. Used for territory planning and historical tracking.',
    `fiscal_year` STRING COMMENT 'Fiscal year for which this territory definition and quota are applicable (e.g., FY2024, FY2025). Enables year-over-year territory comparison.. Valid values are `^FY[0-9]{4}$`',
    `geographic_scope` STRING COMMENT 'Textual description of the geographic coverage (e.g., Germany, Austria, Switzerland, US Northeast Corridor, Asia-Pacific excluding China).',
    `industry_vertical` STRING COMMENT 'Target industry sector or vertical market for this territory (e.g., Automotive Manufacturing, Food & Beverage, Pharmaceuticals, Energy & Utilities). Applicable when territory_type includes industry_vertical.',
    `is_overlay_territory` BOOLEAN COMMENT 'Boolean flag indicating whether this is an overlay territory (True) that operates across other territories for specialized products or services, or a standard exclusive territory (False).',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code for the primary business language in this territory (e.g., en, de, zh, es). Used for localization and communication planning.. Valid values are `^[a-z]{2}$`',
    `market_segment` STRING COMMENT 'Target customer segment for this territory: enterprise (large corporations), mid_market (medium businesses), smb (small business), oem (Original Equipment Manufacturer), government (public sector), or education (academic institutions).. Valid values are `enterprise|mid_market|smb|oem|government|education`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this territory record was last modified. Used for change tracking and synchronization.',
    `notes` STRING COMMENT 'Free-form notes and comments about the territory, including special instructions, historical context, or strategic considerations. Used for knowledge transfer and planning.',
    `overlay_type` STRING COMMENT 'Type of overlay territory if is_overlay_territory is True: product_specialist (specific product expertise), solution_architect (technical pre-sales), key_account (strategic account support), or none (not an overlay).. Valid values are `product_specialist|solution_architect|key_account|none`',
    `priority_level` STRING COMMENT 'Strategic priority classification of the territory: strategic (top-tier), high (important growth area), medium (standard), low (maintenance), or emerging (new market development).. Valid values are `strategic|high|medium|low|emerging`',
    `product_line_scope` STRING COMMENT 'Comma-separated list of product lines or families assigned to this territory (e.g., PLC,SCADA,HMI or Electrification,Automation,Digitalization). Defines which products the territory sales team is responsible for.',
    `quota_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the revenue quota (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `quota_period` STRING COMMENT 'Time period for quota measurement: annual (yearly), semi_annual (twice per year), quarterly (every quarter), or monthly.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `region_level` STRING COMMENT 'Hierarchical level of the territory within the organizational geography: global (worldwide), regional (multi-country), country (single nation), local (sub-national), district (city/metro), or zone (sub-district).. Valid values are `global|regional|country|local|district|zone`',
    `sales_channel` STRING COMMENT 'Primary sales channel used in this territory: direct (company sales force), distributor (third-party distributor), reseller (value-added reseller), online (e-commerce), oem (embedded in OEM products), or system_integrator (SI partner).. Valid values are `direct|distributor|reseller|online|oem|system_integrator`',
    `sales_team_size` STRING COMMENT 'Number of sales representatives assigned to this territory. Used for capacity planning and workload distribution.',
    `source_system` STRING COMMENT 'Name of the source system from which this territory record originated (e.g., Salesforce Sales Cloud, SAP SD, Custom Territory Management). Used for data lineage and integration troubleshooting.',
    `source_system_code` STRING COMMENT 'Unique identifier of this territory in the source system. Used for cross-system reconciliation and data integration.',
    `territory_code` STRING COMMENT 'Business identifier code for the territory used in Salesforce Sales Cloud and reporting systems. Externally-known unique code.. Valid values are `^[A-Z0-9]{3,15}$`',
    `territory_description` STRING COMMENT 'Detailed textual description of the territory scope, strategic objectives, and special considerations. Provides context for territory planning and handoff.',
    `territory_name` STRING COMMENT 'Human-readable name of the sales territory (e.g., North America Industrial Automation, EMEA Electrification Solutions).',
    `territory_status` STRING COMMENT 'Current lifecycle status of the territory: active (operational), inactive (not in use), pending (awaiting activation), suspended (temporarily disabled), archived (historical), or planned (future territory).. Valid values are `active|inactive|pending|suspended|archived|planned`',
    `territory_type` STRING COMMENT 'Classification of territory assignment model: geographic (region-based), industry_vertical (sector-based), account_based (strategic accounts), product_line (product family focus), hybrid (combination), or named_account (specific customer assignment).. Valid values are `geographic|industry_vertical|account_based|product_line|hybrid|named_account`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the territory (e.g., America/New_York, Europe/Berlin, Asia/Shanghai). Used for scheduling and activity coordination.',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'Sales territory definition representing a geographic, industry-vertical, or account-based assignment used to organize the sales force for industrial automation and electrification markets. Captures territory code, region hierarchy (global/regional/local), assigned revenue quota, product line scope, and effective dates. Enables territory-based pipeline reporting and quota attainment tracking.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`sales`.`rep` (
    `rep_id` BIGINT COMMENT 'Primary key for rep',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sales rep cost allocation: industrial manufacturers assign reps to cost centers for commission accrual, travel expense allocation, and headcount cost reporting. This HR-Finance-Sales integration is st',
    `manager_rep_id` BIGINT COMMENT 'Reference to the sales representative record of this reps direct manager in the sales hierarchy.',
    `territory_id` BIGINT COMMENT 'Reference to the sales territory assigned to this representative defining their geographic or account-based coverage area.',
    `active_account_count` STRING COMMENT 'Number of active customer accounts currently assigned to and managed by this sales representative.',
    `active_opportunity_count` STRING COMMENT 'Number of open sales opportunities currently in the representatives pipeline.',
    `annual_quota_amount` DECIMAL(18,2) COMMENT 'Annual sales quota target assigned to the representative measured in base currency. Used for performance tracking and commission calculation.',
    `book_of_business_value` DECIMAL(18,2) COMMENT 'Total annual recurring revenue or contract value of the customer accounts currently managed by this sales representative.',
    `certification_list` STRING COMMENT 'Professional certifications held by the sales representative relevant to industrial automation and electrification sales, such as product certifications, technical sales training, or industry credentials.',
    `commission_plan_code` STRING COMMENT 'Reference code to the commission plan structure governing how this sales representative earns variable compensation based on sales performance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales representative record was first created in the sales system.',
    `crm_user_code` STRING COMMENT 'Salesforce Sales Cloud user identifier linking this sales representative to their CRM login and activity tracking.',
    `customer_segment` STRING COMMENT 'Target customer segment that the sales representative primarily serves based on account size and strategic importance.. Valid values are `enterprise|mid_market|small_business|strategic_accounts`',
    `email_address` STRING COMMENT 'Primary business email address for the sales representative used for customer communication and internal correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `full_name` STRING COMMENT 'Full legal name of the sales representative as recorded in the sales system.',
    `hire_date` DATE COMMENT 'Date when the sales representative was hired into the sales organization.',
    `industry_vertical_focus` STRING COMMENT 'Target industry vertical or market segment that the sales representative focuses on, such as automotive, food and beverage, pharmaceuticals, or infrastructure.',
    `is_key_account_manager` BOOLEAN COMMENT 'Boolean flag indicating whether this sales representative is designated as a key account manager responsible for strategic, high-value customer relationships.',
    `language_proficiency` STRING COMMENT 'Languages spoken by the sales representative relevant for customer communication and territory coverage, stored as comma-separated language codes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales representative record was most recently updated in the sales system.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review conducted for this sales representative.',
    `last_training_date` DATE COMMENT 'Date of the most recent sales training, product training, or professional development activity completed by the representative.',
    `mobile_number` STRING COMMENT 'Mobile phone number for the sales representative used for field communication and urgent customer contact.',
    `notes` STRING COMMENT 'Free-form notes capturing additional context about the sales representatives specializations, territory nuances, or other relevant information for sales operations.',
    `onboarding_completion_date` DATE COMMENT 'Date when the sales representative completed the formal onboarding and training program for new sales hires.',
    `performance_rating` STRING COMMENT 'Most recent performance evaluation rating for the sales representative based on quota attainment, customer satisfaction, and other Key Performance Indicators (KPIs).. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `phone_number` STRING COMMENT 'Primary business phone number for the sales representative to be contacted by customers and internal stakeholders.',
    `product_line_specialization` STRING COMMENT 'Primary product line or solution area that the sales representative specializes in, such as drives, PLCs (Programmable Logic Controllers), switchgear, building automation, or electrification systems.',
    `quota_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the quota amount (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `quota_period_end_date` DATE COMMENT 'End date of the current quota period for this sales representative.',
    `quota_period_start_date` DATE COMMENT 'Start date of the current quota period for this sales representative, typically aligned with fiscal year or calendar year.',
    `rep_code` STRING COMMENT 'Business-assigned unique code for the sales representative used in order entry, commission tracking, and reporting systems.. Valid values are `^[A-Z0-9]{6,12}$`',
    `rep_status` STRING COMMENT 'Current lifecycle status of the sales representative indicating their availability and eligibility for sales assignments.. Valid values are `active|inactive|on_leave|terminated|suspended|probation`',
    `sales_channel` STRING COMMENT 'Primary sales channel through which the representative conducts business: direct to end customer, through channel partners, distributors, or Original Equipment Manufacturer (OEM) relationships.. Valid values are `direct|partner|distributor|oem|hybrid`',
    `sales_office_location` STRING COMMENT 'Primary office location or branch where the sales representative is based for administrative and reporting purposes.',
    `sales_role` STRING COMMENT 'Commercial role classification indicating the sales representatives position in the sales organization hierarchy.. Valid values are `individual_contributor|team_lead|regional_manager|district_manager|account_executive|sales_engineer`',
    `termination_date` DATE COMMENT 'Date when the sales representatives employment or sales role ended. Null for active representatives.',
    `travel_percentage` STRING COMMENT 'Expected percentage of work time spent traveling for customer visits, trade shows, and field sales activities.',
    `years_of_experience` STRING COMMENT 'Total years of sales experience in industrial automation, electrification, or related technical sales roles.',
    CONSTRAINT pk_rep PRIMARY KEY(`rep_id`)
) COMMENT 'Sales representative profile within the sales domain capturing commercial role, quota assignment, product line specialization (drives, PLCs, switchgear, building automation), territory alignment, and performance targets. Distinct from the workforce domain employee record — this is the sales-domain view of a seller including their book of business, commission plan reference, CRM user linkage, and sales hierarchy position (individual contributor, team lead, regional manager). Sourced from Salesforce User / Sales Cloud.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`sales`.`price_book` (
    `price_book_id` BIGINT COMMENT 'Unique identifier for the price book record. Primary key.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Industrial manufacturers maintain company code-specific price books for legal entity pricing, local currency compliance, and intercompany transfer pricing. Price book validity is scoped to a legal ent',
    `parent_price_book_id` BIGINT COMMENT 'Reference to a parent or master price book from which this price book inherits base pricing. Null if this is a top-level price book.',
    `approval_date` DATE COMMENT 'Date when the price book was approved for use by authorized personnel.',
    `approval_required` BOOLEAN COMMENT 'Boolean flag indicating whether quotes or orders using this price book require management approval before finalization.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the specific country for which this price book applies. Null if applicable to multiple countries.. Valid values are `^[A-Z]{3}$`',
    `created_date` TIMESTAMP COMMENT 'Timestamp when the price book record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all prices in this price book (e.g., USD, EUR, GBP, CNY).. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Target customer segment or classification for which this price book is intended (e.g., Enterprise, SMB, OEM Partners, Distributors, Government).',
    `discount_policy` STRING COMMENT 'Reference to the discount policy or guidelines that govern allowable discounts from this price book (e.g., Standard 10% max, Volume-based tiered, No discounts allowed).',
    `effective_end_date` DATE COMMENT 'Date after which the price book is no longer valid for new transactions. Null indicates no expiration date.',
    `effective_start_date` DATE COMMENT 'Date from which the price book becomes valid and can be used for pricing sales transactions.',
    `industry_segment` STRING COMMENT 'Specific industry vertical or segment for which this price book is designed (e.g., Automotive Manufacturing, Food & Beverage, Pharmaceuticals, Energy & Utilities).',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the price book is currently active and available for selection in sales opportunities and quotes.',
    `is_standard` BOOLEAN COMMENT 'Boolean flag indicating whether this is the standard (default) price book for the organization. Only one standard price book should be active at a time.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when the price book record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the price book usage and applicability.',
    `price_book_code` STRING COMMENT 'Unique alphanumeric code identifying the price book for system integration and reporting purposes.',
    `price_book_description` STRING COMMENT 'Detailed description of the price book purpose, scope, and applicability (e.g., Standard list prices for North America industrial automation products effective Q1 2024).',
    `price_book_name` STRING COMMENT 'Business name of the price book (e.g., Standard Price Book, EMEA Industrial Automation 2024, OEM Partner Pricing).',
    `price_book_status` STRING COMMENT 'Current lifecycle status of the price book indicating whether it is available for use in sales transactions.. Valid values are `active|inactive|draft|archived|pending_approval|expired`',
    `price_book_type` STRING COMMENT 'Classification of the price book indicating its purpose and usage context within the sales organization.. Valid values are `standard|custom|promotional|contract|oem|distributor`',
    `pricing_strategy` STRING COMMENT 'The pricing methodology or strategy applied in this price book (e.g., list pricing, cost-plus, competitive pricing, value-based pricing).. Valid values are `list|cost_plus|competitive|value_based|penetration|premium`',
    `product_line` STRING COMMENT 'Primary product line or family covered by this price book (e.g., Industrial Automation, Electrification Solutions, Smart Infrastructure, PLCs, Drives & Motors).',
    `region` STRING COMMENT 'Geographic region or territory for which this price book applies (e.g., North America, EMEA, APAC, LATAM).',
    `revision_date` DATE COMMENT 'Date when the current version of the price book was last revised or updated.',
    `source_system` STRING COMMENT 'Name of the source system from which this price book was originated or synchronized (e.g., Salesforce CPQ, SAP SD, Oracle Pricing).',
    `source_system_code` STRING COMMENT 'Unique identifier of this price book in the source system for traceability and data lineage purposes.',
    `version` STRING COMMENT 'Version identifier for the price book to track revisions and updates over time (e.g., v1.0, 2024.Q1, Rev 3).',
    CONSTRAINT pk_price_book PRIMARY KEY(`price_book_id`)
) COMMENT 'Commercial price book defining the standard or customer-specific list prices for industrial automation products, electrification solutions, and smart infrastructure components. Captures price book name, currency, effective date range, customer segment applicability, and whether it is the standard or a custom price book. Sourced from Salesforce CPQ Price Book. SSOT for sales-side pricing (distinct from product catalog cost data).';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`sales`.`price_book_entry` (
    `price_book_entry_id` BIGINT COMMENT 'Unique identifier for the price book entry record. Primary key.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue account determination: in industrial manufacturing ERP (SAP SD condition technique), price book entries map to GL accounts for automatic revenue posting at order booking. This SD-FI integratio',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Price book entries in industrial manufacturing are tied to specific materials for cost-margin analysis and standard price validation. Pricing analysts and ERP pricing reports require the direct materi',
    `price_book_id` BIGINT COMMENT 'Reference to the parent price book that contains this entry. Links to the price book master record defining the pricing context (standard, regional, promotional).',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Price books in industrial manufacturing are scoped by product family (e.g., all Motion drives get a channel discount). The existing product_family plain-text column is a denormalization of product.fam',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Price book entries in industrial manufacturing are frequently SKU-level, enabling sales ops to resolve list price, minimum price, and discount policy for a specific SKU. Without this FK, pricing repor',
    `approval_status` STRING COMMENT 'The approval workflow status for this price book entry. Tracks whether custom or non-standard pricing has been reviewed and approved per governance policies.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_date` DATE COMMENT 'The date on which this price book entry was approved. Part of the audit trail for pricing governance and compliance.',
    `cost_price` DECIMAL(18,2) COMMENT 'The internal cost or standard cost of the product. Used for margin calculation and profitability analysis. Business-confidential data.',
    `created_date` TIMESTAMP COMMENT 'The timestamp when this price book entry record was first created in the system. Part of the standard audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which all prices in this entry are denominated (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'The customer segment or tier for which this pricing applies (e.g., Enterprise, Mid-Market, Small Business, Government). Supports segment-based pricing strategies.',
    `effective_end_date` DATE COMMENT 'The date after which this price book entry is no longer valid. Null indicates no expiration. Used for promotional pricing and seasonal campaigns.',
    `effective_start_date` DATE COMMENT 'The date from which this price book entry becomes valid and can be used in sales transactions. Supports time-bound pricing strategies.',
    `geography_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country or region code indicating the geographic market for which this pricing applies (e.g., USA, DEU, CHN).. Valid values are `^[A-Z]{3}$`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this price book entry is currently active and available for use in quotes and orders. Inactive entries are retained for historical reference.',
    `last_modified_date` TIMESTAMP COMMENT 'The timestamp when this price book entry record was last modified. Part of the standard audit trail for change tracking.',
    `lead_time_days` STRING COMMENT 'The standard lead time in days from order placement to delivery for this product. Used for delivery date estimation in quotes and orders.',
    `list_price` DECIMAL(18,2) COMMENT 'The standard published list price for this product in the specified currency. Represents the baseline price before any discounts or negotiations.',
    `market_segment` STRING COMMENT 'The target market segment or industry vertical for this product pricing (e.g., Automotive, Food & Beverage, Pharmaceuticals, Energy).',
    `maximum_discount_percent` DECIMAL(18,2) COMMENT 'The maximum allowable discount percentage that can be applied to this product without requiring special approval. Used to enforce pricing governance.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity that must be ordered for this product at this price. Enforces Minimum Order Quantity (MOQ) policies in Configure Price Quote (CPQ) systems.',
    `minimum_price` DECIMAL(18,2) COMMENT 'The floor price below which this product cannot be sold. Used to enforce pricing policies and protect margin thresholds in Configure Price Quote (CPQ) processes.',
    `price_book_entry_description` STRING COMMENT 'Additional notes or description providing context about this pricing entry, such as special terms, conditions, or the rationale for custom pricing.',
    `price_book_entry_name` STRING COMMENT 'A descriptive name or label for this price book entry, typically combining product name, price book name, and currency for easy identification in reports and user interfaces.',
    `price_type` STRING COMMENT 'The type or nature of the price (e.g., list price, negotiated price, promotional price, contract price, spot price). Indicates the pricing strategy applied.. Valid values are `list|negotiated|promotional|contract|spot`',
    `pricing_method` STRING COMMENT 'The methodology used to determine the price (e.g., fixed, cost-plus, market-based, value-based). Supports pricing strategy analysis and governance.. Valid values are `fixed|cost_plus|market_based|value_based`',
    `product_line` STRING COMMENT 'The business product line or division responsible for this product (e.g., Industrial Automation, Building Technologies, Mobility Solutions).',
    `sales_channel` STRING COMMENT 'The sales channel through which this pricing is applicable (e.g., direct sales, distributor, partner, Original Equipment Manufacturer (OEM), online).. Valid values are `direct|distributor|partner|oem|online`',
    `tax_code` STRING COMMENT 'The tax classification code that determines applicable sales tax, Value Added Tax (VAT), or Goods and Services Tax (GST) rates for this product in the specified geography.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for pricing (e.g., Each, Box, Pallet, Kilogram, Meter). Defines the quantity basis for the unit price.',
    `unit_price` DECIMAL(18,2) COMMENT 'The effective selling price per unit for this product in the price book. May differ from list price due to volume discounts, promotions, or regional adjustments.',
    `use_standard_price` BOOLEAN COMMENT 'Indicates whether this entry uses the standard price book price or a custom price. True means standard pricing applies; false indicates custom or negotiated pricing.',
    CONSTRAINT pk_price_book_entry PRIMARY KEY(`price_book_entry_id`)
) COMMENT 'Individual product-price association within a price book, linking a specific SKU or product configuration to its list price, minimum price, and discount thresholds for a given currency and effective period. Supports multi-currency industrial sales across global markets and enables CPQ-driven automated pricing in Salesforce.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`sales`.`order_intake` (
    `order_intake_id` BIGINT COMMENT 'Primary key for order_intake',
    `account_id` BIGINT COMMENT 'Reference to the customer account placing the order. Links to the master customer account record.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: In industrial manufacturing, orders are fulfilled to a specific customer plant/production site. Linking order_intake to account_site enables site-level delivery scheduling, installation planning, and ',
    `ar_item_id` BIGINT COMMENT 'Foreign key linking to finance.ar_item. Business justification: Order-to-cash process: booked orders generate AR items for receivables tracking. Industrial manufacturing DSO (Days Sales Outstanding) reporting and revenue recognition (IFRS 15) require linking order',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Sales order booking in industrial manufacturing ERP requires company code assignment for revenue GL posting, tax determination, and intercompany order processing. Every order intake record belongs to ',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to product.configuration. Business justification: In configure-to-order industrial manufacturing, the order intake must reference the specific product configuration to trigger the correct BOM and routing for production. Without this FK, manufacturing',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.customer_contact. Business justification: Order confirmation, delivery coordination, and dispute resolution in industrial manufacturing require knowing which buyer contact placed the order. Order management teams use this for customer communi',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Revenue allocation to cost center for cost accounting on each order intake (required for statutory cost reporting).',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Order intake records the exact material to be delivered, linking to inventory for allocation and picking.',
    `opportunity_id` BIGINT COMMENT 'Reference to the won sales opportunity that generated this order intake. Links to the originating opportunity record in Salesforce Sales Cloud.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability reporting per profit center for each order intake (used in profit analysis reports).',
    `quote_id` BIGINT COMMENT 'Reference to the accepted quote that was converted into this order intake. May be null if order originated directly from opportunity without formal quote.',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative or account manager who owns this order intake. Used for quota attainment and commission calculation.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Ship-to address drives logistics routing, tax jurisdiction determination, and incoterms application for industrial equipment delivery. delivery_location is a denormalized text field; a validated FK ',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Order intake processing must map incoming orders to the master product record for inventory allocation and production scheduling.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Order fulfillment planning requires assigning a primary supplier to each order intake for procurement scheduling and delivery coordination.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Order intake records a sales territory as text; adding order_intake_territory_id creates a proper FK to sales.territory and removes the ambiguous string column.',
    `site_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_site. Business justification: Logistics tracking needs the specific supplier site fulfilling the order, enabling shipping, compliance, and performance reporting.',
    `booking_recognition_date` DATE COMMENT 'The date when this order intake was recognized as a booking for quota and sales performance measurement. May differ from intake date based on validation rules.',
    `booking_recognized_flag` BOOLEAN COMMENT 'Indicates whether this order intake has been recognized as a booking against sales quota. True when order meets booking recognition criteria per sales policy.',
    `committed_delivery_date` DATE COMMENT 'The delivery date committed by sales to the customer. May differ from requested date based on production capacity and supply chain constraints.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this order intake record was first created. Used for audit trail and data lineage tracking.',
    `credit_approval_date` DATE COMMENT 'Date when credit approval was granted for this order, if required. Null if order did not require credit approval or is still pending.',
    `credit_check_status` STRING COMMENT 'Result of the customer credit check performed at order intake. Orders failing credit check may require advance payment or credit approval before handoff to fulfillment.. Valid values are `Passed|Failed|Pending|Waived|Manual Review`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the order value. Essential for multi-currency sales operations and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `customer_po_date` DATE COMMENT 'The date on the customers purchase order. Used for contract compliance verification and order validity checks.',
    `customer_po_number` STRING COMMENT 'The customers purchase order reference number. Critical for order validation, invoicing, and customer reconciliation. May be required per customer contract terms.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied at intake date to convert order value to base currency. Locked at intake for consistent booking valuation.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter in which this order intake was booked. Format Q1-YYYY through Q4-YYYY. Used for quarterly sales performance reporting and quota tracking.. Valid values are `^Q[1-4]-[0-9]{4}$`',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this order intake was booked. Used for annual sales performance reporting and year-over-year growth analysis.',
    `handoff_date` DATE COMMENT 'The date when the order intake was successfully handed off to the order management domain. Used for sales-to-fulfillment cycle time KPI calculation.',
    `handoff_status` STRING COMMENT 'Current status of the handoff from sales to order management domain. Tracks the intake record through validation, transfer, and acceptance by the fulfillment organization.. Valid values are `Pending|Validated|Transferred|Accepted|Rejected|On Hold`',
    `incoterms` STRING COMMENT 'The Incoterms rule defining the division of costs and risks between buyer and seller. Critical for international trade compliance and logistics planning. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `industry_segment` STRING COMMENT 'The customers industry segment or vertical market. Used for market analysis, sales territory planning, and industry-specific KPI tracking.',
    `intake_date` DATE COMMENT 'The date when the order was officially received and recorded in the sales system. This is the booking date used for sales quota recognition and revenue pipeline tracking.',
    `intake_number` STRING COMMENT 'Business identifier for the order intake record. Human-readable unique number used for tracking and reference in sales reporting and KPI dashboards.. Valid values are `^OI-[0-9]{8}$`',
    `intake_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the order intake record was created in the system. Used for sales-to-fulfillment cycle time measurement and operational analytics.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified this order intake record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this order intake record was last updated. Used for change tracking and data synchronization.',
    `notes` STRING COMMENT 'Free-text notes and comments related to this order intake. May include customer requests, internal coordination notes, or special handling instructions.',
    `order_management_reference` STRING COMMENT 'The order number or reference assigned by the order management system after handoff. Links this sales intake record to the authoritative order record in SAP SD or equivalent ERP.',
    `order_priority` STRING COMMENT 'The priority level assigned to this order intake. Influences production scheduling and resource allocation in the fulfillment process.. Valid values are `Standard|High|Urgent|Critical`',
    `order_type` STRING COMMENT 'Classification of the order by business type. Distinguishes between new customer acquisition, existing customer expansion, and service orders for sales mix analysis. [ENUM-REF-CANDIDATE: New Business|Renewal|Upgrade|Add-On|Replacement|Service|Spare Parts — 7 candidates stripped; promote to reference product]',
    `order_value` DECIMAL(18,2) COMMENT 'The total confirmed order value at intake. This is the gross order amount before any adjustments, used for sales booking recognition and quota attainment calculation.',
    `order_value_base_currency` DECIMAL(18,2) COMMENT 'Order value converted to the companys base reporting currency using the exchange rate at intake date. Used for consolidated sales reporting and KPI tracking.',
    `payment_terms` STRING COMMENT 'The agreed payment terms for this order. Defines when payment is due relative to delivery or invoice date. Critical for cash flow forecasting and credit risk management. [ENUM-REF-CANDIDATE: Net 30|Net 45|Net 60|Net 90|Advance Payment|Letter of Credit|Installment|Custom — 8 candidates stripped; promote to reference product]',
    `payment_terms_days` STRING COMMENT 'Number of days until payment is due per the agreed payment terms. Used for accounts receivable forecasting and working capital planning.',
    `product_line` STRING COMMENT 'The primary product line or business unit for this order. Used for sales performance segmentation and product portfolio analysis.',
    `requested_delivery_date` DATE COMMENT 'The customers requested delivery date as captured at order intake. Used for production planning coordination and customer expectation management.',
    `shipping_method` STRING COMMENT 'The agreed shipping or transportation method for order delivery. Impacts delivery lead time and logistics cost allocation. [ENUM-REF-CANDIDATE: Air Freight|Sea Freight|Road Transport|Rail|Courier|Customer Pickup|Multimodal — 7 candidates stripped; promote to reference product]',
    `special_terms_conditions` STRING COMMENT 'Any special commercial terms, conditions, or customer-specific agreements applicable to this order. May include warranty extensions, service level commitments, or pricing exceptions.',
    `created_by` STRING COMMENT 'Username or identifier of the sales user who created this order intake record in the system.',
    CONSTRAINT pk_order_intake PRIMARY KEY(`order_intake_id`)
) COMMENT 'Sales order intake record capturing the commercial handoff from a won opportunity or accepted quote to the order management domain. Records the intake date, confirmed order value, customer PO reference, requested delivery date, payment terms confirmed, and handoff status. This is NOT the SSOT for order fulfillment data — the authoritative order record lives in the order domain. The sales domain retains this record solely for order intake KPI tracking, sales-to-fulfillment cycle time measurement, and booking recognition against quota.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `manufacturing_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `manufacturing_ecm`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `manufacturing_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `manufacturing_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `manufacturing_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_previous_quote_id` FOREIGN KEY (`previous_quote_id`) REFERENCES `manufacturing_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `manufacturing_ecm`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `manufacturing_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `manufacturing_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_bundle_parent_line_id` FOREIGN KEY (`bundle_parent_line_id`) REFERENCES `manufacturing_ecm`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_price_book_entry_id` FOREIGN KEY (`price_book_entry_id`) REFERENCES `manufacturing_ecm`.`sales`.`price_book_entry`(`price_book_entry_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `manufacturing_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `manufacturing_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `manufacturing_ecm`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `manufacturing_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `manufacturing_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_parent_territory_id` FOREIGN KEY (`parent_territory_id`) REFERENCES `manufacturing_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `manufacturing_ecm`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_manager_rep_id` FOREIGN KEY (`manager_rep_id`) REFERENCES `manufacturing_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `manufacturing_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ADD CONSTRAINT `fk_sales_price_book_parent_price_book_id` FOREIGN KEY (`parent_price_book_id`) REFERENCES `manufacturing_ecm`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ADD CONSTRAINT `fk_sales_price_book_entry_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `manufacturing_ecm`.`sales`.`price_book`(`price_book_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `manufacturing_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `manufacturing_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `manufacturing_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ADD CONSTRAINT `fk_sales_order_intake_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `manufacturing_ecm`.`sales`.`territory`(`territory_id`);

-- ========= TAGS =========
ALTER SCHEMA `manufacturing_ecm`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `manufacturing_ecm`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact ID');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Territory Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Amount');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Close Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Close Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Competitor Name');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Created Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `delivery_installation_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Installation Status');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `delivery_installation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|on_hold');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `expected_revenue` SET TAGS ('dbx_business_glossary_term' = 'Expected Revenue');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `forecast_category` SET TAGS ('dbx_business_glossary_term' = 'Forecast Category');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `forecast_category` SET TAGS ('dbx_value_regex' = 'pipeline|best_case|commit|closed');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `has_open_activity` SET TAGS ('dbx_business_glossary_term' = 'Has Open Activity Flag');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `industry_segment` SET TAGS ('dbx_business_glossary_term' = 'Industry Segment');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `is_closed` SET TAGS ('dbx_business_glossary_term' = 'Is Closed Flag');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `is_private` SET TAGS ('dbx_business_glossary_term' = 'Is Private Flag');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `is_won` SET TAGS ('dbx_business_glossary_term' = 'Is Won Flag');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `lead_source` SET TAGS ('dbx_business_glossary_term' = 'Lead Source');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `lead_source` SET TAGS ('dbx_value_regex' = 'web|trade_show|referral|partner|cold_call|campaign');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `loss_reason` SET TAGS ('dbx_business_glossary_term' = 'Primary Loss Reason');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `loss_reason` SET TAGS ('dbx_value_regex' = 'price|competitor|no_decision|timing|product_fit|budget');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `next_step` SET TAGS ('dbx_business_glossary_term' = 'Next Step');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_description` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Description');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Name');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Number');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_type` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Type');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_type` SET TAGS ('dbx_value_regex' = 'new_business|existing_customer|renewal|upgrade');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `probability_percent` SET TAGS ('dbx_business_glossary_term' = 'Win Probability Percentage');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `project_end_date` SET TAGS ('dbx_business_glossary_term' = 'Project End Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `sales_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Sales Cycle Duration Days');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Sales Stage');
ALTER TABLE `manufacturing_ecm`.`sales`.`opportunity` ALTER COLUMN `stage_changed_date` SET TAGS ('dbx_business_glossary_term' = 'Stage Changed Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Identifier');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Identifier');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `previous_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Quote Identifier');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Identifier');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Ship To Address Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Acceptance Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Name');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `configuration_summary` SET TAGS ('dbx_business_glossary_term' = 'Configuration Summary');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Lead Time (Days)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Percentage');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `non_standard_discount_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Standard Discount Flag');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Quote Notes');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `presented_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Presentation Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `quote_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Issue Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `quote_name` SET TAGS ('dbx_business_glossary_term' = 'Quote Name');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_business_glossary_term' = 'Quote Number');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Status');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `quote_type` SET TAGS ('dbx_business_glossary_term' = 'Quote Type');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `quote_type` SET TAGS ('dbx_value_regex' = 'new_business|renewal|amendment|upsell|replacement');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `rejected_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Rejection Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `shipping_handling_amount` SET TAGS ('dbx_business_glossary_term' = 'Shipping and Handling Amount');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `special_terms_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Terms and Conditions');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Quote Subtotal Amount');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Quote Total Amount');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Validity Start Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `valid_until_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Validity End Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Quote Version Number');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `warranty_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote` ALTER COLUMN `win_probability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Win Probability Percentage');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Identifier (ID)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `bundle_parent_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Parent Line Identifier (ID)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Identifier (ID)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Revision Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Specification Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `price_book_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Entry Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `purchase_info_record_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Info Record Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Identifier (ID)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier (ID)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `serialized_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Serialized Unit Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Level');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `approval_level` SET TAGS ('dbx_value_regex' = 'none|sales_manager|regional_director|vp_sales|cfo');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `commission_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Percentage');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `commission_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `committed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Committed Delivery Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `configuration_summary` SET TAGS ('dbx_business_glossary_term' = 'Configuration Summary');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `is_bundle_parent` SET TAGS ('dbx_business_glossary_term' = 'Is Bundle Parent Flag');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `is_optional` SET TAGS ('dbx_business_glossary_term' = 'Is Optional Flag');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|cancelled');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Line Type');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'product|service|installation|commissioning|maintenance|spare_parts');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'List Price');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Margin Amount');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `margin_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Margin Percentage');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `margin_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Line Notes');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `special_terms` SET TAGS ('dbx_business_glossary_term' = 'Special Terms');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `manufacturing_ecm`.`sales`.`quote_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract ID');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Warehouse Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory ID');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Signatory Customer Contact Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `compliance_certifications_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications Required');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `confidentiality_clause` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'standard|custom|framework|blanket|spot|turnkey');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `delivery_schedule` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|negotiation');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `force_majeure_clause` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Clause');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms)');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `intellectual_property_terms` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Terms');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Amount');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `net_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Net Contract Value');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|letter_of_credit|bank_guarantee|check|credit_card|direct_debit');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signature Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `sla_resolution_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Resolution Time Hours');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time Hours');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `supplier_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Signatory Name');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `value_amount` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Amount');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `value_currency` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Currency');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period Months');
ALTER TABLE `manufacturing_ecm`.`sales`.`contract` ALTER COLUMN `warranty_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Identifier');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `parent_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Territory ID');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `account_count` SET TAGS ('dbx_business_glossary_term' = 'Account Count');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `annual_revenue_quota` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Quota');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `annual_revenue_quota` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `assignment_rule` SET TAGS ('dbx_business_glossary_term' = 'Assignment Rule');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `commission_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Code');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `commission_plan_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `country_codes` SET TAGS ('dbx_business_glossary_term' = 'Country Codes');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `coverage_model` SET TAGS ('dbx_business_glossary_term' = 'Coverage Model');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `coverage_model` SET TAGS ('dbx_value_regex' = 'direct|channel|hybrid|inside_sales|field_sales');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_value_regex' = '^FY[0-9]{4}$');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `industry_vertical` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `is_overlay_territory` SET TAGS ('dbx_business_glossary_term' = 'Is Overlay Territory Flag');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'enterprise|mid_market|smb|oem|government|education');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Territory Notes');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `overlay_type` SET TAGS ('dbx_business_glossary_term' = 'Overlay Type');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `overlay_type` SET TAGS ('dbx_value_regex' = 'product_specialist|solution_architect|key_account|none');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'strategic|high|medium|low|emerging');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `product_line_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Line Scope');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Quota Currency Code');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `quota_period` SET TAGS ('dbx_business_glossary_term' = 'Quota Period');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `quota_period` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `region_level` SET TAGS ('dbx_business_glossary_term' = 'Region Level');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `region_level` SET TAGS ('dbx_value_regex' = 'global|regional|country|local|district|zone');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|distributor|reseller|online|oem|system_integrator');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `sales_team_size` SET TAGS ('dbx_business_glossary_term' = 'Sales Team Size');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,15}$');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `territory_description` SET TAGS ('dbx_business_glossary_term' = 'Territory Description');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Status');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|archived|planned');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'geographic|industry_vertical|account_based|product_line|hybrid|named_account');
ALTER TABLE `manufacturing_ecm`.`sales`.`territory` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Rep Identifier');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `manager_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Sales Representative ID');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory ID');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `active_account_count` SET TAGS ('dbx_business_glossary_term' = 'Active Account Count');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `active_opportunity_count` SET TAGS ('dbx_business_glossary_term' = 'Active Opportunity Count');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `annual_quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Quota Amount');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `annual_quota_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `book_of_business_value` SET TAGS ('dbx_business_glossary_term' = 'Book of Business Value');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `book_of_business_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `certification_list` SET TAGS ('dbx_business_glossary_term' = 'Certification List');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `commission_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Code');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `commission_plan_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `crm_user_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) User ID');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `crm_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `crm_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'enterprise|mid_market|small_business|strategic_accounts');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Email Address');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Full Name');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Hire Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `industry_vertical_focus` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical Focus');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `is_key_account_manager` SET TAGS ('dbx_business_glossary_term' = 'Is Key Account Manager Flag');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `language_proficiency` SET TAGS ('dbx_business_glossary_term' = 'Language Proficiency');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `last_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Training Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Mobile Number');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Notes');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `onboarding_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completion Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `performance_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Phone Number');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `product_line_specialization` SET TAGS ('dbx_business_glossary_term' = 'Product Line Specialization');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Quota Currency Code');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `quota_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Quota Period End Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `quota_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Quota Period Start Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `rep_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Code');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `rep_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `rep_status` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Status');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `rep_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated|suspended|probation');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|partner|distributor|oem|hybrid');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `sales_office_location` SET TAGS ('dbx_business_glossary_term' = 'Sales Office Location');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `sales_role` SET TAGS ('dbx_business_glossary_term' = 'Sales Role');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `sales_role` SET TAGS ('dbx_value_regex' = 'individual_contributor|team_lead|regional_manager|district_manager|account_executive|sales_engineer');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Termination Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `travel_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Percentage');
ALTER TABLE `manufacturing_ecm`.`sales`.`rep` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Sales Experience');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book ID');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `parent_price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Price Book ID');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `discount_policy` SET TAGS ('dbx_business_glossary_term' = 'Discount Policy');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `industry_segment` SET TAGS ('dbx_business_glossary_term' = 'Industry Segment');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `is_standard` SET TAGS ('dbx_business_glossary_term' = 'Is Standard Price Book Flag');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Price Book Notes');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `price_book_code` SET TAGS ('dbx_business_glossary_term' = 'Price Book Code');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `price_book_description` SET TAGS ('dbx_business_glossary_term' = 'Price Book Description');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `price_book_name` SET TAGS ('dbx_business_glossary_term' = 'Price Book Name');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `price_book_status` SET TAGS ('dbx_business_glossary_term' = 'Price Book Status');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `price_book_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|pending_approval|expired');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `price_book_type` SET TAGS ('dbx_business_glossary_term' = 'Price Book Type');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `price_book_type` SET TAGS ('dbx_value_regex' = 'standard|custom|promotional|contract|oem|distributor');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'list|cost_plus|competitive|value_based|penetration|premium');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Price Book Version');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `price_book_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Entry Identifier (ID)');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Identifier (ID)');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `cost_price` SET TAGS ('dbx_business_glossary_term' = 'Cost Price');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `cost_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `geography_code` SET TAGS ('dbx_business_glossary_term' = 'Geography Code');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `geography_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'List Price');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `maximum_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Percentage');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `minimum_price` SET TAGS ('dbx_business_glossary_term' = 'Minimum Price');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `price_book_entry_description` SET TAGS ('dbx_business_glossary_term' = 'Price Book Entry Description');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `price_book_entry_name` SET TAGS ('dbx_business_glossary_term' = 'Price Book Entry Name');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'list|negotiated|promotional|contract|spot');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Pricing Method');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `pricing_method` SET TAGS ('dbx_value_regex' = 'fixed|cost_plus|market_based|value_based');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|distributor|partner|oem|online');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `manufacturing_ecm`.`sales`.`price_book_entry` ALTER COLUMN `use_standard_price` SET TAGS ('dbx_business_glossary_term' = 'Use Standard Price Flag');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Identifier');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `ar_item_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Item Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Customer Contact Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote ID');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Owner ID');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Ship To Address Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Territory Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `booking_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Recognition Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `booking_recognized_flag` SET TAGS ('dbx_business_glossary_term' = 'Booking Recognized Flag');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `committed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Committed Delivery Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `credit_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Approval Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `credit_check_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Status');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `credit_check_status` SET TAGS ('dbx_value_regex' = 'Passed|Failed|Pending|Waived|Manual Review');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `customer_po_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Number');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = '^Q[1-4]-[0-9]{4}$');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `handoff_date` SET TAGS ('dbx_business_glossary_term' = 'Handoff Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `handoff_status` SET TAGS ('dbx_business_glossary_term' = 'Handoff Status');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `handoff_status` SET TAGS ('dbx_value_regex' = 'Pending|Validated|Transferred|Accepted|Rejected|On Hold');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `industry_segment` SET TAGS ('dbx_business_glossary_term' = 'Industry Segment');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `intake_date` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `intake_number` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Number');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `intake_number` SET TAGS ('dbx_value_regex' = '^OI-[0-9]{8}$');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `intake_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Timestamp');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Notes');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `order_management_reference` SET TAGS ('dbx_business_glossary_term' = 'Order Management Reference Number');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `order_priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `order_priority` SET TAGS ('dbx_value_regex' = 'Standard|High|Urgent|Critical');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `order_value` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Order Value');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `order_value_base_currency` SET TAGS ('dbx_business_glossary_term' = 'Order Value in Base Currency');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `special_terms_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Terms and Conditions');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `special_terms_conditions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`sales`.`order_intake` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
