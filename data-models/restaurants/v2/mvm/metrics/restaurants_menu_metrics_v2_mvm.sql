-- Metric views for domain: menu | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 17:03:36

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core menu item performance metrics covering pricing, cost, margin, and portfolio composition. Used by menu engineering, finance, and operations teams to evaluate item-level profitability and strategic positioning."
  source: "`vibe_restaurants_v1`.`menu`.`menu_item`"
  dimensions:
    - name: "item_status"
      expr: item_status
      comment: "Current lifecycle status of the menu item (e.g., active, discontinued, pending). Used to filter active portfolio vs. retired items."
    - name: "daypart"
      expr: daypart
      comment: "Meal period the item belongs to (e.g., breakfast, lunch, dinner). Enables daypart-level menu performance analysis."
    - name: "menu_engineering_class"
      expr: menu_engineering_class
      comment: "Menu engineering quadrant classification (e.g., star, plow horse, puzzle, dog). Drives strategic decisions on item promotion, repricing, or removal."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format (e.g., drive-thru, dine-in, fast casual). Enables format-level portfolio analysis."
    - name: "subcategory"
      expr: subcategory
      comment: "Menu subcategory grouping (e.g., burgers, sides, beverages). Supports category-level mix and margin analysis."
    - name: "is_lto"
      expr: is_lto
      comment: "Indicates whether the item is a Limited Time Offer. Enables LTO vs. core menu performance comparison."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Indicates whether the item is vegan. Supports dietary portfolio composition reporting."
    - name: "is_vegetarian"
      expr: is_vegetarian
      comment: "Indicates whether the item is vegetarian. Supports dietary portfolio composition reporting."
    - name: "is_gluten_free"
      expr: is_gluten_free
      comment: "Indicates whether the item is gluten-free. Supports allergen-sensitive portfolio analysis."
    - name: "launch_date"
      expr: DATE_TRUNC('month', launch_date)
      comment: "Month of item launch. Enables cohort analysis of items by launch period."
    - name: "is_combo_eligible"
      expr: is_combo_eligible
      comment: "Indicates whether the item can be included in combo meals. Supports combo bundling strategy analysis."
    - name: "is_customizable"
      expr: is_customizable
      comment: "Indicates whether the item supports customization. Relevant for operational complexity and modifier revenue analysis."
  measures:
    - name: "total_menu_items"
      expr: COUNT(DISTINCT menu_item_id)
      comment: "Total number of distinct menu items in the portfolio. Baseline measure for portfolio size and breadth analysis."
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base selling price across menu items. Tracks pricing tier positioning and price mix shifts over time."
    - name: "avg_item_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost of goods per menu item. Used alongside avg_base_price to assess gross margin at the item level."
    - name: "total_base_price"
      expr: SUM(CAST(base_price AS DOUBLE))
      comment: "Sum of base prices across items. Used as numerator in portfolio-level average price calculations."
    - name: "total_item_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Sum of item costs across the portfolio. Used as numerator in portfolio-level cost calculations."
    - name: "avg_sodium_mg"
      expr: AVG(CAST(sodium_mg AS DOUBLE))
      comment: "Average sodium content in milligrams across menu items. Supports nutritional compliance monitoring and regulatory reporting obligations."
    - name: "avg_portion_size_grams"
      expr: AVG(CAST(portion_size_grams AS DOUBLE))
      comment: "Average portion size in grams. Used in food cost benchmarking and portion standardization reviews."
    - name: "lto_item_count"
      expr: COUNT(DISTINCT CASE WHEN is_lto = TRUE THEN menu_item_id END)
      comment: "Number of active Limited Time Offer items. Tracks LTO pipeline depth and promotional menu complexity."
    - name: "vegan_item_count"
      expr: COUNT(DISTINCT CASE WHEN is_vegan = TRUE THEN menu_item_id END)
      comment: "Number of vegan menu items. Supports dietary inclusivity portfolio targets and brand positioning."
    - name: "gluten_free_item_count"
      expr: COUNT(DISTINCT CASE WHEN is_gluten_free = TRUE THEN menu_item_id END)
      comment: "Number of gluten-free menu items. Supports allergen-sensitive guest accommodation and regulatory compliance."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_item_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item-level food cost and margin metrics. Used by finance, menu engineering, and supply chain teams to monitor COGS performance, identify cost variance, and drive profitability decisions."
  source: "`vibe_restaurants_v1`.`menu`.`item_cost`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Sales channel (e.g., dine-in, drive-thru, delivery). Enables channel-level cost and margin analysis."
    - name: "daypart"
      expr: daypart
      comment: "Meal period associated with the cost record. Supports daypart-level COGS analysis."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format for the cost record. Enables format-level cost benchmarking."
    - name: "menu_engineering_class"
      expr: menu_engineering_class
      comment: "Menu engineering classification at time of cost calculation. Links cost performance to strategic item classification."
    - name: "is_lto"
      expr: is_lto
      comment: "Indicates whether the cost record applies to a Limited Time Offer item. Enables LTO vs. core cost comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the cost record. Supports period-over-period cost trend analysis."
    - name: "cost_calculation_date"
      expr: DATE_TRUNC('month', cost_calculation_date)
      comment: "Month of cost calculation. Enables monthly cost trend and variance tracking."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the cost record became effective. Used for cost cohort and lifecycle analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost record. Required for multi-currency cost normalization."
  measures:
    - name: "avg_actual_cogs_pct"
      expr: AVG(CAST(actual_cogs_pct AS DOUBLE))
      comment: "Average actual cost of goods sold percentage. Primary profitability KPI — directly measures how much of revenue is consumed by food cost."
    - name: "avg_target_cogs_pct"
      expr: AVG(CAST(target_cogs_pct AS DOUBLE))
      comment: "Average target COGS percentage. Benchmark for evaluating actual vs. planned food cost performance."
    - name: "avg_theoretical_cogs_pct"
      expr: AVG(CAST(theoretical_cogs_pct AS DOUBLE))
      comment: "Average theoretical COGS percentage based on recipe standards. Gap between theoretical and actual indicates waste, theft, or portioning issues."
    - name: "avg_cogs_pct_variance"
      expr: AVG(CAST(cogs_pct_variance AS DOUBLE))
      comment: "Average variance between actual and target COGS percentage. Negative variance indicates over-cost; positive indicates favorable performance."
    - name: "total_theoretical_cost_amount"
      expr: SUM(CAST(theoretical_cost_amount AS DOUBLE))
      comment: "Total theoretical food cost amount across items. Used as baseline for waste and variance dollar quantification."
    - name: "total_theoretical_cost_variance_amount"
      expr: SUM(CAST(theoretical_cost_variance_amount AS DOUBLE))
      comment: "Total dollar variance between theoretical and actual food cost. Directly quantifies financial exposure from food cost inefficiency."
    - name: "avg_packaging_cost"
      expr: AVG(CAST(packaging_cost AS DOUBLE))
      comment: "Average packaging cost per item cost record. Tracks packaging as a component of total COGS, especially relevant for delivery channel growth."
    - name: "avg_waste_pct"
      expr: AVG(CAST(waste_pct AS DOUBLE))
      comment: "Average waste percentage across item cost records. High waste drives COGS above theoretical — a key operational efficiency metric."
    - name: "avg_yield_pct"
      expr: AVG(CAST(yield_pct AS DOUBLE))
      comment: "Average yield percentage across item cost records. Low yield indicates prep inefficiency or over-portioning, directly impacting food cost."
    - name: "avg_base_selling_price"
      expr: AVG(CAST(base_selling_price AS DOUBLE))
      comment: "Average base selling price at time of cost calculation. Used alongside avg_actual_cogs_pct to compute implied gross margin."
    - name: "avg_primary_protein_cost"
      expr: AVG(CAST(primary_protein_cost AS DOUBLE))
      comment: "Average primary protein cost per item. Protein is typically the largest COGS driver — tracking this enables targeted commodity cost management."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_item_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Menu item pricing metrics covering price levels, promotional pricing, and margin indicators. Used by revenue management, finance, and franchise operations to govern pricing strategy and compliance."
  source: "`vibe_restaurants_v1`.`menu`.`item_price`"
  dimensions:
    - name: "ordering_channel"
      expr: ordering_channel
      comment: "Channel through which the price applies (e.g., in-store, OLO, 3PD). Enables channel-level price tier analysis."
    - name: "daypart"
      expr: daypart
      comment: "Meal period for the price record. Supports daypart-level pricing strategy review."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format for the price record. Enables format-level price benchmarking."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model (e.g., corporate, franchise). Critical for franchise pricing compliance monitoring."
    - name: "menu_engineering_category"
      expr: menu_engineering_category
      comment: "Menu engineering category at time of pricing. Links price levels to strategic item classification."
    - name: "is_lto"
      expr: is_lto
      comment: "Indicates whether the price record applies to a Limited Time Offer. Enables LTO vs. core pricing comparison."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the price record is currently active. Used to filter live pricing vs. historical records."
    - name: "country_code"
      expr: country_code
      comment: "Country of the price record. Enables international price tier and currency analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price record. Required for multi-currency price normalization."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the price became effective. Enables price change trend analysis over time."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the price record. Supports governance and compliance workflows."
  measures:
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base menu price across price records. Core pricing KPI used in price tier benchmarking and competitive analysis."
    - name: "avg_suggested_retail_price"
      expr: AVG(CAST(suggested_retail_price AS DOUBLE))
      comment: "Average suggested retail price. Compared against avg_base_price to measure price realization vs. recommended pricing."
    - name: "avg_promotional_price"
      expr: AVG(CAST(promotional_price AS DOUBLE))
      comment: "Average promotional price. Tracks depth of promotional discounting across the menu."
    - name: "avg_channel_surcharge"
      expr: AVG(CAST(channel_surcharge AS DOUBLE))
      comment: "Average channel surcharge applied to prices. Quantifies the revenue premium captured from delivery and digital channels."
    - name: "avg_cogs_pct"
      expr: AVG(CAST(cogs_pct AS DOUBLE))
      comment: "Average COGS percentage embedded in price records. Tracks margin health at the price-record level."
    - name: "avg_cost_of_goods"
      expr: AVG(CAST(cost_of_goods AS DOUBLE))
      comment: "Average cost of goods per price record. Used alongside avg_base_price to compute implied gross margin dollars."
    - name: "avg_franchise_price_deviation_pct"
      expr: AVG(CAST(franchise_price_deviation_pct AS DOUBLE))
      comment: "Average franchise price deviation from corporate recommended price. High deviation signals franchise pricing non-compliance requiring intervention."
    - name: "active_price_record_count"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN item_price_id END)
      comment: "Number of currently active price records. Tracks live pricing coverage across the menu portfolio."
    - name: "lto_price_record_count"
      expr: COUNT(DISTINCT CASE WHEN is_lto = TRUE THEN item_price_id END)
      comment: "Number of price records associated with Limited Time Offers. Tracks promotional pricing complexity and LTO pricing governance."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_combo_meal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Combo meal portfolio and bundling economics metrics. Used by menu engineering, marketing, and finance to evaluate combo pricing strategy, bundle discount depth, and combo portfolio composition."
  source: "`vibe_restaurants_v1`.`menu`.`combo_meal`"
  dimensions:
    - name: "combo_status"
      expr: combo_status
      comment: "Current lifecycle status of the combo meal (e.g., active, discontinued). Used to filter active vs. retired combos."
    - name: "combo_type"
      expr: combo_type
      comment: "Type of combo (e.g., value meal, family bundle, kids meal). Enables combo category performance analysis."
    - name: "daypart"
      expr: daypart
      comment: "Meal period the combo is available. Supports daypart-level combo performance analysis."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format for the combo. Enables format-level combo portfolio analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the combo is available. Supports international combo portfolio and pricing analysis."
    - name: "menu_engineering_class"
      expr: menu_engineering_class
      comment: "Menu engineering classification of the combo. Links combo performance to strategic portfolio decisions."
    - name: "is_national_launch"
      expr: is_national_launch
      comment: "Indicates whether the combo is a national launch. Differentiates national vs. regional combo performance."
    - name: "is_customizable"
      expr: is_customizable
      comment: "Indicates whether the combo supports customization. Relevant for operational complexity analysis."
    - name: "launch_date"
      expr: DATE_TRUNC('month', launch_date)
      comment: "Month of combo launch. Enables cohort analysis of combos by launch period."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the combo price. Required for multi-currency analysis."
  measures:
    - name: "total_active_combos"
      expr: COUNT(DISTINCT CASE WHEN combo_status = 'active' THEN combo_meal_id END)
      comment: "Number of currently active combo meals. Tracks combo portfolio breadth and complexity."
    - name: "avg_bundle_price"
      expr: AVG(CAST(bundle_price AS DOUBLE))
      comment: "Average bundle price across combo meals. Core pricing KPI for combo value positioning."
    - name: "avg_bundle_discount_amount"
      expr: AVG(CAST(bundle_discount_amount AS DOUBLE))
      comment: "Average discount amount offered through combo bundling. Measures the financial incentive provided to guests to trade up to combos."
    - name: "total_bundle_discount_amount"
      expr: SUM(CAST(bundle_discount_amount AS DOUBLE))
      comment: "Total bundle discount value across all combos. Quantifies the aggregate revenue trade-off from combo discounting strategy."
    - name: "avg_individual_items_price_sum"
      expr: AVG(CAST(individual_items_price_sum AS DOUBLE))
      comment: "Average sum of individual item prices if purchased separately. Used with avg_bundle_price to compute average bundle savings rate."
    - name: "avg_food_cost_pct"
      expr: AVG(CAST(food_cost_pct AS DOUBLE))
      comment: "Average food cost percentage for combo meals. Tracks combo-level COGS performance and margin health."
    - name: "avg_item_cost"
      expr: AVG(CAST(item_cost AS DOUBLE))
      comment: "Average item cost for combo meals. Used alongside avg_bundle_price to compute implied combo gross margin."
    - name: "avg_total_calories"
      expr: AVG(CAST(total_calories AS DOUBLE))
      comment: "Average total calorie count for combo meals. Supports nutritional compliance monitoring and menu health positioning."
    - name: "avg_pmix_target_pct"
      expr: AVG(CAST(pmix_target_pct AS DOUBLE))
      comment: "Average product mix target percentage for combos. Tracks whether combos are meeting their planned sales mix contribution."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recipe-level operational and cost metrics. Used by culinary, operations, and finance teams to govern recipe standards, food cost, and kitchen efficiency across the menu portfolio."
  source: "`vibe_restaurants_v1`.`menu`.`recipe`"
  dimensions:
    - name: "recipe_status"
      expr: recipe_status
      comment: "Current status of the recipe (e.g., active, draft, retired). Used to filter production-ready recipes."
    - name: "recipe_type"
      expr: recipe_type
      comment: "Type of recipe (e.g., core, LTO, modifier). Enables recipe portfolio segmentation."
    - name: "subcategory"
      expr: subcategory
      comment: "Recipe subcategory for finer-grained portfolio analysis."
    - name: "daypart"
      expr: daypart
      comment: "Meal period the recipe is associated with. Enables daypart-level recipe performance analysis."
    - name: "channel"
      expr: channel
      comment: "Sales channel the recipe is designed for. Supports channel-specific recipe cost benchmarking."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format for the recipe. Enables format-level recipe standardization analysis."
    - name: "cook_method"
      expr: cook_method
      comment: "Cooking method (e.g., fried, grilled, baked). Supports kitchen equipment utilization and energy cost analysis."
    - name: "is_gluten_free"
      expr: is_gluten_free
      comment: "Indicates whether the recipe is gluten-free. Supports allergen-sensitive menu compliance."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Indicates whether the recipe is vegan. Supports dietary portfolio composition reporting."
    - name: "haccp_ccp_flag"
      expr: haccp_ccp_flag
      comment: "Indicates whether the recipe has a HACCP Critical Control Point. Used in food safety compliance monitoring."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the recipe became effective. Enables recipe version cohort analysis."
  measures:
    - name: "total_active_recipes"
      expr: COUNT(DISTINCT CASE WHEN recipe_status = 'active' THEN recipe_id END)
      comment: "Number of currently active recipes. Tracks recipe portfolio size and standardization coverage."
    - name: "avg_food_cost"
      expr: AVG(CAST(food_cost AS DOUBLE))
      comment: "Average food cost per recipe. Core profitability KPI for recipe-level cost management."
    - name: "avg_food_cost_pct"
      expr: AVG(CAST(food_cost_pct AS DOUBLE))
      comment: "Average food cost as a percentage of menu price. Tracks recipe-level margin health against targets."
    - name: "avg_menu_price"
      expr: AVG(CAST(menu_price AS DOUBLE))
      comment: "Average menu price across recipes. Used alongside avg_food_cost to compute implied gross margin per recipe."
    - name: "avg_waste_pct"
      expr: AVG(CAST(waste_pct AS DOUBLE))
      comment: "Average waste percentage across recipes. High waste directly inflates food cost — a key operational efficiency metric."
    - name: "avg_yield_quantity"
      expr: AVG(CAST(yield_quantity AS DOUBLE))
      comment: "Average yield quantity per recipe. Low yield indicates prep inefficiency or over-portioning."
    - name: "avg_calories"
      expr: AVG(CAST(calories AS DOUBLE))
      comment: "Average calorie count per recipe. Supports nutritional compliance monitoring and menu health positioning."
    - name: "avg_sodium_mg"
      expr: AVG(CAST(sodium_mg AS DOUBLE))
      comment: "Average sodium content in milligrams per recipe. Supports regulatory nutritional disclosure compliance."
    - name: "avg_cook_temperature_f"
      expr: AVG(CAST(cook_temperature_f AS DOUBLE))
      comment: "Average cooking temperature in Fahrenheit. Used in food safety compliance monitoring and HACCP standard verification."
    - name: "avg_holding_temperature_f"
      expr: AVG(CAST(holding_temperature_f AS DOUBLE))
      comment: "Average holding temperature in Fahrenheit. Critical food safety metric — deviations from standard indicate compliance risk."
    - name: "haccp_ccp_recipe_count"
      expr: COUNT(DISTINCT CASE WHEN haccp_ccp_flag = TRUE THEN recipe_id END)
      comment: "Number of recipes with HACCP Critical Control Points. Tracks food safety compliance coverage across the recipe portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_nutrition_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nutritional profile metrics across the menu portfolio. Used by regulatory affairs, culinary, and marketing teams to monitor nutritional compliance, menu health positioning, and disclosure requirements."
  source: "`vibe_restaurants_v1`.`menu`.`nutrition_profile`"
  dimensions:
    - name: "profile_type"
      expr: profile_type
      comment: "Type of nutrition profile (e.g., standard, LTO, modifier). Enables profile-type segmentation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the nutrition profile. Used to filter approved vs. pending profiles for compliance reporting."
    - name: "data_source"
      expr: data_source
      comment: "Source of nutritional data (e.g., lab analysis, database). Tracks data quality and regulatory defensibility."
    - name: "is_current_version"
      expr: is_current_version
      comment: "Indicates whether this is the current active nutrition profile version. Used to filter to live nutritional data."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the nutrition profile became effective. Enables nutritional change trend analysis."
    - name: "lab_analysis_date"
      expr: DATE_TRUNC('month', lab_analysis_date)
      comment: "Month of lab analysis. Tracks recency of nutritional data for compliance freshness monitoring."
  measures:
    - name: "avg_total_fat_g"
      expr: AVG(CAST(total_fat_g AS DOUBLE))
      comment: "Average total fat in grams per nutrition profile. Core nutritional KPI for menu health positioning and regulatory disclosure."
    - name: "avg_saturated_fat_g"
      expr: AVG(CAST(saturated_fat_g AS DOUBLE))
      comment: "Average saturated fat in grams. Regulatory and health-positioning metric — high saturated fat drives menu health risk."
    - name: "avg_trans_fat_g"
      expr: AVG(CAST(trans_fat_g AS DOUBLE))
      comment: "Average trans fat in grams. Regulatory compliance metric — trans fat limits are mandated in many jurisdictions."
    - name: "avg_sodium_mg"
      expr: AVG(CAST(sodium_mg AS DOUBLE))
      comment: "Average sodium in milligrams. High-priority regulatory and public health metric — sodium reduction is a key menu health initiative."
    - name: "avg_total_carbohydrate_g"
      expr: AVG(CAST(total_carbohydrate_g AS DOUBLE))
      comment: "Average total carbohydrates in grams. Supports nutritional disclosure and dietary positioning."
    - name: "avg_protein_g"
      expr: AVG(CAST(protein_g AS DOUBLE))
      comment: "Average protein in grams. Supports nutritional positioning and high-protein menu segment analysis."
    - name: "avg_dietary_fiber_g"
      expr: AVG(CAST(dietary_fiber_g AS DOUBLE))
      comment: "Average dietary fiber in grams. Supports menu health positioning and nutritional disclosure."
    - name: "avg_total_sugars_g"
      expr: AVG(CAST(total_sugars_g AS DOUBLE))
      comment: "Average total sugars in grams. Regulatory and health-positioning metric — sugar reduction is a key menu health initiative."
    - name: "avg_added_sugars_g"
      expr: AVG(CAST(added_sugars_g AS DOUBLE))
      comment: "Average added sugars in grams. Regulatory disclosure requirement under FDA nutrition labeling rules."
    - name: "avg_cholesterol_mg"
      expr: AVG(CAST(cholesterol_mg AS DOUBLE))
      comment: "Average cholesterol in milligrams. Supports nutritional compliance and menu health positioning."
    - name: "avg_serving_size_g"
      expr: AVG(CAST(serving_size_g AS DOUBLE))
      comment: "Average serving size in grams. Used to normalize per-serving nutritional values for cross-item comparison."
    - name: "current_profile_count"
      expr: COUNT(DISTINCT CASE WHEN is_current_version = TRUE THEN nutrition_profile_id END)
      comment: "Number of current active nutrition profiles. Tracks nutritional data coverage across the menu portfolio — gaps indicate compliance risk."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_recipe_ingredient`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recipe ingredient cost and compliance metrics. Used by supply chain, culinary, and finance teams to monitor ingredient-level food cost, sourcing compliance, and allergen risk."
  source: "`vibe_restaurants_v1`.`menu`.`recipe_ingredient`"
  dimensions:
    - name: "ingredient_status"
      expr: ingredient_status
      comment: "Current status of the recipe ingredient (e.g., active, substituted, discontinued). Used to filter active ingredient records."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the ingredient quantity. Required for cost normalization and yield analysis."
    - name: "prep_state"
      expr: prep_state
      comment: "Preparation state of the ingredient (e.g., raw, cooked, frozen). Impacts yield and cost calculations."
    - name: "is_critical_ingredient"
      expr: is_critical_ingredient
      comment: "Indicates whether the ingredient is critical to the recipe. Supports supply chain risk prioritization."
    - name: "is_organic"
      expr: is_organic
      comment: "Indicates whether the ingredient is organic. Supports premium sourcing portfolio analysis."
    - name: "is_halal_certified"
      expr: is_halal_certified
      comment: "Indicates whether the ingredient is halal certified. Supports dietary compliance and market-specific menu requirements."
    - name: "is_kosher_certified"
      expr: is_kosher_certified
      comment: "Indicates whether the ingredient is kosher certified. Supports dietary compliance and market-specific menu requirements."
    - name: "contains_gluten"
      expr: contains_gluten
      comment: "Indicates whether the ingredient contains gluten. Critical for allergen management and gluten-free menu compliance."
    - name: "contains_dairy"
      expr: contains_dairy
      comment: "Indicates whether the ingredient contains dairy. Critical for allergen management and dairy-free menu compliance."
    - name: "is_substitution_allowed"
      expr: is_substitution_allowed
      comment: "Indicates whether ingredient substitution is permitted. Supports supply chain flexibility and shortage response planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the ingredient cost. Required for multi-currency cost normalization."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the ingredient record became effective. Enables ingredient cost trend analysis over time."
  measures:
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit of ingredient. Core ingredient cost KPI — tracks commodity price trends and supplier cost performance."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended ingredient cost (quantity × cost per unit). Quantifies total ingredient spend across the recipe portfolio."
    - name: "avg_extended_cost"
      expr: AVG(CAST(extended_cost AS DOUBLE))
      comment: "Average extended ingredient cost per recipe line. Used for ingredient-level cost benchmarking."
    - name: "avg_waste_factor_pct"
      expr: AVG(CAST(waste_factor_pct AS DOUBLE))
      comment: "Average waste factor percentage across recipe ingredients. High waste factors inflate food cost — a key operational efficiency metric."
    - name: "avg_yield_pct"
      expr: AVG(CAST(yield_pct AS DOUBLE))
      comment: "Average yield percentage across recipe ingredients. Low yield indicates prep inefficiency directly impacting food cost."
    - name: "avg_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average ingredient quantity per recipe line. Used for portion standardization monitoring and recipe compliance."
    - name: "avg_par_level_quantity"
      expr: AVG(CAST(par_level_quantity AS DOUBLE))
      comment: "Average par level quantity for ingredients. Supports inventory planning and waste reduction initiatives."
    - name: "avg_min_internal_temp_f"
      expr: AVG(CAST(min_internal_temp_f AS DOUBLE))
      comment: "Average minimum internal cooking temperature in Fahrenheit. Food safety compliance metric — deviations indicate HACCP risk."
    - name: "critical_ingredient_count"
      expr: COUNT(DISTINCT CASE WHEN is_critical_ingredient = TRUE THEN recipe_ingredient_id END)
      comment: "Number of critical ingredient records. Tracks supply chain risk exposure — high counts indicate vulnerability to ingredient shortages."
    - name: "gluten_containing_ingredient_count"
      expr: COUNT(DISTINCT CASE WHEN contains_gluten = TRUE THEN recipe_ingredient_id END)
      comment: "Number of recipe ingredient records containing gluten. Supports allergen management and gluten-free menu compliance monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_allergen_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allergen declaration compliance and risk metrics. Used by food safety, regulatory affairs, and operations teams to monitor allergen disclosure coverage, cross-contact risk, and regulatory submission compliance."
  source: "`vibe_restaurants_v1`.`menu`.`allergen_declaration`"
  dimensions:
    - name: "declaration_status"
      expr: CAST(declaration_status AS STRING)
      comment: "Current status of the allergen declaration. Used to filter active vs. superseded declarations."
    - name: "declaration_type"
      expr: CAST(declaration_type AS STRING)
      comment: "Type of allergen declaration. Enables declaration type segmentation for compliance analysis."
    - name: "cross_contact_risk_level"
      expr: cross_contact_risk_level
      comment: "Risk level of cross-contact contamination (e.g., low, medium, high). Critical food safety dimension for risk prioritization."
    - name: "channel_applicability"
      expr: channel_applicability
      comment: "Channel(s) to which the declaration applies. Enables channel-level allergen compliance analysis."
    - name: "daypart_applicability"
      expr: daypart_applicability
      comment: "Daypart(s) to which the declaration applies. Supports daypart-level allergen compliance monitoring."
    - name: "gluten_free_certified"
      expr: gluten_free_certified
      comment: "Indicates whether the item is gluten-free certified. Supports allergen-sensitive menu compliance reporting."
    - name: "regulatory_submission_required"
      expr: regulatory_submission_required
      comment: "Indicates whether regulatory submission is required for this declaration. Tracks regulatory obligation coverage."
    - name: "declaration_date"
      expr: DATE_TRUNC('month', declaration_date)
      comment: "Month of allergen declaration. Enables declaration volume trend analysis."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the declaration became effective. Supports compliance timeline analysis."
    - name: "wheat_status"
      expr: wheat_status
      comment: "Wheat allergen status (e.g., contains, may contain, free). Supports Big 9 allergen compliance monitoring."
    - name: "milk_status"
      expr: milk_status
      comment: "Milk allergen status. Supports Big 9 allergen compliance monitoring."
    - name: "peanuts_status"
      expr: peanuts_status
      comment: "Peanuts allergen status. Supports Big 9 allergen compliance monitoring — peanut allergy is a high-severity risk."
    - name: "tree_nuts_status"
      expr: tree_nuts_status
      comment: "Tree nuts allergen status. Supports Big 9 allergen compliance monitoring."
  measures:
    - name: "total_allergen_declarations"
      expr: COUNT(DISTINCT allergen_declaration_id)
      comment: "Total number of allergen declarations. Baseline measure for allergen disclosure coverage across the menu portfolio."
    - name: "avg_total_allergen_count"
      expr: AVG(CAST(total_allergen_count AS DOUBLE))
      comment: "Average number of allergens per declaration. Tracks allergen complexity across the menu — high counts indicate elevated guest risk and labeling burden."
    - name: "total_allergen_count_sum"
      expr: SUM(CAST(total_allergen_count AS DOUBLE))
      comment: "Total allergen count across all declarations. Quantifies aggregate allergen exposure across the menu portfolio."
    - name: "high_cross_contact_risk_count"
      expr: COUNT(DISTINCT CASE WHEN cross_contact_risk_level = 'high' THEN allergen_declaration_id END)
      comment: "Number of declarations with high cross-contact risk. Critical food safety KPI — high counts require immediate operational intervention."
    - name: "regulatory_submission_required_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_submission_required = TRUE THEN allergen_declaration_id END)
      comment: "Number of declarations requiring regulatory submission. Tracks regulatory compliance obligation volume and submission backlog risk."
    - name: "gluten_free_certified_count"
      expr: COUNT(DISTINCT CASE WHEN gluten_free_certified = TRUE THEN allergen_declaration_id END)
      comment: "Number of gluten-free certified declarations. Tracks certified gluten-free menu coverage for allergen-sensitive guests."
    - name: "avg_declaration_number"
      expr: AVG(CAST(declaration_number AS DOUBLE))
      comment: "Average declaration number. Used as a proxy for declaration versioning depth — high averages indicate frequent allergen profile revisions."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_modifier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Menu modifier economics and availability metrics. Used by menu engineering, operations, and finance teams to evaluate modifier pricing, COGS impact, and portfolio complexity."
  source: "`vibe_restaurants_v1`.`menu`.`menu_modifier`"
  dimensions:
    - name: "menu_modifier_status"
      expr: menu_modifier_status
      comment: "Current status of the modifier (e.g., active, unavailable). Used to filter active vs. inactive modifiers."
    - name: "modifier_type"
      expr: modifier_type
      comment: "Type of modifier (e.g., add-on, substitution, removal). Enables modifier type segmentation for revenue and complexity analysis."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format for the modifier. Enables format-level modifier portfolio analysis."
    - name: "is_lto"
      expr: is_lto
      comment: "Indicates whether the modifier is a Limited Time Offer. Enables LTO vs. core modifier comparison."
    - name: "is_available"
      expr: is_available
      comment: "Indicates whether the modifier is currently available. Used to track modifier availability and 86 situations."
    - name: "is_default"
      expr: is_default
      comment: "Indicates whether the modifier is the default selection. Impacts revenue and COGS baseline calculations."
    - name: "is_allergen_free"
      expr: is_allergen_free
      comment: "Indicates whether the modifier is allergen-free. Supports allergen-sensitive menu customization analysis."
    - name: "is_required"
      expr: is_required
      comment: "Indicates whether the modifier selection is required. Impacts guest experience and order completion rate analysis."
    - name: "available_dayparts"
      expr: available_dayparts
      comment: "Dayparts during which the modifier is available. Supports daypart-level modifier availability analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the modifier became effective. Enables modifier portfolio evolution analysis."
  measures:
    - name: "total_active_modifiers"
      expr: COUNT(DISTINCT CASE WHEN is_available = TRUE THEN menu_modifier_id END)
      comment: "Number of currently available modifiers. Tracks modifier portfolio breadth and customization complexity."
    - name: "avg_price_delta"
      expr: AVG(CAST(price_delta AS DOUBLE))
      comment: "Average price delta (upcharge or discount) per modifier. Tracks modifier revenue contribution and pricing strategy."
    - name: "total_price_delta"
      expr: SUM(CAST(price_delta AS DOUBLE))
      comment: "Total price delta across all modifiers. Quantifies aggregate modifier revenue opportunity across the portfolio."
    - name: "avg_cogs_delta"
      expr: AVG(CAST(cogs_delta AS DOUBLE))
      comment: "Average COGS delta per modifier. Tracks the cost impact of modifier selections on food cost."
    - name: "avg_fat_delta_g"
      expr: AVG(CAST(fat_delta_g AS DOUBLE))
      comment: "Average fat content delta in grams per modifier. Supports nutritional impact analysis of modifier selections."
    - name: "avg_sodium_delta_mg"
      expr: AVG(CAST(sodium_delta_mg AS DOUBLE))
      comment: "Average sodium delta in milligrams per modifier. Supports nutritional compliance monitoring for customized orders."
    - name: "avg_protein_delta_g"
      expr: AVG(CAST(protein_delta_g AS DOUBLE))
      comment: "Average protein delta in grams per modifier. Supports nutritional positioning of modifier options."
    - name: "lto_modifier_count"
      expr: COUNT(DISTINCT CASE WHEN is_lto = TRUE THEN menu_modifier_id END)
      comment: "Number of Limited Time Offer modifiers. Tracks LTO modifier pipeline and promotional complexity."
$$;