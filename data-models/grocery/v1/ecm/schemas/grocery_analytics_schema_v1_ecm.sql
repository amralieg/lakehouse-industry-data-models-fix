-- Schema for Domain: analytics | Business: Grocery | Version: v1_ecm
-- Generated on: 2026-05-04 18:34:55

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `grocery_ecm`.`analytics` COMMENT 'Enterprise analytics and reporting domain managing KPI definitions, metric calculations, dashboards, data quality rules, and business intelligence artifacts for comp sales, same-store sales, basket analysis, and category performance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`kpi_definition` (
    `kpi_definition_id` BIGINT COMMENT 'Unique surrogate key for each KPI definition record.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: KPIs are owned by a specific associate (e.g., senior analyst) for accountability; linking enables KPI ownership reporting.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: KPIs are defined to monitor performance of compliance programs; linking KPI to its governing program enables program‑level scorecards.',
    `parent_kpi_definition_id` BIGINT COMMENT 'Self-referencing FK on kpi_definition (parent_kpi_definition_id)',
    `calculation_methodology` STRING COMMENT 'Plain‑text description of the formula or logic used to compute the KPI.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the KPI definition record was first created.',
    `data_quality_rule` STRING COMMENT 'Rule or constraint ensuring data quality for the KPI (e.g., non‑null sales amount).',
    `data_source` STRING COMMENT 'Primary source system or data domain feeding the KPI (e.g., POS, ERP, WMS).',
    `effective_from` DATE COMMENT 'Date when the KPI definition becomes active.',
    `effective_until` DATE COMMENT 'Date when the KPI definition is retired or superseded (null if indefinite).',
    `kpi_definition_category` STRING COMMENT 'High‑level business domain the KPI belongs to.. Valid values are `sales|inventory|customer|finance|operations|loyalty`',
    `kpi_definition_code` STRING COMMENT 'Business identifier or short code for the KPI (e.g., COMP_SALES_QTR).',
    `kpi_definition_description` STRING COMMENT 'Detailed narrative describing the KPI purpose and calculation context.',
    `kpi_definition_name` STRING COMMENT 'Human‑readable name of the KPI as used in reports and dashboards.',
    `kpi_definition_status` STRING COMMENT 'Current lifecycle state of the KPI definition.. Valid values are `active|inactive|deprecated|draft|pending`',
    `last_review_date` DATE COMMENT 'Date when the KPI definition was last reviewed for relevance or accuracy.',
    `owner` STRING COMMENT 'Business owner or responsible team for the KPI.',
    `reporting_frequency` STRING COMMENT 'How often the KPI is calculated and reported.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `strategic_objective` STRING COMMENT 'Enterprise strategic goal that the KPI supports (e.g., Increase Same‑Store Sales).',
    `target_threshold` DECIMAL(18,2) COMMENT 'Acceptable lower/upper threshold range for the KPI; stored as a single numeric bound when only one side is defined.',
    `target_value` DECIMAL(18,2) COMMENT 'Target or goal value for the KPI (e.g., 5.0 for 5%).',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the KPI value (e.g., percent, dollars, count).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the KPI definition.',
    `version` STRING COMMENT 'Version identifier for the KPI definition (e.g., v1.0, v2.1).',
    CONSTRAINT pk_kpi_definition PRIMARY KEY(`kpi_definition_id`)
) COMMENT 'Master catalog of all Key Performance Indicators (KPIs) defined and governed by the enterprise analytics team at Grocery. Captures KPI name, business owner, calculation methodology, unit of measure, target thresholds, reporting frequency, and alignment to strategic objectives. Serves as the authoritative reference for all KPI metadata used across dashboards, scorecards, and automated reporting. Covers comp sales, same-store sales (SSS), basket size, units per transaction (UPT), shrink rate, fill rate, and category performance KPIs.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`metric_definition` (
    `metric_definition_id` BIGINT COMMENT 'Unique identifier for the metric definition. _canonical_skip_reason: Entity classified as OTHER, does not fit standard role categories.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Financial KPI metrics are derived from specific GL accounts; linking provides traceability from metric to underlying account.',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Metric definitions belong to a KPI; many metrics per KPI, so metric_definition gets kpi_definition_id FK.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: Metric definitions are authored and maintained by a data‑analytics associate; the link supports metric stewardship and audit.',
    `price_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.price_rule. Business justification: REQUIRED: KPI metrics track compliance and impact of pricing rules, so each metric definition references the rule it measures.',
    `tender_type_id` BIGINT COMMENT 'Foreign key linking to payment.tender_type. Business justification: Defines metric tracking usage volume per tender type for strategic payment channel optimization.',
    `derived_from_metric_definition_id` BIGINT COMMENT 'Self-referencing FK on metric_definition (derived_from_metric_definition_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the metric definition record was first created.',
    `data_type` STRING COMMENT 'Data type of the metrics result value.. Valid values are `integer|decimal|string|date|boolean`',
    `metric_audience` STRING COMMENT 'Intended consumer audience for the metric.. Valid values are `analyst|executive|operations|ml|marketing`',
    `metric_category` STRING COMMENT 'High‑level business category the metric belongs to.. Valid values are `sales|inventory|finance|customer|operations|supply_chain`',
    `metric_confidentiality` STRING COMMENT 'Data classification level for the metric definition.. Valid values are `public|internal|confidential|restricted`',
    `metric_data_quality_score` DECIMAL(18,2) COMMENT 'Score (0‑100) representing the assessed data quality of the metrics source data.',
    `metric_definition_source` STRING COMMENT 'System or process that originated the metric definition (e.g., SAP Retail, Blue Yonder).',
    `metric_description` STRING COMMENT 'Detailed description of what the metric measures and its business purpose.',
    `metric_formula` STRING COMMENT 'Expression or calculation logic that derives the metric from source data fields.',
    `metric_grain` STRING COMMENT 'Granularity at which the metric is calculated (e.g., per store per day).. Valid values are `store_day|category_week|product_month|store_week`',
    `metric_is_aggregated` BOOLEAN COMMENT 'Indicates whether the metric is an aggregated value (true) or a raw atomic measure (false).',
    `metric_is_time_variant` BOOLEAN COMMENT 'True if the metric value can change over time; false if static.',
    `metric_last_validated` TIMESTAMP COMMENT 'Timestamp of the most recent validation of the metrics correctness.',
    `metric_lineage` STRING COMMENT 'Narrative of source tables, joins, and transformations used to derive the metric.',
    `metric_name` STRING COMMENT 'Human‑readable name of the atomic business metric.',
    `metric_owner` STRING COMMENT 'Business owner or team responsible for the metric.',
    `metric_status` STRING COMMENT 'Current lifecycle status of the metric definition.. Valid values are `active|inactive|deprecated|draft|pending`',
    `metric_tags` STRING COMMENT 'Comma‑separated list of business tags or keywords associated with the metric.',
    `metric_units` STRING COMMENT 'Units of measure for the metric value (e.g., dollars, count, percent).',
    `metric_valid_from` DATE COMMENT 'Effective start date when the metric definition becomes valid.',
    `metric_valid_to` DATE COMMENT 'Effective end date after which the metric definition is retired (nullable).',
    `metric_version` STRING COMMENT 'Version identifier for the metric definition, allowing change tracking.',
    `source_domain` STRING COMMENT 'Data domain that provides the source data for the metric (e.g., sales, inventory).',
    `source_product` STRING COMMENT 'Operational system or product that supplies the raw data used to compute the metric.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the metric definition.',
    CONSTRAINT pk_metric_definition PRIMARY KEY(`metric_definition_id`)
) COMMENT 'Master catalog of atomic business metrics that underpin KPI calculations at Grocery. Distinct from KPIs in that metrics are raw or lightly derived measures (e.g., total_sales_dollars, transaction_count, avg_basket_value, units_sold, gross_margin_pct) rather than composite performance indicators. Captures metric name, formula expression, grain (store/day, category/week), source domain, source product, and data type. Enables governed metric reuse across dashboards and ad-hoc analysis without recalculation inconsistency.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`dashboard` (
    `dashboard_id` BIGINT COMMENT 'Unique surrogate key for each dashboard record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to product.brand. Business justification: Brand performance dashboards require a direct FK to the brand entity to surface brand‑level KPIs and metrics.',
    `center_id` BIGINT COMMENT 'Foreign key linking to fuel.fuel_center. Business justification: Fuel Center Performance Dashboard needs to associate the dashboard with the fuel center it monitors for KPI tracking.',
    `associate_id` BIGINT COMMENT 'Surrogate key of the primary owner (business analyst or data steward) responsible for the dashboard.',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Dashboard displays a KPI; add KPI reference to dashboard.',
    `owner_associate_id` BIGINT COMMENT 'FK to workforce.associate',
    `owner_id` BIGINT COMMENT 'FK to workforce.associate',
    `pricing_recommendation_id` BIGINT COMMENT 'Foreign key linking to pricing.recommendation. Business justification: REQUIRED: Pricing recommendation dashboards need to surface the underlying recommendation record for drill‑down and audit.',
    `store_location_id` BIGINT COMMENT 'Foreign key linking to store.store_location. Business justification: Store managers access dashboards tailored to their store; the FK ties each dashboard instance to the relevant store location.',
    `cloned_from_dashboard_id` BIGINT COMMENT 'Self-referencing FK on dashboard (cloned_from_dashboard_id)',
    `access_level` STRING COMMENT 'Access control level governing who can view the dashboard.. Valid values are `public|restricted|confidential`',
    `audience` STRING COMMENT 'Primary consumer group(s) for the dashboard.. Valid values are `store_ops|category_mgmt|finance|executive|marketing|supply_chain`',
    `average_load_time_seconds` DOUBLE COMMENT 'Average time in seconds for the dashboard to load for end users.',
    `compliance_tags` STRING COMMENT 'Comma‑separated list of regulatory or policy tags applicable to the dashboard (e.g., GDPR, HIPAA).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the dashboard record was first created in the catalog.',
    `dashboard_code` STRING COMMENT 'Business identifier or short code used to reference the dashboard in documentation and governance.',
    `dashboard_description` STRING COMMENT 'Detailed free‑text description of the dashboards purpose, scope, and key metrics.',
    `dashboard_name` STRING COMMENT 'Human‑readable name of the dashboard as displayed to users.',
    `dashboard_status` STRING COMMENT 'Current lifecycle state of the dashboard.. Valid values are `draft|published|certified|retired|archived`',
    `dashboard_type` STRING COMMENT 'Category of the dashboard indicating its primary purpose or audience.. Valid values are `operational|strategic|executive|ad_hoc|reporting|analytics`',
    `data_governance_classification` STRING COMMENT 'Classification of the dashboards data according to corporate data policy.. Valid values are `public|internal|confidential|restricted`',
    `data_source_summary` STRING COMMENT 'Brief description of the primary data sources feeding the dashboard.',
    `domain` STRING COMMENT 'High‑level business domain the dashboard serves (e.g., finance, store operations, supply chain).',
    `expiration_date` DATE COMMENT 'Date on which the dashboard is scheduled to be retired or archived.',
    `is_certified` BOOLEAN COMMENT 'Indicates whether the dashboard has passed governance certification.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Date‑time when the dashboard data was last refreshed.',
    `platform` STRING COMMENT 'Technology platform used to author and publish the dashboard.. Valid values are `databricks_sql|tableau|power_bi|lookml`',
    `publication_status` STRING COMMENT 'Current publication state of the dashboard within the analytics catalog.. Valid values are `draft|published|archived`',
    `refresh_cadence` STRING COMMENT 'Scheduled frequency at which the dashboard data is refreshed.. Valid values are `hourly|daily|weekly|monthly|on_demand`',
    `related_reports` STRING COMMENT 'Identifiers of other dashboards or reports that are logically related.',
    `retention_period_days` STRING COMMENT 'Number of days the dashboard metadata is retained before archival.',
    `sla_response_time_seconds` STRING COMMENT 'Maximum allowed time for the dashboard to become available after a refresh request.',
    `tags` STRING COMMENT 'User‑defined tags for search and categorization (e.g., holiday_sales, inventory_turnover).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent metadata change to the dashboard record.',
    `version_number` STRING COMMENT 'Semantic version identifier (e.g., 1.0.3) for change management.',
    `view_count` BIGINT COMMENT 'Cumulative number of times the dashboard has been viewed by users.',
    CONSTRAINT pk_dashboard PRIMARY KEY(`dashboard_id`)
) COMMENT 'Master record for every business intelligence dashboard published and governed within the Grocery analytics platform (Databricks SQL, Tableau, Power BI). Captures dashboard name, owning business domain, target audience (store ops, category management, finance, executive), refresh cadence, platform, publication status, and certified/draft flag. Serves as the authoritative catalog of all active and retired dashboards enabling governance, access control, and impact analysis when upstream data products change.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`report_definition` (
    `report_definition_id` BIGINT COMMENT 'Unique surrogate key for each report definition record.',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Report definitions are built around KPIs; add KPI reference.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Compliance programs mandate periodic reports; report_definition records the report that satisfies a specific programs reporting requirement.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: Reports have a designated owner associate (e.g., BI analyst); linking enables ownership tracking and compliance.',
    `parent_report_definition_id` BIGINT COMMENT 'Self-referencing FK on report_definition (parent_report_definition_id)',
    `access_level` STRING COMMENT 'Data classification governing who may view the report.. Valid values are `public|internal|confidential|restricted`',
    `compliance_requirements` STRING COMMENT 'List of regulatory or internal compliance rules that the report satisfies (e.g., SOX, FDA).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the report definition record was first created in the system.',
    `data_freshness_sla_days` STRING COMMENT 'Maximum number of days allowed between source data refresh and report generation.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing the quality of source data at the time of report generation.',
    `data_source_system` STRING COMMENT 'Name of the operational system(s) that provide the underlying data (e.g., SAP Retail, Oracle Merchandising).',
    `delivery_format` STRING COMMENT 'File or channel format used to deliver the generated report.. Valid values are `PDF|Excel|CSV|Email|SFTP`',
    `is_ad_hoc` BOOLEAN COMMENT 'True if the report is primarily generated on demand rather than on a fixed schedule.',
    `is_scheduled` BOOLEAN COMMENT 'Flag indicating whether the report runs on a recurring schedule (true) or is on‑demand only (false).',
    `last_run_timestamp` TIMESTAMP COMMENT 'Date‑time when the report was most recently generated.',
    `next_run_timestamp` TIMESTAMP COMMENT 'Planned date‑time for the next scheduled execution of the report.',
    `owner_domain` STRING COMMENT 'Analytics domain that owns and maintains the report definition (e.g., sales, inventory, finance).',
    `recipient_list` STRING COMMENT 'Semicolon‑separated list of email addresses or user IDs that receive the report.',
    `regulatory_report_flag` BOOLEAN COMMENT 'True if the report is required for external regulatory filing.',
    `report_audience` STRING COMMENT 'Intended audience for the report: internal stakeholders or external partners.. Valid values are `internal|external`',
    `report_category` STRING COMMENT 'High‑level business area the report belongs to.. Valid values are `sales|inventory|finance|operations|customer|compliance`',
    `report_definition_code` STRING COMMENT 'Business identifier or short code used to reference the report in catalogs and schedules.',
    `report_definition_description` STRING COMMENT 'Detailed narrative describing the report purpose, scope, and key metrics.',
    `report_definition_name` STRING COMMENT 'Human‑readable name of the report as shown to business users.',
    `report_definition_status` STRING COMMENT 'Current lifecycle state of the report definition.. Valid values are `active|inactive|draft|retired`',
    `report_definition_type` STRING COMMENT 'Classification of the report purpose: operational, financial, regulatory, or ad‑hoc.. Valid values are `operational|financial|regulatory|ad_hoc`',
    `report_distribution_method` STRING COMMENT 'Mechanism used to distribute the report (email, portal, FTP).',
    `report_language` STRING COMMENT 'Language in which the report content is generated (e.g., EN, ES).',
    `report_last_modified_by` STRING COMMENT 'User name of the person who last edited the report definition.',
    `report_last_modified_by_email` STRING COMMENT 'Email address of the user who last modified the report definition.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `report_owner` STRING COMMENT 'Name of the business user or team responsible for the report.',
    `report_owner_email` STRING COMMENT 'Primary email address of the report owner for notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `report_owner_phone` STRING COMMENT 'Contact phone number for the report owner.',
    `report_priority` STRING COMMENT 'Business priority level for report generation and delivery.. Valid values are `high|medium|low`',
    `report_tags` STRING COMMENT 'Free‑form tags or keywords associated with the report for searchability.',
    `retention_period_days` STRING COMMENT 'Number of days the generated report files are retained before archival or deletion.',
    `schedule_cron` STRING COMMENT 'Cron expression that defines the recurring execution schedule for the report.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the report definition.',
    `version_number` STRING COMMENT 'Incremental version of the report definition to track changes over time.',
    CONSTRAINT pk_report_definition PRIMARY KEY(`report_definition_id`)
) COMMENT 'Master catalog of all scheduled and on-demand business reports produced by the Grocery analytics platform. Captures report name, report type (operational, financial, regulatory, ad-hoc), owning domain, delivery format (PDF, Excel, CSV, email, SFTP), schedule expression (cron), recipient list, and data freshness SLA. Distinct from dashboards in that reports are point-in-time document artifacts delivered to stakeholders rather than interactive visualizations. Covers weekly ad performance reports, comp sales reports, category scorecards, and shrink reports.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`comp_sales_period` (
    `comp_sales_period_id` BIGINT COMMENT 'System-generated unique identifier for each comparable sales period definition.',
    `prior_year_comp_sales_period_id` BIGINT COMMENT 'Self-referencing FK on comp_sales_period (prior_year_comp_sales_period_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the period definition record was first created.',
    `current_end_date` DATE COMMENT 'Last calendar date of the current analysis period.',
    `current_start_date` DATE COMMENT 'First calendar date of the current analysis period.',
    `effective_from` TIMESTAMP COMMENT 'When this period definition becomes active for analytics.',
    `effective_until` TIMESTAMP COMMENT 'When this period definition is retired; null if still active.',
    `eligibility_criteria` STRING COMMENT 'Textual description of the rules a store must meet to be included (e.g., open ≥52 weeks, no major remodel).',
    `exclusion_reason` STRING COMMENT 'Reason why a store is excluded; limited to common categories.. Valid values are `remodeled|relocated|closed|other`',
    `is_eligible` BOOLEAN COMMENT 'Indicates whether the store satisfies the eligibility criteria for this period.',
    `is_excluded` BOOLEAN COMMENT 'True when the store is excluded from comp‑sales calculations for this period.',
    `notes` STRING COMMENT 'Free‑form comments or audit notes about the period definition.',
    `period_label` STRING COMMENT 'Human‑readable label for the period pair, e.g., "FY2023 Q1".',
    `period_type` STRING COMMENT 'Classification of the period granularity used for comp‑sales analysis.. Valid values are `week|4-week|quarter|fiscal_year`',
    `prior_end_date` DATE COMMENT 'Last calendar date of the prior‑year comparable period.',
    `prior_start_date` DATE COMMENT 'First calendar date of the prior‑year comparable period.',
    `relocation_flag` BOOLEAN COMMENT 'True if the store changed location or footprint during the period.',
    `remodel_flag` BOOLEAN COMMENT 'True if the store underwent a remodel during the period.',
    `store_open_weeks` STRING COMMENT 'Number of weeks the store was open in the fiscal year, used for eligibility.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the period definition.',
    `version_number` STRING COMMENT 'Incremental version of the period definition for change tracking.',
    CONSTRAINT pk_comp_sales_period PRIMARY KEY(`comp_sales_period_id`)
) COMMENT 'Reference master defining the comparable sales (comp sales) period pairs used in same-store sales (SSS) analysis at Grocery. Captures current period start/end dates, prior-year comparable period start/end dates, period type (week, 4-week, quarter, fiscal year), comp eligibility criteria (store must be open 52+ weeks), and exclusion flags for remodeled or relocated stores. This is the authoritative reference that governs which periods are used in all comp sales KPI calculations across the enterprise, ensuring consistent year-over-year comparisons.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`comp_sales_result` (
    `comp_sales_result_id` BIGINT COMMENT 'System-generated unique identifier for each comparable sales result record.',
    `banner_id` BIGINT COMMENT 'Identifier for the banner (brand family) grouping the store.',
    `comp_sales_period_id` BIGINT COMMENT 'Foreign key linking to analytics.comp_sales_period. Business justification: Comp sales results are calculated for a defined comp period; link result to period.',
    `price_change_id` BIGINT COMMENT 'Foreign key linking to pricing.price_change. Business justification: REQUIRED: Comparative sales reports link results to the specific price change that triggered the sales variance.',
    `region_id` BIGINT COMMENT 'Geographic region identifier for reporting roll‑up.',
    `store_location_id` BIGINT COMMENT 'Unique identifier of the retail store to which the result applies.',
    `prior_period_comp_sales_result_id` BIGINT COMMENT 'Self-referencing FK on comp_sales_result (prior_period_comp_sales_result_id)',
    `basket_size_current` DECIMAL(18,2) COMMENT 'Average transaction amount (basket size) for the current period.',
    `basket_size_prior` DECIMAL(18,2) COMMENT 'Average transaction amount for the prior comparable period.',
    `basket_size_variance` DECIMAL(18,2) COMMENT 'Difference in average basket size between current and prior periods.',
    `comp_sales_dollar_variance` DECIMAL(18,2) COMMENT 'Difference in net sales between current and prior comparable periods (current – prior).',
    `comp_sales_percent_change` DECIMAL(18,2) COMMENT 'Percentage change in net sales between current and prior periods.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values in this record.. Valid values are `USD|CAD|MXN|GBP|EUR`',
    `discount_current` DECIMAL(18,2) COMMENT 'Total discount and promotional reductions applied in the current period.',
    `discount_prior` DECIMAL(18,2) COMMENT 'Total discount and promotional reductions applied in the prior-year comparable period.',
    `eligibility_flag` BOOLEAN COMMENT 'Indicates whether the store is eligible for comp‑sales reporting in this period.',
    `exclusion_reason` STRING COMMENT 'Reason why a store was excluded from comp‑sales calculation, if eligibility_flag is false.. Valid values are `store_closed|data_insufficient|seasonal|other`',
    `gross_sales_current` DECIMAL(18,2) COMMENT 'Total gross sales amount for the current period before discounts and adjustments.',
    `gross_sales_prior` DECIMAL(18,2) COMMENT 'Total gross sales amount for the comparable prior-year period.',
    `net_sales_current` DECIMAL(18,2) COMMENT 'Net sales for the current period after discounts; primary KPI for comp analysis.',
    `net_sales_prior` DECIMAL(18,2) COMMENT 'Net sales for the prior-year comparable period after discounts.',
    `period_end_date` DATE COMMENT 'Last calendar date of the reporting period.',
    `period_start_date` DATE COMMENT 'First calendar date of the reporting period.',
    `record_audit_created` TIMESTAMP COMMENT 'Date and time when the comparable sales record was first created in the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Date and time of the most recent update to the comparable sales record.',
    `result_key` STRING COMMENT 'Composite business key (e.g., store_id + period) uniquely identifying the result within business processes.',
    `result_status` STRING COMMENT 'Current lifecycle status of the comparable sales record.. Valid values are `active|inactive|excluded`',
    `result_timestamp` TIMESTAMP COMMENT 'Timestamp representing the end of the reporting period for which the result is calculated.',
    `transaction_count_current` BIGINT COMMENT 'Number of sales transactions recorded in the current period.',
    `transaction_count_prior` BIGINT COMMENT 'Number of sales transactions recorded in the prior comparable period.',
    `transaction_count_variance` BIGINT COMMENT 'Difference in transaction count between current and prior periods.',
    `units_sold_current` BIGINT COMMENT 'Total number of individual items sold in the current period.',
    `units_sold_prior` BIGINT COMMENT 'Total number of individual items sold in the prior comparable period.',
    `units_variance` BIGINT COMMENT 'Difference in units sold between current and prior periods.',
    CONSTRAINT pk_comp_sales_result PRIMARY KEY(`comp_sales_result_id`)
) COMMENT 'Transactional record capturing computed comparable (comp) sales and same-store sales (SSS) results at the store-period grain for Grocery. Stores current period net sales, prior-year comparable period net sales, comp sales dollar variance, comp sales percent change, transaction count comp, basket size comp, and units comp. Includes store eligibility flag, exclusion reason if applicable, and banner/region rollup keys. This is the authoritative Silver Layer fact table for all comp sales reporting consumed by store operations, finance, and executive dashboards.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`basket_summary` (
    `basket_summary_id` BIGINT COMMENT 'Unique identifier for the basket summary record.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store where basket data was captured.',
    `store_sales_fact_id` BIGINT COMMENT 'Foreign key linking to analytics.store_sales_fact. Business justification: Basket summary aggregates store sales; link to the underlying store_sales_fact.',
    `prior_period_basket_summary_id` BIGINT COMMENT 'Self-referencing FK on basket_summary (prior_period_basket_summary_id)',
    `average_basket_value` DECIMAL(18,2) COMMENT 'Average monetary value per basket.',
    `average_discount_rate` DECIMAL(18,2) COMMENT 'Average discount percentage applied per basket.',
    `average_gross_margin` DECIMAL(18,2) COMMENT 'Average gross margin for baskets.',
    `average_items_per_basket` DECIMAL(18,2) COMMENT 'Average number of items per basket.',
    `average_transaction_time_seconds` STRING COMMENT 'Average time taken to complete a basket transaction.',
    `basket_count` BIGINT COMMENT 'Number of baskets captured in the period.',
    `basket_date` DATE COMMENT 'Date of the basket activity (store‑day grain).',
    `basket_key` STRING COMMENT 'Business identifier for the basket summary (e.g., concatenation of store, date, and sequence).',
    `basket_size_tier` STRING COMMENT 'Overall basket size classification based on value.. Valid values are `small|medium|large`',
    `basket_summary_status` STRING COMMENT 'Current lifecycle status of the basket summary record.. Valid values are `active|inactive|closed|cancelled`',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary values.. Valid values are `USD|CAD|EUR`',
    `fill_rate` DECIMAL(18,2) COMMENT 'Percentage of basket items that were fully fulfilled from inventory.',
    `fiscal_week` STRING COMMENT 'Fiscal week number for the basket period.',
    `fiscal_year` STRING COMMENT 'Fiscal year for the basket period.',
    `large_basket_count` BIGINT COMMENT 'Count of baskets classified as large (e.g., >$50).',
    `loyalty_basket_flag` BOOLEAN COMMENT 'Indicates if the basket belongs to a loyalty program member.',
    `medium_basket_count` BIGINT COMMENT 'Count of baskets classified as medium (e.g., $20‑$50).',
    `multi_category_rate` DECIMAL(18,2) COMMENT 'Percentage of baskets containing items from multiple categories.',
    `net_sales_amount` DECIMAL(18,2) COMMENT 'Net sales after discounts for the period.',
    `out_of_stock_rate` DECIMAL(18,2) COMMENT 'Percentage of basket items that were out of stock at time of purchase.',
    `payment_method` STRING COMMENT 'Primary payment method used for the basket.. Valid values are `cash|credit_card|debit_card|mobile_payment|gift_card`',
    `private_label_penetration` DECIMAL(18,2) COMMENT 'Proportion of basket value contributed by private‑label products.',
    `promotional_basket_flag` BOOLEAN COMMENT 'Indicates if the basket includes any promotional items.',
    `record_created` TIMESTAMP COMMENT 'Timestamp when the basket summary record was first captured in the lakehouse.',
    `record_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the basket summary record.',
    `shrink_rate` DECIMAL(18,2) COMMENT 'Percentage of basket value lost due to shrinkage.',
    `small_basket_count` BIGINT COMMENT 'Count of baskets classified as small (e.g., <$20).',
    `store_format` STRING COMMENT 'Format type of the store.. Valid values are `supermarket|pharmacy|fuel_center|express`',
    `store_region` STRING COMMENT 'Geographic region code of the store (e.g., NE, MW, SE).',
    `total_discount_amount` DECIMAL(18,2) COMMENT 'Total discount value applied across all baskets.',
    `total_sales_amount` DECIMAL(18,2) COMMENT 'Gross sales amount for all baskets in the period.',
    `transaction_channel` STRING COMMENT 'Channel through which the basket was completed.. Valid values are `in_store|online|pickup|delivery`',
    CONSTRAINT pk_basket_summary PRIMARY KEY(`basket_summary_id`)
) COMMENT 'Transactional analytical record capturing basket-level purchase behavior metrics at the store-day or store-week grain for Grocery. Stores average basket size (ABS) in dollars, average items per basket (UPT — units per transaction), basket count by size tier (small/medium/large), multi-category basket rate, private-label penetration per basket, and loyalty vs. non-loyalty basket split. Derived from order and order_line domain data and materialized in the Silver Layer for basket analysis dashboards, category management, and promotional effectiveness measurement.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`category_performance` (
    `category_performance_id` BIGINT COMMENT 'Unique surrogate identifier for each category performance record.',
    `category_id` BIGINT COMMENT 'Identifier of the product category (e.g., dairy, produce) associated with the performance metrics.',
    `store_location_id` BIGINT COMMENT 'Identifier of the retail store for which the performance metrics are recorded.',
    `prior_period_category_performance_id` BIGINT COMMENT 'Self-referencing FK on category_performance (prior_period_category_performance_id)',
    `average_inventory_cost` DECIMAL(18,2) COMMENT 'Average dollar value of inventory on hand for the category during the period.',
    `average_retail_price` DECIMAL(18,2) COMMENT 'Average selling price per unit for the category, weighted by units sold.',
    `category_penetration_rate` DECIMAL(18,2) COMMENT 'Percentage of total store transactions that purchased at least one SKU from the category.',
    `category_status` STRING COMMENT 'Current lifecycle status of the category (e.g., active, inactive, discontinued).. Valid values are `active|inactive|discontinued`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the category performance record was first created in the lakehouse.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Composite score (0‑1) reflecting the quality of the source data for this record.',
    `gross_margin_amount` DECIMAL(18,2) COMMENT 'Dollar amount of gross margin (sales minus cost of goods sold) for the category.',
    `gross_margin_percent` DECIMAL(18,2) COMMENT 'Gross margin expressed as a percentage of net sales.',
    `inventory_turn` DECIMAL(18,2) COMMENT 'Ratio of cost of goods sold to average inventory cost for the category.',
    `markdown_amount` DECIMAL(18,2) COMMENT 'Total dollar value of price reductions applied to the category.',
    `markdown_percent` DECIMAL(18,2) COMMENT 'Aggregate markdown expressed as a percentage of original price.',
    `net_sales_amount` DECIMAL(18,2) COMMENT 'Total net sales dollars for the category after discounts and returns.',
    `out_of_stock_rate` DECIMAL(18,2) COMMENT 'Percentage of time the category was out of stock during the period.',
    `period_end_date` DATE COMMENT 'Last calendar date of the reporting period (e.g., week end).',
    `period_start_date` DATE COMMENT 'First calendar date of the reporting period (e.g., week start).',
    `price_change_amount` DECIMAL(18,2) COMMENT 'Net dollar change in average price for the category over the period.',
    `price_change_flag` BOOLEAN COMMENT 'Indicates whether any price adjustments occurred for the category during the period.',
    `price_change_percent` DECIMAL(18,2) COMMENT 'Percentage change in average price for the category over the period.',
    `promotional_sales_lift_amount` DECIMAL(18,2) COMMENT 'Incremental sales dollars attributed to promotional activities for the category.',
    `promotional_sales_lift_percent` DECIMAL(18,2) COMMENT 'Promotional sales lift expressed as a percentage of baseline sales.',
    `shrink_dollars` DECIMAL(18,2) COMMENT 'Dollar value of inventory loss due to theft, spoilage, or damage for the category.',
    `source_system` STRING COMMENT 'Originating operational system that supplied the source data for this record.. Valid values are `SAP|Oracle|Manhattan|BlueYonder|NCR|Salesforce`',
    `stock_on_hand` BIGINT COMMENT 'Quantity of units physically present in the store for the category at period end.',
    `transaction_count` BIGINT COMMENT 'Number of POS transactions that included at least one item from the category.',
    `units_sold` BIGINT COMMENT 'Total number of units sold for the category during the period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the category performance record.',
    CONSTRAINT pk_category_performance PRIMARY KEY(`category_performance_id`)
) COMMENT 'Transactional analytical record capturing category-level sales and margin performance at the category-store-period grain for Grocery. Stores net sales, gross margin dollars and percent, units sold, transactions with category purchase, category penetration rate, average retail price, promotional sales lift, shrink dollars, and inventory turn. Aligned to the assortment.category hierarchy. Serves as the authoritative Silver Layer fact for category management reviews, category captain reporting, and assortment optimization decisions.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`dq_rule` (
    `dq_rule_id` BIGINT COMMENT 'Unique identifier for the data quality rule.',
    `metric_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.metric_definition. Business justification: Data quality rules are often scoped to a metric; add metric reference.',
    `parent_dq_rule_id` BIGINT COMMENT 'Self-referencing FK on dq_rule (parent_dq_rule_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule record was first created.',
    `dq_rule_description` STRING COMMENT 'Detailed narrative explaining the purpose and logic of the rule.',
    `effective_from` DATE COMMENT 'Date from which the rule becomes active.',
    `effective_until` DATE COMMENT 'Date after which the rule is retired or no longer enforced.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the rule is executed automatically as part of data pipelines.',
    `last_pass_rate` DECIMAL(18,2) COMMENT 'Observed pass percentage from the most recent rule execution.',
    `last_run_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent execution of the rule.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the rule definition.. Valid values are `active|inactive|deprecated`',
    `pass_threshold_pct` DECIMAL(18,2) COMMENT 'Minimum acceptable pass rate for the rule expressed as a percentage.',
    `remediation_owner` STRING COMMENT 'Team or individual responsible for addressing rule violations.',
    `rule_category` STRING COMMENT 'Logical grouping of the rule (e.g., data_quality, governance, compliance).',
    `rule_expression` STRING COMMENT 'SQL or Great Expectations expression that defines the rule logic.',
    `rule_name` STRING COMMENT 'Human‑readable name of the rule.',
    `rule_type` STRING COMMENT 'Category of rule such as completeness, uniqueness, validity, referential integrity, timeliness, or consistency.. Valid values are `completeness|uniqueness|validity|referential_integrity|timeliness|consistency`',
    `severity_level` STRING COMMENT 'Impact level of a rule failure used for prioritization.. Valid values are `critical|warning|info`',
    `source_system` STRING COMMENT 'System or tool where the rule is authored or executed.. Valid values are `SQL|Great Expectations|Custom`',
    `target_column` STRING COMMENT 'Column within the target entity that the rule validates.',
    `target_domain` STRING COMMENT 'Business domain (e.g., product, customer, inventory) to which the rule applies. [ENUM-REF-CANDIDATE: product|customer|store|inventory|order|pharmacy|promotion|vendor|finance|loyalty|fuel|digital_commerce|workforce — promote to reference product]',
    `target_entity` STRING COMMENT 'Name of the entity/table that the rule validates.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the rule record.',
    CONSTRAINT pk_dq_rule PRIMARY KEY(`dq_rule_id`)
) COMMENT 'Master catalog of all data quality rules defined and enforced across the Grocery Lakehouse Silver Layer. Captures rule name, rule type (completeness, uniqueness, validity, referential integrity, timeliness, consistency), target domain, target product, target column, rule expression (SQL or Great Expectations syntax), severity level (critical/warning/info), expected pass threshold percentage, and remediation owner. Serves as the authoritative governance registry for all DQ rules enabling automated DQ execution, lineage tracking, and SLA enforcement.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`dq_result` (
    `dq_result_id` BIGINT COMMENT 'System-generated unique identifier for the data quality result record.',
    `dq_rule_id` BIGINT COMMENT 'Unique identifier of the data quality rule that was executed.',
    `product_item_id` BIGINT COMMENT 'Foreign key linking to product.product_item. Business justification: Data‑quality rule results need to reference the exact product item they evaluate for traceability and remediation.',
    `previous_dq_result_id` BIGINT COMMENT 'Self-referencing FK on dq_result (previous_dq_result_id)',
    `comments` STRING COMMENT 'Free‑form notes or observations added by the data quality analyst.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this data quality result record was first inserted.',
    `data_asset` STRING COMMENT 'Logical name of the data asset (product) that the rule validates.',
    `data_asset_version` STRING COMMENT 'Version identifier of the data asset at the time of validation.',
    `dq_result_status` STRING COMMENT 'Overall pass/fail status of the rule execution against the defined threshold.. Valid values are `pass|fail`',
    `evaluated_record_count` BIGINT COMMENT 'Number of records examined by the rule during this run.',
    `execution_environment` STRING COMMENT 'Identifier of the compute environment or cluster where the rule was executed.',
    `failed_record_count` BIGINT COMMENT 'Number of records that violated the rule conditions.',
    `pass_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of records that passed the rule (passed / evaluated * 100).',
    `passed_record_count` BIGINT COMMENT 'Number of records that satisfied the rule conditions.',
    `remediation_ticket_number` STRING COMMENT 'Reference identifier of the ticket created to address the data quality issue.',
    `rule_category` STRING COMMENT 'Classification of the rule type (e.g., completeness, uniqueness, range).',
    `rule_name` STRING COMMENT 'Human‑readable name of the data quality rule.',
    `run_timestamp` TIMESTAMP COMMENT 'Date and time when the data quality rule execution was performed.',
    `sample_failed_keys` STRING COMMENT 'JSON‑encoded list of primary‑key values for a sample of records that failed the rule.',
    `severity_level` STRING COMMENT 'Business impact severity assigned to the rule failure.. Valid values are `critical|high|medium|low`',
    `source_system` STRING COMMENT 'Name of the system or pipeline that generated the data quality result (e.g., Databricks, Spark job).',
    `target_column` STRING COMMENT 'Column within the target product that the rule evaluated.',
    `target_domain` STRING COMMENT 'Business domain (e.g., product, customer, inventory) to which the rule was applied.',
    `target_product` STRING COMMENT 'Name of the data product (table or view) that was validated.',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold that the rules pass rate must meet or exceed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this data quality result record.',
    CONSTRAINT pk_dq_result PRIMARY KEY(`dq_result_id`)
) COMMENT 'Transactional record capturing the outcome of each data quality rule execution run against a target data product in the Grocery Lakehouse. Captures run timestamp, rule ID, target domain, target product, target column, records evaluated count, records passed count, records failed count, pass rate percentage, pass/fail status against threshold, sample failed record keys, and remediation ticket reference. Enables DQ trend monitoring, SLA breach alerting, and root-cause investigation for data quality incidents across the Silver Layer.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`dq_issue` (
    `dq_issue_id` BIGINT COMMENT 'Unique identifier for the data quality issue record. _canonical_skip_reason: Entity classified as OTHER because it does not fit standard master or transaction roles.',
    `dq_rule_id` BIGINT COMMENT 'Identifier of the DQ rule that generated the issue.',
    `item_attribute_id` BIGINT COMMENT 'Foreign key linking to product.item_attribute. Business justification: Quality issues are often attribute‑specific; linking allows issue tracking directly to the offending product attribute.',
    `related_dq_issue_id` BIGINT COMMENT 'Self-referencing FK on dq_issue (related_dq_issue_id)',
    `affected_record_count` BIGINT COMMENT 'Number of data records impacted by the issue.',
    `assigned_owner` STRING COMMENT 'Name or identifier of the person/team responsible for remediation.',
    `comments` STRING COMMENT 'Any extra free‑text comments from stakeholders.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the issue record was first created.',
    `data_classification` STRING COMMENT 'Classification level indicating sensitivity of the issue data.. Valid values are `restricted|confidential|internal|public`',
    `detection_method` STRING COMMENT 'How the issue was discovered.. Valid values are `automated_rule|manual_review|user_report`',
    `domain` STRING COMMENT 'Primary business domain affected by the issue (e.g., customer, product, inventory).. Valid values are `customer|product|inventory|order|finance|supply_chain`',
    `dq_issue_status` STRING COMMENT 'Current lifecycle state of the data quality issue.. Valid values are `open|in_progress|resolved|waived`',
    `impact_score` DECIMAL(18,2) COMMENT 'Quantitative score (0‑100) representing overall business impact.',
    `is_critical` BOOLEAN COMMENT 'True if the issue is deemed critical for business operations.',
    `is_regulatory` BOOLEAN COMMENT 'Indicates whether the issue affects regulatory reporting or compliance.',
    `issue_category` STRING COMMENT 'Higher‑level grouping of the issue type.. Valid values are `validation|integration|master_data|reference_data`',
    `issue_description` STRING COMMENT 'Detailed narrative describing the nature, scope, and impact of the data quality problem.',
    `issue_type` STRING COMMENT 'Category of data quality problem (e.g., completeness, accuracy).. Valid values are `data_quality|completeness|accuracy|timeliness|consistency`',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent review of the issue by the owner.',
    `priority` STRING COMMENT 'Numeric priority (e.g., 1‑5) used for internal triage.',
    `product` STRING COMMENT 'Specific data product or dataset where the issue was detected. [ENUM-REF-CANDIDATE: assortment|pricing|replenishment|sales|loyalty|pharmacy|supply_chain|store|finance — 9 candidates stripped; promote to reference product]',
    `regulatory_body` STRING COMMENT 'Regulatory authority impacted (e.g., FDA, HIPAA). [ENUM-REF-CANDIDATE: FDA|USDA|DEA|FTC|OSHA|EPA|PCI_DSS|HIPAA|SOX — promote to reference product]',
    `remediation_action` STRING COMMENT 'Planned or executed action to correct the data quality problem.',
    `resolution_notes` STRING COMMENT 'Free‑form notes describing how the issue was resolved or why it was waived.',
    `root_cause_category` STRING COMMENT 'High‑level classification of the underlying cause of the issue.. Valid values are `source_system|etl|business_rule_change|schema_drift|manual`',
    `severity` STRING COMMENT 'Severity level indicating the business impact of the issue.. Valid values are `critical|high|medium|low`',
    `sla_due_date` DATE COMMENT 'Service‑level‑agreement date by which the issue must be addressed.',
    `source_system` STRING COMMENT 'Originating operational system (e.g., SAP, Oracle, Manhattan). [ENUM-REF-CANDIDATE: SAP|Oracle|Manhattan|BlueYonder|NCR|Salesforce|McKesson|JDA|Workday — promote to reference product]',
    `target_resolution_date` DATE COMMENT 'Planned date by which the issue should be resolved.',
    `title` STRING COMMENT 'Short descriptive title of the data quality issue.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the issue record.',
    CONSTRAINT pk_dq_issue PRIMARY KEY(`dq_issue_id`)
) COMMENT 'Operational record tracking active and resolved data quality issues identified through DQ rule execution or manual discovery at Grocery. Captures issue title, severity, affected domain and product, root cause category (source system, ETL, business rule change, schema drift), assigned remediation owner, target resolution date, current status (open/in-progress/resolved/waived), and resolution notes. Distinct from dq_result in that it represents the managed lifecycle of a DQ problem, not just a single rule execution outcome. Enables DQ incident management and SLA tracking.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`analytical_dataset` (
    `analytical_dataset_id` BIGINT COMMENT 'Unique system-generated identifier for the analytical dataset record.',
    `derived_from_analytical_dataset_id` BIGINT COMMENT 'Self-referencing FK on analytical_dataset (derived_from_analytical_dataset_id)',
    `access_tier` STRING COMMENT 'Governance classification that determines who may consume the dataset.. Valid values are `public|internal|restricted|confidential`',
    `analytical_dataset_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and contents of the dataset.',
    `analytical_dataset_name` STRING COMMENT 'Human‑readable name of the dataset as used by analysts and data scientists.',
    `analytical_dataset_status` STRING COMMENT 'Current lifecycle state of the dataset.. Valid values are `active|deprecated|retired|draft`',
    `catalog_path` STRING COMMENT 'Full Databricks Lakehouse catalog location where the dataset resides.',
    `certified_status` BOOLEAN COMMENT 'Indicates whether the dataset has passed data quality and governance certification.',
    `column_count` STRING COMMENT 'Number of columns (fields) in the dataset schema.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the dataset metadata record was first created in the catalog.',
    `data_classification` STRING COMMENT 'Governance classification applied to the datasets content.. Valid values are `restricted|confidential|internal|public`',
    `data_freshness_sla` STRING COMMENT 'Maximum allowed latency between source data change and dataset availability (e.g., 24h, 48h).',
    `dataset_code` STRING COMMENT 'Business identifier or code assigned to the dataset for cataloging and lookup.',
    `domain` STRING COMMENT 'Broad business domain the dataset belongs to (e.g., customer, product, store, supply_chain, inventory, order, pharmacy, promotions, workforce, finance, vendor, fuel, digital_commerce, loyalty). [ENUM-REF-CANDIDATE: customer|product|store|supply_chain|inventory|order|pharmacy|promotions|workforce|finance|vendor|fuel|digital_commerce|loyalty — promote to reference product]',
    `effective_from` DATE COMMENT 'Date when the dataset became active for consumption.',
    `effective_until` DATE COMMENT 'Date when the dataset is scheduled to be retired or become inactive (nullable).',
    `grain_description` STRING COMMENT 'Description of the datasets granularity (e.g., store‑day, SKU‑week, customer‑month).',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Date‑time when the dataset was most recently refreshed.',
    `owner` STRING COMMENT 'Name of the business owner or team responsible for the dataset.',
    `refresh_schedule` STRING COMMENT 'Scheduled frequency at which the dataset is refreshed.. Valid values are `hourly|daily|weekly|monthly|quarterly`',
    `row_count` BIGINT COMMENT 'Number of rows contained in the most recent refresh of the dataset.',
    `source_system` STRING COMMENT 'Originating operational system(s) that feed the dataset (e.g., SAP Retail, Oracle Retail, Manhattan WMS).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the dataset metadata.',
    CONSTRAINT pk_analytical_dataset PRIMARY KEY(`analytical_dataset_id`)
) COMMENT 'Master catalog of curated analytical datasets and Silver Layer data marts published by the Grocery analytics team for consumption by BI tools, data scientists, and self-service analysts. Captures dataset name, owning domain, grain description (e.g., store-day, SKU-week, customer-month), row count, column count, refresh schedule, data freshness SLA, access tier (public/internal/restricted), Databricks catalog path, and certified status. Serves as the enterprise data catalog entry point for all analytics-ready datasets, enabling discoverability and governed self-service.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`store_sales_fact` (
    `store_sales_fact_id` BIGINT COMMENT 'System-generated unique identifier for each store-day sales fact record.',
    `center_id` BIGINT COMMENT 'Foreign key linking to fuel.fuel_center. Business justification: Daily Store Sales Dashboard requires linking each sales fact to the specific fuel center to report per‑center fuel revenue.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Sales facts need to be tied to the fiscal period entity for period‑based financial consolidation and SOX reporting.',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Daily Sales Reconciliation Report requires tracing each store sales fact row to its originating order header for audit and variance analysis.',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Needed for Transaction Detail Drill‑Down report that joins sales fact to underlying payment transaction for finance reconciliation.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: REQUIRED: Zone‑level sales reporting needs each sales fact linked to its price zone for accurate margin and pricing analysis.',
    `product_item_id` BIGINT COMMENT 'Foreign key linking to product.product_item. Business justification: Daily product‑level sales reporting per store used in performance dashboards; linking enables granular sales analysis.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Store sales are allocated to profit centers for profit‑and‑loss reporting; linking enables profit‑center level sales performance dashboards.',
    `promo_zone_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_zone. Business justification: Required for zone‑level sales reporting used in regional performance dashboards.',
    `retail_price_id` BIGINT COMMENT 'Foreign key linking to pricing.retail_price. Business justification: REQUIRED: Transaction‑level price audit links each sales fact to the exact retail price used, enabling compliance and margin verification.',
    `store_location_id` BIGINT COMMENT 'Unique identifier of the retail store for which the sales are recorded.',
    `prior_day_store_sales_fact_id` BIGINT COMMENT 'Self-referencing FK on store_sales_fact (prior_day_store_sales_fact_id)',
    `average_margin_percent` DECIMAL(18,2) COMMENT 'Gross margin expressed as a percentage of net sales.',
    `average_price_per_unit` DECIMAL(18,2) COMMENT 'Average selling price per item unit (net_sales_amount / total_units_sold).',
    `average_ticket_usd` DECIMAL(18,2) COMMENT 'Average sales amount per transaction (net_sales_amount divided by transaction_count).',
    `average_units_per_transaction` DECIMAL(18,2) COMMENT 'Mean number of items purchased per transaction (total_units_sold / transaction_count).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sales fact row was first inserted.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the monetary values; default USD for Grocery.',
    `day_of_week` STRING COMMENT 'Name of the weekday for sales_date. [ENUM-REF-CANDIDATE: Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday — promote to reference product]',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total dollar value of discounts, coupons, and price reductions applied.',
    `fuel_sales_amount` DECIMAL(18,2) COMMENT 'Revenue from fuel transactions at the store (if applicable) for the day.',
    `fuel_sales_percent` DECIMAL(18,2) COMMENT 'Fuel sales amount expressed as a percentage of total net sales.',
    `gross_margin_amount` DECIMAL(18,2) COMMENT 'Revenue remaining after cost of goods sold; calculated as net_sales_amount minus COGS (provided by downstream process).',
    `gross_margin_percent` DECIMAL(18,2) COMMENT 'Gross margin expressed as a percentage of net sales.',
    `gross_sales_amount` DECIMAL(18,2) COMMENT 'Total sales dollars before discounts, returns, and promotions for the store on the sales_date.',
    `is_holiday` BOOLEAN COMMENT 'True if sales_date is a recognized public or store‑specific holiday.',
    `is_promotional_day` BOOLEAN COMMENT 'True if any store‑wide promotion was active on sales_date.',
    `is_return_day` BOOLEAN COMMENT 'True if the store processed a high volume of returns on sales_date.',
    `loyalty_sales_amount` DECIMAL(18,2) COMMENT 'Net sales generated from loyalty program members, including any loyalty discounts.',
    `loyalty_sales_percent` DECIMAL(18,2) COMMENT 'Loyalty sales amount expressed as a percentage of net sales.',
    `month_of_year` STRING COMMENT 'Numeric month (1‑12) for the sales_date.',
    `net_sales_amount` DECIMAL(18,2) COMMENT 'Net sales after discounts and promotions (gross_sales_amount minus discount_amount).',
    `net_sales_per_sqft` DECIMAL(18,2) COMMENT 'Net sales amount divided by store_sqft, a key productivity metric.',
    `notes` STRING COMMENT 'Free‑form text for any manual adjustments, comments, or anomalies related to the days sales.',
    `price_index` DECIMAL(18,2) COMMENT 'Inflation/deflation factor applied to sales for price normalization.',
    `promo_sales_amount` DECIMAL(18,2) COMMENT 'Sales dollars attributable to promotional pricing, BOGO, TPR, and ad circular offers.',
    `promo_sales_percent` DECIMAL(18,2) COMMENT 'Promotional sales amount expressed as a percentage of net sales.',
    `sales_channel` STRING COMMENT 'Channel through which the sales were generated: in‑store, online, curbside pickup, or home delivery.. Valid values are `in_store|online|pickup|delivery`',
    `sales_date` DATE COMMENT 'Calendar date representing the day of sales aggregation (store local time).',
    `sales_timestamp` TIMESTAMP COMMENT 'Timestamp when the daily sales record was materialized in the silver layer.',
    `shrink_amount` DECIMAL(18,2) COMMENT 'Dollar value of inventory loss due to theft, spoilage, or damage for the day.',
    `shrink_percent` DECIMAL(18,2) COMMENT 'Shrink amount expressed as a percentage of net sales.',
    `store_sales_fact_status` STRING COMMENT 'Current lifecycle status of the daily sales record: provisional (pre‑validation), final (validated), or adjusted (post‑close correction).. Valid values are `provisional|final|adjusted`',
    `store_sqft` DECIMAL(18,2) COMMENT 'Total selling area of the store in square feet.',
    `store_type` STRING COMMENT 'Classification of the store format based on size and service offering.. Valid values are `supercenter|grocery|pharmacy|fuel_center`',
    `total_units_sold` STRING COMMENT 'Aggregate count of all items (units) sold across all transactions.',
    `transaction_count` STRING COMMENT 'Number of individual POS transactions recorded for the store on the sales_date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sales fact row.',
    `week_of_year` STRING COMMENT 'ISO week number (1‑53) for the sales_date.',
    `year` STRING COMMENT 'Four‑digit year for the sales_date.',
    CONSTRAINT pk_store_sales_fact PRIMARY KEY(`store_sales_fact_id`)
) COMMENT 'Core Silver Layer sales fact record at the store-day grain for Grocery, serving as the primary analytical foundation for store operations reporting. Captures total net sales dollars, transaction count, total units sold, average transaction value, gross margin dollars, shrink dollars, promotional sales dollars, loyalty sales dollars, and fuel sales dollars (where applicable). Aggregated from order domain transactional data and materialized as a governed Silver Layer fact. Distinct from comp_sales_result (which focuses on year-over-year comp) — this is the base daily sales ledger for all store performance reporting.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` (
    `promo_effectiveness_id` BIGINT COMMENT 'Unique identifier for each promotion effectiveness record. [_canonical_skip_reason: analytical fact does not fit predefined role categories]',
    `analytical_dataset_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_dataset. Business justification: Promo effectiveness results are stored in analytical datasets.',
    `product_item_id` BIGINT COMMENT 'Identifier of the promoted product (SKU).',
    `promo_campaign_id` BIGINT COMMENT 'Identifier of the promotional campaign being evaluated.',
    `promo_price_link_id` BIGINT COMMENT 'Foreign key linking to pricing.promo_price_link. Business justification: REQUIRED: Measuring promo ROI requires tying effectiveness metrics to the specific promo price link that was applied.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store where the promotion was executed.',
    `baseline_promo_effectiveness_id` BIGINT COMMENT 'Self-referencing FK on promo_effectiveness (baseline_promo_effectiveness_id)',
    `actual_sales_amount` DECIMAL(18,2) COMMENT 'Sales dollars generated by the promoted product during the promotion period.',
    `actual_units_sold` DECIMAL(18,2) COMMENT 'Units sold of the promoted product during the promotion period.',
    `baseline_sales_amount` DECIMAL(18,2) COMMENT 'Projected sales dollars without the promotion (baseline).',
    `baseline_units_sold` DECIMAL(18,2) COMMENT 'Projected units that would have been sold without the promotion (baseline).',
    `cannibalization_rate` DECIMAL(18,2) COMMENT 'Share of sales lift that displaced sales of other SKUs (negative effect).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the record was first created in the analytics layer.',
    `halo_effect_sales_amount` DECIMAL(18,2) COMMENT 'Incremental sales dollars of non-promoted items in adjacent categories.',
    `halo_effect_units` DECIMAL(18,2) COMMENT 'Incremental units sold of non-promoted items in adjacent categories due to the promotion.',
    `incremental_gross_margin` DECIMAL(18,2) COMMENT 'Additional gross margin earned due to the promotion after accounting for variable costs.',
    `is_targeted` BOOLEAN COMMENT 'True if the promotion was limited to a defined customer segment.',
    `is_test_promotion` BOOLEAN COMMENT 'True if the promotion was a pilot or test; otherwise false.',
    `lift_sales_amount` DECIMAL(18,2) COMMENT 'Incremental sales dollars above baseline due to the promotion.',
    `lift_units` DECIMAL(18,2) COMMENT 'Incremental units sold above baseline due to the promotion.',
    `period_end_date` DATE COMMENT 'Last date of the measurement period for the promotion.',
    `period_start_date` DATE COMMENT 'First date of the measurement period for the promotion.',
    `promotion_status` STRING COMMENT 'Lifecycle state of the promotion.. Valid values are `planned|active|completed|cancelled|postponed`',
    `promotion_type` STRING COMMENT 'Classification of the promotion mechanism.. Valid values are `price_discount|buy_one_get_one|multi_buy|gift_with_purchase|loyalty_points|clearance`',
    `redemption_count` BIGINT COMMENT 'Total count of promotion redemptions (e.g., coupons used, BOGO applied).',
    `redemption_rate` DECIMAL(18,2) COMMENT 'Percentage of eligible transactions that redeemed the promotion.',
    `roi_percentage` DECIMAL(18,2) COMMENT 'ROI of the promotion expressed as a percentage (net benefit divided by cost).',
    `sales_channel` STRING COMMENT 'Channel through which the promotion was delivered to the customer.. Valid values are `in_store|online|mobile|curbside|pickup|delivery`',
    `target_customer_segment` STRING COMMENT 'Code representing the customer segment the promotion was aimed at.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the record.',
    `vendor_funding_recovered_amount` DECIMAL(18,2) COMMENT 'Monetary value of vendor contributions (co-op) that were recouped.',
    CONSTRAINT pk_promo_effectiveness PRIMARY KEY(`promo_effectiveness_id`)
) COMMENT 'Transactional analytical record measuring the effectiveness of promotional campaigns and offers at the offer-store-period grain for Grocery. Captures promoted item sales lift (units and dollars vs. baseline), redemption count, redemption rate, incremental gross margin, cannibalization rate, halo effect on adjacent categories, vendor funding recovered, and ROI percentage. Derived from promotion and order domain data. Serves as the authoritative Silver Layer fact for post-promotion analysis (PPA) consumed by category managers, buyers, and the marketing analytics team.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` (
    `loyalty_analytics_fact_id` BIGINT COMMENT 'System‑generated unique identifier for each loyalty analytics fact record.',
    `analytical_dataset_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_dataset. Business justification: Loyalty analytics facts are part of an analytical dataset.',
    `membership_id` BIGINT COMMENT 'Unique identifier of the loyalty program member (customer).',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Loyalty Points Earned Report calculates points earned per order, requiring a direct link from loyalty fact rows to the order header.',
    `program_config_id` BIGINT COMMENT 'Identifier of the loyalty program to which the member belongs.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store (or digital channel) where the activity was recorded.',
    `prior_period_loyalty_analytics_fact_id` BIGINT COMMENT 'Self-referencing FK on loyalty_analytics_fact (prior_period_loyalty_analytics_fact_id)',
    `active_member_count` BIGINT COMMENT 'Number of members actively participating in the loyalty program during the period.',
    `avg_points_balance` DECIMAL(18,2) COMMENT 'Mean points balance held by members at period end.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'Originating system that supplied the loyalty activity data.. Valid values are `POS|eCommerce|MobileApp`',
    `is_lapsed_member` BOOLEAN COMMENT 'True if the member became inactive or lapsed during the period.',
    `is_new_member` BOOLEAN COMMENT 'True if the member enrolled during the reporting period.',
    `lapsed_members` BIGINT COMMENT 'Number of members whose loyalty status became inactive or lapsed during the period.',
    `loyalty_sales_amount` DECIMAL(18,2) COMMENT 'Net sales revenue generated from transactions where the loyalty member received points or discounts.',
    `loyalty_sales_penetration` DECIMAL(18,2) COMMENT 'Share of total sales attributable to loyalty members (loyalty_sales_amount / total_sales_amount).',
    `new_enrollments` BIGINT COMMENT 'Count of new members who enrolled in the loyalty program in the period.',
    `offer_acceptance_rate` DECIMAL(18,2) COMMENT 'Percentage of personalized offers accepted by members (offers_accepted / offers_sent).',
    `period_end_date` DATE COMMENT 'Last calendar date of the reporting period.',
    `period_start_date` DATE COMMENT 'First calendar date of the reporting period (e.g., month, week).',
    `points_accrued` BIGINT COMMENT 'Total loyalty points earned by members in the period.',
    `points_redeemed` BIGINT COMMENT 'Total loyalty points redeemed by members in the period.',
    `program_status` STRING COMMENT 'Current operational status of the loyalty program for the period.. Valid values are `active|inactive|paused`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the fact record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fact record.',
    `redemption_rate` DECIMAL(18,2) COMMENT 'Percentage of accrued points that were redeemed (points_redeemed / points_accrued).',
    `segment` STRING COMMENT 'Business‑defined segment classification of members based on value or behavior.. Valid values are `high|medium|low`',
    `tier_bronze_count` BIGINT COMMENT 'Number of members in the Bronze loyalty tier during the period.',
    `tier_gold_count` BIGINT COMMENT 'Number of members in the Gold loyalty tier during the period.',
    `tier_silver_count` BIGINT COMMENT 'Number of members in the Silver loyalty tier during the period.',
    `total_sales_amount` DECIMAL(18,2) COMMENT 'Overall net sales revenue for the period across all customers.',
    CONSTRAINT pk_loyalty_analytics_fact PRIMARY KEY(`loyalty_analytics_fact_id`)
) COMMENT 'Transactional Silver Layer fact capturing loyalty program performance metrics at the member-period or program-period grain for Grocery. Stores active member count, new enrollments, lapsed members, points accrued, points redeemed, redemption rate, average points balance, tier distribution, loyalty sales penetration (loyalty vs. non-loyalty spend), and personalized offer acceptance rate. Derived from loyalty domain data. Serves as the authoritative analytical record for loyalty program health reporting consumed by the loyalty and marketing analytics teams.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` (
    `inventory_analytics_fact_id` BIGINT COMMENT 'Surrogate primary key for the inventory analytics fact record.',
    `analytical_dataset_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_dataset. Business justification: Each inventory analytics fact belongs to a curated analytical dataset.',
    `category_id` BIGINT COMMENT 'Identifier of the product category hierarchy to which the SKU belongs.',
    `sku_id` BIGINT COMMENT 'Unique identifier of the stock keeping unit (SKU) being measured.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Enables Stock Position Detail Report that analyzes on‑hand value and shrink per stock position across stores.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Supports Location‑Level Inventory Dashboard tracking on‑hand units per storage location for capacity planning.',
    `store_location_id` BIGINT COMMENT 'Unique identifier of the retail store for which the inventory snapshot is recorded.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the vendor or supplier that provides the SKU.',
    `wave_id` BIGINT COMMENT 'Foreign key linking to fulfillment.wave. Business justification: Inventory snapshot per wave supports inventory turn and stock‑out analysis tied to wave execution.',
    `prior_day_inventory_analytics_fact_id` BIGINT COMMENT 'Self-referencing FK on inventory_analytics_fact (prior_day_inventory_analytics_fact_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inventory analytics record was first created in the lakehouse.',
    `data_source_system` STRING COMMENT 'Originating operational system that supplied the source inventory data.. Valid values are `SAP_Retail|Oracle_Retail|Manhattan_WMS`',
    `days_of_supply` DECIMAL(18,2) COMMENT 'Estimated number of days the current on‑hand inventory will satisfy forecasted demand.',
    `fifo_compliance_rate` DECIMAL(18,2) COMMENT 'Percentage of inventory moves that adhered to First‑In‑First‑Out rotation policy.',
    `fill_rate` DECIMAL(18,2) COMMENT 'Proportion of ordered units that were fully supplied from the distribution center.',
    `gmroi` DECIMAL(18,2) COMMENT 'Financial efficiency metric calculated as gross margin divided by average inventory cost.',
    `in_stock_rate` DECIMAL(18,2) COMMENT 'Percentage of time the SKU was available for sale during the reporting period.',
    `inventory_turns` DECIMAL(18,2) COMMENT 'Number of times inventory was sold and replaced over the period.',
    `is_perishable` BOOLEAN COMMENT 'Indicates whether the SKU is classified as perishable (true) or non‑perishable (false).',
    `is_private_label` BOOLEAN COMMENT 'True if the SKU is a store‑owned private label product; otherwise false.',
    `last_replenishment_date` DATE COMMENT 'Date of the most recent replenishment receipt for the SKU at the store.',
    `last_replenishment_quantity` STRING COMMENT 'Units received in the most recent replenishment event.',
    `last_stockout_date` DATE COMMENT 'Date when the SKU most recently went out of stock at the store.',
    `last_stockout_duration_days` DECIMAL(18,2) COMMENT 'Number of days the SKU remained out of stock during the most recent stock‑out event.',
    `on_hand_dollars` DECIMAL(18,2) COMMENT 'Monetary value of on‑hand units based on standard cost or average cost.',
    `on_hand_units` STRING COMMENT 'Quantity of units physically available on the sales floor or backroom at snapshot time.',
    `on_order_dollars` DECIMAL(18,2) COMMENT 'Monetary value of units on order based on purchase price.',
    `on_order_units` STRING COMMENT 'Quantity of units that have been ordered from the distribution center or vendor but not yet received.',
    `out_of_stock_rate` DECIMAL(18,2) COMMENT 'Percentage of time the SKU was unavailable for sale during the reporting period.',
    `record_status` STRING COMMENT 'Current lifecycle status of the analytics record.. Valid values are `active|inactive|archived`',
    `shrink_dollars` DECIMAL(18,2) COMMENT 'Monetary value of shrinkage calculated using standard cost.',
    `shrink_units` STRING COMMENT 'Units lost due to theft, damage, spoilage, or administrative error.',
    `snapshot_date` DATE COMMENT 'Date of the inventory snapshot representing the grain of the fact (SKU‑store‑day).',
    `snapshot_type` STRING COMMENT 'Granularity of the inventory snapshot; typically daily for operational reporting.. Valid values are `daily|weekly|monthly`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inventory analytics record.',
    CONSTRAINT pk_inventory_analytics_fact PRIMARY KEY(`inventory_analytics_fact_id`)
) COMMENT 'Transactional Silver Layer fact capturing inventory health and availability metrics at the SKU-store-day grain for Grocery. Stores on-hand units, on-order units, days of supply (DOS), in-stock rate, out-of-stock (OOS) rate, shrink units and dollars, FIFO rotation compliance rate, and fill rate from replenishment. Derived from inventory domain data. Serves as the authoritative analytical record for inventory performance reporting consumed by store operations, supply chain, and category management teams.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` (
    `vendor_analytics_fact_id` BIGINT COMMENT 'Unique identifier for each vendor performance record. _canonical_skip_reason: Entity does not fit predefined role categories.',
    `analytical_dataset_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_dataset. Business justification: Vendor analytics are produced as analytical datasets.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the vendor as defined in the master vendor dimension.',
    `prior_period_vendor_analytics_fact_id` BIGINT COMMENT 'Self-referencing FK on vendor_analytics_fact (prior_period_vendor_analytics_fact_id)',
    `average_order_value` DECIMAL(18,2) COMMENT 'Mean monetary value of purchase orders for the vendor.',
    `chargeback_amount` DECIMAL(18,2) COMMENT 'Total monetary value of chargebacks assessed against the vendor.',
    `chargeback_count` STRING COMMENT 'Number of chargeback events recorded for the vendor during the period.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the fact record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `USD|CAD|MXN|GBP|EUR`',
    `data_source_system` STRING COMMENT 'Originating operational system (e.g., SAP Retail SD, Oracle Retail Replenishment).',
    `fill_rate` DECIMAL(18,2) COMMENT 'Percentage of ordered line items that were fully supplied in a single shipment.',
    `inbound_shipment_volume` DECIMAL(18,2) COMMENT 'Total volume (e.g., pallets or cubic meters) of goods received from the vendor.',
    `lead_time_actual_days` DECIMAL(18,2) COMMENT 'Average number of days from purchase order issuance to receipt of goods.',
    `lead_time_sla_days` DECIMAL(18,2) COMMENT 'Contractual target lead time defined in the vendor service level agreement.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the vendor performance for the period.',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'Percentage of deliveries that arrived at the store on or before the promised delivery window.',
    `order_accuracy_rate` DECIMAL(18,2) COMMENT 'Percentage of orders delivered without discrepancies between ordered and received quantities.',
    `period_end_date` DATE COMMENT 'Last calendar date of the reporting period for the vendor metrics.',
    `period_start_date` DATE COMMENT 'First calendar date of the reporting period for the vendor metrics.',
    `processing_timestamp` TIMESTAMP COMMENT 'Date‑time when the record was materialized into the silver layer.',
    `record_status` STRING COMMENT 'Current lifecycle status of the fact record.. Valid values are `active|inactive|archived`',
    `total_orders` STRING COMMENT 'Count of purchase orders placed with the vendor in the period.',
    `total_units_received` STRING COMMENT 'Aggregate number of individual units (SKUs) received from the vendor.',
    `total_units_shipped` STRING COMMENT 'Aggregate number of units shipped by the vendor to distribution centers.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the fact record.',
    `vendor_compliance_score` DECIMAL(18,2) COMMENT 'Composite score reflecting overall vendor adherence to contractual and operational metrics.',
    CONSTRAINT pk_vendor_analytics_fact PRIMARY KEY(`vendor_analytics_fact_id`)
) COMMENT 'Transactional Silver Layer fact capturing vendor supply chain performance metrics at the vendor-period grain for Grocery. Stores on-time delivery rate, fill rate, order accuracy rate, chargeback count and dollars, lead time actuals vs. SLA, inbound shipment volume, and vendor compliance score. Derived from supply and vendor domain data. Serves as the authoritative analytical record for vendor performance scorecards consumed by the procurement, supply chain, and category management teams.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` (
    `shopper_behavior_fact_id` BIGINT COMMENT 'Unique surrogate key for each shopper behavior record. _canonical_skip_reason: Fact table does not map to a standard entity role, treated as analytical fact.',
    `analytical_dataset_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_dataset. Business justification: Shopper behavior facts are part of an analytical dataset.',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Customer Lifetime Value model needs to associate shopper behavior metrics with completed orders to calculate revenue per shopper.',
    `shopper_id` BIGINT COMMENT 'Unique identifier of the shopper (customer) to which the behavior metrics belong.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store (or fulfillment location) where the shopper activity was recorded.',
    `prior_period_shopper_behavior_fact_id` BIGINT COMMENT 'Self-referencing FK on shopper_behavior_fact (prior_period_shopper_behavior_fact_id)',
    `avg_spend_per_visit` DECIMAL(18,2) COMMENT 'Average monetary amount per visit (total_spend divided by visit_count).',
    `basket_size_avg_items` DECIMAL(18,2) COMMENT 'Average number of distinct line items per transaction for the shopper.',
    `basket_size_avg_units` DECIMAL(18,2) COMMENT 'Average total quantity of units purchased per transaction (including multiple units of the same SKU).',
    `basket_value_avg` DECIMAL(18,2) COMMENT 'Average monetary value of a single transaction (total_spend divided by visit_count).',
    `channel` STRING COMMENT 'Channel through which the shopper made purchases during the period.. Valid values are `in_store|online|pickup|delivery`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shopper behavior record was first created in the lakehouse.',
    `distinct_category_count` STRING COMMENT 'Number of unique product categories purchased by the shopper in the period.',
    `loyalty_points_earned` STRING COMMENT 'Total loyalty points accrued by the shopper during the period.',
    `loyalty_points_redeemed` STRING COMMENT 'Total loyalty points redeemed (used for discounts or rewards) by the shopper in the period.',
    `period_end_date` DATE COMMENT 'Last calendar date of the analysis period for which the shopper metrics are calculated.',
    `period_start_date` DATE COMMENT 'First calendar date of the analysis period for which the shopper metrics are calculated.',
    `private_label_penetration_pct` DECIMAL(18,2) COMMENT 'Share of total spend attributable to store-owned private‑label brands (percentage).',
    `promotional_spend_pct` DECIMAL(18,2) COMMENT 'Proportion of total spend that occurred under promotional pricing or BOGO offers (percentage).',
    `rfm_score` DECIMAL(18,2) COMMENT 'Composite Recency‑Frequency‑Monetary score calculated for the shopper in the period.',
    `rfm_tier` STRING COMMENT 'Segment tier derived from the RFM score (platinum, gold, silver, bronze).. Valid values are `platinum|gold|silver|bronze`',
    `total_spend` DECIMAL(18,2) COMMENT 'Aggregate monetary amount (USD) spent by the shopper across all purchases in the period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shopper behavior record.',
    `visit_count` STRING COMMENT 'Number of distinct store or channel visits made by the shopper in the period.',
    CONSTRAINT pk_shopper_behavior_fact PRIMARY KEY(`shopper_behavior_fact_id`)
) COMMENT 'Transactional Silver Layer fact capturing individual shopper purchase behavior metrics at the shopper-period grain for Grocery. Stores visit frequency, average spend per visit, total spend in period, category breadth (number of distinct categories purchased), private-label penetration, channel mix (in-store vs. online vs. pickup), promotional sensitivity score, and recency-frequency-monetary (RFM) tier. Derived from order and loyalty domain data. Serves as the authoritative analytical record for customer analytics, personalization, and segmentation consumed by marketing and loyalty teams.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`channel_performance` (
    `channel_performance_id` BIGINT COMMENT 'Unique surrogate key for each channel performance record.',
    `analytical_dataset_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_dataset. Business justification: Channel performance metrics are curated as analytical datasets.',
    `store_location_id` BIGINT COMMENT 'Unique identifier for the store where the channel activity occurred.',
    `prior_period_channel_performance_id` BIGINT COMMENT 'Self-referencing FK on channel_performance (prior_period_channel_performance_id)',
    `average_order_value` DECIMAL(18,2) COMMENT 'Average monetary value per order (net sales divided by order count).',
    `cancellation_rate` DECIMAL(18,2) COMMENT 'Percentage of orders cancelled by the customer or system.',
    `channel_code` STRING COMMENT 'Standard code representing the sales channel (e.g., online, in‑store, pickup, delivery).. Valid values are `online|instore|pickup|delivery`',
    `channel_name` STRING COMMENT 'Human‑readable name of the sales channel.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first loaded into the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values (e.g., USD, CAD).',
    `digital_penetration_pct` DECIMAL(18,2) COMMENT 'Share of total sales that originated from digital channels for the store.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total value of discounts applied to sales in the period.',
    `fulfillment_rate` DECIMAL(18,2) COMMENT 'Percentage of orders fulfilled completely (fulfilled orders / total orders).',
    `gross_sales_amount` DECIMAL(18,2) COMMENT 'Total sales amount before discounts and taxes for the period and channel.',
    `items_per_order` DECIMAL(18,2) COMMENT 'Average number of line items per order.',
    `net_sales_amount` DECIMAL(18,2) COMMENT 'Net sales after discounts and taxes for the channel and period.',
    `on_time_fulfillment_rate` DECIMAL(18,2) COMMENT 'Percentage of orders delivered on or before the promised delivery window.',
    `order_count` BIGINT COMMENT 'Number of orders placed through the channel during the period.',
    `period_end_date` DATE COMMENT 'Last calendar date of the reporting period.',
    `period_start_date` DATE COMMENT 'First calendar date of the reporting period.',
    `period_type` STRING COMMENT 'Granularity of the reporting period.. Valid values are `daily|weekly|monthly|quarterly|yearly`',
    `record_status` STRING COMMENT 'Current lifecycle status of the performance record.. Valid values are `active|inactive|archived`',
    `store_name` STRING COMMENT 'Descriptive name of the store location.',
    `store_number` STRING COMMENT 'Retail store number or identifier used in operational systems.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax collected on sales for the period.',
    `units_sold` BIGINT COMMENT 'Total quantity of items sold across all SKUs for the channel and period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_channel_performance PRIMARY KEY(`channel_performance_id`)
) COMMENT 'Transactional Silver Layer fact capturing omnichannel sales and fulfillment performance metrics at the channel-store-period grain for Grocery. Covers in-store POS, online web, mobile app, curbside pickup, and last-mile delivery channels. Stores net sales by channel, order count, average order value, fulfillment rate, on-time fulfillment rate, cancellation rate, and digital penetration percentage. Derived from order and commerce domain data. Serves as the authoritative analytical record for omnichannel performance reporting consumed by the digital commerce and store operations teams.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` (
    `labor_analytics_fact_id` BIGINT COMMENT 'System-generated unique identifier for each labor analytics fact record.',
    `analytical_dataset_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_dataset. Business justification: Labor analytics facts belong to an analytical dataset.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Labor cost reporting requires mapping each labor record to the cost center for budgeting and variance analysis; finance cost_center defines the budget structure.',
    `department_id` BIGINT COMMENT 'Unique identifier of the store department (e.g., produce, pharmacy) for which labor metrics are recorded.',
    `store_location_id` BIGINT COMMENT 'Unique identifier of the store to which the labor metrics apply.',
    `wave_id` BIGINT COMMENT 'Foreign key linking to fulfillment.wave. Business justification: Labor cost analysis per wave requires linking labor metrics to the specific wave where work occurred.',
    `prior_period_labor_analytics_fact_id` BIGINT COMMENT 'Self-referencing FK on labor_analytics_fact (prior_period_labor_analytics_fact_id)',
    `actual_hours` DECIMAL(18,2) COMMENT 'Total number of labor hours actually worked during the period.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the labor analytics event was recorded (typically period_end_timestamp).',
    `event_type` STRING COMMENT 'Discriminator indicating the type of event; fixed value labor_analytics for this fact.. Valid values are `labor_analytics`',
    `labor_cost_percent_of_sales` DECIMAL(18,2) COMMENT 'Labor cost expressed as a percentage of total sales for the period.',
    `labor_cost_usd` DECIMAL(18,2) COMMENT 'Total labor cost in U.S. dollars incurred during the period, including regular and overtime wages.',
    `open_shift_count` STRING COMMENT 'Number of shifts that remained open (unfilled) at the end of the period.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of labor hours worked beyond scheduled hours that are classified as overtime.',
    `period_date` DATE COMMENT 'Calendar date representing the labor reporting period (typically the day for daily grain).',
    `period_end_timestamp` TIMESTAMP COMMENT 'Timestamp marking the end of the labor measurement window.',
    `period_start_timestamp` TIMESTAMP COMMENT 'Timestamp marking the start of the labor measurement window.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the fact record was initially created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fact record.',
    `sales_per_labor_hour_usd` DECIMAL(18,2) COMMENT 'Gross sales generated per labor hour worked, expressed in U.S. dollars.',
    `schedule_adherence_rate` DECIMAL(18,2) COMMENT 'Percentage of scheduled labor hours that were actually worked.',
    `scheduled_hours` DECIMAL(18,2) COMMENT 'Total number of labor hours that were scheduled for the period.',
    `transactions_per_labor_hour` DECIMAL(18,2) COMMENT 'Number of POS transactions processed per labor hour.',
    CONSTRAINT pk_labor_analytics_fact PRIMARY KEY(`labor_analytics_fact_id`)
) COMMENT 'Transactional Silver Layer fact capturing labor productivity and scheduling efficiency metrics at the store-department-period grain for Grocery. Stores scheduled hours, actual hours worked, overtime hours, labor cost dollars, sales per labor hour (SPLH), transactions per labor hour, labor cost as percent of sales, schedule adherence rate, and open shift count. Derived from workforce domain data. Serves as the authoritative analytical record for labor productivity reporting consumed by store operations, HR analytics, and finance teams.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` (
    `shrink_analytics_fact_id` BIGINT COMMENT 'Unique surrogate key for each shrink analytics record.',
    `analytical_dataset_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_dataset. Business justification: Shrink analytics are stored in analytical datasets.',
    `department_id` BIGINT COMMENT 'Identifier of the store department (e.g., produce, dairy) associated with the shrink.',
    `store_location_id` BIGINT COMMENT 'Identifier of the retail store where the shrink was recorded.',
    `prior_period_shrink_analytics_fact_id` BIGINT COMMENT 'Self-referencing FK on shrink_analytics_fact (prior_period_shrink_analytics_fact_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shrink record was first created in the analytics layer.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary amounts.. Valid values are `USD|CAD|MXN|GBP|EUR|JPY`',
    `cycle_count_variance_dollars` DECIMAL(18,2) COMMENT 'Dollar variance between recorded inventory and cycle count.',
    `cycle_count_variance_units` DECIMAL(18,2) COMMENT 'Units variance identified during cycle count reconciliation.',
    `data_source_system` STRING COMMENT 'Originating operational system that supplied the underlying shrink data.. Valid values are `SAP|Oracle|Manhattan|BlueYonder|NCR`',
    `effective_from` DATE COMMENT 'Start date of the reporting period for which the shrink metrics apply.',
    `effective_until` DATE COMMENT 'End date of the reporting period for which the shrink metrics apply.',
    `is_estimated` BOOLEAN COMMENT 'Indicates whether the shrink values are estimated (true) or based on actual count (false).',
    `markdown_dollars` DECIMAL(18,2) COMMENT 'Dollar value of shrink attributable to markdowns.',
    `markdown_units` DECIMAL(18,2) COMMENT 'Units lost due to markdown-driven shrink.',
    `period_date` DATE COMMENT 'The calendar date representing the reporting period for the shrink metrics.',
    `perishable_shrink_dollars` DECIMAL(18,2) COMMENT 'Dollar value of shrink due to spoilage or perishable loss.',
    `perishable_shrink_units` DECIMAL(18,2) COMMENT 'Units of perishable items lost to spoilage.',
    `record_status` STRING COMMENT 'Current lifecycle status of the shrink analytics record.. Valid values are `active|inactive|deleted`',
    `shrink_dollars` DECIMAL(18,2) COMMENT 'Total dollar value of shrink for the period.',
    `shrink_percent_of_sales` DECIMAL(18,2) COMMENT 'Shrink expressed as a percentage of total sales dollars for the period.',
    `shrink_reason_code` STRING COMMENT 'Internal code describing the specific reason for the shrink event.',
    `shrink_type` STRING COMMENT 'Category of shrink loss (e.g., theft, administrative, vendor, spoilage, markdown, cycle count variance).. Valid values are `theft|administrative|vendor|spoilage|markdown|cycle_count_variance`',
    `shrink_units` DECIMAL(18,2) COMMENT 'Total number of units lost to shrink for the period.',
    `total_sales_dollars` DECIMAL(18,2) COMMENT 'Gross sales dollars for the store‑department‑period grain.',
    `total_sales_units` DECIMAL(18,2) COMMENT 'Total number of units sold for the store‑department‑period grain.',
    `unknown_shrink_dollars` DECIMAL(18,2) COMMENT 'Dollar value of shrink with no identified cause (administrative).',
    `unknown_shrink_units` DECIMAL(18,2) COMMENT 'Units lost with unknown cause.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shrink record.',
    `vendor_shrink_dollars` DECIMAL(18,2) COMMENT 'Shrink dollars attributed to vendor-related loss (e.g., short shipments).',
    `vendor_shrink_units` DECIMAL(18,2) COMMENT 'Units lost due to vendor-related issues.',
    CONSTRAINT pk_shrink_analytics_fact PRIMARY KEY(`shrink_analytics_fact_id`)
) COMMENT 'Transactional Silver Layer fact capturing shrink and loss prevention metrics at the store-department-period grain for Grocery. Stores total shrink dollars and units, shrink as percent of sales, breakdown by shrink type (known theft, unknown/administrative, vendor, spoilage/perishable), cycle count variance, and markdown-driven shrink. Derived from inventory domain shrink_record and cycle_count data. Serves as the authoritative analytical record for shrink management reporting consumed by store operations, loss prevention, and finance teams.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`bi_access_request` (
    `bi_access_request_id` BIGINT COMMENT 'Unique surrogate key for each access request record.',
    `associate_id` BIGINT COMMENT 'Internal surrogate key of the person who approved or rejected the request.',
    `dashboard_id` BIGINT COMMENT 'Foreign key linking to analytics.dashboard. Business justification: BI access requests often target a dashboard; add dashboard reference.',
    `primary_bi_associate_id` BIGINT COMMENT 'Internal surrogate key of the person or entity requesting access.',
    `delegated_from_bi_access_request_id` BIGINT COMMENT 'Self-referencing FK on bi_access_request (delegated_from_bi_access_request_id)',
    `access_expiry_date` DATE COMMENT 'Calendar date when the granted access automatically expires.',
    `access_grant_timestamp` TIMESTAMP COMMENT 'Date‑time when the requested access was provisioned.',
    `access_level` STRING COMMENT 'Level of permission requested: view‑only, edit, or admin.. Valid values are `view|edit|admin`',
    `approval_status` STRING COMMENT 'Current state of the request in its lifecycle.. Valid values are `pending|approved|rejected|revoked`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the request was approved or rejected.',
    `approver_name` STRING COMMENT 'Full legal name of the approver.',
    `business_justification` STRING COMMENT 'Narrative explaining why access is required for business purposes.',
    `compliance_check_passed` BOOLEAN COMMENT 'Indicates whether the request satisfied all regulatory and data‑governance checks.',
    `compliance_notes` STRING COMMENT 'Free‑form notes from the compliance review (e.g., exceptions, conditions).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the access request record was first created in the system.',
    `data_classification` STRING COMMENT 'Classification level of the requested BI asset (restricted, confidential, internal, public).. Valid values are `restricted|confidential|internal|public`',
    `notes` STRING COMMENT 'Optional free‑text field for any supplemental information.',
    `request_number` STRING COMMENT 'Human‑readable identifier assigned to the access request (e.g., AR‑2024‑000123).',
    `request_source` STRING COMMENT 'Channel through which the request was submitted (e.g., self‑service portal, email, API).. Valid values are `portal|email|api`',
    `request_timestamp` TIMESTAMP COMMENT 'Date‑time when the access request was submitted.',
    `requester_name` STRING COMMENT 'Full legal name of the requester.',
    `resource_code` STRING COMMENT 'Unique identifier of the specific dashboard, report, or dataset.',
    `resource_name` STRING COMMENT 'Descriptive name of the BI asset being requested.',
    `resource_type` STRING COMMENT 'Category of the BI asset being requested (dashboard, report, or analytical dataset).. Valid values are `dashboard|report|dataset`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the access request record.',
    CONSTRAINT pk_bi_access_request PRIMARY KEY(`bi_access_request_id`)
) COMMENT 'Operational record managing the lifecycle of access requests to analytics dashboards, reports, and analytical datasets within the Grocery BI platform. Captures requester identity, requested resource (dashboard/report/dataset), access level (view/edit/admin), business justification, approver, approval status, approval date, access grant date, and expiry date. Enables governed self-service access management for the analytics platform ensuring data classification compliance (restricted/confidential/internal/public) is enforced before access is provisioned.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`analytical_lineage` (
    `analytical_lineage_id` BIGINT COMMENT 'Unique identifier for each analytical lineage entry. _canonical_skip_reason: Entity represents business‑level data lineage metadata, not fitting standard role categories.',
    `analytical_dataset_id` BIGINT COMMENT 'Identifier of the target analytical dataset produced by this lineage.',
    `kpi_definition_id` BIGINT COMMENT 'Identifier of the KPI or metric that this lineage supports.',
    `upstream_analytical_lineage_id` BIGINT COMMENT 'Self-referencing FK on analytical_lineage (upstream_analytical_lineage_id)',
    `analytical_lineage_status` STRING COMMENT 'Current lifecycle status of the lineage record.. Valid values are `active|inactive|deprecated`',
    `change_reason` STRING COMMENT 'Reason for the most recent change to the lineage definition.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lineage record was created.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Overall data quality score for the lineage path (0‑100).',
    `effective_from` DATE COMMENT 'Date from which this lineage definition is effective.',
    `effective_until` DATE COMMENT 'Date until which this lineage definition remains valid (null for open‑ended).',
    `last_validated_timestamp` TIMESTAMP COMMENT 'Timestamp when the lineage record was last validated against source systems.',
    `lineage_confidentiality` STRING COMMENT 'Data classification level for the lineage record.. Valid values are `public|internal|confidential|restricted`',
    `lineage_depth_level` STRING COMMENT 'Depth level of the lineage chain (0 = source, higher numbers indicate downstream steps).',
    `lineage_notes` STRING COMMENT 'Additional free‑form notes about the lineage entry.',
    `lineage_owner` STRING COMMENT 'Business owner or team responsible for the lineage definition.',
    `source_domain` STRING COMMENT 'Domain of the source data feeding the analytical lineage entry.',
    `source_object_name` STRING COMMENT 'Specific source object or table name within the source product.',
    `source_product` STRING COMMENT 'Name of the source data product (e.g., sales_transactions, inventory_snapshot).',
    `source_system` STRING COMMENT 'Source system of record (e.g., SAP Retail, Oracle Retail).',
    `target_system` STRING COMMENT 'Target analytical system where the dataset resides (e.g., Databricks Lakehouse).',
    `transformation_description` STRING COMMENT 'Human‑readable description of the transformation logic.',
    `transformation_type` STRING COMMENT 'Category of transformation applied to the source data.. Valid values are `aggregation|join|filter|enrichment|lookup`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the lineage record.',
    CONSTRAINT pk_analytical_lineage PRIMARY KEY(`analytical_lineage_id`)
) COMMENT 'Master record documenting the business-level data lineage for each analytical dataset, KPI, and metric at Grocery. Captures source domain, source product, transformation type (aggregation, join, filter, enrichment), target analytical dataset or KPI, lineage depth level, and last validated timestamp. Distinct from IT-level ETL pipeline logs — this is a business-facing lineage catalog that enables data consumers to understand where a metric comes from, which source products feed a dashboard, and the impact of upstream data changes on downstream analytics.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`forecast_baseline` (
    `forecast_baseline_id` BIGINT COMMENT 'System-generated unique identifier for the forecast baseline record.',
    `metric_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.metric_definition. Business justification: Forecast baselines are defined per metric; add metric reference.',
    `store_location_id` BIGINT COMMENT 'Foreign key linking to store.store_location. Business justification: Store‑level sales forecast baseline needed for weekly forecasting reports; each baseline is tied to a specific store location.',
    `superseded_forecast_baseline_id` BIGINT COMMENT 'Self-referencing FK on forecast_baseline (superseded_forecast_baseline_id)',
    `baseline_code` STRING COMMENT 'Business code used to reference the baseline in external systems.',
    `baseline_name` STRING COMMENT 'Human‑readable name describing the forecast baseline.',
    `baseline_type` STRING COMMENT 'Category of metric the baseline represents.. Valid values are `sales|units|traffic|margin`',
    `baseline_value` DECIMAL(18,2) COMMENT 'Primary forecasted metric value for the defined grain and horizon.',
    `confidence_lower` DECIMAL(18,2) COMMENT 'Lower bound of the statistical confidence interval for the baseline value.',
    `confidence_upper` DECIMAL(18,2) COMMENT 'Upper bound of the statistical confidence interval for the baseline value.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the baseline record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary baseline values.. Valid values are `[A-Z]{3}`',
    `effective_from` DATE COMMENT 'Date when the baseline becomes valid for planning.',
    `effective_until` DATE COMMENT 'Date when the baseline expires or is superseded (nullable).',
    `forecast_baseline_status` STRING COMMENT 'Current lifecycle state of the baseline record.. Valid values are `active|inactive|archived|draft`',
    `forecast_frequency` STRING COMMENT 'Regularity at which the baseline is refreshed or recalculated.. Valid values are `weekly|monthly|daily`',
    `grain` STRING COMMENT 'Granularity of the forecast (e.g., SKU‑store‑week).. Valid values are `sku_store_week|category_store_week|store_week`',
    `horizon_weeks` STRING COMMENT 'Number of weeks forward the baseline forecasts cover.',
    `is_manual_override` BOOLEAN COMMENT 'Indicates whether the baseline value has been manually adjusted.',
    `methodology` STRING COMMENT 'Description of the statistical or ML method used to generate the baseline.',
    `notes` STRING COMMENT 'Free‑form comments or business rationale for the baseline.',
    `seasonality_index` DECIMAL(18,2) COMMENT 'Multiplier applied to capture seasonal effects in the baseline.',
    `source_system` STRING COMMENT 'Originating system or tool that generated the baseline (e.g., Blue Yonder).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the baseline record.',
    `version_number` STRING COMMENT 'Incremental version of the baseline for change tracking.',
    CONSTRAINT pk_forecast_baseline PRIMARY KEY(`forecast_baseline_id`)
) COMMENT 'Master record defining the statistical baseline forecasts used as the foundation for business planning and promotional lift measurement at Grocery. Captures baseline type (sales, units, traffic, margin), grain (SKU-store-week, category-store-week), forecast horizon, baseline methodology (moving average, regression, ML model reference), baseline value, confidence interval, and seasonality index applied. Serves as the authoritative reference baseline against which actual performance and promotional lift are measured in comp sales, promo effectiveness, and category performance analytics.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`scorecard` (
    `scorecard_id` BIGINT COMMENT 'Unique system-generated identifier for the scorecard.',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Scorecards track KPI performance; add KPI reference.',
    `store_location_id` BIGINT COMMENT 'Foreign key linking to store.store_location. Business justification: Store performance scorecards are generated per store; linking scorecard to store_location enables store‑specific KPI aggregation.',
    `prior_period_scorecard_id` BIGINT COMMENT 'Self-referencing FK on scorecard (prior_period_scorecard_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the scorecard record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the scorecard becomes effective for business use.',
    `effective_until` DATE COMMENT 'Date when the scorecard is retired or superseded.',
    `kpi_count` STRING COMMENT 'Count of individual KPI definitions included in the scorecard.',
    `overall_performance_rating` STRING COMMENT 'Color‑coded rating summarizing the scorecards performance against targets.. Valid values are `green|yellow|red`',
    `overall_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing aggregated performance.',
    `publication_timestamp` TIMESTAMP COMMENT 'Date‑time when the scorecard was published to the audience.',
    `reporting_period_end` DATE COMMENT 'Last calendar date of the period covered by the scorecard.',
    `reporting_period_start` DATE COMMENT 'First calendar date of the period covered by the scorecard.',
    `scorecard_code` STRING COMMENT 'Human‑readable code used to reference the scorecard in reports and communications.',
    `scorecard_description` STRING COMMENT 'Free‑form text describing the purpose, scope, and methodology of the scorecard.',
    `scorecard_name` STRING COMMENT 'Descriptive name of the scorecard (e.g., "Q2 Store Operations Scorecard").',
    `scorecard_status` STRING COMMENT 'Current lifecycle state of the scorecard.. Valid values are `draft|published|archived`',
    `scorecard_type` STRING COMMENT 'Category of the scorecard indicating the business domain it evaluates.. Valid values are `store_ops|category|vendor|loyalty|digital`',
    `target_audience_level` STRING COMMENT 'Organizational level for which the scorecard is intended.. Valid values are `store|district|region|banner`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the scorecard record.',
    `version` STRING COMMENT 'Incremental version number for revisions of the scorecard.',
    CONSTRAINT pk_scorecard PRIMARY KEY(`scorecard_id`)
) COMMENT 'Master record for business performance scorecards published to store, district, region, and banner leadership at Grocery. Captures scorecard name, scorecard type (store ops, category, vendor, loyalty, digital), reporting period, target audience level (store/district/region/banner), constituent KPI list, overall performance rating (green/yellow/red), and publication timestamp. Distinct from dashboard (interactive BI tool) — a scorecard is a structured periodic performance summary document with explicit ratings against targets, used in operational reviews and leadership meetings.';

CREATE OR REPLACE TABLE `grocery_ecm`.`analytics`.`kpi_target` (
    `kpi_target_id` BIGINT COMMENT 'System-generated unique identifier for each KPI target record.',
    `associate_id` BIGINT COMMENT 'Identifier of the business owner who approved the KPI target.',
    `kpi_definition_id` BIGINT COMMENT 'Identifier of the KPI for which this target is defined.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the specific organization entity (store, district, etc.) the target is set for.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Allows setting KPI targets per promotional campaign for marketing ROI tracking.',
    `revised_kpi_target_id` BIGINT COMMENT 'Self-referencing FK on kpi_target (revised_kpi_target_id)',
    `compliance_tags` STRING COMMENT 'Comma‑separated list of compliance or regulatory tags applicable to the target (e.g., SOX, FDA).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the KPI target record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary targets.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Score (0‑100) representing confidence in the accuracy of the target data.',
    `effective_from` DATE COMMENT 'Date when the KPI target becomes effective for reporting.',
    `effective_until` DATE COMMENT 'Date when the KPI target expires or is superseded (null if open‑ended).',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter (1‑4) within the fiscal year.',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year for which the target is defined.',
    `is_automated_target` BOOLEAN COMMENT 'True if the target value is generated automatically by a forecasting system.',
    `kpi_target_description` STRING COMMENT 'Free‑form description of the KPI target purpose and scope.',
    `lifecycle_status` STRING COMMENT 'Overall record status indicating if the target is in use, retired, or pending.. Valid values are `active|inactive|archived|pending`',
    `minimum_acceptable_threshold` DECIMAL(18,2) COMMENT 'Lowest acceptable performance level before corrective action is required.',
    `notes` STRING COMMENT 'Supplemental comments or remarks about the target.',
    `organization_level` STRING COMMENT 'Level of the organization to which the target applies.. Valid values are `store|district|region|banner|enterprise`',
    `period_end_date` DATE COMMENT 'Last calendar date of the KPI target period.',
    `period_start_date` DATE COMMENT 'First calendar date of the KPI target period.',
    `source_system` STRING COMMENT 'System that supplied the target value (e.g., Blue Yonder forecasting, SAP, manual entry).. Valid values are `BlueYonder|SAP|Oracle|Manual`',
    `stretch_target_value` DECIMAL(18,2) COMMENT 'Aggressive stretch target value for the KPI, used for high‑performance incentives.',
    `target_approval_date` DATE COMMENT 'Date when the KPI target was officially approved.',
    `target_code` STRING COMMENT 'Business code used to reference the KPI target (e.g., TM_SALES_Q1).',
    `target_methodology` STRING COMMENT 'Method used to derive the target (e.g., top‑down corporate goal, bottom‑up store forecast).. Valid values are `top-down|bottom-up|benchmark|historical|market|custom`',
    `target_owner_department` STRING COMMENT 'Business department responsible for the KPI target.. Valid values are `finance|operations|marketing|merchandising|store|hr`',
    `target_review_date` DATE COMMENT 'Scheduled date for formal review of the KPI target performance.',
    `target_status` STRING COMMENT 'Current lifecycle status of the KPI target record.. Valid values are `draft|approved|locked|revised`',
    `target_type` STRING COMMENT 'Category of the KPI target indicating its business domain.. Valid values are `financial|operational|customer|supply_chain|store`',
    `target_value` DECIMAL(18,2) COMMENT 'Primary performance target value for the KPI.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the target values (e.g., %, USD, units).. Valid values are `percentage|dollar|units|points`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the KPI target record.',
    `version_number` STRING COMMENT 'Incremental version of the KPI target record for change tracking.',
    CONSTRAINT pk_kpi_target PRIMARY KEY(`kpi_target_id`)
) COMMENT 'Transactional record capturing the approved performance targets set for each KPI at a specific organizational level (store, district, region, banner, enterprise) and fiscal period at Grocery. Stores KPI definition reference, target value, stretch target value, minimum acceptable threshold, target-setting methodology (top-down, bottom-up, benchmark-based), approving business owner, and target status (draft/approved/locked). Enables variance analysis between actual KPI results and approved targets across all scorecards and dashboards. Distinct from kpi_definition which defines the KPI itself.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_parent_kpi_definition_id` FOREIGN KEY (`parent_kpi_definition_id`) REFERENCES `grocery_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ADD CONSTRAINT `fk_analytics_metric_definition_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `grocery_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ADD CONSTRAINT `fk_analytics_metric_definition_derived_from_metric_definition_id` FOREIGN KEY (`derived_from_metric_definition_id`) REFERENCES `grocery_ecm`.`analytics`.`metric_definition`(`metric_definition_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `grocery_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ADD CONSTRAINT `fk_analytics_dashboard_cloned_from_dashboard_id` FOREIGN KEY (`cloned_from_dashboard_id`) REFERENCES `grocery_ecm`.`analytics`.`dashboard`(`dashboard_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ADD CONSTRAINT `fk_analytics_report_definition_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `grocery_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ADD CONSTRAINT `fk_analytics_report_definition_parent_report_definition_id` FOREIGN KEY (`parent_report_definition_id`) REFERENCES `grocery_ecm`.`analytics`.`report_definition`(`report_definition_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ADD CONSTRAINT `fk_analytics_comp_sales_period_prior_year_comp_sales_period_id` FOREIGN KEY (`prior_year_comp_sales_period_id`) REFERENCES `grocery_ecm`.`analytics`.`comp_sales_period`(`comp_sales_period_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ADD CONSTRAINT `fk_analytics_comp_sales_result_comp_sales_period_id` FOREIGN KEY (`comp_sales_period_id`) REFERENCES `grocery_ecm`.`analytics`.`comp_sales_period`(`comp_sales_period_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ADD CONSTRAINT `fk_analytics_comp_sales_result_prior_period_comp_sales_result_id` FOREIGN KEY (`prior_period_comp_sales_result_id`) REFERENCES `grocery_ecm`.`analytics`.`comp_sales_result`(`comp_sales_result_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ADD CONSTRAINT `fk_analytics_basket_summary_store_sales_fact_id` FOREIGN KEY (`store_sales_fact_id`) REFERENCES `grocery_ecm`.`analytics`.`store_sales_fact`(`store_sales_fact_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ADD CONSTRAINT `fk_analytics_basket_summary_prior_period_basket_summary_id` FOREIGN KEY (`prior_period_basket_summary_id`) REFERENCES `grocery_ecm`.`analytics`.`basket_summary`(`basket_summary_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ADD CONSTRAINT `fk_analytics_category_performance_prior_period_category_performance_id` FOREIGN KEY (`prior_period_category_performance_id`) REFERENCES `grocery_ecm`.`analytics`.`category_performance`(`category_performance_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ADD CONSTRAINT `fk_analytics_dq_rule_metric_definition_id` FOREIGN KEY (`metric_definition_id`) REFERENCES `grocery_ecm`.`analytics`.`metric_definition`(`metric_definition_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ADD CONSTRAINT `fk_analytics_dq_rule_parent_dq_rule_id` FOREIGN KEY (`parent_dq_rule_id`) REFERENCES `grocery_ecm`.`analytics`.`dq_rule`(`dq_rule_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ADD CONSTRAINT `fk_analytics_dq_result_dq_rule_id` FOREIGN KEY (`dq_rule_id`) REFERENCES `grocery_ecm`.`analytics`.`dq_rule`(`dq_rule_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ADD CONSTRAINT `fk_analytics_dq_result_previous_dq_result_id` FOREIGN KEY (`previous_dq_result_id`) REFERENCES `grocery_ecm`.`analytics`.`dq_result`(`dq_result_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ADD CONSTRAINT `fk_analytics_dq_issue_dq_rule_id` FOREIGN KEY (`dq_rule_id`) REFERENCES `grocery_ecm`.`analytics`.`dq_rule`(`dq_rule_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ADD CONSTRAINT `fk_analytics_dq_issue_related_dq_issue_id` FOREIGN KEY (`related_dq_issue_id`) REFERENCES `grocery_ecm`.`analytics`.`dq_issue`(`dq_issue_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ADD CONSTRAINT `fk_analytics_analytical_dataset_derived_from_analytical_dataset_id` FOREIGN KEY (`derived_from_analytical_dataset_id`) REFERENCES `grocery_ecm`.`analytics`.`analytical_dataset`(`analytical_dataset_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ADD CONSTRAINT `fk_analytics_store_sales_fact_prior_day_store_sales_fact_id` FOREIGN KEY (`prior_day_store_sales_fact_id`) REFERENCES `grocery_ecm`.`analytics`.`store_sales_fact`(`store_sales_fact_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ADD CONSTRAINT `fk_analytics_promo_effectiveness_analytical_dataset_id` FOREIGN KEY (`analytical_dataset_id`) REFERENCES `grocery_ecm`.`analytics`.`analytical_dataset`(`analytical_dataset_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ADD CONSTRAINT `fk_analytics_promo_effectiveness_baseline_promo_effectiveness_id` FOREIGN KEY (`baseline_promo_effectiveness_id`) REFERENCES `grocery_ecm`.`analytics`.`promo_effectiveness`(`promo_effectiveness_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ADD CONSTRAINT `fk_analytics_loyalty_analytics_fact_analytical_dataset_id` FOREIGN KEY (`analytical_dataset_id`) REFERENCES `grocery_ecm`.`analytics`.`analytical_dataset`(`analytical_dataset_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ADD CONSTRAINT `fk_analytics_loyalty_analytics_fact_prior_period_loyalty_analytics_fact_id` FOREIGN KEY (`prior_period_loyalty_analytics_fact_id`) REFERENCES `grocery_ecm`.`analytics`.`loyalty_analytics_fact`(`loyalty_analytics_fact_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ADD CONSTRAINT `fk_analytics_inventory_analytics_fact_analytical_dataset_id` FOREIGN KEY (`analytical_dataset_id`) REFERENCES `grocery_ecm`.`analytics`.`analytical_dataset`(`analytical_dataset_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ADD CONSTRAINT `fk_analytics_inventory_analytics_fact_prior_day_inventory_analytics_fact_id` FOREIGN KEY (`prior_day_inventory_analytics_fact_id`) REFERENCES `grocery_ecm`.`analytics`.`inventory_analytics_fact`(`inventory_analytics_fact_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ADD CONSTRAINT `fk_analytics_vendor_analytics_fact_analytical_dataset_id` FOREIGN KEY (`analytical_dataset_id`) REFERENCES `grocery_ecm`.`analytics`.`analytical_dataset`(`analytical_dataset_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ADD CONSTRAINT `fk_analytics_vendor_analytics_fact_prior_period_vendor_analytics_fact_id` FOREIGN KEY (`prior_period_vendor_analytics_fact_id`) REFERENCES `grocery_ecm`.`analytics`.`vendor_analytics_fact`(`vendor_analytics_fact_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ADD CONSTRAINT `fk_analytics_shopper_behavior_fact_analytical_dataset_id` FOREIGN KEY (`analytical_dataset_id`) REFERENCES `grocery_ecm`.`analytics`.`analytical_dataset`(`analytical_dataset_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ADD CONSTRAINT `fk_analytics_shopper_behavior_fact_prior_period_shopper_behavior_fact_id` FOREIGN KEY (`prior_period_shopper_behavior_fact_id`) REFERENCES `grocery_ecm`.`analytics`.`shopper_behavior_fact`(`shopper_behavior_fact_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ADD CONSTRAINT `fk_analytics_channel_performance_analytical_dataset_id` FOREIGN KEY (`analytical_dataset_id`) REFERENCES `grocery_ecm`.`analytics`.`analytical_dataset`(`analytical_dataset_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ADD CONSTRAINT `fk_analytics_channel_performance_prior_period_channel_performance_id` FOREIGN KEY (`prior_period_channel_performance_id`) REFERENCES `grocery_ecm`.`analytics`.`channel_performance`(`channel_performance_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ADD CONSTRAINT `fk_analytics_labor_analytics_fact_analytical_dataset_id` FOREIGN KEY (`analytical_dataset_id`) REFERENCES `grocery_ecm`.`analytics`.`analytical_dataset`(`analytical_dataset_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ADD CONSTRAINT `fk_analytics_labor_analytics_fact_prior_period_labor_analytics_fact_id` FOREIGN KEY (`prior_period_labor_analytics_fact_id`) REFERENCES `grocery_ecm`.`analytics`.`labor_analytics_fact`(`labor_analytics_fact_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ADD CONSTRAINT `fk_analytics_shrink_analytics_fact_analytical_dataset_id` FOREIGN KEY (`analytical_dataset_id`) REFERENCES `grocery_ecm`.`analytics`.`analytical_dataset`(`analytical_dataset_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ADD CONSTRAINT `fk_analytics_shrink_analytics_fact_prior_period_shrink_analytics_fact_id` FOREIGN KEY (`prior_period_shrink_analytics_fact_id`) REFERENCES `grocery_ecm`.`analytics`.`shrink_analytics_fact`(`shrink_analytics_fact_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ADD CONSTRAINT `fk_analytics_bi_access_request_dashboard_id` FOREIGN KEY (`dashboard_id`) REFERENCES `grocery_ecm`.`analytics`.`dashboard`(`dashboard_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ADD CONSTRAINT `fk_analytics_bi_access_request_delegated_from_bi_access_request_id` FOREIGN KEY (`delegated_from_bi_access_request_id`) REFERENCES `grocery_ecm`.`analytics`.`bi_access_request`(`bi_access_request_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ADD CONSTRAINT `fk_analytics_analytical_lineage_analytical_dataset_id` FOREIGN KEY (`analytical_dataset_id`) REFERENCES `grocery_ecm`.`analytics`.`analytical_dataset`(`analytical_dataset_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ADD CONSTRAINT `fk_analytics_analytical_lineage_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `grocery_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ADD CONSTRAINT `fk_analytics_analytical_lineage_upstream_analytical_lineage_id` FOREIGN KEY (`upstream_analytical_lineage_id`) REFERENCES `grocery_ecm`.`analytics`.`analytical_lineage`(`analytical_lineage_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ADD CONSTRAINT `fk_analytics_forecast_baseline_metric_definition_id` FOREIGN KEY (`metric_definition_id`) REFERENCES `grocery_ecm`.`analytics`.`metric_definition`(`metric_definition_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ADD CONSTRAINT `fk_analytics_forecast_baseline_superseded_forecast_baseline_id` FOREIGN KEY (`superseded_forecast_baseline_id`) REFERENCES `grocery_ecm`.`analytics`.`forecast_baseline`(`forecast_baseline_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ADD CONSTRAINT `fk_analytics_scorecard_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `grocery_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ADD CONSTRAINT `fk_analytics_scorecard_prior_period_scorecard_id` FOREIGN KEY (`prior_period_scorecard_id`) REFERENCES `grocery_ecm`.`analytics`.`scorecard`(`scorecard_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `grocery_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_revised_kpi_target_id` FOREIGN KEY (`revised_kpi_target_id`) REFERENCES `grocery_ecm`.`analytics`.`kpi_target`(`kpi_target_id`);

-- ========= TAGS =========
ALTER SCHEMA `grocery_ecm`.`analytics` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `grocery_ecm`.`analytics` SET TAGS ('dbx_domain' = 'analytics');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` SET TAGS ('dbx_subdomain' = 'performance_management');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'KPI Definition Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `parent_kpi_definition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'KPI Calculation Methodology');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `data_quality_rule` SET TAGS ('dbx_business_glossary_term' = 'KPI Data Quality Rule');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'KPI Data Source');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_definition_category` SET TAGS ('dbx_business_glossary_term' = 'KPI Category');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_definition_category` SET TAGS ('dbx_value_regex' = 'sales|inventory|customer|finance|operations|loyalty');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_definition_code` SET TAGS ('dbx_business_glossary_term' = 'KPI Code');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_definition_description` SET TAGS ('dbx_business_glossary_term' = 'KPI Description');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_definition_name` SET TAGS ('dbx_business_glossary_term' = 'KPI Name');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_definition_status` SET TAGS ('dbx_business_glossary_term' = 'KPI Lifecycle Status');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_definition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|draft|pending');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'KPI Owner');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'KPI Reporting Frequency');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `strategic_objective` SET TAGS ('dbx_business_glossary_term' = 'Strategic Objective');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `target_threshold` SET TAGS ('dbx_business_glossary_term' = 'KPI Target Threshold');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'KPI Target Value');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'KPI Definition Version');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` SET TAGS ('dbx_subdomain' = 'performance_management');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Metric Definition ID');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Metric Owner Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Price Rule Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `tender_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Type Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `derived_from_metric_definition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `data_type` SET TAGS ('dbx_business_glossary_term' = 'Metric Data Type');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `data_type` SET TAGS ('dbx_value_regex' = 'integer|decimal|string|date|boolean');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_audience` SET TAGS ('dbx_business_glossary_term' = 'Metric Audience');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_audience` SET TAGS ('dbx_value_regex' = 'analyst|executive|operations|ml|marketing');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_category` SET TAGS ('dbx_business_glossary_term' = 'Metric Category');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_category` SET TAGS ('dbx_value_regex' = 'sales|inventory|finance|customer|operations|supply_chain');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_confidentiality` SET TAGS ('dbx_business_glossary_term' = 'Metric Confidentiality');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_confidentiality` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Metric Data Quality Score');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_definition_source` SET TAGS ('dbx_business_glossary_term' = 'Metric Definition Source');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_description` SET TAGS ('dbx_business_glossary_term' = 'Metric Description');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_formula` SET TAGS ('dbx_business_glossary_term' = 'Metric Formula');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_grain` SET TAGS ('dbx_business_glossary_term' = 'Metric Grain');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_grain` SET TAGS ('dbx_value_regex' = 'store_day|category_week|product_month|store_week');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_is_aggregated` SET TAGS ('dbx_business_glossary_term' = 'Metric Is Aggregated');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_is_time_variant` SET TAGS ('dbx_business_glossary_term' = 'Metric Is Time‑Variant');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_last_validated` SET TAGS ('dbx_business_glossary_term' = 'Metric Last Validated');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_lineage` SET TAGS ('dbx_business_glossary_term' = 'Metric Lineage');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Metric Name');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_owner` SET TAGS ('dbx_business_glossary_term' = 'Metric Owner');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_status` SET TAGS ('dbx_business_glossary_term' = 'Metric Status');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|draft|pending');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_tags` SET TAGS ('dbx_business_glossary_term' = 'Metric Tags');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_units` SET TAGS ('dbx_business_glossary_term' = 'Metric Units');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_valid_from` SET TAGS ('dbx_business_glossary_term' = 'Metric Valid From');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_valid_to` SET TAGS ('dbx_business_glossary_term' = 'Metric Valid To');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `metric_version` SET TAGS ('dbx_business_glossary_term' = 'Metric Version');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `source_domain` SET TAGS ('dbx_business_glossary_term' = 'Source Data Domain');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `source_product` SET TAGS ('dbx_business_glossary_term' = 'Source Product');
ALTER TABLE `grocery_ecm`.`analytics`.`metric_definition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` SET TAGS ('dbx_subdomain' = 'performance_management');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `dashboard_id` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Owner Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `owner_associate_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `owner_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `pricing_recommendation_id` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `cloned_from_dashboard_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'public|restricted|confidential');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `audience` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Target Audience');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `audience` SET TAGS ('dbx_value_regex' = 'store_ops|category_mgmt|finance|executive|marketing|supply_chain');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `average_load_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Average Load Time (Seconds)');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `compliance_tags` SET TAGS ('dbx_business_glossary_term' = 'Compliance Tags');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `dashboard_code` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Code');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `dashboard_description` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Description');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `dashboard_name` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Name');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `dashboard_status` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Lifecycle Status');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `dashboard_status` SET TAGS ('dbx_value_regex' = 'draft|published|certified|retired|archived');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `dashboard_type` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Type');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `dashboard_type` SET TAGS ('dbx_value_regex' = 'operational|strategic|executive|ad_hoc|reporting|analytics');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `data_governance_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Classification');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `data_governance_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `data_source_summary` SET TAGS ('dbx_business_glossary_term' = 'Data Source Summary');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `domain` SET TAGS ('dbx_business_glossary_term' = 'Business Domain');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `is_certified` SET TAGS ('dbx_business_glossary_term' = 'Certified Flag');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Platform');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `platform` SET TAGS ('dbx_value_regex' = 'databricks_sql|tableau|power_bi|lookml');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `publication_status` SET TAGS ('dbx_business_glossary_term' = 'Publication Status');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `publication_status` SET TAGS ('dbx_value_regex' = 'draft|published|archived');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `refresh_cadence` SET TAGS ('dbx_business_glossary_term' = 'Refresh Cadence');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `refresh_cadence` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly|on_demand');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `related_reports` SET TAGS ('dbx_business_glossary_term' = 'Related Reports');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `sla_response_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'SLA Response Time (Seconds)');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Tags');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Version Number');
ALTER TABLE `grocery_ecm`.`analytics`.`dashboard` ALTER COLUMN `view_count` SET TAGS ('dbx_business_glossary_term' = 'Dashboard View Count');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` SET TAGS ('dbx_subdomain' = 'customer_insights');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Definition ID');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Report Owner Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `parent_report_definition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Report Access Level');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Definition Created Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `data_freshness_sla_days` SET TAGS ('dbx_business_glossary_term' = 'Data Freshness SLA (Days)');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Report Data Quality Score');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System for Report Data');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Report Delivery Format');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `delivery_format` SET TAGS ('dbx_value_regex' = 'PDF|Excel|CSV|Email|SFTP');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `is_ad_hoc` SET TAGS ('dbx_business_glossary_term' = 'Is Ad‑Hoc Report');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `is_scheduled` SET TAGS ('dbx_business_glossary_term' = 'Is Report Scheduled');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `last_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Run Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `next_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Run Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `owner_domain` SET TAGS ('dbx_business_glossary_term' = 'Owning Business Domain');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `recipient_list` SET TAGS ('dbx_business_glossary_term' = 'Report Recipient List');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `regulatory_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Is Regulatory Report');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_audience` SET TAGS ('dbx_business_glossary_term' = 'Report Audience');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_audience` SET TAGS ('dbx_value_regex' = 'internal|external');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_category` SET TAGS ('dbx_business_glossary_term' = 'Report Category');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_category` SET TAGS ('dbx_value_regex' = 'sales|inventory|finance|operations|customer|compliance');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_definition_code` SET TAGS ('dbx_business_glossary_term' = 'Report Code');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_definition_description` SET TAGS ('dbx_business_glossary_term' = 'Report Description');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_definition_name` SET TAGS ('dbx_business_glossary_term' = 'Report Name');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_definition_status` SET TAGS ('dbx_business_glossary_term' = 'Report Lifecycle Status');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_definition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_definition_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_definition_type` SET TAGS ('dbx_value_regex' = 'operational|financial|regulatory|ad_hoc');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_distribution_method` SET TAGS ('dbx_business_glossary_term' = 'Report Distribution Method');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_language` SET TAGS ('dbx_business_glossary_term' = 'Report Language');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Report Last Modified By');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_last_modified_by_email` SET TAGS ('dbx_business_glossary_term' = 'Report Last Modified By Email');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_last_modified_by_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_last_modified_by_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_last_modified_by_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_owner` SET TAGS ('dbx_business_glossary_term' = 'Report Owner Name');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Report Owner Email Address');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_owner_phone` SET TAGS ('dbx_business_glossary_term' = 'Report Owner Phone Number');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_owner_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_owner_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_priority` SET TAGS ('dbx_business_glossary_term' = 'Report Priority');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_tags` SET TAGS ('dbx_business_glossary_term' = 'Report Tags');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Report Retention Period (Days)');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `schedule_cron` SET TAGS ('dbx_business_glossary_term' = 'Report Schedule Cron Expression');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Definition Updated Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`report_definition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Report Definition Version Number');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` SET TAGS ('dbx_subdomain' = 'sales_analytics');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `comp_sales_period_id` SET TAGS ('dbx_business_glossary_term' = 'Comparable Sales Period ID');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `prior_year_comp_sales_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `current_end_date` SET TAGS ('dbx_business_glossary_term' = 'Current Period End Date (CPED)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `current_start_date` SET TAGS ('dbx_business_glossary_term' = 'Current Period Start Date (CPSD)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Timestamp (EFT)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Timestamp (EUT)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria (EC)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Reason (ER)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_value_regex' = 'remodeled|relocated|closed|other');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `is_eligible` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Flag (EF)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `is_excluded` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Flag (XF)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (N)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `period_label` SET TAGS ('dbx_business_glossary_term' = 'Period Label (PL)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type (PT)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'week|4-week|quarter|fiscal_year');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `prior_end_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Period End Date (PPED)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `prior_start_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Start Date (PPSD)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `relocation_flag` SET TAGS ('dbx_business_glossary_term' = 'Relocation Flag (RLF)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `remodel_flag` SET TAGS ('dbx_business_glossary_term' = 'Remodel Flag (RF)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `store_open_weeks` SET TAGS ('dbx_business_glossary_term' = 'Store Open Weeks (SOW)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_period` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VN)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` SET TAGS ('dbx_subdomain' = 'sales_analytics');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `comp_sales_result_id` SET TAGS ('dbx_business_glossary_term' = 'Comparable Sales Result ID');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `banner_id` SET TAGS ('dbx_business_glossary_term' = 'Banner Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `comp_sales_period_id` SET TAGS ('dbx_business_glossary_term' = 'Comp Sales Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `price_change_id` SET TAGS ('dbx_business_glossary_term' = 'Price Change Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `prior_period_comp_sales_result_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `basket_size_current` SET TAGS ('dbx_business_glossary_term' = 'Current Basket Size (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `basket_size_prior` SET TAGS ('dbx_business_glossary_term' = 'Prior Basket Size (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `basket_size_variance` SET TAGS ('dbx_business_glossary_term' = 'Basket Size Variance');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `comp_sales_dollar_variance` SET TAGS ('dbx_business_glossary_term' = 'Comp Sales Dollar Variance');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `comp_sales_percent_change` SET TAGS ('dbx_business_glossary_term' = 'Comp Sales Percent Change');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN|GBP|EUR');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `discount_current` SET TAGS ('dbx_business_glossary_term' = 'Current Discount Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `discount_prior` SET TAGS ('dbx_business_glossary_term' = 'Prior Discount Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Flag');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Reason');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_value_regex' = 'store_closed|data_insufficient|seasonal|other');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `gross_sales_current` SET TAGS ('dbx_business_glossary_term' = 'Current Gross Sales (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `gross_sales_prior` SET TAGS ('dbx_business_glossary_term' = 'Prior Gross Sales (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `net_sales_current` SET TAGS ('dbx_business_glossary_term' = 'Current Net Sales (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `net_sales_prior` SET TAGS ('dbx_business_glossary_term' = 'Prior Net Sales (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `result_key` SET TAGS ('dbx_business_glossary_term' = 'Comparable Sales Result Key');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'active|inactive|excluded');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `result_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Result Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `transaction_count_current` SET TAGS ('dbx_business_glossary_term' = 'Current Transaction Count');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `transaction_count_prior` SET TAGS ('dbx_business_glossary_term' = 'Prior Transaction Count');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `transaction_count_variance` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count Variance');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `units_sold_current` SET TAGS ('dbx_business_glossary_term' = 'Current Units Sold');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `units_sold_prior` SET TAGS ('dbx_business_glossary_term' = 'Prior Units Sold');
ALTER TABLE `grocery_ecm`.`analytics`.`comp_sales_result` ALTER COLUMN `units_variance` SET TAGS ('dbx_business_glossary_term' = 'Units Sold Variance');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` SET TAGS ('dbx_subdomain' = 'sales_analytics');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `basket_summary_id` SET TAGS ('dbx_business_glossary_term' = 'Basket Summary ID');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `store_sales_fact_id` SET TAGS ('dbx_business_glossary_term' = 'Store Sales Fact Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `prior_period_basket_summary_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `average_basket_value` SET TAGS ('dbx_business_glossary_term' = 'Average Basket Value (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `average_discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Discount Rate (%)');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `average_gross_margin` SET TAGS ('dbx_business_glossary_term' = 'Average Gross Margin (%)');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `average_items_per_basket` SET TAGS ('dbx_business_glossary_term' = 'Average Items Per Basket (UPT)');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `average_transaction_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Average Transaction Time (seconds)');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `basket_count` SET TAGS ('dbx_business_glossary_term' = 'Basket Count');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `basket_date` SET TAGS ('dbx_business_glossary_term' = 'Basket Date');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `basket_key` SET TAGS ('dbx_business_glossary_term' = 'Basket Key');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `basket_size_tier` SET TAGS ('dbx_business_glossary_term' = 'Basket Size Tier');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `basket_size_tier` SET TAGS ('dbx_value_regex' = 'small|medium|large');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `basket_summary_status` SET TAGS ('dbx_business_glossary_term' = 'Basket Summary Status');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `basket_summary_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|cancelled');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `fill_rate` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate (%)');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `fiscal_week` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Week');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `large_basket_count` SET TAGS ('dbx_business_glossary_term' = 'Large Basket Count');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `loyalty_basket_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Basket Flag');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `medium_basket_count` SET TAGS ('dbx_business_glossary_term' = 'Medium Basket Count');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `multi_category_rate` SET TAGS ('dbx_business_glossary_term' = 'Multi‑Category Basket Rate (%)');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `net_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Sales Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `out_of_stock_rate` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Stock Rate (%)');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'cash|credit_card|debit_card|mobile_payment|gift_card');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `private_label_penetration` SET TAGS ('dbx_business_glossary_term' = 'Private‑Label Penetration (%)');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `promotional_basket_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Basket Flag');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `record_created` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `record_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `shrink_rate` SET TAGS ('dbx_business_glossary_term' = 'Shrink Rate (%)');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `small_basket_count` SET TAGS ('dbx_business_glossary_term' = 'Small Basket Count');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `store_format` SET TAGS ('dbx_business_glossary_term' = 'Store Format');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `store_format` SET TAGS ('dbx_value_regex' = 'supermarket|pharmacy|fuel_center|express');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `store_region` SET TAGS ('dbx_business_glossary_term' = 'Store Region');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `total_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `total_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Sales Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `transaction_channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `grocery_ecm`.`analytics`.`basket_summary` ALTER COLUMN `transaction_channel` SET TAGS ('dbx_value_regex' = 'in_store|online|pickup|delivery');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` SET TAGS ('dbx_subdomain' = 'sales_analytics');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `category_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Category Performance ID');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `prior_period_category_performance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `average_inventory_cost` SET TAGS ('dbx_business_glossary_term' = 'Average Inventory Cost (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `average_retail_price` SET TAGS ('dbx_business_glossary_term' = 'Average Retail Price (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `category_penetration_rate` SET TAGS ('dbx_business_glossary_term' = 'Category Penetration Rate');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `category_status` SET TAGS ('dbx_business_glossary_term' = 'Category Status');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `category_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `gross_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `gross_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Percent');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `inventory_turn` SET TAGS ('dbx_business_glossary_term' = 'Inventory Turn');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `markdown_amount` SET TAGS ('dbx_business_glossary_term' = 'Markdown Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `markdown_percent` SET TAGS ('dbx_business_glossary_term' = 'Markdown Percent');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `net_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Sales Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `out_of_stock_rate` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Stock Rate');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `price_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Change Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `price_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Change Flag');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `price_change_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Change Percent');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `promotional_sales_lift_amount` SET TAGS ('dbx_business_glossary_term' = 'Promotional Sales Lift Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `promotional_sales_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Promotional Sales Lift Percent');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `shrink_dollars` SET TAGS ('dbx_business_glossary_term' = 'Shrink Dollars (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP|Oracle|Manhattan|BlueYonder|NCR|Salesforce');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `stock_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Stock On Hand');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `units_sold` SET TAGS ('dbx_business_glossary_term' = 'Units Sold');
ALTER TABLE `grocery_ecm`.`analytics`.`category_performance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` SET TAGS ('dbx_subdomain' = 'data_governance');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `dq_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Rule ID');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `metric_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Metric Definition Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `parent_dq_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `dq_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description (RD)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUD)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated (IA)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `last_pass_rate` SET TAGS ('dbx_business_glossary_term' = 'Last Pass Rate (LPR)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `last_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Run Timestamp (LRT)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LS)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `pass_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Pass Threshold Percentage (PTP)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `remediation_owner` SET TAGS ('dbx_business_glossary_term' = 'Remediation Owner (RO)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Rule Category (RC)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `rule_expression` SET TAGS ('dbx_business_glossary_term' = 'Rule Expression (RE)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Rule Name');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Rule Type (DQRT)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'completeness|uniqueness|validity|referential_integrity|timeliness|consistency');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level (SL)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|warning|info');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SS)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SQL|Great Expectations|Custom');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `target_column` SET TAGS ('dbx_business_glossary_term' = 'Target Column Name (TCN)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `target_domain` SET TAGS ('dbx_business_glossary_term' = 'Target Business Domain (TBD)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `target_entity` SET TAGS ('dbx_business_glossary_term' = 'Target Entity Name (TEN)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` SET TAGS ('dbx_subdomain' = 'data_governance');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `dq_result_id` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Result ID');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `dq_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Rule ID');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `previous_dq_result_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `data_asset` SET TAGS ('dbx_business_glossary_term' = 'Data Asset Name');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `data_asset_version` SET TAGS ('dbx_business_glossary_term' = 'Data Asset Version');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `dq_result_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Execution Status');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `dq_result_status` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `evaluated_record_count` SET TAGS ('dbx_business_glossary_term' = 'Evaluated Record Count');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `execution_environment` SET TAGS ('dbx_business_glossary_term' = 'Execution Environment');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `failed_record_count` SET TAGS ('dbx_business_glossary_term' = 'Failed Record Count');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `pass_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Pass Rate Percentage');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `passed_record_count` SET TAGS ('dbx_business_glossary_term' = 'Passed Record Count');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `remediation_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Remediation Ticket ID');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Rule Category');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Rule Name');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `sample_failed_keys` SET TAGS ('dbx_business_glossary_term' = 'Sample Failed Record Keys');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `target_column` SET TAGS ('dbx_business_glossary_term' = 'Target Column');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `target_domain` SET TAGS ('dbx_business_glossary_term' = 'Target Data Domain');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `target_product` SET TAGS ('dbx_business_glossary_term' = 'Target Data Product');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` SET TAGS ('dbx_subdomain' = 'data_governance');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `dq_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Issue Identifier (DQ_ISSUE_ID)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `dq_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Rule Identifier (DQ_RULE_ID)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `item_attribute_id` SET TAGS ('dbx_business_glossary_term' = 'Product Item Attribute Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `related_dq_issue_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `affected_record_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Record Count (AFFECTED_RECORD_COUNT)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `assigned_owner` SET TAGS ('dbx_business_glossary_term' = 'Issue Owner (OWNER)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Additional Comments (COMMENTS)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification (DATA_CLASSIFICATION)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method (DETECTION_METHOD)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'automated_rule|manual_review|user_report');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `domain` SET TAGS ('dbx_business_glossary_term' = 'Business Domain (DOMAIN)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `domain` SET TAGS ('dbx_value_regex' = 'customer|product|inventory|order|finance|supply_chain');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `dq_issue_status` SET TAGS ('dbx_business_glossary_term' = 'Issue Status (STATUS)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `dq_issue_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|waived');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `impact_score` SET TAGS ('dbx_business_glossary_term' = 'Impact Score (IMPACT_SCORE)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Flag (IS_CRITICAL)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `is_regulatory` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag (IS_REGULATORY)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `issue_category` SET TAGS ('dbx_business_glossary_term' = 'Issue Category (ISSUE_CATEGORY)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `issue_category` SET TAGS ('dbx_value_regex' = 'validation|integration|master_data|reference_data');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `issue_description` SET TAGS ('dbx_business_glossary_term' = 'Issue Description (DESCRIPTION)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `issue_type` SET TAGS ('dbx_business_glossary_term' = 'Issue Type (ISSUE_TYPE)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `issue_type` SET TAGS ('dbx_value_regex' = 'data_quality|completeness|accuracy|timeliness|consistency');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp (LAST_REVIEWED_TIMESTAMP)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Issue Priority (PRIORITY)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `product` SET TAGS ('dbx_business_glossary_term' = 'Data Product (PRODUCT)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body (REGULATORY_BODY)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action (REMEDIATION_ACTION)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes (RESOLUTION_NOTES)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category (ROOT_CAUSE_CATEGORY)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'source_system|etl|business_rule_change|schema_drift|manual');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Issue Severity (SEVERITY)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `sla_due_date` SET TAGS ('dbx_business_glossary_term' = 'SLA Due Date (SLA_DUE_DATE)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYSTEM)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date (TARGET_RESOLUTION_DATE)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Issue Title (TITLE)');
ALTER TABLE `grocery_ecm`.`analytics`.`dq_issue` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` SET TAGS ('dbx_subdomain' = 'data_governance');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `analytical_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Dataset Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `derived_from_analytical_dataset_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `access_tier` SET TAGS ('dbx_business_glossary_term' = 'Dataset Access Tier');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `access_tier` SET TAGS ('dbx_value_regex' = 'public|internal|restricted|confidential');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `analytical_dataset_description` SET TAGS ('dbx_business_glossary_term' = 'Dataset Description');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `analytical_dataset_name` SET TAGS ('dbx_business_glossary_term' = 'Analytical Dataset Name');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `analytical_dataset_status` SET TAGS ('dbx_business_glossary_term' = 'Dataset Lifecycle Status');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `analytical_dataset_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|retired|draft');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `catalog_path` SET TAGS ('dbx_business_glossary_term' = 'Databricks Catalog Path');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `certified_status` SET TAGS ('dbx_business_glossary_term' = 'Dataset Certified Status');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `column_count` SET TAGS ('dbx_business_glossary_term' = 'Dataset Column Count');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `data_freshness_sla` SET TAGS ('dbx_business_glossary_term' = 'Data Freshness Service Level Agreement');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `dataset_code` SET TAGS ('dbx_business_glossary_term' = 'Analytical Dataset Code');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `domain` SET TAGS ('dbx_business_glossary_term' = 'Analytical Dataset Domain');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Dataset Effective From Date');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Dataset Effective Until Date');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `grain_description` SET TAGS ('dbx_business_glossary_term' = 'Dataset Grain Description');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Dataset Owner');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `refresh_schedule` SET TAGS ('dbx_business_glossary_term' = 'Dataset Refresh Schedule');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `refresh_schedule` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly|quarterly');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `row_count` SET TAGS ('dbx_business_glossary_term' = 'Dataset Row Count');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` SET TAGS ('dbx_subdomain' = 'sales_analytics');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `store_sales_fact_id` SET TAGS ('dbx_business_glossary_term' = 'Store Sales Fact Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Price Zone Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `promo_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Zone Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `retail_price_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `prior_day_store_sales_fact_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `average_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Average Margin Percent');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `average_price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Average Price per Unit (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `average_ticket_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Ticket Value (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `average_units_per_transaction` SET TAGS ('dbx_business_glossary_term' = 'Average Units per Transaction');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Day of Week');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discounts and Allowances Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `fuel_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Sales Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `fuel_sales_percent` SET TAGS ('dbx_business_glossary_term' = 'Fuel Sales Percent');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `gross_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `gross_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Percent');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `gross_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Sales Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `is_holiday` SET TAGS ('dbx_business_glossary_term' = 'Holiday Indicator');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `is_promotional_day` SET TAGS ('dbx_business_glossary_term' = 'Promotional Day Indicator');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `is_return_day` SET TAGS ('dbx_business_glossary_term' = 'Return Day Indicator');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `loyalty_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Sales Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `loyalty_sales_percent` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Sales Percent');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `month_of_year` SET TAGS ('dbx_business_glossary_term' = 'Month of Year');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `net_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Sales Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `net_sales_per_sqft` SET TAGS ('dbx_business_glossary_term' = 'Net Sales per Square Foot (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `price_index` SET TAGS ('dbx_business_glossary_term' = 'Price Index');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `promo_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Promotional Sales Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `promo_sales_percent` SET TAGS ('dbx_business_glossary_term' = 'Promotional Sales Percent');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'in_store|online|pickup|delivery');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `sales_date` SET TAGS ('dbx_business_glossary_term' = 'Sales Date');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `sales_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sales Aggregation Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `shrink_amount` SET TAGS ('dbx_business_glossary_term' = 'Shrink Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `shrink_percent` SET TAGS ('dbx_business_glossary_term' = 'Shrink Percent');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `store_sales_fact_status` SET TAGS ('dbx_business_glossary_term' = 'Sales Record Status');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `store_sales_fact_status` SET TAGS ('dbx_value_regex' = 'provisional|final|adjusted');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `store_sqft` SET TAGS ('dbx_business_glossary_term' = 'Store Square Footage');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `store_type` SET TAGS ('dbx_business_glossary_term' = 'Store Type');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `store_type` SET TAGS ('dbx_value_regex' = 'supercenter|grocery|pharmacy|fuel_center');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `total_units_sold` SET TAGS ('dbx_business_glossary_term' = 'Total Units Sold');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `week_of_year` SET TAGS ('dbx_business_glossary_term' = 'Week of Year');
ALTER TABLE `grocery_ecm`.`analytics`.`store_sales_fact` ALTER COLUMN `year` SET TAGS ('dbx_business_glossary_term' = 'Year');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` SET TAGS ('dbx_subdomain' = 'sales_analytics');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `promo_effectiveness_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Effectiveness Record ID');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `analytical_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Dataset Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID (SKU)');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `promo_price_link_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Price Link Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `baseline_promo_effectiveness_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `actual_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Sales Amount');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `actual_units_sold` SET TAGS ('dbx_business_glossary_term' = 'Actual Units Sold');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `baseline_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Baseline Sales Amount');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `baseline_units_sold` SET TAGS ('dbx_business_glossary_term' = 'Baseline Units Sold');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `cannibalization_rate` SET TAGS ('dbx_business_glossary_term' = 'Cannibalization Rate');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `halo_effect_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Halo Effect Sales Amount');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `halo_effect_units` SET TAGS ('dbx_business_glossary_term' = 'Halo Effect Units');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `incremental_gross_margin` SET TAGS ('dbx_business_glossary_term' = 'Incremental Gross Margin');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `is_targeted` SET TAGS ('dbx_business_glossary_term' = 'Targeted Promotion Indicator');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `is_test_promotion` SET TAGS ('dbx_business_glossary_term' = 'Test Promotion Indicator');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `lift_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Sales Lift Amount');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `lift_units` SET TAGS ('dbx_business_glossary_term' = 'Units Lift');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Period End Date');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Period Start Date');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `promotion_status` SET TAGS ('dbx_business_glossary_term' = 'Promotion Status');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `promotion_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|cancelled|postponed');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `promotion_type` SET TAGS ('dbx_business_glossary_term' = 'Promotion Type');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `promotion_type` SET TAGS ('dbx_value_regex' = 'price_discount|buy_one_get_one|multi_buy|gift_with_purchase|loyalty_points|clearance');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Redemption Count');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `redemption_rate` SET TAGS ('dbx_business_glossary_term' = 'Redemption Rate');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Percentage');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'in_store|online|mobile|curbside|pickup|delivery');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `target_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`promo_effectiveness` ALTER COLUMN `vendor_funding_recovered_amount` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funding Recovered Amount');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` SET TAGS ('dbx_subdomain' = 'customer_insights');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `loyalty_analytics_fact_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Analytics Fact Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `analytical_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Dataset Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `membership_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `membership_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `program_config_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `prior_period_loyalty_analytics_fact_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `active_member_count` SET TAGS ('dbx_business_glossary_term' = 'Active Member Count');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `avg_points_balance` SET TAGS ('dbx_business_glossary_term' = 'Average Points Balance');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'POS|eCommerce|MobileApp');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `is_lapsed_member` SET TAGS ('dbx_business_glossary_term' = 'Is Lapsed Member Flag');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `is_new_member` SET TAGS ('dbx_business_glossary_term' = 'Is New Member Flag');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `lapsed_members` SET TAGS ('dbx_business_glossary_term' = 'Lapsed Member Count');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `loyalty_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Sales Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `loyalty_sales_penetration` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Sales Penetration (Percent)');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `new_enrollments` SET TAGS ('dbx_business_glossary_term' = 'New Loyalty Enrollments');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `offer_acceptance_rate` SET TAGS ('dbx_business_glossary_term' = 'Offer Acceptance Rate (Percent)');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `points_accrued` SET TAGS ('dbx_business_glossary_term' = 'Points Accrued');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Points Redeemed');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Status');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|paused');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `redemption_rate` SET TAGS ('dbx_business_glossary_term' = 'Redemption Rate (Percent)');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Member Segment');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `tier_bronze_count` SET TAGS ('dbx_business_glossary_term' = 'Bronze Tier Member Count');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `tier_gold_count` SET TAGS ('dbx_business_glossary_term' = 'Gold Tier Member Count');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `tier_silver_count` SET TAGS ('dbx_business_glossary_term' = 'Silver Tier Member Count');
ALTER TABLE `grocery_ecm`.`analytics`.`loyalty_analytics_fact` ALTER COLUMN `total_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Sales Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `inventory_analytics_fact_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Analytics Fact ID');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `analytical_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Dataset Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'SKU Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `prior_day_inventory_analytics_fact_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'SAP_Retail|Oracle_Retail|Manhattan_WMS');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `days_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Days of Supply (DOS)');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `fifo_compliance_rate` SET TAGS ('dbx_business_glossary_term' = 'FIFO Compliance Rate (%)');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `fill_rate` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate (%)');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `gmroi` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI)');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `in_stock_rate` SET TAGS ('dbx_business_glossary_term' = 'In‑Stock Rate (%)');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `inventory_turns` SET TAGS ('dbx_business_glossary_term' = 'Inventory Turns');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `is_perishable` SET TAGS ('dbx_business_glossary_term' = 'Perishable Flag');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `is_private_label` SET TAGS ('dbx_business_glossary_term' = 'Private‑Label Flag');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `last_replenishment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Replenishment Date');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `last_replenishment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Last Replenishment Quantity');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `last_stockout_date` SET TAGS ('dbx_business_glossary_term' = 'Last Stock‑Out Date');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `last_stockout_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Last Stock‑Out Duration (Days)');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `on_hand_dollars` SET TAGS ('dbx_business_glossary_term' = 'On‑Hand Inventory Value (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `on_hand_units` SET TAGS ('dbx_business_glossary_term' = 'On‑Hand Units');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `on_order_dollars` SET TAGS ('dbx_business_glossary_term' = 'On‑Order Inventory Value (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `on_order_units` SET TAGS ('dbx_business_glossary_term' = 'On‑Order Units');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `out_of_stock_rate` SET TAGS ('dbx_business_glossary_term' = 'Out‑Of‑Stock Rate (%)');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `shrink_dollars` SET TAGS ('dbx_business_glossary_term' = 'Shrink Value (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `shrink_units` SET TAGS ('dbx_business_glossary_term' = 'Shrink Units');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Date');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `snapshot_type` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Type');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `snapshot_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly');
ALTER TABLE `grocery_ecm`.`analytics`.`inventory_analytics_fact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `vendor_analytics_fact_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Analytics Fact ID');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `analytical_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Dataset Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `prior_period_vendor_analytics_fact_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `average_order_value` SET TAGS ('dbx_business_glossary_term' = 'Average Order Value (AOV)');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `chargeback_amount` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `chargeback_count` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Count');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN|GBP|EUR');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `fill_rate` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate (FR)');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `inbound_shipment_volume` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Volume');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `lead_time_actual_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Lead Time (Days)');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `lead_time_sla_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time SLA (Days)');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `on_time_delivery_rate` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate (OTDR)');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `order_accuracy_rate` SET TAGS ('dbx_business_glossary_term' = 'Order Accuracy Rate (OAR)');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `processing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `total_orders` SET TAGS ('dbx_business_glossary_term' = 'Total Orders');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `total_units_received` SET TAGS ('dbx_business_glossary_term' = 'Total Units Received');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `total_units_shipped` SET TAGS ('dbx_business_glossary_term' = 'Total Units Shipped');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`vendor_analytics_fact` ALTER COLUMN `vendor_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Vendor Compliance Score');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` SET TAGS ('dbx_subdomain' = 'customer_insights');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `shopper_behavior_fact_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Behavior Fact ID');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `analytical_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Dataset Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `shopper_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `shopper_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `prior_period_shopper_behavior_fact_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `avg_spend_per_visit` SET TAGS ('dbx_business_glossary_term' = 'Average Spend Per Visit');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `basket_size_avg_items` SET TAGS ('dbx_business_glossary_term' = 'Average Basket Item Count');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `basket_size_avg_units` SET TAGS ('dbx_business_glossary_term' = 'Average Basket Unit Quantity');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `basket_value_avg` SET TAGS ('dbx_business_glossary_term' = 'Average Basket Value');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Shopping Channel');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'in_store|online|pickup|delivery');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `distinct_category_count` SET TAGS ('dbx_business_glossary_term' = 'Distinct Category Count');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `private_label_penetration_pct` SET TAGS ('dbx_business_glossary_term' = 'Private-Label Penetration Percentage');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `promotional_spend_pct` SET TAGS ('dbx_business_glossary_term' = 'Promotional Spend Percentage');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `rfm_score` SET TAGS ('dbx_business_glossary_term' = 'RFM Score');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `rfm_tier` SET TAGS ('dbx_business_glossary_term' = 'RFM Tier');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `rfm_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `total_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Spend');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`shopper_behavior_fact` ALTER COLUMN `visit_count` SET TAGS ('dbx_business_glossary_term' = 'Store Visit Count');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` SET TAGS ('dbx_subdomain' = 'sales_analytics');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `channel_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Performance ID');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `analytical_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Dataset Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `prior_period_channel_performance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `average_order_value` SET TAGS ('dbx_business_glossary_term' = 'Average Order Value (AOV)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `cancellation_rate` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Rate (CANCEL_RATE)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code (CODE)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = 'online|instore|pickup|delivery');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name (NAME)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CREATED_TS)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `digital_penetration_pct` SET TAGS ('dbx_business_glossary_term' = 'Digital Penetration Percentage (DIG_PENETRATION)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (DISCOUNT)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `fulfillment_rate` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Rate (FULFILL_RATE)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `gross_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Sales Amount (GROSS_SALES)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `items_per_order` SET TAGS ('dbx_business_glossary_term' = 'Items Per Order (ITEMS_PER_ORDER)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `net_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Sales Amount (NET_SALES)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `on_time_fulfillment_rate` SET TAGS ('dbx_business_glossary_term' = 'On‑Time Fulfillment Rate (ON_TIME_RATE)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `order_count` SET TAGS ('dbx_business_glossary_term' = 'Order Count (ORDERS)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date (END_DATE)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date (START_DATE)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type (TYPE)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|yearly');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (STATUS)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `store_name` SET TAGS ('dbx_business_glossary_term' = 'Store Name (NAME)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `store_number` SET TAGS ('dbx_business_glossary_term' = 'Store Number (NUM)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `units_sold` SET TAGS ('dbx_business_glossary_term' = 'Units Sold (UNITS)');
ALTER TABLE `grocery_ecm`.`analytics`.`channel_performance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UPDATED_TS)');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `labor_analytics_fact_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Analytics Fact Identifier (LABOR_ANALYTICS_FACT_ID)');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `analytical_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Dataset Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (DEPARTMENT_ID)');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Identifier (STORE_ID)');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `prior_period_labor_analytics_fact_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Hours Worked (ACTUAL_HOURS)');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp (EVENT_TIMESTAMP)');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type (EVENT_TYPE)');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'labor_analytics');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `labor_cost_percent_of_sales` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost as Percent of Sales (LABOR_COST_PERCENT_OF_SALES)');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `labor_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost (USD) (LABOR_COST_USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `open_shift_count` SET TAGS ('dbx_business_glossary_term' = 'Open Shift Count (OPEN_SHIFT_COUNT)');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Labor Hours (OVERTIME_HOURS)');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `period_date` SET TAGS ('dbx_business_glossary_term' = 'Labor Period Date (PERIOD_DATE)');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `period_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Period End Timestamp (PERIOD_END_TIMESTAMP)');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `period_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Period Start Timestamp (PERIOD_START_TIMESTAMP)');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (RECORD_AUDIT_CREATED)');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (RECORD_AUDIT_UPDATED)');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `sales_per_labor_hour_usd` SET TAGS ('dbx_business_glossary_term' = 'Sales per Labor Hour (USD) (SALES_PER_LABOR_HOUR_USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `schedule_adherence_rate` SET TAGS ('dbx_business_glossary_term' = 'Schedule Adherence Rate (SCHEDULE_ADHERENCE_RATE)');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Labor Hours (SCHEDULED_HOURS)');
ALTER TABLE `grocery_ecm`.`analytics`.`labor_analytics_fact` ALTER COLUMN `transactions_per_labor_hour` SET TAGS ('dbx_business_glossary_term' = 'Transactions per Labor Hour (TRANSACTIONS_PER_LABOR_HOUR)');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `shrink_analytics_fact_id` SET TAGS ('dbx_business_glossary_term' = 'Shrink Analytics Fact Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `analytical_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Dataset Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `prior_period_shrink_analytics_fact_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN|GBP|EUR|JPY');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `cycle_count_variance_dollars` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Variance Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `cycle_count_variance_units` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Variance Units');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'SAP|Oracle|Manhattan|BlueYonder|NCR');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `is_estimated` SET TAGS ('dbx_business_glossary_term' = 'Is Estimated Flag');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `markdown_dollars` SET TAGS ('dbx_business_glossary_term' = 'Markdown Shrink Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `markdown_units` SET TAGS ('dbx_business_glossary_term' = 'Markdown Shrink Units');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `period_date` SET TAGS ('dbx_business_glossary_term' = 'Period Date');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `perishable_shrink_dollars` SET TAGS ('dbx_business_glossary_term' = 'Perishable Shrink Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `perishable_shrink_units` SET TAGS ('dbx_business_glossary_term' = 'Perishable Shrink Units');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deleted');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `shrink_dollars` SET TAGS ('dbx_business_glossary_term' = 'Shrink Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `shrink_percent_of_sales` SET TAGS ('dbx_business_glossary_term' = 'Shrink Percentage of Sales');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `shrink_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Shrink Reason Code');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `shrink_type` SET TAGS ('dbx_business_glossary_term' = 'Shrink Type');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `shrink_type` SET TAGS ('dbx_value_regex' = 'theft|administrative|vendor|spoilage|markdown|cycle_count_variance');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `shrink_units` SET TAGS ('dbx_business_glossary_term' = 'Shrink Units');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `total_sales_dollars` SET TAGS ('dbx_business_glossary_term' = 'Total Sales Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `total_sales_units` SET TAGS ('dbx_business_glossary_term' = 'Total Sales Units');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `unknown_shrink_dollars` SET TAGS ('dbx_business_glossary_term' = 'Unknown Shrink Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `unknown_shrink_units` SET TAGS ('dbx_business_glossary_term' = 'Unknown Shrink Units');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `vendor_shrink_dollars` SET TAGS ('dbx_business_glossary_term' = 'Vendor Shrink Amount (USD)');
ALTER TABLE `grocery_ecm`.`analytics`.`shrink_analytics_fact` ALTER COLUMN `vendor_shrink_units` SET TAGS ('dbx_business_glossary_term' = 'Vendor Shrink Units');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` SET TAGS ('dbx_subdomain' = 'data_governance');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `bi_access_request_id` SET TAGS ('dbx_business_glossary_term' = 'Business Intelligence Access Request ID');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `dashboard_id` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `primary_bi_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `delegated_from_bi_access_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `access_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Access Expiry Date');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `access_grant_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Access Grant Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'view|edit|admin');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revoked');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Full Name');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `approver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `approver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `compliance_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Passed');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Access Request Number');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `request_source` SET TAGS ('dbx_business_glossary_term' = 'Request Source');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `request_source` SET TAGS ('dbx_value_regex' = 'portal|email|api');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `requester_name` SET TAGS ('dbx_business_glossary_term' = 'Requester Full Name');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `requester_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `requester_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `resource_code` SET TAGS ('dbx_business_glossary_term' = 'Requested Resource Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `resource_name` SET TAGS ('dbx_business_glossary_term' = 'Requested Resource Name');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Requested Resource Type');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `resource_type` SET TAGS ('dbx_value_regex' = 'dashboard|report|dataset');
ALTER TABLE `grocery_ecm`.`analytics`.`bi_access_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` SET TAGS ('dbx_subdomain' = 'data_governance');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `analytical_lineage_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Lineage Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `analytical_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Target Analytical Dataset Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Target KPI Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `upstream_analytical_lineage_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `analytical_lineage_status` SET TAGS ('dbx_business_glossary_term' = 'Lineage Record Status');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `analytical_lineage_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `last_validated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Validated Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `lineage_confidentiality` SET TAGS ('dbx_business_glossary_term' = 'Lineage Confidentiality Level');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `lineage_confidentiality` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `lineage_depth_level` SET TAGS ('dbx_business_glossary_term' = 'Lineage Depth Level');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `lineage_notes` SET TAGS ('dbx_business_glossary_term' = 'Lineage Notes');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `lineage_owner` SET TAGS ('dbx_business_glossary_term' = 'Lineage Owner');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `source_domain` SET TAGS ('dbx_business_glossary_term' = 'Source Data Domain (e.g., Customer, Product, etc.)');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `source_object_name` SET TAGS ('dbx_business_glossary_term' = 'Source Object/Table Name');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `source_product` SET TAGS ('dbx_business_glossary_term' = 'Source Data Product Name');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Record');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `target_system` SET TAGS ('dbx_business_glossary_term' = 'Target Analytical System');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `transformation_description` SET TAGS ('dbx_business_glossary_term' = 'Transformation Description');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `transformation_type` SET TAGS ('dbx_business_glossary_term' = 'Transformation Type');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `transformation_type` SET TAGS ('dbx_value_regex' = 'aggregation|join|filter|enrichment|lookup');
ALTER TABLE `grocery_ecm`.`analytics`.`analytical_lineage` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` SET TAGS ('dbx_subdomain' = 'performance_management');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `forecast_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Baseline ID');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `metric_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Metric Definition Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `superseded_forecast_baseline_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `baseline_code` SET TAGS ('dbx_business_glossary_term' = 'Baseline Code');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `baseline_name` SET TAGS ('dbx_business_glossary_term' = 'Baseline Name');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `baseline_type` SET TAGS ('dbx_business_glossary_term' = 'Baseline Type (e.g., Sales, Units, Traffic, Margin)');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `baseline_type` SET TAGS ('dbx_value_regex' = 'sales|units|traffic|margin');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Forecast Value');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `confidence_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `confidence_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `forecast_baseline_status` SET TAGS ('dbx_business_glossary_term' = 'Baseline Lifecycle Status');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `forecast_baseline_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|draft');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `forecast_frequency` SET TAGS ('dbx_business_glossary_term' = 'Forecast Frequency');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `forecast_frequency` SET TAGS ('dbx_value_regex' = 'weekly|monthly|daily');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `grain` SET TAGS ('dbx_business_glossary_term' = 'Forecast Grain (Level of Aggregation)');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `grain` SET TAGS ('dbx_value_regex' = 'sku_store_week|category_store_week|store_week');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `horizon_weeks` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon (Weeks)');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `is_manual_override` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Flag');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Baseline Methodology');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `seasonality_index` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Index');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`forecast_baseline` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` SET TAGS ('dbx_subdomain' = 'performance_management');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `prior_period_scorecard_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `kpi_count` SET TAGS ('dbx_business_glossary_term' = 'Number of KPIs');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `overall_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `overall_performance_rating` SET TAGS ('dbx_value_regex' = 'green|yellow|red');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Score');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `publication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Publication Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `scorecard_code` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Code');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `scorecard_description` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Description');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `scorecard_name` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Name');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Lifecycle Status');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_value_regex' = 'draft|published|archived');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `scorecard_type` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Type');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `scorecard_type` SET TAGS ('dbx_value_regex' = 'store_ops|category|vendor|loyalty|digital');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `target_audience_level` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Level');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `target_audience_level` SET TAGS ('dbx_value_regex' = 'store|district|region|banner');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`scorecard` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Version');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` SET TAGS ('dbx_subdomain' = 'performance_management');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `kpi_target_id` SET TAGS ('dbx_business_glossary_term' = 'KPI Target Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Owner Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'KPI Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Identifier');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `revised_kpi_target_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `compliance_tags` SET TAGS ('dbx_business_glossary_term' = 'Compliance Tags');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `is_automated_target` SET TAGS ('dbx_business_glossary_term' = 'Automated Target Indicator');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `kpi_target_description` SET TAGS ('dbx_business_glossary_term' = 'KPI Target Description');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `minimum_acceptable_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Acceptable Threshold');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'KPI Target Notes');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `organization_level` SET TAGS ('dbx_business_glossary_term' = 'Organization Level');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `organization_level` SET TAGS ('dbx_value_regex' = 'store|district|region|banner|enterprise');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Target Period End Date');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Period Start Date');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'BlueYonder|SAP|Oracle|Manual');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `stretch_target_value` SET TAGS ('dbx_business_glossary_term' = 'Stretch Target Value');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Target Approval Date');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_code` SET TAGS ('dbx_business_glossary_term' = 'KPI Target Code');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_methodology` SET TAGS ('dbx_business_glossary_term' = 'Target Setting Methodology');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_methodology` SET TAGS ('dbx_value_regex' = 'top-down|bottom-up|benchmark|historical|market|custom');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Target Owner Department');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_owner_department` SET TAGS ('dbx_value_regex' = 'finance|operations|marketing|merchandising|store|hr');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_review_date` SET TAGS ('dbx_business_glossary_term' = 'Target Review Date');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_status` SET TAGS ('dbx_business_glossary_term' = 'KPI Target Status');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_status` SET TAGS ('dbx_value_regex' = 'draft|approved|locked|revised');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_type` SET TAGS ('dbx_business_glossary_term' = 'KPI Target Type');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_type` SET TAGS ('dbx_value_regex' = 'financial|operational|customer|supply_chain|store');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'percentage|dollar|units|points');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `grocery_ecm`.`analytics`.`kpi_target` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
