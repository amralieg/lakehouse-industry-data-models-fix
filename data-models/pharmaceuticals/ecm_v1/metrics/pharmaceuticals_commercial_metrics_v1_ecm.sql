-- Metric views for domain: commercial | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 17:46:18

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`commercial_sales_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core sales order metrics tracking revenue, discounts, and order fulfillment performance"
  source: "`pharmaceuticals_ecm`.`commercial`.`sales_order`"
  dimensions:
    - name: "order_date"
      expr: order_date
      comment: "Date the sales order was placed"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the sales order (e.g., confirmed, shipped, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of sales order (e.g., standard, sample, return)"
    - name: "order_channel"
      expr: order_channel
      comment: "Channel through which the order was placed"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area associated with the order"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the order was transacted"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of order placement for time-series analysis"
    - name: "order_quarter"
      expr: DATE_TRUNC('QUARTER', order_date)
      comment: "Quarter of order placement for time-series analysis"
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Year of order placement for time-series analysis"
    - name: "is_sample_order"
      expr: sample_distribution_flag
      comment: "Flag indicating whether this is a sample distribution order"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of sales orders"
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross revenue before discounts and rebates"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue after all discounts, rebates, and adjustments"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to orders"
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate amount applied to orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected on orders"
    - name: "avg_order_value_gross"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross order value per transaction"
    - name: "avg_order_value_net"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net order value per transaction after discounts and rebates"
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross revenue given as discounts"
    - name: "rebate_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(rebate_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross revenue given as rebates"
    - name: "gross_to_net_ratio"
      expr: ROUND(SUM(CAST(net_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of net revenue to gross revenue, indicating overall revenue realization"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`commercial_sales_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales representative and territory performance metrics tracking quota attainment and market share"
  source: "`pharmaceuticals_ecm`.`commercial`.`sales_performance`"
  dimensions:
    - name: "performance_period_start"
      expr: performance_period_start_date
      comment: "Start date of the performance measurement period"
    - name: "performance_period_end"
      expr: performance_period_end_date
      comment: "End date of the performance measurement period"
    - name: "period_type"
      expr: period_type
      comment: "Type of performance period (e.g., monthly, quarterly, annual)"
    - name: "performance_status"
      expr: performance_status
      comment: "Status of the performance record (e.g., draft, approved, final)"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area for which performance is measured"
    - name: "geography"
      expr: geography
      comment: "Geographic region for performance measurement"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit responsible for the performance"
    - name: "performance_month"
      expr: DATE_TRUNC('MONTH', performance_period_start_date)
      comment: "Month of performance period start for time-series analysis"
    - name: "performance_quarter"
      expr: DATE_TRUNC('QUARTER', performance_period_start_date)
      comment: "Quarter of performance period start for time-series analysis"
    - name: "performance_year"
      expr: YEAR(performance_period_start_date)
      comment: "Year of performance period start for time-series analysis"
  measures:
    - name: "total_performance_records"
      expr: COUNT(1)
      comment: "Total number of sales performance records"
    - name: "total_actual_performance"
      expr: SUM(CAST(actual_performance_amount AS DOUBLE))
      comment: "Total actual sales performance amount achieved"
    - name: "total_quota"
      expr: SUM(CAST(quota_amount AS DOUBLE))
      comment: "Total sales quota assigned across all records"
    - name: "avg_quota_attainment_pct"
      expr: AVG(CAST(quota_attainment_percent AS DOUBLE))
      comment: "Average quota attainment percentage across sales representatives"
    - name: "total_incentive_compensation"
      expr: SUM(CAST(incentive_compensation_amount AS DOUBLE))
      comment: "Total incentive compensation paid for performance"
    - name: "avg_market_share_pct"
      expr: AVG(CAST(market_share_percent AS DOUBLE))
      comment: "Average market share percentage across territories"
    - name: "total_new_prescriptions"
      expr: SUM(CAST(new_prescriptions AS BIGINT))
      comment: "Total number of new prescriptions generated"
    - name: "total_prescriptions"
      expr: SUM(CAST(total_prescriptions AS BIGINT))
      comment: "Total number of prescriptions (new and refill)"
    - name: "avg_call_attainment_pct"
      expr: AVG(CAST(call_attainment_percent AS DOUBLE))
      comment: "Average call frequency attainment percentage"
    - name: "total_sample_units_distributed"
      expr: SUM(CAST(sample_units_distributed AS BIGINT))
      comment: "Total number of sample units distributed to healthcare providers"
    - name: "avg_sample_drop_rate"
      expr: AVG(CAST(sample_drop_rate AS DOUBLE))
      comment: "Average sample drop rate per call"
    - name: "quota_achievement_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_performance_amount AS DOUBLE)) / NULLIF(SUM(CAST(quota_amount AS DOUBLE)), 0), 2)
      comment: "Overall quota achievement rate as percentage of total quota"
    - name: "new_rx_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(new_prescriptions AS BIGINT)) / NULLIF(SUM(CAST(total_prescriptions AS BIGINT)), 0), 2)
      comment: "Percentage of prescriptions that are new (vs refill)"
    - name: "incentive_per_dollar_performance"
      expr: ROUND(SUM(CAST(incentive_compensation_amount AS DOUBLE)) / NULLIF(SUM(CAST(actual_performance_amount AS DOUBLE)), 0), 4)
      comment: "Incentive compensation paid per dollar of performance achieved"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`commercial_call_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Healthcare provider call activity metrics tracking field force engagement effectiveness and compliance"
  source: "`pharmaceuticals_ecm`.`commercial`.`call_activity`"
  dimensions:
    - name: "call_date"
      expr: call_date
      comment: "Date the call was conducted"
    - name: "call_type"
      expr: call_type
      comment: "Type of call (e.g., in-person, virtual, phone)"
    - name: "call_status"
      expr: call_status
      comment: "Status of the call (e.g., completed, cancelled, no-show)"
    - name: "call_outcome"
      expr: call_outcome
      comment: "Outcome of the call (e.g., positive, neutral, negative)"
    - name: "hcp_reaction"
      expr: hcp_reaction
      comment: "Healthcare provider reaction to the call"
    - name: "is_kol"
      expr: kol_flag
      comment: "Flag indicating if the HCP is a key opinion leader"
    - name: "samples_dropped"
      expr: samples_dropped_flag
      comment: "Flag indicating if samples were provided during the call"
    - name: "meal_provided"
      expr: meal_provided_flag
      comment: "Flag indicating if a meal was provided during the call"
    - name: "is_phrma_compliant"
      expr: phrma_code_compliant_flag
      comment: "Flag indicating PhRMA code compliance"
    - name: "is_sunshine_reportable"
      expr: sunshine_act_reportable_flag
      comment: "Flag indicating if the call requires Sunshine Act reporting"
    - name: "off_label_discussion"
      expr: off_label_discussion_flag
      comment: "Flag indicating if off-label use was discussed"
    - name: "call_month"
      expr: DATE_TRUNC('MONTH', call_date)
      comment: "Month of call for time-series analysis"
    - name: "call_quarter"
      expr: DATE_TRUNC('QUARTER', call_date)
      comment: "Quarter of call for time-series analysis"
    - name: "call_year"
      expr: YEAR(call_date)
      comment: "Year of call for time-series analysis"
  measures:
    - name: "total_calls"
      expr: COUNT(1)
      comment: "Total number of call activities conducted"
    - name: "total_meal_cost"
      expr: SUM(CAST(meal_cost_usd AS DOUBLE))
      comment: "Total cost of meals provided during calls"
    - name: "total_transfer_of_value"
      expr: SUM(CAST(transfer_of_value_usd AS DOUBLE))
      comment: "Total transfer of value to healthcare providers"
    - name: "avg_meal_cost"
      expr: AVG(CAST(meal_cost_usd AS DOUBLE))
      comment: "Average cost per meal provided"
    - name: "avg_transfer_of_value"
      expr: AVG(CAST(transfer_of_value_usd AS DOUBLE))
      comment: "Average transfer of value per call"
    - name: "calls_with_samples"
      expr: SUM(CASE WHEN samples_dropped_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of calls where samples were provided"
    - name: "calls_with_meals"
      expr: SUM(CASE WHEN meal_provided_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of calls where meals were provided"
    - name: "kol_calls"
      expr: SUM(CASE WHEN kol_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of calls with key opinion leaders"
    - name: "sunshine_reportable_calls"
      expr: SUM(CASE WHEN sunshine_act_reportable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of calls requiring Sunshine Act reporting"
    - name: "phrma_compliant_calls"
      expr: SUM(CASE WHEN phrma_code_compliant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of calls that are PhRMA code compliant"
    - name: "off_label_discussion_calls"
      expr: SUM(CASE WHEN off_label_discussion_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of calls with off-label discussions"
    - name: "sample_drop_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN samples_dropped_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of calls where samples were dropped"
    - name: "kol_engagement_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN kol_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of calls conducted with key opinion leaders"
    - name: "phrma_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN phrma_code_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of calls that are PhRMA code compliant"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`commercial_copay_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Copay program redemption metrics tracking patient assistance program utilization and financial impact"
  source: "`pharmaceuticals_ecm`.`commercial`.`copay_redemption`"
  dimensions:
    - name: "redemption_date"
      expr: redemption_date
      comment: "Date the copay was redeemed"
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the redemption (e.g., approved, rejected, reversed)"
    - name: "payer_adjudication_status"
      expr: payer_adjudication_status
      comment: "Payer adjudication status for the claim"
    - name: "is_reversal"
      expr: reversal_flag
      comment: "Flag indicating if the redemption was reversed"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the redeemed product"
    - name: "indication"
      expr: indication
      comment: "Medical indication for the prescription"
    - name: "geography"
      expr: geography
      comment: "Geographic location of the redemption"
    - name: "state_province"
      expr: state_province
      comment: "State or province where redemption occurred"
    - name: "pharmacy_chain"
      expr: pharmacy_chain_code
      comment: "Pharmacy chain code where redemption occurred"
    - name: "prescriber_specialty"
      expr: prescriber_specialty
      comment: "Specialty of the prescribing physician"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction"
    - name: "redemption_month"
      expr: DATE_TRUNC('MONTH', redemption_date)
      comment: "Month of redemption for time-series analysis"
    - name: "redemption_quarter"
      expr: DATE_TRUNC('QUARTER', redemption_date)
      comment: "Quarter of redemption for time-series analysis"
    - name: "redemption_year"
      expr: YEAR(redemption_date)
      comment: "Year of redemption for time-series analysis"
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Total number of copay redemptions"
    - name: "total_transaction_amount"
      expr: SUM(CAST(total_transaction_amount AS DOUBLE))
      comment: "Total transaction amount across all redemptions"
    - name: "total_insurance_paid"
      expr: SUM(CAST(insurance_paid_amount AS DOUBLE))
      comment: "Total amount paid by insurance"
    - name: "total_patient_out_of_pocket"
      expr: SUM(CAST(patient_out_of_pocket_amount AS DOUBLE))
      comment: "Total patient out-of-pocket amount before copay assistance"
    - name: "total_retail_price"
      expr: SUM(CAST(retail_price_amount AS DOUBLE))
      comment: "Total retail price of dispensed medications"
    - name: "total_quantity_dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total quantity of medication dispensed"
    - name: "avg_transaction_amount"
      expr: AVG(CAST(total_transaction_amount AS DOUBLE))
      comment: "Average transaction amount per redemption"
    - name: "avg_patient_out_of_pocket"
      expr: AVG(CAST(patient_out_of_pocket_amount AS DOUBLE))
      comment: "Average patient out-of-pocket amount per redemption"
    - name: "avg_retail_price"
      expr: AVG(CAST(retail_price_amount AS DOUBLE))
      comment: "Average retail price per redemption"
    - name: "reversals_count"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of redemptions that were reversed"
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of redemptions that were reversed"
    - name: "insurance_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(insurance_paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(retail_price_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of retail price covered by insurance"
    - name: "patient_cost_share_pct"
      expr: ROUND(100.0 * SUM(CAST(patient_out_of_pocket_amount AS DOUBLE)) / NULLIF(SUM(CAST(retail_price_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of retail price paid out-of-pocket by patient"
    - name: "copay_assistance_value"
      expr: SUM((CAST(retail_price_amount AS DOUBLE)) - (CAST(insurance_paid_amount AS DOUBLE)) - (CAST(patient_out_of_pocket_amount AS DOUBLE)))
      comment: "Total value of copay assistance provided (retail minus insurance minus patient OOP)"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`commercial_incentive_compensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales incentive compensation metrics tracking bonus payouts and performance-based rewards"
  source: "`pharmaceuticals_ecm`.`commercial`.`incentive_compensation`"
  dimensions:
    - name: "calculation_date"
      expr: calculation_date
      comment: "Date the incentive compensation was calculated"
    - name: "payout_date"
      expr: payout_date
      comment: "Date the incentive compensation was paid out"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the incentive compensation"
    - name: "compensation_status"
      expr: compensation_status
      comment: "Overall status of the compensation record"
    - name: "payout_status"
      expr: payout_status
      comment: "Status of the payout (e.g., pending, paid, cancelled)"
    - name: "bonus_tier"
      expr: bonus_tier
      comment: "Tier of bonus achieved based on performance"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit for which compensation is calculated"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the compensation amounts"
    - name: "calculation_month"
      expr: DATE_TRUNC('MONTH', calculation_date)
      comment: "Month of calculation for time-series analysis"
    - name: "calculation_quarter"
      expr: DATE_TRUNC('QUARTER', calculation_date)
      comment: "Quarter of calculation for time-series analysis"
    - name: "calculation_year"
      expr: YEAR(calculation_date)
      comment: "Year of calculation for time-series analysis"
  measures:
    - name: "total_compensation_records"
      expr: COUNT(1)
      comment: "Total number of incentive compensation records"
    - name: "total_base_bonus"
      expr: SUM(CAST(base_bonus_amount AS DOUBLE))
      comment: "Total base bonus amount before accelerators"
    - name: "total_accelerator"
      expr: SUM(CAST(accelerator_amount AS DOUBLE))
      comment: "Total accelerator amount for exceeding targets"
    - name: "total_bonus_payout"
      expr: SUM(CAST(total_bonus_amount AS DOUBLE))
      comment: "Total bonus amount paid out including accelerators"
    - name: "total_adjustment"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount applied to bonuses"
    - name: "total_actual_sales"
      expr: SUM(CAST(actual_sales_amount AS DOUBLE))
      comment: "Total actual sales amount achieved"
    - name: "total_quota"
      expr: SUM(CAST(quota_amount AS DOUBLE))
      comment: "Total sales quota assigned"
    - name: "avg_attainment_pct"
      expr: AVG(CAST(attainment_percentage AS DOUBLE))
      comment: "Average quota attainment percentage across all records"
    - name: "avg_base_bonus"
      expr: AVG(CAST(base_bonus_amount AS DOUBLE))
      comment: "Average base bonus amount per record"
    - name: "avg_total_bonus"
      expr: AVG(CAST(total_bonus_amount AS DOUBLE))
      comment: "Average total bonus amount per record"
    - name: "accelerator_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(accelerator_amount AS DOUBLE)) / NULLIF(SUM(CAST(base_bonus_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of base bonus paid as accelerators"
    - name: "bonus_per_dollar_sales"
      expr: ROUND(SUM(CAST(total_bonus_amount AS DOUBLE)) / NULLIF(SUM(CAST(actual_sales_amount AS DOUBLE)), 0), 4)
      comment: "Bonus payout per dollar of actual sales achieved"
    - name: "quota_achievement_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_sales_amount AS DOUBLE)) / NULLIF(SUM(CAST(quota_amount AS DOUBLE)), 0), 2)
      comment: "Overall quota achievement rate as percentage"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`commercial_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand portfolio metrics tracking lifecycle stage and strategic positioning"
  source: "`pharmaceuticals_ecm`.`commercial`.`brand`"
  dimensions:
    - name: "brand_name"
      expr: brand_name
      comment: "Name of the pharmaceutical brand"
    - name: "brand_status"
      expr: brand_status
      comment: "Current status of the brand (e.g., active, discontinued)"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage of the brand (e.g., launch, growth, mature, decline)"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the brand"
    - name: "indication"
      expr: indication
      comment: "Primary medical indication for the brand"
    - name: "primary_market"
      expr: primary_market
      comment: "Primary geographic market for the brand"
    - name: "is_flagship_brand"
      expr: is_flagship_brand
      comment: "Flag indicating if this is a flagship brand"
    - name: "is_orphan_drug"
      expr: orphan_drug_designation
      comment: "Flag indicating orphan drug designation"
    - name: "requires_rems"
      expr: rems_required
      comment: "Flag indicating if REMS (Risk Evaluation and Mitigation Strategy) is required"
    - name: "is_sample_eligible"
      expr: sample_eligible
      comment: "Flag indicating if brand is eligible for sampling"
    - name: "controlled_substance_schedule"
      expr: controlled_substance_schedule
      comment: "DEA controlled substance schedule if applicable"
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year the brand was launched"
  measures:
    - name: "total_brands"
      expr: COUNT(1)
      comment: "Total number of brands in the portfolio"
    - name: "active_brands"
      expr: SUM(CASE WHEN brand_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of active brands"
    - name: "flagship_brands"
      expr: SUM(CASE WHEN is_flagship_brand = TRUE THEN 1 ELSE 0 END)
      comment: "Number of flagship brands"
    - name: "orphan_drug_brands"
      expr: SUM(CASE WHEN orphan_drug_designation = TRUE THEN 1 ELSE 0 END)
      comment: "Number of brands with orphan drug designation"
    - name: "rems_required_brands"
      expr: SUM(CASE WHEN rems_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of brands requiring REMS programs"
    - name: "sample_eligible_brands"
      expr: SUM(CASE WHEN sample_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Number of brands eligible for sampling"
    - name: "flagship_brand_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_flagship_brand = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of brands that are flagship brands"
    - name: "orphan_drug_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN orphan_drug_designation = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of brands with orphan drug designation"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`commercial_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales territory metrics tracking geographic coverage and market potential"
  source: "`pharmaceuticals_ecm`.`commercial`.`territory`"
  dimensions:
    - name: "territory_name"
      expr: territory_name
      comment: "Name of the sales territory"
    - name: "territory_status"
      expr: territory_status
      comment: "Current status of the territory (e.g., active, inactive)"
    - name: "territory_type"
      expr: territory_type
      comment: "Type of territory (e.g., primary, overlay, specialty)"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area focus of the territory"
    - name: "state_province"
      expr: state_province_code
      comment: "State or province code of the territory"
    - name: "is_open_territory"
      expr: is_open_territory
      comment: "Flag indicating if the territory is currently open (unassigned)"
    - name: "is_specialty_overlay"
      expr: is_specialty_overlay
      comment: "Flag indicating if this is a specialty overlay territory"
    - name: "urban_rural_classification"
      expr: urban_rural_classification
      comment: "Classification of territory as urban, suburban, or rural"
    - name: "decile_rank"
      expr: decile_rank
      comment: "Decile ranking of territory by market potential"
    - name: "alignment_version"
      expr: alignment_version
      comment: "Version of territory alignment"
  measures:
    - name: "total_territories"
      expr: COUNT(1)
      comment: "Total number of sales territories"
    - name: "active_territories"
      expr: SUM(CASE WHEN territory_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of active territories"
    - name: "open_territories"
      expr: SUM(CASE WHEN is_open_territory = TRUE THEN 1 ELSE 0 END)
      comment: "Number of open (unassigned) territories"
    - name: "specialty_overlay_territories"
      expr: SUM(CASE WHEN is_specialty_overlay = TRUE THEN 1 ELSE 0 END)
      comment: "Number of specialty overlay territories"
    - name: "total_geographic_area"
      expr: SUM(CAST(geographic_area_sq_miles AS DOUBLE))
      comment: "Total geographic area covered in square miles"
    - name: "avg_geographic_area"
      expr: AVG(CAST(geographic_area_sq_miles AS DOUBLE))
      comment: "Average geographic area per territory in square miles"
    - name: "avg_market_potential_index"
      expr: AVG(CAST(market_potential_index AS DOUBLE))
      comment: "Average market potential index across territories"
    - name: "avg_workload_index"
      expr: AVG(CAST(workload_index AS DOUBLE))
      comment: "Average workload index across territories"
    - name: "open_territory_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_open_territory = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of territories that are open (unassigned)"
$$;