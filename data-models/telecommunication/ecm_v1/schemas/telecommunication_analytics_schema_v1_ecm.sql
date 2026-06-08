-- Schema for Domain: analytics | Business: Telecommunication | Version: v1_ecm
-- Generated on: 2026-05-08 05:07:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`analytics` COMMENT 'SSOT for business intelligence definitions, KPI catalogs, data quality rules, reporting dimensions, and analytical model metadata supporting network analytics, customer analytics, and revenue analytics';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` (
    `kpi_definition_id` BIGINT COMMENT 'Unique identifier for the KPI definition record. Primary key for the KPI definition catalog.',
    `parent_kpi_definition_id` BIGINT COMMENT 'Self-referencing FK on kpi_definition (parent_kpi_definition_id)',
    `aggregation_method` STRING COMMENT 'The statistical method used to aggregate raw data into the KPI value: sum, average, count, minimum, maximum, median, percentile, or weighted average. [ENUM-REF-CANDIDATE: sum|average|count|min|max|median|percentile|weighted_average — 8 candidates stripped; promote to reference product]',
    `aggregation_period` STRING COMMENT 'The time period over which the KPI is calculated and reported: real-time, hourly, daily, weekly, monthly, quarterly, or yearly. [ENUM-REF-CANDIDATE: real_time|hourly|daily|weekly|monthly|quarterly|yearly — 7 candidates stripped; promote to reference product]',
    `approval_date` DATE COMMENT 'The date on which this KPI definition was formally approved by the governance body or KPI owner.',
    `approved_by` STRING COMMENT 'The name or identifier of the individual or governance committee that approved this KPI definition.',
    `benchmark_source` STRING COMMENT 'External industry benchmark or peer comparison source used to contextualize this KPI (e.g., GSMA Intelligence, TM Forum benchmarks, analyst reports).',
    `business_description` STRING COMMENT 'Comprehensive business explanation of what the KPI measures, why it matters, and how it supports strategic objectives. Written for business stakeholders.',
    `calculation_formula` STRING COMMENT 'The mathematical formula or logical expression used to compute the KPI value. May reference source metrics, aggregation functions, and business rules (e.g., (Successful Calls / Total Call Attempts) * 100).',
    `calculation_logic` STRING COMMENT 'Detailed step-by-step logic for computing the KPI, including data sources, filters, transformations, and aggregation rules. Complements the formula with implementation guidance.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this KPI definition record was first created in the system.',
    `dashboard_visibility` STRING COMMENT 'The audience level for which this KPI is visible in dashboards and reports: executive leadership, management, operational teams, public stakeholders, or restricted access.. Valid values are `executive|management|operational|public|restricted`',
    `data_quality_rule` STRING COMMENT 'Data quality validation rules that must be satisfied for the KPI calculation to be considered reliable (e.g., completeness thresholds, accuracy checks, timeliness requirements).',
    `data_source_system` STRING COMMENT 'The primary operational system or data platform from which raw data for this KPI is sourced (e.g., Nokia NetAct, Amdocs Revenue Management, Salesforce CRM, Oracle OSM).',
    `data_source_table` STRING COMMENT 'The specific table, view, or dataset within the source system from which KPI input data is extracted.',
    `data_type` STRING COMMENT 'The data type of the KPI value: integer, decimal, percentage, currency, ratio, or boolean.. Valid values are `integer|decimal|percentage|currency|ratio|boolean`',
    `effective_date` DATE COMMENT 'The date from which this KPI definition version became effective and started being used for reporting and analytics.',
    `expiration_date` DATE COMMENT 'The date on which this KPI definition version was retired or replaced. Null if the definition is still active.',
    `kpi_category` STRING COMMENT 'High-level classification of the KPI by business domain: network performance, customer experience, revenue management, operational efficiency, quality of service, or financial performance.. Valid values are `network|customer|revenue|operational|quality|financial`',
    `kpi_code` STRING COMMENT 'Short alphanumeric code or abbreviation for the KPI used in reports and dashboards (e.g., CSSR, ARPU, NPS, DCR).',
    `kpi_definition_status` STRING COMMENT 'Current lifecycle status of the KPI definition: active (in use), inactive (not currently tracked), deprecated (replaced by another KPI), under review (being evaluated), or draft (not yet approved).. Valid values are `active|inactive|deprecated|under_review|draft`',
    `kpi_name` STRING COMMENT 'The official business name of the KPI as recognized across the enterprise (e.g., Call Setup Success Rate, Average Revenue Per User, Net Promoter Score).',
    `kpi_subcategory` STRING COMMENT 'Detailed classification within the KPI category (e.g., Radio Access Network, Core Network, Billing, Churn, Retention, Fault Management).',
    `last_review_date` DATE COMMENT 'The date on which this KPI definition was last reviewed for accuracy, relevance, and alignment with business objectives.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of this KPI definition.',
    `notes` STRING COMMENT 'Additional notes, comments, or context about the KPI definition, including known limitations, special considerations, or historical changes.',
    `owner_domain` STRING COMMENT 'The business domain or organizational unit responsible for defining, maintaining, and governing this KPI (e.g., Network Operations, Customer Experience, Finance, Revenue Assurance).',
    `owner_role` STRING COMMENT 'The role or job title of the individual or team accountable for this KPI (e.g., Chief Technology Officer, VP Customer Experience, Director of Network Operations).',
    `polarity` STRING COMMENT 'Indicates whether higher values are better (e.g., ARPU, NPS), lower values are better (e.g., churn rate, MTTR), a specific target is optimal, or the KPI is neutral/informational.. Valid values are `higher_is_better|lower_is_better|target_is_optimal|neutral`',
    `regulatory_requirement` STRING COMMENT 'Any regulatory or compliance mandate that requires tracking and reporting of this KPI (e.g., Federal Communications Commission (FCC) service quality reporting, Quality of Service (QoS) obligations).',
    `related_kpi_ids` STRING COMMENT 'Comma-separated list of KPI definition IDs that are related to or dependent on this KPI (e.g., component KPIs, parent/child KPIs, correlated metrics).',
    `reporting_frequency` STRING COMMENT 'How often the KPI is reported to stakeholders: real-time, hourly, daily, weekly, monthly, quarterly, yearly, or on an ad-hoc basis. [ENUM-REF-CANDIDATE: real_time|hourly|daily|weekly|monthly|quarterly|yearly|ad_hoc — 8 candidates stripped; promote to reference product]',
    `sla_applicable` BOOLEAN COMMENT 'Indicates whether this KPI is tied to a contractual Service Level Agreement (SLA) with customers or partners.',
    `strategic_objective` STRING COMMENT 'The enterprise strategic objective or business goal that this KPI supports (e.g., Improve Network Quality of Service, Reduce Customer Churn, Increase Average Revenue Per User).',
    `tags` STRING COMMENT 'Free-form tags or labels used for categorization, search, and filtering of KPI definitions (e.g., 5G, customer_satisfaction, network_quality, revenue_growth).',
    `target_value` DECIMAL(18,2) COMMENT 'The target or goal value for the KPI as defined by business strategy or Service Level Agreement (SLA). Represents the desired performance level.',
    `threshold_critical_high` DECIMAL(18,2) COMMENT 'The upper bound threshold above which KPI performance is considered critically poor and requires immediate escalation (applicable for lower-is-better KPIs).',
    `threshold_critical_low` DECIMAL(18,2) COMMENT 'The lower bound threshold below which KPI performance is considered critically poor and requires immediate escalation.',
    `threshold_warning_high` DECIMAL(18,2) COMMENT 'The upper bound threshold above which KPI performance triggers a warning alert (applicable for lower-is-better KPIs or range-bound KPIs).',
    `threshold_warning_low` DECIMAL(18,2) COMMENT 'The lower bound threshold below which KPI performance triggers a warning alert, indicating potential issues.',
    `trend_direction` STRING COMMENT 'The current observed trend direction of the KPI over recent reporting periods: improving, declining, stable, volatile, or not applicable.. Valid values are `improving|declining|stable|volatile|not_applicable`',
    `unit_of_measure` STRING COMMENT 'The unit in which the KPI value is expressed (e.g., percentage, currency, count, milliseconds, Mbps, ratio, score).',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this KPI definition record was last modified.',
    `version` STRING COMMENT 'Version number of the KPI definition, incremented when calculation logic, thresholds, or other material attributes are changed.',
    CONSTRAINT pk_kpi_definition PRIMARY KEY(`kpi_definition_id`)
) COMMENT 'Master catalog of all Key Performance Indicators (KPIs) defined across the telecommunications enterprise — the SSOT for business intelligence metric definitions. Captures KPI name, business description, calculation formula or logic, unit of measure, polarity (higher-is-better vs lower-is-better), target thresholds, owner domain, reporting frequency, and alignment to strategic objectives. Covers network KPIs (CSSR, DCR, RSRP, throughput), customer KPIs (NPS, churn rate, ARPU, CLV), and revenue KPIs (EBITDA margin, revenue per user, cost per GB). Used by BI tools, dashboards, and analytical models as the authoritative metric registry.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` (
    `reporting_dimension_id` BIGINT COMMENT 'Unique identifier for the reporting dimension. Primary key for the reporting dimension catalog.',
    `parent_reporting_dimension_id` BIGINT COMMENT 'Self-referencing FK on reporting_dimension (parent_reporting_dimension_id)',
    `access_control_group` STRING COMMENT 'The security group or role required to access this dimension data (e.g., Analytics_Users, Network_Operations, Executive_Dashboard).',
    `attribute_count` STRING COMMENT 'Total number of attributes or columns defined in the dimension table, used for schema complexity assessment.',
    `business_domain` STRING COMMENT 'The primary business domain or subject area this dimension belongs to (Customer, Network, Billing, Product, Order, Service, Workforce, Partner, Usage, Revenue Assurance, Inventory, Interconnect, Content, Compliance, Enterprise). [ENUM-REF-CANDIDATE: customer|network|billing|product|order|service|workforce|partner|usage|revenue_assurance|inventory|interconnect|content|compliance|enterprise — 15 candidates stripped; promote to reference product]',
    `business_rules` STRING COMMENT 'Documentation of business rules, constraints, and logic applied to dimension data (e.g., Customer segments are mutually exclusive, Technology generation follows 3GPP (3rd Generation Partnership Project) standards).',
    `cardinality_estimate` BIGINT COMMENT 'Estimated number of distinct members or rows in the dimension table, used for capacity planning and query optimization.',
    `compliance_tags` STRING COMMENT 'Comma-separated list of regulatory or compliance frameworks applicable to this dimension (e.g., GDPR, CPNI, FCC, SOX, PCI-DSS).',
    `conformed_flag` BOOLEAN COMMENT 'Indicates whether this dimension is a conformed dimension shared across multiple fact tables and subject areas (True) or a local dimension specific to one subject area (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this dimension metadata record was first created in the reporting dimension catalog.',
    `data_quality_rules` STRING COMMENT 'Comma-separated list of data quality rules or checks applied to this dimension (e.g., completeness > 95%, uniqueness on business key, referential integrity with fact tables).',
    `data_steward` STRING COMMENT 'Name or identifier of the data steward responsible for maintaining dimension metadata, resolving data quality issues, and coordinating changes.',
    `dimension_code` STRING COMMENT 'Unique business code or abbreviation for the dimension used in reporting and analytics systems (e.g., DIM_TIME, DIM_GEO, DIM_CUST_SEG).',
    `dimension_description` STRING COMMENT 'Comprehensive business description of the dimension, its purpose, scope, and how it should be used in analytical queries and reports.',
    `dimension_name` STRING COMMENT 'The business name of the reporting dimension (e.g., Time, Geography, Customer Segment, Network Element, Product, Channel, Technology Generation).',
    `dimension_owner` STRING COMMENT 'The business unit, team, or individual responsible for the definition, quality, and governance of this dimension (e.g., Network Analytics Team, Customer Insights, Revenue Assurance).',
    `dimension_status` STRING COMMENT 'Current lifecycle status of the dimension in the analytics platform: active (in production use), deprecated (scheduled for retirement), proposed (under development), retired (no longer used), or under_review (being evaluated for changes).. Valid values are `active|deprecated|proposed|retired|under_review`',
    `dimension_type` STRING COMMENT 'Classification of the dimension based on dimensional modeling patterns: conformed (shared across subject areas), degenerate (stored in fact table), role-playing (single dimension used in multiple contexts), junk (low-cardinality flags), slowly-changing (infrequent updates), or rapidly-changing (frequent updates).. Valid values are `conformed|degenerate|role_playing|junk|slowly_changing|rapidly_changing`',
    `documentation_url` STRING COMMENT 'URL or link to detailed documentation, data dictionary, or wiki page for this dimension.',
    `effective_end_date` DATE COMMENT 'The date on which this dimension definition was retired or superseded by a new version. Null indicates the dimension is currently active.',
    `effective_start_date` DATE COMMENT 'The date from which this dimension definition became active and available for use in analytics and reporting.',
    `grain_description` STRING COMMENT 'Detailed description of the dimension grain or level of detail (e.g., Daily calendar date, Individual cell site, Customer account, Product SKU (Stock Keeping Unit)).',
    `hierarchy_levels` STRING COMMENT 'Comma-separated list of hierarchical levels within the dimension from highest to lowest granularity (e.g., Region > Market > Cell Site, Year > Quarter > Month > Day, Technology Generation > Access Type > Service Type).',
    `indexing_strategy` STRING COMMENT 'Description of indexing or partitioning strategy applied to optimize query performance (e.g., Clustered on dimension_code, Partitioned by effective_date, Z-order on business_key).',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful data refresh or load for this dimension from source systems.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this dimension metadata record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this dimension metadata record was last updated or modified.',
    `primary_business_key` STRING COMMENT 'The natural business key or keys used to uniquely identify dimension members in source systems (e.g., customer_account_number, cell_site_id, product_sku, date).',
    `refresh_frequency` STRING COMMENT 'The frequency at which dimension data is refreshed from source systems: real_time (streaming), near_real_time (minutes), hourly, daily, weekly, monthly, or on_demand (manual trigger). [ENUM-REF-CANDIDATE: real_time|near_real_time|hourly|daily|weekly|monthly|on_demand — 7 candidates stripped; promote to reference product]',
    `related_fact_tables` STRING COMMENT 'Comma-separated list of fact tables that reference this dimension (e.g., fact_usage, fact_revenue, fact_network_performance).',
    `related_kpi_count` STRING COMMENT 'Number of KPIs (Key Performance Indicators) that use this dimension for slicing, filtering, or grouping in business intelligence reports.',
    `role_playing_flag` BOOLEAN COMMENT 'Indicates whether this dimension is used in multiple roles within the same fact table (True), such as a Time dimension used for order_date, ship_date, and delivery_date.',
    `scd_type` STRING COMMENT 'The slowly-changing-dimension strategy applied to track historical changes: Type 0 (retain original), Type 1 (overwrite), Type 2 (add new row with versioning), Type 3 (add new column), Type 4 (separate history table), Type 6 (hybrid 1+2+3), or not_applicable for non-SCD dimensions. [ENUM-REF-CANDIDATE: type_0|type_1|type_2|type_3|type_4|type_6|not_applicable — 7 candidates stripped; promote to reference product]',
    `schema_name` STRING COMMENT 'The database schema or namespace containing the dimension table (e.g., analytics, silver, reporting).',
    `security_classification` STRING COMMENT 'Data classification level for the dimension: public (no restrictions), internal (company use only), confidential (sensitive business data), or restricted (contains PII/PHI/PCI requiring strict access controls).. Valid values are `public|internal|confidential|restricted`',
    `source_system` STRING COMMENT 'The primary operational system of record that provides dimension data (e.g., Salesforce CRM, Nokia NetAct, Netcracker Product Catalog, Oracle Order Management).',
    `table_name` STRING COMMENT 'The physical table or view name in the data warehouse or lakehouse where dimension data is stored (e.g., dim_customer, dim_network_element, dim_product).',
    `technology_platform` STRING COMMENT 'The analytics or data platform where this dimension is physically implemented (e.g., Databricks Lakehouse Silver Layer, Snowflake, Azure Synapse, Google BigQuery).',
    `usage_count` STRING COMMENT 'Number of fact tables, reports, dashboards, or analytical models that reference this dimension, indicating its importance and impact scope.',
    `version_number` STRING COMMENT 'Version identifier for the dimension definition, incremented when structural changes are made to the dimension schema or business logic.',
    `created_by` STRING COMMENT 'User identifier or system account that created this dimension metadata record.',
    CONSTRAINT pk_reporting_dimension PRIMARY KEY(`reporting_dimension_id`)
) COMMENT 'Master catalog of all analytical reporting dimensions used across the telecommunications BI and analytics platform — the SSOT for dimensional metadata. Defines dimension name, grain description, hierarchy levels (e.g., Region > Market > Cell Site), associated domain, dimension type (conformed, degenerate, role-playing, junk), slowly-changing-dimension (SCD) type, and primary business keys. Covers standard telecom dimensions: time, geography, network topology, customer segment, product, channel, and technology generation (2G/3G/4G/5G). Enables consistent dimensional modeling across all analytical subject areas.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` (
    `dimension_hierarchy_id` BIGINT COMMENT 'Unique identifier for the dimension hierarchy record. Primary key for the dimension hierarchy entity.',
    `reporting_dimension_id` BIGINT COMMENT 'Reference to the parent dimension that this hierarchy belongs to (e.g., Geography, Product, Time, Customer Segment). Links this hierarchy structure to its owning dimension definition.',
    `parent_dimension_hierarchy_id` BIGINT COMMENT 'Self-referencing FK on dimension_hierarchy (parent_dimension_hierarchy_id)',
    `aggregation_function` STRING COMMENT 'Default aggregation function to apply when rolling up measures along this hierarchy. Defines how Key Performance Indicators (KPIs) are calculated at each level. [ENUM-REF-CANDIDATE: sum|average|count|min|max|distinct_count|none — 7 candidates stripped; promote to reference product]',
    `business_owner` STRING COMMENT 'Name or identifier of the business unit or role responsible for maintaining and governing this hierarchy definition. Supports data governance and stewardship.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hierarchy level record was first created in the system. Supports audit trail and data lineage tracking.',
    `data_steward` STRING COMMENT 'Name or identifier of the individual or team responsible for data quality and metadata management for this hierarchy. Supports data governance processes.',
    `effective_end_date` DATE COMMENT 'Date when this hierarchy level definition becomes inactive. Null for currently active hierarchy levels. Supports slowly-changing hierarchies and point-in-time analysis.',
    `effective_start_date` DATE COMMENT 'Date when this hierarchy level definition becomes active. Supports slowly-changing hierarchies and temporal validity for historical reporting.',
    `hierarchy_code` STRING COMMENT 'Unique business code or identifier for the hierarchy. Used for programmatic reference and integration with Business Intelligence (BI) tools and Online Analytical Processing (OLAP) cubes.',
    `hierarchy_description` STRING COMMENT 'Detailed description of the hierarchy purpose, structure, and business use cases. Explains the drill-down and roll-up semantics for business users.',
    `hierarchy_name` STRING COMMENT 'Business name of the hierarchy structure. Examples: Geographic Rollup, Product Category Tree, Organizational Hierarchy, Network Topology Hierarchy.',
    `hierarchy_type` STRING COMMENT 'Classification of the hierarchy structure. Balanced: all branches have same depth; Ragged: branches may have different depths; Unbalanced: members may skip levels; Network: members may have multiple parents; Parent-Child: recursive self-referencing structure.. Valid values are `balanced|ragged|unbalanced|network|parent_child`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this hierarchy level is currently active and available for use in reporting and analytics. Inactive hierarchies are retained for historical reference.',
    `is_default_hierarchy` BOOLEAN COMMENT 'Indicates whether this is the default hierarchy for the dimension. Used by Business Intelligence (BI) tools to select the primary drill-down path when multiple hierarchies exist for a dimension.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this hierarchy level record was last updated. Supports change tracking and data quality monitoring.',
    `level_attribute_list` STRING COMMENT 'Comma-separated list of attribute names available at this hierarchy level. Defines which dimensional attributes are exposed for filtering and grouping at this level.',
    `level_cardinality` BIGINT COMMENT 'Approximate number of distinct members at this hierarchy level. Used for query optimization and cube design in Business Intelligence (BI) platforms.',
    `level_code` STRING COMMENT 'Unique code or abbreviation for the hierarchy level. Used for programmatic reference in Extract Transform Load (ETL) processes and reporting queries.',
    `level_key_column` STRING COMMENT 'Name of the column that serves as the unique business key for members at this level. Used for joining and identifying dimension members in star schema queries.',
    `level_name` STRING COMMENT 'Name of the hierarchical level within the dimension. Examples: Country, Region, Market, District, Cell Site for geography; Product Line, Product Family, Product Category, Product Subcategory, Stock Keeping Unit (SKU) for product.',
    `level_name_column` STRING COMMENT 'Name of the column that contains the human-readable display name for members at this level. Used for report labels and user interface presentation.',
    `level_ordinal_position` STRING COMMENT 'Numeric position of this level within the hierarchy, starting from 1 at the top (most aggregated) level. Determines drill-down sequence and roll-up aggregation order in OLAP operations.',
    `olap_cube_name` STRING COMMENT 'Name of the Online Analytical Processing (OLAP) cube or analytical model that uses this hierarchy. Links the hierarchy definition to deployed Business Intelligence (BI) assets.',
    `parent_level_name` STRING COMMENT 'Name of the immediate parent level in the hierarchy. Null for the top-most level. Defines the parent-child relationship for roll-up aggregations.',
    `source_system` STRING COMMENT 'Name of the source system or data product that provides the hierarchy definition. Examples: Netcracker Product Catalog, Salesforce CRM, SAP S/4HANA Master Data.',
    `supports_drill_down` BOOLEAN COMMENT 'Indicates whether this hierarchy supports drill-down navigation from aggregated to detailed levels in Online Analytical Processing (OLAP) operations.',
    `supports_roll_up` BOOLEAN COMMENT 'Indicates whether this hierarchy supports roll-up aggregation from detailed to summary levels in Online Analytical Processing (OLAP) operations.',
    `usage_notes` STRING COMMENT 'Free-text notes providing guidance on proper usage of this hierarchy, including business rules, calculation logic, and known limitations. Supports self-service analytics.',
    `version_number` STRING COMMENT 'Version number of the hierarchy definition. Incremented when hierarchy structure changes. Supports change tracking and historical comparison of hierarchy evolution.',
    CONSTRAINT pk_dimension_hierarchy PRIMARY KEY(`dimension_hierarchy_id`)
) COMMENT 'Defines the hierarchical level structure within a reporting dimension — capturing each level name, ordinal position, parent-child relationships, and the business keys at each level. For example, the Geography dimension hierarchy: Country > Region > Market > District > Cell Site. Supports drill-down and roll-up operations in OLAP cubes and Databricks SQL analytics. Each hierarchy node carries its own label, code, and effective date range to support slowly-changing hierarchies over time.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` (
    `analytical_subject_area_id` BIGINT COMMENT 'Unique identifier for the analytical subject area. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Data product ownership is foundational to data mesh operating models in telecommunications. Owner accountability for SLA compliance, consumer support, and product roadmap decisions. Denormalized name/',
    `parent_analytical_subject_area_id` BIGINT COMMENT 'Self-referencing FK on analytical_subject_area (parent_analytical_subject_area_id)',
    `approval_date` DATE COMMENT 'The date when this analytical subject area was formally approved by the data governance council.',
    `approval_status` STRING COMMENT 'The governance approval status of this analytical subject area indicating whether it has been reviewed and approved by data governance council.. Valid values are `draft|pending_review|approved|rejected`',
    `approved_by` STRING COMMENT 'The name or identifier of the data governance authority or individual who approved this analytical subject area for production use.',
    `business_purpose` STRING COMMENT 'Detailed description of the business objectives, use cases, and analytical questions this subject area is designed to answer.',
    `consumer_count` STRING COMMENT 'The number of distinct business users, teams, or downstream systems that consume data from this analytical subject area.',
    `contains_pii_flag` BOOLEAN COMMENT 'Boolean indicator of whether this analytical subject area contains any personally identifiable information subject to privacy regulations (GDPR, CCPA, CPNI).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this analytical subject area record was first created in the catalog.',
    `data_classification_level` STRING COMMENT 'The highest data classification level of any data element within this subject area (public, internal, confidential, restricted), determining access controls and handling requirements.. Valid values are `public|internal|confidential|restricted`',
    `data_quality_rule_count` STRING COMMENT 'The number of data quality rules, validation checks, or business rules applied to data within this subject area.',
    `data_retention_period_days` STRING COMMENT 'The number of days that data in this analytical subject area is retained before archival or deletion, driven by regulatory, compliance, or business requirements.',
    `dimension_count` STRING COMMENT 'The number of analytical dimensions (e.g., time, geography, product, customer segment) associated with this subject area.',
    `documentation_url` STRING COMMENT 'The URL link to the detailed technical and business documentation for this analytical subject area, including data dictionary, lineage, and usage guidelines.. Valid values are `^https?://.*$`',
    `effective_end_date` DATE COMMENT 'The date when this analytical subject area was retired, deprecated, or replaced. Null if still active.',
    `effective_start_date` DATE COMMENT 'The date when this analytical subject area became active and available for business use.',
    `fact_table_count` STRING COMMENT 'The number of fact tables or measurement tables included within this analytical subject area.',
    `kpi_family_count` STRING COMMENT 'The number of distinct KPI families or metric groups associated with this analytical subject area.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this analytical subject area record was last updated or modified.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent data refresh or load operation for this analytical subject area.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the analytical subject area indicating whether it is actively used, under development, deprecated, or retired.. Valid values are `active|inactive|deprecated|under_development|retired|archived`',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about this analytical subject area.',
    `owning_domain` STRING COMMENT 'The primary business domain responsible for this analytical subject area (e.g., Customer, Network, Billing, Product, Order, Service, Workforce, Partner, Usage, Revenue Assurance, Inventory, Interconnect, Content, Compliance, Enterprise). [ENUM-REF-CANDIDATE: customer|network|billing|product|order|service|workforce|partner|usage|revenue_assurance|inventory|interconnect|content|compliance|enterprise — 15 candidates stripped; promote to reference product]',
    `platform_layer` STRING COMMENT 'The lakehouse medallion architecture layer where this subject area resides (Bronze for raw, Silver for cleansed/conformed, Gold for aggregated/business-ready, Platinum for advanced analytics).. Valid values are `bronze|silver|gold|platinum`',
    `primary_consumer_group` STRING COMMENT 'The primary business function or user group that consumes this analytical subject area (e.g., Network Operations, Finance, Marketing, Executive Leadership).',
    `primary_grain` STRING COMMENT 'The fundamental level of detail or granularity at which data is stored in this subject area (e.g., per customer per day, per cell site per hour, per invoice line item).',
    `primary_source_system` STRING COMMENT 'The name of the primary operational system of record that serves as the main data source for this analytical subject area (e.g., Amdocs Revenue Management, Salesforce CRM, Nokia NetAct).',
    `refresh_cadence` STRING COMMENT 'The frequency at which data in this analytical subject area is refreshed or updated (real-time, near real-time, hourly, daily, weekly, monthly, on-demand). [ENUM-REF-CANDIDATE: real_time|near_real_time|hourly|daily|weekly|monthly|on_demand — 7 candidates stripped; promote to reference product]',
    `regulatory_scope` STRING COMMENT 'Comma-separated list of regulatory frameworks or compliance requirements applicable to this subject area (e.g., GDPR, FCC, CPNI, SOX, IFRS 15).',
    `sla_availability_target_pct` DECIMAL(18,2) COMMENT 'The target availability percentage for this analytical subject area as defined in the SLA with business consumers (e.g., 99.9% uptime).',
    `sla_refresh_target_minutes` STRING COMMENT 'The maximum allowable time in minutes between data refresh cycles to meet business SLA requirements for data freshness.',
    `source_system_count` STRING COMMENT 'The number of distinct operational source systems (OSS/BSS) that contribute data to this analytical subject area.',
    `subject_area_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the subject area for system integration and reporting (e.g., NET_ANLYT, CUST_ANLYT, REV_ANLYT).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `subject_area_name` STRING COMMENT 'The business-friendly name of the analytical subject area (e.g., Network Analytics, Customer Analytics, Revenue Analytics, Usage Analytics, Workforce Analytics).',
    `subject_area_type` STRING COMMENT 'Classification of the analytical subject area based on its primary business purpose (operational, strategic, regulatory, customer-facing, network performance, financial).. Valid values are `operational|strategic|regulatory|customer_facing|network_performance|financial`',
    `tags` STRING COMMENT 'Comma-separated list of business tags or labels for categorization, search, and discovery of this analytical subject area (e.g., customer_360, network_performance, revenue_assurance).',
    `version_number` STRING COMMENT 'The semantic version number of this analytical subject area schema (e.g., 1.0.0, 2.1.3) following major.minor.patch convention.. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
    CONSTRAINT pk_analytical_subject_area PRIMARY KEY(`analytical_subject_area_id`)
) COMMENT 'Master registry of all analytical subject areas (data marts / analytical domains) defined within the telecommunications analytics platform — e.g., Network Analytics, Customer Analytics, Revenue Analytics, Usage Analytics, Workforce Analytics. Captures subject area name, owning business domain, primary grain, refresh cadence, platform layer (Silver/Gold), responsible data product owner, and associated KPI families. Serves as the top-level organizational taxonomy for the analytics catalog and governs which KPIs, dimensions, and data quality rules belong to each subject area.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`dq_rule` (
    `dq_rule_id` BIGINT COMMENT 'Unique identifier for the data quality rule. Primary key for the DQ rule catalog.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Data quality rule ownership enables accountability for rule maintenance, threshold adjustments, and false-positive resolution. Critical for DQ incident escalation workflows and rule approval processes',
    `derived_from_dq_rule_id` BIGINT COMMENT 'Self-referencing FK on dq_rule (derived_from_dq_rule_id)',
    `alert_channel` STRING COMMENT 'The communication channel used to notify stakeholders when this rule is violated beyond threshold. Multiple channels may be comma-separated.. Valid values are `email|slack|pagerduty|servicenow|webhook|none`',
    `alert_recipient_list` STRING COMMENT 'Comma-separated list of email addresses, Slack channels, or PagerDuty service keys that should receive alerts when this rule fails. Supports distribution lists and role-based aliases.',
    `business_impact` STRING COMMENT 'Description of the business consequences if this rule is violated. Examples: revenue leakage, SLA breach, customer churn risk, regulatory penalty, network outage, billing dispute.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this rule was first created in the DQ catalog. Immutable audit field.',
    `data_lineage_reference` STRING COMMENT 'Reference to the data lineage graph or metadata catalog entry that shows the upstream sources and downstream consumers of the data validated by this rule. Used for impact analysis.',
    `documentation_url` STRING COMMENT 'Link to external documentation, wiki page, or knowledge base article that provides additional context, examples, or troubleshooting guidance for this rule.. Valid values are `^https?://.*$`',
    `effective_end_date` DATE COMMENT 'The date after which this rule version is no longer active. Null indicates the rule is currently in effect with no planned end date.',
    `effective_start_date` DATE COMMENT 'The date from which this rule version becomes active and should be applied to data. Used for temporal rule management and historical analysis.',
    `execution_frequency` STRING COMMENT 'How often this rule should be executed by the DQ engine. Real-time rules run on streaming data, batch rules run on scheduled intervals, on-demand rules are triggered manually.. Valid values are `real-time|hourly|daily|weekly|monthly|on-demand`',
    `execution_layer` STRING COMMENT 'The lakehouse medallion architecture layer where this rule is executed. Bronze for raw data validation, Silver for cleansed data validation, Gold for aggregated/curated data validation.. Valid values are `bronze|silver|gold`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this rule is currently active and should be executed by the DQ engine. False means the rule is disabled (e.g., temporarily suspended during system maintenance or deprecated).',
    `is_blocking` BOOLEAN COMMENT 'Indicates whether violations of this rule should block downstream processing. True means failed records are quarantined and not promoted to the next layer. False means violations are logged but processing continues.',
    `last_execution_status` STRING COMMENT 'The outcome of the most recent execution of this rule. Success means the rule ran without errors, failure means execution failed, warning means execution succeeded but violations exceeded threshold, skipped means the rule was not executed due to conditions not being met.. Valid values are `success|failure|warning|skipped`',
    `last_execution_timestamp` TIMESTAMP COMMENT 'The date and time when this rule was last executed by the DQ engine. Used to monitor execution frequency and detect stale rules.',
    `last_modified_by` STRING COMMENT 'The username or identifier of the person or system that last modified this rule. Used for audit and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this rule was last updated. Updated whenever rule logic, thresholds, or metadata are changed.',
    `last_pass_rate_percentage` DECIMAL(18,2) COMMENT 'The percentage of records that passed this rule during the last execution (0.00 to 100.00). Used to track data quality trends over time.',
    `regulatory_mandate` STRING COMMENT 'Reference to the specific regulatory requirement, compliance framework, or industry standard that mandates this rule (e.g., FCC Part 64, GDPR Article 5, 3GPP TS 32.401). Null if the rule is business-driven rather than regulatory.',
    `related_kpi` STRING COMMENT 'The name or identifier of the business KPI that depends on this data quality rule. Examples: ARPU accuracy, churn prediction reliability, SLA compliance rate, CDR completeness for billing.',
    `remediation_guidance` STRING COMMENT 'Step-by-step instructions for data stewards on how to investigate and resolve violations of this rule. May include links to runbooks, contact information for data owners, or automated remediation procedures.',
    `rule_category` STRING COMMENT 'Classification of the rule by its purpose. Structural rules validate schema and format, semantic rules check meaning and relationships, business rules enforce business logic, regulatory rules ensure compliance with FCC, GDPR, or other mandates.. Valid values are `structural|semantic|business|regulatory`',
    `rule_code` STRING COMMENT 'Standardized alphanumeric code for the rule following pattern DOMAIN_TYPE_NUMBER (e.g., CDR_CMP_001, MSISDN_VAL_002). Used for programmatic reference and cross-system integration.. Valid values are `^[A-Z]{2,4}_[A-Z]{3}_[0-9]{3,5}$`',
    `rule_description` STRING COMMENT 'Detailed business description of what the rule validates, why it matters, and the expected outcome. Provides context for business users and data stewards.',
    `rule_expression` STRING COMMENT 'The logical expression or SQL predicate that defines the rule logic. May contain Spark SQL syntax, Python expressions, or declarative predicates. Example: msisdn IS NOT NULL AND LENGTH(msisdn) = 10 or billing_amount >= 0.',
    `rule_name` STRING COMMENT 'Human-readable name of the data quality rule. Used for identification and reporting purposes.',
    `rule_type` STRING COMMENT 'Category of data quality dimension this rule validates. Completeness checks for missing values, uniqueness ensures no duplicates, validity verifies format/range, consistency checks cross-field logic, timeliness measures freshness, accuracy validates correctness against source of truth.. Valid values are `completeness|uniqueness|validity|consistency|timeliness|accuracy`',
    `rule_version` STRING COMMENT 'Semantic version number of the rule definition following major.minor.patch format (e.g., 1.0.0, 2.1.3). Incremented when rule logic, thresholds, or metadata are updated.. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
    `sample_violation_query` STRING COMMENT 'A SQL query template that data stewards can run to retrieve sample records that violate this rule. Used for investigation and root cause analysis.',
    `severity_level` STRING COMMENT 'Impact classification of rule violations. Critical failures block downstream processing, major issues require immediate remediation, minor issues are logged for review, warnings are informational only.. Valid values are `critical|major|minor|warning`',
    `tags` STRING COMMENT 'Comma-separated list of user-defined tags for categorization and search. Examples: billing, network, customer-facing, regulatory, high-priority. Used for filtering and grouping rules in the DQ dashboard.',
    `target_attribute` STRING COMMENT 'The specific column or attribute within the target product that this rule validates. Null if the rule applies to the entire record or multiple attributes.',
    `target_domain` STRING COMMENT 'The business domain this rule applies to (e.g., Customer, Network, Billing, Product, Order, Service, Usage, Revenue Assurance). Aligns with the enterprise data domain taxonomy.',
    `target_product` STRING COMMENT 'The specific data product or table this rule validates (e.g., cdr, subscriber, invoice, network_element). References the lakehouse Silver Layer product catalog.',
    `technical_implementation` STRING COMMENT 'The technical framework or method used to implement this rule in the DQ execution engine. Spark SQL for native SQL predicates, Python UDF for custom logic, Great Expectations or Deequ for framework-based validation.. Valid values are `spark_sql|python_udf|great_expectations|deequ|custom`',
    `threshold_operator` STRING COMMENT 'The comparison operator used to evaluate the threshold. Typically >= for minimum pass rates, <= for maximum error rates.. Valid values are `>=|>|<=|<|=`',
    `threshold_percentage` DECIMAL(18,2) COMMENT 'The minimum acceptable pass rate for this rule as a percentage (0.00 to 100.00). Example: 99.50 means at least 99.5% of records must pass. Used to trigger alerts when quality falls below threshold.',
    `created_by` STRING COMMENT 'The username or identifier of the person or system that created this rule. Used for audit and accountability.',
    CONSTRAINT pk_dq_rule PRIMARY KEY(`dq_rule_id`)
) COMMENT 'Master catalog of all Data Quality (DQ) rules defined across the telecommunications data platform — the SSOT for data quality governance definitions. Captures rule name, rule type (completeness, uniqueness, validity, consistency, timeliness, accuracy), rule expression or SQL predicate, severity level (critical, major, minor), target domain and product, expected threshold percentage, remediation guidance, and rule owner. Covers rules for CDR completeness, MSISDN format validity, billing amount non-negativity, SLA breach timeliness, and subscriber record uniqueness. Used by the DQ execution engine to validate Silver Layer data.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` (
    `dq_execution_result_id` BIGINT COMMENT 'Unique identifier for each data quality rule execution result record. Primary key for the DQ execution result entity.',
    `dq_rule_id` BIGINT COMMENT 'Reference to the specific data quality rule that was executed in this run. Links to the DQ rule catalog.',
    `pipeline_run_id` BIGINT COMMENT 'Unique identifier of the Databricks pipeline or job run that triggered this data quality rule execution. Enables traceability to upstream data processing workflows.',
    `rerun_of_dq_execution_result_id` BIGINT COMMENT 'Self-referencing FK on dq_execution_result (rerun_of_dq_execution_result_id)',
    `business_date` DATE COMMENT 'Business effective date for which the data quality rule was executed. May differ from execution_timestamp for batch processing of historical data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this execution result record was first created in the DQ execution result table. Used for audit trail and data lineage.',
    `data_steward_notified_flag` BOOLEAN COMMENT 'Indicates whether the assigned data steward was notified of this rule execution result. True if notification was sent; false otherwise.',
    `error_message` STRING COMMENT 'Detailed error or exception message if the rule execution encountered a technical failure (execution_status = error). Null for successful executions.',
    `execution_duration_seconds` DECIMAL(18,2) COMMENT 'Total time in seconds taken to execute the data quality rule against the target data product. Used for performance monitoring and optimization.',
    `execution_mode` STRING COMMENT 'Mode in which the data quality rule was executed. Scheduled for automated runs; manual for ad-hoc validation; triggered for event-driven execution; continuous for streaming data validation.. Valid values are `scheduled|manual|triggered|continuous`',
    `execution_status` STRING COMMENT 'Overall outcome status of the data quality rule execution. Passed indicates all records met the rule criteria; failed indicates threshold breach; warning indicates approaching threshold; error indicates execution failure; skipped indicates rule was not applicable.. Valid values are `passed|failed|warning|error|skipped`',
    `execution_timestamp` TIMESTAMP COMMENT 'Precise date and time when the data quality rule execution was initiated. Used for operational audit trail and SLA compliance tracking.',
    `failure_sample_records` STRING COMMENT 'JSON array containing a sample of records that failed the data quality rule. Includes primary key and relevant attribute values to enable root cause analysis. Limited to first 100 failures for performance.',
    `failure_threshold_percentage` DECIMAL(18,2) COMMENT 'Configured threshold percentage below which the rule execution is considered failed. Used to determine execution_status based on pass_rate_percentage.',
    `pass_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of records that passed the data quality rule, calculated as (records_passed_count / records_evaluated_count) * 100. Key metric for DQ dashboard and SLA monitoring.',
    `records_evaluated_count` BIGINT COMMENT 'Total number of records in the target data product that were evaluated against the data quality rule during this execution.',
    `records_failed_count` BIGINT COMMENT 'Number of records that did not meet the data quality rule criteria. Used to calculate failure rate and identify data quality issues.',
    `records_passed_count` BIGINT COMMENT 'Number of records that successfully met the data quality rule criteria. Used to calculate pass rate percentage.',
    `remediation_action` STRING COMMENT 'Recommended or automated remediation action to address data quality failures (e.g., quarantine records, trigger data steward notification, auto-correct). Supports operational response workflows.',
    `rule_category` STRING COMMENT 'Classification of the data quality rule based on ISO 25012 quality dimensions. Enables categorization of DQ issues for governance reporting.. Valid values are `completeness|validity|accuracy|consistency|timeliness|uniqueness`',
    `rule_code` STRING COMMENT 'Business-friendly code identifier for the executed rule (e.g., CUS-VAL-001 for customer validation rule 001). Enables human-readable rule reference in reports and dashboards.. Valid values are `^[A-Z]{3}-[A-Z]{3}-[0-9]{3}$`',
    `rule_name` STRING COMMENT 'Descriptive name of the data quality rule that was executed (e.g., Customer Email Format Validation, MSISDN Length Check).',
    `rule_severity` STRING COMMENT 'Business impact severity of the data quality rule. Critical rules block downstream processing; low severity rules are informational only.. Valid values are `critical|high|medium|low`',
    `rule_version` STRING COMMENT 'Version identifier of the data quality rule definition at the time of execution. Enables tracking of rule changes over time and historical comparison.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether this execution result meets the defined SLA for data quality. True if pass_rate_percentage meets or exceeds the SLA threshold; false if SLA is breached.',
    `target_domain` STRING COMMENT 'Business domain of the data product being validated (e.g., Customer, Network, Billing, Product). Aligns with enterprise data domain taxonomy.',
    `target_layer` STRING COMMENT 'Lakehouse medallion architecture layer where the target data product resides. Typically silver for curated business entities.. Valid values are `bronze|silver|gold`',
    `target_product` STRING COMMENT 'Name of the specific data product (table/entity) in the Databricks Lakehouse Silver Layer that was evaluated by this rule execution.',
    `warning_threshold_percentage` DECIMAL(18,2) COMMENT 'Configured threshold percentage below which the rule execution triggers a warning status. Enables proactive alerting before SLA breach.',
    `created_by` STRING COMMENT 'User ID or service account that created this execution result record. Typically the DQ framework service account for automated executions.',
    CONSTRAINT pk_dq_execution_result PRIMARY KEY(`dq_execution_result_id`)
) COMMENT 'Transactional record of each Data Quality rule execution run against a target data product in the Databricks Lakehouse Silver Layer. Captures execution timestamp, rule reference, target domain and product, records evaluated count, records passed count, records failed count, pass rate percentage, execution status (passed, failed, warning), failure sample records (JSON), and triggering pipeline run ID. Provides the operational audit trail for data quality monitoring, SLA compliance for data freshness, and feeds the DQ dashboard for the data governance team.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`dq_issue` (
    `dq_issue_id` BIGINT COMMENT 'Unique identifier for the data quality issue record. Primary key for the DQ issue entity.',
    `element_id` BIGINT COMMENT 'Foreign key linking to network.element. Business justification: Data quality issues in network performance data must be traceable to specific network elements for root cause analysis and remediation. Network operations teams require DQ issue tracking tied to infra',
    `dq_execution_result_id` BIGINT COMMENT 'Foreign key reference to the specific DQ rule execution run that produced the measurement leading to this issue. Links the managed issue to the raw measurement event.',
    `dq_rule_id` BIGINT COMMENT 'Foreign key reference to the DQ rule that detected this issue. Null if the issue was identified through manual data steward review.',
    `location_site_id` BIGINT COMMENT 'Foreign key linking to location.location_site. Business justification: Data quality issues in network data are often traced to specific site equipment or collection points for remediation. Links DQ issues to physical infrastructure for field technician dispatch and equip',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the data steward responsible for investigating and remediating this DQ issue.',
    `spare_part_id` BIGINT COMMENT 'Foreign key linking to inventory.spare_part. Business justification: Inventory data quality issues (stock discrepancies, obsolete records, missing BOMs) are logged as DQ issues to drive supply chain data stewardship and remediation workflows.',
    `related_dq_issue_id` BIGINT COMMENT 'Self-referencing FK on dq_issue (related_dq_issue_id)',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'The date and time when the assigned data steward acknowledged receipt and ownership of the issue.',
    `affected_attribute` STRING COMMENT 'The specific column or attribute within the data product that exhibits the quality defect. Null if the issue is record-level or cross-attribute.',
    `affected_domain` STRING COMMENT 'The data domain where the quality issue was detected (e.g., Customer, Network, Billing, Product). Maps to the enterprise data domain taxonomy.',
    `affected_product` STRING COMMENT 'The specific data product (table/entity) within the domain where the quality issue was identified.',
    `affected_record_count` BIGINT COMMENT 'Number of data records impacted by this quality issue. Used to quantify the scope and business impact of the defect.',
    `affected_report_list` STRING COMMENT 'Comma-separated list of business intelligence reports, dashboards, or analytics products impacted by this data quality issue for stakeholder notification.',
    `business_impact_description` STRING COMMENT 'Narrative description of the business consequences of this data quality issue including affected reports, analytics, operational processes, or regulatory compliance.',
    `closed_timestamp` TIMESTAMP COMMENT 'The date and time when the issue was verified as resolved and formally closed, completing the issue lifecycle.',
    `compliance_impact_flag` BOOLEAN COMMENT 'Boolean indicator whether this data quality issue affects regulatory reporting, compliance obligations, or audit requirements requiring special handling.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this DQ issue record was first created in the system for audit and lifecycle tracking.',
    `detected_timestamp` TIMESTAMP COMMENT 'The date and time when the data quality issue was first identified, marking the start of the issue lifecycle and SLA clock.',
    `detection_method` STRING COMMENT 'The method by which the data quality issue was discovered to support effectiveness analysis of detection mechanisms.. Valid values are `automated_rule|manual_review|user_report|reconciliation|audit`',
    `dq_dimension` STRING COMMENT 'The data quality dimension violated by this issue per ISO/IEC 25012 framework (e.g., completeness for missing values, accuracy for incorrect values).. Valid values are `completeness|accuracy|consistency|validity|timeliness|uniqueness`',
    `escalation_level` STRING COMMENT 'Current escalation tier of the issue (0=no escalation, 1=team lead, 2=manager, 3=director, 4=executive) based on severity and SLA breach status.',
    `estimated_revenue_impact` DECIMAL(18,2) COMMENT 'Estimated financial impact of the data quality issue on revenue recognition, billing accuracy, or revenue assurance in the base currency.',
    `issue_description` STRING COMMENT 'Detailed narrative description of the data quality issue including symptoms, impact, and context discovered during DQ rule execution or manual review.',
    `issue_number` STRING COMMENT 'Human-readable business identifier for the DQ issue, formatted as DQI-YYYYMMDD for external reference and tracking.. Valid values are `^DQI-[0-9]{8}$`',
    `issue_status` STRING COMMENT 'Current lifecycle status of the DQ issue tracking its progression from detection through remediation to closure.. Valid values are `open|in_progress|pending_validation|resolved|closed|reopened`',
    `issue_title` STRING COMMENT 'Short descriptive title summarizing the nature of the data quality issue for quick identification and reporting.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified the DQ issue record for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this DQ issue record was last updated, supporting audit trail and change history tracking.',
    `priority` STRING COMMENT 'Operational priority ranking for issue remediation combining severity, business impact, and resource availability. P1 requires immediate action.. Valid values are `p1|p2|p3|p4`',
    `recurrence_flag` BOOLEAN COMMENT 'Boolean indicator whether this issue is a recurrence of a previously resolved issue, signaling potential systemic problems requiring deeper investigation.',
    `remediation_action` STRING COMMENT 'Description of the corrective action taken or planned to resolve the data quality issue including system fixes, data corrections, or process changes.',
    `remediation_status` STRING COMMENT 'Current status of the remediation effort tracking progress from planning through implementation to verification.. Valid values are `not_started|in_progress|completed|verified|failed`',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the resolution approach, actions taken, validation results, and lessons learned for knowledge management.',
    `resolved_timestamp` TIMESTAMP COMMENT 'The date and time when the remediation action was completed and the issue was marked as resolved, stopping the SLA clock.',
    `root_cause_category` STRING COMMENT 'High-level classification of the underlying cause of the data quality issue to support trend analysis and preventive action.. Valid values are `source_system_defect|etl_transformation_error|schema_change|business_rule_gap|data_entry_error|integration_failure`',
    `root_cause_detail` STRING COMMENT 'Detailed explanation of the root cause analysis findings including specific system, process, or configuration defect identified during investigation.',
    `severity_level` STRING COMMENT 'Business impact severity classification of the DQ issue determining prioritization and response urgency. Critical issues block downstream analytics or violate regulatory requirements.. Valid values are `critical|high|medium|low`',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean indicator whether the issue resolution exceeded the SLA target time, triggering escalation and reporting requirements.',
    `sla_target_resolution_hours` STRING COMMENT 'The number of hours within which this issue must be resolved per the data quality SLA based on severity level.',
    `source_system` STRING COMMENT 'The operational system of record where the defective data originated (e.g., Amdocs, Salesforce CRM, Nokia NetAct). Maps to the enterprise system catalog.',
    `created_by` STRING COMMENT 'Username or identifier of the system or user who created the DQ issue record for audit trail purposes.',
    CONSTRAINT pk_dq_issue PRIMARY KEY(`dq_issue_id`)
) COMMENT 'Operational record of a confirmed Data Quality issue identified through DQ rule execution or manual data steward review. Captures issue description, severity, affected domain and product, affected record count, root cause category (source system defect, ETL transformation error, schema change, business rule gap), assigned data steward, remediation action taken, resolution status, and SLA breach flag. Tracks the full lifecycle of a DQ issue from detection through remediation and closure. Distinct from dq_execution_result which is the raw measurement — this is the managed issue record.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` (
    `analytical_model_registry_id` BIGINT COMMENT 'Unique identifier for the analytical model registry entry. Primary key for the analytical model registry.',
    `analytical_subject_area_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_subject_area. Business justification: ML models belong to analytical subject areas. One model belongs to ONE subject area; one subject area contains MANY models. This establishes the organizational ownership and domain classification of t',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: ML model governance in telecommunications requires formal employee ownership for accountability, access control, model risk management, and regulatory compliance (e.g., AI/ML model inventory requireme',
    `predecessor_analytical_model_registry_id` BIGINT COMMENT 'Self-referencing FK on analytical_model_registry (predecessor_analytical_model_registry_id)',
    `algorithm_name` STRING COMMENT 'Specific algorithm or technique used to build the model. Examples include Random Forest, XGBoost, LSTM, Logistic Regression, K-Means.',
    `approval_date` DATE COMMENT 'Date when the model received governance approval for production deployment.',
    `approval_status` STRING COMMENT 'Governance approval status for the model. Indicates whether the model has been reviewed and approved for production use by governance stakeholders.. Valid values are `pending|approved|rejected|under_review`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or committee that approved the model for production deployment.',
    `business_impact_description` STRING COMMENT 'Description of the expected or realized business impact of the model. Examples include revenue uplift, cost reduction, churn reduction, or operational efficiency gains.',
    `business_use_case` STRING COMMENT 'Description of the business problem or opportunity this model addresses. Examples include churn prediction, network anomaly detection, ARPU forecasting, demand planning, customer segmentation, fraud detection, or service quality prediction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the model registry entry was first created in the system. Supports audit trail and lifecycle tracking.',
    `deployment_status` STRING COMMENT 'Current lifecycle state of the model in the deployment pipeline. Indicates whether the model is in development, testing, production use, or has been retired.. Valid values are `development|testing|staging|production|retired|deprecated`',
    `explainability_method` STRING COMMENT 'Technique or method used to explain model predictions. Examples include SHAP, LIME, feature importance, or partial dependence plots.',
    `fairness_assessment_status` STRING COMMENT 'Status of fairness and bias assessment for the model. Indicates whether the model has been evaluated for discriminatory outcomes across protected groups.. Valid values are `not_assessed|passed|failed|in_progress`',
    `feature_list` STRING COMMENT 'Comma-separated or structured list of features (input variables) used by the model. Documents the feature engineering and selection decisions.',
    `framework` STRING COMMENT 'Software framework or library used to develop and train the model. Examples include TensorFlow, PyTorch, Scikit-learn, Spark MLlib, H2O.',
    `hyperparameters` STRING COMMENT 'JSON or structured representation of hyperparameters used to configure the model. Documents tuning decisions and model configuration.',
    `inference_latency_ms` DECIMAL(18,2) COMMENT 'Average time in milliseconds required for the model to generate a prediction. Key performance indicator for real-time serving.',
    `last_deployment_date` DATE COMMENT 'Date when the model was last deployed to a serving environment. Tracks deployment history and release cadence.',
    `last_training_date` DATE COMMENT 'Date when the model was last trained or retrained. Tracks model freshness and retraining cadence.',
    `model_artifact_path` STRING COMMENT 'Storage path or URI where the serialized model artifact is stored. Enables model retrieval and deployment.',
    `model_category` STRING COMMENT 'Learning paradigm category of the model. Distinguishes the training methodology and data requirements.. Valid values are `supervised|unsupervised|semi_supervised|reinforcement|transfer_learning|federated`',
    `model_code` STRING COMMENT 'Unique business code or identifier for the model used across systems and documentation. Externally-known identifier for model reference.',
    `model_documentation_url` STRING COMMENT 'URL or link to detailed model documentation, including methodology, assumptions, limitations, and usage guidelines.',
    `model_expiry_date` DATE COMMENT 'Date when the model is scheduled to be retired or replaced. Supports planned model lifecycle management.',
    `model_name` STRING COMMENT 'Human-readable name of the analytical or machine learning model. Serves as the primary business identifier for the model.',
    `model_size_mb` DECIMAL(18,2) COMMENT 'Size of the serialized model artifact in megabytes. Impacts storage, deployment, and inference latency considerations.',
    `model_type` STRING COMMENT 'Classification of the analytical model by its algorithmic approach. Defines the fundamental machine learning paradigm used.. Valid values are `regression|classification|clustering|time_series|deep_learning|ensemble`',
    `model_version` STRING COMMENT 'Version identifier for the model. Supports model versioning and lineage tracking across iterations and retraining cycles.',
    `monitoring_enabled` BOOLEAN COMMENT 'Indicates whether automated monitoring is enabled for the model. Monitoring tracks performance drift, data drift, and prediction quality.',
    `owning_team` STRING COMMENT 'Name of the team or organizational unit responsible for developing, maintaining, and governing this model.',
    `performance_metric_accuracy` DECIMAL(18,2) COMMENT 'Overall accuracy metric representing the proportion of correct predictions. Applicable to classification models.',
    `performance_metric_auc` DECIMAL(18,2) COMMENT 'Area Under the Receiver Operating Characteristic Curve metric for classification models. Measures the models ability to distinguish between classes.',
    `performance_metric_f1` DECIMAL(18,2) COMMENT 'F1 Score metric for classification models. Harmonic mean of precision and recall, balancing false positives and false negatives.',
    `performance_metric_mae` DECIMAL(18,2) COMMENT 'Mean Absolute Error metric for regression models. Measures the average absolute difference between predicted and actual values.',
    `performance_metric_precision` DECIMAL(18,2) COMMENT 'Precision metric for classification models. Measures the proportion of positive predictions that are actually correct.',
    `performance_metric_recall` DECIMAL(18,2) COMMENT 'Recall (sensitivity) metric for classification models. Measures the proportion of actual positives that are correctly identified.',
    `performance_metric_rmse` DECIMAL(18,2) COMMENT 'Root Mean Squared Error metric for regression models. Measures the average magnitude of prediction errors.',
    `refresh_schedule` STRING COMMENT 'Frequency or schedule for retraining the model with updated data. Examples include daily, weekly, monthly, or event-driven retraining.',
    `risk_classification` STRING COMMENT 'Risk level associated with the model based on business impact, regulatory requirements, and potential for harm. Drives governance and monitoring requirements.. Valid values are `low|medium|high|critical`',
    `serving_endpoint` STRING COMMENT 'URL or API endpoint where the model is deployed and accessible for inference requests. Enables real-time or batch scoring.',
    `serving_platform` STRING COMMENT 'Platform or infrastructure where the model is deployed for serving. Examples include Databricks Model Serving, SageMaker, Azure ML, Kubernetes.',
    `target_variable` STRING COMMENT 'The dependent variable or outcome that the model predicts or classifies. Defines the models objective.',
    `test_dataset_size` BIGINT COMMENT 'Number of records or observations used to test the model after training. Provides unbiased evaluation of final model performance.',
    `training_data_lineage` STRING COMMENT 'Description of source data domains and data products used to train the model. Captures upstream data dependencies for lineage tracking and impact analysis.',
    `training_dataset_size` BIGINT COMMENT 'Number of records or observations used to train the model. Indicates the scale of training data.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the model registry entry was last updated. Tracks changes to model metadata, version, or deployment status.',
    `validation_dataset_size` BIGINT COMMENT 'Number of records or observations used to validate the model during training. Used for hyperparameter tuning and model selection.',
    CONSTRAINT pk_analytical_model_registry PRIMARY KEY(`analytical_model_registry_id`)
) COMMENT 'Master registry of all analytical and ML models deployed or in development within the telecommunications analytics platform — the SSOT for model metadata governance. Captures model name, model type (regression, classification, clustering, time-series, deep learning), business use case (churn prediction, network anomaly detection, ARPU forecasting, demand planning), owning team, model version, training data lineage (source domains and products), feature list, performance metrics (AUC, RMSE, F1), deployment status, serving endpoint, and model refresh schedule. Supports MLOps governance and model lineage tracking.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`model_run` (
    `model_run_id` BIGINT COMMENT 'Unique identifier for each analytical or machine learning model execution run. Primary key for the model run record.',
    `analytical_model_registry_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_model_registry. Business justification: Each model run executes a specific registered model. One run belongs to ONE model; one model has MANY runs over time. Currently model_run has model_version_id (likely a version number, not a FK to reg',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Model execution audit trail requires employee linkage for compliance, security investigations, and troubleshooting in telecommunications ML operations. Critical for model risk management and regulator',
    `analytical_dataset_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_dataset. Business justification: Model runs consume input analytical datasets for training or scoring. One run uses ONE primary input dataset; one dataset can be used by MANY runs. Currently input_dataset_path is a string path refere',
    `parent_run_model_run_id` BIGINT COMMENT 'Reference to a parent model run if this is a nested or child run (e.g., hyperparameter tuning iteration, cross-validation fold).',
    `fraud_case_id` BIGINT COMMENT 'Foreign key linking to assurance.fraud_case. Business justification: Model training runs use historical fraud cases as labeled training data. Real-world ML operations track which fraud cases were used to train which model versions for reproducibility, bias analysis, an',
    `retrained_from_model_run_id` BIGINT COMMENT 'Self-referencing FK on model_run (retrained_from_model_run_id)',
    `auc_score` DECIMAL(18,2) COMMENT 'Area Under the Receiver Operating Characteristic (ROC) Curve score for classification models. Measures model discrimination ability (0.0 to 1.0).',
    `cluster_code` STRING COMMENT 'Identifier of the Databricks cluster or compute resource used to execute this model run. Used for cost allocation and performance analysis.',
    `compute_cost_usd` DECIMAL(18,2) COMMENT 'Estimated or actual compute cost in USD for executing this model run. Used for cost tracking and optimization of ML operations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this model run record was first created in the system. Part of audit trail for data governance and lineage tracking.',
    `drift_detected_flag` BOOLEAN COMMENT 'Boolean flag indicating whether data drift or model performance drift was detected during or after this run. True if drift detected, False otherwise.',
    `drift_score` DECIMAL(18,2) COMMENT 'Quantitative measure of data or model drift detected in this run. Higher values indicate greater drift from baseline or training distribution.',
    `error_message` STRING COMMENT 'Detailed error message or exception text if the model run failed or encountered errors during execution. Null for successful runs.',
    `evaluation_metric_primary` STRING COMMENT 'Name of the primary evaluation metric used to assess model performance (e.g., AUC, RMSE, F1-score, accuracy, precision, recall, MAE).',
    `evaluation_metric_primary_value` DECIMAL(18,2) COMMENT 'Numeric value of the primary evaluation metric achieved in this model run. Used for performance tracking and model comparison.',
    `execution_environment` STRING COMMENT 'Computing environment where the model run was executed: Databricks cluster, local machine, Kubernetes, AWS SageMaker, Azure ML, or Google Vertex AI.. Valid values are `databricks_cluster|local|kubernetes|sagemaker|azure_ml|vertex_ai`',
    `experiment_code` STRING COMMENT 'Identifier of the MLflow experiment or model development project that this run belongs to. Groups related model runs for comparison.',
    `f1_score` DECIMAL(18,2) COMMENT 'Harmonic mean of precision and recall for classification models. Provides balanced measure of model performance (0.0 to 1.0).',
    `feature_importance_path` STRING COMMENT 'Storage path where feature importance scores or SHAP values from this model run are saved for model interpretability analysis.',
    `hyperparameters_json` STRING COMMENT 'JSON-formatted string containing all hyperparameter configurations used in this model run (learning rate, batch size, epochs, etc.). Essential for model reproducibility.',
    `input_record_count` BIGINT COMMENT 'Total number of records in the input dataset processed during this model run. Used for data quality validation and performance analysis.',
    `is_baseline_run` BOOLEAN COMMENT 'Boolean flag indicating whether this run represents a baseline model for performance comparison. True if baseline, False otherwise.',
    `is_production_candidate` BOOLEAN COMMENT 'Boolean flag indicating whether this model run produced a model that is a candidate for production deployment. True if candidate, False otherwise.',
    `mae_score` DECIMAL(18,2) COMMENT 'Mean Absolute Error for regression models. Measures average absolute difference between predicted and actual values.',
    `model_version_code` BIGINT COMMENT 'Reference to the specific version of the analytical or ML model that was executed in this run. Links to the model version catalog.',
    `output_artifact_path` STRING COMMENT 'Delta table path, MLflow artifact URI, or storage location where model output artifacts (trained model, predictions, feature importance) are stored.',
    `output_model_path` STRING COMMENT 'Specific storage path or URI where the trained model binary or serialized model object is persisted for deployment or future inference.',
    `precision_score` DECIMAL(18,2) COMMENT 'Precision metric for classification models, representing the ratio of true positives to total predicted positives. Measures prediction accuracy (0.0 to 1.0).',
    `prediction_output_path` STRING COMMENT 'Delta table path or storage location where model predictions or inference results from this run are written.',
    `r_squared_score` DECIMAL(18,2) COMMENT 'Coefficient of determination (R²) for regression models. Indicates proportion of variance in the dependent variable explained by the model (-∞ to 1.0).',
    `recall_score` DECIMAL(18,2) COMMENT 'Recall metric for classification models, representing the ratio of true positives to total actual positives. Measures model sensitivity (0.0 to 1.0).',
    `rmse_score` DECIMAL(18,2) COMMENT 'Root Mean Squared Error for regression models. Measures average prediction error magnitude in the same units as the target variable.',
    `run_duration_seconds` DECIMAL(18,2) COMMENT 'Total elapsed time in seconds for the model execution run from start to completion. Used for performance monitoring and resource optimization.',
    `run_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the model execution run completed or terminated. Used to calculate total run duration.',
    `run_name` STRING COMMENT 'Human-readable name or label assigned to this model run for identification and tracking purposes.',
    `run_notes` STRING COMMENT 'Free-text notes or comments about this model run added by data scientists or ML engineers for documentation and knowledge sharing.',
    `run_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the model execution run was initiated. Represents the beginning of the training or inference process.',
    `run_status` STRING COMMENT 'Current execution status of the model run indicating whether it completed successfully, failed, is still running, or was cancelled.. Valid values are `success|failed|running|degraded|cancelled|pending`',
    `training_framework` STRING COMMENT 'Name and version of the ML framework used for this run (e.g., TensorFlow 2.10, PyTorch 1.12, Scikit-learn 1.1, Spark MLlib 3.3).',
    `trigger_event_code` STRING COMMENT 'Identifier of the specific event or job that triggered this model run. May reference a scheduler job ID, API request ID, or drift detection event ID.',
    `trigger_type` STRING COMMENT 'Classification of what initiated this model run: scheduled job, manual execution, automated retraining trigger, drift detection, or external API request.. Valid values are `scheduled|manual|retraining_trigger|drift_detected|api_request|event_driven`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this model run record was last updated or modified. Used for change tracking and audit purposes.',
    CONSTRAINT pk_model_run PRIMARY KEY(`model_run_id`)
) COMMENT 'Transactional record of each analytical or ML model execution run — capturing run timestamp, model version reference, input dataset snapshot reference, hyperparameter configuration, training duration, evaluation metrics achieved (AUC, precision, recall, RMSE), run status (success, failed, degraded), output artifact location (Delta table path or MLflow artifact URI), and triggering event (scheduled, ad-hoc, retraining trigger). Provides the operational audit trail for model governance, reproducibility, and performance drift monitoring over time.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` (
    `feature_store_definition_id` BIGINT COMMENT 'Unique identifier for the feature store definition record. Primary key for the feature catalog in the Databricks Feature Store.',
    `analytical_dataset_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_dataset. Business justification: Features are computed from source analytical datasets. One feature is sourced from ONE primary dataset; one dataset can be the source for MANY features. Currently source_product_name is a string refer',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Feature store governance in telecommunications ML operations requires business owner accountability for feature definition approval, usage policies, and lifecycle management. Critical for model risk m',
    `derived_from_feature_store_definition_id` BIGINT COMMENT 'Self-referencing FK on feature_store_definition (derived_from_feature_store_definition_id)',
    `aggregation_window` STRING COMMENT 'Time window over which aggregation is performed for time-based features (e.g., 7_days, 30_days, 90_days, 12_months). Null for non-aggregated features.',
    `computation_duration_seconds` STRING COMMENT 'Average duration in seconds required to compute this feature during the last refresh cycle. Used for performance monitoring.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this feature definition record was first created in the Feature Store catalog.',
    `data_classification` STRING COMMENT 'Security classification level of the feature data. Determines access controls and handling requirements.. Valid values are `public|internal|confidential|restricted`',
    `data_quality_rule` STRING COMMENT 'SQL expression or rule definition for validating feature values. Used for automated data quality checks during feature computation.',
    `effective_end_date` DATE COMMENT 'Date when this feature definition was deprecated or retired. Null for currently active features.',
    `effective_start_date` DATE COMMENT 'Date when this feature definition became active and available for use in production models.',
    `entity_key_column` STRING COMMENT 'Name of the primary entity key column used to join this feature to other datasets (e.g., subscriber_id, account_id, cell_id). Defines the grain of the feature.',
    `feature_category` STRING COMMENT 'High-level classification of the feature type based on the nature of the data it represents. Used for feature discovery and organization. [ENUM-REF-CANDIDATE: demographic|behavioral|transactional|network_quality|device|temporal|aggregated|derived — 8 candidates stripped; promote to reference product]',
    `feature_data_type` STRING COMMENT 'Spark SQL data type of the feature value. Defines the technical data type used for storage and computation. [ENUM-REF-CANDIDATE: STRING|INT|BIGINT|DOUBLE|FLOAT|DECIMAL|BOOLEAN|DATE|TIMESTAMP|ARRAY|STRUCT — 11 candidates stripped; promote to reference product]',
    `feature_description` STRING COMMENT 'Detailed business description of what the feature represents, how it is calculated, and its intended analytical use. Supports feature discovery and understanding.',
    `feature_group_name` STRING COMMENT 'Logical grouping or namespace for related features. Organizes features by business domain or analytical purpose (e.g., subscriber_behavior, network_performance, billing_patterns).',
    `feature_importance_score` DECIMAL(18,2) COMMENT 'Aggregated feature importance score across all models using this feature. Ranges from 0.0000 to 1.0000, with higher values indicating greater predictive power.',
    `feature_name` STRING COMMENT 'Unique name of the machine learning feature as registered in the Feature Store. Must be unique within the feature group. Examples: subscriber_tenure_months, avg_monthly_data_consumption_gb, network_quality_score.',
    `feature_status` STRING COMMENT 'Current lifecycle status of the feature definition. Active features are production-ready and available for model consumption.. Valid values are `draft|active|deprecated|archived|experimental`',
    `feature_tags` STRING COMMENT 'Comma-separated list of custom tags or labels for feature categorization and discovery (e.g., churn_prediction, revenue_optimization, network_analytics).',
    `is_pii` BOOLEAN COMMENT 'Indicates whether this feature contains or is derived from personally identifiable information. True if feature requires privacy controls per GDPR, CCPA, or CPNI regulations.',
    `last_computed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful feature computation job. Indicates data freshness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this feature definition record was last updated. Tracks metadata changes and version history.',
    `model_names` STRING COMMENT 'Comma-separated list of model names that consume this feature. Establishes downstream lineage to ML models.',
    `model_usage_count` STRING COMMENT 'Number of distinct ML models currently consuming this feature. Indicates feature reuse and criticality.',
    `modified_by` STRING COMMENT 'Username or identifier of the person who last modified this feature definition. Supports audit and accountability.',
    `null_handling_strategy` STRING COMMENT 'Strategy for handling null or missing values in the feature. Defines how nulls are treated during feature computation and model training. [ENUM-REF-CANDIDATE: drop|impute_mean|impute_median|impute_mode|impute_zero|impute_forward_fill|impute_custom — 7 candidates stripped; promote to reference product]',
    `null_percentage` DECIMAL(18,2) COMMENT 'Percentage of null values in the feature column. Used for data quality monitoring and feature selection.',
    `offline_serving_enabled` BOOLEAN COMMENT 'Indicates whether this feature is available for batch offline serving for model training and batch inference. True if feature is available in offline store.',
    `online_serving_enabled` BOOLEAN COMMENT 'Indicates whether this feature is available for real-time online serving through the Feature Store API. True if feature is published to online store.',
    `partition_columns` STRING COMMENT 'Comma-separated list of columns used for partitioning the feature table for optimized query performance (e.g., year, month, region).',
    `row_count` BIGINT COMMENT 'Total number of rows (entity-timestamp combinations) in the feature table. Indicates feature coverage.',
    `source_domain` STRING COMMENT 'Business domain from which the source data originates (e.g., Customer, Network, Billing, Usage). Maps to the data domain taxonomy.',
    `storage_location` STRING COMMENT 'Physical storage path or table name where the feature values are persisted in the lakehouse (e.g., dbfs:/feature_store/subscriber_features).',
    `technical_owner` STRING COMMENT 'Name or identifier of the data engineer or ML engineer responsible for implementing and maintaining this feature.',
    `timestamp_column` STRING COMMENT 'Name of the timestamp column used for point-in-time lookups and time-travel queries. Required for time-series features.',
    `transformation_language` STRING COMMENT 'Programming or query language used to define the feature transformation logic.. Valid values are `SQL|PySpark|Python|Scala`',
    `transformation_logic` STRING COMMENT 'SQL or PySpark expression defining how the feature is computed from source data. Contains the complete transformation code or reference to transformation function.',
    `update_frequency` STRING COMMENT 'Cadence at which the feature values are refreshed or recomputed. Defines the data freshness SLA for this feature. [ENUM-REF-CANDIDATE: real_time|near_real_time|hourly|daily|weekly|monthly|on_demand|batch — 8 candidates stripped; promote to reference product]',
    `usage_notes` STRING COMMENT 'Free-text guidance for data scientists on how to properly use this feature, including known limitations, caveats, or best practices.',
    `version_number` STRING COMMENT 'Semantic version number of the feature definition (e.g., 1.0.0, 2.1.3). Incremented when transformation logic or schema changes.',
    CONSTRAINT pk_feature_store_definition PRIMARY KEY(`feature_store_definition_id`)
) COMMENT 'Master catalog of all ML feature definitions registered in the Databricks Feature Store for the telecommunications analytics platform. Captures feature name, feature group, data type, transformation logic (SQL or PySpark expression), source domain and product, update frequency, feature importance scores by model, online/offline serving flag, and data lineage. Covers telecom-specific features: subscriber tenure, average monthly data consumption, network quality score per cell, payment delinquency flag, roaming frequency, and device upgrade recency. Enables feature reuse across multiple analytical models.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` (
    `bi_report_definition_id` BIGINT COMMENT 'Unique identifier for the BI report definition record. Primary key.',
    `analytical_subject_area_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_subject_area. Business justification: BI reports belong to analytical subject areas (data marts). One report belongs to ONE subject area; one subject area contains MANY reports. This establishes the organizational ownership of the report ',
    `network_qos_profile_id` BIGINT COMMENT 'Foreign key linking to network.qos_profile. Business justification: QoS performance reports and SLA dashboards reference specific QoS profiles (e.g., GBR bearers, QCI classes) for service quality analysis. Regulatory reporting and enterprise SLA validation require rep',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: BI report governance requires formal employee ownership for access management, report certification workflows, decommissioning decisions, and ownership transfer during employee transitions. Denormaliz',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Many BI reports are scoped to specific territories for regional management dashboards, franchise reporting, and territory performance tracking. Standard practice for decentralized telecommunications o',
    `drillthrough_bi_report_definition_id` BIGINT COMMENT 'Self-referencing FK on bi_report_definition (drillthrough_bi_report_definition_id)',
    `access_tier` STRING COMMENT 'Data classification level determining who can access the report based on sensitivity of underlying data.. Valid values are `public|internal|restricted|confidential`',
    `average_load_time_seconds` DECIMAL(18,2) COMMENT 'Average time in seconds for the report to load and render, used for performance monitoring.',
    `certification_date` DATE COMMENT 'Date when the report was last certified by the data governance team.',
    `certified_flag` BOOLEAN COMMENT 'Indicates whether the report has been certified by data governance as meeting quality and accuracy standards.',
    `compliance_framework` STRING COMMENT 'Specific compliance framework or regulation that this report addresses (e.g., SOX, GDPR, FCC reporting).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this report definition record was first created in the system.',
    `data_steward_name` STRING COMMENT 'Full name of the data steward responsible for data quality and governance for this report.',
    `decommission_candidate_flag` BOOLEAN COMMENT 'Indicates whether the report has been flagged as a candidate for decommissioning due to low usage or redundancy.',
    `decommission_reason` STRING COMMENT 'Business justification for why the report is being or was decommissioned.',
    `effective_end_date` DATE COMMENT 'Date when this report definition was retired or decommissioned, null if still active.',
    `effective_start_date` DATE COMMENT 'Date when this report definition became active and available for use.',
    `export_formats` STRING COMMENT 'Comma-separated list of supported export formats (e.g., CSV, XLSX, PDF, PNG).',
    `filter_count` STRING COMMENT 'Number of user-configurable filters available in the report interface.',
    `impact_analysis_notes` STRING COMMENT 'Free-text notes documenting upstream data dependencies and potential impact of source data changes on this report.',
    `kpi_count` STRING COMMENT 'Number of distinct KPIs or metrics displayed in the report.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this report definition record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this report definition record was last updated.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Timestamp when the report data was last successfully refreshed from source systems.',
    `next_refresh_timestamp` TIMESTAMP COMMENT 'Scheduled timestamp for the next report data refresh execution.',
    `owning_business_unit` STRING COMMENT 'The business unit or department that owns and is responsible for the report content and governance.',
    `primary_data_source` STRING COMMENT 'The main data product or table that serves as the primary source for this report.',
    `publication_platform` STRING COMMENT 'The BI platform or tool where the report is published and made available to users.. Valid values are `databricks_sql|power_bi|tableau|qlik_sense|looker|custom`',
    `refresh_schedule` STRING COMMENT 'Frequency at which the report data is refreshed from source systems.. Valid values are `real_time|hourly|daily|weekly|monthly|on_demand`',
    `refresh_time` TIMESTAMP COMMENT 'Scheduled time of day when the report refresh job executes, in HH:MM format (24-hour).',
    `regulatory_body` STRING COMMENT 'Name of the regulatory authority or governing body that requires this report, if applicable.',
    `regulatory_flag` BOOLEAN COMMENT 'Indicates whether this report is required for regulatory compliance or external reporting obligations.',
    `report_category` STRING COMMENT 'Primary subject area or domain that the report addresses, aligned with enterprise data domains.. Valid values are `network_analytics|customer_analytics|revenue_analytics|operational_analytics|compliance_analytics|workforce_analytics`',
    `report_code` STRING COMMENT 'Unique business identifier code for the report, used for external references and API calls.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `report_description` STRING COMMENT 'Detailed description of the report purpose, business questions answered, and intended audience.',
    `report_name` STRING COMMENT 'Human-readable name of the BI report or dashboard as displayed to end users.',
    `report_status` STRING COMMENT 'Current lifecycle status of the report definition in the BI content governance process.. Valid values are `draft|active|deprecated|retired|under_review`',
    `report_type` STRING COMMENT 'Classification of the report by its primary business function and usage pattern.. Valid values are `operational_dashboard|executive_scorecard|ad_hoc_report|regulatory_report|kpi_dashboard|analytical_report`',
    `report_url` STRING COMMENT 'Direct URL link to access the published report in the BI platform.',
    `report_version` STRING COMMENT 'Semantic version number of the report definition following major.minor.patch convention.. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
    `retention_period_days` STRING COMMENT 'Number of days that historical versions of this report must be retained for audit and compliance purposes.',
    `secondary_data_sources` STRING COMMENT 'Comma-separated list of additional data products or tables consumed by this report.',
    `sla_load_time_seconds` DECIMAL(18,2) COMMENT 'Maximum acceptable load time in seconds as defined by the SLA for this report.',
    `supports_drill_down` BOOLEAN COMMENT 'Indicates whether the report supports drill-down navigation to more detailed data views.',
    `supports_export` BOOLEAN COMMENT 'Indicates whether users can export report data to external formats such as CSV, Excel, or PDF.',
    `unique_user_count_last_30_days` STRING COMMENT 'Number of distinct users who accessed the report in the last 30 days.',
    `usage_count_last_30_days` STRING COMMENT 'Number of times the report was accessed or viewed in the last 30 days, used for decommissioning decisions.',
    `visualization_count` STRING COMMENT 'Number of distinct visualizations (charts, tables, graphs) included in the report.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this report definition record.',
    CONSTRAINT pk_bi_report_definition PRIMARY KEY(`bi_report_definition_id`)
) COMMENT 'Master catalog of all Business Intelligence reports, dashboards, and self-service analytical views published across the telecommunications enterprise — the SSOT for BI content governance. Captures report name, report type (operational dashboard, executive scorecard, ad-hoc report, regulatory report), owning business unit, primary subject area, data sources consumed, refresh schedule, access tier (public, internal, restricted), certified status, and publication platform (Databricks SQL, Power BI, Tableau). Enables BI content lifecycle management, impact analysis for upstream data changes, and report decommissioning governance.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` (
    `network_analytics_kpi_id` BIGINT COMMENT 'Unique identifier for the network analytics KPI measurement record. Primary key for the network_analytics_kpi product.',
    `coverage_area_id` BIGINT COMMENT 'Foreign key linking to location.coverage_area. Business justification: Network KPIs must be associated with coverage footprints for regulatory compliance reporting (FCC coverage obligations), coverage quality analysis, and service level verification. Core requirement for',
    `fiber_cable_id` BIGINT COMMENT 'Foreign key linking to inventory.fiber_cable. Business justification: Fiber route performance KPIs (attenuation, availability, splice loss) are tracked for outside plant management, route diversity analysis, and infrastructure investment prioritization.',
    `ims_node_id` BIGINT COMMENT 'Foreign key linking to network.ims_node. Business justification: IMS node KPIs (registration success rate, call setup time, session capacity utilization, codec distribution) are essential for VoLTE/VoWiFi service quality monitoring. Voice service assurance dashboar',
    `spectrum_allocation_id` BIGINT COMMENT 'Foreign key linking to inventory.spectrum_allocation. Business justification: Spectrum efficiency KPIs (throughput per MHz, coverage quality, interference) are measured per licensed band for regulatory compliance reporting and spectrum optimization.',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key reference to the KPI definition catalog that describes the business meaning, calculation formula, and thresholds for this KPI.',
    `location_site_id` BIGINT COMMENT 'Foreign key linking to location.location_site. Business justification: Network KPIs are measured at physical cell sites/towers for performance monitoring, capacity planning, and site-level troubleshooting. Essential for network operations and site maintenance prioritizat',
    `mpls_tunnel_id` BIGINT COMMENT 'Foreign key linking to network.mpls_tunnel. Business justification: MPLS tunnel performance KPIs (bandwidth utilization, packet loss, latency, jitter) are measured per tunnel for IP/MPLS network assurance. Traffic engineering, QoS validation, and enterprise service SL',
    `element_id` BIGINT COMMENT 'Unique identifier of the network element (cell, site, eNodeB, gNodeB, base station, router, switch) that this KPI measurement pertains to. References the network inventory resource.',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: Network performance KPIs must link to specific equipment assets for fault correlation, capacity planning, lifecycle management, and vendor performance analysis - core network operations process.',
    `topology_id` BIGINT COMMENT 'Foreign key linking to network.topology. Business justification: Link-level performance KPIs (utilization, latency, packet loss, error rates) are measured per topology link for transport network monitoring. Network planning and SLA assurance require KPI tracking at',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: ONT-level KPIs (optical power, distance, uptime) are essential for GPON quality monitoring, subscriber experience assurance, and fiber access network troubleshooting.',
    `pipeline_run_id` BIGINT COMMENT 'Identifier of the data pipeline execution or ETL job run that processed and loaded this KPI measurement record. Supports data lineage and troubleshooting.',
    `pop_facility_id` BIGINT COMMENT 'Foreign key linking to inventory.pop_facility. Business justification: Facility-level KPIs (power usage effectiveness, environmental conditions, equipment density) are essential for data center operations, energy management, and site consolidation planning.',
    `sla_contract_id` BIGINT COMMENT 'Foreign key reference to the SLA contract that governs the performance thresholds and compliance requirements for this KPI measurement, if applicable.',
    `slice_id` BIGINT COMMENT 'Foreign key linking to network.network_slice. Business justification: 5G network slice KPIs (latency, throughput, reliability, UE count) are measured per slice instance for slice SLA monitoring and assurance. Enterprise slice customers and regulatory reporting require s',
    `transmission_link_id` BIGINT COMMENT 'Foreign key linking to network.transmission_link. Business justification: Transmission link KPIs (fiber attenuation, BER, availability, latency) are critical for backhaul and fronthaul monitoring. Lease cost optimization and SLA compliance reporting require performance metr',
    `prior_period_network_analytics_kpi_id` BIGINT COMMENT 'Self-referencing FK on network_analytics_kpi (prior_period_network_analytics_kpi_id)',
    `aggregation_function` STRING COMMENT 'The statistical aggregation function applied to raw measurements to produce this KPI value (sum, average, minimum, maximum, count, rate, percentile). [ENUM-REF-CANDIDATE: sum|avg|min|max|count|rate|percentile — 7 candidates stripped; promote to reference product]',
    `alarm_correlation_code` STRING COMMENT 'Correlation identifier linking this KPI measurement to related network alarms or fault events that may explain performance degradation.',
    `business_date` DATE COMMENT 'The business date (calendar date) to which this KPI measurement is attributed for reporting and analytics purposes, independent of the actual measurement timestamp.',
    `collection_method` STRING COMMENT 'The method by which the KPI measurement was collected from the network element (real-time streaming, batch file transfer, scheduled polling, on-demand query).. Valid values are `real_time|batch|scheduled|on_demand`',
    `counter_name` STRING COMMENT 'The vendor-specific or 3GPP-standard performance counter name from the network element that was used to derive this KPI measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this KPI measurement record was first inserted into the analytics data platform (audit trail for data lineage).',
    `data_completeness_flag` BOOLEAN COMMENT 'Boolean indicator whether the measurement period had complete data collection (True = complete, False = partial or missing data detected).',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Computed data quality score (0-100) for this KPI measurement based on completeness, timeliness, and consistency checks. Supports data quality monitoring and filtering.',
    `geographic_region_code` STRING COMMENT 'Code representing the geographic region, market, or administrative area where the network element is located (e.g., state, province, metro area code).',
    `kpi_category` STRING COMMENT 'The functional category or domain of the KPI (accessibility, retainability, mobility, integrity, availability, utilization) per 3GPP and TM Forum classification.. Valid values are `accessibility|retainability|mobility|integrity|availability|utilization`',
    `kpi_code` STRING COMMENT 'Standardized code or abbreviation for the KPI being measured (e.g., CSSR, DCR, HOSR, RSRP, RSRQ, PRB_UTIL, PKT_LOSS).',
    `kpi_name` STRING COMMENT 'Full descriptive name of the KPI being measured (e.g., Call Setup Success Rate, Drop Call Rate, Handover Success Rate, Reference Signal Received Power).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this KPI measurement record was last updated in the analytics data platform (audit trail for data lineage and reprocessing).',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the network element in decimal degrees (WGS84 datum). Enables geospatial analysis and heat mapping of network performance.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the network element in decimal degrees (WGS84 datum). Enables geospatial analysis and heat mapping of network performance.',
    `measured_value` DECIMAL(18,2) COMMENT 'The numeric value of the KPI measurement as observed during the measurement period. Precision supports both percentage KPIs and high-resolution throughput/signal measurements.',
    `measurement_granularity` STRING COMMENT 'The time granularity or aggregation period of the KPI measurement (raw event, 15-minute, hourly, daily, weekly, or monthly aggregation).. Valid values are `raw|15min|hourly|daily|weekly|monthly`',
    `measurement_period_end` TIMESTAMP COMMENT 'The end timestamp of the aggregation window for this KPI measurement (e.g., end of the hour for hourly KPIs).',
    `measurement_period_start` TIMESTAMP COMMENT 'The start timestamp of the aggregation window for this KPI measurement (e.g., start of the hour for hourly KPIs).',
    `measurement_status` STRING COMMENT 'The validation status of the KPI measurement (valid, suspect, invalid, estimated, missing) indicating data quality and reliability.. Valid values are `valid|suspect|invalid|estimated|missing`',
    `measurement_timestamp` TIMESTAMP COMMENT 'The exact date and time when the KPI measurement was captured by the network monitoring system. Represents the business event time of the observation.',
    `network_cluster_code` STRING COMMENT 'Identifier for the logical network cluster or zone that this network element belongs to for capacity planning and performance analysis purposes.',
    `network_element_type` STRING COMMENT 'The type or category of network element being measured (cell, site, eNodeB, gNodeB, base station, router, switch, BNG, BRAS, OLT, ONT). [ENUM-REF-CANDIDATE: cell|site|enodeb|gnodeb|base_station|router|switch|bng|bras|olt|ont — 11 candidates stripped; promote to reference product]',
    `nms_source_system` STRING COMMENT 'The Network Management System (NMS) or Element Management System (EMS) that collected and reported this KPI measurement (e.g., Nokia NetAct, Ericsson Network Manager).',
    `ran_type` STRING COMMENT 'The type of Radio Access Network (RAN) deployment for this network element (macro cell, micro cell, pico cell, femto cell, small cell, distributed antenna system).. Valid values are `macro|micro|pico|femto|small_cell|distributed_antenna`',
    `sample_count` BIGINT COMMENT 'The number of raw samples or events aggregated to produce this KPI measurement. Indicates statistical confidence of the measurement.',
    `severity_level` STRING COMMENT 'The severity classification of the KPI measurement or threshold breach (critical, major, minor, warning, normal) per ITU-T X.733 alarm severity model.. Valid values are `critical|major|minor|warning|normal`',
    `sla_applicable_flag` BOOLEAN COMMENT 'Boolean indicator whether this KPI measurement is subject to Service Level Agreement (SLA) compliance tracking and reporting (True = SLA-tracked, False = informational only).',
    `technology_generation` STRING COMMENT 'The network technology generation or standard applicable to this measurement (2G, 3G, 4G/LTE, 5G/5G NR, FTTH, GPON). [ENUM-REF-CANDIDATE: 2G|3G|4G|5G|LTE|5G_NR|FTTH|GPON — 8 candidates stripped; promote to reference product]',
    `threshold_breach_flag` BOOLEAN COMMENT 'Boolean indicator whether the measured value breached the defined threshold for this KPI (True = breach detected, False = within acceptable range).',
    `threshold_type` STRING COMMENT 'The type of threshold applied for breach detection (upper limit, lower limit, or acceptable range).. Valid values are `upper|lower|range`',
    `threshold_value` DECIMAL(18,2) COMMENT 'The threshold value that was compared against the measured value to determine breach status. For range thresholds, this represents the primary boundary.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the measured_value (percent, Mbps, dBm, dB, milliseconds, count, ratio, Erlang). [ENUM-REF-CANDIDATE: percent|mbps|dbm|db|ms|count|ratio|erlang — 8 candidates stripped; promote to reference product]',
    `vendor_name` STRING COMMENT 'Name of the equipment vendor or manufacturer for the network element (e.g., Nokia, Ericsson, Huawei, Cisco).',
    CONSTRAINT pk_network_analytics_kpi PRIMARY KEY(`network_analytics_kpi_id`)
) COMMENT 'Periodic network performance KPI measurement record at the cell, site, or network element grain — the SSOT for network analytics KPI time-series data in the Silver Layer. Captures measurement period (hourly, daily), network element reference, technology generation (2G/3G/4G/5G), KPI definition reference, measured value, unit, threshold breach flag, and geographic coordinates. Covers key telecom network KPIs: Call Setup Success Rate (CSSR), Drop Call Rate (DCR), Handover Success Rate (HOSR), RSRP/RSRQ signal quality, average user throughput (DL/UL), PRB utilization, and packet loss rate. Feeds network quality dashboards and capacity planning models.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` (
    `customer_analytics_kpi_id` BIGINT COMMENT 'Unique identifier for the customer analytics KPI measurement record. Primary key for the customer analytics KPI fact table.',
    `customer_account_id` BIGINT COMMENT 'Foreign key reference to the billing account for account-grain KPI measurements. Null for subscriber-level or segment-level aggregations.',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: CPE-related customer experience KPIs (device uptime, WiFi performance, firmware currency) drive satisfaction analysis, support optimization, and targeted device upgrade campaigns.',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key reference to the KPI catalog. Identifies the specific KPI being measured (e.g., ARPU, churn rate, NPS, CSAT, MAU, CLV).',
    `pipeline_run_id` BIGINT COMMENT 'The unique identifier of the data pipeline execution or ETL job that generated this KPI measurement. Enables traceability and lineage tracking.',
    `segment_definition_id` BIGINT COMMENT 'Foreign key reference to the customer segment dimension. Identifies the subscriber cohort, account tier, or market segment for which this KPI is measured (e.g., postpaid mobile, enterprise fiber, prepaid).',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Customer metrics are aggregated by service territory for regional performance management, franchise compliance reporting, and market-level P&L analysis. Standard practice in telecommunications operati',
    `sim_stock_id` BIGINT COMMENT 'Foreign key linking to inventory.sim_stock. Business justification: SIM activation velocity and provisioning time KPIs are tracked per inventory batch for fulfillment efficiency analysis and supplier performance management.',
    `subscriber_id` BIGINT COMMENT 'Foreign key reference to the individual subscriber for subscriber-grain KPI measurements. Null for account-level or segment-level aggregations.',
    `prior_period_customer_analytics_kpi_id` BIGINT COMMENT 'Self-referencing FK on customer_analytics_kpi (prior_period_customer_analytics_kpi_id)',
    `alert_severity` STRING COMMENT 'The severity level of the alert when alert_threshold_breached is true. Indicates the urgency of response required for out-of-threshold KPI values.. Valid values are `critical|high|medium|low|none`',
    `alert_threshold_breached` BOOLEAN COMMENT 'Boolean flag indicating whether this KPI measurement has breached a predefined alert threshold, triggering operational or management attention.',
    `benchmark_source` STRING COMMENT 'The source or provider of benchmark data when is_benchmark is true (e.g., GSMA Intelligence, Gartner, internal historical baseline). Null for non-benchmark measurements.',
    `business_date` DATE COMMENT 'The business calendar date for which this KPI measurement is reported. May differ from measurement_date in cases of late-arriving data or retroactive adjustments.',
    `calculation_method` STRING COMMENT 'The mathematical or statistical method used to derive this KPI value from source data. Ensures transparency and reproducibility of KPI calculations. [ENUM-REF-CANDIDATE: sum|average|median|count|ratio|percentage|weighted_average — 7 candidates stripped; promote to reference product]',
    `channel` STRING COMMENT 'The sales or distribution channel through which the customers measured by this KPI were acquired or are served. Enables channel performance analysis.. Valid values are `retail|online|telesales|partner|direct|indirect`',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'The lower bound of the 95% confidence interval for this KPI measurement. Used for statistical KPIs derived from sampling or survey data (e.g., NPS, CSAT).',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'The upper bound of the 95% confidence interval for this KPI measurement. Used for statistical KPIs derived from sampling or survey data (e.g., NPS, CSAT).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this KPI measurement record was first inserted into the Silver Layer. Used for data lineage and audit trail purposes.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A numeric score (0-100) representing the completeness and reliability of the source data used to calculate this KPI measurement. Lower scores indicate potential data quality issues affecting KPI accuracy.',
    `fiscal_period` STRING COMMENT 'The fiscal period identifier (e.g., FY2024-Q2, 2024-06) to which this KPI measurement belongs. Used for financial reporting alignment.',
    `is_benchmark` BOOLEAN COMMENT 'Boolean flag indicating whether this KPI measurement represents a benchmark or baseline value used for comparative analysis (e.g., industry benchmark, historical baseline).',
    `kpi_unit_of_measure` STRING COMMENT 'The unit in which the KPI value is expressed. Enables correct interpretation and display of the measured value.. Valid values are `currency|percentage|count|score|days|ratio`',
    `kpi_value` DECIMAL(18,2) COMMENT 'The measured numeric value of the KPI for this observation period. Interpretation depends on the KPI definition (e.g., currency for ARPU, percentage for churn rate, count for MAU, score for NPS).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this KPI measurement record was last updated in the Silver Layer. Tracks the most recent change to the record for audit and versioning purposes.',
    `measurement_date` DATE COMMENT 'The calendar date for which this KPI measurement applies. Used for day-level reporting and time-series analysis.',
    `measurement_frequency` STRING COMMENT 'The cadence at which this KPI is measured and reported. Defines the periodicity of the time-series data.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `measurement_grain` STRING COMMENT 'The level of aggregation or granularity at which this KPI measurement is captured. Indicates whether this is a subscriber-level, account-level, segment-level, or higher-level aggregation.. Valid values are `subscriber|account|segment|region|product|channel`',
    `measurement_timestamp` TIMESTAMP COMMENT 'The exact date and time when this KPI measurement was captured or calculated. Represents the business event time for the KPI observation.',
    `notes` STRING COMMENT 'Free-text field for capturing contextual notes, explanations, or caveats about this KPI measurement (e.g., data quality issues, one-time events affecting the metric, calculation adjustments).',
    `prior_period_value` DECIMAL(18,2) COMMENT 'The KPI value from the previous comparable measurement period (e.g., prior month, prior quarter, year-ago). Used for period-over-period variance analysis.',
    `product_line` STRING COMMENT 'The telecommunications product line or service category to which this KPI measurement applies. Enables product-specific performance tracking. [ENUM-REF-CANDIDATE: mobile|fixed_broadband|fiber|enterprise|iptv|ott|iot — 7 candidates stripped; promote to reference product]',
    `region_code` STRING COMMENT 'The geographic region or market code for which this KPI is measured. Enables regional performance comparison and market-specific analytics.',
    `sample_size` BIGINT COMMENT 'The number of underlying records, subscribers, or transactions used to calculate this KPI measurement. Provides context for statistical significance and confidence intervals.',
    `service_type` STRING COMMENT 'The billing or service model type for which this KPI is measured. Distinguishes between prepaid, postpaid, and enterprise customer analytics.. Valid values are `prepaid|postpaid|hybrid|enterprise|wholesale`',
    `source_system` STRING COMMENT 'The name or identifier of the operational system or data pipeline that provided the source data for this KPI calculation (e.g., Amdocs, Salesforce CRM, Netcracker).',
    `target_value` DECIMAL(18,2) COMMENT 'The planned or target value for this KPI in this measurement period, as defined by business planning or SLA commitments. Used for target vs actual variance analysis.',
    `target_variance_amount` DECIMAL(18,2) COMMENT 'The absolute difference between the measured KPI value and the target value (kpi_value minus target_value). Indicates performance against plan.',
    `target_variance_percentage` DECIMAL(18,2) COMMENT 'The percentage variance from target, calculated as ((kpi_value - target_value) / target_value) * 100. Null if target value is zero.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The absolute difference between the current KPI value and the prior period value (kpi_value minus prior_period_value). Positive indicates improvement for growth KPIs, negative for cost/churn KPIs.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The percentage change between the current KPI value and the prior period value, calculated as ((kpi_value - prior_period_value) / prior_period_value) * 100. Null if prior period value is zero.',
    CONSTRAINT pk_customer_analytics_kpi PRIMARY KEY(`customer_analytics_kpi_id`)
) COMMENT 'Periodic customer analytics KPI measurement record at the subscriber, account, or segment grain — the SSOT for customer analytics KPI time-series data in the Silver Layer. Captures measurement period, customer segment reference, KPI definition reference, measured value, and comparison to prior period. Covers key telecom customer KPIs: Monthly Active Users (MAU), Average Revenue Per User (ARPU), Average Revenue Per Account (ARPA), Net Promoter Score (NPS), Customer Satisfaction Score (CSAT), churn rate, retention rate, subscriber acquisition cost (SAC), and customer lifetime value (CLV). Feeds customer analytics dashboards and retention model inputs.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` (
    `revenue_analytics_kpi_id` BIGINT COMMENT 'Unique identifier for the revenue analytics KPI measurement record.',
    `administrative_region_id` BIGINT COMMENT 'Reference to the geographic region dimension for this revenue measurement (e.g., market, territory, country).',
    `channel_id` BIGINT COMMENT 'Reference to the sales or distribution channel dimension for this revenue measurement (e.g., direct, retail, online, partner).',
    `kpi_definition_id` BIGINT COMMENT 'Reference to the KPI definition that specifies the calculation formula, business description, and metadata for this measurement.',
    `line_id` BIGINT COMMENT 'Reference to the product line dimension for which this revenue KPI is measured (e.g., wireless, broadband, fiber, IPTV).',
    `segment_definition_id` BIGINT COMMENT 'Reference to the customer segment dimension for this revenue measurement (e.g., consumer, enterprise, small business).',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Revenue reporting by territory is fundamental for P&L management, franchise fee calculation, regional sales performance tracking, and market investment decisions. Already has region_id; territory prov',
    `prior_period_revenue_analytics_kpi_id` BIGINT COMMENT 'Self-referencing FK on revenue_analytics_kpi (prior_period_revenue_analytics_kpi_id)',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any manual or automated adjustment applied to the measured value to account for known anomalies, corrections, or business rules.',
    `adjustment_reason` STRING COMMENT 'Business justification or explanation for any adjustment applied to the measured value.',
    `approval_timestamp` TIMESTAMP COMMENT 'The timestamp when this KPI measurement was approved for official reporting and financial planning use.',
    `approved_by` STRING COMMENT 'The name or identifier of the business user or role who approved this KPI measurement for reporting and decision-making.',
    `budget_target_value` DECIMAL(18,2) COMMENT 'The budgeted or planned target value for this KPI in this period and dimension combination.',
    `business_date` DATE COMMENT 'The business effective date for this KPI measurement, which may differ from the measurement timestamp for backdated or forward-dated calculations.',
    `calculation_run_code` STRING COMMENT 'The unique identifier of the batch or pipeline run that calculated this KPI measurement, enabling traceability and reprocessing.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this revenue analytics KPI record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for monetary KPI values (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A quality score (0-100) indicating the completeness and accuracy of the source data used to calculate this KPI measurement.',
    `fiscal_month` STRING COMMENT 'The fiscal month (1-12) to which this KPI measurement belongs within the fiscal year.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter (1-4) to which this KPI measurement belongs within the fiscal year.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this KPI measurement belongs, supporting fiscal period reporting and analysis.',
    `is_outlier` BOOLEAN COMMENT 'Flag indicating whether this KPI measurement has been identified as a statistical outlier requiring investigation or special handling.',
    `kpi_status` STRING COMMENT 'The status of this KPI measurement indicating whether it is final, preliminary, estimated, revised, forecasted, or cancelled.. Valid values are `final|preliminary|estimated|revised|forecasted|cancelled`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this revenue analytics KPI record was last updated or modified.',
    `measured_value` DECIMAL(18,2) COMMENT 'The actual measured value of the KPI for this period and dimension combination. Unit of measure is defined in the KPI definition.',
    `measurement_granularity` STRING COMMENT 'The time granularity at which this KPI measurement was aggregated (daily, weekly, monthly, quarterly, yearly).. Valid values are `daily|weekly|monthly|quarterly|yearly`',
    `measurement_period_end_date` DATE COMMENT 'The end date of the period for which this KPI measurement was calculated.',
    `measurement_period_start_date` DATE COMMENT 'The start date of the period for which this KPI measurement was calculated.',
    `measurement_timestamp` TIMESTAMP COMMENT 'The precise timestamp when this KPI measurement was calculated and recorded.',
    `notes` STRING COMMENT 'Free-text notes or commentary providing additional context, explanations, or business insights about this KPI measurement.',
    `outlier_reason` STRING COMMENT 'Explanation or categorization of why this measurement was flagged as an outlier (e.g., one-time event, data quality issue, business exception).',
    `prior_period_value` DECIMAL(18,2) COMMENT 'The measured value of this KPI from the equivalent prior period (e.g., prior month, prior quarter, prior year) for trend comparison.',
    `source_system` STRING COMMENT 'The name or identifier of the source system from which the underlying revenue data was extracted (e.g., Amdocs Revenue Management, SAP S/4HANA).',
    `variance_to_budget` DECIMAL(18,2) COMMENT 'The difference between the measured value and the budget target value (measured_value minus budget_target_value).',
    `variance_to_budget_percentage` DECIMAL(18,2) COMMENT 'The percentage variance between measured value and budget target, calculated as ((measured_value - budget_target_value) / budget_target_value) * 100.',
    `variance_to_prior_period` DECIMAL(18,2) COMMENT 'The difference between the measured value and the prior period value (measured_value minus prior_period_value).',
    `variance_to_prior_period_percentage` DECIMAL(18,2) COMMENT 'The percentage variance between measured value and prior period value, calculated as ((measured_value - prior_period_value) / prior_period_value) * 100.',
    CONSTRAINT pk_revenue_analytics_kpi PRIMARY KEY(`revenue_analytics_kpi_id`)
) COMMENT 'Periodic revenue analytics KPI measurement record at the product, segment, channel, or geography grain — the SSOT for revenue analytics KPI time-series data in the Silver Layer. Captures measurement period, business dimension references (product line, channel, region), KPI definition reference, measured value, budget target, variance to budget, and prior period comparison. Covers key telecom revenue KPIs: Total Revenue, Service Revenue, EBITDA, EBITDA margin, blended ARPU, data revenue per GB, roaming revenue, interconnect revenue, and revenue per subscriber. Feeds CFO revenue dashboards and financial planning models.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`segment_definition` (
    `segment_definition_id` BIGINT COMMENT 'Unique identifier for the customer or market segment definition. Primary key for the segment definition catalog.',
    `geographic_zone_id` BIGINT COMMENT 'Foreign key linking to location.geographic_zone. Business justification: Customer segments are often defined with geographic constraints (urban/rural, regulatory zones, roaming zones) for targeted marketing campaigns, service design, and pricing strategies. Standard segmen',
    `parent_segment_segment_definition_id` BIGINT COMMENT 'Reference to a parent segment if this segment is a sub-segment or refinement of a broader segment definition, enabling hierarchical segment taxonomies.',
    `parent_segment_definition_id` BIGINT COMMENT 'Self-referencing FK on segment_definition (parent_segment_definition_id)',
    `actual_population_size` BIGINT COMMENT 'Current count of customers or accounts that match the segment definition criteria as of the last refresh.',
    `approval_status` STRING COMMENT 'Governance approval status for this segment definition: pending (awaiting review), approved (ready for production use), or rejected (not approved for use).. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this segment definition was approved for production use.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this segment definition for production use.',
    `associated_campaign_ids` STRING COMMENT 'Comma-separated list of marketing campaign IDs that target this segment, enabling campaign performance tracking by segment.',
    `associated_report_ids` STRING COMMENT 'Comma-separated list of report or dashboard IDs that use this segment for filtering, grouping, or analysis.',
    `business_objective` STRING COMMENT 'Strategic business objective this segment supports (e.g., reduce churn, increase ARPU, drive 5G adoption, improve NPS, expand enterprise market share).',
    `business_owner_name` STRING COMMENT 'Name of the individual business owner or sponsor accountable for this segment definition and its business outcomes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this segment definition record was first created in the system.',
    `data_source_system` STRING COMMENT 'Primary operational system or data platform from which segment membership data is derived (e.g., Salesforce CRM, Amdocs, Netcracker, Data Lake).',
    `data_source_table` STRING COMMENT 'Specific table, view, or dataset in the source system that provides the data for segment membership calculation.',
    `data_steward_name` STRING COMMENT 'Name of the data steward responsible for data quality, governance, and compliance for this segment definition.',
    `definition_criteria` STRING COMMENT 'SQL predicate, rule expression, or business logic defining membership in this segment. May reference customer attributes, usage patterns, billing history, or network behavior.',
    `effective_end_date` DATE COMMENT 'Date when this segment definition expires or is no longer valid. Null indicates an open-ended segment with no planned expiration.',
    `effective_start_date` DATE COMMENT 'Date when this segment definition became or will become active and available for use in analytics and reporting.',
    `is_default_segment` BOOLEAN COMMENT 'Indicates whether this is a default or catch-all segment for customers who do not match any other segment criteria.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this segment definition record was last updated or modified.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Date and time when the segment membership was last recalculated and refreshed.',
    `last_review_date` DATE COMMENT 'Date when this segment definition was last reviewed for accuracy, relevance, and alignment with business objectives.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this segment definition to ensure continued relevance and accuracy.',
    `next_scheduled_refresh_timestamp` TIMESTAMP COMMENT 'Date and time when the segment is scheduled for its next automatic refresh.',
    `owning_analytics_team` STRING COMMENT 'Name of the analytics team or business unit responsible for defining, maintaining, and governing this segment.',
    `privacy_consent_required` BOOLEAN COMMENT 'Indicates whether explicit customer consent is required before including them in this segment for marketing or personalization purposes.',
    `refresh_frequency` STRING COMMENT 'How often the segment membership is recalculated and updated: real-time (streaming), hourly, daily, weekly, monthly, quarterly, or on-demand (manual trigger). [ENUM-REF-CANDIDATE: real-time|hourly|daily|weekly|monthly|quarterly|on-demand — 7 candidates stripped; promote to reference product]',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this segment definition must comply with specific regulatory requirements (e.g., GDPR consent for marketing segments, FCC requirements for service quality segments).',
    `segment_category` STRING COMMENT 'High-level business domain this segment applies to: customer segmentation, market segmentation, product affinity, network usage, revenue tier, or churn risk.. Valid values are `customer|market|product|network|revenue|churn`',
    `segment_code` STRING COMMENT 'Short alphanumeric code used to reference the segment in operational systems and reports.',
    `segment_description` STRING COMMENT 'Detailed business description of the segment, including its purpose, target audience characteristics, and intended use cases.',
    `segment_name` STRING COMMENT 'Business-friendly name of the segment (e.g., High-Value Postpaid, At-Risk Prepaid, Enterprise SME, Youth Digital Native, Roaming Frequent Traveler, Fiber Early Adopter).',
    `segment_status` STRING COMMENT 'Current lifecycle status of the segment definition: active (in use), inactive (temporarily disabled), draft (under development), under_review (pending approval), deprecated (being phased out), or archived (historical reference only).. Valid values are `active|inactive|draft|under_review|deprecated|archived`',
    `segment_type` STRING COMMENT 'Classification of the segmentation approach: demographic (age, gender), behavioral (usage patterns), value-based (ARPU, CLTV), lifecycle (new, mature, at-risk), geographic (region, urban/rural), or technographic (device, network preference).. Valid values are `demographic|behavioral|value-based|lifecycle|geographic|technographic`',
    `supports_personalization` BOOLEAN COMMENT 'Indicates whether this segment is used for personalized marketing, offers, or customer experience customization.',
    `supports_predictive_analytics` BOOLEAN COMMENT 'Indicates whether this segment is used in predictive models for churn prediction, upsell propensity, or other AI/ML applications.',
    `tags` STRING COMMENT 'Comma-separated list of business tags or labels for categorizing and searching segments (e.g., high-value, at-risk, 5G, enterprise, prepaid, postpaid).',
    `target_arpu` DECIMAL(18,2) COMMENT 'Target or expected Average Revenue Per User for customers in this segment, used for revenue forecasting and performance tracking.',
    `target_churn_rate_percentage` DECIMAL(18,2) COMMENT 'Target or acceptable monthly churn rate percentage for customers in this segment, used for retention strategy and performance monitoring.',
    `target_cltv` DECIMAL(18,2) COMMENT 'Target or expected Customer Lifetime Value for customers in this segment, representing the total revenue expected over the customer relationship.',
    `target_nps_score` STRING COMMENT 'Target Net Promoter Score for customers in this segment, measuring customer satisfaction and loyalty on a scale from -100 to +100.',
    `target_population_size` BIGINT COMMENT 'Expected or target number of customers or accounts that should fall into this segment based on the definition criteria.',
    `usage_notes` STRING COMMENT 'Free-text field for documenting best practices, known limitations, data quality considerations, or special instructions for using this segment.',
    `version_number` STRING COMMENT 'Version identifier for this segment definition, supporting change tracking and historical analysis of segment evolution.',
    CONSTRAINT pk_segment_definition PRIMARY KEY(`segment_definition_id`)
) COMMENT 'Master catalog of all customer and market segment definitions used across the telecommunications analytics platform — the SSOT for segmentation taxonomy. Captures segment name, segment type (demographic, behavioral, value-based, lifecycle, geographic, technographic), definition criteria (SQL predicate or rule expression), target population size, refresh frequency, owning analytics team, and associated KPI targets. Covers telecom-specific segments: High-Value Postpaid, At-Risk Prepaid, Enterprise SME, Youth Digital Native, Roaming Frequent Traveler, and Fiber Early Adopter. Distinct from customer.customer_account which holds individual account records.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` (
    `analytics_segment_membership_id` BIGINT COMMENT 'Unique identifier for the segment membership record. Primary key for the segment membership association.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing or retention campaign that triggered or is associated with this segment membership. Links segment assignment to campaign execution.',
    `employee_id` BIGINT COMMENT 'Identifier of the business user or analyst who performed the manual override. Supports audit trail and accountability for manual segment adjustments.',
    `model_run_id` BIGINT COMMENT 'Identifier of the analytical model execution run that produced this segment membership assignment. Enables traceability to the specific model version and execution batch.',
    `segment_definition_id` BIGINT COMMENT 'Reference to the segment definition that defines the criteria and business rules for this segment. Links to the segment definition master record.',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Tracks which territory a customer belongs to at segment assignment time for territory-based campaign execution, sales credit allocation, and regional offer eligibility. Essential for field sales and t',
    `subscriber_id` BIGINT COMMENT 'Reference to the individual subscriber assigned to this segment. Links to the subscriber master record.',
    `superseded_analytics_segment_membership_id` BIGINT COMMENT 'Self-referencing FK on analytics_segment_membership (superseded_analytics_segment_membership_id)',
    `assignment_date` DATE COMMENT 'Date when the subscriber or account was assigned to this segment. Represents the business effective date of the segment membership.',
    `assignment_method` STRING COMMENT 'Method by which the subscriber or account was assigned to this segment. Indicates whether assignment was rule-based, machine learning model-driven, manually overridden by an analyst, or triggered by a real-time event.. Valid values are `rule_based|ml_model|manual_override|batch_process|real_time_event|api_trigger`',
    `assignment_reason_code` STRING COMMENT 'Code indicating the primary reason or trigger for this segment assignment. Examples include behavioral trigger, demographic match, usage pattern, churn risk, or campaign eligibility.',
    `assignment_reason_description` STRING COMMENT 'Detailed textual description explaining why the subscriber or account was assigned to this segment. Provides business context for the assignment decision.',
    `assignment_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the segment membership assignment was created in the system. Captures the exact moment of assignment for audit and sequencing purposes.',
    `business_date` DATE COMMENT 'Business date for which this segment membership is effective. Used for batch processing and point-in-time reporting. May differ from assignment timestamp for backdated assignments.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Confidence score assigned by the machine learning model for this segment membership assignment. Range 0.0000 to 1.0000. Higher values indicate greater model confidence. Null for non-ML assignments.',
    `consent_status` STRING COMMENT 'Status of the subscriber or account consent for marketing communications related to this segment. Ensures compliance with privacy regulations such as GDPR and CPNI.. Valid values are `granted|denied|pending|withdrawn|expired|not_required`',
    `consent_timestamp` TIMESTAMP COMMENT 'Timestamp when marketing consent was granted or last updated for this segment membership. Supports regulatory compliance and audit requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment membership record was first created in the lakehouse. Supports data lineage tracking and audit trail.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Data quality score for the input data used to assign this segment membership. Range 0.0000 to 1.0000. Higher values indicate better data completeness and accuracy for the assignment decision.',
    `effective_end_date` DATE COMMENT 'Date when this segment membership expires or is no longer effective. Null indicates an open-ended membership. Supports temporal segment membership tracking.',
    `effective_start_date` DATE COMMENT 'Date from which this segment membership becomes effective for business purposes. Enables point-in-time segment membership queries and historical analysis.',
    `evaluation_frequency` STRING COMMENT 'Frequency at which this segment membership is evaluated or refreshed. Indicates whether the segment is updated in real-time, on a scheduled batch basis, or triggered by specific events. [ENUM-REF-CANDIDATE: real_time|daily|weekly|monthly|quarterly|on_demand|event_driven — 7 candidates stripped; promote to reference product]',
    `exclusion_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this record represents an exclusion from the segment rather than an inclusion. True when the subscriber or account is explicitly excluded from segment-based campaigns.',
    `exclusion_reason` STRING COMMENT 'Textual explanation for why the subscriber or account was excluded from this segment. Examples include opt-out preference, regulatory restriction, or business rule violation.',
    `expiry_date` DATE COMMENT 'Scheduled expiration date for this segment membership. Used for time-bound segments such as promotional campaigns or seasonal cohorts. Null indicates no scheduled expiry.',
    `is_primary_segment` BOOLEAN COMMENT 'Boolean flag indicating whether this is the primary or dominant segment for the subscriber or account. True when this segment takes precedence over other concurrent segment memberships.',
    `last_evaluation_date` DATE COMMENT 'Date when this segment membership was last evaluated or refreshed by the segmentation engine. Indicates recency of the membership assessment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment membership record was last updated or modified. Enables change tracking and incremental processing.',
    `membership_status` STRING COMMENT 'Current lifecycle status of the segment membership assignment. Indicates whether the membership is currently active, has expired, or has been suspended or revoked.. Valid values are `active|inactive|pending|expired|suspended|revoked`',
    `model_version` STRING COMMENT 'Version identifier of the machine learning or analytical model that generated this segment assignment. Supports model lineage tracking and A/B testing analysis.',
    `next_evaluation_date` DATE COMMENT 'Scheduled date for the next evaluation or refresh of this segment membership. Used for proactive segment maintenance and recalculation scheduling.',
    `notes` STRING COMMENT 'Free-form textual notes or comments about this segment membership. Captures additional context, special handling instructions, or analyst observations.',
    `override_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this segment membership was manually overridden by a business user or analyst. True when assignment was manually adjusted rather than system-generated.',
    `override_reason` STRING COMMENT 'Textual explanation for why this segment membership was manually overridden. Captures business justification for deviating from automated assignment logic.',
    `override_timestamp` TIMESTAMP COMMENT 'Timestamp when the manual override was applied. Captures the exact moment of manual intervention for audit purposes.',
    `priority_rank` STRING COMMENT 'Priority ranking of this segment membership when a subscriber or account belongs to multiple segments simultaneously. Lower numbers indicate higher priority for campaign targeting and personalization.',
    `propensity_score` DECIMAL(18,2) COMMENT 'Propensity or likelihood score indicating the strength of fit between the subscriber or account and the segment characteristics. Range 0.0000 to 1.0000. Used for ranking and prioritization in campaign targeting.',
    `segment_entry_channel` STRING COMMENT 'Channel or touchpoint through which the subscriber or account entered this segment. Examples include web, mobile app, call center, retail store, or automated batch process.',
    `source_record_reference` STRING COMMENT 'Unique identifier of this segment membership record in the source system. Enables traceability and reconciliation with upstream systems.',
    `source_system` STRING COMMENT 'Name or identifier of the source system that generated this segment membership record. Examples include CRM, analytics platform, or marketing automation system.',
    `tags` STRING COMMENT 'Comma-separated list of custom tags or labels applied to this segment membership for flexible categorization and filtering. Supports ad-hoc analysis and campaign targeting.',
    CONSTRAINT pk_analytics_segment_membership PRIMARY KEY(`analytics_segment_membership_id`)
) COMMENT 'Association record linking individual subscriber or account identities to their assigned analytical segments for a given effective period. Captures subscriber or account reference, segment definition reference, assignment date, expiry date, assignment method (rule-based, ML model, manual override), confidence score (for ML-assigned segments), and the model run that produced the assignment. Enables point-in-time segment membership queries for campaign targeting, personalization, and cohort analysis. Distinct from the segment_definition which defines the segment criteria — this is the instance-level membership roster.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` (
    `analytical_dataset_id` BIGINT COMMENT 'Unique identifier for the analytical dataset record within the Databricks Lakehouse registry.',
    `analytical_subject_area_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_subject_area. Business justification: Analytical datasets belong to analytical subject areas (data marts). One dataset belongs to ONE subject area; one subject area contains MANY datasets. This establishes the organizational ownership and',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Dataset ownership for data product accountability, SLA management, and access governance in telecommunications analytics platforms. Owner responsible for dataset quality, documentation, and consumer s',
    `fiber_cable_id` BIGINT COMMENT 'Foreign key linking to inventory.fiber_cable. Business justification: Fiber infrastructure data is foundational for outside plant analytics, route diversity analysis, capital planning datasets, and fiber-to-the-home expansion modeling.',
    `spectrum_allocation_id` BIGINT COMMENT 'Foreign key linking to inventory.spectrum_allocation. Business justification: Spectrum holdings are critical dimension in network capacity datasets for coverage analysis, 5G deployment planning, and regulatory compliance reporting.',
    `ip_address_pool_id` BIGINT COMMENT 'Foreign key linking to inventory.ip_address_pool. Business justification: IP resource inventory is dimension in network analytics for address space utilization tracking, IPv6 adoption analysis, and CGNAT capacity planning.',
    `network_equipment_id` BIGINT COMMENT 'Foreign key linking to inventory.network_equipment. Business justification: Equipment inventory is a core dimension in analytical datasets for network capacity analysis, vendor performance benchmarking, and technology refresh planning.',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: ONT inventory is key dimension in fiber subscriber analytics for technology adoption tracking, service tier analysis, and GPON-to-XGS-PON migration planning.',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Analytical datasets for territory-specific analysis (market studies, regional forecasting, competitive analysis) are scoped to territories. Supports decentralized analytics and regional data product o',
    `spare_part_id` BIGINT COMMENT 'Foreign key linking to inventory.spare_part. Business justification: Spare parts inventory is dimension in maintenance analytics for stock optimization, supplier performance analysis, equipment reliability studies, and maintenance cost allocation.',
    `derived_from_analytical_dataset_id` BIGINT COMMENT 'Self-referencing FK on analytical_dataset (derived_from_analytical_dataset_id)',
    `access_classification_level` STRING COMMENT 'Data classification level governing access controls and usage restrictions: public (unrestricted), internal (employees only), confidential (business-sensitive), or restricted (PII/PHI/PCI, requires special authorization).. Valid values are `public|internal|confidential|restricted`',
    `approval_date` DATE COMMENT 'Date when the analytical dataset received formal approval for production deployment, establishing the baseline for version control and change management.',
    `approval_status` STRING COMMENT 'Current approval state of the analytical dataset in the data governance workflow: draft (under development), pending_review (awaiting steward approval), approved (production-ready), or rejected (does not meet quality standards).. Valid values are `draft|pending_review|approved|rejected`',
    `approved_by` STRING COMMENT 'Name of the data steward, governance committee member, or technical authority who approved this analytical dataset for production use.',
    `business_purpose` STRING COMMENT 'Detailed description of the business use case, analytical objective, or decision-support function this dataset enables (e.g., Predict customer churn risk for retention campaigns, Aggregate network KPIs for NOC dashboards, Calculate ARPU trends by customer segment).',
    `column_count` STRING COMMENT 'Total number of columns (attributes/features) in the analytical dataset schema, used for schema complexity assessment and feature engineering tracking.',
    `consumer_count` STRING COMMENT 'Number of distinct downstream consumers (users, teams, applications, dashboards, ML models) actively using this analytical dataset, indicating business criticality and impact radius.',
    `contains_pii_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether the dataset contains personally identifiable information subject to GDPR, CCPA, or other privacy regulations, triggering additional access controls and audit requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the analytical dataset registry record was first created in the metadata catalog, supporting audit trail and lifecycle tracking.',
    `data_freshness_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when the dataset was last refreshed or updated with new data, critical for assessing data currency and SLA compliance for time-sensitive analytics.',
    `data_steward` STRING COMMENT 'Name of the data steward or governance representative responsible for ensuring this dataset complies with data quality standards, retention policies, and regulatory requirements.',
    `dataset_category` STRING COMMENT 'Business domain or analytical category this dataset supports: network analytics (RAN, transport, core performance), customer analytics (segmentation, behavior, CLTV), revenue analytics (ARPU, MRR, billing trends), churn prediction, usage analytics (CDR aggregations), or quality analytics (QoS, SLA compliance).. Valid values are `network_analytics|customer_analytics|revenue_analytics|churn_prediction|usage_analytics|quality_analytics`',
    `dataset_code` STRING COMMENT 'Unique business identifier or code assigned to the analytical dataset for reference in data catalogs, lineage tools, and analytics platforms.',
    `dataset_name` STRING COMMENT 'Human-readable name of the analytical dataset, following organizational naming conventions for feature tables, training datasets, scoring datasets, or reporting datasets.',
    `dataset_size_gb` DECIMAL(18,2) COMMENT 'Total storage size of the analytical dataset in gigabytes, used for capacity planning, cost allocation, and performance optimization.',
    `dataset_type` STRING COMMENT 'Classification of the analytical dataset by its primary purpose: training (ML model training), scoring (inference/prediction), reporting (BI dashboards), feature_table (reusable feature store), ad_hoc (one-time analysis), or exploratory (data discovery).. Valid values are `training|scoring|reporting|feature_table|ad_hoc|exploratory`',
    `delta_table_path` STRING COMMENT 'Fully qualified path to the Delta Lake table in the Databricks Lakehouse (e.g., dbfs:/mnt/silver/analytics/customer_churn_features), enabling direct access for queries and pipelines.',
    `documentation_url` STRING COMMENT 'URL link to detailed technical and business documentation for the analytical dataset, including schema definitions, data dictionary, usage examples, and known limitations.',
    `effective_end_date` DATE COMMENT 'Date when the analytical dataset is scheduled for deprecation or retirement, after which it will no longer be maintained or supported (nullable for active datasets with no planned end date).',
    `effective_start_date` DATE COMMENT 'Date when the analytical dataset became available for consumption, marking the beginning of its operational lifecycle.',
    `feature_count` STRING COMMENT 'Number of engineered features or derived attributes in the dataset specifically designed for machine learning model training or scoring, distinct from raw operational columns.',
    `grain_description` STRING COMMENT 'Textual description of the dataset grain or level of detail, specifying what each row represents (e.g., One row per customer per month, One row per cell site per hour, One row per subscriber per day with aggregated CDR metrics).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the analytical dataset metadata record, tracking changes to ownership, classification, documentation, or other registry attributes.',
    `last_schema_change_date` DATE COMMENT 'Date of the most recent schema modification (column addition, removal, or type change), used to track schema evolution and assess impact on downstream consumers.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the analytical dataset: active (in production use), deprecated (scheduled for retirement), archived (historical reference only), in_development (under construction), retired (no longer available), or suspended (temporarily unavailable).. Valid values are `active|deprecated|archived|in_development|retired|suspended`',
    `owning_team` STRING COMMENT 'Name of the analytics, data engineering, or business intelligence team responsible for developing, maintaining, and supporting this analytical dataset.',
    `partition_key` STRING COMMENT 'Column name(s) used for Delta Lake table partitioning (e.g., business_date, region_code), optimizing query performance and data management operations.',
    `platform_layer` STRING COMMENT 'Databricks Lakehouse medallion architecture layer where the dataset resides: silver (cleansed, conformed, joined data) or gold (business-level aggregates, curated for analytics and ML).. Valid values are `silver|gold`',
    `primary_consumer_group` STRING COMMENT 'Name of the primary business unit, analytics team, or application consuming this dataset (e.g., Network Operations Center, Customer Retention Team, Revenue Assurance), used for prioritization and communication.',
    `primary_source_system` STRING COMMENT 'Name of the primary operational system of record providing the majority of data for this dataset (e.g., Amdocs Revenue Management, Nokia NetAct, Salesforce CRM), used for data stewardship and issue escalation.',
    `refresh_schedule` STRING COMMENT 'Frequency at which the analytical dataset is refreshed: real_time (streaming/continuous), hourly, daily, weekly, monthly, or on_demand (manual/ad-hoc refresh).. Valid values are `real_time|hourly|daily|weekly|monthly|on_demand`',
    `regulatory_scope` STRING COMMENT 'Comma-separated list of applicable regulatory frameworks or compliance requirements this dataset must adhere to (e.g., GDPR, FCC, 3GPP, TM Forum SID), guiding retention, access, and audit policies.',
    `retention_policy_days` STRING COMMENT 'Number of days the analytical dataset is retained before archival or deletion, driven by regulatory requirements, storage cost optimization, and business value decay.',
    `row_count` BIGINT COMMENT 'Total number of rows (records) in the analytical dataset as of the last refresh or metadata update, used for dataset size monitoring and capacity planning.',
    `schema_version` STRING COMMENT 'Version identifier for the dataset schema (e.g., v1.2.3, 2024-01), tracking schema evolution and ensuring compatibility with downstream consumers.',
    `sla_availability_target_pct` DECIMAL(18,2) COMMENT 'Target availability percentage for the analytical dataset (e.g., 99.50), defining the uptime commitment for downstream consumers and triggering alerts when breached.',
    `sla_refresh_target_minutes` STRING COMMENT 'Maximum allowable time in minutes between dataset refresh completion and data availability to consumers, ensuring timely delivery for time-sensitive analytics and reporting.',
    `source_lineage_summary` STRING COMMENT 'High-level summary of upstream data sources and transformations that produce this dataset (e.g., Derived from bronze.cdr_events, bronze.customer_master, silver.network_kpi via aggregation pipeline job_123), supporting impact analysis and data governance.',
    `source_system_count` STRING COMMENT 'Number of distinct source systems or upstream datasets contributing data to this analytical dataset, indicating integration complexity.',
    `tags` STRING COMMENT 'Comma-separated list of user-defined tags or labels for dataset categorization, search, and filtering (e.g., churn, customer, ml_ready, high_priority), supporting data discovery and catalog organization.',
    `usage_notes` STRING COMMENT 'Free-text field capturing important usage guidance, known limitations, data quality caveats, or special handling instructions for consumers of this analytical dataset.',
    CONSTRAINT pk_analytical_dataset PRIMARY KEY(`analytical_dataset_id`)
) COMMENT 'Master registry of all curated analytical datasets (feature tables, training datasets, scoring datasets) managed within the Databricks Lakehouse Silver and Gold layers for the telecommunications analytics platform. Captures dataset name, purpose (training, scoring, reporting, ad-hoc), grain description, row count, column count, Delta table path, schema version, data freshness timestamp, source lineage summary, owning team, access classification, and retention policy. Provides the data catalog entry for all analytics-ready datasets, enabling data discovery and reuse across analytical teams.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` (
    `pipeline_run_id` BIGINT COMMENT 'Unique identifier for each pipeline execution instance in the Databricks Lakehouse analytics platform. Primary key for the pipeline run operational metadata.',
    `parent_pipeline_run_id` BIGINT COMMENT 'Reference to the parent pipeline run that triggered this execution, if this pipeline is part of a multi-stage workflow. Null for standalone pipelines. Used for dependency tracking and workflow lineage.',
    `retry_of_pipeline_run_id` BIGINT COMMENT 'Self-referencing FK on pipeline_run (retry_of_pipeline_run_id)',
    `business_date` DATE COMMENT 'Logical business date for which the pipeline processed data, independent of the actual execution timestamp. Used for partitioning and time-based analytics. Format: yyyy-MM-dd.',
    `bytes_processed` BIGINT COMMENT 'Total volume of data processed by the pipeline in bytes. Used for cost analysis, capacity planning, and performance optimization.',
    `bytes_written` BIGINT COMMENT 'Total volume of data written to the target destination in bytes. Used for storage cost tracking and compression ratio analysis.',
    `compute_cost_usd` DECIMAL(18,2) COMMENT 'Estimated compute cost for this pipeline execution in USD, based on cluster type, runtime duration, and Databricks pricing. Used for cost allocation and budget tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this pipeline run record was first created in the operational metadata store. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_freshness_sla_minutes` STRING COMMENT 'Target maximum age of data in minutes as defined by the SLA. Used to determine if pipeline execution met freshness requirements for downstream analytics and reporting.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Overall data quality score for this pipeline execution, expressed as a percentage (0-100). Calculated based on validation rules, completeness checks, and accuracy metrics.',
    `databricks_cluster_code` STRING COMMENT 'Identifier of the Databricks compute cluster that executed the pipeline. Used for cost allocation and resource utilization analysis.',
    `databricks_job_run_code` BIGINT COMMENT 'Native Databricks job run identifier assigned by the platform. Used for linking to Databricks UI and API for detailed execution logs and cluster metrics.',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Total elapsed time for the pipeline execution in seconds. Calculated as end_timestamp minus start_timestamp. Used for performance monitoring and capacity planning.',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the pipeline execution completed or terminated. Null if pipeline is still running. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `error_code` STRING COMMENT 'Standardized error code or exception type for categorizing pipeline failures. Enables automated alerting and error pattern analysis.',
    `error_message` STRING COMMENT 'Detailed error message or exception text captured when the pipeline execution failed. Used for root cause analysis and troubleshooting. Null if execution was successful.',
    `execution_mode` STRING COMMENT 'Processing mode used by the pipeline: full_load (complete dataset refresh), incremental (new and changed records only), delta (change data capture), backfill (historical data load), or reprocess (re-execution of previously processed data).. Valid values are `full_load|incremental|delta|backfill|reprocess`',
    `execution_status` STRING COMMENT 'Current state of the pipeline run: success (completed without errors), failed (terminated with errors), partial (completed with warnings or partial data), running (currently executing), cancelled (user-terminated), or timeout (exceeded maximum duration).. Valid values are `success|failed|partial|running|cancelled|timeout`',
    `initiated_by` STRING COMMENT 'Username or system account that initiated the pipeline execution. Used for audit trail and access control analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this pipeline run record was last updated. Used for tracking status changes and audit trail. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether automated notifications (email, Slack, PagerDuty) were sent for this pipeline execution. True if notifications were triggered, False otherwise.',
    `pipeline_code` STRING COMMENT 'Unique business identifier or code for the pipeline. Used for cross-system reference and operational tracking.',
    `pipeline_name` STRING COMMENT 'Human-readable name of the data pipeline that was executed. Identifies the specific ETL/ELT workflow or data transformation process.',
    `pipeline_type` STRING COMMENT 'Classification of the pipeline based on its primary function: ingestion (raw data loading), transformation (data cleansing and enrichment), aggregation (summarization and rollup), model_scoring (ML inference), data_quality (validation and profiling), or orchestration (workflow coordination).. Valid values are `ingestion|transformation|aggregation|model_scoring|data_quality|orchestration`',
    `pipeline_version` STRING COMMENT 'Version number or Git commit hash of the pipeline code that was executed. Used for change tracking and rollback analysis.',
    `records_failed_count` BIGINT COMMENT 'Number of records that failed processing or validation during pipeline execution. Used for data quality monitoring and error rate tracking.',
    `records_processed_count` BIGINT COMMENT 'Total number of records read and processed by the pipeline during this execution. Used for throughput analysis and data volume tracking.',
    `records_skipped_count` BIGINT COMMENT 'Number of records intentionally skipped during processing due to business rules, filters, or deduplication logic.',
    `records_written_count` BIGINT COMMENT 'Total number of records successfully written to the target destination by the pipeline. Used for data completeness validation and reconciliation.',
    `retry_attempt_number` STRING COMMENT 'Sequential number indicating which retry attempt this execution represents. 0 for initial execution, 1+ for retries after failure. Used for reliability analysis.',
    `sla_breach_reason` STRING COMMENT 'Explanation of why the pipeline execution breached the SLA, if applicable. Examples: upstream delay, cluster unavailability, data volume spike, processing error.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether the pipeline execution met the defined SLA for duration and data freshness. True if compliant, False if SLA was breached.',
    `source_system` STRING COMMENT 'Name of the upstream source system or data platform from which the pipeline ingested data. Examples: Amdocs, Salesforce CRM, Nokia NetAct, Oracle OSM.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the pipeline execution began. Used for duration calculation and SLA monitoring. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `target_domain` STRING COMMENT 'Business domain where the pipeline writes output data. Examples: customer, network, billing, product, order, service.',
    `target_layer` STRING COMMENT 'Medallion architecture layer where the pipeline writes data: bronze (raw ingestion), silver (cleansed and conformed), gold (aggregated and business-ready), or platinum (advanced analytics and ML features).. Valid values are `bronze|silver|gold|platinum`',
    `target_product` STRING COMMENT 'Name of the target data product or table where the pipeline writes processed data. Used for data lineage tracking and impact analysis.',
    `trigger_type` STRING COMMENT 'Mechanism that initiated the pipeline execution: scheduled (time-based cron), event_driven (file arrival or message queue), manual (user-initiated), dependency_triggered (upstream pipeline completion), or on_demand (ad-hoc execution).. Valid values are `scheduled|event_driven|manual|dependency_triggered|on_demand`',
    CONSTRAINT pk_pipeline_run PRIMARY KEY(`pipeline_run_id`)
) COMMENT 'Transactional record of each data pipeline execution in the Databricks Lakehouse analytics platform — the SSOT for pipeline operational metadata. Captures pipeline name, pipeline type (ingestion, transformation, aggregation, model scoring), trigger type (scheduled, event-driven, manual), start timestamp, end timestamp, duration seconds, records processed, records written, status (success, failed, partial), error message, and Databricks job run ID. Provides the operational audit trail for data freshness SLA monitoring, pipeline reliability tracking, and root cause analysis of data quality issues caused by pipeline failures.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`glossary_term` (
    `glossary_term_id` BIGINT COMMENT 'Unique identifier for the business glossary term record. Primary key for the glossary term catalog.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Business glossary stewardship requires employee linkage for term approval workflows, definition disputes, and metadata governance. Essential for regulatory compliance (e.g., consistent metric definiti',
    `replacement_term_glossary_term_id` BIGINT COMMENT 'Reference to the glossary term that supersedes this deprecated term. Used to guide users to the current canonical term.',
    `broader_glossary_term_id` BIGINT COMMENT 'Self-referencing FK on glossary_term (broader_glossary_term_id)',
    `approval_date` DATE COMMENT 'Date when the glossary term was formally approved by the data governance council or designated authority.',
    `approval_status` STRING COMMENT 'Governance approval status indicating whether the term definition has been formally reviewed and approved by the data governance council.. Valid values are `pending|approved|rejected|revision_required`',
    `approved_by` STRING COMMENT 'Name of the governance authority or individual who formally approved this glossary term for enterprise use.',
    `business_context` STRING COMMENT 'Narrative description of how and where this term is used in business operations, including relevant business processes, use cases, and decision-making scenarios.',
    `business_definition` STRING COMMENT 'Comprehensive business definition of the term written in plain language for business users. Explains what the term means, why it matters, and how it is used in business context.',
    `calculation_formula` STRING COMMENT 'Mathematical or logical formula used to calculate or derive this term when it represents a metric or KPI. Includes variable definitions and operators.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this glossary term record was first created in the catalog. Supports audit trail and historical tracking.',
    `data_classification_level` STRING COMMENT 'Security classification level for data associated with this term, governing access controls and handling requirements.. Valid values are `public|internal|confidential|restricted`',
    `data_product_mapping` STRING COMMENT 'Comma-separated list of data product names where this glossary term is implemented as an attribute or entity. Provides business-to-technical term mapping.',
    `data_type` STRING COMMENT 'Expected data type for values associated with this term when it is implemented as a data attribute in systems or data products. [ENUM-REF-CANDIDATE: string|numeric|decimal|integer|boolean|date|timestamp|percentage|currency — 9 candidates stripped; promote to reference product]',
    `deprecation_reason` STRING COMMENT 'Explanation of why this term was deprecated or retired, including replacement term recommendations and migration guidance. Populated only for deprecated terms.',
    `effective_end_date` DATE COMMENT 'Date when this glossary term definition ceases to be valid. Null indicates the term is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which this glossary term definition becomes active and valid for use across the enterprise.',
    `industry_standard_reference` STRING COMMENT 'Reference to telecommunications industry standards, specifications, or frameworks that define or govern this term. Examples: 3GPP TS 32.xxx, TM Forum SID, ITU-T recommendations.',
    `is_sensitive` BOOLEAN COMMENT 'Indicates whether this term relates to sensitive, confidential, or personally identifiable information requiring special handling and access controls.',
    `kpi_linkage` STRING COMMENT 'Comma-separated list of KPI codes or names that use this glossary term in their definition or calculation. Establishes traceability from terms to metrics.',
    `last_modified_by` STRING COMMENT 'User identifier or name of the individual who last modified this glossary term record. Supports change tracking and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this glossary term record was last updated. Tracks recency of definition changes and maintenance activity.',
    `last_review_date` DATE COMMENT 'Date when this glossary term was last reviewed by the data steward or governance council to ensure definition accuracy and relevance.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this glossary term to maintain definition currency and alignment with business needs.',
    `owning_domain` STRING COMMENT 'The primary data domain responsible for defining and maintaining this glossary term. Aligns with the enterprise data domain taxonomy. [ENUM-REF-CANDIDATE: customer|network|billing|product|order|service|workforce|partner|usage|revenue_assurance|inventory|interconnect|content|compliance|enterprise|analytics — 16 candidates stripped; promote to reference product]',
    `primary_audience` STRING COMMENT 'Target user groups or roles who primarily use this term in their work. Examples: network engineers, billing analysts, customer service representatives, executives.',
    `regulatory_reference` STRING COMMENT 'Reference to regulatory requirements, compliance frameworks, or legal mandates that require or govern the use of this term. Examples: FCC regulations, GDPR articles.',
    `related_terms` STRING COMMENT 'Comma-separated list of related glossary term names that have semantic relationships with this term. Supports navigation and discovery of connected concepts.',
    `review_frequency_months` STRING COMMENT 'Standard interval in months between scheduled reviews of this glossary term. Ensures regular governance oversight and definition maintenance.',
    `source_system` STRING COMMENT 'Primary operational system or authoritative source where data for this term originates. Examples: Amdocs, Salesforce CRM, Nokia NetAct, Ericsson Network Manager.',
    `strategic_importance` STRING COMMENT 'Business priority level indicating how critical this term is to strategic decision-making, regulatory compliance, or operational excellence.. Valid values are `critical|high|medium|low`',
    `synonyms` STRING COMMENT 'Comma-separated list of alternative names, abbreviations, or aliases for this term used across the organization or industry. Helps users find the canonical term.',
    `tags` STRING COMMENT 'Comma-separated list of keywords or labels for categorization, search, and discovery. Examples: 5G, customer_experience, revenue_assurance, network_quality.',
    `technical_definition` STRING COMMENT 'Technical or mathematical definition of the term including formulas, calculation methods, data sources, and system-level specifications. Used by data engineers and analysts.',
    `term_category` STRING COMMENT 'High-level classification of the glossary term indicating the primary business domain or functional area it belongs to. [ENUM-REF-CANDIDATE: network|customer|billing|product|service|revenue|operational|technical|regulatory|financial|workforce|quality — 12 candidates stripped; promote to reference product]',
    `term_code` STRING COMMENT 'Short alphanumeric code or abbreviation for the term, used for compact reference in systems and reports. Examples: ARPU, MSISDN, CDR, CSSR, MNP.',
    `term_name` STRING COMMENT 'The canonical name of the business glossary term as it appears in business communications and documentation. This is the primary label used across the enterprise.',
    `term_status` STRING COMMENT 'Current lifecycle status of the glossary term indicating its readiness for use and governance approval state.. Valid values are `draft|under_review|approved|published|deprecated|retired`',
    `term_subcategory` STRING COMMENT 'Secondary classification providing finer granularity within the term category. Examples: RAN metrics, billing cycles, customer segments.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measurement for this term when it represents a quantitative metric. Examples: currency, percentage, count, megabits per second, milliseconds.',
    `usage_examples` STRING COMMENT 'Concrete examples demonstrating how this term is used in business communications, reports, KPIs, or operational contexts. Helps users understand practical application.',
    `usage_frequency` STRING COMMENT 'How frequently this term is referenced or used in business operations, reporting, and analytics. Indicates operational relevance.. Valid values are `daily|weekly|monthly|quarterly|annually|ad_hoc`',
    `usage_notes` STRING COMMENT 'Additional guidance, caveats, or best practices for using this term correctly. Includes common misunderstandings to avoid and contextual nuances.',
    `valid_value_range` STRING COMMENT 'Acceptable range or enumeration of valid values for this term. Examples: 0-100 for percentages, active|inactive|suspended for status codes.',
    `version_number` STRING COMMENT 'Version identifier for this glossary term definition, incremented when the definition is revised. Supports change tracking and historical reference.',
    `created_by` STRING COMMENT 'User identifier or name of the individual who created this glossary term record. Supports accountability and audit trail.',
    CONSTRAINT pk_glossary_term PRIMARY KEY(`glossary_term_id`)
) COMMENT 'Master catalog of all business glossary terms defined for the telecommunications enterprise — the SSOT for business terminology governance. Captures term name, definition, business context, synonyms, related terms, owning domain, steward, status (draft, approved, deprecated), and examples of usage. Covers telecom-specific terms: ARPU, MSISDN, CDR, CSSR, DCR, MNP, MVNO, OLT, ONT, PRB, VoLTE, eSIM, FTTH, GPON, and hundreds more. Linked to data product catalog entries to provide business-to-technical term mapping. Enables consistent business communication and reduces ambiguity in KPI definitions and reporting.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`kpi_target` (
    `kpi_target_id` BIGINT COMMENT 'Unique identifier for the KPI target record. Primary key for the KPI target entity.',
    `administrative_region_id` BIGINT COMMENT 'Foreign key linking to location.administrative_region. Business justification: Regulatory KPI targets (coverage obligations, quality standards, universal service) are mandated by jurisdiction/region. Essential for compliance tracking and regulatory reporting in telecommunication',
    `kpi_definition_id` BIGINT COMMENT 'Reference to the KPI definition that this target applies to. Links to the KPI catalog entry defining the metric, calculation formula, and business meaning.',
    `employee_id` BIGINT COMMENT 'Reference to the individual or role accountable for achieving this target. Typically links to an employee, manager, or organizational unit responsible for performance delivery.',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Performance targets are set at territory level for regional accountability, market-specific goals, and territory manager incentive plans. Complements employee-level targets with geographic accountabil',
    `element_id` BIGINT COMMENT 'Foreign key linking to network.element. Business justification: Performance targets (availability, utilization, MTTR) are set per network element type or specific critical elements for capacity planning and performance management. Budget planning and operational s',
    `target_owner_employee_id` BIGINT COMMENT 'FK to people.employee',
    `revised_kpi_target_id` BIGINT COMMENT 'Self-referencing FK on kpi_target (revised_kpi_target_id)',
    `approval_date` DATE COMMENT 'The date on which this target was formally approved. Establishes the official commitment date for performance tracking.',
    `approval_status` STRING COMMENT 'The approval workflow status for this target. Indicates whether the target has been reviewed and approved by the appropriate governance authority.. Valid values are `not_submitted|pending_review|approved|rejected|revision_required`',
    `approved_by` STRING COMMENT 'The name or identifier of the individual who approved this target. Provides audit trail for governance and accountability.',
    `baseline_period` STRING COMMENT 'The time period from which the baseline value was derived. Examples include Q4 2023, FY 2023, or Trailing 12 Months. Provides temporal context for baseline comparison.',
    `baseline_value` DECIMAL(18,2) COMMENT 'The historical or current performance level that serves as the starting point for target setting. Provides context for evaluating the ambition level of the target.',
    `benchmark_source` STRING COMMENT 'The external benchmark or industry standard used to inform target setting. Examples include analyst reports, industry associations (GSMA, TM Forum), competitive intelligence, or regulatory benchmarks.',
    `benchmark_value` DECIMAL(18,2) COMMENT 'The external benchmark performance level from the specified source. Provides competitive context for evaluating target ambition and performance gaps.',
    `business_dimension_type` STRING COMMENT 'The type of business dimension for which this target is defined. Identifies the analytical axis along which performance is measured (e.g., geographic region, product line, customer segment, distribution channel).. Valid values are `region|product_line|channel|segment|service_type|network_technology`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this KPI target record was first created in the system. Provides audit trail for target planning lifecycle.',
    `dashboard_visibility` STRING COMMENT 'The audience level for which this target is visible in dashboards and scorecards. Controls access and presentation of target information across organizational levels.. Valid values are `executive|management|operational|public|restricted`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'The data quality score (0-100) for the source data used to measure actual performance against this target. Indicates the reliability and trustworthiness of variance analysis.',
    `dimension_hierarchy_level` STRING COMMENT 'The hierarchical level at which the dimension value is defined. For example, National, Regional, Market, or Site for geographic dimensions. Supports roll-up and drill-down analysis.',
    `dimension_value` DECIMAL(18,2) COMMENT 'The specific value of the business dimension for which this target applies. For example, if dimension_type is region, this could be Northeast, West, or EMEA. Enables dimensional variance analysis.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter (1-4) to which this target period belongs. Supports quarterly performance tracking and MBO reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this target period belongs. Enables alignment with financial planning and budgeting cycles.',
    `incentive_eligible_flag` BOOLEAN COMMENT 'Indicates whether achievement of this target is tied to incentive compensation, bonuses, or performance-based rewards. True if the target is part of an MBO or incentive plan.',
    `incentive_weight_percentage` DECIMAL(18,2) COMMENT 'The percentage weight of this target in the overall incentive compensation calculation. Used when multiple KPI targets contribute to a composite performance score.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this KPI target record was most recently updated. Tracks the currency of target information.',
    `minimum_acceptable_threshold` DECIMAL(18,2) COMMENT 'The minimum performance level that is considered acceptable. Performance below this threshold triggers alerts, escalations, or corrective action plans.',
    `modified_by` STRING COMMENT 'The user or system identifier that last modified this target record. Supports audit trail and change management for target revisions.',
    `notes` STRING COMMENT 'Additional free-form notes, comments, or context about this target. Captures supplementary information not covered by structured fields.',
    `owning_domain` STRING COMMENT 'The business domain that owns and is accountable for this KPI target. Aligns with the enterprise data domain taxonomy and supports domain-driven governance. [ENUM-REF-CANDIDATE: customer|network|billing|product|order|service|revenue_assurance|workforce — 8 candidates stripped; promote to reference product]',
    `regulatory_reference` STRING COMMENT 'The specific regulatory rule, order, or standard that mandates this target. Examples include FCC order numbers, ETSI specifications, or 3GPP standards.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this target is driven by regulatory compliance obligations. True if the target is mandated by FCC, ITU, ETSI, or other governing bodies.',
    `reporting_frequency` STRING COMMENT 'The frequency at which actual performance against this target is measured and reported. Defines the cadence of variance analysis and performance reviews.. Valid values are `real-time|daily|weekly|monthly|quarterly|annual`',
    `revision_reason` STRING COMMENT 'The business justification for revising the target after initial approval. Documents changes in market conditions, strategic priorities, or operational capabilities that necessitated target adjustment.',
    `sla_applicable_flag` BOOLEAN COMMENT 'Indicates whether this target is tied to contractual SLA commitments with customers, partners, or wholesale operators. True if target achievement impacts SLA compliance.',
    `strategic_initiative_code` BIGINT COMMENT 'Reference to the strategic initiative, program, or project that this target supports. Links KPI targets to enterprise strategic planning and portfolio management.',
    `strategic_objective` STRING COMMENT 'The high-level strategic objective that this target contributes to. Examples include Improve Customer Satisfaction, Reduce Network OPEX, Increase ARPU, or Accelerate 5G Adoption.',
    `stretch_target_value` DECIMAL(18,2) COMMENT 'An aspirational performance target that exceeds the standard target. Represents exceptional performance and may be tied to incentive compensation or recognition programs.',
    `target_improvement_percentage` DECIMAL(18,2) COMMENT 'The percentage improvement from baseline to target. Calculated as ((target_value - baseline_value) / baseline_value) * 100. Provides a normalized view of target ambition.',
    `target_owner_role` STRING COMMENT 'The organizational role or title of the target owner. Examples include Regional Vice President, Product Manager, Network Operations Director, or Customer Experience Lead.',
    `target_period_end_date` DATE COMMENT 'The end date of the measurement period for which this target is effective. Defines the conclusion of the performance evaluation window.',
    `target_period_start_date` DATE COMMENT 'The start date of the measurement period for which this target is effective. Defines the beginning of the performance evaluation window.',
    `target_period_type` STRING COMMENT 'The measurement period granularity for which this target is set. Defines whether the target applies to a monthly, quarterly, annual, or other time period.. Valid values are `monthly|quarterly|annual|weekly|daily|semi-annual`',
    `target_rationale` STRING COMMENT 'The business justification and strategic reasoning for setting this target at the specified level. Documents the assumptions, market conditions, historical trends, and strategic objectives that informed the target setting process.',
    `target_status` STRING COMMENT 'The current lifecycle status of the KPI target. Tracks the target through planning, approval, activation, and archival stages.. Valid values are `draft|pending_approval|approved|active|suspended|archived`',
    `target_value` DECIMAL(18,2) COMMENT 'The planned performance target value for the KPI during the specified period and dimension combination. This is the primary goal that actual performance will be measured against.',
    `unit_of_measure` STRING COMMENT 'The unit in which the target value is expressed. Examples include percentage, currency (USD, EUR), count, minutes, megabits per second (Mbps), or ratio. Must align with the KPI definition unit of measure.',
    `version_number` STRING COMMENT 'The version number of this target record. Increments when targets are revised during the planning cycle. Supports target change history and audit trail.',
    `created_by` STRING COMMENT 'The user or system identifier that created this target record. Supports accountability and audit trail for target planning.',
    CONSTRAINT pk_kpi_target PRIMARY KEY(`kpi_target_id`)
) COMMENT 'Periodic KPI target record defining the planned performance target for a specific KPI, business dimension combination, and measurement period — the SSOT for KPI target management. Captures KPI definition reference, target period (monthly, quarterly, annual), business dimension values (region, product line, channel, segment), target value, stretch target value, minimum acceptable threshold, target owner, and approval status. Enables variance analysis between actual KPI measurements and planned targets across network, customer, and revenue analytics subject areas. Supports executive scorecard and MBO (Management by Objectives) reporting.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`ab_test` (
    `ab_test_id` BIGINT COMMENT 'Unique identifier for the A/B test or controlled experiment. Primary key for the ab_test product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: A/B test ownership accountability for experiment design, result interpretation, and rollout decisions in telecommunications product optimization (e.g., pricing tests, UX experiments). Critical for exp',
    `segment_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.segment_definition. Business justification: A/B tests target specific customer segments. One test targets ONE primary segment; one segment can be targeted by MANY tests. Currently target_population_segment is a string; normalizing to FK provide',
    `prior_iteration_ab_test_id` BIGINT COMMENT 'Self-referencing FK on ab_test (prior_iteration_ab_test_id)',
    `actual_duration_days` STRING COMMENT 'The actual duration of the experiment in days, from start to conclusion. Null for ongoing experiments.',
    `allocation_method` STRING COMMENT 'The method used to assign subjects to treatment and control groups: random (simple randomization), stratified (balanced by segment), cluster (group-level assignment), systematic (rule-based), or adaptive (dynamic based on results).. Valid values are `random|stratified|cluster|systematic|adaptive`',
    `analysis_method` STRING COMMENT 'The statistical method used to analyze experiment results, such as t-test, chi-square, ANOVA, Bayesian analysis, or regression.',
    `business_sponsor` STRING COMMENT 'The business stakeholder or executive sponsor who requested the experiment and will act on the results.',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'The lower bound of the confidence interval for the observed effect size, typically at 95% confidence level.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'The upper bound of the confidence interval for the observed effect size, typically at 95% confidence level.',
    `control_group_definition` STRING COMMENT 'Definition and criteria for the control group receiving the baseline or current experience, used as the comparison benchmark.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the experiment record was first created in the system.',
    `data_source_system` STRING COMMENT 'The operational system or data source from which experiment metrics are collected, such as BSS (Business Support Systems), OSS (Operations Support Systems), or CRM (Customer Relationship Management).',
    `decision` STRING COMMENT 'The business decision made based on experiment results: implement (roll out treatment), reject (keep control), iterate (refine and retest), or monitor (continue observation).. Valid values are `implement|reject|iterate|monitor`',
    `decision_date` DATE COMMENT 'The date when the business decision was made based on the experiment results.',
    `documentation_url` STRING COMMENT 'URL or reference to detailed experiment documentation, including design specifications, analysis notebooks, and presentation materials.',
    `end_date` DATE COMMENT 'The date when the experiment concluded or is scheduled to conclude. Null for ongoing experiments.',
    `estimated_revenue_impact` DECIMAL(18,2) COMMENT 'The estimated annual revenue impact (positive or negative) if the treatment is fully implemented, based on observed effect size and population size.',
    `ethical_review_flag` BOOLEAN COMMENT 'Indicates whether the experiment has undergone ethical review to ensure customer privacy, fairness, and transparency.',
    `experiment_category` STRING COMMENT 'Business category of the experiment: pricing (plan tests), network_config (infrastructure trials), retention (churn reduction offers), ui_ux (interface personalization), product_feature (new capability tests), or marketing (campaign effectiveness).. Valid values are `pricing|network_config|retention|ui_ux|product_feature|marketing`',
    `hypothesis` STRING COMMENT 'The business hypothesis being tested, describing the expected outcome and rationale for the experiment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the experiment record was last updated or modified.',
    `minimum_detectable_effect` DECIMAL(18,2) COMMENT 'The smallest effect size that the experiment is designed to detect with statistical confidence, expressed as a percentage or absolute value.',
    `modified_by` STRING COMMENT 'The user ID or name of the person who last modified the experiment record.',
    `observed_effect_size` DECIMAL(18,2) COMMENT 'The actual measured effect size observed in the experiment, expressed as a percentage change or absolute difference in the primary metric.',
    `owning_team` STRING COMMENT 'The analytics or data science team responsible for designing, executing, and analyzing this experiment.',
    `p_value` DECIMAL(18,2) COMMENT 'The calculated p-value from the statistical test, indicating the probability of observing the results under the null hypothesis.',
    `planned_duration_days` STRING COMMENT 'The planned duration of the experiment in days, based on statistical power calculations and business requirements.',
    `platform` STRING COMMENT 'The technology platform or tool used to execute the experiment, such as Optimizely, Adobe Target, or custom in-house platform.',
    `primary_success_metric` STRING COMMENT 'The primary Key Performance Indicator (KPI) used to measure experiment success, such as ARPU (Average Revenue Per User), churn rate, NPS (Net Promoter Score), or conversion rate.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the experiment has been reviewed and approved for compliance with applicable regulations such as FCC (Federal Communications Commission) rules, GDPR, or CPNI (Customer Proprietary Network Information) requirements.',
    `result_summary` STRING COMMENT 'High-level summary of the experiment results, including whether the hypothesis was supported, rejected, or inconclusive.',
    `rollout_percentage` DECIMAL(18,2) COMMENT 'If the decision was to implement, the percentage of the population to which the treatment will be rolled out (0-100).',
    `sample_size_control` BIGINT COMMENT 'The number of subjects (customers, subscribers, or sessions) allocated to the control group.',
    `sample_size_treatment` BIGINT COMMENT 'The number of subjects (customers, subscribers, or sessions) allocated to the treatment group(s).',
    `secondary_metrics` STRING COMMENT 'Comma-separated list of secondary KPIs monitored during the experiment to assess broader impact, such as CSAT (Customer Satisfaction Score), MRR (Monthly Recurring Revenue), or network QoS (Quality of Service) metrics.',
    `start_date` DATE COMMENT 'The date when the experiment was launched and data collection began.',
    `statistical_power` DECIMAL(18,2) COMMENT 'The probability of detecting a true effect if one exists, typically set at 0.80 or 0.90, representing 1 minus the Type II error rate.',
    `statistical_significance_threshold` DECIMAL(18,2) COMMENT 'The p-value threshold used to determine statistical significance, typically 0.05 or 0.01, representing the acceptable Type I error rate.',
    `test_code` STRING COMMENT 'Unique business code or identifier for the experiment, used for external reference and integration with analytics platforms.',
    `test_name` STRING COMMENT 'Human-readable name of the A/B test or experiment, used for identification and reporting purposes.',
    `test_status` STRING COMMENT 'Current lifecycle status of the experiment: design (planning), approved (ready to launch), running (active), paused (temporarily stopped), concluded (completed), archived (historical), or cancelled (terminated early). [ENUM-REF-CANDIDATE: design|approved|running|paused|concluded|archived|cancelled — 7 candidates stripped; promote to reference product]',
    `test_type` STRING COMMENT 'Type of experiment design used: A/B (two variants), multivariate (multiple factors), holdout (control group only), sequential (adaptive), factorial (combination testing), or bandit (dynamic allocation).. Valid values are `a_b|multivariate|holdout|sequential|factorial|bandit`',
    `treatment_group_definition` STRING COMMENT 'Definition and criteria for the treatment group(s) receiving the experimental variant(s), including allocation rules and variant descriptions.',
    `version_number` STRING COMMENT 'Version number of the experiment design, incremented when the experiment is modified or re-run with different parameters.',
    `created_by` STRING COMMENT 'The user ID or name of the person who created the experiment record.',
    CONSTRAINT pk_ab_test PRIMARY KEY(`ab_test_id`)
) COMMENT 'Master record for A/B tests and controlled experiments conducted within the telecommunications analytics platform — the SSOT for experimentation governance. Captures experiment name, hypothesis, test type (A/B, multivariate, holdout), target population segment, treatment and control group definitions, primary success metric (KPI reference), secondary metrics, start date, end date, minimum detectable effect, statistical significance threshold, status (design, running, concluded, archived), and owning analytics team. Covers telecom experiments: pricing plan tests, network configuration trials, retention offer effectiveness, and UI/UX personalization tests.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` (
    `ab_test_assignment_id` BIGINT COMMENT 'Unique identifier for the A/B test assignment record. Primary key for the assignment entity.',
    `ab_test_id` BIGINT COMMENT 'Reference to the parent A/B test experiment to which this assignment belongs. Links to the experiment definition.',
    `customer_account_id` BIGINT COMMENT 'Reference to the billing account assigned to this experiment variant. Used when assignment is at account level rather than individual subscriber level.',
    `subscriber_id` BIGINT COMMENT 'Reference to the individual subscriber assigned to this experiment variant. Identifies the telecommunications customer participating in the test.',
    `reassigned_from_ab_test_assignment_id` BIGINT COMMENT 'Self-referencing FK on ab_test_assignment (reassigned_from_ab_test_assignment_id)',
    `assignment_batch_code` STRING COMMENT 'Identifier for the batch or cohort of assignments created together. Used to track assignment waves and support batch-level quality checks.',
    `assignment_hash_seed` STRING COMMENT 'The seed value or salt used in hash-based random assignment algorithms. Enables reproducibility of assignment logic and verification of assignment integrity.',
    `assignment_method` STRING COMMENT 'The methodology used to assign the subject to the variant. Random hash uses deterministic hashing for reproducibility, stratified random ensures balanced representation across segments, propensity score uses ML-based matching, manual indicates deliberate assignment, geographic cluster assigns by location, and temporal cohort assigns by time period.. Valid values are `random_hash|stratified_random|propensity_score|manual|geographic_cluster|temporal_cohort`',
    `assignment_source_system` STRING COMMENT 'The name or identifier of the system that generated this assignment record. Examples include experimentation platform, CRM system, or custom assignment service.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the assignment. Active indicates ongoing participation, completed indicates experiment concluded, withdrawn indicates subject opted out, excluded indicates post-assignment exclusion criteria met, invalidated indicates assignment error or data quality issue.. Valid values are `active|completed|withdrawn|excluded|invalidated`',
    `assignment_timestamp` TIMESTAMP COMMENT 'The precise date and time when the subscriber or account was assigned to the experimental variant. Immutable once set to preserve experimental integrity and enable intent-to-treat analysis.',
    `assignment_variant` STRING COMMENT 'The experimental variant or treatment group to which the subscriber or account has been assigned. Control represents the baseline, treatment groups represent experimental conditions, and holdout represents subjects excluded from exposure.. Valid values are `control|treatment_a|treatment_b|treatment_c|treatment_d|holdout`',
    `assignment_weight` DECIMAL(18,2) COMMENT 'Statistical weight applied to this assignment for weighted analysis. Used in inverse propensity weighting, stratification weighting, or other variance reduction techniques. Default value is 1.0 for equal weighting.',
    `control_group_flag` BOOLEAN COMMENT 'Boolean indicator of whether this assignment is to the control group (True) or a treatment group (False). Simplifies filtering for control vs treatment comparisons.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this assignment record was first created in the system. Immutable audit field for data lineage and compliance.',
    `data_quality_flag` BOOLEAN COMMENT 'Boolean indicator of whether this assignment record has passed all data quality validation rules. False indicates potential data quality issues that may warrant exclusion from analysis.',
    `data_quality_notes` STRING COMMENT 'Free-text notes documenting any data quality issues, anomalies, or special conditions associated with this assignment. Used for audit trail and analysis exclusion decisions.',
    `device_type` STRING COMMENT 'The primary device type or Customer Premises Equipment (CPE) associated with the subscriber at the time of assignment. Examples include smartphone model, modem type, or set-top box model. Used for device-specific treatment effects analysis.',
    `exclusion_reason` STRING COMMENT 'Free-text explanation of why the subject was excluded or withdrawn from the experiment after initial assignment. Examples include account closure, service suspension, data quality issues, or violation of inclusion criteria.',
    `exclusion_timestamp` TIMESTAMP COMMENT 'The date and time when the subject was excluded or withdrawn from the experiment. Used to calculate effective exposure duration.',
    `experiment_end_date` DATE COMMENT 'The calendar date when the experiment period ends for this assignment. May be null for ongoing experiments. Used to define the analysis window and determine completion status.',
    `experiment_start_date` DATE COMMENT 'The calendar date when the experiment period begins for this assignment. Used to define the analysis window and calculate time-in-experiment metrics.',
    `exposure_confirmed_flag` BOOLEAN COMMENT 'Boolean indicator of whether the subject was actually exposed to the assigned treatment. True indicates confirmed exposure, False indicates assignment without exposure. Enables as-treated analysis in addition to intent-to-treat analysis.',
    `exposure_count` STRING COMMENT 'The cumulative number of times the subject has been exposed to the treatment condition during the experiment period. Supports dose-response analysis.',
    `first_exposure_timestamp` TIMESTAMP COMMENT 'The date and time when the subject was first exposed to the assigned treatment condition. May differ from assignment timestamp if there is a delay between assignment and actual exposure.',
    `geographic_market` STRING COMMENT 'The geographic market, region, or service area in which the subscriber or account is located at the time of assignment. Used for geographic stratification and subgroup analysis.',
    `last_modified_by` STRING COMMENT 'The user identifier or system process that last modified this assignment record. Used for audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this assignment record was last updated. Used to track changes to assignment status, exposure confirmation, or exclusion.',
    `pre_experiment_arpu` DECIMAL(18,2) COMMENT 'The average monthly revenue per user for this subscriber or account in the period immediately preceding experiment assignment. Used as a covariate for difference-in-differences analysis and to verify randomization balance.',
    `pre_experiment_churn_risk_score` DECIMAL(18,2) COMMENT 'The predicted churn probability (0.0000 to 1.0000) for this subscriber or account at the time of assignment, based on pre-experiment behavior. Used to verify balance across treatment arms and as a covariate in outcome analysis.',
    `pre_experiment_tenure_months` STRING COMMENT 'The number of complete months the subscriber or account has been active with the telecommunications provider at the time of assignment. Used as a covariate to control for customer maturity effects.',
    `propensity_score` DECIMAL(18,2) COMMENT 'The calculated propensity score (0.0000 to 1.0000) representing the predicted likelihood of treatment assignment based on pre-treatment covariates. Used in propensity score matching and weighting for causal inference.',
    `rate_plan_code` STRING COMMENT 'The rate plan or pricing plan code associated with the subscriber or account at the time of assignment. Used to control for baseline pricing differences and analyze treatment effects by plan type.',
    `service_type` STRING COMMENT 'The primary telecommunications service type associated with the subscriber or account at the time of assignment. Used for service-specific subgroup analysis. [ENUM-REF-CANDIDATE: mobile|fixed_broadband|fiber|iptv|voip|enterprise|converged — 7 candidates stripped; promote to reference product]',
    `stratification_segment` STRING COMMENT 'The stratification segment or cohort to which the subject belongs for stratified randomization. Examples include ARPU tier, tenure band, geographic region, or device type to ensure balanced representation across key dimensions.',
    `created_by` STRING COMMENT 'The user identifier or system process that created this assignment record. Used for audit trail and accountability.',
    CONSTRAINT pk_ab_test_assignment PRIMARY KEY(`ab_test_assignment_id`)
) COMMENT 'Association record linking individual subscribers or accounts to their assigned treatment or control group within an A/B test for the duration of the experiment. Captures experiment reference, subscriber or account reference, assigned variant (control, treatment_A, treatment_B), assignment timestamp, assignment method (random hash, stratified, ML-propensity), and exposure confirmation flag. Enables intent-to-treat and as-treated analysis. Immutable once assigned to preserve experimental integrity. Supports post-experiment lift analysis and causal inference for telecom product and pricing experiments.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` (
    `retention_model_output_id` BIGINT COMMENT 'Unique identifier for each retention model scoring record. Primary key for the retention model output entity.',
    `analytical_model_registry_id` BIGINT COMMENT 'Reference to the registered retention model definition that produced this output. Links to the model registry for model metadata and lineage.',
    `coverage_area_id` BIGINT COMMENT 'Foreign key linking to location.coverage_area. Business justification: Churn models incorporate coverage quality at customer location as poor coverage is a primary churn driver. Links predicted churn risk to network coverage for targeted retention offers and network inve',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: CPE device type, age, condition are churn model features; linking predictions to assets enables targeted device upgrade offers as retention interventions.',
    `model_run_id` BIGINT COMMENT 'Reference to the specific model execution run that generated this score. Links to the analytical model run registry.',
    `trouble_ticket_id` BIGINT COMMENT 'Foreign key linking to assurance.trouble_ticket. Business justification: Churn propensity scores consider recent trouble ticket history as a leading indicator. Real-world retention analytics incorporate service quality incidents into churn models for proactive retention in',
    `segment_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.segment_definition. Business justification: Retention model output includes subscriber segment classification. One output record belongs to ONE segment; one segment has MANY output records. Currently subscriber_segment is a string; normalizing ',
    `ran_cell_id` BIGINT COMMENT 'Foreign key linking to network.ran_cell. Business justification: Churn prediction models incorporate cell-level service quality (RSRP, throughput, congestion) as key features. Retention campaigns targeting subscribers in poor-coverage cells require linking churn sc',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who was scored by the retention model. Links to the customer domain subscriber entity.',
    `previous_retention_model_output_id` BIGINT COMMENT 'Self-referencing FK on retention_model_output (previous_retention_model_output_id)',
    `arpu_at_scoring` DECIMAL(18,2) COMMENT 'The subscribers monthly average revenue per user at the time of model scoring. Snapshot value used to prioritize high-value at-risk customers.',
    `business_date` DATE COMMENT 'The business date (reporting date) for which this retention score is effective. Used for time-based partitioning and historical analysis.',
    `churn_propensity_score` DECIMAL(18,2) COMMENT 'Predicted probability that the subscriber will churn within the forecast horizon. Continuous value between 0.0000 (no churn risk) and 1.0000 (certain churn). Core output of the retention model.',
    `churn_risk_tier` STRING COMMENT 'Categorical segmentation of churn risk based on propensity score thresholds. Used for prioritizing retention campaigns and resource allocation.. Valid values are `low|medium|high|critical`',
    `cltv_at_scoring` DECIMAL(18,2) COMMENT 'The subscribers estimated customer lifetime value at the time of model scoring. Snapshot value used to assess the business impact of potential churn.',
    `competitive_offer_exposure_flag` BOOLEAN COMMENT 'Indicates whether the subscriber is in a geographic area with recent competitive promotional activity. True if exposed to competitor offers that may increase churn risk.',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'Lower bound of the 95% confidence interval for the churn propensity score. Represents the minimum likely churn probability given model uncertainty.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'Upper bound of the 95% confidence interval for the churn propensity score. Represents the maximum likely churn probability given model uncertainty.',
    `contract_end_date` DATE COMMENT 'The date when the subscribers current contract or commitment period ends. Critical for identifying churn risk windows and proactive retention timing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this retention model output record was first created and persisted in the Silver Layer. Represents the data pipeline execution time.',
    `data_source_system` STRING COMMENT 'The primary source system or platform that provided the input data for this model scoring (e.g., Salesforce CRM, Amdocs Billing, internal data lake).',
    `days_to_contract_end` STRING COMMENT 'Number of days remaining until the subscribers contract expires at the time of scoring. Key temporal feature for churn prediction near contract renewal periods.',
    `error_message` STRING COMMENT 'Detailed error or warning message if the scoring process encountered issues for this subscriber. Null if processing completed successfully.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this retention model output record was last updated. Used for tracking record changes and data freshness.',
    `model_drift_flag` BOOLEAN COMMENT 'Indicates whether model drift was detected for this scoring run. True if input data distribution significantly differs from training data, suggesting potential score reliability issues.',
    `model_version` STRING COMMENT 'Version identifier of the retention model that generated this score. Enables tracking of model evolution and performance comparison across versions.',
    `nps_score` STRING COMMENT 'The subscribers most recent Net Promoter Score rating (0-10 scale). Measures customer loyalty and likelihood to recommend the service.',
    `predicted_churn_horizon_days` STRING COMMENT 'Number of days into the future for which the churn prediction is valid. Represents the forecast window of the model (e.g., 30, 60, 90 days).',
    `previous_churn_score` DECIMAL(18,2) COMMENT 'The churn propensity score from the previous model run for this subscriber. Enables tracking of score changes and risk trajectory over time.',
    `processing_status` STRING COMMENT 'Status of the scoring record processing. Completed indicates successful scoring; failed or partial indicates data quality or processing issues.. Valid values are `completed|failed|partial|pending_review`',
    `recent_complaint_count` STRING COMMENT 'Number of customer complaints or trouble tickets filed by the subscriber in the 90 days prior to scoring. Behavioral indicator of dissatisfaction and churn risk.',
    `recent_payment_failure_count` STRING COMMENT 'Number of failed payment attempts in the 90 days prior to scoring. Financial indicator of potential involuntary churn risk.',
    `recommended_retention_action` STRING COMMENT 'Model-recommended intervention strategy to reduce churn risk for this subscriber. Guides sales and customer success teams on next best action. [ENUM-REF-CANDIDATE: no_action|monitor|outreach|discount_offer|loyalty_program|premium_support|contract_renegotiation — 7 candidates stripped; promote to reference product]',
    `retention_campaign_eligible_flag` BOOLEAN COMMENT 'Indicates whether the subscriber is eligible for proactive retention campaigns based on business rules (e.g., not recently contacted, not in dispute, contract status).',
    `score_change_direction` STRING COMMENT 'Indicates whether the churn risk has increased, decreased, or remained stable compared to the previous scoring cycle. New_score indicates first-time scoring for this subscriber.. Valid values are `increased|decreased|stable|new_score`',
    `score_expiry_date` DATE COMMENT 'Date after which this churn score is considered stale and should not be used for operational decisions. Calculated as scoring_timestamp plus model refresh interval.',
    `score_quality_indicator` STRING COMMENT 'Assessment of the reliability and quality of this particular score based on feature completeness, data freshness, and model confidence. Low quality scores should be used with caution.. Valid values are `high|medium|low`',
    `scoring_timestamp` TIMESTAMP COMMENT 'The exact date and time when the churn propensity score was calculated for this subscriber. Represents the business event time of model inference.',
    `tenure_months_at_scoring` STRING COMMENT 'Number of months the subscriber has been active with the service provider at the time of scoring. Snapshot value used as a key churn predictor feature.',
    `top_contributing_features` STRING COMMENT 'JSON-encoded list of the most influential features driving the churn prediction for this subscriber. Includes feature names and their contribution weights for model explainability.',
    `usage_trend` STRING COMMENT 'Directional trend of the subscribers service usage over the past 90 days. Declining usage is a strong churn predictor.. Valid values are `increasing|stable|declining|volatile`',
    CONSTRAINT pk_retention_model_output PRIMARY KEY(`retention_model_output_id`)
) COMMENT 'Operational output record of the subscriber churn and retention propensity model — the SSOT for model-scored subscriber retention risk in the Silver Layer. Captures subscriber reference, model run reference, scoring timestamp, churn propensity score (0.0–1.0), churn risk tier (low, medium, high, critical), predicted churn horizon (days), top contributing features (JSON), recommended retention action, and score expiry date. Consumed by the sales and customer domains for targeted retention campaign execution. Distinct from the analytical_model_registry which defines the model — this is the per-subscriber scored output record.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_parent_kpi_definition_id` FOREIGN KEY (`parent_kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ADD CONSTRAINT `fk_analytics_reporting_dimension_parent_reporting_dimension_id` FOREIGN KEY (`parent_reporting_dimension_id`) REFERENCES `telecommunication_ecm`.`analytics`.`reporting_dimension`(`reporting_dimension_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ADD CONSTRAINT `fk_analytics_dimension_hierarchy_reporting_dimension_id` FOREIGN KEY (`reporting_dimension_id`) REFERENCES `telecommunication_ecm`.`analytics`.`reporting_dimension`(`reporting_dimension_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ADD CONSTRAINT `fk_analytics_dimension_hierarchy_parent_dimension_hierarchy_id` FOREIGN KEY (`parent_dimension_hierarchy_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dimension_hierarchy`(`dimension_hierarchy_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ADD CONSTRAINT `fk_analytics_analytical_subject_area_parent_analytical_subject_area_id` FOREIGN KEY (`parent_analytical_subject_area_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytical_subject_area`(`analytical_subject_area_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ADD CONSTRAINT `fk_analytics_dq_rule_derived_from_dq_rule_id` FOREIGN KEY (`derived_from_dq_rule_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_rule`(`dq_rule_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ADD CONSTRAINT `fk_analytics_dq_execution_result_dq_rule_id` FOREIGN KEY (`dq_rule_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_rule`(`dq_rule_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ADD CONSTRAINT `fk_analytics_dq_execution_result_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ADD CONSTRAINT `fk_analytics_dq_execution_result_rerun_of_dq_execution_result_id` FOREIGN KEY (`rerun_of_dq_execution_result_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_execution_result`(`dq_execution_result_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ADD CONSTRAINT `fk_analytics_dq_issue_dq_execution_result_id` FOREIGN KEY (`dq_execution_result_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_execution_result`(`dq_execution_result_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ADD CONSTRAINT `fk_analytics_dq_issue_dq_rule_id` FOREIGN KEY (`dq_rule_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_rule`(`dq_rule_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ADD CONSTRAINT `fk_analytics_dq_issue_related_dq_issue_id` FOREIGN KEY (`related_dq_issue_id`) REFERENCES `telecommunication_ecm`.`analytics`.`dq_issue`(`dq_issue_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ADD CONSTRAINT `fk_analytics_analytical_model_registry_analytical_subject_area_id` FOREIGN KEY (`analytical_subject_area_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytical_subject_area`(`analytical_subject_area_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ADD CONSTRAINT `fk_analytics_analytical_model_registry_predecessor_analytical_model_registry_id` FOREIGN KEY (`predecessor_analytical_model_registry_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytical_model_registry`(`analytical_model_registry_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ADD CONSTRAINT `fk_analytics_model_run_analytical_model_registry_id` FOREIGN KEY (`analytical_model_registry_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytical_model_registry`(`analytical_model_registry_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ADD CONSTRAINT `fk_analytics_model_run_analytical_dataset_id` FOREIGN KEY (`analytical_dataset_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytical_dataset`(`analytical_dataset_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ADD CONSTRAINT `fk_analytics_model_run_parent_run_model_run_id` FOREIGN KEY (`parent_run_model_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`model_run`(`model_run_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ADD CONSTRAINT `fk_analytics_model_run_retrained_from_model_run_id` FOREIGN KEY (`retrained_from_model_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`model_run`(`model_run_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ADD CONSTRAINT `fk_analytics_feature_store_definition_analytical_dataset_id` FOREIGN KEY (`analytical_dataset_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytical_dataset`(`analytical_dataset_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ADD CONSTRAINT `fk_analytics_feature_store_definition_derived_from_feature_store_definition_id` FOREIGN KEY (`derived_from_feature_store_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`feature_store_definition`(`feature_store_definition_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ADD CONSTRAINT `fk_analytics_bi_report_definition_analytical_subject_area_id` FOREIGN KEY (`analytical_subject_area_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytical_subject_area`(`analytical_subject_area_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ADD CONSTRAINT `fk_analytics_bi_report_definition_drillthrough_bi_report_definition_id` FOREIGN KEY (`drillthrough_bi_report_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`bi_report_definition`(`bi_report_definition_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ADD CONSTRAINT `fk_analytics_network_analytics_kpi_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ADD CONSTRAINT `fk_analytics_network_analytics_kpi_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ADD CONSTRAINT `fk_analytics_network_analytics_kpi_prior_period_network_analytics_kpi_id` FOREIGN KEY (`prior_period_network_analytics_kpi_id`) REFERENCES `telecommunication_ecm`.`analytics`.`network_analytics_kpi`(`network_analytics_kpi_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ADD CONSTRAINT `fk_analytics_customer_analytics_kpi_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ADD CONSTRAINT `fk_analytics_customer_analytics_kpi_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ADD CONSTRAINT `fk_analytics_customer_analytics_kpi_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ADD CONSTRAINT `fk_analytics_customer_analytics_kpi_prior_period_customer_analytics_kpi_id` FOREIGN KEY (`prior_period_customer_analytics_kpi_id`) REFERENCES `telecommunication_ecm`.`analytics`.`customer_analytics_kpi`(`customer_analytics_kpi_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ADD CONSTRAINT `fk_analytics_revenue_analytics_kpi_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ADD CONSTRAINT `fk_analytics_revenue_analytics_kpi_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ADD CONSTRAINT `fk_analytics_revenue_analytics_kpi_prior_period_revenue_analytics_kpi_id` FOREIGN KEY (`prior_period_revenue_analytics_kpi_id`) REFERENCES `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi`(`revenue_analytics_kpi_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ADD CONSTRAINT `fk_analytics_segment_definition_parent_segment_segment_definition_id` FOREIGN KEY (`parent_segment_segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ADD CONSTRAINT `fk_analytics_segment_definition_parent_segment_definition_id` FOREIGN KEY (`parent_segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ADD CONSTRAINT `fk_analytics_analytics_segment_membership_model_run_id` FOREIGN KEY (`model_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`model_run`(`model_run_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ADD CONSTRAINT `fk_analytics_analytics_segment_membership_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ADD CONSTRAINT `fk_analytics_analytics_segment_membership_superseded_analytics_segment_membership_id` FOREIGN KEY (`superseded_analytics_segment_membership_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytics_segment_membership`(`analytics_segment_membership_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ADD CONSTRAINT `fk_analytics_analytical_dataset_analytical_subject_area_id` FOREIGN KEY (`analytical_subject_area_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytical_subject_area`(`analytical_subject_area_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ADD CONSTRAINT `fk_analytics_analytical_dataset_derived_from_analytical_dataset_id` FOREIGN KEY (`derived_from_analytical_dataset_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytical_dataset`(`analytical_dataset_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ADD CONSTRAINT `fk_analytics_pipeline_run_parent_pipeline_run_id` FOREIGN KEY (`parent_pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ADD CONSTRAINT `fk_analytics_pipeline_run_retry_of_pipeline_run_id` FOREIGN KEY (`retry_of_pipeline_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ADD CONSTRAINT `fk_analytics_glossary_term_replacement_term_glossary_term_id` FOREIGN KEY (`replacement_term_glossary_term_id`) REFERENCES `telecommunication_ecm`.`analytics`.`glossary_term`(`glossary_term_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ADD CONSTRAINT `fk_analytics_glossary_term_broader_glossary_term_id` FOREIGN KEY (`broader_glossary_term_id`) REFERENCES `telecommunication_ecm`.`analytics`.`glossary_term`(`glossary_term_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_revised_kpi_target_id` FOREIGN KEY (`revised_kpi_target_id`) REFERENCES `telecommunication_ecm`.`analytics`.`kpi_target`(`kpi_target_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ADD CONSTRAINT `fk_analytics_ab_test_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ADD CONSTRAINT `fk_analytics_ab_test_prior_iteration_ab_test_id` FOREIGN KEY (`prior_iteration_ab_test_id`) REFERENCES `telecommunication_ecm`.`analytics`.`ab_test`(`ab_test_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ADD CONSTRAINT `fk_analytics_ab_test_assignment_ab_test_id` FOREIGN KEY (`ab_test_id`) REFERENCES `telecommunication_ecm`.`analytics`.`ab_test`(`ab_test_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ADD CONSTRAINT `fk_analytics_ab_test_assignment_reassigned_from_ab_test_assignment_id` FOREIGN KEY (`reassigned_from_ab_test_assignment_id`) REFERENCES `telecommunication_ecm`.`analytics`.`ab_test_assignment`(`ab_test_assignment_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ADD CONSTRAINT `fk_analytics_retention_model_output_analytical_model_registry_id` FOREIGN KEY (`analytical_model_registry_id`) REFERENCES `telecommunication_ecm`.`analytics`.`analytical_model_registry`(`analytical_model_registry_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ADD CONSTRAINT `fk_analytics_retention_model_output_model_run_id` FOREIGN KEY (`model_run_id`) REFERENCES `telecommunication_ecm`.`analytics`.`model_run`(`model_run_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ADD CONSTRAINT `fk_analytics_retention_model_output_segment_definition_id` FOREIGN KEY (`segment_definition_id`) REFERENCES `telecommunication_ecm`.`analytics`.`segment_definition`(`segment_definition_id`);
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ADD CONSTRAINT `fk_analytics_retention_model_output_previous_retention_model_output_id` FOREIGN KEY (`previous_retention_model_output_id`) REFERENCES `telecommunication_ecm`.`analytics`.`retention_model_output`(`retention_model_output_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`analytics` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `telecommunication_ecm`.`analytics` SET TAGS ('dbx_domain' = 'analytics');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` SET TAGS ('dbx_subdomain' = 'kpi_management');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Definition Identifier');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `parent_kpi_definition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `aggregation_method` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Method');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `aggregation_period` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Period');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `benchmark_source` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Source');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `business_description` SET TAGS ('dbx_business_glossary_term' = 'Business Description');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `calculation_formula` SET TAGS ('dbx_business_glossary_term' = 'Calculation Formula');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `calculation_logic` SET TAGS ('dbx_business_glossary_term' = 'Calculation Logic');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `dashboard_visibility` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Visibility');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `dashboard_visibility` SET TAGS ('dbx_value_regex' = 'executive|management|operational|public|restricted');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `data_quality_rule` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Rule');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `data_source_table` SET TAGS ('dbx_business_glossary_term' = 'Data Source Table');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `data_type` SET TAGS ('dbx_business_glossary_term' = 'Data Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `data_type` SET TAGS ('dbx_value_regex' = 'integer|decimal|percentage|currency|ratio|boolean');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_category` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Category');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_category` SET TAGS ('dbx_value_regex' = 'network|customer|revenue|operational|quality|financial');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_code` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Code');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_definition_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_definition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|under_review|draft');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_name` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Subcategory');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `owner_domain` SET TAGS ('dbx_business_glossary_term' = 'Owner Domain');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `owner_role` SET TAGS ('dbx_business_glossary_term' = 'Owner Role');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `polarity` SET TAGS ('dbx_business_glossary_term' = 'Polarity');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `polarity` SET TAGS ('dbx_value_regex' = 'higher_is_better|lower_is_better|target_is_optimal|neutral');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `related_kpi_ids` SET TAGS ('dbx_business_glossary_term' = 'Related Key Performance Indicator (KPI) Identifiers');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `sla_applicable` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Applicable');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `strategic_objective` SET TAGS ('dbx_business_glossary_term' = 'Strategic Objective');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Tags');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `threshold_critical_high` SET TAGS ('dbx_business_glossary_term' = 'Critical High Threshold');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `threshold_critical_low` SET TAGS ('dbx_business_glossary_term' = 'Critical Low Threshold');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `threshold_warning_high` SET TAGS ('dbx_business_glossary_term' = 'Warning High Threshold');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `threshold_warning_low` SET TAGS ('dbx_business_glossary_term' = 'Warning Low Threshold');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `trend_direction` SET TAGS ('dbx_business_glossary_term' = 'Trend Direction');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `trend_direction` SET TAGS ('dbx_value_regex' = 'improving|declining|stable|volatile|not_applicable');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` SET TAGS ('dbx_subdomain' = 'reporting_analytics');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `reporting_dimension_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Dimension Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `parent_reporting_dimension_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `access_control_group` SET TAGS ('dbx_business_glossary_term' = 'Access Control Group');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `attribute_count` SET TAGS ('dbx_business_glossary_term' = 'Attribute Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `business_domain` SET TAGS ('dbx_business_glossary_term' = 'Business Domain');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `business_rules` SET TAGS ('dbx_business_glossary_term' = 'Business Rules');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `cardinality_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cardinality Estimate');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `compliance_tags` SET TAGS ('dbx_business_glossary_term' = 'Compliance Tags');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `conformed_flag` SET TAGS ('dbx_business_glossary_term' = 'Conformed Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `data_quality_rules` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Rules');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `data_steward` SET TAGS ('dbx_business_glossary_term' = 'Data Steward');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `dimension_code` SET TAGS ('dbx_business_glossary_term' = 'Dimension Code');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `dimension_description` SET TAGS ('dbx_business_glossary_term' = 'Dimension Description');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `dimension_name` SET TAGS ('dbx_business_glossary_term' = 'Dimension Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `dimension_owner` SET TAGS ('dbx_business_glossary_term' = 'Dimension Owner');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `dimension_status` SET TAGS ('dbx_business_glossary_term' = 'Dimension Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `dimension_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|proposed|retired|under_review');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `dimension_type` SET TAGS ('dbx_business_glossary_term' = 'Dimension Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `dimension_type` SET TAGS ('dbx_value_regex' = 'conformed|degenerate|role_playing|junk|slowly_changing|rapidly_changing');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `grain_description` SET TAGS ('dbx_business_glossary_term' = 'Grain Description');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `hierarchy_levels` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Levels');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `indexing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Indexing Strategy');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `primary_business_key` SET TAGS ('dbx_business_glossary_term' = 'Primary Business Key');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_business_glossary_term' = 'Refresh Frequency');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `related_fact_tables` SET TAGS ('dbx_business_glossary_term' = 'Related Fact Tables');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `related_kpi_count` SET TAGS ('dbx_business_glossary_term' = 'Related Key Performance Indicator (KPI) Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `role_playing_flag` SET TAGS ('dbx_business_glossary_term' = 'Role-Playing Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `scd_type` SET TAGS ('dbx_business_glossary_term' = 'Slowly Changing Dimension (SCD) Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `schema_name` SET TAGS ('dbx_business_glossary_term' = 'Schema Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `security_classification` SET TAGS ('dbx_business_glossary_term' = 'Security Classification');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `security_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `table_name` SET TAGS ('dbx_business_glossary_term' = 'Table Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `technology_platform` SET TAGS ('dbx_business_glossary_term' = 'Technology Platform');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` SET TAGS ('dbx_subdomain' = 'reporting_analytics');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `dimension_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Dimension Hierarchy Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `reporting_dimension_id` SET TAGS ('dbx_business_glossary_term' = 'Dimension Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `parent_dimension_hierarchy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `aggregation_function` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Function');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `business_owner` SET TAGS ('dbx_business_glossary_term' = 'Business Owner');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `data_steward` SET TAGS ('dbx_business_glossary_term' = 'Data Steward');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `hierarchy_code` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Code');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `hierarchy_description` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Description');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `hierarchy_name` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_value_regex' = 'balanced|ragged|unbalanced|network|parent_child');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `is_default_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Is Default Hierarchy Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `level_attribute_list` SET TAGS ('dbx_business_glossary_term' = 'Level Attribute List');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `level_cardinality` SET TAGS ('dbx_business_glossary_term' = 'Level Cardinality');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `level_code` SET TAGS ('dbx_business_glossary_term' = 'Level Code');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `level_key_column` SET TAGS ('dbx_business_glossary_term' = 'Level Key Column');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `level_name` SET TAGS ('dbx_business_glossary_term' = 'Level Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `level_name_column` SET TAGS ('dbx_business_glossary_term' = 'Level Name Column');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `level_ordinal_position` SET TAGS ('dbx_business_glossary_term' = 'Level Ordinal Position');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `olap_cube_name` SET TAGS ('dbx_business_glossary_term' = 'Online Analytical Processing (OLAP) Cube Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `parent_level_name` SET TAGS ('dbx_business_glossary_term' = 'Parent Level Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `supports_drill_down` SET TAGS ('dbx_business_glossary_term' = 'Supports Drill-Down Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `supports_roll_up` SET TAGS ('dbx_business_glossary_term' = 'Supports Roll-Up Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `usage_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Notes');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dimension_hierarchy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` SET TAGS ('dbx_subdomain' = 'reporting_analytics');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `analytical_subject_area_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Subject Area Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Data Product Owner Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `parent_analytical_subject_area_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `business_purpose` SET TAGS ('dbx_business_glossary_term' = 'Business Purpose');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `consumer_count` SET TAGS ('dbx_business_glossary_term' = 'Consumer Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `contains_pii_flag` SET TAGS ('dbx_business_glossary_term' = 'Contains Personally Identifiable Information (PII) Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `data_quality_rule_count` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Rule Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `dimension_count` SET TAGS ('dbx_business_glossary_term' = 'Dimension Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `documentation_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `fact_table_count` SET TAGS ('dbx_business_glossary_term' = 'Fact Table Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `kpi_family_count` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Family Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|under_development|retired|archived');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `owning_domain` SET TAGS ('dbx_business_glossary_term' = 'Owning Business Domain');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `platform_layer` SET TAGS ('dbx_business_glossary_term' = 'Platform Layer');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `platform_layer` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `primary_consumer_group` SET TAGS ('dbx_business_glossary_term' = 'Primary Consumer Group');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `primary_grain` SET TAGS ('dbx_business_glossary_term' = 'Primary Grain');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `primary_source_system` SET TAGS ('dbx_business_glossary_term' = 'Primary Source System');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `refresh_cadence` SET TAGS ('dbx_business_glossary_term' = 'Refresh Cadence');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `regulatory_scope` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Scope');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `sla_availability_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Availability Target Percentage');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `sla_refresh_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Refresh Target (Minutes)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `source_system_count` SET TAGS ('dbx_business_glossary_term' = 'Source System Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `subject_area_code` SET TAGS ('dbx_business_glossary_term' = 'Subject Area Code');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `subject_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `subject_area_name` SET TAGS ('dbx_business_glossary_term' = 'Subject Area Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `subject_area_type` SET TAGS ('dbx_business_glossary_term' = 'Subject Area Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `subject_area_type` SET TAGS ('dbx_value_regex' = 'operational|strategic|regulatory|customer_facing|network_performance|financial');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Tags');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_subject_area` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` SET TAGS ('dbx_subdomain' = 'data_quality');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `dq_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Identifier');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Owner Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `derived_from_dq_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `alert_channel` SET TAGS ('dbx_business_glossary_term' = 'Alert Notification Channel');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `alert_channel` SET TAGS ('dbx_value_regex' = 'email|slack|pagerduty|servicenow|webhook|none');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `alert_recipient_list` SET TAGS ('dbx_business_glossary_term' = 'Alert Recipient List');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `alert_recipient_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `business_impact` SET TAGS ('dbx_business_glossary_term' = 'Business Impact Description');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rule Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `data_lineage_reference` SET TAGS ('dbx_business_glossary_term' = 'Data Lineage Reference Identifier');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Rule Documentation URL');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `documentation_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Rule Effective End Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Rule Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `execution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Execution Frequency');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `execution_frequency` SET TAGS ('dbx_value_regex' = 'real-time|hourly|daily|weekly|monthly|on-demand');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `execution_layer` SET TAGS ('dbx_business_glossary_term' = 'Lakehouse Execution Layer');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `execution_layer` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Rule Indicator');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `is_blocking` SET TAGS ('dbx_business_glossary_term' = 'Blocking Rule Indicator');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `last_execution_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Last Execution Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `last_execution_status` SET TAGS ('dbx_value_regex' = 'success|failure|warning|skipped');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `last_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rule Last Execution Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Rule Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rule Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `last_pass_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Last Execution Pass Rate Percentage');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `regulatory_mandate` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Reference');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `related_kpi` SET TAGS ('dbx_business_glossary_term' = 'Related Key Performance Indicator (KPI)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `remediation_guidance` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Remediation Guidance');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Category');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_value_regex' = 'structural|semantic|business|regulatory');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Code');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}_[A-Z]{3}_[0-9]{3,5}$');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Description');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `rule_expression` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Expression');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'completeness|uniqueness|validity|consistency|timeliness|accuracy');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `rule_version` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Version');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `rule_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `sample_violation_query` SET TAGS ('dbx_business_glossary_term' = 'Sample Violation Query');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Severity Level');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor|warning');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Rule Tags');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `target_attribute` SET TAGS ('dbx_business_glossary_term' = 'Target Attribute Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `target_domain` SET TAGS ('dbx_business_glossary_term' = 'Target Data Domain');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `target_product` SET TAGS ('dbx_business_glossary_term' = 'Target Data Product');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `technical_implementation` SET TAGS ('dbx_business_glossary_term' = 'Technical Implementation Method');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `technical_implementation` SET TAGS ('dbx_value_regex' = 'spark_sql|python_udf|great_expectations|deequ|custom');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `threshold_operator` SET TAGS ('dbx_business_glossary_term' = 'Threshold Comparison Operator');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `threshold_operator` SET TAGS ('dbx_value_regex' = '>=|>|<=|<|=');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Threshold Percentage');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Rule Created By User');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` SET TAGS ('dbx_subdomain' = 'data_quality');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `dq_execution_result_id` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Execution Result ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `dq_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `rerun_of_dq_execution_result_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `business_date` SET TAGS ('dbx_business_glossary_term' = 'Business Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `data_steward_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Steward Notified Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `execution_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Execution Duration (Seconds)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `execution_mode` SET TAGS ('dbx_business_glossary_term' = 'Execution Mode');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `execution_mode` SET TAGS ('dbx_value_regex' = 'scheduled|manual|triggered|continuous');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `execution_status` SET TAGS ('dbx_value_regex' = 'passed|failed|warning|error|skipped');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `failure_sample_records` SET TAGS ('dbx_business_glossary_term' = 'Failure Sample Records');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `failure_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Failure Threshold Percentage');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `pass_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pass Rate Percentage');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `records_evaluated_count` SET TAGS ('dbx_business_glossary_term' = 'Records Evaluated Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `records_failed_count` SET TAGS ('dbx_business_glossary_term' = 'Records Failed Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `records_passed_count` SET TAGS ('dbx_business_glossary_term' = 'Records Passed Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Category');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `rule_category` SET TAGS ('dbx_value_regex' = 'completeness|validity|accuracy|consistency|timeliness|uniqueness');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Code');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[A-Z]{3}-[0-9]{3}$');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `rule_severity` SET TAGS ('dbx_business_glossary_term' = 'Rule Severity Level');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `rule_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `rule_version` SET TAGS ('dbx_business_glossary_term' = 'Rule Version');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `target_domain` SET TAGS ('dbx_business_glossary_term' = 'Target Domain');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `target_layer` SET TAGS ('dbx_business_glossary_term' = 'Target Lakehouse Layer');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `target_layer` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `target_product` SET TAGS ('dbx_business_glossary_term' = 'Target Data Product');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `warning_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Warning Threshold Percentage');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_execution_result` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` SET TAGS ('dbx_subdomain' = 'data_quality');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `dq_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Issue Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Network Element Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `dq_execution_result_id` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Execution Result Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `dq_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Rule Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Data Steward Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `related_dq_issue_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `affected_attribute` SET TAGS ('dbx_business_glossary_term' = 'Affected Data Attribute');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `affected_domain` SET TAGS ('dbx_business_glossary_term' = 'Affected Data Domain');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `affected_product` SET TAGS ('dbx_business_glossary_term' = 'Affected Data Product');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `affected_record_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Record Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `affected_report_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Report List');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `business_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Business Impact Description');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `compliance_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Impact Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detected Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'automated_rule|manual_review|user_report|reconciliation|audit');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `dq_dimension` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Dimension');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `dq_dimension` SET TAGS ('dbx_value_regex' = 'completeness|accuracy|consistency|validity|timeliness|uniqueness');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `estimated_revenue_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Impact');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `estimated_revenue_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `issue_description` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Issue Description');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `issue_number` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Issue Number');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `issue_number` SET TAGS ('dbx_value_regex' = '^DQI-[0-9]{8}$');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `issue_status` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Issue Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `issue_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_validation|resolved|closed|reopened');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `issue_title` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Issue Title');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Issue Priority');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'p1|p2|p3|p4');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified|failed');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolved Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'source_system_defect|etl_transformation_error|schema_change|business_rule_gap|data_entry_error|integration_failure');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `root_cause_detail` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Detail');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Issue Severity Level');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `sla_target_resolution_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Resolution Hours');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`analytics`.`dq_issue` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` SET TAGS ('dbx_subdomain' = 'model_operations');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `analytical_model_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Model Registry ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `analytical_subject_area_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Subject Area Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Model Owner Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `predecessor_analytical_model_registry_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `algorithm_name` SET TAGS ('dbx_business_glossary_term' = 'Algorithm Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `business_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Business Impact Description');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `business_use_case` SET TAGS ('dbx_business_glossary_term' = 'Business Use Case');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `deployment_status` SET TAGS ('dbx_value_regex' = 'development|testing|staging|production|retired|deprecated');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `explainability_method` SET TAGS ('dbx_business_glossary_term' = 'Explainability Method');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `fairness_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Fairness Assessment Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `fairness_assessment_status` SET TAGS ('dbx_value_regex' = 'not_assessed|passed|failed|in_progress');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `feature_list` SET TAGS ('dbx_business_glossary_term' = 'Feature List');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `framework` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Framework');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `hyperparameters` SET TAGS ('dbx_business_glossary_term' = 'Hyperparameters');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `inference_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Inference Latency in Milliseconds (ms)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `last_deployment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Deployment Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `last_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Training Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `model_artifact_path` SET TAGS ('dbx_business_glossary_term' = 'Model Artifact Path');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `model_category` SET TAGS ('dbx_business_glossary_term' = 'Model Category');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `model_category` SET TAGS ('dbx_value_regex' = 'supervised|unsupervised|semi_supervised|reinforcement|transfer_learning|federated');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `model_code` SET TAGS ('dbx_business_glossary_term' = 'Model Code');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `model_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Model Documentation URL');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `model_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Model Expiry Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `model_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Model Size in Megabytes (MB)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Model Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'regression|classification|clustering|time_series|deep_learning|ensemble');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `monitoring_enabled` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `performance_metric_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Performance Metric');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `performance_metric_auc` SET TAGS ('dbx_business_glossary_term' = 'Area Under Curve (AUC) Performance Metric');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `performance_metric_f1` SET TAGS ('dbx_business_glossary_term' = 'F1 Score Performance Metric');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `performance_metric_mae` SET TAGS ('dbx_business_glossary_term' = 'Mean Absolute Error (MAE) Performance Metric');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `performance_metric_precision` SET TAGS ('dbx_business_glossary_term' = 'Precision Performance Metric');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `performance_metric_recall` SET TAGS ('dbx_business_glossary_term' = 'Recall Performance Metric');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `performance_metric_rmse` SET TAGS ('dbx_business_glossary_term' = 'Root Mean Squared Error (RMSE) Performance Metric');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `refresh_schedule` SET TAGS ('dbx_business_glossary_term' = 'Model Refresh Schedule');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Risk Classification');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `risk_classification` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `serving_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Serving Endpoint');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `serving_platform` SET TAGS ('dbx_business_glossary_term' = 'Serving Platform');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `target_variable` SET TAGS ('dbx_business_glossary_term' = 'Target Variable');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `test_dataset_size` SET TAGS ('dbx_business_glossary_term' = 'Test Dataset Size');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `training_data_lineage` SET TAGS ('dbx_business_glossary_term' = 'Training Data Lineage');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `training_dataset_size` SET TAGS ('dbx_business_glossary_term' = 'Training Dataset Size');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_model_registry` ALTER COLUMN `validation_dataset_size` SET TAGS ('dbx_business_glossary_term' = 'Validation Dataset Size');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` SET TAGS ('dbx_subdomain' = 'model_operations');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `model_run_id` SET TAGS ('dbx_business_glossary_term' = 'Model Run Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `analytical_model_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Model Registry Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Executed By User Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `analytical_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Input Analytical Dataset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `parent_run_model_run_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Run Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Training Fraud Case Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `retrained_from_model_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `auc_score` SET TAGS ('dbx_business_glossary_term' = 'Area Under Curve (AUC) Score');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `cluster_code` SET TAGS ('dbx_business_glossary_term' = 'Cluster Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `compute_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Compute Cost in United States Dollars (USD)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `compute_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `drift_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Drift Detected Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `drift_score` SET TAGS ('dbx_business_glossary_term' = 'Drift Score');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `evaluation_metric_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Evaluation Metric Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `evaluation_metric_primary_value` SET TAGS ('dbx_business_glossary_term' = 'Primary Evaluation Metric Value');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `execution_environment` SET TAGS ('dbx_business_glossary_term' = 'Execution Environment');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `execution_environment` SET TAGS ('dbx_value_regex' = 'databricks_cluster|local|kubernetes|sagemaker|azure_ml|vertex_ai');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `experiment_code` SET TAGS ('dbx_business_glossary_term' = 'Experiment Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `f1_score` SET TAGS ('dbx_business_glossary_term' = 'F1 Score');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `feature_importance_path` SET TAGS ('dbx_business_glossary_term' = 'Feature Importance Path');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `hyperparameters_json` SET TAGS ('dbx_business_glossary_term' = 'Hyperparameters Configuration (JSON)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `input_record_count` SET TAGS ('dbx_business_glossary_term' = 'Input Record Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `is_baseline_run` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Run Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `is_production_candidate` SET TAGS ('dbx_business_glossary_term' = 'Is Production Candidate Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `mae_score` SET TAGS ('dbx_business_glossary_term' = 'Mean Absolute Error (MAE) Score');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `model_version_code` SET TAGS ('dbx_business_glossary_term' = 'Model Version Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `output_artifact_path` SET TAGS ('dbx_business_glossary_term' = 'Output Artifact Path');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `output_model_path` SET TAGS ('dbx_business_glossary_term' = 'Output Model Path');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `precision_score` SET TAGS ('dbx_business_glossary_term' = 'Precision Score');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `prediction_output_path` SET TAGS ('dbx_business_glossary_term' = 'Prediction Output Path');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `r_squared_score` SET TAGS ('dbx_business_glossary_term' = 'R-Squared Score');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `recall_score` SET TAGS ('dbx_business_glossary_term' = 'Recall Score');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `rmse_score` SET TAGS ('dbx_business_glossary_term' = 'Root Mean Squared Error (RMSE) Score');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `run_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Model Run Duration in Seconds');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `run_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Model Run End Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `run_name` SET TAGS ('dbx_business_glossary_term' = 'Model Run Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `run_notes` SET TAGS ('dbx_business_glossary_term' = 'Model Run Notes');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Model Run Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Model Run Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'success|failed|running|degraded|cancelled|pending');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `training_framework` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Training Framework');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `trigger_event_code` SET TAGS ('dbx_business_glossary_term' = 'Trigger Event Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Model Run Trigger Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `trigger_type` SET TAGS ('dbx_value_regex' = 'scheduled|manual|retraining_trigger|drift_detected|api_request|event_driven');
ALTER TABLE `telecommunication_ecm`.`analytics`.`model_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` SET TAGS ('dbx_subdomain' = 'model_operations');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_store_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Feature Store Definition ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `analytical_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Dataset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Business Owner Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `derived_from_feature_store_definition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `aggregation_window` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Window');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `computation_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Computation Duration Seconds');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `data_quality_rule` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Rule');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `entity_key_column` SET TAGS ('dbx_business_glossary_term' = 'Entity Key Column');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_category` SET TAGS ('dbx_business_glossary_term' = 'Feature Category');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_data_type` SET TAGS ('dbx_business_glossary_term' = 'Feature Data Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_description` SET TAGS ('dbx_business_glossary_term' = 'Feature Description');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_group_name` SET TAGS ('dbx_business_glossary_term' = 'Feature Group Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_importance_score` SET TAGS ('dbx_business_glossary_term' = 'Feature Importance Score');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_name` SET TAGS ('dbx_business_glossary_term' = 'Feature Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_status` SET TAGS ('dbx_business_glossary_term' = 'Feature Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_status` SET TAGS ('dbx_value_regex' = 'draft|active|deprecated|archived|experimental');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `feature_tags` SET TAGS ('dbx_business_glossary_term' = 'Feature Tags');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `is_pii` SET TAGS ('dbx_business_glossary_term' = 'Is Personally Identifiable Information (PII) Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `last_computed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Computed Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `model_names` SET TAGS ('dbx_business_glossary_term' = 'Model Names');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `model_usage_count` SET TAGS ('dbx_business_glossary_term' = 'Model Usage Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `null_handling_strategy` SET TAGS ('dbx_business_glossary_term' = 'Null Handling Strategy');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `null_percentage` SET TAGS ('dbx_business_glossary_term' = 'Null Percentage');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `offline_serving_enabled` SET TAGS ('dbx_business_glossary_term' = 'Offline Serving Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `online_serving_enabled` SET TAGS ('dbx_business_glossary_term' = 'Online Serving Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `partition_columns` SET TAGS ('dbx_business_glossary_term' = 'Partition Columns');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `row_count` SET TAGS ('dbx_business_glossary_term' = 'Row Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `source_domain` SET TAGS ('dbx_business_glossary_term' = 'Source Domain');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `technical_owner` SET TAGS ('dbx_business_glossary_term' = 'Technical Owner');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `timestamp_column` SET TAGS ('dbx_business_glossary_term' = 'Timestamp Column');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `transformation_language` SET TAGS ('dbx_business_glossary_term' = 'Transformation Language');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `transformation_language` SET TAGS ('dbx_value_regex' = 'SQL|PySpark|Python|Scala');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `transformation_logic` SET TAGS ('dbx_business_glossary_term' = 'Transformation Logic');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `update_frequency` SET TAGS ('dbx_business_glossary_term' = 'Update Frequency');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `usage_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Notes');
ALTER TABLE `telecommunication_ecm`.`analytics`.`feature_store_definition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` SET TAGS ('dbx_subdomain' = 'reporting_analytics');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `bi_report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Business Intelligence (BI) Report Definition ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `analytical_subject_area_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Subject Area Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `network_qos_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Qos Profile Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Report Owner Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `drillthrough_bi_report_definition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `access_tier` SET TAGS ('dbx_business_glossary_term' = 'Access Tier');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `access_tier` SET TAGS ('dbx_value_regex' = 'public|internal|restricted|confidential');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `average_load_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Average Load Time Seconds');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Certified Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `data_steward_name` SET TAGS ('dbx_business_glossary_term' = 'Data Steward Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `data_steward_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `decommission_candidate_flag` SET TAGS ('dbx_business_glossary_term' = 'Decommission Candidate Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `decommission_reason` SET TAGS ('dbx_business_glossary_term' = 'Decommission Reason');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `export_formats` SET TAGS ('dbx_business_glossary_term' = 'Export Formats');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `filter_count` SET TAGS ('dbx_business_glossary_term' = 'Filter Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `impact_analysis_notes` SET TAGS ('dbx_business_glossary_term' = 'Impact Analysis Notes');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `kpi_count` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `next_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Refresh Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `owning_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Owning Business Unit');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `primary_data_source` SET TAGS ('dbx_business_glossary_term' = 'Primary Data Source');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `publication_platform` SET TAGS ('dbx_business_glossary_term' = 'Publication Platform');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `publication_platform` SET TAGS ('dbx_value_regex' = 'databricks_sql|power_bi|tableau|qlik_sense|looker|custom');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `refresh_schedule` SET TAGS ('dbx_business_glossary_term' = 'Refresh Schedule');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `refresh_schedule` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|monthly|on_demand');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `refresh_time` SET TAGS ('dbx_business_glossary_term' = 'Refresh Time');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `regulatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `report_category` SET TAGS ('dbx_business_glossary_term' = 'Report Category');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `report_category` SET TAGS ('dbx_value_regex' = 'network_analytics|customer_analytics|revenue_analytics|operational_analytics|compliance_analytics|workforce_analytics');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `report_code` SET TAGS ('dbx_business_glossary_term' = 'Report Code');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `report_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `report_description` SET TAGS ('dbx_business_glossary_term' = 'Report Description');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `report_name` SET TAGS ('dbx_business_glossary_term' = 'Report Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|active|deprecated|retired|under_review');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'operational_dashboard|executive_scorecard|ad_hoc_report|regulatory_report|kpi_dashboard|analytical_report');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Report Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `report_version` SET TAGS ('dbx_business_glossary_term' = 'Report Version');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `report_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Days');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `secondary_data_sources` SET TAGS ('dbx_business_glossary_term' = 'Secondary Data Sources');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `sla_load_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Load Time Seconds');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `supports_drill_down` SET TAGS ('dbx_business_glossary_term' = 'Supports Drill Down');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `supports_export` SET TAGS ('dbx_business_glossary_term' = 'Supports Export');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `unique_user_count_last_30_days` SET TAGS ('dbx_business_glossary_term' = 'Unique User Count Last 30 Days');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `usage_count_last_30_days` SET TAGS ('dbx_business_glossary_term' = 'Usage Count Last 30 Days');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `visualization_count` SET TAGS ('dbx_business_glossary_term' = 'Visualization Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`bi_report_definition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` SET TAGS ('dbx_subdomain' = 'kpi_management');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `network_analytics_kpi_id` SET TAGS ('dbx_business_glossary_term' = 'Network Analytics Key Performance Indicator (KPI) ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `coverage_area_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Cable Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `ims_node_id` SET TAGS ('dbx_business_glossary_term' = 'Ims Node Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `spectrum_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Spectrum Allocation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Definition ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `mpls_tunnel_id` SET TAGS ('dbx_business_glossary_term' = 'Mpls Tunnel Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `topology_id` SET TAGS ('dbx_business_glossary_term' = 'Network Topology Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `pop_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Pop Facility Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `sla_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Contract ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `slice_id` SET TAGS ('dbx_business_glossary_term' = 'Network Slice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `transmission_link_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Link Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `prior_period_network_analytics_kpi_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `aggregation_function` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Function');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `alarm_correlation_code` SET TAGS ('dbx_business_glossary_term' = 'Alarm Correlation ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `business_date` SET TAGS ('dbx_business_glossary_term' = 'Business Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'real_time|batch|scheduled|on_demand');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `counter_name` SET TAGS ('dbx_business_glossary_term' = 'Counter Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `data_completeness_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Completeness Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `geographic_region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `kpi_category` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Category');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `kpi_category` SET TAGS ('dbx_value_regex' = 'accessibility|retainability|mobility|integrity|availability|utilization');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `kpi_code` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Code');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `kpi_name` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `measurement_granularity` SET TAGS ('dbx_business_glossary_term' = 'Measurement Granularity');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `measurement_granularity` SET TAGS ('dbx_value_regex' = 'raw|15min|hourly|daily|weekly|monthly');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'valid|suspect|invalid|estimated|missing');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `network_cluster_code` SET TAGS ('dbx_business_glossary_term' = 'Network Cluster ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `network_element_type` SET TAGS ('dbx_business_glossary_term' = 'Network Element Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `nms_source_system` SET TAGS ('dbx_business_glossary_term' = 'Network Management System (NMS) Source System');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `ran_type` SET TAGS ('dbx_business_glossary_term' = 'Radio Access Network (RAN) Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `ran_type` SET TAGS ('dbx_value_regex' = 'macro|micro|pico|femto|small_cell|distributed_antenna');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `sample_count` SET TAGS ('dbx_business_glossary_term' = 'Sample Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor|warning|normal');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `sla_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Applicable Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `technology_generation` SET TAGS ('dbx_business_glossary_term' = 'Technology Generation');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `threshold_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Threshold Breach Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `threshold_type` SET TAGS ('dbx_business_glossary_term' = 'Threshold Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `threshold_type` SET TAGS ('dbx_value_regex' = 'upper|lower|range');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`analytics`.`network_analytics_kpi` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` SET TAGS ('dbx_subdomain' = 'kpi_management');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `customer_analytics_kpi_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Analytics Key Performance Indicator (KPI) ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Definition ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `sim_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Sim Stock Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `prior_period_customer_analytics_kpi_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `alert_severity` SET TAGS ('dbx_business_glossary_term' = 'Alert Severity Level');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `alert_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|none');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `alert_threshold_breached` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Breached Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `benchmark_source` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Source');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `business_date` SET TAGS ('dbx_business_glossary_term' = 'Business Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'retail|online|telesales|partner|direct|indirect');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `is_benchmark` SET TAGS ('dbx_business_glossary_term' = 'Is Benchmark Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `kpi_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `kpi_unit_of_measure` SET TAGS ('dbx_value_regex' = 'currency|percentage|count|score|days|ratio');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `kpi_value` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Measured Value');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `measurement_grain` SET TAGS ('dbx_business_glossary_term' = 'Measurement Grain');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `measurement_grain` SET TAGS ('dbx_value_regex' = 'subscriber|account|segment|region|product|channel');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Notes');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `prior_period_value` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Key Performance Indicator (KPI) Value');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'prepaid|postpaid|hybrid|enterprise|wholesale');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Key Performance Indicator (KPI) Value');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `target_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Target Variance Amount');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `target_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Variance Percentage');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `telecommunication_ecm`.`analytics`.`customer_analytics_kpi` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` SET TAGS ('dbx_subdomain' = 'kpi_management');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `revenue_analytics_kpi_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Analytics Key Performance Indicator (KPI) ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `administrative_region_id` SET TAGS ('dbx_business_glossary_term' = 'Region ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Definition ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Product Line ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `prior_period_revenue_analytics_kpi_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `budget_target_value` SET TAGS ('dbx_business_glossary_term' = 'Budget Target Value');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `business_date` SET TAGS ('dbx_business_glossary_term' = 'Business Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `calculation_run_code` SET TAGS ('dbx_business_glossary_term' = 'Calculation Run ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `fiscal_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `is_outlier` SET TAGS ('dbx_business_glossary_term' = 'Is Outlier');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `kpi_status` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `kpi_status` SET TAGS ('dbx_value_regex' = 'final|preliminary|estimated|revised|forecasted|cancelled');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `measurement_granularity` SET TAGS ('dbx_business_glossary_term' = 'Measurement Granularity');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `measurement_granularity` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|yearly');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `measurement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `measurement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `outlier_reason` SET TAGS ('dbx_business_glossary_term' = 'Outlier Reason');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `prior_period_value` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Value');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `variance_to_budget` SET TAGS ('dbx_business_glossary_term' = 'Variance to Budget');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `variance_to_budget_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance to Budget Percentage');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `variance_to_prior_period` SET TAGS ('dbx_business_glossary_term' = 'Variance to Prior Period');
ALTER TABLE `telecommunication_ecm`.`analytics`.`revenue_analytics_kpi` ALTER COLUMN `variance_to_prior_period_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance to Prior Period Percentage');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` SET TAGS ('dbx_subdomain' = 'segment_governance');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `geographic_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Zone Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `parent_segment_segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Segment Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `parent_segment_definition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `actual_population_size` SET TAGS ('dbx_business_glossary_term' = 'Actual Population Size');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `associated_campaign_ids` SET TAGS ('dbx_business_glossary_term' = 'Associated Campaign Identifiers (IDs)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `associated_report_ids` SET TAGS ('dbx_business_glossary_term' = 'Associated Report Identifiers (IDs)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `business_objective` SET TAGS ('dbx_business_glossary_term' = 'Business Objective');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `business_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Business Owner Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `data_source_table` SET TAGS ('dbx_business_glossary_term' = 'Data Source Table');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `data_steward_name` SET TAGS ('dbx_business_glossary_term' = 'Data Steward Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `definition_criteria` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Criteria');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `is_default_segment` SET TAGS ('dbx_business_glossary_term' = 'Is Default Segment Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `next_scheduled_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Refresh Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `owning_analytics_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Analytics Team');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `privacy_consent_required` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Required Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_business_glossary_term' = 'Segment Refresh Frequency');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `segment_category` SET TAGS ('dbx_business_glossary_term' = 'Segment Category');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `segment_category` SET TAGS ('dbx_value_regex' = 'customer|market|product|network|revenue|churn');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|under_review|deprecated|archived');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'demographic|behavioral|value-based|lifecycle|geographic|technographic');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `supports_personalization` SET TAGS ('dbx_business_glossary_term' = 'Supports Personalization Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `supports_predictive_analytics` SET TAGS ('dbx_business_glossary_term' = 'Supports Predictive Analytics Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Segment Tags');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `target_arpu` SET TAGS ('dbx_business_glossary_term' = 'Target Average Revenue Per User (ARPU)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `target_churn_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Churn Rate Percentage');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `target_cltv` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Lifetime Value (CLTV)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `target_nps_score` SET TAGS ('dbx_business_glossary_term' = 'Target Net Promoter Score (NPS)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `target_population_size` SET TAGS ('dbx_business_glossary_term' = 'Target Population Size');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `usage_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Notes');
ALTER TABLE `telecommunication_ecm`.`analytics`.`segment_definition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` SET TAGS ('dbx_subdomain' = 'segment_governance');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `analytics_segment_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Override User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `model_run_id` SET TAGS ('dbx_business_glossary_term' = 'Model Run Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `superseded_analytics_segment_membership_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Method');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'rule_based|ml_model|manual_override|batch_process|real_time_event|api_trigger');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `assignment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Reason Code');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `assignment_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Reason Description');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `business_date` SET TAGS ('dbx_business_glossary_term' = 'Business Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Confidence Score');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|denied|pending|withdrawn|expired|not_required');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality (DQ) Score');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Effective End Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `evaluation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Segment Evaluation Frequency');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Segment Exclusion Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Segment Exclusion Reason');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Expiry Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `is_primary_segment` SET TAGS ('dbx_business_glossary_term' = 'Primary Segment Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `last_evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Evaluation Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|suspended|revoked');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `next_evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Next Evaluation Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Notes');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Reason');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `override_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Override Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Segment Priority Rank');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `propensity_score` SET TAGS ('dbx_business_glossary_term' = 'Segment Propensity Score');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `segment_entry_channel` SET TAGS ('dbx_business_glossary_term' = 'Segment Entry Channel');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytics_segment_membership` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Tags');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` SET TAGS ('dbx_subdomain' = 'reporting_analytics');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `analytical_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Dataset Identifier');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `analytical_subject_area_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Subject Area Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Dataset Owner Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Cable Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `spectrum_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Spectrum Allocation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Address Pool Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `network_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Equipment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `derived_from_analytical_dataset_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `access_classification_level` SET TAGS ('dbx_business_glossary_term' = 'Access Classification Level');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `access_classification_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `business_purpose` SET TAGS ('dbx_business_glossary_term' = 'Business Purpose');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `column_count` SET TAGS ('dbx_business_glossary_term' = 'Column Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `consumer_count` SET TAGS ('dbx_business_glossary_term' = 'Consumer Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `contains_pii_flag` SET TAGS ('dbx_business_glossary_term' = 'Contains Personally Identifiable Information (PII) Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `data_freshness_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Freshness Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `data_steward` SET TAGS ('dbx_business_glossary_term' = 'Data Steward');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `dataset_category` SET TAGS ('dbx_business_glossary_term' = 'Dataset Category');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `dataset_category` SET TAGS ('dbx_value_regex' = 'network_analytics|customer_analytics|revenue_analytics|churn_prediction|usage_analytics|quality_analytics');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `dataset_code` SET TAGS ('dbx_business_glossary_term' = 'Dataset Code');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `dataset_name` SET TAGS ('dbx_business_glossary_term' = 'Dataset Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `dataset_size_gb` SET TAGS ('dbx_business_glossary_term' = 'Dataset Size Gigabytes');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `dataset_type` SET TAGS ('dbx_business_glossary_term' = 'Dataset Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `dataset_type` SET TAGS ('dbx_value_regex' = 'training|scoring|reporting|feature_table|ad_hoc|exploratory');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `delta_table_path` SET TAGS ('dbx_business_glossary_term' = 'Delta Table Path');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `feature_count` SET TAGS ('dbx_business_glossary_term' = 'Feature Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `grain_description` SET TAGS ('dbx_business_glossary_term' = 'Grain Description');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `last_schema_change_date` SET TAGS ('dbx_business_glossary_term' = 'Last Schema Change Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|archived|in_development|retired|suspended');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `partition_key` SET TAGS ('dbx_business_glossary_term' = 'Partition Key');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `platform_layer` SET TAGS ('dbx_business_glossary_term' = 'Platform Layer');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `platform_layer` SET TAGS ('dbx_value_regex' = 'silver|gold');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `primary_consumer_group` SET TAGS ('dbx_business_glossary_term' = 'Primary Consumer Group');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `primary_source_system` SET TAGS ('dbx_business_glossary_term' = 'Primary Source System');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `refresh_schedule` SET TAGS ('dbx_business_glossary_term' = 'Refresh Schedule');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `refresh_schedule` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|monthly|on_demand');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `regulatory_scope` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Scope');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `retention_policy_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Days');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `row_count` SET TAGS ('dbx_business_glossary_term' = 'Row Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `schema_version` SET TAGS ('dbx_business_glossary_term' = 'Schema Version');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `sla_availability_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Availability Target Percentage');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `sla_refresh_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Refresh Target Minutes');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `source_lineage_summary` SET TAGS ('dbx_business_glossary_term' = 'Source Lineage Summary');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `source_system_count` SET TAGS ('dbx_business_glossary_term' = 'Source System Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Tags');
ALTER TABLE `telecommunication_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `usage_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Notes');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` SET TAGS ('dbx_subdomain' = 'model_operations');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `parent_pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Pipeline Run Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `retry_of_pipeline_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `business_date` SET TAGS ('dbx_business_glossary_term' = 'Business Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `bytes_processed` SET TAGS ('dbx_business_glossary_term' = 'Bytes Processed');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `bytes_written` SET TAGS ('dbx_business_glossary_term' = 'Bytes Written');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `compute_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Compute Cost in United States Dollars (USD)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `compute_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `data_freshness_sla_minutes` SET TAGS ('dbx_business_glossary_term' = 'Data Freshness Service Level Agreement (SLA) in Minutes');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score Percentage');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `databricks_cluster_code` SET TAGS ('dbx_business_glossary_term' = 'Databricks Cluster Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `databricks_job_run_code` SET TAGS ('dbx_business_glossary_term' = 'Databricks Job Run Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Execution Duration in Seconds');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pipeline End Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `execution_mode` SET TAGS ('dbx_business_glossary_term' = 'Execution Mode');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `execution_mode` SET TAGS ('dbx_value_regex' = 'full_load|incremental|delta|backfill|reprocess');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `execution_status` SET TAGS ('dbx_value_regex' = 'success|failed|partial|running|cancelled|timeout');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Initiated By User or System');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `pipeline_code` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Code');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `pipeline_name` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `pipeline_type` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `pipeline_type` SET TAGS ('dbx_value_regex' = 'ingestion|transformation|aggregation|model_scoring|data_quality|orchestration');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `pipeline_version` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Version');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `records_failed_count` SET TAGS ('dbx_business_glossary_term' = 'Records Failed Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `records_processed_count` SET TAGS ('dbx_business_glossary_term' = 'Records Processed Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `records_skipped_count` SET TAGS ('dbx_business_glossary_term' = 'Records Skipped Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `records_written_count` SET TAGS ('dbx_business_glossary_term' = 'Records Written Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `retry_attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Retry Attempt Number');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `sla_breach_reason` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Reason');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `target_domain` SET TAGS ('dbx_business_glossary_term' = 'Target Domain');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `target_layer` SET TAGS ('dbx_business_glossary_term' = 'Target Lakehouse Layer');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `target_layer` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `target_product` SET TAGS ('dbx_business_glossary_term' = 'Target Data Product');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Trigger Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`pipeline_run` ALTER COLUMN `trigger_type` SET TAGS ('dbx_value_regex' = 'scheduled|event_driven|manual|dependency_triggered|on_demand');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` SET TAGS ('dbx_subdomain' = 'segment_governance');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `glossary_term_id` SET TAGS ('dbx_business_glossary_term' = 'Glossary Term Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Data Steward Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `replacement_term_glossary_term_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Term Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `broader_glossary_term_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_required');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `business_context` SET TAGS ('dbx_business_glossary_term' = 'Business Context');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `business_definition` SET TAGS ('dbx_business_glossary_term' = 'Business Definition');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `calculation_formula` SET TAGS ('dbx_business_glossary_term' = 'Calculation Formula');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `data_product_mapping` SET TAGS ('dbx_business_glossary_term' = 'Data Product Mapping');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `data_type` SET TAGS ('dbx_business_glossary_term' = 'Data Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `deprecation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Reason');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `industry_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Industry Standard Reference');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `is_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Is Sensitive Data Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `kpi_linkage` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Linkage');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `owning_domain` SET TAGS ('dbx_business_glossary_term' = 'Owning Domain');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `primary_audience` SET TAGS ('dbx_business_glossary_term' = 'Primary Audience');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `related_terms` SET TAGS ('dbx_business_glossary_term' = 'Related Terms');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency in Months');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `strategic_importance` SET TAGS ('dbx_business_glossary_term' = 'Strategic Importance');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `strategic_importance` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `synonyms` SET TAGS ('dbx_business_glossary_term' = 'Synonyms');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Tags');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `technical_definition` SET TAGS ('dbx_business_glossary_term' = 'Technical Definition');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `term_category` SET TAGS ('dbx_business_glossary_term' = 'Term Category');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Term Code');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `term_name` SET TAGS ('dbx_business_glossary_term' = 'Term Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `term_status` SET TAGS ('dbx_business_glossary_term' = 'Term Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `term_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|published|deprecated|retired');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `term_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Term Subcategory');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `usage_examples` SET TAGS ('dbx_business_glossary_term' = 'Usage Examples');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `usage_frequency` SET TAGS ('dbx_business_glossary_term' = 'Usage Frequency');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `usage_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually|ad_hoc');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `usage_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Notes');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `valid_value_range` SET TAGS ('dbx_business_glossary_term' = 'Valid Value Range');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`analytics`.`glossary_term` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` SET TAGS ('dbx_subdomain' = 'kpi_management');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `kpi_target_id` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Target Identifier');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `administrative_region_id` SET TAGS ('dbx_business_glossary_term' = 'Administrative Region Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Definition Identifier');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Target Owner Identifier');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Target Network Element Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_owner_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `revised_kpi_target_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_review|approved|rejected|revision_required');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `baseline_period` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `benchmark_source` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Source');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `benchmark_value` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Value');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `business_dimension_type` SET TAGS ('dbx_business_glossary_term' = 'Business Dimension Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `business_dimension_type` SET TAGS ('dbx_value_regex' = 'region|product_line|channel|segment|service_type|network_technology');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `dashboard_visibility` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Visibility');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `dashboard_visibility` SET TAGS ('dbx_value_regex' = 'executive|management|operational|public|restricted');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `dimension_hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Dimension Hierarchy Level');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `dimension_value` SET TAGS ('dbx_business_glossary_term' = 'Business Dimension Value');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `incentive_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentive Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `incentive_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Incentive Weight Percentage');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `minimum_acceptable_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Acceptable Threshold');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `owning_domain` SET TAGS ('dbx_business_glossary_term' = 'Owning Domain');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'real-time|daily|weekly|monthly|quarterly|annual');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `sla_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Applicable Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `strategic_initiative_code` SET TAGS ('dbx_business_glossary_term' = 'Strategic Initiative Identifier');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `strategic_objective` SET TAGS ('dbx_business_glossary_term' = 'Strategic Objective');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `stretch_target_value` SET TAGS ('dbx_business_glossary_term' = 'Stretch Target Value');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_improvement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Improvement Percentage');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_owner_role` SET TAGS ('dbx_business_glossary_term' = 'Target Owner Role');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Target Period End Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Period Start Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_period_type` SET TAGS ('dbx_business_glossary_term' = 'Target Period Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|weekly|daily|semi-annual');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_rationale` SET TAGS ('dbx_business_glossary_term' = 'Target Rationale');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_status` SET TAGS ('dbx_business_glossary_term' = 'Target Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|active|suspended|archived');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`analytics`.`kpi_target` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` SET TAGS ('dbx_subdomain' = 'segment_governance');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `ab_test_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Identifier');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Owner Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `prior_iteration_ab_test_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `actual_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration in Days');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'random|stratified|cluster|systematic|adaptive');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Statistical Analysis Method');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `business_sponsor` SET TAGS ('dbx_business_glossary_term' = 'Business Sponsor');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `control_group_definition` SET TAGS ('dbx_business_glossary_term' = 'Control Group Definition');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `decision` SET TAGS ('dbx_business_glossary_term' = 'Business Decision');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `decision` SET TAGS ('dbx_value_regex' = 'implement|reject|iterate|monitor');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Experiment End Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `estimated_revenue_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Impact');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `estimated_revenue_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `ethical_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Ethical Review Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `experiment_category` SET TAGS ('dbx_business_glossary_term' = 'Experiment Category');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `experiment_category` SET TAGS ('dbx_value_regex' = 'pricing|network_config|retention|ui_ux|product_feature|marketing');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `hypothesis` SET TAGS ('dbx_business_glossary_term' = 'Test Hypothesis');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `minimum_detectable_effect` SET TAGS ('dbx_business_glossary_term' = 'Minimum Detectable Effect (MDE)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `observed_effect_size` SET TAGS ('dbx_business_glossary_term' = 'Observed Effect Size');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Analytics Team');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `p_value` SET TAGS ('dbx_business_glossary_term' = 'P-Value');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `planned_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration in Days');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Experimentation Platform');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `primary_success_metric` SET TAGS ('dbx_business_glossary_term' = 'Primary Success Metric');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `result_summary` SET TAGS ('dbx_business_glossary_term' = 'Result Summary');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `rollout_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rollout Percentage');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `sample_size_control` SET TAGS ('dbx_business_glossary_term' = 'Control Group Sample Size');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `sample_size_treatment` SET TAGS ('dbx_business_glossary_term' = 'Treatment Group Sample Size');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `sample_size_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `sample_size_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `secondary_metrics` SET TAGS ('dbx_business_glossary_term' = 'Secondary Metrics');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Experiment Start Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `statistical_power` SET TAGS ('dbx_business_glossary_term' = 'Statistical Power');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `statistical_significance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Statistical Significance Threshold');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `test_code` SET TAGS ('dbx_business_glossary_term' = 'Test Code');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `test_name` SET TAGS ('dbx_business_glossary_term' = 'Test Name');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'a_b|multivariate|holdout|sequential|factorial|bandit');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `treatment_group_definition` SET TAGS ('dbx_business_glossary_term' = 'Treatment Group Definition');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `treatment_group_definition` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `treatment_group_definition` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` SET TAGS ('dbx_subdomain' = 'segment_governance');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `ab_test_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Assignment Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `ab_test_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `reassigned_from_ab_test_assignment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `assignment_batch_code` SET TAGS ('dbx_business_glossary_term' = 'Assignment Batch Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `assignment_hash_seed` SET TAGS ('dbx_business_glossary_term' = 'Assignment Hash Seed Value');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'random_hash|stratified_random|propensity_score|manual|geographic_cluster|temporal_cohort');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `assignment_source_system` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source System');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|completed|withdrawn|excluded|invalidated');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `assignment_variant` SET TAGS ('dbx_business_glossary_term' = 'Assignment Variant Group');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `assignment_variant` SET TAGS ('dbx_value_regex' = 'control|treatment_a|treatment_b|treatment_c|treatment_d|holdout');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `assignment_weight` SET TAGS ('dbx_business_glossary_term' = 'Assignment Weight');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `control_group_flag` SET TAGS ('dbx_business_glossary_term' = 'Control Group Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `data_quality_notes` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Notes');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Reason');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `exclusion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `experiment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Experiment End Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `experiment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Experiment Start Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `exposure_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Exposure Confirmed Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `exposure_count` SET TAGS ('dbx_business_glossary_term' = 'Exposure Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `first_exposure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Exposure Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `pre_experiment_arpu` SET TAGS ('dbx_business_glossary_term' = 'Pre-Experiment Average Revenue Per User (ARPU)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `pre_experiment_arpu` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `pre_experiment_churn_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Pre-Experiment Churn Risk Score');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `pre_experiment_tenure_months` SET TAGS ('dbx_business_glossary_term' = 'Pre-Experiment Tenure Months');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `propensity_score` SET TAGS ('dbx_business_glossary_term' = 'Propensity Score');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `rate_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Code');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `stratification_segment` SET TAGS ('dbx_business_glossary_term' = 'Stratification Segment');
ALTER TABLE `telecommunication_ecm`.`analytics`.`ab_test_assignment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` SET TAGS ('dbx_subdomain' = 'model_operations');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `retention_model_output_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Model Output ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `analytical_model_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Model Registry ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `coverage_area_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `model_run_id` SET TAGS ('dbx_business_glossary_term' = 'Model Run ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `trouble_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Recent Trouble Ticket Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Ran Cell Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `previous_retention_model_output_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `arpu_at_scoring` SET TAGS ('dbx_business_glossary_term' = 'Average Revenue Per User (ARPU) at Scoring');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `business_date` SET TAGS ('dbx_business_glossary_term' = 'Business Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `churn_propensity_score` SET TAGS ('dbx_business_glossary_term' = 'Churn Propensity Score');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `churn_risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Churn Risk Tier');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `churn_risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `cltv_at_scoring` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) at Scoring');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `competitive_offer_exposure_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Offer Exposure Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `days_to_contract_end` SET TAGS ('dbx_business_glossary_term' = 'Days to Contract End');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `model_drift_flag` SET TAGS ('dbx_business_glossary_term' = 'Model Drift Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `predicted_churn_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Predicted Churn Horizon (Days)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `previous_churn_score` SET TAGS ('dbx_business_glossary_term' = 'Previous Churn Score');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'completed|failed|partial|pending_review');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `recent_complaint_count` SET TAGS ('dbx_business_glossary_term' = 'Recent Complaint Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `recent_payment_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Recent Payment Failure Count');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `recommended_retention_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Retention Action');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `retention_campaign_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Retention Campaign Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `score_change_direction` SET TAGS ('dbx_business_glossary_term' = 'Score Change Direction');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `score_change_direction` SET TAGS ('dbx_value_regex' = 'increased|decreased|stable|new_score');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `score_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Score Expiry Date');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `score_quality_indicator` SET TAGS ('dbx_business_glossary_term' = 'Score Quality Indicator');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `score_quality_indicator` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `scoring_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scoring Timestamp');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `tenure_months_at_scoring` SET TAGS ('dbx_business_glossary_term' = 'Tenure (Months) at Scoring');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `top_contributing_features` SET TAGS ('dbx_business_glossary_term' = 'Top Contributing Features (JSON)');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `usage_trend` SET TAGS ('dbx_business_glossary_term' = 'Usage Trend');
ALTER TABLE `telecommunication_ecm`.`analytics`.`retention_model_output` ALTER COLUMN `usage_trend` SET TAGS ('dbx_value_regex' = 'increasing|stable|declining|volatile');
