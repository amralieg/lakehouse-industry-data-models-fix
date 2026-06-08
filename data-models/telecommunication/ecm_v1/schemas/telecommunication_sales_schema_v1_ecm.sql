-- Schema for Domain: sales | Business: Telecommunication | Version: v1_ecm
-- Generated on: 2026-05-08 05:07:50

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`sales` COMMENT 'SSOT for commercial sales activities — leads, opportunities, quotes, contracts, channel performance, and dealer/agent management. Supports B2C retail, B2B enterprise, and MVNO wholesale sales pipelines managed via Salesforce CRM opportunity and contract modules.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`lead` (
    `lead_id` BIGINT COMMENT 'Unique identifier for the lead record. Primary key for the lead entity representing a prospective customer or sales inquiry in the early pipeline stage.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign that generated this lead. Used for campaign attribution and ROI analysis.',
    `opportunity_id` BIGINT COMMENT 'Identifier of the opportunity record created upon lead conversion. Null if not yet converted.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the account record created upon lead conversion. Null if not yet converted.',
    `employee_id` BIGINT COMMENT 'Identifier of the sales representative or agent assigned to follow up on this lead. Used for workload distribution and SLA tracking.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Leads capture prospect interest in specific products/services. Sales qualification and conversion tracking require knowing which catalog items prospects are interested in. Essential for lead-to-revenu',
    `partner_id` BIGINT COMMENT 'Identifier of the partner, dealer, or agent who referred this lead. Used for partner commission tracking and channel performance analysis.',
    `privacy_consent_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_consent. Business justification: Lead follow-up requires documented consent for contact under TCPA. Telecom sales must verify opt-in status before outreach (calls, texts, emails). Links lead contact activities to consent records, ena',
    `segment_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.segment_definition. Business justification: Leads are segmented by propensity, value tier, and channel affinity for routing, prioritization, and conversion optimization. Telecom lead management systems assign leads to segments for targeted nurt',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Leads are routed to sales teams by service territory for coverage qualification, pricing model application, and territory quota tracking. Essential for lead assignment workflow and sales capacity plan',
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
    `b2b_account_plan_id` BIGINT COMMENT 'Foreign key linking to sales.b2b_account_plan. Business justification: B2B opportunities often originate from strategic account plans that identify whitespace, upsell, and cross-sell opportunities. This FK links opportunities to their source account plan, enabling tracki',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that generated or influenced this opportunity. Used for campaign ROI analysis and attribution.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: B2B sales opportunities in telecommunications target enterprise corporate accounts for managed services, fiber, SD-WAN, and IoT deployments. Essential for enterprise pipeline reporting, account-based ',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: Sales opportunities for device upgrades, replacements, or trade-ins must reference the customers existing CPE asset to determine upgrade eligibility, trade-in value, and compatibility with proposed n',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this opportunity. Links to the customer domain for prospect or existing subscriber information.',
    `customer_address_id` BIGINT COMMENT 'Reference to the service installation address for fixed services (fiber, broadband, enterprise connectivity). Null for mobile-only opportunities. Links to address entity in customer domain.',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: B2B sales opportunities track primary contact stakeholders for decision-making authority, meeting coordination, and proposal delivery. Essential for sales process management and CRM workflows in enter',
    `employee_id` BIGINT COMMENT 'Reference to the sales representative or account executive who owns and is responsible for progressing this opportunity. Links to workforce domain.',
    `enterprise_site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Enterprise opportunities for fiber, managed services, or SD-WAN target specific customer sites. Site linkage critical for site survey scheduling, service feasibility assessment, installation cost esti',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the order created upon closed-won handoff to fulfillment. Null until opportunity reaches closed-won state and order is generated. Links to order domain.',
    `network_capacity_plan_id` BIGINT COMMENT 'Foreign key linking to network.capacity_plan. Business justification: Network capacity planning directly drives enterprise sales opportunities for bandwidth upgrades, fiber expansion, and network augmentation services. Sales teams reference capacity plans when proposing',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.content_package. Business justification: Sales opportunities in telecommunications routinely propose content packages (IPTV bundles, OTT subscriptions) as part of service offerings. Required for opportunity qualification, quote generation, a',
    `partner_id` BIGINT COMMENT 'Reference to the dealer, agent, or channel partner involved in this opportunity. Null for direct sales. Links to partner domain for commission and performance tracking.',
    `pop_facility_id` BIGINT COMMENT 'Foreign key linking to inventory.pop_facility. Business justification: Enterprise and wholesale opportunities for colocation, interconnection, or dedicated access services reference the specific POP facility where service will be delivered. Critical for feasibility asses',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Opportunities represent potential sales of specific products. Linking to catalog_item enables product mix analysis, win/loss reporting by SKU, revenue forecasting by product, and sales pipeline visibi',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Opportunities propose specific market offerings (bundled plans, enterprise solutions). This link supports opportunity-to-offering pipeline reporting, conversion rate analysis by offering type, and sal',
    `ran_cell_id` BIGINT COMMENT 'Foreign key linking to network.ran_cell. Business justification: Enterprise sales opportunities for private 5G networks, campus coverage, and venue-specific deployments require linking to specific RAN cell sites for technical feasibility validation, coverage analys',
    `team_id` BIGINT COMMENT 'Reference to the sales team or business unit responsible for this opportunity. Used for team-based quota tracking and performance management.',
    `sdwan_policy_id` BIGINT COMMENT 'Foreign key linking to network.sdwan_policy. Business justification: SD-WAN policies are sold as managed service offerings to enterprise customers. Sales opportunities for SD-WAN solutions must reference the policy configurations being proposed to demonstrate technical',
    `segment_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.segment_definition. Business justification: Telecom sales opportunities are segmented (enterprise, SMB, government, high-value) for pipeline analysis, forecasting, and resource allocation. Segment classification drives sales strategy and quota ',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Opportunities require service territory for network availability assessment, regulatory jurisdiction determination, and sales forecasting by geography. Distinct from service_address_id; territory driv',
    `slice_id` BIGINT COMMENT 'Foreign key linking to network.network_slice. Business justification: 5G network slicing is sold as a distinct product offering to enterprise customers requiring dedicated virtual networks with specific SLA guarantees. Sales opportunities for slice-based services must r',
    `subscriber_id` BIGINT COMMENT 'Reference to the existing subscriber if this opportunity represents an upsell, cross-sell, or service expansion for a current customer. Null for new customer acquisition opportunities.',
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
    `lead_id` BIGINT COMMENT 'Reference to the originating lead record that was qualified and converted into this opportunity. Null for opportunities created directly without a lead stage.',
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
    `quote_id` BIGINT COMMENT 'Reference to the formal price quote or proposal document associated with this opportunity. Links to quote entity in sales domain.',
    `sales_channel` STRING COMMENT 'Channel through which the opportunity is being pursued: retail store, telesales center, digital web, mobile app, authorized dealer, independent agent, partner, or direct enterprise sales team. [ENUM-REF-CANDIDATE: retail_store|telesales|digital_web|digital_mobile_app|dealer|agent|partner|direct_sales — 8 candidates stripped; promote to reference product]',
    `sales_stage` STRING COMMENT 'Current stage of the opportunity in the sales pipeline lifecycle. Tracks progression from initial prospecting through qualification, proposal, negotiation, and terminal closed-won or closed-lost states. [ENUM-REF-CANDIDATE: prospecting|qualification|needs_analysis|proposal|negotiation|closed_won|closed_lost — 7 candidates stripped; promote to reference product]',
    `strategic_account_flag` BOOLEAN COMMENT 'Indicates whether this opportunity is for a strategic or key account requiring executive sponsorship and special handling. True for enterprise strategic accounts.',
    `technology_type` STRING COMMENT 'Underlying network technology for the proposed service: 5G, LTE, 3G, fiber to the home, fiber to the building, cable, DSL, fixed wireless, satellite, SD-WAN, or MPLS. [ENUM-REF-CANDIDATE: 5g|lte|3g|fiber_ftth|fiber_fttb|cable|dsl|fixed_wireless|satellite|sd_wan|mpls — 11 candidates stripped; promote to reference product]',
    `whitespace_analysis` STRING COMMENT 'For B2B enterprise opportunities, describes untapped revenue potential and expansion opportunities within the account (additional locations, services, or business units not yet penetrated).',
    `win_loss_reason` STRING COMMENT 'Primary reason for winning or losing the opportunity. Captured at close for sales effectiveness analysis and process improvement. Examples: price, coverage, features, competitor, timing, budget.',
    CONSTRAINT pk_opportunity PRIMARY KEY(`opportunity_id`)
) COMMENT 'Core sales opportunity record representing a qualified sales pursuit for a prospect or existing subscriber, serving as the central pipeline entity from qualification through closed-won handoff to order fulfillment. Tracks opportunity stage, estimated contract value, close date, sales channel (retail/telesales/digital/dealer), segment (B2C/B2B/MVNO wholesale), win/loss reason, associated product offerings, and fulfillment handoff details. For enterprise/B2B accounts, includes strategic account planning attributes: growth objectives, whitespace analysis, key stakeholder map, planned upsell/cross-sell initiatives, competitive threats, and target MRR growth. Terminal closed-won state triggers order creation in the order domain. Sourced from Salesforce CRM Opportunity Management module.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`quote` (
    `quote_id` BIGINT COMMENT 'Primary key for quote',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Quotes require billing account reference for credit limit checks, payment terms validation, billing address verification, account hierarchy in B2B scenarios, and consolidated billing eligibility asses',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise quotes require corporate account linkage for contract pricing validation, enterprise discount scheme application, approval workflow routing, and consolidated billing setup. Critical for B2B',
    `created_by_user_employee_id` BIGINT COMMENT 'Reference to the sales representative or user who created the quote.',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Quotes must identify the authorized contact for presentation, approval, and signature. Required for contract formation, legal compliance, and tracking quote acceptance workflow in telecommunications s',
    `dealer_id` BIGINT COMMENT 'Reference to the dealer or agent who generated the quote, if applicable. Used for commission calculation and channel performance tracking.',
    `employee_id` BIGINT COMMENT 'Reference to the manager or approver who authorized the quote, if approval was required.',
    `enterprise_site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Enterprise service quotes require site-specific details for accurate pricing of installation, CPE deployment, circuit provisioning, and site-based SLA tiers. Essential for multi-site quote generation ',
    `modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified the quote.',
    `opportunity_id` BIGINT COMMENT 'Reference to the sales opportunity that generated this quote. Links to the Salesforce CRM opportunity record.',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to sales.promotion. Business justification: Quotes currently have promotional_code (STRING) to capture promotion references. This should be normalized to a FK relationship to the promotion master table for referential integrity, promotion rule ',
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
    `sales_channel` STRING COMMENT 'Channel through which the quote was generated: direct sales team, retail store, online self-service, telesales, dealer, agent, or partner. [ENUM-REF-CANDIDATE: direct_sales|retail_store|online|telesales|dealer|agent|partner — 7 candidates stripped; promote to reference product]',
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
    `bundle_id` BIGINT COMMENT 'Reference to a product bundle if this line is part of a multi-service package. Enables bundle pricing logic and cross-service dependencies.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Quote lines itemize specific catalog products being quoted. Essential for quote-to-order accuracy, product revenue attribution, and ensuring quoted items match orderable catalog. Removes denormalized ',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: Quote lines for equipment upgrades or replacements reference the specific asset being replaced to calculate trade-in credit, validate compatibility, and determine installation requirements. Standard q',
    `customer_address_id` BIGINT COMMENT 'Reference to the service delivery address for this line item. Critical for Fiber to the Home (FTTH), fixed broadband, and enterprise connectivity services.',
    `device_offering_id` BIGINT COMMENT 'Foreign key linking to product.device_offering. Business justification: When quoting device sales (phones, routers, modems), quote lines must reference the specific device offering with its subsidy/installment terms. Essential for device revenue tracking, inventory manage',
    `fiber_cable_id` BIGINT COMMENT 'Foreign key linking to inventory.fiber_cable. Business justification: Wholesale fiber lease quote lines reference specific cable segments being leased to enterprise or carrier customers. Required for dark fiber and IRU sales, capacity validation, and route planning.',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: Enterprise and wholesale quotes for dedicated network services, colocation, or managed infrastructure reference specific network equipment to be provisioned, upgraded, or allocated to the customer. St',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: Fiber service quote lines reference existing ONT assets when quoting upgrades, replacements, or bandwidth increases to determine if new equipment is required and calculate installation costs.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to content.ott_platform. Business justification: Telecommunications providers bundle third-party OTT platforms (Netflix, Disney+, HBO Max) as standalone quote line items. Required for OTT partner billing reconciliation, provisioning workflows, and r',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.content_package. Business justification: Quote lines itemize content packages sold to customers (e.g., Premium Sports Package, Family Entertainment Bundle). Essential for quote generation, pricing calculations, order fulfillment, and revenue',
    `parent_line_quote_line_id` BIGINT COMMENT 'Reference to another quote line if this line is a dependent or child item. Supports hierarchical quote structures for complex telecom solutions.',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Quote lines must reference the specific price plan being offered to ensure billing system alignment, contract accuracy, and correct revenue recognition. Critical for quote-to-cash process integrity an',
    `employee_id` BIGINT COMMENT 'Reference to the sales representative responsible for this quote line. Used for quota tracking and commission attribution.',
    `quote_id` BIGINT COMMENT 'Reference to the parent commercial quote containing this line item. Links this line to the overall quote header.',
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
    `promotional_code` STRING COMMENT 'Marketing promotion or campaign code applied to this line item. Enables tracking of promotional effectiveness and discount attribution.',
    `promotional_description` STRING COMMENT 'Human-readable description of the promotional offer applied to this line. Displayed on customer-facing quote documents.',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units or subscriptions being quoted for this line item. May represent device count, user licenses, circuit count, or service instances depending on product type.',
    `sales_channel` STRING COMMENT 'Distribution channel through which this quote line was originated. Enables channel performance analysis and commission calculation. [ENUM-REF-CANDIDATE: direct|retail|online|telesales|partner|dealer|agent|enterprise|wholesale — 9 candidates stripped; promote to reference product]',
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
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Sales contracts for enterprise customers must link to corporate accounts for master agreement tracking, multi-site contract management, enterprise SLA enforcement, renewal pipeline management, and con',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that is the counterparty to this contract.',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Contracts require tracking the specific authorized signatory contact for legal enforceability, audit trails, and regulatory compliance (e.g., CPNI authorization). Role-prefixed to distinguish from gen',
    `enterprise_contract_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_contract. Business justification: Sales contracts for enterprise services must reference master commercial contracts for pricing schedule inheritance, discount scheme application, SLA tier enforcement, and amendment tracking. Critical',
    `fiber_cable_id` BIGINT COMMENT 'Foreign key linking to inventory.fiber_cable. Business justification: Dark fiber lease and IRU contracts reference the specific cable infrastructure being leased long-term to enterprise or carrier customers. Essential for wholesale fiber business, asset tracking, and co',
    `spectrum_allocation_id` BIGINT COMMENT 'Foreign key linking to inventory.spectrum_allocation. Business justification: Spectrum lease or wholesale contracts must reference the specific licensed spectrum allocation being provided to enterprise customers, MVNOs, or other carriers. Required for regulatory compliance and ',
    `opportunity_id` BIGINT COMMENT 'Reference to the sales opportunity in Salesforce CRM that led to this contract. Nullable for contracts not originated from opportunity pipeline.',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.content_package. Business justification: B2B telecommunications contracts routinely include content packages as part of enterprise service agreements (e.g., hospitality IPTV, corporate OTT licenses). Required for contract fulfillment, billin',
    `partner_id` BIGINT COMMENT 'Reference to the partner, dealer, or agent organization if the contract was sold through an indirect channel. Null for direct sales.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Contracts formalize the sale of specific offerings. This link is essential for contract compliance monitoring, renewal management, product lifecycle tracking, and ensuring contracted services match pr',
    `employee_id` BIGINT COMMENT 'Reference to the sales representative or account executive responsible for this contract.',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: Sales contracts are executed based on accepted quotes. This is a standard sales pipeline progression: lead → opportunity → quote → contract. The contract formalizes the commercial terms negotiated in ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Telecom service contracts must reference specific regulatory obligations (CPNI protection, E911 service delivery, lawful intercept cooperation). Contract templates include compliance clauses tied to r',
    `segment_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.segment_definition. Business justification: Contracts are classified into segments (strategic accounts, mid-market, SMB) for revenue analytics, retention strategy, and renewal forecasting. Segment-based contract analysis is fundamental to telec',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Contracts track service territory for regulatory jurisdiction, SLA enforcement, network capacity planning, and franchise agreement compliance. Essential for telecommunications contract administration,',
    `sla_contract_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_contract. Business justification: Commercial sales contracts reference technical SLA agreements that define performance commitments. The sales contract governs commercial terms (pricing, term, payment) while the SLA contract defines t',
    `sla_template_id` BIGINT COMMENT 'Foreign key linking to product.sla_template. Business justification: Enterprise contracts reference specific SLA templates defining service commitments (uptime, MTTR, latency). Required for SLA compliance monitoring, penalty calculation, and service level reporting—man',
    `contract_template_id` BIGINT COMMENT 'Reference to the standard contract template used as the basis for this agreement. Null for fully custom contracts.',
    `tertiary_sales_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this contract record.',
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
    `sla_tier` STRING COMMENT 'Service Level Agreement (SLA) tier defining the quality of service commitments, response times, uptime guarantees, and support levels.. Valid values are `standard|premium|enterprise|platinum|gold|silver`',
    `tcv_amount` DECIMAL(18,2) COMMENT 'Total Contract Value (TCV) representing the aggregate revenue expected over the full contract term, including all recurring and one-time charges.',
    `term_months` STRING COMMENT 'Duration of the contract commitment period expressed in months (e.g., 12, 24, 36). Null for month-to-month or evergreen contracts.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate or non-renew the contract. Null if no notice period specified.',
    `uptime_sla_percentage` DECIMAL(18,2) COMMENT 'Contractually committed network uptime percentage (e.g., 99.9%, 99.99%) as part of the SLA. Null if no specific uptime commitment exists.',
    CONSTRAINT pk_sales_contract PRIMARY KEY(`sales_contract_id`)
) COMMENT 'Executed commercial contract between Telecommunication and a customer (B2C, B2B enterprise, or MVNO wholesale) formalizing agreed services, pricing, SLA commitments, contract duration, auto-renewal terms, early termination fee (ETF) schedule, and regulatory compliance clauses. Includes full amendment lifecycle tracking: amendment type (price change, scope change, term extension, service addition/removal), effective dates, approval chain, reason codes, MRR/TCV delta values, and amendment status from request through execution. Distinct from the service agreement in the service domain — this is the commercial/legal sales instrument managed in Salesforce CRM contract module.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`contract_amendment` (
    `contract_amendment_id` BIGINT COMMENT 'Unique identifier for the contract amendment record. Primary key.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Contract amendments changing MRR/TCV (mrr_delta_amount, tcv_delta_amount) require revenue recognition adjustments posted to GL. ASC 606 compliance requires proper accounting for contract modifications',
    `employee_id` BIGINT COMMENT 'Reference to the sales representative, account manager, or system user who initiated the amendment request in Salesforce CRM.',
    `sales_contract_id` BIGINT COMMENT 'Reference to the parent sales contract being amended. Links this amendment to the original contract record managed in Salesforce CRM contract module.',
    `superseded_by_amendment_contract_amendment_id` BIGINT COMMENT 'Reference to a subsequent amendment that supersedes or replaces this amendment. Used to track amendment version chains and ensure only the latest amendment is active.',
    `amended_end_date` DATE COMMENT 'The new contract expiration date after this amendment is applied. Nullable if the amendment does not affect contract end date.',
    `amended_term_months` STRING COMMENT 'The new contract term length in months after this amendment is applied. Nullable if the amendment does not affect contract term.',
    `amendment_document_url` STRING COMMENT 'Reference URL or file path to the signed amendment document stored in the document management system. Enables retrieval of the legal contract artifact.',
    `amendment_number` STRING COMMENT 'Business-facing unique identifier for this amendment, typically formatted as contract number plus amendment sequence (e.g., CNT-2024-001-A01). Used for external communication and legal reference.',
    `amendment_status` STRING COMMENT 'Current lifecycle state of the amendment. Tracks progression from initial draft through approval chain to final execution or cancellation. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|rejected|executed|cancelled|superseded — 7 candidates stripped; promote to reference product]',
    `amendment_type` STRING COMMENT 'Classification of the amendment based on the nature of the change being made to the contract. Determines approval workflow and impact analysis requirements. [ENUM-REF-CANDIDATE: price_change|scope_change|term_extension|service_addition|service_removal|volume_adjustment|sla_modification|billing_change|other — 9 candidates stripped; promote to reference product]',
    `approval_date` DATE COMMENT 'Date when the amendment received final approval from all required parties. Nullable until approval is granted.',
    `approval_level` STRING COMMENT 'Organizational level required for approval based on amendment impact thresholds. Determined by revenue impact, term changes, or policy rules.. Valid values are `sales_manager|director|vp_sales|cfo|ceo|board`',
    `company_signatory_name` STRING COMMENT 'Full name of the telecommunications company representative who signed the amendment on behalf of the organization.',
    `company_signatory_title` STRING COMMENT 'Job title or role of the company representative who signed the amendment. Validates internal signing authority.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this amendment record was first created in the system. Audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this amendment (e.g., USD, EUR, GBP). Must match the parent contract currency.. Valid values are `^[A-Z]{3}$`',
    `customer_signatory_name` STRING COMMENT 'Full name of the customer representative who signed the amendment. Required for legal enforceability and audit trail.',
    `customer_signatory_title` STRING COMMENT 'Job title or role of the customer representative who signed the amendment. Validates signing authority.',
    `customer_signature_date` DATE COMMENT 'Date when the customer signed the amendment. Nullable until customer signature is obtained.',
    `customer_signature_required` BOOLEAN COMMENT 'Indicates whether customer signature is required for this amendment to be legally binding. Depends on amendment materiality and contract terms.',
    `effective_date` DATE COMMENT 'Date when the amendment terms become legally binding and operationally active. May be retroactive, current, or future-dated based on business agreement.',
    `execution_date` DATE COMMENT 'Date when the amendment was formally executed and signed by authorized parties. Represents legal completion of the amendment process.',
    `legal_review_completed` BOOLEAN COMMENT 'Indicates whether required legal review has been completed and approved. Gates the amendment from moving to execution status.',
    `legal_review_required` BOOLEAN COMMENT 'Indicates whether this amendment requires formal legal department review before execution. Typically true for material changes, liability modifications, or regulatory-sensitive amendments.',
    `mrr_delta_amount` DECIMAL(18,2) COMMENT 'Net change in Monthly Recurring Revenue resulting from this amendment. Positive values indicate revenue increase, negative indicate decrease. Critical metric for sales performance and revenue forecasting.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or internal comments about the amendment. Used by sales operations and account management teams.',
    `original_end_date` DATE COMMENT 'The contract expiration date before this amendment. Used to track the impact of term extension or early termination amendments.',
    `original_term_months` STRING COMMENT 'The contract term length in months before this amendment. Used to calculate the impact of term extension amendments.',
    `pricing_change_description` STRING COMMENT 'Detailed description of any pricing modifications including rate changes, discount adjustments, or pricing model changes. Provides transparency for revenue assurance and audit.',
    `reason_code` STRING COMMENT 'Standardized code indicating the business driver or trigger for the amendment. Used for trend analysis and sales effectiveness reporting. [ENUM-REF-CANDIDATE: customer_request|competitive_pressure|service_upgrade|regulatory_compliance|error_correction|renewal_negotiation|churn_prevention|upsell|cross_sell|other — 10 candidates stripped; promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text detailed explanation of why the amendment was requested and the business context. Provides narrative detail beyond the standardized reason code.',
    `request_date` DATE COMMENT 'Date when the amendment was formally requested or initiated. Marks the beginning of the amendment lifecycle.',
    `services_added` STRING COMMENT 'Comma-separated list or description of services, products, or features being added to the contract through this amendment. Used for service catalog impact analysis.',
    `services_removed` STRING COMMENT 'Comma-separated list or description of services, products, or features being removed from the contract through this amendment. Tracks service downgrades or discontinuations.',
    `sla_change_description` STRING COMMENT 'Description of any changes to Service Level Agreement terms, performance commitments, or penalty clauses. Critical for operations and customer success teams.',
    `tcv_delta_amount` DECIMAL(18,2) COMMENT 'Net change in Total Contract Value over the remaining contract term resulting from this amendment. Includes all recurring and one-time charges.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this amendment record was last modified. Tracks the most recent change for audit and synchronization purposes.',
    CONSTRAINT pk_contract_amendment PRIMARY KEY(`contract_amendment_id`)
) COMMENT 'Record of a formal change or amendment to an existing sales contract, capturing amendment type (price change, scope change, term extension, service addition/removal), effective date, approval chain, reason code, and delta values for MRR and TCV impact. Tracks the full amendment lifecycle from request through execution.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`channel` (
    `channel_id` BIGINT COMMENT 'Primary key for channel',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sales channels operate as cost centers with assigned budgets, headcount, and operating expenses. Channel performance tracking requires cost center assignment for P&L analysis and profitability measure',
    `coverage_area_id` BIGINT COMMENT 'Foreign key linking to location.coverage_area. Business justification: Sales channels operate within specific coverage areas to determine product eligibility, technology availability, and network capability alignment. Retail stores and dealer locations must validate serv',
    `employee_id` BIGINT COMMENT 'Reference to the sales manager responsible for this channels performance and operations.',
    `modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system process that last modified this record, used for audit trail and data governance.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to people.org_unit. Business justification: Telecommunications channel management requires organizational hierarchy linkage for P&L reporting, territory planning, and budget allocation. Sales channels (retail stores, telesales centers, dealer n',
    `partner_id` BIGINT COMMENT 'Reference to the partner organization record for dealer, agent, or reseller channels. Null for company-owned channels.',
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
    `commission_structure_code` STRING COMMENT 'Reference code to the commission plan and incentive structure applicable to this channel (e.g., COMM-RET-01, COMM-DEALER-TIER1).. Valid values are `^[A-Z0-9-]{3,10}$`',
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
    `segment_scope` STRING COMMENT 'Customer segment(s) this channel is authorized to serve: B2C (consumer retail), B2B (business/enterprise), MVNO (Mobile Virtual Network Operator wholesale), B2C_B2B (hybrid), ALL (all segments).. Valid values are `B2C|B2B|MVNO|B2C_B2B|ALL`',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Commission plans must be assigned to cost centers for expense allocation and departmental P&L tracking. Sales compensation is a major operating expense requiring proper cost center assignment for mana',
    `employee_id` BIGINT COMMENT 'Identifier of the compensation manager or executive who approved this commission plan for activation. Nullable if plan is in draft status.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to people.org_unit. Business justification: Telecommunications commission structures are typically scoped to organizational units (enterprise sales division, retail operations, indirect channels). Different org units have distinct commission pl',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Commission plans are tied to specific performance KPIs (revenue per rep, attach rate, customer acquisition cost). Compensation measurement requires linking plan to KPI definition for consistent calcul',
    `superseded_by_plan_commission_plan_id` BIGINT COMMENT 'Identifier of the commission plan that replaces this plan when it expires or is terminated. Creates lineage chain for plan evolution. Nullable if plan is current.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Commission plans often vary by product category (mobile vs broadband vs enterprise services). This link enables category-specific incentive design, sales behavior steering toward strategic products, a',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`commission_txn` (
    `commission_txn_id` BIGINT COMMENT 'Primary key for commission_txn',
    `commission_plan_id` BIGINT COMMENT 'Identifier of the commission plan or incentive structure under which this commission was calculated.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account for which this commission was earned.',
    `employee_id` BIGINT COMMENT 'Identifier of the sales representative, dealer, or agent who earned this commission.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Commission calculations are often triggered by invoice issuance or payment; invoice_id is needed for commission reconciliation, clawback processing on unpaid invoices, and revenue-based commission mod',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Commission transactions must post to general ledger for expense recognition and payroll liability tracking. Every commission earned/paid requires GL posting for GAAP compliance and financial reporting',
    `opportunity_id` BIGINT COMMENT 'Identifier of the sales opportunity that triggered this commission transaction.',
    `sales_contract_id` BIGINT COMMENT 'Identifier of the contract or service agreement associated with this commission.',
    `accelerator_applied` BOOLEAN COMMENT 'Boolean indicator of whether a commission accelerator (higher rate for exceeding quota) was applied to this transaction.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'The amount of adjustment applied to the earned commission, which may be positive (bonus) or negative (penalty or correction).',
    `approval_date` DATE COMMENT 'The date when the commission transaction was approved for payment.',
    `approval_status` STRING COMMENT 'The approval workflow status indicating whether the commission transaction has been reviewed and authorized for payment.. Valid values are `pending_approval|approved|rejected|auto_approved`',
    `approved_by` STRING COMMENT 'Name or identifier of the manager or system that approved this commission transaction for payout.',
    `clawback_amount` DECIMAL(18,2) COMMENT 'The amount of commission reversed or reclaimed due to customer churn, contract cancellation, or policy violation.',
    `clawback_reason` STRING COMMENT 'The business reason or justification for commission clawback, such as early customer churn, contract cancellation, payment default, or policy violation.',
    `commission_rate` DECIMAL(18,2) COMMENT 'The percentage rate or multiplier applied to the sale value to calculate the commission amount (e.g., 0.0500 for 5%).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this commission transaction record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this commission transaction.. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'The business segment classification of the customer for whom the sale was made: consumer, small business, mid-market, enterprise, government, or wholesale.. Valid values are `consumer|small_business|mid_market|enterprise|government|wholesale`',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether this commission transaction is currently under dispute by the sales representative or management.',
    `dispute_reason` STRING COMMENT 'Description of the reason for disputing this commission transaction, if applicable.',
    `earned_amount` DECIMAL(18,2) COMMENT 'The gross commission amount earned by the sales representative before any adjustments or clawbacks.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this commission transaction record was last updated or modified.',
    `net_payable_amount` DECIMAL(18,2) COMMENT 'The final net commission amount payable to the sales representative after all adjustments and clawbacks have been applied.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this commission transaction, including special circumstances, approvals, or audit trail information.',
    `override_flag` BOOLEAN COMMENT 'Boolean indicator of whether this commission represents a manager override or additional incentive beyond the standard commission plan.',
    `override_reason` STRING COMMENT 'Business justification for the commission override or manual adjustment, if applicable.',
    `payment_period` STRING COMMENT 'The accounting period (YYYY-MM format) in which this commission is scheduled for payout.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `payout_batch_number` BIGINT COMMENT 'Identifier of the payment batch or payroll run in which this commission was or will be paid out.',
    `payout_date` DATE COMMENT 'The actual date when the commission payment was disbursed to the sales representative.',
    `product_category` STRING COMMENT 'The high-level category of the product or service sold that generated this commission: mobile, broadband, fiber, IPTV, enterprise, IoT, device, or accessory. [ENUM-REF-CANDIDATE: mobile|broadband|fiber|iptv|enterprise|iot|device|accessory — 8 candidates stripped; promote to reference product]',
    `quota_attainment_percentage` DECIMAL(18,2) COMMENT 'The sales representatives quota attainment percentage at the time this commission was earned, which may influence commission rate or bonus eligibility.',
    `sale_amount` DECIMAL(18,2) COMMENT 'The total value of the underlying sale, activation, or contract that forms the basis for commission calculation.',
    `sales_channel` STRING COMMENT 'The distribution channel through which the sale was made: retail store, online, telesales, dealer, agent, partner, direct, or enterprise. [ENUM-REF-CANDIDATE: retail_store|online|telesales|dealer|agent|partner|direct|enterprise — 8 candidates stripped; promote to reference product]',
    `service_type` STRING COMMENT 'The type of service offering associated with the sale: postpaid, prepaid, hybrid, enterprise, wholesale, or Mobile Virtual Network Operator (MVNO).. Valid values are `postpaid|prepaid|hybrid|enterprise|wholesale|mvno`',
    `source_system` STRING COMMENT 'The operational system of record that originated this commission transaction: Salesforce CRM, SAP S/4HANA, commission calculation engine, or manual entry.. Valid values are `salesforce_crm|sap_s4hana|commission_engine|manual_entry`',
    `split_percentage` DECIMAL(18,2) COMMENT 'The percentage of the total commission allocated to this sales representative when commission is shared among multiple parties (e.g., 50.00 for 50% split).',
    `transaction_date` DATE COMMENT 'The business date when the commission transaction was recorded or earned, representing the principal event timestamp for this transaction.',
    `transaction_number` STRING COMMENT 'Human-readable unique business identifier for the commission transaction, used for tracking and reconciliation.. Valid values are `^COMM-[0-9]{10}$`',
    `transaction_status` STRING COMMENT 'Current approval and payment status of the commission transaction in the workflow lifecycle.. Valid values are `pending|approved|rejected|paid|cancelled|disputed`',
    `transaction_type` STRING COMMENT 'Type of commission transaction: earned (initial commission), adjusted (correction), clawback (reversal), bonus (additional incentive), override (manager commission), or split (shared commission).. Valid values are `earned|adjusted|clawback|bonus|override|split`',
    `triggering_event` STRING COMMENT 'The specific sales event or customer action that triggered this commission: new activation, upgrade, renewal, Mobile Number Portability (MNP) port-in, contract extension, add-on sale, device sale, or plan change. [ENUM-REF-CANDIDATE: new_activation|upgrade|renewal|mnp_port_in|contract_extension|add_on_sale|device_sale|plan_change — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_commission_txn PRIMARY KEY(`commission_txn_id`)
) COMMENT 'Transactional record of a commission earned or adjusted for a sales rep, dealer, or agent against a specific sale, activation, or contract. Captures commission plan reference, earned amount, clawback amount, payment period, triggering event (new activation, upgrade, renewal, MNP port-in), approval status, and payout batch reference. SSOT for all sales incentive financial transactions.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`target` (
    `target_id` BIGINT COMMENT 'Primary key for target',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Sales targets are direct inputs to revenue budget planning. Quota setting drives top-line financial forecasts and resource allocation decisions. Critical link for aligning sales goals with financial p',
    `channel_id` BIGINT COMMENT 'Identifier of the sales channel (e.g., retail, online, telesales, enterprise direct) to which this target is assigned. Null if the target is assigned to a specific rep, team, or dealer.',
    `commission_plan_id` BIGINT COMMENT 'Identifier of the sales incentive compensation plan associated with this target. Null if the target is not tied to a specific incentive plan.',
    `dealer_id` BIGINT COMMENT 'Identifier of the dealer or agent to whom this target is assigned. Used for indirect channel sales performance management. Null if the target is assigned to a direct sales rep or team.',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Sales targets measure specific KPIs (quota attainment, average deal size, win rate). The target IS a goal for a defined KPI—linking to kpi_definition ensures consistent metric definitions across targe',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to people.org_unit. Business justification: Sales target cascading in telecommunications flows through organizational hierarchy. Targets are set at org unit level (regional sales, enterprise accounts, SMB division) then allocated to teams and i',
    `team_id` BIGINT COMMENT 'Identifier of the sales team to which this target is assigned. Null if the target is assigned to an individual rep, dealer, or channel.',
    `employee_id` BIGINT COMMENT 'Identifier of the user (typically a sales manager or director) who approved the target. Null if the target has not been approved.',
    `target_created_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who created the sales target record.',
    `target_employee_id` BIGINT COMMENT 'Identifier of the individual sales representative to whom this target is assigned. Null if the target is assigned to a team, dealer, or channel rather than an individual.',
    `target_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the sales target record.',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`activity` (
    `activity_id` BIGINT COMMENT 'Primary key for activity',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that generated or influenced this sales activity. Links the activity to campaign attribution and ROI analysis.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account this activity is associated with. Links to the business or consumer account.',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Sales activities (calls, meetings, emails) target specific contacts within accounts. Essential for CRM activity tracking, contact engagement history, and sales pipeline management in B2B telecommunica',
    `employee_id` BIGINT COMMENT 'Reference to the sales representative who performed or logged this activity. Links to the employee or agent responsible.',
    `lead_id` BIGINT COMMENT 'Reference to the sales lead this activity is associated with. Links to the prospect being qualified.',
    `location_address_id` BIGINT COMMENT 'Foreign key linking to location.location_address. Business justification: Sales activities (site surveys, customer meetings, installation appointments) occur at specific addresses requiring geocoding, territory assignment, and routing optimization. Essential for field sales',
    `opportunity_id` BIGINT COMMENT 'Reference to the sales opportunity this activity is associated with. Links to the opportunity being pursued.',
    `activity_date` DATE COMMENT 'Date when the sales activity occurred or is scheduled to occur. Primary business event date for the interaction.',
    `activity_description` STRING COMMENT 'Detailed description of the sales activity. Captures notes, discussion points, customer feedback, and action items from the interaction.',
    `activity_status` STRING COMMENT 'Current status of the sales activity in its lifecycle. Tracks whether the activity is planned, ongoing, finished, or did not occur.. Valid values are `scheduled|in_progress|completed|cancelled|no_show`',
    `activity_type` STRING COMMENT 'Type of sales activity performed. Categorizes the interaction method used to engage with the prospect or customer.. Valid values are `call|email|meeting|demo|site_visit|proposal`',
    `attendee_count` STRING COMMENT 'Number of attendees who participated in the sales activity. Tracks the size of the meeting or presentation for engagement analysis.',
    `channel` STRING COMMENT 'Sales channel through which the activity was conducted. Identifies whether the interaction occurred through direct sales, retail store, dealer network, agent, partner, online platform, or telesales. [ENUM-REF-CANDIDATE: direct|retail|dealer|agent|partner|online|telesales — 7 candidates stripped; promote to reference product]',
    `competitor_mentioned` STRING COMMENT 'Name of competitor mentioned or discussed during the sales activity. Captures competitive intelligence from customer interactions.',
    `contact_method` STRING COMMENT 'Method or medium used to conduct the sales activity. Distinguishes the communication interface used for the interaction.. Valid values are `phone|email|in_person|video_conference|web_chat|social_media`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the sales activity record was first created in the system. Audit field for record creation tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated revenue. Identifies the currency in which the deal value is denominated.. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Customer segment targeted by this sales activity. Identifies whether the interaction is B2C consumer, small business, mid-market, enterprise, or wholesale MVNO.. Valid values are `consumer|soho|smb|mid_market|enterprise|wholesale`',
    `deal_size_category` STRING COMMENT 'Size category of the potential deal associated with this activity. Classifies the revenue opportunity magnitude for resource prioritization.. Valid values are `small|medium|large|strategic`',
    `duration_minutes` STRING COMMENT 'Total duration of the sales activity in minutes. Measures the time investment in the customer interaction for productivity analysis.',
    `end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the sales activity ended. Captures the conclusion of the interaction for duration calculation.',
    `estimated_revenue` DECIMAL(18,2) COMMENT 'Estimated revenue value associated with the opportunity or lead related to this activity. Represents the potential deal value in the base currency.',
    `external_activity_reference` STRING COMMENT 'Unique identifier of the activity in the source system. Enables traceability and reconciliation with the originating CRM platform.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether the sales activity is billable to the customer or partner. Used for professional services and consulting engagements.',
    `is_deleted` BOOLEAN COMMENT 'Soft delete flag indicating whether the sales activity record has been logically deleted. Supports data retention and audit requirements.',
    `location` STRING COMMENT 'Physical or virtual location where the sales activity took place. Captures the venue for in-person meetings or the platform for virtual interactions.',
    `modified_by` STRING COMMENT 'User or system identifier that last modified the sales activity record. Audit field for accountability and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the sales activity record was last modified. Audit field for change tracking and data freshness.',
    `next_action` STRING COMMENT 'Recommended or planned next action following this sales activity. Captures the follow-up step required to advance the opportunity or lead.',
    `next_action_due_date` DATE COMMENT 'Target date by which the next action should be completed. Supports pipeline velocity tracking and sales cadence management.',
    `objection_raised` STRING COMMENT 'Customer objection or concern raised during the sales activity. Documents barriers to closing the deal for coaching and strategy refinement.',
    `outcome` STRING COMMENT 'Result or outcome of the completed sales activity. Indicates whether the activity achieved its intended goal and what the next step should be.. Valid values are `successful|unsuccessful|follow_up_required|qualified|disqualified|closed_won`',
    `priority` STRING COMMENT 'Priority level assigned to the sales activity. Indicates the urgency and importance of the interaction for resource allocation and follow-up.. Valid values are `low|medium|high|urgent`',
    `product_interest` STRING COMMENT 'Product or service the customer expressed interest in during this activity. Captures the specific offering being discussed or demonstrated.',
    `service_type` STRING COMMENT 'Type of telecommunications service discussed or offered during the activity. Categorizes the service line relevant to the sales interaction. [ENUM-REF-CANDIDATE: wireless|broadband|fiber|iptv|enterprise|mvno|iot — 7 candidates stripped; promote to reference product]',
    `source_system` STRING COMMENT 'Name of the source system from which this activity record was ingested. Identifies the originating CRM or sales automation platform.',
    `start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the sales activity started. Captures the beginning of the interaction for duration calculation and scheduling.',
    `subject` STRING COMMENT 'Brief subject or title of the sales activity. Provides a summary of the activity purpose or topic discussed.',
    `created_by` STRING COMMENT 'User or system identifier that created the sales activity record. Audit field for accountability and data lineage.',
    CONSTRAINT pk_activity PRIMARY KEY(`activity_id`)
) COMMENT 'Transactional record of a sales interaction or activity logged against a lead, opportunity, or account — including calls, emails, demos, site visits, proposal presentations, and negotiation sessions. Captures activity type, outcome, duration, channel, associated opportunity/lead, sales rep, and next action. Sourced from Salesforce CRM activity tracking. Enables pipeline velocity and sales rep productivity analysis.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`promotion` (
    `promotion_id` BIGINT COMMENT 'Unique identifier for the sales promotion or incentive offer. Primary key.',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Promotional campaigns require budget allocation and spend tracking. Marketing/sales promotions are budgeted expenses with allocated amounts that must be tracked against financial plans for variance an',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign or initiative that this promotion is part of. Used to group promotions for reporting and performance analysis. Links to Salesforce CRM Campaign object.',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.content_package. Business justification: Promotions frequently target specific content packages (e.g., "3 months free premium channels", "50% off sports package"). Required for marketing campaign execution, promotion eligibility validation, ',
    `employee_id` BIGINT COMMENT 'User ID or email of the marketing or sales operations user who created this promotion record in the system.',
    `promotion_last_modified_by_user_employee_id` BIGINT COMMENT 'User ID or email of the user who last modified this promotion record. Used for change tracking and accountability.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Promotions often target specific catalog items (e.g., "50% off iPhone 15 with unlimited plan"). This link is essential for promotion eligibility validation, redemption tracking, and measuring promotio',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Many promotions apply to entire product categories rather than individual SKUs (e.g., "20% off all broadband plans"). Enables category-level promotional campaign management, eligibility validation, an',
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
    `eligible_customer_segment` STRING COMMENT 'Target customer segment eligible for this promotion: b2c_consumer (retail individual), b2b_smb (small/medium business), b2b_enterprise (large corporate), mvno_wholesale (Mobile Virtual Network Operator partners), all_segments (universal offer).. Valid values are `b2c_consumer|b2b_smb|b2b_enterprise|mvno_wholesale|all_segments`',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` (
    `promotion_redemption_id` BIGINT COMMENT 'Unique identifier for the promotion redemption transaction. Primary key for this entity.',
    `campaign_id` BIGINT COMMENT 'Reference to the broader marketing or sales campaign under which this promotion was offered. Links to campaign management.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise-specific promotions and volume discounts must track corporate account redemption for discount compliance auditing, enterprise pricing governance, and account-level promotion budget tracking',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that redeemed the promotion. Links to the customer master.',
    `dealer_id` BIGINT COMMENT 'Reference to the dealer or partner organization through which the promotion was redeemed. Applicable for indirect sales channels.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the sales order where this promotion was applied. Nullable if redemption occurred at quote or contract stage.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Each promotion redemption creates discount/contra-revenue posting in general ledger. Revenue recognition standards require proper GL recording of discounts and promotional allowances. Essential for ac',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.content_package. Business justification: Tracks which content package a promotion was redeemed against. Essential for revenue recognition (deferred revenue for free trial periods), promotion effectiveness analysis, and billing system integra',
    `employee_id` BIGINT COMMENT 'Reference to the sales representative or agent who applied the promotion. Nullable for self-service redemptions.',
    `promotion_id` BIGINT COMMENT 'Reference to the promotion campaign or offer that was redeemed. Links to the promotion master catalog.',
    `quote_id` BIGINT COMMENT 'Reference to the sales quote where this promotion was applied. Nullable if redemption occurred at order or contract stage.',
    `sales_contract_id` BIGINT COMMENT 'Reference to the customer contract where this promotion was applied. Nullable if redemption occurred at quote or order stage.',
    `spec_id` BIGINT COMMENT 'Reference to the specific product or service offering to which the promotion was applied. Links to the product catalog.',
    `tertiary_promotion_approved_by_user_employee_id` BIGINT COMMENT 'The system user ID of the manager or approver who authorized this promotion redemption. Nullable if no approval was required.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this promotion redemption required managerial or system approval before being applied. True if approval workflow was triggered.',
    `approval_status` STRING COMMENT 'The current approval state of this promotion redemption. Tracks the approval workflow outcome.. Valid values are `approved|pending_approval|rejected|not_required|auto_approved`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the promotion redemption was approved. Nullable if no approval was required or if still pending.',
    `benefit_duration_months` STRING COMMENT 'The number of months for which the promotion benefit applies. Nullable for one-time or unlimited duration promotions.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this redemption record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the discount amount. Indicates the currency in which the promotion value is denominated.. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'The customer segment classification at the time of redemption. Used to track promotion effectiveness by market segment.. Valid values are `consumer|small_business|enterprise|government|wholesale|mvno`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The monetary value of the discount applied through this promotion redemption. Represents the reduction in price or charge.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied through this promotion. Nullable if promotion is a fixed amount discount rather than percentage-based.',
    `external_reference_code` STRING COMMENT 'The unique identifier for this redemption in the source operational system. Enables traceability back to the originating system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this redemption record was last updated. Audit trail for record modifications.',
    `max_redemptions_allowed` STRING COMMENT 'The maximum number of times this promotion can be redeemed within the defined limit scope. Nullable for unlimited promotions.',
    `notes` STRING COMMENT 'Free-text notes or comments about this promotion redemption. Used to capture additional context or special circumstances.',
    `promotion_effective_date` DATE COMMENT 'The date when the promotion benefit becomes active for the customer. May differ from redemption date for future-dated promotions.',
    `promotion_expiry_date` DATE COMMENT 'The date when the promotion benefit expires or ends. Defines the duration of the promotional offer.',
    `recurring_benefit_flag` BOOLEAN COMMENT 'Indicates whether this promotion provides a recurring benefit over multiple billing cycles. True for ongoing discounts, false for one-time discounts.',
    `redemption_channel` STRING COMMENT 'The sales channel through which the promotion was redeemed. Indicates the customer touchpoint where the promotion was applied.. Valid values are `retail_store|online_portal|mobile_app|call_center|dealer_portal|partner_channel`',
    `redemption_code` STRING COMMENT 'The unique alphanumeric code or voucher number entered or scanned by the customer or sales representative to activate the promotion.. Valid values are `^[A-Z0-9]{6,20}$`',
    `redemption_count` STRING COMMENT 'The sequential count of this redemption within the applicable limit scope. Used to enforce maximum redemption limits.',
    `redemption_date` DATE COMMENT 'The calendar date when the promotion was redeemed. Used for day-level reporting and analytics.',
    `redemption_limit_type` STRING COMMENT 'The scope or level at which redemption limits are enforced for this promotion. Defines the boundary for usage tracking.. Valid values are `per_customer|per_account|per_order|per_campaign|unlimited`',
    `redemption_timestamp` TIMESTAMP COMMENT 'The exact date and time when the promotion was applied to the quote, order, or contract. Represents the business event time of redemption.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this promotion redemption has been reversed or cancelled. True if the redemption was subsequently voided.',
    `reversal_reason` STRING COMMENT 'The business reason or explanation for reversing this promotion redemption. Nullable if redemption has not been reversed.',
    `reversal_timestamp` TIMESTAMP COMMENT 'The date and time when this promotion redemption was reversed. Nullable if redemption has not been reversed.',
    `service_type` STRING COMMENT 'The category of telecommunications service to which the promotion applies. Enables service-line specific promotion tracking. [ENUM-REF-CANDIDATE: mobile|broadband|fiber|iptv|voip|enterprise|iot|wholesale — 8 candidates stripped; promote to reference product]',
    `source_system` STRING COMMENT 'The operational system that originated this redemption record. Indicates the system of record for this transaction.. Valid values are `salesforce_crm|amdocs_billing|oracle_osm|netcracker_bss|sap_erp|partner_portal`',
    `validation_message` STRING COMMENT 'Detailed message or reason code explaining the validation outcome. Provides context for failed or pending validations.',
    `validation_status` STRING COMMENT 'Current validation state of the promotion redemption. Indicates whether the redemption passed eligibility and fraud checks.. Valid values are `validated|pending_validation|validation_failed|expired|revoked|fraud_suspected`',
    `validation_timestamp` TIMESTAMP COMMENT 'The date and time when the promotion redemption was validated or when validation status was last updated.',
    CONSTRAINT pk_promotion_redemption PRIMARY KEY(`promotion_redemption_id`)
) COMMENT 'Transactional record of a promotion being applied to a specific quote, order, or contract during the sales process. Captures promotion reference, redemption date, applied discount value, redemption channel, sales rep or dealer who applied it, and validation status. Enables promotion utilization tracking and prevents over-redemption against defined limits.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` (
    `b2b_account_plan_id` BIGINT COMMENT 'Unique identifier for the B2B account plan. Primary key.',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Enterprise account plans include revenue targets (target_mrr_growth, target_arr_growth) that feed into financial budgets. Strategic account planning drives revenue forecasts and resource allocation in',
    `corporate_hierarchy_id` BIGINT COMMENT 'Foreign key linking to customer.corporate_hierarchy. Business justification: B2B account plans for enterprise customers must reference corporate hierarchy to understand organizational structure, subsidiary relationships, and consolidated billing arrangements. Critical for stra',
    `customer_account_id` BIGINT COMMENT 'Reference to the B2B enterprise or government customer account in the customer domain. Links this strategic plan to the customer master record.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: B2B account plans for large enterprise customers require direct corporate account linkage for strategic account planning, whitespace analysis across enterprise sites, executive relationship mapping, a',
    `position_id` BIGINT COMMENT 'Foreign key linking to people.position. Business justification: Enterprise account planning in telecommunications associates strategic account plans with formal positions (VP Enterprise Sales, Regional Director) for succession planning and coverage continuity. Whe',
    `employee_id` BIGINT COMMENT 'Reference to the user (typically the account owner or sales manager) who created this account plan record.',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: B2B account plans track primary service territory for network capacity planning, competitive footprint analysis, and multi-site expansion opportunities. Critical for enterprise account management, whi',
    `segment_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.segment_definition. Business justification: B2B account plans are built for specific customer segments (Fortune 500, mid-market enterprise, government). Segment classification drives account planning strategy, whitespace analysis, and growth ta',
    `sla_contract_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_contract. Business justification: Enterprise account planning directly references SLA performance commitments. Account managers track assurance SLA compliance as part of renewal strategy, whitespace analysis, and upsell opportunities.',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.content_package. Business justification: Enterprise account plans identify content package upsell and cross-sell opportunities as part of strategic account management. Required for whitespace analysis, revenue growth planning, and tracking c',
    `tertiary_b2b_approved_by_user_employee_id` BIGINT COMMENT 'Reference to the sales leader or manager who approved this account plan. Null if not yet approved.',
    `account_health_status` STRING COMMENT 'Overall health assessment of the customer account based on satisfaction scores, service performance, payment history, and engagement level.. Valid values are `healthy|at_risk|critical|churned`',
    `account_tier` STRING COMMENT 'Tiering classification based on strategic importance and revenue contribution. Tier 1 accounts receive highest touch and resources, Tier 3 are standard accounts.. Valid values are `tier_1_strategic|tier_2_major|tier_3_standard`',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this account plan was formally approved by sales leadership or management. Null if not yet approved.',
    `baseline_arr` DECIMAL(18,2) COMMENT 'The starting Annual Recurring Revenue (ARR) from this account at the beginning of the plan period. Used to measure growth against target.',
    `baseline_mrr` DECIMAL(18,2) COMMENT 'The starting Monthly Recurring Revenue (MRR) from this account at the beginning of the plan period. Used to measure growth against target.',
    `churn_probability_score` DECIMAL(18,2) COMMENT 'Quantitative score (0-100) representing the likelihood of customer churn during the plan period. May be calculated by predictive models or assigned by the account team.',
    `competitive_threats` STRING COMMENT 'Analysis of competitive risks and threats from other telecommunications providers or alternative solutions (e.g., OTT services, MVNO competitors, in-house network builds). Includes competitor names and threat severity.',
    `contract_renewal_date` DATE COMMENT 'The date when the customers primary contract or master service agreement is up for renewal. Critical milestone for retention planning.',
    `contract_value` DECIMAL(18,2) COMMENT 'Total contract value (TCV) of the customers current agreements with the telecommunications provider. Expressed in the base currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this account plan record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `cross_sell_opportunities` STRING COMMENT 'Documented list of planned cross-sell initiatives to introduce new product lines or services (e.g., adding SD-WAN to an MPLS customer, adding cloud services to a connectivity customer).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this plan (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customer_lifetime_value` DECIMAL(18,2) COMMENT 'Estimated Customer Lifetime Value (CLTV) for this B2B account, representing the total revenue expected over the entire customer relationship. Used for prioritization and investment decisions.',
    `customer_satisfaction_score` DECIMAL(18,2) COMMENT 'Most recent Customer Satisfaction (CSAT) score for this account, typically on a scale of 1-5 or 1-10. Reflects overall satisfaction with services and support.',
    `customer_segment` STRING COMMENT 'The B2B customer segment classification: enterprise (large corporations), mid-market (medium-sized businesses), government (public sector), or wholesale/MVNO (carrier/reseller partners).. Valid values are `enterprise|mid_market|government|wholesale_mvno`',
    `executive_sponsor_name` STRING COMMENT 'Name of the executive sponsor or primary decision-maker at the customer organization who champions the telecommunications providers solutions.',
    `executive_sponsor_title` STRING COMMENT 'Job title of the executive sponsor (e.g., CIO, CTO, VP of IT, Director of Procurement).',
    `fiscal_year` STRING COMMENT 'The fiscal year this account plan covers (e.g., FY2024, 2024). Aligns with the enterprise sales planning cycle.',
    `industry_vertical` STRING COMMENT 'The industry vertical or sector of the B2B customer (e.g., Financial Services, Healthcare, Manufacturing, Government, Education, Retail). Used for vertical-specific solution positioning.',
    `key_stakeholder_map` STRING COMMENT 'Structured mapping of key decision-makers, influencers, and champions within the customer organization. May include names, titles, roles, and relationship strength indicators.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this account plan record was last updated. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of this account plan. Used to track planning cadence and ensure plans remain current.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this account plan with the account team and sales leadership. Typically quarterly or semi-annually.',
    `nps_score` STRING COMMENT 'Most recent Net Promoter Score (NPS) for this account, ranging from -100 to +100. Measures customer loyalty and likelihood to recommend the telecommunications provider.',
    `plan_end_date` DATE COMMENT 'The date when this account plan period concludes. Typically aligns with fiscal year end or contract renewal date.',
    `plan_name` STRING COMMENT 'Business-friendly name for this strategic account plan, typically including customer name and fiscal year (e.g., Acme Corp FY2024 Growth Plan).',
    `plan_notes` STRING COMMENT 'Free-text field for additional strategic notes, observations, or context about the account plan that do not fit into structured fields. May include meeting notes, customer feedback, or internal strategy discussions.',
    `plan_start_date` DATE COMMENT 'The date when this account plan becomes effective and execution begins.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the account plan. Indicates whether the plan is in draft, active execution, under review, approved by leadership, archived, or suspended.. Valid values are `draft|active|under_review|approved|archived|suspended`',
    `plan_type` STRING COMMENT 'Classification of the account plan based on the strategic objective: new customer acquisition, existing customer growth, retention focus, renewal focus, or strategic partnership development.. Valid values are `new_customer|existing_customer_growth|retention|renewal|strategic_partnership`',
    `primary_competitor` STRING COMMENT 'Name of the primary competing telecommunications provider or solution vendor that poses the greatest threat to this account.',
    `renewal_risk_factors` STRING COMMENT 'Detailed description of factors contributing to renewal risk, such as service quality issues, pricing concerns, competitive pressure, organizational changes at the customer, or dissatisfaction with support.',
    `renewal_risk_level` STRING COMMENT 'Assessment of the risk that the customer will not renew their contracts or services at the end of the current term. Levels: low (strong relationship, high satisfaction), medium (some concerns), high (significant issues), critical (imminent churn risk).. Valid values are `low|medium|high|critical`',
    `service_portfolio_summary` STRING COMMENT 'High-level summary of the telecommunications services currently subscribed by this customer (e.g., MPLS, SD-WAN, Internet, Voice, Mobile, Cloud Connectivity, Managed Services).',
    `strategic_initiatives` STRING COMMENT 'List of major strategic initiatives planned for this account during the plan period (e.g., 5G migration, SD-WAN deployment, IoT pilot, cloud connectivity expansion).',
    `target_arr_growth` DECIMAL(18,2) COMMENT 'The target increase in Annual Recurring Revenue (ARR) for this account during the plan period. Expressed in the base currency.',
    `target_mrr_growth` DECIMAL(18,2) COMMENT 'The target increase in Monthly Recurring Revenue (MRR) for this account during the plan period. Expressed in the base currency.',
    `upsell_opportunities` STRING COMMENT 'Documented list of planned upsell initiatives to increase service tier, bandwidth, or feature adoption within existing services. May include opportunity IDs or descriptions.',
    `whitespace_analysis` STRING COMMENT 'Detailed analysis of untapped opportunities within the customer account. Identifies products, services, or business units where the customer is not yet using the telecommunications providers offerings.',
    CONSTRAINT pk_b2b_account_plan PRIMARY KEY(`b2b_account_plan_id`)
) COMMENT 'Strategic account plan for a B2B enterprise or government customer, capturing account growth objectives, whitespace analysis, key stakeholder map, planned upsell/cross-sell initiatives, competitive threats, renewal risk assessment, and target MRR growth. Owned by the enterprise sales team and linked to the customer account in the customer domain. Distinct from the customer master — this is the sales strategy document.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` (
    `mvno_agreement_id` BIGINT COMMENT 'Unique identifier for the MVNO wholesale commercial agreement. Primary key.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: MVNO agreements specify which offerings the partner can resell under their brand. Essential for partner catalog management, revenue share calculation, and ensuring MVNOs only provision authorized serv',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: MVNO partners are enterprise customers with wholesale agreements. Corporate account linkage essential for wholesale billing reconciliation, committed volume tracking, revenue share calculation, SLA br',
    `spectrum_allocation_id` BIGINT COMMENT 'Foreign key linking to inventory.spectrum_allocation. Business justification: MVNO wholesale agreements explicitly define which spectrum bands the partner is authorized to use for their network operations. Critical for network access control and regulatory compliance in MVNO bu',
    `msisdn_range_id` BIGINT COMMENT 'Foreign key linking to inventory.msisdn_range. Business justification: MVNO agreements allocate specific number ranges to the partner for their subscriber base. Essential for number resource management, porting coordination, and regulatory compliance in wholesale mobile ',
    `partner_id` BIGINT COMMENT 'Reference to the MVNO partner entity that is party to this wholesale agreement.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to people.org_unit. Business justification: MVNO partnerships are major strategic wholesale agreements requiring organizational unit ownership for governance, P&L accountability, and cross-functional coordination. Typically owned by wholesale/p',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.content_package. Business justification: MVNO wholesale agreements may include content packages as part of white-label service offerings to MVNO partners. Required for MVNO partner provisioning, wholesale billing, revenue share calculations,',
    `peering_agreement_id` BIGINT COMMENT 'Foreign key linking to network.peering_agreement. Business justification: MVNO commercial agreements depend on underlying network peering arrangements for roaming, interconnect, and traffic exchange capabilities. The sales contract must reference the technical peering agree',
    `employee_id` BIGINT COMMENT 'Reference to the sales or account management employee responsible for managing the MVNO partner relationship.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: MVNO agreements explicitly allocate regulatory compliance responsibilities between host MNO and MVNO partner (lawful intercept, E911, number portability, data privacy). Each agreement references speci',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: MVNO agreements are wholesale commercial contracts between the telecommunications provider and MVNO partners. These agreements ARE a specialized type of sales contract and should reference the master ',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: MVNO agreements specify service territories for network access rights, roaming zone definitions, and regulatory compliance obligations. Essential for wholesale agreement administration, coverage entit',
    `wholesale_rate_card_id` BIGINT COMMENT 'Reference to the wholesale pricing rate card defining per-unit charges for voice, SMS, data, and other network services provided to the MVNO.',
    `agreement_name` STRING COMMENT 'Human-readable name or title of the MVNO agreement for identification and reporting purposes.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the MVNO agreement, used in contracts and invoicing.. Valid values are `^MVNO-AGR-[0-9]{8}$`',
    `agreement_type` STRING COMMENT 'Classification of the MVNO agreement model defining the level of network control and infrastructure ownership by the MVNO partner.. Valid values are `full_mvno|light_mvno|branded_reseller|white_label|hybrid`',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the MVNO agreement was formally approved and transitioned from draft to active status.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the MVNO agreement automatically renews at the end of the contract term without requiring explicit renegotiation.',
    `billing_settlement_cycle_days` STRING COMMENT 'Number of days in the billing cycle for wholesale usage settlement between host operator and MVNO partner.',
    `committed_subscriber_volume` STRING COMMENT 'Minimum number of active subscribers the MVNO partner commits to maintain under the agreement terms, used for volume-based pricing tiers.',
    `committed_traffic_volume_gb` DECIMAL(18,2) COMMENT 'Minimum monthly data traffic volume in gigabytes the MVNO partner commits to generate, used for wholesale pricing and capacity planning.',
    `contract_document_url` STRING COMMENT 'Secure storage location or document management system URL for the signed MVNO agreement contract document.',
    `contract_term_months` STRING COMMENT 'Duration of the MVNO agreement contract term expressed in months from effective date to expiry date.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the MVNO agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all financial terms in this MVNO agreement.. Valid values are `^[A-Z]{3}$`',
    `data_privacy_responsibility` STRING COMMENT 'Party responsible for subscriber data privacy compliance including CPNI protection and consent management under regulatory frameworks.. Valid values are `host_operator|mvno_partner|shared`',
    `e911_service_responsibility` STRING COMMENT 'Party responsible for providing E911 emergency location services for MVNO subscribers under regulatory requirements.. Valid values are `host_operator|mvno_partner|shared`',
    `early_termination_penalty_amount` DECIMAL(18,2) COMMENT 'Financial penalty amount payable by the MVNO partner if the agreement is terminated before the contract term expires.',
    `effective_date` DATE COMMENT 'Date when the MVNO agreement becomes legally binding and operational, marking the start of the contract term.',
    `esim_support_flag` BOOLEAN COMMENT 'Indicates whether the MVNO partner is entitled to provision and manage embedded SIM profiles for subscribers under this agreement.',
    `expiry_date` DATE COMMENT 'Date when the MVNO agreement terminates or expires, marking the end of the contract term. Nullable for evergreen agreements.',
    `ims_access_flag` BOOLEAN COMMENT 'Indicates whether the MVNO partner has access to the host operators IMS core for advanced multimedia services.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the MVNO agreement record was last updated or modified.',
    `lawful_intercept_responsibility` STRING COMMENT 'Party responsible for implementing and managing lawful intercept capabilities for MVNO subscriber traffic under regulatory requirements.. Valid values are `host_operator|mvno_partner|shared`',
    `mvno_agreement_status` STRING COMMENT 'Current lifecycle status of the MVNO agreement indicating its operational state and enforceability.. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `network_access_type` STRING COMMENT 'Radio access network technology generations that the MVNO partner is entitled to access under this agreement.. Valid values are `2g|3g|4g_lte|5g_nr|multi_technology`',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special terms, or contextual information about the MVNO agreement.',
    `number_portability_support_flag` BOOLEAN COMMENT 'Indicates whether the MVNO partner is entitled to support mobile number portability for subscribers porting numbers in or out.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date that the MVNO partner has to remit payment for wholesale charges.',
    `qos_priority_level` STRING COMMENT 'Network traffic prioritization level assigned to MVNO subscriber traffic relative to host operator subscribers.. Valid values are `premium|standard|economy`',
    `regulatory_compliance_obligations` STRING COMMENT 'Description of regulatory compliance responsibilities allocated between host operator and MVNO partner, including lawful intercept, E911, and data privacy.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiry that either party must provide notice to prevent automatic renewal or initiate renegotiation.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of retail revenue that the MVNO partner shares with the host network operator under the revenue share model.',
    `roaming_coverage_zones` STRING COMMENT 'Geographic zones or country groups where MVNO subscribers are entitled to roaming services, expressed as comma-separated zone codes.',
    `roaming_entitlement_flag` BOOLEAN COMMENT 'Indicates whether the MVNO partner subscribers are entitled to international and domestic roaming services under this agreement.',
    `sales_channel` STRING COMMENT 'Sales channel through which the MVNO agreement was originated and managed.. Valid values are `direct|partner|broker|wholesale_team`',
    `security_deposit_amount` DECIMAL(18,2) COMMENT 'Financial security deposit amount required from the MVNO partner to secure payment obligations under the agreement.',
    `sla_latency_ms` STRING COMMENT 'Maximum acceptable network latency in milliseconds guaranteed under the SLA for MVNO subscriber traffic.',
    `sla_packet_loss_percentage` DECIMAL(18,2) COMMENT 'Maximum acceptable packet loss percentage guaranteed under the SLA for MVNO subscriber data traffic.',
    `sla_penalty_clause` STRING COMMENT 'Description of financial penalties or service credits applied when the host operator fails to meet SLA commitments.',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'Guaranteed network availability uptime percentage that the host operator commits to provide to MVNO subscribers under the SLA terms.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the MVNO agreement prior to natural expiry.',
    `volte_support_flag` BOOLEAN COMMENT 'Indicates whether the MVNO partner subscribers are entitled to VoLTE voice services over the 4G LTE network.',
    CONSTRAINT pk_mvno_agreement PRIMARY KEY(`mvno_agreement_id`)
) COMMENT 'Wholesale commercial agreement with a Mobile Virtual Network Operator (MVNO) partner defining network access terms, wholesale rate card, traffic commitments, roaming entitlements, SLA parameters, revenue share model, and regulatory obligations. Captures MVNO entity reference, agreement status, effective/expiry dates, committed subscriber volumes, and wholesale pricing tiers. SSOT for MVNO wholesale sales pipeline.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`retention_offer` (
    `retention_offer_id` BIGINT COMMENT 'Unique identifier for the retention offer record. Primary key.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Retention offers target billing accounts based on payment history, ARPU, account status, and outstanding balance; account_id is essential for offer eligibility determination, financial impact analysis',
    `campaign_id` BIGINT COMMENT 'Reference to the retention campaign or churn management program under which this offer was generated.',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.content_package. Business justification: Retention offers commonly include upgraded or discounted content packages to prevent churn (e.g., free premium channels for 6 months). Required for churn prevention campaign execution, retention econo',
    `employee_id` BIGINT COMMENT 'Identifier of the customer service agent or retention specialist who presented the offer to the subscriber.',
    `privacy_consent_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_consent. Business justification: Retention offers require valid marketing consent under TCPA/GDPR. Telecom operators must verify opt-in status before presenting promotional retention offers. Links offer presentation to documented con',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Retention offers propose specific product/plan changes to prevent churn (e.g., upgrade to unlimited plan). This link enables save offer effectiveness analysis by product, churn prevention ROI measurem',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Retention offers often involve price plan changes or discounts. Linking to price_plan enables offer cost analysis, margin impact tracking, and ensuring retention offers are financially sustainable—ess',
    `retention_interaction_id` BIGINT COMMENT 'Foreign key linking to sales.retention_interaction. Business justification: Retention offers are presented DURING retention interactions (save calls). The existing retention_offer.interaction_id points to customer.interaction (cross-domain), but retention_interaction is the s',
    `retention_model_output_id` BIGINT COMMENT 'Foreign key linking to analytics.retention_model_output. Business justification: Retention offers are generated FROM churn model predictions. The model output (churn propensity score, recommended action) directly triggers offer creation and presentation—linking offer to model outp',
    `segment_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.segment_definition. Business justification: Retention offers are targeted to specific churn-risk segments (high-value at-risk, price-sensitive defectors, contract-end vulnerable). Telecom retention campaigns are always segment-driven—offer elig',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber at risk of churn who received this retention offer.',
    `trouble_ticket_id` BIGINT COMMENT 'Foreign key linking to assurance.trouble_ticket. Business justification: Retention offers are frequently triggered by service quality issues. Linking offers to the trouble tickets that prompted them enables analysis of offer effectiveness by issue type, measurement of serv',
    `acceptance_outcome` STRING COMMENT 'Final outcome of the retention offer indicating whether the subscriber accepted, rejected, or did not respond.. Valid values are `accepted|rejected|no_response|deferred`',
    `applied_timestamp` TIMESTAMP COMMENT 'Date and time when the accepted retention offer was applied to the subscriber account and became effective.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether managerial or supervisory approval was required before presenting this retention offer to the subscriber.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the retention offer was approved by the authorized manager or supervisor.',
    `arpu_impact_amount` DECIMAL(18,2) COMMENT 'Estimated impact on Average Revenue Per User if the retention offer is accepted, expressed as a positive or negative monetary amount.',
    `channel` STRING COMMENT 'Channel through which the retention offer was presented to the subscriber. [ENUM-REF-CANDIDATE: call_center|retail_store|web|mobile_app|email|sms|chat — 7 candidates stripped; promote to reference product]',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`retention_interaction` (
    `retention_interaction_id` BIGINT COMMENT 'Unique identifier for the retention interaction record. Primary key.',
    `case_id` BIGINT COMMENT 'Reference to the customer service case record associated with this retention interaction, if applicable.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this retention interaction.',
    `location_address_id` BIGINT COMMENT 'Foreign key linking to location.location_address. Business justification: Retention interactions reference service address for coverage alternative analysis, competitive offer validation, and technology upgrade eligibility. Agents need address-level serviceability data to p',
    `opportunity_id` BIGINT COMMENT 'Reference to the sales opportunity record in CRM if the retention interaction resulted in an upsell or cross-sell opportunity.',
    `employee_id` BIGINT COMMENT 'Reference to the customer service agent or sales representative who handled the retention interaction.',
    `retention_model_output_id` BIGINT COMMENT 'Foreign key linking to analytics.retention_model_output. Business justification: Retention interactions reference the churn score that triggered the save attempt. Agents see the model prediction during the call—linking interaction to model output enables save rate analysis by scor',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who is the subject of this retention interaction.',
    `trouble_ticket_id` BIGINT COMMENT 'Foreign key linking to assurance.trouble_ticket. Business justification: Retention teams investigate service quality issues during save attempts. Churn risk often correlates with unresolved trouble tickets. Linking retention interactions to the specific trouble tickets dis',
    `agent_team` STRING COMMENT 'Name or identifier of the team to which the handling agent belongs, used for performance tracking and workforce management.',
    `churn_reason_code` STRING COMMENT 'Standardized code representing the primary reason the customer is considering cancellation or downgrade.. Valid values are `price_sensitivity|service_quality|competitor_offer|relocation|financial_hardship|dissatisfaction|[ENUM-REF-CANDIDATE: price_sensitivity|service_quality|competitor_offer|relocation|financial_hardship|dissatisfaction|network_coverage|customer_service|billing_dispute|feature_gap|contract_end — promote to reference product]`',
    `churn_reason_description` STRING COMMENT 'Detailed free-text description of the customers stated reason for considering cancellation or service change.',
    `competitor_name` STRING COMMENT 'Name of the competing telecommunications provider mentioned by the customer as an alternative or threat, if applicable.',
    `competitor_offer_description` STRING COMMENT 'Description of the competing offer or promotion that the customer is considering, used for competitive analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this retention interaction record was first created in the system.',
    `customer_satisfaction_score` STRING COMMENT 'Customer satisfaction score collected at the end of the retention interaction, typically on a scale of 1-5 or 1-10.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the retention interaction was escalated to a supervisor or specialized retention team.',
    `escalation_reason` STRING COMMENT 'Reason why the retention interaction was escalated, providing context for management review and process improvement.',
    `follow_up_due_date` DATE COMMENT 'Target date by which follow-up action should be completed for this retention interaction.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether additional follow-up action is required to complete the retention interaction or fulfill commitments made to the customer.',
    `hold_time_seconds` STRING COMMENT 'Total time in seconds that the customer was placed on hold during the retention interaction.',
    `interaction_channel` STRING COMMENT 'Channel through which the retention interaction was conducted, indicating the customer touchpoint used for the save attempt. [ENUM-REF-CANDIDATE: inbound_call|outbound_call|web_chat|mobile_app|email|retail_store|ivr — 7 candidates stripped; promote to reference product]',
    `interaction_duration_seconds` STRING COMMENT 'Total duration of the retention interaction in seconds, from initiation to completion or abandonment.',
    `interaction_notes` STRING COMMENT 'Free-text notes captured by the agent during the retention interaction, documenting key discussion points, customer concerns, and commitments made.',
    `interaction_number` STRING COMMENT 'Business-facing unique identifier for the retention interaction, used for tracking and reference in customer service systems.. Valid values are `^RTN-[0-9]{10}$`',
    `interaction_status` STRING COMMENT 'Current lifecycle status of the retention interaction indicating its progress through the save workflow.. Valid values are `initiated|in_progress|completed|abandoned|escalated|follow_up_required`',
    `interaction_timestamp` TIMESTAMP COMMENT 'Date and time when the retention interaction was initiated, representing the principal business event time for this transaction.',
    `interaction_type` STRING COMMENT 'Classification of the retention interaction based on the trigger and nature of the customer engagement.. Valid values are `reactive_save|proactive_save|cancellation_request|downgrade_request|competitive_threat`',
    `mrr_delta_amount` DECIMAL(18,2) COMMENT 'Change in monthly recurring revenue resulting from the retention interaction, calculated as post-save MRR minus pre-interaction MRR.',
    `nps_score` STRING COMMENT 'Net Promoter Score collected from the customer during or after the retention interaction, measuring likelihood to recommend on a 0-10 scale.',
    `offer_acceptance_status` STRING COMMENT 'Status indicating whether the customer accepted, rejected, or is still considering the retention offer.. Valid values are `accepted|rejected|pending|expired`',
    `offer_acceptance_timestamp` TIMESTAMP COMMENT 'Date and time when the customer accepted the retention offer, if applicable.',
    `offer_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the retention offer value amount.. Valid values are `^[A-Z]{3}$`',
    `offer_description` STRING COMMENT 'Detailed description of the retention offer presented, including terms, conditions, and benefits communicated to the customer.',
    `offer_eligibility_criteria` STRING COMMENT 'Business rules and criteria that determined the customers eligibility for the presented retention offer.',
    `offer_presented_flag` BOOLEAN COMMENT 'Indicates whether a retention offer was presented to the customer during the interaction.',
    `offer_type` STRING COMMENT 'Type of retention offer presented to the customer, categorizing the incentive used to prevent churn.. Valid values are `loyalty_discount|plan_upgrade|device_upgrade|contract_extension|service_credit|waived_fee`',
    `offer_validity_end_date` DATE COMMENT 'Date when the retention offer expires and is no longer available for customer acceptance.',
    `offer_validity_start_date` DATE COMMENT 'Date when the retention offer becomes valid and can be accepted by the customer.',
    `offer_value_amount` DECIMAL(18,2) COMMENT 'Monetary value of the retention offer presented to the customer, representing the discount, credit, or incentive amount.',
    `post_save_contract_term_months` STRING COMMENT 'Duration in months of the new or extended contract term resulting from the successful retention interaction.',
    `post_save_mrr_amount` DECIMAL(18,2) COMMENT 'Monthly recurring revenue amount for the customer after the retention interaction, reflecting any plan changes or discounts applied.',
    `save_method` STRING COMMENT 'Method or approach used to achieve the save outcome, indicating how the retention was accomplished.. Valid values are `offer_accepted|issue_resolved|contract_modified|no_action|escalated`',
    `save_outcome` STRING COMMENT 'Final result of the retention interaction indicating whether the customer was successfully retained, lost to churn, or outcome is pending.. Valid values are `saved|lost|pending|partial_save`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this retention interaction record was last modified in the system.',
    CONSTRAINT pk_retention_interaction PRIMARY KEY(`retention_interaction_id`)
) COMMENT 'Transactional record of a customer retention or save interaction initiated when a subscriber requests cancellation or is identified as churn risk. Captures interaction channel (inbound call, outbound save, digital), churn reason code, save outcome (saved/lost), agent/rep ID, interaction duration, post-save contract term, and the targeted retention offer presented: offer type (loyalty discount, plan upgrade, device upgrade, contract extension), offered value, eligibility criteria, offer validity window, and acceptance/rejection outcome. SSOT for churn save activity and retention offer management in the sales domain.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`forecast` (
    `forecast_id` BIGINT COMMENT 'Unique identifier for the sales forecast record. Primary key.',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Sales forecasts drive financial budget planning cycles in FP&A process. Revenue forecasts feed directly into P&L budgets, headcount planning, and capex allocation. Essential link for integrated financ',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or executive who approved this forecast.',
    `forecast_employee_id` BIGINT COMMENT 'Identifier of the sales representative, team lead, or manager who owns and is accountable for this forecast.',
    `forecast_submitted_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who submitted this forecast for approval.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to people.org_unit. Business justification: Sales forecast aggregation and variance analysis in telecommunications requires organizational unit rollup. Forecasts cascade through org hierarchy (region→district→territory) for executive visibility',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Sales forecasts are built around specific KPIs (projected MRR, activation count, win rate). Each forecast measures attainment against a defined KPI—linking forecast to KPI definition enables consisten',
    `team_id` BIGINT COMMENT 'Identifier of the sales team or organizational unit this forecast represents.',
    `prior_forecast_id` BIGINT COMMENT 'Self-referencing FK on forecast (prior_forecast_id)',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the forecast was approved and locked for reporting.',
    `at_risk_opportunity_count` STRING COMMENT 'Number of opportunities flagged as at risk of slipping to future periods or being lost.',
    `average_deal_size` DECIMAL(18,2) COMMENT 'Average contract value per opportunity in the forecast pipeline, calculated as total_pipeline_value divided by opportunity count.',
    `average_sales_cycle_days` STRING COMMENT 'Average number of days from opportunity creation to close for deals in this forecast scope, used for velocity analysis.',
    `best_case_revenue_amount` DECIMAL(18,2) COMMENT 'Optimistic revenue projection if all high-probability opportunities close and favorable conditions occur.',
    `commit_revenue_amount` DECIMAL(18,2) COMMENT 'Revenue amount the forecast owner commits to delivering with high confidence, typically used for executive reporting and board commitments.',
    `confidence_level` STRING COMMENT 'Forecast owners confidence in achieving the projected numbers: high (90%+ confidence), medium (70-89%), low (<70%).. Valid values are `high|medium|low`',
    `conversion_rate_assumption` DECIMAL(18,2) COMMENT 'Assumed overall win rate percentage applied to pipeline opportunities for this forecast (e.g., 25.00 means 25% expected to close).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this forecast record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this forecast (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Target customer segment scope for this forecast: Business-to-Consumer (B2C), Business-to-Business (B2B), Mobile Virtual Network Operator (MVNO), enterprise, Small and Medium Business (SMB), or residential.. Valid values are `B2C|B2B|MVNO|enterprise|SMB|residential`',
    `forecast_name` STRING COMMENT 'Descriptive name for the forecast period or scenario (e.g., Q3 Enterprise Pipeline Review).',
    `forecast_number` STRING COMMENT 'Human-readable business identifier for the forecast snapshot (e.g., FY24-Q3-W12).',
    `forecast_status` STRING COMMENT 'Current lifecycle status of the forecast: draft (in progress), submitted (under review), approved (finalized), locked (immutable), archived (historical).. Valid values are `draft|submitted|approved|locked|archived`',
    `forecast_type` STRING COMMENT 'Classification of forecast by periodicity: weekly, monthly, quarterly, annual, or ad hoc.. Valid values are `weekly|monthly|quarterly|annual|ad_hoc`',
    `geographic_scope` STRING COMMENT 'Geographic territory or region this forecast covers (e.g., Northeast Region, California, National).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this forecast record was last updated, supporting audit trail and change tracking.',
    `new_pipeline_added_amount` DECIMAL(18,2) COMMENT 'Total value of new opportunities created during this forecast period, indicating lead generation effectiveness.',
    `notes` STRING COMMENT 'Free-text commentary from the forecast owner explaining assumptions, risks, opportunities, and key factors influencing the projection.',
    `period_end_date` DATE COMMENT 'End date of the forecast period being projected (e.g., last day of the quarter).',
    `period_start_date` DATE COMMENT 'Start date of the forecast period being projected (e.g., first day of the quarter).',
    `pipeline_coverage_ratio` DECIMAL(18,2) COMMENT 'Ratio of total pipeline value to quota target, indicating pipeline health (e.g., 3.0 means 3x coverage). Calculated as total_pipeline_value / quota_target_amount.',
    `product_category_scope` STRING COMMENT 'Product category or service type scope for this forecast (e.g., wireless, broadband, fiber, enterprise solutions, all products).',
    `projected_activations_count` STRING COMMENT 'Number of new subscriber activations or service connections forecasted to complete during the period.',
    `projected_attainment_percentage` DECIMAL(18,2) COMMENT 'Forecasted quota attainment percentage (projected_revenue_amount / quota_target_amount × 100), indicating expected performance against target.',
    `projected_mrr_amount` DECIMAL(18,2) COMMENT 'Total forecasted Monthly Recurring Revenue (MRR) expected from new activations and upsells during the forecast period.',
    `projected_revenue_amount` DECIMAL(18,2) COMMENT 'Total forecasted revenue expected to close during the forecast period, calculated as sum of weighted pipeline opportunities.',
    `quota_target_amount` DECIMAL(18,2) COMMENT 'Revenue quota or target assigned to the forecast owner for this period, used as baseline for attainment projections.',
    `slippage_amount` DECIMAL(18,2) COMMENT 'Total value of opportunities that slipped from previous forecast periods into this period, indicating pipeline health and forecasting accuracy.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'Exact date and time when this forecast snapshot was captured, enabling historical trend analysis and point-in-time comparisons.',
    `stage_commit_count` STRING COMMENT 'Number of opportunities in commit/verbal agreement stage at snapshot time, representing high-confidence near-term closes.',
    `stage_negotiation_count` STRING COMMENT 'Number of opportunities in negotiation/contracting stage at snapshot time.',
    `stage_proposal_count` STRING COMMENT 'Number of opportunities in proposal/quote stage at snapshot time.',
    `stage_prospect_count` STRING COMMENT 'Number of opportunities in prospect/qualification stage at snapshot time.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the forecast was submitted for management review and approval.',
    `total_pipeline_value` DECIMAL(18,2) COMMENT 'Total unweighted value of all opportunities in the pipeline for this forecast period, regardless of probability.',
    `upside_opportunity_count` STRING COMMENT 'Number of opportunities identified as upside potential (not yet in commit stage but could accelerate).',
    `variance_to_previous_forecast` DECIMAL(18,2) COMMENT 'Difference in projected revenue between this forecast and the previous periods forecast for the same time window, enabling trend analysis.',
    `weighted_pipeline_value` DECIMAL(18,2) COMMENT 'Total pipeline value adjusted by probability of close (sum of opportunity value × probability percentage for all opportunities in scope).',
    `worst_case_revenue_amount` DECIMAL(18,2) COMMENT 'Conservative revenue projection accounting for potential slippage, delays, and lost opportunities.',
    CONSTRAINT pk_forecast PRIMARY KEY(`forecast_id`)
) COMMENT 'Periodic sales pipeline forecast and snapshot record capturing projected revenue, expected activations, pipeline coverage ratio, weighted pipeline value, and stage-by-stage conversion assumptions for a defined forecast period (weekly/monthly/quarterly). Supports sales leadership pipeline reviews, quota attainment projections, and variance analysis against targets. Captures forecast owner (rep/team/channel), segment scope (B2C/B2B/MVNO), confidence level, and snapshot timestamp for historical trend analysis.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`channel_offering` (
    `channel_offering_id` BIGINT COMMENT 'Unique identifier for this channel-offering assignment record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the user who last modified this channel-offering assignment configuration.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to the commercial offering being made available through this channel',
    `channel_id` BIGINT COMMENT 'Foreign key linking to the sales channel through which this offering is distributed',
    `channel_offering_status` STRING COMMENT 'Current operational status of this channel-offering assignment. Values: active (currently selling), pending_launch (configured but not yet live), suspended (temporarily unavailable), discontinued (permanently removed).',
    `channel_priority` STRING COMMENT 'Numeric priority ranking (1=highest) indicating the strategic importance of this offering in this channels portfolio. Used for sales team focus, promotional planning, and inventory allocation decisions.',
    `commission_override_rate` DECIMAL(18,2) COMMENT 'Commission rate override specific to this offering-channel combination, expressed as a decimal (e.g., 0.0850 for 8.5%). Overrides the channels default commission_structure_code when set. Nullable if default commission applies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel-offering assignment was created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this offering is no longer available for new sales through this specific channel. Nullable for ongoing availability. Supports channel-specific sunset strategies.',
    `effective_start_date` DATE COMMENT 'Date when this offering becomes available for sale through this specific channel. May differ from the offerings global effective_start_date to support phased channel rollouts.',
    `inventory_allocation` STRING COMMENT 'Number of units or subscription slots allocated to this channel for this offering. Relevant for device-included offerings or capacity-constrained services. Nullable for unlimited digital offerings.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this channel-offering assignment record.',
    `performance_tier` STRING COMMENT 'Performance classification tier for this offering within this specific channel based on sales velocity, margin contribution, and customer satisfaction metrics. Values: platinum, gold, silver, bronze, underperforming.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether sales staff in this channel must complete product-specific training before selling this offering. Used for complex enterprise offerings or regulated products.',
    CONSTRAINT pk_channel_offering PRIMARY KEY(`channel_offering_id`)
) COMMENT 'This association product represents the commercial availability contract between offering and channel. It captures the go-to-market strategy execution by defining which offerings are sold through which channels, with channel-specific pricing overrides, inventory allocation, launch timing, and performance tracking. Each record links one offering to one channel with attributes that exist only in the context of this channel-offering relationship.. Existence Justification: In telecommunications go-to-market operations, offerings are distributed through multiple sales channels simultaneously (retail stores, online, telesales, dealers, MVNO partners), and each channel carries a portfolio of multiple offerings. The business actively manages these channel-offering assignments as operational entities with channel-specific attributes including launch timing, commission overrides, inventory allocation, training requirements, and performance tracking that cannot be stored on either the offering or channel entity alone.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` (
    `channel_promotion_eligibility_id` BIGINT COMMENT 'Unique identifier for this channel-promotion eligibility configuration record. Primary key.',
    `employee_id` BIGINT COMMENT 'User ID of the marketing operations or sales operations employee who configured this channel-promotion eligibility record. Used for audit trail and accountability.',
    `last_modified_by_employee_id` BIGINT COMMENT 'User ID of the employee who last modified this eligibility configuration. Used for change tracking and audit trail.',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to the promotion being made available through this channel',
    `channel_id` BIGINT COMMENT 'Foreign key linking to the sales channel where this promotion is eligible',
    `channel_effective_end_date` DATE COMMENT 'Date when this promotion expires and is no longer available for redemption in this specific channel. May differ from the promotions global end_date to support early termination or extended availability in specific channels.',
    `channel_effective_start_date` DATE COMMENT 'Date when this promotion becomes available for redemption in this specific channel. May differ from the promotions global start_date to support phased rollouts or channel-specific launch timing.',
    `channel_eligibility` STRING COMMENT 'Comma-separated list of sales channels where this promotion can be applied (e.g., web, mobile_app, retail_store, telesales, dealer, all_channels). Used to control distribution and prevent unauthorized channel usage. [Moved from promotion: The channel_eligibility attribute in promotion is a comma-separated list attempting to denormalize the many-to-many relationship. With the proper association table, this attribute becomes redundant - channel eligibility is now represented by the existence of records in channel_promotion_eligibility. This eliminates data duplication and allows proper tracking of channel-specific configuration (dates, limits, terms) that cannot be captured in a simple comma-separated list.]',
    `channel_inventory_limit` STRING COMMENT 'Maximum number of times this promotion can be redeemed through this specific channel. Null indicates no channel-specific limit (subject to promotions global redemption_limit_total). Used to allocate promotion inventory across channels and prevent over-redemption in any single channel.',
    `channel_priority` STRING COMMENT 'Numeric priority ranking for this promotion within this specific channel (1=highest). Used when multiple promotions are available and stacking rules or inventory limits require prioritization. This is channel-specific and may differ from the promotions priority in other channels.',
    `channel_redemption_count` STRING COMMENT 'Current count of how many times this promotion has been redeemed through this specific channel. Incremented with each redemption transaction. Used to enforce channel_inventory_limit and track channel-level promotion performance.',
    `channel_specific_terms` STRING COMMENT 'Additional terms, conditions, or business rules that apply to this promotion when redeemed through this specific channel. For example, Requires in-store device trade-in for retail channels, or Online exclusive - no phone orders for digital channels. Supplements the promotions global terms_and_conditions.',
    `configured_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel-promotion eligibility record was first created. Used for audit trail and historical analysis of promotion rollout timing.',
    `eligibility_status` STRING COMMENT 'Current operational status of this promotions eligibility in this channel: active (available for redemption), suspended (temporarily disabled by ops team), expired (past channel_effective_end_date), pending (configured but not yet effective). Allows channel-specific promotion control independent of global promotion status.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this eligibility record was last updated. Used for audit trail and change management.',
    CONSTRAINT pk_channel_promotion_eligibility PRIMARY KEY(`channel_promotion_eligibility_id`)
) COMMENT 'This association product represents the configuration and management of promotion availability across sales channels. It captures which promotions are eligible for use in which channels, with channel-specific business rules, inventory limits, performance tracking, and effective date ranges. Each record links one promotion to one channel with attributes that exist only in the context of this channel-specific promotion configuration. This is an actively managed operational entity used by marketing operations and sales operations teams to control promotion distribution, track channel-level redemption performance, and enforce channel-specific terms.. Existence Justification: In telecommunications sales operations, promotions are actively configured for availability across multiple sales channels, and each channel offers multiple promotions simultaneously. Marketing operations and sales operations teams manage this as a distinct business process: they configure which promotions are available in which channels, set channel-specific inventory allocations, define channel-specific effective dates (for phased rollouts), establish channel-specific terms, and track redemption performance by channel. This is not a reference lookup or analytical correlation - it is an operational configuration entity that humans create, update, and monitor.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`account_team_assignment` (
    `account_team_assignment_id` BIGINT COMMENT 'Unique identifier for this account team assignment record. Primary key.',
    `b2b_account_plan_id` BIGINT COMMENT 'Foreign key linking to the B2B account plan that this team assignment supports',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee assigned to this account plan team',
    `account_team_members` STRING COMMENT 'Comma-separated list or JSON array of team member IDs or names who are part of the extended account team (sales engineers, solution architects, customer success managers). [Moved from b2b_account_plan: This comma-separated list or JSON array in b2b_account_plan is a denormalized representation of the many-to-many relationship. The proper model is individual assignment records with role, dates, and coverage percentage. This attribute should be removed and replaced by queries against the account_team_assignment association.]',
    `assignment_end_date` DATE COMMENT 'The date when this employees assignment to this account plan team ended or is planned to end. Null for active assignments. Used for tracking team changes and historical coverage.',
    `assignment_start_date` DATE COMMENT 'The date when this employee began their assignment to this account plan team. Used for tracking team tenure and transition history.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this team assignment. Active = currently engaged, Planned = future assignment, Completed = assignment ended, Suspended = temporarily paused.',
    `coverage_percentage` DECIMAL(18,2) COMMENT 'The percentage of this employees time allocated to this account plan. Used for capacity planning and workload balancing. Sum across all account plans for an employee should not exceed 100%.',
    `is_primary_owner` BOOLEAN COMMENT 'Indicates whether this team member is the primary owner/lead for this account plan. Typically true for the Account Executive role. Used for routing, escalation, and accountability.',
    `responsibility_scope` STRING COMMENT 'Detailed description of this team members specific responsibilities within the account plan. May include geographic coverage, product line focus, business unit alignment, or specific initiative ownership.',
    `team_role` STRING COMMENT 'The specific role this employee plays on the account team. Defines responsibilities and engagement model. Examples: Account Executive (owns relationship), Solutions Architect (designs technical solutions), Customer Success Manager (post-sale adoption), Technical Specialist (product expertise).',
    CONSTRAINT pk_account_team_assignment PRIMARY KEY(`account_team_assignment_id`)
) COMMENT 'This association product represents the assignment of employees to B2B account plan teams in enterprise telecommunications sales. It captures the multi-person team structure required for complex enterprise account management, where each account plan requires multiple specialized roles (account executive, solutions architect, customer success manager, technical specialist) and each employee participates in multiple account plans simultaneously. Each record links one B2B account plan to one employee with role, assignment period, responsibility scope, and coverage allocation.. Existence Justification: In enterprise telecommunications sales, B2B account plans require multi-person teams with specialized roles (account executive, solutions architect, customer success manager, technical specialists). Each account plan has multiple team members assigned simultaneously, and each employee participates in multiple account plans concurrently. The business actively manages these assignments with role definitions, time allocation percentages, and assignment periods.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Primary key for campaign',
    `parent_campaign_id` BIGINT COMMENT 'Self-referencing FK on campaign (parent_campaign_id)',
    `actual_response_rate` DECIMAL(18,2) COMMENT 'Measured percentage of target audience that responded.',
    `actual_spend` DECIMAL(18,2) COMMENT 'Total amount actually spent on the campaign to date.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved monetary budget allocated for the campaign.',
    `campaign_code` STRING COMMENT 'External business code used to reference the campaign in marketing systems.',
    `campaign_name` STRING COMMENT 'Human‑readable name of the campaign.',
    `campaign_status` STRING COMMENT 'Current lifecycle state of the campaign.',
    `campaign_type` STRING COMMENT 'Category of marketing objective the campaign addresses.',
    `channel` STRING COMMENT 'Primary delivery channel used for the campaign.',
    `cost_per_acquisition` DECIMAL(18,2) COMMENT 'Average cost incurred to acquire a single customer through the campaign.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign record was first created in the system.',
    `campaign_description` STRING COMMENT 'Free‑form narrative describing the campaign details and creative theme.',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`wholesale_rate_card` (
    `wholesale_rate_card_id` BIGINT COMMENT 'Primary key for wholesale_rate_card',
    `superseded_wholesale_rate_card_id` BIGINT COMMENT 'Self-referencing FK on wholesale_rate_card (superseded_wholesale_rate_card_id)',
    `base_rate` DECIMAL(18,2) COMMENT 'Core monetary amount applied per unit before discounts or surcharges.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rate card record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary values.',
    `wholesale_rate_card_description` STRING COMMENT 'Free‑form text describing the purpose, scope, and any special conditions of the rate card.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the base rate for this tier.',
    `effective_from` DATE COMMENT 'Date when the rate card becomes valid for billing.',
    `effective_until` DATE COMMENT 'Date when the rate card expires; null for open‑ended contracts.',
    `rate_card_code` STRING COMMENT 'Business identifier code assigned to the rate card (e.g., RC‑2023‑US‑VOICE).',
    `rate_card_name` STRING COMMENT 'Human‑readable name of the rate card used for reporting and UI display.',
    `rate_card_type` STRING COMMENT 'Category of services covered by the rate card.',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory review and approval for the rate card.',
    `wholesale_rate_card_status` STRING COMMENT 'Current lifecycle status of the rate card.',
    `surcharge_flag` BOOLEAN COMMENT 'Indicates whether a surcharge is applied on top of the base rate.',
    `tier_level` STRING COMMENT 'Pricing tier identifier (e.g., Tier 1, Tier 2) indicating volume‑based pricing bands.',
    `unit_of_measure` STRING COMMENT 'Measurement unit to which the base rate applies.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rate card record.',
    `volume_threshold_max` STRING COMMENT 'Maximum usage quantity for which this tier rate is valid.',
    `volume_threshold_min` STRING COMMENT 'Minimum usage quantity required for this tier to apply.',
    CONSTRAINT pk_wholesale_rate_card PRIMARY KEY(`wholesale_rate_card_id`)
) COMMENT 'Master reference table for wholesale_rate_card. Referenced by wholesale_rate_card_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`sales`.`contract_template` (
    `contract_template_id` BIGINT COMMENT 'Primary key for contract_template',
    `base_contract_template_id` BIGINT COMMENT 'Self-referencing FK on contract_template (base_contract_template_id)',
    `agreement_type` STRING COMMENT 'Classification of the agreement that the template represents.',
    `approval_required_flag` BOOLEAN COMMENT 'Specifies if contracts using this template require managerial approval.',
    `approval_workflow` STRING COMMENT 'Identifier of the approval workflow process for this template.',
    `auto_renew_flag` BOOLEAN COMMENT 'Indicates if contracts using this template auto‑renew by default.',
    `compliance_requirements` STRING COMMENT 'Textual description of regulatory or compliance constraints tied to the template.',
    `confidentiality_level` STRING COMMENT 'Data classification level assigned to the contract template.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract template record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code used for monetary fields in contracts based on this template.',
    `default_term_months` STRING COMMENT 'Standard contract duration in months when this template is applied.',
    `contract_template_description` STRING COMMENT 'Detailed description of the purpose and scope of the contract template.',
    `discount_allowed_flag` BOOLEAN COMMENT 'Indicates whether discounts can be applied to contracts based on this template.',
    `effective_end_date` DATE COMMENT 'Date when the contract template expires or is retired (nullable for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the contract template becomes effective for new contracts.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the contract template contains confidential information.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this template is the default for its agreement type.',
    `jurisdiction` STRING COMMENT 'Three‑letter ISO country code representing the primary legal jurisdiction for the contract.',
    `legal_review_date` DATE COMMENT 'Date of the most recent legal review of the template.',
    `max_discount_percent` DECIMAL(18,2) COMMENT 'Maximum discount percentage allowed on contracts using this template.',
    `regulatory_approval_required_flag` BOOLEAN COMMENT 'Indicates if regulatory authority approval is needed for contracts using this template.',
    `renewal_policy` STRING COMMENT 'Policy governing automatic renewal of contracts derived from this template.',
    `contract_template_status` STRING COMMENT 'Current lifecycle status of the contract template.',
    `template_category` STRING COMMENT 'High‑level category describing the purpose of the contract template.',
    `template_code` STRING COMMENT 'Business identifier code used to reference the contract template externally.',
    `template_file_path` STRING COMMENT 'File system or storage path where the template document is stored.',
    `template_language` STRING COMMENT 'Language of the contract template content.',
    `template_name` STRING COMMENT 'Human‑readable name of the contract template.',
    `template_owner_department` STRING COMMENT 'Internal department responsible for maintaining the template.',
    `template_owner_email` STRING COMMENT 'Contact email of the department or individual owning the template.',
    `termination_notice_days` STRING COMMENT 'Number of days notice required to terminate a contract based on this template.',
    `updated_by` STRING COMMENT 'Identifier of the user or system that last updated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contract template record.',
    `version_number` STRING COMMENT 'Sequential version number of the contract template.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the record.',
    CONSTRAINT pk_contract_template PRIMARY KEY(`contract_template_id`)
) COMMENT 'Master reference table for contract_template. Referenced by template_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `telecommunication_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `telecommunication_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_b2b_account_plan_id` FOREIGN KEY (`b2b_account_plan_id`) REFERENCES `telecommunication_ecm`.`sales`.`b2b_account_plan`(`b2b_account_plan_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `telecommunication_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `telecommunication_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `telecommunication_ecm`.`sales`.`promotion`(`promotion_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_parent_line_quote_line_id` FOREIGN KEY (`parent_line_quote_line_id`) REFERENCES `telecommunication_ecm`.`sales`.`quote_line`(`quote_line_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `telecommunication_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `telecommunication_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `telecommunication_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ADD CONSTRAINT `fk_sales_sales_contract_contract_template_id` FOREIGN KEY (`contract_template_id`) REFERENCES `telecommunication_ecm`.`sales`.`contract_template`(`contract_template_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ADD CONSTRAINT `fk_sales_contract_amendment_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `telecommunication_ecm`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ADD CONSTRAINT `fk_sales_contract_amendment_superseded_by_amendment_contract_amendment_id` FOREIGN KEY (`superseded_by_amendment_contract_amendment_id`) REFERENCES `telecommunication_ecm`.`sales`.`contract_amendment`(`contract_amendment_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ADD CONSTRAINT `fk_sales_channel_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `telecommunication_ecm`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ADD CONSTRAINT `fk_sales_commission_plan_superseded_by_plan_commission_plan_id` FOREIGN KEY (`superseded_by_plan_commission_plan_id`) REFERENCES `telecommunication_ecm`.`sales`.`commission_plan`(`commission_plan_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ADD CONSTRAINT `fk_sales_commission_txn_commission_plan_id` FOREIGN KEY (`commission_plan_id`) REFERENCES `telecommunication_ecm`.`sales`.`commission_plan`(`commission_plan_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ADD CONSTRAINT `fk_sales_commission_txn_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `telecommunication_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ADD CONSTRAINT `fk_sales_commission_txn_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `telecommunication_ecm`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `telecommunication_ecm`.`sales`.`channel`(`channel_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ADD CONSTRAINT `fk_sales_target_commission_plan_id` FOREIGN KEY (`commission_plan_id`) REFERENCES `telecommunication_ecm`.`sales`.`commission_plan`(`commission_plan_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `telecommunication_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `telecommunication_ecm`.`sales`.`lead`(`lead_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ADD CONSTRAINT `fk_sales_activity_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `telecommunication_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ADD CONSTRAINT `fk_sales_promotion_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `telecommunication_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ADD CONSTRAINT `fk_sales_promotion_redemption_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `telecommunication_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ADD CONSTRAINT `fk_sales_promotion_redemption_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `telecommunication_ecm`.`sales`.`promotion`(`promotion_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ADD CONSTRAINT `fk_sales_promotion_redemption_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `telecommunication_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ADD CONSTRAINT `fk_sales_promotion_redemption_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `telecommunication_ecm`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ADD CONSTRAINT `fk_sales_mvno_agreement_sales_contract_id` FOREIGN KEY (`sales_contract_id`) REFERENCES `telecommunication_ecm`.`sales`.`sales_contract`(`sales_contract_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ADD CONSTRAINT `fk_sales_mvno_agreement_wholesale_rate_card_id` FOREIGN KEY (`wholesale_rate_card_id`) REFERENCES `telecommunication_ecm`.`sales`.`wholesale_rate_card`(`wholesale_rate_card_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `telecommunication_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ADD CONSTRAINT `fk_sales_retention_offer_retention_interaction_id` FOREIGN KEY (`retention_interaction_id`) REFERENCES `telecommunication_ecm`.`sales`.`retention_interaction`(`retention_interaction_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ADD CONSTRAINT `fk_sales_retention_interaction_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `telecommunication_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_prior_forecast_id` FOREIGN KEY (`prior_forecast_id`) REFERENCES `telecommunication_ecm`.`sales`.`forecast`(`forecast_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_offering` ADD CONSTRAINT `fk_sales_channel_offering_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `telecommunication_ecm`.`sales`.`channel`(`channel_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ADD CONSTRAINT `fk_sales_channel_promotion_eligibility_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `telecommunication_ecm`.`sales`.`promotion`(`promotion_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ADD CONSTRAINT `fk_sales_channel_promotion_eligibility_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `telecommunication_ecm`.`sales`.`channel`(`channel_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`account_team_assignment` ADD CONSTRAINT `fk_sales_account_team_assignment_b2b_account_plan_id` FOREIGN KEY (`b2b_account_plan_id`) REFERENCES `telecommunication_ecm`.`sales`.`b2b_account_plan`(`b2b_account_plan_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_parent_campaign_id` FOREIGN KEY (`parent_campaign_id`) REFERENCES `telecommunication_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`wholesale_rate_card` ADD CONSTRAINT `fk_sales_wholesale_rate_card_superseded_wholesale_rate_card_id` FOREIGN KEY (`superseded_wholesale_rate_card_id`) REFERENCES `telecommunication_ecm`.`sales`.`wholesale_rate_card`(`wholesale_rate_card_id`);
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_template` ADD CONSTRAINT `fk_sales_contract_template_base_contract_template_id` FOREIGN KEY (`base_contract_template_id`) REFERENCES `telecommunication_ecm`.`sales`.`contract_template`(`contract_template_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `telecommunication_ecm`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` SET TAGS ('dbx_subdomain' = 'lead_generation');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Converted Opportunity Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Converted Account Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Sales Representative Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Interest Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Referral Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `privacy_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`lead` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` SET TAGS ('dbx_subdomain' = 'opportunity_development');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Identifier');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `b2b_account_plan_id` SET TAGS ('dbx_business_glossary_term' = 'B2B Account Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Owner Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `enterprise_site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `network_capacity_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `pop_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Pop Facility Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Ran Cell Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Team Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `sdwan_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Sdwan Policy Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `slice_id` SET TAGS ('dbx_business_glossary_term' = 'Network Slice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
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
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Identifier (ID)');
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
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `sales_stage` SET TAGS ('dbx_business_glossary_term' = 'Sales Stage');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `strategic_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Strategic Account Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `whitespace_analysis` SET TAGS ('dbx_business_glossary_term' = 'Whitespace Analysis');
ALTER TABLE `telecommunication_ecm`.`sales`.`opportunity` ALTER COLUMN `win_loss_reason` SET TAGS ('dbx_business_glossary_term' = 'Win or Loss Reason');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` SET TAGS ('dbx_subdomain' = 'opportunity_development');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Identifier');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `dealer_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `enterprise_site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`sales`.`quote` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
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
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` SET TAGS ('dbx_subdomain' = 'opportunity_development');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Address Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `device_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Device Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Cable Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `parent_line_quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Line Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Identifier (ID)');
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
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `promotional_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `promotional_description` SET TAGS ('dbx_business_glossary_term' = 'Promotional Description');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `telecommunication_ecm`.`sales`.`quote_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` SET TAGS ('dbx_subdomain' = 'contract_execution');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Signatory Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `enterprise_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Cable Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `spectrum_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Spectrum Allocation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Template Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `contract_template_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Template ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `tertiary_sales_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `tertiary_sales_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `tertiary_sales_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|enterprise|platinum|gold|silver');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `tcv_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value (TCV) Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term (Months)');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `telecommunication_ecm`.`sales`.`sales_contract` ALTER COLUMN `uptime_sla_percentage` SET TAGS ('dbx_business_glossary_term' = 'Uptime Service Level Agreement (SLA) Percentage');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` SET TAGS ('dbx_subdomain' = 'contract_execution');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `contract_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `superseded_by_amendment_contract_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Amendment Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `amended_end_date` SET TAGS ('dbx_business_glossary_term' = 'Amended Contract End Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `amended_term_months` SET TAGS ('dbx_business_glossary_term' = 'Amended Contract Term in Months');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `amendment_document_url` SET TAGS ('dbx_business_glossary_term' = 'Amendment Document Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Approval Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Level');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `approval_level` SET TAGS ('dbx_value_regex' = 'sales_manager|director|vp_sales|cfo|ceo|board');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `company_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Company Signatory Name');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `company_signatory_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `company_signatory_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `company_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Company Signatory Title');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `customer_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Signatory Name');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `customer_signatory_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `customer_signatory_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `customer_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Customer Signatory Title');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `customer_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Signature Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `customer_signature_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Signature Required Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Execution Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `legal_review_completed` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completed Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `legal_review_required` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `mrr_delta_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Recurring Revenue (MRR) Delta Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Amendment Notes');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `original_end_date` SET TAGS ('dbx_business_glossary_term' = 'Original Contract End Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `original_term_months` SET TAGS ('dbx_business_glossary_term' = 'Original Contract Term in Months');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `pricing_change_description` SET TAGS ('dbx_business_glossary_term' = 'Pricing Change Description');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason Description');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Request Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `services_added` SET TAGS ('dbx_business_glossary_term' = 'Services Added');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `services_removed` SET TAGS ('dbx_business_glossary_term' = 'Services Removed');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `sla_change_description` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Change Description');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `tcv_delta_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value (TCV) Delta Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_amendment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` SET TAGS ('dbx_subdomain' = 'channel_distribution');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Identifier');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `coverage_area_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Manager Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization Identifier (ID)');
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
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `commission_structure_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Structure Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `commission_structure_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,10}$');
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
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `segment_scope` SET TAGS ('dbx_business_glossary_term' = 'Segment Scope');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel` ALTER COLUMN `segment_scope` SET TAGS ('dbx_value_regex' = 'B2C|B2B|MVNO|B2C_B2B|ALL');
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
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` SET TAGS ('dbx_subdomain' = 'incentive_management');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `commission_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Kpi Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `superseded_by_plan_commission_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Commission Plan Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_plan` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Target Product Category Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` SET TAGS ('dbx_subdomain' = 'incentive_management');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `commission_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Txn Identifier');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `commission_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `accelerator_applied` SET TAGS ('dbx_business_glossary_term' = 'Accelerator Applied Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Adjustment Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected|auto_approved');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `clawback_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Clawback Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `clawback_reason` SET TAGS ('dbx_business_glossary_term' = 'Clawback Reason');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'consumer|small_business|mid_market|enterprise|government|wholesale');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `earned_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Earned Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `net_payable_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payable Commission Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Commission Transaction Notes');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `payment_period` SET TAGS ('dbx_business_glossary_term' = 'Payment Period');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `payment_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `payout_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Payout Batch ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `payout_date` SET TAGS ('dbx_business_glossary_term' = 'Commission Payout Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `quota_attainment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quota Attainment Percentage');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `sale_amount` SET TAGS ('dbx_business_glossary_term' = 'Sale Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'postpaid|prepaid|hybrid|enterprise|wholesale|mvno');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|sap_s4hana|commission_engine|manual_entry');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `split_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Split Percentage');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Commission Transaction Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Commission Transaction Number');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `transaction_number` SET TAGS ('dbx_value_regex' = '^COMM-[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Commission Transaction Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|paid|cancelled|disputed');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Commission Transaction Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'earned|adjusted|clawback|bonus|override|split');
ALTER TABLE `telecommunication_ecm`.`sales`.`commission_txn` ALTER COLUMN `triggering_event` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` SET TAGS ('dbx_subdomain' = 'lead_generation');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Target Identifier');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `commission_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Incentive Plan ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `dealer_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Team ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `target_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `target_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `target_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `target_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `target_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `target_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `target_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `target_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`target` ALTER COLUMN `target_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` SET TAGS ('dbx_subdomain' = 'incentive_management');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Identifier');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `location_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `location_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `location_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `activity_date` SET TAGS ('dbx_business_glossary_term' = 'Activity Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|no_show');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'call|email|meeting|demo|site_visit|proposal');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `attendee_count` SET TAGS ('dbx_business_glossary_term' = 'Attendee Count');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `competitor_mentioned` SET TAGS ('dbx_business_glossary_term' = 'Competitor Mentioned');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `contact_method` SET TAGS ('dbx_business_glossary_term' = 'Contact Method');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `contact_method` SET TAGS ('dbx_value_regex' = 'phone|email|in_person|video_conference|web_chat|social_media');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'consumer|soho|smb|mid_market|enterprise|wholesale');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `deal_size_category` SET TAGS ('dbx_business_glossary_term' = 'Deal Size Category');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `deal_size_category` SET TAGS ('dbx_value_regex' = 'small|medium|large|strategic');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activity End Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `estimated_revenue` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `estimated_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `external_activity_reference` SET TAGS ('dbx_business_glossary_term' = 'External Activity ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Is Deleted');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Activity Location');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `next_action` SET TAGS ('dbx_business_glossary_term' = 'Next Action');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `next_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Action Due Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `objection_raised` SET TAGS ('dbx_business_glossary_term' = 'Objection Raised');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Activity Outcome');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'successful|unsuccessful|follow_up_required|qualified|disqualified|closed_won');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Activity Priority');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `product_interest` SET TAGS ('dbx_business_glossary_term' = 'Product Interest');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activity Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Activity Subject');
ALTER TABLE `telecommunication_ecm`.`sales`.`activity` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` SET TAGS ('dbx_subdomain' = 'incentive_management');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `promotion_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `promotion_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `promotion_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Target Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Target Product Category Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `eligible_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Eligible Customer Segment');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion` ALTER COLUMN `eligible_customer_segment` SET TAGS ('dbx_value_regex' = 'b2c_consumer|b2b_smb|b2b_enterprise|mvno_wholesale|all_segments');
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
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` SET TAGS ('dbx_subdomain' = 'incentive_management');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `promotion_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Redemption ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `dealer_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `tertiary_promotion_approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `tertiary_promotion_approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `tertiary_promotion_approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending_approval|rejected|not_required|auto_approved');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `benefit_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Benefit Duration Months');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'consumer|small_business|enterprise|government|wholesale|mvno');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `max_redemptions_allowed` SET TAGS ('dbx_business_glossary_term' = 'Maximum Redemptions Allowed');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Redemption Notes');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `promotion_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Effective Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `promotion_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Expiry Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `recurring_benefit_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurring Benefit Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `redemption_channel` SET TAGS ('dbx_business_glossary_term' = 'Redemption Channel');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `redemption_channel` SET TAGS ('dbx_value_regex' = 'retail_store|online_portal|mobile_app|call_center|dealer_portal|partner_channel');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `redemption_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Redemption Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `redemption_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Redemption Count');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `redemption_date` SET TAGS ('dbx_business_glossary_term' = 'Redemption Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `redemption_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `redemption_limit_type` SET TAGS ('dbx_value_regex' = 'per_customer|per_account|per_order|per_campaign|unlimited');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversal Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|amdocs_billing|oracle_osm|netcracker_bss|sap_erp|partner_portal');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `validation_message` SET TAGS ('dbx_business_glossary_term' = 'Validation Message');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|pending_validation|validation_failed|expired|revoked|fraud_suspected');
ALTER TABLE `telecommunication_ecm`.`sales`.`promotion_redemption` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` SET TAGS ('dbx_subdomain' = 'incentive_management');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `b2b_account_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Business-to-Business (B2B) Account Plan ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `corporate_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Hierarchy Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Target Content Package Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `tertiary_b2b_approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `tertiary_b2b_approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `tertiary_b2b_approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `account_health_status` SET TAGS ('dbx_business_glossary_term' = 'Account Health Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `account_health_status` SET TAGS ('dbx_value_regex' = 'healthy|at_risk|critical|churned');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `account_health_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `account_health_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `account_tier` SET TAGS ('dbx_business_glossary_term' = 'Account Tier');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `account_tier` SET TAGS ('dbx_value_regex' = 'tier_1_strategic|tier_2_major|tier_3_standard');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `baseline_arr` SET TAGS ('dbx_business_glossary_term' = 'Baseline Annual Recurring Revenue (ARR)');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `baseline_arr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `baseline_mrr` SET TAGS ('dbx_business_glossary_term' = 'Baseline Monthly Recurring Revenue (MRR)');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `baseline_mrr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `churn_probability_score` SET TAGS ('dbx_business_glossary_term' = 'Churn Probability Score');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `churn_probability_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `competitive_threats` SET TAGS ('dbx_business_glossary_term' = 'Competitive Threats');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `competitive_threats` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `contract_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Value');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `cross_sell_opportunities` SET TAGS ('dbx_business_glossary_term' = 'Cross-Sell Opportunities');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `cross_sell_opportunities` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `customer_lifetime_value` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV)');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `customer_lifetime_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `customer_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'enterprise|mid_market|government|wholesale_mvno');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `executive_sponsor_name` SET TAGS ('dbx_business_glossary_term' = 'Executive Sponsor Name');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `executive_sponsor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `executive_sponsor_title` SET TAGS ('dbx_business_glossary_term' = 'Executive Sponsor Title');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `industry_vertical` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `key_stakeholder_map` SET TAGS ('dbx_business_glossary_term' = 'Key Stakeholder Map');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `key_stakeholder_map` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `plan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan End Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Account Plan Name');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `plan_notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `plan_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `plan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Start Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|approved|archived|suspended');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'new_customer|existing_customer_growth|retention|renewal|strategic_partnership');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `primary_competitor` SET TAGS ('dbx_business_glossary_term' = 'Primary Competitor');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `primary_competitor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `renewal_risk_factors` SET TAGS ('dbx_business_glossary_term' = 'Renewal Risk Factors');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `renewal_risk_factors` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `renewal_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Renewal Risk Level');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `renewal_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `renewal_risk_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `service_portfolio_summary` SET TAGS ('dbx_business_glossary_term' = 'Service Portfolio Summary');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `strategic_initiatives` SET TAGS ('dbx_business_glossary_term' = 'Strategic Initiatives');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `strategic_initiatives` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `target_arr_growth` SET TAGS ('dbx_business_glossary_term' = 'Target Annual Recurring Revenue (ARR) Growth');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `target_arr_growth` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `target_mrr_growth` SET TAGS ('dbx_business_glossary_term' = 'Target Monthly Recurring Revenue (MRR) Growth');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `target_mrr_growth` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `upsell_opportunities` SET TAGS ('dbx_business_glossary_term' = 'Upsell Opportunities');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `upsell_opportunities` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `whitespace_analysis` SET TAGS ('dbx_business_glossary_term' = 'Whitespace Analysis');
ALTER TABLE `telecommunication_ecm`.`sales`.`b2b_account_plan` ALTER COLUMN `whitespace_analysis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` SET TAGS ('dbx_subdomain' = 'incentive_management');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `mvno_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Mobile Virtual Network Operator (MVNO) Agreement ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Allowed Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `spectrum_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Spectrum Allocation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_business_glossary_term' = 'Msisdn Range Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Mobile Virtual Network Operator (MVNO) Partner ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `peering_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Peering Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `wholesale_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Rate Card ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^MVNO-AGR-[0-9]{8}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'full_mvno|light_mvno|branded_reseller|white_label|hybrid');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `billing_settlement_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Billing Settlement Cycle (Days)');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `committed_subscriber_volume` SET TAGS ('dbx_business_glossary_term' = 'Committed Subscriber Volume');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `committed_traffic_volume_gb` SET TAGS ('dbx_business_glossary_term' = 'Committed Traffic Volume (GB)');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term (Months)');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `data_privacy_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Responsibility');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `data_privacy_responsibility` SET TAGS ('dbx_value_regex' = 'host_operator|mvno_partner|shared');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `e911_service_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Enhanced 911 (E911) Service Responsibility');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `e911_service_responsibility` SET TAGS ('dbx_value_regex' = 'host_operator|mvno_partner|shared');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `early_termination_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Penalty Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `early_termination_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `esim_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Embedded SIM (eSIM) Support Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `ims_access_flag` SET TAGS ('dbx_business_glossary_term' = 'IP Multimedia Subsystem (IMS) Access Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `lawful_intercept_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Lawful Intercept Responsibility');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `lawful_intercept_responsibility` SET TAGS ('dbx_value_regex' = 'host_operator|mvno_partner|shared');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `lawful_intercept_responsibility` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `mvno_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `mvno_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `network_access_type` SET TAGS ('dbx_business_glossary_term' = 'Network Access Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `network_access_type` SET TAGS ('dbx_value_regex' = '2g|3g|4g_lte|5g_nr|multi_technology');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `number_portability_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number Portability (MNP) Support Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (Days)');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `qos_priority_level` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Priority Level');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `qos_priority_level` SET TAGS ('dbx_value_regex' = 'premium|standard|economy');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `regulatory_compliance_obligations` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Obligations');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `roaming_coverage_zones` SET TAGS ('dbx_business_glossary_term' = 'Roaming Coverage Zones');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `roaming_entitlement_flag` SET TAGS ('dbx_business_glossary_term' = 'Roaming Entitlement Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|partner|broker|wholesale_team');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `sla_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Latency (Milliseconds)');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `sla_packet_loss_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Packet Loss Percentage');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `sla_penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Penalty Clause');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `sla_penalty_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `telecommunication_ecm`.`sales`.`mvno_agreement` ALTER COLUMN `volte_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Voice over Long-Term Evolution (VoLTE) Support Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` SET TAGS ('dbx_subdomain' = 'incentive_management');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `retention_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Offer Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `privacy_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Proposed Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Proposed Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `retention_interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Interaction Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `retention_model_output_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Model Output Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `trouble_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Trouble Ticket Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `acceptance_outcome` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Outcome');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `acceptance_outcome` SET TAGS ('dbx_value_regex' = 'accepted|rejected|no_response|deferred');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `applied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Offer Applied Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `arpu_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Average Revenue Per User (ARPU) Impact Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_offer` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Offer Presentation Channel');
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
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` SET TAGS ('dbx_subdomain' = 'incentive_management');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `retention_interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Interaction Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Case Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `location_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `location_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `location_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Opportunity Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `retention_model_output_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Model Output Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `trouble_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Trouble Ticket Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `agent_team` SET TAGS ('dbx_business_glossary_term' = 'Agent Team');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `churn_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Churn Reason Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `churn_reason_code` SET TAGS ('dbx_value_regex' = 'price_sensitivity|service_quality|competitor_offer|relocation|financial_hardship|dissatisfaction|[ENUM-REF-CANDIDATE: price_sensitivity|service_quality|competitor_offer|relocation|financial_hardship|dissatisfaction|network_coverage|customer_servic...');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `churn_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Churn Reason Description');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Name');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `competitor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `competitor_offer_description` SET TAGS ('dbx_business_glossary_term' = 'Competitor Offer Description');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `competitor_offer_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `customer_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `hold_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Hold Time in Seconds');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `interaction_channel` SET TAGS ('dbx_business_glossary_term' = 'Retention Interaction Channel');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `interaction_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Interaction Duration in Seconds');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `interaction_notes` SET TAGS ('dbx_business_glossary_term' = 'Retention Interaction Notes');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `interaction_number` SET TAGS ('dbx_business_glossary_term' = 'Retention Interaction Number');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `interaction_number` SET TAGS ('dbx_value_regex' = '^RTN-[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_business_glossary_term' = 'Retention Interaction Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_value_regex' = 'initiated|in_progress|completed|abandoned|escalated|follow_up_required');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `interaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Retention Interaction Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Retention Interaction Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_value_regex' = 'reactive_save|proactive_save|cancellation_request|downgrade_request|competitive_threat');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `mrr_delta_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Recurring Revenue (MRR) Delta Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `offer_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Retention Offer Acceptance Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `offer_acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|pending|expired');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `offer_acceptance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Retention Offer Acceptance Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `offer_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Retention Offer Currency Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `offer_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `offer_description` SET TAGS ('dbx_business_glossary_term' = 'Retention Offer Description');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `offer_eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Retention Offer Eligibility Criteria');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `offer_presented_flag` SET TAGS ('dbx_business_glossary_term' = 'Offer Presented Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `offer_type` SET TAGS ('dbx_business_glossary_term' = 'Retention Offer Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `offer_type` SET TAGS ('dbx_value_regex' = 'loyalty_discount|plan_upgrade|device_upgrade|contract_extension|service_credit|waived_fee');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `offer_validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Offer Validity End Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `offer_validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Offer Validity Start Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `offer_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Offer Value Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `post_save_contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Post-Save Contract Term in Months');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `post_save_mrr_amount` SET TAGS ('dbx_business_glossary_term' = 'Post-Save Monthly Recurring Revenue (MRR) Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `save_method` SET TAGS ('dbx_business_glossary_term' = 'Save Method');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `save_method` SET TAGS ('dbx_value_regex' = 'offer_accepted|issue_resolved|contract_modified|no_action|escalated');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `save_outcome` SET TAGS ('dbx_business_glossary_term' = 'Save Outcome');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `save_outcome` SET TAGS ('dbx_value_regex' = 'saved|lost|pending|partial_save');
ALTER TABLE `telecommunication_ecm`.`sales`.`retention_interaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` SET TAGS ('dbx_subdomain' = 'incentive_management');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `forecast_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Owner Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `forecast_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `forecast_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `forecast_submitted_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `forecast_submitted_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `forecast_submitted_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Kpi Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Team Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `prior_forecast_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `at_risk_opportunity_count` SET TAGS ('dbx_business_glossary_term' = 'At Risk Opportunity Count');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `average_deal_size` SET TAGS ('dbx_business_glossary_term' = 'Average Deal Size');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `average_sales_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Average Sales Cycle Days');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `best_case_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Best Case Revenue Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `commit_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Commit Revenue Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `conversion_rate_assumption` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate Assumption');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'B2C|B2B|MVNO|enterprise|SMB|residential');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `forecast_name` SET TAGS ('dbx_business_glossary_term' = 'Forecast Name');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `forecast_number` SET TAGS ('dbx_business_glossary_term' = 'Forecast Number');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|locked|archived');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|annual|ad_hoc');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `new_pipeline_added_amount` SET TAGS ('dbx_business_glossary_term' = 'New Pipeline Added Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Notes');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period End Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period Start Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `pipeline_coverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Coverage Ratio');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `product_category_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Category Scope');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `projected_activations_count` SET TAGS ('dbx_business_glossary_term' = 'Projected Activations Count');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `projected_attainment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Projected Attainment Percentage');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `projected_mrr_amount` SET TAGS ('dbx_business_glossary_term' = 'Projected Monthly Recurring Revenue (MRR) Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `projected_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Projected Revenue Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `quota_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Quota Target Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `slippage_amount` SET TAGS ('dbx_business_glossary_term' = 'Slippage Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `stage_commit_count` SET TAGS ('dbx_business_glossary_term' = 'Stage Commit Count');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `stage_negotiation_count` SET TAGS ('dbx_business_glossary_term' = 'Stage Negotiation Count');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `stage_proposal_count` SET TAGS ('dbx_business_glossary_term' = 'Stage Proposal Count');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `stage_prospect_count` SET TAGS ('dbx_business_glossary_term' = 'Stage Prospect Count');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `total_pipeline_value` SET TAGS ('dbx_business_glossary_term' = 'Total Pipeline Value');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `upside_opportunity_count` SET TAGS ('dbx_business_glossary_term' = 'Upside Opportunity Count');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `variance_to_previous_forecast` SET TAGS ('dbx_business_glossary_term' = 'Variance to Previous Forecast');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `weighted_pipeline_value` SET TAGS ('dbx_business_glossary_term' = 'Weighted Pipeline Value');
ALTER TABLE `telecommunication_ecm`.`sales`.`forecast` ALTER COLUMN `worst_case_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Worst Case Revenue Amount');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_offering` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_offering` SET TAGS ('dbx_subdomain' = 'channel_distribution');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_offering` SET TAGS ('dbx_association_edges' = 'product.offering,sales.channel');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_offering` ALTER COLUMN `channel_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Offering Assignment Identifier');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_offering` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modifying User Identifier');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_offering` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_offering` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_offering` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Offering - Offering Id');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_offering` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Offering - Sales Channel Id');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_offering` ALTER COLUMN `channel_offering_status` SET TAGS ('dbx_business_glossary_term' = 'Channel Offering Assignment Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_offering` ALTER COLUMN `channel_priority` SET TAGS ('dbx_business_glossary_term' = 'Channel Priority Ranking');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_offering` ALTER COLUMN `commission_override_rate` SET TAGS ('dbx_business_glossary_term' = 'Channel-Specific Commission Rate');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_offering` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_offering` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Channel Availability End Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_offering` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Channel Availability Start Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_offering` ALTER COLUMN `inventory_allocation` SET TAGS ('dbx_business_glossary_term' = 'Channel Inventory Allocation Quantity');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_offering` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_offering` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Channel-Offering Performance Classification');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_offering` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Sales Training Required Indicator');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` SET TAGS ('dbx_subdomain' = 'channel_distribution');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` SET TAGS ('dbx_association_edges' = 'sales.promotion,sales.channel');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ALTER COLUMN `channel_promotion_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Promotion Eligibility ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Configured By Employee ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ALTER COLUMN `last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Employee ID');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ALTER COLUMN `last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ALTER COLUMN `last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Promotion Eligibility - Promotion Id');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Promotion Eligibility - Sales Channel Id');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ALTER COLUMN `channel_effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Channel Effective End Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ALTER COLUMN `channel_effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Channel Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ALTER COLUMN `channel_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Channel Eligibility');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ALTER COLUMN `channel_inventory_limit` SET TAGS ('dbx_business_glossary_term' = 'Channel Inventory Limit');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ALTER COLUMN `channel_priority` SET TAGS ('dbx_business_glossary_term' = 'Channel Priority');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ALTER COLUMN `channel_redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Channel Redemption Count');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ALTER COLUMN `channel_specific_terms` SET TAGS ('dbx_business_glossary_term' = 'Channel Specific Terms');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ALTER COLUMN `configured_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configured Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`channel_promotion_eligibility` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`sales`.`account_team_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`account_team_assignment` SET TAGS ('dbx_subdomain' = 'incentive_management');
ALTER TABLE `telecommunication_ecm`.`sales`.`account_team_assignment` SET TAGS ('dbx_association_edges' = 'sales.b2b_account_plan,people.employee');
ALTER TABLE `telecommunication_ecm`.`sales`.`account_team_assignment` ALTER COLUMN `account_team_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Account Team Assignment Identifier');
ALTER TABLE `telecommunication_ecm`.`sales`.`account_team_assignment` ALTER COLUMN `b2b_account_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Account Team Assignment - B2B Account Plan Id');
ALTER TABLE `telecommunication_ecm`.`sales`.`account_team_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Team Assignment - Employee Id');
ALTER TABLE `telecommunication_ecm`.`sales`.`account_team_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`account_team_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`account_team_assignment` ALTER COLUMN `account_team_members` SET TAGS ('dbx_business_glossary_term' = 'Account Team Members');
ALTER TABLE `telecommunication_ecm`.`sales`.`account_team_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`account_team_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `telecommunication_ecm`.`sales`.`account_team_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `telecommunication_ecm`.`sales`.`account_team_assignment` ALTER COLUMN `coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coverage Percentage');
ALTER TABLE `telecommunication_ecm`.`sales`.`account_team_assignment` ALTER COLUMN `is_primary_owner` SET TAGS ('dbx_business_glossary_term' = 'Primary Owner Flag');
ALTER TABLE `telecommunication_ecm`.`sales`.`account_team_assignment` ALTER COLUMN `responsibility_scope` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Scope');
ALTER TABLE `telecommunication_ecm`.`sales`.`account_team_assignment` ALTER COLUMN `team_role` SET TAGS ('dbx_business_glossary_term' = 'Team Role');
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign` SET TAGS ('dbx_subdomain' = 'lead_generation');
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `telecommunication_ecm`.`sales`.`campaign` ALTER COLUMN `parent_campaign_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`wholesale_rate_card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`wholesale_rate_card` SET TAGS ('dbx_subdomain' = 'incentive_management');
ALTER TABLE `telecommunication_ecm`.`sales`.`wholesale_rate_card` ALTER COLUMN `wholesale_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Rate Card Identifier');
ALTER TABLE `telecommunication_ecm`.`sales`.`wholesale_rate_card` ALTER COLUMN `superseded_wholesale_rate_card_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_template` SET TAGS ('dbx_subdomain' = 'contract_execution');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_template` ALTER COLUMN `contract_template_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Template Identifier');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_template` ALTER COLUMN `base_contract_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_template` ALTER COLUMN `template_owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`sales`.`contract_template` ALTER COLUMN `template_owner_email` SET TAGS ('dbx_pii_email' = 'true');
