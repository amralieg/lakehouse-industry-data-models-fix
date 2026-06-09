-- Schema for Domain: content | Business: Ecommerce | Version: v1_ecm
-- Generated on: 2026-05-04 23:24:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`content` COMMENT 'Manages digital content assets powering the buyer experience including product images, videos, descriptions, SEO metadata, and content localization. Supports CDN integration, content versioning, digital asset management, search and recommendation engine inputs, PDP/PLP editorial content, and A/B test content variants for international storefronts.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`content`.`content_digital_asset` (
    `content_digital_asset_id` BIGINT COMMENT 'Unique system-generated identifier for the digital asset.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Required for asset accounting: digital media assets are expensed/depreciated against a GL account, enabling financial reporting of media costs.',
    `rights_license_id` BIGINT COMMENT 'Foreign key linking to content.rights_license. Business justification: Digital assets have a rights_license string; replace with FK to rights_license table for proper licensing management.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: REQUIRED: Asset ownership report – each digital asset must be linked to the seller who uploaded it for royalty, compliance, and dispute tracking.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Asset acquisition process requires linking each digital asset to its supplying vendor for cost, compliance, and rights tracking.',
    `a_b_test_name` STRING COMMENT 'Name of the A/B test associated with this asset.',
    `a_b_test_variant` STRING COMMENT 'Variant identifier for A/B testing of the asset.. Valid values are `A|B|C|D|E|F`',
    `alt_text` STRING COMMENT 'Alternative text for accessibility and SEO.',
    `aspect_ratio` STRING COMMENT 'Width to height ratio (e.g., 16:9).',
    `asset_type` STRING COMMENT 'Category of the digital asset.. Valid values are `image|video|icon|banner|document`',
    `cache_ttl_seconds` STRING COMMENT 'Time‑to‑live for CDN caching in seconds.',
    `cdn_url` STRING COMMENT 'Public CDN URL where the asset is served.',
    `checksum_md5` STRING COMMENT 'MD5 hash for file integrity verification.',
    `color_profile` STRING COMMENT 'Color space information (e.g., sRGB, AdobeRGB).',
    `content_digital_asset_description` STRING COMMENT 'Free‑form description of the asset for editorial use.',
    `content_digital_asset_name` STRING COMMENT 'Human‑readable name of the asset used in catalogs and UI.',
    `content_digital_asset_status` STRING COMMENT 'Current lifecycle status of the asset.. Valid values are `active|inactive|archived|deleted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the digital asset record was first created in the system.',
    `duration_seconds` STRING COMMENT 'Length of video or audio asset in seconds.',
    `edge_region` STRING COMMENT 'Geographic CDN edge region serving the asset.',
    `expiry_date` DATE COMMENT 'Date after which the asset may no longer be used.',
    `file_name` STRING COMMENT 'Original file name of the uploaded asset.',
    `file_size_bytes` BIGINT COMMENT 'Size of the asset file in bytes.',
    `height_px` STRING COMMENT 'Pixel height of the asset (applicable to images and video).',
    `is_primary` BOOLEAN COMMENT 'Indicates if this asset is the primary representation for its product.',
    `language_code` STRING COMMENT 'ISO 639‑1 language code of the asset content.',
    `locale` STRING COMMENT 'Locale identifier (e.g., en_US) for localized assets.',
    `mime_type` STRING COMMENT 'Internet media type (e.g., image/jpeg, video/mp4).',
    `resolution` STRING COMMENT 'Combined width x height string (e.g., 1920x1080).',
    `seo_description` STRING COMMENT 'Search‑engine‑optimized description for the asset.',
    `seo_title` STRING COMMENT 'Search‑engine‑optimized title for the asset.',
    `source_system` STRING COMMENT 'Originating system that supplied the asset (e.g., PIM, CMS).',
    `storage_path` STRING COMMENT 'Internal storage location or bucket path for the asset.',
    `tags` STRING COMMENT 'Comma‑separated list of business tags for categorization.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the digital asset record.',
    `upload_timestamp` TIMESTAMP COMMENT 'Date‑time when the asset was initially uploaded.',
    `version_approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the version was approved for publishing.',
    `version_cdn_url` STRING COMMENT 'CDN URL for this specific version of the asset.',
    `version_change_type` STRING COMMENT 'Nature of the change applied in this version.. Valid values are `crop|recolor|reformat|retranslate|metadata_update`',
    `version_editor` STRING COMMENT 'User or system that edited this version.',
    `version_number` STRING COMMENT 'Sequential version identifier for the asset.',
    `version_status` STRING COMMENT 'Lifecycle status of this version.. Valid values are `draft|approved|archived`',
    `width_px` STRING COMMENT 'Pixel width of the asset (applicable to images and video).',
    CONSTRAINT pk_content_digital_asset PRIMARY KEY(`content_digital_asset_id`)
) COMMENT 'Master record for all digital content assets in the DAM system including product images, videos, banners, icons, and rich media files. Tracks asset metadata (file format, resolution, file size, MIME type, color profile), CDN distribution details (CDN URL, cache TTL, edge region), storage path, asset status, rights/licensing reference, expiry date, and upload source. Maintains full version history as embedded detail records capturing version number, change type (crop, recolor, reformat, retranslate), version status (draft, approved, archived), editor identity, approval timestamp, and CDN-published URL per version. Enables rollback, audit trail, and A/B content variant management. SSOT for all binary content objects, their metadata, and their complete revision lifecycle.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`content`.`asset_version` (
    `asset_version_id` BIGINT COMMENT 'Unique surrogate key for each asset version record.',
    `content_ab_test_id` BIGINT COMMENT 'Identifier of the A/B test experiment that utilizes this version.',
    `content_digital_asset_id` BIGINT COMMENT 'Identifier of the digital asset to which this version belongs.',
    `customer_profile_id` BIGINT COMMENT 'System identifier of the user who created or modified the version.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the version was approved for publishing.',
    `asset_version_description` STRING COMMENT 'Free‑form notes describing the purpose or changes of this version.',
    `asset_version_status` STRING COMMENT 'Current lifecycle state of the asset version.. Valid values are `draft|approved|archived|rejected`',
    `cdn_url` STRING COMMENT 'Public URL where the versioned asset is hosted on the CDN.. Valid values are `^https?://.*$`',
    `change_type` STRING COMMENT 'Category of modification applied in this version.. Valid values are `crop|recolor|reformat|retranslate|metadata_update|other`',
    `checksum_md5` STRING COMMENT 'MD5 hash of the asset file for integrity verification.. Valid values are `^[a-fA-F0-9]{32}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the version record was initially created.',
    `editor_name` STRING COMMENT 'Full name of the editor responsible for the version.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Date‑time after which the version should no longer be served.',
    `file_format` STRING COMMENT 'Technical format of the asset file.. Valid values are `jpg|png|gif|mp4|webm|svg`',
    `file_size_bytes` BIGINT COMMENT 'Size of the asset file in bytes.',
    `is_a_b_test_variant` BOOLEAN COMMENT 'True if this version is used as a variant in an A/B test.',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this version is the currently active primary version for the asset.',
    `language_code` STRING COMMENT 'Two‑letter ISO code indicating the language of the asset content.. Valid values are `^[a-z]{2}$`',
    `resolution` STRING COMMENT 'Pixel dimensions of the asset (e.g., 1920x1080).',
    `source_system` STRING COMMENT 'Name of the upstream system that originated the asset version (e.g., PIM, DAM).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the version record.',
    `version_label` STRING COMMENT 'Human‑readable label for the version (e.g., v1.0, v2‑beta).',
    `version_number` STRING COMMENT 'Sequential integer representing the version order of the asset.',
    CONSTRAINT pk_asset_version PRIMARY KEY(`asset_version_id`)
) COMMENT 'Tracks the full version history of each digital asset, capturing every revision, re-upload, or transformation applied to a digital asset over its lifecycle. Stores version number, change type (crop, recolor, reformat, retranslate), version status (draft, approved, archived), editor identity, approval timestamp, and CDN-published URL per version. Enables rollback, audit, and A/B content variant management.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`content`.`item` (
    `item_id` BIGINT COMMENT 'Unique identifier for the content item.',
    `agent_id` BIGINT COMMENT 'Identifier of the user who approved the content version.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.audience_segment. Business justification: Required for personalization engine to map each content item to a defined marketing audience segment for targeted delivery.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: REQUIRED: Content authoring audit – seller‑generated product pages need the seller_profile ID to attribute content creation for quality and legal compliance.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Allows campaign performance dashboards to attribute impressions, clicks, and conversions back to the exact content items used in each campaign.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability of individual content items is evaluated by assigning them to profit centers, supporting margin reporting and strategic decisions.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the author who created the content.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Required for Content Compliance Review Report: each content item must be linked to the specific compliance obligation it satisfies (e.g., GDPR, CCPA).',
    `original_content_item_id` BIGINT COMMENT 'Identifier of the original content item for which this record is a localized or variant copy.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Content production costs are charged to a cost center for budgeting and variance analysis, a standard practice in e‑commerce content operations.',
    `segment_id` BIGINT COMMENT 'Target audience segment for which the content is intended.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_contract. Business justification: Licensing contracts for content items must reference the governing vendor contract for legal compliance and renewal management.',
    `ab_test_variant_name` STRING COMMENT 'Name or label of the A/B test variant.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the content was approved for publication.',
    `compliance_legal_review` BOOLEAN COMMENT 'Indicates whether the content has passed legal compliance review.',
    `content_body` STRING COMMENT 'Full text or HTML body of the content item.',
    `content_category` STRING COMMENT 'Broad business category the content belongs to.. Valid values are `product|marketing|legal|support`',
    `content_format` STRING COMMENT 'Technical format of the content body.. Valid values are `html|markdown|plain`',
    `content_length_bytes` BIGINT COMMENT 'Size of the content body in bytes.',
    `content_rating` STRING COMMENT 'Numeric rating (e.g., 1‑5) assigned by editors or users.',
    `content_source` STRING COMMENT 'Origin of the content (e.g., created internally or supplied by a vendor).. Valid values are `internal|vendor|partner`',
    `content_tags` STRING COMMENT 'Comma‑separated list of taxonomy tags applied to the content.',
    `content_type` STRING COMMENT 'Classification of the content purpose and format.. Valid values are `product_description|category_description|landing_page|article|faq`',
    `copyright_notice` STRING COMMENT 'Legal copyright statement attached to the content.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the content item was first created.',
    `diff_summary` STRING COMMENT 'Human‑readable summary of changes from the previous version.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Timestamp when the content should be retired or archived (nullable).',
    `is_ab_test_variant` BOOLEAN COMMENT 'Indicates whether this version is part of an A/B test.',
    `is_localized` BOOLEAN COMMENT 'Indicates whether the content has been localized for a specific market.',
    `item_status` STRING COMMENT 'Current lifecycle status of the content item.. Valid values are `draft|review|published|archived`',
    `language_code` STRING COMMENT 'ISO 639‑1 language code of the content.',
    `legal_review_status` STRING COMMENT 'Current status of the legal compliance review process.. Valid values are `pending|approved|rejected`',
    `locale` STRING COMMENT 'Locale identifier (e.g., en_US) for regional variations.',
    `publication_timestamp` TIMESTAMP COMMENT 'Timestamp when the content was made publicly available.',
    `publishing_channel` STRING COMMENT 'Channel through which the content is delivered to end users.. Valid values are `web|mobile|email|social`',
    `readability_score` DOUBLE COMMENT 'Automated readability metric (e.g., Flesch‑Kincaid).',
    `seo_keyword_density` DOUBLE COMMENT 'Percentage of target SEO keywords relative to total words.',
    `seo_keywords` STRING COMMENT 'Comma‑separated list of target SEO keywords.',
    `seo_meta_description` STRING COMMENT 'Meta description tag used for search engine optimization.',
    `seo_meta_title` STRING COMMENT 'Meta title tag used for search engine optimization.',
    `slug` STRING COMMENT 'URL‑friendly identifier derived from the title, used in web addresses.',
    `title` STRING COMMENT 'Human‑readable title of the content item.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the content item.',
    `version_number` STRING COMMENT 'Sequential version number of the content item.',
    `version_timestamp` TIMESTAMP COMMENT 'Timestamp when this version was created.',
    `word_count` STRING COMMENT 'Total number of words in the content body.',
    CONSTRAINT pk_item PRIMARY KEY(`item_id`)
) COMMENT 'Master record for structured editorial content units including product descriptions, feature bullet points, PDP long-form copy, PLP category descriptions, landing page body text, and editorial articles. Tracks content type, locale, authoring status, word count, readability score, SEO keyword density, publication status, and owning editorial team. Maintains immutable version snapshots as embedded detail records capturing version number, full text body, diff summary from prior version, approval state, approver identity, and publish timestamp. Supports content rollback, editorial workflow approvals, regulatory audit trails, and A/B test variant tracking. SSOT for all text-based content objects and their complete revision lifecycle.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`content`.`version` (
    `version_id` BIGINT COMMENT 'Globally unique identifier for the immutable content version record.',
    `ab_test_variant_id` BIGINT COMMENT 'Identifier of the specific A/B test variant linked to this version.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the user who approved or rejected the version.',
    `item_id` BIGINT COMMENT 'Identifier of the parent content item to which this version belongs.',
    `approval_state` STRING COMMENT 'Result of the editorial approval process for this version.. Valid values are `pending|approved|rejected`',
    `checksum` STRING COMMENT 'MD5 hash of the content_body to verify integrity.. Valid values are `^[a-fA-F0-9]{32}$`',
    `content_body` STRING COMMENT 'Full textual or markup body of the content version, stored as a string.',
    `content_category` STRING COMMENT 'High‑level business category the content supports.. Valid values are `product|brand|marketing|legal|faq|support`',
    `content_length` STRING COMMENT 'Number of characters in the content_body, useful for editorial limits.',
    `content_type` STRING COMMENT 'Classification of the content format or purpose.. Valid values are `article|image|video|seo|description|banner`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the version record was initially created.',
    `diff_summary` STRING COMMENT 'Brief description of changes from the previous version, supporting audit and rollback.',
    `is_ab_test_variant` BOOLEAN COMMENT 'Indicates whether this version is part of an A/B test experiment.',
    `keywords` STRING COMMENT 'Comma‑separated list of keywords associated with the content for search relevance.',
    `language_code` STRING COMMENT 'Two‑letter ISO 639‑1 language identifier for the content version.. Valid values are `^[a-z]{2}$`',
    `last_modified_by` BIGINT COMMENT 'User identifier of the person who last edited the version.',
    `locale` STRING COMMENT 'Locale string combining language and region (e.g., en_US).. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `publish_timestamp` TIMESTAMP COMMENT 'Date‑time when the version was made publicly available.',
    `seo_description` STRING COMMENT 'Meta description shown in search results to improve click‑through.',
    `seo_title` STRING COMMENT 'Title used by search engines for indexing and display in SERPs.',
    `source_system` STRING COMMENT 'Originating system that supplied the content version.. Valid values are `pim|cms|manual|api`',
    `title` STRING COMMENT 'Human‑readable title of the content version, used in editorial listings and SEO.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the version record.',
    `version_number` STRING COMMENT 'Sequential version number indicating the order of this snapshot within the content items history.',
    `version_status` STRING COMMENT 'Current lifecycle state of the content version.. Valid values are `draft|active|archived|retired`',
    CONSTRAINT pk_version PRIMARY KEY(`version_id`)
) COMMENT 'Immutable version snapshot of a content item capturing the full text body, structured fields, and metadata at a specific point in time. Supports content rollback, editorial workflow approvals, and regulatory audit trails. Stores version number, content body, diff summary from prior version, approval state, approver identity, and publish timestamp. Enables A/B test variant tracking at the content body level.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`content`.`seo_metadata` (
    `seo_metadata_id` BIGINT COMMENT 'Unique identifier for the SEO metadata record.',
    `item_id` BIGINT COMMENT 'Foreign key linking to content.content_item. Business justification: SEO metadata is scoped to a specific content item; linking provides direct access and eliminates silo.',
    `canonical_url` STRING COMMENT 'Canonical URL for the page, may differ from page_url if redirects exist.',
    `content_hash` STRING COMMENT 'Hash of the page content used to detect changes.',
    `country_code` STRING COMMENT 'Three-letter country code indicating regional targeting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SEO metadata record was created.',
    `hreflang_tags` STRING COMMENT 'Comma-separated list of hreflang locale tags for language targeting.',
    `is_canonical` BOOLEAN COMMENT 'Indicates if this URL is the canonical version.',
    `keyword_target` STRING COMMENT 'Primary SEO keyword targeted for the page.',
    `last_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the SEO metadata.',
    `locale` STRING COMMENT 'Two-letter language code for the page content.. Valid values are `^[a-z]{2}$`',
    `meta_description` STRING COMMENT 'SEO meta description summarizing page content.',
    `open_graph_description` STRING COMMENT 'Description used in Open Graph metadata.',
    `open_graph_image_url` STRING COMMENT 'URL of the image used in Open Graph metadata.',
    `open_graph_title` STRING COMMENT 'Title used in Open Graph metadata for social sharing.',
    `open_graph_type` STRING COMMENT 'Object type for Open Graph metadata. [ENUM-REF-CANDIDATE: website|article|product|video|profile|music|book — 7 candidates stripped; promote to reference product]',
    `page_type` STRING COMMENT 'Classification of the page for SEO targeting.. Valid values are `product|category|landing|blog|search|other`',
    `page_url` STRING COMMENT 'The canonical URL of the page for SEO purposes.',
    `robots_directive` STRING COMMENT 'Robots meta tag directive controlling indexing and crawling.. Valid values are `index|noindex|follow|nofollow|none`',
    `seo_metadata_status` STRING COMMENT 'Current lifecycle status of the SEO metadata record.. Valid values are `active|inactive|archived|pending`',
    `seo_score` DECIMAL(18,2) COMMENT 'Calculated SEO quality score (0-100) for the page.',
    `sitemap_priority` DECIMAL(18,2) COMMENT 'Priority value for sitemap XML indicating page importance (0.0 to 1.0).',
    `structured_data_json` STRING COMMENT 'JSON-LD markup providing structured data for search engines.',
    `title` STRING COMMENT 'SEO meta title displayed in search results.',
    `version` STRING COMMENT 'Version number for the SEO metadata record, incremented on changes.',
    CONSTRAINT pk_seo_metadata PRIMARY KEY(`seo_metadata_id`)
) COMMENT 'Stores SEO-specific metadata for each content-bearing page or entity, including meta title, meta description, canonical URL, Open Graph tags, structured data markup (JSON-LD schema.org), hreflang locale tags, robots directive, sitemap priority, and keyword targeting. Linked to product PDPs, PLPs, category pages, and editorial landing pages. Supports SEO and SEM optimization workflows and search engine indexing compliance.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`content`.`localization` (
    `localization_id` BIGINT COMMENT 'Unique identifier for the localization record.',
    `agent_id` BIGINT COMMENT 'Identifier of the translator or translation service used.',
    `content_digital_asset_id` BIGINT COMMENT 'Identifier of the original digital asset before localization.',
    `item_id` BIGINT COMMENT 'Identifier of the source content item being localized.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Localization must verify content complies with regional regulations (e.g., GDPR for EU). Supports Localization Compliance Check workflow.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Outsourced translation services are provided by suppliers; linking records supplier for each localized asset for cost and SLA tracking.',
    `asset_alt_text` STRING COMMENT 'Localized alternative text for images or media assets.',
    `asset_url` STRING COMMENT 'URL to the localized digital asset (image, video, etc.).',
    `audience_segment` STRING COMMENT 'Target audience segment for which the localized content is intended.',
    `character_count` BIGINT COMMENT 'Number of characters in the localized text.',
    `compliance_gdpr_flag` BOOLEAN COMMENT 'True if the localized content complies with GDPR requirements for the region.',
    `compliance_legal_notice` STRING COMMENT 'Localized legal disclaimer or notice required for the locale.',
    `content_body` STRING COMMENT 'Full localized text or markup for the content item.',
    `content_type` STRING COMMENT 'Category of the content element that is localized.. Valid values are `product_description|image_alt|video_caption|seo_metadata|email_template|legal_notice`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the localization record was created.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Optional date/time when the localized content should be retired.',
    `is_default_locale` BOOLEAN COMMENT 'True if this locale is the default for the content item.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent review action.',
    `locale_code` STRING COMMENT 'Standard BCP-47 locale identifier (e.g., en-US, fr-FR).',
    `localization_status` STRING COMMENT 'Overall lifecycle status of the localization record.. Valid values are `draft|published|archived|retired`',
    `meta_keywords` STRING COMMENT 'Comma‑separated list of localized SEO keywords.',
    `publish_ready_flag` BOOLEAN COMMENT 'Indicates whether the localization is ready for publishing.',
    `publish_timestamp` TIMESTAMP COMMENT 'Date and time when the localized content was made live.',
    `quality_review_notes` STRING COMMENT 'Free‑form notes from reviewers about translation quality.',
    `region_code` STRING COMMENT 'Two‑letter ISO region code associated with the locale (e.g., US, FR).',
    `review_status` STRING COMMENT 'Current review state of the localized content.. Valid values are `pending|in_review|approved|rejected`',
    `rtl_flag` BOOLEAN COMMENT 'True if the locale requires right‑to‑left rendering.',
    `seo_description` STRING COMMENT 'Localized meta description used for SEO.',
    `seo_title` STRING COMMENT 'Localized SEO title for search engine listings.',
    `source_language` STRING COMMENT 'Language code of the original content before translation.',
    `target_language` STRING COMMENT 'Language code of the localized content.',
    `translation_memory_reference` BIGINT COMMENT 'Reference to the translation memory entry used for this localization.',
    `translation_quality_score` DECIMAL(18,2) COMMENT 'Quality rating of the translation on a 0‑100 scale.',
    `translation_source` STRING COMMENT 'Origin of the translation: human, machine, or hybrid.. Valid values are `human|machine|hybrid`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the localization.',
    `version_number` STRING COMMENT 'Sequential version of the localized content.',
    `word_count` BIGINT COMMENT 'Number of words in the localized text.',
    CONSTRAINT pk_localization PRIMARY KEY(`localization_id`)
) COMMENT 'Manages locale-specific translations and adaptations of content items and digital asset metadata for international storefronts. Tracks locale code (BCP-47), translated content body, translation source (human, machine translation, hybrid), translation quality score, review status, translator identity, character count, and publish readiness per locale. Supports GDPR-compliant regional content delivery, multi-language PDP/PLP rendering, and right-to-left (RTL) layout flagging for applicable locales.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`content`.`tag` (
    `tag_id` BIGINT COMMENT 'Unique surrogate key for each tag record.',
    `parent_tag_id` BIGINT COMMENT 'Reference to the immediate parent tag in the hierarchy, if any.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the tag was approved for production use.',
    `assignment_method` STRING COMMENT 'How the tag was applied to content: manually, via machine‑learning, or rule‑based.. Valid values are `manual|auto_ml|rule_based`',
    `audience` STRING COMMENT 'Intended audience for content using this tag.. Valid values are `consumer|seller|internal|partner`',
    `color_hex` STRING COMMENT 'Hexadecimal color code for UI representation of the tag.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Confidence (0‑100) from automated ML or rule‑based assignment processes.',
    `confidentiality_level` STRING COMMENT 'Data classification of the tag for internal policy compliance.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tag record was first created in the system.',
    `display_order` STRING COMMENT 'Integer used to order tags in UI lists.',
    `effective_from` DATE COMMENT 'Date when the tag becomes valid for use.',
    `effective_until` DATE COMMENT 'Date when the tag is retired; null if indefinite.',
    `external_reference` STRING COMMENT 'Identifier of the tag in an external taxonomy system.',
    `governance_status` STRING COMMENT 'Current governance state of the tag within the taxonomy lifecycle.. Valid values are `approved|deprecated|pending_review`',
    `hierarchy_level` STRING COMMENT 'Depth of the tag within the taxonomy tree (root = 0).',
    `icon` STRING COMMENT 'Identifier of the icon asset used for the tag.',
    `image_url` STRING COMMENT 'URL of the visual icon or image representing the tag.',
    `language` STRING COMMENT 'ISO language code of the tag text.. Valid values are `en|es|fr|de|zh`',
    `last_reviewed_by` STRING COMMENT 'User identifier who performed the most recent review.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Most recent timestamp the tag was applied to any content.',
    `locale` STRING COMMENT 'Locale identifier (e.g., US, GB, CA) for region‑specific tags.',
    `relevance_score` DECIMAL(18,2) COMMENT 'Score (0‑100) indicating the tags relevance to search ranking.',
    `review_date` DATE COMMENT 'Date of the most recent governance review.',
    `review_status` STRING COMMENT 'Outcome of the latest tag governance review.. Valid values are `pending|approved|rejected`',
    `seo_metadata` STRING COMMENT 'SEO‑related metadata (meta title, meta description) associated with the tag.',
    `source_system` STRING COMMENT 'Originating system that created the tag (e.g., PIM, CMS, external taxonomy).',
    `synonyms` STRING COMMENT 'Pipe‑separated list of alternative terms for the tag.',
    `tag_category` STRING COMMENT 'Higher‑level grouping of tags (e.g., Fashion, Electronics).',
    `tag_code` STRING COMMENT 'Unique business code or short identifier for the tag, often used in integrations.',
    `tag_description` STRING COMMENT 'Detailed description of the tags meaning and intended usage.',
    `tag_name` STRING COMMENT 'Human‑readable name of the tag used in editorial and UI contexts.',
    `tag_status` STRING COMMENT 'Current lifecycle state of the tag within the taxonomy.. Valid values are `active|inactive|deprecated|pending`',
    `tag_type` STRING COMMENT 'Classification of the tag purpose, e.g., topic, keyword, product attribute, campaign, or seasonal.. Valid values are `topic|keyword|product_attribute|campaign|seasonal`',
    `updated_by` STRING COMMENT 'User identifier who last modified the tag.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tag record.',
    `url` STRING COMMENT 'Canonical URL for the tags landing page.',
    `usage_count` BIGINT COMMENT 'Number of content items or assets currently assigned to this tag.',
    `version` STRING COMMENT 'Version number of the tag definition, incremented on changes.',
    `created_by` STRING COMMENT 'User identifier who originally created the tag.',
    CONSTRAINT pk_tag PRIMARY KEY(`tag_id`)
) COMMENT 'Controlled vocabulary taxonomy entity representing editorial, SEO, and classification tags applied to content items and digital assets. Stores tag name, tag type (topic, keyword, product attribute, campaign, seasonal), tag hierarchy level, parent tag reference, usage frequency, and governance status (approved, deprecated). Owns the many-to-many tag-to-content assignment records as embedded details including assigned content/asset reference, assignment method (manual, auto-ML, rule-based), confidence score, assigning user/system, assignment date, and active status. SSOT for content taxonomy and all tagging relationships.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`content`.`tag_assignment` (
    `tag_assignment_id` BIGINT COMMENT 'Unique surrogate key for each tag assignment record.',
    `content_digital_asset_id` BIGINT COMMENT 'Identifier of the digital asset (image, video, etc.) associated with the tag assignment.',
    `item_id` BIGINT COMMENT 'Identifier of the content item (e.g., product description, page copy) to which the tag is applied.',
    `tag_id` BIGINT COMMENT 'Identifier of the taxonomy tag applied to the content or asset.',
    `active_status` STRING COMMENT 'Current lifecycle status of the tag assignment.. Valid values are `active|inactive|pending`',
    `assigned_by_system` STRING COMMENT 'Name of the automated system or service that performed the tag assignment.',
    `assignment_method` STRING COMMENT 'Method used to assign the tag: manual, auto‑ML, or rule‑based.. Valid values are `manual|auto_ml|rule_based`',
    `assignment_timestamp` TIMESTAMP COMMENT 'Date and time when the tag was assigned.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Confidence level (0‑100) returned by the ML model when the tag is auto‑assigned.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tag assignment record was first created in the system.',
    `is_deleted` BOOLEAN COMMENT 'Indicates whether the tag assignment has been logically removed (true) or is active (false).',
    `notes` STRING COMMENT 'Free‑form comments or rationale for the tag assignment.',
    `source_application` STRING COMMENT 'Name of the application or service that originated the tag assignment event.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tag assignment record.',
    `version_number` STRING COMMENT 'Incremental version for optimistic concurrency control.',
    CONSTRAINT pk_tag_assignment PRIMARY KEY(`tag_assignment_id`)
) COMMENT 'Association entity linking content items and digital assets to their assigned content tags. Carries its own business data including assignment date, assigning user or system, assignment method (manual, auto-ML, rule-based), confidence score for ML-assigned tags, and active status. Enables many-to-many tagging relationships with full audit trail.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`content`.`publication` (
    `publication_id` BIGINT COMMENT 'Unique identifier for the publication event record.',
    `agent_id` BIGINT COMMENT 'Identifier of the internal user or system that performed the publish action.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: Needed for publishing reports that attribute each publication event to the specific marketing channel (email, social, etc.) used.',
    `content_digital_asset_id` BIGINT COMMENT 'Identifier of the digital asset (image, video, file) associated with the publication.',
    `item_id` BIGINT COMMENT 'Identifier of the content item (e.g., product description, article) that is being published.',
    `version_id` BIGINT COMMENT 'Reference to the publication_id of the event being rolled back to, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the publication record was first created in the system.',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the publication event occurred.',
    `event_type` STRING COMMENT 'Type of action recorded by the event (e.g., publish, unpublish, rollback).. Valid values are `publish|unpublish|rollback|schedule|expire`',
    `expiry_timestamp` TIMESTAMP COMMENT 'Date‑time when the published content should automatically become inactive or be removed.',
    `is_rollback` BOOLEAN COMMENT 'Indicates whether this event represents a rollback to a previous version.',
    `is_test_variant` BOOLEAN COMMENT 'True if the publication is part of an A/B test or experimental variant.',
    `locale` STRING COMMENT 'Locale code (language‑country) for which the content version is targeted, e.g., en-US, fr-FR.. Valid values are `^[a-z]{2}-[A-Z]{2}$`',
    `publication_status` STRING COMMENT 'Current lifecycle state of the publication event.. Valid values are `published|unpublished|scheduled|expired|failed`',
    `scheduled_publish_timestamp` TIMESTAMP COMMENT 'Planned date‑time for future publication when the event is scheduled.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the publication record.',
    `version_number` STRING COMMENT 'Sequential version of the content publication for audit and rollback purposes.',
    CONSTRAINT pk_publication PRIMARY KEY(`publication_id`)
) COMMENT 'Transactional record capturing each publish or unpublish event for a content item or digital asset to a specific storefront channel or locale. Stores publication target (web, mobile app, email, marketplace), publish timestamp, scheduled publish date, expiry date, publisher identity, publication status, and rollback reference. Enables content scheduling, time-limited promotions, and multi-channel content orchestration.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`content`.`ab_test_variant` (
    `ab_test_variant_id` BIGINT COMMENT 'Unique surrogate key for the A/B test content variant.',
    `content_ab_test_id` BIGINT COMMENT 'Identifier of the parent A/B test to which this variant belongs.',
    `content_digital_asset_id` BIGINT COMMENT 'Reference to the digital asset (image, video, copy) used by the variant.',
    `ab_test_variant_code` STRING COMMENT 'System‑generated alphanumeric code uniquely identifying the variant within a test.',
    `ab_test_variant_name` STRING COMMENT 'Human‑readable name of the test variant used in reporting and UI.',
    `ab_test_variant_status` STRING COMMENT 'Current lifecycle state of the variant.. Valid values are `draft|active|paused|completed|archived`',
    `ab_test_variant_type` STRING COMMENT 'Classification of the variant: control, treatment, or multivariate.. Valid values are `control|treatment|multivariate`',
    `country_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code where the variant is served.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the variant record was first created.',
    `end_date` DATE COMMENT 'Date when the variant is retired from the experiment.',
    `hypothesis` STRING COMMENT 'Business hypothesis that the variant is intended to validate.',
    `is_multivariate` BOOLEAN COMMENT 'Indicates whether the variant participates in a multivariate test.',
    `language_code` STRING COMMENT 'ISO 639‑1 language code of the variant content (e.g., en, fr, de).',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified the variant record.',
    `priority` STRING COMMENT 'Numeric priority used when multiple active variants compete for the same audience.',
    `start_date` DATE COMMENT 'Date when the variant becomes active in the experiment.',
    `target_audience_segment` STRING COMMENT 'Identifier of the customer segment targeted by this variant.',
    `traffic_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of total test traffic directed to this variant.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the variant record.',
    `variant_description` STRING COMMENT 'Free‑form description of the variants content and purpose.',
    `version_number` STRING COMMENT 'Incremental version of the variant definition for change tracking.',
    `created_by` STRING COMMENT 'User identifier of the person who created the variant record.',
    CONSTRAINT pk_ab_test_variant PRIMARY KEY(`ab_test_variant_id`)
) COMMENT 'Defines individual A/B test content variants for PDP copy, PLP banners, hero images, CTA text, and editorial layouts. Stores variant name, variant type (control, treatment), content item or asset reference, test hypothesis, traffic allocation percentage, target audience segment, start and end dates, and variant status. Supports multivariate and A/B testing workflows for conversion rate optimization (CVR).';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`content`.`content_ab_test` (
    `content_ab_test_id` BIGINT COMMENT 'Unique identifier for the A/B test experiment.',
    `content_ab_test_name` STRING COMMENT 'Human‑readable name of the experiment.',
    `content_ab_test_status` STRING COMMENT 'Current lifecycle status of the experiment.. Valid values are `draft|running|concluded|archived`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the experiment record was first created in the system.',
    `end_date` DATE COMMENT 'Date when the experiment is scheduled to end or was concluded.',
    `experiment_code` STRING COMMENT 'Business identifier or code assigned to the experiment.',
    `hypothesis` STRING COMMENT 'Business hypothesis that the experiment is designed to test.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the experiment.',
    `owner` STRING COMMENT 'Name or identifier of the person or team responsible for the experiment.',
    `primary_success_metric` STRING COMMENT 'Key metric used to evaluate experiment performance (e.g., Conversion Rate, Click‑Through Rate, Average Order Value).. Valid values are `CVR|CTR|AOV`',
    `randomization_seed` STRING COMMENT 'Seed value used for deterministic random assignment of users to variants.',
    `start_date` DATE COMMENT 'Date when the experiment becomes active.',
    `statistical_significance_threshold` DECIMAL(18,2) COMMENT 'Minimum p‑value or confidence level required to deem results statistically significant.',
    `target_page_type` STRING COMMENT 'Page type where the experiment is applied (Product Detail Page, Product Listing Page, homepage, checkout).. Valid values are `PDP|PLP|homepage|checkout`',
    `test_type` STRING COMMENT 'Classification of the experiment type: A/B, multivariate (MVT), or bandit.. Valid values are `A/B|MVT|bandit`',
    `traffic_allocation_percent` DECIMAL(18,2) COMMENT 'Percentage of total site traffic allocated to the experiment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the experiment record.',
    `variant_count` STRING COMMENT 'Number of distinct variants (including control) defined in the experiment.',
    `version` STRING COMMENT 'Version number of the experiment definition, incremented on each change.',
    CONSTRAINT pk_content_ab_test PRIMARY KEY(`content_ab_test_id`)
) COMMENT 'Master record for A/B and multivariate content experiments run across storefronts. Captures experiment name, hypothesis, test type (A/B, MVT, bandit), target page type (PDP, PLP, homepage, checkout), primary success metric (CVR, CTR, AOV), experiment owner, start date, end date, statistical significance threshold, and experiment status (draft, running, concluded, archived). SSOT for all content experimentation programs.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`content`.`template` (
    `template_id` BIGINT COMMENT 'Unique system-generated identifier for the template.',
    `version_id` BIGINT COMMENT 'Identifier of the immediate predecessor version; null for first version.',
    `ab_test_variant` STRING COMMENT 'Identifies the variant of the template used in A/B testing.. Valid values are `control|variant_a|variant_b`',
    `author_name` STRING COMMENT 'Name of the person or team that originally authored the template.',
    `average_load_time_ms` STRING COMMENT 'Measured average client‑side load time attributable to this template, in milliseconds.',
    `compliance_tag` STRING COMMENT 'Internal tag indicating compliance requirements (e.g., GDPR, PCI) applicable to the template.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the template record was first created in the lakehouse.',
    `custom_css` STRING COMMENT 'Optional CSS snippets injected when the template is rendered.',
    `custom_js` STRING COMMENT 'Optional JavaScript snippets injected when the template is rendered.',
    `effective_from` DATE COMMENT 'Date when the template becomes available for use.',
    `effective_until` DATE COMMENT 'Date when the template is retired; null if open‑ended.',
    `governance_status` STRING COMMENT 'Indicates whether the template has passed content governance review.. Valid values are `approved|pending|rejected`',
    `is_archived` BOOLEAN COMMENT 'True when the template is archived and no longer selectable for new content.',
    `is_default` BOOLEAN COMMENT 'True if this template is the default choice for its type; otherwise false.',
    `last_editor_name` STRING COMMENT 'Name of the person who most recently edited the template.',
    `last_published_timestamp` TIMESTAMP COMMENT 'Date‑time when the template was last published to production storefronts.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Date‑time when the template was last reviewed for compliance or design standards.',
    `layout_schema` STRING COMMENT 'Serialized JSON or HTML structure that defines the visual layout and component hierarchy of the template.',
    `locale_default` STRING COMMENT 'Primary language/locale used when no specific locale is requested.',
    `max_height_px` STRING COMMENT 'Maximum allowed height of the rendered template in pixels.',
    `max_width_px` STRING COMMENT 'Maximum allowed width of the rendered template in pixels.',
    `optional_slots` STRING COMMENT 'Comma‑separated identifiers of content slots that may be left empty.',
    `preview_image_url` STRING COMMENT 'Link to a high‑resolution preview of the rendered template.',
    `required_slots` STRING COMMENT 'Comma‑separated identifiers of content slots that must be populated for the template to be valid.',
    `responsive` BOOLEAN COMMENT 'True if the template adapts to different screen sizes.',
    `review_status` STRING COMMENT 'Current status of the most recent governance review.. Valid values are `pending|approved|rejected`',
    `seo_description` STRING COMMENT 'Optional meta description used for search engine snippets.',
    `seo_title` STRING COMMENT 'Optional SEO title tag that can be injected when the template is rendered.',
    `supported_locales` STRING COMMENT 'Comma‑separated list of language codes for which the template has localized versions.',
    `tags` STRING COMMENT 'Comma‑separated list of user‑defined tags for ad‑hoc filtering.',
    `template_category` STRING COMMENT 'Broad category grouping for reporting and governance.. Valid values are `product|category|email|banner|landing`',
    `template_code` STRING COMMENT 'Business identifier used in the PIM system to reference the template.',
    `template_description` STRING COMMENT 'Narrative description of the template purpose, design guidelines, and usage notes.',
    `template_name` STRING COMMENT 'Descriptive name displayed to content editors and marketers.',
    `template_status` STRING COMMENT 'Indicates whether the template is in draft, active, inactive, archived, or deprecated state.. Valid values are `draft|active|inactive|archived|deprecated`',
    `template_type` STRING COMMENT 'Classifies the template as product detail page, product listing page, landing page, email block, or banner.. Valid values are `pdp|plp|landing|email|banner`',
    `thumbnail_url` STRING COMMENT 'Link to a small preview image of the template for catalog browsing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the template record.',
    `usage_count` BIGINT COMMENT 'Number of times the template has been applied to live pages or campaigns.',
    `version_notes` STRING COMMENT 'Free‑form notes describing changes made in this version.',
    `version_number` STRING COMMENT 'Integer representing the current version of the template; increments on each change.',
    CONSTRAINT pk_template PRIMARY KEY(`template_id`)
) COMMENT 'Defines reusable editorial and layout templates for PDP pages, PLP category pages, landing pages, email content blocks, and banner placements. Stores template name, template type, layout schema (JSON/HTML structure), required content slots, optional content slots, supported locales, and template governance status. Enables consistent brand experience and accelerates content production across storefronts.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`content`.`slot` (
    `slot_id` BIGINT COMMENT 'Unique system-generated identifier for the slot.',
    `template_id` BIGINT COMMENT 'FK to content.template',
    `a_b_test_variant_name` STRING COMMENT 'Identifier for the specific A/B test variant applied to the slot.',
    `allowed_asset_types` STRING COMMENT 'Comma‑separated list of asset types permitted in this slot.. Valid values are `image|video|html|text|json`',
    `assignment_rule_code` STRING COMMENT 'Code of the personalization or business rule governing content assignment to the slot.',
    `channel` STRING COMMENT 'Channel through which the slot is presented to the consumer.. Valid values are `web|mobile|app|email|social`',
    `content_assignment_status` STRING COMMENT 'Current status of content items assigned to the slot.. Valid values are `assigned|unassigned|scheduled|expired`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the slot record was first created.',
    `display_priority` STRING COMMENT 'Numeric priority determining slot ordering when multiple slots share a page region (lower = higher priority).',
    `is_a_b_test_variant` BOOLEAN COMMENT 'True if the slot is part of an A/B testing experiment.',
    `locale` STRING COMMENT 'Two‑letter ISO 639‑1 language code for localized slot variants.. Valid values are `^[a-z]{2}$`',
    `max_content_items` STRING COMMENT 'Maximum number of content assets that can be assigned to the slot at one time.',
    `page_location` STRING COMMENT 'Logical page or section where the slot is rendered (e.g., homepage, product_detail).',
    `personalization_eligible` BOOLEAN COMMENT 'Indicates whether the slot can be targeted by personalization rules.',
    `schedule_end` DATE COMMENT 'Date when the slot is retired or no longer eligible for content assignment (nullable).',
    `schedule_start` DATE COMMENT 'Date when the slot becomes active for content assignment.',
    `seo_metadata` STRING COMMENT 'SEO‑related metadata (e.g., meta title, description) associated with the slot.',
    `slot_code` STRING COMMENT 'Business identifier or code for the slot, unique within a template.',
    `slot_description` STRING COMMENT 'Free‑form description of the slot purpose and editorial notes.',
    `slot_name` STRING COMMENT 'Human‑readable name of the slot used by content editors.',
    `slot_status` STRING COMMENT 'Current lifecycle state of the slot.. Valid values are `active|inactive|archived|draft|pending`',
    `slot_type` STRING COMMENT 'Category of the slot defining its layout and behavior.. Valid values are `hero|carousel|sidebar|footer|inline`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the slot record.',
    `version` STRING COMMENT 'Incremental version number tracking schema changes to the slot definition.',
    CONSTRAINT pk_slot PRIMARY KEY(`slot_id`)
) COMMENT 'Named placement zones within content templates or storefront pages where content items or digital assets are injected (e.g., hero banner, product carousel, editorial spotlight, sidebar widget). Stores slot name, slot type, page location, supported asset types, max content items, display priority, and personalization eligibility flag. Owns content-to-slot assignment records as embedded details including assigned content reference, assignment schedule (start/end dates), priority rank, personalization rule reference, assignment status, and channel/locale scope. SSOT for content placement definitions and all slot-level content assignments.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`content`.`slot_assignment` (
    `slot_assignment_id` BIGINT COMMENT 'Unique identifier for the slot assignment record.',
    `item_id` BIGINT COMMENT 'Identifier of the digital content asset being assigned to a slot.',
    `personalization_rule_id` BIGINT COMMENT 'Identifier of the rule or model that determines when this assignment is shown to a specific audience.',
    `slot_id` BIGINT COMMENT 'Identifier of the storefront content slot where the asset will appear.',
    `assignment_end_timestamp` TIMESTAMP COMMENT 'Date and time when the content assignment expires or is scheduled to be removed.',
    `assignment_method` STRING COMMENT 'Process by which the assignment was created.. Valid values are `manual|automated|rule_based`',
    `assignment_start_timestamp` TIMESTAMP COMMENT 'Date and time when the content assignment becomes effective.',
    `channel` STRING COMMENT 'Delivery channel for which the assignment is applicable.. Valid values are `web|mobile|app|api`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the slot assignment record was first created in the system.',
    `is_deleted` BOOLEAN COMMENT 'Flag indicating soft deletion of the assignment (true = deleted, false = active).',
    `locale` STRING COMMENT 'Locale code (language and region) defining the market variant of the assignment.. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the assignment.',
    `priority_rank` STRING COMMENT 'Display priority of the assignment; lower numbers indicate higher priority for slot rendering.',
    `slot_assignment_status` STRING COMMENT 'Current lifecycle state of the slot assignment.. Valid values are `active|inactive|pending|archived`',
    `source_application` STRING COMMENT 'Name of the upstream system or application that originated the assignment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the slot assignment record.',
    `version_number` STRING COMMENT 'Monotonically increasing version for optimistic concurrency control.',
    CONSTRAINT pk_slot_assignment PRIMARY KEY(`slot_assignment_id`)
) COMMENT 'Association entity linking specific content items or digital assets to content slots within a storefront page or template. Carries business data including assignment start date, end date, display priority rank, personalization rule reference, assignment status, and the channel/locale scope. Enables scheduled content rotations, promotional slot takeovers, and personalized content injection.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`content`.`workflow` (
    `workflow_id` BIGINT COMMENT 'Unique system-generated identifier for the workflow record.',
    `content_digital_asset_id` BIGINT COMMENT 'Identifier of the digital asset (image, video, etc.) associated with the workflow.',
    `item_id` BIGINT COMMENT 'Identifier of the content item (e.g., product description, article) that the workflow pertains to.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Compliance workflows are created to address specific obligations; linking enables Compliance Workflow Management dashboard.',
    `agent_id` BIGINT COMMENT 'Identifier of the user assigned to review or approve the workflow step.',
    `workflow_assigned_by_user_agent_id` BIGINT COMMENT 'Identifier of the user who assigned the workflow to a reviewer.',
    `actual_duration_seconds` STRING COMMENT 'Measured total time the workflow took to complete, expressed in seconds.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the workflow was approved.',
    `assigned_by_system` STRING COMMENT 'Name of the automated system that performed the assignment, if any.',
    `assignment_method` STRING COMMENT 'Mechanism used to assign the workflow (manual, automatic, rule‑based).. Valid values are `manual|auto|rule_based`',
    `comments` STRING COMMENT 'Free‑form notes entered by reviewers or editors.',
    `completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the workflow reached a terminal state (e.g., approved, rejected, archived).',
    `compliance_flag` BOOLEAN COMMENT 'True if the workflow satisfies required regulatory or brand‑governance checks.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Confidence level (0‑100) of the automated assignment algorithm.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the workflow record was first created in the system.',
    `due_date` DATE COMMENT 'Planned date by which the workflow should be completed to meet SLA.',
    `escalation_status` STRING COMMENT 'Current escalation state of the workflow when SLA is breached.. Valid values are `none|escalated|resolved`',
    `estimated_duration_seconds` STRING COMMENT 'Planned total time for the workflow to complete, expressed in seconds.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the workflow was initiated (business event time).',
    `is_deleted` BOOLEAN COMMENT 'True if the workflow has been logically removed but retained for audit.',
    `language_code` STRING COMMENT 'ISO 639‑1 two‑letter code indicating the language of the content.. Valid values are `^[a-z]{2}$`',
    `last_stage` STRING COMMENT 'Name of the most recent stage the workflow passed through.',
    `locale` STRING COMMENT 'Locale identifier combining language and region (e.g., en_US).. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `priority` STRING COMMENT 'Business priority assigned to the workflow for resource planning.. Valid values are `low|medium|high|critical`',
    `rejection_reason` STRING COMMENT 'Free‑form text explaining why a workflow was rejected.',
    `sla_breach_flag` BOOLEAN COMMENT 'True if the workflow missed its SLA deadline.',
    `source_system` STRING COMMENT 'Name of the upstream system that originated the workflow record (e.g., CMS, DAM).',
    `stage_sequence` STRING COMMENT 'Numeric order of the current stage within the workflow.',
    `stage_transition_history` STRING COMMENT 'JSON‑encoded list of stage names with timestamps documenting each transition.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the workflow record.',
    `version_number` STRING COMMENT 'Incremental version of the workflow record for concurrency control.',
    `workflow_category` STRING COMMENT 'High‑level classification of the workflow purpose.. Valid values are `editorial|legal|marketing|technical`',
    `workflow_code` STRING COMMENT 'Human‑readable business identifier for the workflow, used in reporting and tracking.',
    `workflow_status` STRING COMMENT 'Current lifecycle status of the workflow.. Valid values are `draft|in_review|approved|rejected|completed|archived`',
    `workflow_type` STRING COMMENT 'Category of workflow action such as creation, update, translation, or retirement of content.. Valid values are `create|update|translate|retire`',
    CONSTRAINT pk_workflow PRIMARY KEY(`workflow_id`)
) COMMENT 'Tracks the editorial workflow lifecycle for content items and digital assets from creation through review, approval, and publication. Stores workflow type (create, update, translate, retire), current workflow stage, assigned reviewer, due date, SLA breach flag, escalation status, completion timestamp, and stage transition history with timestamps. Supports multi-stage approval workflows for regulated markets, brand governance compliance, content SLA reporting, and editorial team capacity planning.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`content`.`rights_license` (
    `rights_license_id` BIGINT COMMENT 'Unique identifier for the rights license record.',
    `cost` DECIMAL(18,2) COMMENT 'Monetary amount paid for the license.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the license record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the license cost.. Valid values are `[A-Z]{3}`',
    `expiry_date` DATE COMMENT 'Date when the license ends or expires.',
    `is_deleted` BOOLEAN COMMENT 'Indicates soft deletion of the license record.',
    `license_number` STRING COMMENT 'External business identifier for the license agreement.',
    `license_terms_url` STRING COMMENT 'Link to the full legal terms of the license.',
    `license_type` STRING COMMENT 'Classification of the license (e.g., royalty‑free, rights‑managed, exclusive, user‑generated content).. Valid values are `royalty_free|rights_managed|exclusive|ugc`',
    `licensor_name` STRING COMMENT 'Name of the party granting the content license.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the license.',
    `renewal_cost` DECIMAL(18,2) COMMENT 'Cost associated with renewing the license.',
    `renewal_date` DATE COMMENT 'Scheduled date for license renewal, if applicable.',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether the license is set for automatic renewal.',
    `rights_license_status` STRING COMMENT 'Current lifecycle status of the license.. Valid values are `active|inactive|expired|revoked|pending`',
    `start_date` DATE COMMENT 'Date when the license becomes effective.',
    `territory` STRING COMMENT 'Geographic region(s) where the content may be used, expressed as ISO‑3166‑1 alpha‑3 country codes (e.g., USA, CAN).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the license record.',
    `usage_scope` STRING COMMENT 'Intended usage channels for the licensed content.. Valid values are `web|print|social|mobile|tv|audio`',
    `version_number` STRING COMMENT 'Version of the license record for change tracking.',
    CONSTRAINT pk_rights_license PRIMARY KEY(`rights_license_id`)
) COMMENT 'Manages digital rights and licensing agreements for third-party content assets including stock photography, licensed video, brand partner imagery, and UGC (user-generated content). Stores licensor name, license type (royalty-free, rights-managed, exclusive, UGC), licensed territory, usage scope (web, print, social), license start date, expiry date, renewal flag, and cost. Ensures CPSC and FTC compliance for licensed content usage.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`content`.`ugc_submission` (
    `ugc_submission_id` BIGINT COMMENT 'Unique identifier for the user-generated content submission record.',
    `agent_id` BIGINT COMMENT 'Identifier of the moderator (human or system) who performed the action.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer who created the user-generated content submission.',
    `item_id` BIGINT COMMENT 'Foreign key linking to content.content_item. Business justification: UGC submissions are associated with a content item (e.g., product page); linking enables traceability.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: UGC vetting process requires linking each submission to applicable regulations before publishing. Enables UGC Regulatory Vetting report.',
    `appeal_status` STRING COMMENT 'Current status of any appeal submitted against the moderation decision.. Valid values are `none|submitted|under_review|resolved`',
    `checksum` STRING COMMENT 'Hash checksum of the content body for integrity verification.',
    `content_body` STRING COMMENT 'Raw textual content submitted by the user.',
    `content_length` STRING COMMENT 'Number of characters in the textual content body.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was first created in the system.',
    `decision_timestamp` TIMESTAMP COMMENT 'Timestamp when the final moderation decision was made.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords/tags associated with the content for search and recommendation.',
    `language_code` STRING COMMENT 'ISO 639-1 language code indicating the language of the submitted content.',
    `locale` STRING COMMENT 'Locale identifier (e.g., en_US) for regional content variations.',
    `media_asset_type` STRING COMMENT 'Type of the attached media asset.. Valid values are `image|video|audio`',
    `media_asset_url` STRING COMMENT 'Link to the associated media asset (image, video, etc.) stored in the digital asset repository.',
    `moderation_action` STRING COMMENT 'Action taken by the moderation system or human reviewer.. Valid values are `approve|reject|escalate|flag|suppress`',
    `moderation_moderator_type` STRING COMMENT 'Indicates whether the moderation was performed by a human reviewer or an automated system.. Valid values are `human|automated`',
    `moderation_rule_triggered` STRING COMMENT 'Name or code of the moderation rule that was triggered for this action.',
    `moderation_timestamp` TIMESTAMP COMMENT 'Date and time when the moderation action was recorded.',
    `publish_eligibility` STRING COMMENT 'Indicates whether the content meets criteria for publication on PDP/PLP.. Valid values are `eligible|ineligible|pending_review`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether the submission must be reported to regulatory bodies (e.g., FTC, CPSC).',
    `seo_description` STRING COMMENT 'Meta description for SEO purposes associated with the content.',
    `seo_title` STRING COMMENT 'Search engine optimized title for the content, used in PDP/PLP listings.',
    `submission_code` STRING COMMENT 'System-generated alphanumeric code that uniquely identifies the submission for external reference.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the user originally submitted the content.',
    `submission_type` STRING COMMENT 'Category of the submitted content (e.g., review, video, image, question, community post).. Valid values are `review|video|image|question|post`',
    `title` STRING COMMENT 'Short title or headline for the submitted content.',
    `ugc_submission_status` STRING COMMENT 'Current lifecycle state of the submission within the moderation workflow.. Valid values are `pending|approved|rejected|escalated|flagged|withdrawn`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the submission record.',
    `violation_category` STRING COMMENT 'Category of policy violation identified during moderation.. Valid values are `prohibited_content|ip_infringement|spam|misinformation|other`',
    CONSTRAINT pk_ugc_submission PRIMARY KEY(`ugc_submission_id`)
) COMMENT 'Captures user-generated content submissions including customer reviews with images, unboxing videos, Q&A responses, and community posts submitted for publication on PDPs and PLPs. Stores submission type, raw content body, submitted media asset references, submitter customer reference, submission timestamp, and publish eligibility. Owns the full moderation lifecycle as embedded detail records including each moderation action (approve, reject, escalate, flag, suppress), moderator identity (human or automated), moderation rule triggered, violation category (prohibited content, IP infringement, spam, misinformation), decision timestamp, appeal status, and regulatory reporting flag. SSOT for all user-generated content and its complete moderation history. Supports FTC disclosure compliance, GDPR right-to-erasure workflows, and CPSC reporting.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`content`.`moderation` (
    `moderation_id` BIGINT COMMENT 'Unique identifier for the moderation action record.',
    `agent_id` BIGINT COMMENT 'Identifier of the moderator (person or system) that performed the action.',
    `content_digital_asset_id` BIGINT COMMENT 'Identifier of the digital asset (image, video, etc.) associated with the moderated content.',
    `item_id` BIGINT COMMENT 'Identifier of the user‑generated content item that was moderated.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Moderation actions reference specific regulations (e.g., hate‑speech law). Needed for Moderation Regulatory Reporting process.',
    `action_type` STRING COMMENT 'Type of moderation action taken on the content.. Valid values are `approve|reject|escalate|flag|suppress`',
    `appeal_status` STRING COMMENT 'Current status of any appeal submitted against the moderation decision.. Valid values are `none|pending|resolved|rejected`',
    `confidence_score` DECIMAL(18,2) COMMENT 'Confidence level (0‑100) of the automated moderation decision, if applicable.',
    `country_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 code of the country associated with the content or user.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the moderation record was first created in the system.',
    `decision_timestamp` TIMESTAMP COMMENT 'Timestamp when the moderation decision was recorded.',
    `is_escalated` BOOLEAN COMMENT 'True if the moderation action was escalated to a higher‑level reviewer.',
    `is_suppressed` BOOLEAN COMMENT 'True if the content was suppressed from public view after moderation.',
    `language_code` STRING COMMENT 'ISO 639‑1 two‑letter code representing the language of the moderated content.. Valid values are `^[a-z]{2}$`',
    `moderation_code` STRING COMMENT 'Business identifier or code for the moderation action, used for external reference.',
    `moderation_status` STRING COMMENT 'Current lifecycle status of the moderation record.. Valid values are `pending|in_review|completed|closed|reopened`',
    `moderator_type` STRING COMMENT 'Indicates whether the moderation was performed by a human reviewer or an automated system.. Valid values are `human|automated`',
    `notes` STRING COMMENT 'Free‑form notes entered by the moderator providing context or rationale.',
    `regulatory_flag` BOOLEAN COMMENT 'Indicates whether the moderation action must be reported for regulatory compliance (e.g., GDPR, FTC).',
    `rule_triggered` STRING COMMENT 'Name or code of the moderation rule that was triggered for this action.',
    `source_channel` STRING COMMENT 'Channel through which the moderation request originated.. Valid values are `web|mobile|api|admin`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the moderation record.',
    `version_number` STRING COMMENT 'Version of the moderation record, incremented on each update.',
    `violation_category` STRING COMMENT 'Category of policy violation identified by the moderation.. Valid values are `prohibited_content|ip_infringement|spam|misinformation|other`',
    CONSTRAINT pk_moderation PRIMARY KEY(`moderation_id`)
) COMMENT 'Operational record of each moderation action taken on a UGC submission, content item, or digital asset. Stores moderation action type (approve, reject, escalate, flag, suppress), moderator identity (human or automated), moderation rule triggered, violation category (prohibited content, IP infringement, spam, misinformation), decision timestamp, appeal status, and regulatory reporting flag. Supports GDPR right-to-erasure workflows and FTC compliance.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`content`.`performance` (
    `performance_id` BIGINT COMMENT 'Unique surrogate key for each content performance record.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: Enables channel‑level KPI reporting (impressions, clicks, revenue) by linking performance rows to the marketing channel definition.',
    `content_digital_asset_id` BIGINT COMMENT 'Identifier of the associated digital asset (image, video, etc.) if the metric relates to an asset.',
    `experiment_id` BIGINT COMMENT 'Identifier of the A/B test experiment linked to this performance snapshot.',
    `item_id` BIGINT COMMENT 'Identifier of the content item (article, page, or editorial block) whose performance is being recorded.',
    `prior_period_performance_id` BIGINT COMMENT 'Self-referencing FK on performance (prior_period_performance_id)',
    `ab_test_variant` STRING COMMENT 'Name or code of the A/B test variant presented to the user.',
    `ab_test_winning` BOOLEAN COMMENT 'True if the variant is the statistically winning variant for the experiment.',
    `audience_segment` STRING COMMENT 'Segment identifier used for targeting the content (e.g., new‑visitor, high‑value‑customer).',
    `bounce_rate` DOUBLE COMMENT 'Percentage of sessions where users left after a single view of the content.',
    `clicks` BIGINT COMMENT 'Number of user clicks on the content or associated asset.',
    `confidence_score` DOUBLE COMMENT 'Model‑generated confidence level for the metric (0‑1).',
    `content_quality_score` DOUBLE COMMENT 'Composite score evaluating content relevance, readability, and compliance.',
    `conversion_count` BIGINT COMMENT 'Number of conversion events (e.g., add‑to‑cart, purchase) attributed to the content.',
    `conversion_rate` DOUBLE COMMENT 'Ratio of conversions to impressions (conversion_count ÷ impressions).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance record was first inserted.',
    `ctr` DOUBLE COMMENT 'Ratio of clicks to impressions (clicks ÷ impressions). Stored as a raw measurement captured by the analytics engine.',
    `engagement_seconds` DOUBLE COMMENT 'Total time (in seconds) users spent interacting with the content.',
    `impressions` BIGINT COMMENT 'Number of times the content was displayed to users.',
    `is_control_group` BOOLEAN COMMENT 'True if the user was exposed to the control (baseline) variant.',
    `is_deleted` BOOLEAN COMMENT 'True if the record has been logically deleted.',
    `lift_percentage` DOUBLE COMMENT 'Percentage lift of the winning variant over the control.',
    `locale` STRING COMMENT 'Locale of the content view in language‑country format (e.g., en-US).. Valid values are `^[a-z]{2}-[A-Z]{2}$`',
    `metric_date` DATE COMMENT 'Calendar date (day granularity) for the performance snapshot.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the performance record.',
    `revenue_influence_usd` DECIMAL(18,2) COMMENT 'Estimated revenue (in US dollars) driven by the content, as calculated by the attribution model.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'Exact time when the performance measurement was captured.',
    `source_system` STRING COMMENT 'Name of the upstream system that generated the metric (e.g., Search Engine, CMS, Marketing Automation).',
    `statistical_significance` BOOLEAN COMMENT 'True when the observed lift meets the pre‑defined significance threshold.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the performance record.',
    `version_number` STRING COMMENT 'Version of the performance snapshot schema for backward‑compatibility tracking.',
    CONSTRAINT pk_performance PRIMARY KEY(`performance_id`)
) COMMENT 'Tracks content effectiveness metrics and engagement analytics per content item, digital asset, and A/B test experiment. Stores impressions, click-through rate (CTR), engagement time, bounce rate, conversion attribution, revenue influence, A/B test result outcomes (winning variant, statistical significance, lift percentage), content quality scores, and time-series performance snapshots by date granularity. Enables content ROI reporting, editorial optimization prioritization, underperforming content identification, and data-driven content investment decisions. SSOT for all content analytics and effectiveness measurement.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`content`.`kpi_assignment` (
    `kpi_assignment_id` BIGINT COMMENT 'Primary key for the kpi_assignment association',
    `item_id` BIGINT COMMENT 'Foreign key linking to the content item',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to the KPI definition',
    `ceiling_threshold` DECIMAL(18,2) COMMENT 'Maximum acceptable KPI value',
    `end_date` DATE COMMENT 'Date when the KPI target expires or is superseded',
    `floor_threshold` DECIMAL(18,2) COMMENT 'Minimum acceptable KPI value',
    `start_date` DATE COMMENT 'Date when the KPI target becomes effective for the content item',
    `stretch_target_value` DECIMAL(18,2) COMMENT 'Stretch (higher) target value for the KPI',
    `target_owner_reference` BIGINT COMMENT 'Identifier of the owner responsible for this KPI target',
    `target_value` DECIMAL(18,2) COMMENT 'Primary KPI target value for the content item',
    CONSTRAINT pk_kpi_assignment PRIMARY KEY(`kpi_assignment_id`)
) COMMENT 'Associates a content_item with a kpi_definition and stores the target values, thresholds, ownership, and effective dates for that specific pairing. Each record represents the business-managed KPI target for a particular piece of content.. Existence Justification: Content teams define KPI targets for each content item (e.g., page views, conversion rate). A single KPI definition can be applied to many content items, and each content item can have multiple KPI definitions. The association stores target values, thresholds, ownership, and effective dates, which are managed as a distinct business object.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`content`.`personalization_rule` (
    `personalization_rule_id` BIGINT COMMENT 'Primary key for personalization_rule',
    `audience_segment_id` BIGINT COMMENT 'Reference to the audience segment definition used by the rule.',
    `overrides_personalization_rule_id` BIGINT COMMENT 'Self-referencing FK on personalization_rule (overrides_personalization_rule_id)',
    `action_payload` STRING COMMENT 'JSON or key‑value payload that supplies parameters for the selected action type.',
    `action_type` STRING COMMENT 'Type of action the rule triggers (e.g., recommendation, banner, email, push notification, discount).',
    `condition_expression` STRING COMMENT 'Serialized logical expression (e.g., JSON or DSL) that defines when the rule fires.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the rule record was first created in the system.',
    `personalization_rule_description` STRING COMMENT 'Detailed free‑text description of rule purpose and logic.',
    `effective_from` DATE COMMENT 'Date when the rule becomes active for evaluation.',
    `effective_until` DATE COMMENT 'Date when the rule expires; null indicates no planned end date.',
    `is_experimental` BOOLEAN COMMENT 'Indicates whether the rule is in experimental mode and not yet fully rolled out.',
    `priority` STRING COMMENT 'Integer priority determining rule evaluation order; lower numbers run first.',
    `rule_approval_status` STRING COMMENT 'Governance status indicating whether the rule has been approved for production.',
    `rule_audience_criteria` STRING COMMENT 'Serialized criteria (e.g., JSON) defining the audience beyond simple segment ID.',
    `rule_capping_type` STRING COMMENT 'Granularity of the frequency cap.',
    `rule_capping_value` STRING COMMENT 'Numeric value associated with the capping type.',
    `rule_category` STRING COMMENT 'Broad business category the rule belongs to.',
    `rule_code` STRING COMMENT 'Compact alphanumeric code that uniquely identifies the rule across systems.',
    `rule_confidence_score` DECIMAL(18,2) COMMENT 'Statistical confidence (0‑100) of the rules predicted impact.',
    `rule_created_by` STRING COMMENT 'User or system that created the rule record.',
    `rule_effective_time_zone` STRING COMMENT 'Time zone used for interpreting effective_from and effective_until.',
    `rule_enabled` BOOLEAN COMMENT 'True if the rule is currently enabled for evaluation.',
    `rule_frequency_limit` STRING COMMENT 'Maximum number of times the rule may fire for a single user within the effective period.',
    `rule_last_run_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent evaluation of the rule.',
    `rule_name` STRING COMMENT 'Human‑readable name of the rule used in UI and reporting.',
    `rule_notes` STRING COMMENT 'Free‑form notes or comments about the rule.',
    `rule_owner` STRING COMMENT 'Team or individual responsible for the rules lifecycle.',
    `rule_scope` STRING COMMENT 'Geographic or logical scope where the rule applies.',
    `rule_status_reason` STRING COMMENT 'Free‑text reason explaining the current status (e.g., why a rule is inactive).',
    `rule_tags` STRING COMMENT 'Comma‑separated list of user‑defined tags for categorization.',
    `rule_target_channel` STRING COMMENT 'Delivery channel(s) the rule is intended for.',
    `rule_target_device` STRING COMMENT 'Device type(s) the rule targets.',
    `rule_target_locale` STRING COMMENT 'Locale (language‑region) the rule applies to, e.g., en_US.',
    `rule_target_market` STRING COMMENT 'Market or country code where the rule is active.',
    `rule_test_group` STRING COMMENT 'Identifier of the A/B test group the rule belongs to, if applicable.',
    `rule_type` STRING COMMENT 'Category of rule logic (e.g., segment‑based, behavior‑based, contextual, or A/B test).',
    `rule_updated_by` STRING COMMENT 'User or system that performed the latest update.',
    `rule_version_number` STRING COMMENT 'Alternative version tracking field; mirrors version.',
    `source_system` STRING COMMENT 'Name of the upstream system or service that authored the rule.',
    `personalization_rule_status` STRING COMMENT 'Current lifecycle state of the rule.',
    `target_audience` STRING COMMENT 'High‑level description of the user segment or context the rule targets.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the rule.',
    `version` STRING COMMENT 'Incremental version number of the rule definition.',
    CONSTRAINT pk_personalization_rule PRIMARY KEY(`personalization_rule_id`)
) COMMENT 'Master reference table for personalization_rule. Referenced by personalization_rule_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ADD CONSTRAINT `fk_content_content_digital_asset_rights_license_id` FOREIGN KEY (`rights_license_id`) REFERENCES `ecommerce_ecm`.`content`.`rights_license`(`rights_license_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ADD CONSTRAINT `fk_content_asset_version_content_ab_test_id` FOREIGN KEY (`content_ab_test_id`) REFERENCES `ecommerce_ecm`.`content`.`content_ab_test`(`content_ab_test_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ADD CONSTRAINT `fk_content_asset_version_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`item` ADD CONSTRAINT `fk_content_item_original_content_item_id` FOREIGN KEY (`original_content_item_id`) REFERENCES `ecommerce_ecm`.`content`.`item`(`item_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_ab_test_variant_id` FOREIGN KEY (`ab_test_variant_id`) REFERENCES `ecommerce_ecm`.`content`.`ab_test_variant`(`ab_test_variant_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_item_id` FOREIGN KEY (`item_id`) REFERENCES `ecommerce_ecm`.`content`.`item`(`item_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ADD CONSTRAINT `fk_content_seo_metadata_item_id` FOREIGN KEY (`item_id`) REFERENCES `ecommerce_ecm`.`content`.`item`(`item_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_item_id` FOREIGN KEY (`item_id`) REFERENCES `ecommerce_ecm`.`content`.`item`(`item_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ADD CONSTRAINT `fk_content_tag_parent_tag_id` FOREIGN KEY (`parent_tag_id`) REFERENCES `ecommerce_ecm`.`content`.`tag`(`tag_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`tag_assignment` ADD CONSTRAINT `fk_content_tag_assignment_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`tag_assignment` ADD CONSTRAINT `fk_content_tag_assignment_item_id` FOREIGN KEY (`item_id`) REFERENCES `ecommerce_ecm`.`content`.`item`(`item_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`tag_assignment` ADD CONSTRAINT `fk_content_tag_assignment_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `ecommerce_ecm`.`content`.`tag`(`tag_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ADD CONSTRAINT `fk_content_publication_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ADD CONSTRAINT `fk_content_publication_item_id` FOREIGN KEY (`item_id`) REFERENCES `ecommerce_ecm`.`content`.`item`(`item_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ADD CONSTRAINT `fk_content_publication_version_id` FOREIGN KEY (`version_id`) REFERENCES `ecommerce_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ADD CONSTRAINT `fk_content_ab_test_variant_content_ab_test_id` FOREIGN KEY (`content_ab_test_id`) REFERENCES `ecommerce_ecm`.`content`.`content_ab_test`(`content_ab_test_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ADD CONSTRAINT `fk_content_ab_test_variant_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`template` ADD CONSTRAINT `fk_content_template_version_id` FOREIGN KEY (`version_id`) REFERENCES `ecommerce_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ADD CONSTRAINT `fk_content_slot_template_id` FOREIGN KEY (`template_id`) REFERENCES `ecommerce_ecm`.`content`.`template`(`template_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ADD CONSTRAINT `fk_content_slot_assignment_item_id` FOREIGN KEY (`item_id`) REFERENCES `ecommerce_ecm`.`content`.`item`(`item_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ADD CONSTRAINT `fk_content_slot_assignment_personalization_rule_id` FOREIGN KEY (`personalization_rule_id`) REFERENCES `ecommerce_ecm`.`content`.`personalization_rule`(`personalization_rule_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ADD CONSTRAINT `fk_content_slot_assignment_slot_id` FOREIGN KEY (`slot_id`) REFERENCES `ecommerce_ecm`.`content`.`slot`(`slot_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ADD CONSTRAINT `fk_content_workflow_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ADD CONSTRAINT `fk_content_workflow_item_id` FOREIGN KEY (`item_id`) REFERENCES `ecommerce_ecm`.`content`.`item`(`item_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ADD CONSTRAINT `fk_content_ugc_submission_item_id` FOREIGN KEY (`item_id`) REFERENCES `ecommerce_ecm`.`content`.`item`(`item_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ADD CONSTRAINT `fk_content_moderation_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ADD CONSTRAINT `fk_content_moderation_item_id` FOREIGN KEY (`item_id`) REFERENCES `ecommerce_ecm`.`content`.`item`(`item_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ADD CONSTRAINT `fk_content_performance_content_digital_asset_id` FOREIGN KEY (`content_digital_asset_id`) REFERENCES `ecommerce_ecm`.`content`.`content_digital_asset`(`content_digital_asset_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ADD CONSTRAINT `fk_content_performance_item_id` FOREIGN KEY (`item_id`) REFERENCES `ecommerce_ecm`.`content`.`item`(`item_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ADD CONSTRAINT `fk_content_performance_prior_period_performance_id` FOREIGN KEY (`prior_period_performance_id`) REFERENCES `ecommerce_ecm`.`content`.`performance`(`performance_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`kpi_assignment` ADD CONSTRAINT `fk_content_kpi_assignment_item_id` FOREIGN KEY (`item_id`) REFERENCES `ecommerce_ecm`.`content`.`item`(`item_id`);
ALTER TABLE `ecommerce_ecm`.`content`.`personalization_rule` ADD CONSTRAINT `fk_content_personalization_rule_overrides_personalization_rule_id` FOREIGN KEY (`overrides_personalization_rule_id`) REFERENCES `ecommerce_ecm`.`content`.`personalization_rule`(`personalization_rule_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`content` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `ecommerce_ecm`.`content` SET TAGS ('dbx_domain' = 'content');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` SET TAGS ('dbx_subdomain' = 'asset_library');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Identifier');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Asset General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `rights_license_id` SET TAGS ('dbx_business_glossary_term' = 'Rights License Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `a_b_test_name` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Name');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `a_b_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `a_b_test_variant` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `alt_text` SET TAGS ('dbx_business_glossary_term' = 'Alt Text');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_value_regex' = 'image|video|icon|banner|document');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `cache_ttl_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cache TTL (Seconds)');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `cdn_url` SET TAGS ('dbx_business_glossary_term' = 'CDN URL');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'MD5 Checksum');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `color_profile` SET TAGS ('dbx_business_glossary_term' = 'Color Profile');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `content_digital_asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `content_digital_asset_name` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Name');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `content_digital_asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `content_digital_asset_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|deleted');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration (Seconds)');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `edge_region` SET TAGS ('dbx_business_glossary_term' = 'Edge Region');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'File Name');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `height_px` SET TAGS ('dbx_business_glossary_term' = 'Height (Pixels)');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Asset Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Locale');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `mime_type` SET TAGS ('dbx_business_glossary_term' = 'MIME Type');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Resolution');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `seo_description` SET TAGS ('dbx_business_glossary_term' = 'SEO Description');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `seo_title` SET TAGS ('dbx_business_glossary_term' = 'SEO Title');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `storage_path` SET TAGS ('dbx_business_glossary_term' = 'Storage Path');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Asset Tags');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `upload_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Upload Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `version_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Version Approval Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `version_cdn_url` SET TAGS ('dbx_business_glossary_term' = 'Version CDN URL');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `version_change_type` SET TAGS ('dbx_business_glossary_term' = 'Version Change Type');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `version_change_type` SET TAGS ('dbx_value_regex' = 'crop|recolor|reformat|retranslate|metadata_update');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `version_editor` SET TAGS ('dbx_business_glossary_term' = 'Version Editor');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Status');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `version_status` SET TAGS ('dbx_value_regex' = 'draft|approved|archived');
ALTER TABLE `ecommerce_ecm`.`content`.`content_digital_asset` ALTER COLUMN `width_px` SET TAGS ('dbx_business_glossary_term' = 'Width (Pixels)');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` SET TAGS ('dbx_subdomain' = 'asset_library');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Identifier');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `content_ab_test_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Identifier');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Editor Identifier');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `asset_version_description` SET TAGS ('dbx_business_glossary_term' = 'Version Description');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `asset_version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Status');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `asset_version_status` SET TAGS ('dbx_value_regex' = 'draft|approved|archived|rejected');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `cdn_url` SET TAGS ('dbx_business_glossary_term' = 'CDN Published URL');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `cdn_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'crop|recolor|reformat|retranslate|metadata_update|other');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'MD5 Checksum');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{32}$');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `editor_name` SET TAGS ('dbx_business_glossary_term' = 'Editor Name');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiration Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'jpg|png|gif|mp4|webm|svg');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `is_a_b_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Version Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Resolution');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `version_label` SET TAGS ('dbx_business_glossary_term' = 'Version Label');
ALTER TABLE `ecommerce_ecm`.`content`.`asset_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ecommerce_ecm`.`content`.`item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`content`.`item` SET TAGS ('dbx_subdomain' = 'content_operations');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Content Item Identifier');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Author Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Content Profit Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Author Identifier');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `original_content_item_id` SET TAGS ('dbx_business_glossary_term' = 'Original Content Item Identifier');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `ab_test_variant_name` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant Name');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `compliance_legal_review` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `content_body` SET TAGS ('dbx_business_glossary_term' = 'Content Body');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `content_category` SET TAGS ('dbx_business_glossary_term' = 'Content Category');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `content_category` SET TAGS ('dbx_value_regex' = 'product|marketing|legal|support');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `content_format` SET TAGS ('dbx_business_glossary_term' = 'Content Format');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `content_format` SET TAGS ('dbx_value_regex' = 'html|markdown|plain');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `content_length_bytes` SET TAGS ('dbx_business_glossary_term' = 'Content Length (Bytes)');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `content_source` SET TAGS ('dbx_business_glossary_term' = 'Content Source');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `content_source` SET TAGS ('dbx_value_regex' = 'internal|vendor|partner');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `content_tags` SET TAGS ('dbx_business_glossary_term' = 'Content Tags');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `content_type` SET TAGS ('dbx_value_regex' = 'product_description|category_description|landing_page|article|faq');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `copyright_notice` SET TAGS ('dbx_business_glossary_term' = 'Copyright Notice');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `diff_summary` SET TAGS ('dbx_business_glossary_term' = 'Diff Summary');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiration Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `is_ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `is_localized` SET TAGS ('dbx_business_glossary_term' = 'Localization Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `item_status` SET TAGS ('dbx_business_glossary_term' = 'Content Status');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `item_status` SET TAGS ('dbx_value_regex' = 'draft|review|published|archived');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Status');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Locale Code');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `publication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Publication Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `publishing_channel` SET TAGS ('dbx_business_glossary_term' = 'Publishing Channel');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `publishing_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|email|social');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `readability_score` SET TAGS ('dbx_business_glossary_term' = 'Readability Score');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `seo_keyword_density` SET TAGS ('dbx_business_glossary_term' = 'SEO Keyword Density');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `seo_keywords` SET TAGS ('dbx_business_glossary_term' = 'SEO Keywords');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `seo_meta_description` SET TAGS ('dbx_business_glossary_term' = 'SEO Meta Description');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `seo_meta_title` SET TAGS ('dbx_business_glossary_term' = 'SEO Meta Title');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `slug` SET TAGS ('dbx_business_glossary_term' = 'Content URL Slug');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Content Title');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `version_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Version Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`item` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Word Count');
ALTER TABLE `ecommerce_ecm`.`content`.`version` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`content`.`version` SET TAGS ('dbx_subdomain' = 'content_operations');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version ID');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `ab_test_variant_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant ID');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User ID');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Content Item ID');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `approval_state` SET TAGS ('dbx_business_glossary_term' = 'Approval State (AS)');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `approval_state` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'Content Checksum (MD5)');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `checksum` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{32}$');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `content_body` SET TAGS ('dbx_business_glossary_term' = 'Content Body Text');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `content_category` SET TAGS ('dbx_business_glossary_term' = 'Content Category (CC)');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `content_category` SET TAGS ('dbx_value_regex' = 'product|brand|marketing|legal|faq|support');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `content_length` SET TAGS ('dbx_business_glossary_term' = 'Content Length (Characters)');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type (CT)');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `content_type` SET TAGS ('dbx_value_regex' = 'article|image|video|seo|description|banner');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Version Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `diff_summary` SET TAGS ('dbx_business_glossary_term' = 'Difference Summary');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `is_ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'SEO Keywords (Keyword List)');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code (ISO 639-1)');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Locale Identifier');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `publish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Publish Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `seo_description` SET TAGS ('dbx_business_glossary_term' = 'SEO Description (Search Engine Optimization Description)');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `seo_title` SET TAGS ('dbx_business_glossary_term' = 'SEO Title (Search Engine Optimization Title)');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SS)');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'pim|cms|manual|api');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Content Title');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Version Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Content Status (CS)');
ALTER TABLE `ecommerce_ecm`.`content`.`version` ALTER COLUMN `version_status` SET TAGS ('dbx_value_regex' = 'draft|active|archived|retired');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` SET TAGS ('dbx_subdomain' = 'experience_optimization');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `seo_metadata_id` SET TAGS ('dbx_business_glossary_term' = 'SEO Metadata ID');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Content Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `canonical_url` SET TAGS ('dbx_business_glossary_term' = 'Canonical URL (Canonical)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `content_hash` SET TAGS ('dbx_business_glossary_term' = 'Content Hash (Hash)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (Created)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `hreflang_tags` SET TAGS ('dbx_business_glossary_term' = 'Hreflang Tags (Tags)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `is_canonical` SET TAGS ('dbx_business_glossary_term' = 'Is Canonical (Flag)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `keyword_target` SET TAGS ('dbx_business_glossary_term' = 'Keyword Target (Keyword)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `last_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (Updated)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Locale (Locale)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `meta_description` SET TAGS ('dbx_business_glossary_term' = 'Meta Description (Description)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `open_graph_description` SET TAGS ('dbx_business_glossary_term' = 'Open Graph Description (OG Description)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `open_graph_image_url` SET TAGS ('dbx_business_glossary_term' = 'Open Graph Image URL (OG Image)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `open_graph_title` SET TAGS ('dbx_business_glossary_term' = 'Open Graph Title (OG Title)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `open_graph_type` SET TAGS ('dbx_business_glossary_term' = 'Open Graph Type (OG Type)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `page_type` SET TAGS ('dbx_business_glossary_term' = 'Page Type (Type)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `page_type` SET TAGS ('dbx_value_regex' = 'product|category|landing|blog|search|other');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `page_url` SET TAGS ('dbx_business_glossary_term' = 'Canonical URL (URL)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `robots_directive` SET TAGS ('dbx_business_glossary_term' = 'Robots Directive (Directive)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `robots_directive` SET TAGS ('dbx_value_regex' = 'index|noindex|follow|nofollow|none');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `seo_metadata_status` SET TAGS ('dbx_business_glossary_term' = 'SEO Metadata Status (Status)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `seo_metadata_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `seo_score` SET TAGS ('dbx_business_glossary_term' = 'SEO Score (Score)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `sitemap_priority` SET TAGS ('dbx_business_glossary_term' = 'Sitemap Priority (Priority)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `structured_data_json` SET TAGS ('dbx_business_glossary_term' = 'Structured Data JSON-LD (JSON-LD)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Meta Title (Title)');
ALTER TABLE `ecommerce_ecm`.`content`.`seo_metadata` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Metadata Version (Version)');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` SET TAGS ('dbx_subdomain' = 'asset_library');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `localization_id` SET TAGS ('dbx_business_glossary_term' = 'Localization ID');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Translator ID');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Source Asset ID');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Translation Supplier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `asset_alt_text` SET TAGS ('dbx_business_glossary_term' = 'Asset Alt Text');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `asset_url` SET TAGS ('dbx_business_glossary_term' = 'Asset URL');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `character_count` SET TAGS ('dbx_business_glossary_term' = 'Character Count');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `compliance_gdpr_flag` SET TAGS ('dbx_business_glossary_term' = 'GDPR Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `compliance_legal_notice` SET TAGS ('dbx_business_glossary_term' = 'Legal Notice');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `content_body` SET TAGS ('dbx_business_glossary_term' = 'Content Body');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `content_type` SET TAGS ('dbx_value_regex' = 'product_description|image_alt|video_caption|seo_metadata|email_template|legal_notice');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiration Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `is_default_locale` SET TAGS ('dbx_business_glossary_term' = 'Default Locale Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `locale_code` SET TAGS ('dbx_business_glossary_term' = 'Locale Code (BCP-47)');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `localization_status` SET TAGS ('dbx_business_glossary_term' = 'Localization Status');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `localization_status` SET TAGS ('dbx_value_regex' = 'draft|published|archived|retired');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `meta_keywords` SET TAGS ('dbx_business_glossary_term' = 'Meta Keywords');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `publish_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Publish Ready Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `publish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Publish Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `quality_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Review Notes');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (ISO 3166‑1 Alpha‑2)');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|approved|rejected');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `rtl_flag` SET TAGS ('dbx_business_glossary_term' = 'Right‑to‑Left Layout Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `seo_description` SET TAGS ('dbx_business_glossary_term' = 'SEO Description');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `seo_title` SET TAGS ('dbx_business_glossary_term' = 'SEO Title');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `source_language` SET TAGS ('dbx_business_glossary_term' = 'Source Language (BCP-47)');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `target_language` SET TAGS ('dbx_business_glossary_term' = 'Target Language (BCP-47)');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `translation_memory_reference` SET TAGS ('dbx_business_glossary_term' = 'Translation Memory ID');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `translation_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Translation Quality Score');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `translation_source` SET TAGS ('dbx_business_glossary_term' = 'Translation Source');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `translation_source` SET TAGS ('dbx_value_regex' = 'human|machine|hybrid');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ecommerce_ecm`.`content`.`localization` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Word Count');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` SET TAGS ('dbx_subdomain' = 'asset_library');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `tag_id` SET TAGS ('dbx_business_glossary_term' = 'Tag Identifier (TAG_ID)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `parent_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Tag Identifier (PARENT_TAG_ID)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tag Approval Timestamp (TAG_APPROVAL_TS)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Tag Assignment Method (TAG_ASSIGNMENT_METHOD)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'manual|auto_ml|rule_based');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `audience` SET TAGS ('dbx_business_glossary_term' = 'Tag Target Audience (TAG_AUDIENCE)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `audience` SET TAGS ('dbx_value_regex' = 'consumer|seller|internal|partner');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `color_hex` SET TAGS ('dbx_business_glossary_term' = 'Tag Color Hex Code (TAG_COLOR_HEX)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Tag Assignment Confidence Score (TAG_CONFIDENCE_SCORE)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Tag Confidentiality Level (TAG_CONFIDENTIALITY)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tag Record Creation Timestamp (TAG_CREATED_TS)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Tag Display Order (TAG_DISPLAY_ORDER)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Tag Effective From Date (TAG_EFFECTIVE_FROM)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Tag Effective Until Date (TAG_EFFECTIVE_UNTIL)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'Tag External Reference ID (TAG_EXTERNAL_REF)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `governance_status` SET TAGS ('dbx_business_glossary_term' = 'Tag Governance Status (TAG_GOVERNANCE_STATUS)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `governance_status` SET TAGS ('dbx_value_regex' = 'approved|deprecated|pending_review');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Tag Hierarchy Level (TAG_HIERARCHY_LEVEL)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `icon` SET TAGS ('dbx_business_glossary_term' = 'Tag Icon Identifier (TAG_ICON)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `image_url` SET TAGS ('dbx_business_glossary_term' = 'Tag Image URL (TAG_IMAGE_URL)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Tag Language (TAG_LANGUAGE)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Tag Last Reviewed By User (TAG_LAST_REVIEWED_BY)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tag Last Used Timestamp (TAG_LAST_USED_TS)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Tag Locale (TAG_LOCALE)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `relevance_score` SET TAGS ('dbx_business_glossary_term' = 'Tag Relevance Score (TAG_RELEVANCE_SCORE)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Tag Review Date (TAG_REVIEW_DATE)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Tag Review Status (TAG_REVIEW_STATUS)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `seo_metadata` SET TAGS ('dbx_business_glossary_term' = 'Tag SEO Metadata (TAG_SEO_METADATA)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Tag Source System (TAG_SOURCE_SYSTEM)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `synonyms` SET TAGS ('dbx_business_glossary_term' = 'Tag Synonyms (TAG_SYNONYMS)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `tag_category` SET TAGS ('dbx_business_glossary_term' = 'Tag Category (TAG_CATEGORY)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `tag_code` SET TAGS ('dbx_business_glossary_term' = 'Tag Code (TAG_CODE)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `tag_description` SET TAGS ('dbx_business_glossary_term' = 'Tag Description (TAG_DESC)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `tag_name` SET TAGS ('dbx_business_glossary_term' = 'Tag Name (TAG_NAME)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `tag_status` SET TAGS ('dbx_business_glossary_term' = 'Tag Lifecycle Status (TAG_STATUS)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `tag_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `tag_type` SET TAGS ('dbx_business_glossary_term' = 'Tag Type (TAG_TYPE)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `tag_type` SET TAGS ('dbx_value_regex' = 'topic|keyword|product_attribute|campaign|seasonal');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Tag Updated By User (TAG_UPDATED_BY)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tag Record Update Timestamp (TAG_UPDATED_TS)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Tag URL (TAG_URL)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Tag Usage Count (TAG_USAGE_COUNT)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Tag Version (TAG_VERSION)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Tag Created By User (TAG_CREATED_BY)');
ALTER TABLE `ecommerce_ecm`.`content`.`tag_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `ecommerce_ecm`.`content`.`tag_assignment` SET TAGS ('dbx_subdomain' = 'asset_library');
ALTER TABLE `ecommerce_ecm`.`content`.`tag_assignment` ALTER COLUMN `tag_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Tag Assignment Identifier');
ALTER TABLE `ecommerce_ecm`.`content`.`tag_assignment` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Identifier');
ALTER TABLE `ecommerce_ecm`.`content`.`tag_assignment` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Content Item Identifier');
ALTER TABLE `ecommerce_ecm`.`content`.`tag_assignment` ALTER COLUMN `tag_id` SET TAGS ('dbx_business_glossary_term' = 'Tag Identifier');
ALTER TABLE `ecommerce_ecm`.`content`.`tag_assignment` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Tag Assignment Active Status');
ALTER TABLE `ecommerce_ecm`.`content`.`tag_assignment` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending');
ALTER TABLE `ecommerce_ecm`.`content`.`tag_assignment` ALTER COLUMN `assigned_by_system` SET TAGS ('dbx_business_glossary_term' = 'Assigning System Name');
ALTER TABLE `ecommerce_ecm`.`content`.`tag_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Tag Assignment Method');
ALTER TABLE `ecommerce_ecm`.`content`.`tag_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'manual|auto_ml|rule_based');
ALTER TABLE `ecommerce_ecm`.`content`.`tag_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tag Assignment Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`tag_assignment` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Tag Assignment Confidence Score');
ALTER TABLE `ecommerce_ecm`.`content`.`tag_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`tag_assignment` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Soft Delete Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`tag_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tag Assignment Notes');
ALTER TABLE `ecommerce_ecm`.`content`.`tag_assignment` ALTER COLUMN `source_application` SET TAGS ('dbx_business_glossary_term' = 'Source Application Name');
ALTER TABLE `ecommerce_ecm`.`content`.`tag_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`tag_assignment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `ecommerce_ecm`.`content`.`publication` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`content`.`publication` SET TAGS ('dbx_subdomain' = 'content_operations');
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ALTER COLUMN `publication_id` SET TAGS ('dbx_business_glossary_term' = 'Publication ID');
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher User ID');
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset ID');
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Rollback Reference ID');
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Publication Event Type');
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'publish|unpublish|rollback|schedule|expire');
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiry Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ALTER COLUMN `is_rollback` SET TAGS ('dbx_business_glossary_term' = 'Is Rollback Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ALTER COLUMN `is_test_variant` SET TAGS ('dbx_business_glossary_term' = 'Is Test Variant Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Locale');
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ALTER COLUMN `locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}-[A-Z]{2}$');
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ALTER COLUMN `publication_status` SET TAGS ('dbx_business_glossary_term' = 'Publication Status');
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ALTER COLUMN `publication_status` SET TAGS ('dbx_value_regex' = 'published|unpublished|scheduled|expired|failed');
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ALTER COLUMN `scheduled_publish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Publish Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`publication` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` SET TAGS ('dbx_subdomain' = 'experience_optimization');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `ab_test_variant_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant ID');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `content_ab_test_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test ID (ATID)');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID (CAID)');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `ab_test_variant_code` SET TAGS ('dbx_business_glossary_term' = 'Variant Code (VC)');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `ab_test_variant_name` SET TAGS ('dbx_business_glossary_term' = 'Variant Name (VN)');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `ab_test_variant_status` SET TAGS ('dbx_business_glossary_term' = 'Variant Status (VS)');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `ab_test_variant_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|completed|archived');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `ab_test_variant_type` SET TAGS ('dbx_business_glossary_term' = 'Variant Type (VT)');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `ab_test_variant_type` SET TAGS ('dbx_value_regex' = 'control|treatment|multivariate');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (CC)');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Variant End Date (VED)');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `hypothesis` SET TAGS ('dbx_business_glossary_term' = 'Test Hypothesis (TH)');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `is_multivariate` SET TAGS ('dbx_business_glossary_term' = 'Is Multivariate Flag (IMF)');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code (LC)');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By (LMB)');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Variant Priority (VP)');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Variant Start Date (VSD)');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `target_audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment (TAS)');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `traffic_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Traffic Allocation Percentage (TAP)');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `variant_description` SET TAGS ('dbx_business_glossary_term' = 'Variant Description (VD)');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VN)');
ALTER TABLE `ecommerce_ecm`.`content`.`ab_test_variant` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (CB)');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` SET TAGS ('dbx_subdomain' = 'experience_optimization');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `content_ab_test_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test ID');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `content_ab_test_name` SET TAGS ('dbx_business_glossary_term' = 'Experiment Name');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `content_ab_test_status` SET TAGS ('dbx_business_glossary_term' = 'Experiment Status');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `content_ab_test_status` SET TAGS ('dbx_value_regex' = 'draft|running|concluded|archived');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Experiment Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Experiment End Date');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `experiment_code` SET TAGS ('dbx_business_glossary_term' = 'Experiment Code');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `hypothesis` SET TAGS ('dbx_business_glossary_term' = 'Experiment Hypothesis');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Experiment Notes');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Experiment Owner');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `primary_success_metric` SET TAGS ('dbx_business_glossary_term' = 'Primary Success Metric');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `primary_success_metric` SET TAGS ('dbx_value_regex' = 'CVR|CTR|AOV');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `randomization_seed` SET TAGS ('dbx_business_glossary_term' = 'Randomization Seed');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Experiment Start Date');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `statistical_significance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Statistical Significance Threshold');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `target_page_type` SET TAGS ('dbx_business_glossary_term' = 'Target Page Type');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `target_page_type` SET TAGS ('dbx_value_regex' = 'PDP|PLP|homepage|checkout');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'A/B|MVT|bandit');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `traffic_allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Traffic Allocation Percentage');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Experiment Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `variant_count` SET TAGS ('dbx_business_glossary_term' = 'Variant Count');
ALTER TABLE `ecommerce_ecm`.`content`.`content_ab_test` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Experiment Version');
ALTER TABLE `ecommerce_ecm`.`content`.`template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`content`.`template` SET TAGS ('dbx_subdomain' = 'content_operations');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Template Identifier');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Version ID');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_value_regex' = 'control|variant_a|variant_b');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `average_load_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Average Load Time (ms)');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `compliance_tag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Tag');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `custom_css` SET TAGS ('dbx_business_glossary_term' = 'Custom CSS');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `custom_js` SET TAGS ('dbx_business_glossary_term' = 'Custom JavaScript');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `governance_status` SET TAGS ('dbx_business_glossary_term' = 'Governance Status');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `governance_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `is_archived` SET TAGS ('dbx_business_glossary_term' = 'Is Archived');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Template');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `last_editor_name` SET TAGS ('dbx_business_glossary_term' = 'Last Editor Name');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `last_published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Published Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `layout_schema` SET TAGS ('dbx_business_glossary_term' = 'Layout Schema');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `locale_default` SET TAGS ('dbx_business_glossary_term' = 'Default Locale');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `max_height_px` SET TAGS ('dbx_business_glossary_term' = 'Maximum Height (px)');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `max_width_px` SET TAGS ('dbx_business_glossary_term' = 'Maximum Width (px)');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `optional_slots` SET TAGS ('dbx_business_glossary_term' = 'Optional Content Slots');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `preview_image_url` SET TAGS ('dbx_business_glossary_term' = 'Preview Image URL');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `required_slots` SET TAGS ('dbx_business_glossary_term' = 'Required Content Slots');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `responsive` SET TAGS ('dbx_business_glossary_term' = 'Responsive Design Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `seo_description` SET TAGS ('dbx_business_glossary_term' = 'SEO Description');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `seo_title` SET TAGS ('dbx_business_glossary_term' = 'SEO Title');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `supported_locales` SET TAGS ('dbx_business_glossary_term' = 'Supported Locales');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Template Tags');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `template_category` SET TAGS ('dbx_business_glossary_term' = 'Template Category');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `template_category` SET TAGS ('dbx_value_regex' = 'product|category|email|banner|landing');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `template_description` SET TAGS ('dbx_business_glossary_term' = 'Template Description');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `template_status` SET TAGS ('dbx_business_glossary_term' = 'Template Status');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `template_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|archived|deprecated');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `template_type` SET TAGS ('dbx_business_glossary_term' = 'Template Type');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `template_type` SET TAGS ('dbx_value_regex' = 'pdp|plp|landing|email|banner');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail URL');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Template Usage Count');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `version_notes` SET TAGS ('dbx_business_glossary_term' = 'Version Notes');
ALTER TABLE `ecommerce_ecm`.`content`.`template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Template Version Number');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` SET TAGS ('dbx_subdomain' = 'content_operations');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `slot_id` SET TAGS ('dbx_business_glossary_term' = 'Slot Identifier');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `template_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `a_b_test_variant_name` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant Name');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `allowed_asset_types` SET TAGS ('dbx_business_glossary_term' = 'Allowed Asset Types');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `allowed_asset_types` SET TAGS ('dbx_value_regex' = 'image|video|html|text|json');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `assignment_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Assignment Rule Code');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile|app|email|social');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `content_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Content Assignment Status');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `content_assignment_status` SET TAGS ('dbx_value_regex' = 'assigned|unassigned|scheduled|expired');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Slot Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `display_priority` SET TAGS ('dbx_business_glossary_term' = 'Display Priority');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `is_a_b_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Locale Code');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `max_content_items` SET TAGS ('dbx_business_glossary_term' = 'Maximum Content Items');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `page_location` SET TAGS ('dbx_business_glossary_term' = 'Page Location');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `personalization_eligible` SET TAGS ('dbx_business_glossary_term' = 'Personalization Eligibility Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `schedule_end` SET TAGS ('dbx_business_glossary_term' = 'Slot Schedule End Date');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `schedule_start` SET TAGS ('dbx_business_glossary_term' = 'Slot Schedule Start Date');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `seo_metadata` SET TAGS ('dbx_business_glossary_term' = 'SEO Metadata');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `slot_code` SET TAGS ('dbx_business_glossary_term' = 'Slot Code');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `slot_description` SET TAGS ('dbx_business_glossary_term' = 'Slot Description');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `slot_name` SET TAGS ('dbx_business_glossary_term' = 'Slot Name');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `slot_status` SET TAGS ('dbx_business_glossary_term' = 'Slot Lifecycle Status');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `slot_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|draft|pending');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `slot_type` SET TAGS ('dbx_business_glossary_term' = 'Slot Type');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `slot_type` SET TAGS ('dbx_value_regex' = 'hero|carousel|sidebar|footer|inline');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Slot Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`slot` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Slot Version Number');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` SET TAGS ('dbx_subdomain' = 'content_operations');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ALTER COLUMN `slot_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Slot Assignment ID');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ALTER COLUMN `personalization_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Personalization Rule ID');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ALTER COLUMN `slot_id` SET TAGS ('dbx_business_glossary_term' = 'Slot ID');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ALTER COLUMN `assignment_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'manual|automated|rule_based');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ALTER COLUMN `assignment_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile|app|api');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Is Deleted');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Locale');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ALTER COLUMN `locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ALTER COLUMN `slot_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ALTER COLUMN `slot_assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|archived');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ALTER COLUMN `source_application` SET TAGS ('dbx_business_glossary_term' = 'Source Application');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`slot_assignment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` SET TAGS ('dbx_subdomain' = 'content_operations');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Workflow Identifier');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Identifier');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Content Identifier');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `workflow_assigned_by_user_agent_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By User Identifier');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `workflow_assigned_by_user_agent_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `workflow_assigned_by_user_agent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `actual_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (Seconds)');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `assigned_by_system` SET TAGS ('dbx_business_glossary_term' = 'Assigned By System');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'manual|auto|rule_based');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Workflow Comments');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Workflow Completion Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Assignment Confidence Score');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Workflow Due Date');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `escalation_status` SET TAGS ('dbx_business_glossary_term' = 'Escalation Status');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `escalation_status` SET TAGS ('dbx_value_regex' = 'none|escalated|resolved');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `estimated_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (Seconds)');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Workflow Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Soft Delete Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `last_stage` SET TAGS ('dbx_business_glossary_term' = 'Last Stage Name');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Locale');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Workflow Priority');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Indicator');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `stage_sequence` SET TAGS ('dbx_business_glossary_term' = 'Stage Sequence Number');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `stage_transition_history` SET TAGS ('dbx_business_glossary_term' = 'Stage Transition History');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `workflow_category` SET TAGS ('dbx_business_glossary_term' = 'Workflow Category');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `workflow_category` SET TAGS ('dbx_value_regex' = 'editorial|legal|marketing|technical');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `workflow_code` SET TAGS ('dbx_business_glossary_term' = 'Workflow Code');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Workflow Status');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `workflow_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|rejected|completed|archived');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `workflow_type` SET TAGS ('dbx_business_glossary_term' = 'Workflow Type');
ALTER TABLE `ecommerce_ecm`.`content`.`workflow` ALTER COLUMN `workflow_type` SET TAGS ('dbx_value_regex' = 'create|update|translate|retire');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` SET TAGS ('dbx_subdomain' = 'asset_library');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `rights_license_id` SET TAGS ('dbx_business_glossary_term' = 'Rights License ID');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'License Cost');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiry Date');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Deletion Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `license_terms_url` SET TAGS ('dbx_business_glossary_term' = 'License Terms URL');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'royalty_free|rights_managed|exclusive|ugc');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `licensor_name` SET TAGS ('dbx_business_glossary_term' = 'Licensor Name');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'License Notes');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `renewal_cost` SET TAGS ('dbx_business_glossary_term' = 'Renewal Cost');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `rights_license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `rights_license_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|revoked|pending');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'License Start Date');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `territory` SET TAGS ('dbx_business_glossary_term' = 'Licensed Territory');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `usage_scope` SET TAGS ('dbx_business_glossary_term' = 'Usage Scope');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `usage_scope` SET TAGS ('dbx_value_regex' = 'web|print|social|mobile|tv|audio');
ALTER TABLE `ecommerce_ecm`.`content`.`rights_license` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` SET TAGS ('dbx_subdomain' = 'experience_optimization');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `ugc_submission_id` SET TAGS ('dbx_business_glossary_term' = 'User-Generated Content Submission ID');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Moderator ID');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Submitter Customer ID');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Content Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'none|submitted|under_review|resolved');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'Content Checksum');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `content_body` SET TAGS ('dbx_business_glossary_term' = 'Content Body');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `content_length` SET TAGS ('dbx_business_glossary_term' = 'Content Length (Characters)');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Content Keywords');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Locale');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `media_asset_type` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Type');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `media_asset_type` SET TAGS ('dbx_value_regex' = 'image|video|audio');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `media_asset_url` SET TAGS ('dbx_business_glossary_term' = 'Media Asset URL');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `moderation_action` SET TAGS ('dbx_business_glossary_term' = 'Moderation Action');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `moderation_action` SET TAGS ('dbx_value_regex' = 'approve|reject|escalate|flag|suppress');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `moderation_moderator_type` SET TAGS ('dbx_business_glossary_term' = 'Moderator Type');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `moderation_moderator_type` SET TAGS ('dbx_value_regex' = 'human|automated');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `moderation_rule_triggered` SET TAGS ('dbx_business_glossary_term' = 'Moderation Rule Triggered');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `moderation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Moderation Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `publish_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Publish Eligibility');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `publish_eligibility` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending_review');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `seo_description` SET TAGS ('dbx_business_glossary_term' = 'SEO Description');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `seo_title` SET TAGS ('dbx_business_glossary_term' = 'SEO Title');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `submission_code` SET TAGS ('dbx_business_glossary_term' = 'Submission Code');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'review|video|image|question|post');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Content Title');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `ugc_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `ugc_submission_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated|flagged|withdrawn');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `violation_category` SET TAGS ('dbx_business_glossary_term' = 'Violation Category');
ALTER TABLE `ecommerce_ecm`.`content`.`ugc_submission` ALTER COLUMN `violation_category` SET TAGS ('dbx_value_regex' = 'prohibited_content|ip_infringement|spam|misinformation|other');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` SET TAGS ('dbx_subdomain' = 'experience_optimization');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `moderation_id` SET TAGS ('dbx_business_glossary_term' = 'Moderation ID');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Moderator ID');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset ID');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Moderation Action Type');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'approve|reject|escalate|flag|suppress');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'none|pending|resolved|rejected');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `is_escalated` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `is_suppressed` SET TAGS ('dbx_business_glossary_term' = 'Suppression Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `moderation_code` SET TAGS ('dbx_business_glossary_term' = 'Moderation Code');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `moderation_status` SET TAGS ('dbx_business_glossary_term' = 'Moderation Status');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `moderation_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|completed|closed|reopened');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `moderator_type` SET TAGS ('dbx_business_glossary_term' = 'Moderator Type');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `moderator_type` SET TAGS ('dbx_value_regex' = 'human|automated');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Moderation Notes');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `regulatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `rule_triggered` SET TAGS ('dbx_business_glossary_term' = 'Moderation Rule Triggered');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|api|admin');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `violation_category` SET TAGS ('dbx_business_glossary_term' = 'Violation Category');
ALTER TABLE `ecommerce_ecm`.`content`.`moderation` ALTER COLUMN `violation_category` SET TAGS ('dbx_value_regex' = 'prohibited_content|ip_infringement|spam|misinformation|other');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` SET TAGS ('dbx_subdomain' = 'experience_optimization');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `performance_id` SET TAGS ('dbx_business_glossary_term' = 'Performance ID');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset ID');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Experiment ID');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `prior_period_performance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `ab_test_winning` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Winning Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `bounce_rate` SET TAGS ('dbx_business_glossary_term' = 'Bounce Rate');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `clicks` SET TAGS ('dbx_business_glossary_term' = 'Clicks Count');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `content_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Content Quality Score');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `conversion_count` SET TAGS ('dbx_business_glossary_term' = 'Conversion Count');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `ctr` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Rate (CTR)');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `engagement_seconds` SET TAGS ('dbx_business_glossary_term' = 'Engagement Time (seconds)');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `impressions` SET TAGS ('dbx_business_glossary_term' = 'Impressions Count');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `is_control_group` SET TAGS ('dbx_business_glossary_term' = 'Control Group Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Soft Delete Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `lift_percentage` SET TAGS ('dbx_business_glossary_term' = 'Lift Percentage');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Locale Code');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}-[A-Z]{2}$');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `metric_date` SET TAGS ('dbx_business_glossary_term' = 'Metric Date');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `revenue_influence_usd` SET TAGS ('dbx_business_glossary_term' = 'Revenue Influence (USD)');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `statistical_significance` SET TAGS ('dbx_business_glossary_term' = 'Statistical Significance Flag');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`content`.`performance` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ecommerce_ecm`.`content`.`kpi_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `ecommerce_ecm`.`content`.`kpi_assignment` SET TAGS ('dbx_subdomain' = 'experience_optimization');
ALTER TABLE `ecommerce_ecm`.`content`.`kpi_assignment` SET TAGS ('dbx_association_edges' = 'content.content_item,analytics.kpi_definition');
ALTER TABLE `ecommerce_ecm`.`content`.`kpi_assignment` ALTER COLUMN `kpi_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Assignment - Kpi Assignment Id');
ALTER TABLE `ecommerce_ecm`.`content`.`kpi_assignment` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Assignment - Content Item Id');
ALTER TABLE `ecommerce_ecm`.`content`.`kpi_assignment` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Assignment - Kpi Definition Id');
ALTER TABLE `ecommerce_ecm`.`content`.`kpi_assignment` ALTER COLUMN `ceiling_threshold` SET TAGS ('dbx_business_glossary_term' = 'Ceiling Threshold');
ALTER TABLE `ecommerce_ecm`.`content`.`kpi_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`content`.`kpi_assignment` ALTER COLUMN `floor_threshold` SET TAGS ('dbx_business_glossary_term' = 'Floor Threshold');
ALTER TABLE `ecommerce_ecm`.`content`.`kpi_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`content`.`kpi_assignment` ALTER COLUMN `stretch_target_value` SET TAGS ('dbx_business_glossary_term' = 'Stretch Target');
ALTER TABLE `ecommerce_ecm`.`content`.`kpi_assignment` ALTER COLUMN `target_owner_reference` SET TAGS ('dbx_business_glossary_term' = 'Target Owner');
ALTER TABLE `ecommerce_ecm`.`content`.`kpi_assignment` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `ecommerce_ecm`.`content`.`personalization_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`content`.`personalization_rule` SET TAGS ('dbx_subdomain' = 'experience_optimization');
ALTER TABLE `ecommerce_ecm`.`content`.`personalization_rule` ALTER COLUMN `personalization_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Personalization Rule Identifier');
ALTER TABLE `ecommerce_ecm`.`content`.`personalization_rule` ALTER COLUMN `overrides_personalization_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
