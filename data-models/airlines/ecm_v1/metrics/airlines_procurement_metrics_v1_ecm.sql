-- Metric views for domain: procurement | Business: Airlines | Version: 1 | Generated on: 2026-05-07 12:47:29

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic procurement KPIs tracking purchase order value, approval efficiency, and order fulfillment performance across procurement categories and vendors"
  source: "`airlines_ecm`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Purchase order status (e.g., draft, approved, sent, closed, cancelled)"
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g., standard, blanket, contract, emergency)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the purchase order"
    - name: "approval_workflow_status"
      expr: approval_workflow_status
      comment: "Current approval workflow state"
    - name: "delivery_station_code"
      expr: delivery_station_code
      comment: "Destination station for delivery"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase order"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms governing delivery and risk"
    - name: "po_year"
      expr: YEAR(po_date)
      comment: "Year of purchase order creation"
    - name: "po_quarter"
      expr: CONCAT('Q', QUARTER(po_date))
      comment: "Quarter of purchase order creation"
    - name: "po_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month of purchase order creation"
  measures:
    - name: "total_po_value"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total purchase order value - primary procurement spend metric"
    - name: "total_po_value_including_tax"
      expr: SUM(CAST(total_po_value_including_tax AS DOUBLE))
      comment: "Total purchase order value including tax - full cost to organization"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across purchase orders"
    - name: "avg_po_value"
      expr: AVG(CAST(total_po_value AS DOUBLE))
      comment: "Average purchase order value - indicates typical order size"
    - name: "purchase_order_count"
      expr: COUNT(DISTINCT purchase_order_id)
      comment: "Number of distinct purchase orders"
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate for currency conversion"
    - name: "cancelled_po_count"
      expr: COUNT(DISTINCT CASE WHEN cancelled_timestamp IS NOT NULL THEN purchase_order_id END)
      comment: "Count of cancelled purchase orders - indicates procurement disruption"
    - name: "closed_po_count"
      expr: COUNT(DISTINCT CASE WHEN closed_timestamp IS NOT NULL THEN purchase_order_id END)
      comment: "Count of closed purchase orders - indicates fulfillment completion"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`procurement_spend_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Comprehensive spend analytics tracking actual procurement expenditure, maverick spend, savings realization, and payment performance across categories and vendors"
  source: "`airlines_ecm`.`procurement`.`spend_record`"
  dimensions:
    - name: "spend_type"
      expr: spend_type
      comment: "Type of spend (e.g., direct, indirect, capital)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the spend record"
    - name: "sourcing_channel"
      expr: sourcing_channel
      comment: "Channel through which procurement was sourced"
    - name: "maverick_spend_flag"
      expr: maverick_spend_flag
      comment: "Indicates if spend was outside approved procurement processes"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the spend"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the spend"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit responsible for the spend"
    - name: "cost_centre_code"
      expr: cost_centre_code
      comment: "Cost center charged for the spend"
    - name: "station_code"
      expr: station_code
      comment: "Station where spend occurred"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the spend transaction"
    - name: "spend_month"
      expr: DATE_TRUNC('MONTH', spend_date)
      comment: "Month of spend occurrence"
  measures:
    - name: "total_spend_amount"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total procurement spend - primary financial metric for procurement performance"
    - name: "total_net_spend_amount"
      expr: SUM(CAST(net_spend_amount AS DOUBLE))
      comment: "Total net spend after discounts - actual cash outflow"
    - name: "total_savings_amount"
      expr: SUM(CAST(savings_amount AS DOUBLE))
      comment: "Total savings realized through procurement initiatives - key value-add metric"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts obtained from vendors"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax paid on procurement spend"
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total spend in local currency for regional analysis"
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate for currency conversion"
    - name: "spend_record_count"
      expr: COUNT(DISTINCT spend_record_id)
      comment: "Number of distinct spend transactions"
    - name: "maverick_spend_amount"
      expr: SUM(CASE WHEN maverick_spend_flag = TRUE THEN CAST(spend_amount AS DOUBLE) ELSE 0 END)
      comment: "Total maverick spend - indicates procurement policy compliance risk"
    - name: "maverick_spend_count"
      expr: COUNT(DISTINCT CASE WHEN maverick_spend_flag = TRUE THEN spend_record_id END)
      comment: "Count of maverick spend transactions - compliance violation frequency"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`procurement_vendor_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance scorecard tracking on-time delivery, quality, invoice accuracy, and AOG response to drive supplier management and contract renewal decisions"
  source: "`airlines_ecm`.`procurement`.`vendor_performance`"
  dimensions:
    - name: "evaluation_period_type"
      expr: evaluation_period_type
      comment: "Type of evaluation period (e.g., monthly, quarterly, annual)"
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier classification of vendor"
    - name: "contract_renewal_eligible_flag"
      expr: contract_renewal_eligible_flag
      comment: "Indicates if vendor is eligible for contract renewal based on performance"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Indicates if corrective action is required from vendor"
    - name: "vendor_development_program_flag"
      expr: vendor_development_program_flag
      comment: "Indicates if vendor is enrolled in development program"
    - name: "trend_versus_prior_period"
      expr: trend_versus_prior_period
      comment: "Performance trend compared to previous period"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for order value metrics"
    - name: "evaluation_year"
      expr: YEAR(evaluation_date)
      comment: "Year of performance evaluation"
    - name: "evaluation_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of performance evaluation"
  measures:
    - name: "avg_overall_performance_score"
      expr: AVG(CAST(overall_performance_score AS DOUBLE))
      comment: "Average overall vendor performance score - primary vendor quality metric"
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate_percent AS DOUBLE))
      comment: "Average on-time delivery rate - critical operational reliability metric"
    - name: "avg_quality_rejection_rate"
      expr: AVG(CAST(quality_rejection_rate_percent AS DOUBLE))
      comment: "Average quality rejection rate - indicates product quality issues"
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate_percent AS DOUBLE))
      comment: "Average invoice accuracy rate - impacts accounts payable efficiency"
    - name: "avg_order_fill_rate"
      expr: AVG(CAST(order_fill_rate_percent AS DOUBLE))
      comment: "Average order fill rate - measures vendor ability to fulfill orders completely"
    - name: "avg_price_compliance_rate"
      expr: AVG(CAST(price_compliance_rate_percent AS DOUBLE))
      comment: "Average price compliance rate - tracks adherence to contracted pricing"
    - name: "avg_aog_response_time_hours"
      expr: AVG(CAST(aog_response_time_hours AS DOUBLE))
      comment: "Average AOG response time in hours - critical for aircraft availability"
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value_amount AS DOUBLE))
      comment: "Total order value evaluated - indicates vendor business volume"
    - name: "vendor_evaluation_count"
      expr: COUNT(DISTINCT vendor_performance_id)
      comment: "Number of vendor performance evaluations conducted"
    - name: "corrective_action_required_count"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_required_flag = TRUE THEN vendor_performance_id END)
      comment: "Count of evaluations requiring corrective action - indicates vendor issues"
    - name: "contract_renewal_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN contract_renewal_eligible_flag = TRUE THEN vendor_performance_id END)
      comment: "Count of vendors eligible for contract renewal - pipeline metric"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`procurement_supply_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract portfolio management tracking total contract value, committed spend, renewal pipeline, and contract lifecycle to optimize supplier relationships and cost management"
  source: "`airlines_ecm`.`procurement`.`supply_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the supply contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of supply contract (e.g., master, framework, spot)"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates if contract auto-renews"
    - name: "sustainability_criteria_flag"
      expr: sustainability_criteria_flag
      comment: "Indicates if contract includes sustainability criteria"
    - name: "confidentiality_clause_flag"
      expr: confidentiality_clause_flag
      comment: "Indicates if contract has confidentiality clause"
    - name: "insurance_requirement_flag"
      expr: insurance_requirement_flag
      comment: "Indicates if contract requires insurance"
    - name: "pricing_mechanism"
      expr: pricing_mechanism
      comment: "Pricing mechanism used in contract (e.g., fixed, variable, indexed)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract"
    - name: "legal_entity_code"
      expr: legal_entity_code
      comment: "Legal entity party to the contract"
    - name: "governing_law_jurisdiction"
      expr: governing_law_jurisdiction
      comment: "Legal jurisdiction governing the contract"
    - name: "contract_year"
      expr: YEAR(effective_start_date)
      comment: "Year contract became effective"
    - name: "contract_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month contract became effective"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all supply contracts - primary contract portfolio metric"
    - name: "total_annual_committed_spend"
      expr: SUM(CAST(annual_committed_spend AS DOUBLE))
      comment: "Total annual committed spend across contracts - budget planning metric"
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value - indicates typical contract size"
    - name: "contract_count"
      expr: COUNT(DISTINCT supply_contract_id)
      comment: "Number of distinct supply contracts"
    - name: "active_contract_count"
      expr: COUNT(DISTINCT CASE WHEN contract_status = 'Active' THEN supply_contract_id END)
      comment: "Count of active contracts - current supplier base size"
    - name: "auto_renewal_contract_count"
      expr: COUNT(DISTINCT CASE WHEN auto_renewal_flag = TRUE THEN supply_contract_id END)
      comment: "Count of auto-renewing contracts - indicates renewal risk exposure"
    - name: "sustainability_contract_count"
      expr: COUNT(DISTINCT CASE WHEN sustainability_criteria_flag = TRUE THEN supply_contract_id END)
      comment: "Count of contracts with sustainability criteria - ESG compliance metric"
    - name: "avg_amendment_count"
      expr: AVG(CAST(amendment_count AS DOUBLE))
      comment: "Average number of amendments per contract - indicates contract stability"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`procurement_sourcing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing effectiveness tracking awarded value, savings achieved, vendor participation, and competitive dynamics to optimize procurement strategy and supplier selection"
  source: "`airlines_ecm`.`procurement`.`sourcing_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Current status of the sourcing event"
    - name: "event_type"
      expr: event_type
      comment: "Type of sourcing event (e.g., RFQ, RFP, auction, tender)"
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Indicates if sourcing event requires approval"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the sourcing event"
    - name: "awarded_currency_code"
      expr: awarded_currency_code
      comment: "Currency of the awarded contract"
    - name: "event_year"
      expr: YEAR(publication_date)
      comment: "Year sourcing event was published"
    - name: "event_quarter"
      expr: CONCAT('Q', QUARTER(publication_date))
      comment: "Quarter sourcing event was published"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', publication_date)
      comment: "Month sourcing event was published"
  measures:
    - name: "total_awarded_value"
      expr: SUM(CAST(awarded_value_amount AS DOUBLE))
      comment: "Total value of awarded contracts - primary sourcing outcome metric"
    - name: "total_baseline_value"
      expr: SUM(CAST(baseline_value_amount AS DOUBLE))
      comment: "Total baseline value before sourcing - comparison benchmark"
    - name: "total_savings_achieved"
      expr: SUM(CAST(savings_achieved_amount AS DOUBLE))
      comment: "Total savings achieved through sourcing events - key value creation metric"
    - name: "avg_savings_percentage"
      expr: AVG(CAST(savings_percentage AS DOUBLE))
      comment: "Average savings percentage achieved - sourcing effectiveness indicator"
    - name: "avg_price_weight"
      expr: AVG(CAST(price_weight_percentage AS DOUBLE))
      comment: "Average price weight in evaluation - indicates price focus"
    - name: "avg_quality_weight"
      expr: AVG(CAST(quality_weight_percentage AS DOUBLE))
      comment: "Average quality weight in evaluation - indicates quality focus"
    - name: "avg_delivery_weight"
      expr: AVG(CAST(delivery_weight_percentage AS DOUBLE))
      comment: "Average delivery weight in evaluation - indicates delivery focus"
    - name: "avg_technical_weight"
      expr: AVG(CAST(technical_weight_percentage AS DOUBLE))
      comment: "Average technical weight in evaluation - indicates technical focus"
    - name: "sourcing_event_count"
      expr: COUNT(DISTINCT sourcing_event_id)
      comment: "Number of distinct sourcing events"
    - name: "awarded_event_count"
      expr: COUNT(DISTINCT CASE WHEN award_date IS NOT NULL THEN sourcing_event_id END)
      comment: "Count of awarded sourcing events - completion rate indicator"
    - name: "avg_vendors_invited"
      expr: AVG(CAST(vendors_invited_count AS DOUBLE))
      comment: "Average number of vendors invited - indicates competitive breadth"
    - name: "avg_responses_received"
      expr: AVG(CAST(responses_received_count AS DOUBLE))
      comment: "Average number of responses received - indicates vendor engagement"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`procurement_fuel_uplift_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel procurement operations tracking actual uplift quantity, cost, variance, and quality compliance to manage fuel spend and operational reliability"
  source: "`airlines_ecm`.`procurement`.`fuel_uplift_order`"
  dimensions:
    - name: "uplift_status"
      expr: uplift_status
      comment: "Status of the fuel uplift order"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel uplifted"
    - name: "station_code"
      expr: station_code
      comment: "Station where fuel was uplifted"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the fuel uplift"
    - name: "quality_check_passed"
      expr: quality_check_passed
      comment: "Indicates if fuel quality check passed"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the fuel transaction"
    - name: "actual_uplift_quantity_unit"
      expr: actual_uplift_quantity_unit
      comment: "Unit of measure for actual uplift quantity"
    - name: "uplift_year"
      expr: YEAR(fueling_start_timestamp)
      comment: "Year of fuel uplift"
    - name: "uplift_month"
      expr: DATE_TRUNC('MONTH', fueling_start_timestamp)
      comment: "Month of fuel uplift"
  measures:
    - name: "total_fuel_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total fuel cost - primary fuel spend metric"
    - name: "total_actual_uplift_quantity"
      expr: SUM(CAST(actual_uplift_quantity AS DOUBLE))
      comment: "Total actual fuel quantity uplifted - operational volume metric"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total ordered fuel quantity - planning baseline"
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total variance between ordered and actual - indicates forecasting accuracy"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average fuel unit price - market price indicator"
    - name: "avg_fuel_density"
      expr: AVG(CAST(fuel_density AS DOUBLE))
      comment: "Average fuel density - quality metric"
    - name: "avg_fuel_temperature"
      expr: AVG(CAST(fuel_temperature_celsius AS DOUBLE))
      comment: "Average fuel temperature at uplift - quality control metric"
    - name: "fuel_uplift_order_count"
      expr: COUNT(DISTINCT fuel_uplift_order_id)
      comment: "Number of distinct fuel uplift orders"
    - name: "quality_check_passed_count"
      expr: COUNT(DISTINCT CASE WHEN quality_check_passed = TRUE THEN fuel_uplift_order_id END)
      comment: "Count of uplifts passing quality check - quality compliance rate"
    - name: "quality_check_failed_count"
      expr: COUNT(DISTINCT CASE WHEN quality_check_passed = FALSE THEN fuel_uplift_order_id END)
      comment: "Count of uplifts failing quality check - quality risk indicator"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`procurement_savings_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement savings program tracking target vs realized savings, initiative status, and validation to measure procurement value creation and cost reduction effectiveness"
  source: "`airlines_ecm`.`procurement`.`savings_initiative`"
  dimensions:
    - name: "initiative_status"
      expr: initiative_status
      comment: "Current status of the savings initiative"
    - name: "initiative_type"
      expr: initiative_type
      comment: "Type of savings initiative (e.g., sourcing, demand management, specification change)"
    - name: "savings_validation_status"
      expr: savings_validation_status
      comment: "Validation status of claimed savings"
    - name: "approval_authority_level"
      expr: approval_authority_level
      comment: "Authority level required for approval"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of savings amounts"
    - name: "cost_center"
      expr: cost_center
      comment: "Cost center benefiting from savings"
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account for savings"
    - name: "initiative_year"
      expr: YEAR(start_date)
      comment: "Year initiative started"
    - name: "initiative_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month initiative started"
  measures:
    - name: "total_target_savings"
      expr: SUM(CAST(target_savings_amount AS DOUBLE))
      comment: "Total target savings amount - planned value creation"
    - name: "total_realized_savings"
      expr: SUM(CAST(realized_savings_amount AS DOUBLE))
      comment: "Total realized savings amount - actual value delivered"
    - name: "total_baseline_spend"
      expr: SUM(CAST(baseline_spend_amount AS DOUBLE))
      comment: "Total baseline spend before initiatives - comparison benchmark"
    - name: "avg_target_savings_percentage"
      expr: AVG(CAST(target_savings_percentage AS DOUBLE))
      comment: "Average target savings percentage - ambition level indicator"
    - name: "savings_initiative_count"
      expr: COUNT(DISTINCT savings_initiative_id)
      comment: "Number of distinct savings initiatives"
    - name: "completed_initiative_count"
      expr: COUNT(DISTINCT CASE WHEN actual_completion_date IS NOT NULL THEN savings_initiative_id END)
      comment: "Count of completed initiatives - delivery rate indicator"
    - name: "validated_initiative_count"
      expr: COUNT(DISTINCT CASE WHEN savings_validation_status = 'Validated' THEN savings_initiative_id END)
      comment: "Count of validated initiatives - quality assurance metric"
    - name: "approved_initiative_count"
      expr: COUNT(DISTINCT CASE WHEN approved_timestamp IS NOT NULL THEN savings_initiative_id END)
      comment: "Count of approved initiatives - governance compliance metric"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`procurement_vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable performance tracking invoice processing, payment timing, three-way match compliance, and dispute resolution to optimize working capital and vendor relationships"
  source: "`airlines_ecm`.`procurement`.`vendor_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the vendor invoice"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., standard, credit note, debit note)"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status (PO, GR, invoice)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment"
    - name: "blocking_reason_code"
      expr: blocking_reason_code
      comment: "Reason code if invoice is blocked"
    - name: "dispute_reason"
      expr: dispute_reason
      comment: "Reason for invoice dispute"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
    - name: "company_code"
      expr: company_code
      comment: "Company code for the invoice"
    - name: "cost_center"
      expr: cost_center
      comment: "Cost center charged"
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year of invoice date"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount - actual payment obligation"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount captured - early payment savings"
    - name: "invoice_count"
      expr: COUNT(DISTINCT vendor_invoice_id)
      comment: "Number of distinct vendor invoices"
    - name: "paid_invoice_count"
      expr: COUNT(DISTINCT CASE WHEN payment_date IS NOT NULL THEN vendor_invoice_id END)
      comment: "Count of paid invoices - payment completion rate"
    - name: "disputed_invoice_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_reason IS NOT NULL THEN vendor_invoice_id END)
      comment: "Count of disputed invoices - indicates invoice quality issues"
    - name: "blocked_invoice_count"
      expr: COUNT(DISTINCT CASE WHEN blocking_reason_code IS NOT NULL THEN vendor_invoice_id END)
      comment: "Count of blocked invoices - payment processing bottleneck indicator"
    - name: "three_way_matched_count"
      expr: COUNT(DISTINCT CASE WHEN three_way_match_status = 'Matched' THEN vendor_invoice_id END)
      comment: "Count of three-way matched invoices - process compliance metric"
    - name: "approved_invoice_count"
      expr: COUNT(DISTINCT CASE WHEN approved_timestamp IS NOT NULL THEN vendor_invoice_id END)
      comment: "Count of approved invoices - approval workflow efficiency"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`procurement_repair_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MRO cost and turnaround tracking repair cost variance, BER decisions, warranty claims, and repair cycle time to optimize maintenance spend and aircraft availability"
  source: "`airlines_ecm`.`procurement`.`repair_order`"
  dimensions:
    - name: "repair_order_status"
      expr: repair_order_status
      comment: "Current status of the repair order"
    - name: "repair_type"
      expr: repair_type
      comment: "Type of repair (e.g., overhaul, repair, exchange)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the repair"
    - name: "ber_flag"
      expr: ber_flag
      comment: "Beyond Economic Repair flag - indicates scrapping decision"
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Indicates if repair is under warranty claim"
    - name: "replacement_part_ordered_flag"
      expr: replacement_part_ordered_flag
      comment: "Indicates if replacement part was ordered"
    - name: "ata_chapter"
      expr: ata_chapter
      comment: "ATA chapter code for component classification"
    - name: "removal_reason_code"
      expr: removal_reason_code
      comment: "Reason code for component removal"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of repair costs"
    - name: "airworthiness_certificate_type"
      expr: airworthiness_certificate_type
      comment: "Type of airworthiness certificate issued"
    - name: "repair_year"
      expr: YEAR(removal_date)
      comment: "Year of component removal"
    - name: "repair_month"
      expr: DATE_TRUNC('MONTH', removal_date)
      comment: "Month of component removal"
  measures:
    - name: "total_repair_cost_actual"
      expr: SUM(CAST(repair_cost_actual AS DOUBLE))
      comment: "Total actual repair cost - primary MRO spend metric"
    - name: "total_repair_cost_quoted"
      expr: SUM(CAST(repair_cost_quoted AS DOUBLE))
      comment: "Total quoted repair cost - budget baseline"
    - name: "avg_repair_cost_actual"
      expr: AVG(CAST(repair_cost_actual AS DOUBLE))
      comment: "Average actual repair cost per order"
    - name: "avg_ber_threshold_value"
      expr: AVG(CAST(ber_threshold_value AS DOUBLE))
      comment: "Average BER threshold value - economic repair limit"
    - name: "repair_order_count"
      expr: COUNT(DISTINCT repair_order_id)
      comment: "Number of distinct repair orders"
    - name: "ber_count"
      expr: COUNT(DISTINCT CASE WHEN ber_flag = TRUE THEN repair_order_id END)
      comment: "Count of BER decisions - indicates uneconomical repairs"
    - name: "warranty_claim_count"
      expr: COUNT(DISTINCT CASE WHEN warranty_claim_flag = TRUE THEN repair_order_id END)
      comment: "Count of warranty claims - vendor quality issue indicator"
    - name: "replacement_ordered_count"
      expr: COUNT(DISTINCT CASE WHEN replacement_part_ordered_flag = TRUE THEN repair_order_id END)
      comment: "Count of replacement parts ordered - indicates irreparable components"
    - name: "completed_repair_count"
      expr: COUNT(DISTINCT CASE WHEN actual_return_date IS NOT NULL THEN repair_order_id END)
      comment: "Count of completed repairs - throughput metric"
$$;