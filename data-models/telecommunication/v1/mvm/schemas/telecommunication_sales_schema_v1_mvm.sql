-- Schema for Domain: sales | Business: Telecommunication | Version: v1_mvm
-- Generated on: 2026-05-08 08:31:46

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`sales` COMMENT 'SSOT for commercial sales activities — leads, opportunities, quotes, contracts, channel performance, and dealer/agent management. Supports B2C retail, B2B enterprise, and MVNO wholesale sales pipelines managed via Salesforce CRM opportunity and contract modules.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`lead` (
    `lead_id` BIGINT COMMENT 'Unique identifier for the lead record. Primary key for the lead entity representing a prospective customer or sales inquiry in the early pipeline stage.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign that generated this lead. Used for campaign attribution and ROI analysis.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to sales.channel. Business justification: A lead is generated through a specific sales channel (e.g., online portal, retail store, telesales, dealer). Adding channel_id to lead normalizes the channel attribution for lead source analytics and ',
    `opportunity_id` BIGINT COMMENT 'Identifier of the opportunity record created upon lead conversion. Null if not yet converted.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise B2B lead qualification requires associating a lead with a corporate account for account-based pipeline reporting and routing. Enterprise sales teams track which corporate account a lead bel',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Leads capture prospect interest in specific products/services. Sales qualification and conversion tracking require knowing which catalog items prospects are interested in. Essential for lead-to-revenu',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Telecom leads capture prospect interest in a specific offering (e.g., Fiber 500 Unlimited plan). Lead conversion rate by offering, sales funnel analysis, and lead scoring models all depend on offeri',
    `partner_id` BIGINT COMMENT 'Identifier of the partner, dealer, or agent who referred this lead. Used for partner commission tracking and channel performance analysis.',
    `privacy_consent_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_consent. Business justification: Lead follow-up requires documented consent for contact under TCPA. Telecom sales must verify opt-in status before outreach (calls, texts, emails). Links lead contact activities to consent records, ena',
    `svc_location_id` BIGINT COMMENT 'Foreign key linking to service.svc_location. Business justification: Lead qualification in telecom requires a serviceability check at the prospects address. Linking lead to svc_location enables automated serviceability-driven lead scoring, network coverage validation,',
    `age_days` STRING COMMENT 'Number of days since the lead was created. Used for aging analysis and pipeline velocity metrics.',
    `assigned_sales_team` STRING COMMENT 'Name or identifier of the sales team responsible for this lead, such as consumer sales, enterprise sales, or partner channel team.',
    `city` STRING COMMENT 'City name of the lead contact address.',
    `company_name` STRING COMMENT 'Name of the company or organization associated with the lead. Populated for B2B and MVNO segment leads.',
    `conversion_date` DATE COMMENT 'Date when the lead was converted to an opportunity, account, and contact in the CRM system. Null if not yet converted.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the lead contact address.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lead record was first created in the system. Used for lead aging, SLA tracking, and audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for estimated values. Defaults to business operating currency.. Valid values are `^[A-Z]{3}$`',
    `disqualification_reason` STRING COMMENT 'Reason code or description for why the lead was marked as unqualified or closed lost. Used for process improvement and lead source quality analysis.',
    `do_not_call` BOOLEAN COMMENT 'Boolean flag indicating the lead is on the Do Not Call list and must not be contacted via phone for marketing purposes.',
    `email_address` STRING COMMENT 'Primary email address of the lead contact. Used for digital communication and campaign follow-up.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `estimated_contract_value` DECIMAL(18,2) COMMENT 'Estimated total contract value over the expected contract term. Relevant for B2B and enterprise leads with multi-year commitments.',
    `estimated_monthly_value` DECIMAL(18,2) COMMENT 'Estimated monthly recurring revenue (MRR) potential from this lead if converted to customer. Used for pipeline value forecasting.',
    `first_contact_date` DATE COMMENT 'Date when the lead was first contacted by sales representative. Used for SLA compliance tracking and lead aging analysis.',
    `first_name` STRING COMMENT 'First name or given name of the prospective customer contact.',
    `follow_up_sla_hours` STRING COMMENT 'Number of hours within which the lead must be contacted per business SLA policy. Varies by lead priority and segment.',
    `grade` STRING COMMENT 'Letter grade representing the leads demographic and firmographic fit with ideal customer profile. A is highest fit, F is lowest.. Valid values are `A|B|C|D|F`',
    `interest_product_category` STRING COMMENT 'Primary product or service category the lead expressed interest in, such as wireless, broadband, fiber internet, IPTV, enterprise connectivity, or IoT solutions.',
    `interest_service_type` STRING COMMENT 'Specific service type the lead is interested in, such as 5G mobile, FTTH, SD-WAN, VoIP, IPTV, or managed services.',
    `last_contact_date` DATE COMMENT 'Date of the most recent contact attempt or interaction with the lead.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the lead record was last updated. Used for change tracking and data freshness monitoring.',
    `last_name` STRING COMMENT 'Last name or family name of the prospective customer contact.',
    `lead_number` STRING COMMENT 'Human-readable business identifier for the lead, typically auto-generated in format LED-XXXXXXXX. Used for external communication and tracking.. Valid values are `^LED-[0-9]{8}$`',
    `lead_source` STRING COMMENT 'Origin channel through which the lead was captured. Values include web form, marketing campaign, customer referral, retail walk-in, partner channel, event, or social media. [ENUM-REF-CANDIDATE: web_form|campaign|referral|walk_in|partner|event|social_media — 7 candidates stripped; promote to reference product]',
    `lead_status` STRING COMMENT 'Current lifecycle status of the lead in the sales pipeline. Values include new, contacted, qualified (SQL), unqualified, converted to opportunity, closed lost, or nurturing (MQL). [ENUM-REF-CANDIDATE: new|contacted|qualified|unqualified|converted|closed_lost|nurturing — 7 candidates stripped; promote to reference product]',
    `mobile_number` STRING COMMENT 'Mobile phone number of the lead contact. Used for SMS campaigns and mobile-first engagement.',
    `next_follow_up_date` DATE COMMENT 'Scheduled date for the next follow-up activity with the lead. Used for task management and pipeline hygiene.',
    `opt_in_email` BOOLEAN COMMENT 'Boolean flag indicating whether the lead has consented to receive email marketing communications. Required for CAN-SPAM and GDPR compliance.',
    `opt_in_phone` BOOLEAN COMMENT 'Boolean flag indicating whether the lead has consented to receive phone marketing calls. Required for TCPA and Do Not Call registry compliance.',
    `opt_in_sms` BOOLEAN COMMENT 'Boolean flag indicating whether the lead has consented to receive SMS marketing communications. Required for TCPA compliance.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the lead. May include mobile or landline number.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the lead contact address. Critical for service availability validation and FTTH/GPON coverage checks.',
    `priority` STRING COMMENT 'Priority classification for follow-up urgency. Hot leads require immediate contact, warm leads require timely follow-up, cold leads are lower priority.. Valid values are `hot|warm|cold`',
    `qualification_status` STRING COMMENT 'Marketing and sales qualification status. MQL (Marketing Qualified Lead) indicates marketing acceptance; SQL (Sales Qualified Lead) indicates sales acceptance and readiness for opportunity conversion.. Valid values are `mql|sql|unqualified|pending`',
    `referral_code` STRING COMMENT 'Unique referral code or tracking identifier provided by the referring party or campaign. Used for attribution and incentive fulfillment.',
    `sales_territory` STRING COMMENT 'Geographic or organizational sales territory to which this lead is assigned, based on address or segment rules.',
    `score` STRING COMMENT 'Numeric score representing the leads propensity to convert, based on demographic fit, engagement behavior, and predictive analytics. Higher scores indicate higher conversion probability.',
    `source_detail` STRING COMMENT 'Additional detail about the lead source, such as specific campaign name, partner name, event name, or referral source identifier.',
    `state_province` STRING COMMENT 'State or province code of the lead contact address. Used for regulatory compliance and territory routing.',
    `street_address` STRING COMMENT 'Street address of the lead contact or business location. Used for service availability checks and territory assignment.',
    CONSTRAINT pk_lead PRIMARY KEY(`lead_id`)
) COMMENT 'Master record for a prospective customer or sales inquiry in the early pipeline stage. Captures lead source (web form, campaign, referral, walk-in, partner), contact details, segment classification (B2C/B2B/MVNO), qualification status (MQL/SQL), assigned sales rep, campaign attribution, lead score, and aging metrics. Sourced from Salesforce CRM Lead Management module. Represents the top-of-funnel entity for all sales pipelines with defined SLA for follow-up.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`opportunity` (
    `opportunity_id` BIGINT COMMENT 'Primary key for opportunity',
    `address_id` BIGINT COMMENT 'Reference to the service installation address for fixed services (fiber, broadband, enterprise connectivity). Null for mobile-only opportunities. Links to address entity in customer domain.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: When an opportunity converts, a billing account is created. Linking opportunity to billing_account enables sales-to-revenue attribution, ARPU tracking against pipeline forecasts, and closed-loop repor',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Telecom opportunities are frequently centered on a specific bundle (triple-play, converged enterprise bundle). Bundle-level pipeline reporting, win/loss analysis by bundle type, and forecast accuracy ',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that generated or influenced this opportunity. Used for campaign ROI analysis and attribution.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: B2B sales opportunities in telecommunications target enterprise corporate accounts for managed services, fiber, SD-WAN, and IoT deployments. Essential for enterprise pipeline reporting, account-based ',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: Sales opportunities for device upgrades, replacements, or trade-ins must reference the customers existing CPE asset to determine upgrade eligibility, trade-in value, and compatibility with proposed n',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: B2B sales opportunities track primary contact stakeholders for decision-making authority, meeting coordination, and proposal delivery. Essential for sales process management and CRM workflows in enter',
    `enterprise_contract_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_contract. Business justification: Enterprise contract renewal and amendment opportunities must reference the existing contract being renegotiated. Telecom sales teams track which enterprise contract an opportunity targets for renewal ',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Managed service renewal and upsell opportunities require linking the opportunity to the specific managed service being renewed or expanded. Telecom account managers track renewal pipeline per managed ',
    `mvno_profile_id` BIGINT COMMENT 'Foreign key linking to partner.mvno_profile. Business justification: Wholesale/MVNO sales opportunities reference an existing MVNO profile for capacity expansion or new service tier deals. Telecom wholesale sales teams track which MVNO profile an opportunity targets to',
    `partner_id` BIGINT COMMENT 'Reference to the dealer, agent, or channel partner involved in this opportunity. Null for direct sales. Links to partner domain for commission and performance tracking.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Opportunities represent potential sales of specific products. Linking to catalog_item enables product mix analysis, win/loss reporting by SKU, revenue forecasting by product, and sales pipeline visibi',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Opportunities propose specific market offerings (bundled plans, enterprise solutions). This link supports opportunity-to-offering pipeline reporting, conversion rate analysis by offering type, and sal',
    `team_id` BIGINT COMMENT 'Reference to the sales team or business unit responsible for this opportunity. Used for team-based quota tracking and performance management.',
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Enterprise opportunities for fiber, managed services, or SD-WAN target specific customer sites. Site linkage critical for site survey scheduling, service feasibility assessment, installation cost esti',
    `sla_contract_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_contract. Business justification: B2B/enterprise telecom sales opportunities are structured around specific SLA tiers. Sales reps must reference the SLA contract being proposed to configure pricing, set customer expectations, and feed',
    `slice_id` BIGINT COMMENT 'Foreign key linking to network.network_slice. Business justification: 5G network slicing is sold as a distinct product offering to enterprise customers requiring dedicated virtual networks with specific SLA guarantees. Sales opportunities for slice-based services must r',
    `spectrum_license_id` BIGINT COMMENT 'Foreign key linking to compliance.spectrum_license. Business justification: Wireless service opportunities require verification of spectrum license availability for the proposed technology and geography. Sales engineers reference the spectrum license during opportunity qualif',
    `subscriber_id` BIGINT COMMENT 'Reference to the existing subscriber if this opportunity represents an upsell, cross-sell, or service expansion for a current customer. Null for new customer acquisition opportunities.',
    `transmission_link_id` BIGINT COMMENT 'Foreign key linking to network.transmission_link. Business justification: Enterprise sales opportunities for dedicated connectivity (leased lines, MPLS, DIA) must reference the specific transmission link being sold to validate capacity, quote SLA-backed pricing, and confirm',
    `actual_close_date` DATE COMMENT 'Actual date when the opportunity reached a terminal closed-won or closed-lost state. Null for opportunities still in active sales stages.',
    `competitive_threat_level` STRING COMMENT 'Assessment of competitive pressure and risk of losing the opportunity to a competitor. Used for resource prioritization and executive escalation.. Valid values are `low|medium|high|critical`',
    `competitor_name` STRING COMMENT 'Name of the primary competitor being displaced or competed against in this opportunity. Used for competitive intelligence and win/loss analysis.',
    `contract_term_months` STRING COMMENT 'Duration of the proposed contract in months. Common terms include 12, 24, or 36 months for consumer and SMB, and 36-60 months for enterprise contracts.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the opportunity record was first created in the system. Audit field for lifecycle tracking.',
    `credit_check_status` STRING COMMENT 'Status of credit verification for the prospect or customer. Required for postpaid services and enterprise contracts to assess financial risk.. Valid values are `not_required|pending|approved|declined|manual_review`',
    `credit_score` STRING COMMENT 'Numeric credit score obtained from credit bureau for risk assessment. Used to determine deposit requirements and service eligibility. Confidential business data.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this opportunity record.. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Target customer segment for this opportunity: B2C consumer, B2C small office/home office, B2B small-medium business, B2B mid-market, B2B enterprise, MVNO wholesale, or government/public sector. [ENUM-REF-CANDIDATE: b2c_consumer|b2c_soho|b2b_smb|b2b_mid_market|b2b_enterprise|mvno_wholesale|government — 7 candidates stripped; promote to reference product]',
    `deposit_required_amount` DECIMAL(18,2) COMMENT 'Security deposit amount required based on credit assessment. Zero if no deposit is required. Expressed in the opportunity currency.',
    `estimated_contract_value` DECIMAL(18,2) COMMENT 'Total estimated revenue value of the opportunity over the contract term, including one-time charges, recurring monthly revenue, and usage-based revenue projections. Expressed in the base currency.',
    `estimated_mrr` DECIMAL(18,2) COMMENT 'Projected monthly recurring revenue from subscription services if the opportunity closes successfully. Key metric for subscription-based business model forecasting.',
    `estimated_one_time_revenue` DECIMAL(18,2) COMMENT 'Projected one-time revenue from activation fees, installation charges, equipment sales, and other non-recurring charges associated with this opportunity.',
    `expected_close_date` DATE COMMENT 'Anticipated date when the opportunity is expected to reach a terminal state (closed-won or closed-lost). Used for sales forecasting and pipeline management.',
    `forecast_category` STRING COMMENT 'Sales forecast classification indicating confidence level: pipeline (early stage), best case (possible), commit (high confidence), or closed (won). Used for revenue forecasting and quota tracking.. Valid values are `pipeline|best_case|commit|closed`',
    `key_stakeholders` STRING COMMENT 'Names and roles of key decision-makers and influencers within the prospect organization. Used for relationship mapping and sales strategy in complex B2B deals.',
    `last_activity_date` DATE COMMENT 'Date of the most recent sales activity (call, meeting, email, task) logged against this opportunity. Used for pipeline hygiene and stale opportunity identification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the opportunity record was last updated. Audit field for change tracking and data freshness monitoring.',
    `next_step` STRING COMMENT 'Description of the next action or milestone required to progress the opportunity. Used for sales activity tracking and pipeline hygiene.',
    `number_of_devices` STRING COMMENT 'Quantity of customer premises equipment, handsets, routers, or IoT devices included in the opportunity. Used for inventory allocation and logistics planning.',
    `number_of_lines` STRING COMMENT 'Quantity of mobile lines, broadband connections, or service instances included in this opportunity. Used for volume-based pricing and capacity planning.',
    `opportunity_name` STRING COMMENT 'Human-readable name or title of the sales opportunity, typically describing the prospect and solution being pursued.',
    `opportunity_number` STRING COMMENT 'Externally-visible business identifier for the opportunity, used in communications and reporting. Format: OPP-NNNNNNNN.. Valid values are `^OPP-[0-9]{8}$`',
    `opportunity_type` STRING COMMENT 'Classification of the opportunity based on the nature of the sales pursuit: new customer acquisition, upsell to existing subscriber, cross-sell of additional services, contract renewal, customer winback, or technology migration.. Valid values are `new_customer|upsell|cross_sell|renewal|winback|migration`',
    `primary_product_offering` STRING COMMENT 'Name or description of the primary product or service offering being sold in this opportunity (e.g., 5G Unlimited Plan, Fiber 1Gbps, Enterprise SD-WAN, MVNO Wholesale Agreement).',
    `probability_percent` STRING COMMENT 'Estimated probability of winning this opportunity, expressed as an integer percentage (0-100). Used for weighted pipeline forecasting.',
    `product_category` STRING COMMENT 'High-level category of the product or service being offered: mobile postpaid, mobile prepaid, fixed broadband, fiber, enterprise connectivity, IoT, cloud services, managed services, or wholesale. [ENUM-REF-CANDIDATE: mobile_postpaid|mobile_prepaid|fixed_broadband|fiber|enterprise_connectivity|iot|cloud_services|managed_services|wholesale — 9 candidates stripped; promote to reference product]',
    `proposed_service_start_date` DATE COMMENT 'Target date for service activation and contract commencement if the opportunity is won. Used for fulfillment planning and resource allocation.',
    `sales_stage` STRING COMMENT 'Current stage of the opportunity in the sales pipeline lifecycle. Tracks progression from initial prospecting through qualification, proposal, negotiation, and terminal closed-won or closed-lost states. [ENUM-REF-CANDIDATE: prospecting|qualification|needs_analysis|proposal|negotiation|closed_won|closed_lost — 7 candidates stripped; promote to reference product]',
    `strategic_account_flag` BOOLEAN COMMENT 'Indicates whether this opportunity is for a strategic or key account requiring executive sponsorship and special handling. True for enterprise strategic accounts.',
    `technology_type` STRING COMMENT 'Underlying network technology for the proposed service: 5G, LTE, 3G, fiber to the home, fiber to the building, cable, DSL, fixed wireless, satellite, SD-WAN, or MPLS. [ENUM-REF-CANDIDATE: 5g|lte|3g|fiber_ftth|fiber_fttb|cable|dsl|fixed_wireless|satellite|sd_wan|mpls — 11 candidates stripped; promote to reference product]',
    `whitespace_analysis` STRING COMMENT 'For B2B enterprise opportunities, describes untapped revenue potential and expansion opportunities within the account (additional locations, services, or business units not yet penetrated).',
    `win_loss_reason` STRING COMMENT 'Primary reason for winning or losing the opportunity. Captured at close for sales effectiveness analysis and process improvement. Examples: price, coverage, features, competitor, timing, budget.',
    CONSTRAINT pk_opportunity PRIMARY KEY(`opportunity_id`)
) COMMENT 'Core sales opportunity record representing a qualified sales pursuit for a prospect or existing subscriber, serving as the central pipeline entity from qualification through closed-won handoff to order fulfillment. Tracks opportunity stage, estimated contract value, close date, sales channel (retail/telesales/digital/dealer), segment (B2C/B2B/MVNO wholesale), win/loss reason, associated product offerings, and fulfillment handoff details. For enterprise/B2B accounts, includes strategic account planning attributes: growth objectives, whitespace analysis, key stakeholder map, planned upsell/cross-sell initiatives, competitive threats, and target MRR growth. Terminal closed-won state triggers order creation in the order domain. Sourced from Salesforce CRM Opportunity Management module.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`quote` (
    `quote_id` BIGINT COMMENT 'Primary key for quote',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Quotes for wholesale, MVNO, or dealer customers must reference the governing partner agreement that defines pricing floors, SLA tiers, and commercial terms. Telecom sales teams require this link for q',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Quotes require billing account reference for credit limit checks, payment terms validation, billing address verification, account hierarchy in B2B scenarios, and consolidated billing eligibility asses',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Quotes must identify the authorized contact for presentation, approval, and signature. Required for contract formation, legal compliance, and tracking quote acceptance workflow in telecommunications s',
    `dealer_id` BIGINT COMMENT 'Reference to the dealer or agent who generated the quote, if applicable. Used for commission calculation and channel performance tracking.',
    `opportunity_id` BIGINT COMMENT 'Reference to the sales opportunity that generated this quote. Links to the Salesforce CRM opportunity record.',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to sales.promotion. Business justification: Quotes currently have promotional_code (STRING) to capture promotion references. This should be normalized to a FK relationship to the promotion master table for referential integrity, promotion rule ',
    `rate_plan_id` BIGINT COMMENT 'Foreign key linking to billing.rate_plan. Business justification: A quote proposes specific billing rate plans to the customer. Quote-to-bill reconciliation — verifying the billed rate plan matches what was quoted — is a core telecom revenue assurance process. This ',
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Enterprise service quotes require site-specific details for accurate pricing of installation, CPE deployment, circuit provisioning, and site-based SLA tiers. Essential for multi-site quote generation ',
    `sla_contract_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_contract. Business justification: Enterprise telecom quotes explicitly include SLA terms (uptime guarantees, MTTR, penalty clauses). The quote must reference the specific SLA contract to correctly price SLA-related charges and penalti',
    `accepted_date` DATE COMMENT 'Date when the customer formally accepted the quote, triggering contract creation or order fulfillment.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether the quote requires management approval before being presented to the customer, typically based on discount thresholds or contract value.',
    `approved_date` DATE COMMENT 'Date when the quote received internal management approval.',
    `billing_frequency` STRING COMMENT 'Frequency at which the customer will be billed for recurring charges: monthly, quarterly, annually, or one-time.. Valid values are `monthly|quarterly|annually|one_time`',
    `competitor_name` STRING COMMENT 'Name of the competitor that the customer is evaluating or currently using, captured during the quoting process for competitive intelligence.',
    `contract_term_months` STRING COMMENT 'Duration of the proposed contract term in months (e.g., 12, 24, 36). Used to calculate Total Contract Value (TCV).',
    `created_date` DATE COMMENT 'Date when the quote was initially created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in the quote (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Target customer segment for this quote: Business-to-Consumer (B2C) retail, Business-to-Business (B2B) small-medium enterprise, B2B enterprise, Mobile Virtual Network Operator (MVNO) wholesale, or government.. Valid values are `b2c_retail|b2b_sme|b2b_enterprise|mvno_wholesale|government`',
    `external_reference_code` STRING COMMENT 'External reference identifier from partner systems, dealer portals, or third-party quoting platforms.',
    `is_primary_version` BOOLEAN COMMENT 'Indicates whether this version is the primary/active version of the quote. Only one version per quote number should be primary.',
    `modified_date` DATE COMMENT 'Date when the quote was last modified.',
    `monthly_recurring_revenue` DECIMAL(18,2) COMMENT 'Monthly Recurring Revenue (MRR): the predictable monthly revenue stream from subscription-based services in this quote.',
    `notes` STRING COMMENT 'Internal notes and comments from the sales team regarding the quote, customer negotiations, special considerations, or follow-up actions.',
    `one_time_charges` DECIMAL(18,2) COMMENT 'Total one-time charges in the quote, including activation fees, installation fees, Customer Premises Equipment (CPE) costs, and setup charges.',
    `payment_terms` STRING COMMENT 'Payment terms specified in the quote: net 30/60/90 days, prepaid, postpaid, or due on receipt.. Valid values are `net_30|net_60|net_90|prepaid|postpaid|due_on_receipt`',
    `presented_date` DATE COMMENT 'Date when the quote was formally presented or sent to the customer.',
    `quote_description` STRING COMMENT 'Detailed description of the quote, including service bundle details, special terms, and customer-specific notes.',
    `quote_name` STRING COMMENT 'Descriptive name or title for the quote, typically reflecting the service bundle or customer segment.',
    `quote_number` STRING COMMENT 'Externally visible business identifier for the quote. Format: QT-YYYYMMDD followed by sequence.. Valid values are `^QT-[0-9]{8}$`',
    `quote_status` STRING COMMENT 'Current lifecycle status of the quote: draft (being prepared), pending approval (awaiting internal sign-off), approved (ready to present), presented (sent to customer), accepted (customer agreed), rejected (customer declined), expired (validity period lapsed), or withdrawn (cancelled by sales). [ENUM-REF-CANDIDATE: draft|pending_approval|approved|presented|accepted|rejected|expired|withdrawn — 8 candidates stripped; promote to reference product]',
    `quote_type` STRING COMMENT 'Classification of the quote based on the nature of the commercial transaction: new service acquisition, service upgrade, contract renewal, service modification, or service disconnect.. Valid values are `new_service|upgrade|renewal|modification|disconnect`',
    `rejected_date` DATE COMMENT 'Date when the customer formally rejected or declined the quote.',
    `rejection_reason` STRING COMMENT 'Free-text explanation or categorized reason provided by the customer or sales team for quote rejection.',
    `service_activation_date` DATE COMMENT 'Proposed or committed date when services will be activated for the customer if the quote is accepted.',
    `source_system` STRING COMMENT 'Source system or application where the quote was originally created (e.g., Salesforce CRM, Oracle CPQ, custom quoting tool).',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Subtotal amount before taxes and fees, representing the sum of all line item charges after discounts.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the quote, including sales tax, value-added tax (VAT), goods and services tax (GST), and regulatory fees.',
    `terms_and_conditions` STRING COMMENT 'Legal terms and conditions associated with the quote, including Service Level Agreement (SLA) commitments, cancellation policies, and liability clauses.',
    `total_amount` DECIMAL(18,2) COMMENT 'Grand total amount of the quote including all charges, discounts, taxes, and fees. This is the final amount presented to the customer.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Total Contract Value (TCV): the total revenue expected over the full contract term, including all recurring and one-time charges.',
    `total_discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied across all line items in the quote, including promotional discounts, volume discounts, and negotiated price reductions.',
    `total_discount_percentage` DECIMAL(18,2) COMMENT 'Overall discount percentage applied to the quote, calculated as total discount divided by list price total.',
    `valid_from_date` DATE COMMENT 'Start date of the quote validity period. Quote pricing and terms are guaranteed from this date.',
    `valid_until_date` DATE COMMENT 'End date of the quote validity period. Quote expires after this date and pricing/terms are no longer guaranteed.',
    `version_number` STRING COMMENT 'Version number of the quote. Increments with each revision to track quote evolution during negotiation.',
    `win_probability_percentage` DECIMAL(18,2) COMMENT 'Estimated probability of winning the deal and converting the quote to a contract, expressed as a percentage (0-100).',
    CONSTRAINT pk_quote PRIMARY KEY(`quote_id`)
) COMMENT 'Commercial quote issued to a prospect or existing customer detailing proposed telecom services, pricing, discounts, promotional offers, and contract terms with full itemized line-level detail. Tracks quote version, validity period, approval status, total contract value (TCV), monthly recurring revenue (MRR), associated opportunity, and individual line items: product catalog reference, unit price, discount applied, quantity, recurring vs one-time charge classification, promotional code, and bundle composition. Supports B2C retail, B2B enterprise, and MVNO wholesale quoting workflows with complete pricing breakdown at both header and line level.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`quote_line` (
    `quote_line_id` BIGINT COMMENT 'Unique identifier for the quote line item. Primary key.',
    `addon_id` BIGINT COMMENT 'Foreign key linking to product.addon. Business justification: Many quote lines represent add-on services (international roaming, extra data, premium content). This link enables add-on attach rate analysis, cross-sell effectiveness tracking, and incremental reven',
    `address_id` BIGINT COMMENT 'Reference to the service delivery address for this line item. Critical for Fiber to the Home (FTTH), fixed broadband, and enterprise connectivity services.',
    `bundle_id` BIGINT COMMENT 'Reference to a product bundle if this line is part of a multi-service package. Enables bundle pricing logic and cross-service dependencies.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Quote lines itemize specific catalog products being quoted. Essential for quote-to-order accuracy, product revenue attribution, and ensuring quoted items match orderable catalog. Removes denormalized ',
    `channel_id` BIGINT COMMENT 'Foreign key linking to sales.channel. Business justification: quote_line.sales_channel is a free-text STRING that should reference the channel master. Individual quote lines may be attributed to specific channels (e.g., in multi-channel bundles). Adding channel_',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: Quote lines for equipment upgrades or replacements reference the specific asset being replaced to calculate trade-in credit, validate compatibility, and determine installation requirements. Standard q',
    `device_model_id` BIGINT COMMENT 'Foreign key linking to product.device_model. Business justification: Telecom quote lines frequently include device sales (handsets, routers). Device model drives retail pricing, compatibility validation, commission calculation, and subsidy eligibility. quote_line has c',
    `fiber_cable_id` BIGINT COMMENT 'Foreign key linking to inventory.fiber_cable. Business justification: Wholesale fiber lease quote lines reference specific cable segments being leased to enterprise or carrier customers. Required for dark fiber and IRU sales, capacity validation, and route planning.',
    `ip_address_pool_id` BIGINT COMMENT 'Foreign key linking to inventory.ip_address_pool. Business justification: Enterprise internet quotes for static IP services reference a specific IP address pool to confirm availability and reserve capacity before contract signing. Telecom sales engineers and IP address mana',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Individual quote lines in enterprise telecom represent changes to specific managed services (bandwidth upgrades, add-ons). Linking quote_line to managed_service enables accurate change-order quoting a',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: Enterprise and wholesale quotes for dedicated network services, colocation, or managed infrastructure reference specific network equipment to be provisioned, upgraded, or allocated to the customer. St',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Telecom quote lines are priced against specific offerings (e.g., Fiber 500 Unlimited). Offering drives eligibility rules, pricing model, and downstream order fulfillment. Quote-to-offering traceabil',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: Fiber service quote lines reference existing ONT assets when quoting upgrades, replacements, or bandwidth increases to determine if new equipment is required and calculate installation costs.',
    `parent_line_quote_line_id` BIGINT COMMENT 'Reference to another quote line if this line is a dependent or child item. Supports hierarchical quote structures for complex telecom solutions.',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Quote lines must reference the specific price plan being offered to ensure billing system alignment, contract accuracy, and correct revenue recognition. Critical for quote-to-cash process integrity an',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to sales.promotion. Business justification: quote_line has promotional_code and promotional_description as free-text STRING fields. The promotion master table is the authoritative source for promotion details. While quote.promotion_id captures ',
    `qos_profile_id` BIGINT COMMENT 'Foreign key linking to network.network_qos_profile. Business justification: Each quote line specifies the QoS tier (guaranteed bit rate, packet delay budget, SLA tier) to be delivered. The network_qos_profile directly determines pricing and SLA commitments on the quote line. ',
    `quote_id` BIGINT COMMENT 'Reference to the parent commercial quote containing this line item. Links this line to the overall quote header.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to interconnect.rate. Business justification: When quoting wholesale voice termination or roaming services to carrier customers, each quote line references the applicable interconnect rate (from interconnect.rate) to derive pricing. Telecom whole',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Individual quote line items for mandatory regulated features (E911, CALEA-compliant intercept capability, universal service contributions) must reference the specific regulatory obligation requiring t',
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_site. Business justification: Multi-site enterprise quotes require each quote line to reference the specific enterprise site being served. Telecom enterprise quoting for multi-location customers assigns services per site at the li',
    `spec_id` BIGINT COMMENT 'Reference to the product catalog entry representing the specific telecom product, service plan, or bundle being quoted. Links to the master product catalog.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this line requires management approval due to special pricing, high discount, or non-standard terms. Triggers approval workflow routing.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this quote line was approved. Used for Service Level Agreement (SLA) tracking and quote-to-order cycle time analysis.',
    `billing_frequency` STRING COMMENT 'Frequency at which recurring charges will be billed. Defines the billing cycle for Monthly Recurring Revenue (MRR) calculation and revenue recognition. [ENUM-REF-CANDIDATE: monthly|quarterly|annually|one_time|usage_based|daily|weekly — 7 candidates stripped; promote to reference product]',
    `charge_type` STRING COMMENT 'Classification of the charge structure for this line item. Distinguishes between one-time fees, recurring subscription charges, and usage-based billing models. [ENUM-REF-CANDIDATE: one_time|recurring|usage_based|installation|activation|termination|overage — 7 candidates stripped; promote to reference product]',
    `commission_amount` DECIMAL(18,2) COMMENT 'Calculated commission or dealer compensation amount for this line item. Used for sales incentive calculation and partner settlement.',
    `commission_eligible_flag` BOOLEAN COMMENT 'Indicates whether this line item qualifies for sales commission or dealer compensation. Some promotional or subsidized offerings may be commission-exempt.',
    `configuration_details` STRING COMMENT 'Technical configuration parameters or service specifications for this line item. Captures bandwidth tiers, Quality of Service (QoS) levels, Service Level Agreement (SLA) parameters, or Customer Premises Equipment (CPE) specifications.',
    `contract_term_months` STRING COMMENT 'Duration of the service commitment in months for this line item. Used to calculate Customer Lifetime Value (CLTV) and enforce early termination penalties.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this quote line record was first created in the system. Audit field for record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this line (e.g., USD, EUR, GBP). Critical for multi-currency quote management.. Valid values are `^[A-Z]{3}$`',
    `dealer_code` STRING COMMENT 'Unique identifier for the dealer or agent partner if this line was sold through an indirect channel. Critical for Mobile Virtual Network Operator (MVNO) and dealer commission management.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total monetary discount applied to this line item. Calculated as (list_price - unit_price) * quantity.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the list price. Expressed as a decimal (e.g., 15.00 for 15% discount). Used for promotional pricing and volume discounts.',
    `extended_amount` DECIMAL(18,2) COMMENT 'Total line amount calculated as unit_price multiplied by quantity. Represents the subtotal for this line before taxes.',
    `line_number` STRING COMMENT 'Sequential line number within the quote for ordering and display purposes. Determines the presentation order of line items on the quote document.',
    `line_status` STRING COMMENT 'Current lifecycle status of this quote line item. Tracks approval workflow and line-level acceptance or rejection.. Valid values are `draft|active|approved|rejected|cancelled|expired`',
    `list_price` DECIMAL(18,2) COMMENT 'Standard catalog price per unit before any discounts or promotions are applied. Represents the published rate card price.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this quote line record was last updated. Audit field for change tracking and data lineage.',
    `notes` STRING COMMENT 'Free-text notes or special instructions related to this quote line. Captures custom requirements, provisioning notes, or customer-specific terms.',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units or subscriptions being quoted for this line item. May represent device count, user licenses, circuit count, or service instances depending on product type.',
    `service_end_date` DATE COMMENT 'Proposed date when the service commitment ends for this line item. Used for contract renewal management and churn forecasting.',
    `service_start_date` DATE COMMENT 'Proposed date when service delivery will commence for this line item. Critical for provisioning scheduling and revenue recognition start date.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this line item. Includes sales tax, VAT, GST, or other jurisdiction-specific telecommunications taxes.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final total for this line item including all charges and taxes. Calculated as extended_amount plus tax_amount.',
    `unit_of_measure` STRING COMMENT 'Unit by which the quantity is measured. Critical for bandwidth products, capacity-based services, and subscription models. [ENUM-REF-CANDIDATE: each|subscription|license|circuit|port|line|user|device|gb|tb|mbps|gbps|month|year — 14 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'Actual price per unit after discounts and promotions have been applied. This is the effective rate the customer will be charged.',
    CONSTRAINT pk_quote_line PRIMARY KEY(`quote_line_id`)
) COMMENT 'Individual line item within a commercial quote representing a specific product, service plan, or bundle being offered. Captures product catalog reference, unit price, discount applied, quantity, recurring vs one-time charge classification, and promotional code. Enables itemized pricing breakdown for complex multi-service telecom quotes.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`sales_contract` (
    `sales_contract_id` BIGINT COMMENT 'Unique identifier for the sales contract. Primary key.',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Telecom sales contracts are frequently executed for a specific bundle (e.g., enterprise converged services bundle). Contract renewal, price escalation, and ETF calculations depend on knowing the contr',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Sales contracts for enterprise customers must link to corporate accounts for master agreement tracking, multi-site contract management, enterprise SLA enforcement, renewal pipeline management, and con',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: Broadband and TV sales contracts cover a specific CPE device provided to the customer. Contract terms including ETF schedule, equipment ownership transfer, and warranty obligations are tied to the spe',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that is the counterparty to this contract.',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Contracts require tracking the specific authorized signatory contact for legal enforceability, audit trails, and regulatory compliance (e.g., CPNI authorization). Role-prefixed to distinguish from gen',
    `enterprise_contract_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_contract. Business justification: Sales contracts for enterprise services must reference master commercial contracts for pricing schedule inheritance, discount scheme application, SLA tier enforcement, and amendment tracking. Critical',
    `segment_id` BIGINT COMMENT 'Foreign key linking to enterprise.segment. Business justification: Enterprise sales contracts are segment-specific in telecom, with segment determining SLA tiers, pricing models, and regulatory compliance requirements (e.g., government vs. large enterprise). Segment-',
    `fiber_cable_id` BIGINT COMMENT 'Foreign key linking to inventory.fiber_cable. Business justification: Dark fiber lease and IRU contracts reference the specific cable infrastructure being leased long-term to enterprise or carrier customers. Essential for wholesale fiber business, asset tracking, and co',
    `ip_address_pool_id` BIGINT COMMENT 'Foreign key linking to inventory.ip_address_pool. Business justification: Business internet contracts with static IP allocations contractually commit a specific IP address pool to the customer. IP address management, regulatory compliance (lawful intercept mapping), and con',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: A sales contract governs the delivery of a specific managed service in telecom. This link is required for SLA enforcement, billing reconciliation, and contract renewal management. Telecom operations t',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: Fiber broadband sales contracts govern service delivered through a specific ONT at the customer premises. Contract SLA enforcement, warranty terms, ETF calculation, and renewal processes all require k',
    `opportunity_id` BIGINT COMMENT 'Reference to the sales opportunity in Salesforce CRM that led to this contract. Nullable for contracts not originated from opportunity pipeline.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: A sales contract executed with a wholesale or MVNO customer is governed by a master partner agreement. Role-prefix partner_ used to distinguish from enterprise_contract_id already present. Enables c',
    `partner_id` BIGINT COMMENT 'Reference to the partner, dealer, or agent organization if the contract was sold through an indirect channel. Null for direct sales.',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Telecom sales contracts lock in a specific price plan for the contract term. Price lock flags, escalation percentages, ETF schedules, and MRR calculations all depend on the contracted price plan. sale',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Contracts formalize the sale of specific offerings. This link is essential for contract compliance monitoring, renewal management, product lifecycle tracking, and ensuring contracted services match pr',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: Sales contracts are executed based on accepted quotes. This is a standard sales pipeline progression: lead → opportunity → quote → contract. The contract formalizes the commercial terms negotiated in ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Telecom service contracts must reference specific regulatory obligations (CPNI protection, E911 service delivery, lawful intercept cooperation). Contract templates include compliance clauses tied to r',
    `sla_contract_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_contract. Business justification: Commercial sales contracts reference technical SLA agreements that define performance commitments. The sales contract governs commercial terms (pricing, term, payment) while the SLA contract defines t',
    `sla_profile_id` BIGINT COMMENT 'Foreign key linking to service.sla_profile. Business justification: A sales contract commits to a specific SLA profile governing uptime, MTTR, and latency thresholds. Linking to the operational sla_profile enables contract compliance auditing and SLA breach credit pro',
    `slice_id` BIGINT COMMENT 'Foreign key linking to network.slice. Business justification: 5G network slice commercial contracts (private 5G, network-as-a-service) formalize the commercial terms for a specific slice instance. The sales contract governs SLA, pricing, and tenant rights for th',
    `spectrum_license_id` BIGINT COMMENT 'Foreign key linking to compliance.spectrum_license. Business justification: Telecom sales contracts for wireless services must cite the spectrum license under which service is delivered. Contract management and regulatory reporting require traceability from executed contracts',
    `transmission_link_id` BIGINT COMMENT 'Foreign key linking to network.transmission_link. Business justification: Enterprise sales contracts for dedicated connectivity services (leased lines, dark fiber, MPLS circuits) are legally bound to a specific transmission link. Contract SLA terms, pricing, and renewal con',
    `amendment_count` STRING COMMENT 'Total number of amendments executed against this contract since original signing. Zero for unamended contracts.',
    `approval_date` DATE COMMENT 'Date when the contract received final internal approval before execution. Null if approval workflow not required.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at the end of the term (True) or requires explicit renewal action (False).',
    `billing_frequency` STRING COMMENT 'Frequency at which invoices are generated under this contract: monthly, quarterly, annually, or one_time for single-payment contracts.. Valid values are `monthly|quarterly|annually|one_time`',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the contract, typically formatted with prefix and numeric sequence.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `contract_status` STRING COMMENT 'Current lifecycle status of the contract: draft (being prepared), pending_approval (awaiting authorization), active (in force), suspended (temporarily inactive), terminated (ended early), or expired (reached natural end date).. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `contract_type` STRING COMMENT 'Classification of the contract based on customer segment: B2C (Business to Consumer) retail, B2B (Business to Business) enterprise, MVNO (Mobile Virtual Network Operator) wholesale, or other wholesale arrangements.. Valid values are `B2C|B2B|MVNO|wholesale|enterprise|retail`',
    `cpni_authorization_included` BOOLEAN COMMENT 'Indicates whether the contract includes Customer Proprietary Network Information (CPNI) authorization clauses allowing use of customer network usage data for marketing purposes, as required by FCC regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this contract (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `e911_compliance_clause` BOOLEAN COMMENT 'Indicates whether the contract includes Enhanced 911 (E911) service disclosure and compliance clauses for VoIP or wireless services, as mandated by FCC.',
    `effective_end_date` DATE COMMENT 'Date when the contract expires or terminates. Nullable for open-ended or evergreen contracts.',
    `effective_start_date` DATE COMMENT 'Date when the contract becomes legally binding and services commence.',
    `etf_amount` DECIMAL(18,2) COMMENT 'Maximum Early Termination Fee (ETF) amount charged for early contract cancellation. Actual fee may vary based on schedule type and remaining term. Null if no ETF applies.',
    `etf_schedule_type` STRING COMMENT 'Type of Early Termination Fee (ETF) schedule applied if customer terminates before contract end: none (no penalty), flat (fixed fee), declining (reduces over time), or prorated (proportional to remaining term).. Valid values are `none|flat|declining|prorated`',
    `last_amendment_date` DATE COMMENT 'Date of the most recent contract amendment. Null if no amendments have been executed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was last updated, including amendments, status changes, or data corrections.',
    `mrr_amount` DECIMAL(18,2) COMMENT 'Monthly Recurring Revenue (MRR) committed under this contract, representing predictable subscription-based revenue stream.',
    `notes` STRING COMMENT 'Free-text field for additional contract-specific notes, special terms, or internal comments not captured in structured fields.',
    `payment_terms` STRING COMMENT 'Payment terms defining when payment is due: net_30/60/90 (days after invoice), due_on_receipt (immediate), prepaid (advance payment), or postpaid (arrears billing).. Valid values are `net_30|net_60|net_90|due_on_receipt|prepaid|postpaid`',
    `price_escalation_percentage` DECIMAL(18,2) COMMENT 'Annual percentage increase applied to recurring charges if price lock is disabled. Null if no escalation clause exists.',
    `price_lock_flag` BOOLEAN COMMENT 'Indicates whether pricing is locked for the contract term (True) or subject to periodic adjustments (False).',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this contract includes specific regulatory compliance clauses required by FCC, CPNI, E911, or other telecommunications regulations (True) or is a standard commercial agreement (False).',
    `renewal_term_months` STRING COMMENT 'Duration in months for each automatic renewal period if auto-renewal is enabled. Null if auto-renewal is disabled.',
    `sales_channel` STRING COMMENT 'Channel through which the contract was acquired: direct (enterprise sales team), retail_store (company-owned), online (web/mobile), telesales (call center), partner/dealer/agent (third-party intermediaries). [ENUM-REF-CANDIDATE: direct|retail_store|online|telesales|partner|dealer|agent — 7 candidates stripped; promote to reference product]',
    `signed_date` DATE COMMENT 'Date when the contract was executed and signed by all parties.',
    `tcv_amount` DECIMAL(18,2) COMMENT 'Total Contract Value (TCV) representing the aggregate revenue expected over the full contract term, including all recurring and one-time charges.',
    `term_months` STRING COMMENT 'Duration of the contract commitment period expressed in months (e.g., 12, 24, 36). Null for month-to-month or evergreen contracts.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate or non-renew the contract. Null if no notice period specified.',
    `uptime_sla_percentage` DECIMAL(18,2) COMMENT 'Contractually committed network uptime percentage (e.g., 99.9%, 99.99%) as part of the SLA. Null if no specific uptime commitment exists.',
    CONSTRAINT pk_sales_contract PRIMARY KEY(`sales_contract_id`)
) COMMENT 'Executed commercial contract between Telecommunication and a customer (B2C, B2B enterprise, or MVNO wholesale) formalizing agreed services, pricing, SLA commitments, contract duration, auto-renewal terms, early termination fee (ETF) schedule, and regulatory compliance clauses. Includes full amendment lifecycle tracking: amendment type (price change, scope change, term extension, service addition/removal), effective dates, approval chain, reason codes, MRR/TCV delta values, and amendment status from request through execution. Distinct from the service agreement in the service domain — this is the commercial/legal sales instrument managed in Salesforce CRM contract module.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`channel` (
    `channel_id` BIGINT COMMENT 'Primary key for channel',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: A partner-operated sales channel (dealer, reseller, MVNO) is authorized and governed by a specific partner agreement defining channel rights, territory scope, and commission terms. Telecom channel man',
    `commission_plan_id` BIGINT COMMENT 'Foreign key linking to sales.commission_plan. Business justification: channel.commission_structure_code is a free-text STRING that should reference the commission_plan master. Each sales channel operates under a defined commission plan that governs how commissions are c',
    `segment_id` BIGINT COMMENT 'Foreign key linking to enterprise.segment. Business justification: Sales channels in telecom are scoped to specific enterprise segments (dedicated enterprise channel vs. SMB channel). The plain text segment_scope is a denormalized enterprise segment reference. A prop',
    `partner_id` BIGINT COMMENT 'Reference to the partner organization record for dealer, agent, or reseller channels. Null for company-owned channels.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Telecom sales channels (telemarketing, door-to-door) are subject to channel-specific regulatory obligations (FTC telemarketing rules, state door-to-door sales laws). Channel compliance management trac',
    `revenue_share_plan_id` BIGINT COMMENT 'Foreign key linking to partner.revenue_share_plan. Business justification: A sales channel operated by a dealer or reseller partner runs under a specific revenue share plan governing commission calculations and settlement. Telecom channel finance teams require this link for ',
    `sales_contract_id` BIGINT COMMENT 'Reference to the master channel agreement or dealer contract governing this channel relationship. Null for internal channels.',
    `team_id` BIGINT COMMENT 'Reference to the sales team assigned to manage this channel and territory.',
    `accepts_walk_in` BOOLEAN COMMENT 'Indicates whether this channel accepts walk-in customers without appointments. Applicable to physical retail and dealer locations.',
    `capacity` STRING COMMENT 'Maximum number of concurrent sales opportunities or leads this channel can handle effectively, used for lead distribution and capacity planning.',
    `channel_code` STRING COMMENT 'Unique business identifier code for the sales channel used across systems and reporting (e.g., RET-001, TELE-002, ONLINE-WEB).. Valid values are `^[A-Z0-9]{3,10}$`',
    `channel_description` STRING COMMENT 'Detailed description of the channels purpose, capabilities, target customer segments, and operational characteristics.',
    `channel_name` STRING COMMENT 'Human-readable name of the sales channel (e.g., Flagship Retail Store - Downtown, Telesales Inbound Team, Digital Self-Service Portal).',
    `channel_status` STRING COMMENT 'Current operational status of the sales channel in the sales ecosystem.. Valid values are `active|inactive|suspended|pending_activation`',
    `channel_type` STRING COMMENT 'Classification of the sales channel by operational model: retail_store (physical company-owned stores), telesales (inbound/outbound phone sales), online_digital (web/mobile self-service), dealer_agent (third-party authorized dealers), enterprise_direct (B2B direct sales teams), partner_reseller (MVNO wholesale and reseller partners).. Valid values are `retail_store|telesales|online_digital|dealer_agent|enterprise_direct|partner_reseller`',
    `city` STRING COMMENT 'City name for physical channel locations. Null for virtual channels.',
    `contact_email` STRING COMMENT 'Primary email address for channel communications and support.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary contact phone number for the channel location or team.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the channel operates (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel record was first created in the system.',
    `crm_system_code` STRING COMMENT 'External identifier for this channel in the Salesforce CRM system, used for cross-system reconciliation and integration.',
    `digital_platform_url` STRING COMMENT 'Web URL or mobile app identifier for digital/online channels. Null for physical channels.',
    `effective_end_date` DATE COMMENT 'Date when this channel ceased operations or was deactivated. Null for currently active channels.',
    `effective_start_date` DATE COMMENT 'Date when this channel became active and authorized to conduct sales activities.',
    `is_primary_channel` BOOLEAN COMMENT 'Indicates whether this is the primary/preferred channel for the assigned territory. Used in lead routing tie-breaker logic.',
    `language_supported` STRING COMMENT 'Comma-separated list of ISO 639-1 language codes supported by this channel (e.g., en, es, fr). Used for customer routing and service delivery.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel record was last updated.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent performance evaluation and tier classification review for this channel.',
    `lead_assignment_priority` STRING COMMENT 'Numeric priority ranking (1=highest) used in automated lead distribution algorithms to route leads to channels based on performance, capacity, and segment fit.',
    `next_performance_review_date` DATE COMMENT 'Scheduled date for the next performance evaluation and potential tier reclassification.',
    `notes` STRING COMMENT 'Free-form notes for special instructions, operational considerations, or historical context about this channel.',
    `operating_hours` STRING COMMENT 'Standard operating hours for the channel (e.g., Mon-Fri 9AM-6PM, 24/7, By Appointment). Used for customer expectation setting and capacity planning.',
    `performance_tier` STRING COMMENT 'Current performance classification tier based on sales metrics, used for incentive allocation and resource prioritization.. Valid values are `platinum|gold|silver|bronze|standard`',
    `physical_address_line1` STRING COMMENT 'Primary street address line for physical channel locations (retail stores, dealer offices). Null for virtual channels.',
    `physical_address_line2` STRING COMMENT 'Secondary address line (suite, floor, building) for physical channel locations. Null for virtual channels.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for physical channel locations. Null for virtual channels.',
    `region_code` STRING COMMENT 'Geographic region code where this channel operates (e.g., NE for Northeast, SW for Southwest, EMEA for international operations).. Valid values are `^[A-Z]{2,5}$`',
    `region_name` STRING COMMENT 'Human-readable name of the geographic region (e.g., Northeast Region, Southwest Region, EMEA Operations).',
    `state_province` STRING COMMENT 'Two-letter state or province code for physical channel locations (e.g., CA, NY, TX). Null for virtual channels.. Valid values are `^[A-Z]{2}$`',
    `supports_business_accounts` BOOLEAN COMMENT 'Indicates whether this channel is authorized and equipped to handle B2B enterprise account sales and service.',
    `supports_mnp` BOOLEAN COMMENT 'Indicates whether this channel can process Mobile Number Portability (MNP) requests for customers switching from other carriers.',
    `territory_code` STRING COMMENT 'Unique identifier for the sales territory assignment within the region (e.g., NE-METRO-01, SW-RURAL-05, ENT-FINANCE-EAST).. Valid values are `^[A-Z0-9-]{3,15}$`',
    `territory_name` STRING COMMENT 'Descriptive name of the sales territory (e.g., Metro Boston Territory, Rural Texas Territory, Enterprise Financial Services - East Coast).',
    `territory_type` STRING COMMENT 'Classification of territory assignment model: geographic (location-based), vertical (industry-based for B2B), named_account (specific enterprise accounts), hybrid (combination of models).. Valid values are `geographic|vertical|named_account|hybrid`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the channel location (e.g., America/New_York, America/Los_Angeles, Europe/London).',
    CONSTRAINT pk_channel PRIMARY KEY(`channel_id`)
) COMMENT 'Reference master defining all sales channels, their associated territory assignments, and geographic/segment-based territory hierarchies through which Telecommunication acquires customers — retail stores, telesales, online/digital self-serve, dealer/agent, MVNO wholesale, enterprise direct sales, and partner resellers. Captures channel type, channel code, region, territory hierarchy (geographic/vertical/named account), territory code, territory type, assigned sales team, active status, commission structure reference, performance tier classification, territory-to-team assignment rules, segment scope (B2C/B2B/MVNO), and effective date ranges. Supports channel performance management, territory management, and equitable lead/opportunity distribution.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`commission_plan` (
    `commission_plan_id` BIGINT COMMENT 'Unique identifier for the commission plan. Primary key.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to enterprise.segment. Business justification: Commission plans in telecom are differentiated by enterprise segment, with higher rates for government or large enterprise deals. Segment-specific commission reporting and plan eligibility rules requi',
    `superseded_by_plan_commission_plan_id` BIGINT COMMENT 'Identifier of the commission plan that replaces this plan when it expires or is terminated. Creates lineage chain for plan evolution. Nullable if plan is current.',
    `accelerator_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to commission rate when accelerator threshold is exceeded (e.g., 1.50 for 150% of base rate). Nullable if plan does not include accelerator.',
    `accelerator_threshold` DECIMAL(18,2) COMMENT 'Sales quota or target that must be exceeded to trigger accelerator multiplier. Nullable if plan does not include accelerator.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether commission payments under this plan require managerial approval before disbursement. True: approval required. False: automatic payment.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the commission plan was approved for activation. Nullable if plan is in draft status.',
    `base_commission_rate` DECIMAL(18,2) COMMENT 'Default commission rate expressed as a decimal percentage (e.g., 0.0500 for 5%). Applies to flat-rate plans or as the starting tier for tiered plans.',
    `business_unit` STRING COMMENT 'Organizational division or business segment to which this commission plan applies. Consumer: B2C retail. Enterprise: B2B corporate. Wholesale: carrier-to-carrier. MVNO (Mobile Virtual Network Operator): reseller partnerships.. Valid values are `consumer|enterprise|wholesale|mvno`',
    `clawback_percentage` DECIMAL(18,2) COMMENT 'Percentage of earned commission that must be returned if clawback is triggered (e.g., 100.00 for full clawback, 50.00 for partial). Expressed as decimal percentage.',
    `clawback_period_days` STRING COMMENT 'Number of days after sale during which customer disconnect or service cancellation triggers commission reversal. Common values: 30, 60, 90 days. Protects against churn-driven commission abuse.',
    `commission_rate_unit` STRING COMMENT 'Unit of measure for the commission calculation. Percentage of revenue: commission on total sale value. Percentage of MRR (Monthly Recurring Revenue): commission on subscription revenue. Flat amount per unit: fixed dollar per activation. Percentage of ARPU (Average Revenue Per User): commission based on customer lifetime value proxy.. Valid values are `percentage_of_revenue|percentage_of_mrr|flat_amount_per_unit|percentage_of_arpu`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this commission plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this plan (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `default_split_percentage` DECIMAL(18,2) COMMENT 'Default percentage of commission allocated to primary participant when splitting is enabled. Expressed as decimal percentage (e.g., 70.00 for 70%). Nullable if splitting not allowed.',
    `effective_end_date` DATE COMMENT 'Date when the commission plan expires and stops accruing new commissions. Nullable for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the commission plan becomes active and begins accruing commissions.',
    `eligible_product_categories` STRING COMMENT 'Comma-separated list of product categories or service types that qualify for commission under this plan (e.g., wireless_postpaid, fiber_internet, enterprise_sd_wan, iptv). Used to filter qualifying sales transactions.',
    `geographic_scope` STRING COMMENT 'Comma-separated list of three-letter ISO country codes or region identifiers where this commission plan is applicable (e.g., USA, CAN, MEX). Supports multi-market compensation management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this commission plan record was last updated. Tracks plan amendments and rate adjustments.',
    `mdf_allocation_amount` DECIMAL(18,2) COMMENT 'Total budget allocated for co-marketing activities with channel partners under this plan. Nullable for non-MDF plans.',
    `participant_type` STRING COMMENT 'Category of sales participant eligible for this commission plan. Internal sales rep: direct employees. Dealer: authorized retail partner. Agent: independent contractor. MVNO (Mobile Virtual Network Operator) partner: wholesale reseller. Channel partner: indirect sales organization.. Valid values are `internal_sales_rep|dealer|agent|mvno_partner|channel_partner`',
    `payment_delay_days` STRING COMMENT 'Number of days after the end of the commission period before payment is issued. Allows time for transaction validation and clawback assessment.',
    `payment_frequency` STRING COMMENT 'Cadence at which earned commissions are paid out to participants. Monthly: paid each month. Quarterly: paid every three months. Semi-annual: twice per year. Annual: once per year. Per transaction: paid immediately upon sale completion.. Valid values are `monthly|quarterly|semi_annual|annual|per_transaction`',
    `plan_code` STRING COMMENT 'Externally-known unique business identifier for the commission plan used in contracts and compensation statements.. Valid values are `^[A-Z0-9]{6,12}$`',
    `plan_description` STRING COMMENT 'Detailed narrative description of the commission plan structure, objectives, and special conditions. Used for participant communication and audit documentation.',
    `plan_name` STRING COMMENT 'Human-readable name of the commission plan (e.g., Q1 2024 Enterprise Sales Accelerator, Dealer Residual Plan).',
    `plan_status` STRING COMMENT 'Current lifecycle state of the commission plan. Draft: under design. Active: in effect and earning commissions. Suspended: temporarily paused. Expired: past effective end date. Terminated: permanently closed.. Valid values are `draft|active|suspended|expired|terminated`',
    `plan_type` STRING COMMENT 'Classification of the commission structure. Flat rate: fixed amount per sale. Tiered: rate increases with volume. Residual: ongoing percentage of recurring revenue. SPIFF (Sales Performance Incentive Fund): short-term bonus for specific products. MDF (Market Development Fund): channel partner co-marketing incentive. Accelerator: multiplier for exceeding quota.. Valid values are `flat_rate|tiered|residual|spiff|mdf|accelerator`',
    `quota_measurement_unit` STRING COMMENT 'Unit of measure for quota target. Revenue: total sales dollars. Unit count: number of products sold. Subscriber count: number of new activations. MRR (Monthly Recurring Revenue): recurring subscription value.. Valid values are `revenue|unit_count|subscriber_count|mrr`',
    `quota_target` DECIMAL(18,2) COMMENT 'Sales target or quota that participants are expected to achieve under this plan. Used to calculate attainment percentage and trigger accelerators.',
    `residual_duration_months` STRING COMMENT 'Number of months that residual commissions continue to be paid on recurring revenue from the original sale. Nullable for non-residual plans.',
    `residual_rate` DECIMAL(18,2) COMMENT 'Commission rate applied to ongoing MRR (Monthly Recurring Revenue) for residual plans. Expressed as decimal percentage. Nullable for non-residual plans.',
    `spiff_amount` DECIMAL(18,2) COMMENT 'Fixed bonus amount paid for selling specific high-priority products or services during promotional periods. Nullable for non-SPIFF plans.',
    `split_eligible_flag` BOOLEAN COMMENT 'Indicates whether commissions under this plan can be split among multiple participants (e.g., sales rep and sales manager). True: splitting allowed. False: single participant only.',
    `terms_and_conditions_url` STRING COMMENT 'URL link to the full legal terms and conditions document governing this commission plan. Provides participants with complete plan rules and dispute resolution procedures.. Valid values are `^https?://.*$`',
    `tier_1_rate` DECIMAL(18,2) COMMENT 'Commission rate applicable when sales reach tier 1 threshold. Expressed as decimal percentage. Nullable for non-tiered plans.',
    `tier_1_threshold` DECIMAL(18,2) COMMENT 'Sales volume or revenue threshold to qualify for tier 1 commission rate in tiered plans. Nullable for non-tiered plans.',
    `tier_2_rate` DECIMAL(18,2) COMMENT 'Commission rate applicable when sales reach tier 2 threshold. Expressed as decimal percentage. Nullable for non-tiered plans.',
    `tier_2_threshold` DECIMAL(18,2) COMMENT 'Sales volume or revenue threshold to qualify for tier 2 commission rate in tiered plans. Nullable for non-tiered plans.',
    `tier_3_rate` DECIMAL(18,2) COMMENT 'Commission rate applicable when sales reach tier 3 threshold. Expressed as decimal percentage. Nullable for non-tiered plans.',
    `tier_3_threshold` DECIMAL(18,2) COMMENT 'Sales volume or revenue threshold to qualify for tier 3 commission rate in tiered plans. Nullable for non-tiered plans.',
    `version_number` STRING COMMENT 'Sequential version number of this commission plan. Incremented each time the plan is amended. Supports audit trail and historical analysis of plan changes.',
    CONSTRAINT pk_commission_plan PRIMARY KEY(`commission_plan_id`)
) COMMENT 'Reference definition of a sales commission or incentive plan applicable to internal sales reps, dealers, or agents. Captures plan name, plan type (flat rate, tiered, residual, SPIFF, MDF), eligible product categories, commission rate schedule by product/plan type, clawback rules (30/60/90-day disconnect), payment frequency, accelerator thresholds, and effective date range. Provides the authoritative commission structure used to calculate earned commissions and supports audit of dealer payments.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`target` (
    `target_id` BIGINT COMMENT 'Primary key for target',
    `channel_id` BIGINT COMMENT 'Identifier of the sales channel (e.g., retail, online, telesales, enterprise direct) to which this target is assigned. Null if the target is assigned to a specific rep, team, or dealer.',
    `commission_plan_id` BIGINT COMMENT 'Identifier of the sales incentive compensation plan associated with this target. Null if the target is not tied to a specific incentive plan.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Named account sales targets in enterprise telecom assign revenue targets per corporate account to account managers. Account-level target tracking and attainment reporting require linking sales targets',
    `dealer_id` BIGINT COMMENT 'Identifier of the dealer or agent to whom this target is assigned. Used for indirect channel sales performance management. Null if the target is assigned to a direct sales rep or team.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to enterprise.segment. Business justification: Sales targets in enterprise telecom are set by enterprise segment for segment-level performance reporting and quota management. Segment-level attainment dashboards and sales planning require this dire',
    `team_id` BIGINT COMMENT 'Identifier of the sales team to which this target is assigned. Null if the target is assigned to an individual rep, dealer, or channel.',
    `approval_status` STRING COMMENT 'Approval workflow status for the target. Pending targets await management approval; approved targets are authorized for use; rejected targets are declined.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the target was approved. Null if the target has not been approved.',
    `attainment_last_calculated_timestamp` TIMESTAMP COMMENT 'Timestamp when the attainment value and percentage were last recalculated. Supports near-real-time performance tracking.',
    `attainment_percentage` DECIMAL(18,2) COMMENT 'Percentage of target achieved, calculated as (attainment_value / target_value) * 100. Used for sales performance dashboards and incentive calculation.',
    `attainment_value` DECIMAL(18,2) COMMENT 'Actual performance value achieved against the target as of the last calculation date. Updated periodically during the measurement period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sales target record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary targets (e.g., USD, EUR, GBP). Null for non-monetary targets such as activations or churn saves.. Valid values are `^[A-Z]{3}$`',
    `geographic_scope` STRING COMMENT 'Geographic region, territory, or market to which the target applies (e.g., Northeast Region, California, National). Null if the target has no geographic restriction.',
    `incentive_eligible_flag` BOOLEAN COMMENT 'Indicates whether attainment of this target qualifies for sales incentive compensation (commission, bonus, SPIF). True if eligible; false otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the sales target record was last modified.',
    `measurement_period_type` STRING COMMENT 'Frequency or duration type of the target measurement period. Monthly targets reset each month; quarterly targets align with fiscal quarters; annual targets span the fiscal year; custom periods have user-defined start and end dates.. Valid values are `monthly|quarterly|semi_annual|annual|custom`',
    `notes` STRING COMMENT 'Free-text notes or comments about the target, such as special conditions, strategic rationale, or adjustment explanations.',
    `period_end_date` DATE COMMENT 'End date of the measurement period. Performance attainment is calculated at this date.',
    `period_start_date` DATE COMMENT 'Start date of the measurement period during which the target is effective and performance is tracked.',
    `product_category_scope` STRING COMMENT 'Product category or service line to which the target applies (e.g., 5G Mobile, FTTH Broadband, IPTV, IoT Solutions). Null if the target applies to all products.',
    `segment_scope` STRING COMMENT 'Customer segment scope for the target. B2C targets apply to consumer retail sales; B2B targets apply to enterprise and business customers; MVNO (Mobile Virtual Network Operator) targets apply to wholesale partner sales; all indicates the target spans multiple segments.. Valid values are `b2c|b2b|mvno|all`',
    `target_code` STRING COMMENT 'Externally-known unique business identifier for the sales target, used for reference in sales performance management systems and incentive calculation workflows.. Valid values are `^[A-Z0-9]{8,20}$`',
    `target_name` STRING COMMENT 'Human-readable descriptive name of the sales target (e.g., Q1 2024 Enterprise 5G Activations - Northeast Region).',
    `target_status` STRING COMMENT 'Current lifecycle status of the sales target. Draft targets are under review; active targets are in effect; suspended targets are temporarily paused; completed targets have reached their measurement period end; cancelled targets are voided.. Valid values are `draft|active|suspended|completed|cancelled`',
    `target_type` STRING COMMENT 'Classification of the sales target by measurement type. Revenue targets measure monetary goals; activations measure new subscriber additions; ARPU (Average Revenue Per User) targets measure per-customer revenue; churn saves measure customer retention; upsell and cross-sell measure product expansion.. Valid values are `revenue|activations|arpu|churn_saves|upsell|cross_sell`',
    `target_value` DECIMAL(18,2) COMMENT 'Numeric goal value for the target. For revenue targets, this is the monetary amount; for activations, the subscriber count; for ARPU, the per-user revenue amount; for churn saves, the retention count.',
    `threshold_accelerator` DECIMAL(18,2) COMMENT 'Performance threshold above which accelerated incentive rates apply (e.g., 120% attainment triggers 1.5x commission rate). Null if no accelerator applies.',
    `threshold_minimum` DECIMAL(18,2) COMMENT 'Minimum performance threshold required for any incentive payout. Attainment below this value results in zero payout. Null if no minimum threshold applies.',
    `weight_factor` DECIMAL(18,2) COMMENT 'Weighting factor for this target when calculating composite performance scores across multiple targets. Expressed as a decimal (e.g., 0.30 for 30% weight). Sum of all target weights for a rep/team should equal 1.00.',
    CONSTRAINT pk_target PRIMARY KEY(`target_id`)
) COMMENT 'Periodic sales performance target assigned to a sales rep, dealer, team, or channel for a defined measurement period. Captures target type (revenue, activations, ARPU, churn saves, upsell), target value, measurement period (monthly/quarterly), segment scope (B2C/B2B/MVNO), product category scope, and attainment tracking fields. Supports sales performance management and incentive calculation.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`promotion` (
    `promotion_id` BIGINT COMMENT 'Unique identifier for the sales promotion or incentive offer. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Partner-channel promotions (MVNO-exclusive offers, dealer incentive promotions) are scoped to and authorized by specific partner agreements. Telecom marketing and partner teams require this link to va',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Telecom promotions are frequently bundle-specific (e.g., $20/month off Triple Play bundle for 12 months). Bundle attach rate reporting, marketing spend allocation by bundle, and promotion stacking r',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign or initiative that this promotion is part of. Used to group promotions for reporting and performance analysis. Links to Salesforce CRM Campaign object.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to enterprise.segment. Business justification: Enterprise promotions in telecom are segment-specific (e.g., only for large enterprise or government). The plain text eligible_customer_segment is a denormalized representation of enterprise segment. ',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Telecom promotions are applied to specific offerings (e.g., 3 months free on Fiber 1Gbps offering). Promotion eligibility validation, campaign ROI reporting by offering, and redemption tracking all ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Telecom promotions (device subsidies, discounted plans) are subject to regulatory obligations around truth-in-advertising and consumer protection. Compliance approval of promotions references the spec',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Promotions often target specific catalog items (e.g., "50% off iPhone 15 with unlimited plan"). This link is essential for promotion eligibility validation, redemption tracking, and measuring promotio',
    `approval_authority` STRING COMMENT 'Role or title of the person/system authorized to approve redemption of this promotion (e.g., Sales Manager, Regional Director, Automated Credit Check System). Null if approval_required_flag is False.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether redemption of this promotion requires manager or system approval before it can be applied to a quote or order. True = approval workflow required, False = auto-apply allowed.',
    `auto_apply_flag` BOOLEAN COMMENT 'Indicates whether this promotion should be automatically applied to eligible quotes and orders without requiring manual entry of the promotion code. True = auto-apply, False = manual code entry required.',
    `budget_allocated` DECIMAL(18,2) COMMENT 'Total budget allocated for this promotion in the promotions currency. Used to track financial exposure and prevent overspending. Null if no budget cap applies.',
    `budget_consumed` DECIMAL(18,2) COMMENT 'Cumulative amount of budget consumed by redemptions of this promotion to date. Incremented with each redemption. Used to enforce budget_allocated cap and track Return on Investment (ROI).',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for budget_allocated (e.g., USD, EUR, GBP). Null if budget_allocated is null.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this promotion record was first created in the system. Used for audit trail and lifecycle tracking.',
    `discount_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for fixed_amount discounts (e.g., USD, EUR, GBP). Null for percentage or free_unit discount types.. Valid values are `^[A-Z]{3}$`',
    `discount_type` STRING COMMENT 'Mechanism by which the discount is applied: percentage (e.g., 20% off), fixed_amount (e.g., $50 off), free_unit (e.g., 3 months free service).. Valid values are `percentage|fixed_amount|free_unit`',
    `discount_value` DECIMAL(18,2) COMMENT 'Numeric value of the discount. Interpretation depends on discount_type: for percentage, this is the percentage (e.g., 20.00 for 20%); for fixed_amount, this is the currency amount (e.g., 50.00 for $50); for free_unit, this is the number of units (e.g., 3.00 for 3 months).',
    `eligible_product_category` STRING COMMENT 'Comma-separated list of product categories or SKU patterns eligible for this promotion (e.g., wireless_postpaid, fiber_internet, device_smartphone, all_products). Used to constrain which products can receive the discount.',
    `end_date` DATE COMMENT 'Date when the promotion expires and is no longer available for new redemptions. Null indicates an open-ended promotion.',
    `exclusion_list` STRING COMMENT 'Comma-separated list of product SKUs, customer IDs, or other identifiers explicitly excluded from this promotion. Used to enforce business rules and prevent unintended redemptions.',
    `external_promotion_reference` STRING COMMENT 'Unique identifier for this promotion in the source system (e.g., Salesforce Campaign ID, Netcracker Offering ID). Used for cross-system reconciliation and data lineage.',
    `geographic_eligibility` STRING COMMENT 'Comma-separated list of geographic regions, states, or countries where this promotion is valid (e.g., USA, CAN, CA,NY,TX, all_regions). Used to enforce regional marketing campaigns and regulatory compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this promotion record was last updated. Used for audit trail and change management.',
    `minimum_contract_term_months` STRING COMMENT 'Minimum service contract duration in months required to qualify for this promotion. For example, a device subsidy may require a 24-month commitment. Null if no minimum term applies.',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum order or quote value required to qualify for this promotion. For example, enterprise volume discounts may require a $10,000 minimum. Null if no minimum applies.',
    `minimum_purchase_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for minimum_purchase_amount (e.g., USD, EUR, GBP). Null if minimum_purchase_amount is null.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free-text field for internal sales operations or marketing notes about this promotion. Not customer-facing. Used for operational guidance and troubleshooting.',
    `priority_rank` STRING COMMENT 'Numeric priority ranking used to determine which promotion to apply when multiple promotions are eligible and stacking is not allowed. Lower numbers indicate higher priority (e.g., 1 = highest priority).',
    `promotion_code` STRING COMMENT 'Externally-known unique alphanumeric code used to identify and apply the promotion during the sales process. This is the code customers or sales reps enter to activate the offer.. Valid values are `^[A-Z0-9]{6,20}$`',
    `promotion_description` STRING COMMENT 'Detailed business description of the promotion, including terms and conditions, eligibility criteria, and customer-facing messaging. Used for sales rep guidance and customer communication.',
    `promotion_name` STRING COMMENT 'Human-readable marketing name of the promotion (e.g., Summer Device Subsidy, Port-In Bonus Q1 2024, Enterprise Volume Discount Tier 3).',
    `promotion_status` STRING COMMENT 'Current lifecycle state of the promotion: draft (not yet live), active (available for redemption), suspended (temporarily paused), expired (end date passed), terminated (manually closed).. Valid values are `draft|active|suspended|expired|terminated`',
    `promotion_type` STRING COMMENT 'Classification of the promotion by incentive mechanism: device_subsidy (handset discount), free_months (service waiver), bundle_discount (multi-product discount), port_in_bonus (Mobile Number Portability incentive), byod_credit (Bring Your Own Device credit), volume_discount (enterprise bulk pricing).. Valid values are `device_subsidy|free_months|bundle_discount|port_in_bonus|byod_credit|volume_discount`',
    `redemption_count` STRING COMMENT 'Current count of how many times this promotion has been redeemed. Incremented with each successful application. Used to enforce redemption_limit_total.',
    `redemption_limit_per_customer` STRING COMMENT 'Maximum number of times a single customer can redeem this promotion. Null indicates no per-customer cap. Prevents abuse and controls discount exposure.',
    `redemption_limit_total` STRING COMMENT 'Maximum number of times this promotion can be redeemed across all customers and transactions. Null indicates no cap. Used for limited-time or limited-quantity offers.',
    `source_system` STRING COMMENT 'System of record where this promotion was originally created: salesforce_crm (Salesforce CRM opportunity/campaign), netcracker_catalog (Netcracker product catalog), manual_entry (direct data entry), marketing_automation (external marketing platform).. Valid values are `salesforce_crm|netcracker_catalog|manual_entry|marketing_automation`',
    `stacking_allowed_flag` BOOLEAN COMMENT 'Indicates whether this promotion can be combined (stacked) with other promotions on the same quote or order. True = stackable, False = exclusive (cannot be combined).',
    `stacking_rule` STRING COMMENT 'Detailed business rule describing stacking behavior and constraints. For example: Can stack with device subsidies but not with other service discounts, Mutually exclusive with promotion codes PROMO2024*. Null if stacking_allowed_flag is False.',
    `start_date` DATE COMMENT 'Date when the promotion becomes active and available for redemption. Promotions cannot be applied before this date.',
    `terms_and_conditions_url` STRING COMMENT 'URL link to the full legal terms and conditions document for this promotion. Required for regulatory compliance and customer transparency.. Valid values are `^https?://.*$`',
    CONSTRAINT pk_promotion PRIMARY KEY(`promotion_id`)
) COMMENT 'Master record for a sales promotion or incentive offer applicable during the sales process — device subsidies, free months, bundle discounts, port-in bonuses, BYOD credits, and enterprise volume discounts — with full redemption transaction tracking. Captures promotion code, type, eligible segments, eligible products, discount value/percentage, start/end dates, redemption limits, stacking rules, and individual redemption records (redemption date, quote/order/contract reference, applied discount value, redemption channel, applying rep/dealer, validation status). Distinct from billing-layer promotions — this is the sales-stage commercial offer. SSOT boundary: sales.promotion owns offers presented during the sales process; product domain owns catalog-level pricing rules and permanent price structures.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`retention_offer` (
    `retention_offer_id` BIGINT COMMENT 'Unique identifier for the retention offer record. Primary key.',
    `addon_id` BIGINT COMMENT 'Foreign key linking to product.addon. Business justification: Telecom retention offers frequently include a free addon (e.g., free streaming service addon for 3 months) as the retention incentive. Retention effectiveness reporting by addon type and addon cost-pe',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Retention offers for MVNO or wholesale partners must reference the governing partner agreement to determine eligible discount thresholds and permissible contract extension terms. Telecom retention tea',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Retention offers target billing accounts based on payment history, ARPU, account status, and outstanding balance; account_id is essential for offer eligibility determination, financial impact analysis',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Telecom retention offers frequently propose a bundle upgrade as the churn prevention mechanism (e.g., upgrade to converged bundle). Retention analytics measuring churn prevention effectiveness by bund',
    `campaign_id` BIGINT COMMENT 'Reference to the retention campaign or churn management program under which this offer was generated.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to sales.channel. Business justification: retention_offer.channel is a free-text STRING representing the channel through which the retention offer was presented (e.g., inbound call center, digital self-serve, retail store). Adding channel_id ',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise retention offers target corporate accounts at churn risk. Telecom retention teams run account-level churn management programs requiring direct linkage between retention offers and corporate',
    `enterprise_contract_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_contract. Business justification: Retention offers are triggered by expiring or at-risk enterprise contracts. Telecom retention teams need to know which enterprise contract is at risk to tailor the offer. Contract expiry-driven retent',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Retention offers in enterprise telecom are often specific to retaining a managed service contract. Linking to the managed service enables service-level churn analysis and targeted retention strategy r',
    `outage_record_id` BIGINT COMMENT 'Foreign key linking to assurance.outage_record. Business justification: Post-outage retention offers are a standard telecom practice — when a customer is impacted by an outage, a retention offer is created to prevent churn. Linking the offer to the specific outage record ',
    `privacy_consent_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_consent. Business justification: Retention offers require valid marketing consent under TCPA/GDPR. Telecom operators must verify opt-in status before presenting promotional retention offers. Links offer presentation to documented con',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Retention offers propose specific product/plan changes to prevent churn (e.g., upgrade to unlimited plan). This link enables save offer effectiveness analysis by product, churn prevention ROI measurem',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Retention offers often involve price plan changes or discounts. Linking to price_plan enables offer cost analysis, margin impact tracking, and ensuring retention offers are financially sustainable—ess',
    `rate_plan_id` BIGINT COMMENT 'Foreign key linking to billing.rate_plan. Business justification: Retention offers propose a specific billing rate plan to retain a customer (e.g., discounted plan). Linking retention_offer to rate_plan enables billing pre-provisioning of the offered plan and tracks',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Telecom retention offers (ETF waivers, contract extensions) are subject to consumer protection regulatory obligations. Compliance teams review retention offer terms against specific obligations to pre',
    `sla_breach_event_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_breach_event. Business justification: SLA breach events are a primary trigger for proactive retention offers in telecom. Linking the retention offer to the triggering breach event enables retention ROI analysis, regulatory remediation rep',
    `sla_contract_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_contract. Business justification: Telecom retention offers frequently include an SLA upgrade as the retention incentive (e.g., upgrading from standard to premium SLA). Retention teams must reference the specific SLA contract being off',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber at risk of churn who received this retention offer.',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to service.svc_instance. Business justification: A retention offer targets a specific service instance at risk of churn or cancellation. Linking retention_offer to the svc_instance it addresses is fundamental to churn management operations, enabling',
    `trouble_ticket_id` BIGINT COMMENT 'Foreign key linking to assurance.trouble_ticket. Business justification: Retention offers are frequently triggered by service quality issues. Linking offers to the trouble tickets that prompted them enables analysis of offer effectiveness by issue type, measurement of serv',
    `acceptance_outcome` STRING COMMENT 'Final outcome of the retention offer indicating whether the subscriber accepted, rejected, or did not respond.. Valid values are `accepted|rejected|no_response|deferred`',
    `applied_timestamp` TIMESTAMP COMMENT 'Date and time when the accepted retention offer was applied to the subscriber account and became effective.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether managerial or supervisory approval was required before presenting this retention offer to the subscriber.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the retention offer was approved by the authorized manager or supervisor.',
    `arpu_impact_amount` DECIMAL(18,2) COMMENT 'Estimated impact on Average Revenue Per User if the retention offer is accepted, expressed as a positive or negative monetary amount.',
    `cltv_impact_amount` DECIMAL(18,2) COMMENT 'Estimated impact on Customer Lifetime Value if the retention offer is accepted and the subscriber is retained.',
    `contract_extension_months` STRING COMMENT 'Number of months the subscriber contract will be extended if this retention offer is accepted.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this retention offer record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the offer value amount.. Valid values are `^[A-Z]{3}$`',
    `discount_duration_months` STRING COMMENT 'Number of months the discount or promotional pricing will remain in effect if the offer is accepted.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount offered as part of the retention offer, if applicable.',
    `eligibility_criteria` STRING COMMENT 'Business rules and criteria that qualified the subscriber to receive this retention offer.',
    `notes` STRING COMMENT 'Free-form notes or comments recorded by the agent or system regarding the retention offer presentation and subscriber interaction.',
    `offer_code` STRING COMMENT 'Business identifier code for the retention offer, used for tracking and reporting purposes.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `offer_cost_amount` DECIMAL(18,2) COMMENT 'Internal cost to the business of providing this retention offer, including discounts, credits, and subsidies.',
    `offer_name` STRING COMMENT 'Human-readable name of the retention offer presented to the subscriber.',
    `offer_priority` STRING COMMENT 'Priority ranking of this retention offer when multiple offers are available for the same subscriber, with lower numbers indicating higher priority.',
    `offer_status` STRING COMMENT 'Current lifecycle status of the retention offer in the save workflow. [ENUM-REF-CANDIDATE: pending|presented|accepted|rejected|expired|withdrawn|applied — 7 candidates stripped; promote to reference product]',
    `offer_type` STRING COMMENT 'Category of retention offer presented to the subscriber to prevent churn.. Valid values are `loyalty_discount|plan_upgrade|device_upgrade|contract_extension|service_credit|bonus_data`',
    `offer_valid_from_date` DATE COMMENT 'Date from which the retention offer becomes valid and can be accepted by the subscriber.',
    `offer_valid_until_date` DATE COMMENT 'Date until which the retention offer remains valid for subscriber acceptance.',
    `offer_value_amount` DECIMAL(18,2) COMMENT 'Monetary value of the retention offer presented to the subscriber.',
    `presented_timestamp` TIMESTAMP COMMENT 'Date and time when the retention offer was presented to the subscriber during the save interaction.',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the reason the subscriber rejected the retention offer, if applicable.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `rejection_reason_description` STRING COMMENT 'Detailed description of why the subscriber rejected the retention offer.',
    `response_timestamp` TIMESTAMP COMMENT 'Date and time when the subscriber responded to the retention offer with acceptance or rejection.',
    `terms_and_conditions` STRING COMMENT 'Full text of the terms and conditions associated with the retention offer that the subscriber must accept.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this retention offer record was last modified in the system.',
    CONSTRAINT pk_retention_offer PRIMARY KEY(`retention_offer_id`)
) COMMENT 'Targeted retention or save offer presented to a subscriber at risk of churn during a save interaction. Captures offer type (loyalty discount, plan upgrade, device upgrade, contract extension), offered value, eligibility criteria, offer validity window, acceptance/rejection outcome, and associated save interaction. Supports churn management and customer retention workflows distinct from new-sales promotions.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Primary key for campaign',
    `segment_id` BIGINT COMMENT 'Foreign key linking to enterprise.segment. Business justification: Enterprise marketing campaigns in telecom are targeted at specific enterprise segments (government, large enterprise, SMB). Campaign effectiveness reporting and audience targeting require linking camp',
    `parent_campaign_id` BIGINT COMMENT 'Self-referencing FK on campaign (parent_campaign_id)',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Telecom marketing campaigns (SMS, robocall, email) must reference their governing regulatory obligation (e.g., TCPA, CAN-SPAM). Compliance teams perform campaign compliance reviews against specific ob',
    `actual_response_rate` DECIMAL(18,2) COMMENT 'Measured percentage of target audience that responded.',
    `actual_spend` DECIMAL(18,2) COMMENT 'Total amount actually spent on the campaign to date.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved monetary budget allocated for the campaign.',
    `campaign_code` STRING COMMENT 'External business code used to reference the campaign in marketing systems.',
    `campaign_description` STRING COMMENT 'Free‑form narrative describing the campaign details and creative theme.',
    `campaign_name` STRING COMMENT 'Human‑readable name of the campaign.',
    `campaign_status` STRING COMMENT 'Current lifecycle state of the campaign.',
    `campaign_type` STRING COMMENT 'Category of marketing objective the campaign addresses.',
    `cost_per_acquisition` DECIMAL(18,2) COMMENT 'Average cost incurred to acquire a single customer through the campaign.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign record was first created in the system.',
    `end_date` DATE COMMENT 'Planned calendar date when the campaign is scheduled to finish.',
    `expected_response_rate` DECIMAL(18,2) COMMENT 'Projected percentage of target audience expected to respond.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign is automatically retired; null if indefinite.',
    `frequency_per_month` STRING COMMENT 'Number of times the campaign is executed each month.',
    `launch_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the campaign was launched.',
    `objective` STRING COMMENT 'Business goal the campaign is intended to achieve.',
    `priority` STRING COMMENT 'Priority level assigned to the campaign by marketing leadership.',
    `roi_percent` DECIMAL(18,2) COMMENT 'Calculated ROI percentage for the campaign (gross profit divided by spend).',
    `start_date` DATE COMMENT 'Planned calendar date when the campaign becomes active.',
    `target_audience` STRING COMMENT 'Description of the customer segment the campaign is aimed at.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the campaign record.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Master reference table for campaign. Referenced by campaign_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`campaign_channel_execution` (
    `campaign_channel_execution_id` BIGINT COMMENT 'Primary key for the campaign_channel_execution association',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the parent campaign being executed on this channel',
    `channel_id` BIGINT COMMENT 'Foreign key linking to the sales channel through which this campaign is being executed',
    `budget_allocation_amount` DECIMAL(18,2) COMMENT 'The portion of the campaigns total budget allocated specifically to this channels execution. Belongs to the execution record, not to the campaign (which holds total budget) nor the channel (which is channel-agnostic to campaign budgets).',
    `channel` STRING COMMENT 'Primary delivery channel used for the campaign. [Moved from campaign: The STRING channel field on campaign is a denormalized single-value text representation of what should be a proper relational many-to-many association. Once the campaign_channel_execution association table exists, this field becomes redundant and should be removed. The FK campaign_id on the association table replaces this relationship.]',
    `channel_cost_per_acquisition` DECIMAL(18,2) COMMENT 'The cost per acquisition measured specifically for this channels execution of the campaign. Distinct from the campaign-level cost_per_acquisition which is an aggregate figure.',
    `channel_response_rate` DECIMAL(18,2) COMMENT 'The measured response rate for this campaign as executed through this specific channel. Distinct from the campaign-level actual_response_rate which aggregates across all channels.',
    `end_date` DATE COMMENT 'The date this campaign deactivates on this specific channel. May differ from the campaign-level end_date, as individual channels may be wound down independently.',
    `execution_status` STRING COMMENT 'Current operational status of this campaigns execution on this channel (e.g., active, paused, completed, cancelled). Allows a campaign to be paused on one channel while remaining active on others.',
    `start_date` DATE COMMENT 'The date this campaign activates on this specific channel. May differ from the campaign-level start_date, as channels may be activated on a rolling basis.',
    CONSTRAINT pk_campaign_channel_execution PRIMARY KEY(`campaign_channel_execution_id`)
) COMMENT 'This association product represents the Execution relationship between campaign and channel. It captures the operational assignment of a marketing campaign to a specific sales channel, including channel-specific budget allocation, activation dates, and per-channel performance metrics. Each record links one campaign to one channel and carries attributes that exist only in the context of that specific channels execution of that campaign — data that belongs to neither the campaign master nor the channel master alone.. Existence Justification: In telecommunications marketing operations, campaigns are explicitly deployed across multiple sales channels (retail, telesales, digital, dealer/agent, enterprise direct), and each channel simultaneously carries multiple campaigns. Marketing operations teams actively manage which channels execute which campaigns, with separate budget allocations, response rate tracking, and cost-per-acquisition metrics per channel-campaign combination. This is a recognized operational business process — not an analytical correlation — where humans create, update, and deactivate channel-campaign execution records as part of campaign lifecycle management.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `telecommunication_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `telecommunication_ecm`.`sales`.`channel`(`channel_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `telecommunication_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `telecommunication_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `telecommunication_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `telecommunication_ecm`.`sales`.`promotion`(`promotion_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `telecommunication_ecm`.`sales`.`channel`(`channel_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_parent_line_quote_line_id` FOREIGN KEY (`parent_line_quote_line_id`) REFERENCES `telecommunication_ecm`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `telecommunication_ecm`.`sales`.`promotion`(`promotion_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `telecommunication_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `telecommunication_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `telecommunication_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ADD CONSTRAINT `fk_sales_channel_commission_plan_id` FOREIGN KEY (`commission_plan_id`) REFERENCES `telecommunication_ecm`.`sales`.`commission_plan`(`commission_plan_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ADD CONSTRAINT `fk_sales_channel_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `telecommunication_ecm`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ADD CONSTRAINT `fk_sales_commission_plan_superseded_by_plan_commission_plan_id` FOREIGN KEY (`superseded_by_plan_commission_plan_id`) REFERENCES `telecommunication_ecm`.`sales`.`commission_plan`(`commission_plan_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `telecommunication_ecm`.`sales`.`channel`(`channel_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_commission_plan_id` FOREIGN KEY (`commission_plan_id`) REFERENCES `telecommunication_ecm`.`sales`.`commission_plan`(`commission_plan_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ADD CONSTRAINT `fk_sales_promotion_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `telecommunication_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `telecommunication_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `telecommunication_ecm`.`sales`.`channel`(`channel_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_parent_campaign_id` FOREIGN KEY (`parent_campaign_id`) REFERENCES `telecommunication_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign_channel_execution` ADD CONSTRAINT `fk_sales_campaign_channel_execution_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `telecommunication_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign_channel_execution` ADD CONSTRAINT `fk_sales_campaign_channel_execution_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `telecommunication_ecm`.`sales`.`channel`(`channel_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `telecommunication_ecm`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Converted Opportunity Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Interest Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Referral Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `privacy_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `svc_location_id` SET TAGS ('dbx_business_glossary_term' = 'Svc Location Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `age_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Age in Days');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `assigned_sales_team` SET TAGS ('dbx_business_glossary_term' = 'Assigned Sales Team');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `company_name` SET TAGS ('dbx_business_glossary_term' = 'Company Name');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Reason');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `do_not_call` SET TAGS ('dbx_business_glossary_term' = 'Do Not Call Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `estimated_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Contract Value');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `estimated_monthly_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Monthly Value');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `first_contact_date` SET TAGS ('dbx_business_glossary_term' = 'First Contact Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `follow_up_sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Service Level Agreement (SLA) Hours');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `grade` SET TAGS ('dbx_business_glossary_term' = 'Lead Grade');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D|F');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `interest_product_category` SET TAGS ('dbx_business_glossary_term' = 'Interest Product Category');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `interest_service_type` SET TAGS ('dbx_business_glossary_term' = 'Interest Service Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `lead_number` SET TAGS ('dbx_business_glossary_term' = 'Lead Number');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `lead_number` SET TAGS ('dbx_value_regex' = '^LED-[0-9]{8}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `lead_source` SET TAGS ('dbx_business_glossary_term' = 'Lead Source');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `lead_status` SET TAGS ('dbx_business_glossary_term' = 'Lead Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `next_follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Next Follow-Up Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Email Marketing');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `opt_in_phone` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Phone Marketing');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `opt_in_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `opt_in_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `opt_in_sms` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Short Message Service (SMS) Marketing');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Lead Priority');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'hot|warm|cold');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'mql|sql|unqualified|pending');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `referral_code` SET TAGS ('dbx_business_glossary_term' = 'Referral Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `sales_territory` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Lead Score');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `source_detail` SET TAGS ('dbx_business_glossary_term' = 'Lead Source Detail');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `street_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Identifier');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `enterprise_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `mvno_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Mvno Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Team Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `slice_id` SET TAGS ('dbx_business_glossary_term' = 'Network Slice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `spectrum_license_id` SET TAGS ('dbx_business_glossary_term' = 'Spectrum License Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `transmission_link_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Link Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `actual_close_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Close Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `competitive_threat_level` SET TAGS ('dbx_business_glossary_term' = 'Competitive Threat Level');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `competitive_threat_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Name');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term in Months');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `credit_check_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `credit_check_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|declined|manual_review');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `credit_score` SET TAGS ('dbx_business_glossary_term' = 'Credit Score');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `credit_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `deposit_required_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Required Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `estimated_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Contract Value');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `estimated_mrr` SET TAGS ('dbx_business_glossary_term' = 'Estimated Monthly Recurring Revenue (MRR)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `estimated_one_time_revenue` SET TAGS ('dbx_business_glossary_term' = 'Estimated One-Time Revenue');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `expected_close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Close Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `forecast_category` SET TAGS ('dbx_business_glossary_term' = 'Forecast Category');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `forecast_category` SET TAGS ('dbx_value_regex' = 'pipeline|best_case|commit|closed');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `key_stakeholders` SET TAGS ('dbx_business_glossary_term' = 'Key Stakeholders');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `next_step` SET TAGS ('dbx_business_glossary_term' = 'Next Step');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `number_of_devices` SET TAGS ('dbx_business_glossary_term' = 'Number of Devices');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `number_of_lines` SET TAGS ('dbx_business_glossary_term' = 'Number of Lines or Connections');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Name');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Number');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_value_regex' = '^OPP-[0-9]{8}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_type` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_type` SET TAGS ('dbx_value_regex' = 'new_customer|upsell|cross_sell|renewal|winback|migration');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `primary_product_offering` SET TAGS ('dbx_business_glossary_term' = 'Primary Product Offering');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `probability_percent` SET TAGS ('dbx_business_glossary_term' = 'Win Probability Percentage');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `proposed_service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Service Start Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `sales_stage` SET TAGS ('dbx_business_glossary_term' = 'Sales Stage');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `strategic_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Strategic Account Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `whitespace_analysis` SET TAGS ('dbx_business_glossary_term' = 'Whitespace Analysis');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `win_loss_reason` SET TAGS ('dbx_business_glossary_term' = 'Win or Loss Reason');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Identifier');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `dealer_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Accepted Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Approved Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|one_time');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Name');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term in Months');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Created Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'b2c_retail|b2b_sme|b2b_enterprise|mvno_wholesale|government');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `is_primary_version` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Version Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `modified_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Modified Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `monthly_recurring_revenue` SET TAGS ('dbx_business_glossary_term' = 'Monthly Recurring Revenue (MRR)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Quote Notes');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `one_time_charges` SET TAGS ('dbx_business_glossary_term' = 'One-Time Charges');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_60|net_90|prepaid|postpaid|due_on_receipt');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `presented_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Presented Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `quote_description` SET TAGS ('dbx_business_glossary_term' = 'Quote Description');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `quote_name` SET TAGS ('dbx_business_glossary_term' = 'Quote Name');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_business_glossary_term' = 'Quote Number');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_value_regex' = '^QT-[0-9]{8}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `quote_type` SET TAGS ('dbx_business_glossary_term' = 'Quote Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `quote_type` SET TAGS ('dbx_value_regex' = 'new_service|upgrade|renewal|modification|disconnect');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `rejected_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Rejected Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Quote Rejection Reason');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `service_activation_date` SET TAGS ('dbx_business_glossary_term' = 'Service Activation Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Quote Source System');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value (TCV)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `total_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `total_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Percentage');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Valid From Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `valid_until_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Valid Until Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Quote Version Number');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `win_probability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Win Probability Percentage');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Address Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Model Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Cable Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Address Pool Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `parent_line_quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Line Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `qos_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Network Qos Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `commission_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `configuration_details` SET TAGS ('dbx_business_glossary_term' = 'Configuration Details');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term (Months)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `dealer_code` SET TAGS ('dbx_business_glossary_term' = 'Dealer Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `extended_amount` SET TAGS ('dbx_business_glossary_term' = 'Extended Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'draft|active|approved|rejected|cancelled|expired');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'List Price');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Signatory Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `enterprise_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Segment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Cable Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Address Pool Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `slice_id` SET TAGS ('dbx_business_glossary_term' = 'Slice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `spectrum_license_id` SET TAGS ('dbx_business_glossary_term' = 'Spectrum License Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `transmission_link_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Link Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|one_time');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'B2C|B2B|MVNO|wholesale|enterprise|retail');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `cpni_authorization_included` SET TAGS ('dbx_business_glossary_term' = 'Customer Proprietary Network Information (CPNI) Authorization Included');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `e911_compliance_clause` SET TAGS ('dbx_business_glossary_term' = 'Enhanced 911 (E911) Compliance Clause');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `etf_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Fee (ETF) Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `etf_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Fee (ETF) Schedule Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `etf_schedule_type` SET TAGS ('dbx_value_regex' = 'none|flat|declining|prorated');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `mrr_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Recurring Revenue (MRR) Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_60|net_90|due_on_receipt|prepaid|postpaid');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `price_escalation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Percentage');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `price_lock_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Lock Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term (Months)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `tcv_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value (TCV) Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term (Months)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `uptime_sla_percentage` SET TAGS ('dbx_business_glossary_term' = 'Uptime Service Level Agreement (SLA) Percentage');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` SET TAGS ('dbx_subdomain' = 'channel_operations');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Identifier');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `commission_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Segment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `revenue_share_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Team Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `accepts_walk_in` SET TAGS ('dbx_business_glossary_term' = 'Accepts Walk-In Customers Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `capacity` SET TAGS ('dbx_business_glossary_term' = 'Channel Capacity');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `channel_description` SET TAGS ('dbx_business_glossary_term' = 'Channel Description');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_business_glossary_term' = 'Channel Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_activation');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'retail_store|telesales|online_digital|dealer_agent|enterprise_direct|partner_reseller');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `crm_system_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) System Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `digital_platform_url` SET TAGS ('dbx_business_glossary_term' = 'Digital Platform Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `is_primary_channel` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Channel Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `language_supported` SET TAGS ('dbx_business_glossary_term' = 'Languages Supported');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `lead_assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Lead Assignment Priority');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `next_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Performance Review Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `physical_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Physical Address Line 1');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `physical_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `physical_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `physical_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Physical Address Line 2');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `physical_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `physical_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `region_name` SET TAGS ('dbx_business_glossary_term' = 'Region Name');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `supports_business_accounts` SET TAGS ('dbx_business_glossary_term' = 'Supports Business Accounts Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `supports_mnp` SET TAGS ('dbx_business_glossary_term' = 'Supports Mobile Number Portability (MNP) Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,15}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'geographic|vertical|named_account|hybrid');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` SET TAGS ('dbx_subdomain' = 'channel_operations');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `commission_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Segment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `superseded_by_plan_commission_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Commission Plan Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `accelerator_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Accelerator Multiplier');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `accelerator_threshold` SET TAGS ('dbx_business_glossary_term' = 'Accelerator Threshold');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `base_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Commission Rate');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `business_unit` SET TAGS ('dbx_value_regex' = 'consumer|enterprise|wholesale|mvno');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `clawback_percentage` SET TAGS ('dbx_business_glossary_term' = 'Clawback Percentage');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `clawback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Clawback Period (Days)');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `commission_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Unit');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `commission_rate_unit` SET TAGS ('dbx_value_regex' = 'percentage_of_revenue|percentage_of_mrr|flat_amount_per_unit|percentage_of_arpu');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `default_split_percentage` SET TAGS ('dbx_business_glossary_term' = 'Default Split Percentage');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `eligible_product_categories` SET TAGS ('dbx_business_glossary_term' = 'Eligible Product Categories');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `mdf_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Market Development Fund (MDF) Allocation Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `participant_type` SET TAGS ('dbx_business_glossary_term' = 'Participant Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `participant_type` SET TAGS ('dbx_value_regex' = 'internal_sales_rep|dealer|agent|mvno_partner|channel_partner');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `payment_delay_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Delay (Days)');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|per_transaction');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Description');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Name');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'flat_rate|tiered|residual|spiff|mdf|accelerator');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `quota_measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Quota Measurement Unit');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `quota_measurement_unit` SET TAGS ('dbx_value_regex' = 'revenue|unit_count|subscriber_count|mrr');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `quota_target` SET TAGS ('dbx_business_glossary_term' = 'Quota Target');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `residual_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Residual Duration (Months)');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `residual_rate` SET TAGS ('dbx_business_glossary_term' = 'Residual Commission Rate');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `spiff_amount` SET TAGS ('dbx_business_glossary_term' = 'Sales Performance Incentive Fund (SPIFF) Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `split_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Split Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `tier_1_rate` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Commission Rate');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `tier_1_threshold` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Threshold');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `tier_2_rate` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Commission Rate');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `tier_2_threshold` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Threshold');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `tier_3_rate` SET TAGS ('dbx_business_glossary_term' = 'Tier 3 Commission Rate');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `tier_3_threshold` SET TAGS ('dbx_business_glossary_term' = 'Tier 3 Threshold');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` SET TAGS ('dbx_subdomain' = 'channel_operations');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Target Identifier');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `commission_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Incentive Plan ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `dealer_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Segment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Team ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `attainment_last_calculated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Attainment Last Calculated Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `attainment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Attainment Percentage');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `attainment_value` SET TAGS ('dbx_business_glossary_term' = 'Attainment Value');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Target Currency Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `incentive_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentive Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|custom');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `product_category_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Category Scope');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `segment_scope` SET TAGS ('dbx_business_glossary_term' = 'Segment Scope');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `segment_scope` SET TAGS ('dbx_value_regex' = 'b2c|b2b|mvno|all');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `target_code` SET TAGS ('dbx_business_glossary_term' = 'Target Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `target_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `target_name` SET TAGS ('dbx_business_glossary_term' = 'Target Name');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `target_status` SET TAGS ('dbx_business_glossary_term' = 'Target Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `target_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|completed|cancelled');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `target_type` SET TAGS ('dbx_business_glossary_term' = 'Target Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `target_type` SET TAGS ('dbx_value_regex' = 'revenue|activations|arpu|churn_saves|upsell|cross_sell');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `threshold_accelerator` SET TAGS ('dbx_business_glossary_term' = 'Threshold Accelerator');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `threshold_minimum` SET TAGS ('dbx_business_glossary_term' = 'Threshold Minimum');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `weight_factor` SET TAGS ('dbx_business_glossary_term' = 'Weight Factor');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` SET TAGS ('dbx_subdomain' = 'customer_retention');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Segment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Target Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `auto_apply_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Apply Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `budget_consumed` SET TAGS ('dbx_business_glossary_term' = 'Budget Consumed');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `budget_consumed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `discount_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Discount Currency Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `discount_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|free_unit');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `eligible_product_category` SET TAGS ('dbx_business_glossary_term' = 'Eligible Product Category');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `exclusion_list` SET TAGS ('dbx_business_glossary_term' = 'Exclusion List');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `external_promotion_reference` SET TAGS ('dbx_business_glossary_term' = 'External Promotion Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `geographic_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Geographic Eligibility');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `minimum_contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Minimum Contract Term (Months)');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `minimum_purchase_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Currency Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `minimum_purchase_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `promotion_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `promotion_description` SET TAGS ('dbx_business_glossary_term' = 'Promotion Description');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `promotion_name` SET TAGS ('dbx_business_glossary_term' = 'Promotion Name');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `promotion_status` SET TAGS ('dbx_business_glossary_term' = 'Promotion Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `promotion_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `promotion_type` SET TAGS ('dbx_business_glossary_term' = 'Promotion Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `promotion_type` SET TAGS ('dbx_value_regex' = 'device_subsidy|free_months|bundle_discount|port_in_bonus|byod_credit|volume_discount');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Redemption Count');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `redemption_limit_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Per-Customer Redemption Limit');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `redemption_limit_total` SET TAGS ('dbx_business_glossary_term' = 'Total Redemption Limit');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|netcracker_catalog|manual_entry|marketing_automation');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `stacking_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Stacking Allowed Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `stacking_rule` SET TAGS ('dbx_business_glossary_term' = 'Stacking Rule');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Start Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` SET TAGS ('dbx_subdomain' = 'customer_retention');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `retention_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Offer Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `enterprise_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `outage_record_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `privacy_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Proposed Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Proposed Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `sla_breach_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Breach Event Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Svc Instance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `trouble_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Trouble Ticket Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `acceptance_outcome` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Outcome');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `acceptance_outcome` SET TAGS ('dbx_value_regex' = 'accepted|rejected|no_response|deferred');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `applied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Offer Applied Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `arpu_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Average Revenue Per User (ARPU) Impact Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `cltv_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Impact Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `contract_extension_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Extension Duration in Months');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `discount_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Discount Duration in Months');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Offer Notes');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `offer_code` SET TAGS ('dbx_business_glossary_term' = 'Retention Offer Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `offer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `offer_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Offer Cost Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `offer_name` SET TAGS ('dbx_business_glossary_term' = 'Retention Offer Name');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `offer_priority` SET TAGS ('dbx_business_glossary_term' = 'Offer Priority');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Retention Offer Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `offer_type` SET TAGS ('dbx_business_glossary_term' = 'Retention Offer Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `offer_type` SET TAGS ('dbx_value_regex' = 'loyalty_discount|plan_upgrade|device_upgrade|contract_extension|service_credit|bonus_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `offer_valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Valid From Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `offer_valid_until_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Valid Until Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `offer_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Offer Value Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `presented_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Offer Presented Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Offer Response Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign` SET TAGS ('dbx_subdomain' = 'customer_retention');
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Segment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign` ALTER COLUMN `parent_campaign_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign_channel_execution` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign_channel_execution` SET TAGS ('dbx_subdomain' = 'customer_retention');
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign_channel_execution` SET TAGS ('dbx_association_edges' = 'sales.campaign,sales.channel');
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign_channel_execution` ALTER COLUMN `campaign_channel_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Channel Execution - Campaign Channel Execution Id');
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign_channel_execution` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Channel Execution - Campaign Id');
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign_channel_execution` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Channel Execution - Channel Id');
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign_channel_execution` ALTER COLUMN `budget_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Channel Budget Allocation');
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign_channel_execution` ALTER COLUMN `channel_cost_per_acquisition` SET TAGS ('dbx_business_glossary_term' = 'Channel Cost Per Acquisition');
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign_channel_execution` ALTER COLUMN `channel_response_rate` SET TAGS ('dbx_business_glossary_term' = 'Channel Response Rate');
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign_channel_execution` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Channel Deactivation Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign_channel_execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign_channel_execution` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Channel Activation Date');
