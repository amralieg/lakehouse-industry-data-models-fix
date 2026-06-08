-- Metric views for domain: sales | Business: Mining | Version: 1 | Generated on: 2026-05-05 10:43:42

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`sales_offtake_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic offtake agreement performance metrics tracking contracted volumes, pricing mechanisms, and life-of-mine alignment for long-term customer commitments"
  source: "`mining_ecm`.`sales`.`offtake_agreement`"
  dimensions:
    - name: "agreement_number"
      expr: agreement_number
      comment: "Unique offtake agreement identifier"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of offtake agreement (e.g., fixed-price, index-linked, take-or-pay)"
    - name: "offtake_agreement_status"
      expr: offtake_agreement_status
      comment: "Current status of the agreement (active, expired, under negotiation)"
    - name: "pricing_mechanism"
      expr: pricing_mechanism
      comment: "Pricing mechanism used (e.g., spot, benchmark-linked, fixed)"
    - name: "delivery_basis"
      expr: delivery_basis
      comment: "Delivery terms (FOB, CIF, CFR, etc.)"
    - name: "destination_port"
      expr: destination_port
      comment: "Destination port for shipments"
    - name: "loading_port"
      expr: loading_port
      comment: "Loading port for shipments"
    - name: "governing_law"
      expr: governing_law
      comment: "Legal jurisdiction governing the agreement"
    - name: "lom_alignment_flag"
      expr: lom_alignment_flag
      comment: "Whether agreement is aligned with life-of-mine production plan"
    - name: "agreement_year"
      expr: YEAR(effective_date)
      comment: "Year the agreement became effective"
    - name: "agreement_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the agreement became effective"
  measures:
    - name: "total_contracted_volume_tonnes"
      expr: SUM(CAST(contracted_volume_tonnes AS DOUBLE))
      comment: "Total contracted volume across all agreements in tonnes"
    - name: "total_annual_volume_tonnes"
      expr: SUM(CAST(annual_volume_tonnes AS DOUBLE))
      comment: "Total annual committed volume across agreements in tonnes"
    - name: "weighted_avg_base_price_usd_per_tonne"
      expr: SUM(CAST(base_price_usd_per_tonne AS DOUBLE) * CAST(contracted_volume_tonnes AS DOUBLE)) / NULLIF(SUM(CAST(contracted_volume_tonnes AS DOUBLE)), 0)
      comment: "Volume-weighted average base price per tonne across agreements"
    - name: "avg_tenure_years"
      expr: AVG(CAST(tenure_years AS DOUBLE))
      comment: "Average tenure of agreements in years"
    - name: "total_agreement_count"
      expr: COUNT(DISTINCT offtake_agreement_id)
      comment: "Total number of distinct offtake agreements"
    - name: "active_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN offtake_agreement_status = 'Active' THEN offtake_agreement_id END)
      comment: "Number of active offtake agreements"
    - name: "lom_aligned_volume_tonnes"
      expr: SUM(CASE WHEN lom_alignment_flag = True THEN CAST(contracted_volume_tonnes AS DOUBLE) ELSE 0 END)
      comment: "Total contracted volume aligned with life-of-mine plans"
    - name: "avg_minimum_shipment_size_tonnes"
      expr: AVG(CAST(minimum_shipment_size_tonnes AS DOUBLE))
      comment: "Average minimum shipment size across agreements"
    - name: "avg_maximum_shipment_size_tonnes"
      expr: AVG(CAST(maximum_shipment_size_tonnes AS DOUBLE))
      comment: "Average maximum shipment size across agreements"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`sales_cargo_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational shipment execution metrics tracking loading efficiency, demurrage costs, and documentary compliance for physical cargo movements"
  source: "`mining_ecm`.`sales`.`cargo_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (loading, in-transit, discharged, etc.)"
    - name: "port_of_loading_code"
      expr: port_of_loading_code
      comment: "Code for the loading port"
    - name: "port_of_discharge_code"
      expr: port_of_discharge_code
      comment: "Code for the discharge port"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the shipping carrier"
    - name: "terminal_name"
      expr: terminal_name
      comment: "Name of the loading terminal"
    - name: "documentary_credit_compliant_flag"
      expr: documentary_credit_compliant_flag
      comment: "Whether shipment documentation is compliant with letter of credit terms"
    - name: "loading_month"
      expr: DATE_TRUNC('MONTH', loading_commenced_timestamp)
      comment: "Month when loading commenced"
    - name: "loading_year"
      expr: YEAR(loading_commenced_timestamp)
      comment: "Year when loading commenced"
    - name: "bl_issue_month"
      expr: DATE_TRUNC('MONTH', bl_issue_date)
      comment: "Month when bill of lading was issued"
  measures:
    - name: "total_shipped_quantity_wmt"
      expr: SUM(CAST(shipped_quantity_wmt AS DOUBLE))
      comment: "Total shipped quantity in wet metric tonnes"
    - name: "total_net_dry_weight_dmt"
      expr: SUM(CAST(net_dry_weight_dmt AS DOUBLE))
      comment: "Total net dry weight in dry metric tonnes"
    - name: "total_invoice_value_usd"
      expr: SUM(CAST(invoice_value_usd AS DOUBLE))
      comment: "Total invoice value across shipments in USD"
    - name: "total_demurrage_amount_usd"
      expr: SUM(CAST(demurrage_amount_usd AS DOUBLE))
      comment: "Total demurrage costs incurred in USD"
    - name: "total_despatch_amount_usd"
      expr: SUM(CAST(despatch_amount_usd AS DOUBLE))
      comment: "Total despatch earnings in USD"
    - name: "net_laytime_performance_usd"
      expr: SUM((CAST(despatch_amount_usd AS DOUBLE)) - (CAST(demurrage_amount_usd AS DOUBLE)))
      comment: "Net laytime performance (despatch minus demurrage) in USD"
    - name: "avg_laytime_utilization_pct"
      expr: 100.0 * AVG(CAST(laytime_used_hours AS DOUBLE) / NULLIF(CAST(laytime_allowed_hours AS DOUBLE), 0))
      comment: "Average laytime utilization as percentage of allowed hours"
    - name: "avg_moisture_content_percent"
      expr: AVG(CAST(moisture_content_percent AS DOUBLE))
      comment: "Average moisture content across shipments"
    - name: "total_insurance_cost_usd"
      expr: SUM(CAST(insurance_cost_usd AS DOUBLE))
      comment: "Total insurance costs in USD"
    - name: "total_shipment_count"
      expr: COUNT(DISTINCT cargo_shipment_id)
      comment: "Total number of distinct cargo shipments"
    - name: "documentary_compliant_shipment_count"
      expr: COUNT(DISTINCT CASE WHEN documentary_credit_compliant_flag = True THEN cargo_shipment_id END)
      comment: "Number of shipments compliant with documentary credit terms"
    - name: "avg_loading_duration_hours"
      expr: AVG((UNIX_TIMESTAMP(loading_completed_timestamp) - UNIX_TIMESTAMP(loading_commenced_timestamp)) / 3600.0)
      comment: "Average loading duration in hours"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`sales_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition and pricing settlement metrics tracking provisional vs final pricing, quotational period adjustments, and payment performance"
  source: "`mining_ecm`.`sales`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (draft, issued, paid, disputed)"
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Status of price adjustments (pending, finalized, disputed)"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms (FOB, CIF, CFR, etc.)"
    - name: "price_currency"
      expr: price_currency
      comment: "Currency of pricing"
    - name: "quality_specification"
      expr: quality_specification
      comment: "Quality specification reference"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month when invoice was issued"
    - name: "invoice_year"
      expr: YEAR(issue_date)
      comment: "Year when invoice was issued"
    - name: "settlement_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month when pricing was settled"
    - name: "quotational_period_month"
      expr: DATE_TRUNC('MONTH', quotational_period_start)
      comment: "Month of quotational period start"
  measures:
    - name: "total_invoice_value"
      expr: SUM(CAST(total_invoice_value AS DOUBLE))
      comment: "Total invoice value across all invoices"
    - name: "total_invoiced_quantity"
      expr: SUM(CAST(invoiced_quantity AS DOUBLE))
      comment: "Total invoiced quantity across all invoices"
    - name: "total_adjustment_value"
      expr: SUM(CAST(adjustment_value AS DOUBLE))
      comment: "Total value of price adjustments (provisional to final)"
    - name: "avg_provisional_price"
      expr: AVG(CAST(provisional_price AS DOUBLE))
      comment: "Average provisional price per unit"
    - name: "avg_final_price"
      expr: AVG(CAST(final_price AS DOUBLE))
      comment: "Average final settled price per unit"
    - name: "avg_price_adjustment_per_unit"
      expr: AVG(CAST(final_price AS DOUBLE) - CAST(provisional_price AS DOUBLE))
      comment: "Average price adjustment per unit (final minus provisional)"
    - name: "total_invoice_count"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Total number of distinct invoices"
    - name: "finalized_invoice_count"
      expr: COUNT(DISTINCT CASE WHEN adjustment_status = 'Finalized' THEN invoice_id END)
      comment: "Number of invoices with finalized pricing"
    - name: "weighted_avg_realized_price"
      expr: SUM(CAST(total_invoice_value AS DOUBLE)) / NULLIF(SUM(CAST(invoiced_quantity AS DOUBLE)), 0)
      comment: "Volume-weighted average realized price per unit"
    - name: "total_adjustment_quantity"
      expr: SUM(CAST(adjustment_quantity AS DOUBLE))
      comment: "Total quantity subject to adjustments"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`sales_revenue_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic revenue planning metrics tracking forecast accuracy, LOM alignment, and price-volume scenario analysis for mine planning integration"
  source: "`mining_ecm`.`sales`.`revenue_forecast`"
  dimensions:
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (budget, rolling, scenario, LOM)"
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast (draft, approved, superseded)"
    - name: "forecast_confidence_level"
      expr: forecast_confidence_level
      comment: "Confidence level of the forecast (high, medium, low)"
    - name: "pricing_mechanism"
      expr: pricing_mechanism
      comment: "Pricing mechanism assumed in forecast"
    - name: "product_grade"
      expr: product_grade
      comment: "Product grade forecasted"
    - name: "shipment_destination_region"
      expr: shipment_destination_region
      comment: "Destination region for shipments"
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterm basis for revenue forecast"
    - name: "lom_production_alignment_flag"
      expr: lom_production_alignment_flag
      comment: "Whether forecast is aligned with life-of-mine production plan"
    - name: "board_reporting_flag"
      expr: board_reporting_flag
      comment: "Whether forecast is used for board reporting"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the forecast"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the forecast"
    - name: "forecast_period_month"
      expr: DATE_TRUNC('MONTH', forecast_period_start_date)
      comment: "Month of forecast period start"
  measures:
    - name: "total_estimated_revenue_amount"
      expr: SUM(CAST(estimated_revenue_amount AS DOUBLE))
      comment: "Total estimated revenue across all forecasts"
    - name: "total_forecast_volume_tonnes"
      expr: SUM(CAST(forecast_volume_tonnes AS DOUBLE))
      comment: "Total forecasted volume in tonnes"
    - name: "weighted_avg_assumed_benchmark_price"
      expr: SUM(CAST(assumed_benchmark_price AS DOUBLE) * CAST(forecast_volume_tonnes AS DOUBLE)) / NULLIF(SUM(CAST(forecast_volume_tonnes AS DOUBLE)), 0)
      comment: "Volume-weighted average assumed benchmark price"
    - name: "total_risk_adjustment_amount"
      expr: SUM(CAST(risk_adjustment_amount AS DOUBLE))
      comment: "Total risk adjustments applied to forecasts"
    - name: "avg_price_adjustment_factor"
      expr: AVG(CAST(price_adjustment_factor AS DOUBLE))
      comment: "Average price adjustment factor applied"
    - name: "total_variance_to_prior_forecast_amount"
      expr: SUM(CAST(variance_to_prior_forecast_amount AS DOUBLE))
      comment: "Total variance to prior forecast in absolute amount"
    - name: "avg_variance_to_prior_forecast_pct"
      expr: AVG(CAST(variance_to_prior_forecast_percentage AS DOUBLE))
      comment: "Average variance to prior forecast as percentage"
    - name: "total_forecast_count"
      expr: COUNT(DISTINCT revenue_forecast_id)
      comment: "Total number of distinct revenue forecasts"
    - name: "approved_forecast_count"
      expr: COUNT(DISTINCT CASE WHEN forecast_status = 'Approved' THEN revenue_forecast_id END)
      comment: "Number of approved forecasts"
    - name: "lom_aligned_revenue_amount"
      expr: SUM(CASE WHEN lom_production_alignment_flag = True THEN CAST(estimated_revenue_amount AS DOUBLE) ELSE 0 END)
      comment: "Total estimated revenue aligned with life-of-mine plans"
    - name: "board_reporting_revenue_amount"
      expr: SUM(CASE WHEN board_reporting_flag = True THEN CAST(estimated_revenue_amount AS DOUBLE) ELSE 0 END)
      comment: "Total estimated revenue used for board reporting"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`sales_performance_actual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales performance variance analysis metrics comparing actual vs planned revenue, volume, and pricing to drive operational accountability and forecast accuracy improvement"
  source: "`mining_ecm`.`sales`.`performance_actual`"
  dimensions:
    - name: "performance_status"
      expr: performance_status
      comment: "Status of the performance record (draft, posted, closed)"
    - name: "delivery_basis"
      expr: delivery_basis
      comment: "Delivery basis for the actual performance"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country code"
    - name: "target_market"
      expr: target_market
      comment: "Target market for sales"
    - name: "lom_forecast_alignment_flag"
      expr: lom_forecast_alignment_flag
      comment: "Whether actuals are aligned with life-of-mine forecast"
    - name: "period_year"
      expr: period_year
      comment: "Year of the performance period"
    - name: "period_quarter"
      expr: period_quarter
      comment: "Quarter of the performance period"
    - name: "period_month"
      expr: period_month
      comment: "Month of the performance period"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month when performance was posted"
  measures:
    - name: "total_actual_revenue_amount"
      expr: SUM(CAST(actual_revenue_amount AS DOUBLE))
      comment: "Total actual revenue achieved"
    - name: "total_planned_revenue_amount"
      expr: SUM(CAST(planned_revenue_amount AS DOUBLE))
      comment: "Total planned revenue"
    - name: "total_revenue_variance_amount"
      expr: SUM(CAST(revenue_variance_amount AS DOUBLE))
      comment: "Total revenue variance (actual minus planned)"
    - name: "total_actual_volume_tonnes"
      expr: SUM(CAST(actual_volume_tonnes AS DOUBLE))
      comment: "Total actual volume sold in tonnes"
    - name: "total_planned_volume_tonnes"
      expr: SUM(CAST(planned_volume_tonnes AS DOUBLE))
      comment: "Total planned volume in tonnes"
    - name: "total_volume_variance_tonnes"
      expr: SUM(CAST(volume_variance_tonnes AS DOUBLE))
      comment: "Total volume variance in tonnes (actual minus planned)"
    - name: "weighted_avg_realised_price_per_tonne"
      expr: SUM(CAST(actual_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(actual_volume_tonnes AS DOUBLE)), 0)
      comment: "Volume-weighted average realized price per tonne"
    - name: "weighted_avg_benchmark_price_per_tonne"
      expr: SUM(CAST(benchmark_price_per_tonne AS DOUBLE) * CAST(actual_volume_tonnes AS DOUBLE)) / NULLIF(SUM(CAST(actual_volume_tonnes AS DOUBLE)), 0)
      comment: "Volume-weighted average benchmark price per tonne"
    - name: "total_margin_amount"
      expr: SUM(CAST(total_margin_amount AS DOUBLE))
      comment: "Total margin achieved"
    - name: "avg_margin_per_tonne"
      expr: AVG(CAST(margin_per_tonne AS DOUBLE))
      comment: "Average margin per tonne"
    - name: "avg_aisc_per_tonne"
      expr: AVG(CAST(aisc_per_tonne AS DOUBLE))
      comment: "Average all-in sustaining cost per tonne"
    - name: "avg_revenue_variance_pct"
      expr: AVG(CAST(revenue_variance_percentage AS DOUBLE))
      comment: "Average revenue variance as percentage"
    - name: "avg_volume_variance_pct"
      expr: AVG(CAST(volume_variance_percentage AS DOUBLE))
      comment: "Average volume variance as percentage"
    - name: "avg_price_variance_per_tonne"
      expr: AVG(CAST(price_variance_per_tonne AS DOUBLE))
      comment: "Average price variance per tonne"
    - name: "total_performance_record_count"
      expr: COUNT(DISTINCT performance_actual_id)
      comment: "Total number of distinct performance records"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`sales_demurrage_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laytime performance and demurrage cost management metrics tracking port efficiency, claim settlement, and net-back impact on realized pricing"
  source: "`mining_ecm`.`sales`.`demurrage_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Status of the demurrage claim (raised, agreed, settled, disputed)"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (demurrage, despatch, combined)"
    - name: "port_of_loading"
      expr: port_of_loading
      comment: "Port where loading occurred"
    - name: "port_code"
      expr: port_code
      comment: "Port code"
    - name: "commodity_type"
      expr: commodity_type
      comment: "Type of commodity shipped"
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterm for the shipment"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the claim is disputed"
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for the demurrage (shipper, receiver, carrier)"
    - name: "claim_raised_month"
      expr: DATE_TRUNC('MONTH', claim_raised_date)
      comment: "Month when claim was raised"
    - name: "claim_settled_month"
      expr: DATE_TRUNC('MONTH', claim_settled_date)
      comment: "Month when claim was settled"
  measures:
    - name: "total_claim_amount_usd"
      expr: SUM(CAST(claim_amount_usd AS DOUBLE))
      comment: "Total demurrage claim amount in USD"
    - name: "total_net_back_impact_usd"
      expr: SUM(CAST(net_back_impact_usd AS DOUBLE))
      comment: "Total net-back impact on realized pricing in USD"
    - name: "total_cargo_quantity_tonnes"
      expr: SUM(CAST(cargo_quantity_tonnes AS DOUBLE))
      comment: "Total cargo quantity subject to claims in tonnes"
    - name: "avg_demurrage_rate_usd_per_day"
      expr: AVG(CAST(demurrage_rate_usd_per_day AS DOUBLE))
      comment: "Average demurrage rate per day in USD"
    - name: "avg_despatch_rate_usd_per_day"
      expr: AVG(CAST(despatch_rate_usd_per_day AS DOUBLE))
      comment: "Average despatch rate per day in USD"
    - name: "avg_laytime_variance_hours"
      expr: AVG(CAST(laytime_variance_hours AS DOUBLE))
      comment: "Average laytime variance in hours (used minus allowed)"
    - name: "avg_laytime_utilization_pct"
      expr: 100.0 * AVG(CAST(laytime_used_hours AS DOUBLE) / NULLIF(CAST(laytime_allowed_hours AS DOUBLE), 0))
      comment: "Average laytime utilization as percentage of allowed hours"
    - name: "total_claim_count"
      expr: COUNT(DISTINCT demurrage_claim_id)
      comment: "Total number of distinct demurrage claims"
    - name: "settled_claim_count"
      expr: COUNT(DISTINCT CASE WHEN claim_status = 'Settled' THEN demurrage_claim_id END)
      comment: "Number of settled claims"
    - name: "disputed_claim_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_flag = True THEN demurrage_claim_id END)
      comment: "Number of disputed claims"
    - name: "avg_net_back_impact_per_tonne"
      expr: SUM(CAST(net_back_impact_usd AS DOUBLE)) / NULLIF(SUM(CAST(cargo_quantity_tonnes AS DOUBLE)), 0)
      comment: "Average net-back impact per tonne in USD"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`sales_quality_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product quality assurance and penalty management metrics tracking specification compliance, price adjustments, and dispute resolution for contractual quality terms"
  source: "`mining_ecm`.`sales`.`quality_certificate`"
  dimensions:
    - name: "certificate_status"
      expr: certificate_status
      comment: "Status of the quality certificate (issued, disputed, superseded)"
    - name: "certificate_type"
      expr: certificate_type
      comment: "Type of certificate (final, provisional, independent)"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the certificate is disputed"
    - name: "issuing_laboratory_name"
      expr: issuing_laboratory_name
      comment: "Name of the laboratory that issued the certificate"
    - name: "sampling_method"
      expr: sampling_method
      comment: "Method used for sampling"
    - name: "loading_port"
      expr: loading_port
      comment: "Port where cargo was loaded"
    - name: "discharge_port"
      expr: discharge_port
      comment: "Port where cargo was discharged"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month when certificate was issued"
    - name: "analysis_month"
      expr: DATE_TRUNC('MONTH', analysis_date)
      comment: "Month when analysis was performed"
  measures:
    - name: "total_shipment_quantity_tonnes"
      expr: SUM(CAST(shipment_quantity_tonnes AS DOUBLE))
      comment: "Total shipment quantity certified in tonnes"
    - name: "total_penalty_deduction_amount"
      expr: SUM(CAST(penalty_deduction_amount AS DOUBLE))
      comment: "Total penalty deductions applied for quality non-compliance"
    - name: "avg_iron_content_percent"
      expr: AVG(CAST(iron_content_percent AS DOUBLE))
      comment: "Average iron content percentage"
    - name: "avg_silica_content_percent"
      expr: AVG(CAST(silica_content_percent AS DOUBLE))
      comment: "Average silica content percentage"
    - name: "avg_alumina_content_percent"
      expr: AVG(CAST(alumina_content_percent AS DOUBLE))
      comment: "Average alumina content percentage"
    - name: "avg_phosphorus_content_percent"
      expr: AVG(CAST(phosphorus_content_percent AS DOUBLE))
      comment: "Average phosphorus content percentage"
    - name: "avg_sulfur_content_percent"
      expr: AVG(CAST(sulfur_content_percent AS DOUBLE))
      comment: "Average sulfur content percentage"
    - name: "avg_moisture_content_percent"
      expr: AVG(CAST(moisture_content_percent AS DOUBLE))
      comment: "Average moisture content percentage"
    - name: "avg_loss_on_ignition_percent"
      expr: AVG(CAST(loss_on_ignition_percent AS DOUBLE))
      comment: "Average loss on ignition percentage"
    - name: "avg_price_adjustment_factor"
      expr: AVG(CAST(price_adjustment_factor AS DOUBLE))
      comment: "Average price adjustment factor applied for quality"
    - name: "total_certificate_count"
      expr: COUNT(DISTINCT quality_certificate_id)
      comment: "Total number of distinct quality certificates"
    - name: "disputed_certificate_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_flag = True THEN quality_certificate_id END)
      comment: "Number of disputed quality certificates"
    - name: "avg_penalty_per_tonne"
      expr: SUM(CAST(penalty_deduction_amount AS DOUBLE)) / NULLIF(SUM(CAST(shipment_quantity_tonnes AS DOUBLE)), 0)
      comment: "Average penalty deduction per tonne"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`sales_spot_trade`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spot market trading performance metrics tracking opportunistic sales, broker involvement, and pricing basis for non-contracted volumes"
  source: "`mining_ecm`.`sales`.`spot_trade`"
  dimensions:
    - name: "trade_status"
      expr: trade_status
      comment: "Status of the spot trade (executed, pending, cancelled)"
    - name: "pricing_basis"
      expr: pricing_basis
      comment: "Pricing basis for the trade (spot index, negotiated, auction)"
    - name: "delivery_terms"
      expr: delivery_terms
      comment: "Delivery terms (FOB, CIF, CFR, etc.)"
    - name: "delivery_location"
      expr: delivery_location
      comment: "Delivery location"
    - name: "broker_involved"
      expr: broker_involved
      comment: "Whether a broker was involved in the trade"
    - name: "broker_name"
      expr: broker_name
      comment: "Name of the broker (if involved)"
    - name: "quality_specification"
      expr: quality_specification
      comment: "Quality specification for the trade"
    - name: "trade_month"
      expr: DATE_TRUNC('MONTH', trade_date)
      comment: "Month when trade was executed"
    - name: "trade_year"
      expr: YEAR(trade_date)
      comment: "Year when trade was executed"
    - name: "settlement_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month when trade was settled"
  measures:
    - name: "total_trade_value"
      expr: SUM(CAST(total_trade_value AS DOUBLE))
      comment: "Total value of spot trades"
    - name: "total_trade_volume_tonnes"
      expr: SUM(CAST(trade_volume_tonnes AS DOUBLE))
      comment: "Total volume of spot trades in tonnes"
    - name: "weighted_avg_agreed_price_per_tonne"
      expr: SUM(CAST(total_trade_value AS DOUBLE)) / NULLIF(SUM(CAST(trade_volume_tonnes AS DOUBLE)), 0)
      comment: "Volume-weighted average agreed price per tonne"
    - name: "avg_broker_commission_rate"
      expr: AVG(CAST(broker_commission_rate AS DOUBLE))
      comment: "Average broker commission rate"
    - name: "total_trade_count"
      expr: COUNT(DISTINCT spot_trade_id)
      comment: "Total number of distinct spot trades"
    - name: "executed_trade_count"
      expr: COUNT(DISTINCT CASE WHEN trade_status = 'Executed' THEN spot_trade_id END)
      comment: "Number of executed spot trades"
    - name: "broker_involved_trade_count"
      expr: COUNT(DISTINCT CASE WHEN broker_involved = True THEN spot_trade_id END)
      comment: "Number of trades involving a broker"
    - name: "broker_involved_volume_tonnes"
      expr: SUM(CASE WHEN broker_involved = True THEN CAST(trade_volume_tonnes AS DOUBLE) ELSE 0 END)
      comment: "Total volume of trades involving a broker in tonnes"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`sales_benchmark_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market pricing intelligence metrics tracking commodity benchmark indices, volatility, and quotational period conventions for pricing mechanism design"
  source: "`mining_ecm`.`sales`.`benchmark_price`"
  dimensions:
    - name: "commodity"
      expr: commodity
      comment: "Commodity type"
    - name: "commodity_grade"
      expr: commodity_grade
      comment: "Grade of the commodity"
    - name: "price_type"
      expr: price_type
      comment: "Type of price (spot, forward, settlement)"
    - name: "index_status"
      expr: index_status
      comment: "Status of the price index (active, discontinued)"
    - name: "delivery_basis"
      expr: delivery_basis
      comment: "Delivery basis for the price"
    - name: "delivery_location"
      expr: delivery_location
      comment: "Delivery location for the price"
    - name: "assessment_methodology"
      expr: assessment_methodology
      comment: "Methodology used for price assessment"
    - name: "publication_frequency"
      expr: publication_frequency
      comment: "Frequency of price publication (daily, weekly, monthly)"
    - name: "quotational_period_convention"
      expr: quotational_period_convention
      comment: "Convention for quotational period (M+1, M+2, etc.)"
    - name: "price_month"
      expr: DATE_TRUNC('MONTH', price_date)
      comment: "Month of the price observation"
    - name: "price_year"
      expr: YEAR(price_date)
      comment: "Year of the price observation"
  measures:
    - name: "avg_price_value"
      expr: AVG(CAST(price_value AS DOUBLE))
      comment: "Average benchmark price value"
    - name: "max_price_high"
      expr: MAX(CAST(price_high AS DOUBLE))
      comment: "Maximum high price observed"
    - name: "min_price_low"
      expr: MIN(CAST(price_low AS DOUBLE))
      comment: "Minimum low price observed"
    - name: "avg_price_open"
      expr: AVG(CAST(price_open AS DOUBLE))
      comment: "Average opening price"
    - name: "avg_price_close"
      expr: AVG(CAST(price_close AS DOUBLE))
      comment: "Average closing price"
    - name: "total_volume_traded"
      expr: SUM(CAST(volume_traded AS DOUBLE))
      comment: "Total volume traded at benchmark prices"
    - name: "price_volatility_range"
      expr: AVG(CAST(price_high AS DOUBLE) - CAST(price_low AS DOUBLE))
      comment: "Average daily price volatility (high minus low)"
    - name: "total_price_observation_count"
      expr: COUNT(DISTINCT benchmark_price_id)
      comment: "Total number of distinct price observations"
$$;