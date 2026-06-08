-- Metric views for domain: product | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 09:03:30

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core SKU financial and safety KPIs for executive oversight"
  source: "`consumer_goods_ecm`.`product`.`sku`"
  dimensions:
    - name: "brand_id"
      expr: brand_id
      comment: "Brand identifier"
    - name: "product_category_id"
      expr: product_category_id
      comment: "Product category identifier"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the product is manufactured"
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating hazardous product"
    - name: "is_recyclable_packaging"
      expr: is_recyclable_packaging
      comment: "Flag for recyclable packaging"
    - name: "launch_year"
      expr: DATE_TRUNC('year', launch_date)
      comment: "Launch year of the SKU"
  measures:
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Sum of standard cost across SKUs"
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight of SKUs (kg)"
    - name: "count_skus"
      expr: COUNT(1)
      comment: "Total number of SKUs"
    - name: "count_hazardous_skus"
      expr: SUM(CASE WHEN is_hazardous THEN 1 ELSE 0 END)
      comment: "Number of SKUs flagged as hazardous"
    - name: "avg_net_content"
      expr: AVG(CAST(net_content AS DOUBLE))
      comment: "Average net content amount across SKUs"
    - name: "total_msrp"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total MSRP value across SKUs"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`product_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "BOM line cost and quality KPIs to drive manufacturing efficiency"
  source: "`consumer_goods_ecm`.`product`.`bom_line`"
  dimensions:
    - name: "product_bom_id"
      expr: product_bom_id
      comment: "Identifier of the product BOM"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU associated with the BOM line"
    - name: "component_type"
      expr: component_type
      comment: "Type of component"
    - name: "bulk_material_flag"
      expr: bulk_material_flag
      comment: "Flag indicating bulk material"
    - name: "is_critical_component"
      expr: is_critical_component
      comment: "Critical component flag"
    - name: "line_status"
      expr: line_status
      comment: "Status of the BOM line"
  measures:
    - name: "total_component_cost_usd"
      expr: SUM(CAST(component_cost_usd AS DOUBLE))
      comment: "Total cost of components in USD for the BOM line"
    - name: "avg_required_quantity"
      expr: AVG(CAST(required_quantity AS DOUBLE))
      comment: "Average required quantity per component"
    - name: "count_critical_components"
      expr: SUM(CASE WHEN is_critical_component THEN 1 ELSE 0 END)
      comment: "Number of critical components in the BOM line"
    - name: "avg_scrap_percentage"
      expr: AVG(CAST(scrap_percentage AS DOUBLE))
      comment: "Average scrap percentage for components"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`product_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certification coverage and cost KPIs for compliance and market strategy"
  source: "`consumer_goods_ecm`.`product`.`certification`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification"
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of certification"
    - name: "consumer_facing_flag"
      expr: consumer_facing_flag
      comment: "Indicates if certification is consumer facing"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the certification became effective"
  measures:
    - name: "count_certifications"
      expr: COUNT(1)
      comment: "Total number of certification records"
    - name: "count_active_certifications"
      expr: SUM(CASE WHEN certification_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of active certifications"
    - name: "avg_cost_amount"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost amount of certifications"
    - name: "count_consumer_facing"
      expr: SUM(CASE WHEN consumer_facing_flag THEN 1 ELSE 0 END)
      comment: "Number of consumer‑facing certifications"
$$;