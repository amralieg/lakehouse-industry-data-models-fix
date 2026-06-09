-- Schema for Domain: search | Business: Ecommerce | Version: v1_ecm
-- Generated on: 2026-05-04 23:24:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`search` COMMENT 'Manages product search indexing, query processing, personalization algorithms, recommendation engines, and search relevance optimization. Owns search configuration, A/B testing of search results, and behavioral signals for ranking.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`index` (
    `index_id` BIGINT COMMENT 'Unique surrogate key for each search index configuration.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Required for price‑aware search ranking; each index uses a specific price list to display correct regional prices and generate the Price‑List Performance report.',
    `relevance_config_id` BIGINT COMMENT 'Foreign key linking to search.relevance_config. Business justification: An index uses a single relevance configuration; moving relevance settings to relevance_config eliminates duplication and creates a clear parent‑child relationship.',
    `superseded_index_id` BIGINT COMMENT 'Self-referencing FK on index (superseded_index_id)',
    `analyzer` STRING COMMENT 'Name of the text analyzer used (standard or custom).. Valid values are `standard|custom`',
    `build_status` STRING COMMENT 'Current status of the most recent index build operation.. Valid values are `pending|in_progress|completed|failed`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the index record was created.',
    `document_count` BIGINT COMMENT 'Total number of documents currently indexed.',
    `index_code` STRING COMMENT 'System‑generated unique code for the index, often used in API calls.',
    `index_description` STRING COMMENT 'Free‑form description of the index purpose and scope.',
    `index_name` STRING COMMENT 'Human‑readable name of the index used in UI and reporting.',
    `index_status` STRING COMMENT 'Current operational state of the index.. Valid values are `active|inactive|archived|building|failed`',
    `index_type` STRING COMMENT 'Category of assets the index serves (e.g., product catalog, content pages, seller profiles, or category taxonomy).. Valid values are `product|content|seller|category`',
    `is_default` BOOLEAN COMMENT 'Indicates whether this index is the default for its type.',
    `is_public` BOOLEAN COMMENT 'Indicates whether the index is exposed to public search APIs.',
    `language` STRING COMMENT 'ISO 639‑1 two‑letter language code for the indexed content.. Valid values are `^[a-z]{2}$`',
    `last_build_timestamp` TIMESTAMP COMMENT 'Date‑time when the index was last successfully built.',
    `locale` STRING COMMENT 'Locale identifier combining language and region (e.g., en_US).. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `max_result_window` STRING COMMENT 'Maximum number of search results that can be returned in a single query.',
    `refresh_interval_minutes` STRING COMMENT 'Scheduled interval in minutes for incremental index refreshes.',
    `retention_policy_days` STRING COMMENT 'Number of days indexed documents are retained before expiration.',
    `schema_version` STRING COMMENT 'Version of the index schema definition (e.g., v1.0, v2.3).. Valid values are `^vd+.d+$`',
    `size_mb` DECIMAL(18,2) COMMENT 'Physical storage size of the index in megabytes.',
    `source_system` STRING COMMENT 'Name of the upstream system that supplied the data for this index.',
    `stemming_enabled` BOOLEAN COMMENT 'Indicates whether stemming is applied during indexing.',
    `stop_word_list` STRING COMMENT 'Reference name of the stop‑word list applied to the index.',
    `tokenization_strategy` STRING COMMENT 'Algorithm used to split text into searchable tokens.. Valid values are `standard|whitespace|ngram|edge_ngram|custom`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the index record.',
    `created_by` STRING COMMENT 'Identifier of the user or service that created the index record.',
    CONSTRAINT pk_index PRIMARY KEY(`index_id`)
) COMMENT 'Master record defining the search index configuration for a product catalog or content corpus. Captures index name, index type (product, content, seller), schema version, language locale, tokenization strategy, stemming configuration, stop-word lists, and index build status. Serves as the authoritative registry of all active and archived search indexes powering the e-commerce platform.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`indexed_document` (
    `indexed_document_id` BIGINT COMMENT 'Unique surrogate key for each searchable document in the index.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Enables search UI carrier filter, allowing customers to select products shipped by preferred carriers; required for shipping option display and delivery time estimation.',
    `catalog_item_id` BIGINT COMMENT 'Identifier of the originating entity (product, seller listing, or content page).',
    `content_digital_asset_id` BIGINT COMMENT 'Foreign key linking to content.digital_asset. Business justification: MEDIA SEARCH: Linking assets to indexed_document enables asset‑level rights tracking and performance metrics for image/video search results.',
    `delivery_zone_id` BIGINT COMMENT 'Foreign key linking to logistics.delivery_zone. Business justification: Supports zone‑based search filtering to show products deliverable to a customer’s region and calculate zone‑specific shipping costs and SLA.',
    `index_id` BIGINT COMMENT 'Foreign key linking to search.index. Business justification: Each indexed document belongs to a specific search index; adding index_id creates the required parent‑child link.',
    `marketplace_promotion_id` BIGINT COMMENT 'Identifier of the promotion campaign applied to the document.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Regulatory tagging: each indexed product must be linked to its compliance obligation for audit and display compliance status.',
    `price_list_item_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_item. Business justification: Ensures each indexed document references its price list item for accurate price display and supports the Search‑Price Synchronization audit.',
    `seller_profile_id` BIGINT COMMENT 'Unique identifier of the seller who owns the listing.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: SKU‑LEVEL SEARCH: SKU-specific documents need a direct FK to sku.sku_id to support locale/variant indexing and inventory visibility in search results.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Needed for real‑time availability in search index; indexing pulls stock_position to populate inventory_quantity for each SKU.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Required for Supplier Catalog Search and compliance reports that filter indexed products by supplying vendor, a core e‑commerce operation.',
    `warehouse_node_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_node. Business justification: Search index may be scoped per warehouse for location‑specific availability; linking provides node metadata for indexing.',
    `previous_version_indexed_document_id` BIGINT COMMENT 'Self-referencing FK on indexed_document (previous_version_indexed_document_id)',
    `asin` STRING COMMENT '10‑character identifier used on Amazon‑style marketplaces.. Valid values are `^[A-Z0-9]{10}$`',
    `availability_status` STRING COMMENT 'Current stock availability of the item.. Valid values are `in_stock|out_of_stock|preorder|discontinued`',
    `boost_score` DECIMAL(18,2) COMMENT 'Manual boost factor applied to influence ranking.',
    `brand` STRING COMMENT 'Brand associated with the product or listing.',
    `category_path` STRING COMMENT 'Full hierarchical path of categories (e.g., Electronics>Computers>Laptops).',
    `color` STRING COMMENT 'Color variant of the product.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the document record was first created.',
    `dimension_height_cm` DECIMAL(18,2) COMMENT 'Physical height of the product in centimeters.',
    `dimension_length_cm` DECIMAL(18,2) COMMENT 'Physical length of the product in centimeters.',
    `dimension_width_cm` DECIMAL(18,2) COMMENT 'Physical width of the product in centimeters.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied to the list price.',
    `discount_price` DECIMAL(18,2) COMMENT 'Promotional price after discount, if applicable.',
    `ean` STRING COMMENT '13‑digit international product identifier.. Valid values are `^[0-9]{13}$`',
    `image_url` STRING COMMENT 'URL to the primary product image used in search results.',
    `index_timestamp` TIMESTAMP COMMENT 'Date‑time when the document was indexed.',
    `indexed_document_description` STRING COMMENT 'Full textual description used for relevance scoring.',
    `indexed_document_status` STRING COMMENT 'Current lifecycle status of the indexed document.. Valid values are `active|suppressed|pending|archived`',
    `is_promoted` BOOLEAN COMMENT 'Indicates whether the document is part of a paid promotion.',
    `keywords` STRING COMMENT 'Comma‑separated list of keywords extracted for indexing.',
    `language_code` STRING COMMENT 'Two‑letter ISO language code of the document content.. Valid values are `^[a-z]{2}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the indexed document.',
    `locale` STRING COMMENT 'Two‑letter ISO country code representing the locale.. Valid values are `^[A-Z]{2}$`',
    `material` STRING COMMENT 'Primary material composition of the product.',
    `personalization_score` DECIMAL(18,2) COMMENT 'Score reflecting personalization signals for the user segment.',
    `price_amount` DECIMAL(18,2) COMMENT 'Standard list price of the item in the catalog.',
    `price_currency` STRING COMMENT 'ISO 4217 three‑letter currency code for the price.. Valid values are `^[A-Z]{3}$`',
    `rating_average` DECIMAL(18,2) COMMENT 'Mean star rating from customer reviews.',
    `relevance_score` DECIMAL(18,2) COMMENT 'Algorithmic relevance score computed at indexing time.',
    `review_count` BIGINT COMMENT 'Total count of customer reviews for the item.',
    `seller_name` STRING COMMENT 'Display name of the seller.',
    `shipping_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the item used for shipping calculations.',
    `size` STRING COMMENT 'Size or dimension variant (e.g., Small, Medium, Large).',
    `sku` STRING COMMENT 'Internal stock keeping unit used for inventory management.',
    `source_entity_type` STRING COMMENT 'Type of source entity that the indexed document represents (e.g., SKU, seller listing, content page).. Valid values are `sku|seller_listing|content_page|category_page`',
    `thumbnail_url` STRING COMMENT 'URL to a small thumbnail version of the product image.',
    `title` STRING COMMENT 'Primary title displayed in search results.',
    `upc` STRING COMMENT '12‑digit global product identifier.. Valid values are `^[0-9]{12}$`',
    CONSTRAINT pk_indexed_document PRIMARY KEY(`indexed_document_id`)
) COMMENT 'Represents a single indexed document (SKU, catalog item, seller listing, or content page) within a search index. Captures document ID, source entity type and reference, indexed field payload (title, description, attributes, price, availability), boost score, index timestamp, and document status (active, suppressed, pending). This is the operational record of what is actually searchable on the platform at any point in time.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`query_log` (
    `query_log_id` BIGINT COMMENT 'Globally unique identifier for each query log record.',
    `ab_test_variant_id` BIGINT COMMENT 'Identifier of the A/B test variant applied to the search experience for this query.',
    `customer_profile_id` BIGINT COMMENT 'Unique identifier of the customer who issued the query.',
    `index_id` BIGINT COMMENT 'Foreign key linking to search.index. Business justification: Each query_log record is generated against a specific search index; adding index_id enables direct join to index without indirect lookup.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Search audit: queries that may retrieve regulated items need to be associated with the relevant compliance obligation for reporting.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Captures the active price list at query time for pricing‑impact analytics, required for the Pricing Effectiveness Dashboard.',
    `refined_from_query_log_id` BIGINT COMMENT 'Self-referencing FK on query_log (refined_from_query_log_id)',
    `applied_filters` STRING COMMENT 'JSON-encoded string of filter criteria applied to the search (e.g., price range, brand).',
    `device_type` STRING COMMENT 'Category of device used to submit the query.. Valid values are `mobile|desktop|tablet|bot`',
    `event_source_reference` BIGINT COMMENT 'Identifier of the search service instance or node that processed the query.',
    `event_timestamp` TIMESTAMP COMMENT 'Exact time when the search query was issued by the user or agent.',
    `event_type_or_channel` STRING COMMENT 'Category of the search interaction, e.g., standard search, autocomplete, or suggestion request.. Valid values are `search|autocomplete|suggestion`',
    `geo_city` STRING COMMENT 'City component of the client location.',
    `geo_country_code` STRING COMMENT 'Three‑letter ISO country code derived from the client IP.. Valid values are `^[A-Z]{3}$`',
    `geo_region` STRING COMMENT 'State, province, or region component of the client location.',
    `ip_address` STRING COMMENT 'IP address of the client device that issued the query.',
    `normalized_query` STRING COMMENT 'Standardized version of the query after tokenization, stemming, and case folding.',
    `platform_channel` STRING COMMENT 'Channel through which the search request was made.. Valid values are `web|mobile_app|api`',
    `query_language` STRING COMMENT 'ISO language code of the query text (e.g., en, es, fr).',
    `query_latency_ms` STRING COMMENT 'Time in milliseconds from query submission to result delivery.',
    `raw_query` STRING COMMENT 'Exact text entered by the user before any normalization or preprocessing.',
    `result_count` STRING COMMENT 'Number of search results returned for the query.',
    `search_version` STRING COMMENT 'Version identifier of the search algorithm or configuration used for this query.',
    `session_code` STRING COMMENT 'Identifier linking the query to a user session for behavioral analysis.',
    `sort_order` STRING COMMENT 'Sorting option selected for the query results.. Valid values are `relevance|price_asc|price_desc|rating|newest`',
    `user_agent` STRING COMMENT 'Browser or application user-agent header identifying client software.',
    `zero_result_flag` BOOLEAN COMMENT 'Indicates whether the query returned zero results (true) or at least one result (false).',
    CONSTRAINT pk_query_log PRIMARY KEY(`query_log_id`)
) COMMENT 'Immutable transactional record capturing every search query submitted by a user or automated agent on the platform. Stores raw query string, normalized query, session ID, customer reference, device type, platform channel, timestamp, result count returned, zero-result flag, applied filters, sort order, and query latency in milliseconds. Primary behavioral signal source for relevance tuning and personalization.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`result` (
    `result_id` BIGINT COMMENT 'Unique identifier for the search result record.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer who performed the search.',
    `indexed_document_id` BIGINT COMMENT 'Identifier of the product or content document displayed as the result.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Result filtering: each search result must reference the compliance obligation of the document to enforce compliance rules at display time.',
    `query_log_id` BIGINT COMMENT 'Unique identifier of the search query that produced this result set.',
    `previous_result_id` BIGINT COMMENT 'Self-referencing FK on result (previous_result_id)',
    `click_timestamp` TIMESTAMP COMMENT 'Timestamp when the user clicked the result (null if not clicked).',
    `clicked_flag` BOOLEAN COMMENT 'True if the user clicked on the result; otherwise false.',
    `device_type` STRING COMMENT 'Type of device used for the search (e.g., desktop, mobile, tablet).',
    `event_source` STRING COMMENT 'Identifier of the search engine instance or service that produced the result.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the search result was generated.',
    `event_type` STRING COMMENT 'Type of event, e.g., search_result or search_suggestion.',
    `location_country` STRING COMMENT 'Three‑letter ISO country code representing the users location at query time.',
    `personalization_flag` BOOLEAN COMMENT 'Indicates whether the result was personalized for the user (true) or generic (false).',
    `position` STRING COMMENT 'Ordinal position of the result within the returned result set (1‑based).',
    `query_text` STRING COMMENT 'The literal text entered by the user for the search.',
    `ranking_algorithm_version` STRING COMMENT 'Version identifier of the ranking algorithm used to produce the score.',
    `relevance_score` DECIMAL(18,2) COMMENT 'Score assigned by the ranking algorithm indicating relevance of the document to the query.',
    `search_query_category` STRING COMMENT 'High‑level category or intent classification of the query (e.g., electronics, apparel).',
    `session_code` BIGINT COMMENT 'Identifier of the user session during which the query was executed.',
    `sponsored_flag` BOOLEAN COMMENT 'True if the result is a paid/sponsored placement; otherwise false.',
    `user_agent` STRING COMMENT 'Browser or app user‑agent string identifying the client software.',
    CONSTRAINT pk_result PRIMARY KEY(`result_id`)
) COMMENT 'Transactional record capturing the ranked result set returned for a specific search query execution. Stores query log reference, result position, document reference, relevance score, ranking algorithm version, personalization flag, sponsored flag, and whether the result was clicked. Enables offline relevance evaluation, A/B test measurement, and ranking model training.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`click_event` (
    `click_event_id` BIGINT COMMENT 'Unique identifier for the click event record.',
    `customer_profile_id` BIGINT COMMENT 'Unique identifier of the customer who performed the click.',
    `experiment_id` BIGINT COMMENT 'A/B test or experiment identifier associated with the click.',
    `indexed_document_id` BIGINT COMMENT 'Identifier of the product or content document that was clicked.',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Enables Click‑to‑Purchase Conversion Tracking, a core metric in marketing dashboards linking a click event to the resulting transaction.',
    `query_log_id` BIGINT COMMENT 'Identifier linking to the originating search query record.',
    `result_id` BIGINT COMMENT 'Foreign key linking to search.result. Business justification: A click event should be linked to the specific result set it originated from for end‑to‑end traceability. Adding result_id (FK) to click_event enables direct navigation from click to result record wit',
    `previous_click_event_id` BIGINT COMMENT 'Self-referencing FK on click_event (previous_click_event_id)',
    `click_latency_ms` STRING COMMENT 'Elapsed time in milliseconds between result display and user click.',
    `click_rank_score` DOUBLE COMMENT 'Score assigned by the ranking algorithm to the clicked item at click time.',
    `click_source` STRING COMMENT 'Originating UI element or channel that generated the click.. Valid values are `search_results|category_page|homepage|email|push_notification`',
    `click_type` STRING COMMENT 'Classification of the click source (e.g., organic search, sponsored ad, recommendation widget).. Valid values are `organic|sponsored|recommendation|ad`',
    `conversion_timestamp` TIMESTAMP COMMENT 'Timestamp when the associated conversion was recorded (null if no conversion).',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the users location at click time.. Valid values are `^[A-Z]{3}$`',
    `device_type` STRING COMMENT 'Category of device used for the click.. Valid values are `desktop|mobile|tablet|smart_tv|voice_assistant`',
    `event_timestamp` TIMESTAMP COMMENT 'Exact time when the click event occurred.',
    `experiment_variant` STRING COMMENT 'Variant of the experiment shown to the user.',
    `ip_address` STRING COMMENT 'IP address of the client at click time.. Valid values are `^((25[0-5]|2[0-4]d|[01]?d?d)(.|$)){4}$`',
    `is_bot` BOOLEAN COMMENT 'True if the click is identified as generated by an automated bot.',
    `is_conversion` BOOLEAN COMMENT 'True if the click later resulted in a purchase or other conversion event.',
    `language_code` STRING COMMENT 'Two‑letter language code of the users interface.. Valid values are `^[a-z]{2}$`',
    `page_section` STRING COMMENT 'Logical section of the page where the result was displayed.. Valid values are `above_the_fold|below_the_fold|sidebar`',
    `page_url` STRING COMMENT 'URL of the page where the click occurred.',
    `personalization_flag` BOOLEAN COMMENT 'True if the result was personalized for the user.',
    `recommendation_widget_code` STRING COMMENT 'Identifier of the recommendation widget that displayed the clicked item.',
    `referrer_url` STRING COMMENT 'URL of the page that referred the user to the current result.',
    `result_position` STRING COMMENT 'Zero‑based position of the clicked item in the result list.',
    `search_query` STRING COMMENT 'The raw text entered by the user for the search.',
    `session_code` STRING COMMENT 'Identifier for the user session during which the click occurred.',
    `user_agent` STRING COMMENT 'Browser or application user‑agent string reported by the client.',
    CONSTRAINT pk_click_event PRIMARY KEY(`click_event_id`)
) COMMENT 'Transactional behavioral signal record capturing each click interaction a user makes on a search result or recommendation widget. Captures query log reference, clicked document reference, result position at time of click, click timestamp, session ID, customer reference, device type, and downstream conversion flag. Core input to click-through rate (CTR) computation and learning-to-rank (LTR) model training.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`relevance_config` (
    `relevance_config_id` BIGINT COMMENT 'Unique surrogate key for each relevance configuration record.',
    `content_ab_test_id` BIGINT COMMENT 'Identifier of the A/B test linked to this relevance configuration.',
    `superseded_relevance_config_id` BIGINT COMMENT 'Self-referencing FK on relevance_config (superseded_relevance_config_id)',
    `active_version_flag` BOOLEAN COMMENT 'Indicates whether this configuration is the currently active version for its type.',
    `bm25_b` DECIMAL(18,2) COMMENT 'BM25 length normalization factor.',
    `bm25_k1` DECIMAL(18,2) COMMENT 'BM25 term frequency scaling factor.',
    `config_code` STRING COMMENT 'Unique business code used to reference the configuration in downstream systems.',
    `config_name` STRING COMMENT 'Human‑readable name identifying the relevance configuration (e.g., "Base Search Boost").',
    `config_type` STRING COMMENT 'Category of the configuration indicating its primary purpose.. Valid values are `search|recommendation|personalization`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the configuration record was first created.',
    `effective_from` DATE COMMENT 'Date on which the configuration becomes effective for live traffic.',
    `effective_until` DATE COMMENT 'Date after which the configuration is no longer applied (null if open‑ended).',
    `enable_spellcheck` BOOLEAN COMMENT 'Flag indicating whether automatic spell‑checking is performed on user queries.',
    `enable_synonyms` BOOLEAN COMMENT 'Flag indicating whether synonym expansion is applied during query processing.',
    `field_boost_brand` DECIMAL(18,2) COMMENT 'Relative boost applied to the brand attribute in relevance calculations.',
    `field_boost_category` DECIMAL(18,2) COMMENT 'Relative boost applied to the product category field.',
    `field_boost_description` DECIMAL(18,2) COMMENT 'Relative boost applied to the product description field.',
    `field_boost_title` DECIMAL(18,2) COMMENT 'Relative boost applied to the product title field during relevance scoring.',
    `freshness_decay_days` STRING COMMENT 'Number of days after publication when freshness decay begins.',
    `freshness_decay_rate` DECIMAL(18,2) COMMENT 'Daily percentage reduction applied to relevance after the decay start.',
    `is_default` BOOLEAN COMMENT 'Flag indicating whether this configuration is the default fallback for its type.',
    `locale` STRING COMMENT 'Locale identifier (language and region) for which the configuration applies, e.g., "en_US".. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `max_results` STRING COMMENT 'Upper limit on the number of results returned for a query.',
    `min_query_length` STRING COMMENT 'Minimum number of characters required for a query to be processed.',
    `notes` STRING COMMENT 'Additional remarks, change‑log entries, or operational comments.',
    `personalization_weight` DECIMAL(18,2) COMMENT 'Weight given to personalized signals (e.g., user behavior) in the final relevance score.',
    `popularity_boost_coefficient` DECIMAL(18,2) COMMENT 'Multiplier applied based on product popularity metrics (e.g., sales velocity).',
    `ranking_algorithm` STRING COMMENT 'Algorithm used to compute relevance scores.. Valid values are `bm25|tfidf|neural`',
    `relevance_config_description` STRING COMMENT 'Free‑form text describing the purpose and scope of the configuration.',
    `relevance_config_status` STRING COMMENT 'Current lifecycle state of the configuration.. Valid values are `draft|active|inactive|archived|pending`',
    `rollout_percentage` STRING COMMENT 'Percentage of traffic exposed to this configuration during an experiment.',
    `updated_by` STRING COMMENT 'Identifier of the user or system that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the configuration.',
    `use_tfidf` BOOLEAN COMMENT 'Flag indicating whether TF‑IDF scoring is enabled instead of BM25.',
    `version_number` STRING COMMENT 'Sequential version identifier for change tracking.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the configuration.',
    CONSTRAINT pk_relevance_config PRIMARY KEY(`relevance_config_id`)
) COMMENT 'Master configuration record defining the relevance tuning parameters applied to a search index. Captures field boost weights (title, brand, category, description), BM25 or TF-IDF parameter settings, freshness decay function, popularity boost coefficients, personalization weight, and active version flag. Owned by the search team and versioned to support rollback and A/B comparison of relevance configurations.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`ranking_model` (
    `ranking_model_id` BIGINT COMMENT 'Unique surrogate key for the ranking model record.',
    `analytical_dataset_id` BIGINT COMMENT 'Identifier of the dataset used to train the model.',
    `index_id` BIGINT COMMENT 'Foreign key linking to search.index. Business justification: A ranking model is scoped to a particular index; linking via index_id avoids orphan models.',
    `experiment_id` BIGINT COMMENT 'Identifier linking the model to an experiment run.',
    `agent_id` BIGINT COMMENT 'Identifier of the data science owner or team responsible for the model.',
    `superseded_ranking_model_id` BIGINT COMMENT 'Self-referencing FK on ranking_model (superseded_ranking_model_id)',
    `artifact_location` STRING COMMENT 'URI or path to the stored model artifact (e.g., S3 bucket).',
    `champion_flag` BOOLEAN COMMENT 'Indicates if the model is the current champion in production.',
    `compliance_gdpr` BOOLEAN COMMENT 'Indicates whether the model processes personal data subject to GDPR.',
    `compliance_pci` BOOLEAN COMMENT 'Indicates whether the model handles payment card data subject to PCI DSS.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ranking model record was created in the data lake.',
    `deployment_status` STRING COMMENT 'Current deployment role of the model in production.. Valid values are `champion|challenger|inactive`',
    `evaluation_metric` STRING COMMENT 'Metric used to evaluate model performance.. Valid values are `ndcg|mrr|map`',
    `evaluation_score` DECIMAL(18,2) COMMENT 'Numeric score of the selected evaluation metric.',
    `feature_set_version` STRING COMMENT 'Version of the feature set used during training.',
    `hyperparameters` STRING COMMENT 'Serialized hyperparameter settings (JSON string).',
    `last_deployed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent deployment of the model.',
    `model_code` STRING COMMENT 'Business identifier code for the model, used in governance and reporting.',
    `model_deployment_region` STRING COMMENT 'Geographic region or cloud zone where the model is deployed.',
    `model_deprecation_date` DATE COMMENT 'Planned date when the model will be deprecated.',
    `model_framework` STRING COMMENT 'Machine learning framework used to build the model.. Valid values are `tensorflow|pytorch|xgboost|lightgbm`',
    `model_input_schema_version` STRING COMMENT 'Version of the input feature schema expected by the model.',
    `model_last_evaluation_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent model evaluation.',
    `model_latency_ms` STRING COMMENT 'Average inference latency in milliseconds.',
    `model_output_schema_version` STRING COMMENT 'Version of the output schema produced by the model.',
    `model_precision` DECIMAL(18,2) COMMENT 'Precision metric of the model on validation data.',
    `model_recall` DECIMAL(18,2) COMMENT 'Recall metric of the model on validation data.',
    `model_retirement_date` DATE COMMENT 'Planned date when the model will be retired from service.',
    `model_throughput_qps` STRING COMMENT 'Maximum queries per second the model can handle.',
    `model_training_compute` STRING COMMENT 'Specification of compute resources used for training (e.g., instance type).',
    `model_training_cost` DECIMAL(18,2) COMMENT 'Monetary cost incurred for training the model.',
    `model_type` STRING COMMENT 'Classification of the model algorithmic approach.. Valid values are `ltr|bm25|neural|hybrid`',
    `ranking_model_description` STRING COMMENT 'Detailed description of the model purpose and characteristics.',
    `ranking_model_name` STRING COMMENT 'Human‑readable name of the ranking model.',
    `ranking_model_status` STRING COMMENT 'Current lifecycle status of the model.. Valid values are `development|testing|staging|production|deprecated|retired`',
    `training_data_source` STRING COMMENT 'Source system or description of the training data origin.',
    `training_data_volume` BIGINT COMMENT 'Number of records in the training dataset.',
    `training_end_timestamp` TIMESTAMP COMMENT 'Timestamp when model training completed.',
    `training_start_timestamp` TIMESTAMP COMMENT 'Timestamp when model training started.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the ranking model record.',
    `version` STRING COMMENT 'Semantic version identifier (e.g., 1.2.3).',
    CONSTRAINT pk_ranking_model PRIMARY KEY(`ranking_model_id`)
) COMMENT 'Master record representing a trained or rule-based ranking model used to order search results. Captures model name, model type (LTR, BM25, neural, hybrid), training dataset reference, feature set version, evaluation metric (NDCG, MRR, MAP), deployment status, champion/challenger flag, and model artifact location. Enables governance of which ranking model is live in production versus in experimentation.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`experiment` (
    `experiment_id` BIGINT COMMENT 'Unique identifier for the experiment record.',
    `agent_id` BIGINT COMMENT 'Identifier of the person or team responsible for the experiment.',
    `index_id` BIGINT COMMENT 'Foreign key linking to search.index. Business justification: Experiments are run against a specific index; the FK ties the experiment to its target index.',
    `price_experiment_id` BIGINT COMMENT 'Foreign key linking to pricing.price_experiment. Business justification: Links search experiments to the corresponding price experiments, enabling the Price‑Experiment Impact report that attributes search metrics to price changes.',
    `iterated_from_experiment_id` BIGINT COMMENT 'Self-referencing FK on experiment (iterated_from_experiment_id)',
    `control_definition` STRING COMMENT 'Configuration details of the control group (baseline) for the experiment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the experiment record was first created in the system.',
    `end_date` DATE COMMENT 'Date when the experiment is scheduled to end or was concluded.',
    `experiment_code` STRING COMMENT 'Business identifier or code assigned to the experiment for tracking across systems.',
    `experiment_name` STRING COMMENT 'Human‑readable name of the experiment used in reporting and UI.',
    `experiment_scope` STRING COMMENT 'Scope of the experiment, such as global, specific product category, brand, or segment.. Valid values are `global|category|brand|segment`',
    `experiment_status` STRING COMMENT 'Current lifecycle state of the experiment.. Valid values are `draft|running|paused|completed|cancelled`',
    `experiment_type` STRING COMMENT 'Category of experiment defining the change being tested.. Valid values are `ab_test|multivariate|personalization|ranking_change`',
    `hypothesis` STRING COMMENT 'Business hypothesis being tested, expressed in plain language.',
    `is_randomized` BOOLEAN COMMENT 'Indicates whether traffic allocation to arms is performed randomly.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the experiment.',
    `platform` STRING COMMENT 'System or product area where the experiment is applied.. Valid values are `search|recommendation|ads`',
    `primary_success_metric` STRING COMMENT 'Key metric used to evaluate experiment performance (e.g., conversion_rate).',
    `start_date` DATE COMMENT 'Date when the experiment is scheduled to begin.',
    `success_metric_target` DECIMAL(18,2) COMMENT 'Target value for the primary success metric that defines experiment success.',
    `target_audience_segment` STRING COMMENT 'Identifier of the customer segment targeted by the experiment.',
    `traffic_allocation_pct` DECIMAL(18,2) COMMENT 'Percentage of total traffic directed to the treatment arm(s).',
    `treatment_definition` STRING COMMENT 'Configuration details of the treatment group(s) for the experiment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the experiment record.',
    `version` STRING COMMENT 'Version number of the experiment definition, incremented on each change.',
    CONSTRAINT pk_experiment PRIMARY KEY(`experiment_id`)
) COMMENT 'Master record for A/B and multivariate search experiments testing ranking algorithms, relevance configurations, query understanding changes, or UI treatments. Captures experiment name, hypothesis, control and treatment arm definitions, traffic allocation percentage, target audience segment, start and end dates, primary success metric, and experiment status (draft, running, concluded). Owned exclusively by the search domain.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`experiment_assignment` (
    `experiment_assignment_id` BIGINT COMMENT 'Unique identifier for the experiment assignment record.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer associated with the session.',
    `experiment_id` BIGINT COMMENT 'Identifier of the search experiment to which the assignment belongs.',
    `reassigned_from_experiment_assignment_id` BIGINT COMMENT 'Self-referencing FK on experiment_assignment (reassigned_from_experiment_assignment_id)',
    `arm` STRING COMMENT 'Arm of the experiment assigned to the session (e.g., control or treatment).. Valid values are `control|treatment`',
    `assignment_method` STRING COMMENT 'Method used to assign the user to an experiment arm.. Valid values are `cookie_hash|user_id_hash|segment_based`',
    `assignment_status` STRING COMMENT 'Current status of the assignment process.. Valid values are `assigned|failed|pending`',
    `assignment_timestamp` TIMESTAMP COMMENT 'Exact time when the experiment assignment was made.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was first created in the system.',
    `device_type` STRING COMMENT 'Type of device used in the session.. Valid values are `mobile|desktop|tablet`',
    `event_type` STRING COMMENT 'Type of event recorded (fixed value for experiment assignment).. Valid values are `search_experiment_assignment`',
    `experiment_owner` STRING COMMENT 'Team or individual responsible for the experiment.',
    `geo_country` STRING COMMENT 'Three‑letter ISO country code of the session origin. [ENUM-REF-CANDIDATE: USA|CAN|GBR|DEU|FRA|JPN|... — promote to reference product]',
    `notes` STRING COMMENT 'Free‑form notes or comments about the assignment.',
    `session_code` STRING COMMENT 'Unique identifier of the user session (e.g., cookie hash).',
    `source_channel` STRING COMMENT 'Channel through which the session originated.. Valid values are `web|app|api`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assignment record.',
    `user_agent` STRING COMMENT 'Browser or app user‑agent string for the session.',
    CONSTRAINT pk_experiment_assignment PRIMARY KEY(`experiment_assignment_id`)
) COMMENT 'Transactional record capturing the assignment of a user session or customer to a specific search experiment arm. Stores experiment reference, arm identifier (control/treatment), session ID, customer reference, assignment timestamp, and assignment method (cookie hash, user ID hash, segment-based). Enables per-user experiment attribution and prevents assignment churn across sessions.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` (
    `query_rewrite_rule_id` BIGINT COMMENT 'System-generated unique identifier for the query rewrite rule.',
    `index_id` BIGINT COMMENT 'Foreign key linking to search.index. Business justification: Query rewrite rules are defined per index; adding index_id associates the rule with its index.',
    `chained_query_rewrite_rule_id` BIGINT COMMENT 'Self-referencing FK on query_rewrite_rule (chained_query_rewrite_rule_id)',
    `case_sensitive` BOOLEAN COMMENT 'Specifies if the pattern matching should respect case.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the rule becomes active.',
    `effective_until` DATE COMMENT 'Date when the rule expires; null indicates no planned expiration.',
    `execution_count` BIGINT COMMENT 'Cumulative number of times the rule has been applied.',
    `is_regex` BOOLEAN COMMENT 'Indicates whether the trigger_pattern is a regular expression.',
    `language_locale` STRING COMMENT 'Locale code (e.g., en_US) indicating the language context for the rule.. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `last_executed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent time the rule was applied to a query.',
    `priority` STRING COMMENT 'Numeric priority determining order of rule application; lower numbers run first.',
    `query_rewrite_rule_code` STRING COMMENT 'Business identifier or short code uniquely representing the rule within the search configuration.',
    `query_rewrite_rule_description` STRING COMMENT 'Detailed free‑text description of the rules purpose and behavior.',
    `query_rewrite_rule_name` STRING COMMENT 'Human‑readable name of the rewrite rule used for display and management.',
    `query_rewrite_rule_status` STRING COMMENT 'Current lifecycle status of the rule.. Valid values are `active|inactive|deprecated|pending`',
    `replacement` STRING COMMENT 'Text or set of terms that replace or augment the trigger pattern.',
    `rule_type` STRING COMMENT 'Category of rewrite logic applied (e.g., synonym expansion, spell correction).. Valid values are `synonym|spell_correction|stemming|stopword|expansion`',
    `source_system` STRING COMMENT 'Name of the originating system or module that supplied the rule (e.g., Search Engine Config).',
    `trigger_pattern` STRING COMMENT 'Pattern or term that, when detected in a user query, activates the rewrite.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the rule.',
    `version` STRING COMMENT 'Version number of the rule for change‑management tracking.',
    CONSTRAINT pk_query_rewrite_rule PRIMARY KEY(`query_rewrite_rule_id`)
) COMMENT 'Master record defining query understanding and rewrite rules applied during query processing. Captures rule type (synonym expansion, spell correction, stemming override, stopword removal, query expansion), trigger pattern, replacement or expansion terms, language locale, priority order, active flag, and effective date range. Enables the search team to manage query normalization logic without code deployments.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`synonym_set` (
    `synonym_set_id` BIGINT COMMENT 'Unique surrogate key for each synonym set.',
    `index_id` BIGINT COMMENT 'Foreign key linking to search.index. Business justification: Synonym sets are scoped to an index; the FK links the set to its index.',
    `parent_synonym_set_id` BIGINT COMMENT 'Self-referencing FK on synonym_set (parent_synonym_set_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the synonym set record was first created.',
    `directionality` STRING COMMENT 'Indicates whether synonyms are applied in one direction only or both directions.. Valid values are `unidirectional|bidirectional`',
    `domain_context` STRING COMMENT 'Business domain or vertical to which the synonym set is scoped.. Valid values are `electronics|fashion|grocery|home|beauty|sports`',
    `is_case_sensitive` BOOLEAN COMMENT 'Indicates whether synonym matching respects character case.',
    `is_exact_match` BOOLEAN COMMENT 'If true, synonyms are applied only when the term matches exactly; otherwise partial matches are allowed.',
    `language_locale` STRING COMMENT 'ISO language and optional region code for which the synonym set applies (e.g., en-US).. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_reviewed_date` DATE COMMENT 'Date when the synonym set was last reviewed for relevance and accuracy.',
    `notes` STRING COMMENT 'Additional free‑text notes for internal stakeholders.',
    `reviewed_by` STRING COMMENT 'Identifier of the user or team that performed the last review.',
    `set_code` STRING COMMENT 'Business identifier or code for the synonym set, often used in integration payloads.',
    `set_name` STRING COMMENT 'Human‑readable name of the synonym set used for display and search configuration.',
    `source_system` STRING COMMENT 'Originating system that supplied the synonym set (e.g., Search Engine, PIM).',
    `synonym_set_description` STRING COMMENT 'Free‑form description of the purpose and usage of the synonym set.',
    `synonym_set_status` STRING COMMENT 'Current lifecycle status of the synonym set.. Valid values are `active|inactive|deprecated|pending`',
    `synonyms` STRING COMMENT 'Pipe‑delimited list of synonym terms belonging to the set.',
    `term_count` STRING COMMENT 'Number of individual terms in the synonym set.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the synonym set.',
    `version` STRING COMMENT 'Incremental version number for change management.',
    CONSTRAINT pk_synonym_set PRIMARY KEY(`synonym_set_id`)
) COMMENT 'Master record defining a named synonym group used in query expansion and index-time tokenization. Captures synonym set name, synonym terms list, directionality (unidirectional vs bidirectional), language locale, domain context (electronics, fashion, grocery), active flag, and last reviewed date. Managed by the search merchandising team to improve recall for equivalent search terms.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`facet_config` (
    `facet_config_id` BIGINT COMMENT 'Unique identifier for the facet configuration record.',
    `index_id` BIGINT COMMENT 'Foreign key linking to search.index. Business justification: Facet configurations belong to a specific index; the FK creates the parent relationship.',
    `parent_facet_config_id` BIGINT COMMENT 'Self-referencing FK on facet_config (parent_facet_config_id)',
    `applicable_category` STRING COMMENT 'Product category (e.g., electronics, apparel) where the facet is active.',
    `applicable_index` STRING COMMENT 'Name of the search index or collection to which the facet applies.',
    `audit_created_by` STRING COMMENT 'User identifier recorded for audit trail of creation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the facet configuration record was first created.',
    `display_order` STRING COMMENT 'Ordinal position of the facet in the filter panel.',
    `display_style` STRING COMMENT 'UI presentation style for the facet.. Valid values are `dropdown|list|slider|swatch`',
    `effective_from` DATE COMMENT 'Date when the facet configuration becomes active.',
    `effective_until` DATE COMMENT 'Date when the facet configuration expires (null if indefinite).',
    `facet_config_description` STRING COMMENT 'Free‑form description of the facet purpose and usage.',
    `facet_config_name` STRING COMMENT 'Human‑readable name shown to users for the facet.',
    `facet_config_status` STRING COMMENT 'Current lifecycle status of the facet configuration.. Valid values are `active|inactive|deprecated`',
    `facet_key` STRING COMMENT 'Technical key used in the search index to reference this facet.',
    `facet_type` STRING COMMENT 'Category of UI control used for the facet.. Valid values are `checkbox|range|color|rating`',
    `is_default` BOOLEAN COMMENT 'Indicates whether this facet is part of the default filter set.',
    `is_multi_select` BOOLEAN COMMENT 'True if users can select multiple values for this facet.',
    `is_personalized` BOOLEAN COMMENT 'True if the facet values are personalized per user behavior.',
    `is_required` BOOLEAN COMMENT 'True if the facet must be applied before search results are returned.',
    `is_searchable` BOOLEAN COMMENT 'True if the facet participates in search relevance calculations.',
    `max_value` DECIMAL(18,2) COMMENT 'Upper bound for numeric range facets.',
    `max_values_shown` STRING COMMENT 'Maximum number of distinct facet values displayed to the user.',
    `min_doc_frequency` STRING COMMENT 'Minimum number of documents required for a facet value to be displayed.',
    `min_value` DECIMAL(18,2) COMMENT 'Lower bound for numeric range facets.',
    `updated_by` STRING COMMENT 'Identifier of the user or system that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the facet configuration.',
    `value_step` DECIMAL(18,2) COMMENT 'Increment step for range sliders.',
    `version_number` STRING COMMENT 'Incremental version of the facet configuration.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the facet configuration.',
    CONSTRAINT pk_facet_config PRIMARY KEY(`facet_config_id`)
) COMMENT 'Master configuration record defining the faceted navigation filters available on search result pages for a given category or index context. Captures facet name, attribute field reference, facet type (checkbox, range slider, color swatch, rating), display order, max values shown, minimum document frequency threshold, and active flag. Drives the dynamic filter panel rendered on PLPs and SERPs.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`merchandising_rule` (
    `merchandising_rule_id` BIGINT COMMENT 'Unique identifier for the merchandising rule.',
    `indexed_document_id` BIGINT COMMENT 'Identifier of the product document (e.g., SKU, ASIN) that the rule targets.',
    `overrides_merchandising_rule_id` BIGINT COMMENT 'Self-referencing FK on merchandising_rule (overrides_merchandising_rule_id)',
    `approval_status` STRING COMMENT 'Result of the rules governance workflow.. Valid values are `approved|rejected|pending`',
    `boost_delta` DECIMAL(18,2) COMMENT 'Numeric boost score applied to the target document when rule_type is boost.',
    `bury_delta` DECIMAL(18,2) COMMENT 'Numeric penalty applied to the target document when rule_type is bury.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule record was first created.',
    `effective_end_date` DATE COMMENT 'Date when the rule expires or is deactivated (null if indefinite).',
    `effective_start_date` DATE COMMENT 'Date when the rule becomes active.',
    `merchandising_rule_status` STRING COMMENT 'Current lifecycle status of the rule.. Valid values are `draft|pending|active|inactive|retired`',
    `priority_score` STRING COMMENT 'Integer priority used to resolve conflicts when multiple rules apply; higher values win.',
    `rule_code` STRING COMMENT 'System‑generated code that uniquely identifies the rule within the search platform.',
    `rule_description` STRING COMMENT 'Free‑form description of the business intent behind the rule.',
    `rule_name` STRING COMMENT 'Human‑readable name of the rule used by merchandisers.',
    `rule_type` STRING COMMENT 'Category of intervention applied to search results (e.g., pin, boost, bury, block, redirect).. Valid values are `pin|boost|bury|block|redirect`',
    `trigger_category` STRING COMMENT 'Product category or taxonomy node that activates the rule when matched.',
    `trigger_query` STRING COMMENT 'Search query string that activates the rule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the rule.',
    `created_by` STRING COMMENT 'User identifier of the merchandiser who created the rule.',
    CONSTRAINT pk_merchandising_rule PRIMARY KEY(`merchandising_rule_id`)
) COMMENT 'Master record for manual search merchandising interventions applied to specific queries or category pages. Captures rule type (pin, boost, bury, block, redirect), trigger query or category, target document reference, boost/bury score delta, effective date range, created by merchandiser, and approval status. Enables the merchandising team to override algorithmic ranking for commercial and promotional purposes.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`recommendation_model` (
    `recommendation_model_id` BIGINT COMMENT 'Unique surrogate key for each recommendation model record.',
    `index_id` BIGINT COMMENT 'Foreign key linking to search.index. Business justification: Recommendation models are trained for a particular index; linking via index_id provides clear ownership.',
    `snapshot_id` BIGINT COMMENT 'Identifier of the data snapshot used for training the model.',
    `superseded_recommendation_model_id` BIGINT COMMENT 'Self-referencing FK on recommendation_model (superseded_recommendation_model_id)',
    `challenger_flag` BOOLEAN COMMENT 'Indicates whether this model is a challenger being evaluated against the champion.',
    `champion_flag` BOOLEAN COMMENT 'Indicates whether this model is the current production champion.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the model (e.g., compliant, non‑compliant, pending).. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the model record was first created in the data lake.',
    `data_privacy_level` STRING COMMENT 'Classification of the data privacy level associated with the models training data.. Valid values are `public|internal|confidential|restricted`',
    `deployment_context` STRING COMMENT 'Target UI or channel where the model is deployed (e.g., product detail page widget, cart page, homepage, email).. Valid values are `pdp_widget|cart_page|homepage|email`',
    `feature_set_version` STRING COMMENT 'Version identifier of the feature set used during model training.',
    `hyperparameters` STRING COMMENT 'JSON‑encoded string of hyperparameter key‑value pairs used during training.',
    `is_experimental` BOOLEAN COMMENT 'Indicates whether the model is in experimental mode and not yet production‑ready.',
    `last_deployed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent deployment of this model to a production environment.',
    `metric_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance metric was recorded.',
    `metric_value` DECIMAL(18,2) COMMENT 'Numeric value of the performance metric at the time of evaluation.',
    `model_artifact_uri` STRING COMMENT 'Location (e.g., cloud storage path) of the serialized model artifact.',
    `model_code` STRING COMMENT 'Business identifier or code used to reference the model in downstream systems.',
    `model_cpu_cores` STRING COMMENT 'Number of CPU cores allocated for model inference.',
    `model_description` STRING COMMENT 'Free‑form description of the models purpose, scope, and key characteristics.',
    `model_framework` STRING COMMENT 'Machine‑learning framework used to build the model (e.g., TensorFlow, PyTorch, Spark ML, XGBoost).',
    `model_gpu_required` BOOLEAN COMMENT 'Indicates whether GPU resources are required for model inference.',
    `model_latency_ms` STRING COMMENT 'Observed average inference latency in milliseconds.',
    `model_memory_mb` STRING COMMENT 'Memory footprint of the model when loaded for inference.',
    `model_owner` STRING COMMENT 'Name of the team or individual responsible for the model.',
    `model_retirement_date` DATE COMMENT 'Planned or actual date when the model will be retired from production.',
    `model_retirement_reason` STRING COMMENT 'Reason for retiring the model (e.g., performance degradation, business rule change).',
    `model_status` STRING COMMENT 'Lifecycle status of the model (active, inactive, deprecated, testing).. Valid values are `active|inactive|deprecated|testing`',
    `model_tags` STRING COMMENT 'Comma‑separated list of business tags or labels applied to the model (e.g., seasonal, high‑value).',
    `model_training_environment` STRING COMMENT 'Computing environment where training was executed (e.g., Databricks Spark cluster).',
    `model_type` STRING COMMENT 'Classification of the recommendation algorithm (e.g., collaborative filtering, content‑based, hybrid, trending, frequently bought together, similar items).. Valid values are `collaborative|content_based|hybrid|trending|frequently_bought|similar_items`',
    `model_version` STRING COMMENT 'Semantic version string of the model (e.g., 1.2.0).',
    `performance_metric` STRING COMMENT 'Name of the primary performance metric used to evaluate the model (e.g., precision_at_k, ndcg).',
    `recommendation_model_name` STRING COMMENT 'Human‑readable name of the recommendation model.',
    `regulatory_approval_date` DATE COMMENT 'Date when the model received required regulatory approval, if applicable.',
    `regulatory_approval_reference` STRING COMMENT 'Identifier of the regulatory approval record linked to the model.',
    `training_algorithm` STRING COMMENT 'Algorithmic technique used to train the model (e.g., ALS, Gradient Boosting, Neural Network).',
    `training_end_timestamp` TIMESTAMP COMMENT 'Timestamp marking the completion of the model training run.',
    `training_start_timestamp` TIMESTAMP COMMENT 'Timestamp marking the start of the model training run.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the model record.',
    CONSTRAINT pk_recommendation_model PRIMARY KEY(`recommendation_model_id`)
) COMMENT 'Master record representing a trained recommendation engine model deployed on the platform. Captures model name, recommendation type (collaborative filtering, content-based, hybrid, trending, frequently bought together, similar items), training algorithm, feature set version, deployment context (PDP widget, cart page, homepage, email), champion/challenger flag, and model artifact location.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`recommendation_event` (
    `recommendation_event_id` BIGINT COMMENT 'Globally unique identifier for the recommendation event record.',
    `ab_test_variant_id` BIGINT COMMENT 'Identifier of the specific variant shown to the customer.',
    `catalog_item_id` BIGINT COMMENT 'FK to product.catalog_item.catalog_item_id — Recommendation-to-product tracing. Without this FK, recommendation effectiveness cannot be measured against actual product catalog — breaking personalization analytics and A/B test evaluation.',
    `customer_profile_id` BIGINT COMMENT 'Unique identifier of the customer who received the recommendation.',
    `experiment_id` BIGINT COMMENT 'Identifier of the A/B test or experiment governing the recommendation.',
    `indexed_document_id` BIGINT COMMENT 'Identifier of the recommended item (product, category, brand, or content).',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Recommendation compliance: recommended items must be checked against obligations (e.g., age‑restricted) before being shown to users.',
    `recommendation_model_id` BIGINT COMMENT 'Identifier of the machine‑learning model that produced the recommendation.',
    `previous_recommendation_event_id` BIGINT COMMENT 'Self-referencing FK on recommendation_event (previous_recommendation_event_id)',
    `algorithm_version` STRING COMMENT 'Version identifier of the recommendation algorithm used.',
    `click_timestamp` TIMESTAMP COMMENT 'Timestamp of the click event, if applicable.',
    `conversion_timestamp` TIMESTAMP COMMENT 'Timestamp of the conversion event, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the recommendation event record was first persisted.',
    `device_type` STRING COMMENT 'Category of device used by the customer (desktop, mobile, tablet).. Valid values are `desktop|mobile|tablet`',
    `document_type` STRING COMMENT 'Type of the recommended document.. Valid values are `product|category|brand|content`',
    `event_timestamp` TIMESTAMP COMMENT 'Exact time when the recommendation event occurred (impression, click, or conversion).',
    `event_type` STRING COMMENT 'Type of event captured: impression, click, or conversion.. Valid values are `impression|click|conversion`',
    `is_clicked` BOOLEAN COMMENT 'Indicates whether the recommendation was clicked by the customer.',
    `is_converted` BOOLEAN COMMENT 'Indicates whether the click led to a conversion (e.g., purchase).',
    `latency_ms` STRING COMMENT 'Time in milliseconds taken to generate the recommendation.',
    `location_country` STRING COMMENT 'Three‑letter ISO country code representing the customers location at event time.. Valid values are `^[A-Z]{3}$`',
    `personalization_flag` BOOLEAN COMMENT 'True if the recommendation was personalized based on the customers profile.',
    `placement` STRING COMMENT 'Surface where the recommendation was displayed (home page, product detail page, cart, email, or search results).. Valid values are `homepage|pdp|cart|email|search`',
    `recommendation_event_status` STRING COMMENT 'Processing status of the recommendation event.. Valid values are `served|failed|skipped`',
    `recommendation_list_json` STRING COMMENT 'JSON array containing the ordered list of recommended document IDs and scores.',
    `recommendation_position` STRING COMMENT 'Zero‑based rank position of the document within the recommendation list.',
    `recommendation_score` DECIMAL(18,2) COMMENT 'Confidence score assigned by the model to the recommendation.',
    `request_reference` STRING COMMENT 'Unique identifier for the recommendation request for tracing.',
    `session_code` STRING COMMENT 'Identifier of the user session associated with the recommendation.',
    `source_system` STRING COMMENT 'Identifier of the system that generated the recommendation event (e.g., recommendation_engine).',
    `surface` STRING COMMENT 'Channel or device family through which the recommendation was served.. Valid values are `web|mobile|app|email`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the recommendation event record.',
    `user_agent` STRING COMMENT 'Browser or application user‑agent string of the client device.',
    CONSTRAINT pk_recommendation_event PRIMARY KEY(`recommendation_event_id`)
) COMMENT 'Transactional record capturing each recommendation impression served to a user on any platform surface. Stores recommendation model reference, placement context (PDP, cart, homepage, email), session ID, customer reference, recommended document list with positions, impression timestamp, and downstream click and conversion flags. Primary signal for measuring recommendation effectiveness and training feedback loops.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`personalization_profile` (
    `personalization_profile_id` BIGINT COMMENT 'Unique surrogate key for each personalization profile record.',
    `ab_test_variant_id` BIGINT COMMENT 'Identifier of the active A/B test variant influencing ranking logic.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the registered customer to which this profile belongs.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Privacy governance: user profiles are linked to the governing regulation (e.g., GDPR) to track consent and data‑protection requirements.',
    `merged_from_personalization_profile_id` BIGINT COMMENT 'Self-referencing FK on personalization_profile (merged_from_personalization_profile_id)',
    `behavioral_vector` STRING COMMENT 'Serialized representation (e.g., JSON) of the user’s latent interest vector used for ranking.',
    `click_count_last_30d` STRING COMMENT 'Number of product result clicks recorded in the last 30 days.',
    `consent_timestamp` TIMESTAMP COMMENT 'Date‑time when privacy consent was recorded.',
    `contact_method` STRING COMMENT 'Preferred channel for delivering personalized communications.. Valid values are `email|sms|push|none`',
    `conversion_rate_estimate` DECIMAL(18,2) COMMENT 'Projected probability (0‑1) that a presented result will convert for this profile.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the profile record was first created.',
    `device_type` STRING COMMENT 'Type of device used during the session (mobile, desktop, tablet).. Valid values are `mobile|desktop|tablet`',
    `gdpr_opt_out` BOOLEAN COMMENT 'True if the user exercised a GDPR right to opt out of personalization.',
    `interest_score` DECIMAL(18,2) COMMENT 'Aggregated numeric score (0‑100) representing the strength of the user’s interest in the catalog.',
    `is_anonymous` BOOLEAN COMMENT 'True if the profile belongs to an unauthenticated (guest) session.',
    `last_model_update` TIMESTAMP COMMENT 'Timestamp when the personalization model was last refreshed for this profile.',
    `location_country` STRING COMMENT 'ISO‑3166‑1 alpha‑3 country code of the user’s location.. Valid values are `^[A-Z]{3}$`',
    `location_region` STRING COMMENT 'Sub‑national region or state code of the user’s location.',
    `model_version` STRING COMMENT 'Version identifier of the recommendation/personalization model that generated the profile state.',
    `personalization_profile_status` STRING COMMENT 'Current lifecycle state of the personalization profile.. Valid values are `active|inactive|suspended|deleted`',
    `preferred_brand_codes` STRING COMMENT 'Pipe‑separated list of brand identifiers the user prefers.',
    `preferred_category_codes` STRING COMMENT 'Pipe‑separated list of category identifiers the user shows affinity for.',
    `price_range_max` DECIMAL(18,2) COMMENT 'Upper bound of the price range the user typically targets.',
    `price_range_min` DECIMAL(18,2) COMMENT 'Lower bound of the price range the user typically targets.',
    `privacy_consent_given` BOOLEAN COMMENT 'True if the user has consented to personalized data processing.',
    `profile_name` STRING COMMENT 'Human‑readable label for the personalization profile (e.g., "John Doe Profile" or "Guest Session 123").',
    `recently_viewed_skus` STRING COMMENT 'Pipe‑separated list of SKU identifiers viewed in the recent session.',
    `recommendation_score` DECIMAL(18,2) COMMENT 'Score assigned by the recommendation engine to indicate relevance of top‑ranked items.',
    `search_query_count_last_30d` STRING COMMENT 'Number of distinct search queries issued in the last 30 days.',
    `segment_type` STRING COMMENT 'Classification of the customer/session for segmentation (e.g., new, returning, high_value, low_value).',
    `session_code` STRING COMMENT 'Unique identifier for an anonymous browsing session when no customer is logged in.',
    `session_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the browsing session ended or timed out.',
    `session_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the browsing session began.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the profile.',
    CONSTRAINT pk_personalization_profile PRIMARY KEY(`personalization_profile_id`)
) COMMENT 'Master record capturing the search and recommendation personalization state for an individual customer or anonymous session. Stores customer or session reference, preferred categories, brand affinities, price range preferences, recently viewed SKU signals, behavioral interest vector, personalization model version, and last updated timestamp. Distinct from the customer domain profile — this is the search-domain-owned behavioral state used exclusively for ranking and recommendation personalization.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`behavioral_signal` (
    `behavioral_signal_id` BIGINT COMMENT 'Unique identifier for the aggregated behavioral signal record.',
    `customer_profile_id` BIGINT COMMENT 'Unique identifier of the customer who generated the signal.',
    `indexed_document_id` BIGINT COMMENT 'Identifier of the product or content document the signal relates to.',
    `search_session_id` BIGINT COMMENT 'Identifier of the browsing session associated with the signal.',
    `aggregated_from_behavioral_signal_id` BIGINT COMMENT 'Self-referencing FK on behavioral_signal (aggregated_from_behavioral_signal_id)',
    `behavioral_signal_status` STRING COMMENT 'Current lifecycle status of the signal record.. Valid values are `active|inactive|archived`',
    `collection_timestamp` TIMESTAMP COMMENT 'Timestamp when the aggregated behavioral signal record was created.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the behavioral signal record was first persisted.',
    `device_type` STRING COMMENT 'Category of device used for the interaction.. Valid values are `desktop|mobile|tablet`',
    `is_bot` BOOLEAN COMMENT 'Indicates whether the interaction was generated by an automated bot.',
    `location_country` STRING COMMENT 'Three‑letter ISO country code representing the users location.. Valid values are `^[A-Z]{3}$`',
    `personalization_flag` BOOLEAN COMMENT 'True if the signal was generated in a personalized search context.',
    `recency_weighted_value` DOUBLE COMMENT 'Signal value adjusted for recency, giving higher weight to more recent interactions.',
    `signal_count` BIGINT COMMENT 'Number of raw events of the given signal type observed within the aggregation window.',
    `signal_type` STRING COMMENT 'Type of user interaction captured (e.g., view, add‑to‑cart, purchase, wishlist, dwell time, scroll depth).. Valid values are `view|add_to_cart|purchase|wishlist|dwell|scroll`',
    `signal_weight` DOUBLE COMMENT 'Numeric weight applied to the signal for ranking algorithms.',
    `source_system` STRING COMMENT 'Originating system that produced the raw interaction events.. Valid values are `clickstream|recommendation_engine|marketing_platform`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the behavioral signal record.',
    `user_agent` STRING COMMENT 'Raw user‑agent header identifying browser, OS, and device details.',
    `window_end` TIMESTAMP COMMENT 'End of the rolling time window over which signals were aggregated.',
    `window_start` TIMESTAMP COMMENT 'Start of the rolling time window over which signals were aggregated.',
    CONSTRAINT pk_behavioral_signal PRIMARY KEY(`behavioral_signal_id`)
) COMMENT 'Transactional record capturing aggregated behavioral signals used as ranking and personalization inputs. Captures signal type (view, add-to-cart, purchase, wishlist, dwell time, scroll depth), document reference, signal count within a rolling window, recency-weighted signal value, customer or session reference, and signal collection timestamp. Aggregated from raw click and interaction events to serve as feature inputs for ranking and recommendation models.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`zero_result_query` (
    `zero_result_query_id` BIGINT COMMENT 'System‑generated unique identifier for the zero‑result query event.',
    `ab_test_variant_id` BIGINT COMMENT 'Identifier of the A/B test variant active at query time, if any.',
    `customer_profile_id` BIGINT COMMENT 'Unique identifier of the customer who issued the query.',
    `index_id` BIGINT COMMENT 'Foreign key linking to search.index. Business justification: Zero‑result queries occur on a particular index; linking them directly to index improves analysis of index performance.',
    `retry_of_zero_result_query_id` BIGINT COMMENT 'Self-referencing FK on zero_result_query (retry_of_zero_result_query_id)',
    `applied_filters` STRING COMMENT 'JSON string representing any filters (price range, brand, category, etc.) applied at query time.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the zero‑result record was first persisted.',
    `device_type` STRING COMMENT 'Type of device used for the search (desktop, mobile, tablet).. Valid values are `desktop|mobile|tablet`',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the search query was executed.',
    `event_type` STRING COMMENT 'Type of search event; for this product always zero_result.',
    `ip_address` STRING COMMENT 'IP address of the client issuing the query.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$`',
    `is_bot` BOOLEAN COMMENT 'Indicates whether the request was identified as originating from an automated bot.',
    `language_locale` STRING COMMENT 'Locale of the query in language_country format (e.g., en_US).. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `location_country` STRING COMMENT 'Three‑letter ISO country code derived from the IP address.',
    `normalized_query` STRING COMMENT 'Standardized version of the query after tokenization, lower‑casing and stop‑word removal.',
    `platform_channel` STRING COMMENT 'Channel through which the search request was made (e.g., web, mobile app, API).. Valid values are `web|mobile|api|voice|chat`',
    `query_category` STRING COMMENT 'High‑level classification of the query intent (e.g., product, brand, category).',
    `query_latency_ms` STRING COMMENT 'Time in milliseconds from query submission to response generation.',
    `query_text` STRING COMMENT 'Original query string entered by the user.',
    `request_reference` STRING COMMENT 'Unique identifier for the HTTP request handling the query.',
    `result_count` STRING COMMENT 'Number of results returned for the query (always zero for this product).',
    `search_engine_instance_code` STRING COMMENT 'Identifier of the search engine instance that processed the query.',
    `search_version` STRING COMMENT 'Version identifier of the search algorithm or index used.',
    `session_code` STRING COMMENT 'Identifier of the user session during which the query was issued.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record (e.g., after enrichment).',
    `user_agent` STRING COMMENT 'Browser or client user‑agent header value.',
    `zero_result_flag` BOOLEAN COMMENT 'Indicates that the query returned no results (always true).',
    CONSTRAINT pk_zero_result_query PRIMARY KEY(`zero_result_query_id`)
) COMMENT 'Transactional record capturing search queries that returned zero results. Stores raw query string, normalized query, session ID, customer reference, timestamp, applied filters at time of zero result, language locale, and platform channel. Used by the search team to identify gaps in catalog coverage, missing synonyms, and query understanding failures requiring remediation.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` (
    `autocomplete_suggestion_id` BIGINT COMMENT 'Unique identifier for the autocomplete suggestion entry.',
    `ab_test_variant_id` BIGINT COMMENT 'Identifier of the A/B test variant influencing this suggestion.',
    `index_id` BIGINT COMMENT 'Foreign key linking to search.index. Business justification: Autocomplete suggestions are generated per index; the FK ties suggestions to their index.',
    `parent_autocomplete_suggestion_id` BIGINT COMMENT 'Self-referencing FK on autocomplete_suggestion (parent_autocomplete_suggestion_id)',
    `autocomplete_suggestion_status` STRING COMMENT 'Indicates whether the suggestion is currently active and served to users.. Valid values are `active|inactive`',
    `click_through_rate` DECIMAL(18,2) COMMENT 'Ratio of clicks to impressions for the suggestion.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the suggestion record was created.',
    `display_rank` STRING COMMENT 'Numeric rank determining the order of suggestion display; lower numbers appear higher.',
    `editorial_source` STRING COMMENT 'Identifier of the editorial source or team responsible for the suggestion.',
    `expiration_date` DATE COMMENT 'Date after which the suggestion should no longer be served.',
    `impression_count` BIGINT COMMENT 'Number of times the suggestion has been shown to users.',
    `is_editorial` BOOLEAN COMMENT 'Indicates if the suggestion was manually curated by editors.',
    `is_personalized` BOOLEAN COMMENT 'Indicates whether the suggestion is personalized for the user.',
    `language_locale` STRING COMMENT 'Locale code (e.g., en_US) indicating the language and region for the suggestion.. Valid values are `^[A-Z]{2}_[A-Z]{2}$`',
    `last_refreshed_timestamp` TIMESTAMP COMMENT 'Timestamp when the suggestion data was last refreshed from source.',
    `personalization_source` STRING COMMENT 'Source of personalization data (e.g., user profile, behavior model).',
    `popularity_score` DECIMAL(18,2) COMMENT 'Score representing the popularity of the suggestion based on query frequency.',
    `relevance_score` DECIMAL(18,2) COMMENT 'Score indicating relevance of the suggestion to the users intent.',
    `source_system` STRING COMMENT 'Originating system that supplied the suggestion (e.g., query logs, editorial curation).',
    `suggestion_text` STRING COMMENT 'The text displayed as an autocomplete suggestion.',
    `suggestion_type` STRING COMMENT 'Classifies the suggestion as a query completion, popular search, trending term, category, or brand.. Valid values are `query_completion|popular_search|trending|category|brand`',
    `target_audience` STRING COMMENT 'Customer segment for which the suggestion is targeted.',
    `trigger_prefix` STRING COMMENT 'The prefix string that triggers this suggestion when a user types it.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the suggestion record.',
    CONSTRAINT pk_autocomplete_suggestion PRIMARY KEY(`autocomplete_suggestion_id`)
) COMMENT 'Master record defining the autocomplete and typeahead suggestion entries served in the search bar. Captures suggestion text, suggestion type (query completion, popular search, trending, category, brand), display rank, trigger prefix, language locale, active flag, impression count, and click-through rate. Managed by the search team and refreshed periodically based on query frequency and editorial curation.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`redirect_rule` (
    `redirect_rule_id` BIGINT COMMENT 'Unique identifier for the redirect rule.',
    `index_id` BIGINT COMMENT 'Auto-generated FK linking siloed redirect_rule to index',
    `fallback_redirect_rule_id` BIGINT COMMENT 'Self-referencing FK on redirect_rule (fallback_redirect_rule_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the redirect rule record was first created.',
    `destination_url` STRING COMMENT 'Full URL to which the user is redirected when the rule matches.',
    `effective_end_date` DATE COMMENT 'Date after which the redirect rule is no longer active; null means indefinite.',
    `effective_start_date` DATE COMMENT 'Date from which the redirect rule becomes active.',
    `is_active` BOOLEAN COMMENT 'Current operational flag; true if the rule is active based on lifecycle and dates.',
    `is_case_sensitive` BOOLEAN COMMENT 'Indicates whether the query matching is case‑sensitive.',
    `is_regex` BOOLEAN COMMENT 'Indicates whether the query_pattern is interpreted as a regular expression.',
    `last_tested_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent automated test of the rules validity.',
    `match_type` STRING COMMENT 'Method used to compare the incoming query with the query_pattern.. Valid values are `exact|contains|starts_with|regex`',
    `priority` STRING COMMENT 'Integer priority determining rule precedence when multiple rules match; lower numbers have higher priority.',
    `query_pattern` STRING COMMENT 'Exact query string or regular‑expression pattern that triggers the redirect.',
    `redirect_rule_code` STRING COMMENT 'Business identifier code for the rule, used for lookup and integration.',
    `redirect_rule_description` STRING COMMENT 'Free‑form description providing context, business purpose, or notes for the rule.',
    `redirect_rule_name` STRING COMMENT 'Human‑readable name of the redirect rule.',
    `redirect_type` STRING COMMENT 'HTTP status code indicating permanent (301) or temporary (302) redirect.. Valid values are `301|302`',
    `rule_category` STRING COMMENT 'High‑level classification of the rules business purpose.. Valid values are `navigational|promotional|campaign|brand`',
    `rule_status` STRING COMMENT 'Current lifecycle state of the rule.. Valid values are `draft|active|retired|archived`',
    `source_system` STRING COMMENT 'Originating system that authored or manages the redirect rule.. Valid values are `search_engine|cms|marketing|seller_portal`',
    `test_result` STRING COMMENT 'Outcome of the last rule test: pass, fail, or warning.. Valid values are `pass|fail|warning`',
    `updated_by` STRING COMMENT 'Identifier of the user or service that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the rule.',
    `created_by` STRING COMMENT 'Identifier of the user or service that created the rule.',
    CONSTRAINT pk_redirect_rule PRIMARY KEY(`redirect_rule_id`)
) COMMENT 'Master record defining query-to-URL redirect rules that bypass standard search results and send users directly to a landing page, category page, or PDP. Captures trigger query (exact or pattern match), destination URL, redirect type (301 permanent, 302 temporary), priority, effective date range, created by, and active flag. Used for branded queries, campaign landing pages, and high-confidence navigational queries.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`index_build_job` (
    `index_build_job_id` BIGINT COMMENT 'Unique identifier for the index build job record.',
    `index_id` BIGINT COMMENT 'Identifier of the search index that this job builds or refreshes.',
    `triggered_by_index_build_job_id` BIGINT COMMENT 'Self-referencing FK on index_build_job (triggered_by_index_build_job_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the job record was first created in the system.',
    `documents_failed` STRING COMMENT 'Number of source documents that failed to process.',
    `documents_processed` STRING COMMENT 'Number of source documents successfully processed during the job.',
    `end_timestamp` TIMESTAMP COMMENT 'Date‑time when the index build job completed or terminated.',
    `error_summary` STRING COMMENT 'Concise description of errors or exceptions encountered during the job.',
    `index_build_job_status` STRING COMMENT 'Current lifecycle status of the job.. Valid values are `pending|running|success|failed|canceled`',
    `initiated_by` BIGINT COMMENT 'Identifier of the user or system component that initiated the job.',
    `is_real_time` BOOLEAN COMMENT 'Indicates whether the job processes data in real‑time (true) or batch mode (false).',
    `job_type` STRING COMMENT 'Specifies whether the job is a full rebuild, incremental (delta) update, or real‑time update.. Valid values are `full|incremental|real_time`',
    `job_version` STRING COMMENT 'Version identifier of the job definition or configuration used.',
    `notes` STRING COMMENT 'Free‑form text for additional context or comments about the job execution.',
    `priority_level` STRING COMMENT 'Relative priority of the job for scheduling purposes.. Valid values are `low|medium|high`',
    `start_timestamp` TIMESTAMP COMMENT 'Date‑time when the index build job started execution.',
    `trigger_source` STRING COMMENT 'Origin of the job trigger: scheduled timer, event‑driven, or manual initiation.. Valid values are `scheduled|event|manual`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the job record.',
    CONSTRAINT pk_index_build_job PRIMARY KEY(`index_build_job_id`)
) COMMENT 'Transactional operational record tracking each full or incremental search index build or refresh job. Captures job type (full rebuild, delta update, real-time update), index reference, trigger source (scheduled, event-driven, manual), start timestamp, end timestamp, documents processed count, documents failed count, job status, and error summary. Enables the search ops team to monitor index freshness and diagnose build failures.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`quality_eval` (
    `quality_eval_id` BIGINT COMMENT 'Unique identifier for the search quality evaluation event.',
    `ab_test_variant_id` BIGINT COMMENT 'Identifier of the specific variant within the experiment.',
    `agent_id` BIGINT COMMENT 'Identifier of the evaluator (human judge or automated system) that performed the evaluation.',
    `experiment_id` BIGINT COMMENT 'Identifier of the A/B test or experiment associated with this evaluation.',
    `query_log_id` BIGINT COMMENT 'Reference to the query log entry associated with this evaluation.',
    `baseline_quality_eval_id` BIGINT COMMENT 'Self-referencing FK on quality_eval (baseline_quality_eval_id)',
    `confidence_score` DECIMAL(18,2) COMMENT 'Confidence level associated with the overall quality score (0.00–100.00).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the evaluation record was first created in the data lake.',
    `evaluation_methodology` STRING COMMENT 'Methodology used to assess search relevance for this evaluation.. Valid values are `ndcg|mrr|precision_at_k|recall_at_k|map|click_through_rate`',
    `evaluation_notes` STRING COMMENT 'Free-text notes or comments from the evaluator about the evaluation.',
    `evaluation_timestamp` TIMESTAMP COMMENT 'Date and time when the evaluation was performed.',
    `evaluator_type` STRING COMMENT 'Indicates whether the evaluation was performed by a human judge or an automated system.. Valid values are `human|automated`',
    `is_successful` BOOLEAN COMMENT 'Indicates whether the evaluation completed successfully.',
    `model_version` STRING COMMENT 'Version identifier of the ranking model evaluated.',
    `overall_quality_score` DECIMAL(18,2) COMMENT 'Aggregated quality score for the query (e.g., 0.00–100.00).',
    `quality_eval_status` STRING COMMENT 'Current processing status of the evaluation record.. Valid values are `pending|completed|failed`',
    `query_string` STRING COMMENT 'The raw search query text that was evaluated.',
    `ranking_algorithm_version` STRING COMMENT 'Version of the underlying ranking algorithm used during evaluation.',
    `rated_document_ids` STRING COMMENT 'Comma-separated list of document IDs that were evaluated.',
    `rated_document_positions` STRING COMMENT 'Comma-separated list of result positions corresponding to the rated documents.',
    `relevance_grades` STRING COMMENT 'Pipe-separated relevance grades assigned to each document in the result set (e.g., 3|2|0|1).',
    `source_system` STRING COMMENT 'Name of the system that generated the evaluation record (e.g., search_engine).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the evaluation record.',
    CONSTRAINT pk_quality_eval PRIMARY KEY(`quality_eval_id`)
) COMMENT 'Transactional record capturing a human or automated search quality evaluation event for a specific query. Stores query string, evaluator type (human judge, automated), evaluation methodology (NDCG, MRR, precision@k), rated document list with relevance grades, evaluation timestamp, ranking model version evaluated, and overall query quality score. Feeds the offline relevance evaluation pipeline used to gate ranking model promotions.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`trending_query` (
    `trending_query_id` BIGINT COMMENT 'Unique surrogate identifier for the trending query record.',
    `ab_test_variant_id` BIGINT COMMENT 'Identifier of the A/B test variant influencing ranking for this period.',
    `index_id` BIGINT COMMENT 'Foreign key linking to search.index. Business justification: Trending queries are tracked per index; the FK associates the trend record with its index.',
    `sku_id` BIGINT COMMENT 'SKU of the most frequently clicked product for this query.',
    `prior_period_trending_query_id` BIGINT COMMENT 'Self-referencing FK on trending_query (prior_period_trending_query_id)',
    `confidence_score` DECIMAL(18,2) COMMENT 'Algorithmic confidence (0‑1) that the trend classification is accurate.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the trending query record was first created.',
    `device_type` STRING COMMENT 'Device category used to issue the query.. Valid values are `desktop|mobile|tablet`',
    `geo_city` STRING COMMENT 'City name of the query origin.',
    `geo_country_code` STRING COMMENT 'Three‑letter ISO country code of the query origin.',
    `geo_region` STRING COMMENT 'Region or state name of the query origin.',
    `ip_address` STRING COMMENT 'IP address of the client that issued the query.',
    `is_bot` BOOLEAN COMMENT 'True if the query originated from an automated bot.',
    `is_promoted` BOOLEAN COMMENT 'True if the query is being actively promoted in UI widgets.',
    `is_seasonal` BOOLEAN COMMENT 'Indicates whether the query is identified as seasonal.',
    `language_code` STRING COMMENT 'ISO 639‑1 language code of the query (e.g., en, fr).',
    `last_seen_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent occurrence of the query within the period.',
    `locale` STRING COMMENT 'Locale identifier (e.g., en_US) representing language and region.',
    `normalized_query` STRING COMMENT 'Standardized version of the query after lower‑casing, stemming, and stop‑word removal.',
    `period_end_timestamp` TIMESTAMP COMMENT 'End time of the trend aggregation window.',
    `period_start_timestamp` TIMESTAMP COMMENT 'Start time of the trend aggregation window.',
    `period_type` STRING COMMENT 'Granularity of the aggregation window for the trend (hourly, daily, weekly, monthly).. Valid values are `hourly|daily|weekly|monthly`',
    `query_hash` STRING COMMENT 'Deterministic hash of the normalized query used for fast deduplication.',
    `query_text` STRING COMMENT 'Exact text entered by the user in the search box.',
    `query_volume` BIGINT COMMENT 'Number of times the query was issued during the period.',
    `record_status` STRING COMMENT 'Current lifecycle status of the record.. Valid values are `active|inactive|archived`',
    `related_product_count` STRING COMMENT 'Number of distinct products associated with the query during the period.',
    `search_engine_version` STRING COMMENT 'Version identifier of the search algorithm used during the period.',
    `source` STRING COMMENT 'Origin channel of the query (web, mobile, app).. Valid values are `web|mobile|app`',
    `trend_classification` STRING COMMENT 'Business classification of the query trend (rising, peak, declining, stable).. Valid values are `rising|peak|declining|stable`',
    `trending_query_category` STRING COMMENT 'Top‑level product or content category linked to the query.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `user_segment` STRING COMMENT 'Customer segment classification applied at query time.',
    `volume_change_pct` DECIMAL(18,2) COMMENT 'Percent change in query volume compared to the previous period.',
    CONSTRAINT pk_trending_query PRIMARY KEY(`trending_query_id`)
) COMMENT 'Master record tracking trending and seasonally popular search queries on the platform. Captures query string, normalized query, trend period (hourly, daily, weekly), query volume, volume change percentage versus prior period, trend classification (rising, peak, declining), category association, and language locale. Used to power trending search widgets, autocomplete prioritization, and inventory demand signals.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`filter_usage` (
    `filter_usage_id` BIGINT COMMENT 'Unique identifier for the filter usage event.',
    `ab_test_variant_id` BIGINT COMMENT 'Identifier of the A/B test variant influencing the search experience.',
    `customer_profile_id` BIGINT COMMENT 'Unique identifier of the customer who applied the filter.',
    `facet_config_id` BIGINT COMMENT 'Identifier of the facet configuration that defines this filter.',
    `query_log_id` BIGINT COMMENT 'Identifier of the original search query associated with this filter usage.',
    `previous_filter_usage_id` BIGINT COMMENT 'Self-referencing FK on filter_usage (previous_filter_usage_id)',
    `customer_segment` STRING COMMENT 'Customer segment classification at the time of filter usage.',
    `device_type` STRING COMMENT 'Type of device used for the search session (e.g., desktop, mobile, tablet).',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the filter usage event occurred.',
    `filter_action` STRING COMMENT 'Action taken on the filter: apply to narrow results or remove to broaden.. Valid values are `apply|remove`',
    `filter_name` STRING COMMENT 'Name of the facet filter applied (e.g., brand, price_range, color).',
    `filter_value` DECIMAL(18,2) COMMENT 'Value selected for the filter (e.g., Nike, 100-200, Red).',
    `is_bot` BOOLEAN COMMENT 'Indicates whether the request was identified as automated bot traffic.',
    `location_country` STRING COMMENT 'Three-letter ISO country code of the users location.. Valid values are `^[A-Z]{3}$`',
    `result_count_after` STRING COMMENT 'Number of search results returned after the filter was applied.',
    `result_count_before` STRING COMMENT 'Number of search results returned before the filter was applied.',
    `result_delta` STRING COMMENT 'Difference in result count after applying the filter (after minus before).',
    `search_version` STRING COMMENT 'Version of the search engine or algorithm used for this session.',
    `session_code` BIGINT COMMENT 'Identifier of the search session in which the filter was used.',
    `session_duration_seconds` STRING COMMENT 'Total duration of the search session in seconds.',
    `session_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the search session ended.',
    `session_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the search session started.',
    `user_agent` STRING COMMENT 'User agent string of the client making the search request.',
    CONSTRAINT pk_filter_usage PRIMARY KEY(`filter_usage_id`)
) COMMENT 'Transactional record capturing each facet filter application event during a search session. Stores query log reference, facet config reference, filter value selected, filter action (apply, remove), session ID, customer reference, result count before and after filter application, and timestamp. Enables analysis of filter adoption rates, filter effectiveness, and facet configuration optimization.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`search`.`search_session` (
    `search_session_id` BIGINT COMMENT 'Primary key for search_session',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer who performed the search session.',
    `previous_search_session_id` BIGINT COMMENT 'Self-referencing FK on search_session (previous_search_session_id)',
    `click_count` STRING COMMENT 'Number of result clicks recorded during the session.',
    `clicked_result_ids` STRING COMMENT 'Comma‑separated list of result identifiers that were clicked.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the user location.',
    `device_code` BIGINT COMMENT 'Identifier of the device used for the search session.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the search session started (event occurrence).',
    `event_type_or_channel` STRING COMMENT 'Category of the search event (e.g., standard search, recommendation, autocomplete).',
    `experiment_variant` STRING COMMENT 'A/B test variant assigned to the session for search experiments.',
    `filters_applied` STRING COMMENT 'Serialized representation of any facet filters applied during the search.',
    `ip_address` STRING COMMENT 'IP address of the client initiating the search session.',
    `is_bot` BOOLEAN COMMENT 'Indicates whether the session was identified as automated (bot) traffic.',
    `language_code` STRING COMMENT 'Two‑letter ISO language code of the users preferred language.',
    `page_number` STRING COMMENT 'Page number of the result set viewed in the session.',
    `personalization_flag` BOOLEAN COMMENT 'True if personalization algorithms were applied to the search results.',
    `ranking_algorithm_version` STRING COMMENT 'Version identifier of the ranking algorithm used for this session.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the session record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the session record.',
    `region_code` STRING COMMENT 'Sub‑national region or state code of the user location.',
    `result_count` STRING COMMENT 'Number of results returned for the query.',
    `results_clicked` STRING COMMENT 'Number of displayed results that were clicked.',
    `results_shown` STRING COMMENT 'Total number of results displayed to the user.',
    `search_query` STRING COMMENT 'The raw text query entered by the user.',
    `session_duration_seconds` STRING COMMENT 'Total duration of the session in seconds.',
    `session_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the search session ended.',
    `session_status` STRING COMMENT 'Current lifecycle status of the search session.',
    `sort_order` STRING COMMENT 'Sorting order applied to the result set (e.g., relevance, price_asc).',
    `user_agent` STRING COMMENT 'Browser or application user-agent string for the session.',
    CONSTRAINT pk_search_session PRIMARY KEY(`search_session_id`)
) COMMENT 'Master reference table for search_session. Referenced by session_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`search`.`index` ADD CONSTRAINT `fk_search_index_relevance_config_id` FOREIGN KEY (`relevance_config_id`) REFERENCES `ecommerce_ecm`.`search`.`relevance_config`(`relevance_config_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`index` ADD CONSTRAINT `fk_search_index_superseded_index_id` FOREIGN KEY (`superseded_index_id`) REFERENCES `ecommerce_ecm`.`search`.`index`(`index_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ADD CONSTRAINT `fk_search_indexed_document_index_id` FOREIGN KEY (`index_id`) REFERENCES `ecommerce_ecm`.`search`.`index`(`index_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ADD CONSTRAINT `fk_search_indexed_document_previous_version_indexed_document_id` FOREIGN KEY (`previous_version_indexed_document_id`) REFERENCES `ecommerce_ecm`.`search`.`indexed_document`(`indexed_document_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ADD CONSTRAINT `fk_search_query_log_index_id` FOREIGN KEY (`index_id`) REFERENCES `ecommerce_ecm`.`search`.`index`(`index_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ADD CONSTRAINT `fk_search_query_log_refined_from_query_log_id` FOREIGN KEY (`refined_from_query_log_id`) REFERENCES `ecommerce_ecm`.`search`.`query_log`(`query_log_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`result` ADD CONSTRAINT `fk_search_result_indexed_document_id` FOREIGN KEY (`indexed_document_id`) REFERENCES `ecommerce_ecm`.`search`.`indexed_document`(`indexed_document_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`result` ADD CONSTRAINT `fk_search_result_query_log_id` FOREIGN KEY (`query_log_id`) REFERENCES `ecommerce_ecm`.`search`.`query_log`(`query_log_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`result` ADD CONSTRAINT `fk_search_result_previous_result_id` FOREIGN KEY (`previous_result_id`) REFERENCES `ecommerce_ecm`.`search`.`result`(`result_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ADD CONSTRAINT `fk_search_click_event_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `ecommerce_ecm`.`search`.`experiment`(`experiment_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ADD CONSTRAINT `fk_search_click_event_indexed_document_id` FOREIGN KEY (`indexed_document_id`) REFERENCES `ecommerce_ecm`.`search`.`indexed_document`(`indexed_document_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ADD CONSTRAINT `fk_search_click_event_query_log_id` FOREIGN KEY (`query_log_id`) REFERENCES `ecommerce_ecm`.`search`.`query_log`(`query_log_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ADD CONSTRAINT `fk_search_click_event_result_id` FOREIGN KEY (`result_id`) REFERENCES `ecommerce_ecm`.`search`.`result`(`result_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ADD CONSTRAINT `fk_search_click_event_previous_click_event_id` FOREIGN KEY (`previous_click_event_id`) REFERENCES `ecommerce_ecm`.`search`.`click_event`(`click_event_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ADD CONSTRAINT `fk_search_relevance_config_superseded_relevance_config_id` FOREIGN KEY (`superseded_relevance_config_id`) REFERENCES `ecommerce_ecm`.`search`.`relevance_config`(`relevance_config_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ADD CONSTRAINT `fk_search_ranking_model_index_id` FOREIGN KEY (`index_id`) REFERENCES `ecommerce_ecm`.`search`.`index`(`index_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ADD CONSTRAINT `fk_search_ranking_model_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `ecommerce_ecm`.`search`.`experiment`(`experiment_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ADD CONSTRAINT `fk_search_ranking_model_superseded_ranking_model_id` FOREIGN KEY (`superseded_ranking_model_id`) REFERENCES `ecommerce_ecm`.`search`.`ranking_model`(`ranking_model_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ADD CONSTRAINT `fk_search_experiment_index_id` FOREIGN KEY (`index_id`) REFERENCES `ecommerce_ecm`.`search`.`index`(`index_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ADD CONSTRAINT `fk_search_experiment_iterated_from_experiment_id` FOREIGN KEY (`iterated_from_experiment_id`) REFERENCES `ecommerce_ecm`.`search`.`experiment`(`experiment_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ADD CONSTRAINT `fk_search_experiment_assignment_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `ecommerce_ecm`.`search`.`experiment`(`experiment_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ADD CONSTRAINT `fk_search_experiment_assignment_reassigned_from_experiment_assignment_id` FOREIGN KEY (`reassigned_from_experiment_assignment_id`) REFERENCES `ecommerce_ecm`.`search`.`experiment_assignment`(`experiment_assignment_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ADD CONSTRAINT `fk_search_query_rewrite_rule_index_id` FOREIGN KEY (`index_id`) REFERENCES `ecommerce_ecm`.`search`.`index`(`index_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ADD CONSTRAINT `fk_search_query_rewrite_rule_chained_query_rewrite_rule_id` FOREIGN KEY (`chained_query_rewrite_rule_id`) REFERENCES `ecommerce_ecm`.`search`.`query_rewrite_rule`(`query_rewrite_rule_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ADD CONSTRAINT `fk_search_synonym_set_index_id` FOREIGN KEY (`index_id`) REFERENCES `ecommerce_ecm`.`search`.`index`(`index_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ADD CONSTRAINT `fk_search_synonym_set_parent_synonym_set_id` FOREIGN KEY (`parent_synonym_set_id`) REFERENCES `ecommerce_ecm`.`search`.`synonym_set`(`synonym_set_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ADD CONSTRAINT `fk_search_facet_config_index_id` FOREIGN KEY (`index_id`) REFERENCES `ecommerce_ecm`.`search`.`index`(`index_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ADD CONSTRAINT `fk_search_facet_config_parent_facet_config_id` FOREIGN KEY (`parent_facet_config_id`) REFERENCES `ecommerce_ecm`.`search`.`facet_config`(`facet_config_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ADD CONSTRAINT `fk_search_merchandising_rule_indexed_document_id` FOREIGN KEY (`indexed_document_id`) REFERENCES `ecommerce_ecm`.`search`.`indexed_document`(`indexed_document_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ADD CONSTRAINT `fk_search_merchandising_rule_overrides_merchandising_rule_id` FOREIGN KEY (`overrides_merchandising_rule_id`) REFERENCES `ecommerce_ecm`.`search`.`merchandising_rule`(`merchandising_rule_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ADD CONSTRAINT `fk_search_recommendation_model_index_id` FOREIGN KEY (`index_id`) REFERENCES `ecommerce_ecm`.`search`.`index`(`index_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ADD CONSTRAINT `fk_search_recommendation_model_superseded_recommendation_model_id` FOREIGN KEY (`superseded_recommendation_model_id`) REFERENCES `ecommerce_ecm`.`search`.`recommendation_model`(`recommendation_model_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ADD CONSTRAINT `fk_search_recommendation_event_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `ecommerce_ecm`.`search`.`experiment`(`experiment_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ADD CONSTRAINT `fk_search_recommendation_event_indexed_document_id` FOREIGN KEY (`indexed_document_id`) REFERENCES `ecommerce_ecm`.`search`.`indexed_document`(`indexed_document_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ADD CONSTRAINT `fk_search_recommendation_event_recommendation_model_id` FOREIGN KEY (`recommendation_model_id`) REFERENCES `ecommerce_ecm`.`search`.`recommendation_model`(`recommendation_model_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ADD CONSTRAINT `fk_search_recommendation_event_previous_recommendation_event_id` FOREIGN KEY (`previous_recommendation_event_id`) REFERENCES `ecommerce_ecm`.`search`.`recommendation_event`(`recommendation_event_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ADD CONSTRAINT `fk_search_personalization_profile_merged_from_personalization_profile_id` FOREIGN KEY (`merged_from_personalization_profile_id`) REFERENCES `ecommerce_ecm`.`search`.`personalization_profile`(`personalization_profile_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ADD CONSTRAINT `fk_search_behavioral_signal_indexed_document_id` FOREIGN KEY (`indexed_document_id`) REFERENCES `ecommerce_ecm`.`search`.`indexed_document`(`indexed_document_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ADD CONSTRAINT `fk_search_behavioral_signal_search_session_id` FOREIGN KEY (`search_session_id`) REFERENCES `ecommerce_ecm`.`search`.`search_session`(`search_session_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ADD CONSTRAINT `fk_search_behavioral_signal_aggregated_from_behavioral_signal_id` FOREIGN KEY (`aggregated_from_behavioral_signal_id`) REFERENCES `ecommerce_ecm`.`search`.`behavioral_signal`(`behavioral_signal_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ADD CONSTRAINT `fk_search_zero_result_query_index_id` FOREIGN KEY (`index_id`) REFERENCES `ecommerce_ecm`.`search`.`index`(`index_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ADD CONSTRAINT `fk_search_zero_result_query_retry_of_zero_result_query_id` FOREIGN KEY (`retry_of_zero_result_query_id`) REFERENCES `ecommerce_ecm`.`search`.`zero_result_query`(`zero_result_query_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ADD CONSTRAINT `fk_search_autocomplete_suggestion_index_id` FOREIGN KEY (`index_id`) REFERENCES `ecommerce_ecm`.`search`.`index`(`index_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ADD CONSTRAINT `fk_search_autocomplete_suggestion_parent_autocomplete_suggestion_id` FOREIGN KEY (`parent_autocomplete_suggestion_id`) REFERENCES `ecommerce_ecm`.`search`.`autocomplete_suggestion`(`autocomplete_suggestion_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ADD CONSTRAINT `fk_search_redirect_rule_index_id` FOREIGN KEY (`index_id`) REFERENCES `ecommerce_ecm`.`search`.`index`(`index_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ADD CONSTRAINT `fk_search_redirect_rule_fallback_redirect_rule_id` FOREIGN KEY (`fallback_redirect_rule_id`) REFERENCES `ecommerce_ecm`.`search`.`redirect_rule`(`redirect_rule_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ADD CONSTRAINT `fk_search_index_build_job_index_id` FOREIGN KEY (`index_id`) REFERENCES `ecommerce_ecm`.`search`.`index`(`index_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ADD CONSTRAINT `fk_search_index_build_job_triggered_by_index_build_job_id` FOREIGN KEY (`triggered_by_index_build_job_id`) REFERENCES `ecommerce_ecm`.`search`.`index_build_job`(`index_build_job_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ADD CONSTRAINT `fk_search_quality_eval_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `ecommerce_ecm`.`search`.`experiment`(`experiment_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ADD CONSTRAINT `fk_search_quality_eval_query_log_id` FOREIGN KEY (`query_log_id`) REFERENCES `ecommerce_ecm`.`search`.`query_log`(`query_log_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ADD CONSTRAINT `fk_search_quality_eval_baseline_quality_eval_id` FOREIGN KEY (`baseline_quality_eval_id`) REFERENCES `ecommerce_ecm`.`search`.`quality_eval`(`quality_eval_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ADD CONSTRAINT `fk_search_trending_query_index_id` FOREIGN KEY (`index_id`) REFERENCES `ecommerce_ecm`.`search`.`index`(`index_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ADD CONSTRAINT `fk_search_trending_query_prior_period_trending_query_id` FOREIGN KEY (`prior_period_trending_query_id`) REFERENCES `ecommerce_ecm`.`search`.`trending_query`(`trending_query_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ADD CONSTRAINT `fk_search_filter_usage_facet_config_id` FOREIGN KEY (`facet_config_id`) REFERENCES `ecommerce_ecm`.`search`.`facet_config`(`facet_config_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ADD CONSTRAINT `fk_search_filter_usage_query_log_id` FOREIGN KEY (`query_log_id`) REFERENCES `ecommerce_ecm`.`search`.`query_log`(`query_log_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ADD CONSTRAINT `fk_search_filter_usage_previous_filter_usage_id` FOREIGN KEY (`previous_filter_usage_id`) REFERENCES `ecommerce_ecm`.`search`.`filter_usage`(`filter_usage_id`);
ALTER TABLE `ecommerce_ecm`.`search`.`search_session` ADD CONSTRAINT `fk_search_search_session_previous_search_session_id` FOREIGN KEY (`previous_search_session_id`) REFERENCES `ecommerce_ecm`.`search`.`search_session`(`search_session_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`search` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `ecommerce_ecm`.`search` SET TAGS ('dbx_domain' = 'search');
ALTER TABLE `ecommerce_ecm`.`search`.`index` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`search`.`index` SET TAGS ('dbx_subdomain' = 'search_indexing');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `index_id` SET TAGS ('dbx_business_glossary_term' = 'Search Index Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `relevance_config_id` SET TAGS ('dbx_business_glossary_term' = 'Relevance Config Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `superseded_index_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `analyzer` SET TAGS ('dbx_business_glossary_term' = 'Text Analyzer');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `analyzer` SET TAGS ('dbx_value_regex' = 'standard|custom');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `build_status` SET TAGS ('dbx_business_glossary_term' = 'Index Build Status');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `build_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Index Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Indexed Document Count');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `index_code` SET TAGS ('dbx_business_glossary_term' = 'Search Index Code');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `index_description` SET TAGS ('dbx_business_glossary_term' = 'Index Description');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `index_name` SET TAGS ('dbx_business_glossary_term' = 'Search Index Name');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `index_status` SET TAGS ('dbx_business_glossary_term' = 'Search Index Lifecycle Status');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `index_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|building|failed');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `index_type` SET TAGS ('dbx_business_glossary_term' = 'Search Index Type');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `index_type` SET TAGS ('dbx_value_regex' = 'product|content|seller|category');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Index Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `is_public` SET TAGS ('dbx_business_glossary_term' = 'Public Visibility Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Index Language Code');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `last_build_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Build Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Index Locale Code');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `max_result_window` SET TAGS ('dbx_business_glossary_term' = 'Maximum Result Window');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `refresh_interval_minutes` SET TAGS ('dbx_business_glossary_term' = 'Refresh Interval (Minutes)');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `retention_policy_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy (Days)');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `schema_version` SET TAGS ('dbx_business_glossary_term' = 'Index Schema Version');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `schema_version` SET TAGS ('dbx_value_regex' = '^vd+.d+$');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `size_mb` SET TAGS ('dbx_business_glossary_term' = 'Index Size (MB)');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `stemming_enabled` SET TAGS ('dbx_business_glossary_term' = 'Stemming Enabled Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `stop_word_list` SET TAGS ('dbx_business_glossary_term' = 'Stop‑Word List Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `tokenization_strategy` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Strategy');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `tokenization_strategy` SET TAGS ('dbx_value_regex' = 'standard|whitespace|ngram|edge_ngram|custom');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Index Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`index` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` SET TAGS ('dbx_subdomain' = 'search_indexing');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `indexed_document_id` SET TAGS ('dbx_business_glossary_term' = 'Indexed Document Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Source Entity Identifier (Entity ID)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `content_digital_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Zone Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `index_id` SET TAGS ('dbx_business_glossary_term' = 'Index Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `marketplace_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Identifier (Promotion ID)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Identifier (Seller ID)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `previous_version_indexed_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `asin` SET TAGS ('dbx_business_glossary_term' = 'Amazon Standard Identification Number (ASIN)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `asin` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status (Availability)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'in_stock|out_of_stock|preorder|discontinued');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `boost_score` SET TAGS ('dbx_business_glossary_term' = 'Boost Score (Boost)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `brand` SET TAGS ('dbx_business_glossary_term' = 'Brand Name (Brand)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `category_path` SET TAGS ('dbx_business_glossary_term' = 'Category Hierarchy Path (Category Path)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `color` SET TAGS ('dbx_business_glossary_term' = 'Color Attribute (Color)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp (Created)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `dimension_height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height Dimension (Height cm)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `dimension_length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length Dimension (Length cm)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `dimension_width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width Dimension (Width cm)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage (Discount %)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `discount_price` SET TAGS ('dbx_business_glossary_term' = 'Discounted Price Amount (Discount Price)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `ean` SET TAGS ('dbx_business_glossary_term' = 'European Article Number (EAN)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `ean` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `image_url` SET TAGS ('dbx_business_glossary_term' = 'Primary Image URL (Image URL)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `index_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Index Timestamp (Index Time)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `indexed_document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description (Description)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `indexed_document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status (Status)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `indexed_document_status` SET TAGS ('dbx_value_regex' = 'active|suppressed|pending|archived');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `is_promoted` SET TAGS ('dbx_business_glossary_term' = 'Promotion Flag (Promoted)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Search Keywords (Keywords)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code (Lang)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp (Last Update)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Locale Code (Locale)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `locale` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `material` SET TAGS ('dbx_business_glossary_term' = 'Material Attribute (Material)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `personalization_score` SET TAGS ('dbx_business_glossary_term' = 'Personalization Score (Personalization)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `price_amount` SET TAGS ('dbx_business_glossary_term' = 'List Price Amount (Price)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency Code (Currency)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `price_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `rating_average` SET TAGS ('dbx_business_glossary_term' = 'Average Customer Rating (Rating Avg)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `relevance_score` SET TAGS ('dbx_business_glossary_term' = 'Relevance Score (Relevance)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `review_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Reviews (Review Count)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `seller_name` SET TAGS ('dbx_business_glossary_term' = 'Seller Name (Seller Name)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `shipping_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Shipping Weight (Weight kg)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Size Attribute (Size)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `source_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Source Entity Type (Entity Type)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `source_entity_type` SET TAGS ('dbx_value_regex' = 'sku|seller_listing|content_page|category_page');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail Image URL (Thumbnail URL)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Document Title (Title)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `ecommerce_ecm`.`search`.`indexed_document` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` SET TAGS ('dbx_subdomain' = 'user_interaction');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `query_log_id` SET TAGS ('dbx_business_glossary_term' = 'Query Log ID');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `ab_test_variant_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant ID');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `index_id` SET TAGS ('dbx_business_glossary_term' = 'Index Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `refined_from_query_log_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `applied_filters` SET TAGS ('dbx_business_glossary_term' = 'Applied Filters');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'mobile|desktop|tablet|bot');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `event_source_reference` SET TAGS ('dbx_business_glossary_term' = 'Event Source Reference');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `event_type_or_channel` SET TAGS ('dbx_business_glossary_term' = 'Event Type or Channel');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `event_type_or_channel` SET TAGS ('dbx_value_regex' = 'search|autocomplete|suggestion');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `geo_city` SET TAGS ('dbx_business_glossary_term' = 'Geographic City');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `geo_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `ip_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `normalized_query` SET TAGS ('dbx_business_glossary_term' = 'Normalized Query String');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `platform_channel` SET TAGS ('dbx_business_glossary_term' = 'Platform Channel');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `platform_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|api');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `query_language` SET TAGS ('dbx_business_glossary_term' = 'Query Language');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `query_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Query Latency (ms)');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `raw_query` SET TAGS ('dbx_business_glossary_term' = 'Raw Query String');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `result_count` SET TAGS ('dbx_business_glossary_term' = 'Result Count');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `search_version` SET TAGS ('dbx_business_glossary_term' = 'Search Engine Version');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `sort_order` SET TAGS ('dbx_value_regex' = 'relevance|price_asc|price_desc|rating|newest');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`query_log` ALTER COLUMN `zero_result_flag` SET TAGS ('dbx_business_glossary_term' = 'Zero Result Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`search`.`result` SET TAGS ('dbx_subdomain' = 'user_interaction');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `result_id` SET TAGS ('dbx_business_glossary_term' = 'Result ID');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'User ID');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `indexed_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document ID');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `query_log_id` SET TAGS ('dbx_business_glossary_term' = 'Query ID');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `previous_result_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `click_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Click Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `clicked_flag` SET TAGS ('dbx_business_glossary_term' = 'Clicked Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `event_source` SET TAGS ('dbx_business_glossary_term' = 'Event Source');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `location_country` SET TAGS ('dbx_business_glossary_term' = 'Location Country');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `personalization_flag` SET TAGS ('dbx_business_glossary_term' = 'Personalization Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `position` SET TAGS ('dbx_business_glossary_term' = 'Result Position');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `query_text` SET TAGS ('dbx_business_glossary_term' = 'Query Text');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `ranking_algorithm_version` SET TAGS ('dbx_business_glossary_term' = 'Ranking Algorithm Version');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `relevance_score` SET TAGS ('dbx_business_glossary_term' = 'Relevance Score');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `search_query_category` SET TAGS ('dbx_business_glossary_term' = 'Search Query Category');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `sponsored_flag` SET TAGS ('dbx_business_glossary_term' = 'Sponsored Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`result` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` SET TAGS ('dbx_subdomain' = 'user_interaction');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `click_event_id` SET TAGS ('dbx_business_glossary_term' = 'Click Event Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `indexed_document_id` SET TAGS ('dbx_business_glossary_term' = 'Result Document Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `query_log_id` SET TAGS ('dbx_business_glossary_term' = 'Search Query Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `result_id` SET TAGS ('dbx_business_glossary_term' = 'Result Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `previous_click_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `click_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Click Latency (ms)');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `click_rank_score` SET TAGS ('dbx_business_glossary_term' = 'Click Rank Score');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `click_source` SET TAGS ('dbx_business_glossary_term' = 'Click Source');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `click_source` SET TAGS ('dbx_value_regex' = 'search_results|category_page|homepage|email|push_notification');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `click_type` SET TAGS ('dbx_business_glossary_term' = 'Click Type');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `click_type` SET TAGS ('dbx_value_regex' = 'organic|sponsored|recommendation|ad');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `conversion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conversion Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|smart_tv|voice_assistant');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `experiment_variant` SET TAGS ('dbx_business_glossary_term' = 'Experiment Variant Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^((25[0-5]|2[0-4]d|[01]?d?d)(.|$)){4}$');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `is_bot` SET TAGS ('dbx_business_glossary_term' = 'Bot Detection Indicator');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `is_conversion` SET TAGS ('dbx_business_glossary_term' = 'Conversion Indicator');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code (ISO 639‑1)');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `page_section` SET TAGS ('dbx_business_glossary_term' = 'Page Section');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `page_section` SET TAGS ('dbx_value_regex' = 'above_the_fold|below_the_fold|sidebar');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `page_url` SET TAGS ('dbx_business_glossary_term' = 'Page URL');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `personalization_flag` SET TAGS ('dbx_business_glossary_term' = 'Personalization Indicator');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `recommendation_widget_code` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Widget Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `referrer_url` SET TAGS ('dbx_business_glossary_term' = 'Referrer URL');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `result_position` SET TAGS ('dbx_business_glossary_term' = 'Result Position');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `search_query` SET TAGS ('dbx_business_glossary_term' = 'Search Query Text');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`click_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` SET TAGS ('dbx_subdomain' = 'result_relevance');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `relevance_config_id` SET TAGS ('dbx_business_glossary_term' = 'Relevance Configuration ID');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `content_ab_test_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test ID');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `superseded_relevance_config_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `active_version_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Version Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `bm25_b` SET TAGS ('dbx_business_glossary_term' = 'BM25 B Parameter');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `bm25_k1` SET TAGS ('dbx_business_glossary_term' = 'BM25 K1 Parameter');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `config_code` SET TAGS ('dbx_business_glossary_term' = 'Relevance Configuration Code');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `config_name` SET TAGS ('dbx_business_glossary_term' = 'Relevance Configuration Name');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `config_type` SET TAGS ('dbx_business_glossary_term' = 'Relevance Configuration Type');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `config_type` SET TAGS ('dbx_value_regex' = 'search|recommendation|personalization');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `enable_spellcheck` SET TAGS ('dbx_business_glossary_term' = 'Enable Spellcheck');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `enable_synonyms` SET TAGS ('dbx_business_glossary_term' = 'Enable Synonym Expansion');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `field_boost_brand` SET TAGS ('dbx_business_glossary_term' = 'Brand Field Boost Weight');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `field_boost_category` SET TAGS ('dbx_business_glossary_term' = 'Category Field Boost Weight');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `field_boost_description` SET TAGS ('dbx_business_glossary_term' = 'Description Field Boost Weight');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `field_boost_title` SET TAGS ('dbx_business_glossary_term' = 'Title Field Boost Weight');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `freshness_decay_days` SET TAGS ('dbx_business_glossary_term' = 'Freshness Decay Start Days');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `freshness_decay_rate` SET TAGS ('dbx_business_glossary_term' = 'Freshness Decay Rate');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Configuration');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Locale');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `max_results` SET TAGS ('dbx_business_glossary_term' = 'Maximum Search Results');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `min_query_length` SET TAGS ('dbx_business_glossary_term' = 'Minimum Query Length');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Configuration Notes');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `personalization_weight` SET TAGS ('dbx_business_glossary_term' = 'Personalization Weight');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `popularity_boost_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Popularity Boost Coefficient');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `ranking_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Ranking Algorithm');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `ranking_algorithm` SET TAGS ('dbx_value_regex' = 'bm25|tfidf|neural');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `relevance_config_description` SET TAGS ('dbx_business_glossary_term' = 'Configuration Description');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `relevance_config_status` SET TAGS ('dbx_business_glossary_term' = 'Relevance Configuration Status');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `relevance_config_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|archived|pending');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `rollout_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rollout Percentage');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Configuration Updated By');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `use_tfidf` SET TAGS ('dbx_business_glossary_term' = 'Use TF‑IDF Scoring');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Relevance Configuration Version Number');
ALTER TABLE `ecommerce_ecm`.`search`.`relevance_config` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Configuration Created By');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` SET TAGS ('dbx_subdomain' = 'result_relevance');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `ranking_model_id` SET TAGS ('dbx_business_glossary_term' = 'Ranking Model ID');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `analytical_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Training Dataset ID');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `index_id` SET TAGS ('dbx_business_glossary_term' = 'Index Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment ID');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Model Owner ID');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `superseded_ranking_model_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `artifact_location` SET TAGS ('dbx_business_glossary_term' = 'Model Artifact Location');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `champion_flag` SET TAGS ('dbx_business_glossary_term' = 'Champion Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `compliance_gdpr` SET TAGS ('dbx_business_glossary_term' = 'GDPR Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `compliance_pci` SET TAGS ('dbx_business_glossary_term' = 'PCI Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `deployment_status` SET TAGS ('dbx_value_regex' = 'champion|challenger|inactive');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `evaluation_metric` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Metric');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `evaluation_metric` SET TAGS ('dbx_value_regex' = 'ndcg|mrr|map');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `evaluation_score` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Score');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `feature_set_version` SET TAGS ('dbx_business_glossary_term' = 'Feature Set Version');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `hyperparameters` SET TAGS ('dbx_business_glossary_term' = 'Model Hyperparameters');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `last_deployed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Deployed Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `model_code` SET TAGS ('dbx_business_glossary_term' = 'Ranking Model Code');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `model_deployment_region` SET TAGS ('dbx_business_glossary_term' = 'Model Deployment Region');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `model_deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Model Deprecation Date');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `model_framework` SET TAGS ('dbx_business_glossary_term' = 'Model Framework');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `model_framework` SET TAGS ('dbx_value_regex' = 'tensorflow|pytorch|xgboost|lightgbm');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `model_input_schema_version` SET TAGS ('dbx_business_glossary_term' = 'Model Input Schema Version');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `model_last_evaluation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Evaluation Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `model_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Model Latency (ms)');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `model_output_schema_version` SET TAGS ('dbx_business_glossary_term' = 'Model Output Schema Version');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `model_precision` SET TAGS ('dbx_business_glossary_term' = 'Model Precision');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `model_recall` SET TAGS ('dbx_business_glossary_term' = 'Model Recall');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `model_retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Model Retirement Date');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `model_throughput_qps` SET TAGS ('dbx_business_glossary_term' = 'Model Throughput (QPS)');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `model_training_compute` SET TAGS ('dbx_business_glossary_term' = 'Model Training Compute Specification');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `model_training_cost` SET TAGS ('dbx_business_glossary_term' = 'Model Training Cost');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `model_training_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Ranking Model Type');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'ltr|bm25|neural|hybrid');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `ranking_model_description` SET TAGS ('dbx_business_glossary_term' = 'Ranking Model Description');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `ranking_model_name` SET TAGS ('dbx_business_glossary_term' = 'Ranking Model Name');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `ranking_model_status` SET TAGS ('dbx_business_glossary_term' = 'Ranking Model Lifecycle Status');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `ranking_model_status` SET TAGS ('dbx_value_regex' = 'development|testing|staging|production|deprecated|retired');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `training_data_source` SET TAGS ('dbx_business_glossary_term' = 'Training Data Source');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `training_data_volume` SET TAGS ('dbx_business_glossary_term' = 'Training Data Volume');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `training_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Training End Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `training_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Training Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`ranking_model` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Ranking Model Version');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` SET TAGS ('dbx_subdomain' = 'result_relevance');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment ID');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Owner ID');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `index_id` SET TAGS ('dbx_business_glossary_term' = 'Index Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `price_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Price Experiment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `iterated_from_experiment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `control_definition` SET TAGS ('dbx_business_glossary_term' = 'Control Arm Definition');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Experiment Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Experiment End Date');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `experiment_code` SET TAGS ('dbx_business_glossary_term' = 'Experiment Code');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `experiment_name` SET TAGS ('dbx_business_glossary_term' = 'Experiment Name');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `experiment_scope` SET TAGS ('dbx_business_glossary_term' = 'Experiment Scope');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `experiment_scope` SET TAGS ('dbx_value_regex' = 'global|category|brand|segment');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `experiment_status` SET TAGS ('dbx_business_glossary_term' = 'Experiment Status');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `experiment_status` SET TAGS ('dbx_value_regex' = 'draft|running|paused|completed|cancelled');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `experiment_type` SET TAGS ('dbx_business_glossary_term' = 'Experiment Type');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `experiment_type` SET TAGS ('dbx_value_regex' = 'ab_test|multivariate|personalization|ranking_change');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `hypothesis` SET TAGS ('dbx_business_glossary_term' = 'Experiment Hypothesis');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `is_randomized` SET TAGS ('dbx_business_glossary_term' = 'Is Randomized Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Experiment Notes');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Experiment Platform');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `platform` SET TAGS ('dbx_value_regex' = 'search|recommendation|ads');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `primary_success_metric` SET TAGS ('dbx_business_glossary_term' = 'Primary Success Metric');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Experiment Start Date');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `success_metric_target` SET TAGS ('dbx_business_glossary_term' = 'Success Metric Target Value');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `target_audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `traffic_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Traffic Allocation Percentage');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `treatment_definition` SET TAGS ('dbx_business_glossary_term' = 'Treatment Arm Definition');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `treatment_definition` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `treatment_definition` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Experiment Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Experiment Version');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` SET TAGS ('dbx_subdomain' = 'result_relevance');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `experiment_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Assignment ID');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment ID');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `reassigned_from_experiment_assignment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `arm` SET TAGS ('dbx_business_glossary_term' = 'Experiment Arm');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `arm` SET TAGS ('dbx_value_regex' = 'control|treatment');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'cookie_hash|user_id_hash|segment_based');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'assigned|failed|pending');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'mobile|desktop|tablet');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'search_experiment_assignment');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `experiment_owner` SET TAGS ('dbx_business_glossary_term' = 'Experiment Owner');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `geo_country` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'web|app|api');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`experiment_assignment` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` SET TAGS ('dbx_subdomain' = 'result_relevance');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `query_rewrite_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Query Rewrite Rule ID');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `index_id` SET TAGS ('dbx_business_glossary_term' = 'Index Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `chained_query_rewrite_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `case_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Case Sensitive Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `execution_count` SET TAGS ('dbx_business_glossary_term' = 'Execution Count');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `is_regex` SET TAGS ('dbx_business_glossary_term' = 'Is Regex Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `language_locale` SET TAGS ('dbx_business_glossary_term' = 'Language Locale');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `language_locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `last_executed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Executed Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Rule Priority');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `query_rewrite_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `query_rewrite_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `query_rewrite_rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `query_rewrite_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `query_rewrite_rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `replacement` SET TAGS ('dbx_business_glossary_term' = 'Replacement Text');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Rule Type');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'synonym|spell_correction|stemming|stopword|expansion');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `trigger_pattern` SET TAGS ('dbx_business_glossary_term' = 'Trigger Pattern');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`query_rewrite_rule` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Rule Version');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` SET TAGS ('dbx_subdomain' = 'search_indexing');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `synonym_set_id` SET TAGS ('dbx_business_glossary_term' = 'Synonym Set Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `index_id` SET TAGS ('dbx_business_glossary_term' = 'Index Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `parent_synonym_set_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `directionality` SET TAGS ('dbx_business_glossary_term' = 'Synonym Directionality');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `directionality` SET TAGS ('dbx_value_regex' = 'unidirectional|bidirectional');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `domain_context` SET TAGS ('dbx_business_glossary_term' = 'Domain Context');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `domain_context` SET TAGS ('dbx_value_regex' = 'electronics|fashion|grocery|home|beauty|sports');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `is_case_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Case Sensitivity Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `is_exact_match` SET TAGS ('dbx_business_glossary_term' = 'Exact Match Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `language_locale` SET TAGS ('dbx_business_glossary_term' = 'Language Locale');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `language_locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Synonym Set Notes');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `set_code` SET TAGS ('dbx_business_glossary_term' = 'Synonym Set Code');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `set_name` SET TAGS ('dbx_business_glossary_term' = 'Synonym Set Name');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `synonym_set_description` SET TAGS ('dbx_business_glossary_term' = 'Synonym Set Description');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `synonym_set_status` SET TAGS ('dbx_business_glossary_term' = 'Synonym Set Status');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `synonym_set_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `synonyms` SET TAGS ('dbx_business_glossary_term' = 'Synonym Terms List');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `term_count` SET TAGS ('dbx_business_glossary_term' = 'Synonym Term Count');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`synonym_set` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Synonym Set Version');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` SET TAGS ('dbx_subdomain' = 'search_indexing');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `facet_config_id` SET TAGS ('dbx_business_glossary_term' = 'Facet Configuration ID');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `index_id` SET TAGS ('dbx_business_glossary_term' = 'Index Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `parent_facet_config_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `applicable_category` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Category');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `applicable_index` SET TAGS ('dbx_business_glossary_term' = 'Applicable Search Index');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `audit_created_by` SET TAGS ('dbx_business_glossary_term' = 'Audit Created By User');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order Sequence');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `display_style` SET TAGS ('dbx_business_glossary_term' = 'Display Style for Facet UI');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `display_style` SET TAGS ('dbx_value_regex' = 'dropdown|list|slider|swatch');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `facet_config_description` SET TAGS ('dbx_business_glossary_term' = 'Facet Description');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `facet_config_name` SET TAGS ('dbx_business_glossary_term' = 'Facet Display Name');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `facet_config_status` SET TAGS ('dbx_business_glossary_term' = 'Facet Configuration Status');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `facet_config_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `facet_key` SET TAGS ('dbx_business_glossary_term' = 'Facet Key Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `facet_type` SET TAGS ('dbx_business_glossary_term' = 'Facet Type (e.g., Checkbox, Range Slider, Color Swatch, Rating)');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `facet_type` SET TAGS ('dbx_value_regex' = 'checkbox|range|color|rating');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Facet Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `is_multi_select` SET TAGS ('dbx_business_glossary_term' = 'Multi‑Select Capability Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `is_personalized` SET TAGS ('dbx_business_glossary_term' = 'Personalized Facet Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `is_required` SET TAGS ('dbx_business_glossary_term' = 'Required Facet Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `is_searchable` SET TAGS ('dbx_business_glossary_term' = 'Searchable Facet Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `max_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Facet Value (Range Facet)');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `max_values_shown` SET TAGS ('dbx_business_glossary_term' = 'Maximum Values Shown');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `min_doc_frequency` SET TAGS ('dbx_business_glossary_term' = 'Minimum Document Frequency Threshold');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `min_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Facet Value (Range Facet)');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `value_step` SET TAGS ('dbx_business_glossary_term' = 'Facet Value Step Increment');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version Number');
ALTER TABLE `ecommerce_ecm`.`search`.`facet_config` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` SET TAGS ('dbx_subdomain' = 'result_relevance');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ALTER COLUMN `merchandising_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Rule ID');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ALTER COLUMN `indexed_document_id` SET TAGS ('dbx_business_glossary_term' = 'Target Document ID');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ALTER COLUMN `overrides_merchandising_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ALTER COLUMN `boost_delta` SET TAGS ('dbx_business_glossary_term' = 'Boost Delta');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ALTER COLUMN `bury_delta` SET TAGS ('dbx_business_glossary_term' = 'Bury Delta');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ALTER COLUMN `merchandising_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Rule Status');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ALTER COLUMN `merchandising_rule_status` SET TAGS ('dbx_value_regex' = 'draft|pending|active|inactive|retired');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ALTER COLUMN `priority_score` SET TAGS ('dbx_business_glossary_term' = 'Priority Score');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Rule Code');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Rule Name');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Rule Type');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'pin|boost|bury|block|redirect');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ALTER COLUMN `trigger_category` SET TAGS ('dbx_business_glossary_term' = 'Trigger Category');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ALTER COLUMN `trigger_query` SET TAGS ('dbx_business_glossary_term' = 'Trigger Query');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`merchandising_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` SET TAGS ('dbx_subdomain' = 'result_relevance');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `recommendation_model_id` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Model ID');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `index_id` SET TAGS ('dbx_business_glossary_term' = 'Index Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Training Data Snapshot ID');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `superseded_recommendation_model_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `challenger_flag` SET TAGS ('dbx_business_glossary_term' = 'Challenger Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `champion_flag` SET TAGS ('dbx_business_glossary_term' = 'Champion Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `data_privacy_level` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Level');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `data_privacy_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `deployment_context` SET TAGS ('dbx_business_glossary_term' = 'Deployment Context');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `deployment_context` SET TAGS ('dbx_value_regex' = 'pdp_widget|cart_page|homepage|email');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `feature_set_version` SET TAGS ('dbx_business_glossary_term' = 'Feature Set Version');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `hyperparameters` SET TAGS ('dbx_business_glossary_term' = 'Hyperparameters');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `is_experimental` SET TAGS ('dbx_business_glossary_term' = 'Experimental Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `last_deployed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Deployed Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `metric_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Metric Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `metric_value` SET TAGS ('dbx_business_glossary_term' = 'Metric Value');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `model_artifact_uri` SET TAGS ('dbx_business_glossary_term' = 'Model Artifact URI');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `model_code` SET TAGS ('dbx_business_glossary_term' = 'Model Code');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `model_cpu_cores` SET TAGS ('dbx_business_glossary_term' = 'Model CPU Cores');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `model_description` SET TAGS ('dbx_business_glossary_term' = 'Model Description');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `model_framework` SET TAGS ('dbx_business_glossary_term' = 'Model Framework');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `model_gpu_required` SET TAGS ('dbx_business_glossary_term' = 'GPU Requirement Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `model_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Model Latency (ms)');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `model_memory_mb` SET TAGS ('dbx_business_glossary_term' = 'Model Memory (MB)');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `model_owner` SET TAGS ('dbx_business_glossary_term' = 'Model Owner');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `model_retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Model Retirement Date');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `model_retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Model Retirement Reason');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `model_status` SET TAGS ('dbx_business_glossary_term' = 'Model Status');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `model_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|testing');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `model_tags` SET TAGS ('dbx_business_glossary_term' = 'Model Tags');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `model_training_environment` SET TAGS ('dbx_business_glossary_term' = 'Model Training Environment');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Model Type');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'collaborative|content_based|hybrid|trending|frequently_bought|similar_items');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `performance_metric` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `recommendation_model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval ID');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `training_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Training Algorithm');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `training_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Training End Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `training_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Training Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_model` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` SET TAGS ('dbx_subdomain' = 'user_interaction');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `recommendation_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Event ID');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `ab_test_variant_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant ID');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment ID');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `indexed_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document ID');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `recommendation_model_id` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Model ID');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `previous_recommendation_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `algorithm_version` SET TAGS ('dbx_business_glossary_term' = 'Algorithm Version');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `click_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Click Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `conversion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conversion Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'product|category|brand|content');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'impression|click|conversion');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `is_clicked` SET TAGS ('dbx_business_glossary_term' = 'Clicked Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `is_converted` SET TAGS ('dbx_business_glossary_term' = 'Conversion Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Latency (ms)');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `location_country` SET TAGS ('dbx_business_glossary_term' = 'Location Country');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `personalization_flag` SET TAGS ('dbx_business_glossary_term' = 'Personalization Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `placement` SET TAGS ('dbx_business_glossary_term' = 'Placement');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `placement` SET TAGS ('dbx_value_regex' = 'homepage|pdp|cart|email|search');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `recommendation_event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `recommendation_event_status` SET TAGS ('dbx_value_regex' = 'served|failed|skipped');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `recommendation_list_json` SET TAGS ('dbx_business_glossary_term' = 'Recommendation List JSON');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `recommendation_position` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Position');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `recommendation_score` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Score');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `request_reference` SET TAGS ('dbx_business_glossary_term' = 'Request ID');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `surface` SET TAGS ('dbx_business_glossary_term' = 'Surface');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `surface` SET TAGS ('dbx_value_regex' = 'web|mobile|app|email');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`recommendation_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` SET TAGS ('dbx_subdomain' = 'result_relevance');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `personalization_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Personalization Profile ID');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `ab_test_variant_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant ID');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `merged_from_personalization_profile_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `behavioral_vector` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Interest Vector');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `click_count_last_30d` SET TAGS ('dbx_business_glossary_term' = '30‑Day Click Count');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `contact_method` SET TAGS ('dbx_value_regex' = 'email|sms|push|none');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `conversion_rate_estimate` SET TAGS ('dbx_business_glossary_term' = 'Estimated Conversion Rate');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'mobile|desktop|tablet');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `gdpr_opt_out` SET TAGS ('dbx_business_glossary_term' = 'GDPR Opt‑Out Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `interest_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Interest Score');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `is_anonymous` SET TAGS ('dbx_business_glossary_term' = 'Anonymous Session Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `last_model_update` SET TAGS ('dbx_business_glossary_term' = 'Model Last Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `location_country` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `location_region` SET TAGS ('dbx_business_glossary_term' = 'Region/State Code');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Personalization Model Version');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `personalization_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Profile Lifecycle Status');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `personalization_profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|deleted');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `preferred_brand_codes` SET TAGS ('dbx_business_glossary_term' = 'Preferred Brand Codes');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `preferred_category_codes` SET TAGS ('dbx_business_glossary_term' = 'Preferred Category Codes');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `price_range_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Preferred Price');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `price_range_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Preferred Price');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `privacy_consent_given` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Given Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Profile Name');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `recently_viewed_skus` SET TAGS ('dbx_business_glossary_term' = 'Recently Viewed SKU List');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `recommendation_score` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Relevance Score');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `search_query_count_last_30d` SET TAGS ('dbx_business_glossary_term' = '30‑Day Search Query Count');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Type');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session End Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`personalization_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` SET TAGS ('dbx_subdomain' = 'result_relevance');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `behavioral_signal_id` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Signal ID');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `indexed_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document ID');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `search_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `aggregated_from_behavioral_signal_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `behavioral_signal_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `behavioral_signal_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collection Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `is_bot` SET TAGS ('dbx_business_glossary_term' = 'Bot Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `location_country` SET TAGS ('dbx_business_glossary_term' = 'Location Country (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `personalization_flag` SET TAGS ('dbx_business_glossary_term' = 'Personalization Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `recency_weighted_value` SET TAGS ('dbx_business_glossary_term' = 'Recency Weighted Value');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `signal_count` SET TAGS ('dbx_business_glossary_term' = 'Signal Count');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `signal_type` SET TAGS ('dbx_business_glossary_term' = 'Signal Type (Signal Type)');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `signal_type` SET TAGS ('dbx_value_regex' = 'view|add_to_cart|purchase|wishlist|dwell|scroll');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `signal_weight` SET TAGS ('dbx_business_glossary_term' = 'Signal Weight');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'clickstream|recommendation_engine|marketing_platform');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `window_end` SET TAGS ('dbx_business_glossary_term' = 'Window End Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`behavioral_signal` ALTER COLUMN `window_start` SET TAGS ('dbx_business_glossary_term' = 'Window Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` SET TAGS ('dbx_subdomain' = 'result_relevance');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `zero_result_query_id` SET TAGS ('dbx_business_glossary_term' = 'Zero Result Query ID');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `ab_test_variant_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant ID');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `index_id` SET TAGS ('dbx_business_glossary_term' = 'Index Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `retry_of_zero_result_query_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `applied_filters` SET TAGS ('dbx_business_glossary_term' = 'Applied Filters JSON');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `ip_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `is_bot` SET TAGS ('dbx_business_glossary_term' = 'Bot Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `language_locale` SET TAGS ('dbx_business_glossary_term' = 'Language Locale');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `language_locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `location_country` SET TAGS ('dbx_business_glossary_term' = 'Location Country (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `normalized_query` SET TAGS ('dbx_business_glossary_term' = 'Normalized Query Text');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `platform_channel` SET TAGS ('dbx_business_glossary_term' = 'Platform Channel');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `platform_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|api|voice|chat');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `query_category` SET TAGS ('dbx_business_glossary_term' = 'Query Category');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `query_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Query Latency (ms)');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `query_text` SET TAGS ('dbx_business_glossary_term' = 'Raw Query Text');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `request_reference` SET TAGS ('dbx_business_glossary_term' = 'Request Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `result_count` SET TAGS ('dbx_business_glossary_term' = 'Result Count');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `search_engine_instance_code` SET TAGS ('dbx_business_glossary_term' = 'Search Engine Instance ID');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `search_version` SET TAGS ('dbx_business_glossary_term' = 'Search Engine Version');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`zero_result_query` ALTER COLUMN `zero_result_flag` SET TAGS ('dbx_business_glossary_term' = 'Zero Result Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` SET TAGS ('dbx_subdomain' = 'user_interaction');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `autocomplete_suggestion_id` SET TAGS ('dbx_business_glossary_term' = 'Autocomplete Suggestion ID');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `ab_test_variant_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant ID');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `index_id` SET TAGS ('dbx_business_glossary_term' = 'Index Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `parent_autocomplete_suggestion_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `autocomplete_suggestion_status` SET TAGS ('dbx_business_glossary_term' = 'Suggestion Status');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `autocomplete_suggestion_status` SET TAGS ('dbx_value_regex' = 'active|inactive');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `click_through_rate` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Rate (CTR)');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `display_rank` SET TAGS ('dbx_business_glossary_term' = 'Display Rank');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `editorial_source` SET TAGS ('dbx_business_glossary_term' = 'Editorial Source');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `impression_count` SET TAGS ('dbx_business_glossary_term' = 'Impression Count');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `is_editorial` SET TAGS ('dbx_business_glossary_term' = 'Editorial Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `is_personalized` SET TAGS ('dbx_business_glossary_term' = 'Personalization Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `language_locale` SET TAGS ('dbx_business_glossary_term' = 'Language Locale');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `language_locale` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}_[A-Z]{2}$');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `last_refreshed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Refreshed Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `personalization_source` SET TAGS ('dbx_business_glossary_term' = 'Personalization Source');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `popularity_score` SET TAGS ('dbx_business_glossary_term' = 'Popularity Score');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `relevance_score` SET TAGS ('dbx_business_glossary_term' = 'Relevance Score');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `suggestion_text` SET TAGS ('dbx_business_glossary_term' = 'Suggestion Text');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `suggestion_type` SET TAGS ('dbx_business_glossary_term' = 'Suggestion Type (QUERY_COMPLETION, POPULAR_SEARCH, TRENDING, CATEGORY, BRAND)');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `suggestion_type` SET TAGS ('dbx_value_regex' = 'query_completion|popular_search|trending|category|brand');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `trigger_prefix` SET TAGS ('dbx_business_glossary_term' = 'Trigger Prefix');
ALTER TABLE `ecommerce_ecm`.`search`.`autocomplete_suggestion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` SET TAGS ('dbx_subdomain' = 'search_indexing');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `redirect_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Redirect Rule ID');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `index_id` SET TAGS ('dbx_business_glossary_term' = 'Reference to index');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `fallback_redirect_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `destination_url` SET TAGS ('dbx_business_glossary_term' = 'Destination URL');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `is_case_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Case Sensitivity Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `is_regex` SET TAGS ('dbx_business_glossary_term' = 'Is Regex Pattern');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `last_tested_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Tested Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `match_type` SET TAGS ('dbx_business_glossary_term' = 'Match Type');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `match_type` SET TAGS ('dbx_value_regex' = 'exact|contains|starts_with|regex');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Redirect Rule Priority');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `query_pattern` SET TAGS ('dbx_business_glossary_term' = 'Trigger Query Pattern');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `redirect_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Redirect Rule Code');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `redirect_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Redirect Rule Description');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `redirect_rule_name` SET TAGS ('dbx_business_glossary_term' = 'Redirect Rule Name');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `redirect_type` SET TAGS ('dbx_business_glossary_term' = 'Redirect Type (HTTP Status Code)');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `redirect_type` SET TAGS ('dbx_value_regex' = '301|302');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Redirect Rule Category');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_value_regex' = 'navigational|promotional|campaign|brand');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Redirect Rule Lifecycle Status');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'draft|active|retired|archived');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'search_engine|cms|marketing|seller_portal');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|warning');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`redirect_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` SET TAGS ('dbx_subdomain' = 'search_indexing');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ALTER COLUMN `index_build_job_id` SET TAGS ('dbx_business_glossary_term' = 'Index Build Job ID');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ALTER COLUMN `index_id` SET TAGS ('dbx_business_glossary_term' = 'Search Index ID');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ALTER COLUMN `triggered_by_index_build_job_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ALTER COLUMN `documents_failed` SET TAGS ('dbx_business_glossary_term' = 'Documents Failed Count');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ALTER COLUMN `documents_processed` SET TAGS ('dbx_business_glossary_term' = 'Documents Processed Count');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Job End Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ALTER COLUMN `error_summary` SET TAGS ('dbx_business_glossary_term' = 'Error Summary');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ALTER COLUMN `index_build_job_status` SET TAGS ('dbx_business_glossary_term' = 'Job Status');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ALTER COLUMN `index_build_job_status` SET TAGS ('dbx_value_regex' = 'pending|running|success|failed|canceled');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ALTER COLUMN `initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Initiated By User ID');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ALTER COLUMN `is_real_time` SET TAGS ('dbx_business_glossary_term' = 'Real‑Time Job Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ALTER COLUMN `job_type` SET TAGS ('dbx_business_glossary_term' = 'Job Type');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ALTER COLUMN `job_type` SET TAGS ('dbx_value_regex' = 'full|incremental|real_time');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ALTER COLUMN `job_version` SET TAGS ('dbx_business_glossary_term' = 'Job Version');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Job Notes');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Job Priority Level');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Job Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ALTER COLUMN `trigger_source` SET TAGS ('dbx_business_glossary_term' = 'Trigger Source');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ALTER COLUMN `trigger_source` SET TAGS ('dbx_value_regex' = 'scheduled|event|manual');
ALTER TABLE `ecommerce_ecm`.`search`.`index_build_job` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` SET TAGS ('dbx_subdomain' = 'result_relevance');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `quality_eval_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Evaluation ID');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `ab_test_variant_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `query_log_id` SET TAGS ('dbx_business_glossary_term' = 'Search Query Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `baseline_quality_eval_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score of Evaluation');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `evaluation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Methodology (e.g., NDCG, MRR, Precision@K)');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `evaluation_methodology` SET TAGS ('dbx_value_regex' = 'ndcg|mrr|precision_at_k|recall_at_k|map|click_through_rate');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `evaluation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `evaluator_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Type (Human or Automated)');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `evaluator_type` SET TAGS ('dbx_value_regex' = 'human|automated');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `is_successful` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Success Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Ranking Model Version');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `overall_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Quality Score');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `quality_eval_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `quality_eval_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `query_string` SET TAGS ('dbx_business_glossary_term' = 'Search Query String');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `ranking_algorithm_version` SET TAGS ('dbx_business_glossary_term' = 'Ranking Algorithm Version');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `rated_document_ids` SET TAGS ('dbx_business_glossary_term' = 'Rated Document Identifiers');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `rated_document_positions` SET TAGS ('dbx_business_glossary_term' = 'Rated Document Positions');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `relevance_grades` SET TAGS ('dbx_business_glossary_term' = 'Relevance Grades per Document');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Evaluation');
ALTER TABLE `ecommerce_ecm`.`search`.`quality_eval` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` SET TAGS ('dbx_subdomain' = 'result_relevance');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `trending_query_id` SET TAGS ('dbx_business_glossary_term' = 'Trending Query ID');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `ab_test_variant_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant ID');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `index_id` SET TAGS ('dbx_business_glossary_term' = 'Index Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Top Product SKU');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `prior_period_trending_query_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `geo_city` SET TAGS ('dbx_business_glossary_term' = 'Geographic City');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `geo_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `is_bot` SET TAGS ('dbx_business_glossary_term' = 'Bot Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `is_promoted` SET TAGS ('dbx_business_glossary_term' = 'Promoted Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `is_seasonal` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `last_seen_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Seen Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Locale');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `normalized_query` SET TAGS ('dbx_business_glossary_term' = 'Normalized Query Text');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `period_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Period End Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `period_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Period Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Trend Period Type');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `query_hash` SET TAGS ('dbx_business_glossary_term' = 'Query Hash');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `query_text` SET TAGS ('dbx_business_glossary_term' = 'Raw Query Text');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `query_volume` SET TAGS ('dbx_business_glossary_term' = 'Query Volume');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `related_product_count` SET TAGS ('dbx_business_glossary_term' = 'Related Product Count');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `search_engine_version` SET TAGS ('dbx_business_glossary_term' = 'Search Engine Version');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Query Source');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'web|mobile|app');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `trend_classification` SET TAGS ('dbx_business_glossary_term' = 'Trend Classification');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `trend_classification` SET TAGS ('dbx_value_regex' = 'rising|peak|declining|stable');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `trending_query_category` SET TAGS ('dbx_business_glossary_term' = 'Associated Category');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `user_segment` SET TAGS ('dbx_business_glossary_term' = 'User Segment');
ALTER TABLE `ecommerce_ecm`.`search`.`trending_query` ALTER COLUMN `volume_change_pct` SET TAGS ('dbx_business_glossary_term' = 'Volume Change Percentage');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` SET TAGS ('dbx_subdomain' = 'user_interaction');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `filter_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Filter Usage ID');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `ab_test_variant_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant ID');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `facet_config_id` SET TAGS ('dbx_business_glossary_term' = 'Facet Configuration ID');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `query_log_id` SET TAGS ('dbx_business_glossary_term' = 'Search Query ID');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `previous_filter_usage_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Filter Usage Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `filter_action` SET TAGS ('dbx_business_glossary_term' = 'Filter Action');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `filter_action` SET TAGS ('dbx_value_regex' = 'apply|remove');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `filter_name` SET TAGS ('dbx_business_glossary_term' = 'Filter Name');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `filter_value` SET TAGS ('dbx_business_glossary_term' = 'Filter Value');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `is_bot` SET TAGS ('dbx_business_glossary_term' = 'Bot Flag');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `location_country` SET TAGS ('dbx_business_glossary_term' = 'Location Country');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `result_count_after` SET TAGS ('dbx_business_glossary_term' = 'Result Count After Filter');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `result_count_before` SET TAGS ('dbx_business_glossary_term' = 'Result Count Before Filter');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `result_delta` SET TAGS ('dbx_business_glossary_term' = 'Result Count Delta');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `search_version` SET TAGS ('dbx_business_glossary_term' = 'Search Engine Version');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Search Session ID');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `session_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Session Duration (Seconds)');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session End Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Start Timestamp');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`filter_usage` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`search_session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`search`.`search_session` SET TAGS ('dbx_subdomain' = 'user_interaction');
ALTER TABLE `ecommerce_ecm`.`search`.`search_session` ALTER COLUMN `search_session_id` SET TAGS ('dbx_business_glossary_term' = 'Search Session Identifier');
ALTER TABLE `ecommerce_ecm`.`search`.`search_session` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`search_session` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`search_session` ALTER COLUMN `previous_search_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`search_session` ALTER COLUMN `device_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`search_session` ALTER COLUMN `device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`search_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`search`.`search_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
