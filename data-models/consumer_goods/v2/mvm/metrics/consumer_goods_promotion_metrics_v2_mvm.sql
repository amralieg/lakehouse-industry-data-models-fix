-- Metric views for domain: promotion | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-24 01:51:46

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_trade_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for trade promotion planning and performance. Covers budget utilization, volume attainment, discount depth, and ROI targets to steer promotional investment decisions."
  source: "`vibe_consumer_goods_v1`.`promotion`.`trade_promotion`"
  dimensions:
    - name: "promotion_status"
      expr: promotion_status
      comment: "Current lifecycle status of the trade promotion (e.g. Draft, Active, Settled, Cancelled) for pipeline and funnel analysis."
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of trade promotion (e.g. Off-Invoice, Scan-Back, Lump Sum) to segment spend by mechanism."
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel (e.g. Grocery, Mass, Club, Drug) to analyze promotional effectiveness by retail channel."
    - name: "funding_type"
      expr: funding_type
      comment: "Source of promotional funding (e.g. Manufacturer, Co-op, Retailer) to attribute spend responsibility."
    - name: "promotion_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the promotion begins, used for time-series trending of promotional activity."
    - name: "promotion_end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the promotion ends, used for settlement timing analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the promotion is executed, enabling geographic performance segmentation."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement state of the promotion (e.g. Pending, Settled, Disputed) to track financial closure."
    - name: "promotion_objective"
      expr: promotion_objective
      comment: "Business objective of the promotion (e.g. Volume Drive, Trial, Loyalty) for strategic alignment analysis."
    - name: "display_type"
      expr: display_type
      comment: "In-store display mechanic (e.g. End Cap, Shipper, Floor Stand) to evaluate display-driven ROI."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing approach used in the promotion (e.g. EDLP, Hi-Lo, TPR) for strategy-level benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the promotion for multi-currency financial reporting."
  measures:
    - name: "total_promotions"
      expr: COUNT(DISTINCT trade_promotion_id)
      comment: "Total number of distinct trade promotions. Baseline volume metric for promotion portfolio sizing and pipeline management."
    - name: "total_authorized_budget"
      expr: SUM(CAST(authorized_budget_amount AS DOUBLE))
      comment: "Total authorized promotional budget across all promotions. Core financial planning KPI for trade spend governance and budget allocation decisions."
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrued trade spend liability. Tracks financial exposure and liability recognition for P&L management."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deduction amount claimed against promotions. Key metric for accounts receivable and deduction management."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average promotional discount depth across promotions. Informs pricing strategy and margin impact assessment."
    - name: "total_target_volume_units"
      expr: SUM(CAST(target_volume_units AS DOUBLE))
      comment: "Total planned volume units across all promotions. Used to assess promotional volume ambition vs. baseline."
    - name: "total_baseline_volume_units"
      expr: SUM(CAST(baseline_volume_units AS DOUBLE))
      comment: "Total baseline (non-promoted) volume units. Denominator for incremental lift calculations and ROI modeling."
    - name: "avg_expected_roi_percentage"
      expr: AVG(CAST(expected_roi_percentage AS DOUBLE))
      comment: "Average expected ROI percentage across promotions. Strategic KPI for evaluating promotional investment quality at portfolio level."
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(accrual_amount AS DOUBLE)) / NULLIF(SUM(CAST(authorized_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of authorized budget consumed via accruals. Critical efficiency KPI — low utilization signals under-execution; over 100% signals budget overrun risk."
    - name: "deduction_to_budget_ratio"
      expr: ROUND(100.0 * SUM(CAST(deduction_amount AS DOUBLE)) / NULLIF(SUM(CAST(authorized_budget_amount AS DOUBLE)), 0), 2)
      comment: "Deductions as a percentage of authorized budget. Measures financial leakage and deduction management effectiveness — high ratios indicate settlement risk."
    - name: "volume_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(baseline_volume_units AS DOUBLE)) / NULLIF(SUM(CAST(target_volume_units AS DOUBLE)), 0), 2)
      comment: "Baseline volume as a percentage of target volume. Proxy for volume plan attainment; drives decisions on promotional intensity and retailer execution."
    - name: "promotions_with_feature_ad"
      expr: COUNT(CASE WHEN feature_ad_flag = TRUE THEN trade_promotion_id END)
      comment: "Number of promotions supported by feature advertising. Measures media investment coverage and its correlation with promotional effectiveness."
    - name: "promotions_with_coupon"
      expr: COUNT(CASE WHEN coupon_flag = TRUE THEN trade_promotion_id END)
      comment: "Number of promotions using coupon mechanics. Tracks coupon-driven promotional activity for redemption cost forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for promotional events. Measures execution quality, spend efficiency, volume delivery, and ROI at the event level to drive in-flight and post-event decisions."
  source: "`vibe_consumer_goods_v1`.`promotion`.`event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Lifecycle status of the event (e.g. Planned, Active, Completed, Cancelled) for pipeline and execution tracking."
    - name: "event_type"
      expr: event_type
      comment: "Type of promotional event (e.g. TPR, Display, Feature) to segment performance by mechanic."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of event funding (e.g. National, Local, Co-op) to attribute spend and evaluate funding mix."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the event starts, enabling time-series analysis of promotional activity cadence."
    - name: "event_end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the event ends, used for settlement timing and post-event analysis scheduling."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Financial settlement state of the event (e.g. Pending, Settled, Disputed) for cash flow and liability management."
    - name: "geography_code"
      expr: geography_code
      comment: "Geographic market where the event executes, enabling regional performance benchmarking."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy applied in the event (e.g. EDLP, Hi-Lo) for strategy-level ROI comparison."
    - name: "post_event_analysis_completed"
      expr: post_event_analysis_completed_flag
      comment: "Whether post-event analysis has been completed (True/False). Tracks analytical closure rate for continuous improvement."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the event for multi-currency financial consolidation."
  measures:
    - name: "total_events"
      expr: COUNT(DISTINCT event_id)
      comment: "Total number of distinct promotional events. Baseline activity metric for event portfolio management."
    - name: "total_planned_trade_spend"
      expr: SUM(CAST(planned_trade_spend_amount AS DOUBLE))
      comment: "Total planned trade spend across events. Core financial planning KPI for budget commitment tracking."
    - name: "total_actual_trade_spend"
      expr: SUM(CAST(actual_trade_spend_amount AS DOUBLE))
      comment: "Total actual trade spend incurred across events. Measures realized financial outlay vs. plan for P&L accuracy."
    - name: "total_planned_volume_units"
      expr: SUM(CAST(planned_volume_units AS DOUBLE))
      comment: "Total planned promotional volume units. Baseline for volume attainment and lift measurement."
    - name: "total_actual_volume_units"
      expr: SUM(CAST(actual_volume_units AS DOUBLE))
      comment: "Total actual volume units sold during events. Primary volume delivery KPI for promotional effectiveness."
    - name: "total_baseline_volume_units"
      expr: SUM(CAST(baseline_volume_units AS DOUBLE))
      comment: "Total baseline (non-promoted) volume units. Used to compute incremental lift and true promotional volume contribution."
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrued trade liability from events. Tracks financial exposure for accrual management and P&L provisioning."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deductions associated with events. Measures deduction exposure and drives prioritization of settlement workload."
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate amounts earned or paid through events. Key metric for rebate program ROI and supplier negotiation leverage."
    - name: "avg_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average ROI percentage across events. Primary profitability KPI for promotional investment quality — drives go/no-go decisions on future events."
    - name: "avg_gmroi_ratio"
      expr: AVG(CAST(gmroi_ratio AS DOUBLE))
      comment: "Average Gross Margin Return on Investment ratio across events. Measures gross margin efficiency of promotional spend — critical for category management decisions."
    - name: "avg_promotional_lift_percentage"
      expr: AVG(CAST(promotional_lift_percentage AS DOUBLE))
      comment: "Average promotional volume lift percentage. Measures incremental volume generated by promotions — key input for future event planning and retailer negotiations."
    - name: "spend_efficiency_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_trade_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(planned_trade_spend_amount AS DOUBLE)), 0), 2)
      comment: "Actual spend as a percentage of planned spend. Measures budget execution accuracy — significant deviations trigger financial reforecasting and accrual adjustments."
    - name: "volume_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_volume_units AS DOUBLE)) / NULLIF(SUM(CAST(planned_volume_units AS DOUBLE)), 0), 2)
      comment: "Actual volume as a percentage of planned volume. Core event execution KPI — below-target attainment triggers retailer compliance reviews and event redesign."
    - name: "incremental_volume_units"
      expr: SUM(CAST(actual_volume_units AS DOUBLE) - CAST(baseline_volume_units AS DOUBLE))
      comment: "Total incremental volume units generated above baseline. Measures true promotional volume contribution, net of baseline, for ROI calculation and event justification."
    - name: "post_event_analysis_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN post_event_analysis_completed_flag = TRUE THEN event_id END) / NULLIF(COUNT(DISTINCT event_id), 0), 2)
      comment: "Percentage of completed events with post-event analysis finished. Measures organizational learning discipline — low rates indicate gaps in continuous improvement processes."
    - name: "cancelled_events"
      expr: COUNT(CASE WHEN event_status = 'Cancelled' THEN event_id END)
      comment: "Number of cancelled events. Tracks execution risk and wasted planning effort — high cancellation rates signal planning quality or retailer alignment issues."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial accrual KPIs for trade promotion liability management. Tracks accrual amounts, settlement timing, dispute rates, and ROI to govern trade spend recognition and cash flow."
  source: "`vibe_consumer_goods_v1`.`promotion`.`accrual`"
  dimensions:
    - name: "accrual_status"
      expr: CAST(accrual_status AS STRING)
      comment: "Status of the accrual record (encoded as numeric code) for lifecycle and aging analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the accrual (e.g. Pending, Approved, Rejected) for governance and authorization tracking."
    - name: "accrual_month"
      expr: DATE_TRUNC('MONTH', accrual_date)
      comment: "Month of accrual recognition for time-series liability trending and period-end close management."
    - name: "settlement_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month of accrual settlement for cash flow forecasting and settlement velocity analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the accrual for period-aligned financial reporting and close processes."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the accrual for annual trade spend budgeting and year-over-year comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the accrual for multi-currency financial consolidation."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Whether the accrual is under dispute (True/False). Flags financial risk and drives prioritization of dispute resolution workload."
    - name: "dispute_reason"
      expr: dispute_reason
      comment: "Reason for accrual dispute to identify systemic issues in promotional execution or documentation."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for volume-related accrual calculations (e.g. Cases, Units) for cross-category normalization."
  measures:
    - name: "total_accrual_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total accrued trade spend liability. Primary financial KPI for trade promotion P&L management and period-end close accuracy."
    - name: "total_accrual_records"
      expr: COUNT(DISTINCT CAST(accrual_id AS BIGINT))
      comment: "Total number of distinct accrual records. Volume metric for accrual processing workload and system throughput monitoring."
    - name: "total_baseline_volume"
      expr: SUM(CAST(baseline_volume AS DOUBLE))
      comment: "Total baseline volume units across accruals. Used to normalize accrual amounts per unit for cost-per-unit analysis."
    - name: "total_incremental_volume"
      expr: SUM(CAST(incremental_volume AS DOUBLE))
      comment: "Total incremental volume units generated above baseline. Measures volume uplift attributable to promoted activity for ROI validation."
    - name: "total_quantity_sold"
      expr: SUM(CAST(quantity_sold AS DOUBLE))
      comment: "Total quantity sold under accrual-eligible promotions. Drives accrual rate calculations and validates volume-based funding claims."
    - name: "avg_accrual_rate"
      expr: AVG(CAST(rate AS DOUBLE))
      comment: "Average accrual rate per unit. Benchmarks funding rate levels across promotions and identifies outliers requiring renegotiation."
    - name: "avg_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average ROI percentage across accruals. Measures return quality of accrual-funded promotions — low ROI triggers funding reallocation decisions."
    - name: "avg_gmroi"
      expr: AVG(CAST(gmroi AS DOUBLE))
      comment: "Average Gross Margin Return on Investment across accruals. Measures gross margin efficiency of accrual-funded trade spend."
    - name: "disputed_accrual_amount"
      expr: SUM(CASE WHEN is_disputed = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total accrual amount under dispute. Quantifies financial risk from disputed accruals — high values trigger escalation and legal review."
    - name: "dispute_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_disputed = TRUE THEN CAST(accrual_id AS BIGINT) END) / NULLIF(COUNT(DISTINCT CAST(accrual_id AS BIGINT)), 0), 2)
      comment: "Percentage of accrual records under dispute. Operational quality KPI — high dispute rates indicate documentation gaps or retailer alignment failures."
    - name: "accrual_amount_per_unit"
      expr: ROUND(SUM(CAST(amount AS DOUBLE)) / NULLIF(SUM(CAST(quantity_sold AS DOUBLE)), 0), 4)
      comment: "Average accrual cost per unit sold. Normalizes trade spend by volume to enable cross-promotion and cross-category cost benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_deduction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deduction management KPIs tracking claim volumes, dispute rates, settlement efficiency, and financial exposure. Drives accounts receivable recovery and deduction resolution prioritization."
  source: "`vibe_consumer_goods_v1`.`promotion`.`deduction`"
  dimensions:
    - name: "deduction_status"
      expr: deduction_status
      comment: "Current status of the deduction (e.g. Open, Approved, Disputed, Settled) for pipeline and aging analysis."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Dispute resolution state of the deduction for prioritizing recovery workload."
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method used to settle the deduction (e.g. Credit Memo, Check, Offset) for cash flow and process efficiency analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the deduction (e.g. Shortage, Pricing Error, Promotional Allowance) to identify root causes and systemic issues."
    - name: "dispute_reason"
      expr: dispute_reason
      comment: "Specific reason for disputing the deduction to drive root cause analysis and process improvement."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the deduction for workload management and SLA compliance tracking."
    - name: "deduction_month"
      expr: DATE_TRUNC('MONTH', deduction_date)
      comment: "Month the deduction was taken for time-series trending of deduction activity and aging."
    - name: "settlement_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month of deduction settlement for cash recovery timing and DSO impact analysis."
    - name: "business_unit_code"
      expr: business_unit_code
      comment: "Business unit associated with the deduction for organizational accountability and cost allocation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the deduction for multi-currency financial reporting."
    - name: "accrual_impact_flag"
      expr: accrual_impact_flag
      comment: "Whether the deduction impacts accrual balances (True/False) for accrual reconciliation and P&L accuracy."
  measures:
    - name: "total_deduction_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross deduction amount claimed. Primary financial exposure KPI — drives urgency of deduction management and recovery programs."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total deduction amount approved for settlement. Measures legitimate trade liability vs. total claims for accrual accuracy."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under active dispute. Quantifies financial risk in the dispute pipeline — high values trigger escalation and legal review."
    - name: "total_settled_amount"
      expr: SUM(CAST(settled_amount AS DOUBLE))
      comment: "Total amount successfully settled. Measures cash recovery effectiveness and settlement program throughput."
    - name: "total_roi_impact_amount"
      expr: SUM(CAST(roi_impact_amount AS DOUBLE))
      comment: "Total ROI impact from deductions. Quantifies the profitability drag of deduction activity on promotional ROI."
    - name: "total_deductions"
      expr: COUNT(DISTINCT CAST(deduction_id AS BIGINT))
      comment: "Total number of distinct deduction records. Volume metric for deduction workload management and staffing decisions."
    - name: "avg_gmroi_impact_percentage"
      expr: AVG(CAST(gmroi_impact_percentage AS DOUBLE))
      comment: "Average GMROI impact percentage from deductions. Measures gross margin erosion caused by deduction activity — critical for category profitability management."
    - name: "dispute_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_status IS NOT NULL AND dispute_status != '' THEN CAST(deduction_id AS BIGINT) END) / NULLIF(COUNT(DISTINCT CAST(deduction_id AS BIGINT)), 0), 2)
      comment: "Percentage of deductions under dispute. Operational quality KPI — high rates indicate systemic promotional execution or documentation failures."
    - name: "settlement_recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(settled_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Settled amount as a percentage of total deduction amount. Measures cash recovery effectiveness — low rates signal deduction management process gaps."
    - name: "approval_rate"
      expr: ROUND(100.0 * SUM(CAST(approved_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Approved amount as a percentage of total claimed amount. Measures legitimacy of deduction claims — low rates indicate over-claiming by retailers."
    - name: "avg_aging_days"
      expr: AVG(CAST(aging_days AS DOUBLE))
      comment: "Average age of open deductions in days. Tracks resolution velocity — high aging drives escalation and impacts working capital and DSO."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_deduction_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Settlement efficiency and financial closure KPIs for deduction management. Tracks settlement amounts, cycle times, SLA compliance, and partial settlement rates to optimize cash recovery operations."
  source: "`vibe_consumer_goods_v1`.`promotion`.`deduction_settlement`"
  dimensions:
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current status of the settlement record (e.g. Pending, Completed, Disputed) for pipeline management."
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method used to settle the deduction (e.g. Credit Memo, Check, Offset) for process efficiency analysis."
    - name: "resolution_code"
      expr: resolution_code
      comment: "Resolution outcome code for the settlement to identify most effective resolution pathways."
    - name: "settlement_reason_code"
      expr: settlement_reason_code
      comment: "Reason code for the settlement decision to drive root cause analysis and process improvement."
    - name: "is_partial_settlement"
      expr: is_partial_settlement
      comment: "Whether the settlement is partial (True/False). Tracks partial settlement prevalence and its impact on deduction aging."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether the settlement met SLA requirements (True/False). Measures operational compliance with service level commitments."
    - name: "settlement_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month of settlement for time-series cash recovery trending and period-end close management."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment for cash flow forecasting and working capital management."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the settlement for period-aligned financial reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the settlement for annual settlement performance benchmarking."
    - name: "business_unit_code"
      expr: business_unit_code
      comment: "Business unit responsible for the settlement for organizational accountability."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the settlement for multi-currency financial consolidation."
    - name: "dispute_resolution_method"
      expr: dispute_resolution_method
      comment: "Method used to resolve disputes within the settlement process for best-practice identification."
  measures:
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total amount settled across all deduction settlement records. Primary cash recovery KPI for trade promotion financial closure."
    - name: "total_settled_amount"
      expr: SUM(CAST(settled_amount AS DOUBLE))
      comment: "Total confirmed settled amount. Measures actual cash recovered vs. claimed for accounts receivable management."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved settlement amount. Tracks authorized financial liability for accrual reconciliation."
    - name: "total_deduction_claimed_amount"
      expr: SUM(CAST(deduction_claimed_amount AS DOUBLE))
      comment: "Total amount originally claimed by retailers. Baseline for recovery rate and approval rate calculations."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute within settlements. Quantifies unresolved financial risk in the settlement pipeline."
    - name: "total_settlements"
      expr: COUNT(DISTINCT CAST(deduction_settlement_id AS BIGINT))
      comment: "Total number of distinct settlement records. Volume metric for settlement processing capacity and throughput management."
    - name: "settlement_recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(settled_amount AS DOUBLE)) / NULLIF(SUM(CAST(deduction_claimed_amount AS DOUBLE)), 0), 2)
      comment: "Settled amount as a percentage of total claimed amount. Core cash recovery efficiency KPI — low rates trigger process improvement and retailer negotiation actions."
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN CAST(deduction_settlement_id AS BIGINT) END) / NULLIF(COUNT(DISTINCT CAST(deduction_settlement_id AS BIGINT)), 0), 2)
      comment: "Percentage of settlements completed within SLA. Operational excellence KPI — low compliance rates drive staffing, process, and system investment decisions."
    - name: "partial_settlement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_partial_settlement = TRUE THEN CAST(deduction_settlement_id AS BIGINT) END) / NULLIF(COUNT(DISTINCT CAST(deduction_settlement_id AS BIGINT)), 0), 2)
      comment: "Percentage of settlements that are partial. High partial settlement rates indicate complex disputes or insufficient documentation — drives process improvement."
    - name: "avg_settlement_cycle_time_days"
      expr: AVG(CAST(settlement_cycle_time_days AS DOUBLE))
      comment: "Average days to complete a deduction settlement. Key operational efficiency KPI — long cycle times increase working capital costs and retailer relationship risk."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_funding_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Funding agreement portfolio KPIs tracking committed funding, utilization, remaining balances, and ROI targets. Drives funding negotiation, renewal decisions, and trade investment governance."
  source: "`vibe_consumer_goods_v1`.`promotion`.`funding_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Lifecycle status of the funding agreement (e.g. Active, Expired, Terminated) for portfolio health monitoring."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of funding agreement (e.g. Annual, Quarterly, Event-Based) for portfolio structure analysis."
    - name: "funding_type"
      expr: funding_type
      comment: "Type of funding mechanism (e.g. Fixed, Variable, Performance-Based) for funding mix optimization."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the agreement (e.g. Pending, Approved, Rejected) for governance and authorization tracking."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the agreement becomes effective for portfolio timing and renewal planning."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the agreement expires for renewal pipeline management and funding continuity planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the funding agreement for multi-currency financial consolidation."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the agreement auto-renews (True/False) for renewal risk and pipeline management."
    - name: "renewal_flag"
      expr: renewal_flag
      comment: "Whether the agreement is a renewal of a prior agreement (True/False) for retention and relationship continuity analysis."
  measures:
    - name: "total_funding_amount"
      expr: SUM(CAST(total_funding_amount AS DOUBLE))
      comment: "Total funding committed across all agreements. Primary trade investment KPI for budget governance and supplier negotiation leverage."
    - name: "total_committed_amount"
      expr: SUM(CAST(total_committed_amount AS DOUBLE))
      comment: "Total contractually committed funding amount. Measures binding financial obligations for cash flow planning and liability management."
    - name: "total_accrued_to_date"
      expr: SUM(CAST(accrued_to_date_amount AS DOUBLE))
      comment: "Total funding accrued to date across agreements. Tracks liability recognition progress against committed amounts."
    - name: "total_paid_to_date"
      expr: SUM(CAST(paid_to_date_amount AS DOUBLE))
      comment: "Total funding paid to date. Measures cash outflow against commitments for working capital and payment schedule management."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance_amount AS DOUBLE))
      comment: "Total remaining uncommitted or unpaid funding balance. Critical for budget reallocation decisions and identifying under-utilized agreements."
    - name: "total_agreements"
      expr: COUNT(DISTINCT funding_agreement_id)
      comment: "Total number of distinct funding agreements. Portfolio size metric for relationship management and administrative capacity planning."
    - name: "avg_roi_target_percentage"
      expr: AVG(CAST(roi_target_percentage AS DOUBLE))
      comment: "Average ROI target percentage across funding agreements. Benchmarks return expectations set during negotiation vs. actuals for performance accountability."
    - name: "avg_gmroi_target"
      expr: AVG(CAST(gmroi_target AS DOUBLE))
      comment: "Average GMROI target across funding agreements. Measures gross margin return expectations embedded in agreements for category profitability governance."
    - name: "funding_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(accrued_to_date_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_funding_amount AS DOUBLE)), 0), 2)
      comment: "Accrued amount as a percentage of total funding. Measures funding consumption velocity — low utilization risks funding forfeiture; high utilization signals budget pressure."
    - name: "payment_execution_rate"
      expr: ROUND(100.0 * SUM(CAST(paid_to_date_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_committed_amount AS DOUBLE)), 0), 2)
      comment: "Paid amount as a percentage of committed amount. Measures payment execution against contractual obligations — low rates indicate payment delays or disputes."
    - name: "auto_renewal_agreements"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN funding_agreement_id END)
      comment: "Number of agreements with auto-renewal enabled. Tracks passive renewal exposure and drives proactive renegotiation planning."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_event_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SKU-level promotional performance KPIs measuring volume delivery, discount depth, trade spend efficiency, and ROI at the most granular event-SKU level. Drives SKU rationalization and promotional mix decisions."
  source: "`vibe_consumer_goods_v1`.`promotion`.`event_sku`"
  dimensions:
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement state of the event-SKU record for financial closure tracking."
    - name: "compliance_check_status"
      expr: compliance_check_status
      comment: "Compliance verification status of the event-SKU (e.g. Compliant, Non-Compliant, Pending) for execution quality management."
    - name: "display_location_type"
      expr: display_location_type
      comment: "Type of in-store display location (e.g. End Cap, Aisle, Checkout) to analyze display placement impact on volume lift."
    - name: "feature_type"
      expr: feature_type
      comment: "Type of feature advertising (e.g. Front Page, Interior, Digital) to measure media placement effectiveness."
    - name: "pricing_approval_status"
      expr: pricing_approval_status
      comment: "Approval status of the promoted price for governance and compliance tracking."
    - name: "is_featured_sku"
      expr: is_featured_sku
      comment: "Whether the SKU is featured in the promotion (True/False) to compare featured vs. non-featured SKU performance."
    - name: "promotion_start_month"
      expr: DATE_TRUNC('MONTH', promotion_effective_start_date)
      comment: "Month the SKU promotion becomes effective for time-series volume and spend trending."
    - name: "compliance_verified_month"
      expr: DATE_TRUNC('MONTH', compliance_verified_date)
      comment: "Month compliance was verified for tracking compliance closure velocity."
  measures:
    - name: "total_event_skus"
      expr: COUNT(DISTINCT event_sku_id)
      comment: "Total number of distinct event-SKU combinations. Measures promotional breadth and SKU coverage across events."
    - name: "total_planned_volume_units"
      expr: SUM(CAST(planned_promotional_volume_units AS DOUBLE))
      comment: "Total planned promotional volume units at SKU level. Baseline for volume attainment and lift measurement."
    - name: "total_actual_volume_units"
      expr: SUM(CAST(actual_promotional_volume_units AS DOUBLE))
      comment: "Total actual promotional volume units sold at SKU level. Primary volume delivery KPI for SKU-level promotional effectiveness."
    - name: "total_planned_volume_cases"
      expr: SUM(CAST(planned_promotional_volume_cases AS DOUBLE))
      comment: "Total planned promotional volume in cases. Used for logistics planning and warehouse capacity management."
    - name: "total_actual_volume_cases"
      expr: SUM(CAST(actual_promotional_volume_cases AS DOUBLE))
      comment: "Total actual promotional volume in cases. Measures case-level execution vs. plan for supply chain performance."
    - name: "total_incremental_lift_volume"
      expr: SUM(CAST(incremental_lift_volume_units AS DOUBLE))
      comment: "Total incremental volume units above baseline at SKU level. Measures true promotional contribution per SKU for ROI calculation."
    - name: "total_trade_spend"
      expr: SUM(CAST(total_trade_spend_amount AS DOUBLE))
      comment: "Total trade spend at SKU level. Core financial KPI for SKU-level spend allocation and efficiency analysis."
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrued trade liability at SKU level. Tracks financial exposure per SKU for accrual management."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deductions at SKU level. Identifies high-deduction SKUs for targeted deduction management."
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate amounts at SKU level. Measures rebate program contribution per SKU for program ROI analysis."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average promotional discount depth at SKU level. Informs pricing strategy and margin impact per SKU."
    - name: "avg_price_reduction_depth"
      expr: AVG(CAST(price_reduction_depth_percent AS DOUBLE))
      comment: "Average price reduction depth percentage. Measures promotional price aggressiveness — deep reductions risk margin erosion and price perception damage."
    - name: "avg_incremental_lift_percent"
      expr: AVG(CAST(incremental_lift_percent AS DOUBLE))
      comment: "Average incremental volume lift percentage at SKU level. Primary effectiveness KPI for SKU-level promotional ROI and future event planning."
    - name: "avg_promotional_roi_percent"
      expr: AVG(CAST(promotional_roi_percent AS DOUBLE))
      comment: "Average promotional ROI percentage at SKU level. Drives SKU rationalization decisions — low-ROI SKUs are candidates for promotional de-listing."
    - name: "avg_promotional_gmroi"
      expr: AVG(CAST(promotional_gmroi AS DOUBLE))
      comment: "Average promotional GMROI at SKU level. Measures gross margin return per SKU — critical for category management and assortment optimization."
    - name: "volume_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_promotional_volume_units AS DOUBLE)) / NULLIF(SUM(CAST(planned_promotional_volume_units AS DOUBLE)), 0), 2)
      comment: "Actual volume as a percentage of planned volume at SKU level. Execution quality KPI — below-target SKUs trigger compliance reviews and retailer follow-up."
    - name: "trade_spend_per_incremental_unit"
      expr: ROUND(SUM(CAST(total_trade_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(incremental_lift_volume_units AS DOUBLE)), 0), 4)
      comment: "Trade spend per incremental unit of volume generated. Efficiency KPI measuring cost of incremental volume — high values indicate poor promotional ROI at SKU level."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_check_status = 'Compliant' THEN event_sku_id END) / NULLIF(COUNT(DISTINCT event_sku_id), 0), 2)
      comment: "Percentage of event-SKU records with verified compliance. Measures retailer execution quality — low compliance rates drive deduction disputes and ROI shortfalls."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_trade_spend_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade spend allocation efficiency KPIs tracking planned vs. actual spend, variance, ROI, and volume delivery at the allocation level. Drives budget reallocation and spend optimization decisions."
  source: "`vibe_consumer_goods_v1`.`promotion`.`trade_spend_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the spend allocation (e.g. Planned, Committed, Actual, Settled) for financial lifecycle tracking."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the allocation for period-aligned financial reporting and close management."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the allocation for annual trade spend budgeting and year-over-year comparison."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy associated with the allocation for strategy-level spend efficiency analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allocation for multi-currency financial consolidation."
    - name: "is_active"
      expr: is_active
      comment: "Whether the allocation is currently active (True/False) for active portfolio management."
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month of the allocation for time-series spend trending and budget pacing analysis."
    - name: "promotion_start_month"
      expr: DATE_TRUNC('MONTH', promotion_start_date)
      comment: "Month the associated promotion starts for spend timing alignment analysis."
    - name: "volume_uom"
      expr: volume_uom
      comment: "Unit of measure for volume in the allocation (e.g. Cases, Units) for cross-category normalization."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total trade spend allocated across all allocation records. Primary budget commitment KPI for trade investment governance."
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual trade spend incurred. Measures realized spend vs. allocation for P&L accuracy and budget management."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed trade spend. Tracks binding financial obligations for cash flow planning."
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrued trade spend liability from allocations. Tracks P&L provisioning accuracy."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deduction amount associated with allocations. Measures deduction exposure within the allocation portfolio."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settled trade spend amount. Measures financial closure progress against allocated spend."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between planned and actual spend. Measures budget accuracy — large variances trigger reforecasting and accrual adjustments."
    - name: "total_actual_volume"
      expr: SUM(CAST(actual_volume AS DOUBLE))
      comment: "Total actual volume delivered under allocations. Measures volume execution against plan for promotional effectiveness assessment."
    - name: "total_target_volume"
      expr: SUM(CAST(target_volume AS DOUBLE))
      comment: "Total target volume for allocations. Baseline for volume attainment rate calculation."
    - name: "avg_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average ROI percentage across allocations. Measures return quality of allocated trade spend — drives reallocation to higher-ROI activities."
    - name: "avg_gmroi_percentage"
      expr: AVG(CAST(gmroi_percentage AS DOUBLE))
      comment: "Average GMROI percentage across allocations. Measures gross margin efficiency of allocated spend for category profitability management."
    - name: "spend_execution_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_amount AS DOUBLE)) / NULLIF(SUM(CAST(allocated_amount AS DOUBLE)), 0), 2)
      comment: "Actual spend as a percentage of allocated spend. Budget execution KPI — significant under-execution risks funding forfeiture; over-execution signals budget overrun."
    - name: "volume_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_volume AS DOUBLE)) / NULLIF(SUM(CAST(target_volume AS DOUBLE)), 0), 2)
      comment: "Actual volume as a percentage of target volume. Measures promotional volume delivery against plan — below-target rates trigger event redesign or retailer intervention."
    - name: "spend_per_unit_volume"
      expr: ROUND(SUM(CAST(actual_amount AS DOUBLE)) / NULLIF(SUM(CAST(actual_volume AS DOUBLE)), 0), 4)
      comment: "Actual trade spend per unit of volume delivered. Efficiency KPI normalizing spend by volume — enables cross-promotion and cross-category cost benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_promoted_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promoted pricing KPIs tracking price reduction depth, margin impact, volume lift estimates, and pricing strategy effectiveness. Drives pricing governance and promotional price optimization."
  source: "`vibe_consumer_goods_v1`.`promotion`.`promoted_price`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the promoted price (e.g. Pending, Approved, Rejected) for pricing governance tracking."
    - name: "pricing_strategy_type"
      expr: pricing_strategy_type
      comment: "Type of pricing strategy applied (e.g. EDLP, Hi-Lo, TPR) for strategy-level effectiveness comparison."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding for the promoted price (e.g. Manufacturer, Retailer, Co-op) for cost attribution."
    - name: "country_code"
      expr: country_code
      comment: "Country where the promoted price applies for geographic pricing analysis."
    - name: "region_code"
      expr: region_code
      comment: "Region where the promoted price applies for regional pricing strategy benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the promoted price for multi-currency financial reporting."
    - name: "is_advertised"
      expr: is_advertised
      comment: "Whether the promoted price is advertised (True/False) to compare advertised vs. non-advertised price effectiveness."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Whether the promoted price can be stacked with other promotions (True/False) for discount depth risk management."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the promoted price becomes effective for time-series pricing trend analysis."
    - name: "effective_end_month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
      comment: "Month the promoted price expires for pricing calendar management."
  measures:
    - name: "total_promoted_prices"
      expr: COUNT(DISTINCT CAST(promoted_price_id AS BIGINT))
      comment: "Total number of distinct promoted price records. Measures pricing portfolio breadth and promotional price management workload."
    - name: "total_promotional_allowance_amount"
      expr: SUM(CAST(promotional_allowance_amount AS DOUBLE))
      comment: "Total promotional allowance granted. Measures total price support investment for margin impact analysis."
    - name: "total_promotional_price_amount"
      expr: SUM(CAST(promotional_price_amount AS DOUBLE))
      comment: "Total promoted price value across all records. Used for average promoted price benchmarking and price corridor analysis."
    - name: "total_estimated_volume_lift"
      expr: SUM(CAST(estimated_volume_lift AS DOUBLE))
      comment: "Total estimated volume lift from promoted prices. Forward-looking demand signal for supply chain planning and promotional ROI forecasting."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average promotional discount percentage. Measures price reduction depth — deep discounts risk margin erosion and long-term price perception damage."
    - name: "avg_price_reduction_percentage"
      expr: AVG(CAST(price_reduction_percentage AS DOUBLE))
      comment: "Average price reduction percentage across promoted prices. Benchmarks promotional price aggressiveness for strategy governance."
    - name: "avg_retailer_margin_percentage"
      expr: AVG(CAST(retailer_margin_percentage AS DOUBLE))
      comment: "Average retailer margin percentage at promoted price. Measures retailer profitability impact of promotional pricing — critical for retailer relationship management."
    - name: "avg_scan_back_rate"
      expr: AVG(CAST(scan_back_rate AS DOUBLE))
      comment: "Average scan-back rate across promoted prices. Measures per-unit funding rate for scan-back promotions — drives accrual accuracy and settlement efficiency."
    - name: "avg_cost_of_goods_sold"
      expr: AVG(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Average COGS at promoted price level. Enables gross margin calculation at promoted price and informs minimum viable promotional price floors."
    - name: "gross_margin_at_promoted_price"
      expr: ROUND(100.0 * (SUM(CAST(promotional_price_amount AS DOUBLE)) - SUM(CAST(cost_of_goods_sold AS DOUBLE))) / NULLIF(SUM(CAST(promotional_price_amount AS DOUBLE)), 0), 2)
      comment: "Gross margin percentage at promoted price. Critical profitability KPI — negative or near-zero margins at promoted prices trigger pricing strategy review and minimum price enforcement."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`promotion_trade_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade calendar planning KPIs tracking promotional event coverage, spend planning, and calendar utilization. Drives annual promotional planning, retailer calendar negotiations, and budget pacing."
  source: "`vibe_consumer_goods_v1`.`promotion`.`trade_calendar`"
  dimensions:
    - name: "calendar_status"
      expr: calendar_status
      comment: "Status of the trade calendar (e.g. Draft, Active, Locked, Closed) for planning lifecycle management."
    - name: "planning_cycle"
      expr: planning_cycle
      comment: "Planning cycle associated with the calendar (e.g. Annual, Quarterly) for planning cadence analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the trade calendar for annual planning and year-over-year comparison."
    - name: "country_code"
      expr: country_code
      comment: "Country of the trade calendar for geographic planning coverage analysis."
    - name: "region_code"
      expr: region_code
      comment: "Region of the trade calendar for regional planning and spend allocation analysis."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy embedded in the calendar (e.g. EDLP, Hi-Lo) for strategy-level planning analysis."
    - name: "is_baseline_calendar"
      expr: is_baseline_calendar
      comment: "Whether this is a baseline calendar (True/False) for distinguishing baseline vs. incremental planning scenarios."
    - name: "calendar_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the calendar period starts for time-series planning coverage analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the trade calendar for multi-currency financial planning."
  measures:
    - name: "total_calendars"
      expr: COUNT(DISTINCT trade_calendar_id)
      comment: "Total number of distinct trade calendars. Measures planning portfolio breadth and retailer coverage."
    - name: "total_planned_trade_spend"
      expr: SUM(CAST(total_planned_trade_spend AS DOUBLE))
      comment: "Total planned trade spend across all calendars. Primary financial planning KPI for annual trade budget governance and retailer investment allocation."
    - name: "event_execution_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_event_count AS DOUBLE)) / NULLIF(SUM(CAST(planned_event_count AS DOUBLE)), 0), 2)
      comment: "Actual events as a percentage of planned events. Measures promotional calendar execution quality — low rates indicate retailer compliance or planning accuracy issues."
    - name: "avg_planned_events_per_calendar"
      expr: AVG(CAST(planned_event_count AS DOUBLE))
      comment: "Average number of planned events per trade calendar. Benchmarks promotional intensity and planning ambition across retailers and regions."
    - name: "avg_actual_events_per_calendar"
      expr: AVG(CAST(actual_event_count AS DOUBLE))
      comment: "Average number of actual events executed per trade calendar. Measures execution throughput and retailer engagement."
    - name: "avg_planned_spend_per_calendar"
      expr: AVG(CAST(total_planned_trade_spend AS DOUBLE))
      comment: "Average planned trade spend per calendar. Enables per-retailer and per-region spend benchmarking for investment allocation decisions."
$$;