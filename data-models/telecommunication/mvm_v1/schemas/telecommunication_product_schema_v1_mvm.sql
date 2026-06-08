-- Schema for Domain: product | Business: Telecommunication | Version: v1_mvm
-- Generated on: 2026-05-08 08:31:45

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`product` COMMENT 'SSOT for the commercial product and service catalog defining all offerings including mobile plans, broadband packages, IPTV/OTT bundles, VoIP offerings, enterprise SD-WAN/MPLS products, devices, and promotional offers. Manages product specifications, pricing models, bundles, eligibility, and product lifecycle via Netcracker Product Catalog.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`catalog_item` (
    `catalog_item_id` BIGINT COMMENT 'Unique identifier for the catalog item in the Netcracker Product Catalog. Primary key for all commercial offerings including mobile plans, broadband packages, IPTV/OTT bundles, VoIP offerings, enterprise SD-WAN/MPLS products, and devices.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Wholesale and MVNO operations require tracking which partner provides or co-brands catalog items (e.g., roaming packages from partner networks, content services from media partners). Supports partner ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Telecom products must comply with specific regulatory obligations (spectrum rules, service quality mandates, consumer protection). Regulatory filings reference which products are covered; compliance o',
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
    `catalog_item_id` BIGINT COMMENT 'Reference to the underlying technical product specification or catalog item that defines the service capabilities and provisioning requirements for this offering. Links commercial offering to technical catalog.',
    `device_model_id` BIGINT COMMENT 'Foreign key linking to product.device_model. Business justification: An offering with device_included_flag=true should reference the specific device model included in the offer (e.g., iPhone 15 Pro + Unlimited Plan offering references the iPhone 15 Pro device_model).',
    `iot_tariff_id` BIGINT COMMENT 'Foreign key linking to interconnect.iot_tariff. Business justification: Roaming-enabled offerings must reference the applicable IOT tariff to ensure correct inter-operator charging rates are applied. Product managers and billing teams use this link during offering design ',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Channel partners and MVNOs require exclusive or customized offerings. Tracks which partner an offering is designed for, supporting partner-specific product configuration, go-to-market strategy, and re',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Commercial offerings map to regulatory obligations for compliance reporting (universal service fund contributions calculated per offering type, accessibility requirements per service category). Real b',
    `revenue_share_plan_id` BIGINT COMMENT 'Foreign key linking to partner.revenue_share_plan. Business justification: Revenue share plans in telecom are tied to specific product offerings — the share percentage and calculation method depend on which offering is sold through a partner channel. This link enables automa',
    `roaming_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.roaming_agreement. Business justification: Offerings with roaming_included_flag=true are enabled by specific roaming agreements with partner operators. This link ensures offerings are only activated where valid roaming agreements exist and sup',
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
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Bundles distributed through partner channels (MVNO, reseller, dealer) are governed by specific partner agreements defining pricing, territory, and component substitution rights. This link supports par',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: MVNO and dealer channel operations create partner-branded bundles with specific revenue share arrangements. Tracks bundle ownership for partner billing, settlement runs, and channel-specific bundle av',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Telecom bundles (triple-play, converged offers) are subject to regulatory obligations around anti-bundling rules, consumer protection, and mandatory unbundling requirements. Compliance teams must trac',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to partner.sla_definition. Business justification: Bundle has a service_level_agreement text field that is a denormalized reference to a formal SLA definition. Linking bundle to partner.sla_definition enables SLA breach monitoring, penalty calculation',
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
    `sms_allowance` STRING COMMENT 'Total SMS text messages included in the bundle. Applicable to mobile bundles. Null for unlimited SMS bundles or bundles without SMS components. Used for usage tracking and overage billing.',
    `upgrade_eligible_flag` BOOLEAN COMMENT 'Indicates whether customers can upgrade from this bundle to higher-tier offerings without penalty (True) or if upgrade restrictions apply (False). Used in customer lifecycle management and upsell campaigns.',
    `version_number` STRING COMMENT 'Version identifier for this bundle specification following semantic versioning (major.minor). Incremented when bundle attributes, pricing, or components change. Used for product change management and historical analysis.. Valid values are `^[0-9]+.[0-9]+$`',
    `voice_minutes_allowance` STRING COMMENT 'Total voice call minutes included in the bundle. Applicable to mobile and VoIP bundles. Null for unlimited voice bundles or bundles without voice components. Used for usage tracking and overage billing.',
    CONSTRAINT pk_bundle PRIMARY KEY(`bundle_id`)
) COMMENT 'Defines composite product bundles that group multiple offerings or catalog items into a single commercial package (e.g., Triple Play: broadband + IPTV + VoIP, or Quad Play: mobile + broadband + IPTV + fixed voice). Captures bundle code, bundle type (fixed, flexible, customizable), minimum/maximum component count, discount applicability, bundle pricing model, and lifecycle dates. Manages the structural definition of bundled products separate from individual component pricing.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`price_plan` (
    `price_plan_id` BIGINT COMMENT 'Unique identifier for the price plan. Primary key for the price plan entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Wholesale and partner-channel price plans are negotiated and governed by specific partner agreements (MVNO wholesale rates, reseller pricing). This link supports wholesale pricing governance, partner ',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: A price plan can be defined for a bundle (in addition to catalog items and offerings). price_plan already has product_offering_id for offering-level pricing; adding bundle_id allows price plans to be ',
    `catalog_item_id` BIGINT COMMENT 'Reference to the product catalog that contains this price plan. Links the price plan to its catalog context for product management and offering organization.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Wholesale telecommunications requires partner-specific rate plans for MVNOs and interconnect partners. Tracks which partner a wholesale price plan applies to, supporting partner billing, settlement ca',
    `offering_id` BIGINT COMMENT 'Reference to the product offering that this price plan applies to. A product offering may have multiple price plans for different customer segments or contract terms.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Telecom price plans must comply with tariff transparency, consumer protection, and price regulation obligations. Regulators (e.g., FCC, Ofcom) require price plans to be traceable to specific regulator',
    `revenue_share_plan_id` BIGINT COMMENT 'Foreign key linking to partner.revenue_share_plan. Business justification: Price plans sold through partner channels generate revenue split per a revenue share plan. Linking price_plan to revenue_share_plan enables automated revenue share calculation during settlement runs a',
    `segment_id` BIGINT COMMENT 'Foreign key linking to enterprise.segment. Business justification: Price plans are designed for specific customer segments. price_plan.customer_segment is a denormalized text field; replacing with segment_id FK enables segment-based pricing enforcement, eligibility v',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`promo_offer` (
    `promo_offer_id` BIGINT COMMENT 'Unique identifier for the promotional offer. Primary key for the promo_offer product.',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Promotional offers frequently target composite bundles (e.g., Save 30% on the Family Broadband + Mobile Bundle). promo_offer.eligibility_product_category is a free-text string that currently capture',
    `catalog_item_id` BIGINT COMMENT 'Identifier of the specific product catalog item to which this promotional offer applies. Null if offer applies to multiple products or product categories.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: A promotional offer can be applied directly to a specific offering (e.g., 3 months free on the Unlimited Plus plan). promo_offer currently only has catalog_item_id; adding offering_id allows promos ',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Partner-funded promotions and dealer incentive campaigns are standard in telecommunications distribution. Tracks which partner sponsors or funds a promotion, supporting cost allocation, partner market',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: A promotional offer modifies or overrides a specific price plan (e.g., a 50% discount applied to the Standard MRC price plan for 6 months). Linking promo_offer to price_plan establishes which base pri',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Promotional offers in telecom are subject to advertising standards, mandatory disclosure rules, and consumer protection regulations. Regulators require promos to reference applicable obligations for c',
    `revenue_share_plan_id` BIGINT COMMENT 'Foreign key linking to partner.revenue_share_plan. Business justification: Promotional offers distributed through partner channels affect revenue share calculations — promo discounts must be factored into partner settlement. Linking promo_offer to revenue_share_plan enables ',
    `segment_id` BIGINT COMMENT 'Foreign key linking to enterprise.segment. Business justification: Promotional offers target specific enterprise segments. promo_offer.eligibility_customer_segment is a denormalized text field; replacing with segment_id FK enables segment-targeted promotion managemen',
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
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Technical specifications can be defined at the offering level in addition to the catalog item level. An offering may have offering-specific SLA tiers, QoS classes, or bandwidth specs that differ from ',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to partner.sla_definition. Business justification: Product specs define SLA parameters (sla_tier, sla_uptime_percent, mttr_hours). Linking to partner.sla_definition enables SLA compliance reporting and partner dispute resolution by tracing which contr',
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
    `addon_id` BIGINT COMMENT 'Foreign key linking to product.addon. Business justification: Eligibility rules also govern addon purchases (e.g., International Roaming addon only available to postpaid customers with 6+ months tenure). Adding addon_id to eligibility_rule completes the eligib',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Eligibility rules for partner-distributed products are often defined within or constrained by the governing partner agreement (e.g., credit class eligibility per MVNO agreement, geographic scope per r',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Eligibility rules govern which customer segments can purchase specific bundles (e.g., Triple Play bundle only available in fiber-enabled geographic zones). eligibility_rule currently references offe',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Eligibility rules can govern which customers can purchase a specific catalog item (e.g., IoT tariff only available to business segment customers). eligibility_rule currently has product_offering_id ',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Channel partners and MVNOs have specific eligibility rules (e.g., MVNO subscribers only, authorized dealer channels). Tracks partner-specific eligibility constraints for product offerings, supporting ',
    `offering_id` BIGINT COMMENT 'Reference to the product offering or promotional offer to which this eligibility rule applies. Links to the product catalog entry in Netcracker Product Catalog.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Eligibility rules in telecom are frequently mandated by regulation (universal service obligations, age verification for adult content, geographic availability mandates). Compliance teams must trace ea',
    `segment_id` BIGINT COMMENT 'Foreign key linking to enterprise.segment. Business justification: Eligibility rules are defined per enterprise segment (e.g., rules applying only to large enterprise or government segments). Linking segment_id enables segment-specific rule evaluation during product ',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`device_model` (
    `device_model_id` BIGINT COMMENT 'Unique identifier for the device model record. Primary key for the device model entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Device models are procured or distributed under specific partner agreements (OEM supply agreements, device financing agreements, exclusive distribution deals). This link supports device procurement go',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: A device model (handset, CPE, ONT, router) is sold as a catalog item in the Netcracker Product Catalog. Linking device_model to catalog_item establishes the devices commercial identity in the product',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Device models must comply with certification requirements (FCC Part 15, SAR limits, hearing aid compatibility per FCC rules). Product managers track regulatory approval status before market launch; co',
    `battery_capacity_mah` STRING COMMENT 'Battery capacity in milliampere-hours (mAh) for portable devices. Null for powered CPE (Customer Premises Equipment) and network infrastructure devices.',
    `color_variants` STRING COMMENT 'Comma-separated list of available color options for the device model (e.g., Black, White, Blue, Titanium). Used for inventory management and customer selection.',
    `compliance_certifications` STRING COMMENT 'Comma-separated list of regulatory compliance certifications (e.g., FCC, CE, RoHS, ENERGY STAR, PTCRB). Required for legal sale and operation in different jurisdictions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this device model record was first created in the product catalog system. Used for audit trails and data lineage tracking.',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`addon` (
    `addon_id` BIGINT COMMENT 'Unique identifier for the add-on product. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Add-ons distributed via partner channels (MVNO bolt-ons, reseller add-ons) are governed by partner agreements defining distribution rights and pricing. This link is required for settlement line attrib',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: An addon attaches to a base offering (e.g., a data top-up addon is available on the Unlimited Mobile offering). The prefix base_ distinguishes this FK from any future offering references and clarifi',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to interconnect.carrier_agreement. Business justification: Roaming day-pass and international calling add-ons are directly enabled by carrier agreements. Operations and product teams must know which carrier agreement governs each roaming addon for settlement,',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: An addon is itself a product catalog entry — data top-ups, international calling packs, and device insurance are all catalog items. Linking addon to catalog_item establishes the addons identity in th',
    `iot_tariff_id` BIGINT COMMENT 'Foreign key linking to interconnect.iot_tariff. Business justification: International roaming addons (travel passes, data boosters) priced using IOT tariff rates for specific destination zones. Essential for margin analysis, ensuring addon pricing covers wholesale settlem',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: An addons pricing should be governed by a price plan record rather than denormalized price_amount and pricing_model columns on the addon table. price_plan has base_price_amount, pricing_model_type, b',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Add-ons (roaming packs, premium SMS, international calling) are governed by specific regulatory obligations (EU roaming regulations, premium rate service rules, opt-in mandates). Compliance officers m',
    `spec_id` BIGINT COMMENT 'Reference to the primary base product offering that this add-on is compatible with. Null if the add-on is compatible with multiple base products (see compatibility rules).',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`product`.`bundle_component` (
    `bundle_component_id` BIGINT COMMENT 'Primary key for the bundle_component association',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to the parent bundle that contains this component offering.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to the offering included as a component in the bundle.',
    `component_discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to this specific offering when included in this bundle, distinct from the bundle-level discount. Enables per-component pricing adjustments in bundle pricing models.',
    `component_quantity` STRING COMMENT 'Number of units of this offering included in the bundle. Typically 1 for most components but may be greater for multi-line or multi-device bundles.',
    `effective_end_date` DATE COMMENT 'Date when this offering ceases to be a component of this bundle. Nullable for open-ended inclusions. Enables graceful removal of components from bundles without deleting historical composition records.',
    `effective_start_date` DATE COMMENT 'Date when this offering became an active component of this bundle. Supports versioned bundle composition and time-bounded component inclusion for product lifecycle management.',
    `is_mandatory_component` BOOLEAN COMMENT 'Indicates whether this offering is a required (mandatory) component of the bundle or an optional component that customers may substitute or remove. Directly governs flexible bundle composition rules.',
    `sequence_number` STRING COMMENT 'Display and processing order of this offering component within the bundle. Used for rendering bundle composition in customer-facing channels and BSS order management.',
    `substitution_allowed` BOOLEAN COMMENT 'Component-level override indicating whether this specific offering within the bundle may be substituted by the customer with an alternative offering. Overrides or refines the bundle-level component_substitution_allowed flag.',
    CONSTRAINT pk_bundle_component PRIMARY KEY(`bundle_component_id`)
) COMMENT 'This association product represents the Component role between bundle and offering in the telecommunications product catalog. It captures the explicit business act of including a specific offering as a component within a bundle, with terms governing that inclusion (mandatory vs. optional, quantity, component-level discount, display sequence, and effective dates). Each record links one bundle to one offering and carries attributes that exist only in the context of that specific bundle-offering composition. Product catalog managers create, modify, and retire these records as part of bundle lifecycle management in BSS/product catalog systems such as Netcracker.. Existence Justification: In telecommunications product catalog management, bundles are explicitly composed of multiple offerings (e.g., a Triple Play bundle contains broadband offering + IPTV offering + VoIP offering), and a single offering (e.g., Fiber 100Mbps) can be included in multiple different bundles simultaneously (e.g., both a Double Play and a Triple Play bundle). This is a first-class operational business concept — product catalog managers actively create, modify, and retire bundle component records as part of product lifecycle management. The relationship carries its own attributes (mandatory/optional flag, component quantity, component-level discount, sequence, effective dates) that belong neither to the bundle nor the offering alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ADD CONSTRAINT `fk_product_offering_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ADD CONSTRAINT `fk_product_offering_device_model_id` FOREIGN KEY (`device_model_id`) REFERENCES `telecommunication_ecm`.`product`.`device_model`(`device_model_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ADD CONSTRAINT `fk_product_price_plan_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ADD CONSTRAINT `fk_product_price_plan_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ADD CONSTRAINT `fk_product_price_plan_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ADD CONSTRAINT `fk_product_price_plan_superseded_by_price_plan_id` FOREIGN KEY (`superseded_by_price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ADD CONSTRAINT `fk_product_promo_offer_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ADD CONSTRAINT `fk_product_promo_offer_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ADD CONSTRAINT `fk_product_promo_offer_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ADD CONSTRAINT `fk_product_promo_offer_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ADD CONSTRAINT `fk_product_spec_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ADD CONSTRAINT `fk_product_spec_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ADD CONSTRAINT `fk_product_eligibility_rule_addon_id` FOREIGN KEY (`addon_id`) REFERENCES `telecommunication_ecm`.`product`.`addon`(`addon_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ADD CONSTRAINT `fk_product_eligibility_rule_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ADD CONSTRAINT `fk_product_eligibility_rule_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ADD CONSTRAINT `fk_product_eligibility_rule_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ADD CONSTRAINT `fk_product_device_model_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ADD CONSTRAINT `fk_product_addon_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ADD CONSTRAINT `fk_product_addon_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `telecommunication_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ADD CONSTRAINT `fk_product_addon_price_plan_id` FOREIGN KEY (`price_plan_id`) REFERENCES `telecommunication_ecm`.`product`.`price_plan`(`price_plan_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ADD CONSTRAINT `fk_product_addon_spec_id` FOREIGN KEY (`spec_id`) REFERENCES `telecommunication_ecm`.`product`.`spec`(`spec_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_component` ADD CONSTRAINT `fk_product_bundle_component_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `telecommunication_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_component` ADD CONSTRAINT `fk_product_bundle_component_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `telecommunication_ecm`.`product`.`offering`(`offering_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `telecommunication_ecm`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`catalog_item` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`product`.`offering` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Model Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `iot_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Iot Tariff Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `revenue_share_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`offering` ALTER COLUMN `roaming_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Agreement Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `sms_allowance` SET TAGS ('dbx_business_glossary_term' = 'Short Message Service (SMS) Allowance');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `upgrade_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle` ALTER COLUMN `voice_minutes_allowance` SET TAGS ('dbx_business_glossary_term' = 'Voice Minutes Allowance');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Catalog Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Product Offering Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `revenue_share_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`price_plan` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Offer Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Catalog Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `revenue_share_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`promo_offer` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`product`.`spec` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification ID');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`spec` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `eligibility_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Product Offering Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`eligibility_rule` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` SET TAGS ('dbx_subdomain' = 'equipment_inventory');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Model Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `battery_capacity_mah` SET TAGS ('dbx_business_glossary_term' = 'Battery Capacity (Milliampere-Hours)');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `color_variants` SET TAGS ('dbx_business_glossary_term' = 'Available Color Variants');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `telecommunication_ecm`.`product`.`device_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
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
ALTER TABLE `telecommunication_ecm`.`product`.`addon` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` SET TAGS ('dbx_subdomain' = 'equipment_inventory');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Add-On Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Base Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `iot_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Iot Tariff Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`product`.`addon` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Base Product Identifier (ID)');
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
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_component` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_component` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_component` SET TAGS ('dbx_association_edges' = 'product.bundle,product.offering');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_component` ALTER COLUMN `bundle_component_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Component - Bundle Component Id');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_component` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Component - Bundle Id');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_component` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Component - Offering Id');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_component` ALTER COLUMN `component_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Component Discount Percentage');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_component` ALTER COLUMN `component_quantity` SET TAGS ('dbx_business_glossary_term' = 'Component Quantity');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_component` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Component Effective End Date');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_component` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Component Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_component` ALTER COLUMN `is_mandatory_component` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Component Flag');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_component` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Component Sequence Number');
ALTER TABLE `telecommunication_ecm`.`product`.`bundle_component` ALTER COLUMN `substitution_allowed` SET TAGS ('dbx_business_glossary_term' = 'Component Substitution Allowed');
