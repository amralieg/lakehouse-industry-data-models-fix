-- Metric views for domain: channel | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 19:35:58

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core channel booking performance metrics tracking revenue, commissions, cancellations, and booking efficiency across all distribution channels. Primary KPI layer for channel mix optimization and revenue management decisions."
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_booking`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel type (OTA, GDS, Direct, etc.) used to segment booking performance by channel category."
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the booking (confirmed, cancelled, modified) for filtering active vs. cancelled bookings."
    - name: "rate_type"
      expr: rate_type
      comment: "Rate type applied to the booking (BAR, negotiated, package, etc.) for rate strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the booking was transacted, enabling multi-currency revenue analysis."
    - name: "is_cancelled"
      expr: is_cancelled
      comment: "Boolean flag indicating whether the booking was cancelled, used to isolate cancellation impact on revenue."
    - name: "is_rate_parity_compliant"
      expr: is_rate_parity_compliant
      comment: "Boolean flag indicating whether the booking adhered to rate parity agreements, critical for OTA contract compliance monitoring."
    - name: "corporate_account_code"
      expr: corporate_account_code
      comment: "Corporate account identifier for segmenting bookings by corporate client, supporting account management decisions."
    - name: "check_in_date"
      expr: DATE_TRUNC('month', check_in_date)
      comment: "Check-in date truncated to month for time-series trend analysis of booking volumes and revenue."
    - name: "booking_date"
      expr: DATE_TRUNC('month', CAST(booking_timestamp AS DATE))
      comment: "Booking creation date truncated to month for booking pace and lead-time trend analysis."
    - name: "is_modified"
      expr: is_modified
      comment: "Boolean flag indicating whether the booking was modified after initial creation, used to track modification rates by channel."
  measures:
    - name: "total_gross_booking_value"
      expr: SUM(CAST(gross_booking_value AS DOUBLE))
      comment: "Total gross booking value across all channel bookings. Primary revenue KPI for channel contribution analysis and investment decisions."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after commissions and fees. Measures true channel profitability and informs channel mix optimization."
    - name: "total_commission_paid"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission expense paid to distribution channels. Directly impacts margin and informs commission renegotiation decisions."
    - name: "total_channel_commission"
      expr: SUM(CAST(channel_commission_amount AS DOUBLE))
      comment: "Total channel-specific commission amount, enabling comparison of commission costs across different channel types."
    - name: "total_connectivity_fees"
      expr: SUM(CAST(connectivity_fee_amount AS DOUBLE))
      comment: "Total connectivity fees incurred across all channel bookings. Tracks technology cost of distribution and informs channel cost-of-sale analysis."
    - name: "avg_daily_rate"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate across channel bookings. Core hospitality KPI used to benchmark pricing performance by channel and inform rate strategy."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage across bookings. Tracks commission cost efficiency and supports contract renegotiation decisions."
    - name: "total_booking_count"
      expr: COUNT(1)
      comment: "Total number of channel bookings. Baseline volume metric for channel throughput and market share analysis."
    - name: "cancelled_booking_count"
      expr: COUNT(CASE WHEN is_cancelled = TRUE THEN 1 END)
      comment: "Number of cancelled bookings by channel. High cancellation rates signal channel quality issues or policy misalignment requiring management action."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cancelled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings that were cancelled. Key channel quality KPI — elevated rates trigger policy review and channel performance discussions."
    - name: "rate_parity_compliant_booking_count"
      expr: COUNT(CASE WHEN is_rate_parity_compliant = TRUE THEN 1 END)
      comment: "Number of bookings that were rate parity compliant. Tracks adherence to OTA contractual rate parity obligations."
    - name: "rate_parity_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_rate_parity_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings compliant with rate parity agreements. Non-compliance exposes the business to OTA contract penalties and delisting risk."
    - name: "avg_booking_value"
      expr: AVG(CAST(gross_booking_value AS DOUBLE))
      comment: "Average gross booking value per transaction. Tracks booking quality and yield per channel, informing channel investment prioritization."
    - name: "net_revenue_per_booking"
      expr: AVG(CAST(net_revenue_amount AS DOUBLE))
      comment: "Average net revenue per booking after commissions. Measures true per-booking profitability by channel for cost-of-sale benchmarking."
    - name: "total_booking_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total booking amount (transaction value) across all channel bookings. Supports revenue reconciliation and channel contribution reporting."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel master entity metrics tracking distribution channel portfolio health, cost structure, and capability coverage. Supports channel strategy, contract management, and technology investment decisions."
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Type of distribution channel (OTA, GDS, Direct, Wholesale, etc.) for portfolio segmentation."
    - name: "channel_status"
      expr: channel_status
      comment: "Operational status of the channel (active, inactive, suspended) for portfolio health monitoring."
    - name: "category"
      expr: category
      comment: "Business category classification of the channel for strategic grouping and reporting."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic market scope of the channel (global, regional, local) for market coverage analysis."
    - name: "commission_basis"
      expr: commission_basis
      comment: "Basis on which commission is calculated (per booking, percentage of revenue, flat fee) for cost structure analysis."
    - name: "connectivity_method"
      expr: connectivity_method
      comment: "Technical connectivity method (API, GDS, direct connect) for technology stack and integration cost analysis."
    - name: "rate_parity_type"
      expr: rate_parity_type
      comment: "Type of rate parity obligation (strict, flexible, none) for compliance risk segmentation."
    - name: "inventory_allocation_method"
      expr: inventory_allocation_method
      comment: "Method used to allocate inventory to this channel (allotment, free-sell, on-request) for yield management analysis."
    - name: "bar_eligible"
      expr: bar_eligible
      comment: "Whether the channel is eligible for Best Available Rate distribution, a key rate strategy dimension."
    - name: "loyalty_bookings_eligible"
      expr: loyalty_bookings_eligible
      comment: "Whether loyalty program bookings are eligible through this channel, for loyalty program distribution analysis."
    - name: "activation_date_month"
      expr: DATE_TRUNC('month', activation_date)
      comment: "Month of channel activation for tracking channel portfolio growth over time."
  measures:
    - name: "total_active_channels"
      expr: COUNT(CASE WHEN channel_status = 'active' THEN 1 END)
      comment: "Number of currently active distribution channels. Tracks portfolio breadth and informs channel expansion or consolidation decisions."
    - name: "total_channels"
      expr: COUNT(1)
      comment: "Total number of channels in the portfolio including all statuses. Baseline for portfolio size benchmarking."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage across all channels. Tracks overall distribution cost burden and informs contract renegotiation strategy."
    - name: "avg_booking_fee_usd"
      expr: AVG(CAST(booking_fee_usd AS DOUBLE))
      comment: "Average per-booking fee in USD across channels. Measures fixed cost-of-sale component for channel economics analysis."
    - name: "avg_connectivity_fee_usd"
      expr: AVG(CAST(connectivity_fee_usd AS DOUBLE))
      comment: "Average connectivity fee in USD across channels. Tracks technology distribution cost and informs connectivity investment decisions."
    - name: "avg_sla_uptime_pct"
      expr: AVG(CAST(sla_uptime_pct AS DOUBLE))
      comment: "Average SLA uptime percentage across channels. Measures distribution technology reliability — low uptime directly causes lost bookings and revenue."
    - name: "bar_eligible_channel_count"
      expr: COUNT(CASE WHEN bar_eligible = TRUE THEN 1 END)
      comment: "Number of channels eligible for Best Available Rate. Tracks BAR distribution reach, a key revenue management lever."
    - name: "loyalty_eligible_channel_count"
      expr: COUNT(CASE WHEN loyalty_bookings_eligible = TRUE THEN 1 END)
      comment: "Number of channels supporting loyalty program bookings. Measures loyalty program distribution coverage, impacting member acquisition and retention."
    - name: "rate_parity_required_channel_count"
      expr: COUNT(CASE WHEN rate_parity_required = TRUE THEN 1 END)
      comment: "Number of channels with mandatory rate parity clauses. Quantifies rate parity compliance exposure across the channel portfolio."
    - name: "pci_compliant_channel_count"
      expr: COUNT(CASE WHEN pci_compliant = TRUE THEN 1 END)
      comment: "Number of PCI-compliant channels. Tracks payment security compliance coverage — non-compliance creates regulatory and financial risk."
    - name: "total_commission_cost_usd"
      expr: SUM(CAST(booking_fee_usd AS DOUBLE))
      comment: "Total booking fee cost in USD across all channels. Aggregate distribution cost baseline for budget and P&L reporting."
    - name: "total_connectivity_cost_usd"
      expr: SUM(CAST(connectivity_fee_usd AS DOUBLE))
      comment: "Total connectivity fee cost in USD across all channels. Aggregate technology distribution cost for IT budget and vendor management decisions."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_commission_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission schedule analytics tracking commission rate structures, tiered incentive thresholds, and cost exposure across channels and market segments. Supports commission negotiation, cost forecasting, and partner incentive strategy."
  source: "`vibe_travel_hospitality_v1`.`channel`.`commission_schedule`"
  dimensions:
    - name: "commission_basis"
      expr: commission_basis
      comment: "Basis for commission calculation (net revenue, gross revenue, per booking) for cost structure segmentation."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the commission schedule (active, expired, pending) for portfolio health monitoring."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of commission billing (monthly, quarterly, per booking) for cash flow and accounts payable planning."
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code for commission expense, enabling financial reporting and cost center allocation."
    - name: "applies_to_cancellations"
      expr: applies_to_cancellations
      comment: "Whether commission applies to cancelled bookings — a key contract risk dimension affecting net commission liability."
    - name: "applies_to_no_shows"
      expr: applies_to_no_shows
      comment: "Whether commission applies to no-show bookings — impacts total commission liability and no-show policy decisions."
    - name: "auto_accrual_enabled"
      expr: auto_accrual_enabled
      comment: "Whether commission auto-accrual is enabled, for financial controls and accrual accuracy monitoring."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the commission schedule became effective, for tracking commission cost evolution over time."
    - name: "rate_parity_monitored"
      expr: rate_parity_monitored
      comment: "Whether rate parity is monitored under this commission schedule, for compliance risk segmentation."
  measures:
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage across all active schedules. Core cost-of-distribution KPI used in contract benchmarking and renegotiation."
    - name: "avg_flat_fee_amount"
      expr: AVG(CAST(flat_fee_amount AS DOUBLE))
      comment: "Average flat fee amount across commission schedules. Tracks fixed commission cost component for total cost-of-sale analysis."
    - name: "total_flat_fee_exposure"
      expr: SUM(CAST(flat_fee_amount AS DOUBLE))
      comment: "Total flat fee exposure across all commission schedules. Quantifies fixed commission liability for financial planning and budget forecasting."
    - name: "avg_max_commission_cap"
      expr: AVG(CAST(max_commission_amount AS DOUBLE))
      comment: "Average maximum commission cap across schedules. Tracks commission ceiling exposure and informs cap negotiation strategy."
    - name: "avg_min_commission_floor"
      expr: AVG(CAST(min_commission_amount AS DOUBLE))
      comment: "Average minimum commission floor across schedules. Tracks guaranteed commission liability regardless of booking volume."
    - name: "avg_tier1_commission_rate_pct"
      expr: AVG(CAST(tier_1_rate_pct AS DOUBLE))
      comment: "Average Tier 1 commission rate percentage. Baseline tier rate used to benchmark standard commission cost across partners."
    - name: "avg_tier2_commission_rate_pct"
      expr: AVG(CAST(tier_2_rate_pct AS DOUBLE))
      comment: "Average Tier 2 commission rate percentage. Tracks incremental commission cost at higher volume tiers, informing volume incentive strategy."
    - name: "avg_tier1_threshold"
      expr: AVG(CAST(tier_1_threshold AS DOUBLE))
      comment: "Average Tier 1 volume threshold for commission escalation. Informs at what booking volume partners qualify for higher commission rates."
    - name: "avg_tier2_threshold"
      expr: AVG(CAST(tier_2_threshold AS DOUBLE))
      comment: "Average Tier 2 volume threshold for commission escalation. Tracks upper-tier incentive thresholds for partner performance management."
    - name: "total_active_schedules"
      expr: COUNT(CASE WHEN schedule_status = 'active' THEN 1 END)
      comment: "Number of currently active commission schedules. Tracks commission contract portfolio size and coverage."
    - name: "cancellation_commission_exposure_count"
      expr: COUNT(CASE WHEN applies_to_cancellations = TRUE THEN 1 END)
      comment: "Number of schedules where commission applies to cancellations. Quantifies financial exposure from cancellation commission liability."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms_days AS DOUBLE))
      comment: "Average payment terms in days across commission schedules. Tracks cash flow timing for commission payables and working capital management."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel contract portfolio metrics tracking contract terms, commission structures, compliance obligations, and contract lifecycle health. Supports legal, finance, and commercial teams in contract governance and renewal decisions."
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the channel contract (active, expired, terminated, pending) for portfolio health monitoring."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of channel contract (OTA, GDS, direct, wholesale) for segmenting contract portfolio by distribution type."
    - name: "commission_basis"
      expr: commission_basis
      comment: "Basis for commission calculation under the contract for cost structure analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency financial exposure analysis."
    - name: "preferred_partner_tier"
      expr: preferred_partner_tier
      comment: "Partner tier designation (preferred, standard, basic) for segmenting contract terms by partner relationship level."
    - name: "rate_parity_type"
      expr: rate_parity_type
      comment: "Type of rate parity obligation in the contract for compliance risk segmentation."
    - name: "renewal_type"
      expr: renewal_type
      comment: "Contract renewal type (auto-renew, manual, evergreen) for contract lifecycle management."
    - name: "invoice_frequency"
      expr: invoice_frequency
      comment: "Frequency of invoicing under the contract for accounts payable planning."
    - name: "rate_parity_clause"
      expr: rate_parity_clause
      comment: "Whether the contract includes a rate parity clause — a key compliance risk indicator."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the contract became effective for contract vintage analysis and renewal pipeline planning."
  measures:
    - name: "total_active_contracts"
      expr: COUNT(CASE WHEN contract_status = 'active' THEN 1 END)
      comment: "Number of currently active channel contracts. Tracks active distribution agreement coverage across the portfolio."
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of channel contracts across all statuses. Baseline for contract portfolio size and management workload."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across all channel contracts. Core cost-of-distribution benchmark used in contract renegotiation and budget planning."
    - name: "total_marketing_coop_committed"
      expr: SUM(CAST(marketing_coop_amount AS DOUBLE))
      comment: "Total marketing co-op investment committed across channel contracts. Tracks marketing spend obligations to distribution partners."
    - name: "avg_marketing_coop_amount"
      expr: AVG(CAST(marketing_coop_amount AS DOUBLE))
      comment: "Average marketing co-op amount per contract. Benchmarks marketing investment per channel partner for budget allocation decisions."
    - name: "avg_connectivity_fee"
      expr: AVG(CAST(connectivity_fee AS DOUBLE))
      comment: "Average connectivity fee per contract. Tracks technology cost-of-distribution per channel agreement."
    - name: "total_connectivity_fee_exposure"
      expr: SUM(CAST(connectivity_fee AS DOUBLE))
      comment: "Total connectivity fee exposure across all contracts. Aggregate technology distribution cost for IT budget and vendor management."
    - name: "rate_parity_clause_contract_count"
      expr: COUNT(CASE WHEN rate_parity_clause = TRUE THEN 1 END)
      comment: "Number of contracts with rate parity clauses. Quantifies rate parity compliance exposure — violations risk contract termination and penalties."
    - name: "nrr_allowed_contract_count"
      expr: COUNT(CASE WHEN nrr_allowed = TRUE THEN 1 END)
      comment: "Number of contracts permitting Non-Refundable Rates. Tracks NRR distribution reach, a key revenue management and cancellation risk lever."
    - name: "pci_compliant_contract_count"
      expr: COUNT(CASE WHEN pci_compliance_confirmed = TRUE THEN 1 END)
      comment: "Number of contracts with confirmed PCI compliance. Tracks payment security compliance coverage across distribution agreements."
    - name: "expiring_contracts_count"
      expr: COUNT(CASE WHEN expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND contract_status = 'active' THEN 1 END)
      comment: "Number of active contracts expiring within 90 days. Critical renewal pipeline metric — missed renewals cause distribution gaps and revenue loss."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_ota_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OTA partner performance and relationship metrics tracking commission economics, content quality, market coverage, and partner tier health. Supports OTA strategy, contract negotiation, and preferred partner program management."
  source: "`vibe_travel_hospitality_v1`.`channel`.`ota_partner`"
  dimensions:
    - name: "partner_type"
      expr: partner_type
      comment: "Type of OTA partner (global OTA, regional OTA, metasearch, travel agent) for portfolio segmentation."
    - name: "partner_status"
      expr: partner_status
      comment: "Current operational status of the OTA partner (active, inactive, suspended) for portfolio health monitoring."
    - name: "commission_model"
      expr: commission_model
      comment: "Commission model used by the OTA partner (merchant, agency, hybrid) for cost structure analysis."
    - name: "market_coverage"
      expr: market_coverage
      comment: "Geographic market coverage of the OTA partner for distribution reach analysis."
    - name: "rate_parity_type"
      expr: rate_parity_type
      comment: "Type of rate parity obligation with the OTA partner for compliance risk segmentation."
    - name: "preferred_partner"
      expr: preferred_partner
      comment: "Whether the OTA is a preferred partner, for segmenting investment and relationship management by tier."
    - name: "cancellation_policy_type"
      expr: cancellation_policy_type
      comment: "Cancellation policy type offered through the OTA partner, for policy alignment and risk analysis."
    - name: "channel_manager_platform"
      expr: channel_manager_platform
      comment: "Channel manager platform used for connectivity with the OTA, for technology stack and integration cost analysis."
    - name: "contract_effective_date_month"
      expr: DATE_TRUNC('month', contract_effective_date)
      comment: "Month the OTA contract became effective for contract vintage and renewal pipeline analysis."
    - name: "mobile_app_channel"
      expr: mobile_app_channel
      comment: "Whether the OTA partner has a mobile app channel, for mobile distribution reach analysis."
  measures:
    - name: "total_active_ota_partners"
      expr: COUNT(CASE WHEN partner_status = 'active' THEN 1 END)
      comment: "Number of currently active OTA partners. Tracks distribution network breadth and informs partner acquisition or consolidation strategy."
    - name: "avg_base_commission_rate_pct"
      expr: AVG(CAST(base_commission_rate_pct AS DOUBLE))
      comment: "Average base commission rate percentage across OTA partners. Core cost-of-distribution benchmark for OTA contract negotiation and budget planning."
    - name: "avg_preferred_commission_rate_pct"
      expr: AVG(CAST(preferred_commission_rate_pct AS DOUBLE))
      comment: "Average preferred partner commission rate. Tracks the premium cost of preferred partner status and informs tier investment decisions."
    - name: "commission_rate_premium"
      expr: AVG(CAST(preferred_commission_rate_pct AS DOUBLE)) - AVG(CAST(base_commission_rate_pct AS DOUBLE))
      comment: "Difference between preferred and base commission rates. Quantifies the cost premium of preferred partner status to inform tier strategy ROI."
    - name: "avg_connectivity_fee_usd"
      expr: AVG(CAST(connectivity_fee_usd AS DOUBLE))
      comment: "Average connectivity fee in USD per OTA partner. Tracks technology cost-of-distribution per partner for vendor cost benchmarking."
    - name: "total_connectivity_fee_usd"
      expr: SUM(CAST(connectivity_fee_usd AS DOUBLE))
      comment: "Total connectivity fee exposure across all OTA partners. Aggregate technology distribution cost for IT budget and vendor management decisions."
    - name: "avg_content_score"
      expr: AVG(CAST(content_score AS DOUBLE))
      comment: "Average content quality score across OTA partners. Content quality directly impacts search ranking and conversion on OTA platforms."
    - name: "avg_review_score"
      expr: AVG(CAST(review_score AS DOUBLE))
      comment: "Average guest review score across OTA partners. Review scores drive OTA search ranking and booking conversion — a key demand generation KPI."
    - name: "preferred_partner_count"
      expr: COUNT(CASE WHEN preferred_partner = TRUE THEN 1 END)
      comment: "Number of OTA partners with preferred partner status. Tracks preferred partner program scale and associated commission premium exposure."
    - name: "rate_parity_clause_partner_count"
      expr: COUNT(CASE WHEN rate_parity_clause = TRUE THEN 1 END)
      comment: "Number of OTA partners with rate parity clauses. Quantifies rate parity compliance exposure across the OTA partner portfolio."
    - name: "expiring_contracts_count"
      expr: COUNT(CASE WHEN contract_expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND partner_status = 'active' THEN 1 END)
      comment: "Number of active OTA partner contracts expiring within 90 days. Critical renewal pipeline metric for maintaining distribution continuity."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_inventory_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel inventory allocation metrics tracking room availability, sell-through efficiency, overbooking exposure, and stop-sell activity. Supports revenue management, yield optimization, and channel inventory strategy decisions."
  source: "`vibe_travel_hospitality_v1`.`channel`.`inventory_allocation`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel type for segmenting inventory allocation performance by channel category."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of inventory allocation (allotment, free-sell, on-request) for yield management analysis."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the allocation (open, closed, released) for real-time inventory availability monitoring."
    - name: "allotment_type"
      expr: allotment_type
      comment: "Allotment type (hard block, soft block, free-sell) for inventory commitment risk analysis."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of inventory restriction applied (CTA, CTD, min-stay, max-stay) for restriction impact analysis."
    - name: "is_stop_sell"
      expr: is_stop_sell
      comment: "Whether stop-sell is active on this allocation — a critical revenue management control flag."
    - name: "is_closed_to_arrival"
      expr: is_closed_to_arrival
      comment: "Whether closed-to-arrival restriction is active, for tracking arrival restriction impact on bookings."
    - name: "is_rms_generated"
      expr: is_rms_generated
      comment: "Whether the allocation was generated by the Revenue Management System, for RMS automation coverage analysis."
    - name: "stay_date_month"
      expr: DATE_TRUNC('month', stay_date)
      comment: "Stay date truncated to month for time-series inventory availability and sell-through trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the inventory allocation for multi-currency revenue analysis."
  measures:
    - name: "avg_channel_allocation_pct"
      expr: AVG(CAST(channel_allocation_pct AS DOUBLE))
      comment: "Average percentage of inventory allocated to each channel. Tracks channel inventory share and informs allocation rebalancing decisions."
    - name: "avg_overbooking_limit_pct"
      expr: AVG(CAST(overbooking_limit_pct AS DOUBLE))
      comment: "Average overbooking limit percentage across allocations. Tracks overbooking exposure — excessive overbooking creates guest experience and compensation risk."
    - name: "total_commission_cost"
      expr: SUM(CAST(commission_rate AS DOUBLE))
      comment: "Total commission rate exposure across inventory allocations. Tracks distribution cost embedded in inventory commitments."
    - name: "total_connectivity_fee"
      expr: SUM(CAST(connectivity_fee AS DOUBLE))
      comment: "Total connectivity fee across inventory allocations. Tracks technology cost associated with channel inventory distribution."
    - name: "stop_sell_allocation_count"
      expr: COUNT(CASE WHEN is_stop_sell = TRUE THEN 1 END)
      comment: "Number of allocations with stop-sell active. High stop-sell counts indicate aggressive inventory restriction that may suppress revenue."
    - name: "stop_sell_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_stop_sell = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations with stop-sell active. Tracks inventory restriction intensity by channel — informs yield management strategy."
    - name: "closed_to_arrival_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_closed_to_arrival = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations with closed-to-arrival restriction. Tracks arrival restriction intensity impacting booking pace."
    - name: "rms_generated_allocation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_rms_generated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations generated by the RMS. Tracks automation coverage of inventory management — low rates indicate manual override risk."
    - name: "lra_enabled_allocation_count"
      expr: COUNT(CASE WHEN lra_enabled_flag = TRUE THEN 1 END)
      comment: "Number of allocations with Last Room Availability enabled. Tracks LRA obligation fulfillment across channel inventory commitments."
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of inventory allocation records. Baseline volume metric for inventory management activity and channel coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_gds_connection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GDS (Global Distribution System) connection performance metrics tracking connectivity health, cost structure, SLA compliance, and rate plan coverage. Supports GDS strategy, technology investment, and corporate travel distribution decisions."
  source: "`vibe_travel_hospitality_v1`.`channel`.`gds_connection`"
  dimensions:
    - name: "gds_name"
      expr: gds_name
      comment: "Name of the GDS platform (Amadeus, Sabre, Travelport, etc.) for platform-level performance segmentation."
    - name: "connection_status"
      expr: connection_status
      comment: "Current operational status of the GDS connection (active, inactive, suspended) for connectivity health monitoring."
    - name: "connectivity_type"
      expr: connectivity_type
      comment: "Type of GDS connectivity (direct connect, switch, CRS) for technology architecture analysis."
    - name: "gds_tier"
      expr: gds_tier
      comment: "GDS tier designation for the property, affecting display priority and booking visibility in GDS search results."
    - name: "health_check_status"
      expr: health_check_status
      comment: "Current health check status of the GDS connection for real-time connectivity monitoring."
    - name: "availability_sync_method"
      expr: availability_sync_method
      comment: "Method used to synchronize availability with the GDS (push, pull, two-way) for integration architecture analysis."
    - name: "lra_enabled"
      expr: lra_enabled
      comment: "Whether Last Room Availability is enabled on this GDS connection — a key corporate contract obligation."
    - name: "corporate_rate_enabled"
      expr: corporate_rate_enabled
      comment: "Whether corporate rates are enabled on this GDS connection, for corporate travel distribution coverage analysis."
    - name: "activation_date_month"
      expr: DATE_TRUNC('month', activation_date)
      comment: "Month of GDS connection activation for tracking GDS portfolio growth over time."
  measures:
    - name: "total_active_gds_connections"
      expr: COUNT(CASE WHEN connection_status = 'active' THEN 1 END)
      comment: "Number of currently active GDS connections. Tracks GDS distribution network coverage — gaps cause lost corporate travel bookings."
    - name: "avg_uptime_sla_pct"
      expr: AVG(CAST(uptime_sla_pct AS DOUBLE))
      comment: "Average GDS connection uptime SLA percentage. Measures distribution technology reliability — downtime directly causes lost bookings and revenue."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage across GDS connections. Tracks GDS distribution cost for contract benchmarking and renegotiation."
    - name: "avg_connectivity_fee_monthly_usd"
      expr: AVG(CAST(connectivity_fee_monthly_usd AS DOUBLE))
      comment: "Average monthly connectivity fee in USD per GDS connection. Tracks recurring technology cost for GDS distribution budget planning."
    - name: "total_monthly_connectivity_cost_usd"
      expr: SUM(CAST(connectivity_fee_monthly_usd AS DOUBLE))
      comment: "Total monthly GDS connectivity cost in USD. Aggregate technology distribution cost for IT budget and vendor management decisions."
    - name: "avg_segment_fee_usd"
      expr: AVG(CAST(segment_fee_usd AS DOUBLE))
      comment: "Average per-segment fee in USD across GDS connections. Tracks variable transaction cost of GDS distribution for cost-per-booking analysis."
    - name: "total_segment_fee_exposure_usd"
      expr: SUM(CAST(segment_fee_usd AS DOUBLE))
      comment: "Total segment fee exposure across all GDS connections. Quantifies variable GDS transaction cost for financial planning."
    - name: "lra_enabled_connection_count"
      expr: COUNT(CASE WHEN lra_enabled = TRUE THEN 1 END)
      comment: "Number of GDS connections with Last Room Availability enabled. Tracks LRA obligation fulfillment — non-compliance risks corporate contract penalties."
    - name: "corporate_rate_enabled_count"
      expr: COUNT(CASE WHEN corporate_rate_enabled = TRUE THEN 1 END)
      comment: "Number of GDS connections with corporate rates enabled. Measures corporate travel distribution reach, a key B2B revenue channel."
    - name: "healthy_connection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN health_check_status = 'healthy' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of GDS connections with healthy status. Tracks overall GDS connectivity health — low rates signal systemic distribution technology issues."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_rate_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel rate plan metrics tracking rate loading coverage, commission structures, rate parity compliance, and rate plan portfolio health. Supports revenue management, rate strategy, and channel distribution optimization decisions."
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_rate_plan`"
  dimensions:
    - name: "rate_plan_type"
      expr: rate_plan_type
      comment: "Type of rate plan (BAR, corporate, package, promotional) for rate strategy segmentation."
    - name: "rate_loading_status"
      expr: rate_loading_status
      comment: "Current loading status of the rate plan (loaded, pending, failed) for rate distribution health monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rate plan for multi-currency rate strategy analysis."
    - name: "rate_derivation_method"
      expr: rate_derivation_method
      comment: "Method used to derive the channel rate (flat, percentage offset, formula) for rate management analysis."
    - name: "rate_adjustment_type"
      expr: rate_adjustment_type
      comment: "Type of rate adjustment applied (discount, premium, flat) for rate strategy analysis."
    - name: "is_rate_parity_applicable"
      expr: is_rate_parity_applicable
      comment: "Whether rate parity applies to this rate plan — a key compliance risk dimension."
    - name: "is_refundable"
      expr: is_refundable
      comment: "Whether the rate plan is refundable, for cancellation risk and NRR strategy analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the rate plan became effective for rate strategy timeline analysis."
    - name: "rate_parity_group_code"
      expr: rate_parity_group_code
      comment: "Rate parity group code for grouping rate plans under the same parity obligation for compliance monitoring."
  measures:
    - name: "avg_base_rate_amount"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate amount across channel rate plans. Core rate benchmarking KPI for pricing strategy and competitive positioning."
    - name: "avg_channel_rate_amount"
      expr: AVG(CAST(channel_rate_amount AS DOUBLE))
      comment: "Average channel-specific rate amount. Tracks effective rate loaded to channels for rate parity and yield analysis."
    - name: "avg_rate_adjustment_value"
      expr: AVG(CAST(rate_adjustment_value AS DOUBLE))
      comment: "Average rate adjustment value applied to channel rates. Measures the magnitude of channel rate modifications from base rates."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage across channel rate plans. Tracks commission cost embedded in rate plan structures."
    - name: "avg_connectivity_fee_amount"
      expr: AVG(CAST(connectivity_fee_amount AS DOUBLE))
      comment: "Average connectivity fee per rate plan. Tracks technology cost associated with rate plan distribution."
    - name: "total_rate_plans"
      expr: COUNT(1)
      comment: "Total number of channel rate plans. Tracks rate plan portfolio size and distribution coverage breadth."
    - name: "rate_parity_applicable_count"
      expr: COUNT(CASE WHEN is_rate_parity_applicable = TRUE THEN 1 END)
      comment: "Number of rate plans subject to rate parity obligations. Quantifies rate parity compliance exposure across the rate plan portfolio."
    - name: "non_refundable_rate_plan_count"
      expr: COUNT(CASE WHEN is_refundable = FALSE THEN 1 END)
      comment: "Number of non-refundable rate plans. Tracks NRR distribution coverage — NRR rates reduce cancellation risk and improve revenue certainty."
    - name: "non_refundable_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_refundable = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rate plans that are non-refundable. Tracks NRR penetration in the rate plan portfolio — a key revenue certainty KPI."
    - name: "loaded_rate_plan_count"
      expr: COUNT(CASE WHEN rate_loading_status = 'loaded' THEN 1 END)
      comment: "Number of rate plans successfully loaded to channels. Tracks rate distribution completeness — unloaded rates cause booking gaps."
    - name: "rate_loading_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rate_loading_status = 'loaded' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rate plans successfully loaded. Measures rate distribution operational efficiency — low rates indicate loading failures causing revenue loss."
$$;