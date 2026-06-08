-- Metric views for domain: advertising | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 17:09:06

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`advertising_ad_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key advertising inventory metrics for planning and performance."
  source: "`media_broadcasting_ecm`.`advertising`.`ad_inventory`"
  dimensions:
    - name: "inventory_type"
      expr: inventory_type
      comment: "Type of advertising inventory (e.g., spot, sponsorship)."
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of the inventory (e.g., booked, available)."
    - name: "channel_id"
      expr: channel_id
      comment: "Identifier of the broadcast channel."
    - name: "demographic_segment_id"
      expr: demographic_segment_id
      comment: "Target demographic segment identifier."
    - name: "inventory_month"
      expr: DATE_TRUNC('month', inventory_date)
      comment: "Month of the inventory date for time‑based analysis."
  measures:
    - name: "inventory_count"
      expr: COUNT(1)
      comment: "Number of inventory records."
    - name: "total_estimated_impressions"
      expr: SUM(CAST(estimated_impressions AS DOUBLE))
      comment: "Total estimated impressions across inventory."
    - name: "total_estimated_reach"
      expr: SUM(CAST(estimated_reach AS DOUBLE))
      comment: "Total estimated unique reach."
    - name: "avg_estimated_grp"
      expr: AVG(CAST(estimated_grp AS DOUBLE))
      comment: "Average Gross Rating Point (GRP) estimate."
    - name: "avg_rate_card_cpm"
      expr: AVG(CAST(rate_card_cpm AS DOUBLE))
      comment: "Average CPM from the associated rate card (as stored on inventory)."
    - name: "total_hut_index"
      expr: SUM(CAST(hut_index AS DOUBLE))
      comment: "Sum of HUT index values for inventory."
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`advertising_rate_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate‑card performance and pricing metrics for revenue planning."
  source: "`media_broadcasting_ecm`.`advertising`.`rate_card`"
  dimensions:
    - name: "inventory_type"
      expr: inventory_type
      comment: "Inventory type the rate card applies to."
    - name: "rate_card_status"
      expr: rate_card_status
      comment: "Current status of the rate card (e.g., active, retired)."
    - name: "channel_id"
      expr: channel_id
      comment: "Broadcast channel identifier linked to the rate card."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when the rate card becomes effective."
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market scope of the rate card."
  measures:
    - name: "rate_card_count"
      expr: COUNT(1)
      comment: "Number of rate cards."
    - name: "total_gross_rate"
      expr: SUM(CAST(gross_rate AS DOUBLE))
      comment: "Total gross rate across all rate cards."
    - name: "avg_net_rate"
      expr: AVG(CAST(net_rate AS DOUBLE))
      comment: "Average net rate after discounts and make‑good adjustments."
    - name: "avg_cpm_basis"
      expr: AVG(CAST(cpm_basis AS DOUBLE))
      comment: "Average CPM basis used for pricing."
    - name: "avg_seasonality_factor"
      expr: AVG(CAST(seasonality_factor AS DOUBLE))
      comment: "Average seasonality factor applied to rates."
    - name: "avg_trp_value"
      expr: AVG(CAST(trp_value AS DOUBLE))
      comment: "Average TRP (Target Rating Point) value."
$$;