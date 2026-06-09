-- Metric views for domain: menu | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 02:26:41

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`menu_item_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing performance metrics for menu items, useful for pricing strategy and margin optimization"
  source: "`restaurants_ecm`.`menu`.`item_price`"
  dimensions:
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Format of the restaurant (e.g., quick-service, casual, fine-dining)"
    - name: "country_code"
      expr: country_code
      comment: "ISO country code where the price is applied"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price"
    - name: "daypart"
      expr: daypart
      comment: "Daypart applicability of the price"
    - name: "price_region_code"
      expr: price_region_code
      comment: "Regional pricing code"
    - name: "price_effective_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month of price effectiveness"
  measures:
    - name: "count_price_records"
      expr: COUNT(1)
      comment: "Total number of price records for menu items"
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price across menu items"
    - name: "avg_promotional_price"
      expr: AVG(CAST(promotional_price AS DOUBLE))
      comment: "Average promotional price across menu items"
    - name: "avg_price_override_limit"
      expr: AVG(CAST(price_override_limit AS DOUBLE))
      comment: "Average price override limit amount"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`menu_item_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost efficiency metrics for menu items, informing procurement and margin improvement"
  source: "`restaurants_ecm`.`menu`.`item_cost`"
  dimensions:
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format (e.g., quick-service, casual)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost data"
    - name: "source_system"
      expr: source_system
      comment: "Source system that supplied the cost record"
    - name: "cost_effective_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month of cost effectiveness"
  measures:
    - name: "count_cost_records"
      expr: COUNT(1)
      comment: "Total number of cost records for menu items"
    - name: "avg_actual_cogs_pct"
      expr: AVG(CAST(actual_cogs_pct AS DOUBLE))
      comment: "Average actual cost of goods sold percentage"
    - name: "avg_theoretical_cogs_pct"
      expr: AVG(CAST(theoretical_cogs_pct AS DOUBLE))
      comment: "Average theoretical COGS percentage"
    - name: "avg_waste_pct"
      expr: AVG(CAST(waste_pct AS DOUBLE))
      comment: "Average waste percentage across items"
    - name: "avg_yield_pct"
      expr: AVG(CAST(yield_pct AS DOUBLE))
      comment: "Average yield percentage across items"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`menu_sales_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core sales performance KPIs for menu items, driving revenue and profitability decisions"
  source: "`restaurants_ecm`.`menu`.`pmix_record`"
  dimensions:
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format (e.g., quick-service, casual)"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Channel through which the sale occurred"
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the sale"
    - name: "reporting_month"
      expr: DATE_TRUNC('month', reporting_date)
      comment: "Month of the reporting date"
    - name: "menu_engineering_classification"
      expr: menu_engineering_classification
      comment: "Engineering classification of the menu item"
  measures:
    - name: "count_sales_records"
      expr: COUNT(1)
      comment: "Total number of sales records in the PMIX view"
    - name: "total_gross_sales_amount"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales amount"
    - name: "total_net_sales_amount"
      expr: SUM(CAST(net_sales_amount AS DOUBLE))
      comment: "Total net sales amount after discounts and refunds"
    - name: "total_contribution_margin_amount"
      expr: SUM(CAST(contribution_margin_amount AS DOUBLE))
      comment: "Total contribution margin amount"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount"
    - name: "avg_menu_mix_pct"
      expr: AVG(CAST(menu_mix_pct AS DOUBLE))
      comment: "Average menu mix percentage"
    - name: "avg_sales_mix_pct"
      expr: AVG(CAST(sales_mix_pct AS DOUBLE))
      comment: "Average sales mix percentage"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`menu_overview`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level overview of menus across the enterprise, supporting portfolio management"
  source: "`restaurants_ecm`.`menu`.`menu`"
  dimensions:
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format (e.g., quick-service, casual, fine-dining)"
    - name: "country_code"
      expr: country_code
      comment: "Country code where the menu is deployed"
    - name: "is_default"
      expr: is_default
      comment: "Indicates if this is the default menu for the location"
    - name: "is_franchise_menu"
      expr: is_franchise_menu
      comment: "Flag indicating franchise‑owned menu"
    - name: "menu_effective_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when the menu became effective"
  measures:
    - name: "count_menus"
      expr: COUNT(1)
      comment: "Total number of menu records"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`menu_engineering_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering review KPIs that track menu optimization impact and guide future redesigns"
  source: "`restaurants_ecm`.`menu`.`engineering_review`"
  dimensions:
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format under review"
    - name: "review_cycle"
      expr: review_cycle
      comment: "Review cycle identifier (e.g., Q1‑2024)"
    - name: "implementation_status"
      expr: implementation_status
      comment: "Current implementation status of the review recommendations"
    - name: "review_month"
      expr: DATE_TRUNC('month', review_date)
      comment: "Month of the engineering review"
  measures:
    - name: "count_engineering_reviews"
      expr: COUNT(1)
      comment: "Total number of engineering review records"
    - name: "avg_menu_complexity_score_before"
      expr: AVG(CAST(menu_complexity_score_before AS DOUBLE))
      comment: "Average menu complexity score before engineering changes"
    - name: "avg_menu_complexity_score_after"
      expr: AVG(CAST(menu_complexity_score_after AS DOUBLE))
      comment: "Average menu complexity score after engineering changes"
    - name: "avg_contribution_margin"
      expr: AVG(CAST(avg_contribution_margin AS DOUBLE))
      comment: "Average contribution margin across reviewed items"
    - name: "avg_popularity_index"
      expr: AVG(CAST(avg_menu_item_popularity_index AS DOUBLE))
      comment: "Average menu item popularity index"
$$;