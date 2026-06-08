-- Metric views for domain: store | Business: Retail | Version: 1 | Generated on: 2026-05-04 11:04:04

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`store_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core store location performance and operational metrics including store count, footprint, and format distribution"
  source: "`retail_ecm`.`store`.`location`"
  dimensions:
    - name: "store_number"
      expr: store_number
      comment: "Unique store identifier for location-level analysis"
    - name: "store_name"
      expr: store_name
      comment: "Store name for reporting and identification"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current operational status of the store (open, closed, remodeling, etc.)"
    - name: "banner_brand"
      expr: banner_brand
      comment: "Brand banner under which the store operates"
    - name: "format_size_band"
      expr: format_size_band
      comment: "Store size classification band for format analysis"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code for regional performance analysis"
    - name: "district_code"
      expr: district_code
      comment: "District code for district-level rollups"
    - name: "state_province"
      expr: state_province
      comment: "State or province for geographic segmentation"
    - name: "city"
      expr: city
      comment: "City location for local market analysis"
    - name: "climate_zone"
      expr: climate_zone
      comment: "Climate zone classification affecting assortment and operations"
    - name: "opening_year"
      expr: YEAR(opening_date)
      comment: "Year the store opened for vintage analysis"
    - name: "bopis_capable"
      expr: bopis_capable
      comment: "Whether store supports buy-online-pickup-in-store"
    - name: "sfs_capable"
      expr: sfs_capable
      comment: "Whether store supports ship-from-store fulfillment"
    - name: "staffing_model_type"
      expr: staffing_model_type
      comment: "Staffing model classification for labor planning"
  measures:
    - name: "store_count"
      expr: COUNT(DISTINCT location_id)
      comment: "Total number of unique store locations"
    - name: "total_selling_square_footage"
      expr: SUM(CAST(selling_square_footage AS DOUBLE))
      comment: "Total selling square footage across stores"
    - name: "avg_selling_square_footage"
      expr: AVG(CAST(selling_square_footage AS DOUBLE))
      comment: "Average selling square footage per store"
    - name: "total_square_footage_all_stores"
      expr: SUM(CAST(total_square_footage AS DOUBLE))
      comment: "Total square footage including back-of-house across all stores"
    - name: "avg_total_square_footage"
      expr: AVG(CAST(total_square_footage AS DOUBLE))
      comment: "Average total square footage per store"
    - name: "omnichannel_penetration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN bopis_capable = TRUE OR sfs_capable = TRUE THEN location_id END) / NULLIF(COUNT(DISTINCT location_id), 0), 2)
      comment: "Percentage of stores with omnichannel fulfillment capabilities"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`store_comparable_sales`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Comparable store sales performance metrics including comp sales growth, transaction metrics, and productivity KPIs"
  source: "`retail_ecm`.`store`.`comparable_sales`"
  dimensions:
    - name: "store_number"
      expr: store_number
      comment: "Store identifier for location-level comp sales analysis"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for year-over-year trending"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-over-period analysis"
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Type of reporting period (monthly, quarterly, annual)"
    - name: "reporting_region"
      expr: reporting_region
      comment: "Geographic region for regional comp sales performance"
    - name: "reporting_district"
      expr: reporting_district
      comment: "District for district-level comp sales rollups"
    - name: "comp_store_qualification_status"
      expr: comp_store_qualification_status
      comment: "Whether store qualifies for comp sales calculation"
    - name: "remodel_flag"
      expr: remodel_flag
      comment: "Indicates if store was remodeled during period"
    - name: "closure_flag"
      expr: closure_flag
      comment: "Indicates if store had closure days during period"
    - name: "reporting_period_start_date"
      expr: reporting_period_start_date
      comment: "Start date of the reporting period"
  measures:
    - name: "total_current_period_net_sales"
      expr: SUM(CAST(current_period_net_sales AS DOUBLE))
      comment: "Total net sales for current period across comp stores"
    - name: "total_prior_period_net_sales"
      expr: SUM(CAST(prior_period_net_sales AS DOUBLE))
      comment: "Total net sales for prior period across comp stores"
    - name: "comp_sales_growth_rate"
      expr: ROUND(100.0 * (SUM(CAST(current_period_net_sales AS DOUBLE)) - SUM(CAST(prior_period_net_sales AS DOUBLE))) / NULLIF(SUM(CAST(prior_period_net_sales AS DOUBLE)), 0), 2)
      comment: "Comparable store sales growth rate percentage"
    - name: "total_current_period_transactions"
      expr: SUM(CAST(current_period_transaction_count AS BIGINT))
      comment: "Total transaction count for current period"
    - name: "total_prior_period_transactions"
      expr: SUM(CAST(prior_period_transaction_count AS BIGINT))
      comment: "Total transaction count for prior period"
    - name: "transaction_growth_rate"
      expr: ROUND(100.0 * (SUM(CAST(current_period_transaction_count AS BIGINT)) - SUM(CAST(prior_period_transaction_count AS BIGINT))) / NULLIF(SUM(CAST(prior_period_transaction_count AS BIGINT)), 0), 2)
      comment: "Transaction count growth rate percentage"
    - name: "avg_current_period_atv"
      expr: AVG(CAST(current_period_atv AS DOUBLE))
      comment: "Average transaction value for current period"
    - name: "avg_prior_period_atv"
      expr: AVG(CAST(prior_period_atv AS DOUBLE))
      comment: "Average transaction value for prior period"
    - name: "avg_current_period_conversion_rate"
      expr: AVG(CAST(current_period_conversion_rate AS DOUBLE))
      comment: "Average conversion rate for current period"
    - name: "total_current_period_footfall"
      expr: SUM(CAST(current_period_footfall AS BIGINT))
      comment: "Total footfall traffic for current period"
    - name: "avg_sales_per_sqft"
      expr: AVG(CAST(sales_per_sqft AS DOUBLE))
      comment: "Average sales per square foot productivity metric"
    - name: "comp_store_count"
      expr: COUNT(DISTINCT comparable_sales_id)
      comment: "Number of comparable store records in the analysis"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`store_pl`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store-level profit and loss statement metrics including revenue, margin, expenses, and profitability KPIs"
  source: "`retail_ecm`.`store`.`pl`"
  dimensions:
    - name: "reporting_entity"
      expr: reporting_entity
      comment: "Store or entity identifier for P&L reporting"
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the P&L reporting period"
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the P&L reporting period"
    - name: "pl_status"
      expr: pl_status
      comment: "Status of the P&L record (draft, finalized, etc.)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for financial amounts"
    - name: "comp_sales_flag"
      expr: comp_sales_flag
      comment: "Whether store qualifies for comp sales in this period"
    - name: "fiscal_year"
      expr: YEAR(period_start_date)
      comment: "Fiscal year derived from period start date"
    - name: "fiscal_quarter"
      expr: QUARTER(period_start_date)
      comment: "Fiscal quarter derived from period start date"
  measures:
    - name: "total_gross_sales"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales before discounts and returns"
    - name: "total_net_sales"
      expr: SUM(CAST(net_sales_amount AS DOUBLE))
      comment: "Total net sales after discounts and returns"
    - name: "total_cogs"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold"
    - name: "total_gross_margin"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Total gross margin (net sales minus COGS)"
    - name: "gross_margin_rate"
      expr: ROUND(100.0 * SUM(CAST(gross_margin_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_sales_amount AS DOUBLE)), 0), 2)
      comment: "Gross margin as a percentage of net sales"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost expense"
    - name: "total_occupancy_cost"
      expr: SUM(CAST(occupancy_cost_amount AS DOUBLE))
      comment: "Total occupancy cost (rent, utilities, etc.)"
    - name: "total_operating_expense"
      expr: SUM(CAST(total_operating_expense_amount AS DOUBLE))
      comment: "Total operating expenses"
    - name: "total_ebitda"
      expr: SUM(CAST(ebitda_amount AS DOUBLE))
      comment: "Total earnings before interest, taxes, depreciation, and amortization"
    - name: "ebitda_margin_rate"
      expr: ROUND(100.0 * SUM(CAST(ebitda_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_sales_amount AS DOUBLE)), 0), 2)
      comment: "EBITDA margin as a percentage of net sales"
    - name: "total_shrinkage"
      expr: SUM(CAST(shrinkage_amount AS DOUBLE))
      comment: "Total shrinkage loss amount"
    - name: "shrinkage_rate"
      expr: ROUND(100.0 * SUM(CAST(shrinkage_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_sales_amount AS DOUBLE)), 0), 2)
      comment: "Shrinkage as a percentage of net sales"
    - name: "total_discounts"
      expr: SUM(CAST(discounts_amount AS DOUBLE))
      comment: "Total discount amount given"
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discounts_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_sales_amount AS DOUBLE)), 0), 2)
      comment: "Discount rate as a percentage of gross sales"
    - name: "total_transactions"
      expr: SUM(CAST(transaction_count AS BIGINT))
      comment: "Total number of transactions"
    - name: "total_units_sold"
      expr: SUM(CAST(units_sold AS BIGINT))
      comment: "Total units sold"
    - name: "avg_transaction_value"
      expr: AVG(CAST(atv_amount AS DOUBLE))
      comment: "Average transaction value"
    - name: "avg_units_per_transaction"
      expr: AVG(CAST(upt AS DOUBLE))
      comment: "Average units per transaction"
    - name: "labor_cost_rate"
      expr: ROUND(100.0 * SUM(CAST(labor_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_sales_amount AS DOUBLE)), 0), 2)
      comment: "Labor cost as a percentage of net sales"
    - name: "store_count_in_pl"
      expr: COUNT(DISTINCT pl_id)
      comment: "Number of store P&L records"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`store_traffic_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store traffic and conversion metrics including footfall, conversion rate, and dwell time analysis"
  source: "`retail_ecm`.`store`.`traffic_count`"
  dimensions:
    - name: "counting_zone_name"
      expr: counting_zone_name
      comment: "Name of the traffic counting zone within the store"
    - name: "zone_type"
      expr: zone_type
      comment: "Type of zone (entrance, department, checkout, etc.)"
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for traffic pattern analysis"
    - name: "hour_of_day"
      expr: hour_of_day
      comment: "Hour of day for intraday traffic patterns"
    - name: "is_holiday"
      expr: is_holiday
      comment: "Whether the measurement occurred on a holiday"
    - name: "is_promotional_event"
      expr: is_promotional_event
      comment: "Whether a promotional event was active during measurement"
    - name: "weather_condition_code"
      expr: weather_condition_code
      comment: "Weather condition code during measurement period"
    - name: "sensor_type"
      expr: sensor_type
      comment: "Type of sensor used for traffic counting"
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality indicator for the traffic measurement"
    - name: "measurement_date"
      expr: DATE(measurement_timestamp)
      comment: "Date of the traffic measurement"
  measures:
    - name: "total_inbound_traffic"
      expr: SUM(CAST(inbound_count AS BIGINT))
      comment: "Total inbound traffic count (customers entering)"
    - name: "total_outbound_traffic"
      expr: SUM(CAST(outbound_count AS BIGINT))
      comment: "Total outbound traffic count (customers exiting)"
    - name: "total_transactions"
      expr: SUM(CAST(transaction_count AS BIGINT))
      comment: "Total transaction count during traffic measurement periods"
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate_percent AS DOUBLE))
      comment: "Average conversion rate (transactions divided by traffic)"
    - name: "avg_dwell_time_minutes"
      expr: AVG(CAST(average_dwell_time_minutes AS DOUBLE))
      comment: "Average time customers spend in the store"
    - name: "peak_occupancy_avg"
      expr: AVG(CAST(peak_occupancy AS BIGINT))
      comment: "Average peak occupancy across measurement periods"
    - name: "traffic_measurement_count"
      expr: COUNT(DISTINCT traffic_count_id)
      comment: "Number of traffic measurement records"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`store_shrinkage_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shrinkage and loss prevention metrics including shrinkage value, recovery, and incident analysis"
  source: "`retail_ecm`.`store`.`shrinkage_event`"
  dimensions:
    - name: "shrinkage_type"
      expr: shrinkage_type
      comment: "Type of shrinkage (theft, damage, administrative error, etc.)"
    - name: "responsible_party_type"
      expr: responsible_party_type
      comment: "Type of party responsible (external, internal, vendor, unknown)"
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which shrinkage was detected"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the shrinkage event"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period when shrinkage occurred"
    - name: "event_year"
      expr: YEAR(event_date)
      comment: "Year when shrinkage event occurred"
    - name: "event_month"
      expr: MONTH(event_date)
      comment: "Month when shrinkage event occurred"
    - name: "incident_report_filed"
      expr: incident_report_filed
      comment: "Whether an incident report was filed"
    - name: "zone_location"
      expr: zone_location
      comment: "Store zone where shrinkage occurred"
  measures:
    - name: "total_retail_value_lost"
      expr: SUM(CAST(total_retail_value_lost AS DOUBLE))
      comment: "Total retail value of shrinkage losses"
    - name: "total_cost_value_lost"
      expr: SUM(CAST(cost_value_lost AS DOUBLE))
      comment: "Total cost value of shrinkage losses"
    - name: "total_quantity_lost"
      expr: SUM(CAST(quantity_lost AS DOUBLE))
      comment: "Total quantity of units lost to shrinkage"
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered from shrinkage events"
    - name: "recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(recovery_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_retail_value_lost AS DOUBLE)), 0), 2)
      comment: "Percentage of shrinkage value recovered"
    - name: "shrinkage_event_count"
      expr: COUNT(DISTINCT shrinkage_event_id)
      comment: "Total number of shrinkage events"
    - name: "avg_retail_value_per_event"
      expr: AVG(CAST(total_retail_value_lost AS DOUBLE))
      comment: "Average retail value lost per shrinkage event"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`store_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store audit and compliance metrics including audit scores, findings, and corrective action tracking"
  source: "`retail_ecm`.`store`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted (operational, safety, compliance, etc.)"
    - name: "audit_scope"
      expr: audit_scope
      comment: "Scope of the audit (full store, department, specific process)"
    - name: "auditor_type"
      expr: auditor_type
      comment: "Type of auditor (internal, external, regulatory)"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Overall pass/fail status of the audit"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of audit findings"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year when audit was conducted"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter when audit was conducted"
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Regulatory agency conducting or requiring the audit"
    - name: "citation_issued_flag"
      expr: citation_issued_flag
      comment: "Whether a citation was issued as a result of the audit"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required"
    - name: "follow_up_audit_required_flag"
      expr: follow_up_audit_required_flag
      comment: "Whether a follow-up audit is required"
  measures:
    - name: "audit_count"
      expr: COUNT(DISTINCT audit_id)
      comment: "Total number of audits conducted"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score_percent AS DOUBLE))
      comment: "Average overall audit score percentage"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS BIGINT))
      comment: "Total number of critical findings across audits"
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS BIGINT))
      comment: "Total number of major findings across audits"
    - name: "total_minor_findings"
      expr: SUM(CAST(minor_findings_count AS BIGINT))
      comment: "Total number of minor findings across audits"
    - name: "total_findings"
      expr: SUM(CAST(total_findings_count AS BIGINT))
      comment: "Total number of all findings across audits"
    - name: "total_fine_amount"
      expr: SUM(CAST(fine_amount AS DOUBLE))
      comment: "Total fines assessed from audit findings"
    - name: "avg_score_variance"
      expr: AVG(CAST(score_variance_percent AS DOUBLE))
      comment: "Average score variance compared to previous audit"
    - name: "pass_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pass_fail_status = 'Pass' THEN audit_id END) / NULLIF(COUNT(DISTINCT audit_id), 0), 2)
      comment: "Percentage of audits with pass status"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`store_remodel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store remodel project metrics including spend, timeline, ROI, and project completion tracking"
  source: "`retail_ecm`.`store`.`remodel`"
  dimensions:
    - name: "remodel_type"
      expr: remodel_type
      comment: "Type of remodel (full, refresh, expansion, etc.)"
    - name: "project_status"
      expr: project_status
      comment: "Current status of the remodel project"
    - name: "format_change_flag"
      expr: format_change_flag
      comment: "Whether the remodel includes a format change"
    - name: "temporary_closure_flag"
      expr: temporary_closure_flag
      comment: "Whether the store was temporarily closed during remodel"
    - name: "comp_sales_exclusion_flag"
      expr: comp_sales_exclusion_flag
      comment: "Whether store is excluded from comp sales during remodel"
    - name: "new_format"
      expr: new_format
      comment: "New store format after remodel"
    - name: "project_year"
      expr: YEAR(planned_start_date)
      comment: "Year the remodel project was planned to start"
    - name: "sustainability_features"
      expr: sustainability_features
      comment: "Sustainability features included in the remodel"
  measures:
    - name: "remodel_project_count"
      expr: COUNT(DISTINCT remodel_id)
      comment: "Total number of remodel projects"
    - name: "total_capital_budget"
      expr: SUM(CAST(capital_budget_amount AS DOUBLE))
      comment: "Total capital budget allocated for remodels"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend on remodel projects"
    - name: "budget_variance"
      expr: SUM((CAST(actual_spend_amount AS DOUBLE)) - (CAST(capital_budget_amount AS DOUBLE)))
      comment: "Total budget variance (actual minus budget)"
    - name: "budget_variance_rate"
      expr: ROUND(100.0 * (SUM(CAST(actual_spend_amount AS DOUBLE)) - SUM(CAST(capital_budget_amount AS DOUBLE))) / NULLIF(SUM(CAST(capital_budget_amount AS DOUBLE)), 0), 2)
      comment: "Budget variance as a percentage of budget"
    - name: "avg_roi_projection"
      expr: AVG(CAST(roi_projection_percent AS DOUBLE))
      comment: "Average projected ROI for remodel projects"
    - name: "avg_capital_budget_per_project"
      expr: AVG(CAST(capital_budget_amount AS DOUBLE))
      comment: "Average capital budget per remodel project"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`store_dsd_receiving`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Direct store delivery receiving metrics including receipt accuracy, timeliness, and cost variance"
  source: "`retail_ecm`.`store`.`dsd_receiving`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the DSD receipt (received, rejected, pending)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the receipt against invoice"
    - name: "invoice_match_status"
      expr: invoice_match_status
      comment: "Whether receipt matches invoice (matched, variance, pending)"
    - name: "on_time_delivery_flag"
      expr: on_time_delivery_flag
      comment: "Whether delivery was on time per delivery window"
    - name: "scan_based_trading_flag"
      expr: scan_based_trading_flag
      comment: "Whether receipt is under scan-based trading agreement"
    - name: "temperature_check_required"
      expr: temperature_check_required
      comment: "Whether temperature check was required for the delivery"
    - name: "temperature_check_result"
      expr: temperature_check_result
      comment: "Result of temperature check (pass, fail, not applicable)"
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for rejecting the delivery"
    - name: "chargeback_reason"
      expr: chargeback_reason
      comment: "Reason for chargeback to vendor"
    - name: "receipt_year"
      expr: YEAR(receipt_date)
      comment: "Year of the receipt"
    - name: "receipt_month"
      expr: MONTH(receipt_date)
      comment: "Month of the receipt"
  measures:
    - name: "dsd_receipt_count"
      expr: COUNT(DISTINCT dsd_receiving_id)
      comment: "Total number of DSD receipts"
    - name: "total_quantity_received"
      expr: SUM(CAST(total_quantity_received AS DOUBLE))
      comment: "Total quantity received across all DSD receipts"
    - name: "total_quantity_invoiced"
      expr: SUM(CAST(total_quantity_invoiced AS DOUBLE))
      comment: "Total quantity invoiced across all DSD receipts"
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total quantity variance (received minus invoiced)"
    - name: "total_cost_received"
      expr: SUM(CAST(total_cost_received AS DOUBLE))
      comment: "Total cost of goods received"
    - name: "total_cost_invoiced"
      expr: SUM(CAST(total_cost_invoiced AS DOUBLE))
      comment: "Total cost invoiced by vendors"
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance (received minus invoiced)"
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount to vendors"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN on_time_delivery_flag = TRUE THEN dsd_receiving_id END) / NULLIF(COUNT(DISTINCT dsd_receiving_id), 0), 2)
      comment: "Percentage of DSD deliveries received on time"
    - name: "receipt_accuracy_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN invoice_match_status = 'Matched' THEN dsd_receiving_id END) / NULLIF(COUNT(DISTINCT dsd_receiving_id), 0), 2)
      comment: "Percentage of receipts that match invoice without variance"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`store_cluster`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store cluster performance and configuration metrics including cluster size, sales, and strategy alignment"
  source: "`retail_ecm`.`store`.`cluster`"
  dimensions:
    - name: "cluster_name"
      expr: cluster_name
      comment: "Name of the store cluster"
    - name: "cluster_code"
      expr: cluster_code
      comment: "Unique code identifying the cluster"
    - name: "cluster_type"
      expr: cluster_type
      comment: "Type of cluster (geographic, demographic, performance-based, etc.)"
    - name: "cluster_status"
      expr: cluster_status
      comment: "Current status of the cluster (active, inactive, under review)"
    - name: "cluster_level"
      expr: cluster_level
      comment: "Hierarchical level of the cluster"
    - name: "primary_business_purpose"
      expr: primary_business_purpose
      comment: "Primary business purpose of the cluster"
    - name: "target_customer_segment"
      expr: target_customer_segment
      comment: "Target customer segment for the cluster"
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy applied to the cluster"
    - name: "promotional_intensity"
      expr: promotional_intensity
      comment: "Promotional intensity level for the cluster"
    - name: "urbanization_level"
      expr: urbanization_level
      comment: "Urbanization level of cluster locations"
    - name: "climate_zone"
      expr: climate_zone
      comment: "Climate zone classification for the cluster"
    - name: "supports_omnichannel"
      expr: supports_omnichannel
      comment: "Whether cluster supports omnichannel capabilities"
  measures:
    - name: "cluster_count"
      expr: COUNT(DISTINCT cluster_id)
      comment: "Total number of store clusters"
    - name: "total_member_stores"
      expr: SUM(CAST(member_store_count AS BIGINT))
      comment: "Total number of stores across all clusters"
    - name: "avg_member_stores_per_cluster"
      expr: AVG(CAST(member_store_count AS BIGINT))
      comment: "Average number of member stores per cluster"
    - name: "total_annual_sales"
      expr: SUM(CAST(average_annual_sales_usd AS DOUBLE))
      comment: "Total average annual sales across all clusters"
    - name: "avg_annual_sales_per_cluster"
      expr: AVG(CAST(average_annual_sales_usd AS DOUBLE))
      comment: "Average annual sales per cluster"
    - name: "avg_store_size_sqft"
      expr: AVG(CAST(average_store_size_sqft AS DOUBLE))
      comment: "Average store size in square feet across clusters"
$$;