-- Metric views for domain: promotion | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-23 23:38:27

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_trade_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core trade promotion performance metrics tracking promotional effectiveness, ROI, and volume impact across accounts and brands"
  source: "`vibe_consumer_goods_v1`.`promotion`.`trade_promotion`"
  dimensions:
    - name: "promotion_status"
      expr: promotion_status
      comment: "Current status of the trade promotion (planned, active, completed, cancelled)"
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of trade promotion (TPR, display, feature, combo)"
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel where promotion is executed"
    - name: "funding_type"
      expr: funding_type
      comment: "Source of promotional funding (manufacturer, co-op, retailer)"
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing approach used in the promotion"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic coverage of the promotion"
    - name: "promotion_year"
      expr: YEAR(start_date)
      comment: "Year the promotion started"
    - name: "promotion_quarter"
      expr: CONCAT('Q', QUARTER(start_date))
      comment: "Quarter the promotion started"
    - name: "promotion_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the promotion started"
    - name: "has_feature_ad"
      expr: feature_ad_flag
      comment: "Whether promotion includes feature advertising"
    - name: "has_coupon"
      expr: coupon_flag
      comment: "Whether promotion includes coupons"
  measures:
    - name: "total_promotions"
      expr: COUNT(1)
      comment: "Total number of trade promotions"
    - name: "total_authorized_budget"
      expr: SUM(CAST(authorized_budget_amount AS DOUBLE))
      comment: "Total authorized budget across all promotions"
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrued promotional spend"
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deductions claimed against promotions"
    - name: "total_baseline_volume"
      expr: SUM(CAST(baseline_volume_units AS DOUBLE))
      comment: "Total baseline volume units across promotions"
    - name: "total_target_volume"
      expr: SUM(CAST(target_volume_units AS DOUBLE))
      comment: "Total target volume units for promotions"
    - name: "avg_expected_roi"
      expr: AVG(CAST(expected_roi_percentage AS DOUBLE))
      comment: "Average expected ROI percentage across promotions"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique trade accounts participating in promotions"
    - name: "distinct_brands"
      expr: COUNT(DISTINCT marketing_brand_id)
      comment: "Number of unique brands promoted"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion event execution metrics tracking actual performance, spend variance, and ROI realization at the event level"
  source: "`vibe_consumer_goods_v1`.`promotion`.`promotion_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Current status of the promotion event"
    - name: "event_type"
      expr: event_type
      comment: "Type of promotional event"
    - name: "funding_source"
      expr: funding_source
      comment: "Source of event funding"
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy employed in the event"
    - name: "settlement_status"
      expr: settlement_status
      comment: "Financial settlement status of the event"
    - name: "geography_code"
      expr: geography_code
      comment: "Geographic code where event executed"
    - name: "event_year"
      expr: YEAR(start_date)
      comment: "Year the event started"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the event started"
    - name: "post_analysis_completed"
      expr: post_event_analysis_completed_flag
      comment: "Whether post-event analysis has been completed"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of promotion events"
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_trade_spend_amount AS DOUBLE))
      comment: "Total planned trade spend across events"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_trade_spend_amount AS DOUBLE))
      comment: "Total actual trade spend incurred"
    - name: "total_accrual"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrued amounts for events"
    - name: "total_deductions"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deductions claimed"
    - name: "total_rebates"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate amounts"
    - name: "total_planned_volume"
      expr: SUM(CAST(planned_volume_units AS DOUBLE))
      comment: "Total planned volume units"
    - name: "total_actual_volume"
      expr: SUM(CAST(actual_volume_units AS DOUBLE))
      comment: "Total actual volume units sold"
    - name: "total_baseline_volume"
      expr: SUM(CAST(baseline_volume_units AS DOUBLE))
      comment: "Total baseline volume units"
    - name: "avg_gmroi"
      expr: AVG(CAST(gmroi_ratio AS DOUBLE))
      comment: "Average gross margin return on investment ratio"
    - name: "avg_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average return on investment percentage"
    - name: "avg_lift_percentage"
      expr: AVG(CAST(promotional_lift_percentage AS DOUBLE))
      comment: "Average promotional lift percentage achieved"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique trade accounts in events"
    - name: "distinct_promotions"
      expr: COUNT(DISTINCT trade_promotion_id)
      comment: "Number of unique trade promotions executed"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_post_event_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post-event analysis metrics measuring promotional effectiveness, incremental lift, ROI realization, and compliance performance"
  source: "`vibe_consumer_goods_v1`.`promotion`.`post_event_analysis`"
  dimensions:
    - name: "analysis_status"
      expr: analysis_status
      comment: "Status of the post-event analysis"
    - name: "learning_classification"
      expr: learning_classification
      comment: "Classification of learnings from the event"
    - name: "baseline_estimation_methodology"
      expr: baseline_estimation_methodology
      comment: "Methodology used to estimate baseline"
    - name: "lift_measurement_methodology"
      expr: lift_measurement_methodology
      comment: "Methodology used to measure lift"
    - name: "lift_measurement_source"
      expr: lift_measurement_source
      comment: "Data source for lift measurement"
    - name: "pre_promotion_trend"
      expr: pre_promotion_trend
      comment: "Trend observed before promotion"
    - name: "analysis_year"
      expr: YEAR(analysis_date)
      comment: "Year of analysis"
    - name: "analysis_month"
      expr: DATE_TRUNC('MONTH', analysis_date)
      comment: "Month of analysis"
    - name: "display_compliant"
      expr: display_compliance_flag
      comment: "Whether display compliance was achieved"
    - name: "feature_compliant"
      expr: feature_compliance_flag
      comment: "Whether feature compliance was achieved"
    - name: "pricing_compliant"
      expr: pricing_compliance_flag
      comment: "Whether pricing compliance was achieved"
  measures:
    - name: "total_analyses"
      expr: COUNT(1)
      comment: "Total number of post-event analyses completed"
    - name: "total_actual_promoted_volume"
      expr: SUM(CAST(actual_promoted_volume_units AS DOUBLE))
      comment: "Total actual promoted volume units"
    - name: "total_baseline_volume"
      expr: SUM(CAST(baseline_volume_units AS DOUBLE))
      comment: "Total baseline volume units"
    - name: "total_incremental_volume"
      expr: SUM(CAST(incremental_volume_units AS DOUBLE))
      comment: "Total incremental volume units generated"
    - name: "total_incremental_lift_units"
      expr: SUM(CAST(incremental_lift_units AS DOUBLE))
      comment: "Total incremental lift units"
    - name: "total_incremental_revenue"
      expr: SUM(CAST(incremental_revenue_amount AS DOUBLE))
      comment: "Total incremental revenue generated"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_trade_spend_amount AS DOUBLE))
      comment: "Total actual trade spend"
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_trade_spend_amount AS DOUBLE))
      comment: "Total planned trade spend"
    - name: "avg_incremental_lift_pct"
      expr: AVG(CAST(incremental_lift_percentage AS DOUBLE))
      comment: "Average incremental lift percentage"
    - name: "avg_lift_pct"
      expr: AVG(CAST(lift_percentage AS DOUBLE))
      comment: "Average lift percentage"
    - name: "avg_gmroi"
      expr: AVG(CAST(gmroi AS DOUBLE))
      comment: "Average gross margin return on investment"
    - name: "avg_promotional_roi"
      expr: AVG(CAST(promotional_roi AS DOUBLE))
      comment: "Average promotional ROI"
    - name: "avg_roi_pct"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average ROI percentage"
    - name: "avg_retailer_compliance_score"
      expr: AVG(CAST(retailer_compliance_score AS DOUBLE))
      comment: "Average retailer compliance score"
    - name: "avg_cost_per_incremental_case"
      expr: AVG(CAST(cost_per_incremental_case AS DOUBLE))
      comment: "Average cost per incremental case"
    - name: "avg_sell_through_rate"
      expr: AVG(CAST(sell_through_rate AS DOUBLE))
      comment: "Average sell-through rate"
    - name: "distinct_events"
      expr: COUNT(DISTINCT promotion_event_id)
      comment: "Number of unique promotion events analyzed"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique trade accounts analyzed"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_lift_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional lift measurement metrics quantifying incremental volume, revenue impact, and statistical significance of promotional effectiveness"
  source: "`vibe_consumer_goods_v1`.`promotion`.`lift_measurement`"
  dimensions:
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the lift measurement"
    - name: "measurement_methodology"
      expr: measurement_methodology
      comment: "Methodology used for lift measurement"
    - name: "baseline_calculation_method"
      expr: baseline_calculation_method
      comment: "Method used to calculate baseline"
    - name: "lift_source"
      expr: lift_source
      comment: "Source of lift data"
    - name: "measurement_year"
      expr: YEAR(measurement_date)
      comment: "Year of measurement"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of measurement"
    - name: "statistically_significant"
      expr: statistical_significance_flag
      comment: "Whether lift is statistically significant"
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total number of lift measurements"
    - name: "total_actual_promoted_volume"
      expr: SUM(CAST(actual_promoted_volume_units AS DOUBLE))
      comment: "Total actual promoted volume units"
    - name: "total_actual_units"
      expr: SUM(CAST(actual_units AS DOUBLE))
      comment: "Total actual units sold"
    - name: "total_baseline_volume"
      expr: SUM(CAST(baseline_volume_units AS DOUBLE))
      comment: "Total baseline volume units"
    - name: "total_baseline_units"
      expr: SUM(CAST(baseline_units AS DOUBLE))
      comment: "Total baseline units"
    - name: "total_incremental_lift_units"
      expr: SUM(CAST(incremental_lift_units AS DOUBLE))
      comment: "Total incremental lift units"
    - name: "total_lift_units"
      expr: SUM(CAST(lift_units AS DOUBLE))
      comment: "Total lift units"
    - name: "total_incremental_revenue"
      expr: SUM(CAST(incremental_revenue AS DOUBLE))
      comment: "Total incremental revenue generated"
    - name: "total_halo_effect_units"
      expr: SUM(CAST(halo_effect_units AS DOUBLE))
      comment: "Total halo effect units"
    - name: "total_post_promotion_dip_units"
      expr: SUM(CAST(post_promotion_dip_units AS DOUBLE))
      comment: "Total post-promotion dip units"
    - name: "avg_incremental_lift_pct"
      expr: AVG(CAST(incremental_lift_percentage AS DOUBLE))
      comment: "Average incremental lift percentage"
    - name: "avg_lift_pct"
      expr: AVG(CAST(lift_percentage AS DOUBLE))
      comment: "Average lift percentage"
    - name: "avg_discount_pct"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage"
    - name: "avg_cannibalization_rate"
      expr: AVG(CAST(cannibalization_rate AS DOUBLE))
      comment: "Average cannibalization rate"
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level_percentage AS DOUBLE))
      comment: "Average confidence level percentage"
    - name: "avg_p_value"
      expr: AVG(CAST(p_value AS DOUBLE))
      comment: "Average p-value for statistical significance"
    - name: "distinct_events"
      expr: COUNT(DISTINCT promotion_event_id)
      comment: "Number of unique promotion events measured"
    - name: "distinct_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs measured"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique trade accounts measured"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_funding_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Funding agreement financial metrics tracking committed amounts, accruals, payments, and ROI targets for trade promotional funding"
  source: "`vibe_consumer_goods_v1`.`promotion`.`funding_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the funding agreement"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of funding agreement"
    - name: "funding_type"
      expr: funding_type
      comment: "Type of funding provided"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the agreement"
    - name: "agreement_year"
      expr: YEAR(effective_date)
      comment: "Year the agreement became effective"
    - name: "agreement_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the agreement became effective"
    - name: "auto_renewal"
      expr: auto_renewal_flag
      comment: "Whether agreement has auto-renewal"
    - name: "renewal_flag"
      expr: renewal_flag
      comment: "Whether this is a renewal agreement"
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of funding agreements"
    - name: "total_committed_amount"
      expr: SUM(CAST(total_committed_amount AS DOUBLE))
      comment: "Total committed funding amount"
    - name: "total_funding_amount"
      expr: SUM(CAST(total_funding_amount AS DOUBLE))
      comment: "Total funding amount"
    - name: "total_accrued_to_date"
      expr: SUM(CAST(accrued_to_date_amount AS DOUBLE))
      comment: "Total accrued to date"
    - name: "total_paid_to_date"
      expr: SUM(CAST(paid_to_date_amount AS DOUBLE))
      comment: "Total paid to date"
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance_amount AS DOUBLE))
      comment: "Total remaining balance"
    - name: "avg_gmroi_target"
      expr: AVG(CAST(gmroi_target AS DOUBLE))
      comment: "Average GMROI target"
    - name: "avg_roi_target_pct"
      expr: AVG(CAST(roi_target_percentage AS DOUBLE))
      comment: "Average ROI target percentage"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique trade accounts with agreements"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_deduction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion deduction metrics tracking claimed amounts, dispute resolution, settlement performance, and aging for trade deductions"
  source: "`vibe_consumer_goods_v1`.`promotion`.`promotion_deduction`"
  dimensions:
    - name: "deduction_status"
      expr: deduction_status
      comment: "Current status of the deduction"
    - name: "dispute_status"
      expr: dispute_status
      comment: "Dispute status of the deduction"
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method used for settlement"
    - name: "deduction_reason_code"
      expr: deduction_reason_code
      comment: "Reason code for the deduction"
    - name: "settlement_reason_code"
      expr: settlement_reason_code
      comment: "Reason code for settlement"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the deduction"
    - name: "deduction_year"
      expr: YEAR(deduction_date)
      comment: "Year of deduction"
    - name: "deduction_month"
      expr: DATE_TRUNC('MONTH', deduction_date)
      comment: "Month of deduction"
    - name: "accrual_impact"
      expr: accrual_impact_flag
      comment: "Whether deduction impacts accruals"
  measures:
    - name: "total_deductions"
      expr: COUNT(1)
      comment: "Total number of deductions"
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deduction amount claimed"
    - name: "total_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved amount"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total disputed amount"
    - name: "total_settled_amount"
      expr: SUM(CAST(settled_amount AS DOUBLE))
      comment: "Total settled amount"
    - name: "total_roi_impact"
      expr: SUM(CAST(roi_impact_amount AS DOUBLE))
      comment: "Total ROI impact amount"
    - name: "avg_gmroi_impact_pct"
      expr: AVG(CAST(gmroi_impact_percentage AS DOUBLE))
      comment: "Average GMROI impact percentage"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique trade accounts with deductions"
    - name: "distinct_events"
      expr: COUNT(DISTINCT promotion_event_id)
      comment: "Number of unique promotion events with deductions"
    - name: "distinct_invoices"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Number of unique invoices with deductions"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion accrual metrics tracking accrued promotional spend, recognition timing, and financial impact by event and account"
  source: "`vibe_consumer_goods_v1`.`promotion`.`promotion_accrual`"
  dimensions:
    - name: "accrual_status"
      expr: accrual_status
      comment: "Status of the accrual"
    - name: "accrual_context"
      expr: accrual_context
      comment: "Context of the accrual"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the accrual"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the accrual"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the accrual"
    - name: "accrual_year"
      expr: YEAR(accrual_date)
      comment: "Year of accrual"
    - name: "accrual_month"
      expr: DATE_TRUNC('MONTH', accrual_date)
      comment: "Month of accrual"
    - name: "is_disputed"
      expr: is_disputed
      comment: "Whether accrual is disputed"
    - name: "dispute_reason"
      expr: dispute_reason
      comment: "Reason for dispute"
  measures:
    - name: "total_accruals"
      expr: COUNT(1)
      comment: "Total number of accruals"
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrual amount"
    - name: "total_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount"
    - name: "total_baseline_volume"
      expr: SUM(CAST(baseline_volume AS DOUBLE))
      comment: "Total baseline volume"
    - name: "total_incremental_volume"
      expr: SUM(CAST(incremental_volume AS DOUBLE))
      comment: "Total incremental volume"
    - name: "total_quantity_sold"
      expr: SUM(CAST(quantity_sold AS DOUBLE))
      comment: "Total quantity sold"
    - name: "avg_gmroi"
      expr: AVG(CAST(gmroi AS DOUBLE))
      comment: "Average GMROI"
    - name: "avg_roi_pct"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average ROI percentage"
    - name: "distinct_events"
      expr: COUNT(DISTINCT promotion_event_id)
      comment: "Number of unique promotion events"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique trade accounts"
    - name: "distinct_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_event_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event SKU performance metrics tracking promoted pricing, volume lift, compliance, and ROI at the SKU-event-account level"
  source: "`vibe_consumer_goods_v1`.`promotion`.`event_sku`"
  dimensions:
    - name: "compliance_check_status"
      expr: compliance_check_status
      comment: "Compliance check status"
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status"
    - name: "pricing_approval_status"
      expr: pricing_approval_status
      comment: "Pricing approval status"
    - name: "display_location_type"
      expr: display_location_type
      comment: "Type of display location"
    - name: "feature_type"
      expr: feature_type
      comment: "Type of feature"
    - name: "event_year"
      expr: YEAR(promotion_effective_start_date)
      comment: "Year of promotion start"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', promotion_effective_start_date)
      comment: "Month of promotion start"
    - name: "is_featured_sku"
      expr: is_featured_sku
      comment: "Whether SKU is featured"
  measures:
    - name: "total_event_skus"
      expr: COUNT(1)
      comment: "Total number of event SKUs"
    - name: "total_planned_promotional_volume_units"
      expr: SUM(CAST(planned_promotional_volume_units AS DOUBLE))
      comment: "Total planned promotional volume units"
    - name: "total_actual_promotional_volume_units"
      expr: SUM(CAST(actual_promotional_volume_units AS DOUBLE))
      comment: "Total actual promotional volume units"
    - name: "total_planned_promotional_volume_cases"
      expr: SUM(CAST(planned_promotional_volume_cases AS DOUBLE))
      comment: "Total planned promotional volume cases"
    - name: "total_actual_promotional_volume_cases"
      expr: SUM(CAST(actual_promotional_volume_cases AS DOUBLE))
      comment: "Total actual promotional volume cases"
    - name: "total_baseline_volume"
      expr: SUM(CAST(baseline_volume_units AS DOUBLE))
      comment: "Total baseline volume units"
    - name: "total_incremental_lift_volume"
      expr: SUM(CAST(incremental_lift_volume_units AS DOUBLE))
      comment: "Total incremental lift volume units"
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrual amount"
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deduction amount"
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate amount"
    - name: "total_trade_spend"
      expr: SUM(CAST(total_trade_spend_amount AS DOUBLE))
      comment: "Total trade spend amount"
    - name: "avg_promoted_price"
      expr: AVG(CAST(promoted_price AS DOUBLE))
      comment: "Average promoted price"
    - name: "avg_regular_shelf_price"
      expr: AVG(CAST(regular_shelf_price AS DOUBLE))
      comment: "Average regular shelf price"
    - name: "avg_discount_pct"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage"
    - name: "avg_incremental_lift_pct"
      expr: AVG(CAST(incremental_lift_percent AS DOUBLE))
      comment: "Average incremental lift percent"
    - name: "avg_promotional_roi_pct"
      expr: AVG(CAST(promotional_roi_percent AS DOUBLE))
      comment: "Average promotional ROI percent"
    - name: "avg_promotional_gmroi"
      expr: AVG(CAST(promotional_gmroi AS DOUBLE))
      comment: "Average promotional GMROI"
    - name: "distinct_events"
      expr: COUNT(DISTINCT promotion_event_id)
      comment: "Number of unique promotion events"
    - name: "distinct_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique trade accounts"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_retailer_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retailer compliance metrics measuring adherence to promotional terms including pricing, display, feature, and OSA compliance"
  source: "`vibe_consumer_goods_v1`.`promotion`.`retailer_compliance`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status"
    - name: "compliance_type"
      expr: compliance_type
      comment: "Type of compliance check"
    - name: "audit_method"
      expr: audit_method
      comment: "Method used for audit"
    - name: "data_source"
      expr: data_source
      comment: "Source of compliance data"
    - name: "non_compliance_category"
      expr: non_compliance_category
      comment: "Category of non-compliance"
    - name: "non_compliance_reason"
      expr: non_compliance_reason
      comment: "Reason for non-compliance"
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of resolution"
    - name: "audit_year"
      expr: YEAR(audit_date)
      comment: "Year of audit"
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month of audit"
    - name: "price_compliant"
      expr: price_compliant_flag
      comment: "Whether price was compliant"
    - name: "display_compliant"
      expr: display_compliant_flag
      comment: "Whether display was compliant"
    - name: "ad_feature_compliant"
      expr: ad_feature_compliant_flag
      comment: "Whether ad feature was compliant"
    - name: "osa_compliant"
      expr: osa_compliant_flag
      comment: "Whether on-shelf availability was compliant"
    - name: "pog_placement_compliant"
      expr: pog_placement_compliant_flag
      comment: "Whether planogram placement was compliant"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether compliance is disputed"
  measures:
    - name: "total_compliance_checks"
      expr: COUNT(1)
      comment: "Total number of compliance checks"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount assessed"
    - name: "total_funding_adjustment"
      expr: SUM(CAST(funding_adjustment_amount AS DOUBLE))
      comment: "Total funding adjustment amount"
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score"
    - name: "avg_compliance_score_pct"
      expr: AVG(CAST(compliance_score_percentage AS DOUBLE))
      comment: "Average compliance score percentage"
    - name: "distinct_events"
      expr: COUNT(DISTINCT promotion_event_id)
      comment: "Number of unique promotion events checked"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique trade accounts checked"
    - name: "distinct_stores"
      expr: COUNT(DISTINCT retail_store_id)
      comment: "Number of unique retail stores checked"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_baseline_volume`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Baseline volume estimation metrics providing non-promotional volume benchmarks for lift measurement and promotional planning"
  source: "`vibe_consumer_goods_v1`.`promotion`.`baseline_volume`"
  dimensions:
    - name: "baseline_status"
      expr: baseline_status
      comment: "Status of baseline calculation"
    - name: "baseline_methodology"
      expr: baseline_methodology
      comment: "Methodology used for baseline"
    - name: "calculation_method"
      expr: calculation_method
      comment: "Calculation method used"
    - name: "data_source"
      expr: data_source
      comment: "Source of baseline data"
    - name: "geography_code"
      expr: geography_code
      comment: "Geographic code"
    - name: "baseline_year"
      expr: YEAR(period_start_date)
      comment: "Year of baseline period"
    - name: "baseline_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month of baseline period"
    - name: "analyst_override"
      expr: analyst_override_flag
      comment: "Whether analyst override was applied"
    - name: "outlier_exclusion"
      expr: outlier_exclusion_flag
      comment: "Whether outliers were excluded"
  measures:
    - name: "total_baseline_records"
      expr: COUNT(1)
      comment: "Total number of baseline records"
    - name: "total_baseline_units"
      expr: SUM(CAST(baseline_units AS DOUBLE))
      comment: "Total baseline units"
    - name: "total_baseline_revenue"
      expr: SUM(CAST(baseline_revenue_amount AS DOUBLE))
      comment: "Total baseline revenue amount"
    - name: "total_units"
      expr: SUM(CAST(units AS DOUBLE))
      comment: "Total units"
    - name: "total_cases"
      expr: SUM(CAST(cases AS DOUBLE))
      comment: "Total cases"
    - name: "avg_seasonality_adjustment"
      expr: AVG(CAST(seasonality_adjustment_factor AS DOUBLE))
      comment: "Average seasonality adjustment factor"
    - name: "avg_trend_adjustment"
      expr: AVG(CAST(trend_adjustment_factor AS DOUBLE))
      comment: "Average trend adjustment factor"
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_percent AS DOUBLE))
      comment: "Average confidence level percent"
    - name: "avg_model_accuracy_score"
      expr: AVG(CAST(model_accuracy_score AS DOUBLE))
      comment: "Average model accuracy score"
    - name: "distinct_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique trade accounts"
    - name: "distinct_brands"
      expr: COUNT(DISTINCT marketing_brand_id)
      comment: "Number of unique brands"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_tpo_scenario`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade promotion optimization scenario metrics comparing projected ROI, volume, and spend across alternative promotional strategies"
  source: "`vibe_consumer_goods_v1`.`promotion`.`tpo_scenario`"
  dimensions:
    - name: "scenario_status"
      expr: scenario_status
      comment: "Status of the scenario"
    - name: "scenario_type"
      expr: scenario_type
      comment: "Type of scenario"
    - name: "optimization_objective"
      expr: optimization_objective
      comment: "Optimization objective"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope"
    - name: "country_code"
      expr: country_code
      comment: "Country code"
    - name: "region_code"
      expr: region_code
      comment: "Region code"
    - name: "scenario_year"
      expr: YEAR(planning_horizon_start_date)
      comment: "Year of scenario planning horizon"
    - name: "is_baseline"
      expr: is_baseline_scenario
      comment: "Whether this is the baseline scenario"
    - name: "is_optimal"
      expr: is_optimal
      comment: "Whether this is the optimal scenario"
  measures:
    - name: "total_scenarios"
      expr: COUNT(1)
      comment: "Total number of scenarios"
    - name: "total_scenario_spend"
      expr: SUM(CAST(total_scenario_spend AS DOUBLE))
      comment: "Total scenario spend"
    - name: "total_predicted_spend"
      expr: SUM(CAST(predicted_spend_amount AS DOUBLE))
      comment: "Total predicted spend amount"
    - name: "total_predicted_volume"
      expr: SUM(CAST(predicted_volume_units AS DOUBLE))
      comment: "Total predicted volume units"
    - name: "total_projected_baseline_volume"
      expr: SUM(CAST(projected_baseline_volume AS DOUBLE))
      comment: "Total projected baseline volume"
    - name: "total_projected_incremental_volume"
      expr: SUM(CAST(projected_incremental_volume AS DOUBLE))
      comment: "Total projected incremental volume"
    - name: "total_projected_total_volume"
      expr: SUM(CAST(projected_total_volume AS DOUBLE))
      comment: "Total projected total volume"
    - name: "total_projected_baseline_revenue"
      expr: SUM(CAST(projected_baseline_revenue AS DOUBLE))
      comment: "Total projected baseline revenue"
    - name: "total_projected_incremental_revenue"
      expr: SUM(CAST(projected_incremental_revenue AS DOUBLE))
      comment: "Total projected incremental revenue"
    - name: "total_projected_total_revenue"
      expr: SUM(CAST(projected_total_revenue AS DOUBLE))
      comment: "Total projected total revenue"
    - name: "total_projected_gross_profit"
      expr: SUM(CAST(projected_gross_profit AS DOUBLE))
      comment: "Total projected gross profit"
    - name: "avg_predicted_roi_pct"
      expr: AVG(CAST(predicted_roi_percentage AS DOUBLE))
      comment: "Average predicted ROI percentage"
    - name: "avg_projected_roi_pct"
      expr: AVG(CAST(projected_roi_percentage AS DOUBLE))
      comment: "Average projected ROI percentage"
    - name: "avg_projected_gmroi"
      expr: AVG(CAST(projected_gmroi AS DOUBLE))
      comment: "Average projected GMROI"
    - name: "avg_projected_lift_pct"
      expr: AVG(CAST(projected_promotional_lift_percentage AS DOUBLE))
      comment: "Average projected promotional lift percentage"
    - name: "distinct_promotions"
      expr: COUNT(DISTINCT trade_promotion_id)
      comment: "Number of unique trade promotions"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique trade accounts"
$$;