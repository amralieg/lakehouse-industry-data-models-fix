-- Metric views for domain: store | Business: Retail | Version: 2 | Generated on: 2026-06-23 23:42:36

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_pl`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store profit and loss performance metrics. Tracks revenue, margin, cost efficiency, and profitability at the store-period level. Core financial steering KPI for store operations leadership."
  source: "`vibe_retail_v1`.`store`.`pl`"
  dimensions:
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the reporting period, used for time-bucketing P&L results."
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the reporting period."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which P&L figures are reported."
    - name: "comp_sales_flag"
      expr: comp_sales_flag
      comment: "Indicates whether the store qualifies as a comparable store for this period."
    - name: "pl_status"
      expr: pl_status
      comment: "Status of the P&L record (e.g. draft, finalized) for filtering to approved financials."
    - name: "reporting_entity"
      expr: reporting_entity
      comment: "Legal or organizational entity the P&L is reported under."
  measures:
    - name: "total_net_sales"
      expr: SUM(CAST(net_sales_amount AS DOUBLE))
      comment: "Total net sales revenue across stores and periods. Primary top-line revenue KPI."
    - name: "total_gross_sales"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales before returns and discounts. Used to measure top-line volume."
    - name: "total_gross_margin"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Total gross margin dollars. Key profitability measure for store operations."
    - name: "avg_gross_margin_percent"
      expr: AVG(CAST(gross_margin_percent AS DOUBLE))
      comment: "Average gross margin percentage across stores. Indicates pricing and cost efficiency."
    - name: "total_cogs"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold. Used to assess merchandise cost efficiency."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost. Key controllable expense for store managers."
    - name: "total_occupancy_cost"
      expr: SUM(CAST(occupancy_cost_amount AS DOUBLE))
      comment: "Total occupancy cost (rent, utilities). Fixed cost burden on store profitability."
    - name: "total_ebitda"
      expr: SUM(CAST(ebitda_amount AS DOUBLE))
      comment: "Total EBITDA across stores. Operational profitability before financing and depreciation."
    - name: "avg_ebitda_percent"
      expr: AVG(CAST(ebitda_percent AS DOUBLE))
      comment: "Average EBITDA margin percentage. Executive-level profitability efficiency metric."
    - name: "total_shrinkage"
      expr: SUM(CAST(shrinkage_amount AS DOUBLE))
      comment: "Total shrinkage loss. Directly impacts gross margin and is a key loss-prevention KPI."
    - name: "total_discounts"
      expr: SUM(CAST(discounts_amount AS DOUBLE))
      comment: "Total discount dollars applied. Measures promotional spend impact on net revenue."
    - name: "total_returns"
      expr: SUM(CAST(returns_amount AS DOUBLE))
      comment: "Total returns value. High returns signal product quality or customer satisfaction issues."
    - name: "avg_transaction_value"
      expr: AVG(CAST(atv_amount AS DOUBLE))
      comment: "Average transaction value (ATV). Key basket-size KPI for store productivity."
    - name: "total_units_sold"
      expr: SUM(CAST(units_sold AS DOUBLE))
      comment: "Total units sold. Volume metric used alongside revenue to assess mix and pricing."
    - name: "total_transactions"
      expr: SUM(CAST(transaction_count AS DOUBLE))
      comment: "Total transaction count. Measures store traffic conversion into purchases."
    - name: "avg_upt"
      expr: AVG(CAST(upt AS DOUBLE))
      comment: "Average units per transaction (UPT). Measures basket depth and cross-sell effectiveness."
    - name: "avg_comp_sales_growth_percent"
      expr: AVG(CAST(comp_sales_growth_percent AS DOUBLE))
      comment: "Average comparable-store sales growth percentage. Core retail performance benchmark."
    - name: "total_marketing_expense"
      expr: SUM(CAST(marketing_expense_amount AS DOUBLE))
      comment: "Total marketing expense allocated to stores. Used to assess marketing ROI at store level."
    - name: "total_operating_expense"
      expr: SUM(CAST(total_operating_expense_amount AS DOUBLE))
      comment: "Total operating expenses. Used to compute operating leverage and cost control."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_comparable_sales`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Comparable store sales performance metrics. Tracks comp-store growth, traffic conversion, and basket metrics across periods. Core retail benchmarking KPI set used in investor reporting and operational reviews."
  source: "`vibe_retail_v1`.`store`.`comparable_sales`"
  dimensions:
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for comparable sales analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for year-over-year comparable sales trending."
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Type of reporting period (weekly, monthly, quarterly) for aggregation control."
    - name: "reporting_period_start_date"
      expr: reporting_period_start_date
      comment: "Start date of the comparable sales reporting period."
    - name: "reporting_period_end_date"
      expr: reporting_period_end_date
      comment: "End date of the comparable sales reporting period."
    - name: "comp_store_qualification_status"
      expr: comp_store_qualification_status
      comment: "Whether the store qualifies as a comp store for this period."
    - name: "remodel_flag"
      expr: remodel_flag
      comment: "Indicates if the store was under remodel during the period, affecting comp sales comparability."
    - name: "closure_flag"
      expr: closure_flag
      comment: "Indicates if the store had a closure period, used to exclude or adjust comp calculations."
    - name: "reporting_district"
      expr: reporting_district
      comment: "District grouping for regional comparable sales analysis."
    - name: "reporting_region"
      expr: reporting_region
      comment: "Region grouping for geographic comparable sales benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of reported sales figures."
  measures:
    - name: "total_current_period_net_sales"
      expr: SUM(CAST(current_period_net_sales AS DOUBLE))
      comment: "Total current period net sales across qualifying comp stores."
    - name: "total_prior_period_net_sales"
      expr: SUM(CAST(prior_period_net_sales AS DOUBLE))
      comment: "Total prior period net sales for year-over-year comparison."
    - name: "avg_comp_sales_growth_rate"
      expr: AVG(CAST(comp_sales_growth_rate AS DOUBLE))
      comment: "Average comparable store sales growth rate. Primary retail performance KPI reported to investors."
    - name: "avg_comp_sales_variance_percent"
      expr: AVG(CAST(comp_sales_variance_percent AS DOUBLE))
      comment: "Average variance percentage between current and prior period comp sales."
    - name: "total_comp_sales_variance_amount"
      expr: SUM(CAST(comp_sales_variance_amount AS DOUBLE))
      comment: "Total dollar variance in comp sales versus prior period. Quantifies growth in absolute terms."
    - name: "total_current_footfall"
      expr: SUM(CAST(current_period_footfall AS DOUBLE))
      comment: "Total current period store footfall (traffic). Measures customer visit volume."
    - name: "total_prior_footfall"
      expr: SUM(CAST(prior_period_footfall AS DOUBLE))
      comment: "Total prior period footfall for traffic trend comparison."
    - name: "avg_current_conversion_rate"
      expr: AVG(CAST(current_period_conversion_rate AS DOUBLE))
      comment: "Average current period conversion rate (transactions / footfall). Key traffic efficiency KPI."
    - name: "avg_prior_conversion_rate"
      expr: AVG(CAST(prior_period_conversion_rate AS DOUBLE))
      comment: "Average prior period conversion rate for trend comparison."
    - name: "avg_current_atv"
      expr: AVG(CAST(current_period_atv AS DOUBLE))
      comment: "Average current period average transaction value. Basket size KPI."
    - name: "avg_prior_atv"
      expr: AVG(CAST(prior_period_atv AS DOUBLE))
      comment: "Average prior period ATV for basket size trend analysis."
    - name: "avg_current_upt"
      expr: AVG(CAST(current_period_upt AS DOUBLE))
      comment: "Average current period units per transaction. Measures cross-sell and basket depth."
    - name: "total_current_units_sold"
      expr: SUM(CAST(current_period_units_sold AS DOUBLE))
      comment: "Total units sold in current period across comp stores."
    - name: "avg_sales_per_sqft"
      expr: AVG(CAST(sales_per_sqft AS DOUBLE))
      comment: "Average sales per square foot. Space productivity benchmark for store portfolio decisions."
    - name: "qualifying_comp_store_count"
      expr: COUNT(DISTINCT comparable_sales_id)
      comment: "Count of qualifying comparable store-period records. Denominator for portfolio-level averages."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_traffic_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store traffic and conversion metrics. Measures footfall patterns, dwell time, and conversion efficiency. Used by store operations and marketing to optimize staffing, layout, and promotional timing."
  source: "`vibe_retail_v1`.`store`.`traffic_count`"
  dimensions:
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for traffic pattern analysis and staffing optimization."
    - name: "hour_of_day"
      expr: hour_of_day
      comment: "Hour of day for intraday traffic analysis and peak staffing decisions."
    - name: "is_holiday"
      expr: is_holiday
      comment: "Holiday flag for comparing holiday vs. non-holiday traffic patterns."
    - name: "is_promotional_event"
      expr: is_promotional_event
      comment: "Promotional event flag for measuring promotional lift on traffic."
    - name: "is_store_open"
      expr: is_store_open
      comment: "Store open flag to filter to valid operating hours."
    - name: "sensor_type"
      expr: sensor_type
      comment: "Type of traffic counting sensor for data quality segmentation."
    - name: "counting_zone_code"
      expr: counting_zone_code
      comment: "Zone code for zone-level traffic analysis within a store."
    - name: "zone_type"
      expr: zone_type
      comment: "Type of counting zone (entrance, department, checkout) for traffic flow analysis."
    - name: "weather_condition_code"
      expr: weather_condition_code
      comment: "Weather condition code for analyzing weather impact on store traffic."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality indicator to filter out unreliable sensor readings."
    - name: "measurement_timestamp"
      expr: measurement_timestamp
      comment: "Timestamp of the traffic measurement for time-series analysis."
  measures:
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate_percent AS DOUBLE))
      comment: "Average store conversion rate (transactions / footfall). Core traffic efficiency KPI."
    - name: "avg_dwell_time_minutes"
      expr: AVG(CAST(average_dwell_time_minutes AS DOUBLE))
      comment: "Average customer dwell time in minutes. Longer dwell correlates with higher basket size."
    - name: "avg_accuracy_confidence"
      expr: AVG(CAST(accuracy_confidence_percent AS DOUBLE))
      comment: "Average sensor accuracy confidence. Used to assess data reliability for traffic reporting."
    - name: "avg_temperature_fahrenheit"
      expr: AVG(CAST(temperature_fahrenheit AS DOUBLE))
      comment: "Average ambient temperature during measurement periods. Used for weather-traffic correlation analysis."
    - name: "total_measurement_intervals"
      expr: COUNT(1)
      comment: "Total number of traffic measurement intervals recorded. Volume indicator for coverage analysis."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_shrinkage_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store shrinkage and loss prevention metrics. Tracks retail value lost, cost impact, and recovery rates by shrinkage type. Critical for loss prevention strategy and gross margin protection."
  source: "`vibe_retail_v1`.`store`.`shrinkage_event`"
  dimensions:
    - name: "shrinkage_type"
      expr: shrinkage_type
      comment: "Type of shrinkage (theft, damage, administrative error, vendor fraud) for root-cause analysis."
    - name: "detection_method"
      expr: detection_method
      comment: "How the shrinkage was detected (cycle count, CCTV, audit) for process improvement."
    - name: "responsible_party_type"
      expr: responsible_party_type
      comment: "Party responsible for the shrinkage (internal, external, vendor) for accountability tracking."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the shrinkage event for case management."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the shrinkage event for period-over-period loss trending."
    - name: "event_date"
      expr: event_date
      comment: "Date the shrinkage event occurred for temporal analysis."
    - name: "incident_report_filed"
      expr: incident_report_filed
      comment: "Whether a formal incident report was filed, for compliance and insurance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of shrinkage value figures."
  measures:
    - name: "total_retail_value_lost"
      expr: SUM(CAST(total_retail_value_lost AS DOUBLE))
      comment: "Total retail value of inventory lost to shrinkage. Primary loss prevention KPI."
    - name: "total_cost_value_lost"
      expr: SUM(CAST(cost_value_lost AS DOUBLE))
      comment: "Total cost value of inventory lost. Measures direct gross margin impact of shrinkage."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total value recovered from shrinkage events. Measures loss prevention effectiveness."
    - name: "avg_unit_retail_value"
      expr: AVG(CAST(unit_retail_value AS DOUBLE))
      comment: "Average retail value per unit lost. Identifies high-value shrinkage targets."
    - name: "total_quantity_lost"
      expr: SUM(CAST(quantity_lost AS DOUBLE))
      comment: "Total units lost to shrinkage. Volume measure for inventory impact assessment."
    - name: "total_shrinkage_events"
      expr: COUNT(1)
      comment: "Total number of shrinkage events recorded. Frequency measure for loss prevention prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store audit compliance and quality metrics. Tracks audit scores, findings, and corrective action rates. Used by compliance, operations, and district management to ensure store standards."
  source: "`vibe_retail_v1`.`store`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (food safety, operations, compliance, loss prevention) for category analysis."
    - name: "auditor_type"
      expr: auditor_type
      comment: "Whether the auditor is internal or external, for audit rigor benchmarking."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Overall pass/fail outcome of the audit. Primary compliance status indicator."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Status of audit finding resolution for corrective action tracking."
    - name: "audit_date"
      expr: audit_date
      comment: "Date of the audit for time-series compliance trend analysis."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the audit for quarterly compliance reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the audit for annual compliance benchmarking."
    - name: "citation_issued_flag"
      expr: citation_issued_flag
      comment: "Whether a regulatory citation was issued, for regulatory risk tracking."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required, for remediation workload planning."
    - name: "follow_up_audit_required_flag"
      expr: follow_up_audit_required_flag
      comment: "Whether a follow-up audit is required, indicating severity of findings."
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Regulatory agency conducting or referenced in the audit."
  measures:
    - name: "avg_overall_score_percent"
      expr: AVG(CAST(overall_score_percent AS DOUBLE))
      comment: "Average audit score percentage across stores. Primary compliance quality KPI."
    - name: "avg_previous_audit_score_percent"
      expr: AVG(CAST(previous_audit_score_percent AS DOUBLE))
      comment: "Average prior audit score for trend comparison and improvement tracking."
    - name: "avg_score_variance_percent"
      expr: AVG(CAST(score_variance_percent AS DOUBLE))
      comment: "Average score variance versus prior audit. Measures compliance improvement or deterioration."
    - name: "total_fine_amount"
      expr: SUM(CAST(fine_amount AS DOUBLE))
      comment: "Total regulatory fines issued. Financial risk KPI for compliance leadership."
    - name: "total_audits_conducted"
      expr: COUNT(1)
      comment: "Total number of audits conducted. Coverage metric for audit program completeness."
    - name: "citation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN citation_issued_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits resulting in a regulatory citation. Key regulatory risk KPI."
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring corrective action. Measures compliance gap frequency."
    - name: "follow_up_audit_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_audit_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring a follow-up. Indicates severity of compliance failures."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_dsd_receiving`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Direct store delivery (DSD) receiving performance metrics. Tracks quantity accuracy, cost variance, on-time delivery, and invoice reconciliation. Used by store operations and accounts payable to manage vendor delivery quality."
  source: "`vibe_retail_v1`.`store`.`dsd_receiving`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the DSD receipt (accepted, rejected, partial) for receiving workflow analysis."
    - name: "invoice_match_status"
      expr: invoice_match_status
      comment: "Invoice matching status for accounts payable reconciliation tracking."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for identifying unresolved DSD discrepancies."
    - name: "on_time_delivery_flag"
      expr: on_time_delivery_flag
      comment: "Whether the delivery arrived within the agreed window. Vendor performance indicator."
    - name: "scan_based_trading_flag"
      expr: scan_based_trading_flag
      comment: "Whether the delivery uses scan-based trading, affecting invoice reconciliation process."
    - name: "temperature_check_required"
      expr: temperature_check_required
      comment: "Whether a temperature check was required, for cold chain compliance tracking."
    - name: "receipt_date"
      expr: receipt_date
      comment: "Date of receipt for temporal analysis of DSD delivery patterns."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost figures."
  measures:
    - name: "total_quantity_received"
      expr: SUM(CAST(total_quantity_received AS DOUBLE))
      comment: "Total units received via DSD. Volume measure for inbound supply flow."
    - name: "total_quantity_invoiced"
      expr: SUM(CAST(total_quantity_invoiced AS DOUBLE))
      comment: "Total units invoiced by vendor. Used with quantity received to compute fill rate."
    - name: "total_cost_received"
      expr: SUM(CAST(total_cost_received AS DOUBLE))
      comment: "Total cost value of goods received. Accounts payable liability measure."
    - name: "total_cost_invoiced"
      expr: SUM(CAST(total_cost_invoiced AS DOUBLE))
      comment: "Total cost invoiced by vendor. Used to identify overbilling."
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total quantity variance (received vs invoiced). Measures vendor fill accuracy."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance (received vs invoiced). Measures vendor pricing accuracy and chargeback exposure."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount issued to vendors for DSD discrepancies. Financial recovery KPI."
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN on_time_delivery_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DSD deliveries arriving on time. Vendor service level KPI."
    - name: "total_dsd_receipts"
      expr: COUNT(1)
      comment: "Total DSD receiving events. Volume measure for receiving workload planning."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_remodel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store remodel project performance metrics. Tracks capital spend, schedule adherence, and ROI projections. Used by real estate, capital planning, and store development leadership."
  source: "`vibe_retail_v1`.`store`.`remodel`"
  dimensions:
    - name: "remodel_type"
      expr: remodel_type
      comment: "Type of remodel (full, refresh, technology upgrade) for capital program analysis."
    - name: "project_status"
      expr: project_status
      comment: "Current project status (planned, in-progress, completed) for portfolio tracking."
    - name: "format_change_flag"
      expr: format_change_flag
      comment: "Whether the remodel includes a format change, for strategic transformation tracking."
    - name: "temporary_closure_flag"
      expr: temporary_closure_flag
      comment: "Whether the store was temporarily closed during remodel, affecting comp sales exclusion."
    - name: "comp_sales_exclusion_flag"
      expr: comp_sales_exclusion_flag
      comment: "Whether the store is excluded from comp sales during remodel period."
    - name: "planned_start_date"
      expr: planned_start_date
      comment: "Planned start date for remodel schedule adherence analysis."
    - name: "actual_start_date"
      expr: actual_start_date
      comment: "Actual start date for schedule variance calculation."
  measures:
    - name: "total_capital_budget"
      expr: SUM(CAST(capital_budget_amount AS DOUBLE))
      comment: "Total capital budget allocated to remodel projects. Capital planning KPI."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual capital spend on remodels. Used to track budget adherence."
    - name: "avg_roi_projection_percent"
      expr: AVG(CAST(roi_projection_percent AS DOUBLE))
      comment: "Average projected ROI for remodel investments. Capital allocation decision KPI."
    - name: "total_remodel_projects"
      expr: COUNT(1)
      comment: "Total number of remodel projects. Portfolio size measure for capital program management."
    - name: "budget_variance"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE) - CAST(capital_budget_amount AS DOUBLE))
      comment: "Total budget variance (actual minus budget). Negative = under budget, positive = over budget."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store location portfolio metrics. Tracks store count, size, and capability distribution across the network. Used by real estate, operations, and strategy for portfolio planning and network optimization."
  source: "`vibe_retail_v1`.`store`.`location`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Store lifecycle status (open, closed, planned, remodeling) for active portfolio analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country for geographic portfolio distribution analysis."
    - name: "state_province"
      expr: state_province
      comment: "State or province for regional portfolio analysis."
    - name: "city"
      expr: city
      comment: "City for local market concentration analysis."
    - name: "climate_zone"
      expr: climate_zone
      comment: "Climate zone for assortment and operational planning."
    - name: "format_size_band"
      expr: format_size_band
      comment: "Store size band for format-level portfolio analysis."
    - name: "bopis_capable"
      expr: bopis_capable
      comment: "BOPIS capability flag for omnichannel network coverage analysis."
    - name: "sfs_capable"
      expr: sfs_capable
      comment: "Ship-from-store capability flag for fulfillment network planning."
    - name: "ropis_capable"
      expr: ropis_capable
      comment: "Reserve online, pick up in store capability flag."
    - name: "dsd_receiving"
      expr: dsd_receiving
      comment: "DSD receiving capability flag for supply chain network planning."
    - name: "staffing_model_type"
      expr: staffing_model_type
      comment: "Staffing model type for workforce planning segmentation."
    - name: "opening_date"
      expr: opening_date
      comment: "Store opening date for cohort analysis of new vs. mature stores."
  measures:
    - name: "total_store_count"
      expr: COUNT(DISTINCT location_id)
      comment: "Total number of store locations. Core portfolio size KPI for network planning."
    - name: "total_selling_square_footage"
      expr: SUM(CAST(selling_square_footage AS DOUBLE))
      comment: "Total selling square footage across the store network. Capacity and productivity denominator."
    - name: "total_square_footage"
      expr: SUM(CAST(total_square_footage AS DOUBLE))
      comment: "Total gross square footage across all locations. Real estate footprint measure."
    - name: "avg_selling_square_footage"
      expr: AVG(CAST(selling_square_footage AS DOUBLE))
      comment: "Average selling square footage per store. Format size benchmark."
    - name: "bopis_capable_store_count"
      expr: SUM(CASE WHEN bopis_capable = TRUE THEN 1 ELSE 0 END)
      comment: "Number of BOPIS-capable stores. Omnichannel network coverage KPI."
    - name: "sfs_capable_store_count"
      expr: SUM(CASE WHEN sfs_capable = TRUE THEN 1 ELSE 0 END)
      comment: "Number of ship-from-store capable locations. Fulfillment network capacity KPI."
    - name: "omnichannel_penetration_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN bopis_capable = TRUE OR sfs_capable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT location_id), 0), 2)
      comment: "Percentage of stores with at least one omnichannel fulfillment capability. Strategic network readiness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_sfs_fulfillment_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ship-from-store fulfillment node performance metrics. Tracks capacity, efficiency, and operational readiness of store-based fulfillment nodes. Used by omnichannel operations and supply chain leadership."
  source: "`vibe_retail_v1`.`store`.`sfs_fulfillment_node`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the fulfillment node (active, inactive, suspended)."
    - name: "node_type"
      expr: node_type
      comment: "Type of fulfillment node (SFS, BOPIS, curbside) for capability segmentation."
    - name: "supports_same_day_delivery"
      expr: supports_same_day_delivery
      comment: "Whether the node supports same-day delivery. Premium fulfillment capability flag."
    - name: "supports_next_day_delivery"
      expr: supports_next_day_delivery
      comment: "Whether the node supports next-day delivery."
    - name: "supports_bopis"
      expr: supports_bopis
      comment: "Whether the node supports buy online, pick up in store."
    - name: "supports_curbside_pickup"
      expr: supports_curbside_pickup
      comment: "Whether the node supports curbside pickup."
    - name: "oms_integration_enabled"
      expr: oms_integration_enabled
      comment: "Whether OMS integration is active, indicating operational readiness."
    - name: "activation_date"
      expr: activation_date
      comment: "Date the node was activated for cohort analysis of node maturity."
  measures:
    - name: "total_active_nodes"
      expr: COUNT(DISTINCT sfs_fulfillment_node_id)
      comment: "Total number of ship-from-store fulfillment nodes. Network capacity measure."
    - name: "avg_pick_time_minutes"
      expr: AVG(CAST(average_pick_time_minutes AS DOUBLE))
      comment: "Average pick time per order in minutes. Fulfillment efficiency KPI."
    - name: "avg_pack_time_minutes"
      expr: AVG(CAST(average_pack_time_minutes AS DOUBLE))
      comment: "Average pack time per order in minutes. Fulfillment throughput KPI."
    - name: "avg_cost_per_order"
      expr: AVG(CAST(cost_per_order AS DOUBLE))
      comment: "Average fulfillment cost per order. Key unit economics KPI for SFS profitability."
    - name: "avg_service_radius_km"
      expr: AVG(CAST(service_radius_km AS DOUBLE))
      comment: "Average service radius in kilometers. Measures geographic coverage of the SFS network."
    - name: "same_day_node_count"
      expr: SUM(CASE WHEN supports_same_day_delivery = TRUE THEN 1 ELSE 0 END)
      comment: "Number of nodes supporting same-day delivery. Premium fulfillment network capacity KPI."
    - name: "bopis_node_count"
      expr: SUM(CASE WHEN supports_bopis = TRUE THEN 1 ELSE 0 END)
      comment: "Number of nodes supporting BOPIS. Omnichannel pickup network coverage KPI."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_cluster`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store cluster portfolio and performance metrics. Tracks cluster composition, sales performance, and strategic attributes. Used by merchandising, pricing, and operations for cluster-based strategy execution."
  source: "`vibe_retail_v1`.`store`.`cluster`"
  dimensions:
    - name: "cluster_type"
      expr: cluster_type
      comment: "Type of cluster (assortment, pricing, promotional) for strategy segmentation."
    - name: "cluster_status"
      expr: cluster_status
      comment: "Active/inactive status of the cluster for filtering to current cluster definitions."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the cluster (national, regional, local) for hierarchy analysis."
    - name: "urbanization_level"
      expr: urbanization_level
      comment: "Urbanization level (urban, suburban, rural) for demographic-based cluster analysis."
    - name: "climate_zone"
      expr: climate_zone
      comment: "Climate zone for seasonal assortment and operational planning."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy assigned to the cluster for price zone alignment."
    - name: "target_customer_segment"
      expr: target_customer_segment
      comment: "Target customer segment for the cluster for marketing and assortment alignment."
    - name: "supports_omnichannel"
      expr: supports_omnichannel
      comment: "Whether the cluster supports omnichannel operations."
    - name: "cluster_level"
      expr: cluster_level
      comment: "Hierarchy level of the cluster for multi-tier cluster analysis."
  measures:
    - name: "total_clusters"
      expr: COUNT(DISTINCT cluster_id)
      comment: "Total number of store clusters. Portfolio size measure for cluster management."
    - name: "avg_annual_sales_usd"
      expr: AVG(CAST(average_annual_sales_usd AS DOUBLE))
      comment: "Average annual sales per cluster. Revenue productivity benchmark for cluster strategy."
    - name: "avg_store_size_sqft"
      expr: AVG(CAST(average_store_size_sqft AS DOUBLE))
      comment: "Average store size within clusters. Used for format-cluster alignment analysis."
    - name: "total_annual_sales_usd"
      expr: SUM(CAST(average_annual_sales_usd AS DOUBLE))
      comment: "Total annual sales across all clusters. Aggregate revenue measure for cluster portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_planogram`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store planogram compliance and deployment metrics. Tracks planogram rollout, compliance rates, and space productivity targets. Used by merchandising and store operations to ensure consistent execution."
  source: "`vibe_retail_v1`.`store`.`store_planogram`"
  dimensions:
    - name: "planogram_status"
      expr: planogram_status
      comment: "Current status of the planogram (active, expired, draft) for filtering to live planograms."
    - name: "planogram_type"
      expr: planogram_type
      comment: "Type of planogram (seasonal, permanent, promotional) for category analysis."
    - name: "merchandising_strategy"
      expr: merchandising_strategy
      comment: "Merchandising strategy applied in the planogram for strategy effectiveness analysis."
    - name: "fixture_type"
      expr: fixture_type
      comment: "Fixture type used in the planogram for space planning analysis."
    - name: "compliance_required_flag"
      expr: compliance_required_flag
      comment: "Whether compliance is mandatory for this planogram."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Planogram effective start date for seasonal and promotional timing analysis."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "Planogram effective end date."
  measures:
    - name: "avg_compliance_tolerance_percent"
      expr: AVG(CAST(compliance_tolerance_percent AS DOUBLE))
      comment: "Average compliance tolerance threshold. Measures how strictly planogram adherence is enforced."
    - name: "avg_target_gmroi"
      expr: AVG(CAST(target_gmroi AS DOUBLE))
      comment: "Average target GMROI (gross margin return on inventory investment) for planograms. Space productivity KPI."
    - name: "avg_target_sales_per_linear_foot"
      expr: AVG(CAST(target_sales_per_linear_foot AS DOUBLE))
      comment: "Average target sales per linear foot. Space productivity benchmark for planogram design."
    - name: "total_linear_feet_planned"
      expr: SUM(CAST(total_linear_feet AS DOUBLE))
      comment: "Total linear feet of shelf space covered by planograms. Space allocation measure."
    - name: "total_active_planograms"
      expr: COUNT(DISTINCT store_planogram_id)
      comment: "Total number of active store planograms. Coverage measure for planogram management."
$$;