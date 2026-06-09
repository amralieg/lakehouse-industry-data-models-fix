-- Metric views for domain: sales | Business: Automotive | Version: 1 | Generated on: 2026-05-07 02:15:05

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`sales_vehicle_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core sales order metrics tracking revenue, volume, and order fulfillment performance across channels, territories, and vehicle configurations"
  source: "`automotive_ecm`.`sales`.`vehicle_order`"
  dimensions:
    - name: "order_date"
      expr: order_date
      comment: "Date the vehicle order was placed"
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Year the order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the order was placed"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the vehicle order"
    - name: "order_type"
      expr: order_type
      comment: "Type of order (retail, fleet, etc.)"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Channel through which the order was placed"
    - name: "financing_type"
      expr: financing_type
      comment: "Type of financing used for the order"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type of the ordered vehicle (ICE, hybrid, electric)"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the ordered vehicle"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the order"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the order was transacted"
    - name: "delivery_location"
      expr: delivery_location
      comment: "Location where the vehicle will be delivered"
    - name: "actual_delivery_date"
      expr: actual_delivery_date
      comment: "Actual date the vehicle was delivered"
    - name: "requested_delivery_date"
      expr: requested_delivery_date
      comment: "Customer requested delivery date"
  measures:
    - name: "total_order_count"
      expr: COUNT(1)
      comment: "Total number of vehicle orders"
    - name: "total_order_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total revenue from all vehicle orders including tax"
    - name: "total_selling_price"
      expr: SUM(CAST(selling_price AS DOUBLE))
      comment: "Total selling price of all vehicles before tax"
    - name: "total_msrp"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total manufacturer suggested retail price across all orders"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount given across all orders"
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive amount applied across all orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across all orders"
    - name: "total_trade_in_value"
      expr: SUM(CAST(trade_in_value AS DOUBLE))
      comment: "Total trade-in value accepted across all orders"
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average order value per vehicle order"
    - name: "avg_selling_price"
      expr: AVG(CAST(selling_price AS DOUBLE))
      comment: "Average selling price per vehicle"
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per order"
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(msrp AS DOUBLE)), 0), 2)
      comment: "Percentage discount rate off MSRP"
    - name: "incentive_rate"
      expr: ROUND(100.0 * SUM(CAST(incentive_amount AS DOUBLE)) / NULLIF(SUM(CAST(msrp AS DOUBLE)), 0), 2)
      comment: "Percentage incentive rate off MSRP"
    - name: "unique_customers"
      expr: COUNT(DISTINCT primary_vehicle_customer_party_id)
      comment: "Number of unique customers who placed orders"
    - name: "unique_dealerships"
      expr: COUNT(DISTINCT dealership_id)
      comment: "Number of unique dealerships processing orders"
    - name: "unique_sales_reps"
      expr: COUNT(DISTINCT primary_vehicle_rep_id)
      comment: "Number of unique sales representatives handling orders"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales pipeline and opportunity conversion metrics tracking deal progression, win rates, and sales effectiveness"
  source: "`automotive_ecm`.`sales`.`opportunity`"
  dimensions:
    - name: "sales_stage"
      expr: sales_stage
      comment: "Current stage of the sales opportunity"
    - name: "opportunity_type"
      expr: opportunity_type
      comment: "Type of sales opportunity"
    - name: "lead_source"
      expr: lead_source
      comment: "Source from which the opportunity originated"
    - name: "financing_type"
      expr: financing_type
      comment: "Type of financing the customer is considering"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type of interest"
    - name: "model_year"
      expr: model_year
      comment: "Model year of vehicle in opportunity"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the opportunity"
    - name: "region"
      expr: region
      comment: "Geographic region of the opportunity"
    - name: "priority"
      expr: priority
      comment: "Priority level of the opportunity"
    - name: "is_won"
      expr: is_won
      comment: "Whether the opportunity was won"
    - name: "is_active"
      expr: is_active
      comment: "Whether the opportunity is currently active"
    - name: "expected_close_month"
      expr: DATE_TRUNC('MONTH', expected_close_date)
      comment: "Expected month of opportunity closure"
    - name: "actual_close_month"
      expr: DATE_TRUNC('MONTH', actual_close_date)
      comment: "Actual month of opportunity closure"
    - name: "test_drive_completed"
      expr: test_drive_completed
      comment: "Whether a test drive was completed"
    - name: "quote_generated"
      expr: quote_generated
      comment: "Whether a quote was generated for the opportunity"
  measures:
    - name: "total_opportunity_count"
      expr: COUNT(1)
      comment: "Total number of sales opportunities"
    - name: "total_pipeline_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all opportunities in pipeline"
    - name: "weighted_pipeline_value"
      expr: SUM(CAST(estimated_value AS DOUBLE) * CAST(probability AS DOUBLE) / 100.0)
      comment: "Pipeline value weighted by win probability"
    - name: "avg_opportunity_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated value per opportunity"
    - name: "avg_win_probability"
      expr: AVG(CAST(probability AS DOUBLE))
      comment: "Average win probability across all opportunities"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount across opportunities"
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive amount across opportunities"
    - name: "total_trade_in_value"
      expr: SUM(CAST(trade_in_value AS DOUBLE))
      comment: "Total trade-in value across opportunities"
    - name: "won_opportunity_count"
      expr: SUM(CASE WHEN is_won = TRUE THEN 1 ELSE 0 END)
      comment: "Number of opportunities that were won"
    - name: "active_opportunity_count"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Number of currently active opportunities"
    - name: "test_drive_completed_count"
      expr: SUM(CASE WHEN test_drive_completed = TRUE THEN 1 ELSE 0 END)
      comment: "Number of opportunities with completed test drives"
    - name: "quote_generated_count"
      expr: SUM(CASE WHEN quote_generated = TRUE THEN 1 ELSE 0 END)
      comment: "Number of opportunities with generated quotes"
    - name: "unique_customers"
      expr: COUNT(DISTINCT opportunity_customer_party_id)
      comment: "Number of unique customers with opportunities"
    - name: "unique_sales_reps"
      expr: COUNT(DISTINCT opportunity_rep_id)
      comment: "Number of unique sales reps managing opportunities"
    - name: "unique_dealerships"
      expr: COUNT(DISTINCT dealership_id)
      comment: "Number of unique dealerships with opportunities"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`sales_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead generation and conversion metrics tracking lead quality, source effectiveness, and conversion funnel performance"
  source: "`automotive_ecm`.`sales`.`lead`"
  dimensions:
    - name: "lead_status"
      expr: lead_status
      comment: "Current status of the lead"
    - name: "lead_type"
      expr: lead_type
      comment: "Type of lead"
    - name: "lead_source"
      expr: lead_source
      comment: "Source from which the lead originated"
    - name: "vehicle_interest_category"
      expr: vehicle_interest_category
      comment: "Category of vehicle the lead is interested in"
    - name: "model_year_interest"
      expr: model_year_interest
      comment: "Model year of interest to the lead"
    - name: "purchase_timeframe"
      expr: purchase_timeframe
      comment: "Expected timeframe for purchase"
    - name: "rating"
      expr: rating
      comment: "Lead quality rating"
    - name: "region"
      expr: region
      comment: "Geographic region of the lead"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the lead"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the lead was created"
    - name: "converted_month"
      expr: DATE_TRUNC('MONTH', converted_date)
      comment: "Month the lead was converted"
    - name: "financing_interest"
      expr: financing_interest
      comment: "Whether the lead expressed financing interest"
    - name: "trade_in_interest"
      expr: trade_in_interest
      comment: "Whether the lead expressed trade-in interest"
    - name: "test_drive_requested"
      expr: test_drive_requested
      comment: "Whether the lead requested a test drive"
  measures:
    - name: "total_lead_count"
      expr: COUNT(1)
      comment: "Total number of leads"
    - name: "converted_lead_count"
      expr: COUNT(DISTINCT CASE WHEN converted_date IS NOT NULL THEN lead_id END)
      comment: "Number of leads that converted to opportunities"
    - name: "total_estimated_budget"
      expr: SUM(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Total estimated budget across all leads"
    - name: "avg_estimated_budget"
      expr: AVG(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Average estimated budget per lead"
    - name: "financing_interest_count"
      expr: SUM(CASE WHEN financing_interest = TRUE THEN 1 ELSE 0 END)
      comment: "Number of leads interested in financing"
    - name: "trade_in_interest_count"
      expr: SUM(CASE WHEN trade_in_interest = TRUE THEN 1 ELSE 0 END)
      comment: "Number of leads interested in trade-in"
    - name: "test_drive_requested_count"
      expr: SUM(CASE WHEN test_drive_requested = TRUE THEN 1 ELSE 0 END)
      comment: "Number of leads requesting test drives"
    - name: "opt_in_email_count"
      expr: SUM(CASE WHEN opt_in_email = TRUE THEN 1 ELSE 0 END)
      comment: "Number of leads opted in for email communication"
    - name: "opt_in_phone_count"
      expr: SUM(CASE WHEN opt_in_phone = TRUE THEN 1 ELSE 0 END)
      comment: "Number of leads opted in for phone communication"
    - name: "opt_in_sms_count"
      expr: SUM(CASE WHEN opt_in_sms = TRUE THEN 1 ELSE 0 END)
      comment: "Number of leads opted in for SMS communication"
    - name: "unique_assigned_dealerships"
      expr: COUNT(DISTINCT lead_assigned_dealer_dealership_id)
      comment: "Number of unique dealerships assigned to leads"
    - name: "unique_assigned_reps"
      expr: COUNT(DISTINCT lead_assigned_owner_rep_id)
      comment: "Number of unique sales reps assigned to leads"
    - name: "unique_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of unique campaigns generating leads"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote generation and conversion metrics tracking pricing effectiveness, quote-to-order conversion, and deal structuring performance"
  source: "`automotive_ecm`.`sales`.`quote`"
  dimensions:
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of the quote"
    - name: "quote_type"
      expr: quote_type
      comment: "Type of quote"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel for the quote"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type quoted"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the quoted vehicle"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the quote"
    - name: "quote_month"
      expr: DATE_TRUNC('MONTH', quote_date)
      comment: "Month the quote was generated"
    - name: "converted_to_order"
      expr: converted_to_order
      comment: "Whether the quote was converted to an order"
    - name: "financing_offered"
      expr: financing_offered
      comment: "Whether financing was offered in the quote"
    - name: "lease_offered"
      expr: lease_offered
      comment: "Whether lease was offered in the quote"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method specified in quote"
    - name: "drivetrain"
      expr: drivetrain
      comment: "Drivetrain configuration quoted"
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission type quoted"
  measures:
    - name: "total_quote_count"
      expr: COUNT(1)
      comment: "Total number of quotes generated"
    - name: "converted_quote_count"
      expr: SUM(CASE WHEN converted_to_order = TRUE THEN 1 ELSE 0 END)
      comment: "Number of quotes converted to orders"
    - name: "total_quote_value"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total value of all quotes including tax"
    - name: "total_net_selling_price"
      expr: SUM(CAST(net_selling_price AS DOUBLE))
      comment: "Total net selling price across all quotes"
    - name: "total_msrp_base"
      expr: SUM(CAST(msrp_base AS DOUBLE))
      comment: "Total base MSRP across all quotes"
    - name: "total_accessories"
      expr: SUM(CAST(accessories_total AS DOUBLE))
      comment: "Total accessories value across all quotes"
    - name: "total_options"
      expr: SUM(CAST(options_total AS DOUBLE))
      comment: "Total options value across all quotes"
    - name: "total_incentives"
      expr: SUM(CAST(incentive_total AS DOUBLE))
      comment: "Total incentives offered across all quotes"
    - name: "total_trade_in_allowance"
      expr: SUM(CAST(trade_in_allowance AS DOUBLE))
      comment: "Total trade-in allowance across all quotes"
    - name: "total_down_payment"
      expr: SUM(CAST(down_payment AS DOUBLE))
      comment: "Total down payment across all quotes"
    - name: "avg_quote_value"
      expr: AVG(CAST(total_amount_due AS DOUBLE))
      comment: "Average quote value"
    - name: "avg_net_selling_price"
      expr: AVG(CAST(net_selling_price AS DOUBLE))
      comment: "Average net selling price per quote"
    - name: "avg_monthly_payment"
      expr: AVG(CAST(monthly_payment AS DOUBLE))
      comment: "Average monthly payment across financing quotes"
    - name: "avg_lease_monthly_payment"
      expr: AVG(CAST(lease_monthly_payment AS DOUBLE))
      comment: "Average monthly lease payment across lease quotes"
    - name: "avg_apr_rate"
      expr: AVG(CAST(apr_rate AS DOUBLE))
      comment: "Average APR rate across financing quotes"
    - name: "financing_offered_count"
      expr: SUM(CASE WHEN financing_offered = TRUE THEN 1 ELSE 0 END)
      comment: "Number of quotes with financing offered"
    - name: "lease_offered_count"
      expr: SUM(CASE WHEN lease_offered = TRUE THEN 1 ELSE 0 END)
      comment: "Number of quotes with lease offered"
    - name: "unique_customers"
      expr: COUNT(DISTINCT quote_customer_party_id)
      comment: "Number of unique customers receiving quotes"
    - name: "unique_dealerships"
      expr: COUNT(DISTINCT quote_dealership_id)
      comment: "Number of unique dealerships generating quotes"
    - name: "unique_sales_reps"
      expr: COUNT(DISTINCT rep_id)
      comment: "Number of unique sales reps generating quotes"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`sales_fleet_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet sales contract metrics tracking large-volume commercial deals, contract value, and fleet customer performance"
  source: "`automotive_ecm`.`sales`.`fleet_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the fleet contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of fleet contract"
    - name: "financing_type"
      expr: financing_type
      comment: "Financing type for the fleet contract"
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region of the fleet contract"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract"
    - name: "government_contract_flag"
      expr: government_contract_flag
      comment: "Whether this is a government contract"
    - name: "national_fleet_account_flag"
      expr: national_fleet_account_flag
      comment: "Whether this is a national fleet account"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the contract auto-renews"
    - name: "maintenance_included_flag"
      expr: maintenance_included_flag
      comment: "Whether maintenance is included in the contract"
    - name: "contract_signed_month"
      expr: DATE_TRUNC('MONTH', contract_signed_date)
      comment: "Month the contract was signed"
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the contract became effective"
    - name: "delivery_schedule_type"
      expr: delivery_schedule_type
      comment: "Type of delivery schedule for the fleet"
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of fleet contracts"
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_amount AS DOUBLE))
      comment: "Total value of all fleet contracts"
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value_amount AS DOUBLE))
      comment: "Average value per fleet contract"
    - name: "total_base_discount"
      expr: SUM(CAST(base_discount_percentage AS DOUBLE))
      comment: "Sum of base discount percentages across contracts"
    - name: "avg_base_discount_pct"
      expr: AVG(CAST(base_discount_percentage AS DOUBLE))
      comment: "Average base discount percentage across fleet contracts"
    - name: "total_volume_tier_discount"
      expr: SUM(CAST(volume_tier_discount_percentage AS DOUBLE))
      comment: "Sum of volume tier discount percentages"
    - name: "avg_volume_tier_discount_pct"
      expr: AVG(CAST(volume_tier_discount_percentage AS DOUBLE))
      comment: "Average volume tier discount percentage"
    - name: "government_contract_count"
      expr: SUM(CASE WHEN government_contract_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of government fleet contracts"
    - name: "national_fleet_account_count"
      expr: SUM(CASE WHEN national_fleet_account_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of national fleet account contracts"
    - name: "auto_renewal_contract_count"
      expr: SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of contracts with auto-renewal"
    - name: "maintenance_included_count"
      expr: SUM(CASE WHEN maintenance_included_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of contracts with maintenance included"
    - name: "unique_fleet_customers"
      expr: COUNT(DISTINCT primary_fleet_customer_party_id)
      comment: "Number of unique fleet customers"
    - name: "unique_fleet_reps"
      expr: COUNT(DISTINCT primary_fleet_rep_id)
      comment: "Number of unique fleet sales representatives"
    - name: "unique_opportunities"
      expr: COUNT(DISTINCT opportunity_id)
      comment: "Number of unique opportunities converted to fleet contracts"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`sales_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing campaign performance metrics tracking spend efficiency, ROI, and campaign effectiveness in driving sales volume and market share"
  source: "`automotive_ecm`.`sales`.`campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of marketing campaign"
    - name: "target_customer_segment"
      expr: target_customer_segment
      comment: "Target customer segment for the campaign"
    - name: "region_code"
      expr: region_code
      comment: "Region code where campaign is running"
    - name: "priority"
      expr: priority
      comment: "Priority level of the campaign"
    - name: "dealer_participation_flag"
      expr: dealer_participation_flag
      comment: "Whether dealers are participating in the campaign"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the campaign started"
    - name: "end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the campaign ended"
    - name: "budget_currency"
      expr: budget_currency
      comment: "Currency of the campaign budget"
    - name: "actual_spent_currency"
      expr: actual_spent_currency
      comment: "Currency of actual spend"
  measures:
    - name: "total_campaign_count"
      expr: COUNT(1)
      comment: "Total number of campaigns"
    - name: "total_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated across all campaigns"
    - name: "total_actual_spent"
      expr: SUM(CAST(actual_spent_amount AS DOUBLE))
      comment: "Total actual spend across all campaigns"
    - name: "avg_budget_per_campaign"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per campaign"
    - name: "avg_actual_spent_per_campaign"
      expr: AVG(CAST(actual_spent_amount AS DOUBLE))
      comment: "Average actual spend per campaign"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_spent_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of budget actually spent across campaigns"
    - name: "total_market_share_actual"
      expr: SUM(CAST(kpi_market_share_actual AS DOUBLE))
      comment: "Sum of actual market share KPI across campaigns"
    - name: "total_market_share_target"
      expr: SUM(CAST(kpi_market_share_target AS DOUBLE))
      comment: "Sum of target market share KPI across campaigns"
    - name: "avg_market_share_actual"
      expr: AVG(CAST(kpi_market_share_actual AS DOUBLE))
      comment: "Average actual market share across campaigns"
    - name: "avg_market_share_target"
      expr: AVG(CAST(kpi_market_share_target AS DOUBLE))
      comment: "Average target market share across campaigns"
    - name: "dealer_participation_count"
      expr: SUM(CASE WHEN dealer_participation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of campaigns with dealer participation"
    - name: "unique_sales_territories"
      expr: COUNT(DISTINCT sales_territory_id)
      comment: "Number of unique sales territories covered by campaigns"
    - name: "unique_vehicle_programs"
      expr: COUNT(DISTINCT vehicle_program_id)
      comment: "Number of unique vehicle programs promoted in campaigns"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`sales_quota`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales quota and target attainment metrics tracking sales performance against goals, quota achievement, and territory effectiveness"
  source: "`automotive_ecm`.`sales`.`quota`"
  dimensions:
    - name: "quota_status"
      expr: quota_status
      comment: "Current status of the quota"
    - name: "quota_type"
      expr: quota_type
      comment: "Type of quota (revenue, unit, etc.)"
    - name: "assignee_type"
      expr: assignee_type
      comment: "Type of assignee (rep, team, territory)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the quota"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the quota"
    - name: "fiscal_month"
      expr: fiscal_month
      comment: "Fiscal month of the quota"
    - name: "region_code"
      expr: region_code
      comment: "Region code for the quota"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel for the quota"
    - name: "product_line"
      expr: product_line
      comment: "Product line covered by the quota"
    - name: "vehicle_segment"
      expr: vehicle_segment
      comment: "Vehicle segment covered by the quota"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type covered by the quota"
    - name: "incentive_eligible"
      expr: incentive_eligible
      comment: "Whether the quota is eligible for incentives"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the quota"
  measures:
    - name: "total_quota_count"
      expr: COUNT(1)
      comment: "Total number of quotas"
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Total target value across all quotas"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value per quota"
    - name: "total_threshold_minimum"
      expr: SUM(CAST(threshold_minimum AS DOUBLE))
      comment: "Total minimum threshold across all quotas"
    - name: "total_threshold_stretch"
      expr: SUM(CAST(threshold_stretch AS DOUBLE))
      comment: "Total stretch threshold across all quotas"
    - name: "avg_threshold_minimum"
      expr: AVG(CAST(threshold_minimum AS DOUBLE))
      comment: "Average minimum threshold per quota"
    - name: "avg_threshold_stretch"
      expr: AVG(CAST(threshold_stretch AS DOUBLE))
      comment: "Average stretch threshold per quota"
    - name: "incentive_eligible_count"
      expr: SUM(CASE WHEN incentive_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Number of quotas eligible for incentives"
    - name: "unique_assignees"
      expr: COUNT(DISTINCT assignee_rep_id)
      comment: "Number of unique sales reps assigned quotas"
    - name: "unique_dealerships"
      expr: COUNT(DISTINCT dealership_id)
      comment: "Number of unique dealerships with quotas"
    - name: "unique_sales_territories"
      expr: COUNT(DISTINCT sales_territory_id)
      comment: "Number of unique sales territories with quotas"
    - name: "unique_vehicle_programs"
      expr: COUNT(DISTINCT vehicle_program_id)
      comment: "Number of unique vehicle programs in quotas"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`sales_rep`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales representative performance and capacity metrics tracking rep productivity, quota assignment, and sales force effectiveness"
  source: "`automotive_ecm`.`sales`.`rep`"
  dimensions:
    - name: "active_status"
      expr: active_status
      comment: "Whether the sales rep is currently active"
    - name: "sales_role"
      expr: sales_role
      comment: "Role of the sales representative"
    - name: "region"
      expr: region
      comment: "Geographic region of the sales rep"
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier of the sales rep"
    - name: "product_specialization"
      expr: product_specialization
      comment: "Product specialization of the sales rep"
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status of the sales rep"
    - name: "work_arrangement"
      expr: work_arrangement
      comment: "Work arrangement (remote, office, hybrid)"
    - name: "commission_plan_code"
      expr: commission_plan_code
      comment: "Commission plan code for the rep"
    - name: "quota_period"
      expr: quota_period
      comment: "Quota period for the rep"
    - name: "quota_currency"
      expr: quota_currency
      comment: "Currency of the rep's quota"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for the rep"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month the rep was hired"
    - name: "sales_start_month"
      expr: DATE_TRUNC('MONTH', sales_start_date)
      comment: "Month the rep started in sales"
  measures:
    - name: "total_rep_count"
      expr: COUNT(1)
      comment: "Total number of sales representatives"
    - name: "active_rep_count"
      expr: SUM(CASE WHEN active_status = TRUE THEN 1 ELSE 0 END)
      comment: "Number of active sales representatives"
    - name: "total_quota_amount"
      expr: SUM(CAST(quota_amount AS DOUBLE))
      comment: "Total quota amount across all sales reps"
    - name: "avg_quota_amount"
      expr: AVG(CAST(quota_amount AS DOUBLE))
      comment: "Average quota amount per sales rep"
    - name: "unique_cost_centers"
      expr: COUNT(DISTINCT cost_center_id)
      comment: "Number of unique cost centers employing sales reps"
    - name: "unique_regions"
      expr: COUNT(DISTINCT region)
      comment: "Number of unique regions with sales reps"
    - name: "unique_performance_tiers"
      expr: COUNT(DISTINCT performance_tier)
      comment: "Number of unique performance tiers"
$$;