-- Metric views for domain: advertising | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-22 23:42:33

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`advertising_ad_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core advertising inventory performance metrics tracking availability, pricing efficiency, sell-through rates, and programmatic win rates. Enables revenue operations and yield management decisions across inventory types, dayparts, and channels."
  source: "`vibe_media_broadcasting_v1`.`advertising`.`ad_inventory`"
  dimensions:
    - name: "inventory_type"
      expr: inventory_type
      comment: "Type of ad inventory (e.g. pre-roll, mid-roll, display, sponsorship) for segmenting yield and pricing analysis."
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of the inventory unit (available, sold, held, reserved) for sell-through and availability reporting."
    - name: "deal_type"
      expr: deal_type
      comment: "Commercial deal type (programmatic guaranteed, preferred deal, open auction, direct) for revenue mix analysis."
    - name: "auction_type"
      expr: auction_type
      comment: "Auction mechanism (first-price, second-price, fixed) for pricing strategy evaluation."
    - name: "sales_category"
      expr: sales_category
      comment: "Sales category classification for inventory segmentation and revenue attribution."
    - name: "pricing_tier"
      expr: pricing_tier
      comment: "Pricing tier assigned to inventory for premium vs. standard yield comparison."
    - name: "content_rating"
      expr: content_rating
      comment: "Content rating of the surrounding program (G, PG, TV-14, etc.) for brand-safety and advertiser restriction analysis."
    - name: "private_marketplace_flag"
      expr: private_marketplace_flag
      comment: "Indicates whether inventory is transacted via a private marketplace deal, enabling PMP vs. open-market performance split."
    - name: "header_bidding_enabled_flag"
      expr: header_bidding_enabled_flag
      comment: "Indicates whether header bidding is enabled for this inventory unit, for header-bidding yield lift analysis."
    - name: "preemptible"
      expr: preemptible
      comment: "Whether the inventory unit can be preempted by higher-priority buys, relevant for revenue risk and makegood forecasting."
    - name: "makegood_eligible"
      expr: makegood_eligible
      comment: "Whether the inventory unit qualifies for makegood replacement if underdelivered, for liability exposure tracking."
    - name: "inventory_date"
      expr: DATE_TRUNC('day', inventory_date)
      comment: "Calendar date of the inventory unit for daily sell-through and revenue trending."
    - name: "inventory_month"
      expr: DATE_TRUNC('month', inventory_date)
      comment: "Month of inventory for monthly yield and revenue pacing dashboards."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the inventory rate became effective, for rate card version and pricing trend analysis."
  measures:
    - name: "total_inventory_units"
      expr: COUNT(1)
      comment: "Total number of ad inventory units. Baseline volume metric for capacity planning and sell-through rate calculation."
    - name: "total_estimated_impressions"
      expr: SUM(CAST(estimated_impressions AS DOUBLE))
      comment: "Sum of estimated impressions across all inventory units. Core audience delivery metric used in upfront and scatter planning."
    - name: "total_estimated_reach"
      expr: SUM(CAST(estimated_reach AS DOUBLE))
      comment: "Sum of estimated unique reach across inventory units. Used for audience guarantee commitments and campaign planning."
    - name: "avg_bid_floor_cpm"
      expr: AVG(CAST(bid_floor_cpm AS DOUBLE))
      comment: "Average bid floor CPM across inventory. Indicates pricing floor strategy and competitiveness in programmatic auctions."
    - name: "avg_clearing_price_cpm"
      expr: AVG(CAST(clearing_price_cpm AS DOUBLE))
      comment: "Average CPM at which inventory actually clears in auction. Key yield management KPI — gap vs. rate card CPM reveals pricing efficiency."
    - name: "avg_rate_card_cpm"
      expr: AVG(CAST(rate_card_cpm AS DOUBLE))
      comment: "Average published rate card CPM. Benchmark for evaluating actual clearing price vs. stated pricing."
    - name: "avg_rate_card_cprp"
      expr: AVG(CAST(rate_card_cprp AS DOUBLE))
      comment: "Average cost per rating point from the rate card. Used in GRP-based upfront deal valuation and audience guarantee pricing."
    - name: "total_estimated_grp"
      expr: SUM(CAST(estimated_grp AS DOUBLE))
      comment: "Total estimated gross rating points across inventory. Core linear TV currency for upfront and scatter deal valuation."
    - name: "total_estimated_trp"
      expr: SUM(CAST(estimated_trp AS DOUBLE))
      comment: "Total estimated target rating points across inventory. Demographic-specific delivery metric for targeted advertising commitments."
    - name: "avg_win_rate"
      expr: AVG(CAST(win_rate AS DOUBLE))
      comment: "Average programmatic auction win rate across inventory units. Measures competitiveness of bid floors and demand-side pressure."
    - name: "avg_hut_index"
      expr: AVG(CAST(hut_index AS DOUBLE))
      comment: "Average Households Using Television index. Indicates audience availability during inventory windows for daypart yield optimization."
    - name: "avg_put_index"
      expr: AVG(CAST(put_index AS DOUBLE))
      comment: "Average Persons Using Television index. Complements HUT for demographic-level audience availability assessment."
    - name: "pmp_inventory_units"
      expr: COUNT(CASE WHEN private_marketplace_flag = TRUE THEN 1 END)
      comment: "Count of inventory units transacted via private marketplace deals. Tracks PMP adoption as a premium programmatic revenue strategy."
    - name: "header_bidding_inventory_units"
      expr: COUNT(CASE WHEN header_bidding_enabled_flag = TRUE THEN 1 END)
      comment: "Count of inventory units with header bidding enabled. Measures header bidding rollout and its contribution to yield improvement."
    - name: "preemptible_inventory_units"
      expr: COUNT(CASE WHEN preemptible = TRUE THEN 1 END)
      comment: "Count of preemptible inventory units. Quantifies revenue-at-risk from higher-priority preemptions and makegood liability."
    - name: "clearing_price_vs_floor_premium"
      expr: AVG(CAST(clearing_price_cpm AS DOUBLE) - CAST(bid_floor_cpm AS DOUBLE))
      comment: "Average premium (in CPM) that clearing price exceeds the bid floor. Positive values indicate strong demand; negative values signal floor miscalibration."
    - name: "clearing_price_vs_rate_card_delta"
      expr: AVG(CAST(clearing_price_cpm AS DOUBLE) - CAST(rate_card_cpm AS DOUBLE))
      comment: "Average difference between actual clearing CPM and published rate card CPM. Negative values indicate rate card is above market; positive values indicate demand exceeding expectations."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`advertising_rate_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate card pricing analytics for advertising sales strategy. Tracks CPM/CPRP pricing levels, seasonal factors, win rates, and programmatic pricing configuration across inventory types, dayparts, and markets. Informs upfront and scatter pricing decisions."
  source: "`vibe_media_broadcasting_v1`.`advertising`.`rate_card`"
  dimensions:
    - name: "inventory_type"
      expr: inventory_type
      comment: "Type of ad inventory the rate card applies to (pre-roll, mid-roll, sponsorship, etc.) for pricing tier analysis."
    - name: "rate_type"
      expr: rate_type
      comment: "Rate basis type (CPM, CPRP, flat, GRP) for comparing pricing methodologies across deal structures."
    - name: "deal_type"
      expr: deal_type
      comment: "Deal type the rate card governs (programmatic guaranteed, preferred deal, direct) for revenue mix pricing analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart the rate card applies to (prime, late night, daytime) for daypart-level pricing strategy review."
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market (DMA, national, regional) for market-level pricing comparison and competitive positioning."
    - name: "program_genre"
      expr: program_genre
      comment: "Genre of programming the rate card is associated with for genre-based pricing premium analysis."
    - name: "rate_card_status"
      expr: rate_card_status
      comment: "Approval/lifecycle status of the rate card (draft, approved, expired) for governance and active pricing tracking."
    - name: "auction_type"
      expr: auction_type
      comment: "Auction mechanism (first-price, second-price, fixed) for programmatic pricing strategy segmentation."
    - name: "private_marketplace_flag"
      expr: private_marketplace_flag
      comment: "Whether the rate card applies to private marketplace deals, for PMP vs. open-market pricing comparison."
    - name: "header_bidding_enabled_flag"
      expr: header_bidding_enabled_flag
      comment: "Whether header bidding is enabled under this rate card, for header-bidding yield impact analysis."
    - name: "rate_currency_code"
      expr: rate_currency_code
      comment: "Currency of the rate card for multi-currency pricing governance and FX normalization."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the rate card became effective for seasonal pricing trend analysis."
    - name: "effective_end_month"
      expr: DATE_TRUNC('month', effective_end_date)
      comment: "Month the rate card expires for rate card lifecycle and renewal planning."
  measures:
    - name: "total_rate_cards"
      expr: COUNT(1)
      comment: "Total number of rate card records. Baseline for rate card portfolio size and governance coverage."
    - name: "avg_gross_rate"
      expr: AVG(CAST(gross_rate AS DOUBLE))
      comment: "Average gross rate across rate cards. Top-line pricing benchmark before agency commissions and discounts."
    - name: "avg_net_rate"
      expr: AVG(CAST(net_rate AS DOUBLE))
      comment: "Average net rate after agency commissions. Reflects actual revenue yield per rate card for profitability analysis."
    - name: "avg_cpm_basis"
      expr: AVG(CAST(cpm_basis AS DOUBLE))
      comment: "Average CPM basis used for rate card pricing. Core programmatic pricing benchmark for yield management."
    - name: "avg_bid_floor_cpm"
      expr: AVG(CAST(bid_floor_cpm AS DOUBLE))
      comment: "Average programmatic bid floor CPM across rate cards. Determines minimum acceptable clearing price in auctions."
    - name: "avg_clearing_price_cpm"
      expr: AVG(CAST(clearing_price_cpm AS DOUBLE))
      comment: "Average actual clearing CPM across rate cards. Measures realized programmatic yield vs. floor and gross rate."
    - name: "avg_grp_value"
      expr: AVG(CAST(grp_value AS DOUBLE))
      comment: "Average GRP value assigned in rate cards. Used for linear TV upfront deal valuation and audience currency pricing."
    - name: "avg_trp_value"
      expr: AVG(CAST(trp_value AS DOUBLE))
      comment: "Average TRP value in rate cards. Demographic-targeted pricing metric for audience-guaranteed deal structures."
    - name: "avg_seasonality_factor"
      expr: AVG(CAST(seasonality_factor AS DOUBLE))
      comment: "Average seasonality adjustment factor across rate cards. Quantifies pricing uplift/discount applied for seasonal demand cycles (Q4 uplifts, summer softness)."
    - name: "avg_win_rate"
      expr: AVG(CAST(win_rate AS DOUBLE))
      comment: "Average programmatic auction win rate associated with rate cards. Indicates whether floor pricing is calibrated to market demand."
    - name: "gross_to_net_rate_spread"
      expr: AVG(CAST(gross_rate AS DOUBLE) - CAST(net_rate AS DOUBLE))
      comment: "Average spread between gross and net rates. Quantifies agency commission and discount burden on advertising revenue."
    - name: "clearing_price_to_floor_premium"
      expr: AVG(CAST(clearing_price_cpm AS DOUBLE) - CAST(bid_floor_cpm AS DOUBLE))
      comment: "Average CPM premium above bid floor at which inventory clears. Positive values confirm floor is set below market; negative values signal floor is too high."
    - name: "approved_rate_cards"
      expr: COUNT(CASE WHEN rate_card_status = 'approved' THEN 1 END)
      comment: "Count of currently approved rate cards. Governance metric ensuring active pricing is formally sanctioned before sales use."
$$;