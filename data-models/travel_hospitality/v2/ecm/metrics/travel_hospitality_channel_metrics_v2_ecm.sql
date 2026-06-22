-- Metric views for domain: channel | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 18:44:46

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core channel booking performance metrics tracking revenue, volume, cancellations, and cost of acquisition across all distribution channels. Primary KPI surface for channel mix optimization and revenue management decisions."
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_booking`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel type (OTA, GDS, Direct, Wholesale, etc.) for channel mix analysis."
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the booking (confirmed, cancelled, modified) for funnel and conversion analysis."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment code (transient, group, corporate, leisure) for segment-level revenue attribution."
    - name: "rate_type"
      expr: rate_type
      comment: "Rate type applied to the booking (BAR, negotiated, package, promotional) for rate strategy analysis."
    - name: "source_country"
      expr: source_country
      comment: "Country of booking origin for geographic demand analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency revenue reporting."
    - name: "check_in_date"
      expr: DATE_TRUNC('month', check_in_date)
      comment: "Check-in month for arrival demand trend analysis."
    - name: "booking_timestamp_month"
      expr: DATE_TRUNC('month', booking_timestamp)
      comment: "Month the booking was made for booking pace and pickup reporting."
    - name: "is_cancelled"
      expr: is_cancelled
      comment: "Boolean flag indicating whether the booking was cancelled, used for cancellation rate segmentation."
    - name: "is_rate_parity_compliant"
      expr: is_rate_parity_compliant
      comment: "Whether the booking was made at a rate-parity-compliant price, for parity compliance monitoring."
    - name: "corporate_account_code"
      expr: corporate_account_code
      comment: "Corporate account identifier for negotiated-rate volume tracking."
  measures:
    - name: "total_bookings"
      expr: COUNT(1)
      comment: "Total number of channel bookings. Baseline volume KPI for channel productivity measurement."
    - name: "total_gross_booking_value"
      expr: SUM(CAST(gross_booking_value AS DOUBLE))
      comment: "Total gross booking value in transaction currency. Primary revenue contribution metric for each channel."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after commissions and fees. Measures true channel revenue contribution to the property."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid to the channel. Key cost-of-distribution metric for channel profitability analysis."
    - name: "total_channel_commission_amount"
      expr: SUM(CAST(channel_commission_amount AS DOUBLE))
      comment: "Total channel-specific commission accrued. Used to compare commission burden across channel types."
    - name: "total_connectivity_fee_amount"
      expr: SUM(CAST(connectivity_fee_amount AS DOUBLE))
      comment: "Total connectivity fees charged by the channel. Contributes to total cost of distribution."
    - name: "avg_adr"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate across channel bookings. Measures rate quality delivered by each channel."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage across bookings. Benchmarks cost efficiency across channels."
    - name: "cancellation_count"
      expr: COUNT(CASE WHEN is_cancelled = TRUE THEN 1 END)
      comment: "Number of cancelled bookings. High cancellation rates signal channel quality or policy issues."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cancelled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings that were cancelled. Critical channel quality and demand reliability metric."
    - name: "avg_booking_value"
      expr: AVG(CAST(booking_amount AS DOUBLE))
      comment: "Average booking value per transaction. Indicates channel's ability to drive higher-value reservations."
    - name: "rate_parity_violation_count"
      expr: COUNT(CASE WHEN is_rate_parity_compliant = FALSE THEN 1 END)
      comment: "Number of bookings where rate parity was violated. Drives contractual compliance and brand protection actions."
    - name: "rate_parity_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_rate_parity_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings in rate parity compliance. Monitors adherence to channel contract obligations."
    - name: "net_revenue_per_booking"
      expr: ROUND(SUM(CAST(net_revenue_amount AS DOUBLE)) / NULLIF(COUNT(1), 0), 2)
      comment: "Net revenue per booking after commissions. Measures true yield per transaction by channel."
    - name: "commission_cost_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(commission_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_booking_value AS DOUBLE)), 0), 2)
      comment: "Commission as a percentage of gross booking value. Core cost-of-distribution efficiency metric."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel master entity metrics covering channel portfolio health, cost structure, and configuration quality. Used by revenue and distribution leadership to evaluate channel mix strategy."
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Type of distribution channel (OTA, GDS, Direct, Wholesale, CRS) for portfolio segmentation."
    - name: "channel_category"
      expr: channel_category
      comment: "Broader category grouping of channels for strategic channel mix reporting."
    - name: "channel_status"
      expr: channel_status
      comment: "Operational status of the channel (active, inactive, suspended) for portfolio health monitoring."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic market scope of the channel for regional distribution strategy analysis."
    - name: "primary_market_country_code"
      expr: primary_market_country_code
      comment: "Primary country market served by the channel for geographic demand attribution."
    - name: "commission_basis"
      expr: commission_basis
      comment: "Basis on which commission is calculated (per booking, per room night, percentage of revenue)."
    - name: "payment_model"
      expr: CAST(payment_model AS STRING)
      comment: "Payment model type for the channel (merchant, agency, net rate) for financial flow analysis."
    - name: "rate_parity_required"
      expr: rate_parity_required
      comment: "Whether rate parity is contractually required for this channel."
    - name: "loyalty_bookings_eligible"
      expr: loyalty_bookings_eligible
      comment: "Whether bookings through this channel are eligible for loyalty points accrual."
    - name: "activation_date_month"
      expr: DATE_TRUNC('month', activation_date)
      comment: "Month the channel was activated for channel onboarding trend analysis."
  measures:
    - name: "total_active_channels"
      expr: COUNT(CASE WHEN channel_status = 'active' THEN 1 END)
      comment: "Number of currently active distribution channels. Measures breadth of active distribution network."
    - name: "total_channels"
      expr: COUNT(1)
      comment: "Total number of channels in the portfolio including all statuses."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate across all channels. Benchmarks cost of distribution across the portfolio."
    - name: "avg_booking_fee_usd"
      expr: AVG(CAST(booking_fee_usd AS DOUBLE))
      comment: "Average per-booking fee charged by channels. Contributes to total cost of distribution analysis."
    - name: "avg_connectivity_fee_usd"
      expr: AVG(CAST(connectivity_fee_usd AS DOUBLE))
      comment: "Average monthly connectivity fee across channels. Key fixed cost component of channel management."
    - name: "total_connectivity_fee_usd"
      expr: SUM(CAST(connectivity_fee_usd AS DOUBLE))
      comment: "Total connectivity fees across all channels. Measures fixed technology cost of distribution infrastructure."
    - name: "avg_sla_uptime_pct"
      expr: AVG(CAST(sla_uptime_pct AS DOUBLE))
      comment: "Average SLA uptime percentage across channels. Measures distribution technology reliability."
    - name: "loyalty_eligible_channel_count"
      expr: COUNT(CASE WHEN loyalty_bookings_eligible = TRUE THEN 1 END)
      comment: "Number of channels supporting loyalty accrual. Measures loyalty program distribution reach."
    - name: "rate_parity_required_channel_count"
      expr: COUNT(CASE WHEN rate_parity_required = TRUE THEN 1 END)
      comment: "Number of channels with contractual rate parity obligations. Drives compliance monitoring scope."
    - name: "pci_compliant_channel_count"
      expr: COUNT(CASE WHEN pci_compliant = TRUE THEN 1 END)
      comment: "Number of PCI-compliant channels. Critical for payment security risk management."
    - name: "pci_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pci_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of channels that are PCI compliant. Measures payment security posture across distribution."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_commission_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission accrual metrics tracking total commission liability, payment status, and cost of acquisition by channel. Used by finance and revenue management to monitor distribution cost and commission payables."
  source: "`vibe_travel_hospitality_v1`.`channel`.`commission_accrual`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Channel type for commission cost attribution by distribution channel category."
    - name: "commission_type"
      expr: commission_type
      comment: "Type of commission (base, override, promotional) for commission structure analysis."
    - name: "commission_basis"
      expr: commission_basis
      comment: "Basis for commission calculation (room revenue, total revenue, per booking) for cost modeling."
    - name: "accrual_status"
      expr: accrual_status
      comment: "Status of the commission accrual (pending, invoiced, paid, disputed) for payables management."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment for commission cost attribution by business segment."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local currency of the commission transaction for multi-currency cost reporting."
    - name: "accrual_date_month"
      expr: DATE_TRUNC('month', accrual_date)
      comment: "Month of commission accrual for trend analysis and period-over-period comparison."
    - name: "payment_due_date_month"
      expr: DATE_TRUNC('month', payment_due_date)
      comment: "Month commission payment is due for cash flow and payables forecasting."
    - name: "is_commissionable"
      expr: is_commissionable
      comment: "Whether the booking is commissionable, for filtering non-commissionable volume."
  measures:
    - name: "total_commission_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total commission accrued across all bookings. Primary cost-of-distribution liability metric."
    - name: "total_commission_amount_base"
      expr: SUM(CAST(commission_amount_base AS DOUBLE))
      comment: "Total base commission in base currency. Used for standardized cross-currency cost comparison."
    - name: "total_commission_amount_local"
      expr: SUM(CAST(commission_amount_local AS DOUBLE))
      comment: "Total commission in local currency. Used for local market cost reporting and payables."
    - name: "total_gross_booking_value"
      expr: SUM(CAST(gross_booking_value AS DOUBLE))
      comment: "Total gross booking value underlying commission accruals. Denominator for commission rate validation."
    - name: "total_cost_of_acquisition"
      expr: SUM(CAST(total_cost_of_acquisition AS DOUBLE))
      comment: "Total cost of acquisition including commission and connectivity fees. True channel cost metric."
    - name: "total_connectivity_fee_amount"
      expr: SUM(CAST(connectivity_fee_amount AS DOUBLE))
      comment: "Total connectivity fees accrued alongside commissions. Measures technology cost of distribution."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average effective commission rate across accruals. Benchmarks negotiated vs. actual commission rates."
    - name: "avg_adr"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate on commissionable bookings. Measures rate quality of commission-generating bookings."
    - name: "commission_to_gbv_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(accrual_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_booking_value AS DOUBLE)), 0), 2)
      comment: "Commission as a percentage of gross booking value. Core cost-of-distribution efficiency ratio."
    - name: "cost_of_acquisition_per_booking"
      expr: ROUND(SUM(CAST(total_cost_of_acquisition AS DOUBLE)) / NULLIF(COUNT(1), 0), 2)
      comment: "Average total cost of acquisition per booking. Measures channel efficiency for investment decisions."
    - name: "disputed_accrual_count"
      expr: COUNT(CASE WHEN accrual_status = 'disputed' THEN 1 END)
      comment: "Number of commission accruals in dispute. Signals channel relationship and billing quality issues."
    - name: "avg_fx_rate"
      expr: AVG(CAST(fx_rate AS DOUBLE))
      comment: "Average FX rate applied to commission conversions. Used for currency risk monitoring in commission payables."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_rate_parity_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate parity audit metrics tracking parity violations, variance severity, and resolution performance across channels. Critical for brand protection, contract compliance, and revenue integrity management."
  source: "`vibe_travel_hospitality_v1`.`channel`.`rate_parity_audit`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Channel type where parity was audited for identifying which channel categories drive most violations."
    - name: "audit_status"
      expr: audit_status
      comment: "Status of the audit record (open, resolved, escalated) for compliance workflow management."
    - name: "parity_status"
      expr: parity_status
      comment: "Parity outcome (compliant, violation, under review) for compliance rate reporting."
    - name: "violation_severity"
      expr: violation_severity
      comment: "Severity level of the parity violation (low, medium, high, critical) for prioritized remediation."
    - name: "violation_type"
      expr: violation_type
      comment: "Type of parity violation (rate, availability, content) for root cause analysis."
    - name: "monitoring_source"
      expr: monitoring_source
      comment: "Source of the parity monitoring (automated tool, manual review, OTA report) for audit coverage analysis."
    - name: "rate_plan_code"
      expr: rate_plan_code
      comment: "Rate plan involved in the audit for identifying which rate plans are most prone to parity issues."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the audited rates for multi-currency parity analysis."
    - name: "stay_date_month"
      expr: DATE_TRUNC('month', stay_date)
      comment: "Stay month of the audited rate for seasonal parity trend analysis."
    - name: "audit_timestamp_month"
      expr: DATE_TRUNC('month', audit_timestamp)
      comment: "Month the audit was performed for audit activity trend reporting."
    - name: "is_parity_violation"
      expr: is_parity_violation
      comment: "Boolean flag for parity violation, used for quick compliance segmentation."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of rate parity audits conducted. Measures monitoring coverage and activity."
    - name: "total_violations"
      expr: COUNT(CASE WHEN is_parity_violation = TRUE THEN 1 END)
      comment: "Total number of confirmed rate parity violations. Primary compliance risk metric."
    - name: "violation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_parity_violation = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits resulting in a parity violation. Core channel compliance KPI for executive reporting."
    - name: "avg_rate_variance_pct"
      expr: AVG(CAST(rate_variance_pct AS DOUBLE))
      comment: "Average rate variance percentage where violations occurred. Measures severity of parity breaches."
    - name: "avg_rate_variance_amount"
      expr: AVG(CAST(rate_variance_amount AS DOUBLE))
      comment: "Average absolute rate variance amount in currency. Quantifies financial impact of parity violations."
    - name: "total_rate_variance_amount"
      expr: SUM(CAST(rate_variance_amount AS DOUBLE))
      comment: "Total rate variance amount across all violations. Measures aggregate revenue risk from parity breaches."
    - name: "avg_direct_rate"
      expr: AVG(CAST(direct_rate AS DOUBLE))
      comment: "Average direct booking rate observed during audits. Benchmarks direct channel rate competitiveness."
    - name: "avg_observed_rate"
      expr: AVG(CAST(observed_rate AS DOUBLE))
      comment: "Average rate observed on the channel during audit. Measures channel rate positioning vs. direct."
    - name: "avg_contracted_parity_rate"
      expr: AVG(CAST(contracted_parity_rate AS DOUBLE))
      comment: "Average contracted parity rate. Baseline for measuring compliance against contractual obligations."
    - name: "avg_tolerance_threshold_pct"
      expr: AVG(CAST(tolerance_threshold_pct AS DOUBLE))
      comment: "Average tolerance threshold applied in audits. Contextualizes violation counts against agreed thresholds."
    - name: "open_dispute_count"
      expr: COUNT(CASE WHEN dispute_raised_date IS NOT NULL AND dispute_resolved_date IS NULL THEN 1 END)
      comment: "Number of parity disputes raised but not yet resolved. Measures outstanding compliance remediation workload."
    - name: "resolved_dispute_count"
      expr: COUNT(CASE WHEN dispute_resolved_date IS NOT NULL THEN 1 END)
      comment: "Number of parity disputes successfully resolved. Measures compliance team effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_inventory_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel inventory allocation metrics tracking room allocation utilization, sell-through rates, and overbooking exposure by channel and room type. Addresses VREQ-024 by providing rich business metrics over this previously stub entity."
  source: "`vibe_travel_hospitality_v1`.`channel`.`inventory_allocation`"
  dimensions:
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of inventory allocation (allotment, free-sale, guaranteed, contingency) for allocation strategy analysis."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the allocation (active, released, expired, consumed) for portfolio health monitoring."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate inventory (manual, RMS-generated, contract-driven) for process efficiency analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allocated rate for multi-currency revenue analysis."
    - name: "stay_date_month"
      expr: DATE_TRUNC('month', stay_date)
      comment: "Stay month of the allocation for demand pattern and seasonal analysis."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the allocation became effective for allocation lifecycle trend analysis."
    - name: "is_freesale"
      expr: is_freesale
      comment: "Whether the allocation is a free-sale (unlimited) allocation vs. fixed allotment."
    - name: "is_guaranteed"
      expr: is_guaranteed
      comment: "Whether the allocation is guaranteed, indicating contractual commitment level."
    - name: "stop_sell_flag"
      expr: stop_sell_flag
      comment: "Whether stop-sell is active on this allocation, for demand management monitoring."
    - name: "overbooking_allowed"
      expr: overbooking_allowed
      comment: "Whether overbooking is permitted on this allocation for risk exposure segmentation."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Last Room Availability flag indicating whether the channel must be offered the last available room."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of inventory allocation records. Baseline measure for allocation portfolio size."
    - name: "total_allocated_rate_amount"
      expr: SUM(CAST(allocated_rate_amount AS DOUBLE))
      comment: "Total value of allocated rate amounts across all allocations. Measures revenue potential of allocated inventory."
    - name: "total_allocation_rate_amount"
      expr: SUM(CAST(allocation_rate_amount AS DOUBLE))
      comment: "Total allocation rate amount. Used alongside allocated_rate_amount for rate variance analysis."
    - name: "total_negotiated_rate_amount"
      expr: SUM(CAST(negotiated_rate_amount AS DOUBLE))
      comment: "Total negotiated rate value across allocations. Measures contracted revenue from negotiated inventory."
    - name: "avg_utilization_pct"
      expr: AVG(CAST(utilization_pct AS DOUBLE))
      comment: "Average inventory utilization percentage across allocations. Core efficiency metric for allocation management."
    - name: "avg_wash_factor_pct"
      expr: AVG(CAST(wash_factor_pct AS DOUBLE))
      comment: "Average wash factor applied to allocations. Measures expected attrition from contracted allotments."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate on allocated inventory. Measures cost of distribution for allocated rooms."
    - name: "avg_overbooking_limit_pct"
      expr: AVG(CAST(overbooking_limit_pct AS DOUBLE))
      comment: "Average overbooking limit percentage across allocations. Measures aggregate overbooking risk exposure."
    - name: "stop_sell_allocation_count"
      expr: COUNT(CASE WHEN stop_sell_flag = TRUE THEN 1 END)
      comment: "Number of allocations with stop-sell active. Measures demand management intervention frequency."
    - name: "stop_sell_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN stop_sell_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations with stop-sell active. Indicates demand pressure and inventory tightness."
    - name: "freesale_allocation_count"
      expr: COUNT(CASE WHEN is_freesale = TRUE THEN 1 END)
      comment: "Number of free-sale allocations. Measures exposure to unlimited-availability channel commitments."
    - name: "guaranteed_allocation_count"
      expr: COUNT(CASE WHEN is_guaranteed = TRUE THEN 1 END)
      comment: "Number of guaranteed allocations. Measures contractual inventory commitment level."
    - name: "avg_rate_amount"
      expr: AVG(CAST(rate_amount AS DOUBLE))
      comment: "Average rate amount across all allocations. Benchmarks pricing level of allocated inventory."
    - name: "overbooking_allowed_count"
      expr: COUNT(CASE WHEN overbooking_allowed = TRUE THEN 1 END)
      comment: "Number of allocations where overbooking is permitted. Quantifies overbooking risk exposure in the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_commission_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission schedule metrics tracking commission rate structures, tiered pricing, and schedule coverage across channels. Used by finance and commercial teams to manage and optimize commission agreements."
  source: "`vibe_travel_hospitality_v1`.`channel`.`commission_schedule`"
  dimensions:
    - name: "commission_basis"
      expr: commission_basis
      comment: "Basis for commission calculation (room revenue, total revenue, per booking) for cost structure analysis."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the commission schedule (active, expired, pending) for schedule portfolio management."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of commission billing (monthly, quarterly, per booking) for cash flow planning."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment the schedule applies to for segment-level commission cost analysis."
    - name: "auto_accrual_enabled"
      expr: auto_accrual_enabled
      comment: "Whether commission accrual is automated for this schedule, measuring automation coverage."
    - name: "applies_to_cancellations"
      expr: applies_to_cancellations
      comment: "Whether commission applies to cancellations, for cancellation cost liability analysis."
    - name: "applies_to_no_shows"
      expr: applies_to_no_shows
      comment: "Whether commission applies to no-shows, for no-show cost liability analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the commission schedule became effective for schedule lifecycle trend analysis."
  measures:
    - name: "total_schedules"
      expr: COUNT(1)
      comment: "Total number of commission schedules. Measures breadth of commission agreement portfolio."
    - name: "active_schedule_count"
      expr: COUNT(CASE WHEN schedule_status = 'active' THEN 1 END)
      comment: "Number of currently active commission schedules. Measures active commission obligation scope."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate across all schedules. Benchmarks overall commission cost structure."
    - name: "avg_flat_fee_amount"
      expr: AVG(CAST(flat_fee_amount AS DOUBLE))
      comment: "Average flat fee amount where applicable. Measures fixed commission cost component."
    - name: "avg_max_commission_amount"
      expr: AVG(CAST(max_commission_amount AS DOUBLE))
      comment: "Average maximum commission cap across schedules. Measures commission liability ceiling."
    - name: "avg_min_commission_amount"
      expr: AVG(CAST(min_commission_amount AS DOUBLE))
      comment: "Average minimum commission floor across schedules. Measures guaranteed commission floor obligations."
    - name: "avg_tier_1_rate_pct"
      expr: AVG(CAST(tier_1_rate_pct AS DOUBLE))
      comment: "Average tier-1 commission rate. Benchmarks base tier commission cost across channel agreements."
    - name: "avg_tier_2_rate_pct"
      expr: AVG(CAST(tier_2_rate_pct AS DOUBLE))
      comment: "Average tier-2 commission rate. Measures incremental commission cost at higher volume tiers."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms_days AS DOUBLE))
      comment: "Average payment terms in days across commission schedules. Measures commission payables timing."
    - name: "auto_accrual_schedule_count"
      expr: COUNT(CASE WHEN auto_accrual_enabled = TRUE THEN 1 END)
      comment: "Number of schedules with automated accrual. Measures commission automation coverage."
    - name: "cancellation_commission_schedule_count"
      expr: COUNT(CASE WHEN applies_to_cancellations = TRUE THEN 1 END)
      comment: "Number of schedules where commission applies to cancellations. Quantifies cancellation commission liability."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_rate_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel rate plan metrics tracking rate loading status, rate adjustment structures, and plan coverage across channels. Used by revenue management and distribution teams to monitor rate plan health and channel rate strategy."
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan`"
  dimensions:
    - name: "channel_rate_plan_status"
      expr: channel_rate_plan_status
      comment: "Status of the channel rate plan (active, inactive, pending) for rate plan portfolio health monitoring."
    - name: "rate_plan_type"
      expr: rate_plan_type
      comment: "Type of rate plan (BAR, negotiated, package, promotional) for rate strategy segmentation."
    - name: "rate_loading_status"
      expr: rate_loading_status
      comment: "Status of rate loading to the channel (loaded, pending, failed) for distribution readiness monitoring."
    - name: "rate_derivation_method"
      expr: rate_derivation_method
      comment: "Method used to derive the channel rate (flat, percentage, offset) for rate structure analysis."
    - name: "rate_adjustment_type"
      expr: rate_adjustment_type
      comment: "Type of rate adjustment applied (markup, markdown, flat) for pricing strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rate plan for multi-currency rate management."
    - name: "meal_plan_code"
      expr: meal_plan_code
      comment: "Meal plan included in the rate (room only, B&B, half board) for package rate analysis."
    - name: "is_rate_parity_applicable"
      expr: is_rate_parity_applicable
      comment: "Whether rate parity applies to this rate plan for compliance scope identification."
    - name: "is_refundable"
      expr: is_refundable
      comment: "Whether the rate plan is refundable for cancellation policy and demand analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the rate plan became effective for rate plan lifecycle trend analysis."
  measures:
    - name: "total_rate_plans"
      expr: COUNT(1)
      comment: "Total number of channel rate plans. Measures breadth of rate plan distribution portfolio."
    - name: "active_rate_plan_count"
      expr: COUNT(CASE WHEN channel_rate_plan_status = 'active' THEN 1 END)
      comment: "Number of currently active channel rate plans. Measures active rate distribution coverage."
    - name: "avg_base_rate_amount"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate amount across channel rate plans. Benchmarks rate level across distribution."
    - name: "avg_channel_rate_amount"
      expr: AVG(CAST(channel_rate_amount AS DOUBLE))
      comment: "Average channel-specific rate amount. Measures actual rate delivered to each channel."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate on channel rate plans. Measures cost of distribution by rate plan."
    - name: "avg_connectivity_fee_amount"
      expr: AVG(CAST(connectivity_fee_amount AS DOUBLE))
      comment: "Average connectivity fee on rate plans. Measures technology cost component of rate distribution."
    - name: "avg_rate_adjustment_value"
      expr: AVG(CAST(rate_adjustment_value AS DOUBLE))
      comment: "Average rate adjustment value applied to channel rates. Measures magnitude of channel rate modifications."
    - name: "rate_loading_failure_count"
      expr: COUNT(CASE WHEN rate_loading_status = 'failed' THEN 1 END)
      comment: "Number of rate plans with failed loading status. Measures distribution technology failure impact."
    - name: "rate_loading_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rate_loading_status = 'loaded' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rate plans successfully loaded to channels. Measures distribution readiness and reliability."
    - name: "parity_applicable_rate_plan_count"
      expr: COUNT(CASE WHEN is_rate_parity_applicable = TRUE THEN 1 END)
      comment: "Number of rate plans subject to rate parity requirements. Defines parity compliance monitoring scope."
    - name: "refundable_rate_plan_count"
      expr: COUNT(CASE WHEN is_refundable = TRUE THEN 1 END)
      comment: "Number of refundable rate plans. Measures cancellation risk exposure in the rate plan portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_gds_connection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GDS connection performance and health metrics tracking uptime, commission rates, and connectivity quality across GDS networks. Used by distribution and technology teams to manage GDS channel performance."
  source: "`vibe_travel_hospitality_v1`.`channel`.`gds_connection`"
  dimensions:
    - name: "gds_name"
      expr: gds_name
      comment: "Name of the GDS network (Amadeus, Sabre, Travelport) for GDS-specific performance analysis."
    - name: "connection_status"
      expr: connection_status
      comment: "Current connection status (active, inactive, degraded) for GDS health monitoring."
    - name: "connectivity_type"
      expr: connectivity_type
      comment: "Type of GDS connectivity (direct, switch, API) for technology architecture analysis."
    - name: "gds_tier"
      expr: gds_tier
      comment: "GDS partnership tier for preferred partner program management."
    - name: "health_check_status"
      expr: health_check_status
      comment: "Latest health check status for real-time GDS connectivity monitoring."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment served by the GDS connection for segment-level distribution analysis."
    - name: "lra_enabled"
      expr: lra_enabled
      comment: "Whether Last Room Availability is enabled on this GDS connection."
    - name: "activation_date_month"
      expr: DATE_TRUNC('month', activation_date)
      comment: "Month the GDS connection was activated for onboarding trend analysis."
  measures:
    - name: "total_gds_connections"
      expr: COUNT(1)
      comment: "Total number of GDS connections. Measures GDS distribution network breadth."
    - name: "active_connection_count"
      expr: COUNT(CASE WHEN connection_status = 'active' THEN 1 END)
      comment: "Number of active GDS connections. Measures live GDS distribution coverage."
    - name: "avg_uptime_sla_pct"
      expr: AVG(CAST(uptime_sla_pct AS DOUBLE))
      comment: "Average GDS uptime SLA percentage. Measures distribution technology reliability across GDS networks."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate across GDS connections. Benchmarks GDS cost of distribution."
    - name: "avg_connectivity_fee_monthly_usd"
      expr: AVG(CAST(connectivity_fee_monthly_usd AS DOUBLE))
      comment: "Average monthly connectivity fee per GDS connection. Measures fixed GDS technology cost."
    - name: "total_connectivity_fee_monthly_usd"
      expr: SUM(CAST(connectivity_fee_monthly_usd AS DOUBLE))
      comment: "Total monthly GDS connectivity fees. Measures aggregate fixed cost of GDS distribution infrastructure."
    - name: "avg_segment_fee_usd"
      expr: AVG(CAST(segment_fee_usd AS DOUBLE))
      comment: "Average per-segment fee charged by GDS. Measures variable cost of GDS bookings."
    - name: "lra_enabled_connection_count"
      expr: COUNT(CASE WHEN lra_enabled = TRUE THEN 1 END)
      comment: "Number of GDS connections with LRA enabled. Measures contractual last-room-availability exposure."
    - name: "healthy_connection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN health_check_status = 'healthy' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of GDS connections with healthy status. Measures GDS distribution reliability."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_metasearch_listing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metasearch channel performance metrics tracking click-through rates, conversion, ROAS, and cost efficiency across metasearch platforms. Used by digital marketing and distribution teams to optimize metasearch investment."
  source: "`vibe_travel_hospitality_v1`.`channel`.`metasearch_listing`"
  dimensions:
    - name: "platform_name"
      expr: platform_name
      comment: "Metasearch platform name (Google Hotel Ads, TripAdvisor, Trivago) for platform-level performance comparison."
    - name: "listing_status"
      expr: listing_status
      comment: "Current listing status (active, paused, suspended) for portfolio health monitoring."
    - name: "listing_type"
      expr: listing_type
      comment: "Type of metasearch listing (CPC, CPA, commission) for bid strategy analysis."
    - name: "bid_strategy_type"
      expr: bid_strategy_type
      comment: "Bidding strategy type (manual, automated, target ROAS) for campaign optimization analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type (desktop, mobile, tablet) for device-level performance optimization."
    - name: "target_market"
      expr: target_market
      comment: "Target market for the listing for geographic demand and investment analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the listing spend and revenue for multi-currency performance reporting."
    - name: "reporting_period_start_month"
      expr: DATE_TRUNC('month', reporting_period_start)
      comment: "Reporting period month for trend analysis of metasearch performance."
    - name: "is_rate_parity_monitored"
      expr: is_rate_parity_monitored
      comment: "Whether rate parity is monitored on this listing for compliance scope identification."
  measures:
    - name: "total_impressions"
      expr: SUM(CAST(impression_count AS DOUBLE))
      comment: "Total metasearch impressions. Measures visibility and reach of hotel listings on metasearch platforms."
    - name: "total_clicks"
      expr: SUM(CAST(click_count AS DOUBLE))
      comment: "Total clicks on metasearch listings. Measures user engagement and traffic driven to direct booking."
    - name: "total_booking_revenue"
      expr: SUM(CAST(booking_revenue AS DOUBLE))
      comment: "Total revenue generated from metasearch bookings. Primary revenue contribution metric for metasearch."
    - name: "total_spend"
      expr: SUM(CAST(total_spend AS DOUBLE))
      comment: "Total metasearch advertising spend. Core cost metric for ROI and budget management."
    - name: "avg_click_through_rate"
      expr: AVG(CAST(click_through_rate AS DOUBLE))
      comment: "Average click-through rate across listings. Measures listing relevance and creative effectiveness."
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average booking conversion rate from clicks. Measures landing page and booking funnel effectiveness."
    - name: "avg_return_on_ad_spend"
      expr: AVG(CAST(return_on_ad_spend AS DOUBLE))
      comment: "Average ROAS across metasearch listings. Primary efficiency metric for metasearch investment decisions."
    - name: "avg_cpc_actual"
      expr: AVG(CAST(cpc_actual AS DOUBLE))
      comment: "Average actual cost per click. Measures bid efficiency and competitive positioning on metasearch."
    - name: "avg_cpa_actual"
      expr: AVG(CAST(cpa_actual AS DOUBLE))
      comment: "Average actual cost per acquisition. Measures true cost efficiency of metasearch bookings."
    - name: "avg_bid_amount"
      expr: AVG(CAST(bid_amount AS DOUBLE))
      comment: "Average bid amount across listings. Benchmarks bidding aggressiveness across platforms."
    - name: "total_daily_budget_cap"
      expr: SUM(CAST(daily_budget_cap AS DOUBLE))
      comment: "Total daily budget cap across all metasearch listings. Measures total metasearch investment ceiling."
    - name: "revenue_per_click"
      expr: ROUND(SUM(CAST(booking_revenue AS DOUBLE)) / NULLIF(SUM(CAST(click_count AS DOUBLE)), 0), 2)
      comment: "Revenue generated per click. Measures the revenue quality of metasearch traffic for investment optimization."
    - name: "cost_per_booking_revenue_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(total_spend AS DOUBLE)) / NULLIF(SUM(CAST(booking_revenue AS DOUBLE)), 0), 2)
      comment: "Metasearch spend as a percentage of booking revenue. Core cost efficiency metric for channel investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_wholesale_allotment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wholesale allotment metrics tracking contracted allotment utilization, pickup performance, and wash factor exposure. Used by revenue management and commercial teams to optimize wholesale channel agreements."
  source: "`vibe_travel_hospitality_v1`.`channel`.`wholesale_allotment`"
  dimensions:
    - name: "allotment_type"
      expr: allotment_type
      comment: "Type of wholesale allotment (hard block, soft block, free-sale) for commitment level analysis."
    - name: "allotment_status"
      expr: allotment_status
      comment: "Current status of the allotment (active, released, expired, consumed) for portfolio health monitoring."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment for the wholesale allotment for segment-level revenue attribution."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allotment rates for multi-currency revenue analysis."
    - name: "connectivity_type"
      expr: connectivity_type
      comment: "Connectivity type for the wholesale channel for technology cost analysis."
    - name: "stay_date_from_month"
      expr: DATE_TRUNC('month', stay_date_from)
      comment: "Stay period start month for seasonal allotment demand analysis."
    - name: "contract_effective_date_month"
      expr: DATE_TRUNC('month', contract_effective_date)
      comment: "Month the wholesale contract became effective for contract lifecycle analysis."
    - name: "is_stop_sell"
      expr: is_stop_sell
      comment: "Whether stop-sell is active on the allotment for demand management monitoring."
    - name: "last_room_availability"
      expr: last_room_availability
      comment: "Whether LRA applies to this wholesale allotment for contractual obligation monitoring."
  measures:
    - name: "total_allotments"
      expr: COUNT(1)
      comment: "Total number of wholesale allotment records. Baseline measure for wholesale portfolio size."
    - name: "total_contracted_net_rate"
      expr: SUM(CAST(contracted_net_rate AS DOUBLE))
      comment: "Total contracted net rate value across allotments. Measures contracted wholesale revenue potential."
    - name: "total_rack_rate"
      expr: SUM(CAST(rack_rate AS DOUBLE))
      comment: "Total rack rate value across allotments. Used to calculate discount depth vs. contracted net rate."
    - name: "avg_contracted_net_rate"
      expr: AVG(CAST(contracted_net_rate AS DOUBLE))
      comment: "Average contracted net rate per allotment. Benchmarks wholesale pricing across partners."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate on wholesale allotments. Measures cost of wholesale distribution."
    - name: "avg_wash_factor_pct"
      expr: AVG(CAST(wash_factor_pct AS DOUBLE))
      comment: "Average wash factor applied to wholesale allotments. Measures expected attrition from contracted blocks."
    - name: "net_rate_to_rack_rate_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(contracted_net_rate AS DOUBLE)) / NULLIF(SUM(CAST(rack_rate AS DOUBLE)), 0), 2)
      comment: "Contracted net rate as a percentage of rack rate. Measures wholesale discount depth across the portfolio."
    - name: "stop_sell_allotment_count"
      expr: COUNT(CASE WHEN is_stop_sell = TRUE THEN 1 END)
      comment: "Number of wholesale allotments with stop-sell active. Measures demand management intervention frequency."
    - name: "lra_allotment_count"
      expr: COUNT(CASE WHEN last_room_availability = TRUE THEN 1 END)
      comment: "Number of wholesale allotments with LRA obligation. Measures contractual last-room-availability exposure."
    - name: "active_allotment_count"
      expr: COUNT(CASE WHEN allotment_status = 'active' THEN 1 END)
      comment: "Number of currently active wholesale allotments. Measures live wholesale inventory commitment."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_ota_campaign_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OTA campaign participation metrics tracking co-op marketing investment, revenue performance, and campaign ROI across OTA partners. Used by commercial and marketing teams to evaluate OTA partnership value."
  source: "`vibe_travel_hospitality_v1`.`channel`.`ota_campaign_participation`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Status of the OTA campaign participation (active, completed, cancelled) for portfolio management."
    - name: "participation_status"
      expr: participation_status
      comment: "Hotel's participation status in the OTA campaign for enrollment tracking."
    - name: "promotional_placement_type"
      expr: promotional_placement_type
      comment: "Type of promotional placement (featured listing, deal badge, sponsored) for placement effectiveness analysis."
    - name: "campaign_start_date_month"
      expr: DATE_TRUNC('month', campaign_start_date)
      comment: "Month the OTA campaign started for campaign timing and seasonality analysis."
    - name: "campaign_end_date_month"
      expr: DATE_TRUNC('month', campaign_end_date)
      comment: "Month the OTA campaign ended for campaign duration and performance analysis."
  measures:
    - name: "total_participations"
      expr: COUNT(1)
      comment: "Total number of OTA campaign participations. Measures breadth of OTA marketing engagement."
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_revenue_amount AS DOUBLE))
      comment: "Total actual revenue generated from OTA campaign participations. Primary ROI metric for OTA co-op investment."
    - name: "total_target_revenue"
      expr: SUM(CAST(target_revenue_amount AS DOUBLE))
      comment: "Total target revenue across OTA campaigns. Baseline for measuring campaign revenue attainment."
    - name: "total_participation_fee"
      expr: SUM(CAST(participation_fee AS DOUBLE))
      comment: "Total participation fees paid to OTA partners. Measures direct cost of OTA campaign participation."
    - name: "total_hotel_contribution"
      expr: SUM(CAST(hotel_contribution_amount AS DOUBLE))
      comment: "Total hotel co-op marketing contribution. Measures hotel's financial commitment to OTA partnerships."
    - name: "total_coop_marketing_budget"
      expr: SUM(CAST(coop_marketing_budget AS DOUBLE))
      comment: "Total co-op marketing budget across OTA campaigns. Measures total OTA marketing investment."
    - name: "total_performance_bonus_earned"
      expr: SUM(CAST(performance_bonus_earned AS DOUBLE))
      comment: "Total performance bonuses earned from OTA campaigns. Measures incremental value from exceeding targets."
    - name: "revenue_attainment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(target_revenue_amount AS DOUBLE)), 0), 2)
      comment: "Actual revenue as a percentage of target revenue. Measures OTA campaign effectiveness vs. plan."
    - name: "revenue_per_participation_fee"
      expr: ROUND(SUM(CAST(actual_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(participation_fee AS DOUBLE)), 0), 2)
      comment: "Revenue generated per dollar of participation fee. Measures ROI of OTA campaign investment."
    - name: "avg_ota_coop_budget"
      expr: AVG(CAST(ota_coop_budget_amount AS DOUBLE))
      comment: "Average OTA co-op budget per campaign participation. Benchmarks OTA marketing investment levels."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_negotiated_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel negotiated rate metrics tracking rate loading status, volume commitments, and rate competitiveness across corporate and consortia agreements. Used by commercial teams to manage negotiated rate portfolio performance."
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_negotiated_rate`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Status of the negotiated rate agreement (active, expired, pending) for portfolio health monitoring."
    - name: "rate_type"
      expr: rate_type
      comment: "Type of negotiated rate (corporate, consortia, government, TMC) for rate category analysis."
    - name: "rate_category"
      expr: rate_category
      comment: "Rate category for the negotiated agreement for segment-level rate management."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment for the negotiated rate for segment-level revenue attribution."
    - name: "gds_loading_status"
      expr: gds_loading_status
      comment: "GDS loading status of the negotiated rate (loaded, pending, failed) for distribution readiness monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the negotiated rate for multi-currency rate management."
    - name: "negotiation_year"
      expr: negotiation_year
      comment: "Year the rate was negotiated for annual rate cycle analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the negotiated rate became effective for rate lifecycle analysis."
    - name: "is_last_room_availability"
      expr: is_last_room_availability
      comment: "Whether LRA applies to this negotiated rate for contractual obligation monitoring."
    - name: "is_rate_parity_required"
      expr: is_rate_parity_required
      comment: "Whether rate parity is required for this negotiated rate for compliance scope identification."
  measures:
    - name: "total_negotiated_rates"
      expr: COUNT(1)
      comment: "Total number of channel negotiated rates. Measures breadth of negotiated rate portfolio."
    - name: "active_rate_count"
      expr: COUNT(CASE WHEN agreement_status = 'active' THEN 1 END)
      comment: "Number of currently active negotiated rates. Measures live negotiated rate distribution coverage."
    - name: "avg_negotiated_rate_amount"
      expr: AVG(CAST(negotiated_rate_amount AS DOUBLE))
      comment: "Average negotiated rate amount. Benchmarks rate level across corporate and consortia agreements."
    - name: "avg_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average rate amount across all negotiated rate records. Used for rate competitiveness benchmarking."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate on negotiated rates. Measures cost of distribution for negotiated business."
    - name: "gds_loading_failure_count"
      expr: COUNT(CASE WHEN gds_loading_status = 'failed' THEN 1 END)
      comment: "Number of negotiated rates with failed GDS loading. Measures distribution readiness failures."
    - name: "gds_loading_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gds_loading_status = 'loaded' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of negotiated rates successfully loaded to GDS. Measures distribution readiness."
    - name: "lra_rate_count"
      expr: COUNT(CASE WHEN is_last_room_availability = TRUE THEN 1 END)
      comment: "Number of negotiated rates with LRA obligation. Measures contractual last-room-availability exposure."
    - name: "parity_required_rate_count"
      expr: COUNT(CASE WHEN is_rate_parity_required = TRUE THEN 1 END)
      comment: "Number of negotiated rates with parity requirements. Defines parity compliance monitoring scope."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_connectivity_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Connectivity fee metrics tracking technology cost of distribution, fee structures, and waiver activity across channels. Used by finance and technology teams to manage and optimize connectivity cost."
  source: "`vibe_travel_hospitality_v1`.`channel`.`connectivity_fee`"
  dimensions:
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of connectivity fee billing (monthly, per-booking, annual) for cash flow planning."
    - name: "invoice_frequency"
      expr: invoice_frequency
      comment: "Invoice frequency for connectivity fees for accounts payable management."
    - name: "property_scope"
      expr: property_scope
      comment: "Scope of the connectivity fee (single property, portfolio, chain) for cost allocation analysis."
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "GL account code for connectivity fee posting for financial reporting and cost center allocation."
    - name: "is_waived"
      expr: is_waived
      comment: "Whether the connectivity fee has been waived for waiver rate and cost savings analysis."
    - name: "tax_applicable"
      expr: tax_applicable
      comment: "Whether tax applies to the connectivity fee for tax liability analysis."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the connectivity fee became effective for fee lifecycle trend analysis."
  measures:
    - name: "total_connectivity_fees"
      expr: COUNT(1)
      comment: "Total number of connectivity fee records. Baseline measure for connectivity fee portfolio size."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total connectivity fee amount. Primary cost metric for technology distribution infrastructure."
    - name: "avg_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average connectivity fee amount. Benchmarks technology cost per channel connection."
    - name: "total_maximum_fee_amount"
      expr: SUM(CAST(maximum_fee_amount AS DOUBLE))
      comment: "Total maximum fee cap across connectivity agreements. Measures maximum connectivity cost exposure."
    - name: "total_minimum_fee_amount"
      expr: SUM(CAST(minimum_fee_amount AS DOUBLE))
      comment: "Total minimum fee floor across connectivity agreements. Measures guaranteed connectivity cost floor."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average tax rate applied to connectivity fees. Measures tax burden on distribution technology costs."
    - name: "waived_fee_count"
      expr: COUNT(CASE WHEN is_waived = TRUE THEN 1 END)
      comment: "Number of connectivity fees that have been waived. Measures cost savings from fee waivers."
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_waived = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of connectivity fees that are waived. Measures negotiation effectiveness in reducing tech costs."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_stop_sell`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stop-sell restriction metrics tracking frequency, duration, and revenue context of inventory closures across channels. Used by revenue management to evaluate demand management effectiveness and restriction patterns."
  source: "`vibe_travel_hospitality_v1`.`channel`.`stop_sell`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Channel type where stop-sell was applied for channel-level restriction analysis."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of restriction (stop-sell, CTA, CTD, min-stay) for restriction strategy analysis."
    - name: "restriction_status"
      expr: restriction_status
      comment: "Current status of the restriction (active, lifted, expired) for active restriction monitoring."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the stop-sell action for root cause analysis of inventory closures."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment affected by the stop-sell for segment-level demand management analysis."
    - name: "is_all_channels"
      expr: is_all_channels
      comment: "Whether the stop-sell applies to all channels for broad vs. targeted restriction analysis."
    - name: "is_system_generated"
      expr: is_system_generated
      comment: "Whether the stop-sell was system-generated (RMS) vs. manually applied for automation analysis."
    - name: "stay_date_month"
      expr: DATE_TRUNC('month', stay_date)
      comment: "Stay month of the stop-sell for seasonal restriction pattern analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for rate context at time of stop-sell application."
  measures:
    - name: "total_stop_sells"
      expr: COUNT(1)
      comment: "Total number of stop-sell records. Baseline measure for restriction activity volume."
    - name: "active_stop_sell_count"
      expr: COUNT(CASE WHEN restriction_status = 'active' THEN 1 END)
      comment: "Number of currently active stop-sell restrictions. Measures live inventory closure scope."
    - name: "system_generated_count"
      expr: COUNT(CASE WHEN is_system_generated = TRUE THEN 1 END)
      comment: "Number of system-generated stop-sells. Measures RMS automation level in demand management."
    - name: "system_generated_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_system_generated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stop-sells generated by RMS. Measures revenue management automation maturity."
    - name: "all_channel_stop_sell_count"
      expr: COUNT(CASE WHEN is_all_channels = TRUE THEN 1 END)
      comment: "Number of stop-sells applied across all channels simultaneously. Measures broad demand management actions."
    - name: "avg_adr_at_apply"
      expr: AVG(CAST(adr_at_apply AS DOUBLE))
      comment: "Average ADR at the time stop-sell was applied. Measures rate context of demand management decisions."
    - name: "avg_occupancy_at_apply"
      expr: AVG(CAST(occupancy_at_apply AS DOUBLE))
      comment: "Average occupancy at the time stop-sell was applied. Validates that stop-sells are applied at appropriate demand levels."
    - name: "avg_revpar_at_apply"
      expr: AVG(CAST(revpar_at_apply AS DOUBLE))
      comment: "Average RevPAR at the time stop-sell was applied. Measures revenue context of inventory closure decisions."
    - name: "lifted_stop_sell_count"
      expr: COUNT(CASE WHEN lift_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of stop-sells that have been lifted. Measures restriction reversal activity and demand recovery."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_booking_source`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking Source business metrics"
  source: "`vibe_travel_hospitality_v1`.`channel`.`booking_source`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Api Connectivity Type"
      expr: api_connectivity_type
    - name: "Attribution Hierarchy Level"
      expr: attribution_hierarchy_level
    - name: "Booking Source Status"
      expr: booking_source_status
    - name: "Booking Window Max Days"
      expr: booking_window_max_days
    - name: "Booking Window Min Days"
      expr: booking_window_min_days
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Channel Type"
      expr: channel_type
    - name: "Commission Basis"
      expr: commission_basis
    - name: "Connectivity Fee Applicable"
      expr: connectivity_fee_applicable
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Source Code"
      expr: crs_source_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Deactivation Date"
      expr: deactivation_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Booking Source"
      expr: COUNT(DISTINCT booking_source_id)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
    - name: "Total Connectivity Fee Amount"
      expr: SUM(connectivity_fee_amount)
    - name: "Average Connectivity Fee Amount"
      expr: AVG(connectivity_fee_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel business metrics"
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Bar Eligible"
      expr: bar_eligible
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Channel Category"
      expr: channel_category
    - name: "Channel Code"
      expr: channel_code
    - name: "Channel Description"
      expr: channel_description
    - name: "Channel Name"
      expr: channel_name
    - name: "Channel Status"
      expr: channel_status
    - name: "Channel Type"
      expr: channel_type
    - name: "Commission Basis"
      expr: commission_basis
    - name: "Connectivity Method"
      expr: connectivity_method
    - name: "Content Distribution Enabled"
      expr: content_distribution_enabled
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Channel Code"
      expr: crs_channel_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel"
      expr: COUNT(DISTINCT channel_id)
    - name: "Total Booking Fee Usd"
      expr: SUM(booking_fee_usd)
    - name: "Average Booking Fee Usd"
      expr: AVG(booking_fee_usd)
    - name: "Total Commission Rate Pct"
      expr: SUM(commission_rate_pct)
    - name: "Average Commission Rate Pct"
      expr: AVG(commission_rate_pct)
    - name: "Total Connectivity Fee Usd"
      expr: SUM(connectivity_fee_usd)
    - name: "Average Connectivity Fee Usd"
      expr: AVG(connectivity_fee_usd)
    - name: "Total Sla Uptime Pct"
      expr: SUM(sla_uptime_pct)
    - name: "Average Sla Uptime Pct"
      expr: AVG(sla_uptime_pct)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_channel_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel Booking business metrics"
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_booking`"
  dimensions:
    - name: "Booking Status"
      expr: booking_status
    - name: "Booking Timestamp"
      expr: booking_timestamp
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Cancellation Timestamp"
      expr: cancellation_timestamp
    - name: "Channel Type"
      expr: channel_type
    - name: "Check In Date"
      expr: check_in_date
    - name: "Check Out Date"
      expr: check_out_date
    - name: "Corporate Account Code"
      expr: corporate_account_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Booking Reference"
      expr: crs_booking_reference
    - name: "Currency Code"
      expr: currency_code
    - name: "Gds Segment Number"
      expr: gds_segment_number
    - name: "Is Cancelled"
      expr: is_cancelled
    - name: "Is Modified"
      expr: is_modified
    - name: "Is Rate Parity Compliant"
      expr: is_rate_parity_compliant
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel Booking"
      expr: COUNT(DISTINCT channel_booking_id)
    - name: "Total Adr"
      expr: SUM(adr)
    - name: "Average Adr"
      expr: AVG(adr)
    - name: "Total Channel Commission Amount"
      expr: SUM(channel_commission_amount)
    - name: "Average Channel Commission Amount"
      expr: AVG(channel_commission_amount)
    - name: "Total Commission Rate Pct"
      expr: SUM(commission_rate_pct)
    - name: "Average Commission Rate Pct"
      expr: AVG(commission_rate_pct)
    - name: "Total Connectivity Fee Amount"
      expr: SUM(connectivity_fee_amount)
    - name: "Average Connectivity Fee Amount"
      expr: AVG(connectivity_fee_amount)
    - name: "Total Gross Booking Value"
      expr: SUM(gross_booking_value)
    - name: "Average Gross Booking Value"
      expr: AVG(gross_booking_value)
    - name: "Total Net Revenue Amount"
      expr: SUM(net_revenue_amount)
    - name: "Average Net Revenue Amount"
      expr: AVG(net_revenue_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_channel_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel Contract business metrics"
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_contract`"
  dimensions:
    - name: "Bar Access"
      expr: bar_access
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Commission Basis"
      expr: commission_basis
    - name: "Connectivity Fee Type"
      expr: connectivity_fee_type
    - name: "Content Requirements"
      expr: content_requirements
    - name: "Contract Name"
      expr: contract_name
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Status"
      expr: contract_status
    - name: "Contract Type"
      expr: contract_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Sharing Agreement"
      expr: data_sharing_agreement
    - name: "Dispute Resolution Jurisdiction"
      expr: dispute_resolution_jurisdiction
    - name: "Dispute Resolution Mechanism"
      expr: dispute_resolution_mechanism
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel Contract"
      expr: COUNT(DISTINCT channel_contract_id)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
    - name: "Total Connectivity Fee"
      expr: SUM(connectivity_fee)
    - name: "Average Connectivity Fee"
      expr: AVG(connectivity_fee)
    - name: "Total Marketing Coop Amount"
      expr: SUM(marketing_coop_amount)
    - name: "Average Marketing Coop Amount"
      expr: AVG(marketing_coop_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_channel_inventory_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel Inventory Allocation business metrics"
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_inventory_allocation`"
  dimensions:
    - name: "Action Type"
      expr: action_type
    - name: "Active Status"
      expr: active_status
    - name: "Allocated Units"
      expr: allocated_units
    - name: "Allocation Reference Number"
      expr: allocation_reference_number
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Allocation Type"
      expr: allocation_type
    - name: "Allotment Type"
      expr: allotment_type
    - name: "Applied By User"
      expr: applied_by_user
    - name: "Available Units"
      expr: available_units
    - name: "Cancellation Count"
      expr: cancellation_count
    - name: "Channel Type"
      expr: channel_type
    - name: "Consumed Units"
      expr: consumed_units
    - name: "Created Date"
      expr: created_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Days Out"
      expr: days_out
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel Inventory Allocation"
      expr: COUNT(DISTINCT channel_inventory_allocation_id)
    - name: "Total Channel Allocation Pct"
      expr: SUM(channel_allocation_pct)
    - name: "Average Channel Allocation Pct"
      expr: AVG(channel_allocation_pct)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
    - name: "Total Connectivity Fee"
      expr: SUM(connectivity_fee)
    - name: "Average Connectivity Fee"
      expr: AVG(connectivity_fee)
    - name: "Total Overbooking Limit Pct"
      expr: SUM(overbooking_limit_pct)
    - name: "Average Overbooking Limit Pct"
      expr: AVG(overbooking_limit_pct)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_channel_negotiated_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel Negotiated Rate business metrics"
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_negotiated_rate`"
  dimensions:
    - name: "Advance Purchase Days"
      expr: advance_purchase_days
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Approved By User"
      expr: approved_by_user
    - name: "Blackout Dates"
      expr: blackout_dates
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Consortia Code"
      expr: consortia_code
    - name: "Consortia Name"
      expr: consortia_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Rate Code"
      expr: crs_rate_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Gds Chain Code"
      expr: gds_chain_code
    - name: "Gds Loading Status"
      expr: gds_loading_status
    - name: "Is Last Room Availability"
      expr: is_last_room_availability
    - name: "Is Rate Parity Required"
      expr: is_rate_parity_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel Negotiated Rate"
      expr: COUNT(DISTINCT channel_negotiated_rate_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Commission Rate Pct"
      expr: SUM(commission_rate_pct)
    - name: "Average Commission Rate Pct"
      expr: AVG(commission_rate_pct)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_channel_rate_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel Rate Plan business metrics"
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan`"
  dimensions:
    - name: "Advance Purchase Days"
      expr: advance_purchase_days
    - name: "Approved By"
      expr: approved_by
    - name: "Booking Window End Date"
      expr: booking_window_end_date
    - name: "Booking Window Start Date"
      expr: booking_window_start_date
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Channel Rate Plan Status"
      expr: channel_rate_plan_status
    - name: "Close Out Days"
      expr: close_out_days
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Rate Plan Code"
      expr: crs_rate_plan_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Days Of Week Applicable"
      expr: days_of_week_applicable
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Is Package Rate"
      expr: is_package_rate
    - name: "Is Rate Parity Applicable"
      expr: is_rate_parity_applicable
    - name: "Is Refundable"
      expr: is_refundable
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel Rate Plan"
      expr: COUNT(DISTINCT channel_rate_plan_id)
    - name: "Total Base Rate Amount"
      expr: SUM(base_rate_amount)
    - name: "Average Base Rate Amount"
      expr: AVG(base_rate_amount)
    - name: "Total Channel Rate Amount"
      expr: SUM(channel_rate_amount)
    - name: "Average Channel Rate Amount"
      expr: AVG(channel_rate_amount)
    - name: "Total Commission Rate Pct"
      expr: SUM(commission_rate_pct)
    - name: "Average Commission Rate Pct"
      expr: AVG(commission_rate_pct)
    - name: "Total Connectivity Fee Amount"
      expr: SUM(connectivity_fee_amount)
    - name: "Average Connectivity Fee Amount"
      expr: AVG(connectivity_fee_amount)
    - name: "Total Rate Adjustment Value"
      expr: SUM(rate_adjustment_value)
    - name: "Average Rate Adjustment Value"
      expr: AVG(rate_adjustment_value)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_crs_channel_mapping`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crs Channel Mapping business metrics"
  source: "`vibe_travel_hospitality_v1`.`channel`.`crs_channel_mapping`"
  dimensions:
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Channel Contract Reference"
      expr: channel_contract_reference
    - name: "Channel Property Code"
      expr: channel_property_code
    - name: "Channel Type"
      expr: channel_type
    - name: "Connectivity Protocol"
      expr: connectivity_protocol
    - name: "Content Sync Enabled"
      expr: content_sync_enabled
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Property Code"
      expr: crs_property_code
    - name: "Crs Rate Plan Code"
      expr: crs_rate_plan_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Guarantee Policy Code"
      expr: guarantee_policy_code
    - name: "Inventory Allocation Type"
      expr: inventory_allocation_type
    - name: "Is Mobile Optimized"
      expr: is_mobile_optimized
    - name: "Last Sync Timestamp"
      expr: last_sync_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Crs Channel Mapping"
      expr: COUNT(DISTINCT crs_channel_mapping_id)
    - name: "Total Commission Rate Pct"
      expr: SUM(commission_rate_pct)
    - name: "Average Commission Rate Pct"
      expr: AVG(commission_rate_pct)
    - name: "Total Connectivity Fee Usd"
      expr: SUM(connectivity_fee_usd)
    - name: "Average Connectivity Fee Usd"
      expr: AVG(connectivity_fee_usd)
    - name: "Total Rate Offset Value"
      expr: SUM(rate_offset_value)
    - name: "Average Rate Offset Value"
      expr: AVG(rate_offset_value)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_ota_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ota Partner business metrics"
  source: "`vibe_travel_hospitality_v1`.`channel`.`ota_partner`"
  dimensions:
    - name: "Affiliate Network"
      expr: affiliate_network
    - name: "Cancellation Policy Type"
      expr: cancellation_policy_type
    - name: "Channel Manager Platform"
      expr: channel_manager_platform
    - name: "Commission Model"
      expr: commission_model
    - name: "Connectivity Fee Frequency"
      expr: connectivity_fee_frequency
    - name: "Connectivity Protocol"
      expr: connectivity_protocol
    - name: "Contract Effective Date"
      expr: contract_effective_date
    - name: "Contract Expiry Date"
      expr: contract_expiry_date
    - name: "Contract Reference"
      expr: contract_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Sharing Agreement"
      expr: data_sharing_agreement
    - name: "Gdpr Data Processor"
      expr: gdpr_data_processor
    - name: "Gds Chain Code"
      expr: gds_chain_code
    - name: "Hq Country Code"
      expr: hq_country_code
    - name: "Inventory Allocation Model"
      expr: inventory_allocation_model
    - name: "Last Room Availability"
      expr: last_room_availability
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ota Partner"
      expr: COUNT(DISTINCT ota_partner_id)
    - name: "Total Base Commission Rate Pct"
      expr: SUM(base_commission_rate_pct)
    - name: "Average Base Commission Rate Pct"
      expr: AVG(base_commission_rate_pct)
    - name: "Total Connectivity Fee Usd"
      expr: SUM(connectivity_fee_usd)
    - name: "Average Connectivity Fee Usd"
      expr: AVG(connectivity_fee_usd)
    - name: "Total Content Score"
      expr: SUM(content_score)
    - name: "Average Content Score"
      expr: AVG(content_score)
    - name: "Total Preferred Commission Rate Pct"
      expr: SUM(preferred_commission_rate_pct)
    - name: "Average Preferred Commission Rate Pct"
      expr: AVG(preferred_commission_rate_pct)
    - name: "Total Review Score"
      expr: SUM(review_score)
    - name: "Average Review Score"
      expr: AVG(review_score)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_package_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Package Rate business metrics"
  source: "`vibe_travel_hospitality_v1`.`channel`.`package_rate`"
  dimensions:
    - name: "Cancellation Policy Override"
      expr: cancellation_policy_override
    - name: "Created Date"
      expr: created_date
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Is Active"
      expr: is_active
    - name: "Last Rate Update Timestamp"
      expr: last_rate_update_timestamp
    - name: "Minimum Advance Booking"
      expr: minimum_advance_booking
    - name: "Modified Date"
      expr: modified_date
    - name: "Rate Loading Status"
      expr: rate_loading_status
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "Effective From Date Month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Package Rate"
      expr: COUNT(DISTINCT package_rate_id)
    - name: "Total Channel Package Price"
      expr: SUM(channel_package_price)
    - name: "Average Channel Package Price"
      expr: AVG(channel_package_price)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
$$;