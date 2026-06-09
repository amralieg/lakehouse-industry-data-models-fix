-- Metric views for domain: channel | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 05:56:59

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core channel booking performance metrics covering revenue, commission costs, and booking mix. Primary KPI layer for channel mix optimization, cost-of-acquisition analysis, and distribution strategy decisions."
  source: "`travel_hospitality_ecm`.`channel`.`channel_booking`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel type (e.g., OTA, GDS, Direct, Voice) used to segment booking performance by channel category."
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the booking (e.g., confirmed, cancelled, modified) enabling funnel and cancellation analysis."
    - name: "rate_type"
      expr: rate_type
      comment: "Rate type applied to the booking (e.g., BAR, corporate, package) for rate mix and yield analysis."
    - name: "source_country"
      expr: source_country
      comment: "Country of origin for the booking, enabling geographic demand and channel mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the booking was transacted, supporting multi-currency revenue reporting."
    - name: "cancellation_policy_code"
      expr: cancellation_policy_code
      comment: "Cancellation policy applied to the booking, used to assess risk exposure and policy mix."
    - name: "is_cancelled"
      expr: is_cancelled
      comment: "Boolean flag indicating whether the booking was cancelled, enabling cancellation rate segmentation."
    - name: "is_rate_parity_compliant"
      expr: is_rate_parity_compliant
      comment: "Boolean flag indicating whether the booking rate was parity-compliant, supporting rate parity monitoring."
    - name: "check_in_date"
      expr: DATE_TRUNC('month', check_in_date)
      comment: "Check-in month bucket for time-series analysis of booking demand and revenue by arrival period."
    - name: "booking_date"
      expr: DATE_TRUNC('month', CAST(booking_timestamp AS DATE))
      comment: "Month in which the booking was made, enabling booking pace and lead-time trend analysis."
  measures:
    - name: "total_bookings"
      expr: COUNT(1)
      comment: "Total number of channel bookings. Baseline volume KPI for channel throughput and demand tracking."
    - name: "confirmed_bookings"
      expr: COUNT(CASE WHEN is_cancelled = FALSE THEN 1 END)
      comment: "Count of non-cancelled bookings. Represents net confirmed demand used in occupancy and revenue forecasting."
    - name: "cancelled_bookings"
      expr: COUNT(CASE WHEN is_cancelled = TRUE THEN 1 END)
      comment: "Count of cancelled bookings. Drives cancellation rate analysis and risk exposure assessment by channel."
    - name: "total_gross_booking_value"
      expr: SUM(CAST(gross_booking_value AS DOUBLE))
      comment: "Total gross booking value across all channel bookings. Primary revenue volume KPI for channel contribution analysis."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after commissions and fees. Core profitability measure for channel economics and margin management."
    - name: "total_channel_commission"
      expr: SUM(CAST(channel_commission_amount AS DOUBLE))
      comment: "Total commission paid to distribution channels. Critical cost-of-acquisition KPI for channel profitability and contract negotiation."
    - name: "total_connectivity_fees"
      expr: SUM(CAST(connectivity_fee_amount AS DOUBLE))
      comment: "Total connectivity fees incurred across channel bookings. Contributes to total cost of distribution for channel economics."
    - name: "avg_daily_rate"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average daily rate across channel bookings. Key yield metric used to assess pricing effectiveness by channel and rate type."
    - name: "avg_gross_booking_value"
      expr: AVG(CAST(gross_booking_value AS DOUBLE))
      comment: "Average gross booking value per transaction. Indicates booking quality and value mix by channel."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage across bookings. Used to benchmark channel cost efficiency and contract compliance."
    - name: "rate_parity_compliant_bookings"
      expr: COUNT(CASE WHEN is_rate_parity_compliant = TRUE THEN 1 END)
      comment: "Count of bookings where rate parity was maintained. Supports rate parity compliance monitoring and OTA contract enforcement."
    - name: "parity_non_compliant_bookings"
      expr: COUNT(CASE WHEN is_rate_parity_compliant = FALSE THEN 1 END)
      comment: "Count of bookings where rate parity was violated. Flags channels with systemic parity breaches requiring contract action."
    - name: "modified_bookings"
      expr: COUNT(CASE WHEN is_modified = TRUE THEN 1 END)
      comment: "Count of bookings that were modified post-confirmation. Indicates booking instability and potential revenue leakage by channel."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_commission_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission cost and accrual metrics for distribution channel financial management. Supports accounts payable, cost-of-acquisition tracking, and commission dispute resolution across OTA, GDS, and travel agent channels."
  source: "`travel_hospitality_ecm`.`channel`.`commission_accrual`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel type for segmenting commission costs by channel category (OTA, GDS, TA, etc.)."
    - name: "commission_type"
      expr: commission_type
      comment: "Type of commission (e.g., base, override, preferred partner) for commission structure analysis."
    - name: "commission_basis"
      expr: commission_basis
      comment: "Basis on which commission is calculated (e.g., net rate, gross rate, room revenue) for cost modeling."
    - name: "accrual_status"
      expr: accrual_status
      comment: "Current status of the commission accrual (e.g., pending, paid, disputed) for payables management."
    - name: "is_commissionable"
      expr: is_commissionable
      comment: "Boolean flag indicating whether the booking is subject to commission, enabling commissionable vs. non-commissionable revenue split."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local currency of the commission accrual for multi-currency cost reporting."
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code for commission postings, supporting financial reconciliation."
    - name: "accrual_month"
      expr: DATE_TRUNC('month', accrual_date)
      comment: "Month of commission accrual for time-series cost trend analysis and period-over-period comparison."
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of commission payment for cash flow and payables aging analysis."
  measures:
    - name: "total_accruals"
      expr: COUNT(1)
      comment: "Total number of commission accrual records. Baseline volume for accrual pipeline monitoring."
    - name: "total_commission_base_currency"
      expr: SUM(CAST(commission_amount_base AS DOUBLE))
      comment: "Total commission accrued in base (USD) currency. Primary cost-of-distribution KPI for channel P&L and budget management."
    - name: "total_commission_local_currency"
      expr: SUM(CAST(commission_amount_local AS DOUBLE))
      comment: "Total commission accrued in local currency. Supports regional cost reporting and FX exposure analysis."
    - name: "total_gross_booking_value"
      expr: SUM(CAST(gross_booking_value AS DOUBLE))
      comment: "Total gross booking value associated with commission accruals. Used as denominator for effective commission rate calculations."
    - name: "total_connectivity_fees"
      expr: SUM(CAST(connectivity_fee_amount AS DOUBLE))
      comment: "Total connectivity fees accrued alongside commissions. Contributes to total cost of acquisition per channel."
    - name: "total_cost_of_acquisition"
      expr: SUM(CAST(total_cost_of_acquisition AS DOUBLE))
      comment: "Total cost of acquisition including commission and fees. Strategic KPI for channel profitability and distribution cost benchmarking."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across accruals. Used to benchmark channel cost efficiency and identify rate outliers."
    - name: "avg_adr_on_commissionable_bookings"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average daily rate on bookings generating commission accruals. Indicates yield quality of commissionable channel demand."
    - name: "disputed_accruals"
      expr: COUNT(CASE WHEN accrual_status = 'disputed' THEN 1 END)
      comment: "Count of commission accruals in disputed status. Flags financial risk and operational effort in commission dispute resolution."
    - name: "avg_fx_rate"
      expr: AVG(CAST(fx_rate AS DOUBLE))
      comment: "Average FX rate applied to commission accruals. Supports FX impact analysis on commission costs."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel contract portfolio metrics for distribution agreement governance, cost structure analysis, and contract lifecycle management. Supports legal, finance, and commercial teams in contract compliance and renewal planning."
  source: "`travel_hospitality_ecm`.`channel`.`channel_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of channel contract (e.g., OTA, GDS, wholesale) for portfolio segmentation and governance."
    - name: "contract_status"
      expr: contract_status
      comment: "Current lifecycle status of the contract (e.g., active, expired, terminated) for contract portfolio health monitoring."
    - name: "commission_basis"
      expr: commission_basis
      comment: "Basis on which commission is calculated under the contract, enabling cost structure benchmarking."
    - name: "payment_model"
      expr: payment_model
      comment: "Payment model specified in the contract (e.g., merchant, agency) for financial flow analysis."
    - name: "rate_parity_type"
      expr: rate_parity_type
      comment: "Type of rate parity obligation in the contract (e.g., broad, narrow, none) for parity risk assessment."
    - name: "preferred_partner_tier"
      expr: preferred_partner_tier
      comment: "Preferred partner tier designation in the contract for strategic partner segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency financial exposure analysis."
    - name: "rate_parity_clause"
      expr: rate_parity_clause
      comment: "Boolean indicating whether the contract includes a rate parity clause, critical for parity compliance risk management."
    - name: "nrr_allowed"
      expr: nrr_allowed
      comment: "Boolean indicating whether non-refundable rates are permitted under the contract."
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month of contract expiration for renewal pipeline planning and contract lifecycle management."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of channel contracts in the portfolio. Baseline for contract portfolio size and governance scope."
    - name: "active_contracts"
      expr: COUNT(CASE WHEN contract_status = 'active' THEN 1 END)
      comment: "Count of currently active channel contracts. Indicates live distribution footprint and active commercial relationships."
    - name: "expiring_contracts_90d"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Contracts expiring within 90 days. Critical renewal pipeline KPI for commercial and legal teams to prioritize renegotiation."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average contracted commission rate across channel contracts. Benchmarks cost of distribution and informs negotiation strategy."
    - name: "total_marketing_coop_committed"
      expr: SUM(CAST(marketing_coop_amount AS DOUBLE))
      comment: "Total marketing co-op investment committed across channel contracts. Supports marketing budget planning and ROI assessment."
    - name: "avg_connectivity_fee"
      expr: AVG(CAST(connectivity_fee AS DOUBLE))
      comment: "Average connectivity fee per contract. Used to benchmark technology cost of distribution across channel partners."
    - name: "contracts_with_parity_clause"
      expr: COUNT(CASE WHEN rate_parity_clause = TRUE THEN 1 END)
      comment: "Count of contracts containing a rate parity clause. Quantifies parity obligation exposure across the distribution portfolio."
    - name: "contracts_nrr_allowed"
      expr: COUNT(CASE WHEN nrr_allowed = TRUE THEN 1 END)
      comment: "Count of contracts permitting non-refundable rates. Indicates revenue protection flexibility available through channel agreements."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_rate_parity_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate parity compliance and violation metrics for distribution channel governance. Enables revenue management and commercial teams to monitor parity breaches, quantify rate variance exposure, and enforce contractual parity obligations."
  source: "`travel_hospitality_ecm`.`channel`.`rate_parity_audit`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel type where the rate parity audit was conducted, enabling violation analysis by channel category."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the parity audit (e.g., open, resolved, escalated) for compliance workflow management."
    - name: "violation_type"
      expr: violation_type
      comment: "Type of rate parity violation detected (e.g., undercutting, surcharging) for root cause categorization."
    - name: "violation_severity"
      expr: violation_severity
      comment: "Severity level of the parity violation (e.g., low, medium, high) for prioritizing remediation actions."
    - name: "is_parity_violation"
      expr: is_parity_violation
      comment: "Boolean flag indicating whether a parity violation was detected in the audit record."
    - name: "monitoring_source"
      expr: monitoring_source
      comment: "Source system or tool used to detect the parity issue (e.g., rate shopping tool, manual review)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the audited rates for multi-currency parity analysis."
    - name: "stay_month"
      expr: DATE_TRUNC('month', stay_date)
      comment: "Stay month of the audited rate for seasonal parity violation trend analysis."
    - name: "audit_month"
      expr: DATE_TRUNC('month', CAST(audit_timestamp AS DATE))
      comment: "Month the audit was conducted for monitoring cadence and trend analysis."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of rate parity audit records. Baseline for monitoring coverage and audit program scope."
    - name: "total_violations"
      expr: COUNT(CASE WHEN is_parity_violation = TRUE THEN 1 END)
      comment: "Total count of confirmed rate parity violations. Primary compliance KPI for OTA contract enforcement and revenue protection."
    - name: "high_severity_violations"
      expr: COUNT(CASE WHEN is_parity_violation = TRUE AND violation_severity = 'high' THEN 1 END)
      comment: "Count of high-severity parity violations. Triggers immediate commercial escalation and potential contract remedies."
    - name: "avg_rate_variance"
      expr: AVG(CAST(rate_variance AS DOUBLE))
      comment: "Average absolute rate variance between direct and channel rates. Quantifies the magnitude of parity deviation across audits."
    - name: "avg_rate_variance_pct"
      expr: AVG(CAST(rate_variance_pct AS DOUBLE))
      comment: "Average percentage rate variance. Key metric for assessing systemic parity undercutting severity by channel."
    - name: "avg_direct_rate"
      expr: AVG(CAST(direct_rate AS DOUBLE))
      comment: "Average direct booking rate observed during audits. Benchmarks direct channel pricing competitiveness."
    - name: "avg_observed_channel_rate"
      expr: AVG(CAST(observed_rate AS DOUBLE))
      comment: "Average rate observed on the channel during audit. Used alongside direct rate to compute parity gap."
    - name: "disputes_raised"
      expr: COUNT(CASE WHEN dispute_raised_date IS NOT NULL THEN 1 END)
      comment: "Count of parity violations that escalated to formal disputes. Indicates severity of channel non-compliance and legal exposure."
    - name: "disputes_resolved"
      expr: COUNT(CASE WHEN dispute_resolved_date IS NOT NULL THEN 1 END)
      comment: "Count of parity disputes that have been resolved. Measures effectiveness of commercial dispute resolution processes."
    - name: "avg_tolerance_threshold_pct"
      expr: AVG(CAST(tolerance_threshold_pct AS DOUBLE))
      comment: "Average parity tolerance threshold applied across audits. Contextualizes violation counts relative to contracted tolerance bands."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel master entity metrics for distribution portfolio governance, cost benchmarking, and channel capability assessment. Supports commercial strategy, technology investment, and channel mix optimization decisions."
  source: "`travel_hospitality_ecm`.`channel`.`channel`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Type of distribution channel (e.g., OTA, GDS, Direct, Voice) for portfolio segmentation."
    - name: "channel_category"
      expr: channel_category
      comment: "Broader category grouping of channels for strategic portfolio analysis."
    - name: "channel_status"
      expr: channel_status
      comment: "Operational status of the channel (e.g., active, inactive, suspended) for portfolio health monitoring."
    - name: "payment_model"
      expr: payment_model
      comment: "Payment model used by the channel (e.g., merchant, agency) for financial flow and working capital analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic coverage of the channel for market reach and distribution footprint analysis."
    - name: "loyalty_bookings_eligible"
      expr: loyalty_bookings_eligible
      comment: "Boolean indicating whether the channel supports loyalty program bookings, relevant for loyalty strategy."
    - name: "bar_eligible"
      expr: bar_eligible
      comment: "Boolean indicating whether the channel is eligible for Best Available Rate distribution."
    - name: "pci_compliant"
      expr: pci_compliant
      comment: "Boolean indicating PCI compliance status of the channel, critical for payment security governance."
    - name: "activation_month"
      expr: DATE_TRUNC('month', activation_date)
      comment: "Month the channel was activated for channel onboarding trend analysis."
  measures:
    - name: "total_channels"
      expr: COUNT(1)
      comment: "Total number of distribution channels in the portfolio. Baseline for distribution footprint and channel diversity assessment."
    - name: "active_channels"
      expr: COUNT(CASE WHEN channel_status = 'active' THEN 1 END)
      comment: "Count of currently active distribution channels. Indicates live distribution reach and operational channel footprint."
    - name: "loyalty_eligible_channels"
      expr: COUNT(CASE WHEN loyalty_bookings_eligible = TRUE THEN 1 END)
      comment: "Count of channels supporting loyalty program bookings. Informs loyalty program distribution strategy and member acquisition reach."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage across channels. Benchmarks cost of distribution and supports contract negotiation strategy."
    - name: "avg_booking_fee_usd"
      expr: AVG(CAST(booking_fee_usd AS DOUBLE))
      comment: "Average per-booking fee in USD across channels. Contributes to total cost of acquisition benchmarking."
    - name: "avg_connectivity_fee_usd"
      expr: AVG(CAST(connectivity_fee_usd AS DOUBLE))
      comment: "Average connectivity fee in USD across channels. Supports technology cost benchmarking for distribution infrastructure decisions."
    - name: "avg_sla_uptime_pct"
      expr: AVG(CAST(sla_uptime_pct AS DOUBLE))
      comment: "Average SLA uptime percentage across channels. Operational reliability KPI for channel technology performance management."
    - name: "pci_compliant_channels"
      expr: COUNT(CASE WHEN pci_compliant = TRUE THEN 1 END)
      comment: "Count of PCI-compliant channels. Payment security governance KPI for risk and compliance reporting."
    - name: "mice_supported_channels"
      expr: COUNT(CASE WHEN mice_bookings_supported = TRUE THEN 1 END)
      comment: "Count of channels supporting MICE (Meetings, Incentives, Conferences, Events) bookings. Informs group and events distribution strategy."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_inventory_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel inventory allocation and restriction metrics for revenue management and distribution control. Enables yield management teams to monitor allocation efficiency, stop-sell activity, and overbooking exposure by channel."
  source: "`travel_hospitality_ecm`.`channel`.`inventory_allocation`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel type for segmenting inventory allocation decisions by channel category."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of inventory allocation (e.g., allotment, free-sell, on-request) for allocation strategy analysis."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the allocation record for operational monitoring of active vs. expired allocations."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of inventory restriction applied (e.g., CTA, CTD, min LOS) for restriction mix analysis."
    - name: "is_stop_sell"
      expr: is_stop_sell
      comment: "Boolean indicating whether a stop-sell restriction is active, enabling stop-sell coverage analysis."
    - name: "is_rms_generated"
      expr: is_rms_generated
      comment: "Boolean indicating whether the allocation was system-generated by the RMS, supporting automation vs. manual override analysis."
    - name: "action_type"
      expr: action_type
      comment: "Type of action taken on the allocation (e.g., open, close, modify) for operational activity monitoring."
    - name: "stay_month"
      expr: DATE_TRUNC('month', stay_date_from)
      comment: "Stay month of the allocation for seasonal inventory distribution pattern analysis."
  measures:
    - name: "total_allocation_records"
      expr: COUNT(1)
      comment: "Total number of inventory allocation records. Baseline for allocation activity volume and distribution control scope."
    - name: "active_allocations"
      expr: COUNT(CASE WHEN active_status = 'active' THEN 1 END)
      comment: "Count of currently active inventory allocations. Indicates live inventory distribution exposure across channels."
    - name: "stop_sell_records"
      expr: COUNT(CASE WHEN is_stop_sell = TRUE THEN 1 END)
      comment: "Count of active stop-sell restrictions. Revenue management KPI for monitoring inventory closure intensity by channel."
    - name: "avg_channel_allocation_pct"
      expr: AVG(CAST(channel_allocation_pct AS DOUBLE))
      comment: "Average percentage of inventory allocated to channels. Informs channel mix strategy and inventory distribution balance."
    - name: "avg_overbooking_limit_pct"
      expr: AVG(CAST(overbooking_limit_pct AS DOUBLE))
      comment: "Average overbooking limit percentage across allocations. Risk management KPI for overbooking exposure monitoring."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate on inventory allocations. Supports cost-of-distribution analysis at the allocation level."
    - name: "rms_generated_allocations"
      expr: COUNT(CASE WHEN is_rms_generated = TRUE THEN 1 END)
      comment: "Count of RMS-generated allocation decisions. Measures automation penetration in inventory distribution management."
    - name: "closed_to_arrival_records"
      expr: COUNT(CASE WHEN is_closed_to_arrival = TRUE THEN 1 END)
      comment: "Count of closed-to-arrival restrictions active across channels. Indicates demand management intensity for specific stay dates."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_gds_connection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GDS (Global Distribution System) connection performance and cost metrics. Supports technology operations, commercial, and finance teams in managing GDS connectivity health, cost efficiency, and contract compliance."
  source: "`travel_hospitality_ecm`.`channel`.`gds_connection`"
  dimensions:
    - name: "gds_name"
      expr: gds_name
      comment: "Name of the GDS platform (e.g., Amadeus, Sabre, Travelport) for per-GDS performance benchmarking."
    - name: "gds_tier"
      expr: gds_tier
      comment: "Tier classification of the GDS connection for strategic partner segmentation."
    - name: "connection_status"
      expr: connection_status
      comment: "Operational status of the GDS connection (e.g., active, inactive, suspended) for connectivity health monitoring."
    - name: "connectivity_type"
      expr: connectivity_type
      comment: "Technical connectivity type used for the GDS interface for infrastructure analysis."
    - name: "health_check_status"
      expr: health_check_status
      comment: "Latest health check result for the GDS connection, enabling real-time operational monitoring."
    - name: "lra_enabled"
      expr: lra_enabled
      comment: "Boolean indicating whether Last Room Availability is enabled on the GDS connection, relevant for yield strategy."
    - name: "nrr_supported"
      expr: nrr_supported
      comment: "Boolean indicating whether non-refundable rates are supported on the GDS connection."
    - name: "activation_month"
      expr: DATE_TRUNC('month', activation_date)
      comment: "Month the GDS connection was activated for onboarding trend analysis."
  measures:
    - name: "total_gds_connections"
      expr: COUNT(1)
      comment: "Total number of GDS connections. Baseline for GDS distribution footprint and connectivity portfolio scope."
    - name: "active_gds_connections"
      expr: COUNT(CASE WHEN connection_status = 'active' THEN 1 END)
      comment: "Count of active GDS connections. Indicates live GDS distribution reach for travel agent and corporate booking channels."
    - name: "avg_uptime_sla_pct"
      expr: AVG(CAST(uptime_sla_pct AS DOUBLE))
      comment: "Average SLA uptime percentage across GDS connections. Technology reliability KPI for GDS performance management and SLA compliance."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate across GDS connections. Benchmarks GDS cost of distribution for contract negotiation."
    - name: "total_monthly_connectivity_fees_usd"
      expr: SUM(CAST(connectivity_fee_monthly_usd AS DOUBLE))
      comment: "Total monthly connectivity fees across all GDS connections. Technology cost KPI for GDS infrastructure budget management."
    - name: "avg_segment_fee_usd"
      expr: AVG(CAST(segment_fee_usd AS DOUBLE))
      comment: "Average per-segment fee charged by GDS platforms. Variable cost KPI for GDS economics and booking cost modeling."
    - name: "lra_enabled_connections"
      expr: COUNT(CASE WHEN lra_enabled = TRUE THEN 1 END)
      comment: "Count of GDS connections with Last Room Availability enabled. Informs yield strategy and inventory exposure through GDS."
    - name: "connections_with_healthy_status"
      expr: COUNT(CASE WHEN health_check_status = 'healthy' THEN 1 END)
      comment: "Count of GDS connections passing health checks. Operational reliability KPI for technology operations and incident management."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_ota_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OTA (Online Travel Agency) partner portfolio metrics for commercial relationship management, cost benchmarking, and partner performance evaluation. Supports VP Distribution and commercial teams in OTA strategy and contract governance."
  source: "`travel_hospitality_ecm`.`channel`.`ota_partner`"
  dimensions:
    - name: "partner_type"
      expr: partner_type
      comment: "Type of OTA partner (e.g., global OTA, regional OTA, metasearch) for portfolio segmentation."
    - name: "partner_status"
      expr: partner_status
      comment: "Operational status of the OTA partner relationship (e.g., active, inactive, suspended)."
    - name: "commission_model"
      expr: commission_model
      comment: "Commission model used by the OTA (e.g., merchant, agency, net rate) for cost structure analysis."
    - name: "primary_market_country_code"
      expr: primary_market_country_code
      comment: "Primary market country of the OTA partner for geographic distribution strategy analysis."
    - name: "preferred_partner"
      expr: preferred_partner
      comment: "Boolean indicating preferred partner status, enabling tiered partner management and investment prioritization."
    - name: "rate_parity_clause"
      expr: rate_parity_clause
      comment: "Boolean indicating whether the OTA contract includes a rate parity clause, critical for parity risk management."
    - name: "mobile_app_channel"
      expr: mobile_app_channel
      comment: "Boolean indicating whether the OTA operates a mobile app channel, relevant for mobile distribution strategy."
    - name: "contract_expiry_month"
      expr: DATE_TRUNC('month', contract_expiry_date)
      comment: "Month of OTA contract expiry for renewal pipeline planning."
  measures:
    - name: "total_ota_partners"
      expr: COUNT(1)
      comment: "Total number of OTA partners in the portfolio. Baseline for OTA distribution breadth and partner diversity."
    - name: "active_ota_partners"
      expr: COUNT(CASE WHEN partner_status = 'active' THEN 1 END)
      comment: "Count of active OTA partners. Indicates live OTA distribution reach and active commercial relationships."
    - name: "preferred_partners"
      expr: COUNT(CASE WHEN preferred_partner = TRUE THEN 1 END)
      comment: "Count of preferred OTA partners. Informs strategic partner investment and co-marketing budget allocation."
    - name: "avg_base_commission_rate_pct"
      expr: AVG(CAST(base_commission_rate_pct AS DOUBLE))
      comment: "Average base commission rate across OTA partners. Primary cost-of-distribution benchmark for OTA contract negotiation."
    - name: "avg_preferred_commission_rate_pct"
      expr: AVG(CAST(preferred_commission_rate_pct AS DOUBLE))
      comment: "Average preferred partner commission rate. Quantifies the cost premium of preferred partner status for ROI assessment."
    - name: "avg_connectivity_fee_usd"
      expr: AVG(CAST(connectivity_fee_usd AS DOUBLE))
      comment: "Average connectivity fee per OTA partner. Technology cost benchmark for OTA integration investment decisions."
    - name: "avg_review_score"
      expr: AVG(CAST(review_score AS DOUBLE))
      comment: "Average guest review score across OTA platforms. Proxy for content quality and guest satisfaction on OTA channels."
    - name: "avg_content_score"
      expr: AVG(CAST(content_score AS DOUBLE))
      comment: "Average content score across OTA partners. Indicates content completeness and quality driving OTA search ranking and conversion."
    - name: "partners_with_parity_clause"
      expr: COUNT(CASE WHEN rate_parity_clause = TRUE THEN 1 END)
      comment: "Count of OTA partners with contractual rate parity clauses. Quantifies parity obligation exposure across the OTA portfolio."
    - name: "expiring_contracts_90d"
      expr: COUNT(CASE WHEN contract_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "OTA contracts expiring within 90 days. Renewal pipeline KPI for commercial teams to prioritize OTA renegotiations."
$$;