-- Schema for Domain: ecommerce | Business: Apparel Fashion | Version: v1_ecm
-- Generated on: 2026-05-05 15:54:35

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `apparel_fashion_ecm`.`ecommerce` COMMENT 'Operates digital storefronts, online catalog management, site merchandising, cart and checkout flows, digital payments, and DTC channel performance. Owns web session data, conversion metrics, AOV, CAC measurement, personalization, and digital customer journey touchpoints powered by Salesforce Commerce Cloud.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` (
    `digital_storefront_id` BIGINT COMMENT 'Unique identifier for the digital storefront instance. Primary key.',
    `brand_id` BIGINT COMMENT 'Reference to the brand this storefront represents.',
    `carbon_target_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_target. Business justification: Links regional/brand-specific storefronts to their carbon reduction commitments for localized ESG disclosure (e.g., EU Green Claims Directive requires market-specific targets). Enables storefront-leve',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Storefronts incur operating costs (hosting, payment processing, customer service, marketing) that must be allocated to cost centers for expense tracking, budgeting, and variance analysis.',
    `employee_id` BIGINT COMMENT 'Reference to the user who last modified this storefront configuration.',
    `inventory_pool_id` BIGINT COMMENT 'Reference to the inventory pool from which this storefront fulfills orders.',
    `price_book_id` BIGINT COMMENT 'Reference to the price book used for pricing on this storefront.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Each digital storefront operates as a distinct profit center for P&L reporting, performance analysis, and management accountability. Standard practice in multi-brand/multi-region apparel e-commerce fi',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Digital storefronts operating in specific jurisdictions require regulatory filings for data privacy (GDPR, CCPA), consumer protection, and accessibility compliance. Compliance teams track jurisdiction',
    `accessibility_wcag_level` STRING COMMENT 'WCAG accessibility compliance level achieved by this storefront (A, AA, AAA, or not certified).. Valid values are `A|AA|AAA|not_certified`',
    `analytics_tracking_code` STRING COMMENT 'Google Analytics or Adobe Analytics tracking ID configured for this storefront.',
    `catalog_id` BIGINT COMMENT 'Reference to the primary product catalog assigned to this storefront.',
    `ccpa_compliant` BOOLEAN COMMENT 'Indicates whether the storefront is configured to comply with CCPA requirements for California customers.',
    `channel_type` STRING COMMENT 'Classification of the digital channel type. DTC = Direct-to-Consumer, PWA = Progressive Web App.. Valid values are `dtc_web|mobile_app|pwa|social_commerce|marketplace|outlet_web`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the storefronts primary market (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storefront record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for transactions on this storefront (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customer_service_email` STRING COMMENT 'Primary customer service email address for this storefront. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `customer_service_phone` STRING COMMENT 'Primary customer service phone number for this storefront. Organizational contact data classified as confidential.',
    `domain_url` STRING COMMENT 'Primary domain URL for the digital storefront (e.g., https://www.apparelfashion.com).. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}(/.*)?$`',
    `gdpr_compliant` BOOLEAN COMMENT 'Indicates whether the storefront is configured to comply with GDPR requirements for EU customers.',
    `guest_checkout_enabled` BOOLEAN COMMENT 'Indicates whether customers can complete purchases without creating an account.',
    `launch_date` DATE COMMENT 'Date when the digital storefront was first launched and made available to customers.',
    `locale_code` STRING COMMENT 'ISO locale code representing language and region (e.g., en_US, fr_FR, de_DE).. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `loyalty_program_enabled` BOOLEAN COMMENT 'Indicates whether a loyalty program is active and integrated with this storefront.',
    `mobile_app_enabled` BOOLEAN COMMENT 'Indicates whether a dedicated mobile application is available for this storefront.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this storefront record was last modified.',
    `operational_status` STRING COMMENT 'Current operational state of the digital storefront.. Valid values are `active|inactive|maintenance|preview|retired`',
    `payment_gateway` STRING COMMENT 'Name of the payment gateway provider integrated with this storefront (e.g., Stripe, PayPal, Adyen).',
    `personalization_enabled` BOOLEAN COMMENT 'Indicates whether AI-driven personalization features are enabled for this storefront.',
    `platform_version` STRING COMMENT 'Version of the e-commerce platform powering this storefront (e.g., Salesforce Commerce Cloud version).',
    `primary_language` STRING COMMENT 'ISO 639-1 two-letter language code for the storefronts primary language.. Valid values are `^[a-z]{2}$`',
    `pwa_enabled` BOOLEAN COMMENT 'Indicates whether Progressive Web App functionality is enabled for this storefront.',
    `region_code` STRING COMMENT 'Business region code for the storefront (e.g., NA for North America, EMEA for Europe/Middle East/Africa, APAC for Asia-Pacific).. Valid values are `^[A-Z]{2,4}$`',
    `retirement_date` DATE COMMENT 'Date when the storefront was or will be retired from active service. Null if still active.',
    `seo_description` STRING COMMENT 'Default SEO meta description for the storefront homepage used for search engine optimization.',
    `seo_title` STRING COMMENT 'Default SEO title tag for the storefront homepage used for search engine optimization.',
    `shipping_origin_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary shipping origin for orders from this storefront.. Valid values are `^[A-Z]{3}$`',
    `social_commerce_enabled` BOOLEAN COMMENT 'Indicates whether social commerce integrations (Instagram Shopping, Facebook Shops) are enabled.',
    `storefront_code` STRING COMMENT 'Business identifier code for the digital storefront, used for external references and integrations.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `storefront_name` STRING COMMENT 'Human-readable name of the digital storefront (e.g., Apparel Fashion US, Outlet Store EU).',
    `storefront_type` STRING COMMENT 'Business classification of the storefront purpose (flagship brand site, regional site, outlet microsite, seasonal campaign site).. Valid values are `flagship|regional|outlet|seasonal|campaign`',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction code applicable to transactions on this storefront for sales tax calculation.',
    `timezone` STRING COMMENT 'IANA timezone identifier for the storefronts operational timezone (e.g., America/New_York, Europe/London).',
    CONSTRAINT pk_digital_storefront PRIMARY KEY(`digital_storefront_id`)
) COMMENT 'Master record for each digital storefront or site instance operated by Apparel Fashion, including DTC brand sites, regional storefronts, outlet microsites, and channel classification (DTC web, mobile app, PWA, social commerce). Captures site identity, locale, currency, brand affiliation, domain URL, launch date, platform version, operational status, and channel type. Serves as the top-level anchor for all site-level configuration, catalog assignments, channel performance attribution, CAC measurement, and AOV benchmarking.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` (
    `web_session_id` BIGINT COMMENT 'Unique identifier for the web session on the digital storefront. Primary key.',
    `digital_storefront_id` BIGINT COMMENT 'Foreign key linking to ecommerce.digital_storefront. Business justification: Web sessions occur on a specific digital storefront. The session captures storefront-specific behavior (landing page, exit page, channel). This is a standard N:1 relationship - many sessions belong to',
    `profile_id` BIGINT COMMENT 'Identifier of the customer associated with this session. Null for anonymous sessions.',
    `add_to_cart_count` STRING COMMENT 'Number of times the user added items to the shopping cart during the session.',
    `bounce_flag` BOOLEAN COMMENT 'Indicates whether the session was a bounce (single page view with no interaction). True if bounce, False otherwise.',
    `browser` STRING COMMENT 'Web browser used during the session (e.g., Chrome, Safari, Firefox, Edge).',
    `browser_version` STRING COMMENT 'Version number of the web browser used during the session.',
    `channel` STRING COMMENT 'Marketing channel through which the user arrived at the digital storefront. [ENUM-REF-CANDIDATE: organic|paid_search|social|email|direct|referral|display|affiliate — 8 candidates stripped; promote to reference product]',
    `checkout_initiated_flag` BOOLEAN COMMENT 'Indicates whether the user initiated the checkout process during the session. True if initiated, False otherwise.',
    `conversion_flag` BOOLEAN COMMENT 'Indicates whether the session resulted in a conversion event (e.g., purchase, signup). True if converted, False otherwise.',
    `cookie_consent_status` STRING COMMENT 'Status of the users cookie consent during the session for GDPR and CCPA compliance.. Valid values are `accepted|declined|partial|not_requested`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this session record was first created in the data platform.',
    `device_type` STRING COMMENT 'Type of device used to access the digital storefront during this session.. Valid values are `desktop|mobile|tablet|smart_tv|wearable|other`',
    `exit_page_url` STRING COMMENT 'The last page URL visited by the user before ending the session.',
    `geographic_city` STRING COMMENT 'City name derived from the session IP address geolocation.',
    `geographic_country_code` STRING COMMENT 'Three-letter ISO country code derived from the session IP address (e.g., USA, GBR, FRA).. Valid values are `^[A-Z]{3}$`',
    `geographic_region` STRING COMMENT 'Geographic region or state derived from the session IP address.',
    `ip_address` STRING COMMENT 'Internet Protocol address of the device used during the session. May be anonymized for privacy compliance.',
    `landing_page_url` STRING COMMENT 'The first page URL visited by the user when entering the digital storefront in this session.',
    `language_preference` STRING COMMENT 'Two-letter ISO language code representing the users browser language preference (e.g., en, es, fr).. Valid values are `^[a-z]{2}$`',
    `operating_system` STRING COMMENT 'Operating system of the device used during the session (e.g., iOS, Android, Windows, macOS).',
    `operating_system_version` STRING COMMENT 'Version number of the operating system used during the session.',
    `page_views` STRING COMMENT 'Total number of pages viewed during the session.',
    `product_page_views` STRING COMMENT 'Number of product detail pages viewed during the session.',
    `referral_source` STRING COMMENT 'The referring URL or source that directed the user to the digital storefront.',
    `search_query_count` STRING COMMENT 'Number of search queries performed by the user during the session.',
    `session_duration_seconds` STRING COMMENT 'Total duration of the session in seconds, calculated from start to end timestamp.',
    `session_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the web session ended or timed out. Null for active sessions.',
    `session_source_platform` STRING COMMENT 'The commerce platform or application that captured this session data (e.g., Salesforce Commerce Cloud).',
    `session_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the web session was initiated on the digital storefront.',
    `session_status` STRING COMMENT 'Current lifecycle status of the web session.. Valid values are `active|completed|abandoned|timeout`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this session record was last updated in the data platform.',
    `utm_campaign` STRING COMMENT 'UTM parameter identifying the specific marketing campaign name.',
    `utm_content` STRING COMMENT 'UTM parameter used to differentiate similar content or links within the same campaign.',
    `utm_medium` STRING COMMENT 'UTM parameter identifying the marketing medium (e.g., cpc, email, social, organic).',
    `utm_source` STRING COMMENT 'UTM parameter identifying the source of the traffic (e.g., google, facebook, newsletter).',
    `utm_term` STRING COMMENT 'UTM parameter identifying paid search keywords or terms.',
    CONSTRAINT pk_web_session PRIMARY KEY(`web_session_id`)
) COMMENT 'Captures individual shopper web sessions on the digital storefront, including session start/end timestamps, device type, browser, OS, referral source, UTM parameters, landing page, exit page, page views, bounce flag, session duration, and key behavioral events (search queries, product page views, filter usage, size/color selection patterns). Sourced from the commerce platform tag layer. Foundational for conversion funnel analysis, CAC measurement, personalization triggering, digital customer journey mapping, and cookie consent state tracking during the browsing session.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` (
    `site_catalog_id` BIGINT COMMENT 'Unique identifier for the site catalog. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Catalogs are often campaign-specific (holiday gift guide, seasonal launch catalog). Enables campaign performance reporting by catalog and supports merchandising-marketing alignment on featured assortm',
    `circular_program_id` BIGINT COMMENT 'Foreign key linking to sustainability.circular_program. Business justification: Links seasonal/regional catalogs to applicable take-back, resale, or rental programs for EPR compliance and customer communication. Real business need: EU textile EPR regulations require catalogs to r',
    `digital_storefront_id` BIGINT COMMENT 'Reference to the digital storefront where this catalog is published.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Catalogs are curated by merchandising employees who manage assortment, pricing, and publication workflows. Links enable workload tracking, approval routing, and performance measurement for catalog man',
    `parent_catalog_site_catalog_id` BIGINT COMMENT 'Reference to a parent catalog if this catalog is a subset or variant. Nullable for top-level catalogs. Enables catalog inheritance and hierarchical merchandising.',
    `price_book_id` BIGINT COMMENT 'Reference to the price book that governs pricing for products in this catalog. Links to merchandising domain for price management.',
    `season_id` BIGINT COMMENT 'Reference to the merchandising season this catalog represents (e.g., Spring 2024, Fall/Winter 2023). Links to the merchandising domain for seasonal planning context.',
    `active_from_date` DATE COMMENT 'The date when this catalog becomes visible and shoppable on the storefront. Part of the catalogs effective date range.',
    `active_sku_count` STRING COMMENT 'The number of SKUs currently active and available for purchase within this catalog. Subset of total SKU count, excluding out-of-stock or discontinued items.',
    `active_to_date` DATE COMMENT 'The date when this catalog is no longer visible on the storefront. Nullable for catalogs with no planned end date (evergreen catalogs).',
    `approval_status` STRING COMMENT 'The approval workflow status for this catalog. Catalogs must be approved before they can be published to the storefront.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this catalog was approved for publication. Nullable if not yet approved.',
    `catalog_code` STRING COMMENT 'Unique business identifier code for the catalog used in system integrations and reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `catalog_description` STRING COMMENT 'Detailed business description of the catalogs purpose, target audience, and merchandising strategy. Used for internal planning and external marketing copy.',
    `catalog_name` STRING COMMENT 'Business name of the catalog (e.g., Spring 2024 Collection, Outlet Clearance, Holiday Gift Guide).',
    `catalog_priority` STRING COMMENT 'Numeric priority ranking used when multiple catalogs are active on the same storefront. Higher values take precedence for product display and search ranking.',
    `catalog_type` STRING COMMENT 'Classification of the catalog by merchandising strategy: seasonal (time-bound collection), evergreen (year-round core), outlet (clearance), promotional (campaign-driven), exclusive (member-only), or limited edition (special release).. Valid values are `seasonal|evergreen|outlet|promotional|exclusive|limited_edition`',
    `country_codes` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where this catalog is available (e.g., USA,CAN,MEX). Empty for global catalogs.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this catalog record was first created in the system. Immutable audit field.',
    `currency_code` STRING COMMENT 'The primary currency for pricing in this catalog (e.g., USD, EUR, GBP). All product prices are displayed in this currency unless overridden by customer locale.. Valid values are `^[A-Z]{3}$`',
    `default_locale` STRING COMMENT 'The primary language and region locale for this catalog (e.g., en_US, fr_FR, de_DE). Determines default product names, descriptions, and pricing display.. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `external_catalog_reference` STRING COMMENT 'The catalog identifier from an external system (e.g., Oracle Retail, legacy PLM). Used for system integration and data lineage tracking.',
    `geographic_scope` STRING COMMENT 'The geographic reach of this catalog: global (available worldwide), regional (multi-country region), or country-specific (single market).. Valid values are `global|regional|country_specific`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this catalog record was last updated. Tracks content changes, SKU additions/removals, and metadata updates.',
    `merchandising_theme` STRING COMMENT 'The creative or marketing theme for this catalog (e.g., Summer Essentials, Back to School, Holiday Gift Guide, Sustainability Collection). Used for site merchandising and campaign alignment.',
    `notes` STRING COMMENT 'Free-text field for internal notes, special instructions, or merchandising commentary about this catalog. Not displayed to customers.',
    `promotion_eligible_flag` BOOLEAN COMMENT 'Indicates whether products in this catalog are eligible for promotional discounts and offers. False for outlet or already-discounted catalogs.',
    `publication_status` STRING COMMENT 'Current lifecycle status of the catalog: draft (being prepared), scheduled (approved for future publication), published (live and shoppable), suspended (temporarily hidden), or archived (no longer active).. Valid values are `draft|scheduled|published|suspended|archived`',
    `published_timestamp` TIMESTAMP COMMENT 'The date and time when this catalog was first published to the storefront. Nullable for catalogs that have never been published.',
    `search_indexing_enabled_flag` BOOLEAN COMMENT 'Indicates whether products in this catalog are included in site search results. May be disabled for exclusive or hidden catalogs.',
    `seo_enabled_flag` BOOLEAN COMMENT 'Indicates whether products in this catalog are indexed by external search engines (Google, Bing). Disabled for member-only or pre-launch catalogs.',
    `target_customer_segment` STRING COMMENT 'The primary customer segment this catalog is merchandised for (e.g., VIP Members, New Customers, Youth, Professional Athletes). Used for personalization and targeted marketing.',
    `total_sku_count` STRING COMMENT 'The total number of unique SKUs included in this catalog. Used for catalog size tracking and assortment breadth analysis.',
    `version_number` STRING COMMENT 'The version number of this catalog. Incremented each time the catalog is republished with changes. Supports catalog versioning and rollback.',
    CONSTRAINT pk_site_catalog PRIMARY KEY(`site_catalog_id`)
) COMMENT 'Defines the online product catalog published to each digital storefront, including catalog name, associated storefront, active date range, catalog type (seasonal, evergreen, outlet), publication status, and total SKU count. Manages which product assortment is visible and shoppable on each site at any given time. Links to the product domain for SKU-level detail while owning the digital publication lifecycle.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` (
    `ecommerce_catalog_product_listing_id` BIGINT COMMENT 'Unique identifier for the catalog product listing record. Primary key for this entity representing a specific SKU or style published on a digital storefront.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Individual product listings are featured in campaigns (new arrival hero products, seasonal hero SKUs). Supports product-level campaign performance analysis and merchandising effectiveness measurement.',
    `category_id` BIGINT COMMENT 'Reference to the primary digital catalog category where this product is classified. Determines default browse placement.',
    `concept_id` BIGINT COMMENT 'Foreign key linking to design.concept. Business justification: E-commerce catalogs are merchandised by design concept for thematic storytelling and campaign cohesion. Merchandisers group products by concept to create concept-driven landing pages and seasonal narr',
    `ecolabel_id` BIGINT COMMENT 'Foreign key linking to sustainability.ecolabel. Business justification: Associates product listings with eco-certifications (GOTS, Fair Trade, OEKO-TEX) for PDP badge display, faceted search filtering, and marketing claims compliance. Real business need: consumer-facing s',
    `employee_id` BIGINT COMMENT 'Reference to the user or merchandiser who published or last updated this product listing. Supports accountability and workflow tracking.',
    `ftc_label_id` BIGINT COMMENT 'Foreign key linking to compliance.ftc_label. Business justification: Online product detail pages must display FTC-compliant labeling information (fiber content, care, country of origin). Digital merchandising teams link catalog listings to approved FTC labels to ensure',
    `merchandise_hierarchy_id` BIGINT COMMENT 'Foreign key linking to merchandising.merchandise_hierarchy. Business justification: Catalog listings need merchandise hierarchy for site navigation tree construction, category page generation, faceted search filtering, and merchandising performance reporting. This is how digital stor',
    `product_safety_test_id` BIGINT COMMENT 'Foreign key linking to compliance.product_safety_test. Business justification: Digital merchandising requires safety test clearance before publishing SKUs to online catalogs. Merchandising teams verify test completion and pass/fail status during catalog setup to ensure only comp',
    `site_catalog_id` BIGINT COMMENT 'Reference to the digital storefront or e-commerce site where this product is listed. Supports multi-site catalog management.',
    `size_scale_id` BIGINT COMMENT 'Reference to the size chart or fit guide associated with this product listing. Helps customers select appropriate size.',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: Digital merchandisers trace listed products to originating design sketches for creative attribution, design performance ROI analysis, and designer productivity measurement. Essential for design-to-com',
    `sku_id` BIGINT COMMENT 'Reference to the product master SKU being listed on the digital catalog. Links this listing to the core product entity.',
    `standard_id` BIGINT COMMENT 'Foreign key linking to quality.quality_standard. Business justification: Product listings must display applicable quality/sustainability certifications (OEKO-TEX, GOTS, Fair Trade) for regulatory compliance and customer transparency. Quality standards drive product badging',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Digital merchandising requires vendor attribution for catalog products to manage vendor-funded digital promotions, co-op advertising budgets, and measure vendor performance by online sales channel. Dr',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Pre-order catalog listings must reference specific production work orders to calculate accurate expected ship dates, manage inventory promises, and coordinate go-live timing with production completion',
    `average_rating` DECIMAL(18,2) COMMENT 'Calculated average customer rating score for this product listing, typically on a 1-5 scale. Displayed to influence purchase decisions.',
    `badge_color` STRING COMMENT 'Hexadecimal color code or predefined color name for the product badge. Controls visual presentation of promotional badges.',
    `badge_text` STRING COMMENT 'Optional promotional or informational badge text displayed on the product tile or detail page (e.g., Sale, Limited Edition, Sustainable).',
    `browsable_flag` BOOLEAN COMMENT 'Boolean indicator whether this product listing should appear in category browse pages and navigation menus.',
    `canonical_url` STRING COMMENT 'The canonical URL path for this product listing. Used for SEO to prevent duplicate content issues and establish the authoritative product page.',
    `digital_price_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the digital price override. Required when digital price override is populated.. Valid values are `^[A-Z]{3}$`',
    `digital_price_override` DECIMAL(18,2) COMMENT 'Optional price override specific to the digital channel. When populated, this price supersedes the standard retail price for online transactions.',
    `display_sequence` STRING COMMENT 'Numeric ordering value controlling the position of this product in catalog browse and search results. Lower values appear first.',
    `expected_ship_date` DATE COMMENT 'Expected date when pre-order or back-ordered items will ship to customers. Manages customer expectations for delayed fulfillment.',
    `expiry_date` DATE COMMENT 'The date when this product listing expires and is automatically removed from the digital storefront. Supports time-limited offerings.',
    `go_live_date` DATE COMMENT 'The date when this product listing becomes active and visible to customers on the digital storefront. Supports scheduled product launches.',
    `inventory_display_mode` STRING COMMENT 'Controls how inventory availability is displayed to customers on the product listing (exact quantity, low stock warning, simple in-stock indicator, or hidden).. Valid values are `show_quantity|low_stock_warning|in_stock_only|hide`',
    `is_bestseller` BOOLEAN COMMENT 'Boolean indicator whether this product qualifies as a bestseller based on sales velocity and should be merchandised accordingly.',
    `is_featured` BOOLEAN COMMENT 'Boolean indicator whether this product is featured or promoted on the digital storefront. Featured products receive priority placement.',
    `is_new_arrival` BOOLEAN COMMENT 'Boolean indicator whether this product should be displayed with new arrival badge or in new arrivals collection.',
    `is_online_exclusive` BOOLEAN COMMENT 'Boolean indicator whether this product is available exclusively through the digital channel and not in physical retail stores.',
    `listing_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this catalog product listing record was first created in the system. Audit trail for listing lifecycle.',
    `listing_status` STRING COMMENT 'Current publication status of the product listing on the digital storefront. Determines visibility and availability to customers.. Valid values are `active|suppressed|out_of_stock|discontinued|pending|draft`',
    `listing_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this catalog product listing record was last modified. Tracks merchandising changes and content updates.',
    `locale_code` STRING COMMENT 'Language and region locale code for this product listing (e.g., en_US, fr_FR). Supports multi-language and multi-region catalog management.. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `low_stock_threshold` STRING COMMENT 'Inventory quantity threshold below which the low stock warning is displayed to customers. Drives urgency messaging.',
    `personalization_segment` STRING COMMENT 'Customer segment or persona code used for personalized product recommendations and targeted merchandising on the digital storefront.',
    `pre_order_flag` BOOLEAN COMMENT 'Boolean indicator whether this product is available for pre-order before official release date. Supports launch campaigns.',
    `recommendation_priority` STRING COMMENT 'Numeric priority score used by recommendation engines to rank this product in personalized product suggestions and cross-sell opportunities.',
    `review_count` STRING COMMENT 'Total number of customer reviews submitted for this product listing. Provides social proof and credibility.',
    `searchable_flag` BOOLEAN COMMENT 'Boolean indicator whether this product listing should be included in site search results and search engine indexing.',
    `seo_keywords` STRING COMMENT 'Comma-separated list of keywords and phrases for search engine optimization and internal site search relevance.',
    `seo_meta_description` STRING COMMENT 'Meta description tag content for search engine results pages. Summarizes product listing in 150-160 characters to drive click-through.',
    `seo_title` STRING COMMENT 'Optimized page title for search engine indexing and display in search results. Typically 50-60 characters for optimal display.',
    `shipping_restriction_flag` BOOLEAN COMMENT 'Boolean indicator whether this product has shipping restrictions (e.g., hazardous materials, oversized, international restrictions).',
    `suppression_reason` STRING COMMENT 'Code or description explaining why this product listing is suppressed from the digital storefront (e.g., quality issue, compliance, inventory).',
    `tax_category_code` STRING COMMENT 'Tax classification code for this product listing. Determines applicable sales tax rates and rules for digital transactions.',
    `three_sixty_view_url` STRING COMMENT 'URL to the interactive 360-degree product view asset. Provides immersive product visualization experience.',
    `url_slug` STRING COMMENT 'Human-readable URL-friendly identifier derived from product name. Used in constructing the product detail page URL path.',
    `video_url` STRING COMMENT 'URL to the primary product video showcasing the item. Enhances product presentation and conversion rates.',
    CONSTRAINT pk_ecommerce_catalog_product_listing PRIMARY KEY(`ecommerce_catalog_product_listing_id`)
) COMMENT 'Represents the published listing of a specific SKU or style on a digital storefront catalog, including listing status (active, suppressed, out-of-stock), display sequence, featured flag, online exclusive flag, digital price override, SEO title, SEO meta description, canonical URL, and go-live/expiry dates. Distinct from the product master — this entity owns the digital merchandising and publication attributes for each SKU on each site.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` (
    `cart_id` BIGINT COMMENT 'Unique identifier for the shopping cart instance. Primary key.',
    `address_id` BIGINT COMMENT 'Reference to the customer address selected for billing. May be null if address not yet selected.',
    `digital_storefront_id` BIGINT COMMENT 'Reference to the digital storefront where this cart was created. Enables multi-brand and multi-locale cart tracking.',
    `distribution_center_id` BIGINT COMMENT 'Foreign key linking to logistics.distribution_center. Business justification: Carts check real-time inventory availability against specific DC pools to calculate ATP and display accurate stock status. Critical for preventing overselling and enabling DC-specific inventory reserv',
    `merged_from_cart_id` BIGINT COMMENT 'Reference to another cart that was merged into this cart. Occurs when a guest shopper logs in and their guest cart is merged with their authenticated cart.',
    `packaging_sustainability_id` BIGINT COMMENT 'Foreign key linking to sustainability.packaging_sustainability. Business justification: Associates cart sessions with packaging sustainability profiles for checkout-time carbon footprint display and packaging preference capture (e.g., plastic-free option). Real business need: checkout fl',
    `payment_method_id` BIGINT COMMENT 'Reference to the customer payment method selected for this cart. May be null if payment method not yet selected.',
    `profile_id` BIGINT COMMENT 'Reference to the customer who owns this cart. Links to authenticated or guest customer profile.',
    `promotion_id` BIGINT COMMENT 'Reference to the primary promotion applied to the cart. Links to the merchandising promotion master.',
    `sales_order_id` BIGINT COMMENT 'Reference to the sales order created when this cart was successfully converted. Null if cart has not been converted.',
    `shipping_address_id` BIGINT COMMENT 'Reference to the customer address selected for shipping. May be null if address not yet selected.',
    `web_session_id` BIGINT COMMENT 'Unique session identifier from the e-commerce platform tracking the shoppers browsing session. Used for abandoned cart recovery and session analytics.',
    `ab_test_variant` STRING COMMENT 'Identifier for the A/B test variant or experience shown to this shopper. Used for conversion rate optimization and multivariate testing analysis.',
    `abandoned_timestamp` TIMESTAMP COMMENT 'Timestamp when the cart was classified as abandoned based on inactivity threshold. Triggers abandoned cart recovery campaigns.',
    `cart_status` STRING COMMENT 'Current lifecycle status of the shopping cart. Active = shopper is actively browsing; Abandoned = shopper left without checkout; Converted = cart was successfully checked out; Merged = cart was merged with another; Expired = cart aged out per retention policy; Saved = shopper explicitly saved for later.. Valid values are `active|abandoned|merged|converted|expired|saved`',
    `cart_type` STRING COMMENT 'Classification of cart purpose. Standard = regular shopping cart; Wishlist = saved items for future purchase; Registry = gift registry or wedding registry; Subscription = recurring order cart.. Valid values are `standard|wishlist|registry|subscription`',
    `channel_source` STRING COMMENT 'Marketing channel or traffic source that brought the customer to the cart. Used for Customer Acquisition Cost (CAC) and channel attribution analysis.. Valid values are `web|mobile_app|social|email|affiliate|marketplace`',
    `converted_timestamp` TIMESTAMP COMMENT 'Timestamp when the cart was successfully converted to a sales order. Marks the completion of the purchase journey.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cart was first created. Marks the beginning of the shopping session.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this cart. Determined by the digital storefront locale.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `device_type` STRING COMMENT 'Type of device used to create and interact with the cart. Used for device-specific analytics and responsive design optimization.. Valid values are `desktop|mobile|tablet|app`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the cart from all promotions, coupon codes, and markdowns. Reduces the subtotal.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Timestamp when the cart will expire and be purged from the system per data retention policy. Typically 30-90 days from last modification.',
    `gift_message` STRING COMMENT 'Optional gift message text entered by the customer for gift orders. Printed on packing slip or gift card.',
    `gift_wrap_flag` BOOLEAN COMMENT 'Indicates whether the customer has requested gift wrapping for items in this cart. May incur additional charges.',
    `guest_checkout_flag` BOOLEAN COMMENT 'Indicates whether this cart belongs to a guest (non-authenticated) shopper. Guest carts have limited personalization and no saved payment methods.',
    `ip_address` STRING COMMENT 'IP address of the device used to create the cart. Used for fraud detection and geographic analytics. May be considered PII under GDPR.',
    `item_count` STRING COMMENT 'Total number of distinct line items (SKUs) in the cart. Does not account for quantity per line.',
    `locale_code` STRING COMMENT 'Locale code (language and region) for the cart, determining language, currency, and regional preferences. Format: language_REGION (e.g., en_US, fr_FR, de_DE).',
    `loyalty_points_applied` STRING COMMENT 'Number of loyalty program points the customer has elected to redeem against this cart. Converted to discount amount based on points-to-currency ratio.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the cart (item added, removed, quantity changed, or promotion applied). Used to calculate cart abandonment time windows.',
    `personalization_segment` STRING COMMENT 'Customer segment code used for personalized pricing, product recommendations, and targeted promotions. Driven by Adobe Experience Platform or similar CDP.',
    `shipping_amount` DECIMAL(18,2) COMMENT 'Estimated shipping cost for the cart. Final shipping cost is determined at checkout based on selected shipping method and destination.',
    `shipping_method_code` STRING COMMENT 'Code representing the selected or estimated shipping method (e.g., standard, express, overnight). Used to calculate shipping cost and delivery estimate.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of all line item subtotals before discounts, taxes, and shipping. Represents the gross merchandise value in the cart.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Estimated sales tax or VAT amount for the cart. Final tax is calculated at checkout based on shipping address.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total cart value including subtotal, discounts, estimated tax, and estimated shipping. Represents the expected order total if the cart is converted.',
    `unit_count` STRING COMMENT 'Total quantity of all units across all line items in the cart. Sum of all line item quantities.',
    `user_agent` STRING COMMENT 'Browser user agent string capturing browser type, version, and operating system. Used for compatibility testing and device analytics.',
    `utm_campaign` STRING COMMENT 'UTM campaign tracking parameter from the referring URL. Used for digital marketing campaign attribution and ROI measurement.',
    `utm_medium` STRING COMMENT 'UTM medium tracking parameter identifying the marketing medium (e.g., cpc, email, social). Used for channel attribution.',
    `utm_source` STRING COMMENT 'UTM source tracking parameter identifying the traffic source (e.g., google, facebook, newsletter). Used for channel attribution.',
    CONSTRAINT pk_cart PRIMARY KEY(`cart_id`)
) COMMENT 'Captures the complete shopping cart state for each shopper on the digital storefront, including cart header (creation timestamp, last modified, status, currency, applied promotions, estimated shipping/tax) and line-item detail (SKU, style, colorway, size, quantity, unit price, line subtotal, discount, gift flag, add-to-cart timestamp). Tracks pre-checkout purchase intent at both aggregate and SKU level. Critical for abandoned cart recovery, AOV optimization, and product affinity modeling.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` (
    `checkout_session_id` BIGINT COMMENT 'Unique identifier for the checkout session. Primary key for this entity.',
    `cart_id` BIGINT COMMENT 'Foreign key linking to ecommerce.cart. Business justification: Checkout session processes a specific shopping cart. This FK links the checkout flow back to the cart being checked out. Business value: trace checkout abandonment back to cart state, analyze cart-to-',
    `digital_storefront_id` BIGINT COMMENT 'Reference to the digital storefront where the checkout session occurred.',
    `profile_id` BIGINT COMMENT 'Reference to the customer profile initiating the checkout. Null for guest checkout sessions.',
    `sales_order_id` BIGINT COMMENT 'Reference to the sales order created upon successful checkout completion. Null if checkout was abandoned or errored.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Checkout sessions capture customer-selected carrier for shipping method choice, rate calculation, and delivery promise. Essential for order fulfillment instructions and carrier performance tracking by',
    `abandonment_step` STRING COMMENT 'The specific checkout step where the customer abandoned the session. None if checkout was completed.. Valid values are `cart_review|address_entry|shipping_selection|payment_entry|order_review|none`',
    `browser_type` STRING COMMENT 'Web browser type and version used during the checkout session (e.g., Chrome, Safari, Firefox).',
    `checkout_abandonment_timestamp` TIMESTAMP COMMENT 'Timestamp when the checkout session was abandoned by the customer or timed out. Null if not abandoned.',
    `checkout_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the checkout was successfully completed and order was placed. Null if not completed.',
    `checkout_duration_seconds` STRING COMMENT 'Total duration of the checkout session in seconds from start to completion or abandonment.',
    `checkout_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer initiated the checkout process from the shopping cart.',
    `checkout_status` STRING COMMENT 'Current lifecycle status of the checkout session indicating the final outcome or current state.. Valid values are `completed|abandoned|errored|in_progress`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the checkout session record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `device_type` STRING COMMENT 'Type of device used by the customer to complete the checkout session.. Valid values are `desktop|mobile|tablet|app`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the order from promotional codes, loyalty points, or other offers.',
    `error_code` STRING COMMENT 'System error code if the checkout session encountered a technical error. Null if no error occurred.',
    `error_message` STRING COMMENT 'Detailed error message describing the technical failure that prevented checkout completion. Null if no error occurred.',
    `estimated_delivery_date` DATE COMMENT 'Estimated delivery date presented to the customer at checkout based on selected shipping method.',
    `gift_message_included` BOOLEAN COMMENT 'Indicates whether the customer included a gift message with the order during checkout.',
    `guest_checkout_flag` BOOLEAN COMMENT 'Indicates whether the checkout was completed as a guest without customer account login.',
    `ip_address` STRING COMMENT 'IP address of the customer device during the checkout session for fraud detection and analytics.',
    `locale_code` STRING COMMENT 'Locale code representing the language and regional settings used during checkout (e.g., en_US, fr_FR).',
    `loyalty_points_redeemed` STRING COMMENT 'Number of loyalty program points redeemed by the customer during checkout. Zero if no points used.',
    `marketing_consent_captured` BOOLEAN COMMENT 'Indicates whether the customer provided opt-in consent for marketing communications during checkout.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the checkout session record was last modified or updated.',
    `payment_failure_reason` STRING COMMENT 'Reason code or description for payment authorization failure if payment was declined. Null if payment succeeded or was not attempted.',
    `payment_gateway` STRING COMMENT 'Payment gateway provider used to process the transaction (e.g., Stripe, Adyen, PayPal, Authorize.Net).',
    `payment_method_type` STRING COMMENT 'Type of payment method used or selected during checkout. [ENUM-REF-CANDIDATE: credit_card|debit_card|paypal|apple_pay|google_pay|gift_card|store_credit|buy_now_pay_later — 8 candidates stripped; promote to reference product]',
    `promo_code_applied` STRING COMMENT 'Promotional code entered and applied by the customer during checkout. Null if no promo code used.',
    `session_token` STRING COMMENT 'Unique session token generated by Salesforce Commerce Cloud to track the checkout session across steps.',
    `shipping_amount` DECIMAL(18,2) COMMENT 'Shipping charge amount for the selected shipping method.',
    `shipping_method_selected` STRING COMMENT 'The shipping method chosen by the customer during checkout.. Valid values are `standard|express|next_day|click_and_collect|same_day`',
    `steps_completed` STRING COMMENT 'Comma-separated list of checkout steps completed by the customer (e.g., address_entry, shipping_selection, payment_entry, order_review).',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Subtotal amount of all items in the cart before shipping, tax, and discounts.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount calculated for the order based on shipping address and tax jurisdiction.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final total amount of the order including subtotal, shipping, tax, and discounts.',
    `transactional_consent_captured` BOOLEAN COMMENT 'Indicates whether the customer provided consent for transactional communications (order updates, shipping notifications) during checkout.',
    CONSTRAINT pk_checkout_session PRIMARY KEY(`checkout_session_id`)
) COMMENT 'Tracks the checkout flow from cart confirmation through order placement, capturing checkout start timestamp, steps completed (address entry, shipping method selection, payment entry, order review), step abandonment point, selected shipping method (standard, express, next-day, click-and-collect, same-day) with carrier reference and delivery estimate, payment method type, promo code applied, checkout duration, marketing and transactional consent opt-ins captured at checkout, and outcome (completed, abandoned, errored). Enables checkout funnel optimization, shipping preference analysis, and payment failure root-cause investigation.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` (
    `digital_order_id` BIGINT COMMENT 'Unique identifier for the digital order placed through the DTC e-commerce channel. Primary key for this entity.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Digital orders generate AR invoices for revenue recognition, receivables tracking, and financial reporting. Essential for order-to-cash process and revenue reconciliation in apparel e-commerce operati',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Orders track assigned carrier for shipment execution, customer tracking notifications, delivery performance monitoring, and carrier cost reconciliation. Fundamental to order fulfillment operations and',
    `address_id` BIGINT COMMENT 'Reference to the customer address used for billing and payment verification. May differ from shipping address.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Orders attributed to campaigns for ROAS calculation, CAC measurement, and campaign effectiveness reporting. Core marketing-ecommerce integration for performance measurement and budget allocation decis',
    `digital_storefront_id` BIGINT COMMENT 'Reference to the specific digital storefront where this order was placed. Identifies the brand, locale, and channel configuration.',
    `finance_payment_id` BIGINT COMMENT 'Foreign key linking to finance.finance_payment. Business justification: Links customer payments to orders for cash application, AR clearing, and payment reconciliation. Critical for order-to-cash cycle completion and accounts receivable management in e-commerce.',
    `distribution_center_id` BIGINT COMMENT 'Foreign key linking to logistics.distribution_center. Business justification: Orders route to specific DCs based on inventory location, shipping proximity, and capacity. Critical for order orchestration, pick/pack instructions, and delivery promise accuracy in multi-DC apparel ',
    `profile_id` BIGINT COMMENT 'Reference to the customer who placed this order. Links to the customer master record in the customer domain.',
    `sales_order_id` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — MUST-HAVE: Enables reconciliation of DTC e-commerce orders with the unified order management system. Without this, revenue reporting and fulfillment tracking across channels is fragmented.',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Digital orders require season attribution for seasonal sales performance analysis, collection sell-through reporting, and merchandise planning feedback. Critical for understanding which seasons merch',
    `shipping_address_id` BIGINT COMMENT 'Reference to the customer address where the order will be shipped. Links to customer address master data.',
    `web_session_id` BIGINT COMMENT 'Unique identifier for the customer web session during which the order was placed. Enables journey analysis and attribution.',
    `channel_type` STRING COMMENT 'Digital channel interface through which the order was placed. Distinguishes between web browser, native mobile app, progressive web app, social commerce, or third-party marketplace.. Valid values are `web|mobile_app|pwa|social_commerce|marketplace`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this order record was first created in the e-commerce platform database.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this order. Supports multi-currency e-commerce operations.. Valid values are `^[A-Z]{3}$`',
    `customer_email` STRING COMMENT 'Email address provided by the customer for order confirmation and shipping notifications. Required for guest checkout orders.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `customer_notes` STRING COMMENT 'Special delivery instructions or comments provided by the customer at checkout. Communicated to fulfillment and carrier.',
    `customer_phone` STRING COMMENT 'Phone number provided by the customer for delivery coordination and order updates. May be used by carrier for delivery notifications.',
    `device_type` STRING COMMENT 'Type of device used by the customer to place the order. Supports device-specific conversion analysis.. Valid values are `desktop|mobile|tablet|other`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the order including promotional codes, loyalty rewards, and markdowns. Reduces the subtotal.',
    `estimated_delivery_date` DATE COMMENT 'Estimated date when the order is expected to be delivered to the customer. Calculated based on fulfillment method and carrier SLA.',
    `fraud_review_status` STRING COMMENT 'Status of manual or automated fraud review for this order. Orders flagged for fraud may be held pending investigation.. Valid values are `not_reviewed|approved|declined|pending_review`',
    `fraud_score` DECIMAL(18,2) COMMENT 'Calculated fraud risk score from payment gateway or fraud detection service. Higher scores indicate higher risk. Scale typically 0-100.',
    `fulfillment_method` STRING COMMENT 'Method by which the order will be delivered to the customer. Supports omnichannel fulfillment options.. Valid values are `ship_to_home|store_pickup|curbside_pickup|locker_pickup|same_day_delivery`',
    `fulfillment_status` STRING COMMENT 'Current status of order fulfillment operations. Tracks warehouse and logistics progression independent of payment status. [ENUM-REF-CANDIDATE: pending|allocated|picked|packed|shipped|delivered|cancelled — 7 candidates stripped; promote to reference product]',
    `gift_message` STRING COMMENT 'Optional personalized message provided by the customer for gift orders. Printed on packing slip or gift card.',
    `grand_total_amount` DECIMAL(18,2) COMMENT 'Final total amount charged to the customer. Calculated as subtotal minus discounts plus shipping plus tax.',
    `ip_address` STRING COMMENT 'Internet Protocol address of the device used to place the order. Used for fraud detection and geographic analysis.',
    `is_gift` BOOLEAN COMMENT 'Indicates whether this order was marked as a gift by the customer. Triggers gift wrapping and receipt exclusion.',
    `is_guest_checkout` BOOLEAN COMMENT 'Indicates whether the order was placed by a guest user without creating an account. Impacts customer acquisition tracking.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points earned by the customer for this purchase. Supports CLTV and retention programs.',
    `loyalty_points_redeemed` STRING COMMENT 'Number of loyalty program points redeemed by the customer as payment or discount on this order.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this order record was last updated. Tracks any changes to order status, payment, or fulfillment details.',
    `order_notes` STRING COMMENT 'Internal notes or special instructions added by customer service representatives or automated systems regarding order handling.',
    `order_number` STRING COMMENT 'Customer-facing order confirmation number displayed in order confirmation emails and customer account portal. Externally-known business identifier for this transaction.. Valid values are `^[A-Z0-9]{8,20}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the digital order in the fulfillment workflow. Tracks progression from placement through delivery or cancellation. [ENUM-REF-CANDIDATE: pending|confirmed|processing|shipped|delivered|cancelled|refunded — 7 candidates stripped; promote to reference product]',
    `payment_method_type` STRING COMMENT 'Type of payment instrument used by the customer. Distinguishes between card payments, digital wallets, and buy-now-pay-later options. [ENUM-REF-CANDIDATE: credit_card|debit_card|paypal|apple_pay|google_pay|afterpay|klarna|gift_card — 8 candidates stripped; promote to reference product]',
    `payment_status` STRING COMMENT 'Current status of payment processing for this order. Tracks authorization, capture, and refund lifecycle.. Valid values are `pending|authorized|captured|failed|refunded|partially_refunded`',
    `placed_timestamp` TIMESTAMP COMMENT 'Exact date and time when the customer completed checkout and placed the order. Principal business event timestamp for this transaction.',
    `promotion_code` STRING COMMENT 'Promotional or coupon code applied by the customer at checkout. Used for discount attribution and campaign tracking.',
    `referrer_url` STRING COMMENT 'URL of the page or external site that referred the customer to the storefront. Supports marketing attribution and channel analysis.',
    `shipping_amount` DECIMAL(18,2) COMMENT 'Shipping and handling charges applied to the order. May be zero for free shipping promotions.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of all line item prices before discounts, shipping, and taxes. Base merchandise value of the order.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total sales tax, VAT, or other applicable taxes calculated for this order based on shipping destination and tax jurisdiction.',
    `user_agent` STRING COMMENT 'Browser and operating system information from the device used to place the order. Supports technical analytics and compatibility tracking.',
    `utm_campaign` STRING COMMENT 'Marketing campaign name parameter from the URL. Identifies the specific campaign driving this order for ROI measurement.',
    `utm_medium` STRING COMMENT 'Marketing campaign medium parameter from the URL. Identifies the marketing channel type (e.g., cpc, email, social, organic).',
    `utm_source` STRING COMMENT 'Marketing campaign source parameter from the URL. Identifies the platform or publisher driving traffic (e.g., google, facebook, email).',
    CONSTRAINT pk_digital_order PRIMARY KEY(`digital_order_id`)
) COMMENT 'Master record for orders placed through the DTC e-commerce channel. Captures order number, placement timestamp, storefront, channel (web, mobile app, PWA), order status, subtotal, discount total, shipping cost, tax amount, grand total, currency, AOV contribution, payment status, fulfillment status, and customer-facing order confirmation details. This entity is the SSOT for DTC digital order capture within the ecommerce domain — it owns the moment of purchase and initial order state. The order domain owns the downstream enterprise-wide order lifecycle (allocation, fulfillment routing, shipment tracking, delivery confirmation) once the order enters the OMS.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` (
    `digital_order_line_id` BIGINT COMMENT 'Unique identifier for the digital order line item. Primary key for this entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Line-level campaign attribution enables product performance analysis by campaign (which SKUs drive campaign revenue). Supports merchandising-marketing collaboration on assortment planning and campaign',
    `cogs_entry_id` BIGINT COMMENT 'Foreign key linking to finance.cogs_entry. Business justification: Each line item sold requires COGS recognition for gross margin calculation, P&L reporting, and inventory valuation. Core requirement for financial close and profitability analysis by product/channel.',
    `collection_id` BIGINT COMMENT 'Reference to the collection or season this product belongs to. Used for collection performance and STR tracking.',
    `digital_order_id` BIGINT COMMENT 'Reference to the parent digital order header. Links this line item to its containing order.',
    `ftc_label_id` BIGINT COMMENT 'Foreign key linking to compliance.ftc_label. Business justification: Federal law requires accurate fiber content, care instructions, and origin labeling on apparel sold online. E-commerce systems link order lines to FTC labels to display compliant information on produc',
    `distribution_center_id` BIGINT COMMENT 'Foreign key linking to logistics.distribution_center. Business justification: Order lines may fulfill from different DCs in split shipment scenarios when inventory is distributed across facilities. Essential for line-level fulfillment routing, multi-box shipment coordination, a',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to quality.inspection. Business justification: Order lines require inspection linkage for quality-gated fulfillment decisions (hold shipment if inspection failed), customer service escalations when post-shipment defects are reported, and supplier ',
    `merchandise_hierarchy_id` BIGINT COMMENT 'Foreign key linking to merchandising.merchandise_hierarchy. Business justification: Digital order lines require merchandise hierarchy classification for revenue reporting by department/class/subclass, financial consolidation, margin analysis by category, and performance dashboards. S',
    `product_safety_test_id` BIGINT COMMENT 'Foreign key linking to compliance.product_safety_test. Business justification: E-commerce order fulfillment requires verification that sold SKUs passed mandatory safety testing. Order management systems check test status before shipment to prevent non-compliant product sales, su',
    `promotion_id` BIGINT COMMENT 'Reference to the promotion applied to this line item. Null if no promotion was applied.',
    `quality_certification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_certification. Business justification: Order lines for certified products (organic, fair trade) require certification references for customs documentation, customer claim verification, and regulatory audit trails. Supports certificate numb',
    `retail_store_id` BIGINT COMMENT 'Reference to the retail store assigned to fulfill this line for store pickup or ship-from-store. Null for warehouse fulfillment.',
    `shipment_id` BIGINT COMMENT 'Reference to the shipment containing this line item. Null if not yet shipped. Multiple lines may share one shipment.',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU ordered. Represents the unique product variant including style, color, and size.',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: Regulatory compliance (CA Transparency Act, EU due diligence) requires factory-level traceability for products sold online. Critical for product recalls, quality issue root cause analysis, and supply ',
    `sustainable_material_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainable_material. Business justification: Enables ESG reporting to attribute revenue/volume to sustainable material usage, powers customer transparency labels on receipts/emails, and supports sustainability impact dashboards. Apparel brands m',
    `traceability_record_id` BIGINT COMMENT 'Foreign key linking to sustainability.traceability_record. Business justification: Connects sold items to supply chain traceability data for post-sale transparency (QR codes on receipts, blockchain verification apps). Real business need: premium brands provide customers with blockch',
    `trade_compliance_record_id` BIGINT COMMENT 'Foreign key linking to compliance.trade_compliance_record. Business justification: International e-commerce orders require HS codes, duty rates, and country-of-origin data for customs documentation and landed cost calculation. Order management systems link order lines to trade compl',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Apparel e-commerce tracks manufacturing vendor per order line for quality traceability, warranty claims, vendor performance analytics, and chargeback processing. Essential for supply chain accountabil',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the warehouse or distribution center assigned to fulfill this line. Null if not yet allocated.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Made-to-order and pre-order fulfillment requires direct linkage between customer order lines and manufacturing work orders for production scheduling, delivery promise calculation, and order-to-product',
    `actual_ship_date` DATE COMMENT 'Actual date this line item was shipped. Null if not yet shipped. Used for OTIF measurement.',
    `backorder_flag` BOOLEAN COMMENT 'Indicates whether this line item is on backorder due to insufficient inventory at order time. True if backordered.',
    `brand_code` BIGINT COMMENT 'Reference to the brand of the product on this line. Supports multi-brand DTC operations and brand performance analysis.',
    `cogs_amount` DECIMAL(18,2) COMMENT 'Total cost of goods sold for this line item. Quantity ordered multiplied by unit cost. Confidential financial data.',
    `colorway` STRING COMMENT 'The color variant of the style ordered. Industry-standard term for color option in apparel.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this line item record was created in the system. Represents when the line was added to the order.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this line. Supports multi-currency DTC operations.. Valid values are `^[A-Z]{3}$`',
    `expected_ship_date` DATE COMMENT 'Expected date this line item will ship from the fulfillment location. Used for customer communication and SLA tracking.',
    `fulfillment_method` STRING COMMENT 'Method by which this line item will be fulfilled. Supports omnichannel fulfillment options.. Valid values are `ship_to_home|store_pickup|curbside_pickup|locker_pickup|same_day_delivery`',
    `fulfillment_status` STRING COMMENT 'Current fulfillment status of this line item. Tracks the line through warehouse and delivery lifecycle. [ENUM-REF-CANDIDATE: pending|allocated|picked|packed|shipped|delivered|cancelled|returned — 8 candidates stripped; promote to reference product]',
    `gift_message` STRING COMMENT 'Customer-provided gift message text for this line item. Confidential customer communication.',
    `gift_wrap_charge` DECIMAL(18,2) COMMENT 'Additional charge for gift wrapping service on this line. Zero if gift wrap was not selected or was complimentary.',
    `gift_wrap_flag` BOOLEAN COMMENT 'Indicates whether gift wrapping was requested for this line item. True if gift wrap service was selected.',
    `line_discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to this line item. Sum of all promotional and markdown discounts for the line.',
    `line_number` STRING COMMENT 'Sequential line number within the digital order. Determines the display and processing order of line items.',
    `line_subtotal` DECIMAL(18,2) COMMENT 'Subtotal for this line before tax. Calculated as (unit_selling_price * quantity_ordered) - line_discount_amount.',
    `line_tax_amount` DECIMAL(18,2) COMMENT 'Tax amount applied to this line item. Calculated based on tax jurisdiction and product tax category.',
    `line_total` DECIMAL(18,2) COMMENT 'Total amount for this line including tax. Calculated as line_subtotal + line_tax_amount. Contributes to order total.',
    `markdown_code` STRING COMMENT 'Code identifying the markdown reason or campaign applied to this line. Used for markdown tracking and analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this line item record was last modified. Tracks updates to quantity, price, or fulfillment status.',
    `personalization_charge` DECIMAL(18,2) COMMENT 'Additional charge for personalization service on this line. Zero if personalization was not selected or was complimentary.',
    `personalization_text` STRING COMMENT 'Custom text for product personalization (e.g., monogram, embroidery). Confidential customer specification.',
    `product_category` STRING COMMENT 'Merchandise category of the product on this line. Denormalized for reporting and STR analysis by category.',
    `quantity_ordered` STRING COMMENT 'The number of units of this SKU ordered on this line. Used for inventory allocation and revenue calculation.',
    `return_eligible_flag` BOOLEAN COMMENT 'Indicates whether this line item is eligible for return per business policy. False for final sale or non-returnable items.',
    `return_window_days` STRING COMMENT 'Number of days from delivery within which this line can be returned. Null if not return eligible.',
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue for this line item is recognized per accounting policy. Typically ship date or delivery date.',
    `size` STRING COMMENT 'The size of the item ordered (e.g., XS, S, M, L, XL, or numeric sizing). Captured as ordered by customer.',
    `style_code` STRING COMMENT 'The style identifier for the product ordered. Represents the base design before color and size variation.',
    `tax_category_code` STRING COMMENT 'Product tax category code determining applicable tax rates. Used for tax calculation and compliance reporting.',
    `unit_msrp` DECIMAL(18,2) COMMENT 'The manufacturers suggested retail price per unit at the time of order. Used for markdown analysis and pricing strategy.',
    `unit_selling_price` DECIMAL(18,2) COMMENT 'The actual selling price per unit charged to the customer. May differ from MSRP due to promotions or markdowns.',
    CONSTRAINT pk_digital_order_line PRIMARY KEY(`digital_order_line_id`)
) COMMENT 'Line-item detail for each SKU within a digital order, including SKU, style, colorway, size, quantity ordered, unit MSRP, unit selling price, line discount, line total, gift wrap flag, personalization text, and fulfillment status per line. Supports STR analysis, markdown tracking, and per-SKU revenue attribution for the DTC channel.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` (
    `digital_payment_id` BIGINT COMMENT 'Unique identifier for the digital payment transaction. Primary key for the digital payment entity.',
    `sales_order_id` BIGINT COMMENT 'Reference to the digital sales order associated with this payment transaction.',
    `authorization_code` STRING COMMENT 'Authorization code returned by the payment gateway or issuing bank confirming approval of the transaction.',
    `authorization_timestamp` TIMESTAMP COMMENT 'Date and time when the payment was authorized by the payment gateway or issuing bank.',
    `avs_result_code` STRING COMMENT 'Address Verification System result code returned by the payment processor indicating the match status of billing address components.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address associated with the payment method, used for address verification and fraud screening.',
    `billing_city` STRING COMMENT 'City component of the billing address associated with the payment method.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the billing address country.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code of the billing address used for address verification and fraud detection.',
    `billing_state_province` STRING COMMENT 'State or province component of the billing address associated with the payment method.',
    `capture_timestamp` TIMESTAMP COMMENT 'Date and time when the authorized payment was captured and funds were committed for settlement.',
    `card_brand` STRING COMMENT 'The payment card network or brand for card-based transactions, such as Visa, Mastercard, or American Express. [ENUM-REF-CANDIDATE: visa|mastercard|amex|discover|jcb|diners|unionpay|maestro|not_applicable — 9 candidates stripped; promote to reference product]',
    `card_expiry_month` STRING COMMENT 'Expiration month of the payment card used in the transaction, stored for validation and retry logic.',
    `card_expiry_year` STRING COMMENT 'Expiration year of the payment card used in the transaction, stored for validation and retry logic.',
    `card_last_four_digits` STRING COMMENT 'Last four digits of the payment card number used for customer reference and reconciliation purposes without exposing full card details.. Valid values are `^[0-9]{4}$`',
    `cardholder_name` STRING COMMENT 'Name of the cardholder as it appears on the payment card, used for verification and reconciliation purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the payment was processed.. Valid values are `^[A-Z]{3}$`',
    `customer_ip_address` STRING COMMENT 'Internet Protocol address of the customer device at the time of payment submission, used for fraud detection and geographic analysis.',
    `cvv_result_code` STRING COMMENT 'Card Verification Value result code indicating whether the CVV provided matched the card issuer records.',
    `decline_reason_code` STRING COMMENT 'Code provided by the payment gateway or issuing bank indicating the reason for payment decline or failure.',
    `decline_reason_description` STRING COMMENT 'Human-readable description of the reason why the payment was declined or failed, used for customer communication and root-cause analysis.',
    `device_fingerprint` STRING COMMENT 'Unique identifier or hash representing the customers device characteristics, used for fraud detection and device recognition.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Numerical risk score assigned by the fraud detection system indicating the likelihood of fraudulent activity, typically ranging from 0 to 100.',
    `fraud_screening_result` STRING COMMENT 'Outcome of the fraud detection screening process indicating whether the transaction passed, failed, or requires manual review.. Valid values are `passed|failed|review|not_screened`',
    `gateway_transaction_reference` STRING COMMENT 'Unique transaction identifier assigned by the payment gateway for tracking and reconciliation with external systems.',
    `installment_count` STRING COMMENT 'Total number of installments for Buy Now Pay Later or installment payment plans, if applicable.',
    `installment_plan_enabled` BOOLEAN COMMENT 'Indicates whether this payment is part of an installment or Buy Now Pay Later plan.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this payment record was last modified or updated.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The total monetary amount processed in this payment transaction, representing the gross payment value before any adjustments.',
    `payment_channel` STRING COMMENT 'The digital interface or channel through which the payment was initiated, such as web storefront, mobile app, or call center.. Valid values are `web|mobile_app|mobile_web|tablet|kiosk|call_center`',
    `payment_gateway` STRING COMMENT 'The payment gateway or processor that handled the transaction, such as Stripe, Adyen, PayPal, or Authorize.Net.',
    `payment_method_type` STRING COMMENT 'The type of payment instrument used for the transaction, such as credit card, PayPal, Buy Now Pay Later (BNPL), gift card, store credit, or digital wallet. [ENUM-REF-CANDIDATE: credit_card|debit_card|paypal|apple_pay|google_pay|bnpl|gift_card|store_credit|bank_transfer — 9 candidates stripped; promote to reference product]',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction indicating its processing state and outcome. [ENUM-REF-CANDIDATE: pending|authorized|captured|settled|failed|declined|cancelled|refunded|partially_refunded|voided — 10 candidates stripped; promote to reference product]',
    `payment_token` STRING COMMENT 'Tokenized representation of the payment method provided by the payment gateway for secure storage and future transactions without exposing sensitive card data.',
    `processing_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the payment gateway or processor for handling this transaction, used for cost analysis and reconciliation.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Total amount refunded to the customer for this payment transaction, applicable when payment status is refunded or partially refunded.',
    `refund_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was processed and initiated back to the customers payment method.',
    `settlement_timestamp` TIMESTAMP COMMENT 'Date and time when the payment was settled and funds were transferred to the merchant account.',
    `three_ds_authentication_status` STRING COMMENT 'Status of 3D Secure authentication indicating whether the cardholder was successfully authenticated through the issuers authentication process.. Valid values are `authenticated|not_authenticated|attempted|not_enrolled|error|not_applicable`',
    `transaction_number` STRING COMMENT 'Externally visible unique transaction identifier provided by the payment gateway or internal system for tracking and reconciliation purposes.. Valid values are `^[A-Z0-9]{10,20}$`',
    CONSTRAINT pk_digital_payment PRIMARY KEY(`digital_payment_id`)
) COMMENT 'Records payment transactions associated with digital orders, including payment method type (credit card, PayPal, BNPL, gift card, store credit, Apple Pay), payment gateway, authorization code, transaction ID, payment amount, currency, payment status (authorized, captured, failed, refunded, partially refunded), capture timestamp, and fraud screening result flag. Supports DTC revenue reconciliation and payment failure root-cause analysis.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` (
    `digital_return_id` BIGINT COMMENT 'Unique identifier for the digital return request. Primary key for the digital return entity.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Returns generate credit memos or adjustments to original AR invoices for revenue reversal and receivables adjustment. Required for accurate revenue recognition and financial statement accuracy.',
    `defect_id` BIGINT COMMENT 'Foreign key linking to quality.quality_defect. Business justification: Returns must link to standardized defect codes for root cause analysis, supplier scorecarding, and defect trend reporting. Maps customer return reasons to quality defect taxonomy, enabling cost-of-qua',
    `employee_id` BIGINT COMMENT 'Reference to the customer service agent who processed or assisted with the return request, if applicable.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Product returns citing safety defects, labeling violations, or quality failures may trigger compliance incidents requiring investigation and regulatory notification. Returns management systems link re',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to quality.inspection. Business justification: Returns trigger re-inspection to validate customer defect claims, determine restocking vs. disposal disposition, and identify quality escapes. Inspection results drive refund approval, supplier debit ',
    `non_conformance_id` BIGINT COMMENT 'Foreign key linking to quality.non_conformance. Business justification: Customer returns often generate formal NCRs when return reason codes indicate quality failures (defective, not as described). Links return claims to supplier corrective action plans, quality scorecard',
    `sales_order_id` BIGINT COMMENT 'Reference to the original sales order from which this return originated.',
    `profile_id` BIGINT COMMENT 'Reference to the customer initiating the return request.',
    `sales_order_line_id` BIGINT COMMENT 'Reference to the specific order line item being returned.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Returns processing requires vendor identification for RTV (return-to-vendor) eligibility decisions, vendor chargeback calculations, quality defect escalation, and vendor scorecard impact. Critical for',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the warehouse or return center where the returned item was received.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Quality feedback loop requires linking returns to originating production work orders to identify factory-specific defects, trigger corrective actions, and analyze quality trends by production batch. C',
    `approval_date` DATE COMMENT 'Date when the return request was approved by the system or customer service team.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this return record was first created in the system.',
    `disposition_code` STRING COMMENT 'Final disposition decision for the returned merchandise (resell, liquidate, donate, destroy, return to vendor, repair).. Valid values are `resell|liquidate|donate|destroy|rtv|repair`',
    `inspection_date` DATE COMMENT 'Date when the returned item was inspected for quality and condition assessment.',
    `inspection_outcome` STRING COMMENT 'Result of the quality inspection determining whether the return meets acceptance criteria.. Valid values are `approved|rejected|partial_approval|pending`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this return record was last updated.',
    `product_condition` STRING COMMENT 'Condition of the returned product as declared by the customer or assessed upon receipt.. Valid values are `new_unused|opened_unused|used_good|used_fair|damaged|defective`',
    `received_date` DATE COMMENT 'Date when the returned merchandise was physically received at the warehouse or return center.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Total monetary amount to be refunded to the customer for this return, including product value and applicable taxes.',
    `refund_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the refund amount.. Valid values are `^[A-Z]{3}$`',
    `refund_date` DATE COMMENT 'Date when the refund was processed and issued to the customer.',
    `refund_method` STRING COMMENT 'Method by which the refund will be issued to the customer.. Valid values are `original_payment|store_credit|gift_card|bank_transfer|check`',
    `restocking_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to the customer for processing the return, if applicable per return policy.',
    `restocking_flag` BOOLEAN COMMENT 'Indicates whether a restocking fee was applied to this return.',
    `return_channel` STRING COMMENT 'Digital channel through which the return request was initiated (web storefront, mobile app, customer service portal).. Valid values are `web|mobile_app|customer_service|chatbot|email`',
    `return_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the item met the eligibility criteria for return based on policy rules.',
    `return_label_generated_flag` BOOLEAN COMMENT 'Indicates whether a prepaid return shipping label was generated for the customer.',
    `return_method` STRING COMMENT 'Method by which the customer will return the merchandise (mail-in, drop-off location, in-store, courier pickup).. Valid values are `mail_in|drop_off|in_store|courier_pickup|locker`',
    `return_policy_version` STRING COMMENT 'Version identifier of the return policy that was in effect at the time of the return request.',
    `return_quantity` STRING COMMENT 'Number of units being returned for this line item.',
    `return_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for the return as selected by the customer. [ENUM-REF-CANDIDATE: defective|wrong_item|wrong_size|not_as_described|changed_mind|damaged_in_transit|quality_issue|fit_issue|color_mismatch|late_delivery|duplicate_order|other — 12 candidates stripped; promote to reference product]',
    `return_reason_description` STRING COMMENT 'Free-text explanation provided by the customer detailing the reason for the return.',
    `return_request_date` DATE COMMENT 'Date when the customer initiated the return request through the digital channel.',
    `return_request_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the return request was submitted via the e-commerce platform.',
    `return_shipping_carrier` STRING COMMENT 'Shipping carrier used for returning the merchandise (e.g., UPS, FedEx, USPS, DHL).',
    `return_shipping_cost` DECIMAL(18,2) COMMENT 'Cost of return shipping, either paid by customer or absorbed by the business depending on return policy.',
    `return_status` STRING COMMENT 'Current lifecycle status of the return request in the DTC after-sales workflow. [ENUM-REF-CANDIDATE: requested|approved|rejected|shipped|received|inspected|refunded|completed|cancelled — 9 candidates stripped; promote to reference product]',
    `return_tracking_number` STRING COMMENT 'Tracking number provided by the carrier for monitoring the return shipment.',
    `return_window_days` STRING COMMENT 'Number of days allowed for return from the original purchase date, as defined by the applicable return policy.',
    `rma_number` STRING COMMENT 'Externally-visible return authorization number provided to the customer for tracking and reference.. Valid values are `^RMA-[0-9]{8,12}$`',
    `rtv_eligible_flag` BOOLEAN COMMENT 'Indicates whether the returned item is eligible to be returned to the vendor for credit or replacement.',
    `rtv_processed_flag` BOOLEAN COMMENT 'Indicates whether the item has been processed as a return to vendor.',
    `sku` STRING COMMENT 'Product SKU identifier for the item being returned.. Valid values are `^[A-Z0-9]{8,15}$`',
    `upc` STRING COMMENT 'UPC barcode of the returned product for inventory reconciliation.. Valid values are `^[0-9]{12}$`',
    CONSTRAINT pk_digital_return PRIMARY KEY(`digital_return_id`)
) COMMENT 'Captures return and refund requests initiated through the DTC e-commerce channel, including return request date, return reason code, return method (mail-in, drop-off, in-store), return status (requested, approved, received, refunded, rejected), refund amount, refund method, restocking flag, and RTV eligibility. Distinct from in-store returns — this entity owns the digital after-sales service workflow for DTC.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` (
    `site_promotion_id` BIGINT COMMENT 'Unique identifier for the site promotion record. Primary key for the site_promotion data product.',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: Promotional discounts and campaigns must be tracked against marketing budgets for spend control, ROI analysis, and budget variance reporting. Essential for promotional effectiveness and financial plan',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Promotions are campaign tactics (seasonal sale, launch discount). Links promotional discount strategy to campaign budget and enables promotion effectiveness measurement within campaign context.',
    `digital_storefront_id` BIGINT COMMENT 'Reference to the digital storefront where this promotion is configured and active.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Promotions require employee ownership for approval workflows, budget accountability, and performance measurement. Merchandising managers need to track which employees created/manage promotions for ROI',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Promotions may offer free or discounted shipping with specific carriers (e.g., "Free 2-day FedEx shipping"). Required for promotion eligibility validation, checkout display logic, and carrier cost all',
    `applicable_category_list` STRING COMMENT 'Comma-separated list of product category codes eligible for this promotion. Null if promotion applies to specific SKUs or all products.',
    `applicable_sku_list` STRING COMMENT 'Comma-separated list of SKU codes eligible for this promotion. Null if promotion applies to all products or is category-based.',
    `auto_apply_flag` BOOLEAN COMMENT 'Indicates whether the promotion is automatically applied to eligible carts without requiring a promo code entry. True if auto-applied, False if code entry required.',
    `channel_restriction` STRING COMMENT 'Digital channel where this promotion is valid. Restricts redemption to specific customer touchpoints.. Valid values are `web|mobile_app|all_digital`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this promotion record was first created in the system.',
    `customer_segment_code` STRING COMMENT 'Code identifying the customer segment eligible for this promotion (e.g., VIP, loyalty tier, new customer). Null if promotion is available to all customers.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Fixed monetary discount applied when promotion type is fixed_amount. Currency is inherited from the storefront configuration.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied when promotion type is percentage_off. Null for non-percentage promotions.',
    `display_message` STRING COMMENT 'Customer-facing promotional message displayed on the storefront, cart, or checkout pages to communicate the offer.',
    `end_date` DATE COMMENT 'Date when the promotion expires and is no longer available for redemption. Null for open-ended promotions.',
    `exclusion_sku_list` STRING COMMENT 'Comma-separated list of SKU codes explicitly excluded from this promotion even if they match category or general eligibility rules.',
    `maximum_discount_amount` DECIMAL(18,2) COMMENT 'Cap on the total discount value that can be applied in a single transaction, typically used with percentage-based promotions. Null if no cap applies.',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'Minimum cart subtotal required for the promotion to be eligible for redemption. Null if no minimum threshold applies.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this promotion record was last updated.',
    `order_count` STRING COMMENT 'Total number of distinct orders that included this promotion.',
    `priority_rank` STRING COMMENT 'Numeric ranking used to determine promotion application order when multiple promotions are eligible. Lower numbers indicate higher priority.',
    `promotion_code` STRING COMMENT 'Unique alphanumeric code that customers enter at checkout to redeem the promotion. Also known as promo code or coupon code.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `promotion_name` STRING COMMENT 'Business-friendly name of the promotion for internal reference and customer display.',
    `promotion_status` STRING COMMENT 'Current lifecycle state of the promotion indicating whether it is available for customer redemption.. Valid values are `draft|scheduled|active|paused|expired|cancelled`',
    `promotion_type` STRING COMMENT 'Category of discount mechanism applied by this promotion. [ENUM-REF-CANDIDATE: percentage_off|fixed_amount|bogo|free_shipping|bundle|loyalty_point_redemption|tiered_member_pricing|gift_with_purchase|volume_discount — promote to reference product]. Valid values are `percentage_off|fixed_amount|bogo|free_shipping|bundle|loyalty_point_redemption`',
    `redemption_count` STRING COMMENT 'Total number of times this promotion has been successfully redeemed by customers to date.',
    `revenue_impact_amount` DECIMAL(18,2) COMMENT 'Total monetary value of discounts granted through this promotion to date, representing the revenue reduction attributable to the promotion.',
    `stackable_flag` BOOLEAN COMMENT 'Indicates whether this promotion can be combined with other promotions in a single transaction. True if stackable, False if exclusive.',
    `start_date` DATE COMMENT 'Date when the promotion becomes active and available for customer redemption.',
    `terms_and_conditions` STRING COMMENT 'Legal and business terms governing the use of this promotion, including restrictions, exclusions, and customer obligations.',
    `usage_limit_per_customer` STRING COMMENT 'Maximum number of times a single customer can redeem this promotion. Null for unlimited per-customer usage.',
    `usage_limit_total` STRING COMMENT 'Maximum number of times this promotion can be redeemed across all customers. Null for unlimited usage.',
    CONSTRAINT pk_site_promotion PRIMARY KEY(`site_promotion_id`)
) COMMENT 'Defines promotional campaigns, discount rules, and redemption tracking configured on the digital storefront, including promotion name, promotion type (percentage off, fixed amount, BOGO, free shipping, bundle, loyalty point redemption, tiered member pricing), applicable SKUs or categories, promo code, start/end dates, usage limit, minimum order value threshold, stackability flag, redemption count, revenue impact, and promotion status. Owned by the e-commerce domain for digital channel promotions; complements but does not duplicate marketing campaign records.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` (
    `ab_test_id` BIGINT COMMENT 'Unique identifier for the A/B or multivariate test. Primary key for the ab_test data product.',
    `concept_id` BIGINT COMMENT 'Foreign key linking to design.concept. Business justification: E-commerce teams A/B test concept-driven merchandising strategies (concept-based landing pages, thematic product groupings). Test results inform which design concepts resonate with digital customers, ',
    `digital_storefront_id` BIGINT COMMENT 'Reference to the digital storefront where this test is executed. Links to the digital_storefront product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: A/B tests are owned by product managers, merchandisers, or UX designers for experimentation programs. Links enable performance tracking, workload management, and accountability for test design/analysi',
    `additional_variants_count` STRING COMMENT 'Number of additional treatment variants beyond the primary treatment. Zero for simple A/B tests, one or more for A/B/n or multivariate tests. Detailed variant data stored in related variant detail table.',
    `confidence_level_percent` DECIMAL(18,2) COMMENT 'Statistical confidence level achieved by the test results, typically 95.00 or 99.00. Represents the probability that the observed difference is not due to random chance. Calculated from p-value: confidence = (1 - p_value) * 100.',
    `control_aov` DECIMAL(18,2) COMMENT 'Average Order Value (AOV) for orders from the control variant, calculated as total revenue divided by number of orders. Measured in the storefronts default currency.',
    `control_conversion_rate_percent` DECIMAL(18,2) COMMENT 'Conversion rate for the control variant, calculated as (control_conversions / control_impressions) * 100. Baseline performance metric against which treatment variants are compared.',
    `control_conversions` BIGINT COMMENT 'Total number of conversions (successful outcomes per primary success metric) from the control variant. For conversion rate tests, this is completed purchases; for CTR tests, this is clicks.',
    `control_impressions` BIGINT COMMENT 'Total number of unique visitors or sessions exposed to the control variant during the test period. Used as denominator in conversion rate calculations.',
    `control_revenue_per_visitor` DECIMAL(18,2) COMMENT 'Revenue per visitor for the control variant, calculated as total revenue divided by impressions. Combines conversion rate and order value into a single metric. Measured in the storefronts default currency.',
    `control_traffic_split_percent` DECIMAL(18,2) COMMENT 'Percentage of test traffic allocated to the control variant. In a 50/50 A/B test this would be 50.00. In multivariate tests may be lower to accommodate multiple treatment variants.',
    `control_variant_name` STRING COMMENT 'Name of the control variant (baseline experience). Typically Control or Original. This is the existing experience against which treatment variants are compared.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this test record was first created in the system. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and record lifecycle tracking.',
    `end_date` DATE COMMENT 'Date when the test concluded or is scheduled to conclude. Null for tests still running. Used to calculate test duration and determine when results are final.',
    `hypothesis` STRING COMMENT 'The business hypothesis being tested, describing the expected outcome and rationale. Example: Changing the CTA button color from blue to orange will increase click-through rate by 15% because it creates stronger visual contrast.',
    `lift_percent` DECIMAL(18,2) COMMENT 'Percentage improvement (or decline if negative) of the treatment variant over the control for the primary success metric. Calculated as ((treatment_metric - control_metric) / control_metric) * 100. Example: 15.50 means the treatment performed 15.5% better than control.',
    `minimum_detectable_effect_percent` DECIMAL(18,2) COMMENT 'The smallest percentage improvement in the primary metric that the test is designed to detect with statistical confidence. Used in sample size calculation. Example: 5.00 means the test can reliably detect a 5% or greater improvement.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this test record was last modified. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX. Updated whenever test configuration or results are changed. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional context, observations, learnings, or special considerations about the test. May include information about external factors (seasonality, promotions, site issues) that affected results.',
    `p_value` DECIMAL(18,2) COMMENT 'The probability that the observed difference between variants occurred by random chance. Lower values indicate stronger evidence of a real effect. Values below the significance threshold (typically 0.05) indicate statistical significance.',
    `planned_duration_days` STRING COMMENT 'Planned duration of the test in days, determined during test design based on required sample size and traffic volume to achieve statistical significance.',
    `primary_success_metric` STRING COMMENT 'The primary Key Performance Indicator (KPI) used to determine test success. Conversion rate (CVR): percentage of visitors who complete purchase, AOV: Average Order Value, revenue per visitor (RPV): total revenue divided by visitors, click-through rate (CTR): clicks divided by impressions, add-to-cart rate: products added to cart divided by product views, bounce rate: single-page sessions, time on page: average session duration on tested page. [ENUM-REF-CANDIDATE: conversion_rate|aov|revenue_per_visitor|click_through_rate|add_to_cart_rate|bounce_rate|time_on_page — 7 candidates stripped; promote to reference product]',
    `rollout_date` DATE COMMENT 'Date when the winning variant was or will be rolled out to production for all users. Null if no rollout planned or decision pending.',
    `rollout_decision` STRING COMMENT 'Business decision on how to implement test results. Full rollout: deploy winning variant to 100% of traffic, Partial rollout: deploy to subset of traffic or segments, No rollout: keep original experience, Pending: decision not yet made, Rollback: reverse a previous rollout.. Valid values are `full_rollout|partial_rollout|no_rollout|pending|rollback`',
    `secondary_success_metrics` STRING COMMENT 'Comma-separated list of additional metrics monitored to understand broader test impact. Examples: engagement rate, return rate, customer satisfaction score. Used to detect unintended consequences.',
    `significance_threshold` DECIMAL(18,2) COMMENT 'The p-value threshold required to declare a statistically significant result, typically 0.0500 (95% confidence) or 0.0100 (99% confidence). Lower values require stronger evidence but reduce false positive risk.',
    `start_date` DATE COMMENT 'Date when the test began running and traffic allocation started. Used to calculate test duration and align with business calendar events.',
    `test_category` STRING COMMENT 'Category of the test element being optimized: layout (page structure), copy (messaging/text), pricing (price display/strategy), cta (call-to-action buttons), recommendation (product suggestions), navigation (site navigation), checkout (purchase flow), personalization (targeted content). [ENUM-REF-CANDIDATE: layout|copy|pricing|cta|recommendation|navigation|checkout|personalization — 8 candidates stripped; promote to reference product]',
    `test_code` STRING COMMENT 'Business-friendly unique code for the test, used for tracking and reporting purposes. Typically follows a naming convention like EXP_HOMEPAGE_CTA_Q1.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `test_name` STRING COMMENT 'Human-readable name of the A/B test describing the experiment focus, such as Homepage Hero Banner CTA Optimization or Product Detail Page Layout Test.',
    `test_status` STRING COMMENT 'Current lifecycle status of the test. Draft: being designed, Scheduled: approved and awaiting start, Running: actively collecting data, Paused: temporarily stopped, Completed: finished with results, Cancelled: terminated early, Archived: historical record. [ENUM-REF-CANDIDATE: draft|scheduled|running|paused|completed|cancelled|archived — 7 candidates stripped; promote to reference product]',
    `test_type` STRING COMMENT 'Type of experiment being conducted. A/B tests compare two variants, multivariate tests multiple variables simultaneously, split_url tests different page URLs, redirect tests send traffic to entirely different pages.. Valid values are `A/B|multivariate|split_url|redirect`',
    `traffic_allocation_percent` DECIMAL(18,2) COMMENT 'Percentage of total site traffic allocated to this test. Remaining traffic sees the default experience. Typical values range from 10% to 100% depending on risk tolerance and traffic volume.',
    `treatment_aov` DECIMAL(18,2) COMMENT 'Average Order Value (AOV) for orders from the primary treatment variant, calculated as total revenue divided by number of orders. Measured in the storefronts default currency.',
    `treatment_conversion_rate_percent` DECIMAL(18,2) COMMENT 'Conversion rate for the primary treatment variant, calculated as (treatment_conversions / treatment_impressions) * 100. Compared against control to determine test outcome.',
    `treatment_conversions` BIGINT COMMENT 'Total number of conversions (successful outcomes per primary success metric) from the primary treatment variant. For conversion rate tests, this is completed purchases; for CTR tests, this is clicks.',
    `treatment_impressions` BIGINT COMMENT 'Total number of unique visitors or sessions exposed to the primary treatment variant during the test period. Used as denominator in conversion rate calculations.',
    `treatment_revenue_per_visitor` DECIMAL(18,2) COMMENT 'Revenue per visitor for the primary treatment variant, calculated as total revenue divided by impressions. Combines conversion rate and order value into a single metric. Measured in the storefronts default currency.',
    `treatment_traffic_split_percent` DECIMAL(18,2) COMMENT 'Percentage of test traffic allocated to the primary treatment variant. In a 50/50 A/B test this would be 50.00. Sum of all variant splits must equal 100.',
    `treatment_variant_name` STRING COMMENT 'Name of the primary treatment variant (new experience being tested). Examples: Variant A, Orange CTA, New Layout. For multivariate tests, this may represent the first treatment; additional variants tracked separately.',
    `winner_variant` STRING COMMENT 'Declared winner of the test based on statistical analysis. Control: original experience wins, Treatment: new experience wins, Inconclusive: no statistically significant difference, Ongoing: test still running or analysis incomplete.. Valid values are `control|treatment|inconclusive|ongoing`',
    CONSTRAINT pk_ab_test PRIMARY KEY(`ab_test_id`)
) COMMENT 'Master record for A/B and multivariate tests run on the digital storefront, covering the full test lifecycle from hypothesis through outcome. Captures test name, hypothesis, type (layout, copy, pricing, CTA, recommendation), start/end dates, traffic split, control/treatment variants, success metric, significance threshold, status, and per-variant results (impressions, conversions, CVR, AOV, revenue per visitor, confidence level, lift, winner flag). Supports continuous site optimization and evidence-based rollout decisions.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` (
    `wishlist_id` BIGINT COMMENT 'Unique identifier for the wishlist. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Wishlists created from campaign traffic (gift guides, seasonal lookbooks). Supports campaign engagement measurement beyond immediate conversion and enables wishlist-based remarketing within campaign c',
    `digital_storefront_id` BIGINT COMMENT 'Reference to the digital storefront where this wishlist was created.',
    `profile_id` BIGINT COMMENT 'Reference to the customer who owns this wishlist.',
    `archived_timestamp` TIMESTAMP COMMENT 'Timestamp when the wishlist was archived by the customer. Null if never archived.',
    `back_in_stock_alert_enabled` BOOLEAN COMMENT 'Indicates whether the customer wants to be notified when out-of-stock wishlist items become available.',
    `conversion_count` STRING COMMENT 'Number of wishlist items that have been moved to cart or purchased.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the wishlist was first created by the customer.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for wishlist value calculations.. Valid values are `^[A-Z]{3}$`',
    `default_wishlist_flag` BOOLEAN COMMENT 'Indicates whether this is the customers default wishlist for quick-add actions from product pages.',
    `deleted_timestamp` TIMESTAMP COMMENT 'Timestamp when the wishlist was soft-deleted by the customer. Null if not deleted.',
    `event_date` DATE COMMENT 'Target date for event-based wishlists (e.g., wedding date, birthday, holiday). Null for non-event wishlists.',
    `item_count` STRING COMMENT 'Total number of items currently in the wishlist.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the wishlist was last modified (item added, removed, or wishlist attributes updated).',
    `last_share_timestamp` TIMESTAMP COMMENT 'Timestamp when the wishlist was most recently shared. Null if never shared.',
    `last_viewed_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer last accessed or viewed this wishlist.',
    `locale_code` STRING COMMENT 'Locale code (language and region) for the wishlist, inherited from the storefront at creation time.',
    `notes` STRING COMMENT 'Free-form notes or comments added by the customer about the wishlist.',
    `notification_enabled` BOOLEAN COMMENT 'Indicates whether the customer has opted in to receive notifications for price drops, back-in-stock alerts, or promotional offers on wishlist items.',
    `price_drop_alert_enabled` BOOLEAN COMMENT 'Indicates whether the customer wants to be notified when any wishlist item price decreases.',
    `registry_completion_percentage` DECIMAL(18,2) COMMENT 'For registry-type wishlists, the percentage of items that have been purchased by gift-givers. Null for non-registry wishlists.',
    `share_count` STRING COMMENT 'Number of times the wishlist has been shared via social media, email, or direct link.',
    `share_token` STRING COMMENT 'Unique token embedded in the share URL for secure access control.',
    `share_url` STRING COMMENT 'Unique shareable URL for the wishlist when visibility is public or shared.',
    `source_channel` STRING COMMENT 'Digital channel through which the wishlist was originally created.. Valid values are `web|mobile_app|tablet|social|email`',
    `total_value` DECIMAL(18,2) COMMENT 'Sum of current prices for all items in the wishlist, in the storefront currency.',
    `view_count` STRING COMMENT 'Total number of times the wishlist has been viewed by the owner or shared recipients.',
    `visibility` STRING COMMENT 'Privacy setting for the wishlist: private (only owner), public (discoverable), or shared (accessible via link).. Valid values are `private|public|shared`',
    `wishlist_description` STRING COMMENT 'Optional customer-provided description or notes about the wishlist purpose.',
    `wishlist_name` STRING COMMENT 'Customer-defined name for the wishlist (e.g., Summer Favorites, Gift Ideas, Wedding Registry).',
    `wishlist_status` STRING COMMENT 'Current lifecycle status of the wishlist: active (in use), archived (saved but inactive), or deleted (soft delete).. Valid values are `active|archived|deleted`',
    `wishlist_type` STRING COMMENT 'Classification of wishlist purpose: standard (general), registry (wedding/baby), gift (gift ideas), favorites (saved items), seasonal (holiday/season-specific), or event (special occasion).. Valid values are `standard|registry|gift|favorites|seasonal|event`',
    CONSTRAINT pk_wishlist PRIMARY KEY(`wishlist_id`)
) COMMENT 'Captures shopper wishlists on the digital storefront including list-level attributes (name, creation date, visibility, share URL) and item-level detail (SKU, style, colorway, size, date added, price at save, current price, price drop flag, in-stock flag, move-to-cart timestamp). Supports demand sensing, NOS planning, personalized re-engagement, and back-in-stock/price-drop notification triggers. Distinct from cart — wishlist represents saved intent without active checkout commitment.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` (
    `product_review_id` BIGINT COMMENT 'Unique identifier for the product review record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Reviews solicited via post-purchase email campaigns. Tracks review generation campaign effectiveness and supports UGC content strategy measurement. Links review acquisition to marketing investment.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Customer reviews reporting safety issues, labeling errors, or quality defects trigger compliance incident investigations. Quality assurance teams link reviews to incidents for root cause analysis, cor',
    `profile_id` BIGINT COMMENT 'Reference to the customer who submitted the review. Links to the customer profile in the customer domain.',
    `sales_order_id` BIGINT COMMENT 'Reference to the sales order from which this review originated, if the review is from a verified purchase.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Product reviews must link to specific SKUs for quality feedback loops, return rate analysis, fit issue identification, and product performance dashboards. Currently has only sku code field; proper F',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Customer reviews linked to production batches enable quality intelligence by factory, season, and production run. Identifies manufacturing quality issues, informs factory selection decisions, and supp',
    `age_range` STRING COMMENT 'Age bracket of the reviewer, optionally provided to help other customers assess relevance of the review. [ENUM-REF-CANDIDATE: under_18|18_24|25_34|35_44|45_54|55_64|65_plus — 7 candidates stripped; promote to reference product]',
    `body_type` STRING COMMENT 'Self-reported body type of the reviewer, optionally provided to help other customers with similar body types assess fit.. Valid values are `petite|athletic|curvy|plus_size|tall|average`',
    `brand_response_text` STRING COMMENT 'Official response from the brand or customer service team addressing the customers review, feedback, or concerns.',
    `brand_response_timestamp` TIMESTAMP COMMENT 'Date and time when the brand published their response to the customer review.',
    `color_purchased` STRING COMMENT 'The color variant of the product that the customer purchased and is reviewing. Helps identify color-specific quality issues.',
    `comfort_rating` STRING COMMENT 'Customer rating of the products comfort and wearability on a scale of 1 to 5. Critical metric for apparel and footwear.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the review record was first created in the database. Used for audit trail and data lineage.',
    `fit_rating` STRING COMMENT 'Customer assessment of how the apparel item fits relative to standard sizing expectations. Critical for apparel purchase decisions.. Valid values are `runs_small|true_to_size|runs_large`',
    `helpful_votes_count` STRING COMMENT 'Number of customers who marked this review as helpful. Used to surface most useful reviews and calculate review quality scores.',
    `incentive_type` STRING COMMENT 'Type of incentive provided to the customer for submitting the review, if applicable. Required for transparency and regulatory compliance.. Valid values are `discount|loyalty_points|free_product|gift_card|contest_entry|none`',
    `incentivized_review_flag` BOOLEAN COMMENT 'Indicates whether the customer received an incentive (discount, loyalty points, free product) for submitting the review. Required for FTC compliance.',
    `media_attachment_count` STRING COMMENT 'Number of photos or videos attached to the review by the customer. Reviews with media typically receive higher engagement.',
    `moderation_reason` STRING COMMENT 'Explanation or reason code for rejection or flagging of the review, such as inappropriate content, spam, or policy violation.',
    `moderation_status` STRING COMMENT 'Current moderation workflow state of the review. Pending indicates awaiting review, approved means published, rejected means not published, flagged indicates requiring additional review.. Valid values are `pending|approved|rejected|flagged`',
    `moderation_timestamp` TIMESTAMP COMMENT 'Date and time when the review moderation decision was made by the content moderation team or automated system.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the review record was last modified. Tracks updates to moderation status, brand responses, or vote counts.',
    `overall_rating` STRING COMMENT 'Overall product rating provided by the customer on a scale of 1 to 5, where 1 is poor and 5 is excellent.',
    `published_flag` BOOLEAN COMMENT 'Indicates whether the review is currently visible on the public-facing digital storefront. True if published, False if hidden or unpublished.',
    `published_timestamp` TIMESTAMP COMMENT 'Date and time when the review was first made visible on the digital storefront after moderation approval.',
    `quality_rating` STRING COMMENT 'Customer rating of product quality on a scale of 1 to 5, assessing materials, construction, and craftsmanship.',
    `recommend_flag` BOOLEAN COMMENT 'Indicates whether the customer would recommend this product to others. True if yes, False if no. Contributes to Net Promoter Score (NPS) calculation.',
    `review_body` STRING COMMENT 'Full text content of the customers product review, containing detailed feedback, opinions, and experiences.',
    `review_language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the review was written.. Valid values are `^[a-z]{2}$`',
    `review_source_channel` STRING COMMENT 'The digital channel or touchpoint through which the customer submitted the review.. Valid values are `web|mobile_app|email_campaign|social_media|in_store_kiosk`',
    `review_title` STRING COMMENT 'Short headline or title summarizing the customers review, displayed prominently on the product page.',
    `reviewer_display_name` STRING COMMENT 'Public display name or pseudonym of the reviewer shown on the product page. May be customers actual name or chosen alias.',
    `reviewer_location` STRING COMMENT 'Geographic location of the reviewer, typically city and state or country, displayed to provide context for the review.',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Automated sentiment analysis score derived from natural language processing of the review text, ranging from -1.00 (very negative) to +1.00 (very positive).',
    `size_purchased` STRING COMMENT 'The size variant of the product that the customer purchased and is reviewing. Provides context for fit feedback.',
    `sku` STRING COMMENT 'The SKU code of the product being reviewed. Links to the product catalog.. Valid values are `^[A-Z0-9]{8,20}$`',
    `style_rating` STRING COMMENT 'Customer rating of the products style and aesthetic appeal on a scale of 1 to 5. Specific to fashion and apparel products.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the customer submitted the product review to the digital storefront.',
    `unhelpful_votes_count` STRING COMMENT 'Number of customers who marked this review as not helpful. Used for review quality assessment and ranking algorithms.',
    `value_rating` STRING COMMENT 'Customer assessment of product value for money on a scale of 1 to 5, comparing price paid to perceived quality and utility.',
    `verified_purchase_flag` BOOLEAN COMMENT 'Indicates whether the review is from a verified purchase transaction. True if the reviewer purchased the product through the platform, False otherwise.',
    CONSTRAINT pk_product_review PRIMARY KEY(`product_review_id`)
) COMMENT 'Captures customer-submitted product reviews and ratings on the digital storefront, including reviewer reference, SKU reviewed, overall rating (1-5), review title, review body, fit rating, quality rating, verified purchase flag, submission date, moderation status (pending, approved, rejected, flagged), helpful votes, and response from brand. Supports social proof, product quality feedback loops, and NPS contribution.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` (
    `ecommerce_storefront_availability_id` BIGINT COMMENT 'Unique identifier for the storefront availability record. Primary key for this entity.',
    `digital_storefront_id` BIGINT COMMENT 'Identifier for the digital storefront where this availability record applies.',
    `distribution_center_id` BIGINT COMMENT 'Identifier for the primary warehouse or distribution center that will fulfill orders for this SKU on this storefront.',
    `inventory_pool_id` BIGINT COMMENT 'Identifier for the inventory pool from which this storefront sources its available inventory. Links to the inventory allocation strategy.',
    `quality_hold_id` BIGINT COMMENT 'Foreign key linking to quality.quality_hold. Business justification: Inventory availability must respect quality holds to prevent sale of non-conforming goods. Quality hold status drives WMS inventory blocks, ATP calculation exclusions, and storefront suppression flags',
    `sku_id` BIGINT COMMENT 'Identifier for the SKU whose availability is being tracked on the digital storefront.',
    `source_distribution_center_id` BIGINT COMMENT 'Foreign key linking to logistics.distribution_center. Business justification: Storefront availability records source inventory from specific DCs for ATP calculation and regional stock display. Critical for accurate online inventory visibility and preventing overselling in omnic',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Availability messaging on digital storefronts includes vendor-specific lead times and restock ETAs, especially for drop-ship, made-to-order, and backorder scenarios. Enables accurate customer communic',
    `superseded_ecommerce_storefront_availability_id` BIGINT COMMENT 'Self-referencing FK on ecommerce_storefront_availability (superseded_ecommerce_storefront_availability_id)',
    `allocation_priority` STRING COMMENT 'Priority ranking for inventory allocation to this storefront when inventory is constrained across multiple channels.',
    `atp_quantity` STRING COMMENT 'Quantity of the SKU that can be promised to customers for future delivery, accounting for committed inventory and inbound supply.',
    `availability_change_timestamp` TIMESTAMP COMMENT 'Timestamp when the availability status last changed. Used for tracking availability transitions and triggering notifications.',
    `availability_message` STRING COMMENT 'Customer-facing message describing the current availability status of the SKU, such as in stock, low stock, or out of stock messaging.',
    `availability_status` STRING COMMENT 'Current availability status of the SKU on the digital storefront. Determines shopper visibility, listing suppression, and checkout eligibility.. Valid values are `in_stock|low_stock|out_of_stock|pre_order|backorder|discontinued`',
    `available_quantity` STRING COMMENT 'Current quantity of the SKU available for purchase on this storefront. Represents the Available-to-Sell (ATS) quantity visible to shoppers.',
    `back_in_stock_notification_enabled` BOOLEAN COMMENT 'Indicates whether back-in-stock notifications are enabled for this SKU. When true, customers can subscribe to restock alerts.',
    `backorder_eligible_flag` BOOLEAN COMMENT 'Indicates whether the SKU is eligible for backorder when out of stock. When true, customers can place orders for future fulfillment.',
    `backorder_eta` DATE COMMENT 'Estimated date when backordered SKUs will be available for fulfillment. Used for backorder messaging and customer expectations.',
    `backorder_message` STRING COMMENT 'Customer-facing message displayed when the SKU is on backorder, providing estimated availability and fulfillment expectations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storefront availability record was first created in the system.',
    `display_availability_flag` BOOLEAN COMMENT 'Indicates whether availability information should be displayed to shoppers on the product detail page. When false, availability is hidden.',
    `effective_date` DATE COMMENT 'Date when this availability record became effective on the storefront. Used for historical tracking and availability lifecycle management.',
    `expiration_date` DATE COMMENT 'Date when this availability record expires or is no longer valid. Used for seasonal products and limited-time offerings.',
    `inventory_source_system` STRING COMMENT 'Name of the source system providing inventory data for this availability record, such as WMS, ERP, or OMS.',
    `last_inventory_sync_timestamp` TIMESTAMP COMMENT 'Timestamp of the last successful inventory synchronization from the warehouse management system to the digital storefront.',
    `low_stock_threshold` STRING COMMENT 'Threshold quantity below which the SKU is considered low stock and may trigger low-stock messaging or alerts.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this storefront availability record was last modified or updated.',
    `notification_subscriber_count` STRING COMMENT 'Number of customers subscribed to back-in-stock notifications for this SKU on this storefront. Used for demand forecasting.',
    `perpetual_flag` BOOLEAN COMMENT 'Indicates whether this SKU is managed as perpetual inventory (always available) on the storefront, bypassing standard inventory checks.',
    `pre_order_eligible_flag` BOOLEAN COMMENT 'Indicates whether the SKU is eligible for pre-order before official release. When true, customers can reserve the SKU for future delivery.',
    `pre_order_release_date` DATE COMMENT 'Date when pre-ordered SKUs will be released and shipped to customers. Applicable only when availability status is pre-order.',
    `previous_availability_status` STRING COMMENT 'The availability status immediately before the most recent change. Used for availability change history and analytics.. Valid values are `in_stock|low_stock|out_of_stock|pre_order|backorder|discontinued`',
    `reserved_quantity` STRING COMMENT 'Quantity of the SKU currently reserved in active shopping carts or pending orders, not yet available for new purchases.',
    `restock_date` DATE COMMENT 'Expected date when the SKU will be restocked and available for purchase again. Used for back-in-stock notifications and customer communication.',
    `safety_stock_quantity` STRING COMMENT 'Minimum safety stock quantity maintained for this SKU on this storefront to prevent stockouts and maintain service levels.',
    `suppression_flag` BOOLEAN COMMENT 'Indicates whether the SKU listing is suppressed from the digital storefront. When true, the SKU is hidden from search and browse results.',
    `suppression_reason` STRING COMMENT 'Reason why the SKU listing is suppressed from the storefront. Provides context for merchandising and operational teams. [ENUM-REF-CANDIDATE: out_of_stock|quality_issue|seasonal|discontinued|compliance|pricing_error|merchandising_decision — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_ecommerce_storefront_availability PRIMARY KEY(`ecommerce_storefront_availability_id`)
) COMMENT 'Real-time digital shelf availability record for each SKU on each storefront, representing the ecommerce platforms view of Available-to-Promise (ATP) and Available-to-Sell (ATS) quantities. Captures SKU, storefront, availability status (in-stock, low-stock, out-of-stock, pre-order, backorder), available quantity, restock ETA, suppression flag, backorder messaging eligibility, pre-order release date, last inventory sync timestamp, and availability change history. Distinct from warehouse inventory (owned by inventory domain) — this entity represents what the shopper sees and what drives listing suppression, back-in-stock notifications, and pre-order/backorder checkout logic on the digital storefront.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` (
    `search_query_id` BIGINT COMMENT 'Unique identifier for the search query event. Primary key for the search query product.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Search queries driven by campaign messaging (branded search from TV, product search from social). Measures campaign impact on search behavior and supports SEO-SEM-campaign integration analysis.',
    `digital_storefront_id` BIGINT COMMENT 'Reference to the digital storefront where the search was performed.',
    `merchandising_rule_id` BIGINT COMMENT 'The identifier of the merchandising rule applied to this search query if any rule was triggered.',
    `profile_id` BIGINT COMMENT 'Reference to the customer who performed the search. Null for guest users.',
    `web_session_id` BIGINT COMMENT 'Reference to the web session during which this search query was executed.',
    `refined_from_search_query_id` BIGINT COMMENT 'Self-referencing FK on search_query (refined_from_search_query_id)',
    `ab_test_variant` STRING COMMENT 'The A/B test variant identifier if this search was part of a search algorithm or merchandising experiment.',
    `add_to_cart_flag` BOOLEAN COMMENT 'Indicates whether the shopper added at least one product to cart from this search session.',
    `autocomplete_suggestion_count` STRING COMMENT 'The number of autocomplete suggestions displayed to the shopper as they typed the search term.',
    `click_through_flag` BOOLEAN COMMENT 'Indicates whether the shopper clicked on at least one product from the search results page.',
    `click_through_position` STRING COMMENT 'The position rank of the first product clicked by the shopper in the search results list. Null if no click occurred.',
    `conversion_flag` BOOLEAN COMMENT 'Indicates whether the search session resulted in a completed purchase transaction.',
    `corrected_search_term` STRING COMMENT 'The spell-corrected version of the search term if automatic correction was applied. Null if no correction occurred.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this search query record was first created in the data platform.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the storefront where the search was performed.. Valid values are `^[A-Z]{3}$`',
    `device_type` STRING COMMENT 'The type of device used by the shopper to perform the search: desktop, mobile web, tablet, or native mobile app.. Valid values are `desktop|mobile|tablet|app`',
    `locale_code` STRING COMMENT 'The locale code representing the language and region context of the search in ISO 639-1 and ISO 3166-1 format.. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `merchandising_rule_applied_flag` BOOLEAN COMMENT 'Indicates whether any merchandising rules such as boosting, burying, or pinning were applied to influence search result ranking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this search query record was last modified or enriched with additional metrics.',
    `normalized_search_term` STRING COMMENT 'The search term after normalization processing including lowercasing, stemming, and synonym expansion for analytics consistency.',
    `null_result_flag` BOOLEAN COMMENT 'Indicates whether the search query returned zero results, signaling a merchandising gap or catalog coverage issue.',
    `page_number` STRING COMMENT 'The deepest results page number viewed by the shopper during this search session.',
    `personalization_applied_flag` BOOLEAN COMMENT 'Indicates whether search results were personalized based on customer profile, browsing history, or segment membership.',
    `personalization_segment` STRING COMMENT 'The customer segment code used to personalize search results if personalization was applied.',
    `refinement_applied_flag` BOOLEAN COMMENT 'Indicates whether the shopper applied any filters or refinements such as size, color, price range, or brand after the initial search.',
    `refinement_count` STRING COMMENT 'The number of refinement filters applied by the shopper to narrow search results.',
    `results_count` STRING COMMENT 'The total number of product results returned by the search query.',
    `results_viewed_count` STRING COMMENT 'The total number of individual product results viewed by the shopper across all pages during this search session.',
    `search_duration_seconds` STRING COMMENT 'The time in seconds the shopper spent on search results pages before exiting or converting.',
    `search_exit_type` STRING COMMENT 'The action taken by the shopper to exit the search results: clicked a product, navigated to category, performed new search, exited site, went to cart, or proceeded to checkout.. Valid values are `product_click|category_navigation|new_search|site_exit|cart|checkout`',
    `search_method` STRING COMMENT 'How the search term was entered: manually typed, selected from autocomplete, clicked from suggested searches, selected from recent searches, or clicked from trending searches.. Valid values are `manual|autocomplete|suggested|recent|trending`',
    `search_revenue_amount` DECIMAL(18,2) COMMENT 'The total revenue attributed to this search query if a conversion occurred within the session.',
    `search_source` STRING COMMENT 'The page or interface location where the search was initiated: header search box, landing page, category page, product page, no-results page, or mobile app search.. Valid values are `header|landing_page|category_page|product_page|no_results_page|mobile_app`',
    `search_term` STRING COMMENT 'The raw search query text entered by the shopper in the search box.',
    `search_timestamp` TIMESTAMP COMMENT 'The exact date and time when the search query was executed by the shopper.',
    `search_type` STRING COMMENT 'The type of search performed: keyword text search, category browse, brand filter, attribute filter, voice search, visual search, or barcode scan. [ENUM-REF-CANDIDATE: keyword|category|brand|attribute|voice|visual|barcode — 7 candidates stripped; promote to reference product]',
    `sort_option` STRING COMMENT 'The sorting method selected by the shopper to order search results: relevance, price ascending, price descending, newest arrivals, bestsellers, highest rating, or highest discount. [ENUM-REF-CANDIDATE: relevance|price_low_high|price_high_low|newest|bestseller|rating|discount — 7 candidates stripped; promote to reference product]',
    `spell_correction_applied_flag` BOOLEAN COMMENT 'Indicates whether the search engine applied automatic spell correction to the original search term.',
    `synonym_expansion_applied_flag` BOOLEAN COMMENT 'Indicates whether the search engine expanded the query using configured synonym rules to broaden results.',
    `utm_campaign` STRING COMMENT 'The UTM campaign parameter associated with the session in which the search occurred, used for marketing attribution.',
    `utm_medium` STRING COMMENT 'The UTM medium parameter associated with the session in which the search occurred, identifying the marketing medium.',
    `utm_source` STRING COMMENT 'The UTM source parameter associated with the session in which the search occurred, identifying the traffic source.',
    CONSTRAINT pk_search_query PRIMARY KEY(`search_query_id`)
) COMMENT 'Captures on-site search queries entered by shoppers including search term, results count, click-through rate, and null-result flags for merchandising optimization';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` (
    `recommendation_id` BIGINT COMMENT 'Unique identifier for the product recommendation event. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Recommendations contextualized by active campaigns (seasonal, launch). Enables campaign-aware personalization (recommend campaign products) and measures recommendation engine contribution to campaign ',
    `digital_storefront_id` BIGINT COMMENT 'Identifier of the digital storefront where the recommendation was displayed.',
    `profile_id` BIGINT COMMENT 'Identifier of the customer who received the recommendation.',
    `sales_order_id` BIGINT COMMENT 'Identifier of the order that included a recommended product purchase.',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: Personalization engines recommend products from similar design aesthetics using sketch attributes (silhouette, color story, design direction). Recommendation algorithms leverage design sketch metadata',
    `web_session_id` BIGINT COMMENT 'Identifier of the web session during which the recommendation was served.',
    `fallback_recommendation_id` BIGINT COMMENT 'Self-referencing FK on recommendation (fallback_recommendation_id)',
    `ab_test_variant` STRING COMMENT 'Identifier of the A/B test variant or experiment group to which this recommendation belongs.',
    `add_to_cart_flag` BOOLEAN COMMENT 'Indicates whether any recommended product was added to the shopping cart.',
    `added_to_cart_sku` STRING COMMENT 'The specific SKU from the recommendation set that was added to the cart.',
    `algorithm_type` STRING COMMENT 'Type of recommendation algorithm used to generate the product suggestions.. Valid values are `collaborative_filtering|content_based|hybrid|trending|personalized|rule_based`',
    `algorithm_version` STRING COMMENT 'Version identifier of the recommendation algorithm used.',
    `channel_type` STRING COMMENT 'Digital channel through which the recommendation was delivered.. Valid values are `web|mobile_app|email|sms|push_notification`',
    `click_flag` BOOLEAN COMMENT 'Indicates whether the customer clicked on any of the recommended products.',
    `click_timestamp` TIMESTAMP COMMENT 'Date and time when the customer clicked on a recommended product.',
    `clicked_sku` STRING COMMENT 'The specific SKU that was clicked by the customer from the recommendation set.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Algorithm confidence score for the recommendation quality, typically ranging from 0 to 1.',
    `conversion_flag` BOOLEAN COMMENT 'Indicates whether any recommended product resulted in a completed purchase.',
    `conversion_timestamp` TIMESTAMP COMMENT 'Date and time when the recommended product was purchased.',
    `converted_sku` STRING COMMENT 'The specific SKU from the recommendation set that was purchased.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the recommendation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the revenue amount.. Valid values are `^[A-Z]{3}$`',
    `device_type` STRING COMMENT 'Type of device used by the customer when the recommendation was served.. Valid values are `desktop|mobile|tablet|app|other`',
    `impression_flag` BOOLEAN COMMENT 'Indicates whether the recommendation was actually displayed to the customer (true) or generated but not rendered (false).',
    `locale_code` STRING COMMENT 'Locale or language setting of the customer when the recommendation was served.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the recommendation record was last updated.',
    `personalization_segment` STRING COMMENT 'Customer segment or persona used to personalize the recommendation.',
    `placement_position` STRING COMMENT 'Sequential position of the recommendation widget on the page (1 for first, 2 for second, etc.).',
    `placement_type` STRING COMMENT 'Location or context where the recommendation was displayed to the customer. [ENUM-REF-CANDIDATE: homepage|product_detail_page|cart|checkout|category_page|search_results|email|mobile_app — 8 candidates stripped; promote to reference product]',
    `primary_sku` STRING COMMENT 'The anchor or context SKU that triggered the recommendation (e.g., the product being viewed when recommendations were shown).',
    `recommendation_source` STRING COMMENT 'Source system or service that generated the recommendation (e.g., Adobe Target, internal ML service).',
    `recommendation_status` STRING COMMENT 'Current status of the recommendation event.. Valid values are `active|expired|dismissed|hidden`',
    `recommendation_timestamp` TIMESTAMP COMMENT 'Date and time when the recommendation was generated and served to the customer.',
    `recommended_sku_count` STRING COMMENT 'Total number of SKUs included in the recommendation set.',
    `recommended_sku_list` STRING COMMENT 'Comma-separated list of SKU codes that were recommended to the customer in display order.',
    `relevance_score` DECIMAL(18,2) COMMENT 'Calculated relevance score indicating how well the recommendation matches customer preferences.',
    `revenue_amount` DECIMAL(18,2) COMMENT 'Total revenue generated from the purchase of recommended products in this recommendation event.',
    `strategy` STRING COMMENT 'Business strategy or campaign name associated with the recommendation (e.g., cross-sell, upsell, complete-the-look, frequently-bought-together).',
    `time_to_click_seconds` STRING COMMENT 'Number of seconds elapsed between recommendation display and customer click.',
    `time_to_conversion_seconds` STRING COMMENT 'Number of seconds elapsed between recommendation display and purchase conversion.',
    CONSTRAINT pk_recommendation PRIMARY KEY(`recommendation_id`)
) COMMENT 'Records product recommendations served to shoppers including algorithm type, placement, recommended SKUs, and click/conversion outcomes';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` (
    `storefront_carrier_service_id` BIGINT COMMENT 'Primary key for the storefront-carrier service configuration record',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to the carrier providing service to this storefront',
    `digital_storefront_id` BIGINT COMMENT 'Foreign key linking to the digital storefront where this carrier service is configured',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storefront-carrier service configuration record was created in the system.',
    `display_name` STRING COMMENT 'Customer-facing display name for this carrier service option shown at checkout (e.g., FedEx 2-Day Shipping, UPS Ground). May vary by storefront locale.',
    `effective_date` DATE COMMENT 'Date when this carrier service configuration became effective for this storefront. Identified in detection phase as relationship-specific data.',
    `enabled_flag` BOOLEAN COMMENT 'Indicates whether this carrier service is currently enabled and available for customer selection at checkout on this storefront. Identified in detection phase as relationship-specific data.',
    `estimated_cost_max` DECIMAL(18,2) COMMENT 'Maximum estimated shipping cost for this carrier service on this storefront, used for customer cost estimation ranges.',
    `estimated_cost_min` DECIMAL(18,2) COMMENT 'Minimum estimated shipping cost for this carrier service on this storefront, used for customer cost estimation ranges.',
    `expiration_date` DATE COMMENT 'Date when this carrier service configuration expires or was discontinued for this storefront. Null if still active. Identified in detection phase as relationship-specific data.',
    `free_shipping_threshold` DECIMAL(18,2) COMMENT 'Order value threshold above which this carrier service is offered for free on this storefront. Null if no free shipping promotion applies.',
    `priority_rank` BIGINT COMMENT 'Display priority ranking for this carrier service option at checkout on this storefront. Lower numbers appear first. Identified in detection phase as relationship-specific data.',
    `rate_card_reference` STRING COMMENT 'Reference identifier to the negotiated rate card or pricing agreement applicable to this storefront-carrier combination. Identified in detection phase as relationship-specific data.',
    `service_level` STRING COMMENT 'The specific service level offered by this carrier on this storefront (e.g., standard, express, overnight). Identified in detection phase as relationship-specific data.',
    `sla_target_days` BIGINT COMMENT 'Service level agreement target delivery time in days for this carrier service on this storefront. Used for customer delivery estimates. Identified in detection phase as relationship-specific data.',
    `updated_by` STRING COMMENT 'User or system identifier that last updated this storefront-carrier service configuration.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this storefront-carrier service configuration record was last updated.',
    CONSTRAINT pk_storefront_carrier_service PRIMARY KEY(`storefront_carrier_service_id`)
) COMMENT 'This association product represents the service configuration between digital storefronts and carriers. It captures the operational relationship where each storefront offers specific carrier services to customers at checkout, with distinct service levels, rates, SLAs, and availability settings per storefront-carrier combination. Each record links one digital storefront to one carrier with attributes that define how that carrier service is presented and managed within that specific storefront context.. Existence Justification: In apparel fashion e-commerce operations, digital storefronts offer multiple carrier service options to customers at checkout (FedEx Express, UPS Ground, USPS Priority, regional carriers, etc.), and each carrier serves multiple storefronts across different brands, regions, and markets. The business actively manages storefront-carrier service configurations as operational entities, setting service levels, priority rankings, rate cards, SLAs, and availability flags per storefront-carrier pair. This is not a derived analytical relationship but an operational configuration that ecommerce teams create, update, and disable as part of checkout experience management and carrier performance optimization.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_fulfillment_assignment` (
    `storefront_fulfillment_assignment_id` BIGINT COMMENT 'Unique identifier for this storefront-DC fulfillment assignment record. Primary key.',
    `digital_storefront_id` BIGINT COMMENT 'Foreign key linking to the digital storefront that this fulfillment assignment applies to',
    `distribution_center_id` BIGINT COMMENT 'Foreign key linking to the distribution center assigned to fulfill orders from this storefront',
    `inventory_pool_id` BIGINT COMMENT 'Reference to the specific inventory pool within the DC that this storefront draws from for ATP calculation. Supports segmented inventory management where a DC maintains separate pools for different channels or brands.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of inventory allocated from this DC to this storefront for ATP calculation and order routing. Used in split-allocation scenarios where multiple DCs share fulfillment responsibility for a storefront.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fulfillment assignment record was created in the system.',
    `effective_date` DATE COMMENT 'Date when this storefront-DC fulfillment assignment becomes active and begins routing orders. Supports temporal assignment changes for seasonal capacity shifts, new DC launches, or network reconfigurations.',
    `enabled_flag` BOOLEAN COMMENT 'Indicates whether this storefront-DC fulfillment assignment is currently active and available for order routing. Allows temporary disabling of assignments without deleting the configuration (e.g., during DC maintenance or capacity constraints).',
    `expiration_date` DATE COMMENT 'Date when this storefront-DC fulfillment assignment expires and stops routing orders. Null if assignment is indefinite. Supports planned network changes and temporary assignments.',
    `fulfillment_priority` STRING COMMENT 'Numeric priority ranking for this DC when fulfilling orders from this storefront. Lower numbers indicate higher priority. Used by order routing logic to sequence DC selection when multiple DCs can fulfill the same order.',
    `shipping_cutoff_time` TIMESTAMP COMMENT 'Time of day (in DC local time) by which orders from this storefront must be received to qualify for same-day shipment from this DC. Used for delivery promise calculation and order routing deadlines.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fulfillment assignment record was last modified.',
    CONSTRAINT pk_storefront_fulfillment_assignment PRIMARY KEY(`storefront_fulfillment_assignment_id`)
) COMMENT 'This association product represents the fulfillment assignment between digital storefronts and distribution centers in the omnichannel apparel network. It captures the operational routing rules that determine which DCs can fulfill orders from which storefronts, including priority sequencing, inventory allocation percentages, shipping cutoff times, and effective date ranges. Each record links one digital storefront to one distribution center with attributes that govern order routing, ATP calculation, and fulfillment orchestration across the logistics network.. Existence Justification: In apparel omnichannel operations, digital storefronts fulfill orders from multiple distribution centers to provide inventory breadth, geographic coverage, and redundancy, while each distribution center serves multiple storefronts across different brands, regions, and channels. The business actively manages these fulfillment assignments as operational configuration, setting priority sequences, allocation percentages, cutoff times, and effective date ranges for each storefront-DC pairing to optimize order routing, ATP calculation, and delivery promises.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_factory_allocation` (
    `storefront_factory_allocation_id` BIGINT COMMENT 'Unique identifier for this storefront-factory allocation record. Primary key.',
    `digital_storefront_id` BIGINT COMMENT 'Foreign key linking to the digital storefront that sources from this factory allocation',
    `production_factory_id` BIGINT COMMENT 'Foreign key linking to the manufacturing factory allocated to this storefront',
    `allocation_priority` STRING COMMENT 'Priority ranking for this factory when routing orders from this storefront. Lower numbers indicate higher priority. Used by order management systems to determine factory selection sequence when multiple factories are available.',
    `allocation_status` STRING COMMENT 'Current operational status of this allocation. Active = available for order routing; Inactive = historical record; Pending = approved but not yet effective; Suspended = temporarily disabled.',
    `capacity_allocation_percent` DECIMAL(18,2) COMMENT 'Percentage of the factorys total certified capacity allocated to this storefront. Used for production planning and capacity reservation. Sum of allocations across all storefronts for a factory should not exceed 100%.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this allocation record was created in the system.',
    `effective_date` DATE COMMENT 'Date from which this storefront-factory allocation becomes active and can be used for order routing and production planning.',
    `expiration_date` DATE COMMENT 'Date on which this storefront-factory allocation expires or is scheduled to be terminated. Null indicates an open-ended allocation. Used for contract management and allocation planning.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier that last modified this allocation record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this allocation record.',
    `lead_time_days` STRING COMMENT 'Committed production lead time in days from order placement to ex-factory date for this specific storefront-factory pairing. May differ from the factorys standard lead time due to storefront-specific agreements, product mix, or capacity allocation.',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'Minimum order value in the factorys currency required for orders from this storefront to this factory. Used for order routing validation and consolidation logic.',
    `product_category_scope` STRING COMMENT 'Comma-separated list of product categories that this allocation applies to. Allows storefront-factory allocations to be scoped to specific product types (e.g., woven,knit or footwear). Null indicates all categories the factory is capable of producing.',
    `created_by` STRING COMMENT 'User ID or system identifier that created this allocation record.',
    CONSTRAINT pk_storefront_factory_allocation PRIMARY KEY(`storefront_factory_allocation_id`)
) COMMENT 'This association product represents the allocation contract between digital storefronts and manufacturing factories. It captures the business rules governing which factories can fulfill orders from which storefronts, including priority sequencing, capacity allocation percentages, and lead time commitments. Each record links one digital storefront to one factory with attributes that exist only in the context of this sourcing relationship, enabling order routing logic, production planning, and multi-brand factory allocation strategies.. Existence Justification: In apparel fashion multi-brand retail operations, digital storefronts (regional sites, brand-specific sites, outlet microsites) source production from multiple factories based on capacity, capability, and geographic optimization, while factories simultaneously produce for multiple storefronts across different brands and regions. The business actively manages storefront-factory allocation rules as a sourcing strategy, setting priority sequences for order routing, allocating factory capacity percentages across storefronts, and negotiating storefront-specific lead times. This is an operational relationship managed by production planning and sourcing teams, not an analytical correlation.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`ecommerce`.`merchandising_rule` (
    `merchandising_rule_id` BIGINT COMMENT 'Primary key for merchandising_rule',
    `overridden_by_merchandising_rule_id` BIGINT COMMENT 'Self-referencing FK on merchandising_rule (overridden_by_merchandising_rule_id)',
    `ab_test_variant` STRING COMMENT 'Identifier for the A/B test variant this rule belongs to, used for testing different merchandising strategies.',
    `action_type` STRING COMMENT 'Type of merchandising action the rule performs when triggered (e.g., boosting product visibility, excluding items, pinning to top).',
    `approved_by` STRING COMMENT 'Username or identifier of the manager or system user who approved the rule for activation.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the merchandising rule was approved and authorized for use in production.',
    `boost_factor` DECIMAL(18,2) COMMENT 'Numeric multiplier applied to product ranking scores when the rule boosts product visibility. Higher values increase prominence.',
    `condition_logic` STRING COMMENT 'Business logic or criteria that must be met for the merchandising rule to be triggered and applied.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the merchandising rule record was first created in the system.',
    `merchandising_rule_description` STRING COMMENT 'Detailed business description explaining the purpose, strategy, and expected impact of the merchandising rule.',
    `effective_end_date` DATE COMMENT 'Date when the merchandising rule expires and stops influencing site merchandising. Null indicates no expiration.',
    `effective_start_date` DATE COMMENT 'Date when the merchandising rule becomes active and begins influencing site merchandising.',
    `is_global` BOOLEAN COMMENT 'Indicates whether the merchandising rule applies globally across all markets and channels or is limited to specific targets.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who most recently modified the merchandising rule configuration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the merchandising rule was last updated or modified.',
    `max_products_displayed` STRING COMMENT 'Maximum number of products that can be displayed when this merchandising rule is applied to a placement zone.',
    `notes` STRING COMMENT 'Additional internal notes or comments about the rule for merchandising team reference and collaboration.',
    `performance_metric_target` STRING COMMENT 'Primary key performance indicator (KPI) that the merchandising rule is designed to optimize.',
    `personalization_enabled` BOOLEAN COMMENT 'Indicates whether the rule uses personalization algorithms to tailor product recommendations based on customer behavior and preferences.',
    `placement_zone` STRING COMMENT 'Specific zone or slot on the digital storefront where the rule controls product placement (e.g., homepage hero, category top, PDP recommendations).',
    `priority_rank` STRING COMMENT 'Numeric ranking used to determine rule precedence when multiple rules apply to the same product or page. Lower numbers indicate higher priority.',
    `rule_category` STRING COMMENT 'Secondary classification indicating how the rule is triggered or managed within the merchandising system.',
    `rule_code` STRING COMMENT 'Unique business identifier code for the merchandising rule used in external systems and reporting.',
    `rule_name` STRING COMMENT 'Human-readable name of the merchandising rule for display and identification purposes.',
    `rule_type` STRING COMMENT 'Classification of the merchandising rule indicating its primary purpose in the digital storefront.',
    `source_system` STRING COMMENT 'Name of the system where the merchandising rule was created and is managed (e.g., Salesforce Commerce Cloud).',
    `merchandising_rule_status` STRING COMMENT 'Current lifecycle status of the merchandising rule indicating whether it is currently in effect.',
    `target_channel` STRING COMMENT 'Digital channel where the merchandising rule is applied within the direct-to-consumer (DTC) ecosystem.',
    `target_geography` STRING COMMENT 'Three-letter ISO country code indicating the geographic market where the rule applies. Multiple geographies stored as comma-separated codes.',
    `target_segment` STRING COMMENT 'Customer segment or persona that the merchandising rule is designed to target for personalization purposes.',
    `version_number` STRING COMMENT 'Version number of the merchandising rule configuration, incremented with each modification for change tracking.',
    `created_by` STRING COMMENT 'Username or identifier of the merchandising manager or system user who created the rule.',
    CONSTRAINT pk_merchandising_rule PRIMARY KEY(`merchandising_rule_id`)
) COMMENT 'Master reference table for merchandising_rule. Referenced by merchandising_rule_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ADD CONSTRAINT `fk_ecommerce_web_session_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ADD CONSTRAINT `fk_ecommerce_site_catalog_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ADD CONSTRAINT `fk_ecommerce_site_catalog_parent_catalog_site_catalog_id` FOREIGN KEY (`parent_catalog_site_catalog_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`site_catalog`(`site_catalog_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ADD CONSTRAINT `fk_ecommerce_ecommerce_catalog_product_listing_site_catalog_id` FOREIGN KEY (`site_catalog_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`site_catalog`(`site_catalog_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_merged_from_cart_id` FOREIGN KEY (`merged_from_cart_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`cart`(`cart_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ADD CONSTRAINT `fk_ecommerce_cart_web_session_id` FOREIGN KEY (`web_session_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`web_session`(`web_session_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ADD CONSTRAINT `fk_ecommerce_checkout_session_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`cart`(`cart_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ADD CONSTRAINT `fk_ecommerce_checkout_session_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ADD CONSTRAINT `fk_ecommerce_digital_order_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ADD CONSTRAINT `fk_ecommerce_digital_order_web_session_id` FOREIGN KEY (`web_session_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`web_session`(`web_session_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ADD CONSTRAINT `fk_ecommerce_digital_order_line_digital_order_id` FOREIGN KEY (`digital_order_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_order`(`digital_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ADD CONSTRAINT `fk_ecommerce_site_promotion_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ADD CONSTRAINT `fk_ecommerce_ab_test_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ADD CONSTRAINT `fk_ecommerce_wishlist_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ADD CONSTRAINT `fk_ecommerce_ecommerce_storefront_availability_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ADD CONSTRAINT `fk_ecommerce_ecommerce_storefront_availability_superseded_ecommerce_storefront_availability_id` FOREIGN KEY (`superseded_ecommerce_storefront_availability_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability`(`ecommerce_storefront_availability_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ADD CONSTRAINT `fk_ecommerce_search_query_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ADD CONSTRAINT `fk_ecommerce_search_query_merchandising_rule_id` FOREIGN KEY (`merchandising_rule_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`merchandising_rule`(`merchandising_rule_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ADD CONSTRAINT `fk_ecommerce_search_query_web_session_id` FOREIGN KEY (`web_session_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`web_session`(`web_session_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ADD CONSTRAINT `fk_ecommerce_search_query_refined_from_search_query_id` FOREIGN KEY (`refined_from_search_query_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`search_query`(`search_query_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ADD CONSTRAINT `fk_ecommerce_recommendation_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ADD CONSTRAINT `fk_ecommerce_recommendation_web_session_id` FOREIGN KEY (`web_session_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`web_session`(`web_session_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ADD CONSTRAINT `fk_ecommerce_recommendation_fallback_recommendation_id` FOREIGN KEY (`fallback_recommendation_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`recommendation`(`recommendation_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` ADD CONSTRAINT `fk_ecommerce_storefront_carrier_service_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_fulfillment_assignment` ADD CONSTRAINT `fk_ecommerce_storefront_fulfillment_assignment_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_factory_allocation` ADD CONSTRAINT `fk_ecommerce_storefront_factory_allocation_digital_storefront_id` FOREIGN KEY (`digital_storefront_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`digital_storefront`(`digital_storefront_id`);
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`merchandising_rule` ADD CONSTRAINT `fk_ecommerce_merchandising_rule_overridden_by_merchandising_rule_id` FOREIGN KEY (`overridden_by_merchandising_rule_id`) REFERENCES `apparel_fashion_ecm`.`ecommerce`.`merchandising_rule`(`merchandising_rule_id`);

