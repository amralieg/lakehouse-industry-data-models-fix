-- Metric views for domain: promotion | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 10:59:38

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`promotion_trade_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over trade promotions — tracks planned vs. actual spend efficiency, ROI expectations, volume targets, and promotion portfolio health for executive trade investment decisions."
  source: "`consumer_goods_ecm`.`promotion`.`trade_promotion`"
  dimensions:
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of trade promotion (e.g., TPR, display, feature ad) used to segment spend and ROI by tactic."
    - name: "promotion_status"
      expr: promotion_status
      comment: "Current lifecycle status of the promotion (e.g., planned, active, settled, cancelled) for pipeline visibility."
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel (e.g., grocery, mass, e-commerce) to analyze trade investment by go-to-market channel."
    - name: "funding_type"
      expr: funding_type
      comment: "Source of promotion funding (e.g., manufacturer, co-op, retailer) to track funding mix and accountability."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement state of the promotion (e.g., open, settled, disputed) for financial close tracking."
    - name: "country_code"
      expr: country_code
      comment: "Country where the promotion is executed for geographic performance segmentation."
    - name: "promotion_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the promotion starts, used for time-series trending of trade investment."
    - name: "promotion_end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the promotion ends, used for cohort analysis of promotion duration and timing."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy applied (e.g., EDLP, Hi-Lo) to evaluate trade spend alignment with pricing architecture."
    - name: "display_type"
      expr: display_type
      comment: "In-store display type associated with the promotion for compliance and effectiveness analysis."
    - name: "feature_ad_flag"
      expr: feature_ad_flag
      comment: "Indicates whether the promotion includes a feature advertisement, used to isolate ad-supported lift."
    - name: "coupon_flag"
      expr: coupon_flag
      comment: "Indicates whether the promotion includes a coupon mechanic for coupon-specific ROI analysis."
  measures:
    - name: "total_authorized_budget"
      expr: SUM(CAST(authorized_budget_amount AS DOUBLE))
      comment: "Total authorized trade promotion budget across selected promotions — primary measure of trade investment commitment."
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrued trade spend liability — tracks financial exposure from active and pending promotions."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deduction amount claimed against promotions — key input for trade spend reconciliation and P&L impact."
    - name: "total_target_volume_units"
      expr: SUM(CAST(target_volume_units AS DOUBLE))
      comment: "Total planned volume units across promotions — baseline for measuring volume delivery against plan."
    - name: "total_baseline_volume_units"
      expr: SUM(CAST(baseline_volume_units AS DOUBLE))
      comment: "Total baseline (non-promoted) volume units used to calculate incremental lift from trade promotions."
    - name: "avg_expected_roi_percentage"
      expr: AVG(CAST(expected_roi_percentage AS DOUBLE))
      comment: "Average expected ROI percentage across promotions — used to evaluate portfolio-level return expectations before execution."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount depth across promotions — monitors price reduction intensity and its relationship to volume lift."
    - name: "promotion_count"
      expr: COUNT(DISTINCT trade_promotion_id)
      comment: "Count of distinct trade promotions — measures the breadth of the active promotion portfolio."
    - name: "settled_promotion_count"
      expr: COUNT(DISTINCT CASE WHEN settlement_status = 'Settled' THEN trade_promotion_id END)
      comment: "Count of promotions with settled status — tracks financial close rate and settlement backlog."
    - name: "cancelled_promotion_count"
      expr: COUNT(DISTINCT CASE WHEN promotion_status = 'Cancelled' THEN trade_promotion_id END)
      comment: "Count of cancelled promotions — signals execution risk and planning quality issues."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`promotion_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPI layer over promotion events — measures actual vs. planned trade spend, volume delivery, promotional lift, ROI, and GMROI at the event level for in-flight and post-event performance management."
  source: "`consumer_goods_ecm`.`promotion`.`event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of promotional event (e.g., TPR, display, feature) to segment performance by tactic."
    - name: "event_status"
      expr: event_status
      comment: "Lifecycle status of the event (e.g., planned, active, completed, cancelled) for pipeline and execution tracking."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Financial settlement state of the event for trade spend close tracking."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of event funding (e.g., manufacturer, co-op) to track funding accountability."
    - name: "geography_code"
      expr: geography_code
      comment: "Geographic market where the event runs for regional performance analysis."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy applied during the event for strategy-level ROI benchmarking."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the event starts for time-series trending of event-level trade investment."
    - name: "post_event_analysis_completed_flag"
      expr: post_event_analysis_completed_flag
      comment: "Indicates whether post-event analysis has been completed — used to track analytical coverage of the event portfolio."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of event financials for multi-currency portfolio analysis."
  measures:
    - name: "total_actual_trade_spend"
      expr: SUM(CAST(actual_trade_spend_amount AS DOUBLE))
      comment: "Total actual trade spend incurred across events — primary measure of realized trade investment."
    - name: "total_planned_trade_spend"
      expr: SUM(CAST(planned_trade_spend_amount AS DOUBLE))
      comment: "Total planned trade spend across events — baseline for spend variance and budget adherence analysis."
    - name: "total_trade_spend_variance"
      expr: SUM(CAST(actual_trade_spend_amount AS DOUBLE) - CAST(planned_trade_spend_amount AS DOUBLE))
      comment: "Total variance between actual and planned trade spend — negative values indicate underspend; positive values indicate overspend."
    - name: "total_actual_volume_units"
      expr: SUM(CAST(actual_volume_units AS DOUBLE))
      comment: "Total actual volume units sold during promoted events — measures volume delivery against plan."
    - name: "total_planned_volume_units"
      expr: SUM(CAST(planned_volume_units AS DOUBLE))
      comment: "Total planned volume units for events — denominator for volume attainment rate calculation."
    - name: "total_baseline_volume_units"
      expr: SUM(CAST(baseline_volume_units AS DOUBLE))
      comment: "Total baseline (non-promoted) volume units across events — used to compute incremental lift."
    - name: "total_incremental_volume_units"
      expr: SUM(CAST(actual_volume_units AS DOUBLE) - CAST(baseline_volume_units AS DOUBLE))
      comment: "Total incremental volume units generated by promotions (actual minus baseline) — core measure of promotional effectiveness."
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrued trade liability across events — tracks financial exposure for accounting close."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deduction amount across events — key input for deduction management and P&L reconciliation."
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate amounts paid across events — tracks rebate liability and funding mix."
    - name: "avg_promotional_lift_percentage"
      expr: AVG(CAST(promotional_lift_percentage AS DOUBLE))
      comment: "Average promotional lift percentage across events — headline KPI for promotion effectiveness benchmarking."
    - name: "avg_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average ROI percentage across events — primary measure for evaluating trade investment returns."
    - name: "avg_gmroi_ratio"
      expr: AVG(CAST(gmroi_ratio AS DOUBLE))
      comment: "Average Gross Margin Return on Investment ratio across events — measures retailer profitability of promoted inventory."
    - name: "event_count"
      expr: COUNT(DISTINCT event_id)
      comment: "Count of distinct promotion events — measures the scale and breadth of promotional activity."
    - name: "post_event_analysis_completion_count"
      expr: COUNT(DISTINCT CASE WHEN post_event_analysis_completed_flag = TRUE THEN event_id END)
      comment: "Count of events with completed post-event analysis — tracks analytical coverage and learning capture rate."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`promotion_event_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SKU-level promotional performance KPI layer — measures promoted price depth, volume lift, trade spend efficiency, and ROI at the individual SKU-event level to guide assortment and tactic decisions."
  source: "`consumer_goods_ecm`.`promotion`.`event_sku`"
  dimensions:
    - name: "feature_type"
      expr: feature_type
      comment: "Type of feature mechanic applied to the SKU (e.g., end-cap, in-ad feature) for tactic-level analysis."
    - name: "display_location_type"
      expr: display_location_type
      comment: "In-store display location type for the SKU (e.g., end-cap, secondary display) to evaluate display placement effectiveness."
    - name: "promoted_price_type"
      expr: promoted_price_type
      comment: "Type of promoted price mechanic (e.g., TPR, BOGO, multi-buy) for tactic-level ROI benchmarking."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement state of the SKU-level event for financial close tracking."
    - name: "pricing_approval_status"
      expr: pricing_approval_status
      comment: "Approval status of the promoted price for compliance and governance monitoring."
    - name: "compliance_check_status"
      expr: compliance_check_status
      comment: "Compliance verification status for the SKU promotion — used to track regulatory and contractual adherence."
    - name: "is_featured_sku"
      expr: is_featured_sku
      comment: "Indicates whether the SKU is a featured item in the promotion — used to isolate featured vs. non-featured SKU performance."
    - name: "promotion_effective_start_month"
      expr: DATE_TRUNC('MONTH', promotion_effective_start_date)
      comment: "Month the SKU promotion becomes effective for time-series trending of SKU-level trade investment."
  measures:
    - name: "total_trade_spend"
      expr: SUM(CAST(total_trade_spend_amount AS DOUBLE))
      comment: "Total trade spend at the SKU-event level — primary measure of SKU-level trade investment."
    - name: "total_actual_promotional_volume_units"
      expr: SUM(CAST(actual_promotional_volume_units AS DOUBLE))
      comment: "Total actual promotional volume units sold at SKU level — measures volume delivery per SKU during promotions."
    - name: "total_planned_promotional_volume_units"
      expr: SUM(CAST(planned_promotional_volume_units AS DOUBLE))
      comment: "Total planned promotional volume units at SKU level — denominator for SKU volume attainment rate."
    - name: "total_actual_promotional_volume_cases"
      expr: SUM(CAST(actual_promotional_volume_cases AS DOUBLE))
      comment: "Total actual promotional volume in cases at SKU level — used for supply chain and logistics planning."
    - name: "total_incremental_lift_volume_units"
      expr: SUM(CAST(incremental_lift_volume_units AS DOUBLE))
      comment: "Total incremental volume units generated above baseline at SKU level — core measure of SKU-level promotional effectiveness."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deduction amount at SKU-event level — tracks deduction liability per SKU for reconciliation."
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate amount at SKU-event level — tracks rebate funding per SKU."
    - name: "avg_price_reduction_depth_percent"
      expr: AVG(CAST(price_reduction_depth_percent AS DOUBLE))
      comment: "Average price reduction depth percentage across SKU promotions — monitors discount intensity and its relationship to volume lift."
    - name: "avg_incremental_lift_percent"
      expr: AVG(CAST(incremental_lift_percent AS DOUBLE))
      comment: "Average incremental lift percentage at SKU level — benchmarks promotional effectiveness across SKUs and tactics."
    - name: "avg_promotional_roi_percent"
      expr: AVG(CAST(promotional_roi_percent AS DOUBLE))
      comment: "Average promotional ROI percentage at SKU level — primary measure for evaluating SKU-level trade investment returns."
    - name: "avg_promotional_gmroi"
      expr: AVG(CAST(promotional_gmroi AS DOUBLE))
      comment: "Average promotional GMROI at SKU level — measures gross margin return on promoted inventory investment per SKU."
    - name: "avg_promotional_discount_per_unit"
      expr: AVG(CAST(promotional_discount_per_unit AS DOUBLE))
      comment: "Average promotional discount per unit — used to assess per-unit trade investment and margin impact."
    - name: "promoted_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs promoted — measures the breadth of the promoted assortment."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`promotion_post_event_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post-event analysis KPI layer — measures realized promotional ROI, GMROI, incremental lift, trade spend variance, compliance, and sell-through to drive continuous improvement in trade promotion planning."
  source: "`consumer_goods_ecm`.`promotion`.`post_event_analysis`"
  dimensions:
    - name: "analysis_status"
      expr: analysis_status
      comment: "Status of the post-event analysis (e.g., draft, approved, final) for governance and completeness tracking."
    - name: "learning_classification"
      expr: learning_classification
      comment: "Classification of the key learning from the event (e.g., winner, loser, neutral) for portfolio optimization."
    - name: "baseline_estimation_methodology"
      expr: baseline_estimation_methodology
      comment: "Methodology used to estimate baseline volume — used to assess analytical rigor and comparability across analyses."
    - name: "lift_measurement_methodology"
      expr: lift_measurement_methodology
      comment: "Methodology used to measure promotional lift — used to ensure consistency and comparability of lift estimates."
    - name: "display_compliance_flag"
      expr: display_compliance_flag
      comment: "Indicates whether display compliance was achieved — used to correlate compliance with lift outcomes."
    - name: "feature_compliance_flag"
      expr: feature_compliance_flag
      comment: "Indicates whether feature ad compliance was achieved — used to isolate the impact of feature execution on lift."
    - name: "pricing_compliance_flag"
      expr: pricing_compliance_flag
      comment: "Indicates whether pricing compliance was achieved — used to assess the impact of price execution on ROI."
    - name: "analysis_period_start_month"
      expr: DATE_TRUNC('MONTH', analysis_period_start_date)
      comment: "Month the analysis period starts for time-series trending of post-event learnings."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the analysis financials for multi-currency portfolio analysis."
  measures:
    - name: "avg_promotional_roi"
      expr: AVG(CAST(promotional_roi AS DOUBLE))
      comment: "Average promotional ROI across analyzed events — headline KPI for evaluating realized trade investment returns."
    - name: "avg_gmroi"
      expr: AVG(CAST(gmroi AS DOUBLE))
      comment: "Average GMROI across analyzed events — measures gross margin return on promoted inventory investment."
    - name: "avg_incremental_lift_percentage"
      expr: AVG(CAST(incremental_lift_percentage AS DOUBLE))
      comment: "Average incremental lift percentage across analyzed events — primary measure of promotional volume effectiveness."
    - name: "total_incremental_lift_units"
      expr: SUM(CAST(incremental_lift_units AS DOUBLE))
      comment: "Total incremental volume units generated above baseline across analyzed events — measures absolute promotional volume impact."
    - name: "total_actual_trade_spend"
      expr: SUM(CAST(actual_trade_spend_amount AS DOUBLE))
      comment: "Total actual trade spend across analyzed events — realized trade investment for ROI denominator analysis."
    - name: "total_planned_trade_spend"
      expr: SUM(CAST(planned_trade_spend_amount AS DOUBLE))
      comment: "Total planned trade spend across analyzed events — baseline for spend variance analysis."
    - name: "total_trade_spend_variance"
      expr: SUM(CAST(trade_spend_variance_amount AS DOUBLE))
      comment: "Total variance between actual and planned trade spend — measures budget discipline and planning accuracy."
    - name: "avg_sell_through_rate"
      expr: AVG(CAST(sell_through_rate AS DOUBLE))
      comment: "Average sell-through rate across analyzed events — measures inventory efficiency during promotions."
    - name: "avg_retailer_compliance_score"
      expr: AVG(CAST(retailer_compliance_score AS DOUBLE))
      comment: "Average retailer compliance score across analyzed events — measures execution quality and its correlation with ROI."
    - name: "avg_cost_per_incremental_case"
      expr: AVG(CAST(cost_per_incremental_case AS DOUBLE))
      comment: "Average cost per incremental case across analyzed events — efficiency KPI for comparing trade investment productivity across tactics."
    - name: "total_oos_impact_estimated_units"
      expr: SUM(CAST(oos_impact_estimated_units AS DOUBLE))
      comment: "Total estimated volume units lost to out-of-stock events during promotions — measures supply chain execution risk on promotional ROI."
    - name: "analyzed_event_count"
      expr: COUNT(DISTINCT event_id)
      comment: "Count of distinct events with completed post-event analysis — measures analytical coverage of the promotion portfolio."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`promotion_lift_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical lift measurement KPI layer — tracks incremental volume, revenue lift, cannibalization, halo effects, and measurement confidence to validate promotional effectiveness with statistical rigor."
  source: "`consumer_goods_ecm`.`promotion`.`lift_measurement`"
  dimensions:
    - name: "measurement_methodology"
      expr: measurement_methodology
      comment: "Methodology used to measure lift (e.g., matched market, control group, syndicated) for comparability and rigor assessment."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the lift measurement (e.g., preliminary, validated, final) for data quality governance."
    - name: "lift_source"
      expr: lift_source
      comment: "Source of lift data (e.g., POS, panel, TPM system) to assess data provenance and reliability."
    - name: "baseline_calculation_method"
      expr: baseline_calculation_method
      comment: "Method used to calculate the baseline volume for lift measurement — used to ensure methodological consistency."
    - name: "statistical_significance_flag"
      expr: statistical_significance_flag
      comment: "Indicates whether the measured lift is statistically significant — critical filter for valid ROI conclusions."
    - name: "measurement_week_start_month"
      expr: DATE_TRUNC('MONTH', measurement_week_start_date)
      comment: "Month of the measurement week start for time-series trending of lift performance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of lift revenue measures for multi-currency analysis."
  measures:
    - name: "total_incremental_lift_units"
      expr: SUM(CAST(incremental_lift_units AS DOUBLE))
      comment: "Total incremental volume units generated above baseline — primary measure of promotional volume effectiveness."
    - name: "total_incremental_revenue"
      expr: SUM(CAST(incremental_revenue AS DOUBLE))
      comment: "Total incremental revenue generated by promotions above baseline — measures the revenue value of trade investment."
    - name: "total_actual_promoted_volume_units"
      expr: SUM(CAST(actual_promoted_volume_units AS DOUBLE))
      comment: "Total actual volume units sold during the promoted period — gross volume measure for lift rate calculation."
    - name: "total_baseline_volume_units"
      expr: SUM(CAST(baseline_volume_units AS DOUBLE))
      comment: "Total baseline volume units used as the counterfactual for lift measurement."
    - name: "avg_incremental_lift_percentage"
      expr: AVG(CAST(incremental_lift_percentage AS DOUBLE))
      comment: "Average incremental lift percentage across measurements — headline KPI for promotional effectiveness benchmarking."
    - name: "total_cannibalization_rate_sum"
      expr: SUM(CAST(cannibalization_rate AS DOUBLE))
      comment: "Sum of cannibalization rates across measurements — used to assess the net portfolio impact of promotions on non-promoted SKUs."
    - name: "total_halo_effect_units"
      expr: SUM(CAST(halo_effect_units AS DOUBLE))
      comment: "Total halo effect volume units (lift on non-promoted adjacent SKUs) — measures the broader portfolio benefit of promotions."
    - name: "total_post_promotion_dip_units"
      expr: SUM(CAST(post_promotion_dip_units AS DOUBLE))
      comment: "Total post-promotion volume dip units — measures demand pull-forward and pantry-loading effects that reduce net incremental lift."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across lift measurements — used to model the price elasticity and discount-to-lift relationship."
    - name: "statistically_significant_measurement_count"
      expr: COUNT(DISTINCT CASE WHEN statistical_significance_flag = TRUE THEN lift_measurement_id END)
      comment: "Count of lift measurements with statistical significance — measures the proportion of actionable, validated lift data."
    - name: "total_measurement_count"
      expr: COUNT(DISTINCT lift_measurement_id)
      comment: "Total count of lift measurements — denominator for statistical significance rate and analytical coverage metrics."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`promotion_deduction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deduction management KPI layer — tracks deduction volumes, dispute rates, settlement efficiency, and financial impact to minimize invalid deductions and accelerate trade spend reconciliation."
  source: "`consumer_goods_ecm`.`promotion`.`deduction`"
  dimensions:
    - name: "deduction_type"
      expr: deduction_type
      comment: "Type of deduction (e.g., promotional, shortage, pricing) to segment deduction liability by root cause."
    - name: "deduction_source"
      expr: deduction_source
      comment: "Source system or channel originating the deduction for root cause and process improvement analysis."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current dispute status of the deduction (e.g., open, resolved, escalated) for dispute backlog management."
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method used to settle the deduction (e.g., credit memo, check, offset) for process efficiency analysis."
    - name: "settlement_reason_code"
      expr: settlement_reason_code
      comment: "Reason code for deduction settlement — used to classify valid vs. invalid deductions and track approval patterns."
    - name: "business_unit_code"
      expr: business_unit_code
      comment: "Business unit associated with the deduction for organizational accountability and P&L attribution."
    - name: "product_category_code"
      expr: product_category_code
      comment: "Product category associated with the deduction for category-level deduction analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the deduction for workload management and SLA compliance tracking."
    - name: "deduction_date_month"
      expr: DATE_TRUNC('MONTH', deduction_date)
      comment: "Month the deduction was recorded for time-series trending of deduction volumes and amounts."
    - name: "accrual_impact_flag"
      expr: accrual_impact_flag
      comment: "Indicates whether the deduction has an accrual impact — used to assess P&L exposure from open deductions."
  measures:
    - name: "total_deduction_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross deduction amount claimed — primary measure of trade deduction liability and P&L exposure."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved deduction amount — measures the validated trade liability after review."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total disputed deduction amount — measures the financial exposure from contested deductions requiring resolution."
    - name: "total_settled_amount"
      expr: SUM(CAST(settled_amount AS DOUBLE))
      comment: "Total settled deduction amount — measures the resolved trade liability and cash flow impact."
    - name: "total_roi_impact_amount"
      expr: SUM(CAST(roi_impact_amount AS DOUBLE))
      comment: "Total ROI impact amount from deductions — measures the net effect of deductions on promotional return calculations."
    - name: "avg_gmroi_impact_percentage"
      expr: AVG(CAST(gmroi_impact_percentage AS DOUBLE))
      comment: "Average GMROI impact percentage from deductions — measures how deductions erode gross margin return on inventory."
    - name: "deduction_count"
      expr: COUNT(DISTINCT deduction_id)
      comment: "Count of distinct deductions — measures the volume of deduction claims requiring management attention."
    - name: "disputed_deduction_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_status IS NOT NULL AND dispute_status != 'Resolved' THEN deduction_id END)
      comment: "Count of deductions in active dispute — measures the dispute backlog and associated financial risk."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`promotion_deduction_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deduction settlement efficiency KPI layer — tracks settlement amounts, cycle times, SLA compliance, partial settlement rates, and dispute resolution to optimize the trade deduction close process."
  source: "`consumer_goods_ecm`.`promotion`.`deduction_settlement`"
  dimensions:
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current status of the settlement (e.g., pending, approved, completed) for settlement pipeline management."
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method used to settle the deduction (e.g., credit memo, offset) for process efficiency benchmarking."
    - name: "settlement_reason_code"
      expr: settlement_reason_code
      comment: "Reason code for the settlement — used to classify valid vs. invalid deduction resolutions."
    - name: "dispute_resolution_method"
      expr: dispute_resolution_method
      comment: "Method used to resolve disputes (e.g., negotiation, write-off) for dispute management process analysis."
    - name: "is_partial_settlement"
      expr: is_partial_settlement
      comment: "Indicates whether the settlement is partial — used to track incomplete resolutions and residual liability."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Indicates whether the settlement met SLA requirements — used to monitor settlement process efficiency and compliance."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the settlement for annual trade spend close and financial reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the settlement for period-level trade spend reconciliation."
    - name: "business_unit_code"
      expr: business_unit_code
      comment: "Business unit associated with the settlement for organizational accountability."
    - name: "settlement_date_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month of settlement for time-series trending of settlement volumes and amounts."
  measures:
    - name: "total_settled_amount"
      expr: SUM(CAST(settled_amount AS DOUBLE))
      comment: "Total amount settled across deduction settlements — primary measure of resolved trade liability."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved settlement amount — measures the validated trade liability approved for payment."
    - name: "total_deduction_claimed_amount"
      expr: SUM(CAST(deduction_claimed_amount AS DOUBLE))
      comment: "Total deduction amount originally claimed — baseline for settlement recovery rate calculation."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total disputed amount in settlements — measures the financial exposure from contested settlement claims."
    - name: "avg_settlement_cycle_time_days"
      expr: AVG(CAST(settlement_cycle_time_days AS DOUBLE))
      comment: "Average settlement cycle time in days — key operational efficiency KPI for the deduction management process."
    - name: "settlement_count"
      expr: COUNT(DISTINCT deduction_settlement_id)
      comment: "Count of distinct deduction settlements — measures the volume of settlement transactions processed."
    - name: "sla_compliant_settlement_count"
      expr: COUNT(DISTINCT CASE WHEN sla_compliance_flag = TRUE THEN deduction_settlement_id END)
      comment: "Count of settlements meeting SLA requirements — numerator for SLA compliance rate calculation."
    - name: "partial_settlement_count"
      expr: COUNT(DISTINCT CASE WHEN is_partial_settlement = TRUE THEN deduction_settlement_id END)
      comment: "Count of partial settlements — measures the volume of incomplete resolutions requiring follow-up."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`promotion_funding_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Funding agreement KPI layer — tracks committed vs. paid trade funding, accrual balances, remaining budget, ROI targets, and agreement portfolio health to govern trade fund utilization and compliance."
  source: "`consumer_goods_ecm`.`promotion`.`funding_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of funding agreement (e.g., lump sum, scan-back, bill-back) to segment trade fund utilization by funding mechanism."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Lifecycle status of the agreement (e.g., active, expired, terminated) for portfolio health monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the funding agreement for governance and compliance tracking."
    - name: "accrual_method"
      expr: accrual_method
      comment: "Accrual method used for the agreement (e.g., fixed, variable, scan-based) for financial accounting alignment."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of funding payments (e.g., monthly, quarterly, annual) for cash flow planning."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the agreement auto-renews — used to manage agreement expiry risk and renegotiation planning."
    - name: "renewal_flag"
      expr: renewal_flag
      comment: "Indicates whether the agreement is a renewal — used to track agreement continuity and relationship tenure."
    - name: "funding_period_start_month"
      expr: DATE_TRUNC('MONTH', funding_period_start_date)
      comment: "Month the funding period starts for time-series trending of trade fund commitments."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the funding agreement for multi-currency trade fund analysis."
  measures:
    - name: "total_committed_amount"
      expr: SUM(CAST(total_committed_amount AS DOUBLE))
      comment: "Total committed trade funding across agreements — primary measure of trade fund obligation and budget exposure."
    - name: "total_paid_to_date_amount"
      expr: SUM(CAST(paid_to_date_amount AS DOUBLE))
      comment: "Total amount paid to date across agreements — measures actual cash outflow against committed trade funding."
    - name: "total_accrued_to_date_amount"
      expr: SUM(CAST(accrued_to_date_amount AS DOUBLE))
      comment: "Total accrued trade funding to date — measures the financial liability recognized but not yet paid."
    - name: "total_remaining_balance_amount"
      expr: SUM(CAST(remaining_balance_amount AS DOUBLE))
      comment: "Total remaining uncommitted balance across agreements — measures available trade funding for future promotions."
    - name: "avg_roi_target_percentage"
      expr: AVG(CAST(roi_target_percentage AS DOUBLE))
      comment: "Average ROI target percentage across funding agreements — measures the expected return threshold set for trade investments."
    - name: "avg_gmroi_target"
      expr: AVG(CAST(gmroi_target AS DOUBLE))
      comment: "Average GMROI target across funding agreements — measures the gross margin return threshold negotiated with retailers."
    - name: "funding_agreement_count"
      expr: COUNT(DISTINCT funding_agreement_id)
      comment: "Count of distinct funding agreements — measures the breadth of the trade funding portfolio."
    - name: "active_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN agreement_status = 'Active' THEN funding_agreement_id END)
      comment: "Count of active funding agreements — measures the current active trade funding portfolio size."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`promotion_retailer_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retailer compliance KPI layer — measures promotional execution compliance rates, penalty exposure, price and display adherence, and dispute rates to protect trade investment ROI through execution quality management."
  source: "`consumer_goods_ecm`.`promotion`.`retailer_compliance`"
  dimensions:
    - name: "compliance_type"
      expr: compliance_type
      comment: "Type of compliance being measured (e.g., price, display, feature ad) for tactic-specific compliance analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status (e.g., compliant, non-compliant, partial) for compliance portfolio health monitoring."
    - name: "non_compliance_category"
      expr: non_compliance_category
      comment: "Category of non-compliance (e.g., pricing, placement, timing) for root cause analysis and corrective action."
    - name: "audit_method"
      expr: audit_method
      comment: "Method used to audit compliance (e.g., field audit, syndicated data, photo) for data quality and coverage assessment."
    - name: "price_compliant_flag"
      expr: price_compliant_flag
      comment: "Indicates whether the retailer executed the agreed promotional price — key compliance dimension for price integrity."
    - name: "display_compliant_flag"
      expr: display_compliant_flag
      comment: "Indicates whether the retailer executed the agreed display placement — used to correlate display compliance with lift."
    - name: "ad_feature_compliant_flag"
      expr: ad_feature_compliant_flag
      comment: "Indicates whether the retailer executed the agreed feature advertisement — used to isolate ad execution impact on lift."
    - name: "osa_compliant_flag"
      expr: osa_compliant_flag
      comment: "Indicates whether on-shelf availability compliance was achieved — used to assess OOS risk during promotions."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the compliance finding is under dispute — used to track contested compliance assessments."
    - name: "compliance_check_month"
      expr: DATE_TRUNC('MONTH', compliance_check_date)
      comment: "Month of the compliance check for time-series trending of compliance rates."
  measures:
    - name: "avg_compliance_score_percentage"
      expr: AVG(CAST(compliance_score_percentage AS DOUBLE))
      comment: "Average retailer compliance score percentage — headline KPI for overall promotional execution quality."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount assessed for non-compliance — measures the financial consequence of poor execution and deduction recovery."
    - name: "total_funding_adjustment_amount"
      expr: SUM(CAST(funding_adjustment_amount AS DOUBLE))
      comment: "Total funding adjustment amount applied due to compliance findings — measures the trade fund recovery from non-compliant events."
    - name: "total_actual_retail_price_sum"
      expr: SUM(CAST(actual_retail_price AS DOUBLE))
      comment: "Sum of actual retail prices observed during compliance audits — used to compute average price execution vs. agreed promotional price."
    - name: "total_agreed_promotional_price_sum"
      expr: SUM(CAST(agreed_promotional_price AS DOUBLE))
      comment: "Sum of agreed promotional prices across compliance checks — denominator for price compliance variance analysis."
    - name: "compliance_check_count"
      expr: COUNT(DISTINCT retailer_compliance_id)
      comment: "Count of distinct compliance checks — measures the breadth of compliance audit coverage."
    - name: "non_compliant_check_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_status = 'Non-Compliant' THEN retailer_compliance_id END)
      comment: "Count of non-compliant compliance checks — numerator for non-compliance rate calculation."
    - name: "disputed_compliance_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN retailer_compliance_id END)
      comment: "Count of compliance findings under dispute — measures the contested compliance backlog and associated financial risk."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`promotion_trade_spend_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade spend allocation KPI layer — tracks allocated vs. actual spend, variance, ROI, GMROI, and volume attainment at the allocation level to govern trade budget utilization and efficiency."
  source: "`consumer_goods_ecm`.`promotion`.`trade_spend_allocation`"
  dimensions:
    - name: "spend_type"
      expr: spend_type
      comment: "Type of trade spend (e.g., off-invoice, scan-back, lump sum) for spend mix and efficiency analysis."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the spend allocation (e.g., planned, committed, settled) for budget pipeline management."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy associated with the allocation for strategy-level spend efficiency analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the allocation for annual trade budget planning and close."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the allocation for period-level trade spend reconciliation."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the allocation is currently active — used to filter live vs. historical spend commitments."
    - name: "volume_uom"
      expr: volume_uom
      comment: "Unit of measure for volume (e.g., cases, units) for consistent volume-based spend efficiency analysis."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month of the allocation for time-series trending of trade spend commitments."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allocation for multi-currency trade spend analysis."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total allocated trade spend amount — primary measure of trade budget commitment."
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual trade spend incurred — measures realized spend against allocation."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed trade spend — measures firm financial obligations against the trade budget."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between allocated and actual trade spend — measures budget discipline and planning accuracy."
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrued trade spend liability — tracks financial exposure from active allocations."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settled trade spend amount — measures the resolved financial liability from trade allocations."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deduction amount associated with allocations — tracks deduction liability per allocation for reconciliation."
    - name: "total_actual_volume"
      expr: SUM(CAST(actual_volume AS DOUBLE))
      comment: "Total actual volume delivered against allocations — measures volume attainment for spend efficiency analysis."
    - name: "total_target_volume"
      expr: SUM(CAST(target_volume AS DOUBLE))
      comment: "Total target volume for allocations — denominator for volume attainment rate calculation."
    - name: "avg_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average ROI percentage across trade spend allocations — measures the expected return on allocated trade investment."
    - name: "avg_gmroi_percentage"
      expr: AVG(CAST(gmroi_percentage AS DOUBLE))
      comment: "Average GMROI percentage across allocations — measures gross margin return on allocated trade inventory investment."
    - name: "allocation_count"
      expr: COUNT(DISTINCT trade_spend_allocation_id)
      comment: "Count of distinct trade spend allocations — measures the granularity and breadth of trade budget deployment."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`promotion_consumer_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer offer KPI layer — tracks offer budget utilization, redemption economics, discount depth, and offer portfolio health to optimize consumer promotion investment and targeting effectiveness."
  source: "`consumer_goods_ecm`.`promotion`.`consumer_offer`"
  dimensions:
    - name: "offer_type"
      expr: offer_type
      comment: "Type of consumer offer (e.g., coupon, rebate, BOGO, loyalty reward) for tactic-level ROI benchmarking."
    - name: "offer_status"
      expr: offer_status
      comment: "Current status of the offer (e.g., active, expired, cancelled) for portfolio health monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the consumer offer for governance and compliance tracking."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Channel through which the offer is distributed (e.g., digital, FSI, in-store) for channel effectiveness analysis."
    - name: "redemption_channel"
      expr: redemption_channel
      comment: "Channel where the offer is redeemed (e.g., in-store, online) for redemption behavior analysis."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of offer funding (e.g., manufacturer, retailer, co-op) for funding accountability."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the offer (e.g., national, regional, local) for geographic targeting analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the offer is valid for multi-market consumer promotion analysis."
    - name: "stackable_flag"
      expr: stackable_flag
      comment: "Indicates whether the offer can be stacked with other promotions — used to assess combined discount risk."
    - name: "valid_from_month"
      expr: DATE_TRUNC('MONTH', valid_from_date)
      comment: "Month the offer becomes valid for time-series trending of consumer offer activity."
  measures:
    - name: "total_budget_allocated"
      expr: SUM(CAST(total_budget_allocated AS DOUBLE))
      comment: "Total budget allocated to consumer offers — primary measure of consumer promotion investment."
    - name: "total_actual_cost_incurred"
      expr: SUM(CAST(actual_cost_incurred AS DOUBLE))
      comment: "Total actual cost incurred from consumer offers — measures realized consumer promotion spend."
    - name: "total_budget_variance"
      expr: SUM(CAST(total_budget_allocated AS DOUBLE) - CAST(actual_cost_incurred AS DOUBLE))
      comment: "Total variance between allocated budget and actual cost — measures consumer offer budget discipline."
    - name: "avg_estimated_cost_per_redemption"
      expr: AVG(CAST(estimated_cost_per_redemption AS DOUBLE))
      comment: "Average estimated cost per redemption across offers — key efficiency KPI for consumer promotion economics."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across consumer offers — monitors discount depth and its relationship to redemption rates."
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average absolute discount value per offer — measures the per-offer consumer incentive magnitude."
    - name: "avg_minimum_purchase_amount"
      expr: AVG(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Average minimum purchase amount required for offer redemption — used to assess basket-building effectiveness of offer mechanics."
    - name: "consumer_offer_count"
      expr: COUNT(DISTINCT consumer_offer_id)
      comment: "Count of distinct consumer offers — measures the breadth of the consumer promotion portfolio."
    - name: "active_offer_count"
      expr: COUNT(DISTINCT CASE WHEN offer_status = 'Active' THEN consumer_offer_id END)
      comment: "Count of currently active consumer offers — measures the live consumer promotion portfolio size."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`promotion_promoted_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promoted price KPI layer — tracks price reduction depth, promotional allowances, margin impact, and volume lift estimates to optimize pricing strategy and protect retailer and manufacturer margins during promotions."
  source: "`consumer_goods_ecm`.`promotion`.`promoted_price`"
  dimensions:
    - name: "pricing_strategy_type"
      expr: pricing_strategy_type
      comment: "Type of pricing strategy applied (e.g., EDLP, Hi-Lo, value pack) for strategy-level price effectiveness analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the promoted price for governance and compliance tracking."
    - name: "accrual_method"
      expr: accrual_method
      comment: "Accrual method for the promoted price (e.g., scan-back, bill-back) for financial accounting alignment."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding for the price reduction (e.g., manufacturer, retailer) for funding accountability."
    - name: "is_advertised"
      expr: is_advertised
      comment: "Indicates whether the promoted price is advertised — used to isolate the incremental lift from advertised vs. non-advertised price reductions."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Indicates whether the promoted price can be stacked with other offers — used to assess combined discount risk."
    - name: "country_code"
      expr: country_code
      comment: "Country where the promoted price is valid for multi-market pricing analysis."
    - name: "region_code"
      expr: region_code
      comment: "Region where the promoted price applies for regional pricing strategy analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the promoted price becomes effective for time-series trending of promotional pricing activity."
  measures:
    - name: "avg_price_reduction_percentage"
      expr: AVG(CAST(price_reduction_percentage AS DOUBLE))
      comment: "Average price reduction percentage across promoted prices — headline KPI for promotional discount depth management."
    - name: "avg_promotional_price_amount"
      expr: AVG(CAST(promotional_price_amount AS DOUBLE))
      comment: "Average promoted price amount — used to benchmark promotional price levels across retailers and geographies."
    - name: "avg_regular_shelf_price"
      expr: AVG(CAST(regular_shelf_price AS DOUBLE))
      comment: "Average regular shelf price — baseline for computing price reduction depth and consumer value perception."
    - name: "total_promotional_allowance_amount"
      expr: SUM(CAST(promotional_allowance_amount AS DOUBLE))
      comment: "Total promotional allowance amount granted — measures the trade funding deployed through price allowances."
    - name: "avg_retailer_margin_percentage"
      expr: AVG(CAST(retailer_margin_percentage AS DOUBLE))
      comment: "Average retailer margin percentage at promoted price — monitors retailer profitability during promotions to protect partnership health."
    - name: "avg_scan_back_rate"
      expr: AVG(CAST(scan_back_rate AS DOUBLE))
      comment: "Average scan-back rate across promoted prices — measures the per-unit trade funding rate for scan-back funded promotions."
    - name: "total_estimated_volume_lift"
      expr: SUM(CAST(estimated_volume_lift AS DOUBLE))
      comment: "Total estimated volume lift from promoted prices — measures the expected incremental volume from price reductions."
    - name: "avg_cost_of_goods_sold"
      expr: AVG(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Average COGS at promoted price — used to compute gross margin at promoted price and assess margin floor compliance."
    - name: "promoted_price_count"
      expr: COUNT(DISTINCT promoted_price_id)
      comment: "Count of distinct promoted prices — measures the breadth of the active promotional pricing portfolio."
$$;