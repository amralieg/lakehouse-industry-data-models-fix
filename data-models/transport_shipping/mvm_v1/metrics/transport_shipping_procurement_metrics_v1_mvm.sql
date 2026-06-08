-- Metric views for domain: procurement | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 22:31:03

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic procurement KPIs tracking purchase order value, approval efficiency, and supplier performance across the organization"
  source: "`transport_shipping_ecm`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order (e.g., draft, approved, closed, cancelled)"
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g., standard, blanket, contract)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the purchase order"
    - name: "procurement_category"
      expr: procurement_category
      comment: "Category of goods or services being procured"
    - name: "expenditure_type"
      expr: expenditure_type
      comment: "Type of expenditure (e.g., CAPEX, OPEX)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the purchase order"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms defining delivery responsibilities"
    - name: "payment_term_code"
      expr: payment_term_code
      comment: "Payment terms code (e.g., Net30, Net60)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the purchase order is denominated"
    - name: "po_year"
      expr: YEAR(po_date)
      comment: "Year the purchase order was created"
    - name: "po_quarter"
      expr: CONCAT('Q', QUARTER(po_date))
      comment: "Quarter the purchase order was created"
    - name: "po_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month the purchase order was created"
  measures:
    - name: "total_po_value"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total value of all purchase orders - primary procurement spend metric"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount before tax across all purchase orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all purchase orders"
    - name: "avg_po_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average purchase order value - indicates typical order size and procurement efficiency"
    - name: "po_count"
      expr: COUNT(DISTINCT purchase_order_id)
      comment: "Number of distinct purchase orders - tracks procurement transaction volume"
    - name: "supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers - measures supplier base diversity and concentration risk"
    - name: "avg_approval_cycle_days"
      expr: AVG(CAST(DATEDIFF(approved_timestamp, created_timestamp) AS DOUBLE))
      comment: "Average days from PO creation to approval - key procurement efficiency metric"
    - name: "avg_delivery_lead_time_days"
      expr: AVG(CAST(DATEDIFF(promised_delivery_date, po_date) AS DOUBLE))
      comment: "Average promised delivery lead time in days - measures supply chain responsiveness"
    - name: "cancelled_po_count"
      expr: COUNT(DISTINCT CASE WHEN po_status = 'cancelled' THEN purchase_order_id END)
      comment: "Number of cancelled purchase orders - indicates procurement planning quality"
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN po_status = 'cancelled' THEN purchase_order_id END) / NULLIF(COUNT(DISTINCT purchase_order_id), 0), 2)
      comment: "Percentage of purchase orders cancelled - key quality metric for procurement planning"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for goods receipt quality, three-way matching efficiency, and receiving performance"
  source: "`transport_shipping_ecm`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the goods receipt (e.g., received, inspected, accepted, rejected)"
    - name: "receipt_type"
      expr: receipt_type
      comment: "Type of goods receipt (e.g., standard, return, sample)"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three-way match between PO, goods receipt, and invoice"
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Code indicating reason for rejection (quality, quantity, damage, etc.)"
    - name: "match_tolerance_exceeded_flag"
      expr: match_tolerance_exceeded_flag
      comment: "Flag indicating whether matching tolerance was exceeded"
    - name: "payment_cleared_flag"
      expr: payment_cleared_flag
      comment: "Flag indicating whether payment has been cleared"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods receipt value"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for received goods"
    - name: "receipt_year"
      expr: YEAR(receipt_date)
      comment: "Year the goods were received"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month the goods were received"
  measures:
    - name: "total_receipt_value"
      expr: SUM(CAST(receipt_value_amount AS DOUBLE))
      comment: "Total value of all goods receipts - measures actual procurement fulfillment value"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of goods received across all receipts"
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total quantity of goods accepted after inspection"
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity of goods rejected - key quality metric"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity originally ordered"
    - name: "receipt_count"
      expr: COUNT(DISTINCT goods_receipt_id)
      comment: "Number of distinct goods receipts - tracks receiving transaction volume"
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received goods rejected - critical supplier quality metric"
    - name: "order_fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity actually received - measures supplier delivery performance"
    - name: "three_way_match_success_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN three_way_match_status = 'matched' THEN goods_receipt_id END) / NULLIF(COUNT(DISTINCT goods_receipt_id), 0), 2)
      comment: "Percentage of receipts with successful three-way match - key accounts payable efficiency metric"
    - name: "avg_receipt_cycle_days"
      expr: AVG(CAST(DATEDIFF(receipt_date, expected_delivery_date) AS DOUBLE))
      comment: "Average days variance between expected and actual receipt - measures delivery reliability"
    - name: "tolerance_exception_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN match_tolerance_exceeded_flag = TRUE THEN goods_receipt_id END) / NULLIF(COUNT(DISTINCT goods_receipt_id), 0), 2)
      comment: "Percentage of receipts exceeding matching tolerance - indicates procurement control effectiveness"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`procurement_supplier_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPIs for supplier invoice processing, payment efficiency, and dispute management"
  source: "`transport_shipping_ecm`.`procurement`.`supplier_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the supplier invoice (e.g., received, approved, paid, disputed)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., standard, credit memo, debit memo)"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three-way match validation"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating whether the invoice is under dispute"
    - name: "dispute_reason"
      expr: dispute_reason
      comment: "Reason for invoice dispute"
    - name: "match_exception_type"
      expr: match_exception_type
      comment: "Type of matching exception (price, quantity, tax, etc.)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g., wire transfer, ACH, check)"
    - name: "payment_term_code"
      expr: payment_term_code
      comment: "Payment terms code"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year the invoice was issued"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was issued"
  measures:
    - name: "total_invoice_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount - measures total supplier payment obligations"
    - name: "total_invoice_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount captured - measures early payment savings"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax amount"
    - name: "total_match_exception_amount"
      expr: SUM(CAST(match_exception_amount AS DOUBLE))
      comment: "Total value of matching exceptions - indicates invoice accuracy issues"
    - name: "invoice_count"
      expr: COUNT(DISTINCT supplier_invoice_id)
      comment: "Number of distinct supplier invoices processed"
    - name: "supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers invoicing"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average invoice amount - indicates typical transaction size"
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN supplier_invoice_id END) / NULLIF(COUNT(DISTINCT supplier_invoice_id), 0), 2)
      comment: "Percentage of invoices under dispute - key supplier relationship and process quality metric"
    - name: "match_exception_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN match_exception_amount > 0 THEN supplier_invoice_id END) / NULLIF(COUNT(DISTINCT supplier_invoice_id), 0), 2)
      comment: "Percentage of invoices with matching exceptions - measures invoice processing efficiency"
    - name: "avg_payment_cycle_days"
      expr: AVG(CAST(DATEDIFF(payment_date, invoice_date) AS DOUBLE))
      comment: "Average days from invoice date to payment - key working capital and supplier relationship metric"
    - name: "avg_approval_cycle_days"
      expr: AVG(CAST(DATEDIFF(approval_date, received_date) AS DOUBLE))
      comment: "Average days from invoice receipt to approval - measures AP processing efficiency"
    - name: "discount_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross amount captured as discount - measures early payment program effectiveness"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`procurement_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic supplier management KPIs tracking supplier base composition, certification status, and risk profile"
  source: "`transport_shipping_ecm`.`procurement`.`supplier`"
  dimensions:
    - name: "supplier_status"
      expr: supplier_status
      comment: "Current status of the supplier (e.g., active, inactive, suspended)"
    - name: "supplier_type"
      expr: supplier_type
      comment: "Type of supplier (e.g., manufacturer, distributor, service provider)"
    - name: "supplier_category"
      expr: supplier_category
      comment: "Category of goods or services provided"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier classification (e.g., low, medium, high, critical)"
    - name: "preferred_supplier"
      expr: preferred_supplier
      comment: "Flag indicating preferred supplier status"
    - name: "iso_9001_certified"
      expr: iso_9001_certified
      comment: "ISO 9001 quality management certification status"
    - name: "iso_14001_certified"
      expr: iso_14001_certified
      comment: "ISO 14001 environmental management certification status"
    - name: "aeo_certified"
      expr: aeo_certified
      comment: "Authorized Economic Operator certification status"
    - name: "ctpat_certified"
      expr: ctpat_certified
      comment: "Customs-Trade Partnership Against Terrorism certification status"
    - name: "small_business"
      expr: small_business
      comment: "Small business classification flag"
    - name: "minority_owned"
      expr: minority_owned
      comment: "Minority-owned business flag"
    - name: "woman_owned"
      expr: woman_owned
      comment: "Woman-owned business flag"
    - name: "country_code"
      expr: country_code
      comment: "Country where supplier is located"
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Supplier onboarding workflow status"
  measures:
    - name: "total_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Total number of suppliers in the base - measures supplier base size and diversity"
    - name: "active_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN supplier_status = 'active' THEN supplier_id END)
      comment: "Number of active suppliers - key metric for supplier base management"
    - name: "preferred_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN preferred_supplier = TRUE THEN supplier_id END)
      comment: "Number of preferred suppliers - indicates strategic supplier relationships"
    - name: "high_risk_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN risk_tier = 'high' OR risk_tier = 'critical' THEN supplier_id END)
      comment: "Number of high or critical risk suppliers - key risk management metric"
    - name: "iso_9001_certified_count"
      expr: COUNT(DISTINCT CASE WHEN iso_9001_certified = TRUE THEN supplier_id END)
      comment: "Number of ISO 9001 certified suppliers - measures quality assurance in supplier base"
    - name: "iso_14001_certified_count"
      expr: COUNT(DISTINCT CASE WHEN iso_14001_certified = TRUE THEN supplier_id END)
      comment: "Number of ISO 14001 certified suppliers - measures environmental compliance"
    - name: "aeo_certified_count"
      expr: COUNT(DISTINCT CASE WHEN aeo_certified = TRUE THEN supplier_id END)
      comment: "Number of AEO certified suppliers - measures customs compliance and security"
    - name: "ctpat_certified_count"
      expr: COUNT(DISTINCT CASE WHEN ctpat_certified = TRUE THEN supplier_id END)
      comment: "Number of C-TPAT certified suppliers - measures supply chain security"
    - name: "diverse_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN small_business = TRUE OR minority_owned = TRUE OR woman_owned = TRUE THEN supplier_id END)
      comment: "Number of diverse suppliers - tracks supplier diversity program effectiveness"
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average supplier performance rating - key supplier quality metric"
    - name: "preferred_supplier_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN preferred_supplier = TRUE THEN supplier_id END) / NULLIF(COUNT(DISTINCT supplier_id), 0), 2)
      comment: "Percentage of suppliers with preferred status - indicates strategic sourcing maturity"
    - name: "certification_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN iso_9001_certified = TRUE OR iso_14001_certified = TRUE THEN supplier_id END) / NULLIF(COUNT(DISTINCT supplier_id), 0), 2)
      comment: "Percentage of suppliers with quality or environmental certification - measures supplier base quality"
    - name: "diverse_supplier_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN small_business = TRUE OR minority_owned = TRUE OR woman_owned = TRUE THEN supplier_id END) / NULLIF(COUNT(DISTINCT supplier_id), 0), 2)
      comment: "Percentage of diverse suppliers - key corporate social responsibility metric"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`procurement_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic sourcing KPIs tracking RFQ effectiveness, supplier participation, and competitive bidding outcomes"
  source: "`transport_shipping_ecm`.`procurement`.`rfq`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ (e.g., draft, issued, closed, awarded)"
    - name: "rfq_category"
      expr: rfq_category
      comment: "Category of goods or services being sourced"
    - name: "sourcing_event_type"
      expr: sourcing_event_type
      comment: "Type of sourcing event (e.g., RFQ, RFP, RFI, auction)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the RFQ"
    - name: "is_reverse_auction"
      expr: is_reverse_auction
      comment: "Flag indicating whether this is a reverse auction"
    - name: "is_multi_round"
      expr: is_multi_round
      comment: "Flag indicating whether this is a multi-round sourcing event"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for the RFQ"
    - name: "issuing_country_code"
      expr: issuing_country_code
      comment: "Country code where the RFQ was issued"
    - name: "delivery_country_code"
      expr: delivery_country_code
      comment: "Country code for delivery destination"
    - name: "rfq_year"
      expr: YEAR(issue_date)
      comment: "Year the RFQ was issued"
    - name: "rfq_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the RFQ was issued"
  measures:
    - name: "rfq_count"
      expr: COUNT(DISTINCT rfq_id)
      comment: "Number of distinct RFQs - tracks strategic sourcing activity volume"
    - name: "total_estimated_spend"
      expr: SUM(CAST(estimated_spend_amount AS DOUBLE))
      comment: "Total estimated spend across all RFQs - measures sourcing pipeline value"
    - name: "total_awarded_amount"
      expr: SUM(CAST(awarded_amount AS DOUBLE))
      comment: "Total awarded amount - measures actual sourcing value realized"
    - name: "avg_estimated_spend"
      expr: AVG(CAST(estimated_spend_amount AS DOUBLE))
      comment: "Average estimated spend per RFQ - indicates typical sourcing event size"
    - name: "avg_awarded_amount"
      expr: AVG(CAST(awarded_amount AS DOUBLE))
      comment: "Average awarded amount per RFQ"
    - name: "awarded_rfq_count"
      expr: COUNT(DISTINCT CASE WHEN awarded_amount > 0 THEN rfq_id END)
      comment: "Number of RFQs that resulted in awards"
    - name: "award_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN awarded_amount > 0 THEN rfq_id END) / NULLIF(COUNT(DISTINCT rfq_id), 0), 2)
      comment: "Percentage of RFQs resulting in awards - measures sourcing effectiveness"
    - name: "avg_cycle_time_days"
      expr: AVG(CAST(DATEDIFF(award_date, issue_date) AS DOUBLE))
      comment: "Average days from RFQ issue to award - key sourcing efficiency metric"
    - name: "avg_supplier_participation"
      expr: AVG(CAST(supplier_count AS DOUBLE))
      comment: "Average number of suppliers participating per RFQ - measures competitive intensity"
    - name: "avg_response_rate"
      expr: AVG(CAST(response_count AS DOUBLE))
      comment: "Average number of responses per RFQ - indicates market engagement"
    - name: "savings_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(estimated_spend_amount AS DOUBLE)) - SUM(CAST(awarded_amount AS DOUBLE))) / NULLIF(SUM(CAST(estimated_spend_amount AS DOUBLE)), 0), 2)
      comment: "Percentage savings from estimated to awarded amount - critical sourcing value metric"
    - name: "reverse_auction_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_reverse_auction = TRUE THEN rfq_id END) / NULLIF(COUNT(DISTINCT rfq_id), 0), 2)
      comment: "Percentage of RFQs using reverse auction - measures advanced sourcing technique adoption"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`procurement_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed procurement line-item KPIs tracking order fulfillment, pricing variance, and line-level efficiency"
  source: "`transport_shipping_ecm`.`procurement`.`po_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the purchase order line (e.g., open, closed, cancelled)"
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category of the line item"
    - name: "is_capital_expenditure"
      expr: is_capital_expenditure
      comment: "Flag indicating whether this is a capital expenditure"
    - name: "is_services"
      expr: is_services
      comment: "Flag indicating whether this line is for services (vs. goods)"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms for the line"
    - name: "payment_term_code"
      expr: payment_term_code
      comment: "Payment terms code"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line item"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the line item"
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the line"
  measures:
    - name: "po_line_count"
      expr: COUNT(DISTINCT po_line_id)
      comment: "Number of distinct purchase order lines"
    - name: "total_line_amount"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total line amount across all PO lines - measures total procurement value at line level"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount captured at line level"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount at line level"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all lines"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received across all lines"
    - name: "total_invoiced_quantity"
      expr: SUM(CAST(invoiced_quantity AS DOUBLE))
      comment: "Total quantity invoiced across all lines"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across all line items"
    - name: "avg_line_value"
      expr: AVG(CAST(line_total_amount AS DOUBLE))
      comment: "Average line value - indicates typical line item size"
    - name: "line_fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity received - key supplier delivery performance metric"
    - name: "invoice_match_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(invoiced_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity invoiced - measures invoice-to-receipt matching accuracy"
    - name: "capex_line_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_capital_expenditure = TRUE THEN po_line_id END) / NULLIF(COUNT(DISTINCT po_line_id), 0), 2)
      comment: "Percentage of lines classified as capital expenditure - tracks CAPEX vs OPEX mix"
    - name: "services_line_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_services = TRUE THEN po_line_id END) / NULLIF(COUNT(DISTINCT po_line_id), 0), 2)
      comment: "Percentage of lines for services - measures goods vs services procurement mix"
$$;