-- Metric views for domain: menu | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 15:12:58

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core menu item performance metrics covering pricing, cost, nutritional positioning, and availability across channels and formats. Used by menu engineers, category managers, and executives to evaluate item portfolio health."
  source: "`vibe_restaurants_v1`.`menu`.`menu_item`"
  dimensions:
    - name: "item_status"
      expr: item_status
      comment: "Current lifecycle status of the menu item (active, discontinued, LTO, etc.) for portfolio segmentation."
    - name: "menu_engineering_class"
      expr: menu_engineering_class
      comment: "Menu engineering quadrant classification (Star, Plow Horse, Puzzle, Dog) used to drive pricing and promotion decisions."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format (QSR, Fast Casual, Dine-In) to segment item performance by service model."
    - name: "daypart"
      expr: daypart
      comment: "Daypart (Breakfast, Lunch, Dinner, Late Night) for time-of-day menu analysis."
    - name: "subcategory"
      expr: subcategory
      comment: "Menu subcategory (Burgers, Salads, Beverages, etc.) for category-level portfolio analysis."
    - name: "is_lto"
      expr: is_lto
      comment: "Flag indicating whether the item is a Limited Time Offer, enabling LTO vs. core menu comparison."
    - name: "is_vegetarian"
      expr: is_vegetarian
      comment: "Vegetarian flag for dietary segmentation and portfolio balance reporting."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Vegan flag for dietary segmentation and plant-based portfolio tracking."
    - name: "is_gluten_free"
      expr: is_gluten_free
      comment: "Gluten-free flag for allergen-sensitive portfolio analysis."
    - name: "is_3pd_available"
      expr: is_3pd_available
      comment: "Third-party delivery availability flag for omnichannel menu coverage analysis."
    - name: "is_olo_available"
      expr: is_olo_available
      comment: "Online ordering availability flag for digital channel menu coverage."
    - name: "is_dt_available"
      expr: is_dt_available
      comment: "Drive-thru availability flag for drive-thru channel menu coverage."
    - name: "launch_date"
      expr: DATE_TRUNC('month', launch_date)
      comment: "Month of item launch for cohort analysis of new item performance over time."
  measures:
    - name: "total_active_items"
      expr: COUNT(CASE WHEN item_status = 'active' THEN menu_item_id END)
      comment: "Count of currently active menu items. Executives use this to monitor portfolio size and complexity — too many items increases operational burden and cost."
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base selling price across menu items. Tracks pricing tier positioning and informs revenue-per-item benchmarking."
    - name: "avg_item_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost of goods per menu item. Directly tied to gross margin management and food cost control decisions."
    - name: "avg_gross_margin_per_item"
      expr: AVG(CAST(base_price AS DOUBLE) - CAST(cost AS DOUBLE))
      comment: "Average gross margin (price minus cost) per menu item. Core profitability KPI used in menu engineering and pricing strategy reviews."
    - name: "avg_sodium_mg"
      expr: AVG(CAST(sodium_mg AS DOUBLE))
      comment: "Average sodium content in milligrams across menu items. Used by nutrition and regulatory teams to monitor compliance with health guidelines and consumer transparency commitments."
    - name: "avg_portion_size_grams"
      expr: AVG(CAST(portion_size_grams AS DOUBLE))
      comment: "Average portion size in grams. Informs cost-per-gram benchmarking and portion standardization across formats."
    - name: "lto_item_count"
      expr: COUNT(CASE WHEN is_lto = TRUE THEN menu_item_id END)
      comment: "Count of Limited Time Offer items currently in the portfolio. Tracks LTO pipeline depth and innovation velocity."
    - name: "digital_channel_coverage_count"
      expr: COUNT(CASE WHEN is_olo_available = TRUE OR is_3pd_available = TRUE THEN menu_item_id END)
      comment: "Count of items available on at least one digital ordering channel. Measures digital menu completeness, a key driver of off-premise revenue growth."
    - name: "combo_eligible_item_count"
      expr: COUNT(CASE WHEN is_combo_eligible = TRUE THEN menu_item_id END)
      comment: "Count of items eligible for combo bundling. Informs upsell strategy and average check size optimization."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_pmix_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product mix (PMIX) performance metrics tracking sales volume, revenue, margin, and menu mix by item, daypart, channel, and restaurant format. The primary operational dashboard for menu performance management."
  source: "`vibe_restaurants_v1`.`menu`.`pmix_record`"
  dimensions:
    - name: "reporting_date"
      expr: DATE_TRUNC('week', reporting_date)
      comment: "Week of reporting date for trend analysis of item sales performance over time."
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Period type (daily, weekly, period, quarterly) for flexible time-grain analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart (Breakfast, Lunch, Dinner, Late Night) for time-of-day sales mix analysis."
    - name: "menu_category"
      expr: menu_category
      comment: "Menu category for category-level sales and margin analysis."
    - name: "menu_engineering_classification"
      expr: menu_engineering_classification
      comment: "Menu engineering quadrant (Star, Plow Horse, Puzzle, Dog) for portfolio optimization decisions."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format for cross-format performance benchmarking."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (corporate, franchise) for performance comparison between ownership models."
    - name: "is_lto"
      expr: is_lto
      comment: "LTO flag to compare Limited Time Offer performance against core menu items."
    - name: "is_available"
      expr: is_available
      comment: "Availability flag to identify items that were unavailable during the reporting period (86'd items)."
    - name: "sku_code"
      expr: sku_code
      comment: "SKU code for item-level granularity in sales mix reporting."
  measures:
    - name: "total_gross_sales"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales revenue across all items in the period. Primary top-line revenue KPI for menu performance reviews."
    - name: "total_net_sales"
      expr: SUM(CAST(net_sales_amount AS DOUBLE))
      comment: "Total net sales after discounts and voids. Used for accurate revenue reporting and P&L alignment."
    - name: "total_cogs"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold across all items. Core food cost management KPI tracked weekly by operations and finance."
    - name: "total_contribution_margin"
      expr: SUM(CAST(contribution_margin_amount AS DOUBLE))
      comment: "Total contribution margin (net sales minus COGS) across all items. Measures the profitability of the menu mix and informs engineering decisions."
    - name: "avg_cogs_pct"
      expr: AVG(CAST(cogs_pct AS DOUBLE))
      comment: "Average COGS percentage across items. Tracks food cost efficiency — a key operational KPI with direct P&L impact."
    - name: "avg_selling_price"
      expr: AVG(CAST(avg_selling_price AS DOUBLE))
      comment: "Average actual selling price per item record. Measures price realization vs. menu list price and tracks discount impact."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars applied across items. Tracks promotional spend effectiveness and discount leakage."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund dollars issued. Elevated refunds signal quality or fulfillment issues requiring operational intervention."
    - name: "total_void_amount"
      expr: SUM(CAST(void_amount AS DOUBLE))
      comment: "Total void dollars. High void rates indicate POS errors, training gaps, or potential fraud — a key loss prevention metric."
    - name: "avg_menu_mix_pct"
      expr: AVG(CAST(menu_mix_pct AS DOUBLE))
      comment: "Average menu mix percentage per item. Measures each item's share of total orders — core input to menu engineering quadrant classification."
    - name: "avg_sales_mix_pct"
      expr: AVG(CAST(sales_mix_pct AS DOUBLE))
      comment: "Average sales mix percentage per item. Measures each item's share of total revenue — used alongside menu mix to identify high-revenue vs. high-volume items."
    - name: "total_unavailability_hours"
      expr: SUM(CAST(unavailability_hours AS DOUBLE))
      comment: "Total hours items were unavailable (86'd). Directly tied to lost sales opportunity and guest satisfaction — a key operational reliability metric."
    - name: "total_comp_amount"
      expr: SUM(CAST(comp_amount AS DOUBLE))
      comment: "Total complimentary (comped) item value. Tracks guest recovery spend and manager discretionary comp usage."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_item_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Menu item cost analytics tracking theoretical vs. actual food cost, COGS percentages, and cost variances by item, channel, daypart, and restaurant format. Used by finance and operations to manage food cost targets."
  source: "`vibe_restaurants_v1`.`menu`.`item_cost`"
  dimensions:
    - name: "cost_calculation_date"
      expr: DATE_TRUNC('month', cost_calculation_date)
      comment: "Month of cost calculation for trend analysis of food cost movements over time."
    - name: "channel"
      expr: channel
      comment: "Sales channel (dine-in, drive-thru, delivery, OLO) for channel-specific cost analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart for time-of-day cost analysis."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format for cross-format food cost benchmarking."
    - name: "menu_engineering_class"
      expr: menu_engineering_class
      comment: "Menu engineering classification for cost analysis by item profitability tier."
    - name: "is_lto"
      expr: is_lto
      comment: "LTO flag to compare food cost profiles of LTO items vs. core menu items."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-over-period food cost reporting aligned to financial close cycles."
  measures:
    - name: "avg_theoretical_cogs_pct"
      expr: AVG(CAST(theoretical_cogs_pct AS DOUBLE))
      comment: "Average theoretical COGS percentage based on recipe costs. Establishes the food cost baseline against which actual performance is measured."
    - name: "avg_actual_cogs_pct"
      expr: AVG(CAST(actual_cogs_pct AS DOUBLE))
      comment: "Average actual COGS percentage realized in operations. Compared against theoretical to identify waste, theft, or portioning issues."
    - name: "avg_cogs_pct_variance"
      expr: AVG(CAST(cogs_pct_variance AS DOUBLE))
      comment: "Average variance between actual and target COGS percentage. A key food cost control KPI — positive variance signals overspend requiring investigation."
    - name: "avg_theoretical_cost_amount"
      expr: AVG(CAST(theoretical_cost_amount AS DOUBLE))
      comment: "Average theoretical cost per item in currency. Used for menu pricing decisions and margin modeling."
    - name: "total_theoretical_cost_variance"
      expr: SUM(CAST(theoretical_cost_variance_amount AS DOUBLE))
      comment: "Total dollar variance between theoretical and actual cost. Quantifies the financial impact of food cost inefficiencies across the portfolio."
    - name: "avg_target_cogs_pct"
      expr: AVG(CAST(target_cogs_pct AS DOUBLE))
      comment: "Average target COGS percentage set by finance. Establishes the performance benchmark for food cost management."
    - name: "avg_yield_pct"
      expr: AVG(CAST(yield_pct AS DOUBLE))
      comment: "Average yield percentage across items. Low yield indicates excessive waste or prep inefficiency, directly impacting food cost."
    - name: "avg_waste_pct"
      expr: AVG(CAST(waste_pct AS DOUBLE))
      comment: "Average waste percentage per item. Tracks food waste as a cost driver and sustainability metric — high waste triggers operational intervention."
    - name: "avg_packaging_cost"
      expr: AVG(CAST(packaging_cost AS DOUBLE))
      comment: "Average packaging cost per item. Tracks non-food COGS component, especially relevant for delivery and takeout channels."
    - name: "avg_base_selling_price"
      expr: AVG(CAST(base_selling_price AS DOUBLE))
      comment: "Average base selling price at time of cost calculation. Used alongside cost metrics to compute implied margin at the item level."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_item_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Menu item pricing analytics covering price levels, promotional pricing, channel surcharges, and franchise price deviations. Used by revenue management, franchise operations, and marketing to optimize pricing strategy."
  source: "`vibe_restaurants_v1`.`menu`.`item_price`"
  dimensions:
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month price became effective for trend analysis of pricing changes over time."
    - name: "ordering_channel"
      expr: ordering_channel
      comment: "Ordering channel (dine-in, drive-thru, OLO, 3PD) for channel-specific price analysis."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format for cross-format price benchmarking."
    - name: "daypart"
      expr: daypart
      comment: "Daypart for time-of-day pricing analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (corporate, franchise) to compare pricing compliance between ownership models."
    - name: "is_lto"
      expr: is_lto
      comment: "LTO flag to analyze promotional pricing vs. core menu pricing."
    - name: "is_active"
      expr: is_active
      comment: "Active price record flag for filtering to current vs. historical pricing."
    - name: "tax_category_code"
      expr: tax_category_code
      comment: "Tax category for tax-inclusive vs. tax-exclusive price analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Price approval status for governance and compliance reporting."
  measures:
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base menu price across items and locations. Core pricing benchmark used in competitive analysis and revenue management."
    - name: "avg_promotional_price"
      expr: AVG(CAST(promotional_price AS DOUBLE))
      comment: "Average promotional price when discounts are applied. Measures depth of promotional discounting and its impact on revenue realization."
    - name: "avg_suggested_retail_price"
      expr: AVG(CAST(suggested_retail_price AS DOUBLE))
      comment: "Average suggested retail price (SRP). Tracks alignment between corporate pricing guidance and actual charged prices."
    - name: "avg_channel_surcharge"
      expr: AVG(CAST(channel_surcharge AS DOUBLE))
      comment: "Average channel surcharge applied (e.g., delivery upcharge). Informs channel pricing strategy and consumer price sensitivity analysis."
    - name: "avg_franchise_price_deviation_pct"
      expr: AVG(CAST(franchise_price_deviation_pct AS DOUBLE))
      comment: "Average percentage deviation of franchise prices from corporate suggested prices. High deviation signals pricing compliance issues requiring franchise operations intervention."
    - name: "avg_cogs_pct"
      expr: AVG(CAST(cogs_pct AS DOUBLE))
      comment: "Average COGS percentage at the price record level. Enables margin analysis by channel, format, and ownership type."
    - name: "price_override_allowed_count"
      expr: COUNT(CASE WHEN is_price_override_allowed = TRUE THEN item_price_id END)
      comment: "Count of price records where override is permitted. Tracks pricing governance exposure — too many overrideable prices increases revenue leakage risk."
    - name: "active_price_record_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN item_price_id END)
      comment: "Count of currently active price records. Monitors pricing data completeness and ensures all active items have valid prices."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recipe management metrics covering food cost, nutritional content, yield, waste, and compliance status. Used by culinary, food safety, and finance teams to manage recipe standards and cost efficiency."
  source: "`vibe_restaurants_v1`.`menu`.`recipe`"
  dimensions:
    - name: "recipe_status"
      expr: recipe_status
      comment: "Recipe lifecycle status (active, draft, retired) for portfolio management."
    - name: "recipe_type"
      expr: recipe_type
      comment: "Recipe type (core, LTO, test, seasonal) for portfolio segmentation."
    - name: "recipe_category"
      expr: recipe_category
      comment: "Recipe category (entree, side, beverage, dessert) for category-level analysis."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format for cross-format recipe standardization analysis."
    - name: "channel"
      expr: channel
      comment: "Sales channel for channel-specific recipe variant analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart for time-of-day recipe applicability analysis."
    - name: "cook_method"
      expr: cook_method
      comment: "Cooking method (grill, fry, bake, etc.) for equipment utilization and throughput analysis."
    - name: "is_gluten_free"
      expr: is_gluten_free
      comment: "Gluten-free flag for dietary compliance portfolio tracking."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Vegan flag for plant-based portfolio analysis."
    - name: "haccp_ccp_flag"
      expr: haccp_ccp_flag
      comment: "HACCP critical control point flag for food safety compliance monitoring."
    - name: "effective_date"
      expr: DATE_TRUNC('quarter', effective_date)
      comment: "Quarter recipe became effective for tracking recipe refresh cadence."
  measures:
    - name: "total_active_recipes"
      expr: COUNT(CASE WHEN recipe_status = 'active' THEN recipe_id END)
      comment: "Count of active recipes. Tracks recipe portfolio size and complexity — a key driver of kitchen training burden and operational consistency."
    - name: "avg_food_cost"
      expr: AVG(CAST(food_cost AS DOUBLE))
      comment: "Average food cost per recipe. Core input to menu pricing and margin management decisions."
    - name: "avg_food_cost_pct"
      expr: AVG(CAST(food_cost_pct AS DOUBLE))
      comment: "Average food cost as a percentage of menu price. Primary food cost efficiency KPI tracked by operations and finance leadership."
    - name: "avg_yield_quantity"
      expr: AVG(CAST(yield_quantity AS DOUBLE))
      comment: "Average yield quantity per recipe. Low yield signals waste or portioning issues that inflate food cost."
    - name: "avg_waste_pct"
      expr: AVG(CAST(waste_pct AS DOUBLE))
      comment: "Average waste percentage per recipe. Tracks food waste as both a cost and sustainability metric."
    - name: "avg_calories"
      expr: AVG(CAST(calories AS DOUBLE))
      comment: "Average calorie count per recipe. Used by nutrition and regulatory teams to monitor menu health profile and menu board disclosure compliance."
    - name: "avg_sodium_mg"
      expr: AVG(CAST(sodium_mg AS DOUBLE))
      comment: "Average sodium content per recipe. Tracks compliance with health guidelines and consumer transparency commitments."
    - name: "avg_cook_temperature_f"
      expr: AVG(CAST(cook_temperature_f AS DOUBLE))
      comment: "Average cooking temperature in Fahrenheit. Used by food safety teams to verify HACCP critical control point compliance across recipes."
    - name: "haccp_ccp_recipe_count"
      expr: COUNT(CASE WHEN haccp_ccp_flag = TRUE THEN recipe_id END)
      comment: "Count of recipes with HACCP critical control points. Tracks food safety compliance exposure — all CCP recipes require documented monitoring procedures."
    - name: "avg_total_time_seconds"
      expr: AVG(CAST(total_time_seconds AS DOUBLE))
      comment: "Average total preparation time in seconds. Informs kitchen throughput modeling and speed-of-service target setting."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_lto`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Limited Time Offer (LTO) pipeline and performance metrics tracking launch timelines, food cost targets, approval status, and rollout scope. Used by marketing, culinary, and operations to manage the LTO innovation pipeline."
  source: "`vibe_restaurants_v1`.`menu`.`menu_lto`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "LTO lifecycle stage (concept, approved, in-market, retired) for pipeline stage-gate management."
    - name: "lto_type"
      expr: lto_type
      comment: "LTO type (seasonal, promotional, test market, national) for portfolio segmentation."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format for cross-format LTO availability analysis."
    - name: "rollout_scope"
      expr: rollout_scope
      comment: "Rollout scope (national, regional, test market) for launch scale analysis."
    - name: "is_national_launch"
      expr: is_national_launch
      comment: "National launch flag to distinguish national vs. regional LTO performance."
    - name: "is_returning_item"
      expr: is_returning_item
      comment: "Returning item flag to compare new vs. returning LTO performance — returning items typically have lower launch risk."
    - name: "season_or_occasion"
      expr: season_or_occasion
      comment: "Season or occasion (Summer, Holiday, Valentine's Day) for seasonal LTO portfolio planning."
    - name: "planned_launch_date"
      expr: DATE_TRUNC('quarter', planned_launch_date)
      comment: "Quarter of planned launch for pipeline capacity planning."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for governance tracking of LTO pipeline readiness."
    - name: "target_channel"
      expr: target_channel
      comment: "Target sales channel for the LTO for channel-specific launch planning."
  measures:
    - name: "total_lto_items_in_pipeline"
      expr: COUNT(menu_lto_id)
      comment: "Total LTO items in the pipeline. Tracks innovation velocity and pipeline depth — a key indicator of future revenue growth potential."
    - name: "avg_planned_duration_days"
      expr: AVG(CAST(planned_duration_days AS DOUBLE))
      comment: "Average planned duration of LTO campaigns in days. Informs marketing calendar planning and supply chain commitment windows."
    - name: "avg_target_food_cost_pct"
      expr: AVG(CAST(target_food_cost_pct AS DOUBLE))
      comment: "Average target food cost percentage for LTO items. Ensures LTO items meet profitability thresholds before launch approval."
    - name: "avg_suggested_retail_price"
      expr: AVG(CAST(suggested_retail_price AS DOUBLE))
      comment: "Average suggested retail price for LTO items. Used in revenue forecasting and competitive price positioning analysis."
    - name: "avg_pmix_target_pct"
      expr: AVG(CAST(pmix_target_pct AS DOUBLE))
      comment: "Average product mix target percentage for LTO items. Sets the sales volume expectation used to evaluate LTO success post-launch."
    - name: "food_safety_approved_count"
      expr: COUNT(CASE WHEN food_safety_approved = TRUE THEN menu_lto_id END)
      comment: "Count of LTO items with food safety approval. Tracks compliance gate completion — no LTO can launch without food safety sign-off."
    - name: "nutritional_approved_count"
      expr: COUNT(CASE WHEN nutritional_approved = TRUE THEN menu_lto_id END)
      comment: "Count of LTO items with nutritional approval. Tracks regulatory compliance readiness for menu board calorie disclosure requirements."
    - name: "allergen_reviewed_count"
      expr: COUNT(CASE WHEN allergen_reviewed = TRUE THEN menu_lto_id END)
      comment: "Count of LTO items with completed allergen review. Tracks food safety compliance — allergen incidents from LTO items carry significant brand and legal risk."
    - name: "national_launch_count"
      expr: COUNT(CASE WHEN is_national_launch = TRUE THEN menu_lto_id END)
      comment: "Count of national LTO launches. Tracks the scale of innovation investment and national marketing campaign alignment."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_nutrition_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nutritional content analytics across the menu portfolio tracking macronutrients, calories, sodium, and regulatory compliance status. Used by nutrition, regulatory, and marketing teams to manage menu health positioning."
  source: "`vibe_restaurants_v1`.`menu`.`nutrition_profile`"
  dimensions:
    - name: "profile_type"
      expr: profile_type
      comment: "Nutrition profile type (standard, reduced-calorie, allergen-free variant) for portfolio segmentation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the nutrition profile for regulatory compliance tracking."
    - name: "is_current_version"
      expr: is_current_version
      comment: "Flag indicating whether this is the current active nutrition profile version."
    - name: "data_source"
      expr: data_source
      comment: "Source of nutritional data (lab analysis, database, supplier-provided) for data quality segmentation."
    - name: "effective_date"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year nutrition profile became effective for tracking nutritional improvement trends over time."
  measures:
    - name: "avg_calories"
      expr: AVG(CAST(calories_from_fat AS DOUBLE))
      comment: "Average calories from fat per nutrition profile. Tracks fat-calorie contribution as a health positioning metric."
    - name: "avg_total_fat_g"
      expr: AVG(CAST(total_fat_g AS DOUBLE))
      comment: "Average total fat in grams per item. Used by nutrition teams to monitor menu health profile against dietary guidelines."
    - name: "avg_saturated_fat_g"
      expr: AVG(CAST(saturated_fat_g AS DOUBLE))
      comment: "Average saturated fat in grams. Tracks compliance with heart-health guidelines and consumer health commitments."
    - name: "avg_sodium_mg"
      expr: AVG(CAST(sodium_mg AS DOUBLE))
      comment: "Average sodium content in milligrams. A key regulatory and consumer health metric — high sodium drives negative press and regulatory scrutiny."
    - name: "avg_total_carbohydrate_g"
      expr: AVG(CAST(total_carbohydrate_g AS DOUBLE))
      comment: "Average total carbohydrates in grams. Used for low-carb menu positioning and diabetic-friendly item identification."
    - name: "avg_protein_g"
      expr: AVG(CAST(protein_g AS DOUBLE))
      comment: "Average protein content in grams. Tracks high-protein menu positioning, a key driver of health-conscious consumer segment appeal."
    - name: "avg_dietary_fiber_g"
      expr: AVG(CAST(dietary_fiber_g AS DOUBLE))
      comment: "Average dietary fiber in grams. Tracks menu health positioning for fiber-conscious consumers."
    - name: "avg_trans_fat_g"
      expr: AVG(CAST(trans_fat_g AS DOUBLE))
      comment: "Average trans fat in grams. Regulatory compliance metric — trans fat must be near zero per FDA guidelines; any non-zero value triggers immediate review."
    - name: "avg_serving_size_g"
      expr: AVG(CAST(serving_size_g AS DOUBLE))
      comment: "Average serving size in grams. Used for portion standardization and per-serving nutritional benchmarking."
    - name: "current_version_profile_count"
      expr: COUNT(CASE WHEN is_current_version = TRUE THEN nutrition_profile_id END)
      comment: "Count of current-version nutrition profiles. Ensures all active menu items have up-to-date nutritional data for regulatory disclosure compliance."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_engineering_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Menu engineering review analytics tracking portfolio optimization decisions, complexity scores, and implementation outcomes. Used by menu strategy, operations, and finance to drive systematic menu simplification and profitability improvement."
  source: "`vibe_restaurants_v1`.`menu`.`engineering_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Review status (in-progress, completed, approved) for pipeline management of engineering reviews."
    - name: "review_cycle"
      expr: review_cycle
      comment: "Review cycle (quarterly, annual, ad-hoc) for cadence analysis."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format for cross-format engineering review comparison."
    - name: "review_scope_type"
      expr: review_scope_type
      comment: "Scope of the review (full menu, category, daypart) for granularity analysis."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Implementation status of review recommendations for tracking execution follow-through."
    - name: "is_franchise_applicable"
      expr: is_franchise_applicable
      comment: "Flag indicating whether the review applies to franchise locations for franchise vs. corporate comparison."
    - name: "review_date"
      expr: DATE_TRUNC('quarter', review_date)
      comment: "Quarter of review for trend analysis of menu engineering activity."
    - name: "engineering_framework"
      expr: engineering_framework
      comment: "Engineering framework used (BCG matrix, custom) for methodology consistency tracking."
  measures:
    - name: "avg_menu_complexity_score_before"
      expr: AVG(CAST(menu_complexity_score_before AS DOUBLE))
      comment: "Average menu complexity score before engineering review. Establishes the baseline complexity level — high complexity increases training burden and error rates."
    - name: "avg_menu_complexity_score_after"
      expr: AVG(CAST(menu_complexity_score_after AS DOUBLE))
      comment: "Average menu complexity score after engineering review. Measures the effectiveness of simplification efforts — a key operational efficiency KPI."
    - name: "avg_complexity_reduction"
      expr: AVG(CAST(menu_complexity_score_before AS DOUBLE) - CAST(menu_complexity_score_after AS DOUBLE))
      comment: "Average reduction in menu complexity score per review. Quantifies the operational benefit of menu engineering — directly tied to speed-of-service and training cost improvements."
    - name: "avg_contribution_margin"
      expr: AVG(CAST(avg_contribution_margin AS DOUBLE))
      comment: "Average contribution margin across items evaluated in the review. Core profitability metric used to prioritize which items to keep, reposition, or discontinue."
    - name: "avg_popularity_index"
      expr: AVG(CAST(avg_menu_item_popularity_index AS DOUBLE))
      comment: "Average menu item popularity index across reviewed items. Combined with contribution margin to classify items into engineering quadrants."
    - name: "total_items_reprice"
      expr: SUM(CAST(items_reprice_count AS DOUBLE))
      comment: "Total count of items recommended for repricing across all reviews. Tracks the scale of pricing optimization activity driven by menu engineering."
    - name: "avg_cogs_pct_threshold"
      expr: AVG(CAST(cogs_pct_threshold AS DOUBLE))
      comment: "Average COGS percentage threshold used in engineering reviews. Tracks the food cost standard applied to item keep/discontinue decisions."
    - name: "total_reviews_completed"
      expr: COUNT(CASE WHEN review_status = 'completed' THEN engineering_review_id END)
      comment: "Count of completed engineering reviews. Tracks adherence to the menu review cadence — a governance metric for menu management discipline."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_item_86_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item 86 (out-of-stock) event analytics tracking frequency, duration, and operational impact of item unavailability. Used by operations, supply chain, and guest experience teams to reduce stockout incidents and lost sales."
  source: "`vibe_restaurants_v1`.`menu`.`item_86_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Current status of the 86 event (active, resolved) for real-time availability monitoring."
    - name: "reason_code"
      expr: reason_code
      comment: "Root cause code for the 86 event (supply shortage, equipment failure, prep issue) for root cause analysis."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format for cross-format availability benchmarking."
    - name: "channel_affected"
      expr: channel_affected
      comment: "Sales channel affected by the 86 event for channel-specific impact analysis."
    - name: "daypart_affected"
      expr: daypart_affected
      comment: "Daypart during which the 86 event occurred for time-of-day availability analysis."
    - name: "is_lto_item"
      expr: is_lto_item
      comment: "Flag indicating whether the 86'd item is an LTO — LTO stockouts carry higher brand risk due to marketing commitments."
    - name: "is_food_safety_related"
      expr: is_food_safety_related
      comment: "Flag indicating food safety-related 86 events for compliance tracking."
    - name: "is_recall_related"
      expr: is_recall_related
      comment: "Flag indicating recall-related 86 events for supply chain risk monitoring."
    - name: "start_timestamp"
      expr: DATE_TRUNC('week', CAST(start_timestamp AS DATE))
      comment: "Week of 86 event start for trend analysis of stockout frequency."
    - name: "ownership_model"
      expr: ownership_model
      comment: "Ownership model (corporate, franchise) for comparing 86 event rates between ownership types."
  measures:
    - name: "total_86_events"
      expr: COUNT(item_86_event_id)
      comment: "Total count of item 86 events. Primary availability reliability KPI — high frequency signals supply chain or inventory management failures."
    - name: "avg_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of 86 events in minutes. Longer durations indicate slower resolution processes and greater guest impact."
    - name: "total_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total minutes of item unavailability across all 86 events. Quantifies the aggregate operational disruption and lost sales exposure."
    - name: "food_safety_86_event_count"
      expr: COUNT(CASE WHEN is_food_safety_related = TRUE THEN item_86_event_id END)
      comment: "Count of 86 events triggered by food safety concerns. A critical compliance metric — food safety 86 events require immediate escalation and documentation."
    - name: "recall_related_86_event_count"
      expr: COUNT(CASE WHEN is_recall_related = TRUE THEN item_86_event_id END)
      comment: "Count of 86 events related to ingredient recalls. Tracks supply chain risk exposure and recall response effectiveness."
    - name: "olo_suppressed_event_count"
      expr: COUNT(CASE WHEN olo_suppressed = TRUE THEN item_86_event_id END)
      comment: "Count of 86 events where the item was suppressed from online ordering. Measures digital channel availability management effectiveness."
    - name: "avg_inventory_on_hand_at_86"
      expr: AVG(CAST(inventory_quantity_on_hand AS DOUBLE))
      comment: "Average inventory quantity on hand when 86 event was triggered. Low values confirm true stockouts; higher values may indicate par level or ordering process issues."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_allergen_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allergen declaration compliance metrics tracking declaration status, allergen counts, cross-contact risks, and regulatory submission requirements. Used by food safety, legal, and operations teams to manage allergen disclosure obligations."
  source: "`vibe_restaurants_v1`.`menu`.`allergen_declaration`"
  dimensions:
    - name: "declaration_status"
      expr: declaration_status
      comment: "Current status of the allergen declaration (active, superseded, expired) for compliance portfolio management."
    - name: "declaration_type"
      expr: declaration_type
      comment: "Type of allergen declaration (full, partial, may-contain) for risk classification."
    - name: "cross_contact_risk_level"
      expr: cross_contact_risk_level
      comment: "Cross-contact risk level (low, medium, high) for risk-stratified compliance monitoring."
    - name: "gluten_free_certified"
      expr: gluten_free_certified
      comment: "Gluten-free certification flag for certified vs. non-certified item tracking."
    - name: "regulatory_submission_required"
      expr: regulatory_submission_required
      comment: "Flag indicating whether regulatory submission is required for this declaration."
    - name: "declaration_date"
      expr: DATE_TRUNC('year', declaration_date)
      comment: "Year of declaration for tracking declaration refresh cadence and compliance currency."
    - name: "channel_applicability"
      expr: channel_applicability
      comment: "Channel applicability for channel-specific allergen disclosure compliance."
  measures:
    - name: "total_declarations"
      expr: COUNT(allergen_declaration_id)
      comment: "Total allergen declarations in the system. Tracks declaration portfolio completeness — every active menu item must have a current declaration."
    - name: "avg_total_allergen_count"
      expr: AVG(CAST(total_allergen_count AS DOUBLE))
      comment: "Average number of allergens per declaration. Tracks menu allergen complexity — high counts increase guest risk and require more robust disclosure processes."
    - name: "high_cross_contact_risk_count"
      expr: COUNT(CASE WHEN cross_contact_risk_level = 'high' THEN allergen_declaration_id END)
      comment: "Count of declarations with high cross-contact risk. A critical food safety KPI — high cross-contact risk items require enhanced kitchen protocols and guest advisories."
    - name: "regulatory_submission_pending_count"
      expr: COUNT(CASE WHEN regulatory_submission_required = TRUE AND regulatory_submission_date IS NULL THEN allergen_declaration_id END)
      comment: "Count of declarations requiring regulatory submission that have not yet been submitted. Tracks regulatory compliance backlog — unsubmitted declarations create legal exposure."
    - name: "gluten_free_certified_count"
      expr: COUNT(CASE WHEN gluten_free_certified = TRUE THEN allergen_declaration_id END)
      comment: "Count of gluten-free certified declarations. Tracks the certified gluten-free portfolio size for marketing and compliance reporting."
$$;