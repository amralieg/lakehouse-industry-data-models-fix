-- Metric views for domain: assortment | Business: Grocery | Version: 1 | Generated on: 2026-05-04 20:38:05

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`assortment_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the assortment item catalogue, covering SKU portfolio composition, private-label penetration, space productivity, and rationalization risk. Used by Category Managers and Merchandising VPs to govern range width, shelf efficiency, and brand mix."
  source: "`grocery_ecm`.`assortment`.`assortment_item`"
  dimensions:
    - name: "assortment_tier"
      expr: assortment_tier
      comment: "Tier classification of the assortment item (e.g., core, secondary, tail) — used to segment KPIs by strategic importance."
    - name: "merchandising_role"
      expr: merchandising_role
      comment: "Merchandising role assigned to the item (e.g., traffic driver, profit generator, image builder) — key dimension for range strategy analysis."
    - name: "inclusion_status"
      expr: inclusion_status
      comment: "Current inclusion status of the item in the assortment (e.g., active, pending, discontinued) — used to filter live vs. inactive range."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Indicates whether the item is a private-label (own-brand) product — critical dimension for own-brand penetration analysis."
    - name: "seasonal_flag"
      expr: seasonal_flag
      comment: "Indicates whether the item is seasonal — used to separate evergreen from seasonal range KPIs."
    - name: "new_item_flag"
      expr: new_item_flag
      comment: "Indicates whether the item is a new introduction — used to track new-item contribution to range growth."
    - name: "rationalization_candidate_flag"
      expr: rationalization_candidate_flag
      comment: "Flags items identified as candidates for range rationalization — key dimension for delisting decision dashboards."
    - name: "season_code"
      expr: season_code
      comment: "Season code associated with the item (e.g., SUMMER, HOLIDAY) — used for seasonal range planning analysis."
    - name: "localization_source"
      expr: localization_source
      comment: "Source driving localization of this item (e.g., cluster, banner, store) — used to measure localization depth."
    - name: "override_flag"
      expr: override_flag
      comment: "Indicates whether the item's assortment decision was manually overridden — used to audit governance compliance."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the item became effective in the assortment — used for cohort and trend analysis of range introductions."
    - name: "introduction_date"
      expr: DATE_TRUNC('month', introduction_date)
      comment: "Month the item was introduced — used to track new-item introduction velocity over time."
  measures:
    - name: "total_active_skus"
      expr: COUNT(DISTINCT CASE WHEN inclusion_status = 'active' THEN assortment_item_id END)
      comment: "Total number of distinct active SKUs in the assortment. Core range-width KPI used by Category Managers to govern assortment breadth against plan targets."
    - name: "private_label_sku_count"
      expr: COUNT(DISTINCT CASE WHEN private_label_flag = TRUE THEN assortment_item_id END)
      comment: "Number of distinct private-label SKUs in the assortment. Tracks own-brand range depth, a key strategic lever for margin improvement."
    - name: "private_label_sku_penetration_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN private_label_flag = TRUE THEN assortment_item_id END) / NULLIF(COUNT(DISTINCT assortment_item_id), 0), 2)
      comment: "Percentage of total SKUs that are private-label. Executive KPI for own-brand strategy — directly tied to gross margin improvement targets."
    - name: "rationalization_candidate_sku_count"
      expr: COUNT(DISTINCT CASE WHEN rationalization_candidate_flag = TRUE THEN assortment_item_id END)
      comment: "Number of SKUs flagged as rationalization candidates. Drives delisting decisions and range simplification initiatives to reduce complexity costs."
    - name: "rationalization_candidate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN rationalization_candidate_flag = TRUE THEN assortment_item_id END) / NULLIF(COUNT(DISTINCT assortment_item_id), 0), 2)
      comment: "Percentage of the active range flagged for rationalization. High values signal over-assortment risk and prompt category review."
    - name: "total_space_allocation_linear_feet"
      expr: SUM(CAST(space_allocation_linear_feet AS DOUBLE))
      comment: "Total linear feet of shelf space allocated across all assortment items. Foundational space productivity input used alongside sales data to compute sales-per-linear-foot."
    - name: "avg_space_allocation_linear_feet_per_sku"
      expr: ROUND(AVG(CAST(space_allocation_linear_feet AS DOUBLE)), 4)
      comment: "Average linear feet allocated per SKU. Used to identify over- or under-spaced items relative to category norms and planogram standards."
    - name: "new_item_sku_count"
      expr: COUNT(DISTINCT CASE WHEN new_item_flag = TRUE THEN assortment_item_id END)
      comment: "Number of new-item SKUs currently in the assortment. Tracks innovation pipeline contribution to range and supports new-item review cadences."
    - name: "new_item_penetration_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN new_item_flag = TRUE THEN assortment_item_id END) / NULLIF(COUNT(DISTINCT assortment_item_id), 0), 2)
      comment: "Percentage of the assortment that consists of new items. Measures innovation velocity and freshness of the range — a key supplier and category KPI."
    - name: "override_sku_count"
      expr: COUNT(DISTINCT CASE WHEN override_flag = TRUE THEN assortment_item_id END)
      comment: "Number of SKUs where the assortment decision was manually overridden. High counts indicate governance gaps or buyer discretion outside algorithmic recommendations."
    - name: "override_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN override_flag = TRUE THEN assortment_item_id END) / NULLIF(COUNT(DISTINCT assortment_item_id), 0), 2)
      comment: "Percentage of SKUs with a manual override. Governance KPI — elevated override rates may indicate process compliance issues or model trust deficits."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`assortment_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category-level performance and health metrics covering space productivity targets, shrink exposure, margin return targets, and assortment governance attributes. Used by Category Directors and Space Planning teams to prioritize investment and manage category P&L."
  source: "`grocery_ecm`.`assortment`.`category`"
  dimensions:
    - name: "category_type"
      expr: category_type
      comment: "Type classification of the category (e.g., perishable, dry grocery, HBC) — primary grouping dimension for category portfolio analysis."
    - name: "category_status"
      expr: category_status
      comment: "Current lifecycle status of the category (e.g., active, under review, discontinued) — used to filter operational vs. inactive categories."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level within the merchandise hierarchy (e.g., department, category, subcategory) — used to roll up or drill down KPIs across the hierarchy."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone of the category (e.g., ambient, chilled, frozen) — used to segment space and shrink KPIs by storage requirement."
    - name: "perishable_flag"
      expr: perishable_flag
      comment: "Indicates whether the category contains perishable products — critical for shrink and markdown strategy segmentation."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Indicates whether the category is primarily private-label — used to track own-brand category development."
    - name: "seasonal_flag"
      expr: seasonal_flag
      comment: "Indicates whether the category is seasonal — used to separate evergreen from seasonal category performance."
    - name: "snap_eligible_flag"
      expr: snap_eligible_flag
      comment: "Indicates SNAP/EBT eligibility for the category — used for compliance reporting and basket analysis by payment type."
    - name: "wic_eligible_flag"
      expr: wic_eligible_flag
      comment: "Indicates WIC program eligibility — used for regulatory compliance and community nutrition program reporting."
    - name: "markdown_strategy"
      expr: markdown_strategy
      comment: "Markdown strategy applied to the category (e.g., clearance, everyday low price, promotional) — used to align space and margin planning."
    - name: "replenishment_method"
      expr: replenishment_method
      comment: "Replenishment method for the category (e.g., DSD, warehouse, cross-dock) — used to segment supply chain cost and availability KPIs."
  measures:
    - name: "total_active_categories"
      expr: COUNT(DISTINCT CASE WHEN category_status = 'active' THEN category_id END)
      comment: "Total number of active categories in the assortment hierarchy. Baseline portfolio breadth KPI used by Category Directors to govern range complexity."
    - name: "avg_gmroi_target"
      expr: ROUND(AVG(CAST(gmroi_target AS DOUBLE)), 4)
      comment: "Average Gross Margin Return on Inventory Investment (GMROI) target across categories. Key financial efficiency KPI used to prioritize space and inventory investment by category."
    - name: "total_space_allocation_sqft"
      expr: SUM(CAST(space_allocation_square_feet AS DOUBLE))
      comment: "Total square footage allocated across all categories. Foundational space planning KPI — used to assess space distribution against sales and margin contribution."
    - name: "avg_space_allocation_sqft_per_category"
      expr: ROUND(AVG(CAST(space_allocation_square_feet AS DOUBLE)), 4)
      comment: "Average square footage allocated per category. Used to identify over- or under-spaced categories relative to their sales and margin contribution."
    - name: "avg_shrink_rate_pct"
      expr: ROUND(AVG(CAST(shrink_rate_percent AS DOUBLE)), 4)
      comment: "Average shrink rate percentage across categories. Shrink is a direct P&L cost — elevated rates trigger operational investigations and markdown strategy reviews."
    - name: "total_shrink_exposure_sqft_weighted"
      expr: ROUND(SUM(shrink_rate_percent * space_allocation_square_feet), 2)
      comment: "Space-weighted shrink exposure across categories (shrink rate × allocated sqft). Compound KPI that identifies which categories carry the highest shrink risk relative to their footprint."
    - name: "perishable_category_count"
      expr: COUNT(DISTINCT CASE WHEN perishable_flag = TRUE THEN category_id END)
      comment: "Number of perishable categories. Used to size shrink management, cold chain investment, and markdown strategy scope."
    - name: "private_label_category_count"
      expr: COUNT(DISTINCT CASE WHEN private_label_flag = TRUE THEN category_id END)
      comment: "Number of categories with a private-label designation. Tracks own-brand category development breadth as part of margin improvement strategy."
    - name: "planogram_required_category_count"
      expr: COUNT(DISTINCT CASE WHEN planogram_required_flag = TRUE THEN category_id END)
      comment: "Number of categories requiring a planogram. Used by Space Planning to size planogram workload and compliance monitoring scope."
    - name: "planogram_required_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN planogram_required_flag = TRUE THEN category_id END) / NULLIF(COUNT(DISTINCT category_id), 0), 2)
      comment: "Percentage of categories requiring planogram compliance. High percentages increase space planning operational burden and compliance monitoring costs."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`assortment_new_item_intro`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "New item introduction pipeline metrics covering submission-to-approval cycle times, expected margin and sales performance, slotting fee revenue, and introduction status funnel. Used by Category Managers, Buyers, and Vendor Management teams to govern the new item pipeline and supplier negotiations."
  source: "`grocery_ecm`.`assortment`.`new_item_intro`"
  dimensions:
    - name: "introduction_status"
      expr: introduction_status
      comment: "Current status of the new item introduction (e.g., submitted, approved, rejected, launched) — primary funnel dimension for pipeline analysis."
    - name: "is_private_label"
      expr: is_private_label
      comment: "Indicates whether the new item is a private-label product — used to segment pipeline KPIs by brand ownership."
    - name: "is_organic_certified"
      expr: is_organic_certified
      comment: "Indicates whether the new item is organic certified — used to track organic range expansion pipeline."
    - name: "is_seasonal"
      expr: is_seasonal
      comment: "Indicates whether the new item is seasonal — used to separate seasonal from evergreen new item introductions."
    - name: "requires_refrigeration"
      expr: requires_refrigeration
      comment: "Indicates whether the new item requires refrigeration — used to assess cold chain capacity impact of new introductions."
    - name: "season_code"
      expr: season_code
      comment: "Season code for the new item (e.g., SUMMER, HOLIDAY) — used for seasonal pipeline planning and launch timing analysis."
    - name: "submission_date_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of new item submission — used to track pipeline intake velocity and seasonal submission patterns."
    - name: "target_launch_date_month"
      expr: DATE_TRUNC('month', target_launch_date)
      comment: "Month of planned launch — used to forecast new item introduction volume by period and align with promotional calendars."
    - name: "approval_date_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month of approval — used to measure approval throughput and identify bottlenecks in the review process."
  measures:
    - name: "total_new_item_submissions"
      expr: COUNT(DISTINCT new_item_intro_id)
      comment: "Total number of new item introductions submitted. Baseline pipeline volume KPI — tracks supplier and buyer activity in range innovation."
    - name: "approved_new_item_count"
      expr: COUNT(DISTINCT CASE WHEN introduction_status = 'approved' THEN new_item_intro_id END)
      comment: "Number of new items approved for introduction. Measures pipeline conversion and range innovation throughput."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN introduction_status = 'approved' THEN new_item_intro_id END) / NULLIF(COUNT(DISTINCT new_item_intro_id), 0), 2)
      comment: "Percentage of submitted new items that are approved. Low approval rates signal quality issues in supplier submissions or overly restrictive buying criteria."
    - name: "avg_review_cycle_days"
      expr: ROUND(AVG(DATEDIFF(review_completion_date, review_start_date)), 2)
      comment: "Average number of days from review start to review completion. Measures new item review process efficiency — long cycles delay range freshness and supplier relationships."
    - name: "avg_submission_to_approval_days"
      expr: ROUND(AVG(DATEDIFF(approval_date, submission_date)), 2)
      comment: "Average days from submission to approval. End-to-end pipeline speed KPI — directly impacts time-to-shelf and competitive responsiveness."
    - name: "total_slotting_fee_revenue"
      expr: SUM(CAST(slotting_fee_amount AS DOUBLE))
      comment: "Total slotting fee revenue collected from new item introductions. Direct P&L line item — tracked by Finance and Category Management to offset new item onboarding costs."
    - name: "avg_slotting_fee_per_item"
      expr: ROUND(AVG(CAST(slotting_fee_amount AS DOUBLE)), 2)
      comment: "Average slotting fee per new item introduction. Used in supplier negotiations to benchmark fee levels against category and format norms."
    - name: "avg_expected_gross_margin_pct"
      expr: ROUND(AVG(CAST(expected_gross_margin_percent AS DOUBLE)), 4)
      comment: "Average expected gross margin percentage across new item introductions. Pre-launch margin quality KPI — items below category margin thresholds are flagged for renegotiation."
    - name: "total_expected_cost"
      expr: SUM(CAST(cost_per_unit AS DOUBLE))
      comment: "Total cost per unit summed across new item introductions. Used to size the cost investment in the new item pipeline and inform cost plan updates."
    - name: "avg_suggested_retail_price"
      expr: ROUND(AVG(CAST(suggested_retail_price AS DOUBLE)), 2)
      comment: "Average suggested retail price across new item introductions. Used to assess price positioning of the incoming range relative to category price architecture."
    - name: "private_label_new_item_count"
      expr: COUNT(DISTINCT CASE WHEN is_private_label = TRUE THEN new_item_intro_id END)
      comment: "Number of new private-label items in the introduction pipeline. Tracks own-brand innovation velocity — a strategic KPI for margin improvement programs."
    - name: "private_label_new_item_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_private_label = TRUE THEN new_item_intro_id END) / NULLIF(COUNT(DISTINCT new_item_intro_id), 0), 2)
      comment: "Percentage of new item introductions that are private-label. Measures own-brand pipeline share — used to steer innovation investment toward margin-accretive introductions."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`assortment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assortment plan financial and structural KPIs covering sales, margin, inventory investment, SKU count targets, and private-label plan performance. Used by Category Directors, Finance BPs, and Merchandising VPs to govern category financial plans and track plan vs. actuals."
  source: "`grocery_ecm`.`assortment`.`plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the assortment plan (e.g., draft, approved, active, closed) — used to filter operational plans from historical or draft versions."
    - name: "assortment_strategy"
      expr: assortment_strategy
      comment: "Assortment strategy applied in the plan (e.g., expand, maintain, rationalize) — key dimension for strategic intent analysis across categories."
    - name: "planning_period_type"
      expr: planning_period_type
      comment: "Type of planning period (e.g., annual, seasonal, quarterly) — used to segment plan KPIs by planning horizon."
    - name: "planning_season"
      expr: planning_season
      comment: "Planning season associated with the plan (e.g., Spring/Summer, Fall/Winter) — used for seasonal plan performance analysis."
    - name: "localization_level"
      expr: localization_level
      comment: "Level at which the plan is localized (e.g., national, cluster, store) — used to measure localization depth and its impact on plan complexity."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the plan becomes effective — used for time-series analysis of plan activation and financial commitment."
    - name: "approval_date_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month the plan was approved — used to track planning cycle timeliness and approval throughput."
  measures:
    - name: "total_sales_plan_amount"
      expr: SUM(CAST(sales_plan_amount AS DOUBLE))
      comment: "Total planned sales revenue across all assortment plans. Top-line financial KPI — used by Finance and Category Management to set and track revenue targets."
    - name: "total_margin_plan_amount"
      expr: SUM(CAST(margin_plan_amount AS DOUBLE))
      comment: "Total planned gross margin dollars across all assortment plans. Core P&L KPI — used to govern category profitability targets and investment decisions."
    - name: "avg_margin_plan_pct"
      expr: ROUND(AVG(CAST(margin_plan_percent AS DOUBLE)), 4)
      comment: "Average planned gross margin percentage across plans. Used to benchmark category margin targets and identify categories below acceptable margin thresholds."
    - name: "total_inventory_investment_plan"
      expr: SUM(CAST(inventory_investment_plan AS DOUBLE))
      comment: "Total planned inventory investment across all assortment plans. Capital allocation KPI — used by Finance to govern working capital commitments by category."
    - name: "avg_gmroi_target"
      expr: ROUND(AVG(CAST(gmroi_target AS DOUBLE)), 4)
      comment: "Average GMROI target across assortment plans. Measures expected return on inventory investment — plans below threshold trigger category strategy reviews."
    - name: "avg_turn_rate_target"
      expr: ROUND(AVG(CAST(turn_rate_target AS DOUBLE)), 4)
      comment: "Average inventory turn rate target across plans. High turn rates indicate efficient inventory utilization — low rates signal over-investment or slow-moving range risk."
    - name: "total_cost_plan_amount"
      expr: SUM(CAST(cost_plan_amount AS DOUBLE))
      comment: "Total planned cost of goods across all assortment plans. Used alongside sales plan to validate planned margin and identify cost pressure by category."
    - name: "avg_private_label_sales_plan_pct"
      expr: ROUND(AVG(CAST(private_label_sales_plan_percent AS DOUBLE)), 4)
      comment: "Average planned private-label sales penetration percentage across plans. Strategic KPI for own-brand revenue mix — used to track progress against private-label growth targets."
    - name: "total_space_allocation_linear_feet"
      expr: SUM(CAST(space_allocation_linear_feet AS DOUBLE))
      comment: "Total planned linear feet of shelf space across all assortment plans. Space planning KPI — used to validate that space commitments align with sales and margin plans."
    - name: "plan_count_by_status"
      expr: COUNT(DISTINCT plan_id)
      comment: "Total number of distinct assortment plans. Used to monitor planning workload, governance coverage, and plan lifecycle management across categories and clusters."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`assortment_planogram`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planogram design and compliance KPIs covering space utilization, private-label facing share, estimated sales productivity, and planogram lifecycle governance. Used by Space Planning teams, Category Managers, and Store Operations to optimize shelf layouts and drive compliance."
  source: "`grocery_ecm`.`assortment`.`planogram`"
  dimensions:
    - name: "planogram_status"
      expr: planogram_status
      comment: "Current lifecycle status of the planogram (e.g., draft, approved, active, retired) — used to filter operational planograms from historical versions."
    - name: "planogram_type"
      expr: planogram_type
      comment: "Type of planogram (e.g., standard, seasonal, promotional, endcap) — used to segment space productivity KPIs by planogram purpose."
    - name: "fixture_type"
      expr: fixture_type
      comment: "Type of fixture the planogram is designed for (e.g., gondola, cooler, endcap) — used to analyze space efficiency by fixture category."
    - name: "merchandising_strategy"
      expr: merchandising_strategy
      comment: "Merchandising strategy applied in the planogram (e.g., brand block, segment block, price ladder) — used to evaluate strategy effectiveness."
    - name: "layout_orientation"
      expr: layout_orientation
      comment: "Orientation of the planogram layout (e.g., horizontal, vertical) — used to analyze space utilization patterns by layout type."
    - name: "compliance_required_flag"
      expr: compliance_required_flag
      comment: "Indicates whether compliance is mandatory for this planogram — used to scope compliance monitoring and enforcement workload."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the planogram became effective — used for trend analysis of planogram resets and space change velocity."
  measures:
    - name: "total_active_planograms"
      expr: COUNT(DISTINCT CASE WHEN planogram_status = 'active' THEN planogram_id END)
      comment: "Total number of active planograms. Baseline operational KPI — used by Space Planning to size the active planogram estate and maintenance workload."
    - name: "total_estimated_weekly_sales_amount"
      expr: SUM(CAST(estimated_weekly_sales_amount AS DOUBLE))
      comment: "Total estimated weekly sales revenue across all planograms. Forward-looking revenue KPI — used to validate that space allocations are aligned with sales expectations."
    - name: "avg_estimated_weekly_sales_per_planogram"
      expr: ROUND(AVG(CAST(estimated_weekly_sales_amount AS DOUBLE)), 2)
      comment: "Average estimated weekly sales per planogram. Space productivity benchmark — planograms below threshold are candidates for redesign or consolidation."
    - name: "avg_private_label_facing_pct"
      expr: ROUND(AVG(CAST(private_label_facing_pct AS DOUBLE)), 4)
      comment: "Average percentage of facings allocated to private-label products across planograms. Measures own-brand shelf presence — a key lever for private-label sales penetration."
    - name: "avg_compliance_tolerance_pct"
      expr: ROUND(AVG(CAST(compliance_tolerance_pct AS DOUBLE)), 4)
      comment: "Average compliance tolerance percentage across planograms. Used to assess how strictly planogram compliance is enforced — tighter tolerances indicate higher execution standards."
    - name: "avg_fixture_width_inches"
      expr: ROUND(AVG(CAST(fixture_width_inches AS DOUBLE)), 2)
      comment: "Average fixture width in inches across planograms. Used by Space Planning to validate planogram designs against physical fixture dimensions and identify mismatches."
    - name: "compliance_required_planogram_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_required_flag = TRUE THEN planogram_id END)
      comment: "Number of planograms with mandatory compliance requirements. Used to size store compliance monitoring scope and prioritize field execution resources."
    - name: "compliance_required_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN compliance_required_flag = TRUE THEN planogram_id END) / NULLIF(COUNT(DISTINCT planogram_id), 0), 2)
      comment: "Percentage of planograms requiring mandatory compliance. High percentages increase store execution burden — used to balance compliance rigor with operational feasibility."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`assortment_space_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Space allocation efficiency and investment KPIs covering linear feet and square footage utilization, GMROI targets per linear foot, vendor-funded space share, and promotional space tie-ins. Used by Space Planning, Category Management, and Vendor Management to optimize shelf ROI and negotiate vendor space agreements."
  source: "`grocery_ecm`.`assortment`.`space_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the space allocation (e.g., active, pending, expired) — used to filter live allocations from historical records."
    - name: "allocation_priority"
      expr: allocation_priority
      comment: "Priority level of the space allocation (e.g., high, medium, low) — used to segment space KPIs by strategic importance."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone of the allocated space (e.g., ambient, chilled, frozen) — used to segment space investment by storage type."
    - name: "seasonal_flag"
      expr: seasonal_flag
      comment: "Indicates whether the space allocation is seasonal — used to separate permanent from seasonal space commitments."
    - name: "vendor_funded_flag"
      expr: vendor_funded_flag
      comment: "Indicates whether the space allocation is vendor-funded — key dimension for vendor income and trade spend analysis."
    - name: "promotional_tie_in_flag"
      expr: promotional_tie_in_flag
      comment: "Indicates whether the space allocation is tied to a promotional campaign — used to measure promotional space utilization and ROI."
    - name: "aisle_number"
      expr: aisle_number
      comment: "Aisle number of the space allocation — used for store layout analysis and traffic flow optimization."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the space allocation became effective — used for trend analysis of space change velocity and reset cadence."
  measures:
    - name: "total_linear_feet_allocated"
      expr: SUM(CAST(linear_feet_allocated AS DOUBLE))
      comment: "Total linear feet of shelf space allocated. Primary space volume KPI — used to track total shelf estate under management and validate against store capacity."
    - name: "total_square_footage_allocated"
      expr: SUM(CAST(square_footage_allocated AS DOUBLE))
      comment: "Total square footage allocated across all space allocations. Used alongside sales data to compute sales-per-square-foot, a core retail space productivity metric."
    - name: "avg_linear_feet_per_allocation"
      expr: ROUND(AVG(CAST(linear_feet_allocated AS DOUBLE)), 4)
      comment: "Average linear feet per space allocation record. Used to benchmark allocation sizes and identify outliers that may indicate over- or under-allocation."
    - name: "avg_target_gmroi_per_linear_foot"
      expr: ROUND(AVG(CAST(target_gmroi_per_linear_foot AS DOUBLE)), 4)
      comment: "Average target GMROI per linear foot across space allocations. Core space productivity KPI — used to prioritize space reallocation toward higher-return categories and suppliers."
    - name: "total_target_gmroi_weighted_linear_feet"
      expr: ROUND(SUM(target_gmroi_per_linear_foot * linear_feet_allocated), 2)
      comment: "Space-weighted total GMROI target (GMROI per linear foot × linear feet). Compound KPI that measures the aggregate return potential of the total shelf estate."
    - name: "vendor_funded_linear_feet"
      expr: SUM(CASE WHEN vendor_funded_flag = TRUE THEN linear_feet_allocated ELSE 0 END)
      comment: "Total linear feet of vendor-funded space. Measures the scale of vendor trade investment in shelf space — used in vendor income negotiations and trade spend reporting."
    - name: "vendor_funded_space_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN vendor_funded_flag = TRUE THEN linear_feet_allocated ELSE 0 END) / NULLIF(SUM(CAST(linear_feet_allocated AS DOUBLE)), 0), 2)
      comment: "Percentage of total allocated linear feet that is vendor-funded. Measures vendor trade investment share of shelf — high percentages indicate strong vendor partnership leverage."
    - name: "promotional_tie_in_linear_feet"
      expr: SUM(CASE WHEN promotional_tie_in_flag = TRUE THEN linear_feet_allocated ELSE 0 END)
      comment: "Total linear feet tied to promotional campaigns. Used to measure promotional space commitment and validate alignment with the promotional calendar."
    - name: "promotional_space_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN promotional_tie_in_flag = TRUE THEN linear_feet_allocated ELSE 0 END) / NULLIF(SUM(CAST(linear_feet_allocated AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated space tied to promotional campaigns. Elevated percentages may indicate over-reliance on promotional space at the expense of everyday range visibility."
    - name: "avg_shelf_height_inches"
      expr: ROUND(AVG(CAST(shelf_height_inches AS DOUBLE)), 2)
      comment: "Average shelf height in inches across space allocations. Used by Space Planning to validate physical compatibility of planogram designs with actual fixture configurations."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`assortment_store_cluster`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store cluster strategic and operational KPIs covering cluster size, sales performance, private-label penetration targets, SKU rationalization scores, and localization depth. Used by Cluster Managers, Category Directors, and Merchandising VPs to govern cluster-level assortment strategy and performance."
  source: "`grocery_ecm`.`assortment`.`store_cluster`"
  dimensions:
    - name: "cluster_status"
      expr: cluster_status
      comment: "Current status of the store cluster (e.g., active, under review, inactive) — used to filter operational clusters from historical or inactive groupings."
    - name: "cluster_type"
      expr: cluster_type
      comment: "Type of store cluster (e.g., urban, suburban, rural, high-volume) — primary dimension for cluster strategy segmentation."
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier of the cluster (e.g., tier 1, tier 2, tier 3) — used to prioritize investment and assortment depth by cluster performance."
    - name: "competitive_intensity"
      expr: competitive_intensity
      comment: "Competitive intensity level of the cluster's market (e.g., high, medium, low) — used to align assortment strategy with competitive positioning."
    - name: "localization_level"
      expr: localization_level
      comment: "Level of assortment localization applied to the cluster (e.g., national, regional, local) — used to measure localization depth and its operational impact."
    - name: "assortment_depth_strategy"
      expr: assortment_depth_strategy
      comment: "Assortment depth strategy for the cluster (e.g., full, edited, core) — used to segment clusters by range breadth strategy."
    - name: "climate_zone"
      expr: climate_zone
      comment: "Climate zone of the cluster — used to align seasonal assortment planning with regional climate patterns."
    - name: "primary_demographic_profile"
      expr: primary_demographic_profile
      comment: "Primary demographic profile of the cluster's customer base — used to align assortment strategy with customer needs and preferences."
    - name: "refresh_frequency"
      expr: refresh_frequency
      comment: "Frequency at which the cluster definition is refreshed (e.g., annual, semi-annual) — used to assess cluster model currency."
  measures:
    - name: "total_active_clusters"
      expr: COUNT(DISTINCT CASE WHEN cluster_status = 'active' THEN store_cluster_id END)
      comment: "Total number of active store clusters. Baseline KPI for cluster portfolio scope — used to govern localization complexity and operational overhead."
    - name: "avg_weekly_sales_per_cluster"
      expr: ROUND(AVG(CAST(average_weekly_sales AS DOUBLE)), 2)
      comment: "Average weekly sales per store cluster. Core revenue productivity KPI — used to rank clusters by sales performance and prioritize assortment investment."
    - name: "total_weekly_sales_across_clusters"
      expr: SUM(CAST(average_weekly_sales AS DOUBLE))
      comment: "Total average weekly sales summed across all clusters. Used to size the revenue base under cluster-managed assortment and track portfolio-level sales trends."
    - name: "avg_store_size_sqft"
      expr: ROUND(AVG(CAST(average_store_size_sqft AS DOUBLE)), 2)
      comment: "Average store size in square feet across clusters. Used to align space allocation plans with physical store capacity by cluster type."
    - name: "avg_private_label_penetration_target"
      expr: ROUND(AVG(CAST(private_label_penetration_target AS DOUBLE)), 4)
      comment: "Average private-label sales penetration target across clusters. Strategic KPI for own-brand growth — used to set cluster-level private-label goals and track progress."
    - name: "avg_sku_rationalization_score"
      expr: ROUND(AVG(CAST(sku_rationalization_score AS DOUBLE)), 4)
      comment: "Average SKU rationalization score across clusters. Compound efficiency KPI — high scores indicate clusters with significant range simplification opportunity, driving cost reduction."
    - name: "high_rationalization_cluster_count"
      expr: COUNT(DISTINCT CASE WHEN sku_rationalization_score >= 0.7 THEN store_cluster_id END)
      comment: "Number of clusters with a SKU rationalization score of 0.7 or above. Identifies clusters with the highest range complexity risk — used to prioritize rationalization programs."
    - name: "avg_sales_per_sqft"
      expr: ROUND(AVG(average_weekly_sales / NULLIF(average_store_size_sqft, 0)), 4)
      comment: "Average weekly sales per square foot across clusters. Compound space productivity KPI — used to rank clusters by space efficiency and guide space investment decisions."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`assortment_fixture`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixture asset management and compliance KPIs covering fixture estate size, space capacity, maintenance status, planogram compliance, and capital investment. Used by Store Operations, Space Planning, and Finance to govern fixture lifecycle, compliance, and capital expenditure."
  source: "`grocery_ecm`.`assortment`.`fixture`"
  dimensions:
    - name: "fixture_type"
      expr: fixture_type
      comment: "Type of fixture (e.g., gondola, cooler, endcap, freezer) — primary dimension for fixture estate analysis by equipment category."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the fixture (e.g., active, under maintenance, decommissioned) — used to filter operational from non-operational fixtures."
    - name: "planogram_compliance_status"
      expr: planogram_compliance_status
      comment: "Planogram compliance status of the fixture (e.g., compliant, non-compliant, pending reset) — key dimension for store execution compliance analysis."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone of the fixture (e.g., ambient, chilled, frozen) — used to segment fixture estate and maintenance KPIs by storage type."
    - name: "condition_status"
      expr: condition_status
      comment: "Physical condition status of the fixture (e.g., good, fair, poor) — used to prioritize maintenance and capital replacement decisions."
    - name: "ada_compliant_flag"
      expr: ada_compliant_flag
      comment: "Indicates whether the fixture is ADA compliant — used for regulatory compliance reporting and store accessibility audits."
    - name: "energy_star_certified_flag"
      expr: energy_star_certified_flag
      comment: "Indicates whether the fixture is Energy Star certified — used for sustainability reporting and energy cost management."
    - name: "installation_date_year"
      expr: DATE_TRUNC('year', installation_date)
      comment: "Year of fixture installation — used for fixture age analysis and capital replacement planning."
  measures:
    - name: "total_active_fixtures"
      expr: COUNT(DISTINCT CASE WHEN operational_status = 'active' THEN fixture_id END)
      comment: "Total number of operationally active fixtures. Baseline estate KPI — used by Store Operations to size the active fixture portfolio and maintenance workload."
    - name: "total_linear_feet_capacity"
      expr: SUM(CAST(total_linear_feet AS DOUBLE))
      comment: "Total linear feet of shelf capacity across all fixtures. Physical space capacity KPI — used to validate that space allocation plans do not exceed physical fixture capacity."
    - name: "avg_linear_feet_per_fixture"
      expr: ROUND(AVG(CAST(total_linear_feet AS DOUBLE)), 4)
      comment: "Average linear feet per fixture. Used to benchmark fixture capacity utilization and identify under-utilized fixtures for redeployment or decommissioning."
    - name: "total_fixture_purchase_cost"
      expr: SUM(CAST(purchase_cost AS DOUBLE))
      comment: "Total capital investment in fixtures. Finance KPI — used to track fixture asset base value and inform capital expenditure planning for store remodels."
    - name: "avg_fixture_purchase_cost"
      expr: ROUND(AVG(CAST(purchase_cost AS DOUBLE)), 2)
      comment: "Average purchase cost per fixture. Used to benchmark fixture investment levels and evaluate cost-effectiveness of fixture procurement decisions."
    - name: "non_compliant_fixture_count"
      expr: COUNT(DISTINCT CASE WHEN planogram_compliance_status = 'non-compliant' THEN fixture_id END)
      comment: "Number of fixtures not compliant with their assigned planogram. Store execution KPI — high counts indicate execution gaps that directly impact sales and customer experience."
    - name: "planogram_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN planogram_compliance_status = 'compliant' THEN fixture_id END) / NULLIF(COUNT(DISTINCT CASE WHEN operational_status = 'active' THEN fixture_id END), 0), 2)
      comment: "Percentage of active fixtures that are planogram compliant. Core store execution KPI — directly linked to sales performance and brand standards compliance."
    - name: "ada_non_compliant_fixture_count"
      expr: COUNT(DISTINCT CASE WHEN ada_compliant_flag = FALSE THEN fixture_id END)
      comment: "Number of fixtures that are not ADA compliant. Regulatory risk KPI — non-compliant fixtures expose the business to accessibility violation penalties and reputational risk."
    - name: "energy_star_certified_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN energy_star_certified_flag = TRUE THEN fixture_id END) / NULLIF(COUNT(DISTINCT fixture_id), 0), 2)
      comment: "Percentage of fixtures that are Energy Star certified. Sustainability KPI — used to track progress against energy efficiency targets and reduce utility costs."
$$;