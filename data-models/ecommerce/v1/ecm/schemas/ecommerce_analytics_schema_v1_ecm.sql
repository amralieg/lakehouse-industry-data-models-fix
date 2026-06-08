-- Schema for Domain: analytics | Business: Ecommerce | Version: v1_ecm
-- Generated on: 2026-05-04 23:24:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`analytics` COMMENT 'Owns business intelligence data products including KPI definitions, metric calculations, reporting dimensions, forecast models, and operational dashboards metadata. Provides the semantic layer for enterprise reporting and advanced analytics.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` (
    `kpi_definition_id` BIGINT COMMENT 'Unique surrogate key for each KPI definition. _canonical_skip_reason: Entity does not fit standard role categories and is a master registry of KPI metadata.',
    `account_id` BIGINT COMMENT 'Identifier of the business party (e.g., department, team, or individual) responsible for the KPI.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: KPI definitions are often scoped to product categories for category performance reporting and targets.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: KPIs like "Price Elasticity per List" are defined per price list; the FK ties the KPI definition to its relevant price list.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Regulatory reporting KPIs must be tied to a specific regulation; linking KPI to regulation enables compliance reporting and audit traceability.',
    `parent_kpi_definition_id` BIGINT COMMENT 'Self-referencing FK on kpi_definition (parent_kpi_definition_id)',
    `aggregation_level` STRING COMMENT 'Granularity at which the KPI is aggregated for reporting.. Valid values are `transaction|daily|weekly|monthly|quarterly|yearly`',
    `business_line` STRING COMMENT 'High‑level business line or division (e.g., Marketplace, Fulfillment) that the KPI supports.',
    `calculation_formula` STRING COMMENT 'Logical expression or algorithm used to compute the KPI from source data elements.',
    `change_log` STRING COMMENT 'Free‑text log of modifications made to the KPI definition, including rationale.',
    `compliance_requirements` STRING COMMENT 'Regulatory or internal compliance constraints that the KPI must satisfy (e.g., GDPR, SOX).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the KPI definition record was first created in the registry.',
    `data_classification` STRING COMMENT 'Classification level of the KPI data according to enterprise data policy.. Valid values are `restricted|confidential|internal|public`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing the assessed quality of the source data feeding the KPI.',
    `data_source_domain` STRING COMMENT 'Primary data domain (e.g., order, customer, finance) that supplies the raw inputs for the KPI.',
    `effective_from` DATE COMMENT 'Date when the KPI definition becomes valid for reporting.',
    `effective_until` DATE COMMENT 'Date when the KPI definition is retired or superseded (null if indefinite).',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the KPI contains confidential information that requires restricted access.',
    `kpi_definition_status` STRING COMMENT 'Current lifecycle status of the KPI definition.. Valid values are `active|inactive|deprecated|draft|pending`',
    `kpi_description` STRING COMMENT 'Detailed business description of what the KPI measures and why it matters.',
    `kpi_name` STRING COMMENT 'Human‑readable name of the KPI as used in reports and dashboards.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the last formal review of the KPI definition for relevance and accuracy.',
    `metric_category` STRING COMMENT 'Broad category of the metric such as Performance, Financial, Operational, or Customer.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the KPI.',
    `owner_role` STRING COMMENT 'Business role or title of the KPI owner (e.g., Finance Analyst, Marketing Manager).',
    `refresh_cadence` STRING COMMENT 'Frequency at which the KPI value is recomputed and refreshed in reporting.. Valid values are `real_time|hourly|daily|weekly|monthly|quarterly`',
    `regulatory_reporting_requirement` STRING COMMENT 'Specific regulatory reporting mandate (e.g., SEC, GDPR) that the KPI fulfills.',
    `related_kpi_ids` STRING COMMENT 'Comma‑separated list of other KPI definition IDs that are logically related or derived.',
    `reporting_frequency` STRING COMMENT 'How often the KPI is expected to be reported to stakeholders.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `target_threshold_lower` DECIMAL(18,2) COMMENT 'Lower bound of the acceptable KPI range (used when threshold_type = range).',
    `target_threshold_type` STRING COMMENT 'Indicates whether the KPI has an upper bound, lower bound, or a range of acceptable values.. Valid values are `upper|lower|range`',
    `target_threshold_upper` DECIMAL(18,2) COMMENT 'Upper bound of the acceptable KPI range (used when threshold_type = range).',
    `target_value` DECIMAL(18,2) COMMENT 'Numeric target that the KPI is expected to achieve (used for single‑threshold KPIs).',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the KPI value is expressed.. Valid values are `count|percent|currency|seconds|minutes|hours`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the KPI definition.',
    `version_number` STRING COMMENT 'Incremental version of the KPI definition to track changes over time.',
    CONSTRAINT pk_kpi_definition PRIMARY KEY(`kpi_definition_id`)
) COMMENT 'Master registry of all enterprise KPI definitions used across business intelligence and reporting. Captures KPI name, business description, calculation formula, unit of measure, target thresholds, owner, data source domain, refresh cadence, and governance metadata. Serves as the semantic layer contract between data producers and BI consumers. Owned by the analytics domain as the authoritative catalog of what each metric means and how it is computed.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`metric_value` (
    `metric_value_id` BIGINT COMMENT 'Unique identifier for the metric value record.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Required for KPI dashboards that show metric values per marketing campaign, enabling campaign‑level performance analysis.',
    `center_id` BIGINT COMMENT 'Foreign key linking to fulfillment.center. Business justification: Needed for Center Performance KPI reports that track metrics per fulfillment center (e.g., daily throughput).',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: Supports order‑processing time and volume metrics that must reference the exact fulfillment order.',
    `indexed_document_id` BIGINT COMMENT 'Foreign key linking to search.indexed_document. Business justification: KPI Document Click‑Through Rate report needs to tie metric values to specific indexed documents for performance tracking.',
    `item_id` BIGINT COMMENT 'Foreign key linking to content.content_item. Business justification: Required for the Content Performance KPI Report which tracks KPI values per individual content item, enabling per‑page performance dashboards.',
    `kpi_definition_id` BIGINT COMMENT 'Identifier of the KPI definition that this metric value belongs to.',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Needed for shipment‑level KPI reporting (e.g., on‑time delivery) used in operational dashboards.',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Required for transaction‑level KPI drill‑down reports that let analysts trace metric values back to the underlying payment transaction.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Metrics such as average discount or price elasticity are calculated per price list; linking metric values to price_list provides traceability.',
    `procurement_goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_goods_receipt. Business justification: Receiving efficiency KPI tracks goods receipt timeliness per receipt, requiring metric values linked to procurement_goods_receipt.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Spend analysis and PO cycle‑time KPI need metric values tied to the originating purchase order.',
    `result_id` BIGINT COMMENT 'Foreign key linking to search.result. Business justification: Result‑position performance KPI aggregates metrics per search result; linking enables per‑result analysis in dashboards.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Required for Seller Performance KPI dashboards; stores metric values per seller for reporting and payout calculations.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Required for SKU‑level KPI dashboards that track conversion, sales, and inventory metrics per SKU.',
    `snapshot_id` BIGINT COMMENT 'Foreign key linking to inventory.snapshot. Business justification: Metric values are derived from a particular inventory snapshot; the FK enables reproducibility of metric calculations and traceability.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Supplier performance KPI dashboard requires linking metric values to each supplier to calculate on‑time delivery and cost metrics.',
    `prior_period_metric_value_id` BIGINT COMMENT 'Self-referencing FK on metric_value (prior_period_metric_value_id)',
    `computation_method` STRING COMMENT 'Method used to compute the metric (e.g., aggregation, statistical model, manual entry).',
    `compute_timestamp` TIMESTAMP COMMENT 'Timestamp when the metric value was calculated or materialized.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Confidence level (0‑100) associated with the metric value, typically for predictive or ML‑derived metrics.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code when the metric is monetary.. Valid values are `^[A-Z]{3}$`',
    `data_freshness_indicator` STRING COMMENT 'Indicator of how current the metric data is.. Valid values are `fresh|stale|delayed`',
    `dimension_category` STRING COMMENT 'Product category dimension associated with the metric.',
    `dimension_channel` STRING COMMENT 'Sales channel dimension (e.g., online, mobile app, physical store).. Valid values are `online|mobile|store`',
    `dimension_region` STRING COMMENT 'Three‑letter ISO country code representing the geographic region.. Valid values are `^[A-Z]{3}$`',
    `dimension_seller_tier` STRING COMMENT 'Seller tier classification (e.g., gold, silver, bronze).. Valid values are `gold|silver|bronze`',
    `is_estimated` BOOLEAN COMMENT 'Indicates whether the metric value is an estimate rather than a definitive measurement.',
    `metric_name` STRING COMMENT 'Human‑readable name of the metric or KPI.',
    `metric_timestamp` TIMESTAMP COMMENT 'Timestamp representing the point in time the metric value applies to (e.g., end of the reporting period).',
    `metric_value` DECIMAL(18,2) COMMENT 'Calculated numeric result of the metric.',
    `metric_value_status` STRING COMMENT 'Current lifecycle status of the metric record.. Valid values are `active|inactive|archived`',
    `notes` STRING COMMENT 'Free‑form text for any additional context, comments, or exceptions related to the metric value.',
    `period_end_date` DATE COMMENT 'End date of the reporting period covered by the metric.',
    `period_grain` STRING COMMENT 'Granularity of the reporting period for the metric.. Valid values are `daily|weekly|monthly|quarterly|yearly`',
    `period_start_date` DATE COMMENT 'Start date of the reporting period covered by the metric.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the metric record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the metric record.',
    `source_system` STRING COMMENT 'Name of the source system that generated the underlying data for this metric.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the metric value (e.g., USD, count, percent).',
    CONSTRAINT pk_metric_value PRIMARY KEY(`metric_value_id`)
) COMMENT 'Transactional store of computed metric values for each KPI definition across time periods, business dimensions, and organizational units. Captures the calculated numeric result, period grain (daily/weekly/monthly), dimensional context (channel, region, category, seller tier), computation timestamp, and data freshness indicators. Serves as the pre-aggregated semantic layer powering dashboards and self-service BI tools without requiring raw transactional joins.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` (
    `reporting_dimension_id` BIGINT COMMENT 'Unique surrogate key for the reporting dimension.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Reporting dimensions need a direct link to product_category to support hierarchical drill‑downs in analytics.',
    `parent_dimension_reporting_dimension_id` BIGINT COMMENT 'Identifier of the immediate parent dimension in the hierarchy.',
    `warehouse_node_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_node. Business justification: Needed for Warehouse Location dimension in dashboards, linking dimension rows to actual warehouse nodes for accurate location‑based KPI reporting.',
    `parent_reporting_dimension_id` BIGINT COMMENT 'Self-referencing FK on reporting_dimension (parent_reporting_dimension_id)',
    `confidentiality_level` STRING COMMENT 'Data classification level for the dimension metadata.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the dimension record was created in the system.',
    `default_format` STRING COMMENT 'Default display format for dimension values (e.g., yyyy-MM-dd).',
    `default_sort_order` STRING COMMENT 'Default ordering direction for the dimension values.. Valid values are `asc|desc`',
    `dimension_group` STRING COMMENT 'Logical grouping of dimensions for reporting purposes.',
    `domain` STRING COMMENT 'Business domain to which the dimension belongs.. Valid values are `analytics|finance|marketing|sales|inventory|fulfillment`',
    `effective_from` DATE COMMENT 'Date from which the dimension definition is effective.',
    `effective_until` DATE COMMENT 'Date until which the dimension definition is effective; null if indefinite.',
    `grain_level` STRING COMMENT 'Temporal granularity of the dimension when applicable.. Valid values are `day|week|month|quarter|year`',
    `hierarchy_depth` STRING COMMENT 'Number of levels in the dimension hierarchy.',
    `hierarchy_path` STRING COMMENT 'Delimited path representing the full hierarchy (e.g., Country>State>City).',
    `is_custom` BOOLEAN COMMENT 'Indicates whether the dimension is custom‑defined rather than standard.',
    `is_hierarchical` BOOLEAN COMMENT 'Flag indicating whether the dimension has a hierarchical structure.',
    `is_time_dimension` BOOLEAN COMMENT 'Flag indicating whether the dimension represents time.',
    `is_time_zone_aware` BOOLEAN COMMENT 'Flag indicating if the dimension accounts for time zones.',
    `measurement_unit` STRING COMMENT 'Unit of measure associated with the dimension when it represents a quantitative attribute.',
    `reporting_dimension_code` STRING COMMENT 'Unique business code identifying the dimension across systems.',
    `reporting_dimension_description` STRING COMMENT 'Detailed description of the dimension purpose and usage.',
    `reporting_dimension_name` STRING COMMENT 'Human‑readable name of the reporting dimension used in analytics and dashboards.',
    `reporting_dimension_status` STRING COMMENT 'Current lifecycle status of the dimension.. Valid values are `active|inactive|deprecated|draft`',
    `reporting_dimension_type` STRING COMMENT 'Category of the dimension indicating its analytical purpose.. Valid values are `time|geography|product_hierarchy|customer_segment|channel|seller_tier`',
    `source_system` STRING COMMENT 'Originating operational system that defines the dimension.',
    `time_zone` STRING COMMENT 'Standard time zone identifier associated with the dimension.. Valid values are `UTC|[A-Z]{3}`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the dimension record.',
    `version` STRING COMMENT 'Version number of the dimension definition.',
    CONSTRAINT pk_reporting_dimension PRIMARY KEY(`reporting_dimension_id`)
) COMMENT 'Master catalog of all reporting dimensions available in the enterprise semantic layer. Defines dimension name, dimension type (time, geography, product hierarchy, customer segment, channel, seller tier), grain level, associated domain, and hierarchy depth. Provides the authoritative list of slicing and dicing axes available to BI consumers and ensures consistent dimensional labeling across all dashboards and reports.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`dimension_member` (
    `dimension_member_id` BIGINT COMMENT 'Unique surrogate key for each dimension member record.',
    `parent_member_dimension_member_id` BIGINT COMMENT 'Identifier of the immediate parent member in the hierarchy, enabling tree traversal.',
    `parent_dimension_member_id` BIGINT COMMENT 'Self-referencing FK on dimension_member (parent_dimension_member_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dimension member record was first created in the system.',
    `dimension_member_description` STRING COMMENT 'Optional free‑text description providing additional context about the member.',
    `dimension_member_level` STRING COMMENT 'Depth of the member within the hierarchy (root = 0).',
    `effective_from` DATE COMMENT 'Date when the member becomes valid for reporting.',
    `effective_to` DATE COMMENT 'Date when the member ceases to be valid; null indicates open‑ended.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the member is currently active in the dimension.',
    `member_code` STRING COMMENT 'Business identifier code for the dimension member (e.g., SKU, GEO code, org unit code).',
    `member_name` STRING COMMENT 'Human‑readable name or label of the dimension member.',
    `member_type` STRING COMMENT 'Classification of the dimension member indicating the domain it belongs to (e.g., product category, geographic region, organizational unit).. Valid values are `product|geography|organization|customer_segment|seller|marketing`',
    `sort_order` STRING COMMENT 'Ordinal position of the member among its siblings for display ordering.',
    `source_system` STRING COMMENT 'Name of the operational system of record that supplied the member (e.g., OMS, WMS, PIM, CDP).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the dimension member record.',
    CONSTRAINT pk_dimension_member PRIMARY KEY(`dimension_member_id`)
) COMMENT 'Master record for individual members within a reporting dimension hierarchy. Captures member code, member label, parent member reference for hierarchy traversal, sort order, level within hierarchy, effective date range, and is_active flag. Enables consistent roll-up and drill-down navigation across product categories, geographies, organizational units, and customer segments in all BI tools.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` (
    `dashboard_definition_id` BIGINT COMMENT 'Unique surrogate key for each dashboard definition record.',
    `team_id` BIGINT COMMENT 'Foreign key linking to service.team. Business justification: Dashboards are owned by specific support teams; linking owner_team_id to team.team_id supports governance and access control.',
    `cloned_from_dashboard_definition_id` BIGINT COMMENT 'Self-referencing FK on dashboard_definition (cloned_from_dashboard_definition_id)',
    `access_tier` STRING COMMENT 'Security classification governing who may view the dashboard.. Valid values are `public|internal|confidential|restricted`',
    `approval_status` STRING COMMENT 'Governance approval state of the dashboard.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name of the individual or role that approved the dashboard.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the dashboard received approval.',
    `compliance_status` STRING COMMENT 'Indicates whether the dashboard meets regulatory and internal compliance requirements.. Valid values are `compliant|non_compliant|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the dashboard definition record was first created.',
    `dashboard_definition_code` STRING COMMENT 'Business identifier or short code used to reference the dashboard in governance systems.',
    `dashboard_definition_description` STRING COMMENT 'Detailed textual description of the dashboards purpose and content.',
    `dashboard_definition_name` STRING COMMENT 'Human‑readable name of the dashboard as displayed to users.',
    `dashboard_definition_status` STRING COMMENT 'Current lifecycle state of the dashboard.. Valid values are `draft|published|retired|archived`',
    `dashboard_definition_type` STRING COMMENT 'Classification of the dashboard by primary audience or purpose.. Valid values are `operational|executive|seller|finance|marketing|analytics`',
    `data_domains` STRING COMMENT 'Comma‑separated list of data domains (customer, product, order, etc.) used by the dashboard.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Composite score (0‑100) reflecting the quality of source data feeding the dashboard.',
    `deprecation_date` DATE COMMENT 'Planned date for retiring the dashboard from active use.',
    `is_template` BOOLEAN COMMENT 'Indicates whether the dashboard serves as a reusable template for other dashboards.',
    `last_modified_by` STRING COMMENT 'User or service that performed the most recent update to the dashboard definition.',
    `last_refreshed_timestamp` TIMESTAMP COMMENT 'Date‑time when the dashboard data was last refreshed.',
    `layout_configuration` STRING COMMENT 'JSON string describing the visual layout, tile arrangement, and sizing of the dashboard.',
    `metric_count` STRING COMMENT 'Number of distinct metrics displayed on the dashboard.',
    `notes` STRING COMMENT 'Free‑form comments or annotations about the dashboard.',
    `privacy_level` STRING COMMENT 'Privacy classification aligned with corporate data protection policies.. Valid values are `public|internal|confidential|restricted`',
    `publication_status` STRING COMMENT 'Indicates whether the dashboard is publicly available, hidden, or scheduled for release.. Valid values are `published|unpublished|scheduled`',
    `refresh_frequency` STRING COMMENT 'How often the dashboard data is refreshed (e.g., real‑time, hourly, daily).',
    `retention_policy` STRING COMMENT 'Policy governing how long the dashboard definition is retained after deprecation.',
    `source_system` STRING COMMENT 'Underlying analytics platform or tool that authored the dashboard (e.g., Databricks, Tableau).',
    `target_audience` STRING COMMENT 'Primary consumer group for the dashboard.. Valid values are `executive|operational|seller|finance|marketing|analytics`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the dashboard definition.',
    `version_number` STRING COMMENT 'Incremental version identifier for change management.',
    `visualization_count` STRING COMMENT 'Total number of visual components (charts, tables, maps) in the dashboard.',
    CONSTRAINT pk_dashboard_definition PRIMARY KEY(`dashboard_definition_id`)
) COMMENT 'Master record for each operational and executive dashboard deployed on the analytics platform. Captures dashboard name, business owner, target audience (executive, operational, seller, finance), refresh frequency, data domains consumed, layout configuration metadata, publication status, and access tier. Serves as the governance registry for all dashboards ensuring discoverability and ownership accountability.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` (
    `dashboard_widget_id` BIGINT COMMENT 'Unique identifier for the dashboard widget.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Widgets often display campaign‑specific charts; linking ties widget data to the campaign it visualises.',
    `dashboard_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.dashboard_definition. Business justification: Dashboard widgets belong to a dashboard; adding dashboard_definition_id creates parent link and removes no redundant columns.',
    `agent_id` BIGINT COMMENT 'Foreign key linking to service.agent. Business justification: Widgets may be customized by individual agents; linking owner_agent_id to agent.agent_id tracks widget ownership and change history.',
    `drilldown_dashboard_widget_id` BIGINT COMMENT 'Self-referencing FK on dashboard_widget (drilldown_dashboard_widget_id)',
    `bound_kpi` STRING COMMENT 'Identifier of the KPI or metric bound to the widget.',
    `chart_color_scheme` STRING COMMENT 'Selected color scheme for chart visualizations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the widget record was initially created.',
    `dashboard_widget_description` STRING COMMENT 'Detailed description of the widget purpose and content.',
    `dashboard_widget_name` STRING COMMENT 'Human readable name of the dashboard widget.',
    `dashboard_widget_status` STRING COMMENT 'Current lifecycle status of the widget.. Valid values are `active|inactive|archived|draft`',
    `data_source` STRING COMMENT 'Name or identifier of the underlying data source or query used by the widget.',
    `dimension_filters` STRING COMMENT 'Serialized list of dimensional filters applied to the widget data.',
    `display_format` STRING COMMENT 'Formatting options for the widget display, such as number format, color scheme, or unit.',
    `drilldown_enabled` BOOLEAN COMMENT 'Flag indicating whether drill‑down navigation is enabled.',
    `error_state` STRING COMMENT 'Current error state of the widget after the last refresh.. Valid values are `none|warning|error`',
    `exportable` BOOLEAN COMMENT 'Indicates if the widget data can be exported by end users.',
    `height` STRING COMMENT 'Height of the widget in grid units.',
    `is_shared` BOOLEAN COMMENT 'Indicates whether the widget is shared across multiple dashboards.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Timestamp of the last successful data refresh for the widget.',
    `position_x` STRING COMMENT 'Horizontal grid column position of the widget within the dashboard layout.',
    `position_y` STRING COMMENT 'Vertical grid row position of the widget within the dashboard layout.',
    `refresh_interval_minutes` STRING COMMENT 'Data refresh interval for the widget in minutes.',
    `tooltip_enabled` BOOLEAN COMMENT 'Flag indicating whether tooltips are enabled on the widget.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the widget record.',
    `version_number` STRING COMMENT 'Version number of the widget definition for change tracking.',
    `widget_type` STRING COMMENT 'Type of visualization displayed by the widget.. Valid values are `bar_chart|line_chart|scorecard|table|funnel|heatmap`',
    `width` STRING COMMENT 'Width of the widget in grid units.',
    CONSTRAINT pk_dashboard_widget PRIMARY KEY(`dashboard_widget_id`)
) COMMENT 'Master record for individual visualization widgets embedded within a dashboard. Captures widget name, widget type (bar chart, line chart, scorecard, table, funnel, heatmap), bound KPI or metric, dimensional filters applied, display format, position coordinates within the dashboard layout, and data refresh configuration. Enables fine-grained governance and reuse of visualization components across multiple dashboards.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`forecast_model` (
    `forecast_model_id` BIGINT COMMENT 'Unique surrogate key for the forecast model record.',
    `snapshot_id` BIGINT COMMENT 'Identifier of the immutable data snapshot used for training.',
    `superseded_forecast_model_id` BIGINT COMMENT 'Self-referencing FK on forecast_model (superseded_forecast_model_id)',
    `algorithm_family` STRING COMMENT 'Machine‑learning algorithm family used to build the model.. Valid values are `ARIMA|Prophet|XGBoost|LSTM|RandomForest|LinearRegression`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the model record was first created.',
    `data_privacy_level` STRING COMMENT 'Classified privacy level of the models input data.. Valid values are `public|internal|confidential|restricted`',
    `deployment_status` STRING COMMENT 'Current lifecycle state of the model in production.. Valid values are `deployed|testing|retired|failed`',
    `evaluation_metric` STRING COMMENT 'Primary metric used to assess model performance.. Valid values are `MAPE|RMSE|MAE|R2`',
    `feature_set_description` STRING COMMENT 'Narrative description of the features engineered for model training.',
    `forecast_horizon_days` STRING COMMENT 'Number of future days the model forecasts.',
    `hyperparameters` STRING COMMENT 'JSON‑encoded hyper‑parameter settings for the model.',
    `last_trained_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent model training run.',
    `model_accuracy_percent` DECIMAL(18,2) COMMENT 'Overall accuracy of the model expressed as a percentage.',
    `model_deployment_environment` STRING COMMENT 'Target environment where the model is deployed.. Valid values are `production|staging|dev`',
    `model_deployment_timestamp` TIMESTAMP COMMENT 'Timestamp when the model was deployed to the target environment.',
    `model_description` STRING COMMENT 'Detailed narrative of model purpose, scope, and methodology.',
    `model_endpoint_url` STRING COMMENT 'HTTP endpoint exposing the model for inference.',
    `model_feature_count` STRING COMMENT 'Count of distinct input features used in the model.',
    `model_last_evaluated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent performance evaluation run.',
    `model_mae` DECIMAL(18,2) COMMENT 'Mean absolute error of the model on validation data.',
    `model_mape` DECIMAL(18,2) COMMENT 'Mean absolute percentage error of the model on validation data.',
    `model_name` STRING COMMENT 'Human‑readable name of the forecasting model.',
    `model_notes` STRING COMMENT 'Free‑form notes captured by data scientists or reviewers.',
    `model_owner_contact` STRING COMMENT 'Email address of the primary owner responsible for the model.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `model_owner_phone` STRING COMMENT 'Phone number of the model owner for urgent communications.',
    `model_retirement_date` DATE COMMENT 'Planned date for model decommissioning.',
    `model_risk_score` STRING COMMENT 'Risk rating (0‑100) based on governance, bias, and compliance assessments.',
    `model_rmse` DECIMAL(18,2) COMMENT 'Root mean squared error of the model on validation data.',
    `model_status` STRING COMMENT 'Operational status of the model within the analytics platform.. Valid values are `active|inactive|deprecated`',
    `model_training_cost_usd` DECIMAL(18,2) COMMENT 'Estimated compute cost of the training run in US dollars.',
    `model_training_duration_seconds` STRING COMMENT 'Total wall‑clock time taken to train the model, in seconds.',
    `model_type` STRING COMMENT 'Category of business problem the model addresses.. Valid values are `demand_forecast|revenue_forecast|inventory_forecast|churn_forecast`',
    `model_version` STRING COMMENT 'Version identifier following semantic versioning.',
    `owner_team` STRING COMMENT 'Team responsible for model development and maintenance.',
    `regulatory_compliance_status` STRING COMMENT 'Current compliance posture of the model with GDPR, PCI DSS, etc.. Valid values are `compliant|non_compliant|pending`',
    `target_variable` STRING COMMENT 'Business metric the model predicts (e.g., daily sales, stock‑out risk).',
    `training_data_domain` STRING COMMENT 'Primary business domain of the data used to train the model (e.g., order, inventory, customer).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the model record.',
    CONSTRAINT pk_forecast_model PRIMARY KEY(`forecast_model_id`)
) COMMENT 'Master record for each predictive and forecasting model deployed in the enterprise analytics platform. Captures model name, model type (demand forecast, revenue forecast, inventory forecast, churn forecast), algorithm family (ARIMA, Prophet, XGBoost, LSTM), training data domain, feature set description, target variable, evaluation metrics (MAPE, RMSE, MAE), model version, deployment status, and owner team. Serves as the model registry for all production forecasting assets.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`forecast_run` (
    `forecast_run_id` BIGINT COMMENT 'Unique identifier for each forecast model execution.',
    `forecast_model_id` BIGINT COMMENT 'Foreign key linking to analytics.forecast_model. Business justification: Each forecast run is generated by a specific forecast model; adding forecast_model_id consolidates model metadata.',
    `snapshot_id` BIGINT COMMENT 'Identifier of the input data snapshot used for this run.',
    `rerun_of_forecast_run_id` BIGINT COMMENT 'Self-referencing FK on forecast_run (rerun_of_forecast_run_id)',
    `compliance_gdpr_flag` BOOLEAN COMMENT 'Indicates whether the run complies with GDPR data handling requirements.',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'Lower bound of the forecast confidence interval.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'Upper bound of the forecast confidence interval.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the forecast run record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary forecasts.. Valid values are `USD|EUR|GBP|JPY|CNY|AUD`',
    `data_quality_flag` STRING COMMENT 'Indicator of data quality assessment for the run.. Valid values are `pass|warning|fail`',
    `data_source_system` STRING COMMENT 'Originating system that supplied the input data snapshot.',
    `error_message` STRING COMMENT 'Error details if the run failed.',
    `execution_status` STRING COMMENT 'Current status of the forecast run.. Valid values are `success|failed|running|cancelled|pending`',
    `forecast_horizon` STRING COMMENT 'Temporal granularity of the forecast (e.g., days, weeks).. Valid values are `days|weeks|months|quarters|years`',
    `forecast_units` STRING COMMENT 'Measurement unit of the forecasted values.. Valid values are `units|dollars|percentage|ratio`',
    `horizon_value` STRING COMMENT 'Numeric length of the forecast horizon.',
    `is_comparison_base` BOOLEAN COMMENT 'Marks the run as a baseline for model comparisons.',
    `is_reproducible` BOOLEAN COMMENT 'Indicates whether the run can be exactly reproduced.',
    `model_owner` STRING COMMENT 'Team or business unit responsible for the model.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the run.',
    `output_period_end` DATE COMMENT 'End date of the forecasted period.',
    `output_period_start` DATE COMMENT 'Start date of the forecasted period.',
    `parameter_set_code` STRING COMMENT 'Identifier of the parameter set applied to the model.',
    `resource_usage_cpu_seconds` DECIMAL(18,2) COMMENT 'Total CPU time consumed by the run.',
    `resource_usage_memory_mb` DECIMAL(18,2) COMMENT 'Peak memory usage in megabytes.',
    `run_environment` STRING COMMENT 'Deployment environment where the run executed.. Valid values are `production|development|testing|staging`',
    `run_id_external` STRING COMMENT 'Identifier used by external orchestration systems.',
    `run_source` STRING COMMENT 'Origin of the run request.. Valid values are `scheduled|on_demand|api|manual`',
    `run_timestamp` TIMESTAMP COMMENT 'Exact time when the forecast run was initiated.',
    `run_user` STRING COMMENT 'User or service that triggered the forecast run.',
    `runtime_seconds` STRING COMMENT 'Total execution time in seconds.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_forecast_run PRIMARY KEY(`forecast_run_id`)
) COMMENT 'Transactional record capturing each execution of a forecast model. Stores run timestamp, model version used, forecast horizon (days/weeks/months), input data snapshot reference, output forecast period, execution status, runtime duration, and data quality flags. Provides the audit trail for all forecast computations enabling reproducibility, model comparison, and governance of forecast outputs consumed by demand planning, inventory, and finance.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`forecast_output` (
    `forecast_output_id` BIGINT COMMENT 'Unique identifier for each forecast record.',
    `catalog_item_id` BIGINT COMMENT 'Identifier of the target entity for which the forecast is generated.',
    `forecast_run_id` BIGINT COMMENT 'Unique identifier for the forecast execution batch.',
    `revised_forecast_output_id` BIGINT COMMENT 'Self-referencing FK on forecast_output (revised_forecast_output_id)',
    `actual_value` DECIMAL(18,2) COMMENT 'Observed actual value after the forecast period, used for accuracy tracking.',
    `confidence_level` STRING COMMENT 'Confidence level expressed as a percentage (e.g., 95).',
    `confidence_lower` DECIMAL(18,2) COMMENT 'Lower bound of the confidence interval for the forecast value.',
    `confidence_upper` DECIMAL(18,2) COMMENT 'Upper bound of the confidence interval for the forecast value.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the forecast record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary forecasts.. Valid values are `^[A-Z]{3}$`',
    `forecast_period_end` DATE COMMENT 'End date of the forecasted period.',
    `forecast_period_start` DATE COMMENT 'Start date of the forecasted period.',
    `forecast_run_timestamp` TIMESTAMP COMMENT 'Date and time when the forecast was generated.',
    `forecast_status` STRING COMMENT 'Current processing status of the forecast record.. Valid values are `pending|completed|error|canceled|in_progress`',
    `forecast_target_type` STRING COMMENT 'Type of entity the forecast applies to (e.g., SKU, category, region, seller).. Valid values are `sku|category|region|seller|brand|department`',
    `forecast_value` DECIMAL(18,2) COMMENT 'Predicted metric value for the forecast period.',
    `model_name` STRING COMMENT 'Name or identifier of the forecasting model used.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the forecast record.',
    `source_system` STRING COMMENT 'Originating operational system that supplied the input data for the forecast. [ENUM-REF-CANDIDATE: OMS|WMS|PIM|CDP|ERP|TMS|Marketing|Search — 8 candidates stripped; promote to reference product]',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the forecasted value.. Valid values are `units|dollars|items|kg|liters|percent`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the forecast record.',
    `variance` DECIMAL(18,2) COMMENT 'Difference between forecasted value and actual value.',
    CONSTRAINT pk_forecast_output PRIMARY KEY(`forecast_output_id`)
) COMMENT 'Transactional store of point-in-time forecast values produced by a forecast run. Captures the forecast target entity (SKU, category, region, seller), forecast period date, predicted value, confidence interval lower and upper bounds, actuals value (populated post-period for accuracy tracking), and variance from actuals. Enables demand planners, inventory managers, and finance teams to consume structured forecast data for operational decision-making.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`report_definition` (
    `report_definition_id` BIGINT COMMENT 'Unique surrogate key for each report definition.',
    `account_id` BIGINT COMMENT 'Identifier of the user who owns or is accountable for the report.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Scheduled reports that monitor campaign performance need a direct FK to the campaign they report on.',
    `team_id` BIGINT COMMENT 'Foreign key linking to service.team. Business justification: Report definitions are owned by support teams; the FK ties reports to the responsible team for lifecycle management.',
    `regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulation. Business justification: Regulatory reports are produced to satisfy a particular regulation; the FK allows the reporting engine to validate required regulatory coverage.',
    `parent_report_definition_id` BIGINT COMMENT 'Self-referencing FK on report_definition (parent_report_definition_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the report definition record was first created.',
    `data_domains` STRING COMMENT 'Comma‑separated list of data domains (e.g., customer, order, finance) referenced by the report.',
    `distribution_list` STRING COMMENT 'Comma‑separated list of email addresses or user identifiers that receive the report.',
    `estimated_output_size_mb` STRING COMMENT 'Typical size of the generated report file.',
    `estimated_run_time_seconds` STRING COMMENT 'Typical execution duration for the report, used for scheduling and capacity planning.',
    `format` STRING COMMENT 'File or delivery format in which the report is produced.. Valid values are `PDF|Excel|CSV|Embedded|HTML`',
    `governance_classification` STRING COMMENT 'Data governance classification indicating sensitivity level.. Valid values are `public|internal|confidential|restricted`',
    `is_executive` BOOLEAN COMMENT 'True if the report is intended for executive leadership.',
    `is_financial` BOOLEAN COMMENT 'True if the report contains financial metrics or statements.',
    `is_operational` BOOLEAN COMMENT 'True if the report supports day‑to‑day operational monitoring.',
    `is_regulatory` BOOLEAN COMMENT 'True if the report is required for regulatory compliance.',
    `is_scheduled` BOOLEAN COMMENT 'Indicates whether the report runs on a schedule (true) or on demand (false).',
    `is_seller` BOOLEAN COMMENT 'True if the report is primarily consumed by marketplace sellers.',
    `last_run_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent execution of the report.',
    `next_run_timestamp` TIMESTAMP COMMENT 'Planned timestamp for the next scheduled execution.',
    `owner_contact_email` STRING COMMENT 'Primary email address of the report owner or steward.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `parameters_json` STRING COMMENT 'JSON‑encoded parameter set used at runtime to filter or customize the report.',
    `report_definition_code` STRING COMMENT 'Business identifier or short code used to reference the report.',
    `report_definition_description` STRING COMMENT 'Free‑form description of the report purpose, content, and audience.',
    `report_definition_name` STRING COMMENT 'Human‑readable name of the report.',
    `report_definition_status` STRING COMMENT 'Current lifecycle state of the report definition.. Valid values are `active|inactive|deprecated|draft|pending`',
    `report_definition_type` STRING COMMENT 'Category of the report indicating its primary audience or purpose.. Valid values are `operational|executive|regulatory|seller|financial|ad_hoc`',
    `report_version` STRING COMMENT 'Version number of the report definition, incremented on each change.',
    `retention_period_days` STRING COMMENT 'Number of days the report definition and its metadata are retained before archival.',
    `schedule_cron` STRING COMMENT 'Cron expression that defines the recurring schedule for the report.',
    `schedule_frequency` STRING COMMENT 'Human‑readable frequency of the report schedule.. Valid values are `daily|weekly|monthly|quarterly|on_demand`',
    `schedule_timezone` STRING COMMENT 'IANA timezone identifier (e.g., America/Los_Angeles) for schedule calculations.',
    `updated_by` STRING COMMENT 'User name or system identifier that performed the most recent update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the report definition.',
    `created_by` STRING COMMENT 'User name or system identifier that created the report definition.',
    CONSTRAINT pk_report_definition PRIMARY KEY(`report_definition_id`)
) COMMENT 'Master catalog of all scheduled and on-demand reports distributed across the enterprise. Captures report name, report type (operational, executive, regulatory, seller, financial), delivery format (PDF, Excel, CSV, embedded), distribution list, schedule cadence, data domains consumed, owning team, and governance classification. Provides the authoritative registry of all enterprise reports enabling deduplication and lifecycle management.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`report_execution` (
    `report_execution_id` BIGINT COMMENT 'System-generated unique identifier for each report execution event.',
    `agent_id` BIGINT COMMENT 'Foreign key linking to service.agent. Business justification: Report executions are run by support agents; storing the executing agent links execution logs to agent performance and audit trails.',
    `report_definition_id` BIGINT COMMENT 'Identifier of the report definition that was executed.',
    `report_schedule_id` BIGINT COMMENT 'Identifier of the schedule that triggered the report (null for manual/API runs).',
    `rerun_of_report_execution_id` BIGINT COMMENT 'Self-referencing FK on report_execution (rerun_of_report_execution_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the execution record was first created in the system.',
    `delivery_channel` STRING COMMENT 'Medium through which the report was delivered: email, S3 bucket, or BI tool.. Valid values are `email|s3|bi_tool`',
    `error_code` STRING COMMENT 'Standardized error code associated with a failure or partial execution.',
    `error_details` STRING COMMENT 'Detailed error message or stack trace when execution_status is failure or partial.',
    `execution_duration_seconds` STRING COMMENT 'Total time taken to generate the report, measured in seconds.',
    `execution_environment` STRING COMMENT 'Logical environment where the report was generated (e.g., production, development).. Valid values are `prod|dev|test|staging`',
    `execution_status` STRING COMMENT 'Final outcome of the report run: success, failure, or partial.. Valid values are `success|failure|partial`',
    `execution_timestamp` TIMESTAMP COMMENT 'Exact date and time when the report run started.',
    `file_size_bytes` BIGINT COMMENT 'Size of the generated report file in bytes.',
    `recipient_list` STRING COMMENT 'Comma‑separated list of recipients (e.g., email addresses) for the report.',
    `report_format` STRING COMMENT 'File format of the generated report.. Valid values are `pdf|csv|xlsx|json`',
    `report_parameters` STRING COMMENT 'JSON‑encoded string of parameters supplied to the report at execution time.',
    `report_version` STRING COMMENT 'Version identifier of the report definition used for this execution.',
    `row_count` BIGINT COMMENT 'Number of data rows returned by the report.',
    `triggered_by` STRING COMMENT 'Mechanism that initiated the report run: scheduled, manual, or API.. Valid values are `scheduled|manual|api`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the execution record.',
    CONSTRAINT pk_report_execution PRIMARY KEY(`report_execution_id`)
) COMMENT 'Transactional record capturing each scheduled or on-demand report generation event. Stores execution timestamp, report definition reference, triggered by (scheduled/manual/API), execution status (success/failure/partial), row count returned, file size, delivery channel (email/S3/BI tool), recipient list, and error details if failed. Provides the operational audit trail for all report runs supporting SLA monitoring and troubleshooting.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`kpi_target` (
    `kpi_target_id` BIGINT COMMENT 'Unique surrogate key for each KPI target record.',
    `account_id` BIGINT COMMENT 'Identifier of the person or team responsible for achieving the target.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: KPI targets are set per campaign; linking stores the campaign that each target applies to.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Allows carrier‑specific KPI targets (e.g., delivery time SLA) for performance contracts.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: KPI targets are frequently set per product category to align business goals with category performance.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: KPI targets are set to meet specific compliance obligations; linking provides direct traceability from performance targets to the obligation they satisfy.',
    `org_unit_id` BIGINT COMMENT 'Reference to the specific business unit, channel, region, or seller tier.',
    `team_id` BIGINT COMMENT 'Foreign key linking to service.team. Business justification: KPI targets are managed by support teams; linking owner_team_id to team.team_id enables team‑level KPI accountability.',
    `kpi_definition_id` BIGINT COMMENT 'Reference to the KPI definition that this target applies to.',
    `tertiary_kpi_definition_id` BIGINT COMMENT 'FK to analytics.kpi_definition',
    `superseded_kpi_target_id` BIGINT COMMENT 'Self-referencing FK on kpi_target (superseded_kpi_target_id)',
    `ceiling_threshold` DECIMAL(18,2) COMMENT 'Maximum acceptable performance level; values above may indicate data issues.',
    `compliance_requirement` STRING COMMENT 'Regulatory or internal compliance frameworks governing the KPI (e.g., GDPR, PCI, SOX).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the KPI target record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code when the target is monetary.',
    `data_source_system` STRING COMMENT 'Originating operational system that supplies the KPI definition (e.g., OMS, PIM, CDP).',
    `end_date` DATE COMMENT 'Date when the KPI target expires or is superseded (nullable).',
    `floor_threshold` DECIMAL(18,2) COMMENT 'Minimum acceptable performance level; values below trigger alerts.',
    `frequency` STRING COMMENT 'How often the target is evaluated.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the target is considered critical for executive scorecards.',
    `kpi_target_status` STRING COMMENT 'Current lifecycle status of the KPI target.. Valid values are `active|inactive|pending|retired`',
    `last_review_date` DATE COMMENT 'Date when the target was last reviewed or adjusted.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the target value (e.g., percent, USD, count).. Valid values are `percent|currency|count|seconds|minutes|hours`',
    `notes` STRING COMMENT 'Free‑form comments or rationale for the target.',
    `organizational_scope` STRING COMMENT 'Level of the organization to which the target applies.. Valid values are `company|business_unit|channel|region|seller_tier`',
    `start_date` DATE COMMENT 'Date when the KPI target becomes effective.',
    `stretch_target_value` DECIMAL(18,2) COMMENT 'Aggressive optional target used for high‑performance incentives.',
    `target_owner_name` STRING COMMENT 'Readable name of the target owner.',
    `target_period` STRING COMMENT 'Frequency at which the target is measured (e.g., monthly, quarterly).. Valid values are `monthly|quarterly|annual|weekly|daily`',
    `target_type` STRING COMMENT 'Indicates whether the target is an absolute value, a relative change, or a percentage.. Valid values are `absolute|relative|percentage`',
    `target_value` DECIMAL(18,2) COMMENT 'Primary numeric target for the KPI (e.g., revenue amount, conversion rate).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the KPI target record.',
    CONSTRAINT pk_kpi_target PRIMARY KEY(`kpi_target_id`)
) COMMENT 'Master record defining business performance targets for each KPI across organizational units and time periods. Captures KPI definition reference, target period (monthly/quarterly/annual), organizational scope (company-wide, business unit, channel, region, seller tier), target value, stretch target value, floor threshold, and owner. Enables variance analysis between actuals and targets across all enterprise dashboards and executive scorecards.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` (
    `analytical_dataset_id` BIGINT COMMENT 'Unique surrogate key for each analytical dataset record.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Datasets that store category‑level aggregates reference product_category for lineage and SLA enforcement.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Analytical datasets are curated for compliance program reporting; the FK identifies which program consumes the dataset for audit and monitoring.',
    `report_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.report_definition. Business justification: Analytical datasets are the source for scheduled reports; linking dataset to report definition enables traceability.',
    `derived_from_analytical_dataset_id` BIGINT COMMENT 'Self-referencing FK on analytical_dataset (derived_from_analytical_dataset_id)',
    `analytical_dataset_description` STRING COMMENT 'Detailed business description of the dataset purpose, contents, and usage.',
    `consumer_sla` STRING COMMENT 'Service‑level agreement describing availability and latency expectations for dataset consumers.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the dataset metadata record was first created.',
    `data_classification` STRING COMMENT 'Classification level indicating data sensitivity and handling requirements.. Valid values are `public|internal|confidential|restricted`',
    `dataset_name` STRING COMMENT 'Human‑readable name of the curated analytical dataset.',
    `domain` STRING COMMENT 'Business domain to which the dataset belongs (e.g., core, marketing, finance).. Valid values are `core|marketing|finance|logistics|seller|content`',
    `grain` STRING COMMENT 'Level of granularity of the dataset (e.g., per order, per customer, per product). [ENUM-REF-CANDIDATE: order|customer|product|inventory|payment|session|daily|hourly — 8 candidates stripped; promote to reference product]',
    `is_active` BOOLEAN COMMENT 'Indicates whether the dataset is currently active and available for consumption.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Date‑time when the dataset was last refreshed from its source systems.',
    `owner` STRING COMMENT 'Email address of the business owner responsible for the dataset.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `row_count` BIGINT COMMENT 'Number of rows currently stored in the dataset.',
    `schema_version` STRING COMMENT 'Version identifier of the dataset schema following semantic versioning.. Valid values are `^vd+.d+$`',
    `source_system` STRING COMMENT 'Originating operational system that supplies the raw data for the dataset (e.g., OMS, WMS, PIM, CDP, ERP). [ENUM-REF-CANDIDATE: oms|wms|pim|cdp|payment_gateway|erp|tms|marketing_automation|search_engine|seller_portal — promote to reference product]',
    `storage_path` STRING COMMENT 'File system or object store location where the dataset resides.. Valid values are `^/.*$`',
    `update_frequency` STRING COMMENT 'How often the dataset is refreshed or recomputed.. Valid values are `hourly|daily|weekly|monthly|quarterly|yearly`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the dataset metadata.',
    CONSTRAINT pk_analytical_dataset PRIMARY KEY(`analytical_dataset_id`)
) COMMENT 'Master catalog of curated analytical datasets and feature stores published in the Databricks Lakehouse Silver layer for consumption by BI tools, data scientists, and ML pipelines. Captures dataset name, business description, owning domain, grain level, update frequency, schema version, data classification, row count, storage path, and consumer SLA. Serves as the data product catalog enabling governed self-service analytics across the enterprise.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` (
    `cohort_definition_id` BIGINT COMMENT 'Unique surrogate key for the cohort definition record.',
    `parent_cohort_definition_id` BIGINT COMMENT 'Self-referencing FK on cohort_definition (parent_cohort_definition_id)',
    `cohort_definition_code` STRING COMMENT 'Business identifier or short code for the cohort, unique within the analytics domain.',
    `cohort_definition_description` STRING COMMENT 'Detailed free‑text description of the cohort purpose and business rules.',
    `cohort_definition_name` STRING COMMENT 'Human‑readable name of the cohort used in reports and dashboards.',
    `cohort_definition_status` STRING COMMENT 'Current lifecycle status of the cohort definition.. Valid values are `active|inactive|archived|draft`',
    `cohort_definition_type` STRING COMMENT 'Category of cohort – acquisition (first‑time customers), behavioral (based on actions), value (revenue‑based), or custom.. Valid values are `acquisition|behavioral|value|custom`',
    `cohort_size_estimate` BIGINT COMMENT 'Projected number of members in the cohort at formation time.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cohort definition record was first created in the lakehouse.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Overall quality rating (0‑100) of the source data used for the cohort.',
    `formation_criteria` STRING COMMENT 'JSON or serialized expression defining the logical rules used to select members of the cohort.',
    `formation_end_date` DATE COMMENT 'Date on which the cohort formation period ends; null for open‑ended cohorts.',
    `formation_start_date` DATE COMMENT 'Date on which the cohort formation period begins.',
    `grain` STRING COMMENT 'Granularity of the cohort – whether members are customers, sellers, or individual SKUs.. Valid values are `customer|seller|sku`',
    `is_dynamic` BOOLEAN COMMENT 'Indicates whether the cohort updates automatically as new data arrives (true) or is static (false).',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Timestamp when the cohort membership was last recomputed.',
    `owning_team` STRING COMMENT 'Name of the analytics team responsible for maintaining the cohort.',
    `privacy_level` STRING COMMENT 'Data privacy classification governing access to the cohort data.. Valid values are `public|internal|confidential|restricted`',
    `refresh_frequency_days` STRING COMMENT 'How often (in days) the dynamic cohort is refreshed.',
    `retention_window_days` STRING COMMENT 'Number of days after cohort formation that members are tracked for retention analysis.',
    `source_system` STRING COMMENT 'Primary operational system that provides the raw data used to build the cohort. [ENUM-REF-CANDIDATE: CDP|OMS|WMS|PIM|Payment|ERP|TMS|Marketing|Search — 9 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cohort definition.',
    `version_number` STRING COMMENT 'Incremental version number for changes to the cohort definition.',
    CONSTRAINT pk_cohort_definition PRIMARY KEY(`cohort_definition_id`)
) COMMENT 'Master record defining named customer or seller cohorts used for longitudinal analytics and retention analysis. Captures cohort name, cohort type (acquisition cohort, behavioral cohort, value cohort), cohort formation criteria, formation period, cohort grain (customer, seller, SKU), and owning analytics team. Enables repeat purchase analysis, LTV cohort curves, seller growth tracking, and retention funnel reporting across the e-commerce platform.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`cohort_membership` (
    `cohort_membership_id` BIGINT COMMENT 'Unique identifier for the cohort membership record.',
    `cohort_definition_id` BIGINT COMMENT 'Identifier of the cohort definition to which the member belongs.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Supports Seller Cohort Analysis; tracks each sellers entry/exit dates and status within retention cohorts.',
    `superseded_cohort_membership_id` BIGINT COMMENT 'Self-referencing FK on cohort_membership (superseded_cohort_membership_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cohort membership record was created.',
    `entry_date` DATE COMMENT 'Date when the member was first added to the cohort.',
    `exit_date` DATE COMMENT 'Date when the member left the cohort, if applicable.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the cohort membership is currently active.',
    `member_type` STRING COMMENT 'Type of entity that is a member of the cohort (customer, seller, or SKU).. Valid values are `customer|seller|sku`',
    `notes` STRING COMMENT 'Optional free-text notes about the cohort membership.',
    `period_index` STRING COMMENT 'Zero-based index representing the period (e.g., month) relative to cohort entry for retention analysis.',
    `retention_status` STRING COMMENT 'Current retention status of the member within the cohort.. Valid values are `retained|churned|inactive|unknown`',
    `source_system` STRING COMMENT 'Name of the source system that generated the cohort membership record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cohort membership record.',
    CONSTRAINT pk_cohort_membership PRIMARY KEY(`cohort_membership_id`)
) COMMENT 'Association entity linking individual customers, sellers, or SKUs to their assigned cohorts. Captures cohort definition reference, member entity type, member entity identifier, cohort entry date, cohort period index (period 0, 1, 2...), and retention status. Enables cohort-based retention curves, LTV progression analysis, and behavioral segmentation reporting without requiring ad-hoc cohort recomputation at query time.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` (
    `funnel_definition_id` BIGINT COMMENT 'Unique surrogate key for each funnel definition record.',
    `parent_funnel_definition_id` BIGINT COMMENT 'Self-referencing FK on funnel_definition (parent_funnel_definition_id)',
    `conversion_window_days` STRING COMMENT 'Maximum number of days allowed between entry and exit events for a conversion to be counted.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the funnel definition record was first created.',
    `effective_from` DATE COMMENT 'Date from which the funnel definition becomes active for reporting.',
    `effective_until` DATE COMMENT 'Date after which the funnel definition is retired (null if open‑ended).',
    `entry_event` STRING COMMENT 'Name of the event that marks a user entering the funnel.',
    `exit_event` STRING COMMENT 'Name of the event that marks a user exiting the funnel (conversion or drop‑off).',
    `funnel_definition_code` STRING COMMENT 'Unique business code used to reference the funnel across systems.',
    `funnel_definition_description` STRING COMMENT 'Detailed textual description of the funnel purpose and scope.',
    `funnel_definition_name` STRING COMMENT 'Human‑readable name of the conversion funnel.',
    `funnel_definition_status` STRING COMMENT 'Current lifecycle state of the funnel definition.. Valid values are `active|inactive|draft|deprecated`',
    `funnel_definition_type` STRING COMMENT 'Category of funnel (e.g., purchase, seller onboarding, checkout, search‑to‑purchase).. Valid values are `purchase|seller_onboarding|checkout|search_to_purchase`',
    `owning_team` STRING COMMENT 'Internal team responsible for maintaining the funnel definition.',
    `stages` STRING COMMENT 'JSON‑encoded ordered list of stage identifiers that compose the funnel.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the funnel definition.',
    `version_number` STRING COMMENT 'Incremental version identifier for changes to the funnel definition.',
    CONSTRAINT pk_funnel_definition PRIMARY KEY(`funnel_definition_id`)
) COMMENT 'Master record defining conversion funnels tracked across the e-commerce platform. Captures funnel name, funnel type (purchase funnel, seller onboarding funnel, checkout funnel, search-to-purchase funnel), ordered list of funnel stages, entry event, exit event, conversion window, and owning team. Provides the semantic definition of all conversion funnels enabling consistent funnel analysis across marketing, product, and growth analytics.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`funnel_event` (
    `funnel_event_id` BIGINT COMMENT 'Unique identifier for the funnel event record.',
    `ab_test_variant_id` BIGINT COMMENT 'Identifier of the A/B test variant presented to the user.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign associated with the event.',
    `click_event_id` BIGINT COMMENT 'Unique identifier for the click that led to the funnel entry.',
    `experiment_id` BIGINT COMMENT 'Identifier of the A/B test experiment.',
    `funnel_definition_id` BIGINT COMMENT 'Identifier of the funnel definition to which this event belongs.',
    `header_id` BIGINT COMMENT 'Identifier of the order generated as a result of conversion, if any.',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Conversion funnel analysis includes the payment step; linking to the transaction enables measurement of success/failure rates per payment.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Captures Seller Onboarding Funnel events; allows analysis of conversion rates through onboarding stages.',
    `session_id` BIGINT COMMENT 'Unique identifier for the user session.',
    `previous_funnel_event_id` BIGINT COMMENT 'Self-referencing FK on funnel_event (previous_funnel_event_id)',
    `abandonment_reason` STRING COMMENT 'Reason code for funnel abandonment, if known.. Valid values are `timeout|lost_interest|error|other`',
    `attribution_model` STRING COMMENT 'Model used to attribute credit for the conversion (e.g., last_click).. Valid values are `last_click|first_click|linear|time_decay|position_based`',
    `browser` STRING COMMENT 'Name of the web browser used (e.g., Chrome, Safari).',
    `channel` STRING COMMENT 'Marketing channel through which the entity interacted (e.g., web, mobile app).. Valid values are `web|mobile_app|email|social|offline`',
    `conversion_flag` BOOLEAN COMMENT 'Indicates whether the entity progressed to the next funnel stage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the funnel event record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the order value.. Valid values are `^[A-Z]{3}$`',
    `device_code` STRING COMMENT 'Unique identifier of the device (e.g., advertising ID).',
    `device_os_version` STRING COMMENT 'Version number of the operating system on the device.',
    `device_type` STRING COMMENT 'Category of device used (desktop, mobile, tablet).. Valid values are `desktop|mobile|tablet`',
    `entered_timestamp` TIMESTAMP COMMENT 'Exact time the entity entered the funnel stage.',
    `entity_type` STRING COMMENT 'Type of entity progressing through the funnel (customer, seller, or session).. Valid values are `customer|seller|session`',
    `event_payload` STRING COMMENT 'Raw payload or JSON string containing additional event details.',
    `event_source` STRING COMMENT 'System or component that generated the funnel event (e.g., web app, mobile SDK).',
    `exited_timestamp` TIMESTAMP COMMENT 'Exact time the entity left the funnel stage (if applicable).',
    `funnel_stage_entry_method` STRING COMMENT 'Method by which the entity entered the stage (click, view, or automatic).. Valid values are `click|view|auto`',
    `geo_country` STRING COMMENT 'Three‑letter ISO country code of the client location.. Valid values are `^[A-Z]{3}$`',
    `geo_region` STRING COMMENT 'State, province, or region of the client location.',
    `ip_address` STRING COMMENT 'IP address of the client at event time.',
    `is_abandoned` BOOLEAN COMMENT 'True if the entity abandoned the funnel after this stage.',
    `is_new_user` BOOLEAN COMMENT 'True if this is the first recorded interaction for the entity.',
    `is_returning_user` BOOLEAN COMMENT 'True if the entity has prior interactions before this event.',
    `notes` STRING COMMENT 'Free‑form notes or comments captured by analysts.',
    `operating_system` STRING COMMENT 'Operating system of the device (e.g., Windows, iOS).',
    `order_value` DECIMAL(18,2) COMMENT 'Monetary value of the order associated with the conversion.',
    `page_url` STRING COMMENT 'URL of the page where the funnel event occurred.',
    `referrer_url` STRING COMMENT 'URL of the page that referred the user to the current page.',
    `screen_resolution` STRING COMMENT 'Screen resolution of the device at event time (e.g., 1920x1080).',
    `source_medium` STRING COMMENT 'Medium through which the traffic arrived (organic, paid, referral, email).. Valid values are `organic|paid|referral|email`',
    `stage_name` STRING COMMENT 'Human‑readable name of the funnel stage entered.',
    `stage_sequence` STRING COMMENT 'Numeric order of the stage within the funnel.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the funnel event record.',
    `user_agent` STRING COMMENT 'Full user‑agent string sent by the browser.',
    CONSTRAINT pk_funnel_event PRIMARY KEY(`funnel_event_id`)
) COMMENT 'Transactional record capturing each customer or seller progression event through a defined conversion funnel stage. Stores funnel definition reference, entity type (customer/session/seller), entity identifier, funnel stage entered, event timestamp, session context, channel, device type, and whether the entity converted to the next stage. Powers funnel drop-off analysis, A/B test conversion measurement, and checkout optimization reporting.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` (
    `ab_test_result_id` BIGINT COMMENT 'Unique identifier for the A/B test result record.',
    `ab_test_variant_id` BIGINT COMMENT 'Identifier of the specific variant (treatment) within the experiment.',
    `attribution_model_id` BIGINT COMMENT 'Foreign key linking to analytics.attribution_model. Business justification: AB test results can be analyzed using an attribution model; linking provides direct reference.',
    `experiment_id` BIGINT COMMENT 'Identifier of the experiment that generated this result.',
    `baseline_ab_test_result_id` BIGINT COMMENT 'Self-referencing FK on ab_test_result (baseline_ab_test_result_id)',
    `ab_test_result_status` STRING COMMENT 'Current lifecycle status of the result record.. Valid values are `active|archived|deleted`',
    `confidence_interval_lower` DOUBLE COMMENT 'Lower bound of the confidence interval for the lift.',
    `confidence_interval_upper` DOUBLE COMMENT 'Upper bound of the confidence interval for the lift.',
    `confidence_level` DOUBLE COMMENT 'Confidence level (e.g., 95.0 for 95% confidence) used for the interval.',
    `control_value` DOUBLE COMMENT 'Measured value of the metric for the control group.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the result record was first created in the system.',
    `event_payload` STRING COMMENT 'Serialized JSON payload containing raw result details; retained for audit.',
    `event_type` STRING COMMENT 'Classification of the event; for this entity always result.. Valid values are `result`',
    `experiment_end_date` DATE COMMENT 'Date when the experiment concluded or was stopped.',
    `experiment_start_date` DATE COMMENT 'Date when the experiment began.',
    `is_statistically_significant` BOOLEAN COMMENT 'True if the result meets the predefined significance threshold.',
    `metric_name` STRING COMMENT 'Name of the business metric evaluated in the experiment (e.g., conversion_rate, revenue_per_user).',
    `observed_value` DOUBLE COMMENT 'Measured value of the metric for the variant.',
    `p_value` DOUBLE COMMENT 'Statistical p‑value indicating significance of the observed lift.',
    `relative_lift` DOUBLE COMMENT 'Percentage lift of the variant over the control (observed_value - control_value) / control_value.',
    `result_recorded_timestamp` TIMESTAMP COMMENT 'Timestamp when this result record was captured (event timestamp).',
    `sample_size` BIGINT COMMENT 'Number of users or sessions included in the experiment for this variant.',
    `test_type` STRING COMMENT 'Type of experiment: A/B test or multivariate test.. Valid values are `ab|multivariate`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the result record.',
    CONSTRAINT pk_ab_test_result PRIMARY KEY(`ab_test_result_id`)
) COMMENT 'Transactional record capturing the statistical results and business outcomes of A/B and multivariate experiments run across the platform. Captures experiment reference (linked to content, pricing, or search experiment), variant identifier, metric evaluated, observed value, control value, relative lift, p-value, confidence interval, sample size, and statistical significance flag. Serves as the authoritative results store for all platform experimentation enabling data-driven decision-making.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`attribution_model` (
    `attribution_model_id` BIGINT COMMENT 'Unique system-generated identifier for the attribution model.',
    `baseline_attribution_model_id` BIGINT COMMENT 'Self-referencing FK on attribution_model (baseline_attribution_model_id)',
    `attribution_model_code` STRING COMMENT 'Business code used to reference the model in external systems.',
    `attribution_model_description` STRING COMMENT 'Detailed free‑text description of the model purpose and logic.',
    `attribution_model_name` STRING COMMENT 'Human‑readable name of the attribution model.',
    `attribution_model_status` STRING COMMENT 'Current lifecycle state of the attribution model.. Valid values are `active|inactive|deprecated|draft|pending`',
    `attribution_type` STRING COMMENT 'Method used to assign conversion credit across touchpoints.. Valid values are `last_click|first_click|linear|time_decay|data_driven`',
    `channel_weighting_json` STRING COMMENT 'JSON representation of channel‑specific weightings used by the model.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the model under GDPR, CCPA, etc.. Valid values are `compliant|non_compliant|under_review`',
    `conversion_event` STRING COMMENT 'Business event that qualifies a conversion for attribution.. Valid values are `purchase|signup|add_to_cart|checkout|subscription`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the model record was first created.',
    `data_source` STRING COMMENT 'Primary data source(s) used to train or calibrate the model (e.g., CRM, web analytics).',
    `deployment_status` STRING COMMENT 'Current deployment state of the model in production.. Valid values are `deployed|testing|retired`',
    `is_default` BOOLEAN COMMENT 'Indicates whether this model is the default attribution model for reporting.',
    `last_evaluated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent performance evaluation of the model.',
    `lookback_window_days` STRING COMMENT 'Number of days prior to a conversion event that touchpoints are considered.',
    `model_owner` STRING COMMENT 'Business team or department responsible for the model.',
    `model_version` STRING COMMENT 'Version identifier of the model implementation.',
    `performance_score` DECIMAL(18,2) COMMENT 'Numeric score (e.g., 0‑100) representing model accuracy or fit.',
    `privacy_impact_assessment` STRING COMMENT 'Summary of the privacy impact assessment for the model.',
    `retention_period_days` STRING COMMENT 'Number of days the model definition is retained after deprecation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the model record.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the model record.',
    CONSTRAINT pk_attribution_model PRIMARY KEY(`attribution_model_id`)
) COMMENT 'Master record defining marketing attribution models used to assign conversion credit across customer touchpoints. Captures model name, attribution type (last-click, first-click, linear, time-decay, data-driven), lookback window, channel weighting configuration, conversion event definition, and deployment status. Provides the semantic definition of how marketing spend is credited to revenue outcomes across all attribution reporting.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`attribution_result` (
    `attribution_result_id` BIGINT COMMENT 'System-generated unique identifier for each attribution result record.',
    `attribution_model_id` BIGINT COMMENT 'Foreign key linking to analytics.attribution_model. Business justification: Attribution results are produced by a specific attribution model; replace string column with FK.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Attribution results must be tied to the originating marketing campaign for revenue attribution reporting.',
    `conversion_event_id` BIGINT COMMENT 'Identifier of the conversion event (e.g., order, signup) to which the attribution credit is assigned.',
    `reattributed_attribution_result_id` BIGINT COMMENT 'Self-referencing FK on attribution_result (reattributed_attribution_result_id)',
    `attributed_order_count` STRING COMMENT 'Number of orders assigned to the touchpoint based on the fractional credit.',
    `attributed_revenue` DECIMAL(18,2) COMMENT 'Monetary value of revenue credited to the touchpoint after attribution calculation.',
    `attribution_status` STRING COMMENT 'Current processing state of the attribution record.. Valid values are `pending|completed|error`',
    `computation_timestamp` TIMESTAMP COMMENT 'Date‑time when the attribution credit was computed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the attribution result record was first created in the lakehouse.',
    `credit_weight` DECIMAL(18,2) COMMENT 'Fractional weight (0‑1) representing the proportion of credit allocated to this touchpoint.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the attributed revenue.',
    `is_estimated` BOOLEAN COMMENT 'Indicates whether the attributed revenue is an estimate rather than a definitive amount.',
    `line_sequence` STRING COMMENT 'Sequential order of the touchpoint within the conversion path.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the attribution calculation.',
    `source_system` STRING COMMENT 'Originating system that generated the raw touchpoint data (e.g., SFMC, Google Ads).',
    `touchpoint_campaign` STRING COMMENT 'Identifier or code of the marketing campaign associated with the touchpoint.',
    `touchpoint_channel` STRING COMMENT 'Marketing channel through which the touchpoint was delivered.. Valid values are `email|search|social|display|referral|direct`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the attribution result record.',
    CONSTRAINT pk_attribution_result PRIMARY KEY(`attribution_result_id`)
) COMMENT 'Transactional record capturing the computed attribution credit assigned to each marketing touchpoint for a conversion event under a specific attribution model. Stores attribution model reference, conversion event identifier, touchpoint channel, touchpoint campaign, attributed revenue value, attributed order count, fractional credit weight, and computation timestamp. Powers marketing ROI reporting, channel budget optimization, and ROAS analysis.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` (
    `gmv_daily_snapshot_id` BIGINT COMMENT 'Surrogate key uniquely identifying each GMV daily snapshot record.',
    `analytical_dataset_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_dataset. Business justification: GMV daily snapshots are derived from analytical datasets; linking provides lineage.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: Daily GMV snapshots are broken down by marketing channel; FK enables channel‑level financial analysis.',
    `marketplace_transaction_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_transaction. Business justification: Required for audit of daily GMV snapshot to trace back to source transactions for compliance and dispute resolution.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Enables Daily GMV Snapshot Report per seller, used in financial reconciliation and seller payout processes.',
    `prior_day_gmv_daily_snapshot_id` BIGINT COMMENT 'Self-referencing FK on gmv_daily_snapshot (prior_day_gmv_daily_snapshot_id)',
    `active_buyer_count` BIGINT COMMENT 'Number of distinct customers who placed at least one order on the snapshot date.',
    `average_order_value` DECIMAL(18,2) COMMENT 'Average monetary value per order (GMV gross divided by order count).',
    `cancellation_rate` DECIMAL(18,2) COMMENT 'Proportion of orders cancelled relative to total orders (decimal).',
    `channel` STRING COMMENT 'Sales channel through which the orders were placed.. Valid values are `direct|marketplace|partner|affiliate`',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary values.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `data_freshness_indicator` STRING COMMENT 'Indicator of how current the snapshot data is relative to source system ingestion.. Valid values are `fresh|stale|delayed`',
    `gmv_daily_snapshot_category` STRING COMMENT 'Top‑level product category aggregated for the snapshot.',
    `gmv_gross` DECIMAL(18,2) COMMENT 'Total gross value of merchandise sold before discounts, returns, and fees.',
    `gmv_net` DECIMAL(18,2) COMMENT 'Net GMV after deducting returns, cancellations, and platform fees.',
    `order_count` BIGINT COMMENT 'Number of orders placed on the snapshot date for the given dimensions.',
    `platform` STRING COMMENT 'The sales platform (e.g., website, mobile app) where the transactions occurred.. Valid values are `website|mobile_app|api|storefront`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the snapshot record was initially created in the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the snapshot record.',
    `region` STRING COMMENT 'Three‑letter country code representing the geographic region of the snapshot. [ENUM-REF-CANDIDATE: USA|CAN|GBR|DEU|FRA|JPN|CHN|IND|BRA|AUS — promote to reference product]',
    `return_rate` DECIMAL(18,2) COMMENT 'Proportion of orders returned relative to total orders (decimal).',
    `seller_tier` STRING COMMENT 'Classification of seller based on performance or agreement level.. Valid values are `platinum|gold|silver|bronze`',
    `snapshot_date` DATE COMMENT 'The calendar date for which the GMV metrics are captured.',
    `snapshot_status` STRING COMMENT 'Current processing state of the snapshot record.. Valid values are `pending|finalized|error`',
    `source_system` STRING COMMENT 'Name of the operational system that supplied the underlying transactional data.',
    `take_rate` DECIMAL(18,2) COMMENT 'Portion of GMV retained by the platform as revenue (percentage expressed as decimal).',
    CONSTRAINT pk_gmv_daily_snapshot PRIMARY KEY(`gmv_daily_snapshot_id`)
) COMMENT 'Daily point-in-time snapshot of Gross Merchandise Value (GMV) and key revenue metrics aggregated at the platform, channel, category, and seller tier level. Captures snapshot date, GMV gross, GMV net, order count, average order value, take rate, cancellation rate, return rate, and active buyer count. Serves as the pre-computed operational fact table for executive GMV dashboards, financial reporting, and trend analysis without requiring real-time transactional joins.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`category_performance` (
    `category_performance_id` BIGINT COMMENT 'Unique identifier for the category performance record. _canonical_skip_reason: Entity is a periodic analytics fact table, does not fit other roles.',
    `analytical_dataset_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_dataset. Business justification: Category performance records are calculated from analytical datasets; linking enables source tracking.',
    `category_id` BIGINT COMMENT 'Identifier of the product category.',
    `listing_category_id` BIGINT COMMENT 'Foreign key linking to marketplace.listing_category. Business justification: Enables Marketplace Category Performance Report to map analytics data to marketplace listing categories for accurate category‑level GMV analysis.',
    `prior_period_category_performance_id` BIGINT COMMENT 'Self-referencing FK on category_performance (prior_period_category_performance_id)',
    `average_items_per_order` DECIMAL(18,2) COMMENT 'Average number of items contained in each order.',
    `average_order_value` DECIMAL(18,2) COMMENT 'Average monetary value per order for the category.',
    `average_selling_price` DECIMAL(18,2) COMMENT 'Average selling price per unit.',
    `avg_selling_price_currency_code` STRING COMMENT 'Currency code for average selling price.. Valid values are `^[A-Z]{3}$`',
    `category_performance_status` STRING COMMENT 'Current status of the category performance record.. Valid values are `active|inactive|archived`',
    `confidence_score` DECIMAL(18,2) COMMENT 'Confidence level (0‑100) for estimated metrics.',
    `conversion_rate` DECIMAL(18,2) COMMENT 'Ratio of orders to site visits, expressed as a decimal (e.g., 0.0254 = 2.54%).',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Score (0‑1) indicating confidence in data quality for this record.',
    `gmv` DECIMAL(18,2) COMMENT 'Total gross merchandise value for the period.',
    `gmv_currency_code` STRING COMMENT 'ISO 4217 currency code for GMV.. Valid values are `^[A-Z]{3}$`',
    `gross_margin_percent` DECIMAL(18,2) COMMENT 'Gross margin expressed as a percentage of GMV.',
    `inventory_coverage_days` DECIMAL(18,2) COMMENT 'Number of days of inventory on hand based on current stock and sales velocity.',
    `inventory_turnover_rate` DECIMAL(18,2) COMMENT 'Ratio of cost of goods sold to average inventory value.',
    `is_estimated` BOOLEAN COMMENT 'Indicates whether the metrics are estimated (true) or based on actual data (false).',
    `net_margin_percent` DECIMAL(18,2) COMMENT 'Net margin after expenses expressed as a percentage of GMV.',
    `new_seller_count` BIGINT COMMENT 'Count of newly onboarded sellers in the category during the period.',
    `notes` STRING COMMENT 'Free‑text comments or observations about the record.',
    `order_count` BIGINT COMMENT 'Total number of orders placed in the period.',
    `period_end_date` DATE COMMENT 'End date of the reporting period.',
    `period_start_date` DATE COMMENT 'Start date of the reporting period.',
    `processing_date` DATE COMMENT 'Date when the record was processed into the silver layer.',
    `promotional_discount_amount` DECIMAL(18,2) COMMENT 'Total monetary value of promotional discounts applied.',
    `promotional_discount_rate` DECIMAL(18,2) COMMENT 'Discount amount divided by GMV, expressed as a decimal.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance record was first created in the data lake.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `reporting_period` STRING COMMENT 'Periodicity of the performance record.. Valid values are `daily|weekly|monthly|quarterly|yearly`',
    `return_rate` DECIMAL(18,2) COMMENT 'Ratio of returned units to units sold, expressed as a decimal.',
    `sell_through_rate` DECIMAL(18,2) COMMENT 'Percentage of inventory sold during the period.',
    `source_system` STRING COMMENT 'Source system that provided the raw data (e.g., OMS, WMS, PIM).',
    `top_sku_count` BIGINT COMMENT 'Number of top‑selling SKUs contributing to the majority of sales.',
    `units_sold` BIGINT COMMENT 'Total number of units sold across all orders.',
    CONSTRAINT pk_category_performance PRIMARY KEY(`category_performance_id`)
) COMMENT 'Periodic performance record capturing key commercial and operational metrics for each product category. Stores category identifier, reporting period, GMV, order count, units sold, average selling price, conversion rate, return rate, top SKU count, new seller count, and inventory coverage days. Enables category management teams to monitor health, identify growth opportunities, and benchmark performance across the product taxonomy.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` (
    `seller_performance_snapshot_id` BIGINT COMMENT 'System-generated unique identifier for each seller performance snapshot record.',
    `analytical_dataset_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_dataset. Business justification: Seller performance snapshots are derived from analytical datasets; linking provides data provenance.',
    `seller_profile_id` BIGINT COMMENT 'Unique identifier of the marketplace seller whose performance is captured.',
    `prior_period_seller_performance_snapshot_id` BIGINT COMMENT 'Self-referencing FK on seller_performance_snapshot (prior_period_seller_performance_snapshot_id)',
    `average_order_value` DECIMAL(18,2) COMMENT 'Average monetary value per order for the seller in the period (GMV / order count).',
    `cancellation_rate` DECIMAL(18,2) COMMENT 'Proportion of orders cancelled by the seller (cancellations / total orders).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the snapshot record was initially created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which monetary values are expressed.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `customer_rating_average` DECIMAL(18,2) COMMENT 'Average star rating (0‑5) given by customers to the seller during the period.',
    `defect_rate` DECIMAL(18,2) COMMENT 'Proportion of orders with quality or fulfillment defects reported by customers.',
    `gross_margin_percent` DECIMAL(18,2) COMMENT 'Percentage of GMV retained after cost of goods sold ( (GMV‑COGS)/GMV * 100 ).',
    `gross_merchandise_value` DECIMAL(18,2) COMMENT 'Total sales value of all orders fulfilled by the seller during the period, before discounts and returns.',
    `late_shipment_rate` DECIMAL(18,2) COMMENT 'Proportion of orders shipped later than the committed delivery window.',
    `net_profit` DECIMAL(18,2) COMMENT 'Sellers profit after deducting cost of goods sold, fees, and refunds for the period.',
    `order_count` STRING COMMENT 'Number of orders placed with the seller in the reporting period.',
    `period_end_date` DATE COMMENT 'Last date of the reporting period covered by the snapshot.',
    `period_grain` STRING COMMENT 'Granularity of the reporting period (e.g., daily, weekly, monthly).. Valid values are `daily|weekly|monthly|quarterly|yearly`',
    `period_start_date` DATE COMMENT 'First date of the reporting period covered by the snapshot.',
    `region_code` STRING COMMENT 'Three‑letter ISO country or region code representing the primary market of the seller for the snapshot.',
    `return_rate` DECIMAL(18,2) COMMENT 'Proportion of orders that resulted in a return or refund.',
    `seller_performance_snapshot_status` STRING COMMENT 'Current lifecycle status of the snapshot record (active = latest, inactive = historical).. Valid values are `active|inactive`',
    `seller_tier` STRING COMMENT 'Classification of the seller based on performance metrics (e.g., bronze, silver, gold, platinum).. Valid values are `bronze|silver|gold|platinum`',
    `snapshot_date` DATE COMMENT 'The calendar date representing the reporting period for the snapshot (e.g., end of day).',
    `total_units_sold` STRING COMMENT 'Aggregate count of individual product units sold by the seller during the period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the snapshot record.',
    CONSTRAINT pk_seller_performance_snapshot PRIMARY KEY(`seller_performance_snapshot_id`)
) COMMENT 'Periodic performance snapshot capturing operational and commercial KPIs for each marketplace seller at a defined reporting grain. Captures seller identifier, snapshot period, GMV, order count, cancellation rate, late shipment rate, defect rate, return rate, customer rating average, and tier classification. Complements seller.scorecard by providing the analytics-layer pre-computed time series enabling trend analysis, tier eligibility assessment, and seller health monitoring at scale.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` (
    `customer_retention_fact_id` BIGINT COMMENT 'Unique surrogate key for each row in the customer retention fact table.',
    `cohort_definition_id` BIGINT COMMENT 'Identifier for the acquisition cohort to which the customers belong (e.g., month‑year of first purchase).',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Retention fact tables aggregate by customer segment; FK enables drill‑down from fact to segment definition for reporting.',
    `prior_period_customer_retention_fact_id` BIGINT COMMENT 'Self-referencing FK on customer_retention_fact (prior_period_customer_retention_fact_id)',
    `active_buyer_count` BIGINT COMMENT 'Number of distinct customers who made at least one purchase in the reporting period.',
    `average_order_value_usd` DECIMAL(18,2) COMMENT 'Mean monetary value of orders placed by active buyers, expressed in US dollars.',
    `churn_count` BIGINT COMMENT 'Number of customers from the cohort who did not make any purchase during the reporting period and are considered churned.',
    `churn_rate` DECIMAL(18,2) COMMENT 'Proportion of the cohort that churned during the reporting period (value between 0 and 1).',
    `customer_retention_fact_status` STRING COMMENT 'Lifecycle status of the fact row (active = current, inactive = superseded, archived = retained for history).. Valid values are `active|inactive|archived`',
    `customer_segment` STRING COMMENT 'Business-defined segment or cohort classification of the customer (e.g., high‑value, new, churn‑risk).',
    `data_source_system` STRING COMMENT 'Name of the source system that supplied the underlying raw data (e.g., OMS, CDP, Payment Gateway).',
    `new_customers_count` BIGINT COMMENT 'Number of first‑time buyers acquired during the reporting period.',
    `purchase_frequency` DECIMAL(18,2) COMMENT 'Average number of purchases per active buyer within the reporting period.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the fact row was first inserted into the analytics layer.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fact row.',
    `repeat_purchase_rate` DECIMAL(18,2) COMMENT 'Proportion of active buyers who placed more than one order during the period (value between 0 and 1).',
    `reporting_period_end_date` DATE COMMENT 'Last calendar date of the reporting period covered by the fact row.',
    `reporting_period_grain` STRING COMMENT 'Temporal granularity of the reporting period (e.g., day, week, month, quarter, year).. Valid values are `day|week|month|quarter|year`',
    `reporting_period_start_date` DATE COMMENT 'First calendar date of the reporting period covered by the fact row.',
    `retention_30_day_rate` DECIMAL(18,2) COMMENT 'Proportion of customers from the cohort who made a purchase within 30 days after their first purchase.',
    `retention_60_day_rate` DECIMAL(18,2) COMMENT 'Proportion of cohort customers who made a purchase within 60 days after acquisition.',
    `retention_90_day_rate` DECIMAL(18,2) COMMENT 'Proportion of cohort customers who made a purchase within 90 days after acquisition.',
    `total_orders` BIGINT COMMENT 'Total number of orders placed by the segment/cohort in the reporting period.',
    `total_revenue_usd` DECIMAL(18,2) COMMENT 'Aggregate gross revenue generated by the segment/cohort in US dollars for the reporting period.',
    CONSTRAINT pk_customer_retention_fact PRIMARY KEY(`customer_retention_fact_id`)
) COMMENT 'Periodic analytical fact record capturing customer retention and engagement metrics at the customer segment and acquisition cohort level. Stores reporting period, customer segment, cohort reference, active buyer count, repeat purchase rate, purchase frequency, average order value, 30/60/90-day retention rates, and churn count. Powers retention dashboards, loyalty program effectiveness reporting, and customer lifecycle analytics for growth and CRM teams.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`operational_alert` (
    `operational_alert_id` BIGINT COMMENT 'System-generated unique identifier for each operational alert record.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Alerts are raised when campaign KPIs breach thresholds; linking identifies the affected campaign.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Enables alerts tied to carrier SLA breaches, supporting carrier performance monitoring.',
    `center_id` BIGINT COMMENT 'Foreign key linking to fulfillment.center. Business justification: KPI breach alerts often target a specific fulfillment center; linking alerts to center enables root‑cause analysis.',
    `kpi_definition_id` BIGINT COMMENT 'Identifier of the KPI or metric that triggered the alert.',
    `agent_id` BIGINT COMMENT 'Foreign key linking to service.agent. Business justification: Alerts are assigned to support agents for resolution; linking owner_agent_id to agent.agent_id enables alert ownership tracking in SLA monitoring.',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Real‑time fraud and settlement alerts must reference the specific payment transaction that triggered the alert for investigation.',
    `incident_id` BIGINT COMMENT 'Identifier of a related incident or ticket, if applicable.',
    `related_operational_alert_id` BIGINT COMMENT 'Self-referencing FK on operational_alert (related_operational_alert_id)',
    `alert_category` STRING COMMENT 'High‑level grouping of the alert purpose.. Valid values are `performance|security|data_quality|operational`',
    `alert_description` STRING COMMENT 'Detailed narrative explaining the cause and context of the alert.',
    `alert_name` STRING COMMENT 'Descriptive name of the alert, e.g., "High Cart Abandonment Rate".',
    `alert_tags` STRING COMMENT 'Comma‑separated list of user‑defined tags for filtering and reporting.',
    `alert_type` STRING COMMENT 'Category of the alert indicating why it was generated.. Valid values are `threshold_breach|anomaly|data_quality`',
    `anomaly_score` DECIMAL(18,2) COMMENT 'Statistical confidence score for anomaly‑based alerts.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the alert record was first inserted.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Score indicating the quality of the underlying data that triggered the alert.',
    `kpi_target_type` STRING COMMENT 'Indicates whether the KPI target is an upper bound, lower bound, or a range.. Valid values are `upper|lower|range`',
    `kpi_target_value` DECIMAL(18,2) COMMENT 'Target value defined for the KPI at the time of alert generation.',
    `metric_name` STRING COMMENT 'Human‑readable name of the metric associated with the alert.',
    `observed_value` DECIMAL(18,2) COMMENT 'The actual value observed at the time of the alert (numeric or categorical).',
    `owner_role` STRING COMMENT 'Job role or function of the alert owner (e.g., Analyst, Manager).',
    `priority` STRING COMMENT 'Business priority used for escalation routing.. Valid values are `high|medium|low`',
    `resolution_notes` STRING COMMENT 'Free‑form text describing actions taken to resolve the alert.',
    `resolution_status` STRING COMMENT 'Current state of the alerts handling workflow.. Valid values are `open|in_progress|resolved|closed`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date‑time when the alert was marked as resolved or closed.',
    `severity_level` STRING COMMENT 'Business impact level of the alert.. Valid values are `critical|warning|info`',
    `source_system` STRING COMMENT 'Name of the analytics or monitoring system that emitted the alert.',
    `threshold_operator` STRING COMMENT 'Logical operator used to compare observed value with the threshold.. Valid values are `greater_than|less_than|outside_range`',
    `threshold_value` DECIMAL(18,2) COMMENT 'Configured threshold that the observed value was compared against.',
    `triggered_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the alert was generated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the alert record.',
    CONSTRAINT pk_operational_alert PRIMARY KEY(`operational_alert_id`)
) COMMENT 'Transactional record capturing threshold-breach alerts generated by the analytics monitoring layer when KPI values deviate from defined targets or anomaly detection rules are triggered. Captures alert name, alert type (threshold breach, anomaly, data quality), KPI or metric reference, observed value, threshold value, severity level (critical/warning/info), triggered timestamp, assigned owner, resolution status, and resolution notes. Enables proactive operational monitoring and escalation workflows.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`conversion_event` (
    `conversion_event_id` BIGINT COMMENT 'Primary key for conversion_event',
    `account_id` BIGINT COMMENT 'Unique identifier of the user who performed the conversion.',
    `order_address_id` BIGINT COMMENT 'Identifier of billing address used.',
    `campaign_id` BIGINT COMMENT 'Marketing campaign identifier that drove the conversion.',
    `catalog_item_id` BIGINT COMMENT 'Identifier of the product involved in the conversion.',
    `purchase_order_id` BIGINT COMMENT 'Associated order identifier if conversion resulted in purchase.',
    `session_id` BIGINT COMMENT 'Identifier of the user session associated with the conversion.',
    `shipping_address_id` BIGINT COMMENT 'Identifier of shipping address used.',
    `originating_conversion_event_id` BIGINT COMMENT 'Self-referencing FK on conversion_event (originating_conversion_event_id)',
    `attribution_model` STRING COMMENT 'Attribution model used (e.g., last_click, first_click).',
    `attribution_touchpoint` STRING COMMENT 'Touchpoint identifier used for attribution.',
    `browser` STRING COMMENT 'Web browser used for the conversion.',
    `conversion_status` STRING COMMENT 'Result status of the conversion process.',
    `conversion_type` STRING COMMENT 'Category of conversion action.',
    `conversion_value` DECIMAL(18,2) COMMENT 'Monetary value associated with the conversion.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for conversion value.',
    `custom_attributes_json` STRING COMMENT 'JSON string for any additional custom attributes captured at conversion time.',
    `device_type` STRING COMMENT 'Type of device used for the conversion.',
    `discount_code` STRING COMMENT 'Promotional discount code applied, if any.',
    `event_timestamp` TIMESTAMP COMMENT 'Exact time the conversion event occurred.',
    `geo_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of users location.',
    `geo_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of users location.',
    `ip_address` STRING COMMENT 'IP address of the user at time of conversion.',
    `is_new_user` BOOLEAN COMMENT 'Indicates if the user is new (first conversion).',
    `landing_page_url` STRING COMMENT 'Landing page URL where conversion occurred.',
    `location_country` STRING COMMENT 'Three-letter ISO country code of users location. [ENUM-REF-CANDIDATE: list of country codes — promote to reference product]',
    `location_region` STRING COMMENT 'Region or state within the country.',
    `operating_system` STRING COMMENT 'Operating system of the device (e.g., iOS, Android, Windows).',
    `payment_method` STRING COMMENT 'Payment method used for purchase conversion.',
    `payment_status` STRING COMMENT 'Status of the payment transaction.',
    `processing_time_ms` BIGINT COMMENT 'Time in milliseconds taken to process the conversion.',
    `product_category` STRING COMMENT 'High-level category of the product.',
    `quantity` STRING COMMENT 'Number of units involved in the conversion.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the conversion event record was first ingested.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the conversion event record.',
    `referrer_url` STRING COMMENT 'URL of the page that referred the user to the conversion.',
    `shipping_cost` DECIMAL(18,2) COMMENT 'Shipping cost associated with the conversion.',
    `source_channel` STRING COMMENT 'Channel through which the user arrived (e.g., web, mobile app).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount applied to the conversion.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total amount (conversion value + tax + shipping).',
    `user_agent` STRING COMMENT 'User agent string of the browser/device.',
    `user_email` STRING COMMENT 'Email address of the user.',
    `user_phone` STRING COMMENT 'Phone number of the user.',
    CONSTRAINT pk_conversion_event PRIMARY KEY(`conversion_event_id`)
) COMMENT 'Master reference table for conversion_event. Referenced by conversion_event_id.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`session` (
    `session_id` BIGINT COMMENT 'Primary key for session',
    `account_id` BIGINT COMMENT 'Identifier of the customer who generated the session.',
    `ad_group_id` BIGINT COMMENT 'Identifier of the ad group linked to the sessions traffic source.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign associated with the session.',
    `previous_session_id` BIGINT COMMENT 'Self-referencing FK on session (previous_session_id)',
    `app_version` STRING COMMENT 'Version of the mobile or web application used.',
    `average_page_load_time_ms` STRING COMMENT 'Mean time in milliseconds for pages to load during the session.',
    `browser` STRING COMMENT 'Browser used during the session.',
    `city` STRING COMMENT 'City associated with the sessions IP location.',
    `client_time_zone` STRING COMMENT 'IANA time zone identifier of the client device.',
    `conversion_flag` BOOLEAN COMMENT 'True if the session resulted in a conversion (e.g., purchase).',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the sessions origin.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the session record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the purchase amount.',
    `device_brand` STRING COMMENT 'Manufacturer brand of the device.',
    `device_code` STRING COMMENT 'Unique identifier of the device (e.g., mobile advertising ID).',
    `device_model` STRING COMMENT 'Model name/number of the device.',
    `device_type` STRING COMMENT 'Category of device used for the session.',
    `duration_seconds` STRING COMMENT 'Total length of the session in seconds.',
    `error_code` STRING COMMENT 'Code representing the type of error encountered.',
    `error_flag` BOOLEAN COMMENT 'True if an error was recorded during the session.',
    `geo_latitude` DOUBLE COMMENT 'Latitude coordinate derived from IP geolocation.',
    `geo_longitude` DOUBLE COMMENT 'Longitude coordinate derived from IP geolocation.',
    `ip_address` STRING COMMENT 'IP address from which the session originated.',
    `is_bot` BOOLEAN COMMENT 'True if the session is identified as automated traffic.',
    `is_new_visitor` BOOLEAN COMMENT 'True if this is the visitors first session.',
    `language` STRING COMMENT 'Language preference detected for the session.',
    `last_activity_timestamp` TIMESTAMP COMMENT 'Timestamp of the last recorded activity within the session.',
    `network_type` STRING COMMENT 'Type of network connection used during the session.',
    `os` STRING COMMENT 'Operating system of the device.',
    `page_view_count` STRING COMMENT 'Number of pages viewed during the session.',
    `purchase_amount` DECIMAL(18,2) COMMENT 'Monetary value of purchases made in the session.',
    `purchase_count` STRING COMMENT 'Number of distinct purchase events in the session.',
    `referrer_url` STRING COMMENT 'URL of the page that referred the user to the site.',
    `screen_resolution` STRING COMMENT 'Screen resolution reported by the device (e.g., 1920x1080).',
    `session_end` TIMESTAMP COMMENT 'Timestamp when the session ended or was terminated.',
    `session_start` TIMESTAMP COMMENT 'Timestamp when the session began.',
    `session_status` STRING COMMENT 'Current lifecycle status of the session.',
    `session_type` STRING COMMENT 'High‑level purpose of the session.',
    `traffic_source` STRING COMMENT 'Marketing channel that drove the user to the site.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the session record.',
    `user_agent` STRING COMMENT 'Full user‑agent string reported by the browser.',
    CONSTRAINT pk_session PRIMARY KEY(`session_id`)
) COMMENT 'Master reference table for session. Referenced by session_id.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Primary key for org_unit',
    `parent_org_unit_id` BIGINT COMMENT 'Identifier of the immediate parent unit in the organizational hierarchy.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual budget allocated to the unit, expressed in US dollars.',
    `org_unit_code` STRING COMMENT 'Business identifier code for the unit, used in external systems and reporting.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier associated with the unit for financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the organizational unit record was first created.',
    `org_unit_description` STRING COMMENT 'Free‑form description providing additional context about the unit.',
    `effective_from` DATE COMMENT 'Date when the organizational unit became operational.',
    `effective_to` DATE COMMENT 'Date when the organizational unit was retired or ceased operation (null if still active).',
    `email` STRING COMMENT 'Primary contact email address for the unit.',
    `employee_count` STRING COMMENT 'Total number of employees assigned to the unit.',
    `location` STRING COMMENT 'Physical address of the units primary office or facility.',
    `manager_name` STRING COMMENT 'Name of the person responsible for managing the unit.',
    `org_unit_name` STRING COMMENT 'Human‑readable name of the organizational unit.',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the unit.',
    `region` STRING COMMENT 'Geographic region (e.g., North America, EMEA) where the unit primarily operates.',
    `org_unit_status` STRING COMMENT 'Current lifecycle status of the unit.',
    `org_unit_type` STRING COMMENT 'Classification of the unit within the organization hierarchy.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the organizational unit record.',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Master reference table for org_unit. Referenced by org_unit_id.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`incident` (
    `incident_id` BIGINT COMMENT 'Primary key for incident',
    `agent_id` BIGINT COMMENT 'Identifier of the party responsible for handling the incident.',
    `reporter_agent_id` BIGINT COMMENT 'Identifier of the party (customer, internal user, or external partner) who reported the incident.',
    `related_incident_id` BIGINT COMMENT 'Self-referencing FK on incident (related_incident_id)',
    `incident_category` STRING COMMENT 'High‑level classification of the incident type.',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident record was closed and archived.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Monetary cost associated with handling the incident (e.g., labor, refunds).',
    `cost_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the incident cost.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident record was first created in the system.',
    `incident_description` STRING COMMENT 'Detailed free‑text description of the problem reported.',
    `escalation_level` STRING COMMENT 'Level of escalation applied to the incident.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident was escalated to the next level.',
    `impact` STRING COMMENT 'Assessment of the incidents impact on business operations.',
    `incident_number` STRING COMMENT 'Human‑readable identifier assigned to the incident by the incident management system.',
    `incident_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident was initially reported.',
    `is_duplicate` BOOLEAN COMMENT 'Flag indicating whether this incident is a duplicate of an existing one.',
    `priority` STRING COMMENT 'Priority assigned to the incident for triage and resolution scheduling.',
    `resolution_description` STRING COMMENT 'Narrative of how the incident was resolved.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident was marked as resolved.',
    `resolution_type` STRING COMMENT 'Type of resolution applied to the incident.',
    `root_cause` STRING COMMENT 'Identified root cause of the incident after investigation.',
    `severity` STRING COMMENT 'Severity rating indicating the impact and urgency of the incident.',
    `sla_actual_hours` DECIMAL(18,2) COMMENT 'Actual time (in hours) taken to resolve the incident.',
    `sla_target_hours` DECIMAL(18,2) COMMENT 'Target time (in hours) defined by SLA for resolving the incident.',
    `source` STRING COMMENT 'Channel through which the incident was reported.',
    `incident_status` STRING COMMENT 'Current lifecycle state of the incident.',
    `subcategory` STRING COMMENT 'More specific classification within the main category.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the incident record.',
    CONSTRAINT pk_incident PRIMARY KEY(`incident_id`)
) COMMENT 'Master reference table for incident. Referenced by related_incident_id.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`analytics`.`report_schedule` (
    `report_schedule_id` BIGINT COMMENT 'Primary key for report_schedule',
    `agent_id` BIGINT COMMENT 'Identifier of the user responsible for the schedule.',
    `superseded_report_schedule_id` BIGINT COMMENT 'Self-referencing FK on report_schedule (superseded_report_schedule_id)',
    `alert_enabled` BOOLEAN COMMENT 'Whether alerts are sent on schedule failures or successes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule record was first created.',
    `data_retention_days` STRING COMMENT 'Number of days to retain run logs and output before archival.',
    `report_schedule_description` STRING COMMENT 'Free‑form description of the schedule purpose and scope.',
    `email_recipients` STRING COMMENT 'Comma‑separated list of email addresses to receive schedule notifications.',
    `end_date` DATE COMMENT 'Date when the schedule expires; null for indefinite.',
    `failure_reason` STRING COMMENT 'Textual reason for the most recent execution failure.',
    `frequency_interval` STRING COMMENT 'Numeric interval for the schedule (e.g., 2 for every 2 days).',
    `frequency_unit` STRING COMMENT 'Time unit associated with the frequency interval.',
    `is_enabled` BOOLEAN COMMENT 'Indicates whether the schedule is currently enabled for execution.',
    `last_failed_run_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent failed execution of the schedule.',
    `last_run_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent execution of the report.',
    `last_successful_run_timestamp` TIMESTAMP COMMENT 'Timestamp of the last successful execution of the schedule.',
    `max_retries` STRING COMMENT 'Maximum number of retry attempts after a failed run.',
    `next_run_timestamp` TIMESTAMP COMMENT 'Planned timestamp for the next execution of the report.',
    `notify_on_failure` BOOLEAN COMMENT 'Whether to send notifications when a run fails.',
    `notify_on_success` BOOLEAN COMMENT 'Whether to send notifications when a run succeeds.',
    `owner_email` STRING COMMENT 'Email address of the schedule owner for notifications.',
    `priority` STRING COMMENT 'Numeric priority used to order execution when multiple schedules run concurrently.',
    `retry_interval_minutes` STRING COMMENT 'Delay in minutes between retry attempts.',
    `run_duration_seconds` STRING COMMENT 'Execution duration of the most recent run, measured in seconds.',
    `schedule_code` STRING COMMENT 'System‑generated code that uniquely identifies the schedule across environments.',
    `schedule_expression` STRING COMMENT 'Cron‑style expression defining the schedule timing.',
    `schedule_name` STRING COMMENT 'Human‑readable name of the schedule used in reporting dashboards.',
    `schedule_type` STRING COMMENT 'Category of schedule defining its recurrence pattern.',
    `start_date` DATE COMMENT 'Date when the schedule becomes effective.',
    `report_schedule_status` STRING COMMENT 'Current operational status of the schedule.',
    `timezone` STRING COMMENT 'IANA timezone identifier used to interpret schedule times.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the schedule record.',
    CONSTRAINT pk_report_schedule PRIMARY KEY(`report_schedule_id`)
) COMMENT 'Master reference table for report_schedule. Referenced by schedule_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ADD CONSTRAINT `fk_analytics_kpi_definition_parent_kpi_definition_id` FOREIGN KEY (`parent_kpi_definition_id`) REFERENCES `ecommerce_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ADD CONSTRAINT `fk_analytics_metric_value_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `ecommerce_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ADD CONSTRAINT `fk_analytics_metric_value_prior_period_metric_value_id` FOREIGN KEY (`prior_period_metric_value_id`) REFERENCES `ecommerce_ecm`.`analytics`.`metric_value`(`metric_value_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ADD CONSTRAINT `fk_analytics_reporting_dimension_parent_dimension_reporting_dimension_id` FOREIGN KEY (`parent_dimension_reporting_dimension_id`) REFERENCES `ecommerce_ecm`.`analytics`.`reporting_dimension`(`reporting_dimension_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ADD CONSTRAINT `fk_analytics_reporting_dimension_parent_reporting_dimension_id` FOREIGN KEY (`parent_reporting_dimension_id`) REFERENCES `ecommerce_ecm`.`analytics`.`reporting_dimension`(`reporting_dimension_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ADD CONSTRAINT `fk_analytics_dimension_member_parent_member_dimension_member_id` FOREIGN KEY (`parent_member_dimension_member_id`) REFERENCES `ecommerce_ecm`.`analytics`.`dimension_member`(`dimension_member_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ADD CONSTRAINT `fk_analytics_dimension_member_parent_dimension_member_id` FOREIGN KEY (`parent_dimension_member_id`) REFERENCES `ecommerce_ecm`.`analytics`.`dimension_member`(`dimension_member_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ADD CONSTRAINT `fk_analytics_dashboard_definition_cloned_from_dashboard_definition_id` FOREIGN KEY (`cloned_from_dashboard_definition_id`) REFERENCES `ecommerce_ecm`.`analytics`.`dashboard_definition`(`dashboard_definition_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ADD CONSTRAINT `fk_analytics_dashboard_widget_dashboard_definition_id` FOREIGN KEY (`dashboard_definition_id`) REFERENCES `ecommerce_ecm`.`analytics`.`dashboard_definition`(`dashboard_definition_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ADD CONSTRAINT `fk_analytics_dashboard_widget_drilldown_dashboard_widget_id` FOREIGN KEY (`drilldown_dashboard_widget_id`) REFERENCES `ecommerce_ecm`.`analytics`.`dashboard_widget`(`dashboard_widget_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ADD CONSTRAINT `fk_analytics_forecast_model_superseded_forecast_model_id` FOREIGN KEY (`superseded_forecast_model_id`) REFERENCES `ecommerce_ecm`.`analytics`.`forecast_model`(`forecast_model_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ADD CONSTRAINT `fk_analytics_forecast_run_forecast_model_id` FOREIGN KEY (`forecast_model_id`) REFERENCES `ecommerce_ecm`.`analytics`.`forecast_model`(`forecast_model_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ADD CONSTRAINT `fk_analytics_forecast_run_rerun_of_forecast_run_id` FOREIGN KEY (`rerun_of_forecast_run_id`) REFERENCES `ecommerce_ecm`.`analytics`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_forecast_run_id` FOREIGN KEY (`forecast_run_id`) REFERENCES `ecommerce_ecm`.`analytics`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ADD CONSTRAINT `fk_analytics_forecast_output_revised_forecast_output_id` FOREIGN KEY (`revised_forecast_output_id`) REFERENCES `ecommerce_ecm`.`analytics`.`forecast_output`(`forecast_output_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ADD CONSTRAINT `fk_analytics_report_definition_parent_report_definition_id` FOREIGN KEY (`parent_report_definition_id`) REFERENCES `ecommerce_ecm`.`analytics`.`report_definition`(`report_definition_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ADD CONSTRAINT `fk_analytics_report_execution_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `ecommerce_ecm`.`analytics`.`report_definition`(`report_definition_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ADD CONSTRAINT `fk_analytics_report_execution_report_schedule_id` FOREIGN KEY (`report_schedule_id`) REFERENCES `ecommerce_ecm`.`analytics`.`report_schedule`(`report_schedule_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ADD CONSTRAINT `fk_analytics_report_execution_rerun_of_report_execution_id` FOREIGN KEY (`rerun_of_report_execution_id`) REFERENCES `ecommerce_ecm`.`analytics`.`report_execution`(`report_execution_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ecommerce_ecm`.`analytics`.`org_unit`(`org_unit_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `ecommerce_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_tertiary_kpi_definition_id` FOREIGN KEY (`tertiary_kpi_definition_id`) REFERENCES `ecommerce_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ADD CONSTRAINT `fk_analytics_kpi_target_superseded_kpi_target_id` FOREIGN KEY (`superseded_kpi_target_id`) REFERENCES `ecommerce_ecm`.`analytics`.`kpi_target`(`kpi_target_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ADD CONSTRAINT `fk_analytics_analytical_dataset_report_definition_id` FOREIGN KEY (`report_definition_id`) REFERENCES `ecommerce_ecm`.`analytics`.`report_definition`(`report_definition_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ADD CONSTRAINT `fk_analytics_analytical_dataset_derived_from_analytical_dataset_id` FOREIGN KEY (`derived_from_analytical_dataset_id`) REFERENCES `ecommerce_ecm`.`analytics`.`analytical_dataset`(`analytical_dataset_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ADD CONSTRAINT `fk_analytics_cohort_definition_parent_cohort_definition_id` FOREIGN KEY (`parent_cohort_definition_id`) REFERENCES `ecommerce_ecm`.`analytics`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_membership` ADD CONSTRAINT `fk_analytics_cohort_membership_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `ecommerce_ecm`.`analytics`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_membership` ADD CONSTRAINT `fk_analytics_cohort_membership_superseded_cohort_membership_id` FOREIGN KEY (`superseded_cohort_membership_id`) REFERENCES `ecommerce_ecm`.`analytics`.`cohort_membership`(`cohort_membership_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` ADD CONSTRAINT `fk_analytics_funnel_definition_parent_funnel_definition_id` FOREIGN KEY (`parent_funnel_definition_id`) REFERENCES `ecommerce_ecm`.`analytics`.`funnel_definition`(`funnel_definition_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ADD CONSTRAINT `fk_analytics_funnel_event_funnel_definition_id` FOREIGN KEY (`funnel_definition_id`) REFERENCES `ecommerce_ecm`.`analytics`.`funnel_definition`(`funnel_definition_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ADD CONSTRAINT `fk_analytics_funnel_event_session_id` FOREIGN KEY (`session_id`) REFERENCES `ecommerce_ecm`.`analytics`.`session`(`session_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ADD CONSTRAINT `fk_analytics_funnel_event_previous_funnel_event_id` FOREIGN KEY (`previous_funnel_event_id`) REFERENCES `ecommerce_ecm`.`analytics`.`funnel_event`(`funnel_event_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ADD CONSTRAINT `fk_analytics_ab_test_result_attribution_model_id` FOREIGN KEY (`attribution_model_id`) REFERENCES `ecommerce_ecm`.`analytics`.`attribution_model`(`attribution_model_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ADD CONSTRAINT `fk_analytics_ab_test_result_baseline_ab_test_result_id` FOREIGN KEY (`baseline_ab_test_result_id`) REFERENCES `ecommerce_ecm`.`analytics`.`ab_test_result`(`ab_test_result_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ADD CONSTRAINT `fk_analytics_attribution_model_baseline_attribution_model_id` FOREIGN KEY (`baseline_attribution_model_id`) REFERENCES `ecommerce_ecm`.`analytics`.`attribution_model`(`attribution_model_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ADD CONSTRAINT `fk_analytics_attribution_result_attribution_model_id` FOREIGN KEY (`attribution_model_id`) REFERENCES `ecommerce_ecm`.`analytics`.`attribution_model`(`attribution_model_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ADD CONSTRAINT `fk_analytics_attribution_result_conversion_event_id` FOREIGN KEY (`conversion_event_id`) REFERENCES `ecommerce_ecm`.`analytics`.`conversion_event`(`conversion_event_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ADD CONSTRAINT `fk_analytics_attribution_result_reattributed_attribution_result_id` FOREIGN KEY (`reattributed_attribution_result_id`) REFERENCES `ecommerce_ecm`.`analytics`.`attribution_result`(`attribution_result_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ADD CONSTRAINT `fk_analytics_gmv_daily_snapshot_analytical_dataset_id` FOREIGN KEY (`analytical_dataset_id`) REFERENCES `ecommerce_ecm`.`analytics`.`analytical_dataset`(`analytical_dataset_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ADD CONSTRAINT `fk_analytics_gmv_daily_snapshot_prior_day_gmv_daily_snapshot_id` FOREIGN KEY (`prior_day_gmv_daily_snapshot_id`) REFERENCES `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot`(`gmv_daily_snapshot_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ADD CONSTRAINT `fk_analytics_category_performance_analytical_dataset_id` FOREIGN KEY (`analytical_dataset_id`) REFERENCES `ecommerce_ecm`.`analytics`.`analytical_dataset`(`analytical_dataset_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ADD CONSTRAINT `fk_analytics_category_performance_prior_period_category_performance_id` FOREIGN KEY (`prior_period_category_performance_id`) REFERENCES `ecommerce_ecm`.`analytics`.`category_performance`(`category_performance_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ADD CONSTRAINT `fk_analytics_seller_performance_snapshot_analytical_dataset_id` FOREIGN KEY (`analytical_dataset_id`) REFERENCES `ecommerce_ecm`.`analytics`.`analytical_dataset`(`analytical_dataset_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ADD CONSTRAINT `fk_analytics_seller_performance_snapshot_prior_period_seller_performance_snapshot_id` FOREIGN KEY (`prior_period_seller_performance_snapshot_id`) REFERENCES `ecommerce_ecm`.`analytics`.`seller_performance_snapshot`(`seller_performance_snapshot_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ADD CONSTRAINT `fk_analytics_customer_retention_fact_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `ecommerce_ecm`.`analytics`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ADD CONSTRAINT `fk_analytics_customer_retention_fact_prior_period_customer_retention_fact_id` FOREIGN KEY (`prior_period_customer_retention_fact_id`) REFERENCES `ecommerce_ecm`.`analytics`.`customer_retention_fact`(`customer_retention_fact_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ADD CONSTRAINT `fk_analytics_operational_alert_kpi_definition_id` FOREIGN KEY (`kpi_definition_id`) REFERENCES `ecommerce_ecm`.`analytics`.`kpi_definition`(`kpi_definition_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ADD CONSTRAINT `fk_analytics_operational_alert_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `ecommerce_ecm`.`analytics`.`incident`(`incident_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ADD CONSTRAINT `fk_analytics_operational_alert_related_operational_alert_id` FOREIGN KEY (`related_operational_alert_id`) REFERENCES `ecommerce_ecm`.`analytics`.`operational_alert`(`operational_alert_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`conversion_event` ADD CONSTRAINT `fk_analytics_conversion_event_session_id` FOREIGN KEY (`session_id`) REFERENCES `ecommerce_ecm`.`analytics`.`session`(`session_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`conversion_event` ADD CONSTRAINT `fk_analytics_conversion_event_originating_conversion_event_id` FOREIGN KEY (`originating_conversion_event_id`) REFERENCES `ecommerce_ecm`.`analytics`.`conversion_event`(`conversion_event_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`session` ADD CONSTRAINT `fk_analytics_session_previous_session_id` FOREIGN KEY (`previous_session_id`) REFERENCES `ecommerce_ecm`.`analytics`.`session`(`session_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`org_unit` ADD CONSTRAINT `fk_analytics_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `ecommerce_ecm`.`analytics`.`org_unit`(`org_unit_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`incident` ADD CONSTRAINT `fk_analytics_incident_related_incident_id` FOREIGN KEY (`related_incident_id`) REFERENCES `ecommerce_ecm`.`analytics`.`incident`(`incident_id`);
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_schedule` ADD CONSTRAINT `fk_analytics_report_schedule_superseded_report_schedule_id` FOREIGN KEY (`superseded_report_schedule_id`) REFERENCES `ecommerce_ecm`.`analytics`.`report_schedule`(`report_schedule_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`analytics` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `ecommerce_ecm`.`analytics` SET TAGS ('dbx_domain' = 'analytics');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` SET TAGS ('dbx_subdomain' = 'performance_metrics');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'KPI Definition ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'KPI Owner ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `parent_kpi_definition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `aggregation_level` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Level');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `aggregation_level` SET TAGS ('dbx_value_regex' = 'transaction|daily|weekly|monthly|quarterly|yearly');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `business_line` SET TAGS ('dbx_business_glossary_term' = 'Business Line');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `calculation_formula` SET TAGS ('dbx_business_glossary_term' = 'KPI Calculation Formula');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `change_log` SET TAGS ('dbx_business_glossary_term' = 'Change Log');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `data_source_domain` SET TAGS ('dbx_business_glossary_term' = 'Data Source Domain');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential Flag');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_definition_status` SET TAGS ('dbx_business_glossary_term' = 'KPI Status');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_definition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|draft|pending');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_description` SET TAGS ('dbx_business_glossary_term' = 'KPI Description');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `kpi_name` SET TAGS ('dbx_business_glossary_term' = 'KPI Name');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `metric_category` SET TAGS ('dbx_business_glossary_term' = 'Metric Category');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `owner_role` SET TAGS ('dbx_business_glossary_term' = 'KPI Owner Role');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `refresh_cadence` SET TAGS ('dbx_business_glossary_term' = 'Refresh Cadence');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `refresh_cadence` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|monthly|quarterly');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `regulatory_reporting_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Requirement');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `related_kpi_ids` SET TAGS ('dbx_business_glossary_term' = 'Related KPI IDs');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `target_threshold_lower` SET TAGS ('dbx_business_glossary_term' = 'Target Threshold Lower');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `target_threshold_type` SET TAGS ('dbx_business_glossary_term' = 'Target Threshold Type');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `target_threshold_type` SET TAGS ('dbx_value_regex' = 'upper|lower|range');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `target_threshold_upper` SET TAGS ('dbx_business_glossary_term' = 'Target Threshold Upper');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'count|percent|currency|seconds|minutes|hours');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_definition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` SET TAGS ('dbx_subdomain' = 'performance_metrics');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `metric_value_id` SET TAGS ('dbx_business_glossary_term' = 'Metric Value ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `indexed_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Content Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `procurement_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `result_id` SET TAGS ('dbx_business_glossary_term' = 'Result Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `prior_period_metric_value_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `computation_method` SET TAGS ('dbx_business_glossary_term' = 'Computation Method (Metric Calculation Methodology)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `compute_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Computation Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score (Metric Confidence Level)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217 Currency)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `data_freshness_indicator` SET TAGS ('dbx_business_glossary_term' = 'Data Freshness Indicator (Metric Freshness Status)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `data_freshness_indicator` SET TAGS ('dbx_value_regex' = 'fresh|stale|delayed');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `dimension_category` SET TAGS ('dbx_business_glossary_term' = 'Category Dimension (Product Category)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `dimension_channel` SET TAGS ('dbx_business_glossary_term' = 'Channel Dimension (Sales Channel)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `dimension_channel` SET TAGS ('dbx_value_regex' = 'online|mobile|store');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `dimension_region` SET TAGS ('dbx_business_glossary_term' = 'Region Dimension (Geographic Region Code)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `dimension_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `dimension_seller_tier` SET TAGS ('dbx_business_glossary_term' = 'Seller Tier Dimension (Seller Tier Level)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `dimension_seller_tier` SET TAGS ('dbx_value_regex' = 'gold|silver|bronze');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `is_estimated` SET TAGS ('dbx_business_glossary_term' = 'Is Estimated Flag (Estimated Metric Indicator)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Metric Name (KPI Name)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `metric_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Metric Period Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `metric_value` SET TAGS ('dbx_business_glossary_term' = 'Metric Value (Numeric Result)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `metric_value_status` SET TAGS ('dbx_business_glossary_term' = 'Metric Status (Record Status)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `metric_value_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (Additional Comments or Context)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `period_grain` SET TAGS ('dbx_business_glossary_term' = 'Period Grain (Aggregation Granularity)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `period_grain` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|yearly');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (Originating System Name)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`metric_value` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (Metric Unit)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` SET TAGS ('dbx_subdomain' = 'performance_metrics');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `reporting_dimension_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Dimension ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `parent_dimension_reporting_dimension_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Dimension ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `warehouse_node_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Node Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `parent_reporting_dimension_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `default_format` SET TAGS ('dbx_business_glossary_term' = 'Default Format');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `default_sort_order` SET TAGS ('dbx_business_glossary_term' = 'Default Sort Order');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `default_sort_order` SET TAGS ('dbx_value_regex' = 'asc|desc');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `dimension_group` SET TAGS ('dbx_business_glossary_term' = 'Dimension Group');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `domain` SET TAGS ('dbx_business_glossary_term' = 'Domain');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `domain` SET TAGS ('dbx_value_regex' = 'analytics|finance|marketing|sales|inventory|fulfillment');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `grain_level` SET TAGS ('dbx_business_glossary_term' = 'Grain Level');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `grain_level` SET TAGS ('dbx_value_regex' = 'day|week|month|quarter|year');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `hierarchy_depth` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Depth');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `is_custom` SET TAGS ('dbx_business_glossary_term' = 'Is Custom Dimension');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `is_hierarchical` SET TAGS ('dbx_business_glossary_term' = 'Is Hierarchical');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `is_time_dimension` SET TAGS ('dbx_business_glossary_term' = 'Is Time Dimension');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `is_time_zone_aware` SET TAGS ('dbx_business_glossary_term' = 'Is Time Zone Aware');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `reporting_dimension_code` SET TAGS ('dbx_business_glossary_term' = 'Dimension Code');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `reporting_dimension_description` SET TAGS ('dbx_business_glossary_term' = 'Dimension Description');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `reporting_dimension_name` SET TAGS ('dbx_business_glossary_term' = 'Dimension Name');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `reporting_dimension_status` SET TAGS ('dbx_business_glossary_term' = 'Dimension Status');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `reporting_dimension_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|draft');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `reporting_dimension_type` SET TAGS ('dbx_business_glossary_term' = 'Dimension Type');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `reporting_dimension_type` SET TAGS ('dbx_value_regex' = 'time|geography|product_hierarchy|customer_segment|channel|seller_tier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `time_zone` SET TAGS ('dbx_value_regex' = 'UTC|[A-Z]{3}');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`reporting_dimension` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Dimension Version');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` SET TAGS ('dbx_subdomain' = 'performance_metrics');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ALTER COLUMN `dimension_member_id` SET TAGS ('dbx_business_glossary_term' = 'Dimension Member ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ALTER COLUMN `dimension_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ALTER COLUMN `dimension_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ALTER COLUMN `parent_member_dimension_member_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Member ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ALTER COLUMN `parent_member_dimension_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ALTER COLUMN `parent_member_dimension_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ALTER COLUMN `parent_dimension_member_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ALTER COLUMN `dimension_member_description` SET TAGS ('dbx_business_glossary_term' = 'Member Description');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ALTER COLUMN `dimension_member_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ALTER COLUMN `member_code` SET TAGS ('dbx_business_glossary_term' = 'Member Code');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ALTER COLUMN `member_name` SET TAGS ('dbx_business_glossary_term' = 'Member Name');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ALTER COLUMN `member_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ALTER COLUMN `member_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ALTER COLUMN `member_type` SET TAGS ('dbx_business_glossary_term' = 'Member Type');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ALTER COLUMN `member_type` SET TAGS ('dbx_value_regex' = 'product|geography|organization|customer_segment|seller|marketing');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dimension_member` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` SET TAGS ('dbx_subdomain' = 'dashboard_management');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `dashboard_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Definition ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Team Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `cloned_from_dashboard_definition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `access_tier` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Access Tier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `access_tier` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Approval Status');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Approved By');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Approved Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Compliance Status');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `dashboard_definition_code` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Code');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `dashboard_definition_description` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Description');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `dashboard_definition_name` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Name');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `dashboard_definition_status` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Lifecycle Status');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `dashboard_definition_status` SET TAGS ('dbx_value_regex' = 'draft|published|retired|archived');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `dashboard_definition_type` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Type');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `dashboard_definition_type` SET TAGS ('dbx_value_regex' = 'operational|executive|seller|finance|marketing|analytics');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `data_domains` SET TAGS ('dbx_business_glossary_term' = 'Data Domains Consumed');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Data Quality Score');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Deprecation Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `is_template` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Template Flag');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Last Modified By');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `last_refreshed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Last Refreshed Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `layout_configuration` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Layout Configuration');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `metric_count` SET TAGS ('dbx_business_glossary_term' = 'Metric Count');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Notes');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `privacy_level` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Privacy Level');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `privacy_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `publication_status` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Publication Status');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `publication_status` SET TAGS ('dbx_value_regex' = 'published|unpublished|scheduled');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Refresh Frequency');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Retention Policy');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Source System');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Target Audience');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `target_audience` SET TAGS ('dbx_value_regex' = 'executive|operational|seller|finance|marketing|analytics');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Version Number');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_definition` ALTER COLUMN `visualization_count` SET TAGS ('dbx_business_glossary_term' = 'Visualization Count');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` SET TAGS ('dbx_subdomain' = 'dashboard_management');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `dashboard_widget_id` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Widget ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `dashboard_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Dashboard Definition Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Agent Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `drilldown_dashboard_widget_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `bound_kpi` SET TAGS ('dbx_business_glossary_term' = 'Bound KPI Identifier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `chart_color_scheme` SET TAGS ('dbx_business_glossary_term' = 'Chart Color Scheme');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `dashboard_widget_description` SET TAGS ('dbx_business_glossary_term' = 'Widget Description');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `dashboard_widget_name` SET TAGS ('dbx_business_glossary_term' = 'Widget Name');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `dashboard_widget_status` SET TAGS ('dbx_business_glossary_term' = 'Widget Status');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `dashboard_widget_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|draft');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source Identifier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `dimension_filters` SET TAGS ('dbx_business_glossary_term' = 'Dimension Filters');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `display_format` SET TAGS ('dbx_business_glossary_term' = 'Display Format');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `drilldown_enabled` SET TAGS ('dbx_business_glossary_term' = 'Drilldown Enabled Flag');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `error_state` SET TAGS ('dbx_business_glossary_term' = 'Error State');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `error_state` SET TAGS ('dbx_value_regex' = 'none|warning|error');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `exportable` SET TAGS ('dbx_business_glossary_term' = 'Exportable Flag');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `height` SET TAGS ('dbx_business_glossary_term' = 'Widget Height');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `is_shared` SET TAGS ('dbx_business_glossary_term' = 'Shared Flag');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `position_x` SET TAGS ('dbx_business_glossary_term' = 'Position X');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `position_y` SET TAGS ('dbx_business_glossary_term' = 'Position Y');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `refresh_interval_minutes` SET TAGS ('dbx_business_glossary_term' = 'Refresh Interval (Minutes)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `tooltip_enabled` SET TAGS ('dbx_business_glossary_term' = 'Tooltip Enabled Flag');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `widget_type` SET TAGS ('dbx_business_glossary_term' = 'Widget Type');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `widget_type` SET TAGS ('dbx_value_regex' = 'bar_chart|line_chart|scorecard|table|funnel|heatmap');
ALTER TABLE `ecommerce_ecm`.`analytics`.`dashboard_widget` ALTER COLUMN `width` SET TAGS ('dbx_business_glossary_term' = 'Widget Width');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` SET TAGS ('dbx_subdomain' = 'forecasting_operations');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `forecast_model_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model ID (FMID)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Training Data Snapshot ID (TDSID)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `superseded_forecast_model_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `algorithm_family` SET TAGS ('dbx_business_glossary_term' = 'Algorithm Family (AF)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `algorithm_family` SET TAGS ('dbx_value_regex' = 'ARIMA|Prophet|XGBoost|LSTM|RandomForest|LinearRegression');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `data_privacy_level` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Level (DPL)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `data_privacy_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status (DS)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `deployment_status` SET TAGS ('dbx_value_regex' = 'deployed|testing|retired|failed');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `evaluation_metric` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Metric (EM)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `evaluation_metric` SET TAGS ('dbx_value_regex' = 'MAPE|RMSE|MAE|R2');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `feature_set_description` SET TAGS ('dbx_business_glossary_term' = 'Feature Set Description (FSD)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `forecast_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon (Days) (FHD)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `hyperparameters` SET TAGS ('dbx_business_glossary_term' = 'Model Hyperparameters (HP)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `last_trained_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Trained Timestamp (LTT)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Model Accuracy Percentage (MAP)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_deployment_environment` SET TAGS ('dbx_business_glossary_term' = 'Deployment Environment (DE)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_deployment_environment` SET TAGS ('dbx_value_regex' = 'production|staging|dev');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_deployment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deployment Timestamp (DT)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_description` SET TAGS ('dbx_business_glossary_term' = 'Model Description (MD)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Model Endpoint URL (MEU)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_feature_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Features Used (NFU)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_last_evaluated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Evaluation Timestamp (LET)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_mae` SET TAGS ('dbx_business_glossary_term' = 'Mean Absolute Error (MAE)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_mape` SET TAGS ('dbx_business_glossary_term' = 'Mean Absolute Percentage Error (MAPE)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Name (FMN)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_notes` SET TAGS ('dbx_business_glossary_term' = 'Model Notes (MN)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_owner_contact` SET TAGS ('dbx_business_glossary_term' = 'Model Owner Email Contact (MOEC)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_owner_contact` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_owner_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_owner_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_owner_phone` SET TAGS ('dbx_business_glossary_term' = 'Model Owner Phone Number (MOPN)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_owner_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_owner_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Model Retirement Date (MRD)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Model Risk Score (MRS)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_rmse` SET TAGS ('dbx_business_glossary_term' = 'Root Mean Squared Error (RMSE)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_status` SET TAGS ('dbx_business_glossary_term' = 'Model Status (MS)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_training_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Training Cost (USD) (TC)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_training_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Training Duration (Seconds) (TD)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Type (FMT)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'demand_forecast|revenue_forecast|inventory_forecast|churn_forecast');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version (MV)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `owner_team` SET TAGS ('dbx_business_glossary_term' = 'Owner Team (OT)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status (RCS)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `target_variable` SET TAGS ('dbx_business_glossary_term' = 'Target Variable (TV)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `training_data_domain` SET TAGS ('dbx_business_glossary_term' = 'Training Data Domain (TDD)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_model` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` SET TAGS ('dbx_subdomain' = 'forecasting_operations');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `forecast_run_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Run Identifier (FRID)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `forecast_model_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Input Data Snapshot Identifier (IDSID)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `rerun_of_forecast_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `compliance_gdpr_flag` SET TAGS ('dbx_business_glossary_term' = 'GDPR Compliance Flag (GDPRF)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Forecast Confidence Interval Lower Bound (FCILB)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Forecast Confidence Interval Upper Bound (FCIUB)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CC)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|AUD');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag (DQF)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'pass|warning|fail');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Input Data (SSID)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message (EM)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Execution Status (FES)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `execution_status` SET TAGS ('dbx_value_regex' = 'success|failed|running|cancelled|pending');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `forecast_horizon` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon (FH)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `forecast_horizon` SET TAGS ('dbx_value_regex' = 'days|weeks|months|quarters|years');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `forecast_units` SET TAGS ('dbx_business_glossary_term' = 'Forecast Units (FU)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `forecast_units` SET TAGS ('dbx_value_regex' = 'units|dollars|percentage|ratio');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `horizon_value` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon Length (FHL)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `is_comparison_base` SET TAGS ('dbx_business_glossary_term' = 'Comparison Base Flag (CBF)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `is_reproducible` SET TAGS ('dbx_business_glossary_term' = 'Reproducibility Flag (RF)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `model_owner` SET TAGS ('dbx_business_glossary_term' = 'Model Owner Team (MOT)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Run Notes (RN)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `output_period_end` SET TAGS ('dbx_business_glossary_term' = 'Forecast Output Period End Date (FOPED)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `output_period_start` SET TAGS ('dbx_business_glossary_term' = 'Forecast Output Period Start Date (FOPSD)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `parameter_set_code` SET TAGS ('dbx_business_glossary_term' = 'Model Parameter Set Identifier (MPSID)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `resource_usage_cpu_seconds` SET TAGS ('dbx_business_glossary_term' = 'CPU Usage Seconds (CPU_SEC)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `resource_usage_memory_mb` SET TAGS ('dbx_business_glossary_term' = 'Memory Usage Megabytes (MEM_MB)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `run_environment` SET TAGS ('dbx_business_glossary_term' = 'Run Environment (RENV)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `run_environment` SET TAGS ('dbx_value_regex' = 'production|development|testing|staging');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `run_id_external` SET TAGS ('dbx_business_glossary_term' = 'External Run Identifier (ERID)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `run_source` SET TAGS ('dbx_business_glossary_term' = 'Run Source Channel (RSC)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `run_source` SET TAGS ('dbx_value_regex' = 'scheduled|on_demand|api|manual');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Timestamp (RTS)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `run_user` SET TAGS ('dbx_business_glossary_term' = 'Run Initiating User (RIU)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_business_glossary_term' = 'Forecast Runtime Duration Seconds (FRDS)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` SET TAGS ('dbx_subdomain' = 'forecasting_operations');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `forecast_output_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Output ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Target ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `forecast_run_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Run ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `revised_forecast_output_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percentage');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `confidence_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `confidence_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `forecast_period_end` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period End Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `forecast_period_start` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period Start Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `forecast_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Run Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'pending|completed|error|canceled|in_progress');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `forecast_target_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Target Type');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `forecast_target_type` SET TAGS ('dbx_value_regex' = 'sku|category|region|seller|brand|department');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `forecast_value` SET TAGS ('dbx_business_glossary_term' = 'Forecast Value');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Name');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'units|dollars|items|kg|liters|percent');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`forecast_output` ALTER COLUMN `variance` SET TAGS ('dbx_business_glossary_term' = 'Forecast Variance');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` SET TAGS ('dbx_subdomain' = 'dashboard_management');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Definition ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Report Owner User ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Team Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `parent_report_definition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `data_domains` SET TAGS ('dbx_business_glossary_term' = 'Data Domains Consumed');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Distribution List');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `estimated_output_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Estimated Output Size (MB)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `estimated_run_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Estimated Run Time (Seconds)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Report Delivery Format');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `format` SET TAGS ('dbx_value_regex' = 'PDF|Excel|CSV|Embedded|HTML');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `governance_classification` SET TAGS ('dbx_business_glossary_term' = 'Governance Classification');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `governance_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `is_executive` SET TAGS ('dbx_business_glossary_term' = 'Is Executive Report');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `is_financial` SET TAGS ('dbx_business_glossary_term' = 'Is Financial Report');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `is_operational` SET TAGS ('dbx_business_glossary_term' = 'Is Operational Report');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `is_regulatory` SET TAGS ('dbx_business_glossary_term' = 'Is Regulatory Report');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `is_scheduled` SET TAGS ('dbx_business_glossary_term' = 'Is Report Scheduled');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `is_seller` SET TAGS ('dbx_business_glossary_term' = 'Is Seller‑Facing Report');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `last_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Run Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `next_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Run Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Owner Contact Email');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `parameters_json` SET TAGS ('dbx_business_glossary_term' = 'Report Parameters (JSON)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_definition_code` SET TAGS ('dbx_business_glossary_term' = 'Report Code');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_definition_description` SET TAGS ('dbx_business_glossary_term' = 'Report Description');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_definition_name` SET TAGS ('dbx_business_glossary_term' = 'Report Name');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_definition_status` SET TAGS ('dbx_business_glossary_term' = 'Report Lifecycle Status');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_definition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|draft|pending');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_definition_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_definition_type` SET TAGS ('dbx_value_regex' = 'operational|executive|regulatory|seller|financial|ad_hoc');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `report_version` SET TAGS ('dbx_business_glossary_term' = 'Report Version');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `schedule_cron` SET TAGS ('dbx_business_glossary_term' = 'Report Schedule Cron Expression');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `schedule_frequency` SET TAGS ('dbx_business_glossary_term' = 'Report Schedule Frequency');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `schedule_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|on_demand');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `schedule_timezone` SET TAGS ('dbx_business_glossary_term' = 'Schedule Timezone');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_definition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` SET TAGS ('dbx_subdomain' = 'dashboard_management');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `report_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Report Execution ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Agent Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Definition ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `report_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `rerun_of_report_execution_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Report Delivery Channel');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_value_regex' = 'email|s3|bi_tool');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Report Error Code');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `error_details` SET TAGS ('dbx_business_glossary_term' = 'Report Error Details');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `execution_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Report Execution Duration (Seconds)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `execution_environment` SET TAGS ('dbx_business_glossary_term' = 'Execution Environment');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `execution_environment` SET TAGS ('dbx_value_regex' = 'prod|dev|test|staging');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Report Execution Status');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_value_regex' = 'success|failure|partial');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Execution Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Report File Size (Bytes)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `recipient_list` SET TAGS ('dbx_business_glossary_term' = 'Report Recipients');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `report_format` SET TAGS ('dbx_business_glossary_term' = 'Report File Format');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `report_format` SET TAGS ('dbx_value_regex' = 'pdf|csv|xlsx|json');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `report_parameters` SET TAGS ('dbx_business_glossary_term' = 'Report Parameters');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `report_version` SET TAGS ('dbx_business_glossary_term' = 'Report Version');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `row_count` SET TAGS ('dbx_business_glossary_term' = 'Rows Returned');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `triggered_by` SET TAGS ('dbx_business_glossary_term' = 'Report Trigger Source');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `triggered_by` SET TAGS ('dbx_value_regex' = 'scheduled|manual|api');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_execution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` SET TAGS ('dbx_subdomain' = 'performance_metrics');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `kpi_target_id` SET TAGS ('dbx_business_glossary_term' = 'KPI Target Identifier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Target Owner Identifier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Identifier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Team Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'KPI Identifier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `tertiary_kpi_definition_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `superseded_kpi_target_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `ceiling_threshold` SET TAGS ('dbx_business_glossary_term' = 'Ceiling Threshold');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Target End Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `floor_threshold` SET TAGS ('dbx_business_glossary_term' = 'Floor Threshold');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Target Frequency');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Target Flag');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `kpi_target_status` SET TAGS ('dbx_business_glossary_term' = 'Target Status');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `kpi_target_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'percent|currency|count|seconds|minutes|hours');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Target Notes');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `organizational_scope` SET TAGS ('dbx_business_glossary_term' = 'Organizational Scope');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `organizational_scope` SET TAGS ('dbx_value_regex' = 'company|business_unit|channel|region|seller_tier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `stretch_target_value` SET TAGS ('dbx_business_glossary_term' = 'Stretch Target Value');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Target Owner Name');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_period` SET TAGS ('dbx_business_glossary_term' = 'Target Period');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_period` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|weekly|daily');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_type` SET TAGS ('dbx_business_glossary_term' = 'Target Type');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_type` SET TAGS ('dbx_value_regex' = 'absolute|relative|percentage');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `ecommerce_ecm`.`analytics`.`kpi_target` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` SET TAGS ('dbx_subdomain' = 'forecasting_operations');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `analytical_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Dataset Identifier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Definition Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `derived_from_analytical_dataset_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `analytical_dataset_description` SET TAGS ('dbx_business_glossary_term' = 'Dataset Description');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `consumer_sla` SET TAGS ('dbx_business_glossary_term' = 'Consumer SLA');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `dataset_name` SET TAGS ('dbx_business_glossary_term' = 'Dataset Name');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `domain` SET TAGS ('dbx_business_glossary_term' = 'Dataset Domain');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `domain` SET TAGS ('dbx_value_regex' = 'core|marketing|finance|logistics|seller|content');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `grain` SET TAGS ('dbx_business_glossary_term' = 'Dataset Grain');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Dataset Owner Email');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `owner` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `owner` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `owner` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `row_count` SET TAGS ('dbx_business_glossary_term' = 'Row Count');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `schema_version` SET TAGS ('dbx_business_glossary_term' = 'Schema Version');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `schema_version` SET TAGS ('dbx_value_regex' = '^vd+.d+$');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `storage_path` SET TAGS ('dbx_business_glossary_term' = 'Storage Path');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `storage_path` SET TAGS ('dbx_value_regex' = '^/.*$');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `update_frequency` SET TAGS ('dbx_business_glossary_term' = 'Update Frequency');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `update_frequency` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly|quarterly|yearly');
ALTER TABLE `ecommerce_ecm`.`analytics`.`analytical_dataset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` SET TAGS ('dbx_subdomain' = 'commercial_insights');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Definition ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `parent_cohort_definition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `cohort_definition_code` SET TAGS ('dbx_business_glossary_term' = 'Cohort Code');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `cohort_definition_description` SET TAGS ('dbx_business_glossary_term' = 'Cohort Description');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `cohort_definition_name` SET TAGS ('dbx_business_glossary_term' = 'Cohort Name');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `cohort_definition_status` SET TAGS ('dbx_business_glossary_term' = 'Cohort Status');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `cohort_definition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|draft');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `cohort_definition_type` SET TAGS ('dbx_business_glossary_term' = 'Cohort Type');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `cohort_definition_type` SET TAGS ('dbx_value_regex' = 'acquisition|behavioral|value|custom');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `cohort_size_estimate` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cohort Size');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cohort Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `formation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Cohort Formation Criteria');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `formation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Cohort Formation End Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `formation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Cohort Formation Start Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `grain` SET TAGS ('dbx_business_glossary_term' = 'Cohort Grain');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `grain` SET TAGS ('dbx_value_regex' = 'customer|seller|sku');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `is_dynamic` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Cohort Flag');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cohort Last Refresh Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Analytics Team');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `privacy_level` SET TAGS ('dbx_business_glossary_term' = 'Cohort Privacy Level');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `privacy_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `refresh_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Refresh Frequency (Days)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `retention_window_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Window (Days)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cohort Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_definition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Cohort Definition Version');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_membership` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_membership` SET TAGS ('dbx_subdomain' = 'commercial_insights');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_membership` ALTER COLUMN `cohort_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Membership ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_membership` ALTER COLUMN `cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_membership` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_membership` ALTER COLUMN `superseded_cohort_membership_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_membership` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Cohort Entry Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_membership` ALTER COLUMN `exit_date` SET TAGS ('dbx_business_glossary_term' = 'Cohort Exit Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_membership` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_membership` ALTER COLUMN `member_type` SET TAGS ('dbx_business_glossary_term' = 'Member Type');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_membership` ALTER COLUMN `member_type` SET TAGS ('dbx_value_regex' = 'customer|seller|sku');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_membership` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_membership` ALTER COLUMN `period_index` SET TAGS ('dbx_business_glossary_term' = 'Cohort Period Index');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_membership` ALTER COLUMN `retention_status` SET TAGS ('dbx_business_glossary_term' = 'Retention Status');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_membership` ALTER COLUMN `retention_status` SET TAGS ('dbx_value_regex' = 'retained|churned|inactive|unknown');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_membership` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`analytics`.`cohort_membership` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` SET TAGS ('dbx_subdomain' = 'commercial_insights');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `funnel_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Funnel Definition ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `parent_funnel_definition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `conversion_window_days` SET TAGS ('dbx_business_glossary_term' = 'Conversion Window (Days)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `entry_event` SET TAGS ('dbx_business_glossary_term' = 'Funnel Entry Event');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `exit_event` SET TAGS ('dbx_business_glossary_term' = 'Funnel Exit Event');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `funnel_definition_code` SET TAGS ('dbx_business_glossary_term' = 'Funnel Code');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `funnel_definition_description` SET TAGS ('dbx_business_glossary_term' = 'Funnel Description');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `funnel_definition_name` SET TAGS ('dbx_business_glossary_term' = 'Funnel Name');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `funnel_definition_status` SET TAGS ('dbx_business_glossary_term' = 'Funnel Status');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `funnel_definition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|deprecated');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `funnel_definition_type` SET TAGS ('dbx_business_glossary_term' = 'Funnel Type');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `funnel_definition_type` SET TAGS ('dbx_value_regex' = 'purchase|seller_onboarding|checkout|search_to_purchase');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `stages` SET TAGS ('dbx_business_glossary_term' = 'Funnel Stages');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_definition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Funnel Definition Version');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` SET TAGS ('dbx_subdomain' = 'commercial_insights');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `funnel_event_id` SET TAGS ('dbx_business_glossary_term' = 'Funnel Event ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `ab_test_variant_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `click_event_id` SET TAGS ('dbx_business_glossary_term' = 'Click Identifier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `funnel_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Funnel Definition ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `previous_funnel_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `abandonment_reason` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Reason');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `abandonment_reason` SET TAGS ('dbx_value_regex' = 'timeout|lost_interest|error|other');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `attribution_model` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `attribution_model` SET TAGS ('dbx_value_regex' = 'last_click|first_click|linear|time_decay|position_based');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `browser` SET TAGS ('dbx_business_glossary_term' = 'Browser Name');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Channel');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|email|social|offline');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `conversion_flag` SET TAGS ('dbx_business_glossary_term' = 'Conversion Flag');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `device_os_version` SET TAGS ('dbx_business_glossary_term' = 'Device OS Version');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `entered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Stage Entry Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'customer|seller|session');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `event_payload` SET TAGS ('dbx_business_glossary_term' = 'Event Payload');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `event_source` SET TAGS ('dbx_business_glossary_term' = 'Event Source');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `exited_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Stage Exit Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `funnel_stage_entry_method` SET TAGS ('dbx_business_glossary_term' = 'Stage Entry Method');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `funnel_stage_entry_method` SET TAGS ('dbx_value_regex' = 'click|view|auto');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `geo_country` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 alpha‑3)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `geo_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `geo_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `is_abandoned` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Flag');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `is_new_user` SET TAGS ('dbx_business_glossary_term' = 'New User Flag');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `is_returning_user` SET TAGS ('dbx_business_glossary_term' = 'Returning User Flag');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `order_value` SET TAGS ('dbx_business_glossary_term' = 'Order Value (USD)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `page_url` SET TAGS ('dbx_business_glossary_term' = 'Page URL');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `referrer_url` SET TAGS ('dbx_business_glossary_term' = 'Referrer URL');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `screen_resolution` SET TAGS ('dbx_business_glossary_term' = 'Screen Resolution');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `source_medium` SET TAGS ('dbx_business_glossary_term' = 'Source Medium');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `source_medium` SET TAGS ('dbx_value_regex' = 'organic|paid|referral|email');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `stage_name` SET TAGS ('dbx_business_glossary_term' = 'Funnel Stage Name');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `stage_sequence` SET TAGS ('dbx_business_glossary_term' = 'Funnel Stage Sequence');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`funnel_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` SET TAGS ('dbx_subdomain' = 'commercial_insights');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `ab_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'AB Test Result ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `ab_test_variant_id` SET TAGS ('dbx_business_glossary_term' = 'Variant ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `attribution_model_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `baseline_ab_test_result_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `ab_test_result_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (STATUS)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `ab_test_result_status` SET TAGS ('dbx_value_regex' = 'active|archived|deleted');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound (CI_LOWER)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound (CI_UPPER)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percentage (CONFIDENCE_LEVEL)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `control_value` SET TAGS ('dbx_business_glossary_term' = 'Control Metric Value (CONTROL_VALUE)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `event_payload` SET TAGS ('dbx_business_glossary_term' = 'Event Payload JSON (EVENT_PAYLOAD)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type (EVENT_TYPE)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'result');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `experiment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Experiment End Date (EXP_END_DATE)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `experiment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Experiment Start Date (EXP_START_DATE)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `is_statistically_significant` SET TAGS ('dbx_business_glossary_term' = 'Statistical Significance Flag (STAT_SIGNIFICANT)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Metric Name (METRIC_NAME)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `observed_value` SET TAGS ('dbx_business_glossary_term' = 'Observed Metric Value (OBSERVED_VALUE)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `p_value` SET TAGS ('dbx_business_glossary_term' = 'P-Value (P_VALUE)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `relative_lift` SET TAGS ('dbx_business_glossary_term' = 'Relative Lift Percentage (RELATIVE_LIFT)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `result_recorded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Result Recorded Timestamp (RESULT_RECORDED_TS)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size (SAMPLE_SIZE)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type (TEST_TYPE)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'ab|multivariate');
ALTER TABLE `ecommerce_ecm`.`analytics`.`ab_test_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` SET TAGS ('dbx_subdomain' = 'commercial_insights');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `attribution_model_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `baseline_attribution_model_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `attribution_model_code` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model Code');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `attribution_model_description` SET TAGS ('dbx_business_glossary_term' = 'Model Description');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `attribution_model_name` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model Name');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `attribution_model_status` SET TAGS ('dbx_business_glossary_term' = 'Model Lifecycle Status (STATUS)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `attribution_model_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|draft|pending');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `attribution_type` SET TAGS ('dbx_business_glossary_term' = 'Attribution Type (ATTRIBUTION_TYPE)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `attribution_type` SET TAGS ('dbx_value_regex' = 'last_click|first_click|linear|time_decay|data_driven');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `channel_weighting_json` SET TAGS ('dbx_business_glossary_term' = 'Channel Weighting Configuration (JSON)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `conversion_event` SET TAGS ('dbx_business_glossary_term' = 'Conversion Event Definition (CONVERSION_EVENT)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `conversion_event` SET TAGS ('dbx_value_regex' = 'purchase|signup|add_to_cart|checkout|subscription');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Model Data Source');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status (DEPLOYMENT_STATUS)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `deployment_status` SET TAGS ('dbx_value_regex' = 'deployed|testing|retired');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Model Flag');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `last_evaluated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Evaluation Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `lookback_window_days` SET TAGS ('dbx_business_glossary_term' = 'Lookback Window (DAYS)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `model_owner` SET TAGS ('dbx_business_glossary_term' = 'Model Owner Team');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version (VERSION)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Model Performance Score');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `privacy_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Privacy Impact Assessment (PIA)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (DAYS)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_model` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` SET TAGS ('dbx_subdomain' = 'commercial_insights');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ALTER COLUMN `attribution_result_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Result Identifier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ALTER COLUMN `attribution_model_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ALTER COLUMN `conversion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Event Identifier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ALTER COLUMN `reattributed_attribution_result_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ALTER COLUMN `attributed_order_count` SET TAGS ('dbx_business_glossary_term' = 'Attributed Order Count');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ALTER COLUMN `attributed_revenue` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue (USD)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ALTER COLUMN `attribution_status` SET TAGS ('dbx_business_glossary_term' = 'Attribution Status');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ALTER COLUMN `attribution_status` SET TAGS ('dbx_value_regex' = 'pending|completed|error');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ALTER COLUMN `computation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Computation Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ALTER COLUMN `credit_weight` SET TAGS ('dbx_business_glossary_term' = 'Credit Weight');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ALTER COLUMN `is_estimated` SET TAGS ('dbx_business_glossary_term' = 'Is Estimated Flag');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Sequence');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Attribution Notes');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ALTER COLUMN `touchpoint_campaign` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Campaign Code');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ALTER COLUMN `touchpoint_channel` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Channel');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ALTER COLUMN `touchpoint_channel` SET TAGS ('dbx_value_regex' = 'email|search|social|display|referral|direct');
ALTER TABLE `ecommerce_ecm`.`analytics`.`attribution_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` SET TAGS ('dbx_subdomain' = 'commercial_insights');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `gmv_daily_snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'GMV Daily Snapshot Surrogate Key');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `analytical_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Dataset Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `marketplace_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Transaction Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `prior_day_gmv_daily_snapshot_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `active_buyer_count` SET TAGS ('dbx_business_glossary_term' = 'Active Buyer Count');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `average_order_value` SET TAGS ('dbx_business_glossary_term' = 'Average Order Value (AOV)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `cancellation_rate` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Rate');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'direct|marketplace|partner|affiliate');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `data_freshness_indicator` SET TAGS ('dbx_business_glossary_term' = 'Data Freshness Indicator');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `data_freshness_indicator` SET TAGS ('dbx_value_regex' = 'fresh|stale|delayed');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `gmv_daily_snapshot_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `gmv_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Merchandise Value (GMV) – Gross');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `gmv_net` SET TAGS ('dbx_business_glossary_term' = 'Gross Merchandise Value (GMV) – Net');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `order_count` SET TAGS ('dbx_business_glossary_term' = 'Order Count');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `platform` SET TAGS ('dbx_value_regex' = 'website|mobile_app|api|storefront');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `return_rate` SET TAGS ('dbx_business_glossary_term' = 'Return Rate');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `seller_tier` SET TAGS ('dbx_business_glossary_term' = 'Seller Tier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `seller_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `snapshot_status` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Status');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `snapshot_status` SET TAGS ('dbx_value_regex' = 'pending|finalized|error');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`analytics`.`gmv_daily_snapshot` ALTER COLUMN `take_rate` SET TAGS ('dbx_business_glossary_term' = 'Take Rate');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` SET TAGS ('dbx_subdomain' = 'commercial_insights');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `category_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Category Performance Record ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `analytical_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Dataset Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `listing_category_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Category Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `prior_period_category_performance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `average_items_per_order` SET TAGS ('dbx_business_glossary_term' = 'Average Items Per Order');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `average_order_value` SET TAGS ('dbx_business_glossary_term' = 'Average Order Value (AOV)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `average_selling_price` SET TAGS ('dbx_business_glossary_term' = 'Average Selling Price (ASP)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `avg_selling_price_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Average Selling Price Currency Code');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `avg_selling_price_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `category_performance_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `category_performance_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate (CR)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `gmv` SET TAGS ('dbx_business_glossary_term' = 'Gross Merchandise Value (GMV)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `gmv_currency_code` SET TAGS ('dbx_business_glossary_term' = 'GMV Currency Code');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `gmv_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `gross_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Percent');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `inventory_coverage_days` SET TAGS ('dbx_business_glossary_term' = 'Inventory Coverage Days');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `inventory_turnover_rate` SET TAGS ('dbx_business_glossary_term' = 'Inventory Turnover Rate');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `is_estimated` SET TAGS ('dbx_business_glossary_term' = 'Is Estimated Flag');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `net_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Net Margin Percent');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `new_seller_count` SET TAGS ('dbx_business_glossary_term' = 'New Seller Count');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `order_count` SET TAGS ('dbx_business_glossary_term' = 'Order Count');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `processing_date` SET TAGS ('dbx_business_glossary_term' = 'Processing Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `promotional_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Promotional Discount Amount');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `promotional_discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Promotional Discount Rate');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `reporting_period` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|yearly');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `return_rate` SET TAGS ('dbx_business_glossary_term' = 'Return Rate (RR)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `sell_through_rate` SET TAGS ('dbx_business_glossary_term' = 'Sell‑Through Rate');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `top_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Top SKU Count');
ALTER TABLE `ecommerce_ecm`.`analytics`.`category_performance` ALTER COLUMN `units_sold` SET TAGS ('dbx_business_glossary_term' = 'Units Sold');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` SET TAGS ('dbx_subdomain' = 'commercial_insights');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `seller_performance_snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Performance Snapshot ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `analytical_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Dataset Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `prior_period_seller_performance_snapshot_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `average_order_value` SET TAGS ('dbx_business_glossary_term' = 'Average Order Value (AOV)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `cancellation_rate` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Rate');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `customer_rating_average` SET TAGS ('dbx_business_glossary_term' = 'Customer Rating Average');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `defect_rate` SET TAGS ('dbx_business_glossary_term' = 'Defect Rate');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `gross_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Percent');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `gross_merchandise_value` SET TAGS ('dbx_business_glossary_term' = 'Gross Merchandise Value (GMV)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `late_shipment_rate` SET TAGS ('dbx_business_glossary_term' = 'Late Shipment Rate');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `net_profit` SET TAGS ('dbx_business_glossary_term' = 'Net Profit');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `order_count` SET TAGS ('dbx_business_glossary_term' = 'Order Count');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `period_grain` SET TAGS ('dbx_business_glossary_term' = 'Period Grain');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `period_grain` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|yearly');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `return_rate` SET TAGS ('dbx_business_glossary_term' = 'Return Rate');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `seller_performance_snapshot_status` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Status');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `seller_performance_snapshot_status` SET TAGS ('dbx_value_regex' = 'active|inactive');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `seller_tier` SET TAGS ('dbx_business_glossary_term' = 'Seller Tier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `seller_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `total_units_sold` SET TAGS ('dbx_business_glossary_term' = 'Total Units Sold');
ALTER TABLE `ecommerce_ecm`.`analytics`.`seller_performance_snapshot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` SET TAGS ('dbx_subdomain' = 'commercial_insights');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `customer_retention_fact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Retention Fact Identifier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cohort Identifier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `prior_period_customer_retention_fact_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `active_buyer_count` SET TAGS ('dbx_business_glossary_term' = 'Active Buyer Count');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `average_order_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Order Value (USD)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `churn_count` SET TAGS ('dbx_business_glossary_term' = 'Churn Count');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `churn_rate` SET TAGS ('dbx_business_glossary_term' = 'Churn Rate');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `customer_retention_fact_status` SET TAGS ('dbx_business_glossary_term' = 'Fact Row Status');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `customer_retention_fact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `new_customers_count` SET TAGS ('dbx_business_glossary_term' = 'New Customers Count');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `purchase_frequency` SET TAGS ('dbx_business_glossary_term' = 'Purchase Frequency');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `repeat_purchase_rate` SET TAGS ('dbx_business_glossary_term' = 'Repeat Purchase Rate');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `reporting_period_grain` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Grain');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `reporting_period_grain` SET TAGS ('dbx_value_regex' = 'day|week|month|quarter|year');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `retention_30_day_rate` SET TAGS ('dbx_business_glossary_term' = '30‑Day Retention Rate');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `retention_60_day_rate` SET TAGS ('dbx_business_glossary_term' = '60‑Day Retention Rate');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `retention_90_day_rate` SET TAGS ('dbx_business_glossary_term' = '90‑Day Retention Rate');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `total_orders` SET TAGS ('dbx_business_glossary_term' = 'Total Orders');
ALTER TABLE `ecommerce_ecm`.`analytics`.`customer_retention_fact` ALTER COLUMN `total_revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue (USD)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` SET TAGS ('dbx_subdomain' = 'commercial_insights');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `operational_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Alert ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'KPI ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Agent Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Incident ID');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `related_operational_alert_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `alert_category` SET TAGS ('dbx_business_glossary_term' = 'Alert Category');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `alert_category` SET TAGS ('dbx_value_regex' = 'performance|security|data_quality|operational');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `alert_description` SET TAGS ('dbx_business_glossary_term' = 'Alert Description');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `alert_name` SET TAGS ('dbx_business_glossary_term' = 'Alert Name');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `alert_tags` SET TAGS ('dbx_business_glossary_term' = 'Alert Tags');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_business_glossary_term' = 'Alert Type');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_value_regex' = 'threshold_breach|anomaly|data_quality');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `anomaly_score` SET TAGS ('dbx_business_glossary_term' = 'Anomaly Score');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `kpi_target_type` SET TAGS ('dbx_business_glossary_term' = 'KPI Target Type');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `kpi_target_type` SET TAGS ('dbx_value_regex' = 'upper|lower|range');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `kpi_target_value` SET TAGS ('dbx_business_glossary_term' = 'KPI Target Value');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Metric Name');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `observed_value` SET TAGS ('dbx_business_glossary_term' = 'Observed Value');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `owner_role` SET TAGS ('dbx_business_glossary_term' = 'Owner Role');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Alert Priority');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|warning|info');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `threshold_operator` SET TAGS ('dbx_business_glossary_term' = 'Threshold Operator');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `threshold_operator` SET TAGS ('dbx_value_regex' = 'greater_than|less_than|outside_range');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `triggered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Triggered Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`operational_alert` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`analytics`.`conversion_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`conversion_event` SET TAGS ('dbx_subdomain' = 'commercial_insights');
ALTER TABLE `ecommerce_ecm`.`analytics`.`conversion_event` ALTER COLUMN `conversion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Event Identifier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`conversion_event` ALTER COLUMN `originating_conversion_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`conversion_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`conversion_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`conversion_event` ALTER COLUMN `user_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`conversion_event` ALTER COLUMN `user_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`conversion_event` ALTER COLUMN `user_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`conversion_event` ALTER COLUMN `user_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`session` SET TAGS ('dbx_subdomain' = 'commercial_insights');
ALTER TABLE `ecommerce_ecm`.`analytics`.`session` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`session` ALTER COLUMN `account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`session` ALTER COLUMN `account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`session` ALTER COLUMN `previous_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`session` ALTER COLUMN `device_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`session` ALTER COLUMN `device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`session` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`session` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`session` ALTER COLUMN `purchase_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`session` ALTER COLUMN `purchase_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`org_unit` SET TAGS ('dbx_subdomain' = 'commercial_insights');
ALTER TABLE `ecommerce_ecm`.`analytics`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Identifier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`org_unit` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`org_unit` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`org_unit` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`org_unit` ALTER COLUMN `location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`org_unit` ALTER COLUMN `location` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`incident` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`incident` SET TAGS ('dbx_subdomain' = 'commercial_insights');
ALTER TABLE `ecommerce_ecm`.`analytics`.`incident` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Identifier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`incident` ALTER COLUMN `related_incident_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`incident` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_schedule` SET TAGS ('dbx_subdomain' = 'dashboard_management');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_schedule` ALTER COLUMN `report_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Report Schedule Identifier');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_schedule` ALTER COLUMN `superseded_report_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_schedule` ALTER COLUMN `owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`analytics`.`report_schedule` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_email' = 'true');