-- ========= TAGS =========
ALTER SCHEMA `apparel_fashion_ecm`.`ecommerce` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `apparel_fashion_ecm`.`ecommerce` SET TAGS ('dbx_domain' = 'ecommerce');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` SET TAGS ('dbx_subdomain' = 'storefront_operations');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `digital_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Storefront Identifier');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `carbon_target_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Target Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `inventory_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Pool Identifier');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Identifier');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `accessibility_wcag_level` SET TAGS ('dbx_business_glossary_term' = 'Web Content Accessibility Guidelines (WCAG) Compliance Level');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `accessibility_wcag_level` SET TAGS ('dbx_value_regex' = 'A|AA|AAA|not_certified');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `analytics_tracking_code` SET TAGS ('dbx_business_glossary_term' = 'Analytics Tracking Identifier');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Identifier');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `ccpa_compliant` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Compliant Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Direct-to-Consumer (DTC) Channel Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'dtc_web|mobile_app|pwa|social_commerce|marketplace|outlet_web');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `customer_service_email` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Email Address');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `customer_service_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `customer_service_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `domain_url` SET TAGS ('dbx_business_glossary_term' = 'Domain Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `domain_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}(/.*)?$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `gdpr_compliant` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `guest_checkout_enabled` SET TAGS ('dbx_business_glossary_term' = 'Guest Checkout Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `locale_code` SET TAGS ('dbx_business_glossary_term' = 'Locale Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `locale_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `loyalty_program_enabled` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `mobile_app_enabled` SET TAGS ('dbx_business_glossary_term' = 'Mobile Application Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `mobile_app_enabled` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `mobile_app_enabled` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|preview|retired');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `payment_gateway` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `personalization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Personalization Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `platform_version` SET TAGS ('dbx_business_glossary_term' = 'Platform Version');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `pwa_enabled` SET TAGS ('dbx_business_glossary_term' = 'Progressive Web Application (PWA) Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `seo_description` SET TAGS ('dbx_business_glossary_term' = 'Search Engine Optimization (SEO) Meta Description');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `seo_title` SET TAGS ('dbx_business_glossary_term' = 'Search Engine Optimization (SEO) Title');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `shipping_origin_country` SET TAGS ('dbx_business_glossary_term' = 'Shipping Origin Country Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `shipping_origin_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `social_commerce_enabled` SET TAGS ('dbx_business_glossary_term' = 'Social Commerce Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `storefront_code` SET TAGS ('dbx_business_glossary_term' = 'Storefront Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `storefront_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `storefront_name` SET TAGS ('dbx_business_glossary_term' = 'Storefront Name');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `storefront_type` SET TAGS ('dbx_business_glossary_term' = 'Storefront Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `storefront_type` SET TAGS ('dbx_value_regex' = 'flagship|regional|outlet|seasonal|campaign');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_storefront` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` SET TAGS ('dbx_subdomain' = 'storefront_operations');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `web_session_id` SET TAGS ('dbx_business_glossary_term' = 'Web Session ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `digital_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Storefront Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `add_to_cart_count` SET TAGS ('dbx_business_glossary_term' = 'Add to Cart Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `bounce_flag` SET TAGS ('dbx_business_glossary_term' = 'Bounce Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `browser` SET TAGS ('dbx_business_glossary_term' = 'Browser');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `browser_version` SET TAGS ('dbx_business_glossary_term' = 'Browser Version');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `checkout_initiated_flag` SET TAGS ('dbx_business_glossary_term' = 'Checkout Initiated Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `conversion_flag` SET TAGS ('dbx_business_glossary_term' = 'Conversion Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `cookie_consent_status` SET TAGS ('dbx_business_glossary_term' = 'Cookie Consent Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `cookie_consent_status` SET TAGS ('dbx_value_regex' = 'accepted|declined|partial|not_requested');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|smart_tv|wearable|other');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `exit_page_url` SET TAGS ('dbx_business_glossary_term' = 'Exit Page URL');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `geographic_city` SET TAGS ('dbx_business_glossary_term' = 'Geographic City');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `landing_page_url` SET TAGS ('dbx_business_glossary_term' = 'Landing Page URL');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System (OS)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `operating_system_version` SET TAGS ('dbx_business_glossary_term' = 'Operating System (OS) Version');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `page_views` SET TAGS ('dbx_business_glossary_term' = 'Page Views');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `product_page_views` SET TAGS ('dbx_business_glossary_term' = 'Product Page Views');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `search_query_count` SET TAGS ('dbx_business_glossary_term' = 'Search Query Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `session_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Session Duration (Seconds)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session End Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `session_source_platform` SET TAGS ('dbx_business_glossary_term' = 'Session Source Platform');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Start Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `session_status` SET TAGS ('dbx_business_glossary_term' = 'Session Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `session_status` SET TAGS ('dbx_value_regex' = 'active|completed|abandoned|timeout');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'UTM Campaign');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `utm_content` SET TAGS ('dbx_business_glossary_term' = 'UTM Content');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'UTM Medium');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM Source');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`web_session` ALTER COLUMN `utm_term` SET TAGS ('dbx_business_glossary_term' = 'UTM Term');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` SET TAGS ('dbx_subdomain' = 'storefront_operations');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `site_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Site Catalog Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `circular_program_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Program Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `digital_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Merchandiser Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `parent_catalog_site_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Catalog Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `active_from_date` SET TAGS ('dbx_business_glossary_term' = 'Active From Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `active_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Active Stock Keeping Unit (SKU) Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `active_to_date` SET TAGS ('dbx_business_glossary_term' = 'Active To Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `catalog_code` SET TAGS ('dbx_business_glossary_term' = 'Catalog Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `catalog_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `catalog_description` SET TAGS ('dbx_business_glossary_term' = 'Catalog Description');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `catalog_name` SET TAGS ('dbx_business_glossary_term' = 'Catalog Name');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `catalog_priority` SET TAGS ('dbx_business_glossary_term' = 'Catalog Priority');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `catalog_type` SET TAGS ('dbx_business_glossary_term' = 'Catalog Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `catalog_type` SET TAGS ('dbx_value_regex' = 'seasonal|evergreen|outlet|promotional|exclusive|limited_edition');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `country_codes` SET TAGS ('dbx_business_glossary_term' = 'Country Codes');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `default_locale` SET TAGS ('dbx_business_glossary_term' = 'Default Locale');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `default_locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `external_catalog_reference` SET TAGS ('dbx_business_glossary_term' = 'External Catalog Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|country_specific');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `merchandising_theme` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Theme');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `promotion_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `publication_status` SET TAGS ('dbx_business_glossary_term' = 'Publication Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `publication_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|published|suspended|archived');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `search_indexing_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Search Indexing Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `seo_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Search Engine Optimization (SEO) Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `target_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `total_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Total Stock Keeping Unit (SKU) Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_catalog` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` SET TAGS ('dbx_subdomain' = 'storefront_operations');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `ecommerce_catalog_product_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Product Listing Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Category Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `ecolabel_id` SET TAGS ('dbx_business_glossary_term' = 'Ecolabel Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Published By User Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `ftc_label_id` SET TAGS ('dbx_business_glossary_term' = 'Ftc Label Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `merchandise_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Hierarchy Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `product_safety_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Safety Test Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `site_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `size_scale_id` SET TAGS ('dbx_business_glossary_term' = 'Size Chart Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `standard_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `average_rating` SET TAGS ('dbx_business_glossary_term' = 'Average Customer Rating Score');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `badge_color` SET TAGS ('dbx_business_glossary_term' = 'Badge Color Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `badge_text` SET TAGS ('dbx_business_glossary_term' = 'Badge Text');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `browsable_flag` SET TAGS ('dbx_business_glossary_term' = 'Browsable Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `canonical_url` SET TAGS ('dbx_business_glossary_term' = 'Canonical Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `digital_price_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Digital Price Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `digital_price_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `digital_price_override` SET TAGS ('dbx_business_glossary_term' = 'Digital Price Override Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `display_sequence` SET TAGS ('dbx_business_glossary_term' = 'Display Sequence Number');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `expected_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Ship Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `inventory_display_mode` SET TAGS ('dbx_business_glossary_term' = 'Inventory Display Mode');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `inventory_display_mode` SET TAGS ('dbx_value_regex' = 'show_quantity|low_stock_warning|in_stock_only|hide');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `is_bestseller` SET TAGS ('dbx_business_glossary_term' = 'Bestseller Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `is_featured` SET TAGS ('dbx_business_glossary_term' = 'Featured Product Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `is_new_arrival` SET TAGS ('dbx_business_glossary_term' = 'New Arrival Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `is_online_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Online Exclusive Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `listing_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Listing Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `listing_status` SET TAGS ('dbx_business_glossary_term' = 'Listing Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `listing_status` SET TAGS ('dbx_value_regex' = 'active|suppressed|out_of_stock|discontinued|pending|draft');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `listing_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Listing Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `locale_code` SET TAGS ('dbx_business_glossary_term' = 'Locale Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `locale_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `low_stock_threshold` SET TAGS ('dbx_business_glossary_term' = 'Low Stock Threshold Quantity');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `personalization_segment` SET TAGS ('dbx_business_glossary_term' = 'Personalization Segment Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `pre_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Order Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `recommendation_priority` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Priority Score');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `review_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Review Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `searchable_flag` SET TAGS ('dbx_business_glossary_term' = 'Searchable Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `seo_keywords` SET TAGS ('dbx_business_glossary_term' = 'Search Engine Optimization (SEO) Keywords');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `seo_meta_description` SET TAGS ('dbx_business_glossary_term' = 'Search Engine Optimization (SEO) Meta Description');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `seo_title` SET TAGS ('dbx_business_glossary_term' = 'Search Engine Optimization (SEO) Title');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `shipping_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Shipping Restriction Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `tax_category_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Category Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `three_sixty_view_url` SET TAGS ('dbx_business_glossary_term' = '360-Degree View Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `url_slug` SET TAGS ('dbx_business_glossary_term' = 'URL Slug');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_catalog_product_listing` ALTER COLUMN `video_url` SET TAGS ('dbx_business_glossary_term' = 'Product Video Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` SET TAGS ('dbx_subdomain' = 'purchase_journey');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `cart_id` SET TAGS ('dbx_business_glossary_term' = 'Cart Identifier');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Identifier');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `digital_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Storefront Identifier');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Distribution Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `merged_from_cart_id` SET TAGS ('dbx_business_glossary_term' = 'Merged From Cart Identifier');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `packaging_sustainability_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Sustainability Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Identifier');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Applied Promotion Identifier');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Converted Sales Order Identifier');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Identifier');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `web_session_id` SET TAGS ('dbx_business_glossary_term' = 'Web Session Identifier');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `abandoned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cart Abandonment Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `cart_status` SET TAGS ('dbx_business_glossary_term' = 'Cart Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `cart_status` SET TAGS ('dbx_value_regex' = 'active|abandoned|merged|converted|expired|saved');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `cart_type` SET TAGS ('dbx_business_glossary_term' = 'Cart Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `cart_type` SET TAGS ('dbx_value_regex' = 'standard|wishlist|registry|subscription');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `channel_source` SET TAGS ('dbx_business_glossary_term' = 'Channel Source');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `channel_source` SET TAGS ('dbx_value_regex' = 'web|mobile_app|social|email|affiliate|marketplace');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `converted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cart Conversion Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cart Creation Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|app');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cart Expiration Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `gift_message` SET TAGS ('dbx_business_glossary_term' = 'Gift Message Text');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `gift_wrap_flag` SET TAGS ('dbx_business_glossary_term' = 'Gift Wrap Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `guest_checkout_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Checkout Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `item_count` SET TAGS ('dbx_business_glossary_term' = 'Total Item Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `locale_code` SET TAGS ('dbx_business_glossary_term' = 'Locale Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `loyalty_points_applied` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Applied');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cart Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `personalization_segment` SET TAGS ('dbx_business_glossary_term' = 'Personalization Segment Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `shipping_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Shipping Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `shipping_method_code` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Cart Subtotal Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Cart Total Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `unit_count` SET TAGS ('dbx_business_glossary_term' = 'Total Unit Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'UTM Campaign Parameter');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'UTM Medium Parameter');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`cart` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM Source Parameter');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` SET TAGS ('dbx_subdomain' = 'purchase_journey');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `checkout_session_id` SET TAGS ('dbx_business_glossary_term' = 'Checkout Session ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `cart_id` SET TAGS ('dbx_business_glossary_term' = 'Cart Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `digital_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Storefront ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Selected Carrier Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `abandonment_step` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Step');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `abandonment_step` SET TAGS ('dbx_value_regex' = 'cart_review|address_entry|shipping_selection|payment_entry|order_review|none');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `browser_type` SET TAGS ('dbx_business_glossary_term' = 'Browser Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `checkout_abandonment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Checkout Abandonment Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `checkout_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Checkout Completion Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `checkout_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Checkout Duration Seconds');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `checkout_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Checkout Start Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `checkout_status` SET TAGS ('dbx_business_glossary_term' = 'Checkout Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `checkout_status` SET TAGS ('dbx_value_regex' = 'completed|abandoned|errored|in_progress');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|app');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `estimated_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `gift_message_included` SET TAGS ('dbx_business_glossary_term' = 'Gift Message Included');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `guest_checkout_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Checkout Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `locale_code` SET TAGS ('dbx_business_glossary_term' = 'Locale Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `marketing_consent_captured` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Captured');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `payment_failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Failure Reason');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `payment_gateway` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `promo_code_applied` SET TAGS ('dbx_business_glossary_term' = 'Promo Code Applied');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `session_token` SET TAGS ('dbx_business_glossary_term' = 'Session Token');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `session_token` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `shipping_amount` SET TAGS ('dbx_business_glossary_term' = 'Shipping Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `shipping_method_selected` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method Selected');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `shipping_method_selected` SET TAGS ('dbx_value_regex' = 'standard|express|next_day|click_and_collect|same_day');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `steps_completed` SET TAGS ('dbx_business_glossary_term' = 'Steps Completed');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`checkout_session` ALTER COLUMN `transactional_consent_captured` SET TAGS ('dbx_business_glossary_term' = 'Transactional Consent Captured');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` SET TAGS ('dbx_subdomain' = 'purchase_journey');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `digital_order_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Order ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Carrier Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `digital_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Storefront ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `finance_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Payment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Distribution Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `web_session_id` SET TAGS ('dbx_business_glossary_term' = 'Web Session ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `web_session_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'web|mobile_app|pwa|social_commerce|marketplace');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `customer_email` SET TAGS ('dbx_business_glossary_term' = 'Customer Email Address');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `customer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `customer_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `customer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `customer_notes` SET TAGS ('dbx_business_glossary_term' = 'Customer Notes');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `customer_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `customer_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `customer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|other');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `estimated_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `fraud_review_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Review Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `fraud_review_status` SET TAGS ('dbx_value_regex' = 'not_reviewed|approved|declined|pending_review');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `fraud_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_value_regex' = 'ship_to_home|store_pickup|curbside_pickup|locker_pickup|same_day_delivery');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `gift_message` SET TAGS ('dbx_business_glossary_term' = 'Gift Message');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `grand_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Grand Total Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `is_gift` SET TAGS ('dbx_business_glossary_term' = 'Is Gift Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `is_guest_checkout` SET TAGS ('dbx_business_glossary_term' = 'Is Guest Checkout Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|authorized|captured|failed|refunded|partially_refunded');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Placed Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `referrer_url` SET TAGS ('dbx_business_glossary_term' = 'Referrer URL');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `shipping_amount` SET TAGS ('dbx_business_glossary_term' = 'Shipping Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'UTM Campaign Parameter');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'UTM Medium Parameter');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM Source Parameter');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` SET TAGS ('dbx_subdomain' = 'purchase_journey');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `digital_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Order Line ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `cogs_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cogs Entry Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `digital_order_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Order ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `ftc_label_id` SET TAGS ('dbx_business_glossary_term' = 'Ftc Label Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Distribution Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `merchandise_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Hierarchy Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `product_safety_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Safety Test Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `quality_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `sustainable_material_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `traceability_record_id` SET TAGS ('dbx_business_glossary_term' = 'Traceability Record Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `trade_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Compliance Record Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `backorder_flag` SET TAGS ('dbx_business_glossary_term' = 'Backorder Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `cogs_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `cogs_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `colorway` SET TAGS ('dbx_business_glossary_term' = 'Colorway');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `expected_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Ship Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_value_regex' = 'ship_to_home|store_pickup|curbside_pickup|locker_pickup|same_day_delivery');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `gift_message` SET TAGS ('dbx_business_glossary_term' = 'Gift Message');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `gift_message` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `gift_wrap_charge` SET TAGS ('dbx_business_glossary_term' = 'Gift Wrap Charge');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `gift_wrap_flag` SET TAGS ('dbx_business_glossary_term' = 'Gift Wrap Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `line_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Discount Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `line_subtotal` SET TAGS ('dbx_business_glossary_term' = 'Line Subtotal');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `line_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `line_total` SET TAGS ('dbx_business_glossary_term' = 'Line Total');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `markdown_code` SET TAGS ('dbx_business_glossary_term' = 'Markdown (MD) Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `personalization_charge` SET TAGS ('dbx_business_glossary_term' = 'Personalization Charge');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `personalization_text` SET TAGS ('dbx_business_glossary_term' = 'Personalization Text');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `personalization_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `return_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `return_window_days` SET TAGS ('dbx_business_glossary_term' = 'Return Window Days');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Size');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `style_code` SET TAGS ('dbx_business_glossary_term' = 'Style Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `tax_category_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Category Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `unit_msrp` SET TAGS ('dbx_business_glossary_term' = 'Unit Manufacturers Suggested Retail Price (MSRP)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_order_line` ALTER COLUMN `unit_selling_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Selling Price');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` SET TAGS ('dbx_subdomain' = 'purchase_journey');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `digital_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Payment ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Authorization Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `avs_result_code` SET TAGS ('dbx_business_glossary_term' = 'Address Verification System (AVS) Result Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `billing_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `capture_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Capture Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Card Brand');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `card_expiry_month` SET TAGS ('dbx_business_glossary_term' = 'Card Expiry Month');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `card_expiry_month` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `card_expiry_year` SET TAGS ('dbx_business_glossary_term' = 'Card Expiry Year');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `card_expiry_year` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_business_glossary_term' = 'Card Last Four Digits');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Name');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `customer_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Customer IP Address');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `customer_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `customer_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `cvv_result_code` SET TAGS ('dbx_business_glossary_term' = 'Card Verification Value (CVV) Result Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `cvv_result_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `cvv_result_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `decline_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Decline Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `decline_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Decline Reason Description');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `fraud_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Fraud Screening Result');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `fraud_screening_result` SET TAGS ('dbx_value_regex' = 'passed|failed|review|not_screened');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `gateway_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Gateway Transaction ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `installment_count` SET TAGS ('dbx_business_glossary_term' = 'Installment Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `installment_plan_enabled` SET TAGS ('dbx_business_glossary_term' = 'Installment Plan Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|mobile_web|tablet|kiosk|call_center');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `payment_gateway` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway Provider');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `payment_token` SET TAGS ('dbx_business_glossary_term' = 'Payment Token');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `payment_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `payment_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `processing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Processing Fee Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `refund_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Settlement Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `three_ds_authentication_status` SET TAGS ('dbx_business_glossary_term' = '3D Secure (3DS) Authentication Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `three_ds_authentication_status` SET TAGS ('dbx_value_regex' = 'authenticated|not_authenticated|attempted|not_enrolled|error|not_applicable');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Number');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_payment` ALTER COLUMN `transaction_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` SET TAGS ('dbx_subdomain' = 'purchase_journey');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `digital_return_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Return ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `defect_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Defect Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Agent ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `non_conformance_id` SET TAGS ('dbx_business_glossary_term' = 'Non Conformance Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `sales_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Line ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Disposition Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `disposition_code` SET TAGS ('dbx_value_regex' = 'resell|liquidate|donate|destroy|rtv|repair');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Inspection Outcome');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_value_regex' = 'approved|rejected|partial_approval|pending');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `product_condition` SET TAGS ('dbx_business_glossary_term' = 'Product Condition');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `product_condition` SET TAGS ('dbx_value_regex' = 'new_unused|opened_unused|used_good|used_fair|damaged|defective');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `refund_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `refund_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `refund_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `refund_method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `refund_method` SET TAGS ('dbx_value_regex' = 'original_payment|store_credit|gift_card|bank_transfer|check');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `restocking_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `restocking_flag` SET TAGS ('dbx_business_glossary_term' = 'Restocking Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `return_channel` SET TAGS ('dbx_business_glossary_term' = 'Return Channel');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `return_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|customer_service|chatbot|email');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `return_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Eligibility Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `return_label_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Label Generated Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `return_method` SET TAGS ('dbx_business_glossary_term' = 'Return Method');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `return_method` SET TAGS ('dbx_value_regex' = 'mail_in|drop_off|in_store|courier_pickup|locker');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `return_policy_version` SET TAGS ('dbx_business_glossary_term' = 'Return Policy Version');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `return_quantity` SET TAGS ('dbx_business_glossary_term' = 'Return Quantity');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `return_request_date` SET TAGS ('dbx_business_glossary_term' = 'Return Request Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `return_request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Request Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `return_shipping_carrier` SET TAGS ('dbx_business_glossary_term' = 'Return Shipping Carrier');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `return_shipping_cost` SET TAGS ('dbx_business_glossary_term' = 'Return Shipping Cost');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `return_status` SET TAGS ('dbx_business_glossary_term' = 'Return Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `return_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Return Tracking Number');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `return_window_days` SET TAGS ('dbx_business_glossary_term' = 'Return Window Days');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `rma_number` SET TAGS ('dbx_value_regex' = '^RMA-[0-9]{8,12}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `rtv_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Return to Vendor (RTV) Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `rtv_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Return to Vendor (RTV) Processed Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`digital_return` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` SET TAGS ('dbx_subdomain' = 'storefront_operations');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `site_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Site Promotion ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `digital_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Storefront ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Carrier Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `applicable_category_list` SET TAGS ('dbx_business_glossary_term' = 'Applicable Category List');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `applicable_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Applicable Stock Keeping Unit (SKU) List');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `auto_apply_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Apply Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `channel_restriction` SET TAGS ('dbx_business_glossary_term' = 'Channel Restriction');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `channel_restriction` SET TAGS ('dbx_value_regex' = 'web|mobile_app|all_digital');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `customer_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `display_message` SET TAGS ('dbx_business_glossary_term' = 'Display Message');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `exclusion_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Stock Keeping Unit (SKU) List');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `maximum_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value (MOV)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `order_count` SET TAGS ('dbx_business_glossary_term' = 'Order Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `promotion_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `promotion_name` SET TAGS ('dbx_business_glossary_term' = 'Promotion Name');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `promotion_status` SET TAGS ('dbx_business_glossary_term' = 'Promotion Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `promotion_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|paused|expired|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `promotion_type` SET TAGS ('dbx_business_glossary_term' = 'Promotion Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `promotion_type` SET TAGS ('dbx_value_regex' = 'percentage_off|fixed_amount|bogo|free_shipping|bundle|loyalty_point_redemption');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Redemption Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `revenue_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Impact Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Start Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `usage_limit_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Usage Limit Per Customer');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`site_promotion` ALTER COLUMN `usage_limit_total` SET TAGS ('dbx_business_glossary_term' = 'Total Usage Limit');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` SET TAGS ('dbx_subdomain' = 'storefront_operations');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `ab_test_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `digital_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Storefront ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `additional_variants_count` SET TAGS ('dbx_business_glossary_term' = 'Additional Variants Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `confidence_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percent');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `control_aov` SET TAGS ('dbx_business_glossary_term' = 'Control Average Order Value (AOV)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `control_conversion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Control Conversion Rate (CVR) Percent');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `control_conversions` SET TAGS ('dbx_business_glossary_term' = 'Control Conversions');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `control_impressions` SET TAGS ('dbx_business_glossary_term' = 'Control Impressions');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `control_revenue_per_visitor` SET TAGS ('dbx_business_glossary_term' = 'Control Revenue Per Visitor (RPV)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `control_traffic_split_percent` SET TAGS ('dbx_business_glossary_term' = 'Control Traffic Split Percent');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `control_variant_name` SET TAGS ('dbx_business_glossary_term' = 'Control Variant Name');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Test End Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `hypothesis` SET TAGS ('dbx_business_glossary_term' = 'Test Hypothesis');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Lift Percent');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `minimum_detectable_effect_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum Detectable Effect (MDE) Percent');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Test Notes');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `p_value` SET TAGS ('dbx_business_glossary_term' = 'P-Value');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `planned_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration Days');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `primary_success_metric` SET TAGS ('dbx_business_glossary_term' = 'Primary Success Metric');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `rollout_date` SET TAGS ('dbx_business_glossary_term' = 'Rollout Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `rollout_decision` SET TAGS ('dbx_business_glossary_term' = 'Rollout Decision');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `rollout_decision` SET TAGS ('dbx_value_regex' = 'full_rollout|partial_rollout|no_rollout|pending|rollback');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `secondary_success_metrics` SET TAGS ('dbx_business_glossary_term' = 'Secondary Success Metrics');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `significance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Statistical Significance Threshold');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Test Start Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `test_category` SET TAGS ('dbx_business_glossary_term' = 'Test Category');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `test_code` SET TAGS ('dbx_business_glossary_term' = 'Test Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `test_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `test_name` SET TAGS ('dbx_business_glossary_term' = 'Test Name');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'A/B|multivariate|split_url|redirect');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `traffic_allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Traffic Allocation Percent');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `treatment_aov` SET TAGS ('dbx_business_glossary_term' = 'Treatment Average Order Value (AOV)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `treatment_aov` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `treatment_aov` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `treatment_conversion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Treatment Conversion Rate (CVR) Percent');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `treatment_conversion_rate_percent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `treatment_conversion_rate_percent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `treatment_conversions` SET TAGS ('dbx_business_glossary_term' = 'Treatment Conversions');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `treatment_conversions` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `treatment_conversions` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `treatment_impressions` SET TAGS ('dbx_business_glossary_term' = 'Treatment Impressions');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `treatment_impressions` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `treatment_impressions` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `treatment_revenue_per_visitor` SET TAGS ('dbx_business_glossary_term' = 'Treatment Revenue Per Visitor (RPV)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `treatment_revenue_per_visitor` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `treatment_revenue_per_visitor` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `treatment_traffic_split_percent` SET TAGS ('dbx_business_glossary_term' = 'Treatment Traffic Split Percent');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `treatment_traffic_split_percent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `treatment_traffic_split_percent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `treatment_variant_name` SET TAGS ('dbx_business_glossary_term' = 'Treatment Variant Name');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `treatment_variant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `treatment_variant_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `winner_variant` SET TAGS ('dbx_business_glossary_term' = 'Winner Variant');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ab_test` ALTER COLUMN `winner_variant` SET TAGS ('dbx_value_regex' = 'control|treatment|inconclusive|ongoing');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` SET TAGS ('dbx_subdomain' = 'customer_engagement');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `wishlist_id` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `digital_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Storefront Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `back_in_stock_alert_enabled` SET TAGS ('dbx_business_glossary_term' = 'Back In Stock Alert Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `conversion_count` SET TAGS ('dbx_business_glossary_term' = 'Conversion Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `default_wishlist_flag` SET TAGS ('dbx_business_glossary_term' = 'Default Wishlist Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `deleted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deleted Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `item_count` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Item Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `last_share_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Share Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `last_viewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Viewed Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `locale_code` SET TAGS ('dbx_business_glossary_term' = 'Locale Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Notes');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `notification_enabled` SET TAGS ('dbx_business_glossary_term' = 'Notification Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `price_drop_alert_enabled` SET TAGS ('dbx_business_glossary_term' = 'Price Drop Alert Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `registry_completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Registry Completion Percentage');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `share_count` SET TAGS ('dbx_business_glossary_term' = 'Share Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `share_token` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Share Token');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `share_url` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Share Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|tablet|social|email');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Total Value');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `view_count` SET TAGS ('dbx_business_glossary_term' = 'View Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `visibility` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Visibility');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `visibility` SET TAGS ('dbx_value_regex' = 'private|public|shared');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `wishlist_description` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Description');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `wishlist_name` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Name');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `wishlist_status` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `wishlist_status` SET TAGS ('dbx_value_regex' = 'active|archived|deleted');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `wishlist_type` SET TAGS ('dbx_business_glossary_term' = 'Wishlist Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`wishlist` ALTER COLUMN `wishlist_type` SET TAGS ('dbx_value_regex' = 'standard|registry|gift|favorites|seasonal|event');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` SET TAGS ('dbx_subdomain' = 'customer_engagement');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `product_review_id` SET TAGS ('dbx_business_glossary_term' = 'Product Review ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `age_range` SET TAGS ('dbx_business_glossary_term' = 'Age Range');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `body_type` SET TAGS ('dbx_business_glossary_term' = 'Body Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `body_type` SET TAGS ('dbx_value_regex' = 'petite|athletic|curvy|plus_size|tall|average');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `brand_response_text` SET TAGS ('dbx_business_glossary_term' = 'Brand Response Text');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `brand_response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Brand Response Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `color_purchased` SET TAGS ('dbx_business_glossary_term' = 'Color Purchased');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `comfort_rating` SET TAGS ('dbx_business_glossary_term' = 'Comfort Rating');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `fit_rating` SET TAGS ('dbx_business_glossary_term' = 'Fit Rating');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `fit_rating` SET TAGS ('dbx_value_regex' = 'runs_small|true_to_size|runs_large');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `helpful_votes_count` SET TAGS ('dbx_business_glossary_term' = 'Helpful Votes Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Incentive Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `incentive_type` SET TAGS ('dbx_value_regex' = 'discount|loyalty_points|free_product|gift_card|contest_entry|none');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `incentivized_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentivized Review Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `media_attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Media Attachment Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `moderation_reason` SET TAGS ('dbx_business_glossary_term' = 'Moderation Reason');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `moderation_status` SET TAGS ('dbx_business_glossary_term' = 'Moderation Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `moderation_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|flagged');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `moderation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Moderation Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `published_flag` SET TAGS ('dbx_business_glossary_term' = 'Published Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `recommend_flag` SET TAGS ('dbx_business_glossary_term' = 'Recommend Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `review_body` SET TAGS ('dbx_business_glossary_term' = 'Review Body');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `review_language_code` SET TAGS ('dbx_business_glossary_term' = 'Review Language Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `review_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `review_source_channel` SET TAGS ('dbx_business_glossary_term' = 'Review Source Channel');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `review_source_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|email_campaign|social_media|in_store_kiosk');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `review_title` SET TAGS ('dbx_business_glossary_term' = 'Review Title');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `reviewer_display_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Display Name');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `reviewer_display_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `reviewer_display_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `reviewer_location` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Location');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `size_purchased` SET TAGS ('dbx_business_glossary_term' = 'Size Purchased');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `style_rating` SET TAGS ('dbx_business_glossary_term' = 'Style Rating');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `unhelpful_votes_count` SET TAGS ('dbx_business_glossary_term' = 'Unhelpful Votes Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `value_rating` SET TAGS ('dbx_business_glossary_term' = 'Value Rating');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`product_review` ALTER COLUMN `verified_purchase_flag` SET TAGS ('dbx_business_glossary_term' = 'Verified Purchase Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` SET TAGS ('dbx_subdomain' = 'storefront_operations');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `ecommerce_storefront_availability_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Availability ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `digital_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Storefront ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Location ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `inventory_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Pool ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `quality_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `source_distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Source Distribution Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `superseded_ecommerce_storefront_availability_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `allocation_priority` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `atp_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Quantity');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `availability_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Availability Change Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `availability_message` SET TAGS ('dbx_business_glossary_term' = 'Availability Message');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'in_stock|low_stock|out_of_stock|pre_order|backorder|discontinued');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `back_in_stock_notification_enabled` SET TAGS ('dbx_business_glossary_term' = 'Back-in-Stock Notification Enabled');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `backorder_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Backorder Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `backorder_eta` SET TAGS ('dbx_business_glossary_term' = 'Backorder Estimated Time of Arrival (ETA)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `backorder_message` SET TAGS ('dbx_business_glossary_term' = 'Backorder Message');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `display_availability_flag` SET TAGS ('dbx_business_glossary_term' = 'Display Availability Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `inventory_source_system` SET TAGS ('dbx_business_glossary_term' = 'Inventory Source System');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `last_inventory_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Inventory Sync Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `low_stock_threshold` SET TAGS ('dbx_business_glossary_term' = 'Low Stock Threshold');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `notification_subscriber_count` SET TAGS ('dbx_business_glossary_term' = 'Notification Subscriber Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `perpetual_flag` SET TAGS ('dbx_business_glossary_term' = 'Perpetual Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `pre_order_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Order Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `pre_order_release_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Order Release Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `previous_availability_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Availability Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `previous_availability_status` SET TAGS ('dbx_value_regex' = 'in_stock|low_stock|out_of_stock|pre_order|backorder|discontinued');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `restock_date` SET TAGS ('dbx_business_glossary_term' = 'Restock Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`ecommerce_storefront_availability` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` SET TAGS ('dbx_subdomain' = 'storefront_operations');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `search_query_id` SET TAGS ('dbx_business_glossary_term' = 'Search Query ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `digital_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Storefront ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `merchandising_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Rule ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `web_session_id` SET TAGS ('dbx_business_glossary_term' = 'Web Session ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `refined_from_search_query_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `add_to_cart_flag` SET TAGS ('dbx_business_glossary_term' = 'Add to Cart Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `autocomplete_suggestion_count` SET TAGS ('dbx_business_glossary_term' = 'Autocomplete Suggestion Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `click_through_flag` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `click_through_position` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Position');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `conversion_flag` SET TAGS ('dbx_business_glossary_term' = 'Conversion Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `corrected_search_term` SET TAGS ('dbx_business_glossary_term' = 'Corrected Search Term');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|app');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `locale_code` SET TAGS ('dbx_business_glossary_term' = 'Locale Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `locale_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `merchandising_rule_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Rule Applied Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `normalized_search_term` SET TAGS ('dbx_business_glossary_term' = 'Normalized Search Term');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `null_result_flag` SET TAGS ('dbx_business_glossary_term' = 'Null Result Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `page_number` SET TAGS ('dbx_business_glossary_term' = 'Page Number');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `personalization_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Personalization Applied Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `personalization_segment` SET TAGS ('dbx_business_glossary_term' = 'Personalization Segment');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `refinement_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Refinement Applied Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `refinement_count` SET TAGS ('dbx_business_glossary_term' = 'Refinement Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `results_count` SET TAGS ('dbx_business_glossary_term' = 'Results Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `results_viewed_count` SET TAGS ('dbx_business_glossary_term' = 'Results Viewed Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `search_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Search Duration Seconds');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `search_exit_type` SET TAGS ('dbx_business_glossary_term' = 'Search Exit Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `search_exit_type` SET TAGS ('dbx_value_regex' = 'product_click|category_navigation|new_search|site_exit|cart|checkout');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `search_method` SET TAGS ('dbx_business_glossary_term' = 'Search Method');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `search_method` SET TAGS ('dbx_value_regex' = 'manual|autocomplete|suggested|recent|trending');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `search_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Search Revenue Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `search_source` SET TAGS ('dbx_business_glossary_term' = 'Search Source');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `search_source` SET TAGS ('dbx_value_regex' = 'header|landing_page|category_page|product_page|no_results_page|mobile_app');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `search_term` SET TAGS ('dbx_business_glossary_term' = 'Search Term');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `search_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Search Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `search_type` SET TAGS ('dbx_business_glossary_term' = 'Search Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `sort_option` SET TAGS ('dbx_business_glossary_term' = 'Sort Option');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `spell_correction_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Spell Correction Applied Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `synonym_expansion_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Synonym Expansion Applied Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'UTM Campaign');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'UTM Medium');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`search_query` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'UTM Source');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` SET TAGS ('dbx_subdomain' = 'storefront_operations');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `recommendation_id` SET TAGS ('dbx_business_glossary_term' = 'Recommendation ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `digital_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Storefront ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `web_session_id` SET TAGS ('dbx_business_glossary_term' = 'Web Session ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `fallback_recommendation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `add_to_cart_flag` SET TAGS ('dbx_business_glossary_term' = 'Add to Cart Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `added_to_cart_sku` SET TAGS ('dbx_business_glossary_term' = 'Added to Cart Stock Keeping Unit (SKU)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `algorithm_type` SET TAGS ('dbx_business_glossary_term' = 'Algorithm Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `algorithm_type` SET TAGS ('dbx_value_regex' = 'collaborative_filtering|content_based|hybrid|trending|personalized|rule_based');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `algorithm_version` SET TAGS ('dbx_business_glossary_term' = 'Algorithm Version');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'web|mobile_app|email|sms|push_notification');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `click_flag` SET TAGS ('dbx_business_glossary_term' = 'Click Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `click_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Click Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `clicked_sku` SET TAGS ('dbx_business_glossary_term' = 'Clicked Stock Keeping Unit (SKU)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `conversion_flag` SET TAGS ('dbx_business_glossary_term' = 'Conversion Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `conversion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conversion Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `converted_sku` SET TAGS ('dbx_business_glossary_term' = 'Converted Stock Keeping Unit (SKU)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|app|other');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `impression_flag` SET TAGS ('dbx_business_glossary_term' = 'Impression Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `locale_code` SET TAGS ('dbx_business_glossary_term' = 'Locale Code');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `personalization_segment` SET TAGS ('dbx_business_glossary_term' = 'Personalization Segment');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `placement_position` SET TAGS ('dbx_business_glossary_term' = 'Placement Position');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Placement Type');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `primary_sku` SET TAGS ('dbx_business_glossary_term' = 'Primary Stock Keeping Unit (SKU)');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `recommendation_source` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Source');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `recommendation_status` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `recommendation_status` SET TAGS ('dbx_value_regex' = 'active|expired|dismissed|hidden');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `recommendation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `recommended_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Recommended Stock Keeping Unit (SKU) Count');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `recommended_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Recommended Stock Keeping Unit (SKU) List');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `relevance_score` SET TAGS ('dbx_business_glossary_term' = 'Relevance Score');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Amount');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `strategy` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Strategy');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `time_to_click_seconds` SET TAGS ('dbx_business_glossary_term' = 'Time to Click Seconds');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`recommendation` ALTER COLUMN `time_to_conversion_seconds` SET TAGS ('dbx_business_glossary_term' = 'Time to Conversion Seconds');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` SET TAGS ('dbx_subdomain' = 'storefront_operations');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` SET TAGS ('dbx_association_edges' = 'ecommerce.digital_storefront,logistics.carrier');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` ALTER COLUMN `storefront_carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Carrier Service ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Carrier Service - Carrier Id');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` ALTER COLUMN `digital_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Carrier Service - Digital Storefront Id');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` ALTER COLUMN `display_name` SET TAGS ('dbx_business_glossary_term' = 'Display Name');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` ALTER COLUMN `enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` ALTER COLUMN `estimated_cost_max` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Maximum');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` ALTER COLUMN `estimated_cost_min` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Minimum');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` ALTER COLUMN `free_shipping_threshold` SET TAGS ('dbx_business_glossary_term' = 'Free Shipping Threshold');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` ALTER COLUMN `rate_card_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Reference');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` ALTER COLUMN `sla_target_days` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Days');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_carrier_service` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_fulfillment_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_fulfillment_assignment` SET TAGS ('dbx_subdomain' = 'storefront_operations');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_fulfillment_assignment` SET TAGS ('dbx_association_edges' = 'ecommerce.digital_storefront,logistics.distribution_center');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_fulfillment_assignment` ALTER COLUMN `storefront_fulfillment_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Fulfillment Assignment ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_fulfillment_assignment` ALTER COLUMN `digital_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Fulfillment Assignment - Digital Storefront Id');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_fulfillment_assignment` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Fulfillment Assignment - Distribution Center Id');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_fulfillment_assignment` ALTER COLUMN `inventory_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Pool ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_fulfillment_assignment` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_fulfillment_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_fulfillment_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_fulfillment_assignment` ALTER COLUMN `enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_fulfillment_assignment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_fulfillment_assignment` ALTER COLUMN `fulfillment_priority` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Priority');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_fulfillment_assignment` ALTER COLUMN `shipping_cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cutoff Time');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_fulfillment_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_factory_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_factory_allocation` SET TAGS ('dbx_subdomain' = 'storefront_operations');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_factory_allocation` SET TAGS ('dbx_association_edges' = 'ecommerce.digital_storefront,production.factory');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_factory_allocation` ALTER COLUMN `storefront_factory_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Factory Allocation ID');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_factory_allocation` ALTER COLUMN `digital_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Factory Allocation - Digital Storefront Id');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_factory_allocation` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Factory Allocation - Factory Id');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_factory_allocation` ALTER COLUMN `allocation_priority` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_factory_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_factory_allocation` ALTER COLUMN `capacity_allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Allocation Percentage');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_factory_allocation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_factory_allocation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_factory_allocation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_factory_allocation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_factory_allocation` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_factory_allocation` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_factory_allocation` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_factory_allocation` ALTER COLUMN `product_category_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Category Scope');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`storefront_factory_allocation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`merchandising_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`merchandising_rule` SET TAGS ('dbx_subdomain' = 'storefront_operations');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`merchandising_rule` ALTER COLUMN `merchandising_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Rule Identifier');
ALTER TABLE `apparel_fashion_ecm`.`ecommerce`.`merchandising_rule` ALTER COLUMN `overridden_by_merchandising_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
