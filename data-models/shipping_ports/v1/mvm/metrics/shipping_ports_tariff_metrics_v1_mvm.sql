-- Metric views for domain: tariff | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 06:46:03

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_port_tariff`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over port tariff master records. Tracks tariff portfolio health, rate levels, discount eligibility, and regulatory filing obligations to support tariff governance and revenue management decisions."
  source: "`shipping_ports_ecm`.`tariff`.`port_tariff`"
  dimensions:
    - name: "tariff_status"
      expr: tariff_status
      comment: "Current lifecycle status of the port tariff (e.g. Active, Expired, Draft) — primary filter for operational vs. historical analysis."
    - name: "charge_type"
      expr: charge_type
      comment: "Category of charge covered by the tariff (e.g. Port Dues, Wharfage, THC) — enables revenue segmentation by charge type."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency for the tariff — supports multi-currency portfolio analysis."
    - name: "effective_from_date"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the tariff became effective — enables trend analysis of tariff introductions over time."
    - name: "effective_to_date"
      expr: DATE_TRUNC('month', effective_to_date)
      comment: "Month the tariff expires — supports proactive tariff renewal pipeline management."
    - name: "discount_eligible_flag"
      expr: discount_eligible_flag
      comment: "Indicates whether the tariff is eligible for discounting — segments negotiable vs. fixed-rate tariffs."
    - name: "public_tariff_flag"
      expr: public_tariff_flag
      comment: "Indicates whether the tariff is publicly published — distinguishes public schedule rates from confidential contract rates."
    - name: "regulatory_filing_required_flag"
      expr: regulatory_filing_required_flag
      comment: "Flags tariffs requiring regulatory filing — critical for compliance tracking and audit readiness."
    - name: "rate_unit_of_measure"
      expr: rate_unit_of_measure
      comment: "Unit basis for the tariff rate (e.g. per TEU, per GRT, per call) — enables like-for-like rate comparisons."
    - name: "applicable_trade_lanes"
      expr: applicable_trade_lanes
      comment: "Trade lanes covered by the tariff — supports trade-lane-level revenue and pricing analysis."
  measures:
    - name: "active_tariff_count"
      expr: COUNT(CASE WHEN tariff_status = 'Active' THEN port_tariff_id END)
      comment: "Number of currently active port tariffs. Tracks the live tariff portfolio size — a drop signals potential coverage gaps requiring urgent remediation."
    - name: "avg_base_rate_amount"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate across all port tariffs. Benchmarks the port's overall rate level against market and historical norms — a key input to revenue yield management."
    - name: "total_maximum_charge_amount"
      expr: SUM(CAST(maximum_charge_amount AS DOUBLE))
      comment: "Sum of maximum charge caps across tariffs. Represents the theoretical revenue ceiling of the tariff portfolio — used in revenue forecasting and capacity planning."
    - name: "avg_minimum_charge_amount"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum charge floor across tariffs. Indicates the revenue floor protection level — low averages may signal under-pricing risk."
    - name: "discount_eligible_tariff_count"
      expr: COUNT(CASE WHEN discount_eligible_flag = TRUE THEN port_tariff_id END)
      comment: "Number of tariffs eligible for discounting. Quantifies the negotiable portion of the tariff portfolio — high counts may indicate revenue leakage risk."
    - name: "regulatory_filing_required_count"
      expr: COUNT(CASE WHEN regulatory_filing_required_flag = TRUE THEN port_tariff_id END)
      comment: "Number of tariffs requiring regulatory filing. Directly drives compliance workload and risk exposure — unfiled tariffs can result in regulatory penalties."
    - name: "expiring_tariff_count_90d"
      expr: COUNT(CASE WHEN effective_to_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN port_tariff_id END)
      comment: "Number of tariffs expiring within the next 90 days. A leading indicator of tariff renewal urgency — prevents revenue disruption from lapsed tariffs."
    - name: "avg_dwt_band_max"
      expr: AVG(CAST(dwt_band_max AS DOUBLE))
      comment: "Average upper DWT band limit across tariffs. Indicates the vessel size ceiling the tariff portfolio is designed to serve — informs fleet mix and capacity strategy."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_rate_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commercial rate card performance and portfolio KPIs. Tracks committed volumes, discount levels, SLA tiers, and renewal pipeline to support commercial negotiations and revenue assurance."
  source: "`shipping_ports_ecm`.`tariff`.`rate_card`"
  dimensions:
    - name: "rate_card_type"
      expr: rate_card_type
      comment: "Classification of the rate card (e.g. Spot, Contract, Framework) — segments commercial agreements by type for portfolio analysis."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment the rate card applies to — enables segment-level revenue and discount analysis."
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level tier associated with the rate card — links commercial terms to operational service commitments."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency of the rate card — supports multi-currency commercial portfolio management."
    - name: "trade_lane"
      expr: trade_lane
      comment: "Trade lane scope of the rate card — enables trade-lane-level commercial performance analysis."
    - name: "service_type"
      expr: service_type
      comment: "Type of port service covered by the rate card (e.g. Container Handling, Storage) — supports service-line revenue analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the rate card — tracks governance pipeline and identifies bottlenecks in rate card activation."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the rate card auto-renews — distinguishes managed renewals from automatic rollovers that may lock in suboptimal rates."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the rate card became effective — enables cohort analysis of commercial agreements by vintage."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of billing under the rate card (e.g. Monthly, Per Call) — impacts cash flow forecasting and revenue recognition timing."
  measures:
    - name: "active_rate_card_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN rate_card_id END)
      comment: "Number of approved and active rate cards. Tracks the live commercial agreement portfolio — a key indicator of commercial coverage and customer engagement."
    - name: "total_committed_volume_teu"
      expr: SUM(CAST(committed_volume_teu AS DOUBLE))
      comment: "Total TEU volume committed across all rate cards. Represents contracted throughput obligations — directly drives terminal capacity planning and berth scheduling."
    - name: "avg_committed_volume_teu"
      expr: AVG(CAST(committed_volume_teu AS DOUBLE))
      comment: "Average committed TEU volume per rate card. Benchmarks the scale of individual commercial agreements — low averages may indicate fragmented, high-cost-to-serve customer base."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage granted across rate cards. A critical revenue leakage indicator — rising averages signal deteriorating commercial discipline or competitive pressure."
    - name: "total_minimum_commitment_amount"
      expr: SUM(CAST(minimum_commitment_amount AS DOUBLE))
      comment: "Total minimum revenue commitment across all rate cards. Represents the guaranteed revenue floor from contracted customers — a key input to revenue forecasting and financial planning."
    - name: "avg_premium_percentage"
      expr: AVG(CAST(premium_percentage AS DOUBLE))
      comment: "Average premium percentage charged above base rates. Measures the port's ability to command premium pricing — a direct indicator of competitive positioning and service differentiation."
    - name: "expiring_rate_card_count_90d"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN rate_card_id END)
      comment: "Number of rate cards expiring within 90 days. A leading indicator of commercial renewal urgency — prevents revenue disruption from lapsed agreements and enables proactive renegotiation."
    - name: "avg_crane_productivity_target"
      expr: AVG(CAST(crane_productivity_target_moves_per_hour AS DOUBLE))
      comment: "Average crane productivity target (moves/hour) committed in rate cards. Links commercial SLA commitments to operational performance benchmarks — misalignment drives penalty exposure."
    - name: "avg_vessel_turnaround_target_hours"
      expr: AVG(CAST(vessel_turnaround_time_target_hours AS DOUBLE))
      comment: "Average vessel turnaround time target (hours) committed in rate cards. Tracks the operational performance standard the port has commercially committed to — breaches trigger penalty clauses."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_rate_card_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level rate card KPIs covering unit rates, discounts, surcharges, tax applicability, and SLA targets. Provides granular commercial pricing intelligence to support rate benchmarking, margin analysis, and contract compliance."
  source: "`shipping_ports_ecm`.`tariff`.`rate_card_line`"
  dimensions:
    - name: "service_category"
      expr: service_category
      comment: "Service category of the rate card line (e.g. Lift-On/Lift-Off, Storage, Gate) — enables service-line-level rate analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency for the rate card line — supports multi-currency rate benchmarking."
    - name: "line_status"
      expr: line_status
      comment: "Lifecycle status of the rate card line (e.g. Active, Superseded, Draft) — filters operational vs. historical rate lines."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit basis for the rate (e.g. per TEU, per tonne, per move) — ensures like-for-like rate comparisons across lines."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency for the rate card line — impacts revenue recognition and cash flow timing."
    - name: "tax_applicable_flag"
      expr: tax_applicable_flag
      comment: "Indicates whether tax applies to this rate line — critical for gross vs. net revenue analysis and tax compliance reporting."
    - name: "surcharge_applicable_flag"
      expr: surcharge_applicable_flag
      comment: "Indicates whether surcharges apply to this rate line — identifies lines with additional revenue uplift potential."
    - name: "baf_applicable_flag"
      expr: baf_applicable_flag
      comment: "Indicates whether Bunker Adjustment Factor applies — tracks fuel cost pass-through exposure in commercial agreements."
    - name: "effective_from_date"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the rate line became effective — enables rate trend analysis and vintage cohort comparisons."
  measures:
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate across rate card lines. The primary rate benchmarking metric — deviations from market norms signal pricing risk or competitive opportunity."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied at line level. Measures commercial concession depth — high averages indicate revenue leakage and weak pricing discipline."
    - name: "avg_tax_rate_percentage"
      expr: AVG(CAST(tax_rate_percentage AS DOUBLE))
      comment: "Average tax rate percentage across applicable rate lines. Tracks the effective tax burden on port charges — informs net revenue calculations and tax compliance exposure."
    - name: "avg_penalty_rate"
      expr: AVG(CAST(penalty_rate AS DOUBLE))
      comment: "Average penalty rate across rate card lines. Quantifies the financial deterrent for SLA breaches — low averages may indicate insufficient contractual protection for the port."
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target hours committed at rate line level. Tracks the operational performance standard embedded in commercial agreements — a key input to operational planning."
    - name: "surcharge_applicable_line_count"
      expr: COUNT(CASE WHEN surcharge_applicable_flag = TRUE THEN rate_card_line_id END)
      comment: "Number of rate card lines with surcharges applicable. Quantifies surcharge revenue exposure across the commercial portfolio — high counts amplify revenue sensitivity to surcharge triggers."
    - name: "tax_applicable_line_count"
      expr: COUNT(CASE WHEN tax_applicable_flag = TRUE THEN rate_card_line_id END)
      comment: "Number of rate card lines subject to tax. Drives tax compliance workload and gross-to-net revenue reconciliation complexity."
    - name: "avg_tier_threshold_upper"
      expr: AVG(CAST(tier_threshold_upper AS DOUBLE))
      comment: "Average upper tier threshold across tiered rate lines. Indicates the volume/weight ceiling at which the highest rate tier applies — informs volume incentive structure design."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_thc_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Terminal Handling Charge (THC) schedule KPIs. Tracks base rates, surcharges, discount eligibility, and schedule coverage to support container handling revenue management and competitive rate benchmarking."
  source: "`shipping_ports_ecm`.`tariff`.`thc_schedule`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Direction of container movement (e.g. Import, Export, Transshipment) — the primary segmentation dimension for THC revenue analysis."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment the THC schedule applies to — enables segment-level rate differentiation analysis."
    - name: "trade_lane"
      expr: trade_lane
      comment: "Trade lane scope of the THC schedule — supports trade-lane-level competitive rate benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency for the THC schedule — supports multi-currency rate portfolio management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the THC schedule — tracks governance pipeline and identifies unapproved schedules in use."
    - name: "service_level"
      expr: service_level
      comment: "Service level tier associated with the THC schedule — links rate levels to service quality commitments."
    - name: "discount_eligible_flag"
      expr: discount_eligible_flag
      comment: "Indicates whether the THC schedule is eligible for discounting — segments negotiable vs. fixed THC rates."
    - name: "published_flag"
      expr: published_flag
      comment: "Indicates whether the THC schedule has been publicly published — distinguishes public tariff rates from confidential contract rates."
    - name: "effective_from_date"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the THC schedule became effective — enables rate trend analysis over time."
  measures:
    - name: "active_thc_schedule_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN thc_schedule_id END)
      comment: "Number of approved and active THC schedules. Tracks the live THC rate portfolio — gaps in coverage by movement type or trade lane signal revenue risk."
    - name: "avg_base_rate_amount"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average THC base rate across schedules. The primary THC rate benchmarking metric — deviations from market norms directly impact container line competitiveness and volume attraction."
    - name: "avg_dangerous_goods_surcharge"
      expr: AVG(CAST(dangerous_goods_surcharge AS DOUBLE))
      comment: "Average dangerous goods surcharge across THC schedules. Quantifies the DG cargo premium — a key input to DG cargo revenue strategy and risk-adjusted pricing."
    - name: "avg_reefer_surcharge"
      expr: AVG(CAST(reefer_surcharge AS DOUBLE))
      comment: "Average reefer surcharge across THC schedules. Tracks the cold chain premium — reefer cargo commands higher margins and this metric monitors pricing competitiveness in the reefer segment."
    - name: "avg_peak_season_surcharge"
      expr: AVG(CAST(peak_season_surcharge AS DOUBLE))
      comment: "Average peak season surcharge across THC schedules. Measures the port's ability to capture demand-driven revenue uplift during peak periods — a key yield management lever."
    - name: "avg_oversize_surcharge"
      expr: AVG(CAST(oversize_surcharge AS DOUBLE))
      comment: "Average oversize cargo surcharge across THC schedules. Tracks the premium for non-standard cargo handling — informs equipment investment decisions and special cargo pricing strategy."
    - name: "avg_minimum_charge_amount"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum charge floor across THC schedules. Indicates the revenue floor protection level — ensures the port recovers minimum handling costs regardless of cargo value."
    - name: "discount_eligible_schedule_count"
      expr: COUNT(CASE WHEN discount_eligible_flag = TRUE THEN thc_schedule_id END)
      comment: "Number of THC schedules eligible for discounting. Quantifies the negotiable portion of the THC portfolio — high counts may indicate revenue leakage risk from excessive commercial flexibility."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_demurrage_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demurrage schedule KPIs covering rate tiers, free time allowances, caps, and schedule coverage. Supports demurrage revenue optimization, free time policy governance, and container dwell time management."
  source: "`shipping_ports_ecm`.`tariff`.`demurrage_schedule`"
  dimensions:
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of demurrage schedule (e.g. Standard, Premium, Contractual) — primary segmentation for demurrage rate portfolio analysis."
    - name: "customer_tier"
      expr: customer_tier
      comment: "Customer tier the demurrage schedule applies to — enables tier-differentiated demurrage revenue analysis."
    - name: "trade_lane"
      expr: trade_lane
      comment: "Trade lane scope of the demurrage schedule — supports trade-lane-level demurrage revenue benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency for demurrage charges — supports multi-currency demurrage revenue management."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate demurrage (e.g. Per Day, Per Hour, Prorated) — impacts revenue recognition and customer dispute rates."
    - name: "demurrage_schedule_status"
      expr: demurrage_schedule_status
      comment: "Lifecycle status of the demurrage schedule — filters active vs. historical schedules for operational analysis."
    - name: "holiday_exclusion_flag"
      expr: holiday_exclusion_flag
      comment: "Indicates whether public holidays are excluded from demurrage calculation — impacts effective free time and revenue yield."
    - name: "weekend_exclusion_flag"
      expr: weekend_exclusion_flag
      comment: "Indicates whether weekends are excluded from demurrage calculation — a key commercial differentiator affecting demurrage revenue yield."
    - name: "effective_from_date"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the demurrage schedule became effective — enables rate trend analysis and schedule vintage comparisons."
  measures:
    - name: "active_demurrage_schedule_count"
      expr: COUNT(CASE WHEN demurrage_schedule_status = 'Active' THEN demurrage_schedule_id END)
      comment: "Number of active demurrage schedules. Tracks the live demurrage rate portfolio — coverage gaps by trade lane or customer tier signal revenue risk."
    - name: "avg_rate_tier_1_amount"
      expr: AVG(CAST(rate_tier_1_amount AS DOUBLE))
      comment: "Average Tier 1 demurrage rate (initial period). The entry-level demurrage rate is the most frequently applied — benchmarking this against market norms directly impacts container dwell time incentives."
    - name: "avg_rate_tier_2_amount"
      expr: AVG(CAST(rate_tier_2_amount AS DOUBLE))
      comment: "Average Tier 2 demurrage rate (escalated period). Tracks the escalation premium — the step-up from Tier 1 to Tier 2 is a key lever for incentivising timely container collection."
    - name: "avg_rate_tier_3_amount"
      expr: AVG(CAST(rate_tier_3_amount AS DOUBLE))
      comment: "Average Tier 3 demurrage rate (maximum escalation). The highest demurrage tier — tracks the port's maximum penalty rate and its deterrent effectiveness against chronic overstay."
    - name: "avg_maximum_demurrage_cap"
      expr: AVG(CAST(maximum_demurrage_cap AS DOUBLE))
      comment: "Average maximum demurrage cap across schedules. Quantifies the revenue ceiling per container — low caps limit demurrage revenue upside and may reduce dwell time deterrence."
    - name: "prorated_schedule_count"
      expr: COUNT(CASE WHEN prorated_calculation_flag = TRUE THEN demurrage_schedule_id END)
      comment: "Number of demurrage schedules using prorated calculation. Prorated schedules are more customer-friendly but reduce revenue predictability — tracks the balance between commercial flexibility and revenue certainty."
    - name: "tier_1_to_tier_2_rate_escalation_avg"
      expr: AVG(CAST(rate_tier_2_amount AS DOUBLE) - CAST(rate_tier_1_amount AS DOUBLE))
      comment: "Average rate escalation from Tier 1 to Tier 2 demurrage. Measures the financial incentive step-up for container collection — a key lever in dwell time management strategy."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_detention_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detention schedule KPIs covering rate tiers, free time, caps, and schedule governance. Supports detention revenue management, equipment utilisation incentives, and container return policy effectiveness."
  source: "`shipping_ports_ecm`.`tariff`.`detention_schedule`"
  dimensions:
    - name: "detention_schedule_status"
      expr: detention_schedule_status
      comment: "Lifecycle status of the detention schedule — filters active vs. historical schedules for operational analysis."
    - name: "customer_tier"
      expr: customer_tier
      comment: "Customer tier the detention schedule applies to — enables tier-differentiated detention revenue analysis."
    - name: "trade_direction"
      expr: trade_direction
      comment: "Trade direction (Import/Export) the schedule applies to — supports directional detention revenue analysis."
    - name: "service_line"
      expr: service_line
      comment: "Shipping service line the detention schedule is associated with — enables service-line-level detention rate benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency for detention charges — supports multi-currency detention revenue management."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate detention charges — impacts revenue recognition and dispute resolution."
    - name: "holiday_charge_applicable"
      expr: holiday_charge_applicable
      comment: "Indicates whether detention charges apply on public holidays — impacts effective revenue yield and customer perception."
    - name: "weekend_charge_applicable"
      expr: weekend_charge_applicable
      comment: "Indicates whether detention charges apply on weekends — a key commercial differentiator affecting detention revenue yield."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the detention schedule became effective — enables rate trend analysis over time."
  measures:
    - name: "active_detention_schedule_count"
      expr: COUNT(CASE WHEN detention_schedule_status = 'Active' THEN detention_schedule_id END)
      comment: "Number of active detention schedules. Tracks the live detention rate portfolio — coverage gaps signal equipment return incentive weaknesses."
    - name: "avg_rate_tier_1_amount"
      expr: AVG(CAST(rate_tier_1_amount AS DOUBLE))
      comment: "Average Tier 1 detention rate (initial period). The entry-level detention rate most frequently applied — benchmarking against market norms directly impacts equipment return incentives."
    - name: "avg_rate_tier_2_amount"
      expr: AVG(CAST(rate_tier_2_amount AS DOUBLE))
      comment: "Average Tier 2 detention rate (escalated period). Tracks the escalation premium — the step-up from Tier 1 to Tier 2 is a key lever for incentivising timely equipment return."
    - name: "avg_rate_tier_3_amount"
      expr: AVG(CAST(rate_tier_3_amount AS DOUBLE))
      comment: "Average Tier 3 detention rate (maximum escalation). The highest detention tier — tracks the port's maximum equipment return penalty and its deterrent effectiveness."
    - name: "avg_maximum_detention_cap"
      expr: AVG(CAST(maximum_detention_cap AS DOUBLE))
      comment: "Average maximum detention cap across schedules. Quantifies the revenue ceiling per container — low caps limit detention revenue upside and may reduce equipment return urgency."
    - name: "waiver_eligible_schedule_count"
      expr: COUNT(CASE WHEN waiver_eligible = TRUE THEN detention_schedule_id END)
      comment: "Number of detention schedules with waiver eligibility. Tracks the proportion of schedules where charges can be waived — high counts may indicate revenue leakage risk from excessive waiver grants."
    - name: "tier_1_to_tier_2_rate_escalation_avg"
      expr: AVG(CAST(rate_tier_2_amount AS DOUBLE) - CAST(rate_tier_1_amount AS DOUBLE))
      comment: "Average rate escalation from Tier 1 to Tier 2 detention. Measures the financial incentive step-up for equipment return — a key lever in container fleet management strategy."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_storage_tariff`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage tariff KPIs covering daily rates, free storage periods, charge caps, and tariff coverage. Supports yard revenue management, free time policy governance, and storage capacity monetisation strategy."
  source: "`shipping_ports_ecm`.`tariff`.`storage_tariff`"
  dimensions:
    - name: "tariff_status"
      expr: tariff_status
      comment: "Lifecycle status of the storage tariff — filters active vs. historical tariffs for operational analysis."
    - name: "customer_tier"
      expr: customer_tier
      comment: "Customer tier the storage tariff applies to — enables tier-differentiated storage revenue analysis."
    - name: "container_status"
      expr: container_status
      comment: "Status of containers the tariff applies to (e.g. Full, Empty, Reefer) — supports container-type-level storage revenue analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency for storage charges — supports multi-currency storage revenue management."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of storage billing (e.g. Daily, Weekly) — impacts revenue recognition and cash flow timing."
    - name: "demurrage_linkage_flag"
      expr: demurrage_linkage_flag
      comment: "Indicates whether storage charges convert to demurrage after free storage period — a key policy flag affecting revenue escalation behaviour."
    - name: "tax_applicable_flag"
      expr: tax_applicable_flag
      comment: "Indicates whether tax applies to storage charges — critical for gross vs. net revenue analysis."
    - name: "weekend_charge_flag"
      expr: weekend_charge_flag
      comment: "Indicates whether storage charges apply on weekends — impacts effective revenue yield and customer perception."
    - name: "effective_from_date"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the storage tariff became effective — enables rate trend analysis over time."
  measures:
    - name: "active_storage_tariff_count"
      expr: COUNT(CASE WHEN tariff_status = 'Active' THEN storage_tariff_id END)
      comment: "Number of active storage tariffs. Tracks the live storage rate portfolio — coverage gaps by container type or terminal zone signal yard revenue risk."
    - name: "avg_rate_band_1_daily_rate"
      expr: AVG(CAST(rate_band_1_daily_rate AS DOUBLE))
      comment: "Average Band 1 daily storage rate (initial free-time-expired period). The entry-level storage rate most frequently applied — benchmarking against market norms directly impacts yard utilisation incentives."
    - name: "avg_rate_band_2_daily_rate"
      expr: AVG(CAST(rate_band_2_daily_rate AS DOUBLE))
      comment: "Average Band 2 daily storage rate (escalated period). Tracks the escalation premium — the step-up from Band 1 to Band 2 is a key lever for incentivising timely cargo collection."
    - name: "avg_rate_band_3_daily_rate"
      expr: AVG(CAST(rate_band_3_daily_rate AS DOUBLE))
      comment: "Average Band 3 daily storage rate (maximum escalation). The highest storage tier — tracks the port's maximum yard occupancy penalty and its deterrent effectiveness."
    - name: "avg_maximum_charge_amount"
      expr: AVG(CAST(maximum_charge_amount AS DOUBLE))
      comment: "Average maximum storage charge cap. Quantifies the revenue ceiling per container — low caps limit storage revenue upside and may reduce cargo collection urgency."
    - name: "avg_minimum_charge_amount"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum storage charge floor. Ensures the port recovers minimum yard occupancy costs regardless of dwell duration — a key revenue protection metric."
    - name: "demurrage_linked_tariff_count"
      expr: COUNT(CASE WHEN demurrage_linkage_flag = TRUE THEN storage_tariff_id END)
      comment: "Number of storage tariffs linked to demurrage conversion. Tracks the proportion of storage arrangements that escalate to demurrage — a key indicator of revenue escalation policy coverage."
    - name: "band_1_to_band_2_rate_escalation_avg"
      expr: AVG(CAST(rate_band_2_daily_rate AS DOUBLE) - CAST(rate_band_1_daily_rate AS DOUBLE))
      comment: "Average daily rate escalation from Band 1 to Band 2 storage. Measures the financial incentive step-up for cargo collection — a key lever in yard capacity management strategy."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_surcharge_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Surcharge rule KPIs covering rate levels, applicability, compounding, and regulatory coverage. Supports surcharge revenue management, regulatory compliance, and commercial risk assessment."
  source: "`shipping_ports_ecm`.`tariff`.`surcharge_rule`"
  dimensions:
    - name: "surcharge_type"
      expr: surcharge_type
      comment: "Type of surcharge (e.g. BAF, CAF, Security, Environmental) — primary segmentation for surcharge revenue analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the surcharge rule — tracks governance pipeline and identifies unapproved surcharges in use."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency for the surcharge — supports multi-currency surcharge revenue management."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate the surcharge (e.g. Flat Rate, Percentage, Index-Linked) — impacts revenue predictability and customer transparency."
    - name: "service_type_applicability"
      expr: service_type_applicability
      comment: "Service types to which the surcharge applies — enables service-line-level surcharge revenue analysis."
    - name: "trade_lane_scope"
      expr: trade_lane_scope
      comment: "Trade lane scope of the surcharge rule — supports trade-lane-level surcharge revenue analysis."
    - name: "compounding_allowed"
      expr: compounding_allowed
      comment: "Indicates whether the surcharge can compound with other surcharges — a key flag for total charge calculation accuracy and customer dispute prevention."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of surcharge billing — impacts revenue recognition and cash flow timing."
    - name: "effective_from_date"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the surcharge rule became effective — enables surcharge trend analysis over time."
  measures:
    - name: "active_surcharge_rule_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN surcharge_rule_id END)
      comment: "Number of approved and active surcharge rules. Tracks the live surcharge portfolio — a key indicator of additional revenue layer coverage across port services."
    - name: "avg_rate_amount"
      expr: AVG(CAST(rate_amount AS DOUBLE))
      comment: "Average flat rate amount across surcharge rules. Benchmarks the absolute surcharge level — a key input to total charge competitiveness analysis."
    - name: "avg_rate_percentage"
      expr: AVG(CAST(rate_percentage AS DOUBLE))
      comment: "Average percentage-based surcharge rate. Tracks the proportional surcharge burden on base charges — high averages may signal customer dissatisfaction and volume risk."
    - name: "avg_maximum_charge"
      expr: AVG(CAST(maximum_charge AS DOUBLE))
      comment: "Average maximum surcharge cap. Quantifies the revenue ceiling per surcharge application — low caps limit surcharge revenue upside."
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge AS DOUBLE))
      comment: "Average minimum surcharge floor. Ensures the port recovers minimum surcharge revenue regardless of base charge size — a key revenue protection metric."
    - name: "compounding_surcharge_count"
      expr: COUNT(CASE WHEN compounding_allowed = TRUE THEN surcharge_rule_id END)
      comment: "Number of surcharge rules that allow compounding. Tracks the complexity and potential revenue amplification of the surcharge portfolio — high counts increase total charge volatility and dispute risk."
    - name: "expiring_surcharge_count_90d"
      expr: COUNT(CASE WHEN effective_to_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN surcharge_rule_id END)
      comment: "Number of surcharge rules expiring within 90 days. A leading indicator of surcharge renewal urgency — lapsed surcharges result in immediate revenue loss."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_pilotage_tariff`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pilotage tariff KPIs covering base fees, surcharges, vessel size bands, and tariff coverage. Supports pilotage revenue management, regulatory compliance, and vessel service pricing strategy."
  source: "`shipping_ports_ecm`.`tariff`.`pilotage_tariff`"
  dimensions:
    - name: "pilotage_tariff_status"
      expr: pilotage_tariff_status
      comment: "Lifecycle status of the pilotage tariff — filters active vs. historical tariffs for operational analysis."
    - name: "pilotage_type"
      expr: pilotage_type
      comment: "Type of pilotage service (e.g. Inbound, Outbound, Shifting) — primary segmentation for pilotage revenue analysis."
    - name: "service_category"
      expr: service_category
      comment: "Service category of the pilotage tariff — enables service-line-level revenue analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency for pilotage charges — supports multi-currency revenue management."
    - name: "time_of_day_category"
      expr: time_of_day_category
      comment: "Time-of-day category (e.g. Day, Night, Weekend) — enables time-differentiated pilotage rate analysis and premium pricing assessment."
    - name: "discount_eligible_flag"
      expr: discount_eligible_flag
      comment: "Indicates whether the pilotage tariff is eligible for discounting — segments negotiable vs. fixed pilotage rates."
    - name: "tax_applicable_flag"
      expr: tax_applicable_flag
      comment: "Indicates whether tax applies to pilotage charges — critical for gross vs. net revenue analysis."
    - name: "distance_based_flag"
      expr: distance_based_flag
      comment: "Indicates whether pilotage is charged on a distance basis — distinguishes flat-fee from variable distance-based pricing models."
    - name: "effective_from_date"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the pilotage tariff became effective — enables rate trend analysis over time."
  measures:
    - name: "active_pilotage_tariff_count"
      expr: COUNT(CASE WHEN pilotage_tariff_status = 'Active' THEN pilotage_tariff_id END)
      comment: "Number of active pilotage tariffs. Tracks the live pilotage rate portfolio — coverage gaps by vessel type or pilotage type signal revenue risk."
    - name: "avg_base_pilotage_fee"
      expr: AVG(CAST(base_pilotage_fee AS DOUBLE))
      comment: "Average base pilotage fee across tariffs. The primary pilotage rate benchmarking metric — deviations from market norms impact vessel call competitiveness and pilotage revenue yield."
    - name: "avg_dangerous_goods_surcharge"
      expr: AVG(CAST(dangerous_goods_surcharge AS DOUBLE))
      comment: "Average dangerous goods surcharge on pilotage. Quantifies the DG cargo premium for pilotage services — a key input to DG vessel pricing strategy and risk-adjusted revenue."
    - name: "avg_waiting_time_surcharge_per_hour"
      expr: AVG(CAST(waiting_time_surcharge_per_hour AS DOUBLE))
      comment: "Average waiting time surcharge per hour for pilotage. Tracks the financial deterrent for vessel delays — a key metric for port efficiency incentive design and pilot resource cost recovery."
    - name: "avg_extraordinary_conditions_surcharge"
      expr: AVG(CAST(extraordinary_conditions_surcharge AS DOUBLE))
      comment: "Average extraordinary conditions surcharge (e.g. adverse weather, emergency). Quantifies the risk premium for non-standard pilotage conditions — informs risk-based pricing and pilot safety policy."
    - name: "avg_cancellation_fee"
      expr: AVG(CAST(cancellation_fee AS DOUBLE))
      comment: "Average pilotage cancellation fee. Tracks the financial deterrent for last-minute cancellations — a key metric for pilot resource utilisation and revenue protection."
    - name: "avg_rate_per_nautical_mile"
      expr: AVG(CAST(rate_per_nautical_mile AS DOUBLE))
      comment: "Average distance-based pilotage rate per nautical mile. Benchmarks distance-based pricing — relevant for ports with long approach channels where distance-based pricing is commercially significant."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_port_dues_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port dues schedule KPIs covering base rates, levies, discounts, and regulatory coverage. Supports port dues revenue management, environmental levy tracking, and vessel call frequency incentive analysis."
  source: "`shipping_ports_ecm`.`tariff`.`port_dues_schedule`"
  dimensions:
    - name: "port_dues_schedule_status"
      expr: port_dues_schedule_status
      comment: "Lifecycle status of the port dues schedule — filters active vs. historical schedules for operational analysis."
    - name: "dues_type"
      expr: dues_type
      comment: "Type of port dues (e.g. Light Dues, Port Dues, Conservancy Dues) — primary segmentation for port dues revenue analysis."
    - name: "trade_type"
      expr: trade_type
      comment: "Trade type the dues schedule applies to (e.g. Import, Export, Coastal) — enables directional dues revenue analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency for port dues — supports multi-currency revenue management."
    - name: "call_frequency_tier"
      expr: call_frequency_tier
      comment: "Vessel call frequency tier for discount eligibility — tracks the volume incentive structure for regular callers."
    - name: "exemption_flag"
      expr: exemption_flag
      comment: "Indicates whether the schedule includes exemption provisions — tracks the proportion of dues revenue at risk from exemptions."
    - name: "rate_unit_of_measure"
      expr: rate_unit_of_measure
      comment: "Unit basis for port dues (e.g. per GRT, per NRT, per call) — ensures like-for-like rate comparisons."
    - name: "effective_from_date"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the port dues schedule became effective — enables rate trend analysis over time."
  measures:
    - name: "active_dues_schedule_count"
      expr: COUNT(CASE WHEN port_dues_schedule_status = 'Active' THEN port_dues_schedule_id END)
      comment: "Number of active port dues schedules. Tracks the live dues rate portfolio — coverage gaps by vessel type or trade type signal revenue risk."
    - name: "avg_base_rate_amount"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base port dues rate. The primary dues rate benchmarking metric — a key input to vessel call cost competitiveness analysis and port authority revenue planning."
    - name: "avg_environmental_levy_percentage"
      expr: AVG(CAST(environmental_levy_percentage AS DOUBLE))
      comment: "Average environmental levy percentage across dues schedules. Tracks the green surcharge burden on vessel operators — a key metric for environmental policy effectiveness and ESG reporting."
    - name: "avg_security_levy_percentage"
      expr: AVG(CAST(security_levy_percentage AS DOUBLE))
      comment: "Average security levy percentage across dues schedules. Tracks the ISPS/security cost recovery rate — ensures port security costs are adequately recovered through dues."
    - name: "avg_dangerous_goods_surcharge_percentage"
      expr: AVG(CAST(dangerous_goods_surcharge_percentage AS DOUBLE))
      comment: "Average dangerous goods surcharge percentage on port dues. Quantifies the DG vessel premium — a key input to DG cargo risk-adjusted pricing strategy."
    - name: "avg_call_frequency_discount_percentage"
      expr: AVG(CAST(call_frequency_discount_percentage AS DOUBLE))
      comment: "Average call frequency discount percentage. Measures the volume incentive offered to regular callers — a key lever for vessel call attraction and market share growth."
    - name: "avg_late_payment_penalty_percentage"
      expr: AVG(CAST(late_payment_penalty_percentage AS DOUBLE))
      comment: "Average late payment penalty percentage. Tracks the financial deterrent for late dues payment — a key metric for port authority cash flow protection and credit risk management."
    - name: "avg_maximum_charge_amount"
      expr: AVG(CAST(maximum_charge_amount AS DOUBLE))
      comment: "Average maximum port dues charge cap. Quantifies the revenue ceiling per vessel call — low caps limit dues revenue upside for large vessels and may undervalue port infrastructure usage."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_discount_scheme`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discount scheme KPIs covering discount values, thresholds, eligibility, and portfolio governance. Supports commercial discount management, revenue leakage analysis, and customer incentive programme effectiveness."
  source: "`shipping_ports_ecm`.`tariff`.`discount_scheme`"
  dimensions:
    - name: "scheme_status"
      expr: scheme_status
      comment: "Lifecycle status of the discount scheme — filters active vs. historical schemes for operational analysis."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount (e.g. Volume, Loyalty, Promotional, SLA-Linked) — primary segmentation for discount revenue impact analysis."
    - name: "discount_category"
      expr: discount_category
      comment: "Category of discount (e.g. Commercial, Regulatory, Operational) — enables category-level discount portfolio governance."
    - name: "customer_tier_eligibility"
      expr: customer_tier_eligibility
      comment: "Customer tier eligible for the discount — enables tier-differentiated discount impact analysis."
    - name: "discount_currency_code"
      expr: discount_currency_code
      comment: "Currency in which the discount is denominated — supports multi-currency discount portfolio management."
    - name: "auto_apply_flag"
      expr: auto_apply_flag
      comment: "Indicates whether the discount is automatically applied — distinguishes automated from manually-triggered discounts, impacting revenue leakage risk."
    - name: "sla_linked_flag"
      expr: sla_linked_flag
      comment: "Indicates whether the discount is linked to SLA performance — tracks performance-contingent discount exposure."
    - name: "combinable_with_other_discounts"
      expr: combinable_with_other_discounts
      comment: "Indicates whether the discount can be combined with other schemes — a key flag for total discount stack analysis and revenue leakage risk."
    - name: "effective_from_date"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the discount scheme became effective — enables discount trend analysis over time."
  measures:
    - name: "active_discount_scheme_count"
      expr: COUNT(CASE WHEN scheme_status = 'Active' THEN discount_scheme_id END)
      comment: "Number of active discount schemes. Tracks the live discount portfolio — a high count signals potential revenue leakage complexity and governance risk."
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value across schemes. The primary discount depth metric — rising averages signal deteriorating commercial discipline and increasing revenue leakage."
    - name: "avg_maximum_discount_cap"
      expr: AVG(CAST(maximum_discount_cap AS DOUBLE))
      comment: "Average maximum discount cap across schemes. Quantifies the maximum revenue concession per scheme — low caps provide revenue floor protection; high caps signal uncapped leakage risk."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average threshold value required to trigger the discount. Tracks the volume/value hurdle for discount eligibility — low thresholds indicate easy-to-achieve discounts with high revenue leakage risk."
    - name: "avg_minimum_charge_threshold"
      expr: AVG(CAST(minimum_charge_threshold AS DOUBLE))
      comment: "Average minimum charge threshold below which discounts do not apply. Tracks the revenue floor protection level — ensures discounts do not erode charges below cost recovery levels."
    - name: "auto_apply_scheme_count"
      expr: COUNT(CASE WHEN auto_apply_flag = TRUE THEN discount_scheme_id END)
      comment: "Number of discount schemes that auto-apply. Tracks automated revenue concessions — high counts amplify revenue leakage risk as discounts apply without manual approval."
    - name: "sla_linked_scheme_count"
      expr: COUNT(CASE WHEN sla_linked_flag = TRUE THEN discount_scheme_id END)
      comment: "Number of discount schemes linked to SLA performance. Quantifies performance-contingent discount exposure — a key metric for understanding the financial risk of SLA underperformance."
    - name: "combinable_scheme_count"
      expr: COUNT(CASE WHEN combinable_with_other_discounts = TRUE THEN discount_scheme_id END)
      comment: "Number of discount schemes that can be combined with others. Tracks the stacking risk in the discount portfolio — combinable schemes amplify total discount depth and revenue leakage."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_pricing_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing rule KPIs covering rule coverage, discount and surcharge levels, trigger conditions, and governance. Supports dynamic pricing governance, revenue optimisation, and commercial rule portfolio management."
  source: "`shipping_ports_ecm`.`tariff`.`pricing_rule`"
  dimensions:
    - name: "rule_status"
      expr: rule_status
      comment: "Lifecycle status of the pricing rule — filters active vs. historical rules for operational analysis."
    - name: "rule_type"
      expr: rule_type
      comment: "Type of pricing rule (e.g. Discount, Surcharge, Override, Escalation) — primary segmentation for pricing rule portfolio analysis."
    - name: "trigger_trade_direction"
      expr: trigger_trade_direction
      comment: "Trade direction that triggers the rule (Import/Export) — enables directional pricing rule analysis."
    - name: "trigger_trade_lane"
      expr: trigger_trade_lane
      comment: "Trade lane that triggers the rule — supports trade-lane-level pricing rule coverage analysis."
    - name: "trigger_customer_segment"
      expr: trigger_customer_segment
      comment: "Customer segment that triggers the rule — enables segment-level pricing rule impact analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the pricing rule is denominated — supports multi-currency rule portfolio management."
    - name: "auto_apply_flag"
      expr: auto_apply_flag
      comment: "Indicates whether the pricing rule is automatically applied — distinguishes automated from manually-triggered rules, impacting revenue predictability."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Indicates whether the pricing rule requires approval before application — tracks governance compliance in the pricing rule portfolio."
    - name: "effective_from_date"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the pricing rule became effective — enables rule trend analysis over time."
  measures:
    - name: "active_pricing_rule_count"
      expr: COUNT(CASE WHEN rule_status = 'Active' THEN pricing_rule_id END)
      comment: "Number of active pricing rules. Tracks the live dynamic pricing rule portfolio — a key indicator of pricing complexity and governance workload."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied by pricing rules. Measures the average commercial concession depth — rising averages signal deteriorating pricing discipline and revenue leakage."
    - name: "avg_surcharge_percentage"
      expr: AVG(CAST(surcharge_percentage AS DOUBLE))
      comment: "Average surcharge percentage applied by pricing rules. Tracks the average revenue uplift from surcharge rules — a key metric for additional revenue layer effectiveness."
    - name: "avg_maximum_charge_amount"
      expr: AVG(CAST(maximum_charge_amount AS DOUBLE))
      comment: "Average maximum charge cap across pricing rules. Quantifies the revenue ceiling enforced by pricing rules — low caps limit revenue upside from high-value transactions."
    - name: "avg_minimum_charge_amount"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum charge floor across pricing rules. Tracks the revenue floor protection level — ensures pricing rules do not erode charges below cost recovery levels."
    - name: "auto_apply_rule_count"
      expr: COUNT(CASE WHEN auto_apply_flag = TRUE THEN pricing_rule_id END)
      comment: "Number of pricing rules that auto-apply. Tracks automated pricing decisions — high counts amplify revenue impact of rule errors and require robust governance controls."
    - name: "approval_required_rule_count"
      expr: COUNT(CASE WHEN approval_required_flag = TRUE THEN pricing_rule_id END)
      comment: "Number of pricing rules requiring approval. Quantifies the governance workload in the pricing rule portfolio — a key metric for commercial approval process capacity planning."
    - name: "avg_trigger_volume_max_teu"
      expr: AVG(CAST(trigger_volume_max_teu AS DOUBLE))
      comment: "Average maximum TEU volume trigger threshold across pricing rules. Tracks the volume ceiling at which pricing rules activate — informs volume incentive structure design and commercial strategy."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_wharfage_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wharfage schedule KPIs covering rates, surcharges, discounts, and cargo-type coverage. Supports wharfage revenue management, cargo-type pricing strategy, and tariff competitiveness benchmarking."
  source: "`shipping_ports_ecm`.`tariff`.`wharfage_schedule`"
  dimensions:
    - name: "tariff_status"
      expr: tariff_status
      comment: "Lifecycle status of the wharfage schedule — filters active vs. historical schedules for operational analysis."
    - name: "trade_direction"
      expr: trade_direction
      comment: "Trade direction (Import/Export/Coastal) the wharfage schedule applies to — primary segmentation for directional wharfage revenue analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency for wharfage charges — supports multi-currency revenue management."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit basis for wharfage rates (e.g. per tonne, per unit, per TEU) — ensures like-for-like rate comparisons."
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Indicates whether the schedule applies to dangerous goods cargo — enables DG-specific wharfage rate analysis."
    - name: "refrigerated_cargo_flag"
      expr: refrigerated_cargo_flag
      comment: "Indicates whether the schedule applies to refrigerated cargo — enables reefer-specific wharfage rate analysis."
    - name: "oversized_cargo_flag"
      expr: oversized_cargo_flag
      comment: "Indicates whether the schedule applies to oversized cargo — enables special cargo wharfage rate analysis."
    - name: "exemption_flag"
      expr: exemption_flag
      comment: "Indicates whether the schedule includes exemption provisions — tracks the proportion of wharfage revenue at risk from exemptions."
    - name: "effective_from_date"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the wharfage schedule became effective — enables rate trend analysis over time."
  measures:
    - name: "active_wharfage_schedule_count"
      expr: COUNT(CASE WHEN tariff_status = 'Active' THEN wharfage_schedule_id END)
      comment: "Number of active wharfage schedules. Tracks the live wharfage rate portfolio — coverage gaps by cargo type or trade direction signal revenue risk."
    - name: "avg_rate_per_unit"
      expr: AVG(CAST(rate_per_unit AS DOUBLE))
      comment: "Average wharfage rate per unit across schedules. The primary wharfage rate benchmarking metric — deviations from market norms directly impact cargo handling competitiveness and revenue yield."
    - name: "avg_surcharge_percentage"
      expr: AVG(CAST(surcharge_percentage AS DOUBLE))
      comment: "Average surcharge percentage applied on top of wharfage rates. Tracks the additional revenue uplift from wharfage surcharges — a key metric for total wharfage charge competitiveness."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied to wharfage rates. Measures commercial concession depth — rising averages signal deteriorating wharfage pricing discipline."
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge AS DOUBLE))
      comment: "Average minimum wharfage charge floor. Ensures the port recovers minimum wharfage costs regardless of cargo volume — a key revenue protection metric."
    - name: "dangerous_goods_schedule_count"
      expr: COUNT(CASE WHEN dangerous_goods_flag = TRUE THEN wharfage_schedule_id END)
      comment: "Number of wharfage schedules covering dangerous goods cargo. Tracks DG cargo rate coverage — gaps signal potential revenue leakage or unpriced risk for DG handling."
    - name: "avg_volume_break_upper_limit"
      expr: AVG(CAST(volume_break_upper_limit AS DOUBLE))
      comment: "Average upper volume break limit across wharfage schedules. Tracks the volume ceiling at which the highest wharfage rate tier applies — informs volume incentive structure design."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_mooring_tariff`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mooring tariff KPIs covering base fees, waiting time surcharges, cancellation fees, and vessel size band coverage. Supports mooring revenue management, berth utilisation incentive design, and tariff competitiveness benchmarking."
  source: "`shipping_ports_ecm`.`tariff`.`mooring_tariff`"
  dimensions:
    - name: "tariff_status"
      expr: tariff_status
      comment: "Lifecycle status of the mooring tariff — filters active vs. historical tariffs for operational analysis."
    - name: "mooring_type"
      expr: mooring_type
      comment: "Type of mooring service (e.g. Conventional, Buoy, Alongside) — primary segmentation for mooring revenue analysis."
    - name: "service_type"
      expr: service_type
      comment: "Service type associated with the mooring tariff — enables service-line-level revenue analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency for mooring charges — supports multi-currency revenue management."
    - name: "time_of_day_category"
      expr: time_of_day_category
      comment: "Time-of-day category (e.g. Day, Night, Weekend) — enables time-differentiated mooring rate analysis and premium pricing assessment."
    - name: "customer_tier"
      expr: customer_tier
      comment: "Customer tier the mooring tariff applies to — enables tier-differentiated mooring revenue analysis."
    - name: "discount_eligible_flag"
      expr: discount_eligible_flag
      comment: "Indicates whether the mooring tariff is eligible for discounting — segments negotiable vs. fixed mooring rates."
    - name: "public_tariff_flag"
      expr: public_tariff_flag
      comment: "Indicates whether the mooring tariff is publicly published — distinguishes public schedule rates from confidential contract rates."
    - name: "effective_from_date"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the mooring tariff became effective — enables rate trend analysis over time."
  measures:
    - name: "active_mooring_tariff_count"
      expr: COUNT(CASE WHEN tariff_status = 'Active' THEN mooring_tariff_id END)
      comment: "Number of active mooring tariffs. Tracks the live mooring rate portfolio — coverage gaps by vessel size band or mooring type signal revenue risk."
    - name: "avg_base_mooring_fee"
      expr: AVG(CAST(base_mooring_fee AS DOUBLE))
      comment: "Average base mooring fee across tariffs. The primary mooring rate benchmarking metric — a key input to vessel call cost competitiveness analysis and mooring revenue planning."
    - name: "avg_waiting_time_surcharge_per_hour"
      expr: AVG(CAST(waiting_time_surcharge_per_hour AS DOUBLE))
      comment: "Average waiting time surcharge per hour for mooring. Tracks the financial deterrent for vessel delays at berth — a key metric for berth utilisation incentive design and gang cost recovery."
    - name: "avg_cancellation_fee"
      expr: AVG(CAST(cancellation_fee AS DOUBLE))
      comment: "Average mooring cancellation fee. Tracks the financial deterrent for last-minute cancellations — a key metric for mooring gang resource utilisation and revenue protection."
    - name: "avg_maximum_charge_cap"
      expr: AVG(CAST(maximum_charge_cap AS DOUBLE))
      comment: "Average maximum mooring charge cap. Quantifies the revenue ceiling per mooring operation — low caps limit mooring revenue upside for large vessels."
    - name: "avg_minimum_charge_amount"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum mooring charge floor. Ensures the port recovers minimum mooring costs regardless of vessel size — a key revenue protection metric."
    - name: "avg_grt_band_max"
      expr: AVG(CAST(grt_band_max AS DOUBLE))
      comment: "Average upper GRT band limit across mooring tariffs. Indicates the vessel size ceiling the mooring tariff portfolio is designed to serve — informs fleet mix strategy and berth capacity planning."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_towage_tariff`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Towage tariff KPIs covering base fees, standby rates, extraordinary surcharges, and vessel size band coverage. Supports towage revenue management, tug fleet utilisation, and tariff competitiveness benchmarking."
  source: "`shipping_ports_ecm`.`tariff`.`towage_tariff`"
  dimensions:
    - name: "tariff_status"
      expr: tariff_status
      comment: "Lifecycle status of the towage tariff — filters active vs. historical tariffs for operational analysis."
    - name: "operation_type"
      expr: operation_type
      comment: "Type of towage operation (e.g. Berthing, Unberthing, Shifting, Emergency) — primary segmentation for towage revenue analysis."
    - name: "time_of_day_category"
      expr: time_of_day_category
      comment: "Time-of-day category (e.g. Day, Night, Weekend) — enables time-differentiated towage rate analysis and premium pricing assessment."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency for towage charges — supports multi-currency revenue management."
    - name: "discount_eligible_flag"
      expr: discount_eligible_flag
      comment: "Indicates whether the towage tariff is eligible for discounting — segments negotiable vs. fixed towage rates."
    - name: "sla_linked_flag"
      expr: sla_linked_flag
      comment: "Indicates whether the towage tariff is linked to SLA performance — tracks performance-contingent towage pricing."
    - name: "effective_from_date"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the towage tariff became effective — enables rate trend analysis over time."
  measures:
    - name: "active_towage_tariff_count"
      expr: COUNT(CASE WHEN tariff_status = 'Active' THEN towage_tariff_id END)
      comment: "Number of active towage tariffs. Tracks the live towage rate portfolio — coverage gaps by vessel size band or operation type signal revenue risk."
    - name: "avg_base_towage_fee_amount"
      expr: AVG(CAST(base_towage_fee_amount AS DOUBLE))
      comment: "Average base towage fee across tariffs. The primary towage rate benchmarking metric — a key input to vessel call cost competitiveness analysis and tug fleet revenue planning."
    - name: "avg_standby_time_rate_per_hour"
      expr: AVG(CAST(standby_time_rate_per_hour AS DOUBLE))
      comment: "Average standby time rate per hour for towage. Tracks the financial deterrent for tug standby delays — a key metric for tug fleet utilisation and standby cost recovery."
    - name: "avg_extraordinary_conditions_surcharge_pct"
      expr: AVG(CAST(extraordinary_conditions_surcharge_pct AS DOUBLE))
      comment: "Average extraordinary conditions surcharge percentage (e.g. adverse weather, emergency). Quantifies the risk premium for non-standard towage conditions — informs risk-based pricing and tug safety policy."
    - name: "avg_cancellation_fee_amount"
      expr: AVG(CAST(cancellation_fee_amount AS DOUBLE))
      comment: "Average towage cancellation fee. Tracks the financial deterrent for last-minute cancellations — a key metric for tug resource utilisation and revenue protection."
    - name: "avg_maximum_charge_amount"
      expr: AVG(CAST(maximum_charge_amount AS DOUBLE))
      comment: "Average maximum towage charge cap. Quantifies the revenue ceiling per towage operation — low caps limit towage revenue upside for large vessels requiring multiple tugs."
    - name: "avg_tug_bollard_pull_min_tonnes"
      expr: AVG(CAST(tug_bollard_pull_min_tonnes AS DOUBLE))
      comment: "Average minimum tug bollard pull requirement (tonnes) across towage tariffs. Tracks the tug capability standard embedded in commercial tariffs — informs tug fleet investment decisions and capability gap analysis."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_free_time_allowance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Free time allowance KPIs covering volume thresholds, auto-apply coverage, and allowance portfolio governance. Supports free time policy management, container dwell time incentive design, and revenue impact assessment of free time concessions."
  source: "`shipping_ports_ecm`.`tariff`.`free_time_allowance`"
  dimensions:
    - name: "free_time_allowance_status"
      expr: free_time_allowance_status
      comment: "Lifecycle status of the free time allowance — filters active vs. historical allowances for operational analysis."
    - name: "free_time_type"
      expr: free_time_type
      comment: "Type of free time (e.g. Demurrage Free Time, Detention Free Time, Storage Free Time) — primary segmentation for free time policy analysis."
    - name: "applicable_charge_type"
      expr: applicable_charge_type
      comment: "Charge type to which the free time allowance applies — enables charge-type-level free time impact analysis."
    - name: "customer_tier"
      expr: customer_tier
      comment: "Customer tier the free time allowance applies to — enables tier-differentiated free time policy analysis."
    - name: "trade_lane"
      expr: trade_lane
      comment: "Trade lane scope of the free time allowance — supports trade-lane-level free time policy benchmarking."
    - name: "auto_apply_flag"
      expr: auto_apply_flag
      comment: "Indicates whether the free time allowance is automatically applied — distinguishes automated from manually-triggered allowances, impacting revenue leakage risk."
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Indicates whether the allowance applies to dangerous goods cargo — enables DG-specific free time policy analysis."
    - name: "reefer_cargo_flag"
      expr: reefer_cargo_flag
      comment: "Indicates whether the allowance applies to reefer cargo — enables cold chain-specific free time policy analysis."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the free time allowance became effective — enables policy trend analysis over time."
  measures:
    - name: "active_allowance_count"
      expr: COUNT(CASE WHEN free_time_allowance_status = 'Active' THEN free_time_allowance_id END)
      comment: "Number of active free time allowances. Tracks the live free time policy portfolio — a high count signals significant revenue deferral exposure from free time concessions."
    - name: "avg_maximum_volume_teu"
      expr: AVG(CAST(maximum_volume_teu AS DOUBLE))
      comment: "Average maximum volume (TEU) eligible for free time allowances. Tracks the scale of free time concessions — high averages indicate significant revenue deferral exposure for large-volume customers."
    - name: "avg_minimum_volume_teu"
      expr: AVG(CAST(minimum_volume_teu AS DOUBLE))
      comment: "Average minimum volume (TEU) required to qualify for free time allowances. Tracks the volume hurdle for free time eligibility — low thresholds indicate easy-to-achieve concessions with high revenue impact."
    - name: "auto_apply_allowance_count"
      expr: COUNT(CASE WHEN auto_apply_flag = TRUE THEN free_time_allowance_id END)
      comment: "Number of free time allowances that auto-apply. Tracks automated revenue concessions — high counts amplify revenue leakage risk as free time is granted without manual approval."
    - name: "dangerous_goods_allowance_count"
      expr: COUNT(CASE WHEN dangerous_goods_flag = TRUE THEN free_time_allowance_id END)
      comment: "Number of free time allowances covering dangerous goods cargo. Tracks DG-specific free time policy coverage — DG free time concessions carry additional risk and cost implications."
    - name: "reefer_cargo_allowance_count"
      expr: COUNT(CASE WHEN reefer_cargo_flag = TRUE THEN free_time_allowance_id END)
      comment: "Number of free time allowances covering reefer cargo. Tracks cold chain-specific free time policy coverage — reefer free time concessions impact high-value cargo revenue and cold storage capacity utilisation."
$$;