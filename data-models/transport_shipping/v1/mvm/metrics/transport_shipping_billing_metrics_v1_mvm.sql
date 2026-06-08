-- Metric views for domain: billing | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 22:31:03

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice metrics tracking revenue, outstanding balances, payment performance, and invoice lifecycle KPIs for financial steering and cash flow management"
  source: "`transport_shipping_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., draft, sent, paid, overdue, disputed)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., standard, credit, debit, proforma)"
    - name: "service_line"
      expr: service_line
      comment: "Service line or business unit generating the invoice"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice is denominated"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month when the invoice was issued"
    - name: "invoice_quarter"
      expr: DATE_TRUNC('QUARTER', invoice_date)
      comment: "Quarter when the invoice was issued"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year when the invoice was issued"
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Month of the billing period start"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (e.g., wire transfer, credit card, ACH)"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the invoice (e.g., email, portal, mail)"
    - name: "revenue_recognition_status"
      expr: revenue_recognition_status
      comment: "Status of revenue recognition for the invoice"
    - name: "is_disputed"
      expr: CASE WHEN dispute_date IS NOT NULL THEN TRUE ELSE FALSE END
      comment: "Flag indicating whether the invoice has been disputed"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices issued"
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total invoiced amount across all invoices (gross revenue)"
    - name: "total_outstanding_amount"
      expr: SUM(CAST(amount_outstanding AS DOUBLE))
      comment: "Total amount outstanding across all invoices (accounts receivable)"
    - name: "total_paid_amount"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount paid across all invoices"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected across all invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied across all invoices"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount applied to invoices (credits, debits, corrections)"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice amount per invoice"
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount_paid AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced amount that has been collected (payment effectiveness)"
    - name: "outstanding_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount_outstanding AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced amount that remains outstanding (AR exposure)"
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_date IS NOT NULL THEN 1 END)
      comment: "Number of invoices that have been disputed"
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices that have been disputed (quality indicator)"
    - name: "avg_days_to_payment"
      expr: AVG(DATEDIFF(payment_received_date, invoice_date))
      comment: "Average number of days from invoice date to payment received date (cash conversion cycle)"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed invoice line-item metrics for revenue analysis by charge type, service, and profitability dimensions"
  source: "`transport_shipping_ecm`.`billing`.`billing_invoice_line`"
  dimensions:
    - name: "charge_category"
      expr: charge_category
      comment: "Category of the charge (e.g., freight, accessorial, surcharge, tax)"
    - name: "revenue_type"
      expr: revenue_type
      comment: "Type of revenue (e.g., service revenue, accessorial revenue, fuel surcharge)"
    - name: "service_code"
      expr: service_code
      comment: "Code identifying the service provided"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the line item is denominated"
    - name: "audit_status"
      expr: audit_status
      comment: "Audit status of the line item (e.g., pending, approved, rejected)"
    - name: "is_billable"
      expr: billable_flag
      comment: "Flag indicating whether the line item is billable to the customer"
    - name: "is_disputed"
      expr: dispute_flag
      comment: "Flag indicating whether the line item is under dispute"
    - name: "is_chargeback"
      expr: chargeback_flag
      comment: "Flag indicating whether the line item is a chargeback"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month when the service was provided"
    - name: "revenue_recognition_month"
      expr: DATE_TRUNC('MONTH', revenue_recognition_date)
      comment: "Month when revenue is recognized"
    - name: "origin_location_code"
      expr: origin_location_code
      comment: "Origin location code for the service"
    - name: "destination_location_code"
      expr: destination_location_code
      comment: "Destination location code for the service"
    - name: "surcharge_type"
      expr: surcharge_type
      comment: "Type of surcharge applied (e.g., fuel, peak season, remote area)"
  measures:
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total number of invoice line items"
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total line amount before discounts and taxes"
    - name: "total_line_total"
      expr: SUM(CAST(line_total AS DOUBLE))
      comment: "Total line amount after discounts and taxes (net revenue)"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to line items"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on line items"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of units billed"
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate across line items"
    - name: "avg_line_amount"
      expr: AVG(CAST(line_amount AS DOUBLE))
      comment: "Average line amount per line item"
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(line_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of line amount discounted (pricing effectiveness)"
    - name: "disputed_line_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of line items under dispute"
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of line items disputed (billing quality indicator)"
    - name: "chargeback_count"
      expr: COUNT(CASE WHEN chargeback_flag = TRUE THEN 1 END)
      comment: "Number of chargeback line items"
    - name: "chargeback_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN chargeback_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of line items that are chargebacks (service quality indicator)"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment performance metrics tracking cash collection, payment methods, reconciliation efficiency, and working capital KPIs"
  source: "`transport_shipping_ecm`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., pending, cleared, failed, reversed)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (e.g., wire transfer, credit card, ACH, check)"
    - name: "channel"
      expr: channel
      comment: "Channel through which payment was received (e.g., online portal, bank, manual)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the payment was made"
    - name: "clearing_status"
      expr: clearing_status
      comment: "Clearing status of the payment in the financial system"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the payment against invoices"
    - name: "is_disputed"
      expr: is_disputed
      comment: "Flag indicating whether the payment is disputed"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month when the payment was made"
    - name: "payment_quarter"
      expr: DATE_TRUNC('QUARTER', payment_date)
      comment: "Quarter when the payment was made"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year when the payment was made"
    - name: "business_unit_code"
      expr: business_unit_code
      comment: "Business unit receiving the payment"
    - name: "is_early_payment"
      expr: CASE WHEN early_payment_discount_amount > 0 THEN TRUE ELSE FALSE END
      comment: "Flag indicating whether early payment discount was applied"
  measures:
    - name: "total_payment_count"
      expr: COUNT(1)
      comment: "Total number of payments received"
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total payment amount received (cash inflow)"
    - name: "total_base_currency_amount"
      expr: SUM(CAST(base_currency_amount AS DOUBLE))
      comment: "Total payment amount in base currency (normalized cash inflow)"
    - name: "total_bank_charges"
      expr: SUM(CAST(bank_charges AS DOUBLE))
      comment: "Total bank charges incurred on payments"
    - name: "total_early_payment_discount"
      expr: SUM(CAST(early_payment_discount_amount AS DOUBLE))
      comment: "Total early payment discount given (cost of accelerating cash)"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from payments"
    - name: "total_unapplied_balance"
      expr: SUM(CAST(unapplied_balance AS DOUBLE))
      comment: "Total payment amount not yet allocated to invoices (cash application backlog)"
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction"
    - name: "early_payment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN early_payment_discount_amount > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that received early payment discount (cash acceleration effectiveness)"
    - name: "disputed_payment_count"
      expr: COUNT(CASE WHEN is_disputed = TRUE THEN 1 END)
      comment: "Number of disputed payments"
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_disputed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments disputed (payment quality indicator)"
    - name: "avg_days_to_clearing"
      expr: AVG(DATEDIFF(clearing_date, payment_date))
      comment: "Average number of days from payment date to clearing date (cash availability lag)"
    - name: "avg_days_to_reconciliation"
      expr: AVG(DATEDIFF(reconciliation_date, payment_date))
      comment: "Average number of days from payment date to reconciliation (cash application efficiency)"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`billing_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable aging and collection performance metrics for working capital management and credit risk steering"
  source: "`transport_shipping_ecm`.`billing`.`receivable`"
  dimensions:
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket of the receivable (e.g., current, 1-30 days, 31-60 days, 61-90 days, over 90 days)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the receivable is denominated"
    - name: "company_code"
      expr: company_code
      comment: "Company code for the receivable"
    - name: "business_area"
      expr: business_area
      comment: "Business area or division for the receivable"
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning level applied to the receivable (escalation stage)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the receivable"
    - name: "write_off_status"
      expr: write_off_status
      comment: "Write-off status of the receivable"
    - name: "is_disputed"
      expr: dispute_hold_flag
      comment: "Flag indicating whether the receivable is on dispute hold"
    - name: "is_collection_agency_referred"
      expr: collection_agency_referral_flag
      comment: "Flag indicating whether the receivable has been referred to a collection agency"
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month of the receivable snapshot"
    - name: "snapshot_quarter"
      expr: DATE_TRUNC('QUARTER', snapshot_date)
      comment: "Quarter of the receivable snapshot"
    - name: "snapshot_year"
      expr: YEAR(snapshot_date)
      comment: "Year of the receivable snapshot"
  measures:
    - name: "total_receivable_count"
      expr: COUNT(1)
      comment: "Total number of receivable records"
    - name: "total_ar_balance"
      expr: SUM(CAST(ar_balance_amount AS DOUBLE))
      comment: "Total accounts receivable balance (working capital tied up)"
    - name: "total_current_amount"
      expr: SUM(CAST(current_amount AS DOUBLE))
      comment: "Total current receivable amount (not yet due)"
    - name: "total_days_1_30_amount"
      expr: SUM(CAST(days_1_30_amount AS DOUBLE))
      comment: "Total receivable amount aged 1-30 days past due"
    - name: "total_days_31_60_amount"
      expr: SUM(CAST(days_31_60_amount AS DOUBLE))
      comment: "Total receivable amount aged 31-60 days past due"
    - name: "total_days_61_90_amount"
      expr: SUM(CAST(days_61_90_amount AS DOUBLE))
      comment: "Total receivable amount aged 61-90 days past due"
    - name: "total_days_over_90_amount"
      expr: SUM(CAST(days_over_90_amount AS DOUBLE))
      comment: "Total receivable amount aged over 90 days past due (high credit risk)"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total receivable amount under dispute"
    - name: "total_bad_debt_provision"
      expr: SUM(CAST(bad_debt_provision_amount AS DOUBLE))
      comment: "Total bad debt provision amount (expected credit loss)"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total receivable amount written off (realized credit loss)"
    - name: "avg_ar_balance"
      expr: AVG(CAST(ar_balance_amount AS DOUBLE))
      comment: "Average accounts receivable balance per account"
    - name: "past_due_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(days_1_30_amount AS DOUBLE)) + SUM(CAST(days_31_60_amount AS DOUBLE)) + SUM(CAST(days_61_90_amount AS DOUBLE)) + SUM(CAST(days_over_90_amount AS DOUBLE))) / NULLIF(SUM(CAST(ar_balance_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of AR balance that is past due (collection risk indicator)"
    - name: "high_risk_ar_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(days_over_90_amount AS DOUBLE)) / NULLIF(SUM(CAST(ar_balance_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of AR balance aged over 90 days (high credit risk exposure)"
    - name: "bad_debt_provision_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(bad_debt_provision_amount AS DOUBLE)) / NULLIF(SUM(CAST(ar_balance_amount AS DOUBLE)), 0), 2)
      comment: "Bad debt provision as percentage of AR balance (expected loss rate)"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`billing_carrier_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier payable and cost metrics for freight spend analysis, supplier payment performance, and margin management"
  source: "`transport_shipping_ecm`.`billing`.`carrier_payable`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the carrier payable (e.g., pending, approved, paid, disputed)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to pay the carrier"
    - name: "service_type"
      expr: service_type
      comment: "Type of service provided by the carrier"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the payable is denominated"
    - name: "origin_location_code"
      expr: origin_location_code
      comment: "Origin location code for the shipment"
    - name: "destination_location_code"
      expr: destination_location_code
      comment: "Destination location code for the shipment"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month when the carrier invoice was received"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_start_date)
      comment: "Month when the service was provided"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month when the payment was made"
    - name: "is_disputed"
      expr: CASE WHEN dispute_date IS NOT NULL THEN TRUE ELSE FALSE END
      comment: "Flag indicating whether the payable is under dispute"
  measures:
    - name: "total_payable_count"
      expr: COUNT(1)
      comment: "Total number of carrier payable records"
    - name: "total_payable_amount"
      expr: SUM(CAST(payable_amount AS DOUBLE))
      comment: "Total carrier payable amount (freight cost)"
    - name: "total_net_payable_amount"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net payable amount after discounts and adjustments"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount received from carriers"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on carrier payables"
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight in kilograms"
    - name: "total_actual_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total actual weight in kilograms"
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volume in cubic meters"
    - name: "avg_payable_amount"
      expr: AVG(CAST(payable_amount AS DOUBLE))
      comment: "Average payable amount per carrier invoice"
    - name: "avg_cost_per_kg"
      expr: AVG(CAST(payable_amount AS DOUBLE) / NULLIF(CAST(chargeable_weight_kg AS DOUBLE), 0))
      comment: "Average cost per kilogram of chargeable weight (unit freight cost)"
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(payable_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of payable amount discounted (procurement effectiveness)"
    - name: "disputed_payable_count"
      expr: COUNT(CASE WHEN dispute_date IS NOT NULL THEN 1 END)
      comment: "Number of carrier payables under dispute"
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carrier payables disputed (carrier billing quality indicator)"
    - name: "avg_days_to_payment"
      expr: AVG(DATEDIFF(payment_date, invoice_date))
      comment: "Average number of days from carrier invoice date to payment date (payment cycle time)"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing dispute metrics tracking dispute volume, resolution performance, financial impact, and root cause analysis for quality improvement"
  source: "`transport_shipping_ecm`.`billing`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g., open, in review, resolved, closed)"
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of dispute (e.g., pricing, service failure, billing error, documentation)"
    - name: "dispute_category"
      expr: dispute_category
      comment: "Category of the dispute for classification"
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution applied (e.g., credit issued, invoice corrected, no action)"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code for the dispute"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the dispute (e.g., low, medium, high, critical)"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the dispute"
    - name: "service_failure_type"
      expr: service_failure_type
      comment: "Type of service failure that led to the dispute"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the disputed amount is denominated"
    - name: "raised_month"
      expr: DATE_TRUNC('MONTH', raised_date)
      comment: "Month when the dispute was raised"
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month when the dispute was resolved"
    - name: "is_sla_breach"
      expr: sla_breach_flag
      comment: "Flag indicating whether the dispute resolution breached SLA"
    - name: "origin_location_code"
      expr: origin_location_code
      comment: "Origin location code for the disputed shipment"
    - name: "destination_location_code"
      expr: destination_location_code
      comment: "Destination location code for the disputed shipment"
  measures:
    - name: "total_dispute_count"
      expr: COUNT(1)
      comment: "Total number of disputes raised"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute (revenue at risk)"
    - name: "total_resolution_amount"
      expr: SUM(CAST(resolution_amount AS DOUBLE))
      comment: "Total amount resolved (credits, adjustments, write-offs)"
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per dispute"
    - name: "avg_resolution_amount"
      expr: AVG(CAST(resolution_amount AS DOUBLE))
      comment: "Average resolution amount per dispute"
    - name: "resolution_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(resolution_amount AS DOUBLE)) / NULLIF(SUM(CAST(disputed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of disputed amount that was resolved in favor of customer (dispute cost rate)"
    - name: "resolved_dispute_count"
      expr: COUNT(CASE WHEN resolution_date IS NOT NULL THEN 1 END)
      comment: "Number of disputes that have been resolved"
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of disputes that breached resolution SLA"
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes that breached resolution SLA (dispute handling quality)"
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(resolution_date, raised_date))
      comment: "Average number of days from dispute raised to resolution (dispute cycle time)"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`billing_freight_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight audit metrics tracking invoice accuracy, cost variance, savings captured, and audit efficiency for cost control and supplier performance management"
  source: "`transport_shipping_ecm`.`billing`.`freight_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Status of the freight audit (e.g., pending, in progress, completed, closed)"
    - name: "finding_type"
      expr: finding_type
      comment: "Type of audit finding (e.g., overcharge, undercharge, rate mismatch, weight discrepancy)"
    - name: "resolution_action"
      expr: resolution_action
      comment: "Action taken to resolve the audit finding"
    - name: "service_type"
      expr: service_type
      comment: "Type of service audited"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the audit amounts are denominated"
    - name: "origin_location_code"
      expr: origin_location_code
      comment: "Origin location code for the audited shipment"
    - name: "destination_location_code"
      expr: destination_location_code
      comment: "Destination location code for the audited shipment"
    - name: "shipment_month"
      expr: DATE_TRUNC('MONTH', shipment_date)
      comment: "Month when the shipment occurred"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month when the carrier invoice was received"
    - name: "is_sla_breach"
      expr: sla_breach_flag
      comment: "Flag indicating whether the audit identified an SLA breach"
  measures:
    - name: "total_audit_count"
      expr: COUNT(1)
      comment: "Total number of freight audits performed"
    - name: "total_carrier_invoiced_amount"
      expr: SUM(CAST(carrier_invoiced_amount AS DOUBLE))
      comment: "Total amount invoiced by carriers (pre-audit cost)"
    - name: "total_contracted_rate_amount"
      expr: SUM(CAST(contracted_rate_amount AS DOUBLE))
      comment: "Total amount based on contracted rates (expected cost)"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between invoiced and contracted amounts (audit findings)"
    - name: "total_savings_captured"
      expr: SUM(CAST(savings_captured_amount AS DOUBLE))
      comment: "Total savings captured through freight audit (cost avoidance)"
    - name: "total_accessorial_charges"
      expr: SUM(CAST(accessorial_charges_amount AS DOUBLE))
      comment: "Total accessorial charges audited"
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharge audited"
    - name: "total_weight_contracted_kg"
      expr: SUM(CAST(weight_contracted_kg AS DOUBLE))
      comment: "Total contracted weight in kilograms"
    - name: "total_weight_invoiced_kg"
      expr: SUM(CAST(weight_invoiced_kg AS DOUBLE))
      comment: "Total invoiced weight in kilograms"
    - name: "total_weight_variance_kg"
      expr: SUM(CAST(weight_variance_kg AS DOUBLE))
      comment: "Total weight variance in kilograms (weight discrepancy)"
    - name: "avg_variance_amount"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average variance amount per audit"
    - name: "variance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(carrier_invoiced_amount AS DOUBLE)), 0), 2)
      comment: "Percentage variance between invoiced and contracted amounts (carrier billing accuracy)"
    - name: "savings_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(savings_captured_amount AS DOUBLE)) / NULLIF(SUM(CAST(carrier_invoiced_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced amount saved through audit (audit ROI)"
    - name: "audit_with_findings_count"
      expr: COUNT(CASE WHEN variance_amount != 0 THEN 1 END)
      comment: "Number of audits that identified variances"
    - name: "finding_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN variance_amount != 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits that identified variances (audit hit rate)"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`billing_credit_note`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit note metrics tracking revenue reversals, credit issuance patterns, and application performance for revenue integrity and customer satisfaction management"
  source: "`transport_shipping_ecm`.`billing`.`credit_note`"
  dimensions:
    - name: "credit_type"
      expr: credit_type
      comment: "Type of credit note (e.g., service failure, billing error, goodwill, promotional)"
    - name: "credit_reason_code"
      expr: credit_reason_code
      comment: "Reason code for the credit note issuance"
    - name: "application_status"
      expr: application_status
      comment: "Application status of the credit note (e.g., pending, applied, expired)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the credit note"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the credit note is denominated"
    - name: "service_line"
      expr: service_line
      comment: "Service line for which the credit note was issued"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit issuing the credit note"
    - name: "is_automated"
      expr: is_automated
      comment: "Flag indicating whether the credit note was issued automatically"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month when the credit note was issued"
    - name: "issue_quarter"
      expr: DATE_TRUNC('QUARTER', issue_date)
      comment: "Quarter when the credit note was issued"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year when the credit note was issued"
    - name: "revenue_reversal_period"
      expr: revenue_reversal_period
      comment: "Period in which revenue was reversed"
  measures:
    - name: "total_credit_note_count"
      expr: COUNT(1)
      comment: "Total number of credit notes issued"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount issued (revenue reversal)"
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total credit amount applied to invoices"
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total remaining credit balance not yet applied"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on credit notes"
    - name: "total_credit_amount_incl_tax"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit amount including tax"
    - name: "avg_credit_amount"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit amount per credit note"
    - name: "application_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(credit_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of credit amount that has been applied (credit utilization rate)"
    - name: "automated_credit_note_count"
      expr: COUNT(CASE WHEN is_automated = TRUE THEN 1 END)
      comment: "Number of credit notes issued automatically"
    - name: "automation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_automated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credit notes issued automatically (process efficiency)"
$$;