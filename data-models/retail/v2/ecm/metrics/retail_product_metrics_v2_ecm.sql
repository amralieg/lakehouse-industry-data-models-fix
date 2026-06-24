-- Metric views for domain: product | Business: Retail | Version: 2 | Generated on: 2026-06-23 23:42:36

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core SKU master metrics tracking active product portfolio health, physical attributes, and lifecycle distribution. Used by merchandising, supply chain, and product teams to govern the active catalog."
  source: "`vibe_retail_v1`.`product`.`sku`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the SKU (e.g. active, discontinued, pending). Primary filter for active-catalog analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the SKU is manufactured or sourced. Used for trade compliance and sourcing diversification analysis."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Indicates whether the SKU is a private-label product. Drives margin and brand-mix reporting."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the SKU is classified as hazardous material. Required for compliance and logistics routing."
    - name: "temperature_requirement"
      expr: temperature_requirement
      comment: "Storage temperature requirement (e.g. ambient, refrigerated, frozen). Drives supply chain and fulfillment routing decisions."
    - name: "age_restriction_flag"
      expr: age_restriction_flag
      comment: "Indicates whether the SKU has an age restriction. Used for compliance and POS enforcement reporting."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the SKU became effective. Used to track new product introduction cadence over time."
    - name: "discontinuation_date"
      expr: DATE_TRUNC('month', discontinuation_date)
      comment: "Month the SKU was discontinued. Used to track product exit cadence and end-of-life planning."
  measures:
    - name: "total_active_skus"
      expr: COUNT(CASE WHEN lifecycle_status = 'active' THEN sku_id END)
      comment: "Count of SKUs currently in active lifecycle status. Core catalog breadth KPI used by merchandising and buying teams to govern assortment size."
    - name: "total_skus"
      expr: COUNT(1)
      comment: "Total SKU count across all lifecycle statuses. Baseline for portfolio size and lifecycle distribution analysis."
    - name: "private_label_sku_count"
      expr: COUNT(CASE WHEN private_label_flag = TRUE THEN sku_id END)
      comment: "Number of private-label SKUs in the portfolio. Tracks private-label penetration, a key margin and brand strategy KPI."
    - name: "private_label_penetration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN private_label_flag = TRUE THEN sku_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of total SKUs that are private label. Directly informs brand-mix and margin strategy decisions at executive level."
    - name: "hazmat_sku_count"
      expr: COUNT(CASE WHEN hazmat_flag = TRUE THEN sku_id END)
      comment: "Number of hazardous-material SKUs. Drives compliance risk exposure and logistics cost planning."
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(gross_weight AS DOUBLE))
      comment: "Average gross weight across SKUs. Used in logistics cost modeling and carrier rate negotiation."
    - name: "avg_cube"
      expr: AVG(CAST(cube AS DOUBLE))
      comment: "Average cubic volume per SKU. Used for warehouse slotting, truck utilization, and DC capacity planning."
    - name: "discontinued_sku_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'discontinued' THEN sku_id END)
      comment: "Number of discontinued SKUs. Tracks product exit velocity and informs assortment rationalization decisions."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_item_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category and merchandise hierarchy metrics covering margin targets, assortment strategy, and financial linkage. Used by category managers, buyers, and finance to govern category performance targets."
  source: "`vibe_retail_v1`.`product`.`item_hierarchy`"
  dimensions:
    - name: "hierarchy_type"
      expr: hierarchy_type
      comment: "Type of hierarchy node (e.g. department, category, sub-category). Enables drill-down analysis across the merchandise hierarchy."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Numeric or named level within the hierarchy. Used to filter analysis to a specific tier of the category tree."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current status of the hierarchy node (e.g. active, archived). Filters to live categories for operational reporting."
    - name: "strategic_classification"
      expr: strategic_classification
      comment: "Strategic role of the category (e.g. destination, routine, convenience). Core input to category management strategy."
    - name: "seasonality_indicator"
      expr: seasonality_indicator
      comment: "Indicates whether the category is seasonal. Drives planning calendar and OTB budget allocation."
    - name: "replenishment_method"
      expr: replenishment_method
      comment: "Replenishment approach for the category (e.g. continuous, periodic). Informs supply chain planning."
    - name: "is_leaf_node"
      expr: is_leaf_node
      comment: "Whether this node is a leaf (lowest level) in the hierarchy. Used to isolate actionable category nodes from roll-up nodes."
    - name: "omnichannel_enabled"
      expr: omnichannel_enabled
      comment: "Whether the category is enabled for omnichannel selling. Tracks omnichannel assortment coverage."
  measures:
    - name: "avg_target_gross_margin_percent"
      expr: AVG(CAST(target_gross_margin_percent AS DOUBLE))
      comment: "Average target gross margin percentage across hierarchy nodes. Key financial planning KPI used by finance and category management to set profitability expectations."
    - name: "avg_private_label_penetration_target_pct"
      expr: AVG(CAST(private_label_penetration_target_percent AS DOUBLE))
      comment: "Average private-label penetration target across categories. Tracks strategic intent for own-brand growth, a key margin lever."
    - name: "avg_safety_stock_weeks"
      expr: AVG(CAST(safety_stock_weeks AS DOUBLE))
      comment: "Average safety stock weeks target across categories. Informs working capital and inventory investment decisions."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across hierarchy nodes. Tracks master data completeness; low scores indicate governance risk that can corrupt downstream analytics."
    - name: "active_category_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'active' THEN item_hierarchy_id END)
      comment: "Number of active category nodes. Tracks the breadth of the active merchandise hierarchy for assortment governance."
    - name: "omnichannel_enabled_category_count"
      expr: COUNT(CASE WHEN omnichannel_enabled = TRUE THEN item_hierarchy_id END)
      comment: "Number of categories enabled for omnichannel selling. Tracks omnichannel assortment coverage, a strategic growth KPI."
    - name: "omnichannel_enablement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN omnichannel_enabled = TRUE THEN item_hierarchy_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of active categories enabled for omnichannel. Directly measures omnichannel strategy execution progress."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand portfolio performance and health metrics. Used by brand managers, buyers, and executives to evaluate brand mix, margin contribution, quality, and private-label strategy."
  source: "`vibe_retail_v1`.`product`.`product_brand`"
  dimensions:
    - name: "brand_status"
      expr: brand_status
      comment: "Current status of the brand (e.g. active, discontinued). Filters to live brands for operational reporting."
    - name: "brand_type"
      expr: brand_type
      comment: "Type of brand (e.g. national, private label, licensed). Core dimension for brand-mix strategy analysis."
    - name: "brand_tier"
      expr: brand_tier
      comment: "Tier classification of the brand (e.g. premium, value, mid-tier). Used for assortment and pricing strategy."
    - name: "is_private_label"
      expr: is_private_label
      comment: "Whether the brand is a private-label brand. Key dimension for margin and brand-mix reporting."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Whether the brand is exclusive to this retailer. Tracks competitive differentiation through exclusive brand partnerships."
    - name: "is_licensed"
      expr: is_licensed
      comment: "Whether the brand is a licensed brand. Tracks licensing exposure and associated royalty obligations."
    - name: "country_of_origin_code"
      expr: country_of_origin_code
      comment: "Country of origin for the brand. Used for trade compliance and sourcing diversification analysis."
    - name: "portfolio_group"
      expr: portfolio_group
      comment: "Portfolio grouping for the brand. Enables roll-up analysis across brand families."
    - name: "launch_date"
      expr: DATE_TRUNC('year', launch_date)
      comment: "Year the brand was launched. Used to analyze brand portfolio age and new brand introduction cadence."
  measures:
    - name: "total_active_brands"
      expr: COUNT(CASE WHEN brand_status = 'active' THEN product_brand_id END)
      comment: "Number of active brands in the portfolio. Core brand breadth KPI used by brand management and buying teams."
    - name: "avg_margin_percent"
      expr: AVG(CAST(average_margin_percent AS DOUBLE))
      comment: "Average gross margin percentage across brands. Key profitability KPI used by finance and category management to evaluate brand contribution."
    - name: "avg_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average quality rating across brands. Tracks brand quality perception; low scores signal customer satisfaction and return risk."
    - name: "avg_return_rate_percent"
      expr: AVG(CAST(return_rate_percent AS DOUBLE))
      comment: "Average return rate percentage across brands. High return rates signal quality or expectation-setting issues requiring brand-level intervention."
    - name: "private_label_brand_count"
      expr: COUNT(CASE WHEN is_private_label = TRUE THEN product_brand_id END)
      comment: "Number of private-label brands. Tracks own-brand portfolio depth, a key margin strategy lever."
    - name: "exclusive_brand_count"
      expr: COUNT(CASE WHEN is_exclusive = TRUE THEN product_brand_id END)
      comment: "Number of exclusive brands. Measures competitive differentiation through exclusive brand partnerships."
    - name: "licensed_brand_count"
      expr: COUNT(CASE WHEN is_licensed = TRUE THEN product_brand_id END)
      comment: "Number of licensed brands. Tracks licensing exposure and associated royalty and renewal risk."
    - name: "brands_with_expiring_license"
      expr: COUNT(CASE WHEN is_licensed = TRUE AND license_expiration_date <= DATE_ADD(CURRENT_DATE(), 90) THEN product_brand_id END)
      comment: "Number of licensed brands with license expiring within 90 days. Actionable risk KPI for brand and legal teams to prioritize renewal negotiations."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_recall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product recall operational and financial metrics. Used by product safety, compliance, and executive teams to monitor recall scope, recovery effectiveness, and financial exposure."
  source: "`vibe_retail_v1`.`product`.`recall`"
  dimensions:
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall (e.g. open, closed, monitoring). Primary filter for active recall management."
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (e.g. voluntary, mandatory, market withdrawal). Indicates regulatory severity and response requirements."
    - name: "class"
      expr: class
      comment: "Regulatory class of the recall (e.g. Class I, II, III). Directly maps to health risk severity and response urgency."
    - name: "remedy_type"
      expr: remedy_type
      comment: "Type of remedy offered (e.g. refund, replacement, repair). Drives customer communication and financial reserve planning."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory agency overseeing the recall. Used for compliance reporting and agency relationship management."
    - name: "is_private_label"
      expr: is_private_label
      comment: "Whether the recalled product is private label. Private-label recalls carry higher reputational and financial risk."
    - name: "initiation_date"
      expr: DATE_TRUNC('month', initiation_date)
      comment: "Month the recall was initiated. Used to track recall frequency trends over time."
    - name: "country_of_origin_code"
      expr: country_of_origin_code
      comment: "Country of origin of the recalled product. Used to identify sourcing risk patterns."
  measures:
    - name: "total_active_recalls"
      expr: COUNT(CASE WHEN recall_status NOT IN ('closed', 'completed') THEN recall_id END)
      comment: "Number of currently active recalls. Core safety risk KPI monitored by product safety and executive teams."
    - name: "total_units_affected"
      expr: SUM(CAST(units_affected AS BIGINT))
      comment: "Total units affected across all recalls. Measures the scale of product safety exposure."
    - name: "total_units_recovered"
      expr: SUM(CAST(units_recovered AS BIGINT))
      comment: "Total units successfully recovered. Tracks recall execution effectiveness and remaining consumer exposure."
    - name: "total_units_in_customer_hands"
      expr: SUM(CAST(units_in_customer_hands AS BIGINT))
      comment: "Total recalled units still in customer possession. Measures residual consumer safety risk requiring ongoing outreach."
    - name: "avg_recovery_rate_percent"
      expr: AVG(CAST(recovery_rate_percent AS DOUBLE))
      comment: "Average unit recovery rate across recalls. Key effectiveness KPI; low rates indicate inadequate customer notification or remedy uptake."
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact_amount AS DOUBLE))
      comment: "Total estimated financial impact across all recalls. Critical for financial reserve planning and executive risk reporting."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amounts recovered from vendors for recalled products. Tracks vendor accountability and cost recovery."
    - name: "private_label_recall_count"
      expr: COUNT(CASE WHEN is_private_label = TRUE THEN recall_id END)
      comment: "Number of recalls involving private-label products. Private-label recalls carry higher reputational risk and require elevated executive attention."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product regulatory compliance metrics tracking certification status, audit cadence, and compliance gaps. Used by compliance officers, legal, and product teams to manage regulatory risk."
  source: "`vibe_retail_v1`.`product`.`product_compliance`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (e.g. compliant, non-compliant, pending). Primary filter for compliance risk reporting."
    - name: "compliance_type"
      expr: compliance_type
      comment: "Type of compliance requirement (e.g. food safety, chemical, import). Enables compliance analysis by regulatory domain."
    - name: "country_code"
      expr: country_code
      comment: "Country for which compliance applies. Used for market-specific regulatory reporting."
    - name: "region_code"
      expr: region_code
      comment: "Region for which compliance applies. Enables regional compliance risk aggregation."
    - name: "recall_status"
      expr: recall_status
      comment: "Recall status associated with this compliance record. Flags products under active recall for prioritized remediation."
    - name: "prop_65_warning_required"
      expr: prop_65_warning_required
      comment: "Whether a Proposition 65 warning is required. Tracks chemical disclosure compliance exposure in applicable markets."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the compliance record became effective. Used to track compliance certification renewal cadence."
    - name: "next_audit_date"
      expr: DATE_TRUNC('month', next_audit_date)
      comment: "Month of the next scheduled audit. Used for audit pipeline planning and resource allocation."
  measures:
    - name: "total_compliant_records"
      expr: COUNT(CASE WHEN compliance_status = 'compliant' THEN product_compliance_id END)
      comment: "Number of product-compliance records in compliant status. Baseline for compliance portfolio health."
    - name: "total_non_compliant_records"
      expr: COUNT(CASE WHEN compliance_status = 'non-compliant' THEN product_compliance_id END)
      comment: "Number of non-compliant product records. Critical risk KPI; non-compliance can result in regulatory fines, market withdrawal, or recall."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'compliant' THEN product_compliance_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of product-compliance records in compliant status. Executive-level regulatory health KPI."
    - name: "expiring_certifications_90d"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND compliance_status = 'compliant' THEN product_compliance_id END)
      comment: "Number of compliant certifications expiring within 90 days. Actionable pipeline KPI for compliance renewal prioritization."
    - name: "overdue_audit_count"
      expr: COUNT(CASE WHEN next_audit_date < CURRENT_DATE() THEN product_compliance_id END)
      comment: "Number of compliance records with overdue audits. Tracks audit execution gaps that create regulatory exposure."
    - name: "prop_65_exposure_count"
      expr: COUNT(CASE WHEN prop_65_warning_required = TRUE THEN product_compliance_id END)
      comment: "Number of products requiring Proposition 65 warnings. Tracks chemical disclosure compliance exposure in California and similar markets."
    - name: "active_recall_compliance_count"
      expr: COUNT(CASE WHEN recall_status IS NOT NULL AND recall_status != '' THEN product_compliance_id END)
      comment: "Number of compliance records associated with an active recall. Measures the intersection of compliance and safety risk."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_item_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product lifecycle event metrics tracking new product introductions, discontinuations, and approval workflow performance. Used by merchandising, buying, and product teams to manage the product pipeline."
  source: "`vibe_retail_v1`.`product`.`item_lifecycle_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of lifecycle event (e.g. introduction, discontinuation, reactivation). Core dimension for pipeline stage analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the event. Tracks bottlenecks in the new product introduction process."
    - name: "workflow_stage"
      expr: workflow_stage
      comment: "Current stage in the product lifecycle workflow. Used to identify pipeline congestion and approval delays."
    - name: "new_status"
      expr: new_status
      comment: "The product status resulting from this event. Used to track status transition patterns."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the lifecycle event. Used to analyze root causes of discontinuations and status changes."
    - name: "is_private_label"
      expr: is_private_label
      comment: "Whether the event relates to a private-label product. Tracks private-label pipeline activity separately."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the event has a regulatory compliance dimension. Flags events requiring compliance review."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the lifecycle event became effective. Used to track new product introduction and discontinuation cadence."
    - name: "target_launch_date"
      expr: DATE_TRUNC('month', target_launch_date)
      comment: "Month of the planned product launch. Used for pipeline planning and launch readiness tracking."
  measures:
    - name: "total_lifecycle_events"
      expr: COUNT(1)
      comment: "Total product lifecycle events. Baseline for product pipeline activity volume."
    - name: "new_product_introductions"
      expr: COUNT(CASE WHEN event_type = 'introduction' THEN item_lifecycle_event_id END)
      comment: "Number of new product introduction events. Tracks innovation pipeline velocity, a key merchandising strategy KPI."
    - name: "discontinuation_events"
      expr: COUNT(CASE WHEN event_type = 'discontinuation' THEN item_lifecycle_event_id END)
      comment: "Number of product discontinuation events. Tracks assortment rationalization activity and exit velocity."
    - name: "pending_approval_events"
      expr: COUNT(CASE WHEN approval_status NOT IN ('approved', 'rejected') THEN item_lifecycle_event_id END)
      comment: "Number of lifecycle events awaiting approval. Tracks workflow bottlenecks that delay product launches."
    - name: "approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'approved' THEN item_lifecycle_event_id END) / NULLIF(COUNT(CASE WHEN approval_status IN ('approved', 'rejected') THEN item_lifecycle_event_id END), 0), 2)
      comment: "Percentage of reviewed lifecycle events that were approved. Tracks product pipeline quality and approval efficiency."
    - name: "regulatory_flagged_events"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN item_lifecycle_event_id END)
      comment: "Number of lifecycle events with regulatory compliance requirements. Tracks compliance workload in the product pipeline."
    - name: "private_label_introductions"
      expr: COUNT(CASE WHEN event_type = 'introduction' AND is_private_label = TRUE THEN item_lifecycle_event_id END)
      comment: "Number of new private-label product introductions. Tracks own-brand pipeline growth, a key margin strategy KPI."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_category_campaign_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category campaign planning and performance metrics. Used by category managers, marketing, and finance to evaluate campaign investment efficiency, revenue attainment, and budget utilization."
  source: "`vibe_retail_v1`.`product`.`category_campaign_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the campaign plan (e.g. draft, approved, active, closed). Filters to actionable plans."
    - name: "performance_priority_rank"
      expr: performance_priority_rank
      comment: "Priority ranking of the campaign plan. Used to focus investment and review on highest-priority campaigns."
    - name: "approved_timestamp"
      expr: DATE_TRUNC('month', approved_timestamp)
      comment: "Month the plan was approved. Used to track planning cycle cadence and approval lead times."
    - name: "created_timestamp"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the plan was created. Used to analyze planning pipeline activity over time."
  measures:
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated across category campaign plans. Core financial planning KPI for marketing and category investment governance."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend across category campaign plans. Tracks budget execution and spend pacing."
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated budget actually spent. Measures campaign investment execution efficiency; under-spend signals missed opportunities, over-spend signals governance risk."
    - name: "total_target_revenue"
      expr: SUM(CAST(target_revenue_goal AS DOUBLE))
      comment: "Total revenue goal across category campaign plans. Baseline for revenue attainment analysis."
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_revenue_amount AS DOUBLE))
      comment: "Total actual revenue generated across category campaign plans. Core revenue performance KPI."
    - name: "revenue_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(target_revenue_goal AS DOUBLE)), 0), 2)
      comment: "Percentage of revenue target achieved across campaign plans. Executive KPI for campaign effectiveness and category performance vs. plan."
    - name: "total_actual_units_sold"
      expr: SUM(CAST(actual_units_sold AS BIGINT))
      comment: "Total units sold across category campaign plans. Volume KPI for campaign sell-through performance."
    - name: "unit_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_units_sold AS BIGINT)) / NULLIF(SUM(CAST(target_units_goal AS BIGINT)), 0), 2)
      comment: "Percentage of unit sales target achieved. Tracks volume execution vs. plan, complementing revenue attainment."
    - name: "avg_promotional_depth_percent"
      expr: AVG(CAST(promotional_depth_percent AS DOUBLE))
      comment: "Average promotional discount depth across campaign plans. Tracks promotional intensity; excessive depth erodes margin."
    - name: "avg_media_weight_percent"
      expr: AVG(CAST(media_weight_percent AS DOUBLE))
      comment: "Average media weight allocation across campaign plans. Tracks media investment intensity relative to category plans."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_category_kpi_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category KPI target governance metrics. Used by category managers and analytics teams to track target coverage, active monitoring, and measurement frequency distribution across the category portfolio."
  source: "`vibe_retail_v1`.`product`.`category_kpi_target`"
  dimensions:
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "How frequently the KPI is measured (e.g. daily, weekly, monthly). Used to assess monitoring intensity and reporting cadence."
    - name: "is_active"
      expr: is_active
      comment: "Whether the KPI target is currently active. Filters to live targets for operational monitoring."
    - name: "responsible_role"
      expr: responsible_role
      comment: "Role accountable for the KPI target. Used for accountability and escalation routing."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the KPI target became effective. Used to track target-setting cadence."
    - name: "effective_end_date"
      expr: DATE_TRUNC('month', effective_end_date)
      comment: "Month the KPI target expires. Used to identify targets requiring renewal."
  measures:
    - name: "total_active_kpi_targets"
      expr: COUNT(CASE WHEN is_active = TRUE THEN category_kpi_target_id END)
      comment: "Number of active category KPI targets. Tracks the breadth of category performance monitoring coverage."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average KPI target value across active targets. Provides a baseline for target-setting benchmarking across categories."
    - name: "avg_alert_threshold"
      expr: AVG(CAST(alert_threshold AS DOUBLE))
      comment: "Average alert threshold across KPI targets. Tracks how aggressively categories are monitored for performance deviations."
    - name: "expiring_targets_90d"
      expr: COUNT(CASE WHEN effective_end_date <= DATE_ADD(CURRENT_DATE(), 90) AND is_active = TRUE THEN category_kpi_target_id END)
      comment: "Number of active KPI targets expiring within 90 days. Actionable governance KPI to ensure targets are renewed before expiry."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_gtin_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GTIN registry quality and publication metrics. Used by product data stewards and supply chain teams to monitor barcode registration completeness, GS1 publication status, and data quality."
  source: "`vibe_retail_v1`.`product`.`gtin_registry`"
  dimensions:
    - name: "gtin_type"
      expr: gtin_type
      comment: "Type of GTIN (e.g. GTIN-8, GTIN-12, GTIN-13, GTIN-14). Used to analyze barcode type distribution across the product catalog."
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status of the GTIN. Tracks completeness of barcode registration across the catalog."
    - name: "gdsn_publication_status"
      expr: gdsn_publication_status
      comment: "GS1 Data Synchronization Network publication status. Tracks trading partner data synchronization compliance."
    - name: "regulatory_compliance_status"
      expr: regulatory_compliance_status
      comment: "Regulatory compliance status of the GTIN record. Flags non-compliant barcodes requiring remediation."
    - name: "packaging_level"
      expr: packaging_level
      comment: "Packaging hierarchy level (e.g. each, inner pack, case, pallet). Used for supply chain and ordering unit analysis."
    - name: "is_base_unit"
      expr: is_base_unit
      comment: "Whether this GTIN represents the base consumer unit. Used to isolate consumer-facing barcodes."
    - name: "is_consumer_unit"
      expr: is_consumer_unit
      comment: "Whether this GTIN is a consumer unit. Used for POS and e-commerce barcode coverage analysis."
    - name: "country_of_sale"
      expr: country_of_sale
      comment: "Country where the product is sold under this GTIN. Used for market-specific barcode compliance analysis."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the GTIN became effective. Used to track new product barcode registration cadence."
  measures:
    - name: "total_registered_gtins"
      expr: COUNT(CASE WHEN registration_status = 'registered' THEN gtin_registry_id END)
      comment: "Number of fully registered GTINs. Core catalog data completeness KPI for supply chain and trading partner compliance."
    - name: "gdsn_published_count"
      expr: COUNT(CASE WHEN gdsn_publication_status = 'published' THEN gtin_registry_id END)
      comment: "Number of GTINs published to the GS1 Data Synchronization Network. Tracks trading partner data synchronization compliance."
    - name: "gdsn_publication_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gdsn_publication_status = 'published' THEN gtin_registry_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of GTINs published to GDSN. Measures data synchronization compliance with trading partners; low rates cause order and invoice discrepancies."
    - name: "avg_gross_weight"
      expr: AVG(CAST(gross_weight_value AS DOUBLE))
      comment: "Average gross weight across registered GTINs. Used for logistics cost modeling and carrier rate validation."
    - name: "avg_net_content"
      expr: AVG(CAST(net_content_value AS DOUBLE))
      comment: "Average net content value across GTINs. Used for unit economics and pricing per unit analysis."
    - name: "variable_measure_gtin_count"
      expr: COUNT(CASE WHEN is_variable_measure = TRUE THEN gtin_registry_id END)
      comment: "Number of variable-measure GTINs (e.g. random-weight items). Tracks the complexity of the catalog for POS and pricing systems."
    - name: "regulatory_non_compliant_gtin_count"
      expr: COUNT(CASE WHEN regulatory_compliance_status != 'compliant' THEN gtin_registry_id END)
      comment: "Number of GTINs with regulatory compliance issues. Tracks barcode compliance risk that can block product from sale in regulated markets."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_item_bundle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product bundle portfolio and pricing metrics. Used by merchandising, pricing, and marketing teams to evaluate bundle strategy, discount depth, and promotional eligibility."
  source: "`vibe_retail_v1`.`product`.`item_bundle`"
  dimensions:
    - name: "bundle_status"
      expr: bundle_status
      comment: "Current status of the bundle (e.g. active, inactive, pending). Filters to live bundles for operational reporting."
    - name: "bundle_type"
      expr: bundle_type
      comment: "Type of bundle (e.g. fixed, configurable, gift set). Used to analyze bundle strategy mix."
    - name: "pricing_method"
      expr: pricing_method
      comment: "How the bundle is priced (e.g. fixed price, component sum, discount off total). Drives pricing strategy analysis."
    - name: "channel_availability"
      expr: channel_availability
      comment: "Channels where the bundle is available (e.g. in-store, online, both). Used for omnichannel bundle strategy analysis."
    - name: "promotion_eligible"
      expr: promotion_eligible
      comment: "Whether the bundle is eligible for promotional pricing. Tracks promotional flexibility of the bundle portfolio."
    - name: "returnable"
      expr: returnable
      comment: "Whether the bundle is returnable. Tracks return policy complexity for bundle products."
    - name: "loyalty_points_eligible"
      expr: loyalty_points_eligible
      comment: "Whether the bundle earns loyalty points. Tracks loyalty program integration for bundle products."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the bundle became effective. Used to track bundle introduction cadence."
  measures:
    - name: "total_active_bundles"
      expr: COUNT(CASE WHEN bundle_status = 'active' THEN item_bundle_id END)
      comment: "Number of active product bundles. Tracks bundle portfolio breadth for merchandising strategy."
    - name: "avg_bundle_price"
      expr: AVG(CAST(bundle_price_amount AS DOUBLE))
      comment: "Average bundle selling price. Used for bundle pricing strategy benchmarking and average transaction value analysis."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per bundle. Tracks the absolute value of bundle incentives offered to customers."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across bundles. Tracks promotional depth of bundle offers; excessive depth erodes margin."
    - name: "total_bundle_revenue_potential"
      expr: SUM(CAST(bundle_price_amount AS DOUBLE))
      comment: "Sum of bundle prices across all active bundles. Proxy for bundle revenue potential in the catalog."
    - name: "promotion_eligible_bundle_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN promotion_eligible = TRUE THEN item_bundle_id END) / NULLIF(COUNT(CASE WHEN bundle_status = 'active' THEN item_bundle_id END), 0), 2)
      comment: "Percentage of active bundles eligible for promotional pricing. Tracks promotional flexibility of the bundle portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_item_cross_reference`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item cross-reference data quality and trading partner mapping metrics. Used by supply chain, procurement, and data governance teams to monitor external item number mapping completeness and accuracy."
  source: "`vibe_retail_v1`.`product`.`item_cross_reference`"
  dimensions:
    - name: "cross_reference_type"
      expr: cross_reference_type
      comment: "Type of cross-reference (e.g. vendor item number, UPC, EDI item). Used to analyze mapping coverage by reference type."
    - name: "cross_reference_status"
      expr: cross_reference_status
      comment: "Current status of the cross-reference (e.g. active, superseded, invalid). Filters to valid mappings."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the cross-reference mapping. Tracks data quality of external item mappings."
    - name: "external_system_name"
      expr: external_system_name
      comment: "Name of the external system providing the cross-reference. Used to analyze mapping coverage by trading partner system."
    - name: "is_primary_reference"
      expr: is_primary_reference
      comment: "Whether this is the primary cross-reference for the item. Used to ensure each item has a designated primary mapping."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the cross-reference became effective. Used to track new mapping creation cadence."
  measures:
    - name: "total_active_cross_references"
      expr: COUNT(CASE WHEN cross_reference_status = 'active' THEN item_cross_reference_id END)
      comment: "Number of active item cross-references. Tracks the breadth of external item mapping coverage for trading partner integration."
    - name: "validated_mapping_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN validation_status = 'validated' THEN item_cross_reference_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cross-references that have been validated. Tracks data quality of external item mappings; low rates cause order and invoice matching failures."
    - name: "avg_mapping_confidence_score"
      expr: AVG(CAST(mapping_confidence_score AS DOUBLE))
      comment: "Average mapping confidence score across cross-references. Tracks automated mapping quality; low scores indicate manual review backlog."
    - name: "total_usage_count"
      expr: SUM(CAST(usage_count AS BIGINT))
      comment: "Total usage count across all cross-references. Identifies the most actively used external mappings for prioritized maintenance."
    - name: "distinct_trading_partners"
      expr: COUNT(DISTINCT trading_partner_name)
      comment: "Number of distinct trading partners with active cross-references. Tracks the breadth of external item mapping relationships."
    - name: "superseded_reference_count"
      expr: COUNT(CASE WHEN cross_reference_status = 'superseded' THEN item_cross_reference_id END)
      comment: "Number of superseded cross-references. Tracks legacy mapping cleanup backlog that can cause routing errors if not retired."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_item_nutritional`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nutritional data completeness and certification metrics for food products. Used by product compliance, regulatory, and category teams to monitor nutritional labeling coverage and dietary certification status."
  source: "`vibe_retail_v1`.`product`.`item_nutritional`"
  dimensions:
    - name: "is_organic_certified"
      expr: is_organic_certified
      comment: "Whether the product is certified organic. Tracks organic certification coverage in the food portfolio."
    - name: "is_gluten_free"
      expr: is_gluten_free
      comment: "Whether the product is gluten-free. Tracks dietary restriction compliance for allergen-sensitive customers."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Whether the product is vegan. Tracks vegan product coverage for dietary preference-based assortment analysis."
    - name: "is_kosher_certified"
      expr: is_kosher_certified
      comment: "Whether the product is kosher certified. Tracks religious dietary certification coverage."
    - name: "is_halal_certified"
      expr: is_halal_certified
      comment: "Whether the product is halal certified. Tracks religious dietary certification coverage."
    - name: "is_non_gmo_verified"
      expr: is_non_gmo_verified
      comment: "Whether the product is non-GMO verified. Tracks non-GMO certification coverage in the food portfolio."
    - name: "nutritional_data_effective_date"
      expr: DATE_TRUNC('year', nutritional_data_effective_date)
      comment: "Year the nutritional data became effective. Used to track nutritional data freshness and update cadence."
  measures:
    - name: "total_nutritional_records"
      expr: COUNT(1)
      comment: "Total nutritional records. Baseline for nutritional data coverage across the food product catalog."
    - name: "organic_certified_count"
      expr: COUNT(CASE WHEN is_organic_certified = TRUE THEN item_nutritional_id END)
      comment: "Number of organically certified products. Tracks organic portfolio breadth, a growing consumer demand and premium margin opportunity."
    - name: "avg_calories_per_serving"
      expr: AVG(CAST(calories_per_serving AS DOUBLE))
      comment: "Average calories per serving across food products. Used for nutritional profile benchmarking and health-oriented assortment planning."
    - name: "avg_sodium_mg"
      expr: AVG(CAST(sodium_mg AS DOUBLE))
      comment: "Average sodium content in milligrams across food products. Tracks sodium profile of the food portfolio for health and regulatory compliance."
    - name: "avg_total_fat_g"
      expr: AVG(CAST(total_fat_g AS DOUBLE))
      comment: "Average total fat content in grams. Used for nutritional profile analysis and health-oriented category management."
    - name: "avg_protein_g"
      expr: AVG(CAST(protein_g AS DOUBLE))
      comment: "Average protein content in grams. Used for nutritional positioning and high-protein product segment analysis."
    - name: "allergen_declared_count"
      expr: COUNT(CASE WHEN allergen_declaration IS NOT NULL AND allergen_declaration != '' THEN item_nutritional_id END)
      comment: "Number of products with allergen declarations. Tracks allergen labeling compliance coverage, a regulatory requirement in most markets."
    - name: "expiring_nutritional_data_90d"
      expr: COUNT(CASE WHEN nutritional_data_expiration_date <= DATE_ADD(CURRENT_DATE(), 90) THEN item_nutritional_id END)
      comment: "Number of nutritional records expiring within 90 days. Actionable data governance KPI to prevent stale nutritional labeling."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_attribute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product attribute data quality and governance metrics. Used by product data stewards and category teams to monitor attribute completeness, certification status, and data quality across the product catalog."
  source: "`vibe_retail_v1`.`product`.`attribute`"
  dimensions:
    - name: "attribute_group"
      expr: attribute_group
      comment: "Logical grouping of the attribute (e.g. physical, regulatory, marketing). Used to analyze data quality by attribute domain."
    - name: "attribute_status"
      expr: attribute_status
      comment: "Current status of the attribute (e.g. active, deprecated). Filters to live attributes for operational reporting."
    - name: "data_type"
      expr: data_type
      comment: "Data type of the attribute value (e.g. string, numeric, boolean). Used for data governance and validation analysis."
    - name: "is_required"
      expr: is_required
      comment: "Whether the attribute is required for the product. Used to identify mandatory attribute completion gaps."
    - name: "is_searchable"
      expr: is_searchable
      comment: "Whether the attribute is used in product search. Tracks search-relevant attribute coverage for e-commerce discoverability."
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Whether the attribute is required for regulatory compliance. Flags attributes with compliance implications."
    - name: "is_certified"
      expr: is_certified
      comment: "Whether the attribute value has been certified. Tracks certification coverage for regulated attributes."
    - name: "locale"
      expr: locale
      comment: "Locale for which the attribute applies. Used for localization coverage analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the attribute became effective. Used to track attribute enrichment cadence."
  measures:
    - name: "total_active_attributes"
      expr: COUNT(CASE WHEN attribute_status = 'active' THEN attribute_id END)
      comment: "Number of active product attributes. Tracks the breadth of product data enrichment across the catalog."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across product attributes. Core master data governance KPI; low scores indicate enrichment gaps that degrade search and analytics."
    - name: "required_attribute_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_required = TRUE AND value IS NOT NULL THEN attribute_id END) / NULLIF(COUNT(CASE WHEN is_required = TRUE THEN attribute_id END), 0), 2)
      comment: "Percentage of required attributes that have values populated. Tracks mandatory attribute completeness, a critical product data quality KPI."
    - name: "regulatory_attribute_certified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_regulatory_required = TRUE AND is_certified = TRUE THEN attribute_id END) / NULLIF(COUNT(CASE WHEN is_regulatory_required = TRUE THEN attribute_id END), 0), 2)
      comment: "Percentage of regulatory-required attributes that are certified. Tracks compliance certification coverage for regulated product attributes."
    - name: "avg_attribute_value"
      expr: AVG(CAST(value AS DOUBLE))
      comment: "Average numeric attribute value across all numeric attributes. Used for attribute value distribution benchmarking."
    - name: "searchable_attribute_count"
      expr: COUNT(CASE WHEN is_searchable = TRUE AND attribute_status = 'active' THEN attribute_id END)
      comment: "Number of active searchable attributes. Tracks e-commerce search discoverability coverage across the product catalog."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_assortment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product assortment assignment metrics tracking stocking status, replenishment lead times, and fulfillment node coverage. Used by supply chain and merchandising teams to govern assortment deployment."
  source: "`vibe_retail_v1`.`product`.`assortment`"
  dimensions:
    - name: "stocking_status"
      expr: stocking_status
      comment: "Current stocking status of the assortment assignment (e.g. in-stock, out-of-stock, discontinued). Core availability dimension."
    - name: "allocation_priority"
      expr: allocation_priority
      comment: "Priority level for inventory allocation to this assortment node. Used for allocation strategy analysis."
    - name: "assignment_effective_date"
      expr: DATE_TRUNC('month', assignment_effective_date)
      comment: "Month the assortment assignment became effective. Used to track assortment deployment cadence."
    - name: "assignment_end_date"
      expr: DATE_TRUNC('month', assignment_end_date)
      comment: "Month the assortment assignment expires. Used to track assortment exit cadence."
    - name: "last_received_date"
      expr: DATE_TRUNC('month', last_received_date)
      comment: "Month inventory was last received for this assortment. Used to identify stale or inactive assortment positions."
  measures:
    - name: "total_active_assortment_assignments"
      expr: COUNT(CASE WHEN stocking_status = 'in-stock' THEN assortment_id END)
      comment: "Number of active in-stock assortment assignments. Tracks the breadth of the live assortment across fulfillment nodes."
    - name: "distinct_skus_in_assortment"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs assigned to assortment positions. Measures assortment breadth across the fulfillment network."
    - name: "distinct_fulfillment_nodes"
      expr: COUNT(DISTINCT fulfillment_node_id)
      comment: "Number of distinct fulfillment nodes with assortment assignments. Tracks assortment deployment coverage across the fulfillment network."
    - name: "out_of_stock_assignment_count"
      expr: COUNT(CASE WHEN stocking_status = 'out-of-stock' THEN assortment_id END)
      comment: "Number of assortment positions currently out of stock. Tracks availability gaps that directly impact sales and customer satisfaction."
    - name: "out_of_stock_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN stocking_status = 'out-of-stock' THEN assortment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assortment positions that are out of stock. Key availability KPI; high rates signal supply chain or replenishment failures."
$$;