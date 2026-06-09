-- Metric views for domain: content | Business: Ecommerce | Version: 1 | Generated on: 2026-05-04 23:19:28

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`content_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core performance KPIs for content items, used by marketing and product leadership to gauge engagement and revenue impact"
  source: "`ecommerce_ecm`.`content`.`performance`"
  dimensions:
    - name: "metric_date"
      expr: metric_date
      comment: "Date of the performance snapshot"
    - name: "channel_id"
      expr: channel_id
      comment: "Identifier of the marketing channel"
    - name: "item_id"
      expr: item_id
      comment: "Content item identifier"
    - name: "locale"
      expr: locale
      comment: "Locale of the content view"
    - name: "ab_test_variant"
      expr: ab_test_variant
      comment: "A/B test variant label if applicable"
    - name: "audience_segment"
      expr: audience_segment
      comment: "Audience segment targeted"
  measures:
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS DOUBLE))
      comment: "Total number of clicks recorded"
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total number of impressions shown"
    - name: "total_conversion_count"
      expr: SUM(CAST(conversion_count AS DOUBLE))
      comment: "Total conversions (e.g., purchases) generated"
    - name: "total_revenue_influence_usd"
      expr: SUM(CAST(revenue_influence_usd AS DOUBLE))
      comment: "Sum of revenue influence in USD attributed to content"
    - name: "average_lift_percentage"
      expr: AVG(CAST(lift_percentage AS DOUBLE))
      comment: "Average lift percentage across records"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`content_seo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SEO health metrics for content, informing SEO strategy and prioritization"
  source: "`ecommerce_ecm`.`content`.`seo_metadata`"
  dimensions:
    - name: "item_id"
      expr: item_id
      comment: "Content item identifier"
    - name: "locale"
      expr: locale
      comment: "Locale of the page"
    - name: "country_code"
      expr: country_code
      comment: "Country code associated with the page"
    - name: "page_type"
      expr: page_type
      comment: "Type of page (e.g., product, landing)"
  measures:
    - name: "total_pages"
      expr: COUNT(1)
      comment: "Count of SEO metadata records (pages)"
    - name: "average_seo_score"
      expr: AVG(CAST(seo_score AS DOUBLE))
      comment: "Average SEO score across pages"
    - name: "average_sitemap_priority"
      expr: AVG(CAST(sitemap_priority AS DOUBLE))
      comment: "Average sitemap priority value"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`content_asset_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage and versioning metrics for digital assets, supporting cost and governance decisions"
  source: "`ecommerce_ecm`.`content`.`asset_version`"
  dimensions:
    - name: "content_digital_asset_id"
      expr: content_digital_asset_id
      comment: "Identifier of the digital asset"
    - name: "language_code"
      expr: language_code
      comment: "Language of the asset version"
    - name: "is_primary"
      expr: is_primary
      comment: "Flag indicating if this version is the primary asset"
    - name: "file_format"
      expr: file_format
      comment: "File format of the asset (e.g., jpg, mp4)"
  measures:
    - name: "total_file_size_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Aggregate size of all asset versions in bytes"
    - name: "version_count"
      expr: COUNT(1)
      comment: "Number of asset version records"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`content_ab_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance metrics for content A/B testing programs, guiding experiment planning and resource allocation"
  source: "`ecommerce_ecm`.`content`.`content_ab_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of A/B test (e.g., multivariate, split)"
    - name: "target_page_type"
      expr: target_page_type
      comment: "Page type targeted by the test"
    - name: "primary_success_metric"
      expr: primary_success_metric
      comment: "Primary metric used to evaluate test success"
    - name: "start_date"
      expr: start_date
      comment: "Start date of the test"
  measures:
    - name: "ab_test_count"
      expr: COUNT(1)
      comment: "Number of A/B test definitions"
    - name: "average_traffic_allocation_percent"
      expr: AVG(CAST(traffic_allocation_percent AS DOUBLE))
      comment: "Average traffic allocation percentage across tests"
    - name: "average_statistical_significance_threshold"
      expr: AVG(CAST(statistical_significance_threshold AS DOUBLE))
      comment: "Average statistical significance threshold set for tests"
$$;