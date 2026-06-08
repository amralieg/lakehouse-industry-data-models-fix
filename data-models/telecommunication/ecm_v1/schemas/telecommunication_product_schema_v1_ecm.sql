-- Schema for Domain: product | Business: Telecommunication | Version: v1_ecm
-- Generated on: 2026-05-08 05:07:50

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`product` COMMENT 'SSOT for the commercial product and service catalog defining all offerings including mobile plans, broadband packages, IPTV/OTT bundles, VoIP offerings, enterprise SD-WAN/MPLS products, devices, and promotional offers. Manages product specifications, pricing models, bundles, eligibility, and product lifecycle via Netcracker Product Catalog.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`catalog_item` (
    `catalog_item_id` BIGINT COMMENT 'Unique identifier for the catalog item in the Netcracker Product Catalog. Primary key for all commercial offerings including mobile plans, broadband packages, IPTV/OTT bundles, VoIP offerings, enterprise SD-WAN/MPLS products, and devices.',
    `analytical_subject_area_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_subject_area. Business justification: Catalog items belong to analytical subject areas (Product Analytics, Revenue Analytics). Organizes data products and enables data governance. Standard telecom data architecture practice.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Catalog items must be classified within the hierarchical product taxonomy. Current STRING columns (product_category, product_subcategory) should be replaced with FK to product_category.product_categor',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Catalog items are assigned to cost centers for product line P&L tracking, profitability analysis, and management accounting. Standard telecom finance practice for product portfolio management and cost',
    `coverage_area_id` BIGINT COMMENT 'Foreign key linking to location.coverage_area. Business justification: Products specify technical availability zones; coverage qualification validates if customer location supports product technology (e.g., 5G plans require 5G coverage). Sales systems check coverage_area',
    `iot_tariff_id` BIGINT COMMENT 'Foreign key linking to interconnect.iot_tariff. Business justification: Roaming catalog items (international voice/data plans) reference specific IOT tariff structures for wholesale rate calculation. Essential for pricing international roaming products and ensuring retail',
    `lifecycle_status_id` BIGINT COMMENT 'Foreign key linking to product.lifecycle_status. Business justification: Catalog item lifecycle (concept, design, active, end-of-sale, end-of-life) must reference standardized lifecycle_status table for consistent state management, workflow rules, and reporting across all ',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Wholesale and MVNO operations require tracking which partner provides or co-brands catalog items (e.g., roaming packages from partner networks, content services from media partners). Supports partner ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Product managers own catalog items throughout lifecycle in telco operations - responsible for launch, pricing strategy, market positioning, and retirement decisions. Critical for product portfolio acc',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Catalog items are assigned to profit centers for segment reporting, business unit performance measurement, and revenue/margin analysis. Required for management accounting and regulatory financial repo',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Telecom products must comply with specific regulatory obligations (spectrum rules, service quality mandates, consumer protection). Regulatory filings reference which products are covered; compliance o',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Products have territory-specific availability due to franchise agreements, regulatory approvals, and market segmentation. Catalog management enforces territory-based product visibility and pricing rul',
    `zero_rating_program_id` BIGINT COMMENT 'Foreign key linking to product.zero_rating_program. Business justification: A catalog item can be associated with a zero‑rating program; many catalog items may share the same program while each catalog item references at most one program. Adding catalog_item.zero_rating_progr',
    `approval_status` STRING COMMENT 'Workflow state for catalog item changes requiring governance approval. Only approved items are published to active catalog and available for ordering.. Valid values are `draft|pending_review|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the current catalog version was approved for publication. Null for unapproved items. Used for audit trail and effective dating.',
    `approved_by` STRING COMMENT 'User ID or name of the product manager or governance authority who approved the current catalog version. Null for unapproved items.',
    `base_price` DECIMAL(18,2) COMMENT 'Standard list price for the catalog item before discounts, promotions, or customer-specific adjustments. Currency is USD unless otherwise specified in enterprise configuration.',
    `billing_frequency` STRING COMMENT 'Cadence at which recurring charges are generated for this catalog item. Drives invoice generation schedule in Amdocs billing system. [ENUM-REF-CANDIDATE: monthly|quarterly|annually|one_time|daily|per_usage|na — 7 candidates stripped; promote to reference product]',
    `catalog_version` STRING COMMENT 'Version number of the catalog item definition in Netcracker Product Catalog. Incremented with each approved change to product specifications, pricing, or terms. Format: major.minor.. Valid values are `^[0-9]+.[0-9]+$`',
    `channel_count` STRING COMMENT 'Number of live TV channels included in IPTV and OTT packages. Null for non-content products. Used for content licensing cost allocation and package differentiation.',
    `contract_term_months` STRING COMMENT 'Standard contract commitment period in months for this catalog item. Null for no-contract or prepaid offerings. Used for early termination fee calculations and churn analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this catalog item record was first created in the Netcracker Product Catalog system. Immutable audit field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the base price. Supports multi-currency pricing for international operations and wholesale agreements.. Valid values are `^[A-Z]{3}$`',
    `data_allowance_gb` DECIMAL(18,2) COMMENT 'Monthly data usage quota in gigabytes for mobile and broadband products. Null for unlimited plans or non-data products. Used for usage threshold monitoring and overage billing.',
    `download_speed_mbps` DECIMAL(18,2) COMMENT 'Maximum or typical download throughput in Mbps for broadband and mobile data products. Key QoS parameter for customer expectations and SLA commitments.',
    `effective_date` DATE COMMENT 'Date when the current catalog version becomes active and available for new orders. Supports future-dated product launches and pricing changes.',
    `eligibility_criteria` STRING COMMENT 'Business rules defining customer qualification requirements for this catalog item. Examples: credit score thresholds, geographic availability, existing customer status, business registration requirements.',
    `end_of_life_date` DATE COMMENT 'Date when all support and service for this catalog item ceases. All customer subscriptions must be migrated or terminated by this date. Null if not yet scheduled.',
    `end_of_sale_date` DATE COMMENT 'Date after which new orders for this catalog item are no longer accepted. Existing subscriptions may continue. Null if product is still available for sale.',
    `expiration_date` DATE COMMENT 'Date when the current catalog version is superseded by a newer version or withdrawn from the catalog. Null for current active versions without planned replacement.',
    `geographic_availability` STRING COMMENT 'Regions, states, or service areas where this catalog item can be provisioned. Constrained by network infrastructure coverage (RAN, fiber footprint, DSLAM reach). Pipe-separated list of region codes or national for full coverage.',
    `is_bundled` BOOLEAN COMMENT 'Indicates whether this catalog item is a composite bundle containing multiple sub-products or services. True for triple-play, quad-play, and enterprise solution bundles.',
    `is_standalone` BOOLEAN COMMENT 'Indicates whether this catalog item can be purchased independently or requires a base product. False for add-ons, value-added services, and device accessories.',
    `launch_date` DATE COMMENT 'Date when the catalog item was first made available for sale to customers. Used for product performance analysis and lifecycle tracking.',
    `market_segment` STRING COMMENT 'Target customer segment for the catalog item. Determines pricing strategy, sales channel eligibility, contract terms, and SLA commitments. [ENUM-REF-CANDIDATE: b2c|b2b|wholesale|mvno|government|enterprise_sme|enterprise_large — 7 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to this catalog item record. Updated with every change to product specifications, pricing, or lifecycle status.',
    `pricing_model` STRING COMMENT 'Revenue model and charging structure for the catalog item. Determines how billing events are generated and rated in Amdocs Revenue Management. [ENUM-REF-CANDIDATE: recurring|one_time|usage_based|tiered|hybrid|freemium|prepaid|postpaid — 8 candidates stripped; promote to reference product]',
    `product_code` STRING COMMENT 'Externally-known unique business identifier for the catalog item. Used across all BSS/OSS systems for product identification and ordering. Follows enterprise SKU format.. Valid values are `^[A-Z0-9]{6,20}$`',
    `product_description` STRING COMMENT 'Detailed description of the catalog item including features, benefits, and technical specifications. Used for customer-facing documentation and sales enablement.',
    `product_family` STRING COMMENT 'Logical grouping of related catalog items that share common characteristics, pricing models, or go-to-market strategy. Example: Unlimited Plans, Fiber Home, Business Connect Suite.',
    `product_name` STRING COMMENT 'Human-readable commercial name of the catalog item as presented to customers and used in marketing materials. Example: Unlimited 5G Premium Plan, Fiber 1Gbps Home Broadband, Enterprise SD-WAN Plus.',
    `promotion_end_date` DATE COMMENT 'Date when promotional pricing or terms expire. After this date, standard pricing applies to new orders. Null for non-promotional products.',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this catalog item is a limited-time promotional offer with special pricing or terms. Used for campaign tracking and revenue recognition.',
    `requires_device` BOOLEAN COMMENT 'Indicates whether this catalog item requires customer premises equipment (CPE), SIM card, or device to function. True for mobile plans, IPTV services, and broadband requiring ONT/modem.',
    `sales_channel` STRING COMMENT 'Distribution channels authorized to sell this catalog item. Pipe-separated list: retail_store, online, telesales, partner, enterprise_direct, wholesale. Controls product visibility in Salesforce CRM and order capture systems.',
    `sla_mttr_hours` DECIMAL(18,2) COMMENT 'Maximum time in hours to restore service after a fault for enterprise products with SLA commitments. Null for consumer products. Drives NOC escalation procedures.',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'Contractually guaranteed network availability percentage for enterprise and wholesale products. Null for consumer products without formal SLA. Used for penalty calculations and service credits.',
    `sms_allowance` STRING COMMENT 'Monthly SMS message quota included in mobile products. Null for unlimited messaging or non-mobile products. Used for usage tracking and overage billing.',
    `supports_esim` BOOLEAN COMMENT 'Indicates whether mobile product supports eSIM provisioning for compatible devices. Enables remote SIM activation and multi-profile management.',
    `supports_mnp` BOOLEAN COMMENT 'Indicates whether customers can port their existing phone number when subscribing to this mobile product. Drives MNP transaction workflows and regulatory compliance.',
    `supports_roaming` BOOLEAN COMMENT 'Indicates whether mobile product includes international or domestic roaming capabilities. Affects CDR rating and interconnect settlement processing.',
    `technology_type` STRING COMMENT 'Underlying network technology or platform that delivers the product. Critical for network planning, capacity management, and technical support routing. [ENUM-REF-CANDIDATE: 5g_nr|lte|3g|ftth|gpon|dsl|cable|sd_wan|mpls|voip|volte|ims|ott|hybrid|na — 15 candidates stripped; promote to reference product]',
    `upload_speed_mbps` DECIMAL(18,2) COMMENT 'Maximum or typical upload throughput in Mbps for broadband and mobile data products. Critical for enterprise applications, video conferencing, and cloud services.',
    `voice_minutes_allowance` STRING COMMENT 'Monthly voice call minutes included in mobile and VoIP products. Null for unlimited voice or data-only plans. Used for usage tracking and overage charges.',
    CONSTRAINT pk_catalog_item PRIMARY KEY(`catalog_item_id`)
) COMMENT 'Master record for every commercial offering in the Netcracker Product Catalog — mobile plans, broadband packages, IPTV/OTT bundles, VoIP offerings, enterprise SD-WAN/MPLS products, and devices. Captures canonical product definition including product code, category, sub-category, technology type, market segment (B2C, B2B, wholesale, MVNO), product family, launch date, end-of-sale date, and lifecycle status. Includes catalog versioning metadata (version number, approval status, effective date) and lifecycle event audit trail. SSOT for all product definitions.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`offering` (
    `offering_id` BIGINT COMMENT 'Unique identifier for the commercial offering. Primary key for the offering entity.',
    `analytical_subject_area_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_subject_area. Business justification: Offerings belong to analytical subject areas (Offering Performance, Customer Lifecycle). Enables data product organization and analytics governance. Real telecom data management need.',
    `catalog_item_id` BIGINT COMMENT 'Reference to the underlying technical product specification or catalog item that defines the service capabilities and provisioning requirements for this offering. Links commercial offering to technical catalog.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Offerings are assigned to cost centers for expense allocation, product performance tracking, and cost-to-serve analysis. Essential for telecom product profitability measurement and operational cost ma',
    `coverage_area_id` BIGINT COMMENT 'Foreign key linking to location.coverage_area. Business justification: Offerings specify minimum coverage requirements for sales qualification; order management validates customer location against offering coverage before provisioning. Critical for technology-specific of',
    `lifecycle_status_id` BIGINT COMMENT 'Foreign key linking to product.lifecycle_status. Business justification: Commercial offering lifecycle must reference lifecycle_status table for consistent state management across catalog_item, offering, and bundle entities.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who approved this offering for market launch. Nullable if offering is not yet approved. Used for governance and audit compliance.',
    `offering_employee_id` BIGINT COMMENT 'Reference to the employee responsible for this offerings lifecycle, pricing strategy, and market performance. Used for accountability and product portfolio management.',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.content_package. Business justification: Offerings bundle content packages (e.g., Premium Entertainment includes HBO+Sports). Required for marketing campaigns, sales proposals, subscription activation, and revenue reporting in telecommunicat',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Channel partners and MVNOs require exclusive or customized offerings. Tracks which partner an offering is designed for, supporting partner-specific product configuration, go-to-market strategy, and re',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Offerings are assigned to profit centers for revenue and margin analysis by business segment. Critical for management reporting, segment performance evaluation, and strategic decision-making in teleco',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Commercial offerings map to regulatory obligations for compliance reporting (universal service fund contributions calculated per offering type, accessibility requirements per service category). Real b',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Offerings are territory-bound for regulatory compliance, go-to-market strategy, and franchise obligations. Territory assignment drives channel availability, pricing models, and competitive positioning',
    `sla_template_id` BIGINT COMMENT 'Foreign key linking to product.sla_template. Business justification: Offerings (particularly enterprise SD-WAN/MPLS products) must reference formal SLA templates. Current scalar SLA attributes should be replaced with FK to sla_template.sla_template_id, allowing full SL',
    `approval_status` STRING COMMENT 'Current approval workflow status for this offering. Controls progression from draft to active state. Pending = awaiting review, Approved = ready for activation, Rejected = requires revision, Under_review = in approval process.. Valid values are `pending|approved|rejected|under_review`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this offering was approved for market launch. Nullable if offering is not yet approved. Used for audit trail and compliance reporting.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the offering automatically renews at the end of the contract term. True = auto-renew enabled, False = manual renewal required.',
    `base_monthly_price` DECIMAL(18,2) COMMENT 'Standard monthly recurring charge for this offering before discounts, promotions, or usage charges. Used for MRR forecasting and ARPU calculations. Nullable for one-time or usage-based offerings.',
    `bundle_flag` BOOLEAN COMMENT 'Indicates whether this offering is a bundle combining multiple catalog items or services. True = bundle offering, False = standalone offering. Bundles may include discounts vs. individual component pricing.',
    `channel_availability` STRING COMMENT 'Comma-separated list of sales channels where this offering is available for purchase (e.g., retail, online, telesales, dealer, b2b_direct, mvno_reseller). Drives channel-specific pricing and commission rules.',
    `competitive_positioning` STRING COMMENT 'Strategic positioning statement describing how this offering compares to competitor products in the market. Used for sales enablement and marketing strategy. Business-confidential information.',
    `content_entitlements` STRING COMMENT 'Comma-separated list of included content packages, streaming services, or IPTV/OTT subscriptions bundled with this offering (e.g., premium_sports, hd_channels, streaming_music). Drives content provisioning and DRM policy application.',
    `contract_term_months` STRING COMMENT 'Standard contract duration in months for this offering. Nullable for month-to-month or prepaid offerings. Drives Early Termination Fee (ETF) calculations and renewal workflows.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this offering record was first created in the product catalog system. Used for audit trail and lifecycle tracking.',
    `credit_class_eligibility` STRING COMMENT 'Minimum credit class required for customer eligibility. Drives deposit requirements, payment terms, and risk-based pricing. All = no credit restrictions.. Valid values are `excellent|good|fair|subprime|all`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all pricing attributes in this offering (e.g., USD, EUR, GBP). Ensures consistent financial reporting and billing.. Valid values are `^[A-Z]{3}$`',
    `data_allowance_gb` DECIMAL(18,2) COMMENT 'Monthly data usage allowance in gigabytes for mobile or broadband offerings. Nullable for unlimited plans or non-data offerings. Used for usage tracking and overage billing.',
    `device_included_flag` BOOLEAN COMMENT 'Indicates whether this offering includes a physical device (e.g., smartphone, router, set-top box, Customer Premises Equipment). True = device included, False = service-only offering.',
    `download_speed_mbps` DECIMAL(18,2) COMMENT 'Maximum advertised download speed in Mbps for broadband, fiber, or mobile data offerings. Used for service tier classification and Quality of Service (QoS) enforcement.',
    `effective_end_date` DATE COMMENT 'Date when the offering is no longer available for new sales. Nullable for offerings without a planned retirement date. Existing subscriptions may continue beyond this date per contract terms.',
    `effective_start_date` DATE COMMENT 'Date when the offering becomes available for sale through configured channels. Controls offering visibility in product catalogs and order capture systems.',
    `eligibility_rules_summary` STRING COMMENT 'High-level summary of customer eligibility criteria for this offering (e.g., credit score requirements, existing customer status, device compatibility, service address qualification). Detailed rules managed in policy engine.',
    `etf_structure` STRING COMMENT 'Structure of the Early Termination Fee applied when a customer cancels before contract term completion. Flat = fixed amount, Prorated = decreases over time, Tiered = varies by remaining term, None = no ETF.. Valid values are `flat|prorated|tiered|none`',
    `geographic_availability` STRING COMMENT 'Geographic regions, markets, or service areas where this offering is available. May reference coverage zones, state/province codes, or network footprint identifiers. Critical for order validation and service provisioning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this offering record. Used for change tracking, audit compliance, and data synchronization across BSS/OSS systems.',
    `mvno_reseller_flag` BOOLEAN COMMENT 'Indicates whether this offering is available for resale through MVNO partners. True = MVNO reseller enabled, False = direct sales only. Drives wholesale pricing and interconnect billing.',
    `network_technology` STRING COMMENT 'Underlying network technology or access method for this offering. Determines service capabilities, coverage, and provisioning requirements. [ENUM-REF-CANDIDATE: 4g_lte|5g_nr|ftth|gpon|dsl|cable|satellite|fixed_wireless|mpls|sd_wan — promote to reference product]',
    `nps_target_score` STRING COMMENT 'Target Net Promoter Score for customer satisfaction tracking specific to this offering. Used for product performance monitoring and churn prediction. Nullable if no specific NPS target is set.',
    `offering_category` STRING COMMENT 'Market segment classification indicating the target customer base for this offering. Drives channel strategy and pricing models.. Valid values are `consumer|business|enterprise|wholesale|mvno`',
    `offering_code` STRING COMMENT 'Externally-known unique business identifier for the offering used in BSS/CRM systems and customer-facing materials. Typically follows a structured format for catalog management.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `offering_description` STRING COMMENT 'Detailed description of the offering including key features, benefits, and value proposition for customer-facing and internal reference.',
    `offering_name` STRING COMMENT 'Customer-facing marketing name of the offering as displayed in sales channels, promotional materials, and customer communications.',
    `offering_type` STRING COMMENT 'Classification of the offering by product category. Determines the primary service domain and applicable business rules. [ENUM-REF-CANDIDATE: mobile_plan|broadband_package|iptv_bundle|ott_service|voip_offering|enterprise_sdwan|mpls_service|ftth_service|device|accessory|value_added_service|promotional_bundle — promote to reference product]. Valid values are `mobile_plan|broadband_package|iptv_bundle|ott_service|voip_offering|enterprise_sdwan`',
    `one_time_activation_fee` DECIMAL(18,2) COMMENT 'Non-recurring charge applied at service activation or order fulfillment. Includes setup, installation, or provisioning fees. Nullable if no activation fee applies.',
    `pricing_model` STRING COMMENT 'Revenue model structure for this offering. Flat_rate = fixed monthly charge, Usage_based = pay per consumption, Tiered = volume discounts, Hybrid = base + usage, Freemium = free tier with paid upgrades, Prepaid = pay-before-use.. Valid values are `flat_rate|usage_based|tiered|hybrid|freemium|prepaid`',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this offering includes time-limited promotional pricing or incentives. True = promotional offering, False = standard offering. Promotional offerings may have special eligibility or expiration rules.',
    `retirement_reason` STRING COMMENT 'Business justification for retiring or obsoleting this offering (e.g., technology sunset, regulatory change, poor market performance, replaced by new offering). Nullable for active offerings. Used for product portfolio analysis.',
    `roaming_included_flag` BOOLEAN COMMENT 'Indicates whether international or domestic roaming is included in the offering without additional charges. True = roaming included, False = roaming charged separately. Applicable to mobile offerings.',
    `sms_allowance` STRING COMMENT 'Monthly SMS message allowance for mobile offerings. Nullable for unlimited or non-mobile offerings. Used for usage tracking and overage billing.',
    `upload_speed_mbps` DECIMAL(18,2) COMMENT 'Maximum advertised upload speed in Mbps for broadband, fiber, or mobile data offerings. Critical for enterprise SD-WAN and business-class services.',
    `voice_minutes_allowance` STRING COMMENT 'Monthly voice call minutes included in mobile or VoIP offerings. Nullable for unlimited or data-only plans. Used for CDR rating and overage calculations.',
    CONSTRAINT pk_offering PRIMARY KEY(`offering_id`)
) COMMENT 'A commercially sellable product offering combining one or more catalog items into a customer-facing package. Represents the marketable unit in BSS/CRM — includes offering name/code, channel availability (retail, online, telesales, dealer, B2B direct, MVNO reseller), geographic availability footprint, eligibility rules summary, contract term options (duration, ETF structure, auto-renewal), effective dates, and offering status. Distinct from catalog_item (technical specification) — an offering is the commercial wrapper presented to customers through specific channels in specific geographies.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`bundle` (
    `bundle_id` BIGINT COMMENT 'Unique identifier for the product bundle. Primary key.',
    `bi_report_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.bi_report_definition. Business justification: Bundles link to bundle performance reports (attach rate, revenue lift, component mix). Enables bundle optimization and cross-sell analysis. Real telecom product analytics need.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Bundles are assigned to cost centers for cost tracking, bundle profitability analysis, and promotional campaign cost allocation. Required for telecom product portfolio financial management and pricing',
    `employee_id` BIGINT COMMENT 'Identifier of the product manager responsible for this bundles lifecycle, pricing strategy, and market performance. Used for product governance and accountability.',
    `lifecycle_status_id` BIGINT COMMENT 'Foreign key linking to product.lifecycle_status. Business justification: Bundle lifecycle management requires referential integrity to standardized lifecycle_status reference table. Current STRING column should be replaced with FK to lifecycle_status.lifecycle_status_id fo',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.content_package. Business justification: Triple-play and quad-play bundles explicitly include content packages as the TV/video component. Critical for bundle configuration, pricing calculations, provisioning workflows, and customer entitleme',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: MVNO and dealer channel operations create partner-branded bundles with specific revenue share arrangements. Tracks bundle ownership for partner billing, settlement runs, and channel-specific bundle av',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Bundles are assigned to profit centers for segment reporting, business unit performance measurement, and bundled offering revenue analysis. Essential for telecom management accounting and strategic po',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Bundles have territory-specific availability due to regulatory mandates (e.g., NBN bundles in Australia), competitive responses, and franchise obligations. Territory determines bundle eligibility and ',
    `activation_fee` DECIMAL(18,2) COMMENT 'One-time charge for service activation and provisioning in Operations Support Systems (OSS) and Business Support Systems (BSS). Null if activation is included at no charge. Distinct from installation fee which covers physical setup.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether bundle subscriptions automatically renew at contract term expiration (True) or require explicit customer action to continue (False). Used in subscription lifecycle management and customer retention workflows.',
    `billing_frequency` STRING COMMENT 'Recurring billing cycle for the bundle. Monthly is standard for consumer services. Quarterly and annual are common for business contracts. One-time applies to non-recurring bundles. Usage-based bills after consumption. Prepaid requires advance payment.. Valid values are `monthly|quarterly|annual|one_time|usage_based|prepaid`',
    `bundle_category` STRING COMMENT 'Market segment classification for the bundle. Consumer bundles target residential customers. Business bundles serve SMB and enterprise. Wholesale bundles are for carrier-to-carrier. MVNO (Mobile Virtual Network Operator) bundles support virtual operators. IoT (Internet of Things) bundles serve connected devices. Roaming bundles provide international services.. Valid values are `consumer|business|wholesale|mvno|iot|roaming`',
    `bundle_code` STRING COMMENT 'Externally-known unique business identifier for the bundle used in product catalog, ordering, and billing systems. Examples: TRIPLE_PLAY_GOLD, QUAD_PLAY_PREMIUM, MOBILE_FAMILY_PLUS.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `bundle_description` STRING COMMENT 'Detailed business description of the bundle including key features, benefits, target customer segment, and value proposition. Used for product catalog documentation and sales enablement.',
    `bundle_name` STRING COMMENT 'Human-readable marketing name of the bundle displayed to customers and used in sales channels. Examples: Triple Play Gold, Quad Play Premium, Family Mobile Plus.',
    `bundle_type` STRING COMMENT 'Classification of the bundle structure. Fixed bundles have predefined components that cannot be changed. Flexible bundles allow customer selection from a set of options. Customizable bundles permit component substitution. Dynamic bundles adjust based on usage patterns. Promotional bundles are time-limited offers. Enterprise bundles are tailored for business customers.. Valid values are `fixed|flexible|customizable|dynamic|promotional|enterprise`',
    `channel_availability` STRING COMMENT 'Sales and distribution channels authorized to sell this bundle. All channels indicates universal availability. Retail is physical stores. Online is web and mobile app. Telesales is call center. Partner is third-party resellers. Enterprise direct is account management. Agent is authorized dealer network. [ENUM-REF-CANDIDATE: all|retail|online|telesales|partner|enterprise_direct|agent — 7 candidates stripped; promote to reference product]',
    `component_substitution_allowed` BOOLEAN COMMENT 'Indicates whether customers can substitute bundle components with alternatives of equal or lesser value (True) or if the bundle composition is fixed (False). Used in order configuration and customization workflows.',
    `contract_term_months` STRING COMMENT 'Minimum contract commitment period in months required for this bundle. Common values: 12, 24, 36 for consumer; 36, 60 for enterprise. Null indicates no minimum term or month-to-month service.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this bundle record was first created in the product catalog system. Used for audit trail and product lifecycle tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for bundle pricing. Examples: USD, EUR, GBP, JPY, AUD.. Valid values are `^[A-Z]{3}$`',
    `data_allowance_gb` DECIMAL(18,2) COMMENT 'Total data usage allowance included in the bundle measured in gigabytes. Applicable to mobile, broadband, and IoT bundles. Null for unlimited data bundles or bundles without data components. Used for usage tracking and overage billing.',
    `device_included_flag` BOOLEAN COMMENT 'Indicates whether Customer Premises Equipment (CPE) or mobile devices are included in the bundle (True) or must be purchased separately (False). Examples: modem, router, Optical Network Terminal (ONT), smartphone, tablet.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Fixed monetary discount applied to the bundle in the specified currency. Alternative to percentage-based discount. Used when bundle offers a specific dollar-value reduction.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied when purchasing the bundle versus buying components individually. Null if no discount applies or pricing model is not discount-based. Used to calculate bundle savings for customer value proposition.',
    `downgrade_eligible_flag` BOOLEAN COMMENT 'Indicates whether customers can downgrade from this bundle to lower-tier offerings (True) or if downgrade restrictions apply (False). Used in churn prevention and customer retention strategies.',
    `early_termination_fee` DECIMAL(18,2) COMMENT 'Penalty charge applied if customer cancels the bundle before the contract term expires. Null if no early termination fee applies. Used in contract enforcement and customer retention calculations.',
    `effective_end_date` DATE COMMENT 'Date when this bundle is no longer available for new sales. Existing subscriptions may continue beyond this date. Null indicates no planned end date. Used for product retirement planning and promotional offer expiration. Format: yyyy-MM-dd.',
    `effective_start_date` DATE COMMENT 'Date when this bundle becomes available for sale and order capture. Used for product launch coordination and sales channel enablement. Format: yyyy-MM-dd.',
    `eligibility_criteria` STRING COMMENT 'Business rules defining customer or service eligibility for this bundle. May include geographic restrictions, credit requirements, existing service prerequisites, customer segment qualifications, or network availability constraints. Used during order validation.',
    `geographic_availability` STRING COMMENT 'Geographic regions, markets, or service areas where this bundle is available for sale. May reference coverage zones, state/province codes, or network footprint identifiers. Used for sales channel enablement and order feasibility checks.',
    `installation_fee` DECIMAL(18,2) COMMENT 'One-time charge for service installation, activation, and Customer Premises Equipment (CPE) setup. Null if installation is included at no charge. Used in order pricing and revenue recognition.',
    `international_roaming_included` BOOLEAN COMMENT 'Indicates whether international roaming services are included in the bundle at no additional charge (True) or require separate fees (False). Used for service provisioning and roaming partner settlement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this bundle record was last updated. Used for change tracking, version control, and audit compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `maximum_component_count` STRING COMMENT 'Maximum number of component products or services that can be included in the bundle. Null indicates no upper limit. Used for bundle configuration validation.',
    `minimum_component_count` STRING COMMENT 'Minimum number of component products or services that must be included in the bundle for it to be valid. Used for bundle eligibility validation during order capture.',
    `price_amount` DECIMAL(18,2) COMMENT 'Base recurring price of the bundle in the specified currency. For flat-rate bundles this is the total charge. For other pricing models this represents the base component before usage or tiered calculations.',
    `pricing_model` STRING COMMENT 'Pricing strategy applied to the bundle. Flat rate charges a single fixed price. Tiered pricing varies by usage thresholds. Usage-based charges per consumption. Hybrid combines fixed and variable components. Discount off components applies percentage reduction to sum of individual prices. Promotional offers temporary pricing.. Valid values are `flat_rate|tiered|usage_based|hybrid|discount_off_components|promotional`',
    `service_level_agreement` STRING COMMENT 'Quality of Service (QoS) tier and performance guarantees associated with this bundle. Standard is basic residential service. Premium offers enhanced support. Enterprise includes business-grade SLAs. Gold and Platinum are tiered service levels. Best effort has no guarantees. Defines uptime commitments, support response times, and performance thresholds.. Valid values are `standard|premium|enterprise|gold|platinum|best_effort`',
    `sms_allowance` STRING COMMENT 'Total SMS text messages included in the bundle. Applicable to mobile bundles. Null for unlimited SMS bundles or bundles without SMS components. Used for usage tracking and overage billing.',
    `upgrade_eligible_flag` BOOLEAN COMMENT 'Indicates whether customers can upgrade from this bundle to higher-tier offerings without penalty (True) or if upgrade restrictions apply (False). Used in customer lifecycle management and upsell campaigns.',
    `version_number` STRING COMMENT 'Version identifier for this bundle specification following semantic versioning (major.minor). Incremented when bundle attributes, pricing, or components change. Used for product change management and historical analysis.. Valid values are `^[0-9]+.[0-9]+$`',
    `voice_minutes_allowance` STRING COMMENT 'Total voice call minutes included in the bundle. Applicable to mobile and VoIP bundles. Null for unlimited voice bundles or bundles without voice components. Used for usage tracking and overage billing.',
    CONSTRAINT pk_bundle PRIMARY KEY(`bundle_id`)
) COMMENT 'Defines composite product bundles that group multiple offerings or catalog items into a single commercial package (e.g., Triple Play: broadband + IPTV + VoIP, or Quad Play: mobile + broadband + IPTV + fixed voice). Captures bundle code, bundle type (fixed, flexible, customizable), minimum/maximum component count, discount applicability, bundle pricing model, and lifecycle dates. Manages the structural definition of bundled products separate from individual component pricing.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`price_plan` (
    `price_plan_id` BIGINT COMMENT 'Unique identifier for the price plan. Primary key for the price plan entity.',
    `bi_report_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.bi_report_definition. Business justification: Price plans link to pricing analysis reports (revenue by plan, migration patterns, discount effectiveness). Standard telecom finance and pricing analytics reporting.',
    `catalog_item_id` BIGINT COMMENT 'Reference to the product catalog that contains this price plan. Links the price plan to its catalog context for product management and offering organization.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Price plans map to GL accounts for revenue recognition, financial reporting, and accounting compliance. Critical for telecom revenue accounting, IFRS 15 compliance, and automated journal entry generat',
    `lifecycle_status_id` BIGINT COMMENT 'Foreign key linking to product.lifecycle_status. Business justification: Price plan lifecycle management requires FK to lifecycle_status.lifecycle_status_id for standardized status tracking, particularly for managing active vs. grandfathered pricing.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Wholesale telecommunications requires partner-specific rate plans for MVNOs and interconnect partners. Tracks which partner a wholesale price plan applies to, supporting partner billing, settlement ca',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Pricing analysts create and maintain price plans in telecommunications - essential for pricing governance, audit trails, and revenue assurance. Tracks who designed tiered pricing structures, overage r',
    `offering_id` BIGINT COMMENT 'Reference to the product offering that this price plan applies to. A product offering may have multiple price plans for different customer segments or contract terms.',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Price plans vary by territory due to regulatory tariffs, cost-to-serve differences, and competitive positioning. Billing systems apply territory-specific pricing rules; regulatory reporting aggregates',
    `superseded_by_price_plan_id` BIGINT COMMENT 'Reference to the price plan that replaces this plan when it is retired or obsoleted. Null if no replacement plan exists. Supports migration path tracking.',
    `advance_payment_required_flag` BOOLEAN COMMENT 'Indicates whether payment must be collected in advance before service activation (true) or billed in arrears after service delivery (false). Common for prepaid vs postpaid models.',
    `approval_status` STRING COMMENT 'Workflow approval status for this price plan. Pending indicates awaiting approval, approved indicates ready for activation, rejected indicates not approved for use. Supports governance and compliance controls.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this price plan was approved. Null if not yet approved. Supports audit trail and compliance tracking.',
    `approved_by_user` STRING COMMENT 'Identifier of the user who approved this price plan for activation. Null if not yet approved. Supports audit trail and governance.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether subscriptions on this price plan automatically renew at the end of the contract term (true) or require explicit renewal action (false).',
    `base_price_amount` DECIMAL(18,2) COMMENT 'The base price amount for this price plan before any discounts, surcharges, or taxes. For flat rate plans this is the fixed charge; for tiered/volume plans this is the starting tier price.',
    `billing_frequency` STRING COMMENT 'The frequency at which charges under this price plan are billed to the customer. Defines the billing cycle period for recurring charges. [ENUM-REF-CANDIDATE: monthly|quarterly|semi_annual|annual|one_time|daily|weekly|per_event — 8 candidates stripped; promote to reference product]',
    `bundle_eligible_flag` BOOLEAN COMMENT 'Indicates whether this price plan can be included in product bundles or multi-service packages (true) or must be purchased standalone (false).',
    `charge_type` STRING COMMENT 'Classification of the charge applied by this price plan. Recurring for subscription fees (MRC - Monthly Recurring Charge), one-time for activation/installation (OTC - One-Time Charge), usage for consumption-based charges, overage for exceeding allowances, penalty for late payments or violations, adjustment for credits or corrections.. Valid values are `recurring|one_time|usage|overage|penalty|adjustment`',
    `contract_term_months` STRING COMMENT 'The minimum contract commitment period in months for this price plan. Customer must maintain the plan for this duration or face early termination fees. Null for month-to-month plans.',
    `created_by_user` STRING COMMENT 'Identifier of the user or system that created this price plan record. Supports audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this price plan record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the price plan amount (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Target customer segment for this price plan. Consumer for individual retail customers, small business for SMB, enterprise for large corporate accounts, government for public sector, wholesale for carrier-to-carrier, MVNO (Mobile Virtual Network Operator) for reseller partners.. Valid values are `consumer|small_business|enterprise|government|wholesale|mvno`',
    `early_termination_fee` DECIMAL(18,2) COMMENT 'The penalty fee charged if customer terminates service before the contract term expires. Null if no early termination fee applies.',
    `effective_end_date` DATE COMMENT 'The date when this price plan expires and is no longer available for new subscriptions. Null for plans with no defined end date. Existing customers may continue on the plan after this date.',
    `effective_start_date` DATE COMMENT 'The date when this price plan becomes effective and available for new subscriptions. Defines the beginning of the price plans validity period.',
    `eligibility_criteria` STRING COMMENT 'Business rules defining which customers or accounts are eligible for this price plan. May include customer segment, credit score requirements, geographic restrictions, existing service requirements, or promotional qualifications.',
    `geographic_availability` STRING COMMENT 'Geographic regions, markets, or service areas where this price plan is available. May be defined as country codes, state/province codes, zip/postal codes, or market identifiers.',
    `included_quantity` DECIMAL(18,2) COMMENT 'The quantity of units included in the base price before overage charges apply. For example, 50GB of data included in a mobile plan. Null if plan does not include a bundled quantity.',
    `last_modified_by_user` STRING COMMENT 'Identifier of the user or system that last modified this price plan record. Supports change tracking and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this price plan record was last updated. Supports change tracking and audit compliance.',
    `maximum_charge_amount` DECIMAL(18,2) COMMENT 'Maximum charge cap for this price plan within the billing period. Charges will not exceed this amount even if usage or events would normally result in higher charges. Null if no cap applies.',
    `minimum_commitment_amount` DECIMAL(18,2) COMMENT 'Minimum spending commitment required under this price plan within the billing period. Customer must pay at least this amount regardless of actual usage. Null if no minimum commitment applies.',
    `overage_rate` DECIMAL(18,2) COMMENT 'The per-unit charge applied when usage exceeds the included quantity. For example, $0.10 per GB over the included data allowance. Null if no overage charges apply.',
    `price_plan_code` STRING COMMENT 'External business identifier for the price plan used in product catalogs and billing systems. Unique code assigned by product management.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `price_plan_description` STRING COMMENT 'Detailed description of the price plan including what it covers, applicable services, and any special conditions or restrictions.',
    `price_plan_name` STRING COMMENT 'Human-readable name of the price plan displayed to customers and used in marketing materials.',
    `pricing_model_type` STRING COMMENT 'The pricing structure model applied to this plan. Flat rate for fixed charges, tiered for step-based pricing, volume-based for quantity discounts, usage-based for consumption charges, event-based for transaction charges, or hybrid for combinations.. Valid values are `flat_rate|tiered|volume_based|usage_based|event_based|hybrid`',
    `promotional_end_date` DATE COMMENT 'The date when promotional pricing or terms expire and standard pricing takes effect. Null for non-promotional plans or promotions without a defined end date.',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this price plan is a promotional or limited-time offer (true) or a standard ongoing plan (false). Promotional plans typically have special pricing or terms for a limited period.',
    `proration_policy` STRING COMMENT 'Policy for prorating charges when service starts or ends mid-billing cycle. Full period charges the entire amount, daily proration calculates based on days used, no proration means no refund or partial charge, custom follows specific business rules.. Valid values are `full_period|daily_proration|no_proration|custom`',
    `qos_tier` STRING COMMENT 'The Quality of Service tier associated with this price plan defining network priority, bandwidth guarantees, latency targets, and service level commitments. Premium offers highest priority and guarantees, best effort offers no guarantees.. Valid values are `premium|standard|basic|best_effort`',
    `rating_group` STRING COMMENT 'Classification group used by the rating engine to apply appropriate charging rules and tariffs. Used in real-time charging systems for CDR (Call Detail Record) processing and usage rating.',
    `service_type` STRING COMMENT 'The type of telecommunications service this price plan applies to (e.g., mobile voice, mobile data, broadband internet, FTTH (Fiber to the Home), IPTV (Internet Protocol Television), VoIP (Voice over Internet Protocol), SD-WAN (Software-Defined Wide Area Network), MPLS (Multiprotocol Label Switching), 5G NR (5G New Radio)). [ENUM-REF-CANDIDATE: mobile_voice|mobile_data|broadband|ftth|iptv|voip|sd_wan|mpls|5g_nr|lte|ott|device — promote to reference product]',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'The guaranteed service availability percentage defined in the SLA (Service Level Agreement) for this price plan. For example, 99.9% uptime guarantee. Null if no SLA uptime commitment applies.',
    `tax_category` STRING COMMENT 'Tax classification category for this price plan determining applicable tax rates and treatment. Telecom-specific category applies to services subject to special telecommunications taxes or regulatory fees.. Valid values are `standard|reduced|exempt|zero_rated|luxury|telecom_specific`',
    `tax_inclusive_flag` BOOLEAN COMMENT 'Indicates whether the base price amount includes taxes (true) or taxes are added on top (false). Critical for pricing display and billing calculation.',
    `tiered_pricing_structure` STRING COMMENT 'JSON or structured text defining the tier breakpoints and rates for tiered pricing models. Specifies quantity ranges and corresponding unit prices for each tier. Null for non-tiered plans.',
    `unit_of_measure` STRING COMMENT 'The unit of measurement for usage-based or volume-based pricing (e.g., GB for data, minutes for voice, SMS for messaging, Mbps for bandwidth, each for devices). Null for non-usage-based plans.',
    `version_number` STRING COMMENT 'Version identifier for this price plan definition. Incremented when pricing terms, rates, or structure are modified. Supports price plan change tracking and historical analysis.. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_price_plan PRIMARY KEY(`price_plan_id`)
) COMMENT 'Defines the base pricing model for a catalog item or offering — including recurring charges (MRC), one-time charges (OTC), and usage-based charges. Captures charge type, billing frequency, currency, tax category, price points, tiered/volume pricing structures, and effective date ranges. Supports flat rate, tiered, volume-based, and event-based pricing models. References price_alteration records for discount/surcharge modifications. SSOT for base product pricing definitions and charge structures.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`price_alteration` (
    `price_alteration_id` BIGINT COMMENT 'Unique identifier for the price alteration rule. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Discount and price alteration approvals require employee accountability in telco revenue management - critical for fraud prevention, margin protection, and regulatory compliance. Tracks authorization ',
    `price_plan_id` BIGINT COMMENT 'Reference to the parent price plan to which this alteration applies. Links this alteration to the base pricing structure.',
    `superseded_by_alteration_price_alteration_id` BIGINT COMMENT 'Reference to the newer price alteration that replaces this one. Used to maintain version history and migration paths. Null if this is the current version.',
    `alteration_category` STRING COMMENT 'Business category of the alteration defining its purpose: promotional (marketing campaigns), loyalty (customer retention rewards), volume (usage-based discounts), bundle (package discounts), regulatory (mandated charges), tax (government levies), penalty (contract breach fees), early termination (cancellation fees), late payment (overdue charges), seasonal (time-based offers). [ENUM-REF-CANDIDATE: promotional|loyalty|volume|bundle|regulatory|tax|penalty|early_termination|late_payment|seasonal — 10 candidates stripped; promote to reference product]',
    `alteration_code` STRING COMMENT 'Unique business identifier code for the price alteration rule, used for external reference and integration with billing systems.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `alteration_description` STRING COMMENT 'Detailed description of the price alteration, including business purpose, eligibility criteria, and application logic.',
    `alteration_name` STRING COMMENT 'Human-readable name of the price alteration rule, such as Holiday Promotion 2024 or Volume Discount Tier 3.',
    `alteration_type` STRING COMMENT 'Classification of the price alteration indicating whether it reduces, increases, or modifies the base price. Discount reduces price, surcharge increases price, rebate provides post-payment credit, waiver eliminates a charge, adjustment modifies for specific conditions, credit applies account credit.. Valid values are `discount|surcharge|rebate|waiver|adjustment|credit`',
    `alteration_value` DECIMAL(18,2) COMMENT 'Numeric value of the price alteration. For percentage type, represents the percentage (e.g., 15.00 for 15%). For absolute type, represents the fixed amount in the currency of the price plan. For tiered and formula types, may represent a base value or multiplier.',
    `application_scope` STRING COMMENT 'Defines the level at which the alteration is applied: account (entire customer account), subscription (specific subscription), service (individual service instance), usage (per usage event), invoice (entire invoice).. Valid values are `account|subscription|service|usage|invoice`',
    `application_sequence` STRING COMMENT 'Order in which this alteration is applied when multiple alterations exist on the same price plan. Lower numbers are applied first. Critical for calculating compound discounts and surcharges correctly.',
    `approval_authority_level` STRING COMMENT 'Organizational level required to approve application of this alteration. Null if no approval is required (auto_approved).. Valid values are `manager|director|vp|cfo|auto_approved`',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether manual approval is required before this alteration can be applied to customer accounts. True for high-value discounts or regulatory surcharges requiring oversight.',
    `charge_type_filter` STRING COMMENT 'Comma-separated list of charge types to which this alteration applies (e.g., recurring,usage,activation). Null means applies to all charge types. Used to restrict alterations to specific billing components.',
    `created_by_user` STRING COMMENT 'Username or identifier of the person or system that created this alteration record. Supports audit and accountability requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this price alteration record was first created in the system. Used for audit trail and compliance reporting.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the alteration amounts (e.g., USD, EUR, GBP). Must align with the price plan currency.. Valid values are `^[A-Z]{3}$`',
    `customer_segment_filter` STRING COMMENT 'Comma-separated list of customer segments eligible for this alteration (e.g., enterprise,government,education). Null means applies to all segments. Enables segment-specific pricing strategies.',
    `effective_end_date` DATE COMMENT 'Date when this price alteration expires and can no longer be applied to new charges. Null indicates an open-ended alteration with no expiration.',
    `effective_start_date` DATE COMMENT 'Date when this price alteration becomes active and can be applied to customer charges. Part of the validity period for the alteration rule.',
    `eligibility_criteria` STRING COMMENT 'Business rules defining which customers, accounts, or usage scenarios qualify for this alteration. May reference customer segments, account types, service tenure, usage thresholds, or promotional codes.',
    `external_reference_code` STRING COMMENT 'Identifier used by external systems or partners to reference this alteration. Supports integration with third-party billing, CRM, and partner portals.',
    `geographic_scope` STRING COMMENT 'Comma-separated list of geographic regions, countries, or zones where this alteration is valid (e.g., USA,CAN,MEX). Null means applies globally. Used for region-specific pricing and regulatory compliance.',
    `gl_account_code` STRING COMMENT 'General ledger account code for financial posting of this alteration. Used for revenue recognition and financial reporting integration with ERP systems.. Valid values are `^[0-9]{4,10}$`',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the person or system that last modified this alteration record. Supports audit and accountability requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this price alteration record was last updated. Critical for change tracking and synchronization with downstream systems.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the price alteration rule: draft (being designed), active (available for use), suspended (temporarily disabled), expired (past end date), retired (permanently removed from catalog).. Valid values are `draft|active|suspended|expired|retired`',
    `maximum_alteration_amount` DECIMAL(18,2) COMMENT 'Maximum monetary value that the alteration can apply, capping the discount or surcharge. Null if no maximum applies.',
    `minimum_alteration_amount` DECIMAL(18,2) COMMENT 'Minimum monetary value that the alteration can apply, ensuring discounts or surcharges meet a floor threshold. Null if no minimum applies.',
    `notes` STRING COMMENT 'Free-text field for additional comments, business context, or special instructions related to this price alteration. Used for operational guidance and knowledge transfer.',
    `priority_level` STRING COMMENT 'Priority ranking for conflict resolution when multiple exclusive alterations could apply. Higher numbers indicate higher priority. Used by rating engines to determine which alteration wins.',
    `promo_code` STRING COMMENT 'Optional promotional code that customers must provide to activate this alteration. Used for targeted marketing campaigns and partner offers. Null if no code is required.. Valid values are `^[A-Z0-9]{4,15}$`',
    `recurrence_frequency` STRING COMMENT 'For recurring alterations, specifies the frequency of application. Null for non-recurring alterations.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `recurrence_pattern` STRING COMMENT 'Defines how often the alteration is applied: one_time (single application), recurring (applies every billing cycle), usage_based (applies per usage event), event_triggered (applies when specific business event occurs).. Valid values are `one_time|recurring|usage_based|event_triggered`',
    `revenue_recognition_rule` STRING COMMENT 'Defines when revenue impact of this alteration is recognized: immediate (recognized at billing), deferred (spread over service period), prorated (proportional to service delivery), milestone (recognized at specific events).. Valid values are `immediate|deferred|prorated|milestone`',
    `service_type_filter` STRING COMMENT 'Comma-separated list of service types to which this alteration applies (e.g., mobile,broadband,iptv). Null means applies to all service types. Enables service-specific pricing modifications.',
    `source_system` STRING COMMENT 'Name of the operational system that created or manages this alteration rule (e.g., Netcracker Product Catalog, Amdocs Revenue Management). Used for data lineage and integration tracking.',
    `stacking_rule` STRING COMMENT 'Defines whether this alteration can be combined with other alterations: stackable (can combine with others), exclusive (cannot combine, only one applies), conditional (can combine only with specific alterations based on business rules).. Valid values are `stackable|exclusive|conditional`',
    `tax_treatment` STRING COMMENT 'Defines how tax is applied to this alteration: taxable (subject to standard tax), non_taxable (not subject to tax), tax_exempt (exempt from tax by regulation), tax_inclusive (alteration value includes tax).. Valid values are `taxable|non_taxable|tax_exempt|tax_inclusive`',
    `tenure_requirement_months` STRING COMMENT 'Minimum number of months a customer must have been active to qualify for this alteration. Used for loyalty discounts. Null if no tenure requirement applies.',
    `usage_threshold_quantity` DECIMAL(18,2) COMMENT 'Minimum usage quantity required to trigger this alteration. Used for volume discounts and tiered pricing. Null if no usage threshold applies.',
    `usage_threshold_unit` STRING COMMENT 'Unit of measure for the usage threshold quantity (e.g., minutes for voice, gigabytes for data). Null if no usage threshold applies.. Valid values are `minutes|gigabytes|messages|calls|sessions|transactions`',
    `value_type` STRING COMMENT 'Defines how the alteration value is calculated: percentage (percent of base price), absolute (fixed amount), tiered (varies by usage/volume bands), formula (complex calculation based on multiple factors).. Valid values are `percentage|absolute|tiered|formula`',
    `version_number` STRING COMMENT 'Version identifier for this alteration rule, supporting change tracking and audit requirements. Format: major.minor (e.g., 1.0, 2.3).. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_price_alteration PRIMARY KEY(`price_alteration_id`)
) COMMENT 'Defines reusable discount, surcharge, and price modification rules that can be applied to base price plans — including promotional discounts, loyalty rewards, volume discounts, bundle discounts, regulatory surcharges, and tax adjustments. Captures alteration type, value (absolute/percentage), application sequence, stacking rules (stackable/exclusive), eligibility conditions, and validity period. Child entity of price_plan — enables complex pricing logic and promotional mechanics without modifying the base charge structure. SSOT for all price modifications and discount definitions.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`promo_offer` (
    `promo_offer_id` BIGINT COMMENT 'Unique identifier for the promotional offer. Primary key for the promo_offer product.',
    `ab_test_id` BIGINT COMMENT 'Identifier of the marketing campaign associated with this promotional offer. Links the offer to broader marketing initiatives for performance tracking and attribution.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Marketing campaign managers own promotional offers in telecommunications - accountable for campaign ROI, budget management, and promotional effectiveness. Essential for tracking who designed bonus dat',
    `catalog_item_id` BIGINT COMMENT 'Identifier of the specific product catalog item to which this promotional offer applies. Null if offer applies to multiple products or product categories.',
    `coverage_area_id` BIGINT COMMENT 'Foreign key linking to location.coverage_area. Business justification: Promotions target specific coverage areas (e.g., "5G launch promo in downtown zones"); marketing campaigns are coverage-driven. Sales systems validate customer location coverage before applying covera',
    `lifecycle_status_id` BIGINT COMMENT 'Foreign key linking to product.lifecycle_status. Business justification: Promotional offer lifecycle (draft, active, expired, cancelled) must reference lifecycle_status.lifecycle_status_id. Current promo_status STRING should be replaced with FK for consistent status manage',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to content.ott_platform. Business justification: Promo offers include OTT platform trials (e.g., 3 months Disney+ free with new broadband plan). Critical for acquisition campaigns, partner co-marketing agreements, trial provisioning, and conversion ',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Partner-funded promotions and dealer incentive campaigns are standard in telecommunications distribution. Tracks which partner sponsors or funds a promotion, supporting cost allocation, partner market',
    `segment_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.segment_definition. Business justification: Promotional offers target specific customer segments (high-value, churn-risk, new customers). Enables targeted marketing campaigns and offer personalization. Standard telecom marketing practice.',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Promotions are territory-targeted for regional campaigns, competitive responses, and subsidy programs. Marketing systems enforce territory-based promo eligibility; budget allocation and performance tr',
    `vod_asset_id` BIGINT COMMENT 'Foreign key linking to content.vod_asset. Business justification: Promo offers grant free access to specific VOD assets (e.g., Watch Premiere Movie Free This Weekend). Required for promotional campaigns, content marketing, entitlement grants, and campaign performanc',
    `approval_status` STRING COMMENT 'Approval workflow status for the promotional offer. Indicates whether the offer has been reviewed and approved by authorized personnel before activation.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this promotional offer was approved. Null if not yet approved or approval not required.',
    `approved_by` STRING COMMENT 'Username or identifier of the person who approved this promotional offer for activation. Null if not yet approved or approval not required.',
    `auto_apply_flag` BOOLEAN COMMENT 'Indicates whether this promotional offer is automatically applied to eligible customers without requiring a promo code entry. True if auto-applied, False if customer must enter promo code.',
    `bonus_data_amount` DECIMAL(18,2) COMMENT 'Additional data allowance provided as part of the promotional offer, measured in the unit specified by bonus_data_unit. Applicable for mobile and broadband promotions.',
    `bonus_data_unit` STRING COMMENT 'Unit of measure for bonus data amount: GB (gigabytes), MB (megabytes), or TB (terabytes).. Valid values are `GB|MB|TB`',
    `budget_allocated` DECIMAL(18,2) COMMENT 'Total budget allocated for this promotional offer in the currency specified by discount_currency_code. Used to track promotional spending and prevent budget overruns.',
    `budget_consumed` DECIMAL(18,2) COMMENT 'Amount of promotional budget consumed to date through customer redemptions. Updated as offers are redeemed. Used for budget tracking and offer performance monitoring.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this promotional offer record was first created in the product catalog system.',
    `discount_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for fixed amount discounts (e.g., USD, EUR, GBP). Null for percentage-based discounts.. Valid values are `^[A-Z]{3}$`',
    `discount_type` STRING COMMENT 'Type of discount structure applied: percentage (percent off regular price), fixed_amount (dollar/currency amount off), tiered (discount varies by quantity or commitment), or bogo (buy one get one).. Valid values are `percentage|fixed_amount|tiered|bogo`',
    `discount_value` DECIMAL(18,2) COMMENT 'Numeric value of the discount. For percentage discounts, represents the percentage (e.g., 25.00 for 25% off). For fixed amount discounts, represents the currency amount. Interpretation depends on discount_type.',
    `effective_end_date` DATE COMMENT 'Date when this promotional offer expires and is no longer available for new redemptions. Null for open-ended offers without expiration.',
    `effective_start_date` DATE COMMENT 'Date when this promotional offer becomes active and available for customer redemption. Promotional offers cannot be redeemed before this date.',
    `eligibility_channel` STRING COMMENT 'Sales or service channel(s) through which this offer can be redeemed (e.g., online, retail_store, telesales, partner, mobile_app). Comma-separated list if multiple channels are eligible. Null if no channel restriction.',
    `eligibility_customer_segment` STRING COMMENT 'Specific customer segment(s) eligible for this offer (e.g., residential, small_business, enterprise, prepaid, postpaid). Comma-separated list if multiple segments are eligible. Null if no segment restriction.',
    `eligibility_customer_type` STRING COMMENT 'Customer type eligible for this promotional offer: new (new customers only), existing (current customers only), churned (win-back for former customers), or all (no customer type restriction).. Valid values are `new|existing|churned|all`',
    `eligibility_geographic_scope` STRING COMMENT 'Geographic region(s) where this promotional offer is valid. Can be country codes (ISO 3166-1 alpha-3), state/province codes, or region identifiers. Comma-separated list if multiple regions. Null if no geographic restriction.',
    `eligibility_product_category` STRING COMMENT 'Product category or categories to which this promotional offer applies (e.g., mobile_postpaid, fiber_broadband, iptv, voip, sd_wan). Comma-separated list if applicable to multiple categories. Null if offer applies to all products.',
    `external_reference_code` STRING COMMENT 'Identifier used to reference this promotional offer in external systems or partner platforms. Used for cross-system reconciliation and integration.',
    `free_trial_duration` STRING COMMENT 'Length of the free trial period measured in the unit specified by free_trial_unit. Applicable for free trial promotional offers.',
    `free_trial_unit` STRING COMMENT 'Unit of measure for free trial duration: days, months, or billing_cycles.. Valid values are `days|months|billing_cycles`',
    `last_modified_by` STRING COMMENT 'Username or identifier of the person who last modified this promotional offer record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this promotional offer record was last modified.',
    `marketing_message` STRING COMMENT 'Short marketing message or tagline used to promote this offer in customer-facing materials, advertisements, and digital channels.',
    `maximum_redemption_count` STRING COMMENT 'Maximum number of times this promotional offer can be redeemed across all customers. Used to cap total offer usage for budget control. Null if unlimited redemptions allowed.',
    `minimum_commitment_period` STRING COMMENT 'Minimum contract commitment period required to qualify for this promotional offer, measured in months. Null if no commitment required.',
    `priority_rank` STRING COMMENT 'Priority ranking used to determine which promotional offer to apply when multiple offers are eligible and stackable_flag is False. Lower numbers indicate higher priority.',
    `promo_category` STRING COMMENT 'Category of promotional benefit provided: discount (percentage or fixed amount off), free_trial (service at no charge for period), bonus_data (additional data allowance), device_subsidy (reduced device cost), bundle (package deal), or waived_fee (activation/installation fee waived).. Valid values are `discount|free_trial|bonus_data|device_subsidy|bundle|waived_fee`',
    `promo_code` STRING COMMENT 'Unique alphanumeric code that customers use to redeem the promotional offer. Used in order entry, self-service portals, and customer service systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `promo_description` STRING COMMENT 'Detailed description of the promotional offer including terms, benefits, and conditions. Used in marketing materials and customer communications.',
    `promo_name` STRING COMMENT 'Marketing name of the promotional offer displayed to customers and used in campaign materials.',
    `promo_type` STRING COMMENT 'Classification of the promotional offer based on its strategic purpose: acquisition (new customer), retention (existing customer), win-back (churned customer), seasonal (holiday/event-based), loyalty (reward program), or referral (customer referral incentive).. Valid values are `acquisition|retention|win_back|seasonal|loyalty|referral`',
    `redemption_limit_per_customer` STRING COMMENT 'Maximum number of times a single customer can redeem this promotional offer. Typically 1 for most offers. Null if no per-customer limit.',
    `source_system` STRING COMMENT 'Name of the source system from which this promotional offer record originated (e.g., Netcracker Product Catalog, Salesforce CRM, custom promotion management system).',
    `stackable_flag` BOOLEAN COMMENT 'Indicates whether this promotional offer can be combined (stacked) with other promotional offers. True if stackable, False if mutually exclusive with other offers.',
    `target_arpu_impact` DECIMAL(18,2) COMMENT 'Projected impact on Average Revenue Per User (ARPU) from this promotional offer, expressed as a currency amount. Negative values indicate expected ARPU reduction during promo period. Used for financial planning and offer ROI analysis.',
    `terms_and_conditions` STRING COMMENT 'Full legal terms and conditions governing the promotional offer including restrictions, disclaimers, and fine print. Used for regulatory compliance and customer disclosure.',
    `created_by` STRING COMMENT 'Username or identifier of the person who created this promotional offer record in the product catalog system.',
    CONSTRAINT pk_promo_offer PRIMARY KEY(`promo_offer_id`)
) COMMENT 'Defines time-limited promotional offers applied to catalog items or bundles — including introductory pricing, free trial periods, bonus data allowances, device subsidies, and retention offers. Captures promo code, promo type (acquisition, retention, win-back, seasonal), discount structure, eligibility criteria (new/existing customer, segment, channel), promo start/end dates, maximum redemption count, and campaign association. Supports both B2C and B2B promotional strategies.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`spec` (
    `spec_id` BIGINT COMMENT 'Unique identifier for the product specification record. Primary key for technical specification records defining detailed service characteristics, network requirements, and capability parameters.',
    `catalog_item_id` BIGINT COMMENT 'Reference to the parent product catalog item that this specification defines. Links technical specifications to the commercial product offering.',
    `content_channel_lineup_id` BIGINT COMMENT 'Foreign key linking to content.channel_lineup. Business justification: Product specs define which channel lineup is included in TV service tiers (Basic, Premium, Ultimate). Essential for product configuration, entitlement rules, provisioning systems, and customer communi',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Technical product managers define product specifications including data allowances, speed tiers, QoS parameters in telco operations - responsible for technical feasibility, network capacity planning, ',
    `allowance_quantity` DECIMAL(18,2) COMMENT 'Numeric quantity of the usage allowance. Defines the included amount (e.g., 50 GB data, 1000 voice minutes, unlimited). Use -1 or special value for unlimited allowances.',
    `allowance_type` STRING COMMENT 'Type of usage allowance for mobile and roaming products. Specifies the consumption category: data, voice minutes, SMS, roaming data, roaming voice, or international minutes. Applicable only to usage allowance specifications.. Valid values are `data|voice|sms|roaming_data|roaming_voice|international_minutes`',
    `bandwidth_mbps` DECIMAL(18,2) COMMENT 'Committed bandwidth in megabits per second for enterprise SD-WAN and MPLS circuits. Defines the guaranteed throughput for business connectivity products (e.g., 10 Mbps, 100 Mbps, 1 Gbps).',
    `burst_bandwidth_mbps` DECIMAL(18,2) COMMENT 'Burstable bandwidth in megabits per second for enterprise circuits. Defines the maximum temporary throughput allowed above committed rate (e.g., 100 Mbps committed, 200 Mbps burst).',
    `channel_count` STRING COMMENT 'Number of IPTV channels included in the package. Defines the content entitlement scope for television service offerings (e.g., 100 channels, 300 channels).',
    `characteristic_name` STRING COMMENT 'Name of the technical characteristic being specified. Extensible name-value pair key for product capabilities (e.g., data_allowance_gb, download_speed_mbps, channel_count, sla_uptime_percent).',
    `characteristic_value` DECIMAL(18,2) COMMENT 'Value of the technical characteristic. Stores the specification parameter value as string to support numeric, boolean, and enumerated values (e.g., 50, unlimited, true, gold_tier).',
    `concurrent_streams` STRING COMMENT 'Maximum number of simultaneous video streams allowed for IPTV and OTT services. Defines the multi-device viewing limit (e.g., 2 streams, 4 streams, unlimited).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the product specification record was first created in the system. Audit trail for specification lifecycle tracking.',
    `download_speed_mbps` DECIMAL(18,2) COMMENT 'Maximum download speed in megabits per second for broadband and mobile data products. Defines the advertised or guaranteed downstream bandwidth tier (e.g., 100 Mbps, 1 Gbps).',
    `dvr_hours` STRING COMMENT 'Cloud DVR storage capacity in hours of recording for IPTV services. Defines the network-based recording allowance (e.g., 50 hours, 200 hours, unlimited).',
    `effective_date` DATE COMMENT 'Date when this product specification becomes active and available for provisioning. Supports product lifecycle management and version control for specification changes.',
    `expiration_date` DATE COMMENT 'Date when this product specification is retired and no longer available for new provisioning. Null for active specifications. Supports product catalog lifecycle management.',
    `fair_use_limit_gb` DECIMAL(18,2) COMMENT 'Fair use policy limit in gigabytes for unlimited plans. Defines the threshold beyond which network management policies may apply (e.g., deprioritization, throttling). Regulatory compliance for unlimited offerings.',
    `is_rollover_enabled` BOOLEAN COMMENT 'Flag indicating whether unused allowance rolls over to the next billing cycle. True for rollover data plans. False for use-it-or-lose-it allowances.',
    `is_shared` BOOLEAN COMMENT 'Flag indicating whether the allowance is shared across multiple subscribers or devices. True for family plans and multi-device data pools. False for individual allowances.',
    `is_unlimited` BOOLEAN COMMENT 'Flag indicating whether the allowance is unlimited. True for unlimited data, voice, or SMS plans. False for metered allowances. Drives billing and network management policies.',
    `latency_ms` DECIMAL(18,2) COMMENT 'Maximum network latency in milliseconds guaranteed by the service. Defines the round-trip time SLA for latency-sensitive applications (e.g., 10ms for 5G URLLC, 50ms for broadband).',
    `modified_by` STRING COMMENT 'User or system identifier that last modified the product specification record. Audit trail for specification change accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the product specification record was last modified. Audit trail for specification change management and version control.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Guaranteed mean time to repair in hours per SLA. Defines the maximum average time to restore service after a fault (e.g., 4 hours, 8 hours, 24 hours). Applicable to enterprise and premium consumer products.',
    `overage_policy` STRING COMMENT 'Policy applied when usage exceeds allowance. Defines the enforcement action: block (hard cap), throttle (reduce speed), charge (pay-per-use), rollover (carry forward unused), or unlimited (no cap).. Valid values are `block|throttle|charge|rollover|unlimited`',
    `priority_level` STRING COMMENT 'Network traffic priority level for QoS enforcement. Numeric value where lower numbers indicate higher priority (e.g., 1=highest, 10=lowest). Maps to 3GPP QCI or 5G 5QI values.',
    `qos_class` STRING COMMENT 'Quality of Service tier assigned to the product. Defines the traffic prioritization and performance guarantees: best effort (no guarantee), guaranteed (SLA-backed), premium (high priority), or mission critical (highest priority).. Valid values are `best_effort|guaranteed|premium|mission_critical`',
    `reset_frequency` STRING COMMENT 'Frequency at which usage allowances reset. Defines the billing cycle for allowance renewal: monthly (standard), daily (roaming fair-use), weekly, annual, one-time (non-recurring), or never (lifetime).. Valid values are `monthly|daily|weekly|annual|one_time|never`',
    `roaming_data_allowance_gb` DECIMAL(18,2) COMMENT 'Data allowance in gigabytes available for roaming usage. Defines the fair-use limit for international data consumption. May differ from domestic allowance.',
    `roaming_zone` STRING COMMENT 'Geographic roaming zone configuration for mobile products. Defines the international roaming coverage area (e.g., Zone 1 Europe, Zone 2 Americas, Global). Maps to carrier roaming agreements.',
    `sla_tier` STRING COMMENT 'Service level tier for enterprise products. Defines the support and performance commitment level: bronze (basic), silver (standard), gold (premium), platinum (mission-critical). Determines MTTR and uptime guarantees.. Valid values are `bronze|silver|gold|platinum`',
    `sla_uptime_percent` DECIMAL(18,2) COMMENT 'Guaranteed service availability percentage per SLA. Defines the contractual uptime commitment (e.g., 99.9%, 99.99%, 99.999% for carrier-grade). Applicable to enterprise SD-WAN, MPLS, and premium broadband.',
    `spec_category` STRING COMMENT 'Functional category of the specification parameter. Groups specifications by purpose: usage allowance, network capability, service feature, QoS parameter, device capability, or pricing rule.. Valid values are `usage_allowance|network_capability|service_feature|qos_parameter|device_capability|pricing_rule`',
    `spec_description` STRING COMMENT 'Detailed description of the product specification. Provides business context and technical details for the characteristic definition. Used for product catalog documentation and customer communication.',
    `spec_name` STRING COMMENT 'Human-readable name of the product specification. Identifies the technical characteristic being defined (e.g., Data Allowance, Speed Tier, Channel Package).',
    `spec_status` STRING COMMENT 'Current lifecycle status of the product specification. Defines availability for provisioning: draft (under development), active (available), deprecated (phasing out), retired (no longer available).. Valid values are `draft|active|deprecated|retired`',
    `spec_type` STRING COMMENT 'Category of product specification defining the service domain. Determines which technical parameters are applicable (mobile, broadband, IPTV, VoIP, SD-WAN, MPLS, device, roaming, add-on). [ENUM-REF-CANDIDATE: mobile|broadband|iptv|voip|sdwan|mpls|device|roaming|addon — 9 candidates stripped; promote to reference product]',
    `technology_type` STRING COMMENT 'Network access technology used to deliver the service. Specifies the physical layer technology: fiber (FTTH), DSL, cable, LTE, 5G NR, GPON, VDSL, or DOCSIS. Determines capability boundaries. [ENUM-REF-CANDIDATE: fiber|dsl|cable|lte|5g|gpon|vdsl|docsis — 8 candidates stripped; promote to reference product]',
    `throttle_speed_mbps` DECIMAL(18,2) COMMENT 'Reduced data speed in megabits per second applied after allowance exhaustion. Applicable when overage_policy is throttle. Defines the post-allowance QoS degradation (e.g., 128 Kbps, 1 Mbps).',
    `unit_of_measure` STRING COMMENT 'Unit of measurement for numeric characteristic values. Defines the quantity unit (GB, Mbps, minutes, channels, percent, ms latency, concurrent streams). Null for non-numeric characteristics.',
    `upload_speed_mbps` DECIMAL(18,2) COMMENT 'Maximum upload speed in megabits per second for broadband and mobile data products. Defines the advertised or guaranteed upstream bandwidth tier (e.g., 20 Mbps, 500 Mbps).',
    `value_type` STRING COMMENT 'Data type of the characteristic value. Indicates how to interpret the characteristic_value field: numeric (quantities), boolean (flags), string (text), enumeration (predefined list), or range (min-max).. Valid values are `numeric|boolean|string|enumeration|range`',
    `version` STRING COMMENT 'Version identifier for the product specification. Supports specification change tracking and backward compatibility management (e.g., 1.0, 2.1, 3.0).',
    `created_by` STRING COMMENT 'User or system identifier that created the product specification record. Audit trail for specification authorship and accountability.',
    CONSTRAINT pk_spec PRIMARY KEY(`spec_id`)
) COMMENT 'Technical specification record for a catalog item defining detailed service characteristics, network requirements, and capability parameters as extensible name-value pairs. Covers all product types: mobile (data allowance, voice minutes, SMS, roaming entitlements, QoS), broadband (speed tiers, technology, latency SLA), IPTV (channels, streams, DVR), SD-WAN/MPLS (bandwidth, SLA tier), and roaming profiles (zone configurations, fair-use limits). Includes usage allowance definitions (allowance type, quantity, reset frequency, overage policy, throttle speed). Aligned with TM Forum SID specification pattern. SSOT for all technical product characteristics.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`eligibility_rule` (
    `eligibility_rule_id` BIGINT COMMENT 'Unique identifier for the eligibility rule. Primary key for the eligibility rule entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Business analysts define eligibility rules for product offerings in telco operations - responsible for credit class requirements, geographic restrictions, and customer segment targeting. Critical for ',
    `coverage_area_id` BIGINT COMMENT 'Foreign key linking to location.coverage_area. Business justification: Eligibility rules validate customer location coverage against product requirements; "fiber-only" plans require FTTP coverage validation. Sales qualification systems check coverage_area before allowing',
    `lifecycle_status_id` BIGINT COMMENT 'Foreign key linking to product.lifecycle_status. Business justification: Eligibility rule lifecycle (active, inactive, superseded) must reference lifecycle_status.lifecycle_status_id for consistent rule management. Current status STRING should be replaced with FK.',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.content_package. Business justification: Eligibility rules gate content package access (e.g., 4K content requires fiber, premium content requires credit check). Required for order validation, upsell targeting, and customer eligibility verifi',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Channel partners and MVNOs have specific eligibility rules (e.g., MVNO subscribers only, authorized dealer channels). Tracks partner-specific eligibility constraints for product offerings, supporting ',
    `offering_id` BIGINT COMMENT 'Reference to the product offering or promotional offer to which this eligibility rule applies. Links to the product catalog entry in Netcracker Product Catalog.',
    `rule_group_id` BIGINT COMMENT 'Identifier for a logical grouping of related eligibility rules that are evaluated together as a unit. Enables complex nested rule logic where groups of rules can be combined with AND/OR operators at the group level. Supports advanced eligibility scenarios for enterprise Software-Defined Wide Area Network (SD-WAN), Multiprotocol Label Switching (MPLS), and wholesale offerings.',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Eligibility rules enforce territory-specific restrictions due to franchise boundaries, regulatory zones, and credit policies. Order management validates customer territory against rule scope before pr',
    `approved_by` STRING COMMENT 'User identifier or name of the person who approved this eligibility rule for activation. Supports governance workflows and approval chains for product catalog changes. Nullable for rules that do not require formal approval.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this eligibility rule was formally approved for activation. Used for governance audit trail and compliance reporting. Nullable for rules that do not require formal approval. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `channel_applicability` STRING COMMENT 'Comma-separated list of sales and service channels where this eligibility rule applies. Examples include retail stores, online web portal, mobile app, telesales, partner channels, enterprise direct sales, Mobile Virtual Network Operator (MVNO) channels. Enables channel-specific eligibility logic for omnichannel product offerings.',
    `compliance_framework` STRING COMMENT 'Comma-separated list of regulatory or compliance frameworks that this eligibility rule supports or enforces. Examples include Federal Communications Commission (FCC) regulations, General Data Protection Regulation (GDPR), age verification requirements, Know Your Customer (KYC) rules, or industry-specific mandates from International Telecommunication Union (ITU), 3rd Generation Partnership Project (3GPP), or GSM Association (GSMA).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this eligibility rule record was first created in the system. Used for audit trail, data lineage, and compliance reporting. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `effective_end_date` DATE COMMENT 'The date after which this eligibility rule is no longer enforced. Nullable for rules with indefinite validity. Used to automatically expire promotional eligibility conditions, sunset legacy product offerings, and manage regulatory compliance windows. Format: yyyy-MM-dd.',
    `effective_start_date` DATE COMMENT 'The date from which this eligibility rule becomes active and is enforced in order management and service provisioning systems. Supports time-bound promotional offers, seasonal campaigns, and regulatory compliance effective dates. Format: yyyy-MM-dd.',
    `error_message` STRING COMMENT 'The user-facing error or informational message displayed when a customer or order fails to meet this eligibility condition. Provides clear guidance to Customer Relationship Management (CRM) agents and self-service portals on why a product cannot be purchased and what actions are required to become eligible.',
    `evaluation_frequency` STRING COMMENT 'Defines how often or under what conditions this eligibility rule is evaluated. Real-time evaluation occurs during order capture; periodic evaluation supports batch eligibility checks for existing customers; event-triggered evaluation responds to specific business events such as contract renewal, credit score update, or network upgrade.. Valid values are `real_time|daily|weekly|monthly|on_demand|event_triggered`',
    `external_rule_code` STRING COMMENT 'The unique identifier for this eligibility rule in external or upstream systems such as Netcracker Product Catalog, Salesforce CRM, or Oracle Communications Order and Service Management (OSM). Used for cross-system reconciliation, data integration, and troubleshooting.',
    `geographic_scope` STRING COMMENT 'Comma-separated list of geographic areas (countries, regions, states, postal codes, network coverage zones) where this eligibility rule applies. Uses ISO 3166-1 alpha-3 country codes and internal geographic identifiers. Supports location-based eligibility for Fiber to the Home (FTTH), 5G New Radio (5G NR), and regional promotional offers.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this eligibility rule must be satisfied (true) or is optional/advisory (false). Mandatory rules block order submission if not met; optional rules may generate warnings but allow order progression. Supports flexible eligibility frameworks for complex product bundles and promotional offers.',
    `is_overridable` BOOLEAN COMMENT 'Indicates whether authorized users (e.g., sales managers, retention specialists) can manually override this eligibility rule during order capture. Supports exception handling for high-value customers, retention scenarios, and special business cases while maintaining audit trail of overrides.',
    `logical_operator` STRING COMMENT 'Defines how this rule combines with other rules in the same eligibility rule set. AND requires all rules to be satisfied; OR requires at least one rule to be satisfied. Used to construct complex multi-condition eligibility expressions for bundled offerings, promotional campaigns, and segment-specific products.. Valid values are `AND|OR`',
    `market_segment` STRING COMMENT 'The target market segment to which this eligibility rule applies. Supports segment-specific product eligibility for Business-to-Consumer (B2C) consumer, prepaid, postpaid, Business-to-Business (B2B) small and medium business (SMB), enterprise, government, Mobile Virtual Network Operator (MVNO), wholesale, and Internet of Things (IoT) Machine-to-Machine (M2M) offerings. [ENUM-REF-CANDIDATE: b2c_consumer|b2c_prepaid|b2c_postpaid|b2b_smb|b2b_enterprise|b2b_government|mvno|wholesale|iot_m2m — 9 candidates stripped; promote to reference product]',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this eligibility rule. Supports audit trail and change tracking for product catalog governance. Integrates with Identity and Access Management (IAM) systems for user attribution.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this eligibility rule record was last modified. Used for audit trail, change tracking, and data synchronization across Business Support Systems (BSS) and Operations Support Systems (OSS). Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special instructions related to this eligibility rule. Used for internal documentation, implementation guidance, known issues, or business context that does not fit in structured fields.',
    `override_authorization_level` STRING COMMENT 'The minimum user role or authorization level required to override this eligibility rule. Enforces governance and controls around exception handling. Integrates with Customer Relationship Management (CRM) and Identity and Access Management (IAM) systems to validate user permissions during order capture.. Valid values are `agent|supervisor|manager|director|executive|system_admin`',
    `priority` STRING COMMENT 'The business priority or importance of this eligibility rule relative to other rules. Higher priority rules may take precedence in conflict resolution scenarios or be evaluated first in performance-optimized rule engines. Used for rule execution optimization in high-volume order management systems.',
    `product_category` STRING COMMENT 'Comma-separated list of product categories to which this eligibility rule applies. Examples include mobile plans, broadband packages, Internet Protocol Television (IPTV), Over-The-Top (OTT) bundles, Voice over Internet Protocol (VoIP) offerings, Software-Defined Wide Area Network (SD-WAN), Multiprotocol Label Switching (MPLS), devices, accessories, value-added services. Enables category-level eligibility management.',
    `rule_attribute` STRING COMMENT 'The specific customer, account, or context attribute that this rule evaluates. Examples include customer segment code, account type identifier, service address postal code, existing subscribed product identifier, credit score class, contract start date, device model identifier, network technology availability (Long-Term Evolution (LTE), 5G New Radio (5G NR)), customer age, or business employee count.',
    `rule_description` STRING COMMENT 'Detailed business description of the eligibility rule, including its purpose, business rationale, and any special conditions or exceptions. Used for documentation, training, and audit purposes within product management and compliance teams.',
    `rule_name` STRING COMMENT 'Human-readable name or label for the eligibility rule, used for identification and reporting purposes within Business Support Systems (BSS) and Customer Relationship Management (CRM) systems.',
    `rule_operator` STRING COMMENT 'The logical comparison operator used to evaluate the rule condition. Determines how the rule value is compared against customer or account attributes during order capture and service provisioning workflows in Operations Support Systems (OSS) and Business Support Systems (BSS). [ENUM-REF-CANDIDATE: equals|not_equals|in|not_in|greater_than|less_than|greater_than_or_equal|less_than_or_equal|contains|not_contains|between — 11 candidates stripped; promote to reference product]',
    `rule_sequence` STRING COMMENT 'The execution order or priority of this rule within the eligibility rule set. Lower numbers are evaluated first. Determines the sequence in which rules are applied during product eligibility validation in order management and service activation workflows.',
    `rule_source_system` STRING COMMENT 'The source system or module that originated or manages this eligibility rule. Examples include Netcracker Product Catalog, Salesforce CRM, Oracle Communications Order and Service Management (OSM), custom rule engine. Used for data lineage, troubleshooting, and system integration mapping.',
    `rule_type` STRING COMMENT 'The category or dimension of eligibility being evaluated. Defines the business domain of the rule such as customer segmentation (Business-to-Consumer (B2C), Business-to-Business (B2B), Mobile Virtual Network Operator (MVNO)), account classification, geographic restrictions, product dependencies, credit scoring, contract duration requirements, Customer Premises Equipment (CPE) compatibility, Radio Access Network (RAN) coverage, regulatory age limits, or enterprise size thresholds. [ENUM-REF-CANDIDATE: customer_segment|account_type|geographic_area|existing_product|credit_class|contract_tenure|device_compatibility|network_coverage|age_restriction|business_size — 10 candidates stripped; promote to reference product]',
    `rule_value` DECIMAL(18,2) COMMENT 'The target value or set of values against which the customer or account attribute is compared. May contain single values, comma-separated lists, numeric thresholds, geographic codes (ISO 3166-1 alpha-3), product codes, credit class identifiers, or tenure periods in months. Supports complex eligibility logic for multi-segment offerings.',
    `rule_version` STRING COMMENT 'Version identifier for this eligibility rule. Supports rule versioning and change management for product catalog governance. Enables tracking of rule evolution over time and rollback capabilities for Business Support Systems (BSS) configuration changes.',
    `tags` STRING COMMENT 'Comma-separated list of business tags or labels for categorization, search, and filtering of eligibility rules. Examples include promotional campaign identifiers, regulatory compliance markers, product launch wave identifiers, or business initiative codes. Supports flexible taxonomy and metadata management.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this eligibility rule. Supports audit trail and accountability for product catalog changes. Integrates with Identity and Access Management (IAM) systems for user attribution.',
    CONSTRAINT pk_eligibility_rule PRIMARY KEY(`eligibility_rule_id`)
) COMMENT 'Defines the eligibility conditions that govern which customers or segments can purchase a specific offering or promotional offer. Captures rule type (customer segment, account type, geographic area, existing product, credit class, contract tenure), rule operator (equals, in, greater_than), rule value, and logical combination (AND/OR). Supports complex eligibility logic for B2C, B2B, MVNO, and wholesale segments. Used by BSS/CRM systems during order capture to validate product eligibility.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`compatibility_rule` (
    `compatibility_rule_id` BIGINT COMMENT 'Unique identifier for the product compatibility rule. Primary key.',
    `lifecycle_status_id` BIGINT COMMENT 'Foreign key linking to product.lifecycle_status. Business justification: Compatibility rule lifecycle (active, inactive, superseded) must reference lifecycle_status.lifecycle_status_id for consistent rule management. Current rule_status STRING should be replaced with FK.',
    `catalog_item_id` BIGINT COMMENT 'Identifier of the product that is the subject of the compatibility rule. The product for which compatibility constraints are being defined.',
    `target_product_catalog_item_id` BIGINT COMMENT 'Identifier of the product that is the object of the compatibility rule. The product that the source product has a compatibility relationship with.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Technical analysts define product compatibility rules in telecommunications - responsible for device-plan compatibility, technology constraints (5G/4G), and bundle validation logic. Essential for orde',
    `approved_by` STRING COMMENT 'Username or identifier of the user who approved this compatibility rule for activation. Used for governance and compliance in product catalog change management.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this compatibility rule was approved for activation. Used for audit trail and compliance tracking in product catalog governance.',
    `channel` STRING COMMENT 'Sales channel to which this compatibility rule applies. Allows channel-specific product compatibility constraints. Null indicates rule applies to all channels.. Valid values are `retail|online|telesales|partner|enterprise_direct`',
    `constraint_operator` STRING COMMENT 'Operator used to evaluate the quantity constraint. Used in conjunction with quantity_constraint field. Example: greater_or_equal with quantity_constraint=2 means at least 2 units required.. Valid values are `equals|greater_than|less_than|greater_or_equal|less_or_equal`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this compatibility rule record was first created in the system. Used for audit trail and data lineage.',
    `customer_segment` STRING COMMENT 'Customer segment to which this compatibility rule applies. Allows segment-specific product compatibility constraints. Null indicates rule applies to all segments.. Valid values are `consumer|business|enterprise|wholesale|government`',
    `effective_end_date` DATE COMMENT 'Date after which the compatibility rule is no longer active. Nullable for rules with indefinite validity. Supports time-based rule expiration for limited-time offers and product retirements.',
    `effective_start_date` DATE COMMENT 'Date from which the compatibility rule becomes active and is enforced in order validation. Supports time-based rule activation for product launches and promotional campaigns.',
    `enforcement_level` STRING COMMENT 'Severity level for rule enforcement in order validation. Mandatory: order will be rejected if rule is violated. Warning: order proceeds with alert to user. Informational: rule displayed as guidance only.. Valid values are `mandatory|warning|informational`',
    `error_message` STRING COMMENT 'User-facing error or warning message displayed when the compatibility rule is violated during order validation. Should be clear and actionable for customer service representatives and self-service portals.',
    `external_rule_code` STRING COMMENT 'Identifier of this compatibility rule in the source system of record. Used for cross-system reconciliation and integration with Netcracker Product Catalog and Oracle Communications OSM.',
    `geographic_scope` STRING COMMENT 'Geographic region or market to which this compatibility rule applies. Examples: USA, CAN, GBR, EU. Supports region-specific product compatibility for regulatory or network availability reasons. Null indicates global applicability.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified this compatibility rule. Used for audit trail and change tracking in product catalog management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this compatibility rule record was last modified. Used for audit trail, change tracking, and data synchronization.',
    `notes` STRING COMMENT 'Free-form notes and comments about this compatibility rule. Used for internal documentation, special instructions, and business context that does not fit structured fields.',
    `override_allowed` BOOLEAN COMMENT 'Indicates whether authorized users can override this compatibility rule during order entry. True allows manual override with appropriate permissions. False enforces strict compliance.',
    `override_approval_required` BOOLEAN COMMENT 'Indicates whether rule override requires managerial or workflow approval. Used in conjunction with override_allowed flag. True requires approval workflow. False allows immediate override by authorized users.',
    `priority` STRING COMMENT 'Numeric priority for rule evaluation when multiple conflicting rules apply. Lower numbers indicate higher priority. Used to resolve rule conflicts in complex product catalogs.',
    `product_category` STRING COMMENT 'Category or family of products to which this rule applies. Examples: Mobile Plans, Broadband, IPTV, Devices, Enterprise Services. Used for rule filtering and catalog organization.',
    `quantity_constraint` STRING COMMENT 'Minimum or maximum quantity constraint for the target product when the rule is applied. Example: A family plan requires at least 2 lines. Null indicates no quantity constraint.',
    `rule_code` STRING COMMENT 'Business-readable unique code identifying this compatibility rule. Used for reference in order validation and product catalog management.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `rule_description` STRING COMMENT 'Detailed business description of the compatibility rule, including rationale and business context. Used for documentation and user guidance in product catalog and order management systems.',
    `rule_direction` STRING COMMENT 'Indicates whether the rule applies in one direction only (source to target) or both directions (mutual relationship). Unidirectional: A requires B does not imply B requires A. Bidirectional: A conflicts with B implies B conflicts with A.. Valid values are `unidirectional|bidirectional`',
    `rule_expression` STRING COMMENT 'Advanced rule logic expression for complex compatibility scenarios. Supports conditional logic, attribute-based rules, and multi-product dependencies. Used by rule engine for evaluation. Syntax follows Oracle Communications OSM rule expression language.',
    `rule_name` STRING COMMENT 'Human-readable name describing the compatibility rule. Example: 5G Plan Requires 5G Device, IPTV Conflicts with OTT Streaming.',
    `rule_type` STRING COMMENT 'Type of compatibility relationship between source and target products. Requires: target product must be co-subscribed. Conflicts: products are mutually exclusive. Recommends: target product is suggested but optional. Supersedes: source product replaces target product.. Valid values are `requires|conflicts|recommends|supersedes`',
    `source_system` STRING COMMENT 'Name of the source system or module that created or manages this compatibility rule. Examples: Netcracker Product Catalog, Oracle OSM, Manual Entry. Used for data lineage and troubleshooting.',
    `technology_type` STRING COMMENT 'Network technology or service delivery platform to which this compatibility rule applies. Used to enforce technology-specific product constraints. Example: 5G plans require 5G-capable devices. [ENUM-REF-CANDIDATE: 5G|LTE|FTTH|GPON|IPTV|VoLTE|SD-WAN|MPLS — 8 candidates stripped; promote to reference product]',
    `validation_scope` STRING COMMENT 'Scope at which the compatibility rule is evaluated. Order: rule applies within a single order. Subscription: rule applies across all products in a subscription. Account: rule applies across all subscriptions in an account. Customer: rule applies across all accounts for a customer.. Valid values are `order|subscription|account|customer`',
    `version_number` STRING COMMENT 'Version number of this compatibility rule. Incremented with each modification. Supports rule versioning and change history tracking in product catalog management.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this compatibility rule. Used for audit trail and accountability in product catalog management.',
    CONSTRAINT pk_compatibility_rule PRIMARY KEY(`compatibility_rule_id`)
) COMMENT 'Defines product compatibility and incompatibility constraints between catalog items and offerings — specifying which products can be co-subscribed (requires, recommends) and which are mutually exclusive (conflicts, supersedes). Captures source product, target product, rule type (requires, conflicts, recommends, supersedes), rule direction (unidirectional/bidirectional), and effective date range. Critical for order validation in Oracle Communications OSM and Netcracker OSS/BSS to prevent invalid product combinations.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`device_model` (
    `device_model_id` BIGINT COMMENT 'Unique identifier for the device model record. Primary key for the device model entity.',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Device models track network performance KPIs (data throughput, call drop rate, battery impact on network). Critical for RAN optimization and device certification. Real telecom network operations.',
    `lifecycle_status_id` BIGINT COMMENT 'Foreign key linking to product.lifecycle_status. Business justification: Device model lifecycle management (launch, active, discontinued, end-of-support) requires FK to lifecycle_status.lifecycle_status_id for standardized status tracking and automated workflow triggers.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Device product managers manage handset and equipment portfolios in telco operations - responsible for vendor negotiations, device lifecycle, subsidy strategies, and inventory planning. Critical for de',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Device models must comply with certification requirements (FCC Part 15, SAR limits, hearing aid compatibility per FCC rules). Product managers track regulatory approval status before market launch; co',
    `battery_capacity_mah` STRING COMMENT 'Battery capacity in milliampere-hours (mAh) for portable devices. Null for powered CPE (Customer Premises Equipment) and network infrastructure devices.',
    `color_variants` STRING COMMENT 'Comma-separated list of available color options for the device model (e.g., Black, White, Blue, Titanium). Used for inventory management and customer selection.',
    `compliance_certifications` STRING COMMENT 'Comma-separated list of regulatory compliance certifications (e.g., FCC, CE, RoHS, ENERGY STAR, PTCRB). Required for legal sale and operation in different jurisdictions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this device model record was first created in the product catalog system. Used for audit trails and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for pricing fields (e.g., USD, EUR, GBP). Used for multi-currency pricing and international operations.. Valid values are `^[A-Z]{3}$`',
    `device_category` STRING COMMENT 'Classification of the device type. CPE (Customer Premises Equipment) includes routers and modems; ONT (Optical Network Terminal) for FTTH (Fiber to the Home); OLT (Optical Line Terminal) for network infrastructure; STB (Set-Top Box) for IPTV (Internet Protocol Television) services. [ENUM-REF-CANDIDATE: smartphone|tablet|feature_phone|cpe_router|cpe_modem|ont|olt|stb|iot_device|wearable — 10 candidates stripped; promote to reference product]',
    `device_subcategory` STRING COMMENT 'Detailed subcategory within the device category for finer classification (e.g., flagship smartphone, budget smartphone, Wi-Fi 6 router, GPON ONT, 4K STB).',
    `dimensions` STRING COMMENT 'Physical dimensions of the device in millimeters, typically formatted as length x width x height (e.g., 146.7 x 71.5 x 7.8 mm). Used for packaging and display specifications.',
    `discontinuation_date` DATE COMMENT 'Date when the device model was discontinued from active sales. Null if still available. Used for inventory planning and customer migration strategies.',
    `display_resolution` STRING COMMENT 'Screen resolution in pixels (e.g., 1920x1080, 2560x1440, 3840x2160). Relevant for smartphones, tablets, and content consumption quality for IPTV and OTT services.',
    `display_size_inches` DECIMAL(18,2) COMMENT 'Screen diagonal size in inches for devices with displays (smartphones, tablets). Null for non-display devices like routers and ONT.',
    `drm_support` STRING COMMENT 'Comma-separated list of supported DRM (Digital Rights Management) systems (e.g., Widevine, FairPlay, PlayReady). Required for premium content protection in OTT and IPTV services.',
    `dual_sim_support` BOOLEAN COMMENT 'Indicates whether the device supports dual SIM functionality, allowing two active subscriptions simultaneously. Important for enterprise customers and international travelers.',
    `end_of_support_date` DATE COMMENT 'Date when manufacturer support, software updates, and warranty services end for this device model. Critical for SLA (Service Level Agreement) management and customer communication.',
    `esim_capable` BOOLEAN COMMENT 'Indicates whether the device supports eSIM (Embedded SIM) technology, enabling remote SIM provisioning without physical SIM card. Critical for digital service activation and MNP (Mobile Number Portability).',
    `ethernet_ports` STRING COMMENT 'Number of physical Ethernet ports available on CPE devices (routers, modems, ONT). Relevant for enterprise SD-WAN (Software-Defined Wide Area Network) and MPLS (Multiprotocol Label Switching) connectivity.',
    `frequency_bands` STRING COMMENT 'Comma-separated list of supported radio frequency bands for cellular connectivity (e.g., Band 1, Band 3, Band 7, Band 28, n78, n79 for 5G NR). Essential for RAN (Radio Access Network) compatibility and roaming.',
    `gps_enabled` BOOLEAN COMMENT 'Indicates whether the device has GPS (Global Positioning System) or GNSS (Global Navigation Satellite System) capability. Used for location-based services and emergency services (E911).',
    `imei_range_end` STRING COMMENT 'Ending IMEI number in the allocated range for this device model. Used with imei_range_start to validate device authenticity and prevent cloning.',
    `imei_range_start` STRING COMMENT 'Starting IMEI (International Mobile Equipment Identity) number in the allocated range for this device model. Used for device registration, activation, and fraud prevention in HLR (Home Location Register) and HSS (Home Subscriber Server).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this device model record. Used for change tracking, synchronization, and audit compliance.',
    `launch_date` DATE COMMENT 'Official market launch date when the device model became available for sale. Used for product lifecycle tracking and promotional planning.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactures the device (e.g., Apple, Samsung, Nokia, Huawei, Cisco, Ericsson).',
    `model_name` STRING COMMENT 'Commercial marketing name of the device model as presented to customers (e.g., iPhone 14 Pro, Galaxy S23 Ultra, Nokia ONT G-010S-A).',
    `model_number` STRING COMMENT 'Manufacturer-assigned model number or SKU (Stock Keeping Unit) used for inventory and catalog management. Unique identifier within manufacturers product line.',
    `nfc_enabled` BOOLEAN COMMENT 'Indicates whether the device supports NFC (Near Field Communication) for contactless payments and data exchange. Relevant for mobile payment services and digital wallet integration.',
    `operating_system` STRING COMMENT 'Operating system platform and version running on the device (e.g., iOS 17, Android 14, HarmonyOS, proprietary firmware). Impacts application compatibility and OTT (Over-The-Top) service delivery.',
    `processor_chipset` STRING COMMENT 'Processor or chipset model powering the device (e.g., Apple A17 Pro, Qualcomm Snapdragon 8 Gen 3, MediaTek Dimensity 9300). Indicates device performance tier.',
    `ram_capacity_gb` STRING COMMENT 'RAM memory capacity in gigabytes. Impacts device performance and ability to run advanced applications and services.',
    `retail_price` DECIMAL(18,2) COMMENT 'Manufacturer suggested retail price (MSRP) or standard retail price in the base currency. Used for pricing strategies, promotional offers, and revenue forecasting (ARPU - Average Revenue Per User calculations).',
    `sar_value` DECIMAL(18,2) COMMENT 'Specific Absorption Rate (SAR) value in watts per kilogram (W/kg), measuring radio frequency energy absorption. Required for regulatory compliance (FCC, ICNIRP guidelines) for mobile devices.',
    `storage_capacity_gb` STRING COMMENT 'Internal storage capacity of the device in gigabytes. Relevant for smartphones, tablets, and STB (Set-Top Box) devices with local recording capability.',
    `supplier_code` STRING COMMENT 'Internal code identifying the primary supplier or distributor for this device model. Used for procurement, inventory management, and supply chain tracking in ERP (Enterprise Resource Planning) systems.',
    `tac_code` STRING COMMENT '8-digit Type Allocation Code forming the first 8 digits of the IMEI. Uniquely identifies the device model and manufacturer. Used by network systems for device identification and policy enforcement.',
    `technology_support` STRING COMMENT 'Comma-separated list of supported network technologies and standards (e.g., 4G LTE, 5G NR, VoLTE, Wi-Fi 6, Wi-Fi 6E, GPON, Bluetooth 5.2). Critical for network compatibility and service provisioning.',
    `usb_ports` STRING COMMENT 'Number of USB ports available on the device. Used for charging, data transfer, and peripheral connectivity.',
    `video_codec_support` STRING COMMENT 'Comma-separated list of supported video codecs (e.g., H.264, H.265/HEVC, VP9, AV1). Essential for IPTV, OTT content delivery, and video call quality.',
    `voip_capable` BOOLEAN COMMENT 'Indicates whether the device supports VoIP (Voice over Internet Protocol) functionality. Critical for IMS (IP Multimedia Subsystem) service delivery and VoLTE (Voice over LTE) compatibility.',
    `warranty_period_months` STRING COMMENT 'Standard manufacturer warranty period in months. Used for service provisioning, insurance offerings, and customer support planning.',
    `water_resistance_rating` STRING COMMENT 'IP (Ingress Protection) rating for water and dust resistance (e.g., IP67, IP68). Indicates device durability and suitability for outdoor or harsh environments.',
    `weight_grams` STRING COMMENT 'Physical weight of the device in grams. Relevant for logistics, shipping cost calculation, and customer information.',
    `wholesale_cost` DECIMAL(18,2) COMMENT 'Wholesale acquisition cost from manufacturer or distributor. Used for margin analysis, CAPEX (Capital Expenditure) planning, and profitability calculations (EBITDA - Earnings Before Interest Taxes Depreciation and Amortization).',
    `wifi_standard` STRING COMMENT 'Supported Wi-Fi standard (e.g., Wi-Fi 5 (802.11ac), Wi-Fi 6 (802.11ax), Wi-Fi 6E). Critical for CPE devices and home broadband service quality (QoS - Quality of Service).',
    CONSTRAINT pk_device_model PRIMARY KEY(`device_model_id`)
) COMMENT 'Master record for handsets, CPE (Customer Premises Equipment), ONT (Optical Network Terminal), routers, set-top boxes, and other devices offered through the product catalog. Captures device model name, manufacturer, device category (smartphone, tablet, CPE, ONT, STB, router), technology support (4G/LTE, 5G NR, Wi-Fi 6, GPON), eSIM capability, operating system, storage/RAM specs, color variants, IMEI range, and device status (available, end-of-life). SSOT for device catalog definitions.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`device_offering` (
    `device_offering_id` BIGINT COMMENT 'Unique identifier for the device offering. Primary key for this entity.',
    `bundle_id` BIGINT COMMENT 'Reference to a predefined accessory bundle (e.g., case, screen protector, charger) that can be included with this device offering. Null if no bundle defined.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to finance.capital_project. Business justification: Large device procurement programs (fleet purchases, retail inventory builds) are tracked as capital projects for budget management, ROI analysis, and capital expenditure reporting in telecom operation',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to interconnect.carrier_agreement. Business justification: Device offerings with international roaming capabilities must reference carrier agreements to validate network compatibility and roaming entitlements. Critical for device certification processes and e',
    `device_model_id` BIGINT COMMENT 'Reference to the specific device model (e.g., iPhone 15 Pro, Samsung Galaxy S24) that this offering is based on.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Device inventory (especially subsidized handsets) is capitalized as fixed assets and depreciated over contract terms. Standard telecom accounting practice for device financing programs and subsidy cos',
    `lifecycle_status_id` BIGINT COMMENT 'Foreign key linking to product.lifecycle_status. Business justification: Device offering lifecycle (active, promotional, discontinued) must reference lifecycle_status table for consistent state management across all product offering types.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to content.ott_platform. Business justification: Device offerings frequently include OTT platform trials (e.g., Buy iPhone, get 6 months Apple TV+ free). Essential for device promotions, partner co-marketing, entitlement grants, and revenue share tr',
    `partner_id` BIGINT COMMENT 'Reference to the supplier or manufacturer providing the device inventory for this offering (e.g., Apple, Samsung, Motorola).',
    `price_plan_id` BIGINT COMMENT 'Reference to the service plan (rate plan) that must be activated with this device offering. Null if no specific plan requirement exists.',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Device subsidies, trade-in programs, and inventory allocation are territory-specific. Regulatory device approvals and warranty service coverage vary by territory; inventory planning uses territory-bas',
    `bundle_eligible` BOOLEAN COMMENT 'Indicates whether this device offering can be bundled with other products or services (e.g., broadband, Internet Protocol Television - IPTV, accessories).',
    `channel_availability` STRING COMMENT 'Comma-separated list of sales channels where this device offering is available (e.g., retail_store,online,telesales,partner_dealer,enterprise_direct). Enables channel-specific product catalog filtering.',
    `contract_term_months` STRING COMMENT 'Required service contract commitment duration in months associated with this device offering. Common for subsidized offerings. Null if no contract commitment required.',
    `created_by_user` STRING COMMENT 'User identifier or system account that created this device offering record in the product catalog.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this device offering record was first created in the product catalog system.',
    `credit_check_required` BOOLEAN COMMENT 'Indicates whether a credit check is required to qualify for this device offering, typically true for installment plans and subsidized offerings.',
    `customer_segment` STRING COMMENT 'Target customer segment for this device offering: consumer (individual retail), small business (SMB), enterprise (large corporate), government, or wholesale (Mobile Virtual Network Operator - MVNO partners).. Valid values are `consumer|small_business|enterprise|government|wholesale`',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Amount of security deposit required if deposit_required is true. Null if no deposit required.',
    `deposit_required` BOOLEAN COMMENT 'Indicates whether a security deposit is required for customers who do not meet standard credit requirements but are approved with conditions.',
    `down_payment_amount` DECIMAL(18,2) COMMENT 'Initial down payment required for installment plan or lease offerings. Null for outright purchase or fully subsidized offerings.',
    `early_termination_fee` DECIMAL(18,2) COMMENT 'Fee charged if customer terminates service contract before the contract term expires, typically used to recover device subsidy. Null if no ETF applies.',
    `effective_end_date` DATE COMMENT 'Date when this device offering is no longer available for new sales. Null for offerings with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this device offering becomes available for sale and order capture in the product catalog.',
    `full_retail_price` DECIMAL(18,2) COMMENT 'Full retail price of the device without any subsidies, discounts, or installment plans. Represents the outright purchase price.',
    `geographic_availability` STRING COMMENT 'Geographic regions or markets where this device offering is available, using comma-separated country codes (ISO 3166-1 alpha-3) or region identifiers.',
    `installment_term_months` STRING COMMENT 'Duration of the Equipment Installment Plan (EIP) in months over which the device balance is financed. Common values: 12, 24, 30, 36 months. Null for non-installment offerings.',
    `insurance_eligible` BOOLEAN COMMENT 'Indicates whether device insurance or protection plans can be attached to this offering.',
    `inventory_sku` STRING COMMENT 'Stock Keeping Unit (SKU) code used in inventory management systems to track physical device stock for this offering.',
    `last_modified_by_user` STRING COMMENT 'User identifier or system account that last modified this device offering record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this device offering record was last updated, tracking changes to pricing, terms, or availability.',
    `minimum_credit_score` STRING COMMENT 'Minimum credit score required to qualify for this device offering. Null if no credit requirement or credit check not required.',
    `minimum_plan_arpu` DECIMAL(18,2) COMMENT 'Minimum Average Revenue Per User (ARPU) threshold for the associated service plan required to qualify for this device offering, typically used for subsidized or promotional offerings.',
    `monthly_installment_amount` DECIMAL(18,2) COMMENT 'Fixed monthly payment amount for installment plan offerings, calculated as (offering_price - down_payment) / installment_term_months. Null for non-installment offerings.',
    `network_compatibility` STRING COMMENT 'Comma-separated list of network technologies supported by the device (e.g., 5G NR,LTE,VoLTE,WiFi-6). Ensures device compatibility with network infrastructure.',
    `offering_code` STRING COMMENT 'Unique business identifier code for the device offering used in product catalog and order management systems.',
    `offering_name` STRING COMMENT 'Commercial name of the device offering as presented to customers (e.g., iPhone 15 Pro 256GB - 24 Month Plan).',
    `offering_price` DECIMAL(18,2) COMMENT 'Actual price charged to the customer for this specific offering, which may differ from full retail price based on offering type (e.g., subsidized price, down payment for installment).',
    `offering_type` STRING COMMENT 'Type of commercial device offering model: outright purchase (full payment upfront), installment plan (Equipment Installment Plan - EIP), subsidized with contract (device discount tied to service plan), lease (return device at end), or device-as-a-service (subscription model).. Valid values are `outright_purchase|installment_plan|subsidized_contract|lease|device_as_a_service`',
    `promotional_offering` BOOLEAN COMMENT 'Indicates whether this is a limited-time promotional device offering with special pricing or terms.',
    `residual_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the device at the end of a lease term, representing the buyout price if customer chooses to purchase. Null for non-lease offerings.',
    `restocking_fee` DECIMAL(18,2) COMMENT 'Fee charged when a device is returned within the return period. Null if no restocking fee applies.',
    `return_period_days` STRING COMMENT 'Number of days within which customer can return the device for a full refund, per consumer protection regulations and company policy.',
    `sim_type_required` STRING COMMENT 'Type of Subscriber Identity Module (SIM) required or supported by this device offering: physical SIM card, embedded SIM (eSIM), dual SIM capability, or SIM-free (unlocked device).. Valid values are `physical_sim|esim|dual_sim|sim_free`',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Amount of subsidy applied to reduce the device price, typically tied to a service contract commitment. Null for non-subsidized offerings.',
    `trade_in_eligible` BOOLEAN COMMENT 'Indicates whether this device offering is eligible for trade-in programs where customers can exchange old devices for credit toward the new device.',
    `unlock_eligibility_days` STRING COMMENT 'Number of days after activation before the device becomes eligible for unlocking. Null if device is unlocked or unlock not applicable.',
    `unlock_eligible` BOOLEAN COMMENT 'Indicates whether the device can be unlocked for use on other carriers after contract obligations are met, per Federal Communications Commission (FCC) regulations.',
    `warranty_period_months` STRING COMMENT 'Duration of the manufacturer warranty included with the device offering, typically 12 or 24 months.',
    CONSTRAINT pk_device_offering PRIMARY KEY(`device_offering_id`)
) COMMENT 'Links device models to commercial offerings defining how devices are sold — outright purchase, installment plan (EIP), subsidized with contract, or lease. Captures device offering price, subsidy amount, installment term (months), down payment, residual value (for lease), associated plan requirement, channel availability, and effective date range. Enables device-as-a-service and installment billing models tracked in Amdocs Revenue Management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`addon` (
    `addon_id` BIGINT COMMENT 'Unique identifier for the add-on product. Primary key.',
    `coverage_area_id` BIGINT COMMENT 'Foreign key linking to location.coverage_area. Business justification: Add-ons have coverage prerequisites (e.g., "5G data boost" requires 5G coverage); sales systems validate customer location coverage before allowing add-on purchase. Critical for technology-dependent a',
    `iot_tariff_id` BIGINT COMMENT 'Foreign key linking to interconnect.iot_tariff. Business justification: International roaming addons (travel passes, data boosters) priced using IOT tariff rates for specific destination zones. Essential for margin analysis, ensuring addon pricing covers wholesale settlem',
    `lifecycle_status_id` BIGINT COMMENT 'Foreign key linking to product.lifecycle_status. Business justification: Addon lifecycle (active, deprecated, end-of-sale) must reference lifecycle_status.lifecycle_status_id for consistent status management. Current addon_status STRING should be replaced with FK.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to content.ott_platform. Business justification: Add-ons provision OTT platform subscriptions (e.g., Netflix Standard addon). Critical for OTT partner billing, provisioning automation, revenue share calculations, and customer self-service portals.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Product managers create and manage addon offerings (international roaming packs, data boosters, content subscriptions) in telecommunications - accountable for addon portfolio performance, attach rates',
    `spec_id` BIGINT COMMENT 'Reference to the primary base product offering that this add-on is compatible with. Null if the add-on is compatible with multiple base products (see compatibility rules).',
    `vod_catalog_id` BIGINT COMMENT 'Foreign key linking to content.vod_catalog. Business justification: Add-ons grant access to specific VOD catalogs (e.g., Premium Movies addon unlocks premium catalog). Required for upsell campaigns, entitlement provisioning, billing integration, and content library ma',
    `activation_method` STRING COMMENT 'Method by which the add-on is activated on the customer subscription. Instant: immediate activation; Scheduled: activation at specified date/time; Manual approval: requires CSR or system approval; Provisioning required: requires network provisioning workflow.. Valid values are `instant|scheduled|manual_approval|provisioning_required`',
    `addon_category` STRING COMMENT 'Classification of the add-on product type. Determines the functional category and business rules applicable to the add-on. [ENUM-REF-CANDIDATE: data_topup|voice_pack|sms_pack|international_calling|roaming|premium_content|cloud_storage|security|static_ip|device_insurance — 10 candidates stripped; promote to reference product]',
    `addon_code` STRING COMMENT 'Unique business identifier code for the add-on product used in product catalog and billing systems. Examples: DATA_5GB, INTL_CALL_100, PREMIUM_SPORTS.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `addon_description` STRING COMMENT 'Detailed business description of the add-on product, including features, benefits, and usage terms. Used for customer-facing documentation and sales materials.',
    `addon_name` STRING COMMENT 'Human-readable name of the add-on product displayed to customers and in product catalogs.',
    `addon_type` STRING COMMENT 'Billing model type for the add-on. One-time: single charge; Recurring: periodic subscription; Usage-based: pay-per-use; Hybrid: combination of recurring and usage.. Valid values are `one_time|recurring|usage_based|hybrid`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the add-on automatically renews at the end of its validity period. True: auto-renews; False: requires manual renewal or expires.',
    `billing_frequency` STRING COMMENT 'Frequency at which the add-on charge is billed to the customer. Applicable for recurring and usage-based add-ons. One-time add-ons are billed once at activation. [ENUM-REF-CANDIDATE: one_time|daily|weekly|monthly|quarterly|annually|usage_triggered — 7 candidates stripped; promote to reference product]',
    `channel_availability` STRING COMMENT 'Comma-separated list of sales and service channels through which the add-on can be purchased or activated. Examples: web, mobile_app, retail_store, call_center, partner_portal. [ENUM-REF-CANDIDATE: web|mobile_app|retail_store|call_center|partner_portal|self_service|agent_assisted|third_party — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the add-on product record was first created in the product catalog system. Immutable audit field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the price amount. Examples: USD, EUR, GBP, JPY.. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Target customer segment for the add-on product. Defines eligibility based on customer classification. Examples: consumer, small_business, enterprise, government, wholesale. [ENUM-REF-CANDIDATE: consumer|small_business|mid_market|enterprise|government|wholesale|MVNO|partner — promote to reference product]',
    `deactivation_method` STRING COMMENT 'Method by which the add-on is deactivated or removed from the customer subscription. Instant: immediate removal; End of period: deactivation at billing cycle end; Manual: requires CSR intervention; Grace period: deactivation after notice period.. Valid values are `instant|end_of_period|manual|grace_period`',
    `effective_end_date` DATE COMMENT 'Date after which the add-on is no longer available for new sales. Existing subscriptions may continue beyond this date based on contract terms. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which the add-on becomes available for sale and activation in the product catalog. Add-ons cannot be sold before this date.',
    `external_product_code` STRING COMMENT 'Identifier for the add-on product in external systems such as partner catalogs, wholesale platforms, or third-party marketplaces. Used for system integration and cross-reference.',
    `geographic_scope` STRING COMMENT 'Geographic regions or countries where the add-on is available for sale and use. Comma-separated list of ISO 3166-1 alpha-3 country codes or region identifiers. Examples: USA, CAN, MEX for North America; GBR, FRA, DEU for Europe.',
    `gl_account_code` STRING COMMENT 'General ledger account code for revenue posting in the financial system. Used for financial reporting and reconciliation of add-on revenue.. Valid values are `^[0-9]{4,10}$`',
    `last_modified_by` STRING COMMENT 'User identifier or system account that last updated the add-on product record. Used for audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the add-on product record was last updated in the product catalog system. Updated with each modification.',
    `max_quantity_per_subscription` STRING COMMENT 'Maximum number of instances of this add-on that can be attached to a single customer subscription. Null indicates no limit. Example: customer can purchase up to 5 data top-up add-ons per month.',
    `min_quantity_per_subscription` STRING COMMENT 'Minimum number of instances of this add-on required when attached to a subscription. Typically 1 or null. Used for bundled add-ons with minimum purchase requirements.',
    `price_amount` DECIMAL(18,2) COMMENT 'Standard price amount for the add-on in the default currency. For recurring add-ons, this is the periodic charge amount. For one-time add-ons, this is the single purchase price.',
    `pricing_model` STRING COMMENT 'Pricing structure applied to the add-on. Flat rate: fixed price; Tiered: price varies by usage tier; Volume: discount based on quantity; Usage-based: pay-per-unit; Freemium: free with premium upgrade; Promotional: temporary discount pricing.. Valid values are `flat_rate|tiered|volume|usage_based|freemium|promotional`',
    `product_family` STRING COMMENT 'High-level product family or portfolio to which the add-on belongs. Examples: Mobile Services, Broadband Services, Enterprise Solutions, Digital Content, IoT Services. Used for product hierarchy and reporting.',
    `promotion_code` STRING COMMENT 'Unique code identifying the promotional campaign associated with this add-on. Null if not promotional. Used for tracking campaign performance and eligibility validation.. Valid values are `^[A-Z0-9_-]{0,20}$`',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether the add-on is part of a promotional campaign with special pricing or terms. True: promotional offer; False: standard catalog offering.',
    `proration_allowed_flag` BOOLEAN COMMENT 'Indicates whether the add-on charge is prorated when activated or deactivated mid-billing cycle. True: charge is prorated; False: full charge applies regardless of activation date.',
    `quota_unit` STRING COMMENT 'Unit of measure for the quota value. Defines what the quota_value represents. Examples: GB for data, minutes for voice, SMS for messaging, channels for IPTV. [ENUM-REF-CANDIDATE: GB|MB|minutes|SMS|channels|users|GB_storage|static_IP|incidents — 9 candidates stripped; promote to reference product]',
    `quota_value` DECIMAL(18,2) COMMENT 'Numeric value representing the allowance or quota provided by the add-on. Examples: 5 GB data, 100 international minutes, 500 SMS. Used in conjunction with quota_unit.',
    `revenue_recognition_rule` STRING COMMENT 'Accounting rule for revenue recognition of the add-on charges. Immediate: recognize at sale; Deferred: recognize over service period; Prorated: recognize proportionally; Usage-based: recognize as consumed.. Valid values are `immediate|deferred|prorated|usage_based`',
    `rollover_allowed_flag` BOOLEAN COMMENT 'Indicates whether unused quota from the current period can roll over to the next period. True: unused quota carries forward; False: quota expires at period end.',
    `service_level` STRING COMMENT 'Quality of Service (QoS) tier or Service Level Agreement (SLA) class associated with the add-on. Determines priority, support level, and performance guarantees.. Valid values are `standard|premium|gold|platinum|enterprise`',
    `short_description` STRING COMMENT 'Brief summary of the add-on product for display in mobile apps, web portals, and point-of-sale systems. Typically 1-2 sentences.',
    `source_system` STRING COMMENT 'Name of the operational system of record that manages this add-on product. Examples: Netcracker Product Catalog, Amdocs CRM, Oracle Product Hub. Used for data lineage and troubleshooting.',
    `tax_code` STRING COMMENT 'Tax classification code used by billing and revenue systems to determine applicable taxes, fees, and regulatory charges. Examples: TELECOM_SERVICE, DIGITAL_CONTENT, EQUIPMENT_SALE.. Valid values are `^[A-Z0-9_-]{0,20}$`',
    `technology_type` STRING COMMENT 'Network technology or service delivery platform required for the add-on. Defines technical compatibility constraints. Examples: 5G NR for 5G data add-ons, FTTH for fiber broadband add-ons, VoLTE for voice add-ons. [ENUM-REF-CANDIDATE: 4G_LTE|5G_NR|FTTH|GPON|DSL|cable|satellite|fixed_wireless|VoLTE|VoIP — 10 candidates stripped; promote to reference product]',
    `trial_period_days` STRING COMMENT 'Number of days for which the add-on is offered as a free trial before billing begins. Null if no trial period is available. Common values: 7, 14, 30 days.',
    `validity_period_unit` STRING COMMENT 'Unit of time for the validity period. Examples: 30 days, 1 month, 1 year. Perpetual indicates no expiration.. Valid values are `day|week|month|year|perpetual`',
    `validity_period_value` STRING COMMENT 'Numeric value representing the duration for which the add-on remains active after activation. Used in conjunction with validity_period_unit. Null for perpetual add-ons.',
    `version_number` STRING COMMENT 'Version number of the add-on product specification. Incremented with each significant change to pricing, features, or terms. Used for change management and historical tracking.',
    `created_by` STRING COMMENT 'User identifier or system account that created the add-on product record in the product catalog. Used for audit trail and accountability.',
    CONSTRAINT pk_addon PRIMARY KEY(`addon_id`)
) COMMENT 'Defines optional add-on products that can be attached to a base offering — including data top-ups, international calling packs, premium channel subscriptions, cloud storage upgrades, static IP add-ons, and security packages. Captures add-on code, add-on category, compatible base offerings, pricing model, maximum quantity per subscription, auto-renewal flag, and validity period. Supports both one-time and recurring add-ons across mobile, broadband, and enterprise product lines.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`sla_template` (
    `sla_template_id` BIGINT COMMENT 'Unique identifier for the SLA template. Primary key for the SLA template entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: SLA templates are assigned to cost centers for service delivery cost tracking, penalty provisioning, and operational expense allocation. Required for telecom service cost management and SLA financial ',
    `lifecycle_status_id` BIGINT COMMENT 'Foreign key linking to product.lifecycle_status. Business justification: SLA template lifecycle (draft, active, deprecated) must reference lifecycle_status.lifecycle_status_id. Current template_status STRING should be replaced with FK.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Wholesale and MVNO agreements require partner-specific SLA templates defining service levels, penalties, and measurement methods. Tracks which partner an SLA template applies to, supporting partner SL',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: SLA commitments often derive from regulatory mandates (FCC broadband performance disclosure rules, EU net neutrality QoS requirements). Compliance officers verify SLA templates meet regulatory minimum',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Service delivery managers define SLA templates for enterprise and business customers in telecommunications - accountable for uptime commitments, MTTR targets, and penalty structures. Essential for ope',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: SLA commitments vary by territory based on technician availability, site density, and service infrastructure. Enterprise contracts specify territory-specific MTTR; service delivery planning uses terri',
    `approved_by` STRING COMMENT 'User identifier or name of the person who approved this SLA template for production use. Null if not yet approved.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA template was approved for production use. Null if not yet approved.',
    `availability_target_percent` DECIMAL(18,2) COMMENT 'Committed service availability percentage (e.g., 99.999% for five-nines, 99.95%, 99.5%). Represents the percentage of time the service must be operational within the measurement window.',
    `bandwidth_guarantee_mbps` DECIMAL(18,2) COMMENT 'Guaranteed minimum bandwidth in megabits per second. Defines the committed information rate for the service.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA template record was first created in the system.',
    `customer_segment` STRING COMMENT 'Target customer segment for this SLA template (Enterprise, Business, SME, Consumer, Government, Wholesale). SLA commitments typically vary by segment.. Valid values are `enterprise|business|sme|consumer|government|wholesale`',
    `effective_end_date` DATE COMMENT 'Date after which this SLA template is no longer available for new contracts. Existing contracts may continue under this template. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which this SLA template becomes available for use in product offerings and contracts.',
    `escalation_matrix` STRING COMMENT 'Structured escalation path defining roles and timeframes for incident escalation (e.g., L1 Support → L2 Support → Engineering → Management). May reference external escalation document.',
    `exclusions` STRING COMMENT 'Circumstances or events excluded from SLA calculations (e.g., scheduled maintenance, force majeure, customer-caused outages, third-party failures outside provider control).',
    `geographic_scope` STRING COMMENT 'Geographic regions or countries where this SLA template applies (e.g., USA, EUR, APAC, Global). May be comma-separated list of ISO 3166-1 alpha-3 country codes.',
    `jitter_threshold_ms` DECIMAL(18,2) COMMENT 'Maximum acceptable jitter (variation in packet delay) in milliseconds. Critical for voice and video quality.',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified this SLA template record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA template record was last modified in the system.',
    `latency_threshold_ms` DECIMAL(18,2) COMMENT 'Maximum acceptable network latency in milliseconds. Critical for real-time services like VoIP, video conferencing, and enterprise applications.',
    `maintenance_window` STRING COMMENT 'Scheduled maintenance windows during which SLA commitments may be suspended (e.g., Sunday 02:00-06:00 UTC, first Saturday of month). Defines planned downtime allowances.',
    `max_penalty_percent` DECIMAL(18,2) COMMENT 'Maximum penalty as a percentage of monthly recurring charges that can be applied in a single measurement period. Caps the financial liability.',
    `measurement_method` STRING COMMENT 'Technical method used to measure SLA compliance (e.g., synthetic monitoring, passive monitoring, agent-based, network probe, end-to-end testing).',
    `measurement_window` STRING COMMENT 'Time period over which SLA metrics are measured and evaluated (e.g., Monthly, Quarterly, Annual, Rolling 30-day, Rolling 90-day).. Valid values are `monthly|quarterly|annual|rolling_30_day|rolling_90_day`',
    `mttr_target_hours` DECIMAL(18,2) COMMENT 'Maximum committed mean time to repair in hours. Defines the average time allowed to restore service after a fault or outage.',
    `notification_lead_time_hours` DECIMAL(18,2) COMMENT 'Minimum advance notice in hours required for planned maintenance or service changes. Defines customer notification commitment.',
    `packet_loss_threshold_percent` DECIMAL(18,2) COMMENT 'Maximum acceptable packet loss percentage. Defines the upper limit for packet loss before SLA breach occurs.',
    `penalty_calculation_method` STRING COMMENT 'Formula or method used to calculate penalties when SLA is breached (e.g., percentage of monthly fee, tiered based on breach severity, fixed amount per incident).',
    `penalty_type` STRING COMMENT 'Type of penalty or remedy applied when SLA is breached (Service Credit, Refund, Rebate, None). Defines the financial consequence structure.. Valid values are `service_credit|refund|rebate|none`',
    `regulatory_compliance` STRING COMMENT 'Regulatory frameworks or standards this SLA template complies with (e.g., FCC requirements, GDPR, HIPAA, PCI-DSS, SOC 2). May be comma-separated list.',
    `reporting_format` STRING COMMENT 'Format in which SLA reports are delivered (e.g., PDF, Excel, dashboard, API, portal access). May be comma-separated list.',
    `reporting_frequency` STRING COMMENT 'Frequency at which SLA performance reports are provided to the customer (Real-time, Daily, Weekly, Monthly, Quarterly).. Valid values are `real_time|daily|weekly|monthly|quarterly`',
    `resolution_time_priority_1_hours` DECIMAL(18,2) COMMENT 'Maximum resolution time in hours for Priority 1 (critical) incidents. Defines the time commitment to fully resolve service-affecting issues.',
    `resolution_time_priority_2_hours` DECIMAL(18,2) COMMENT 'Maximum resolution time in hours for Priority 2 (high) incidents. Defines resolution commitment for high-impact but non-critical issues.',
    `resolution_time_priority_3_hours` DECIMAL(18,2) COMMENT 'Maximum resolution time in hours for Priority 3 (medium) incidents. Defines resolution commitment for moderate-impact issues.',
    `response_time_priority_1_hours` DECIMAL(18,2) COMMENT 'Maximum response time in hours for Priority 1 (critical) incidents. Defines how quickly support must respond to service-affecting issues.',
    `response_time_priority_2_hours` DECIMAL(18,2) COMMENT 'Maximum response time in hours for Priority 2 (high) incidents. Defines response commitment for high-impact but non-critical issues.',
    `response_time_priority_3_hours` DECIMAL(18,2) COMMENT 'Maximum response time in hours for Priority 3 (medium) incidents. Defines response commitment for moderate-impact issues.',
    `service_type` STRING COMMENT 'Type of telecommunications service this SLA template applies to (e.g., SD-WAN, MPLS, Broadband, FTTH, VoIP, IPTV, Managed Services, Enterprise Connectivity).',
    `sla_template_description` STRING COMMENT 'Detailed description of the SLA template including its purpose, target use cases, and key differentiators from other SLA tiers.',
    `support_channel` STRING COMMENT 'Available support channels under this SLA (e.g., phone, email, portal, dedicated account manager, on-site support). May be comma-separated list.',
    `support_hours` STRING COMMENT 'Hours during which support is available under this SLA (24x7, Business Hours, Extended Hours). Defines the temporal scope of support commitments.. Valid values are `24x7|business_hours|extended_hours`',
    `template_code` STRING COMMENT 'Business identifier code for the SLA template used in product catalog and contract management systems. Externally visible unique code.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `template_name` STRING COMMENT 'Human-readable name of the SLA template (e.g., Gold Enterprise SLA, Silver Business Broadband SLA, Bronze MPLS SLA).',
    `terms_and_conditions_url` STRING COMMENT 'URL or document reference to the full legal terms and conditions governing this SLA template.',
    `tier` STRING COMMENT 'Service tier classification indicating the level of service commitment (Platinum, Gold, Silver, Bronze, Standard, Basic). Higher tiers typically offer stricter performance guarantees and faster response times.. Valid values are `platinum|gold|silver|bronze|standard|basic`',
    `version_number` STRING COMMENT 'Version identifier for the SLA template following semantic versioning (e.g., 1.0, 2.1, 3.0.1). Tracks template evolution over time.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this SLA template record in the product catalog system.',
    CONSTRAINT pk_sla_template PRIMARY KEY(`sla_template_id`)
) COMMENT 'Defines SLA (Service Level Agreement) templates associated with product offerings — particularly for enterprise SD-WAN/MPLS, broadband, and managed services products. Captures SLA tier name (Gold, Silver, Bronze), availability target (%), MTTR commitment (hours), latency threshold (ms), packet loss threshold (%), jitter threshold (ms), measurement window, penalty structure, and escalation matrix. Provides the contractual service quality commitments embedded in product definitions for B2B and enterprise segments.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`relationship` (
    `relationship_id` BIGINT COMMENT 'Unique identifier for the product relationship record. Primary key.',
    `lifecycle_status_id` BIGINT COMMENT 'Foreign key linking to product.lifecycle_status. Business justification: Product relationship lifecycle (active, inactive, superseded) must reference lifecycle_status.lifecycle_status_id for consistent relationship management. Current relationship_status STRING should be r',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Product strategists define cross-sell, upsell, and migration relationships between products in telco portfolio management - accountable for upgrade paths, bundle strategies, and product lifecycle tran',
    `spec_id` BIGINT COMMENT 'Identifier of the originating product in the relationship. The product from which the relationship is defined.',
    `target_product_product_spec_id` BIGINT COMMENT 'Identifier of the destination product in the relationship. The product to which the relationship points.',
    `approved_by` STRING COMMENT 'Username or identifier of the user who approved this product relationship for production use. Used for governance and compliance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this product relationship was approved for production use. Used for governance and compliance audit trail.',
    `channel` STRING COMMENT 'The sales or service channel through which this relationship rule is enforced. Allows channel-specific product bundling and compatibility rules.. Valid values are `web|mobile_app|retail_store|call_center|partner|dealer`',
    `constraint_operator` STRING COMMENT 'Logical operator used when multiple relationship rules are combined. AND requires all conditions to be met; OR requires at least one; NOT excludes the target; XOR requires exactly one of multiple options.. Valid values are `AND|OR|NOT|XOR`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this product relationship record was first created in the system. Used for audit trail and data lineage.',
    `customer_segment` STRING COMMENT 'The customer segment for which this relationship rule applies. Allows different compatibility rules for consumer vs. enterprise customers.. Valid values are `consumer|small_business|enterprise|government|wholesale`',
    `direction` STRING COMMENT 'Indicates whether the relationship applies in one direction only (unidirectional) or both directions (bidirectional). Bidirectional relationships apply the same rule from source to target and target to source.. Valid values are `unidirectional|bidirectional`',
    `effective_end_date` DATE COMMENT 'The date after which this product relationship is no longer active. Nullable for open-ended relationships. Used to manage product lifecycle transitions and regulatory compliance windows.',
    `effective_start_date` DATE COMMENT 'The date from which this product relationship becomes active and enforceable. Relationships are not evaluated before this date.',
    `eligibility_condition` STRING COMMENT 'Business rule expression defining when this relationship applies. May reference customer segment, account type, geographic region, or other contextual attributes. Expressed in rule engine syntax.',
    `enforcement_level` STRING COMMENT 'Defines the strictness of the relationship rule. Mandatory rules block order submission if violated; recommended rules generate warnings; informational rules provide guidance without enforcement.. Valid values are `mandatory|recommended|informational`',
    `error_message` STRING COMMENT 'User-facing error message displayed when the relationship constraint is violated during order entry or product configuration. Should clearly explain the constraint and suggest corrective action.',
    `external_rule_code` STRING COMMENT 'The unique identifier of this relationship rule in the source system. Used for traceability and synchronization with upstream product catalog systems.',
    `geographic_scope` STRING COMMENT 'Geographic region or market in which this relationship applies. May be country code, state/province, or custom market identifier. Used for region-specific product availability and regulatory compliance.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified this product relationship record. Used for audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this product relationship record was last modified. Used for audit trail and change tracking.',
    `migration_incentive_description` STRING COMMENT 'Textual description of the migration incentive offer, including discount amount, waived fees, or promotional terms. Displayed to customer service representatives and customers during guided selling.',
    `migration_incentive_flag` BOOLEAN COMMENT 'Indicates whether a promotional incentive or discount is available when migrating from source to target product. Used for supersession and migration path relationships to drive product lifecycle transitions.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, business rationale, or implementation guidance for this product relationship. Used by product managers and catalog administrators.',
    `override_allowed` BOOLEAN COMMENT 'Indicates whether authorized users can override this relationship constraint. Used for business exceptions and special customer accommodations.',
    `override_approval_required` BOOLEAN COMMENT 'Indicates whether management approval is required to override this relationship constraint. Used for high-value or high-risk exceptions.',
    `priority` STRING COMMENT 'Numeric priority used to resolve conflicts when multiple relationship rules apply to the same product pair. Lower numbers indicate higher priority. Rules are evaluated in priority order.',
    `product_category` STRING COMMENT 'The product category or line of business to which this relationship applies. Used to scope relationship rules to specific product domains (e.g., mobile, broadband, IPTV, enterprise).',
    `quantity_max` STRING COMMENT 'Maximum quantity of the target product allowed in the relationship. Used for conflicts and exclusivity rules (e.g., only one premium plan allowed per account).',
    `quantity_min` STRING COMMENT 'Minimum quantity of the target product required to satisfy the relationship constraint. Used for requires relationships where multiple units are needed (e.g., a bundle requires at least 2 add-ons).',
    `relationship_type` STRING COMMENT 'The nature of the relationship between source and target products. Defines the semantic meaning of the association (e.g., requires indicates dependency, conflicts indicates mutual exclusivity, supersedes indicates product replacement).. Valid values are `requires|conflicts|recommends|supersedes|migration_path|upsell`',
    `rule_expression` STRING COMMENT 'Machine-readable expression of the relationship constraint in rule engine syntax. Used by Oracle OSM and Netcracker OSS/BSS for automated order validation and product configuration.',
    `source_system` STRING COMMENT 'The operational system that originated or manages this product relationship record (e.g., Netcracker Product Catalog, Oracle OSM, Salesforce CPQ).',
    `technology_type` STRING COMMENT 'The underlying network technology or platform to which this relationship applies (e.g., LTE, 5G NR, FTTH, GPON, MPLS, SD-WAN). Used for technology-specific compatibility rules.',
    `validation_scope` STRING COMMENT 'The business context in which this relationship rule is evaluated. Order-level rules apply at order submission; cart-level rules apply during shopping; subscription-level rules apply to active services; account-level rules apply across all customer products.. Valid values are `order|cart|subscription|account`',
    `version_number` STRING COMMENT 'Version number of this product relationship record. Incremented with each modification to support change history and optimistic locking.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this product relationship record. Used for audit trail and accountability.',
    CONSTRAINT pk_relationship PRIMARY KEY(`relationship_id`)
) COMMENT 'SSOT for all formal relationships, constraints, and compatibility rules between catalog items and offerings. Captures compatibility constraints (requires, conflicts, recommends, supersedes), commercial relationships (supersession, migration path, upsell, cross-sell), and dependency chains. Stores relationship type, source product, target product, direction (unidirectional/bidirectional), rule operator, eligibility conditions, migration incentive flag, and effective date range. Consolidates all inter-product compatibility rules previously managed separately — including technical compatibility (device-to-plan, plan-to-addon), commercial exclusivity, and regulatory co-subscription restrictions. Used by CRM, order management (Oracle OSM), and Netcracker OSS/BSS for order validation, guided selling, and product lifecycle transitions. Single authoritative source for all inter-product relationships and constraints.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`lifecycle_status` (
    `lifecycle_status_id` BIGINT COMMENT 'Unique identifier for the product lifecycle status record. Primary key for the lifecycle status reference table.',
    `dq_rule_id` BIGINT COMMENT 'Foreign key linking to analytics.dq_rule. Business justification: Lifecycle status values require data quality validation rules (valid status transitions, mandatory fields by status). Ensures product data integrity. Standard telecom data governance.',
    `superseded_by_status_lifecycle_status_id` BIGINT COMMENT 'Reference to the lifecycle status that replaces this status definition when it is retired. Null for active status definitions. Maintains historical lineage.',
    `previous_lifecycle_status_id` BIGINT COMMENT 'Self-referencing FK on lifecycle_status (previous_lifecycle_status_id)',
    `allowed_predecessor_statuses` STRING COMMENT 'Comma-separated list of lifecycle status codes from which products can transition into this status. Defines valid state transition rules in the product lifecycle state machine.',
    `allowed_successor_statuses` STRING COMMENT 'Comma-separated list of lifecycle status codes to which products can transition from this status. Defines valid forward state transitions in the product lifecycle state machine.',
    `allows_existing_customers` BOOLEAN COMMENT 'Boolean flag indicating whether existing customers can continue to use and maintain products in this lifecycle status. Typically true even for end-of-sale products.',
    `allows_new_customers` BOOLEAN COMMENT 'Boolean flag indicating whether new customers can acquire products in this lifecycle status. False for end-of-sale statuses where only existing customers can maintain service.',
    `approval_authority_level` STRING COMMENT 'Organizational level required to approve transition to this lifecycle status. Higher-risk transitions (e.g., end-of-life) require senior authority.. Valid values are `product_manager|director|vp|cxo`',
    `approval_required` BOOLEAN COMMENT 'Boolean flag indicating whether transitioning a product to this lifecycle status requires formal approval from product management or governance authority.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lifecycle status record was first created in the system. Supports audit trail and temporal analysis of reference data changes.',
    `display_sequence` STRING COMMENT 'Numeric ordering value used to control the display sequence of lifecycle statuses in user interfaces, reports, and dropdown lists. Lower values appear first.',
    `effective_end_date` DATE COMMENT 'Date after which this lifecycle status definition is no longer active. Null for currently active status definitions. Supports temporal versioning and status retirement.',
    `effective_start_date` DATE COMMENT 'Date from which this lifecycle status definition becomes active and available for use in the product catalog. Supports temporal versioning of status definitions.',
    `external_status_code` STRING COMMENT 'Status code used in external systems or partner integrations that maps to this internal lifecycle status. Supports cross-system status synchronization and API integration.',
    `is_active_status` BOOLEAN COMMENT 'Boolean flag indicating whether this lifecycle status represents an active, sellable state. True for statuses where products can be actively marketed and sold to customers.',
    `is_downgradeable` BOOLEAN COMMENT 'Boolean flag indicating whether customers can downgrade from products in this lifecycle status to lower-tier offerings. Controls product migration and retention workflows.',
    `is_orderable` BOOLEAN COMMENT 'Boolean flag indicating whether products in this lifecycle status can be ordered by customers through sales channels. Controls order capture and fulfillment system behavior.',
    `is_provisionable` BOOLEAN COMMENT 'Boolean flag indicating whether products in this lifecycle status can be provisioned and activated in network and service delivery systems. Controls service fulfillment workflows.',
    `is_renewable` BOOLEAN COMMENT 'Boolean flag indicating whether existing subscriptions for products in this lifecycle status can be renewed at contract expiration. Controls retention and renewal workflows.',
    `is_system_status` BOOLEAN COMMENT 'Boolean flag indicating whether this lifecycle status is system-defined and cannot be modified or deleted by users. True for core statuses required by platform logic.',
    `is_upgradeable` BOOLEAN COMMENT 'Boolean flag indicating whether customers with products in this lifecycle status can upgrade to newer offerings. Controls product migration and upsell workflows.',
    `last_modified_by` STRING COMMENT 'User identifier or system account that last modified this lifecycle status record. Supports audit trail and change tracking for reference data governance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lifecycle status record was last modified. Supports audit trail, change detection, and incremental data processing workflows.',
    `migration_deadline_days` STRING COMMENT 'Number of days from status transition date by which customers must migrate to alternative products. Null if no migration deadline applies. Used for end-of-life planning.',
    `notification_lead_time_days` STRING COMMENT 'Minimum number of days advance notice required before transitioning products to this lifecycle status. Null if no notification required. Ensures regulatory compliance.',
    `notification_required` BOOLEAN COMMENT 'Boolean flag indicating whether customers must be notified when their product transitions to this lifecycle status. True for end-of-sale and end-of-life statuses.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Boolean flag indicating whether transitions to this lifecycle status must be reported to regulatory authorities such as Federal Communications Commission (FCC) or state public utility commissions.',
    `requires_migration` BOOLEAN COMMENT 'Boolean flag indicating whether customers must be migrated off products in this lifecycle status by a specific date. True for end-of-life statuses requiring mandatory customer transitions.',
    `source_system` STRING COMMENT 'Name of the operational system that is the authoritative source for this lifecycle status definition. Typically Netcracker Product Catalog for product lifecycle statuses.',
    `status_category` STRING COMMENT 'High-level grouping of lifecycle statuses into major phases: pre-launch (concept, design, testing), active (available for sale), sunset (end-of-sale, end-of-life), retired (no longer supported).. Valid values are `pre-launch|active|sunset|retired`',
    `status_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the lifecycle status within the product catalog system. Used as a business key for system integration and API references.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `status_description` STRING COMMENT 'Detailed explanation of what the lifecycle status represents, including business implications, operational constraints, and typical use cases within the product catalog.',
    `status_name` STRING COMMENT 'Human-readable name of the product lifecycle status. Displayed in user interfaces and reports to indicate the current state of a product offering in its lifecycle.',
    `status_version` STRING COMMENT 'Version number of this lifecycle status definition. Incremented when status rules, transitions, or attributes are modified. Supports change tracking and audit.',
    `supports_billing` BOOLEAN COMMENT 'Boolean flag indicating whether products in this lifecycle status continue to generate billing charges and invoices. False for retired products with no ongoing billing.',
    `supports_usage_rating` BOOLEAN COMMENT 'Boolean flag indicating whether usage events for products in this lifecycle status are rated and charged. Controls Call Detail Record (CDR) processing and usage-based billing.',
    `visible_in_catalog` BOOLEAN COMMENT 'Boolean flag indicating whether products in this lifecycle status are visible in customer-facing product catalogs and self-service portals. False for internal-only or retired products.',
    `visible_in_channel` STRING COMMENT 'Comma-separated list of sales channels where products in this lifecycle status are visible and available for sale. Examples: web, mobile, retail, telesales, partner. Empty if not visible in any channel.',
    `created_by` STRING COMMENT 'User identifier or system account that created this lifecycle status record. Supports audit trail and accountability for reference data management.',
    CONSTRAINT pk_lifecycle_status PRIMARY KEY(`lifecycle_status_id`)
) COMMENT 'Reference table defining product lifecycle states (concept, design, active, end-of-sale, end-of-life, retired) with transition rules and effective dates governing catalog item availability';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`category` (
    `category_id` BIGINT COMMENT 'Unique identifier for the product category. Primary key for the product category taxonomy.',
    `analytical_subject_area_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_subject_area. Business justification: Product categories organize analytical subject areas (Mobile Analytics, Broadband Analytics, Enterprise Services). Enables category-based analytics and reporting. Standard telecom data architecture.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Product categories are assigned to cost centers for product line cost allocation, profitability analysis, and portfolio management. Standard telecom practice for hierarchical cost tracking and product',
    `employee_id` BIGINT COMMENT 'Reference to the product manager or business owner responsible for this category in the product catalog management system.',
    `parent_category_id` BIGINT COMMENT 'Reference to the parent category in the hierarchical taxonomy. Null for top-level categories (Mobile, Broadband, TV, Enterprise).',
    `approval_status` STRING COMMENT 'Current approval workflow status for this category in the product catalog governance process.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'Username or identifier of the person who approved this category for publication in the product catalog.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this category was approved for use in the product catalog.',
    `billing_frequency` STRING COMMENT 'Standard billing cycle frequency for products in this category.. Valid values are `monthly|quarterly|annual|one_time|usage_based|daily`',
    `category_code` STRING COMMENT 'Unique business identifier code for the product category used in catalog systems and reporting. Examples: MOB_POSTPAID, BB_FIBER, IPTV_PREMIUM, ENT_SDWAN.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `category_description` STRING COMMENT 'Detailed description of the product category including its purpose, scope, and the types of products it contains.',
    `category_name` STRING COMMENT 'Human-readable name of the product category displayed in catalogs and user interfaces. Examples: Mobile Postpaid, Fiber Broadband, IPTV Premium, Enterprise SD-WAN.',
    `category_type` STRING COMMENT 'Market segment classification for the category indicating the target customer base.. Valid values are `consumer|business|enterprise|wholesale|mvno`',
    `channel_availability` STRING COMMENT 'Comma-separated list of sales channels where products in this category can be sold. Examples: retail,online,telesales,partner,enterprise_direct.',
    `contract_term_months` STRING COMMENT 'Typical contract commitment period in months for products in this category. Null for no-contract categories.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this category record was first created in the product catalog system.',
    `customer_segment` STRING COMMENT 'Primary customer segment targeted by products in this category for marketing and eligibility purposes. [ENUM-REF-CANDIDATE: mass_market|premium|youth|senior|soho|smb|mid_market|enterprise|government|wholesale — 10 candidates stripped; promote to reference product]',
    `display_order` STRING COMMENT 'Numeric sequence for ordering categories in catalog navigation, marketing materials, and user interfaces. Lower numbers appear first.',
    `effective_end_date` DATE COMMENT 'Date when this product category is retired from the catalog. Null for categories with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this product category becomes active and available in the catalog for product assignment and sales.',
    `external_reference_code` STRING COMMENT 'External system identifier for this category used for integration with upstream source systems such as Netcracker Product Catalog or legacy catalog systems.',
    `geographic_scope` STRING COMMENT 'Geographic markets or regions where this product category is available. Comma-separated list of ISO 3166-1 alpha-3 country codes or regional identifiers.',
    `gl_account_code` STRING COMMENT 'Default General Ledger account code for revenue booking of products in this category.. Valid values are `^[0-9]{4,10}$`',
    `hierarchy_level` STRING COMMENT 'Numeric level in the category hierarchy. Level 1 for top-level categories (Mobile, Broadband, TV, Enterprise), Level 2 for sub-categories, Level 3 for further subdivisions.',
    `icon_url` STRING COMMENT 'URL path to the icon or image asset representing this category in digital channels and user interfaces.',
    `is_bundleable` BOOLEAN COMMENT 'Indicates whether products in this category can be included in bundle offerings with products from other categories.',
    `is_standalone` BOOLEAN COMMENT 'Indicates whether products in this category can be sold as standalone offerings without requiring other products or services.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the person who last modified this category record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this category record was last updated in the product catalog system.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the product category in the catalog management system.. Valid values are `active|inactive|deprecated|planned|retired`',
    `marketing_label` STRING COMMENT 'Customer-facing marketing label or brand name for this category used in promotional materials and campaigns.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special instructions related to this product category.',
    `pricing_model` STRING COMMENT 'Default pricing and billing model for products in this category. [ENUM-REF-CANDIDATE: postpaid|prepaid|hybrid|usage_based|subscription|one_time|freemium — 7 candidates stripped; promote to reference product]',
    `regulatory_classification` STRING COMMENT 'Regulatory service classification for compliance reporting to governing bodies such as Federal Communications Commission (FCC), International Telecommunication Union (ITU), or regional regulators.',
    `requires_device` BOOLEAN COMMENT 'Indicates whether products in this category require Customer Premises Equipment (CPE) or device hardware for service delivery.',
    `revenue_recognition_rule` STRING COMMENT 'Accounting rule code for revenue recognition applicable to products in this category per financial reporting standards.',
    `roaming_eligible` BOOLEAN COMMENT 'Indicates whether products in this category include or support international roaming capabilities.',
    `search_keywords` STRING COMMENT 'Comma-separated list of keywords and tags for search engine optimization and catalog search functionality.',
    `service_domain` STRING COMMENT 'High-level service domain classification for grouping related product categories. Aligns with Operations Support Systems (OSS) and Business Support Systems (BSS) service taxonomy. [ENUM-REF-CANDIDATE: mobile|broadband|voice|video|data|messaging|iot|cloud|security|managed_services — 10 candidates stripped; promote to reference product]',
    `sla_tier` STRING COMMENT 'Default Service Level Agreement tier for products in this category defining quality of service commitments.. Valid values are `basic|standard|premium|enterprise|carrier_grade`',
    `source_system` STRING COMMENT 'Name of the operational system of record that is the authoritative source for this category. Examples: Netcracker_Product_Catalog, Legacy_Catalog_System.',
    `supports_esim` BOOLEAN COMMENT 'Indicates whether products in this category support embedded SIM technology for remote provisioning and activation.',
    `supports_mnp` BOOLEAN COMMENT 'Indicates whether products in this category support Mobile Number Portability allowing customers to retain their phone numbers when switching carriers.',
    `tax_category` STRING COMMENT 'Tax classification code for products in this category used for tax calculation and compliance reporting.',
    `technology_type` STRING COMMENT 'Primary network technology or service delivery platform associated with this category. Examples: 5G for mobile categories, GPON for fiber broadband, SD-WAN for enterprise connectivity. [ENUM-REF-CANDIDATE: 5g|lte|3g|fiber|dsl|cable|satellite|voip|ims|sdwan|mpls|ott|iptv|gpon|volte — 15 candidates stripped; promote to reference product]',
    `version_number` STRING COMMENT 'Version number for tracking changes to the category definition over time. Incremented with each modification.',
    `created_by` STRING COMMENT 'Username or identifier of the person who created this category record in the product catalog system.',
    CONSTRAINT pk_category PRIMARY KEY(`category_id`)
) COMMENT 'Hierarchical product categorization taxonomy — top-level categories (mobile, broadband, TV, enterprise), sub-categories, and classification rules for reporting and catalog navigation';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` (
    `device_supply_agreement_id` BIGINT COMMENT 'Unique identifier for this device supply agreement record. Primary key.',
    `device_model_id` BIGINT COMMENT 'Foreign key linking to the device model being supplied under this agreement',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the partner (equipment vendor, distributor, or manufacturer) supplying the device',
    `agreement_status` STRING COMMENT 'Current lifecycle status of this supply agreement. Active agreements are eligible for procurement. Suspended agreements are temporarily inactive. Expired/Terminated agreements are historical.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply agreement record was created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this supply agreement expires or is terminated. Null for open-ended agreements. Supports historical tracking of supply relationships.',
    `effective_start_date` DATE COMMENT 'Date when this supply agreement becomes effective. Supports temporal tracking of supply relationships and pricing changes over time.',
    `inventory_allocation_quantity` STRING COMMENT 'Committed inventory allocation quantity for this device model from this partner. Represents guaranteed supply capacity under the agreement.',
    `lead_time_days` STRING COMMENT 'Number of days from order placement to delivery for this device model from this partner. Critical for inventory planning and customer promise dates.',
    `minimum_order_quantity` STRING COMMENT 'Minimum order quantity (MOQ) required by the partner for this device model. Impacts procurement batch sizing and inventory holding costs.',
    `preferred_supplier_flag` BOOLEAN COMMENT 'Indicates whether this partner is the preferred supplier for this device model. Used in procurement routing logic when multiple suppliers are available.',
    `return_policy_days` STRING COMMENT 'Number of days within which unsold or defective devices can be returned to the partner under this agreement. Varies by partner and device category.',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Device subsidy amount provided by the partner (e.g., manufacturer marketing development funds) to reduce effective device cost. Common in telecommunications device procurement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply agreement record was last updated.',
    `warranty_terms` STRING COMMENT 'Warranty terms provided by the partner for this device model (e.g., 12 months parts and labor, 24 months manufacturer warranty). Impacts customer service commitments.',
    `wholesale_cost` DECIMAL(18,2) COMMENT 'Per-unit wholesale cost paid to the partner for this device model. Varies by partner and negotiated contract terms. Used for margin calculation and procurement decisions.',
    CONSTRAINT pk_device_supply_agreement PRIMARY KEY(`device_supply_agreement_id`)
) COMMENT 'This association product represents the commercial supply contract between device_model and partner. It captures the procurement terms, pricing, inventory allocation, and service levels for each device model sourced from each equipment vendor or distributor partner. Each record links one device_model to one partner with attributes that exist only in the context of this specific supply relationship.. Existence Justification: In telecommunications device procurement operations, a single device model (e.g., iPhone 15 Pro) is sourced from multiple partners (Apple direct, authorized distributors, regional wholesalers) simultaneously, each with different wholesale costs, lead times, and inventory allocations. Conversely, each equipment vendor or distributor partner supplies multiple device models across categories (smartphones, tablets, CPE, ONTs). The business actively manages these supply agreements as operational contracts with partner-specific and device-specific terms.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`offering_filing_metric` (
    `offering_filing_metric_id` BIGINT COMMENT 'Unique identifier for this offering-filing metric record. Primary key.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to the commercial offering being reported in this filing',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to the regulatory filing submission that includes this offerings metrics',
    `data_source_system` STRING COMMENT 'Source system from which the offering metrics were extracted for this filing (e.g., billing system, CRM, data warehouse). Supports audit trail and reconciliation.',
    `filing_period_end_date` DATE COMMENT 'End date of the reporting period for which this offerings metrics apply within this filing.',
    `filing_period_start_date` DATE COMMENT 'Start date of the reporting period for which this offerings metrics apply within this filing. May differ from the overall filing period if offering was launched mid-period.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this offerings data within this specific filing, including any adjustments, exclusions, or special circumstances.',
    `preparation_date` DATE COMMENT 'Date when the offering metrics for this filing were prepared and validated.',
    `preparer_name` STRING COMMENT 'Name of the individual who prepared and validated the offering-specific metrics for inclusion in this filing.',
    `reported_revenue_amount` DECIMAL(18,2) COMMENT 'Revenue amount attributed to this specific offering for the filing period, as reported to the regulatory authority. This is offering-specific revenue within the context of this particular filing.',
    `reported_subscriber_count` BIGINT COMMENT 'Number of active subscribers for this offering during the filing period, as reported to the regulatory authority.',
    `reported_usage_volume` DECIMAL(18,2) COMMENT 'Aggregated usage volume (data GB, voice minutes, or other usage metric) for this offering during the filing period, as reported to the regulatory authority.',
    `revenue_category` STRING COMMENT 'Regulatory revenue classification category for this offering within this filing (e.g., retail_mobile, retail_broadband, wholesale, enterprise, roaming). Required for FCC Form 499 and similar filings.',
    `service_classification_code` STRING COMMENT 'Regulatory service classification code assigned to this offering for this filing (e.g., FCC service codes, EU service type codes). Classification may vary by filing type and regulatory authority.',
    CONSTRAINT pk_offering_filing_metric PRIMARY KEY(`offering_filing_metric_id`)
) COMMENT 'This association product represents the regulatory reporting metrics between offering and regulatory_filing. It captures offering-specific financial and operational data submitted within each regulatory filing. Each record links one offering to one regulatory_filing with metrics that exist only in the context of that specific filing submission - including reported revenue, subscriber counts, usage volumes, and service classifications required by regulatory authorities.. Existence Justification: Telecom operators submit regulatory filings (FCC Form 499, universal service fund reports, EU regulatory submissions) that require offering-level revenue and subscriber breakdowns. One filing covers multiple offerings (all mobile plans, all broadband offerings), and one offering appears in multiple filings over time (quarterly/annual submissions). The business actively manages offering-specific metrics per filing for audit trails, regulatory reconciliation, and compliance verification.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`addon_eligibility` (
    `addon_eligibility_id` BIGINT COMMENT 'Unique identifier for this eligibility rule. Primary key.',
    `addon_id` BIGINT COMMENT 'Foreign key linking to the add-on product being made eligible for attachment',
    `offering_id` BIGINT COMMENT 'Foreign key linking to the base offering to which the add-on can be attached',
    `addon_price_override` DECIMAL(18,2) COMMENT 'Offering-specific price override for this add-on. When populated, overrides the standard price_amount from the addon product. Allows same add-on to have different pricing when attached to different offerings. Explicitly identified in detection phase.',
    `auto_attach_flag` BOOLEAN COMMENT 'Indicates whether this add-on is automatically attached to customer subscriptions when this offering is purchased. Used for mandatory add-ons or promotional bundles. Explicitly identified in detection phase.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this eligibility rule was created in the product catalog system.',
    `display_priority` STRING COMMENT 'Sort order for displaying this add-on in the list of available add-ons for this offering in sales channels and self-service portals. Lower numbers appear first.',
    `effective_end_date` DATE COMMENT 'Date when this eligibility rule expires. Nullable for ongoing eligibility. Allows product managers to time-bound add-on availability for promotional campaigns. Explicitly identified in detection phase.',
    `effective_start_date` DATE COMMENT 'Date when this eligibility rule becomes active. Allows product managers to schedule future add-on availability for specific offerings. Explicitly identified in detection phase.',
    `eligibility_condition` STRING COMMENT 'Business rule or condition that must be met for this add-on to be available for this offering. Examples: customer_segment=premium, contract_term>=12, geographic_scope=EU. Explicitly identified in detection phase.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the product manager who last modified this eligibility rule.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this eligibility rule was last updated.',
    `max_quantity_per_offering` STRING COMMENT 'Maximum number of instances of this add-on that can be attached when purchased with this specific offering. May differ from the add-ons global max_quantity_per_subscription. Explicitly identified in detection phase.',
    `created_by` STRING COMMENT 'User ID or system identifier of the product manager who created this eligibility rule.',
    CONSTRAINT pk_addon_eligibility PRIMARY KEY(`addon_eligibility_id`)
) COMMENT 'This association product represents the eligibility and compatibility rules between add-on products and base offerings in the telecommunications product catalog. It captures which add-ons can be attached to which offerings, along with offering-specific pricing overrides, quantity constraints, and auto-attachment rules. Each record defines one add-ons availability and terms for one specific offering, enabling product managers to configure different eligibility conditions and pricing for the same add-on across different base offerings.. Existence Justification: In telecommunications product catalog management, add-ons and offerings have a genuine many-to-many relationship. A single add-on (e.g., International Roaming pack) can be made eligible for multiple base offerings (Premium Mobile, Standard Mobile, Business Mobile), and each offering can have multiple eligible add-ons (data top-ups, premium channels, security packages). Product managers actively configure eligibility rules with offering-specific pricing overrides, quantity constraints, and auto-attachment rules for each add-on-offering combination.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` (
    `service_addon_subscription_id` BIGINT COMMENT 'Unique identifier for this add-on subscription instance. Primary key.',
    `addon_id` BIGINT COMMENT 'Foreign key linking to the add-on product definition in the product catalog',
    `employee_id` BIGINT COMMENT 'Reference to the employee (service delivery manager, sales rep, or support agent) who created this add-on subscription record.',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to the managed service instance to which the add-on is subscribed',
    `activation_date` DATE COMMENT 'Date when the add-on was activated on the managed service instance. Marks the start of billing and service delivery for this add-on subscription.',
    `addon_status` STRING COMMENT 'Current lifecycle status of the add-on subscription on this managed service. Controls billing, service delivery, and operational visibility.',
    `auto_renewal_override` BOOLEAN COMMENT 'Subscription-level override for the add-ons default auto-renewal behavior. Allows per-subscription control of renewal even when the add-on product has auto-renewal enabled by default.',
    `billing_start_date` DATE COMMENT 'Date when billing commenced for this add-on subscription. May differ from activation_date if trial period or promotional delay applies.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this add-on subscription record was created.',
    `deactivation_date` DATE COMMENT 'Actual date when the add-on was deactivated or removed from the managed service. Null for active subscriptions. Used for historical tracking and billing reconciliation.',
    `deactivation_reason` STRING COMMENT 'Business reason for add-on deactivation. Used for churn analysis and service delivery improvement.',
    `expiration_date` DATE COMMENT 'Scheduled expiration or deactivation date for this add-on subscription. Null for perpetual or auto-renewing add-ons. Used for time-limited promotional add-ons or trial periods.',
    `last_billing_date` DATE COMMENT 'Most recent date when this add-on subscription was billed. Used for billing cycle tracking and revenue recognition.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this add-on subscription record was last modified.',
    `next_billing_date` DATE COMMENT 'Scheduled date for the next billing cycle for this add-on subscription. Null for one-time add-ons or deactivated subscriptions.',
    `price_override` DECIMAL(18,2) COMMENT 'Custom pricing amount for this specific add-on subscription, overriding the standard catalog price. Used for negotiated enterprise pricing, promotional discounts, or volume-based pricing adjustments. Null if standard catalog pricing applies.',
    `provisioning_date` DATE COMMENT 'Date when technical provisioning of the add-on was completed on the managed service infrastructure. Used for SLA tracking and operational reporting.',
    `provisioning_status` STRING COMMENT 'Technical provisioning state of the add-on on the managed service infrastructure. Tracks whether network configuration, CPE updates, or service activation tasks are complete.',
    `quantity` STRING COMMENT 'Number of instances or units of this add-on subscribed to the managed service. Examples: 5 additional static IPs, 3 DDoS protection tiers, 10 GB extra bandwidth.',
    `trial_flag` BOOLEAN COMMENT 'Indicates whether this add-on subscription is currently in a free trial period. When true, billing is suspended until trial expiration.',
    CONSTRAINT pk_service_addon_subscription PRIMARY KEY(`service_addon_subscription_id`)
) COMMENT 'This association product represents the subscription relationship between an add-on product and a managed service instance. It captures the operational activation, billing, and lifecycle management of add-ons attached to enterprise managed services. Each record links one add-on to one managed service with attributes that exist only in the context of this subscription relationship, including activation timing, pricing overrides, quantity, status, and trial periods.. Existence Justification: In telecommunications enterprise operations, managed services (SD-WAN, MPLS, UCaaS) can have multiple add-ons attached simultaneously (extra bandwidth, DDoS protection, static IPs, managed firewall), and each add-on product can be subscribed to by many different managed service instances across the customer base. The business actively manages these subscriptions as operational entities with lifecycle states, activation dates, custom pricing, quantities, and trial periods.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`bundle_subscription` (
    `bundle_subscription_id` BIGINT COMMENT 'Unique identifier for this bundle subscription record. Primary key.',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to the product bundle that is subscribed to by the corporate account',
    `enterprise_contract_id` BIGINT COMMENT 'Reference to the master service agreement or specific contract under which this bundle subscription is governed. Explicitly identified in detection phase relationship data.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to the corporate account that holds the bundle subscription',
    `bundle_quantity` STRING COMMENT 'Number of bundle instances subscribed by the corporate account. Explicitly identified in detection phase relationship data. Relevant for enterprise accounts with multiple locations or departments.',
    `discount_applied` DECIMAL(18,2) COMMENT 'Monetary discount amount applied to this specific subscription, which may differ from the standard bundle discount due to enterprise negotiation. Explicitly identified in detection phase relationship data.',
    `monthly_recurring_revenue` DECIMAL(18,2) COMMENT 'Calculated MRR for this specific bundle subscription after applying quantity and discounts. Critical for enterprise revenue analysis and bundle performance tracking.',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether this bundle subscription is set to auto-renew at contract term expiration. Explicitly identified in detection phase relationship data.',
    `subscription_end_date` DATE COMMENT 'Date when this bundle subscription ended or is scheduled to end. Null for active ongoing subscriptions. Supports historical tracking of subscription lifecycle.',
    `subscription_start_date` DATE COMMENT 'Date when this bundle subscription was activated for the corporate account. Explicitly identified in detection phase relationship data.',
    `subscription_status` STRING COMMENT 'Current lifecycle status of the bundle subscription. Explicitly identified in detection phase relationship data. Values: active, suspended, cancelled, pending_activation, expired.',
    CONSTRAINT pk_bundle_subscription PRIMARY KEY(`bundle_subscription_id`)
) COMMENT 'This association product represents the Contract between bundle and corporate_account. It captures the active and historical subscriptions of product bundles by enterprise customers. Each record links one bundle to one corporate_account with attributes that exist only in the context of this subscription relationship, including activation dates, subscription status, quantity of bundle instances, applied discounts, contract references, and renewal flags.. Existence Justification: In telecommunications B2B operations, corporate accounts routinely subscribe to multiple product bundles simultaneously (e.g., connectivity bundle for headquarters, UC bundle for remote offices, security bundle for IT department), and each bundle is sold to many different corporate accounts across the customer base. The business actively manages these subscriptions as operational entities with lifecycle tracking, status management, contract linkage, and revenue attribution.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`bundle_channel_inclusion` (
    `bundle_channel_inclusion_id` BIGINT COMMENT 'Unique identifier for this bundle-channel inclusion record. Primary key.',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to the product bundle that includes this channel',
    `iptv_channel_id` BIGINT COMMENT 'Foreign key linking to the IPTV channel included in this bundle',
    `additional_charge` DECIMAL(18,2) COMMENT 'Additional monthly charge for this channel within this bundle, if applicable. Used when a channel incurs an extra fee beyond the base bundle price (e.g., premium sports channels).',
    `channel_position` STRING COMMENT 'The display position or sequence order of this channel within the bundles channel lineup. Used for EPG presentation and channel ordering specific to this bundle.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this bundle-channel inclusion record was created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this channel is removed from this bundle. Null indicates ongoing inclusion. Used for managing licensing changes and bundle reconfigurations.',
    `effective_start_date` DATE COMMENT 'Date when this channel becomes available within this bundle. Used for managing channel lineup changes and promotional inclusions.',
    `is_optional` BOOLEAN COMMENT 'Indicates whether this channel is optional (can be added/removed by customer) or mandatory (always included) within this bundle. Supports flexible and customizable bundle configurations.',
    `is_premium_channel` BOOLEAN COMMENT 'Indicates whether this channel is treated as a premium channel within this specific bundle, potentially requiring additional entitlement or incurring additional charges. A channel may be premium in one bundle but included in another.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this bundle-channel inclusion record was last updated.',
    `tier_level` STRING COMMENT 'The service tier classification of this channel within this specific bundle (e.g., basic, standard, premium, sports). A channel may be in different tiers across different bundles.',
    CONSTRAINT pk_bundle_channel_inclusion PRIMARY KEY(`bundle_channel_inclusion_id`)
) COMMENT 'This association product represents the inclusion relationship between bundle and iptv_channel. It captures the specific configuration of each IPTV channel within a product bundle, including channel positioning, tier classification, premium status, and any additional charges. Each record links one bundle to one iptv_channel with attributes that exist only in the context of this bundle-channel pairing.. Existence Justification: In telecommunications bundle management, a single product bundle (e.g., Triple Play, Quad Play) includes multiple IPTV channels as part of its channel lineup, and each IPTV channel appears across multiple different bundles with varying configurations. The business actively manages bundle-channel inclusions as operational records, tracking channel positioning within each bundle, tier classification, effective dates for lineup changes, premium status per bundle, and additional charges. Product managers configure these inclusions during bundle design, and provisioning systems use them to entitle subscribers.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`bundle_promotion` (
    `bundle_promotion_id` BIGINT COMMENT 'Unique identifier for this bundle-promotion eligibility record. Primary key.',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to the product bundle that is eligible for this promotion',
    `employee_id` BIGINT COMMENT 'Employee ID of the marketing or sales operations user who configured this bundle-promotion eligibility. Used for audit and accountability.',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to the sales promotion that can be applied to this bundle',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bundle-promotion eligibility record was created. Used for audit trail and tracking when promotional eligibility was configured.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Fixed monetary discount applied to this specific bundle under this promotion. May differ from the promotions general discount_value when bundle-specific pricing rules apply.',
    `effective_end_date` DATE COMMENT 'Date when this promotion is no longer applicable to this specific bundle. May differ from the promotions general end_date to support bundle-specific expiration or inventory clearance.',
    `effective_start_date` DATE COMMENT 'Date when this promotion becomes applicable to this specific bundle. May differ from the promotions general start_date to support phased rollouts or bundle-specific launch timing.',
    `priority_rank` STRING COMMENT 'Priority order for applying this promotion to this bundle when multiple promotions are eligible. Lower numbers indicate higher priority. Used by sales systems to determine which promotion to apply first or suggest to customers.',
    `promotional_bundle_price` DECIMAL(18,2) COMMENT 'Special price for this bundle when this specific promotion is applied. Overrides the standard bundle_price_amount from the bundle master record for promotional periods.',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this bundle is a time-limited promotional offer (True) or a standard catalog product (False). Promotional bundles typically have special pricing, limited availability periods, and marketing campaigns. [Moved from bundle: This boolean flag in the bundle table indicates whether a bundle is promotional, but it doesnt capture WHICH promotions apply or the specific terms. This is better represented by the existence of records in the bundle_promotion association with effective date ranges.]',
    `redemption_limit` STRING COMMENT 'Maximum number of times this promotion can be redeemed specifically for this bundle. Allows bundle-level inventory or capacity constraints separate from the promotions overall redemption_limit_total.',
    `stacking_allowed_flag` BOOLEAN COMMENT 'Indicates whether this promotion can be stacked with other promotions specifically when applied to this bundle. May override the promotions general stacking_allowed_flag for bundle-specific business rules.',
    CONSTRAINT pk_bundle_promotion PRIMARY KEY(`bundle_promotion_id`)
) COMMENT 'This association product represents the eligibility relationship between product bundles and sales promotions in the telecommunications sales process. It captures which promotions can be applied to which bundles, with promotion-specific pricing, discount rules, and redemption constraints that exist only in the context of this bundle-promotion combination. Each record links one bundle to one promotion with attributes defining how that specific promotion applies to that specific bundle.. Existence Justification: In telecommunications sales operations, product bundles (Triple Play, Quad Play, family plans) are routinely made eligible for multiple concurrent promotions—a new customer acquisition offer, a seasonal discount campaign, and a loyalty reward can all apply to the same bundle simultaneously. Conversely, a single promotion (e.g., Summer Sale 20% Off) applies across multiple bundle types to maximize market reach. The business actively manages this many-to-many eligibility matrix, configuring bundle-specific promotional pricing, redemption limits, effective date windows, and stacking rules that vary by bundle-promotion combination.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`product_channel_lineup` (
    `product_channel_lineup_id` BIGINT COMMENT 'Primary key for product_channel_lineup',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to the catalog item (TV package/bundle) that contains this channel in its lineup',
    `content_channel_lineup_id` BIGINT COMMENT 'Unique identifier for this package-channel lineup configuration record. Primary key.',
    `iptv_channel_id` BIGINT COMMENT 'Foreign key linking to the IPTV channel included in this package lineup',
    `channel_position` STRING COMMENT 'The logical position or sequence number of this channel within the package lineup, used for display ordering in EPG and marketing materials. This attribute exists only in the context of a specific package-channel pairing.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this channel-package lineup configuration was created in the system, supporting audit trail for lineup management operations.',
    `effective_end_date` DATE COMMENT 'Date when this channel was removed from this package lineup, typically due to licensing expiration or strategic lineup changes. Null for currently active channel inclusions.',
    `effective_start_date` DATE COMMENT 'Date when this channel was added to this package lineup and became available to subscribers of this package. Supports lineup versioning and historical tracking of channel additions.',
    `inclusion_status` STRING COMMENT 'Current operational status of this channel inclusion in this package. Active=currently available to subscribers, Pending=scheduled for future activation, Suspended=temporarily unavailable, Removed=permanently removed from lineup.',
    `is_featured` BOOLEAN COMMENT 'Indicates whether this channel is promoted as a featured or highlighted channel in marketing materials for this specific package. A channel may be featured in one package but not in another.',
    `last_modified_by` STRING COMMENT 'User or system identifier that last modified this lineup configuration, supporting operational audit.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this lineup configuration, supporting change tracking and audit.',
    `sort_order` STRING COMMENT 'Display sort order for this channel within this package lineup, used for EPG presentation and channel guide ordering. May differ from channel_position if custom sorting logic is applied per package.',
    `tier_level` STRING COMMENT 'The tier classification of this channel within this specific package (e.g., basic, premium, sports add-on). A channel may be premium in one package but standard in another, so this attribute belongs to the relationship, not to either entity alone.',
    `created_by` STRING COMMENT 'User or system identifier that created this lineup configuration record, supporting operational audit and accountability.',
    CONSTRAINT pk_product_channel_lineup PRIMARY KEY(`product_channel_lineup_id`)
) COMMENT 'This association product represents the configuration relationship between catalog_item (TV packages/bundles) and iptv_channel (linear broadcast channels). It captures the business process of composing TV package lineups by defining which channels are included in which packages, at what tier level, in what position, and with what promotional treatment. Each record links one catalog_item to one iptv_channel with attributes that exist only in the context of this package-channel inclusion relationship. This is the operational SSOT for lineup management, channel negotiation outcomes, and subscriber entitlement determination.. Existence Justification: In telecommunications IPTV operations, TV packages (catalog items) contain multiple channels, and channels appear in multiple packages at different tier levels and positions. The business actively manages channel lineup configurations as operational entities - product managers compose lineups, negotiate channel placement with broadcasters, version lineups over time as licensing changes, and communicate lineup changes to subscribers. This is not an analytical correlation but an operational business process with dedicated tooling and workflows.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`offering_platform_bundle` (
    `offering_platform_bundle_id` BIGINT COMMENT 'Unique identifier for this offering-platform bundling relationship. Primary key.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to the commercial offering that includes this OTT platform bundle',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to the OTT streaming platform included in this offering',
    `bundle_status` STRING COMMENT 'Current operational status of this offering-platform bundle. Active=available for new subscriptions, Suspended=temporarily unavailable, Deprecated=no longer offered but existing subscriptions continue, Pending-Approval=awaiting commercial or technical approval.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this offering-platform bundle record was created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this OTT platform was removed from this offering or when the bundling terms changed. Null for currently active bundles.',
    `effective_start_date` DATE COMMENT 'Date when this OTT platform became available as part of this offering. Supports versioning of bundling terms over time.',
    `incremental_monthly_charge` DECIMAL(18,2) COMMENT 'Additional monthly charge to the customer for including this OTT platform in the offering, beyond the base offering price. Zero if the platform is included at no extra cost.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this offering-platform bundle record was last updated.',
    `promotional_end_date` DATE COMMENT 'Date when the promotional bundling terms expire. Null if promotional_flag is false or for open-ended promotions.',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this platform inclusion is part of a time-limited promotional campaign for this offering. True for promotional bundles, false for standard inclusions.',
    `provisioning_method` STRING COMMENT 'Technical method used to provision access to the OTT platform when a customer subscribes to this offering. May vary by offering even for the same platform (e.g., premium offerings get auto-provisioning, basic offerings get voucher codes).',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of subscription revenue allocated to the OTT platform provider for this specific offering-platform combination. May differ from the platform-level default based on negotiated terms for high-volume offerings.',
    `subscription_tier` STRING COMMENT 'The specific subscription tier of the OTT platform included in this offering (e.g., Netflix Basic, Disney+ Premium). Different offerings may bundle different tiers of the same platform.',
    `trial_duration_months` STRING COMMENT 'Number of months of free or promotional trial access to the OTT platform included with this offering. Null if no trial period applies.',
    CONSTRAINT pk_offering_platform_bundle PRIMARY KEY(`offering_platform_bundle_id`)
) COMMENT 'This association product represents the commercial bundling contract between a telco offering and an OTT streaming platform. It captures the specific terms, pricing, provisioning rules, and revenue-sharing arrangements that apply when a particular OTT platform is included in a particular customer-facing offering. Each record links one offering to one OTT platform with attributes that exist only in the context of this commercial bundling relationship.. Existence Justification: In telecommunications operations, a single commercial offering can bundle multiple OTT streaming platforms (e.g., a premium broadband package includes Netflix, Disney+, and HBO Max), and each OTT platform is included in multiple different offerings across the product catalog (e.g., Netflix Basic in entry-level mobile plans, Netflix Premium in fiber bundles). The business actively manages these bundling relationships with specific commercial terms, provisioning methods, trial periods, and revenue-sharing arrangements that vary by offering-platform combination.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`catalog_roaming_enablement` (
    `catalog_roaming_enablement_id` BIGINT COMMENT 'Unique surrogate identifier for this catalog item to carrier agreement enablement record. Primary key.',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to the carrier agreement that provides the commercial and technical framework enabling this catalog item.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to the catalog item (roaming product, wholesale offering, or MVNO service) that is enabled through this carrier agreement.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this catalog item to carrier agreement enablement record was created in the system. Audit trail for product launch and agreement activation tracking.',
    `effective_end_date` DATE COMMENT 'Calendar date after which this catalog item is no longer enabled through this carrier agreement. Nullable for ongoing enablements. Used when products are deprecated or migrated to different agreements.',
    `effective_start_date` DATE COMMENT 'Calendar date from which this catalog item is commercially enabled through this specific carrier agreement. May differ from the agreements overall effective_from_date if product rollout is phased.',
    `enablement_status` STRING COMMENT 'Current operational status of this catalog item enablement through this carrier agreement. ACTIVE = live and routing traffic; SUSPENDED = temporarily disabled due to commercial dispute or technical issue; PENDING_ACTIVATION = configured but not yet live; DEPRECATED = end-of-life, no new subscriptions.',
    `geographic_scope` STRING COMMENT 'Geographic restriction or coverage area for this specific catalog item under this carrier agreement. May be narrower than the agreements overall coverage (e.g., Western Europe only when agreement covers all of Europe). Comma-separated list of ISO country codes or region identifiers.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier that last modified this enablement record. Audit trail for troubleshooting routing or billing issues.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent update to this enablement record. Tracks configuration changes over time.',
    `priority_rank` STRING COMMENT 'Routing priority for this catalog item when multiple carrier agreements could serve the same roaming/wholesale scenario. Lower numbers indicate higher priority. Used by network routing logic and billing systems to select the optimal agreement based on commercial terms.',
    `service_type_filter` STRING COMMENT 'Comma-separated list of telecommunication service types that are enabled for this catalog item under this carrier agreement. Subset of the agreements covered_services, reflecting product-specific restrictions (e.g., data-only product would have DATA even if agreement covers voice and SMS).',
    `created_by` STRING COMMENT 'User ID or system identifier that created this enablement record. Supports audit and accountability for product-agreement configuration changes.',
    CONSTRAINT pk_catalog_roaming_enablement PRIMARY KEY(`catalog_roaming_enablement_id`)
) COMMENT 'This association product represents the commercial enablement relationship between catalog items and carrier agreements in the telecommunications roaming and wholesale ecosystem. It captures which roaming/wholesale products (catalog items) are technically and commercially enabled through which inter-operator agreements, including the effective date ranges, routing priority for multi-agreement scenarios, geographic scope restrictions, and service type filters. Each record links one catalog item to one carrier agreement with attributes that exist only in the context of this specific product-agreement enablement.. Existence Justification: In telecommunications roaming and wholesale operations, a single catalog item (e.g., International Data Pass, Roaming Voice Bundle) is commercially enabled through multiple carrier agreements covering different geographic regions and network operators. Conversely, one bilateral carrier agreement enables multiple catalog items (voice products, SMS products, data products, VoLTE services) with different commercial terms, priority routing rules, and service type restrictions. This is an operational relationship actively managed by product managers and interconnect teams to optimize routing costs and service coverage.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`skill_requirement` (
    `skill_requirement_id` BIGINT COMMENT 'Unique identifier for this product-skill requirement record. Primary key.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key to product.catalog_item. Identifies which catalog item requires this skill.',
    `skill_id` BIGINT COMMENT 'Foreign key to workforce.skill. Identifies which technical skill is required.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether formal external certification is mandatory for technicians working on this catalog item. Overrides skill-level certification requirements when product has specific regulatory or vendor contractual obligations. Explicitly identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this product-skill requirement record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when this skill requirement became effective for the catalog item. Typically aligns with product launch date or product modification date when new skills were added. Explicitly identified in detection phase relationship data.',
    `expiration_date` DATE COMMENT 'Date when this skill requirement is no longer applicable, typically when catalog item reaches end-of-life or when technology changes eliminate the skill need. Null if requirement is still active. Explicitly identified in detection phase relationship data.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this skill is absolutely required (true) or preferred but optional (false) for work orders related to this catalog item. Mandatory skills block dispatch if no qualified technician available; optional skills are used for optimization only.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this product-skill requirement record was last modified.',
    `proficiency_level_required` STRING COMMENT 'Minimum proficiency level required for this catalog item: trainee, competent, or expert. Determines which technicians can be dispatched to work orders for this product. Explicitly identified in detection phase relationship data.',
    `skill_requirement_status` STRING COMMENT 'Lifecycle status of this product-skill requirement: active (currently enforced), deprecated (being phased out), obsolete (no longer applicable). Tracks evolution of skill requirements as products and technologies change.',
    `training_hours_required` DECIMAL(18,2) COMMENT 'Estimated training hours required for a technician to achieve the required proficiency level for this specific catalog item. Used for workforce training planning and capacity modeling. Explicitly identified in detection phase relationship data.',
    `work_order_phase_applicability` STRING COMMENT 'Comma-separated list of work order phases where this skill is required: installation, provisioning, configuration, maintenance, troubleshooting, decommissioning. Enables phase-specific skill matching in Granite WFM dispatch.',
    CONSTRAINT pk_skill_requirement PRIMARY KEY(`skill_requirement_id`)
) COMMENT 'This association product represents the skill requirements for telecom catalog items. It captures which technical skills are required to install, provision, configure, or support each commercial offering, enabling skill-based workforce dispatch and capacity planning. Each record links one catalog item to one skill with proficiency requirements, certification mandates, and training specifications that exist only in the context of this product-skill relationship.. Existence Justification: In telecommunications operations, each catalog item (fiber broadband, 5G mobile plan, IPTV bundle, enterprise SD-WAN) requires multiple technical skills for installation, provisioning, and support (e.g., fiber splicing, 5G RAN commissioning, GPON configuration, VoLTE troubleshooting). Conversely, each technical skill applies to multiple catalog items across product families. The business actively manages these product-skill requirements to enable skill-based dispatch in Granite WFM, ensuring only appropriately qualified technicians are assigned to work orders for specific products.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`segment_eligibility` (
    `segment_eligibility_id` BIGINT COMMENT 'Unique identifier for this product-segment eligibility record. Primary key.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to the catalog item being made eligible for a customer segment',
    `segment_definition_id` BIGINT COMMENT 'Foreign key linking to the customer segment definition for which the product is eligible',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this eligibility record was created in the system',
    `effective_date` DATE COMMENT 'Date when this product-segment eligibility becomes active and the product can be offered to customers in this segment',
    `eligibility_criteria` STRING COMMENT 'Segment-specific business rules or conditions that must be met for customers in this segment to purchase this catalog item. May include credit score thresholds, account tenure requirements, or device compatibility rules.',
    `eligibility_status` STRING COMMENT 'Current lifecycle status of this eligibility configuration: active (in use), inactive (temporarily disabled), pending (scheduled for future), expired (past expiration date)',
    `expiration_date` DATE COMMENT 'Date when this product-segment eligibility expires and the product is no longer available to customers in this segment. Null indicates no expiration.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier that last modified this eligibility record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this eligibility record was last updated',
    `priority_rank` STRING COMMENT 'Ranking used by offer optimization engines to prioritize this product when presenting offers to customers in this segment. Lower numbers indicate higher priority.',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this product-segment pairing is part of a promotional campaign with special pricing or terms for this segment',
    `created_by` STRING COMMENT 'User ID or system identifier that created this eligibility record',
    CONSTRAINT pk_segment_eligibility PRIMARY KEY(`segment_eligibility_id`)
) COMMENT 'This association product represents the eligibility rules and targeting configuration between catalog items and customer segments in the telecommunications product catalog. It captures which products are available to which customer segments, with segment-specific eligibility criteria, priority ranking for offer optimization, and temporal validity windows. Each record links one catalog_item to one segment_definition with attributes that exist only in the context of this targeting relationship.. Existence Justification: In telecommunications product management, catalog items are intentionally targeted to multiple customer segments with segment-specific eligibility rules, priority rankings, and promotional configurations. A single product (e.g., 5G Unlimited Plan) is simultaneously eligible for multiple segments (High-Value Postpaid, Youth Digital Native, Enterprise SME) with different priority rankings and eligibility criteria. Conversely, each customer segment has access to multiple products that are curated and prioritized for that segments needs. This is an operational relationship actively managed by product managers and marketing teams.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`rule_group` (
    `rule_group_id` BIGINT COMMENT 'Primary key for rule_group',
    `parent_rule_group_id` BIGINT COMMENT 'Self-referencing FK on rule_group (parent_rule_group_id)',
    `applicability_scope` STRING COMMENT 'Scope indicating the entity type to which the rule group applies.',
    `rule_group_code` STRING COMMENT 'Short alphanumeric code that uniquely identifies the rule group within the catalog.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule group record was first created in the system.',
    `rule_group_description` STRING COMMENT 'Detailed description of the purpose, scope, and business intent of the rule group.',
    `effective_from` DATE COMMENT 'Date when the rule group becomes effective for evaluation.',
    `effective_until` DATE COMMENT 'Date when the rule group ceases to be effective; null if open‑ended.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this rule group is the default for its type when no explicit group is assigned.',
    `rule_group_name` STRING COMMENT 'Human‑readable name of the rule group used in UI and reports.',
    `owner` STRING COMMENT 'Business team or system responsible for maintaining the rule group.',
    `priority` STRING COMMENT 'Numeric priority used to resolve conflicts when multiple rule groups apply; lower numbers have higher precedence.',
    `rule_count` STRING COMMENT 'Total count of individual rules contained in the group.',
    `rule_group_status` STRING COMMENT 'Current lifecycle status of the rule group.',
    `rule_group_type` STRING COMMENT 'Category of the rule group indicating the functional area it governs.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rule group record.',
    CONSTRAINT pk_rule_group PRIMARY KEY(`rule_group_id`)
) COMMENT 'Master reference table for rule_group. Referenced by rule_group_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`zero_rating_program` (
    `zero_rating_program_id` BIGINT COMMENT 'Primary key for zero_rating_program',
    `superseded_zero_rating_program_id` BIGINT COMMENT 'Self-referencing FK on zero_rating_program (superseded_zero_rating_program_id)',
    `data_cap_gb` DECIMAL(18,2) COMMENT 'Maximum amount of data (in gigabytes) that can be consumed under zero rating per billing cycle.',
    `zero_rating_program_description` STRING COMMENT 'Detailed textual description of the program, its purpose, and any marketing notes.',
    `eligibility_criteria` STRING COMMENT 'Free‑text rules defining which customers, devices, or plans qualify for the program.',
    `eligibility_customer_segment` STRING COMMENT 'Segment of customers that may enroll in the program.',
    `eligibility_device_type` STRING COMMENT 'Device categories (e.g., smartphone, tablet, IoT) that are allowed under the program.',
    `end_date` DATE COMMENT 'Date when the program expires or is retired; null if open‑ended.',
    `is_promotional` BOOLEAN COMMENT 'True if the program is a limited‑time promotional offering.',
    `max_speed_mbps` STRING COMMENT 'Maximum network speed allowed for traffic under the program.',
    `network_type` STRING COMMENT 'Network technology on which the zero rating applies.',
    `pricing_model` STRING COMMENT 'How the program is priced for the customer (e.g., free, discounted, subscription).',
    `program_code` STRING COMMENT 'Unique alphanumeric code used in billing and provisioning systems to reference the program.',
    `program_name` STRING COMMENT 'Human‑readable name of the zero rating program as displayed to customers.',
    `program_type` STRING COMMENT 'Category of content or service that is zero‑rated (e.g., app, video, social media).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the program record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the program record.',
    `rollover_allowed` BOOLEAN COMMENT 'True if unused data cap can roll over to the next billing cycle.',
    `start_date` DATE COMMENT 'Date when the zero rating program becomes active for eligible customers.',
    `zero_rating_program_status` STRING COMMENT 'Current lifecycle state of the program.',
    `zero_rating_percentage` DECIMAL(18,2) COMMENT 'Percentage of data usage that is exempt from charging (e.g., 100% for fully zero‑rated).',
    CONSTRAINT pk_zero_rating_program PRIMARY KEY(`zero_rating_program_id`)
) COMMENT 'Master reference table for zero_rating_program. Referenced by zero_rating_program_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_category_id` FOREIGN KEY (`category_id`) REFERENCES `telecommunication_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_lifecycle_status_id` FOREIGN KEY (`lifecycle_status_id`) REFERENCES `telecommunication_ecm`.`product`.`lifecycle_status`(`lifecycle_status_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_zero_rating_program_id` FOREIGN KEY (`zero_rating_program_id`) REFERENCES `telecommunication_ecm`.`product`.`zero_rating_program`(`zero_rating_program_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ADD CONSTRAINT `fk_product_offering_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ADD CONSTRAINT `fk_product_offering_lifecycle_status_id` FOREIGN KEY (`lifecycle_status_id`) REFERENCES `telecommunication_ecm`.`product`.`lifecycle_status`(`lifecycle_status_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ADD CONSTRAINT `fk_product_offering_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `telecommunication_ecm`.`product`.`sla_template`(`sla_template_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_lifecycle_status_id` FOREIGN KEY (`lifecycle_status_id`) REFERENCES `telecommunication_ecm`.`product`.`lifecycle_status`(`lifecycle_status_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ADD CONSTRAINT `fk_product_price_plan_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ADD CONSTRAINT `fk_product_price_plan_lifecycle_status_id` FOREIGN KEY (`lifecycle_status_id`) REFERENCES `telecommunication_ecm`.`product`.`lifecycle_status`(`lifecycle_status_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ADD CONSTRAINT `fk_product_price_plan_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ADD CONSTRAINT `fk_product_price_plan_superseded_by_price_plan_id` FOREIGN KEY (`superseded_by_price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ADD CONSTRAINT `fk_product_price_alteration_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ADD CONSTRAINT `fk_product_price_alteration_superseded_by_alteration_price_alteration_id` FOREIGN KEY (`superseded_by_alteration_price_alteration_id`) REFERENCES `telecommunication_ecm`.`product`.`price_alteration`(`price_alteration_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ADD CONSTRAINT `fk_product_promo_offer_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ADD CONSTRAINT `fk_product_promo_offer_lifecycle_status_id` FOREIGN KEY (`lifecycle_status_id`) REFERENCES `telecommunication_ecm`.`product`.`lifecycle_status`(`lifecycle_status_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ADD CONSTRAINT `fk_product_spec_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ADD CONSTRAINT `fk_product_eligibility_rule_lifecycle_status_id` FOREIGN KEY (`lifecycle_status_id`) REFERENCES `telecommunication_ecm`.`product`.`lifecycle_status`(`lifecycle_status_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ADD CONSTRAINT `fk_product_eligibility_rule_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ADD CONSTRAINT `fk_product_eligibility_rule_rule_group_id` FOREIGN KEY (`rule_group_id`) REFERENCES `telecommunication_ecm`.`product`.`rule_group`(`rule_group_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ADD CONSTRAINT `fk_product_compatibility_rule_lifecycle_status_id` FOREIGN KEY (`lifecycle_status_id`) REFERENCES `telecommunication_ecm`.`product`.`lifecycle_status`(`lifecycle_status_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ADD CONSTRAINT `fk_product_compatibility_rule_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ADD CONSTRAINT `fk_product_compatibility_rule_target_product_catalog_item_id` FOREIGN KEY (`target_product_catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ADD CONSTRAINT `fk_product_device_model_lifecycle_status_id` FOREIGN KEY (`lifecycle_status_id`) REFERENCES `telecommunication_ecm`.`product`.`lifecycle_status`(`lifecycle_status_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ADD CONSTRAINT `fk_product_device_offering_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ADD CONSTRAINT `fk_product_device_offering_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ADD CONSTRAINT `fk_product_device_offering_lifecycle_status_id` FOREIGN KEY (`lifecycle_status_id`) REFERENCES `telecommunication_ecm`.`product`.`lifecycle_status`(`lifecycle_status_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ADD CONSTRAINT `fk_product_device_offering_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ADD CONSTRAINT `fk_product_addon_lifecycle_status_id` FOREIGN KEY (`lifecycle_status_id`) REFERENCES `telecommunication_ecm`.`product`.`lifecycle_status`(`lifecycle_status_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ADD CONSTRAINT `fk_product_addon_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ADD CONSTRAINT `fk_product_sla_template_lifecycle_status_id` FOREIGN KEY (`lifecycle_status_id`) REFERENCES `telecommunication_ecm`.`product`.`lifecycle_status`(`lifecycle_status_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ADD CONSTRAINT `fk_product_relationship_lifecycle_status_id` FOREIGN KEY (`lifecycle_status_id`) REFERENCES `telecommunication_ecm`.`product`.`lifecycle_status`(`lifecycle_status_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ADD CONSTRAINT `fk_product_relationship_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ADD CONSTRAINT `fk_product_relationship_target_product_product_spec_id` FOREIGN KEY (`target_product_product_spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ADD CONSTRAINT `fk_product_lifecycle_status_superseded_by_status_lifecycle_status_id` FOREIGN KEY (`superseded_by_status_lifecycle_status_id`) REFERENCES `telecommunication_ecm`.`product`.`lifecycle_status`(`lifecycle_status_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ADD CONSTRAINT `fk_product_lifecycle_status_previous_lifecycle_status_id` FOREIGN KEY (`previous_lifecycle_status_id`) REFERENCES `telecommunication_ecm`.`product`.`lifecycle_status`(`lifecycle_status_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`category` ADD CONSTRAINT `fk_product_category_parent_category_id` FOREIGN KEY (`parent_category_id`) REFERENCES `telecommunication_ecm`.`product`.`category`(`category_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` ADD CONSTRAINT `fk_product_device_supply_agreement_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`offering_filing_metric` ADD CONSTRAINT `fk_product_offering_filing_metric_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`addon_eligibility` ADD CONSTRAINT `fk_product_addon_eligibility_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`addon_eligibility` ADD CONSTRAINT `fk_product_addon_eligibility_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ADD CONSTRAINT `fk_product_service_addon_subscription_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_subscription` ADD CONSTRAINT `fk_product_bundle_subscription_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_channel_inclusion` ADD CONSTRAINT `fk_product_bundle_channel_inclusion_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_promotion` ADD CONSTRAINT `fk_product_bundle_promotion_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`product_channel_lineup` ADD CONSTRAINT `fk_product_product_channel_lineup_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`offering_platform_bundle` ADD CONSTRAINT `fk_product_offering_platform_bundle_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_roaming_enablement` ADD CONSTRAINT `fk_product_catalog_roaming_enablement_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`skill_requirement` ADD CONSTRAINT `fk_product_skill_requirement_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`segment_eligibility` ADD CONSTRAINT `fk_product_segment_eligibility_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`rule_group` ADD CONSTRAINT `fk_product_rule_group_parent_rule_group_id` FOREIGN KEY (`parent_rule_group_id`) REFERENCES `telecommunication_ecm`.`product`.`rule_group`(`rule_group_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`zero_rating_program` ADD CONSTRAINT `fk_product_zero_rating_program_superseded_zero_rating_program_id` FOREIGN KEY (`superseded_zero_rating_program_id`) REFERENCES `telecommunication_ecm`.`product`.`zero_rating_program`(`zero_rating_program_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `telecommunication_ecm`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `analytical_subject_area_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Subject Area Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `coverage_area_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `iot_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Iot Tariff Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `lifecycle_status_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Product Manager Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `zero_rating_program_id` SET TAGS ('dbx_business_glossary_term' = 'Zero Rating Program Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `base_price` SET TAGS ('dbx_business_glossary_term' = 'Base Price');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `catalog_version` SET TAGS ('dbx_business_glossary_term' = 'Catalog Version');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `catalog_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `channel_count` SET TAGS ('dbx_business_glossary_term' = 'Channel Count');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term (Months)');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `data_allowance_gb` SET TAGS ('dbx_business_glossary_term' = 'Data Allowance (Gigabytes)');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `download_speed_mbps` SET TAGS ('dbx_business_glossary_term' = 'Download Speed (Megabits per Second)');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `end_of_life_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life (EOL) Date');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `end_of_sale_date` SET TAGS ('dbx_business_glossary_term' = 'End of Sale (EOS) Date');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `geographic_availability` SET TAGS ('dbx_business_glossary_term' = 'Geographic Availability');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `is_bundled` SET TAGS ('dbx_business_glossary_term' = 'Is Bundled Product');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `is_standalone` SET TAGS ('dbx_business_glossary_term' = 'Is Standalone Product');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `product_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `promotion_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `requires_device` SET TAGS ('dbx_business_glossary_term' = 'Requires Device');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `sla_mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Mean Time to Repair (MTTR) Hours');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `sms_allowance` SET TAGS ('dbx_business_glossary_term' = 'Short Message Service (SMS) Allowance');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `supports_esim` SET TAGS ('dbx_business_glossary_term' = 'Supports Embedded Subscriber Identity Module (eSIM)');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `supports_mnp` SET TAGS ('dbx_business_glossary_term' = 'Supports Mobile Number Portability (MNP)');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `supports_roaming` SET TAGS ('dbx_business_glossary_term' = 'Supports Roaming');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `upload_speed_mbps` SET TAGS ('dbx_business_glossary_term' = 'Upload Speed (Megabits per Second)');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `voice_minutes_allowance` SET TAGS ('dbx_business_glossary_term' = 'Voice Minutes Allowance');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` SET TAGS ('dbx_subdomain' = 'offering_management');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `analytical_subject_area_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Subject Area Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `coverage_area_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `lifecycle_status_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `offering_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Product Manager Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `offering_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `offering_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Template Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `base_monthly_price` SET TAGS ('dbx_business_glossary_term' = 'Base Monthly Recurring Revenue (MRR) Price');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `bundle_flag` SET TAGS ('dbx_business_glossary_term' = 'Bundle Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `channel_availability` SET TAGS ('dbx_business_glossary_term' = 'Channel Availability');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `competitive_positioning` SET TAGS ('dbx_business_glossary_term' = 'Competitive Positioning');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `competitive_positioning` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `content_entitlements` SET TAGS ('dbx_business_glossary_term' = 'Content Entitlements');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term (Months)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `credit_class_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Credit Class Eligibility');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `credit_class_eligibility` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|subprime|all');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `data_allowance_gb` SET TAGS ('dbx_business_glossary_term' = 'Data Allowance (Gigabytes)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `device_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Device Included Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `download_speed_mbps` SET TAGS ('dbx_business_glossary_term' = 'Download Speed (Megabits per Second)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `eligibility_rules_summary` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rules Summary');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `etf_structure` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Fee (ETF) Structure');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `etf_structure` SET TAGS ('dbx_value_regex' = 'flat|prorated|tiered|none');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `geographic_availability` SET TAGS ('dbx_business_glossary_term' = 'Geographic Availability Footprint');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `mvno_reseller_flag` SET TAGS ('dbx_business_glossary_term' = 'Mobile Virtual Network Operator (MVNO) Reseller Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `network_technology` SET TAGS ('dbx_business_glossary_term' = 'Network Technology');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `nps_target_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Target');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `offering_category` SET TAGS ('dbx_business_glossary_term' = 'Offering Category');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `offering_category` SET TAGS ('dbx_value_regex' = 'consumer|business|enterprise|wholesale|mvno');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `offering_code` SET TAGS ('dbx_business_glossary_term' = 'Offering Code');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `offering_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `offering_description` SET TAGS ('dbx_business_glossary_term' = 'Offering Description');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `offering_name` SET TAGS ('dbx_business_glossary_term' = 'Offering Name');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `offering_type` SET TAGS ('dbx_business_glossary_term' = 'Offering Type');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `offering_type` SET TAGS ('dbx_value_regex' = 'mobile_plan|broadband_package|iptv_bundle|ott_service|voip_offering|enterprise_sdwan');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `one_time_activation_fee` SET TAGS ('dbx_business_glossary_term' = 'One-Time Activation Fee');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'flat_rate|usage_based|tiered|hybrid|freemium|prepaid');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `roaming_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Roaming Included Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `sms_allowance` SET TAGS ('dbx_business_glossary_term' = 'Short Message Service (SMS) Allowance');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `upload_speed_mbps` SET TAGS ('dbx_business_glossary_term' = 'Upload Speed (Megabits per Second)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `voice_minutes_allowance` SET TAGS ('dbx_business_glossary_term' = 'Voice Minutes Allowance');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` SET TAGS ('dbx_subdomain' = 'offering_management');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `bi_report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Bi Report Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Product Manager Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `lifecycle_status_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `activation_fee` SET TAGS ('dbx_business_glossary_term' = 'Activation Fee');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|one_time|usage_based|prepaid');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `bundle_category` SET TAGS ('dbx_business_glossary_term' = 'Bundle Category');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `bundle_category` SET TAGS ('dbx_value_regex' = 'consumer|business|wholesale|mvno|iot|roaming');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `bundle_code` SET TAGS ('dbx_business_glossary_term' = 'Bundle Code');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `bundle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `bundle_description` SET TAGS ('dbx_business_glossary_term' = 'Bundle Description');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `bundle_name` SET TAGS ('dbx_business_glossary_term' = 'Bundle Name');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `bundle_type` SET TAGS ('dbx_business_glossary_term' = 'Bundle Type');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `bundle_type` SET TAGS ('dbx_value_regex' = 'fixed|flexible|customizable|dynamic|promotional|enterprise');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `channel_availability` SET TAGS ('dbx_business_glossary_term' = 'Channel Availability');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `component_substitution_allowed` SET TAGS ('dbx_business_glossary_term' = 'Component Substitution Allowed');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term Months');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `data_allowance_gb` SET TAGS ('dbx_business_glossary_term' = 'Data Allowance Gigabytes (GB)');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `device_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Device Included Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `downgrade_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Downgrade Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `early_termination_fee` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Fee (ETF)');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `geographic_availability` SET TAGS ('dbx_business_glossary_term' = 'Geographic Availability');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `installation_fee` SET TAGS ('dbx_business_glossary_term' = 'Installation Fee');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `international_roaming_included` SET TAGS ('dbx_business_glossary_term' = 'International Roaming Included');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `maximum_component_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Component Count');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `minimum_component_count` SET TAGS ('dbx_business_glossary_term' = 'Minimum Component Count');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `price_amount` SET TAGS ('dbx_business_glossary_term' = 'Bundle Price Amount');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'flat_rate|tiered|usage_based|hybrid|discount_off_components|promotional');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA)');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_value_regex' = 'standard|premium|enterprise|gold|platinum|best_effort');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `sms_allowance` SET TAGS ('dbx_business_glossary_term' = 'Short Message Service (SMS) Allowance');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `upgrade_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `voice_minutes_allowance` SET TAGS ('dbx_business_glossary_term' = 'Voice Minutes Allowance');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` SET TAGS ('dbx_subdomain' = 'pricing_promotion');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `bi_report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Bi Report Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Catalog Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `lifecycle_status_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Analyst Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Product Offering Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `superseded_by_price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Price Plan Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `advance_payment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Required Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `base_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Price Amount');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `bundle_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Bundle Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `charge_type` SET TAGS ('dbx_value_regex' = 'recurring|one_time|usage|overage|penalty|adjustment');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term Months');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'consumer|small_business|enterprise|government|wholesale|mvno');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `early_termination_fee` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Fee (ETF)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `geographic_availability` SET TAGS ('dbx_business_glossary_term' = 'Geographic Availability');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `included_quantity` SET TAGS ('dbx_business_glossary_term' = 'Included Quantity');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `maximum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge Amount');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `minimum_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Commitment Amount');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `overage_rate` SET TAGS ('dbx_business_glossary_term' = 'Overage Rate');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `price_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Code');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `price_plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `price_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Description');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `price_plan_name` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Name');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `pricing_model_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Type');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `pricing_model_type` SET TAGS ('dbx_value_regex' = 'flat_rate|tiered|volume_based|usage_based|event_based|hybrid');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `promotional_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotional End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `proration_policy` SET TAGS ('dbx_business_glossary_term' = 'Proration Policy');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `proration_policy` SET TAGS ('dbx_value_regex' = 'full_period|daily_proration|no_proration|custom');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `qos_tier` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Tier');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `qos_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|basic|best_effort');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `rating_group` SET TAGS ('dbx_business_glossary_term' = 'Rating Group');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `tax_category` SET TAGS ('dbx_value_regex' = 'standard|reduced|exempt|zero_rated|luxury|telecom_specific');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `tax_inclusive_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Inclusive Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `tiered_pricing_structure` SET TAGS ('dbx_business_glossary_term' = 'Tiered Pricing Structure');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` SET TAGS ('dbx_subdomain' = 'pricing_promotion');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `price_alteration_id` SET TAGS ('dbx_business_glossary_term' = 'Price Alteration Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `superseded_by_alteration_price_alteration_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Alteration Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `alteration_category` SET TAGS ('dbx_business_glossary_term' = 'Alteration Category');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `alteration_code` SET TAGS ('dbx_business_glossary_term' = 'Alteration Code');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `alteration_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `alteration_description` SET TAGS ('dbx_business_glossary_term' = 'Alteration Description');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `alteration_name` SET TAGS ('dbx_business_glossary_term' = 'Alteration Name');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `alteration_type` SET TAGS ('dbx_business_glossary_term' = 'Alteration Type');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `alteration_type` SET TAGS ('dbx_value_regex' = 'discount|surcharge|rebate|waiver|adjustment|credit');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `alteration_value` SET TAGS ('dbx_business_glossary_term' = 'Alteration Value');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `application_scope` SET TAGS ('dbx_business_glossary_term' = 'Application Scope');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `application_scope` SET TAGS ('dbx_value_regex' = 'account|subscription|service|usage|invoice');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `application_sequence` SET TAGS ('dbx_business_glossary_term' = 'Application Sequence');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_value_regex' = 'manager|director|vp|cfo|auto_approved');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `charge_type_filter` SET TAGS ('dbx_business_glossary_term' = 'Charge Type Filter');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `customer_segment_filter` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Filter');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|retired');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `maximum_alteration_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Alteration Amount');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `minimum_alteration_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Alteration Amount');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `promo_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `promo_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,15}$');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Frequency');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_value_regex' = 'one_time|recurring|usage_based|event_triggered');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `revenue_recognition_rule` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Rule');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `revenue_recognition_rule` SET TAGS ('dbx_value_regex' = 'immediate|deferred|prorated|milestone');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `service_type_filter` SET TAGS ('dbx_business_glossary_term' = 'Service Type Filter');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `stacking_rule` SET TAGS ('dbx_business_glossary_term' = 'Stacking Rule');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `stacking_rule` SET TAGS ('dbx_value_regex' = 'stackable|exclusive|conditional');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_value_regex' = 'taxable|non_taxable|tax_exempt|tax_inclusive');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `tenure_requirement_months` SET TAGS ('dbx_business_glossary_term' = 'Tenure Requirement Months');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `usage_threshold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Usage Threshold Quantity');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `usage_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Usage Threshold Unit');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `usage_threshold_unit` SET TAGS ('dbx_value_regex' = 'minutes|gigabytes|messages|calls|sessions|transactions');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `value_type` SET TAGS ('dbx_business_glossary_term' = 'Value Type');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `value_type` SET TAGS ('dbx_value_regex' = 'percentage|absolute|tiered|formula');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`product`.`price_alteration` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` SET TAGS ('dbx_subdomain' = 'pricing_promotion');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Offer Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `ab_test_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Manager Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Catalog Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `coverage_area_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `lifecycle_status_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `vod_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Vod Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `auto_apply_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Apply Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `bonus_data_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Data Amount');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `bonus_data_unit` SET TAGS ('dbx_business_glossary_term' = 'Bonus Data Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `bonus_data_unit` SET TAGS ('dbx_value_regex' = 'GB|MB|TB');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `budget_consumed` SET TAGS ('dbx_business_glossary_term' = 'Budget Consumed');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `budget_consumed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `discount_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Discount Currency Code');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `discount_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|tiered|bogo');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `eligibility_channel` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Channel');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `eligibility_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Customer Segment');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `eligibility_customer_type` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Customer Type');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `eligibility_customer_type` SET TAGS ('dbx_value_regex' = 'new|existing|churned|all');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `eligibility_geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Geographic Scope');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `eligibility_product_category` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Product Category');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `free_trial_duration` SET TAGS ('dbx_business_glossary_term' = 'Free Trial Duration');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `free_trial_unit` SET TAGS ('dbx_business_glossary_term' = 'Free Trial Duration Unit');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `free_trial_unit` SET TAGS ('dbx_value_regex' = 'days|months|billing_cycles');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `marketing_message` SET TAGS ('dbx_business_glossary_term' = 'Marketing Message');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `maximum_redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Redemption Count');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `minimum_commitment_period` SET TAGS ('dbx_business_glossary_term' = 'Minimum Commitment Period');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `promo_category` SET TAGS ('dbx_business_glossary_term' = 'Promotional Offer Category');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `promo_category` SET TAGS ('dbx_value_regex' = 'discount|free_trial|bonus_data|device_subsidy|bundle|waived_fee');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `promo_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `promo_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `promo_description` SET TAGS ('dbx_business_glossary_term' = 'Promotional Offer Description');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `promo_name` SET TAGS ('dbx_business_glossary_term' = 'Promotional Offer Name');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `promo_type` SET TAGS ('dbx_business_glossary_term' = 'Promotional Offer Type');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `promo_type` SET TAGS ('dbx_value_regex' = 'acquisition|retention|win_back|seasonal|loyalty|referral');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `redemption_limit_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit Per Customer');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `target_arpu_impact` SET TAGS ('dbx_business_glossary_term' = 'Target Average Revenue Per User (ARPU) Impact');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification ID');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `content_channel_lineup_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Lineup Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Product Manager Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `allowance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allowance Quantity');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `allowance_type` SET TAGS ('dbx_business_glossary_term' = 'Allowance Type');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `allowance_type` SET TAGS ('dbx_value_regex' = 'data|voice|sms|roaming_data|roaming_voice|international_minutes');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `bandwidth_mbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth (Mbps)');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `burst_bandwidth_mbps` SET TAGS ('dbx_business_glossary_term' = 'Burst Bandwidth (Mbps)');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `channel_count` SET TAGS ('dbx_business_glossary_term' = 'Channel Count');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `characteristic_name` SET TAGS ('dbx_business_glossary_term' = 'Characteristic Name');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `characteristic_value` SET TAGS ('dbx_business_glossary_term' = 'Characteristic Value');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `concurrent_streams` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Streams');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `download_speed_mbps` SET TAGS ('dbx_business_glossary_term' = 'Download Speed (Mbps)');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `dvr_hours` SET TAGS ('dbx_business_glossary_term' = 'Digital Video Recorder (DVR) Hours');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `fair_use_limit_gb` SET TAGS ('dbx_business_glossary_term' = 'Fair Use Limit (Gigabytes)');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `is_rollover_enabled` SET TAGS ('dbx_business_glossary_term' = 'Is Rollover Enabled');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `is_shared` SET TAGS ('dbx_business_glossary_term' = 'Is Shared');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `is_unlimited` SET TAGS ('dbx_business_glossary_term' = 'Is Unlimited');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Latency (Milliseconds)');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time to Repair (MTTR) Hours');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `overage_policy` SET TAGS ('dbx_business_glossary_term' = 'Overage Policy');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `overage_policy` SET TAGS ('dbx_value_regex' = 'block|throttle|charge|rollover|unlimited');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `qos_class` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Class');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `qos_class` SET TAGS ('dbx_value_regex' = 'best_effort|guaranteed|premium|mission_critical');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `reset_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reset Frequency');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `reset_frequency` SET TAGS ('dbx_value_regex' = 'monthly|daily|weekly|annual|one_time|never');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `roaming_data_allowance_gb` SET TAGS ('dbx_business_glossary_term' = 'Roaming Data Allowance (Gigabytes)');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `roaming_zone` SET TAGS ('dbx_business_glossary_term' = 'Roaming Zone');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `sla_uptime_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percent');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `spec_category` SET TAGS ('dbx_business_glossary_term' = 'Specification Category');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `spec_category` SET TAGS ('dbx_value_regex' = 'usage_allowance|network_capability|service_feature|qos_parameter|device_capability|pricing_rule');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `spec_description` SET TAGS ('dbx_business_glossary_term' = 'Specification Description');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `spec_name` SET TAGS ('dbx_business_glossary_term' = 'Specification Name');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `spec_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `spec_status` SET TAGS ('dbx_value_regex' = 'draft|active|deprecated|retired');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `spec_type` SET TAGS ('dbx_business_glossary_term' = 'Specification Type');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `throttle_speed_mbps` SET TAGS ('dbx_business_glossary_term' = 'Throttle Speed (Mbps)');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `upload_speed_mbps` SET TAGS ('dbx_business_glossary_term' = 'Upload Speed (Mbps)');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `value_type` SET TAGS ('dbx_business_glossary_term' = 'Value Type');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `value_type` SET TAGS ('dbx_value_regex' = 'numeric|boolean|string|enumeration|range');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` SET TAGS ('dbx_subdomain' = 'offering_management');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `eligibility_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Business Analyst Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `coverage_area_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `lifecycle_status_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Product Offering Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `rule_group_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Group Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Approved By User');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Approved Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Channel Applicability');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Compliance Framework');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Effective End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Error Message');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `evaluation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Evaluation Frequency');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `evaluation_frequency` SET TAGS ('dbx_value_regex' = 'real_time|daily|weekly|monthly|on_demand|event_triggered');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `external_rule_code` SET TAGS ('dbx_business_glossary_term' = 'External Eligibility Rule Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Geographic Scope');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Mandatory Indicator');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `is_overridable` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Override Indicator');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `logical_operator` SET TAGS ('dbx_business_glossary_term' = 'Logical Combination Operator');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `logical_operator` SET TAGS ('dbx_value_regex' = 'AND|OR');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Market Segment');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Modified By User');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Notes');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `override_authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Override Authorization Level');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `override_authorization_level` SET TAGS ('dbx_value_regex' = 'agent|supervisor|manager|director|executive|system_admin');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Priority');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Product Category');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `rule_attribute` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Attribute');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Description');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Name');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `rule_operator` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Operator');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `rule_sequence` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Sequence Number');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `rule_source_system` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Source System');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Type');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `rule_value` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Value');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `rule_version` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Version');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Tags');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Created By User');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` SET TAGS ('dbx_subdomain' = 'offering_management');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `compatibility_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Rule Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `lifecycle_status_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Source Product Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `target_product_catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Target Product Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Analyst Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'retail|online|telesales|partner|enterprise_direct');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `constraint_operator` SET TAGS ('dbx_business_glossary_term' = 'Constraint Operator');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `constraint_operator` SET TAGS ('dbx_value_regex' = 'equals|greater_than|less_than|greater_or_equal|less_or_equal');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'consumer|business|enterprise|wholesale|government');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `enforcement_level` SET TAGS ('dbx_business_glossary_term' = 'Rule Enforcement Level');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `enforcement_level` SET TAGS ('dbx_value_regex' = 'mandatory|warning|informational');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Validation Error Message');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `external_rule_code` SET TAGS ('dbx_business_glossary_term' = 'External Rule Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rule Notes');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `override_allowed` SET TAGS ('dbx_business_glossary_term' = 'Override Allowed Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `override_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Override Approval Required Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Rule Priority');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `quantity_constraint` SET TAGS ('dbx_business_glossary_term' = 'Quantity Constraint');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Rule Code');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Rule Description');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `rule_direction` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Rule Direction');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `rule_direction` SET TAGS ('dbx_value_regex' = 'unidirectional|bidirectional');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `rule_expression` SET TAGS ('dbx_business_glossary_term' = 'Rule Expression');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Rule Name');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Rule Type');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'requires|conflicts|recommends|supersedes');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `validation_scope` SET TAGS ('dbx_business_glossary_term' = 'Validation Scope');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `validation_scope` SET TAGS ('dbx_value_regex' = 'order|subscription|account|customer');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`product`.`compatibility_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` SET TAGS ('dbx_subdomain' = 'offering_management');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Model Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `lifecycle_status_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Product Manager Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `battery_capacity_mah` SET TAGS ('dbx_business_glossary_term' = 'Battery Capacity (Milliampere-Hours)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `color_variants` SET TAGS ('dbx_business_glossary_term' = 'Available Color Variants');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `device_category` SET TAGS ('dbx_business_glossary_term' = 'Device Category');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `device_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Device Subcategory');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `dimensions` SET TAGS ('dbx_business_glossary_term' = 'Device Dimensions');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Device Discontinuation Date');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `display_resolution` SET TAGS ('dbx_business_glossary_term' = 'Display Resolution');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `display_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Display Size (Inches)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `drm_support` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Support');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `dual_sim_support` SET TAGS ('dbx_business_glossary_term' = 'Dual SIM Support');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `end_of_support_date` SET TAGS ('dbx_business_glossary_term' = 'End of Support Date');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `esim_capable` SET TAGS ('dbx_business_glossary_term' = 'Embedded SIM (eSIM) Capable');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `ethernet_ports` SET TAGS ('dbx_business_glossary_term' = 'Number of Ethernet Ports');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `frequency_bands` SET TAGS ('dbx_business_glossary_term' = 'Supported Frequency Bands');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `gps_enabled` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Enabled');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `imei_range_end` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Equipment Identity (IMEI) Range End');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `imei_range_end` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `imei_range_start` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Equipment Identity (IMEI) Range Start');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `imei_range_start` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Device Launch Date');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Device Manufacturer');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Device Model Name');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Device Model Number');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `nfc_enabled` SET TAGS ('dbx_business_glossary_term' = 'Near Field Communication (NFC) Enabled');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System (OS)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `processor_chipset` SET TAGS ('dbx_business_glossary_term' = 'Processor Chipset');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `ram_capacity_gb` SET TAGS ('dbx_business_glossary_term' = 'Random Access Memory (RAM) Capacity (Gigabytes)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `retail_price` SET TAGS ('dbx_business_glossary_term' = 'Retail Price');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `retail_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `sar_value` SET TAGS ('dbx_business_glossary_term' = 'Specific Absorption Rate (SAR) Value');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `storage_capacity_gb` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity (Gigabytes)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `supplier_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Code');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `tac_code` SET TAGS ('dbx_business_glossary_term' = 'Type Allocation Code (TAC)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `technology_support` SET TAGS ('dbx_business_glossary_term' = 'Technology Support');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `usb_ports` SET TAGS ('dbx_business_glossary_term' = 'Number of Universal Serial Bus (USB) Ports');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `video_codec_support` SET TAGS ('dbx_business_glossary_term' = 'Video Codec Support');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `voip_capable` SET TAGS ('dbx_business_glossary_term' = 'Voice over Internet Protocol (VoIP) Capable');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `water_resistance_rating` SET TAGS ('dbx_business_glossary_term' = 'Water Resistance Rating');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `weight_grams` SET TAGS ('dbx_business_glossary_term' = 'Device Weight (Grams)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `wholesale_cost` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Cost');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `wholesale_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `wifi_standard` SET TAGS ('dbx_business_glossary_term' = 'Wi-Fi Standard');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` SET TAGS ('dbx_subdomain' = 'offering_management');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `device_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Device Offering Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Accessory Bundle Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Model Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `lifecycle_status_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Device Supplier Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Required Service Plan Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `bundle_eligible` SET TAGS ('dbx_business_glossary_term' = 'Bundle Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `channel_availability` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Availability');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Term (Months)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `credit_check_required` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Required Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'consumer|small_business|enterprise|government|wholesale');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `deposit_required` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Required Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `down_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Down Payment Amount');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `early_termination_fee` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Fee (ETF)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Offering Effective End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Offering Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `full_retail_price` SET TAGS ('dbx_business_glossary_term' = 'Full Retail Price');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `geographic_availability` SET TAGS ('dbx_business_glossary_term' = 'Geographic Availability');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `installment_term_months` SET TAGS ('dbx_business_glossary_term' = 'Installment Term (Months)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `insurance_eligible` SET TAGS ('dbx_business_glossary_term' = 'Device Insurance Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `inventory_sku` SET TAGS ('dbx_business_glossary_term' = 'Inventory Stock Keeping Unit (SKU)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `minimum_credit_score` SET TAGS ('dbx_business_glossary_term' = 'Minimum Credit Score Requirement');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `minimum_plan_arpu` SET TAGS ('dbx_business_glossary_term' = 'Minimum Plan Average Revenue Per User (ARPU)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `monthly_installment_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Installment Amount');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `network_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Network Technology Compatibility');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `offering_code` SET TAGS ('dbx_business_glossary_term' = 'Device Offering Code');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `offering_name` SET TAGS ('dbx_business_glossary_term' = 'Device Offering Name');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `offering_price` SET TAGS ('dbx_business_glossary_term' = 'Device Offering Price');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `offering_type` SET TAGS ('dbx_business_glossary_term' = 'Device Offering Type');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `offering_type` SET TAGS ('dbx_value_regex' = 'outright_purchase|installment_plan|subsidized_contract|lease|device_as_a_service');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `promotional_offering` SET TAGS ('dbx_business_glossary_term' = 'Promotional Offering Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `residual_value` SET TAGS ('dbx_business_glossary_term' = 'Device Residual Value');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `restocking_fee` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `return_period_days` SET TAGS ('dbx_business_glossary_term' = 'Return Period (Days)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `sim_type_required` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identity Module (SIM) Type Required');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `sim_type_required` SET TAGS ('dbx_value_regex' = 'physical_sim|esim|dual_sim|sim_free');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Device Subsidy Amount');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `trade_in_eligible` SET TAGS ('dbx_business_glossary_term' = 'Trade-In Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `unlock_eligibility_days` SET TAGS ('dbx_business_glossary_term' = 'Device Unlock Eligibility Period (Days)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `unlock_eligible` SET TAGS ('dbx_business_glossary_term' = 'Device Unlock Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`device_offering` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Warranty Period (Months)');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` SET TAGS ('dbx_subdomain' = 'offering_management');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Add-On Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `coverage_area_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `iot_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Iot Tariff Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `lifecycle_status_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Product Manager Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Base Product Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `vod_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Vod Catalog Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `activation_method` SET TAGS ('dbx_business_glossary_term' = 'Activation Method');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `activation_method` SET TAGS ('dbx_value_regex' = 'instant|scheduled|manual_approval|provisioning_required');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `addon_category` SET TAGS ('dbx_business_glossary_term' = 'Add-On Category');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `addon_code` SET TAGS ('dbx_business_glossary_term' = 'Add-On Code');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `addon_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `addon_description` SET TAGS ('dbx_business_glossary_term' = 'Add-On Description');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `addon_name` SET TAGS ('dbx_business_glossary_term' = 'Add-On Name');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `addon_type` SET TAGS ('dbx_business_glossary_term' = 'Add-On Type');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `addon_type` SET TAGS ('dbx_value_regex' = 'one_time|recurring|usage_based|hybrid');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `channel_availability` SET TAGS ('dbx_business_glossary_term' = 'Channel Availability');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `deactivation_method` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Method');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `deactivation_method` SET TAGS ('dbx_value_regex' = 'instant|end_of_period|manual|grace_period');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `external_product_code` SET TAGS ('dbx_business_glossary_term' = 'External Product Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `max_quantity_per_subscription` SET TAGS ('dbx_business_glossary_term' = 'Maximum Quantity Per Subscription');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `min_quantity_per_subscription` SET TAGS ('dbx_business_glossary_term' = 'Minimum Quantity Per Subscription');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `price_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Amount');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'flat_rate|tiered|volume|usage_based|freemium|promotional');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `promotion_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{0,20}$');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `proration_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Proration Allowed Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `quota_unit` SET TAGS ('dbx_business_glossary_term' = 'Quota Unit');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `quota_value` SET TAGS ('dbx_business_glossary_term' = 'Quota Value');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `revenue_recognition_rule` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Rule');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `revenue_recognition_rule` SET TAGS ('dbx_value_regex' = 'immediate|deferred|prorated|usage_based');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `rollover_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollover Allowed Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|premium|gold|platinum|enterprise');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Add-On Short Description');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{0,20}$');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `trial_period_days` SET TAGS ('dbx_business_glossary_term' = 'Trial Period Days');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `validity_period_unit` SET TAGS ('dbx_business_glossary_term' = 'Validity Period Unit');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `validity_period_unit` SET TAGS ('dbx_value_regex' = 'day|week|month|year|perpetual');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `validity_period_value` SET TAGS ('dbx_business_glossary_term' = 'Validity Period Value');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Template Identifier');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `lifecycle_status_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Manager Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `availability_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Availability Target Percentage');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `bandwidth_guarantee_mbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Guarantee Megabits per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'enterprise|business|sme|consumer|government|wholesale');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `escalation_matrix` SET TAGS ('dbx_business_glossary_term' = 'Escalation Matrix');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Exclusions');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `jitter_threshold_ms` SET TAGS ('dbx_business_glossary_term' = 'Jitter Threshold Milliseconds');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `latency_threshold_ms` SET TAGS ('dbx_business_glossary_term' = 'Latency Threshold Milliseconds');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `maintenance_window` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `max_penalty_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Penalty Percentage');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `measurement_window` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `measurement_window` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|rolling_30_day|rolling_90_day');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `mttr_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time to Repair (MTTR) Target Hours');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `notification_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Notification Lead Time Hours');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `packet_loss_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Packet Loss Threshold Percentage');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `penalty_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Penalty Calculation Method');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `penalty_type` SET TAGS ('dbx_business_glossary_term' = 'Penalty Type');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `penalty_type` SET TAGS ('dbx_value_regex' = 'service_credit|refund|rebate|none');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `regulatory_compliance` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `reporting_format` SET TAGS ('dbx_business_glossary_term' = 'Reporting Format');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'real_time|daily|weekly|monthly|quarterly');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `resolution_time_priority_1_hours` SET TAGS ('dbx_business_glossary_term' = 'Resolution Time Priority 1 Hours');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `resolution_time_priority_2_hours` SET TAGS ('dbx_business_glossary_term' = 'Resolution Time Priority 2 Hours');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `resolution_time_priority_3_hours` SET TAGS ('dbx_business_glossary_term' = 'Resolution Time Priority 3 Hours');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `response_time_priority_1_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time Priority 1 Hours');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `response_time_priority_2_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time Priority 2 Hours');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `response_time_priority_3_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time Priority 3 Hours');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `sla_template_description` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Template Description');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `support_channel` SET TAGS ('dbx_business_glossary_term' = 'Support Channel');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `support_hours` SET TAGS ('dbx_business_glossary_term' = 'Support Hours');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `support_hours` SET TAGS ('dbx_value_regex' = '24x7|business_hours|extended_hours');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Template Code');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `template_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Template Name');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard|basic');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `telecommunication_ecm`.`product`.`sla_template` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` SET TAGS ('dbx_subdomain' = 'offering_management');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Product Relationship Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `lifecycle_status_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Product Strategist Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Source Product Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `target_product_product_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Target Product Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|retail_store|call_center|partner|dealer');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `constraint_operator` SET TAGS ('dbx_business_glossary_term' = 'Constraint Operator');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `constraint_operator` SET TAGS ('dbx_value_regex' = 'AND|OR|NOT|XOR');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'consumer|small_business|enterprise|government|wholesale');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Relationship Direction');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'unidirectional|bidirectional');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `eligibility_condition` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Condition');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `enforcement_level` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Level');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `enforcement_level` SET TAGS ('dbx_value_regex' = 'mandatory|recommended|informational');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `external_rule_code` SET TAGS ('dbx_business_glossary_term' = 'External Rule Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `migration_incentive_description` SET TAGS ('dbx_business_glossary_term' = 'Migration Incentive Description');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `migration_incentive_flag` SET TAGS ('dbx_business_glossary_term' = 'Migration Incentive Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Relationship Notes');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `override_allowed` SET TAGS ('dbx_business_glossary_term' = 'Override Allowed Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `override_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Override Approval Required Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Relationship Priority');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `quantity_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Quantity');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `quantity_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Quantity');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'requires|conflicts|recommends|supersedes|migration_path|upsell');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `rule_expression` SET TAGS ('dbx_business_glossary_term' = 'Rule Expression');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `validation_scope` SET TAGS ('dbx_business_glossary_term' = 'Validation Scope');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `validation_scope` SET TAGS ('dbx_value_regex' = 'order|cart|subscription|account');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`product`.`relationship` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `lifecycle_status_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `dq_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Dq Rule Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `superseded_by_status_lifecycle_status_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Lifecycle Status Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `previous_lifecycle_status_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `allowed_predecessor_statuses` SET TAGS ('dbx_business_glossary_term' = 'Allowed Predecessor Lifecycle Statuses');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `allowed_successor_statuses` SET TAGS ('dbx_business_glossary_term' = 'Allowed Successor Lifecycle Statuses');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `allows_existing_customers` SET TAGS ('dbx_business_glossary_term' = 'Existing Customer Service Allowed Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `allows_new_customers` SET TAGS ('dbx_business_glossary_term' = 'New Customer Acquisition Allowed Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_value_regex' = 'product_manager|director|vp|cxo');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Approval Required Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `display_sequence` SET TAGS ('dbx_business_glossary_term' = 'Display Sequence Order');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status Effective End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `external_status_code` SET TAGS ('dbx_business_glossary_term' = 'External System Status Code');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `is_active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status Indicator Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `is_downgradeable` SET TAGS ('dbx_business_glossary_term' = 'Downgradeable Status Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `is_orderable` SET TAGS ('dbx_business_glossary_term' = 'Orderable Status Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `is_provisionable` SET TAGS ('dbx_business_glossary_term' = 'Provisionable Status Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `is_renewable` SET TAGS ('dbx_business_glossary_term' = 'Renewable Status Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `is_system_status` SET TAGS ('dbx_business_glossary_term' = 'System-Defined Status Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `is_upgradeable` SET TAGS ('dbx_business_glossary_term' = 'Upgradeable Status Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `migration_deadline_days` SET TAGS ('dbx_business_glossary_term' = 'Migration Deadline Days');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `notification_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Lead Time Days');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `requires_migration` SET TAGS ('dbx_business_glossary_term' = 'Customer Migration Required Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Record');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `status_category` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status Category');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `status_category` SET TAGS ('dbx_value_regex' = 'pre-launch|active|sunset|retired');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `status_code` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status Code');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `status_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `status_description` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status Description');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `status_name` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status Name');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `status_version` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status Definition Version Number');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `supports_billing` SET TAGS ('dbx_business_glossary_term' = 'Billing Support Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `supports_usage_rating` SET TAGS ('dbx_business_glossary_term' = 'Usage Rating Support Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `visible_in_catalog` SET TAGS ('dbx_business_glossary_term' = 'Catalog Visibility Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `visible_in_channel` SET TAGS ('dbx_business_glossary_term' = 'Channel Visibility Scope');
ALTER TABLE `telecommunication_ecm`.`product`.`lifecycle_status` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `telecommunication_ecm`.`product`.`category` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `telecommunication_ecm`.`product`.`category` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `analytical_subject_area_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Subject Area Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Product Manager Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `parent_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Product Category Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|one_time|usage_based|daily');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Product Category Code');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Product Category Description');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Product Category Name');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `category_type` SET TAGS ('dbx_business_glossary_term' = 'Product Category Type');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `category_type` SET TAGS ('dbx_value_regex' = 'consumer|business|enterprise|wholesale|mvno');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `channel_availability` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Availability');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Standard Contract Term (Months)');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Category Display Order');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Category Hierarchy Level');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `icon_url` SET TAGS ('dbx_business_glossary_term' = 'Category Icon Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `is_bundleable` SET TAGS ('dbx_business_glossary_term' = 'Bundleable Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `is_standalone` SET TAGS ('dbx_business_glossary_term' = 'Standalone Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Category Lifecycle Status');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|planned|retired');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `marketing_label` SET TAGS ('dbx_business_glossary_term' = 'Marketing Label');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Category Notes');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Type');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `requires_device` SET TAGS ('dbx_business_glossary_term' = 'Device Requirement Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `revenue_recognition_rule` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Rule');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `roaming_eligible` SET TAGS ('dbx_business_glossary_term' = 'Roaming Eligibility Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `search_keywords` SET TAGS ('dbx_business_glossary_term' = 'Search Keywords');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `service_domain` SET TAGS ('dbx_business_glossary_term' = 'Service Domain');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'basic|standard|premium|enterprise|carrier_grade');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `supports_esim` SET TAGS ('dbx_business_glossary_term' = 'Embedded SIM (eSIM) Support Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `supports_mnp` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number Portability (MNP) Support Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category Code');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Category Version Number');
ALTER TABLE `telecommunication_ecm`.`product`.`category` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` SET TAGS ('dbx_subdomain' = 'offering_management');
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` SET TAGS ('dbx_association_edges' = 'product.device_model,partner.partner');
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` ALTER COLUMN `device_supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Device Supply Agreement ID');
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Supply Agreement - Device Model Id');
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Device Supply Agreement - Partner Id');
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` ALTER COLUMN `inventory_allocation_quantity` SET TAGS ('dbx_business_glossary_term' = 'Inventory Allocation Quantity');
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` ALTER COLUMN `preferred_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` ALTER COLUMN `return_policy_days` SET TAGS ('dbx_business_glossary_term' = 'Return Policy Days');
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_pii_business_sensitive' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` ALTER COLUMN `warranty_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms');
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` ALTER COLUMN `wholesale_cost` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Cost');
ALTER TABLE `telecommunication_ecm`.`product`.`device_supply_agreement` ALTER COLUMN `wholesale_cost` SET TAGS ('dbx_pii_business_sensitive' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_filing_metric` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_filing_metric` SET TAGS ('dbx_subdomain' = 'offering_management');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_filing_metric` SET TAGS ('dbx_association_edges' = 'product.offering,compliance.regulatory_filing');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_filing_metric` ALTER COLUMN `offering_filing_metric_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Filing Metric ID');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_filing_metric` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Filing Metric - Offering Id');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_filing_metric` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Filing Metric - Regulatory Filing Id');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_filing_metric` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_filing_metric` ALTER COLUMN `filing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Period End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_filing_metric` ALTER COLUMN `filing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Period Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_filing_metric` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_filing_metric` ALTER COLUMN `preparation_date` SET TAGS ('dbx_business_glossary_term' = 'Preparation Date');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_filing_metric` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Name');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_filing_metric` ALTER COLUMN `reported_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Reported Revenue Amount');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_filing_metric` ALTER COLUMN `reported_revenue_amount` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_filing_metric` ALTER COLUMN `reported_subscriber_count` SET TAGS ('dbx_business_glossary_term' = 'Reported Subscriber Count');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_filing_metric` ALTER COLUMN `reported_usage_volume` SET TAGS ('dbx_business_glossary_term' = 'Reported Usage Volume');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_filing_metric` ALTER COLUMN `revenue_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Category');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_filing_metric` ALTER COLUMN `service_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Service Classification Code');
ALTER TABLE `telecommunication_ecm`.`product`.`addon_eligibility` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`product`.`addon_eligibility` SET TAGS ('dbx_subdomain' = 'offering_management');
ALTER TABLE `telecommunication_ecm`.`product`.`addon_eligibility` SET TAGS ('dbx_association_edges' = 'product.addon,product.offering');
ALTER TABLE `telecommunication_ecm`.`product`.`addon_eligibility` ALTER COLUMN `addon_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Add-on Eligibility Identifier');
ALTER TABLE `telecommunication_ecm`.`product`.`addon_eligibility` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Eligibility - Addon Id');
ALTER TABLE `telecommunication_ecm`.`product`.`addon_eligibility` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Eligibility - Offering Id');
ALTER TABLE `telecommunication_ecm`.`product`.`addon_eligibility` ALTER COLUMN `addon_price_override` SET TAGS ('dbx_business_glossary_term' = 'Add-on Price Override');
ALTER TABLE `telecommunication_ecm`.`product`.`addon_eligibility` ALTER COLUMN `auto_attach_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Attach Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`addon_eligibility` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `telecommunication_ecm`.`product`.`addon_eligibility` ALTER COLUMN `display_priority` SET TAGS ('dbx_business_glossary_term' = 'Display Priority');
ALTER TABLE `telecommunication_ecm`.`product`.`addon_eligibility` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`addon_eligibility` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`addon_eligibility` ALTER COLUMN `eligibility_condition` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Condition');
ALTER TABLE `telecommunication_ecm`.`product`.`addon_eligibility` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `telecommunication_ecm`.`product`.`addon_eligibility` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `telecommunication_ecm`.`product`.`addon_eligibility` ALTER COLUMN `max_quantity_per_offering` SET TAGS ('dbx_business_glossary_term' = 'Maximum Quantity Per Offering');
ALTER TABLE `telecommunication_ecm`.`product`.`addon_eligibility` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` SET TAGS ('dbx_association_edges' = 'product.addon,enterprise.managed_service');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ALTER COLUMN `service_addon_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Service Add-on Subscription Identifier');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Service Addon Subscription - Addon Id');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Service Addon Subscription - Managed Service Id');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Add-on Activation Date');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ALTER COLUMN `addon_status` SET TAGS ('dbx_business_glossary_term' = 'Add-on Subscription Status');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ALTER COLUMN `auto_renewal_override` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Override');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ALTER COLUMN `billing_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Add-on Deactivation Date');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Reason');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Add-on Expiration Date');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ALTER COLUMN `last_billing_date` SET TAGS ('dbx_business_glossary_term' = 'Last Billing Date');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modification Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ALTER COLUMN `next_billing_date` SET TAGS ('dbx_business_glossary_term' = 'Next Billing Date');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ALTER COLUMN `price_override` SET TAGS ('dbx_business_glossary_term' = 'Add-on Price Override');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ALTER COLUMN `provisioning_date` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Completion Date');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ALTER COLUMN `provisioning_status` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Status');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Add-on Quantity');
ALTER TABLE `telecommunication_ecm`.`product`.`service_addon_subscription` ALTER COLUMN `trial_flag` SET TAGS ('dbx_business_glossary_term' = 'Trial Period Indicator');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_subscription` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_subscription` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_subscription` SET TAGS ('dbx_association_edges' = 'product.bundle,enterprise.corporate_account');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_subscription` ALTER COLUMN `bundle_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Subscription Identifier');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_subscription` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Subscription - Bundle Id');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_subscription` ALTER COLUMN `enterprise_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_subscription` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Subscription - Corporate Account Id');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_subscription` ALTER COLUMN `bundle_quantity` SET TAGS ('dbx_business_glossary_term' = 'Bundle Quantity');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_subscription` ALTER COLUMN `discount_applied` SET TAGS ('dbx_business_glossary_term' = 'Discount Applied');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_subscription` ALTER COLUMN `monthly_recurring_revenue` SET TAGS ('dbx_business_glossary_term' = 'Monthly Recurring Revenue');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_subscription` ALTER COLUMN `renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_subscription` ALTER COLUMN `subscription_end_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_subscription` ALTER COLUMN `subscription_start_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_subscription` ALTER COLUMN `subscription_status` SET TAGS ('dbx_business_glossary_term' = 'Subscription Status');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_channel_inclusion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_channel_inclusion` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_channel_inclusion` SET TAGS ('dbx_association_edges' = 'product.bundle,content.iptv_channel');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_channel_inclusion` ALTER COLUMN `bundle_channel_inclusion_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Channel Inclusion Identifier');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_channel_inclusion` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Channel Inclusion - Bundle Id');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_channel_inclusion` ALTER COLUMN `iptv_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Channel Inclusion - Iptv Channel Id');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_channel_inclusion` ALTER COLUMN `additional_charge` SET TAGS ('dbx_business_glossary_term' = 'Additional Charge');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_channel_inclusion` ALTER COLUMN `channel_position` SET TAGS ('dbx_business_glossary_term' = 'Channel Position');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_channel_inclusion` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_channel_inclusion` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_channel_inclusion` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_channel_inclusion` ALTER COLUMN `is_optional` SET TAGS ('dbx_business_glossary_term' = 'Is Optional Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_channel_inclusion` ALTER COLUMN `is_premium_channel` SET TAGS ('dbx_business_glossary_term' = 'Is Premium Channel Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_channel_inclusion` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_channel_inclusion` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Tier Level');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_promotion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_promotion` SET TAGS ('dbx_subdomain' = 'pricing_promotion');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_promotion` SET TAGS ('dbx_association_edges' = 'product.bundle,sales.promotion');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_promotion` ALTER COLUMN `bundle_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Promotion Identifier');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_promotion` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Promotion - Bundle Id');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_promotion` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Creator Employee ID');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_promotion` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_promotion` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_promotion` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Promotion - Promotion Id');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_promotion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_promotion` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Bundle-Specific Discount Amount');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_promotion` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Bundle Promotion Effective End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_promotion` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Bundle Promotion Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_promotion` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Promotion Priority Rank');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_promotion` ALTER COLUMN `promotional_bundle_price` SET TAGS ('dbx_business_glossary_term' = 'Promotional Bundle Price');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_promotion` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_promotion` ALTER COLUMN `redemption_limit` SET TAGS ('dbx_business_glossary_term' = 'Bundle-Specific Redemption Limit');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_promotion` ALTER COLUMN `stacking_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Bundle-Specific Stacking Allowed');
ALTER TABLE `telecommunication_ecm`.`product`.`product_channel_lineup` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`product`.`product_channel_lineup` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `telecommunication_ecm`.`product`.`product_channel_lineup` SET TAGS ('dbx_association_edges' = 'product.catalog_item,content.iptv_channel');
ALTER TABLE `telecommunication_ecm`.`product`.`product_channel_lineup` ALTER COLUMN `product_channel_lineup_id` SET TAGS ('dbx_business_glossary_term' = 'product_channel_lineup Identifier');
ALTER TABLE `telecommunication_ecm`.`product`.`product_channel_lineup` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Lineup - Catalog Item Id');
ALTER TABLE `telecommunication_ecm`.`product`.`product_channel_lineup` ALTER COLUMN `content_channel_lineup_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Lineup Configuration Identifier');
ALTER TABLE `telecommunication_ecm`.`product`.`product_channel_lineup` ALTER COLUMN `iptv_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Lineup - Iptv Channel Id');
ALTER TABLE `telecommunication_ecm`.`product`.`product_channel_lineup` ALTER COLUMN `channel_position` SET TAGS ('dbx_business_glossary_term' = 'Channel Position in Package');
ALTER TABLE `telecommunication_ecm`.`product`.`product_channel_lineup` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Lineup Configuration Created Date');
ALTER TABLE `telecommunication_ecm`.`product`.`product_channel_lineup` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lineup Inclusion End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`product_channel_lineup` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lineup Inclusion Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`product_channel_lineup` ALTER COLUMN `inclusion_status` SET TAGS ('dbx_business_glossary_term' = 'Channel Inclusion Status');
ALTER TABLE `telecommunication_ecm`.`product`.`product_channel_lineup` ALTER COLUMN `is_featured` SET TAGS ('dbx_business_glossary_term' = 'Featured Channel Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`product_channel_lineup` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Lineup Configuration Last Modified By');
ALTER TABLE `telecommunication_ecm`.`product`.`product_channel_lineup` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Lineup Configuration Last Modified Date');
ALTER TABLE `telecommunication_ecm`.`product`.`product_channel_lineup` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Channel Sort Order');
ALTER TABLE `telecommunication_ecm`.`product`.`product_channel_lineup` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Channel Tier Level');
ALTER TABLE `telecommunication_ecm`.`product`.`product_channel_lineup` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Lineup Configuration Created By');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_platform_bundle` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_platform_bundle` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_platform_bundle` SET TAGS ('dbx_association_edges' = 'product.offering,content.ott_platform');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_platform_bundle` ALTER COLUMN `offering_platform_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Platform Bundle ID');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_platform_bundle` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Platform Bundle - Offering Id');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_platform_bundle` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Platform Bundle - Ott Platform Id');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_platform_bundle` ALTER COLUMN `bundle_status` SET TAGS ('dbx_business_glossary_term' = 'Bundle Status');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_platform_bundle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_platform_bundle` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_platform_bundle` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_platform_bundle` ALTER COLUMN `incremental_monthly_charge` SET TAGS ('dbx_business_glossary_term' = 'Incremental Monthly Charge');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_platform_bundle` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_platform_bundle` ALTER COLUMN `promotional_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotional End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_platform_bundle` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_platform_bundle` ALTER COLUMN `provisioning_method` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Method');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_platform_bundle` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_platform_bundle` ALTER COLUMN `subscription_tier` SET TAGS ('dbx_business_glossary_term' = 'Subscription Tier');
ALTER TABLE `telecommunication_ecm`.`product`.`offering_platform_bundle` ALTER COLUMN `trial_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Trial Duration Months');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_roaming_enablement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_roaming_enablement` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_roaming_enablement` SET TAGS ('dbx_association_edges' = 'product.catalog_item,interconnect.carrier_agreement');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_roaming_enablement` ALTER COLUMN `catalog_roaming_enablement_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Roaming Enablement ID');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_roaming_enablement` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Roaming Enablement - Roaming Agreement Id');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_roaming_enablement` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Roaming Enablement - Catalog Item Id');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_roaming_enablement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_roaming_enablement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_roaming_enablement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_roaming_enablement` ALTER COLUMN `enablement_status` SET TAGS ('dbx_business_glossary_term' = 'Enablement Status');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_roaming_enablement` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_roaming_enablement` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_roaming_enablement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_roaming_enablement` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_roaming_enablement` ALTER COLUMN `service_type_filter` SET TAGS ('dbx_business_glossary_term' = 'Service Type Filter');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_roaming_enablement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `telecommunication_ecm`.`product`.`skill_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`product`.`skill_requirement` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `telecommunication_ecm`.`product`.`skill_requirement` SET TAGS ('dbx_association_edges' = 'product.catalog_item,workforce.skill');
ALTER TABLE `telecommunication_ecm`.`product`.`skill_requirement` ALTER COLUMN `skill_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Product Skill Requirement ID');
ALTER TABLE `telecommunication_ecm`.`product`.`skill_requirement` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item ID');
ALTER TABLE `telecommunication_ecm`.`product`.`skill_requirement` ALTER COLUMN `skill_id` SET TAGS ('dbx_business_glossary_term' = 'Skill ID');
ALTER TABLE `telecommunication_ecm`.`product`.`skill_requirement` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`skill_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`skill_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `telecommunication_ecm`.`product`.`skill_requirement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `telecommunication_ecm`.`product`.`skill_requirement` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Skill Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`skill_requirement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`skill_requirement` ALTER COLUMN `proficiency_level_required` SET TAGS ('dbx_business_glossary_term' = 'Required Proficiency Level');
ALTER TABLE `telecommunication_ecm`.`product`.`skill_requirement` ALTER COLUMN `skill_requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Skill Requirement Status');
ALTER TABLE `telecommunication_ecm`.`product`.`skill_requirement` ALTER COLUMN `training_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Required');
ALTER TABLE `telecommunication_ecm`.`product`.`skill_requirement` ALTER COLUMN `work_order_phase_applicability` SET TAGS ('dbx_business_glossary_term' = 'Work Order Phase Applicability');
ALTER TABLE `telecommunication_ecm`.`product`.`segment_eligibility` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`product`.`segment_eligibility` SET TAGS ('dbx_subdomain' = 'offering_management');
ALTER TABLE `telecommunication_ecm`.`product`.`segment_eligibility` SET TAGS ('dbx_association_edges' = 'product.catalog_item,analytics.segment_definition');
ALTER TABLE `telecommunication_ecm`.`product`.`segment_eligibility` ALTER COLUMN `segment_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Product Segment Eligibility ID');
ALTER TABLE `telecommunication_ecm`.`product`.`segment_eligibility` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Segment Eligibility - Catalog Item Id');
ALTER TABLE `telecommunication_ecm`.`product`.`segment_eligibility` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Product Segment Eligibility - Segment Definition Id');
ALTER TABLE `telecommunication_ecm`.`product`.`segment_eligibility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`segment_eligibility` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `telecommunication_ecm`.`product`.`segment_eligibility` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `telecommunication_ecm`.`product`.`segment_eligibility` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `telecommunication_ecm`.`product`.`segment_eligibility` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `telecommunication_ecm`.`product`.`segment_eligibility` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `telecommunication_ecm`.`product`.`segment_eligibility` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`product`.`segment_eligibility` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `telecommunication_ecm`.`product`.`segment_eligibility` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`segment_eligibility` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `telecommunication_ecm`.`product`.`rule_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`product`.`rule_group` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `telecommunication_ecm`.`product`.`rule_group` ALTER COLUMN `rule_group_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Group Identifier');
ALTER TABLE `telecommunication_ecm`.`product`.`rule_group` ALTER COLUMN `parent_rule_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`product`.`zero_rating_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`product`.`zero_rating_program` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `telecommunication_ecm`.`product`.`zero_rating_program` ALTER COLUMN `zero_rating_program_id` SET TAGS ('dbx_business_glossary_term' = 'Zero Rating Program Identifier');
ALTER TABLE `telecommunication_ecm`.`product`.`zero_rating_program` ALTER COLUMN `superseded_zero_rating_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
