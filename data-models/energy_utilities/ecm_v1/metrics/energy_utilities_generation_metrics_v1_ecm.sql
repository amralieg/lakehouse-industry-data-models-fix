-- Metric views for domain: generation | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-04 21:07:37

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`generation_capacity_market_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for capacity market offers, focusing on cleared capacity, pricing, and revenue"
  source: "`energy_utilities_ecm`.`generation`.`capacity_market_offer`"
  dimensions:
    - name: "iso_rto_code"
      expr: iso_rto_code
      comment: "ISO/RTO identifier"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Primary fuel type of the generating unit"
    - name: "auction_year"
      expr: auction_year
      comment: "Year of the capacity auction"
    - name: "auction_date_day"
      expr: DATE_TRUNC('day', auction_date)
      comment: "Auction date truncated to day"
  measures:
    - name: "total_cleared_capacity_mw"
      expr: SUM(CAST(cleared_capacity_mw AS DOUBLE))
      comment: "Total cleared capacity (MW) awarded in capacity market offers"
    - name: "average_clearing_price_per_mw_day"
      expr: AVG(CAST(clearing_price_per_mw_day AS DOUBLE))
      comment: "Average clearing price per MW-day for awarded offers"
    - name: "total_net_capacity_revenue_usd"
      expr: SUM(CAST(net_capacity_revenue_usd AS DOUBLE))
      comment: "Total net revenue (USD) from capacity market participation"
    - name: "awarded_offers_count"
      expr: COUNT(CASE WHEN offer_status = 'Awarded' THEN 1 END)
      comment: "Count of offers with status Awarded"
    - name: "total_offers_count"
      expr: COUNT(1)
      comment: "Total number of capacity market offers"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`generation_dispatch_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispatch schedule effectiveness and variance metrics"
  source: "`energy_utilities_ecm`.`generation`.`dispatch_schedule`"
  dimensions:
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area identifier"
    - name: "market_type"
      expr: market_type
      comment: "Market type (e.g., Energy, Ancillary)"
    - name: "dispatch_status"
      expr: dispatch_status
      comment: "Status of the dispatch instruction"
    - name: "schedule_day"
      expr: DATE_TRUNC('day', schedule_interval_start_timestamp)
      comment: "Dispatch schedule day"
  measures:
    - name: "total_actual_output_mw"
      expr: SUM(CAST(actual_output_mw AS DOUBLE))
      comment: "Total actual MW output scheduled"
    - name: "total_dispatch_variance_mw"
      expr: SUM(CAST(dispatch_variance_mw AS DOUBLE))
      comment: "Total MW variance between scheduled and dispatched output"
    - name: "dispatch_count"
      expr: COUNT(1)
      comment: "Number of dispatch schedule records"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`generation_emissions_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental emissions performance metrics"
  source: "`energy_utilities_ecm`.`generation`.`emissions_reading`"
  dimensions:
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area identifier"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type of the generating unit"
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year"
    - name: "reporting_quarter"
      expr: reporting_quarter
      comment: "Reporting quarter"
  measures:
    - name: "total_emission_rate"
      expr: SUM(CAST(emission_rate AS DOUBLE))
      comment: "Total emissions rate across all readings"
    - name: "average_emission_rate"
      expr: AVG(CAST(emission_rate AS DOUBLE))
      comment: "Average emissions rate per reading"
    - name: "total_allowance_quantity_deducted"
      expr: SUM(CAST(allowance_quantity_deducted AS DOUBLE))
      comment: "Total allowance quantity deducted"
    - name: "emissions_reading_count"
      expr: COUNT(1)
      comment: "Number of emissions readings recorded"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`generation_gads_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Generation Availability Data System (GADS) performance indicators"
  source: "`energy_utilities_ecm`.`generation`.`gads_report`"
  dimensions:
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area identifier"
    - name: "primary_fuel_type"
      expr: primary_fuel_type
      comment: "Primary fuel type of the unit"
    - name: "reporting_period_start_day"
      expr: DATE_TRUNC('day', reporting_period_start_date)
      comment: "Start date of the reporting period truncated to day"
  measures:
    - name: "total_gross_generation_mwh"
      expr: SUM(CAST(gross_generation_mwh AS DOUBLE))
      comment: "Total gross generation (MWh) reported"
    - name: "average_capacity_factor_pct"
      expr: AVG(CAST(capacity_factor_pct AS DOUBLE))
      comment: "Average capacity factor percentage"
    - name: "total_forced_outage_hours"
      expr: SUM(CAST(forced_outage_hours AS DOUBLE))
      comment: "Total forced outage hours"
    - name: "gads_report_count"
      expr: COUNT(1)
      comment: "Number of GADS reports"
$$;