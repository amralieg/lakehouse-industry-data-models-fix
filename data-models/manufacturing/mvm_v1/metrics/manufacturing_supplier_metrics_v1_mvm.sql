-- Metric views for domain: supplier | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 09:37:16

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic supplier master metrics covering portfolio health, risk distribution, certification compliance, and diversity. Used by procurement leadership to steer supplier base strategy, risk mitigation, and ESG commitments."
  source: "`manufacturing_ecm`.`supplier`.`supplier`"
  dimensions:
    - name: "supplier_status"
      expr: supplier_status
      comment: "Operational status of the supplier (e.g., Active, Inactive, Blocked) — used to filter active supplier base."
    - name: "supplier_category"
      expr: supplier_category
      comment: "Category classification of the supplier (e.g., Raw Material, MRO, Services) — key segmentation for spend and risk analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Supplier-level risk rating (e.g., Low, Medium, High, Critical) — used to prioritize mitigation actions."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status of the supplier — indicates readiness to supply."
    - name: "headquarters_country"
      expr: headquarters_country
      comment: "Country of supplier headquarters — used for geographic concentration and geopolitical risk analysis."
    - name: "business_type"
      expr: business_type
      comment: "Legal or organizational business type of the supplier (e.g., Corporation, SME, Cooperative)."
    - name: "iso9001_certified"
      expr: iso9001_certified
      comment: "Flag indicating whether the supplier holds ISO 9001 quality management certification."
    - name: "minority_owned"
      expr: minority_owned
      comment: "Flag indicating minority-owned supplier — relevant for diversity spend reporting."
    - name: "small_business"
      expr: small_business
      comment: "Flag indicating small business classification — relevant for regulatory and diversity reporting."
    - name: "woman_owned"
      expr: woman_owned
      comment: "Flag indicating woman-owned supplier — relevant for ESG and diversity spend reporting."
  measures:
    - name: "total_active_suppliers"
      expr: COUNT(CASE WHEN supplier_status = 'Active' THEN supplier_id END)
      comment: "Count of suppliers with Active status. Baseline KPI for supplier portfolio size — a shrinking active base signals consolidation risk or attrition."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across all suppliers. Directly measures supply chain reliability — a drop triggers supplier performance reviews and sourcing diversification."
    - name: "avg_quality_acceptance_rate"
      expr: AVG(CAST(quality_acceptance_rate AS DOUBLE))
      comment: "Average quality acceptance rate across all suppliers. Measures incoming material quality — low rates drive corrective action plans and potential disqualification."
    - name: "avg_overall_scorecard_rating"
      expr: AVG(CAST(overall_scorecard_rating AS DOUBLE))
      comment: "Average overall scorecard rating across the supplier base. Composite performance indicator used in quarterly business reviews to assess supplier health."
    - name: "high_risk_supplier_count"
      expr: COUNT(CASE WHEN risk_rating IN ('High', 'Critical') THEN supplier_id END)
      comment: "Number of suppliers rated High or Critical risk. Directly informs risk mitigation investment and dual-sourcing decisions at the executive level."
    - name: "iso9001_certified_supplier_count"
      expr: COUNT(CASE WHEN iso9001_certified = TRUE THEN supplier_id END)
      comment: "Count of suppliers holding ISO 9001 certification. Tracks quality certification coverage — a key procurement governance KPI."
    - name: "diversity_supplier_count"
      expr: COUNT(CASE WHEN minority_owned = TRUE OR woman_owned = TRUE OR small_business = TRUE THEN supplier_id END)
      comment: "Count of suppliers qualifying as diverse (minority-owned, woman-owned, or small business). Tracks ESG and regulatory diversity spend commitments."
    - name: "qualified_supplier_count"
      expr: COUNT(CASE WHEN qualification_status = 'Qualified' THEN supplier_id END)
      comment: "Count of fully qualified suppliers. Measures the depth of the approved supply base — critical for sourcing agility and risk coverage."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supplier_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order execution metrics covering procurement volume, value, cycle performance, and compliance. Used by procurement operations and finance to manage spend, supplier performance, and process efficiency."
  source: "`manufacturing_ecm`.`supplier`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order (e.g., Open, Closed, Cancelled) — used to filter active vs. completed procurement activity."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g., Standard, Blanket, Framework) — used to segment procurement strategy analysis."
    - name: "material_category"
      expr: material_category
      comment: "Category of material being procured — key dimension for spend analysis by commodity."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization responsible for the PO — used for organizational spend accountability."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group (buyer team) responsible for the PO — used for buyer performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the purchase order — used for multi-currency spend normalization."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms governing delivery responsibility — used to analyze logistics cost allocation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the PO — used to track procurement governance compliance."
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of goods receipt against the PO — used to track fulfillment and open liability."
    - name: "po_date"
      expr: DATE_TRUNC('month', po_date)
      comment: "Purchase order creation month — used for time-series spend trend analysis."
    - name: "priority"
      expr: priority
      comment: "Priority classification of the purchase order — used to analyze urgency and expediting patterns."
  measures:
    - name: "total_po_spend"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total gross value of all purchase orders including tax. Primary spend KPI used in budget vs. actuals reporting and supplier spend concentration analysis."
    - name: "total_net_po_spend"
      expr: SUM(CAST(net_po_value AS DOUBLE))
      comment: "Total net value of purchase orders excluding tax. Used for clean spend analytics and contract compliance measurement."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all purchase orders. Used for tax liability reporting and indirect cost tracking."
    - name: "purchase_order_count"
      expr: COUNT(DISTINCT purchase_order_id)
      comment: "Total number of distinct purchase orders. Baseline volume metric for procurement workload and process efficiency benchmarking."
    - name: "avg_po_value"
      expr: AVG(CAST(total_po_value AS DOUBLE))
      comment: "Average value per purchase order. Tracks order consolidation effectiveness — rising average PO value indicates better spend aggregation and reduced transaction costs."
    - name: "open_po_count"
      expr: COUNT(CASE WHEN po_status = 'Open' THEN purchase_order_id END)
      comment: "Count of purchase orders currently in Open status. Measures outstanding procurement commitments and open liability exposure."
    - name: "cancelled_po_count"
      expr: COUNT(CASE WHEN po_status = 'Cancelled' THEN purchase_order_id END)
      comment: "Count of cancelled purchase orders. High cancellation rates signal demand volatility, supplier failures, or procurement process inefficiency."
    - name: "pending_goods_receipt_po_count"
      expr: COUNT(CASE WHEN goods_receipt_status NOT IN ('Complete', 'Closed') THEN purchase_order_id END)
      comment: "Count of POs awaiting goods receipt completion. Tracks open delivery obligations and potential supply chain bottlenecks."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supplier_po_line_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order line-level metrics for granular spend, delivery performance, and quantity variance analysis. Used by procurement analysts and supply chain managers to identify fulfillment gaps and price deviations."
  source: "`manufacturing_ecm`.`supplier`.`po_line_item`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the PO line item (e.g., Open, Closed, Cancelled) — used to filter active vs. completed line items."
    - name: "item_category"
      expr: item_category
      comment: "Category of the line item (e.g., Standard, Consignment, Subcontracting) — used to segment procurement type analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Receiving plant code — used to analyze procurement demand by manufacturing location."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for the line item — used for multi-currency spend analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms for the line item — used to analyze delivery responsibility and logistics cost allocation."
    - name: "delivery_date"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Scheduled delivery month for the line item — used for delivery timeline and lead time trend analysis."
    - name: "goods_receipt_indicator"
      expr: goods_receipt_indicator
      comment: "Flag indicating whether goods receipt is required for this line — used to filter GR-relevant lines."
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Flag indicating whether quality inspection is required — used to track inspection workload and compliance."
  measures:
    - name: "total_net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Total net order value across all PO line items. Granular spend KPI used for commodity-level spend analysis and budget tracking."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across all PO line items. Used for demand volume analysis and supplier capacity planning."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity received against PO line items. Measures actual fulfillment volume — gap vs. ordered quantity signals delivery shortfalls."
    - name: "total_open_quantity"
      expr: SUM(CAST(open_quantity AS DOUBLE))
      comment: "Total outstanding quantity not yet received. Tracks unfulfilled procurement commitments and potential production supply risk."
    - name: "total_quantity_invoiced"
      expr: SUM(CAST(quantity_invoiced AS DOUBLE))
      comment: "Total quantity invoiced by suppliers. Used for three-way match analysis (PO vs. GR vs. Invoice) to detect billing discrepancies."
    - name: "avg_net_price"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net unit price across PO line items. Used for price benchmarking and tracking price inflation trends by material or supplier."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across PO line items. Used for indirect tax cost tracking and compliance reporting."
    - name: "line_item_count"
      expr: COUNT(DISTINCT po_line_item_id)
      comment: "Total number of distinct PO line items. Measures procurement transaction granularity and buyer workload."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supplier_procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt metrics covering inbound delivery performance, quantity accuracy, quality inspection outcomes, and reversal rates. Used by supply chain and quality teams to measure supplier delivery reliability and inbound quality."
  source: "`manufacturing_ecm`.`supplier`.`procurement_goods_receipt`"
  dimensions:
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of the goods receipt document (e.g., Posted, Reversed, Blocked) — used to filter valid receipts."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Outcome of quality inspection at goods receipt (e.g., Passed, Failed, Pending) — key quality gate metric."
    - name: "movement_type"
      expr: movement_type
      comment: "SAP movement type for the goods receipt — used to distinguish standard receipts from returns and reversals."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock received (e.g., Unrestricted, Quality Inspection, Blocked) — used to track stock availability impact."
    - name: "receiving_plant_code"
      expr: receiving_plant_code
      comment: "Plant receiving the goods — used for location-level inbound performance analysis."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of goods receipt posting — used for time-series inbound volume and performance trending."
    - name: "damage_flag"
      expr: damage_flag
      comment: "Flag indicating damaged goods were received — used to track supplier packaging and logistics quality."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flag indicating the goods receipt was reversed — used to measure receipt accuracy and process errors."
    - name: "gr_ir_clearing_status"
      expr: gr_ir_clearing_status
      comment: "GR/IR clearing status — used to track invoice matching and open accrual positions."
  measures:
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received across all goods receipts. Primary inbound volume KPI used to measure supplier fulfillment throughput."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered corresponding to goods receipts. Used as denominator for fill rate and quantity variance calculations."
    - name: "total_goods_receipt_value"
      expr: SUM(CAST(goods_receipt_value AS DOUBLE))
      comment: "Total value of goods received. Used for accrual accounting, GR/IR reconciliation, and inbound spend tracking."
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total quantity variance between ordered and received quantities. Measures supplier delivery accuracy — persistent variance triggers supplier corrective action."
    - name: "goods_receipt_count"
      expr: COUNT(DISTINCT procurement_goods_receipt_id)
      comment: "Total number of distinct goods receipt documents. Measures inbound transaction volume and receiving workload."
    - name: "damaged_receipt_count"
      expr: COUNT(CASE WHEN damage_flag = TRUE THEN procurement_goods_receipt_id END)
      comment: "Count of goods receipts flagged as damaged. Tracks supplier packaging and logistics quality — high rates drive supplier corrective action plans."
    - name: "reversed_receipt_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN procurement_goods_receipt_id END)
      comment: "Count of reversed goods receipts. Measures receipt processing errors and supplier return activity — high reversal rates indicate process or quality issues."
    - name: "quality_inspection_required_count"
      expr: COUNT(CASE WHEN quality_inspection_required_flag = TRUE THEN procurement_goods_receipt_id END)
      comment: "Count of goods receipts requiring quality inspection. Used to plan inspection resource capacity and track quality gate coverage."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supplier_invoice_line_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier invoice line metrics covering payables accuracy, price variance, discount capture, and three-way match compliance. Used by accounts payable and procurement finance to manage invoice accuracy and working capital."
  source: "`manufacturing_ecm`.`supplier`.`invoice_line_item`"
  dimensions:
    - name: "match_status"
      expr: match_status
      comment: "Three-way match status of the invoice line (e.g., Matched, Blocked, Exception) — key AP compliance dimension."
    - name: "verification_status"
      expr: verification_status
      comment: "Invoice verification status — used to track AP processing pipeline and blocked invoices."
    - name: "line_type"
      expr: line_type
      comment: "Type of invoice line (e.g., Material, Service, Freight) — used to segment invoice spend by category."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency — used for multi-currency payables analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the invoice line — used for location-level payables analysis."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the invoice line — used for tax compliance and indirect tax reporting."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms on the invoice line — used to analyze early payment discount capture and DPO management."
    - name: "verification_date"
      expr: DATE_TRUNC('month', verification_date)
      comment: "Month of invoice verification — used for time-series AP processing volume and aging analysis."
    - name: "blocking_reason"
      expr: blocking_reason
      comment: "Reason an invoice line is blocked from payment — used to identify systemic AP process issues."
  measures:
    - name: "total_invoiced_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total gross invoiced amount across all invoice lines. Primary AP spend KPI used for payables accrual and cash flow forecasting."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoiced amount after discounts. Used for clean spend reporting and supplier payment obligation tracking."
    - name: "total_price_variance"
      expr: SUM(CAST(price_variance AS DOUBLE))
      comment: "Total price variance between PO price and invoiced price. Measures invoice accuracy and supplier pricing compliance — large variances trigger dispute resolution."
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total quantity variance between goods received and invoiced quantity. Tracks overbilling risk and three-way match failures."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount captured across invoice lines. Measures early payment discount realization — a direct working capital optimization KPI."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on invoiced lines. Used for indirect tax liability reporting and compliance."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average invoiced unit price across line items. Used for price benchmarking and detecting invoice price inflation vs. contracted rates."
    - name: "invoice_line_count"
      expr: COUNT(DISTINCT invoice_line_item_id)
      comment: "Total number of distinct invoice line items. Measures AP processing volume and workload for staffing and automation ROI analysis."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage across invoice lines. Tracks discount term utilization — declining averages signal missed early payment opportunities."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier scorecard performance metrics covering overall ratings, quality, delivery, cost, and responsiveness dimensions. Used by procurement leadership and supplier relationship managers for quarterly performance reviews and strategic sourcing decisions."
  source: "`manufacturing_ecm`.`supplier`.`scorecard`"
  dimensions:
    - name: "rating_tier"
      expr: rating_tier
      comment: "Current performance tier of the supplier (e.g., Preferred, Approved, Conditional, Disqualified) — primary segmentation for supplier stratification."
    - name: "previous_rating_tier"
      expr: previous_rating_tier
      comment: "Prior period rating tier — used to track tier movement and identify improving or declining suppliers."
    - name: "period_type"
      expr: period_type
      comment: "Evaluation period type (e.g., Monthly, Quarterly, Annual) — used to filter scorecard granularity."
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Status of the scorecard (e.g., Draft, Published, Approved) — used to filter finalized scorecards."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the scorecard spend values — used for multi-currency normalization."
    - name: "evaluation_period_end_date"
      expr: DATE_TRUNC('quarter', evaluation_period_end_date)
      comment: "Quarter of scorecard evaluation period end — used for time-series performance trending."
    - name: "evaluation_methodology"
      expr: evaluation_methodology
      comment: "Methodology used to evaluate the supplier — used to ensure comparability across scorecard cohorts."
  measures:
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier scorecard score. Primary composite performance KPI used in quarterly business reviews and strategic sourcing decisions."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality dimension score across scorecards. Tracks supplier quality performance trend — declining scores trigger quality improvement programs."
    - name: "avg_delivery_score"
      expr: AVG(CAST(delivery_score AS DOUBLE))
      comment: "Average delivery dimension score across scorecards. Measures on-time delivery performance — used to identify suppliers requiring logistics improvement."
    - name: "avg_cost_score"
      expr: AVG(CAST(cost_score AS DOUBLE))
      comment: "Average cost competitiveness score across scorecards. Tracks price competitiveness — used in renegotiation and dual-sourcing decisions."
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average responsiveness score across scorecards. Measures supplier communication and issue resolution speed — critical for agile supply chain management."
    - name: "avg_otd_percentage"
      expr: AVG(CAST(otd_percentage AS DOUBLE))
      comment: "Average on-time delivery percentage across all evaluated suppliers. Direct delivery reliability KPI used in supplier performance dashboards and contract reviews."
    - name: "avg_ppm_defect_rate"
      expr: AVG(CAST(ppm_defect_rate AS DOUBLE))
      comment: "Average parts-per-million defect rate across suppliers. Industry-standard quality KPI — high PPM rates drive corrective action plans and potential disqualification."
    - name: "total_purchase_value_evaluated"
      expr: SUM(CAST(total_purchase_value AS DOUBLE))
      comment: "Total purchase value covered by scorecards. Measures spend under performance management — low coverage signals governance gaps in supplier oversight."
    - name: "avg_cost_variance_percentage"
      expr: AVG(CAST(cost_variance_percentage AS DOUBLE))
      comment: "Average cost variance percentage vs. target across scorecards. Tracks price discipline — persistent positive variance drives renegotiation or resourcing."
    - name: "avg_responsiveness_index"
      expr: AVG(CAST(responsiveness_index AS DOUBLE))
      comment: "Average responsiveness index score. Composite measure of supplier agility and communication effectiveness — used to identify relationship management priorities."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supplier_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier audit metrics covering audit outcomes, findings severity, CAPA compliance, and risk rating changes. Used by quality and compliance teams to manage supplier audit programs and track corrective action effectiveness."
  source: "`manufacturing_ecm`.`supplier`.`supplier_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted (e.g., Quality, Environmental, Social, Financial) — used to segment audit program coverage."
    - name: "audit_result"
      expr: audit_result
      comment: "Overall result of the audit (e.g., Pass, Conditional Pass, Fail) — primary outcome dimension for audit performance analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (e.g., Planned, In Progress, Completed, Closed) — used to track audit program execution."
    - name: "certification_standard"
      expr: certification_standard
      comment: "Certification standard being audited (e.g., ISO 9001, IATF 16949, ISO 14001) — used to analyze compliance by standard."
    - name: "audit_method"
      expr: audit_method
      comment: "Method of audit execution (e.g., On-site, Remote, Document Review) — used to analyze audit effectiveness by method."
    - name: "risk_rating_post_audit"
      expr: risk_rating_post_audit
      comment: "Supplier risk rating assigned after audit completion — used to track risk profile changes driven by audit findings."
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Flag indicating whether a corrective action plan is required — used to track CAPA obligation volume."
    - name: "audit_date"
      expr: DATE_TRUNC('quarter', audit_date)
      comment: "Quarter of audit execution — used for time-series audit program activity and findings trending."
  measures:
    - name: "total_audit_count"
      expr: COUNT(DISTINCT supplier_audit_id)
      comment: "Total number of supplier audits conducted. Measures audit program coverage and execution velocity — used to track compliance with audit frequency targets."
    - name: "avg_audit_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average audit score across all completed audits. Composite quality and compliance KPI — declining scores signal systemic supplier quality deterioration."
    - name: "total_audit_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost incurred for supplier audits. Used for audit program budget management and ROI analysis vs. quality outcomes."
    - name: "capa_required_audit_count"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN supplier_audit_id END)
      comment: "Count of audits requiring corrective action plans. Measures the volume of supplier non-conformances requiring remediation — a leading indicator of supply quality risk."
    - name: "follow_up_audit_required_count"
      expr: COUNT(CASE WHEN follow_up_audit_required_flag = TRUE THEN supplier_audit_id END)
      comment: "Count of audits requiring follow-up audits. Tracks unresolved compliance issues requiring re-verification — high counts signal persistent supplier quality problems."
    - name: "failed_audit_count"
      expr: COUNT(CASE WHEN audit_result = 'Fail' THEN supplier_audit_id END)
      comment: "Count of audits with a Fail result. Direct compliance failure KPI — triggers escalation, sourcing review, and potential supplier disqualification."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supplier_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier certification compliance metrics covering certification coverage, expiry risk, non-conformance rates, and renewal status. Used by quality and procurement teams to manage certification-gated sourcing and compliance obligations."
  source: "`manufacturing_ecm`.`supplier`.`supplier_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g., ISO 9001, IATF 16949, ISO 14001, AS9100) — primary segmentation for certification compliance analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (e.g., Active, Expired, Suspended, Revoked) — used to identify compliance gaps."
    - name: "standard"
      expr: standard
      comment: "Certification standard (e.g., ISO 9001:2015) — used for standard-level compliance tracking."
    - name: "business_criticality"
      expr: business_criticality
      comment: "Business criticality of the certification (e.g., Critical, High, Medium, Low) — used to prioritize renewal and compliance actions."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Status of certification renewal process — used to track upcoming expiry risk and renewal pipeline."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating associated with the certification — used to prioritize compliance monitoring."
    - name: "procurement_gate_enabled"
      expr: procurement_gate_enabled
      comment: "Flag indicating whether this certification gates procurement activity — used to identify sourcing-critical certifications."
    - name: "expiry_date"
      expr: DATE_TRUNC('quarter', expiry_date)
      comment: "Quarter of certification expiry — used for expiry risk horizon analysis and renewal planning."
  measures:
    - name: "total_certification_count"
      expr: COUNT(DISTINCT supplier_certification_id)
      comment: "Total number of supplier certifications tracked. Baseline coverage KPI for the certification compliance program."
    - name: "active_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN supplier_certification_id END)
      comment: "Count of currently active certifications. Measures the live compliance posture of the supplier base — a drop signals emerging compliance risk."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Expired' THEN supplier_certification_id END)
      comment: "Count of expired certifications. Directly measures compliance failures — expired certifications on procurement-gated suppliers can halt sourcing."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_actions_required = TRUE THEN supplier_certification_id END)
      comment: "Count of certifications with open corrective action requirements. Tracks unresolved non-conformances that threaten certification validity."
    - name: "procurement_gated_certification_count"
      expr: COUNT(CASE WHEN procurement_gate_enabled = TRUE THEN supplier_certification_id END)
      comment: "Count of certifications that gate procurement activity. Measures the scope of certification-controlled sourcing — critical for supply continuity risk management."
    - name: "avg_nonconformance_count"
      expr: AVG(CAST(nonconformance_count AS DOUBLE))
      comment: "Average number of non-conformances per certification. Tracks certification quality health — rising averages signal deteriorating supplier compliance."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supplier_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier qualification metrics covering qualification pipeline, audit scores, risk ratings, and disqualification rates. Used by supplier development and procurement teams to manage the approved supplier base and qualification program effectiveness."
  source: "`manufacturing_ecm`.`supplier`.`qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status (e.g., Qualified, Conditional, Disqualified, In Progress) — primary dimension for approved supplier base analysis."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification process (e.g., New Supplier, Re-qualification, Commodity Extension) — used to segment qualification pipeline."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned during qualification — used to stratify the qualified supplier base by risk."
    - name: "ppap_level"
      expr: ppap_level
      comment: "PPAP (Production Part Approval Process) level required — used to track qualification rigor by commodity."
    - name: "approval_date"
      expr: DATE_TRUNC('quarter', approval_date)
      comment: "Quarter of qualification approval — used for time-series qualification throughput analysis."
    - name: "re_qualification_eligible"
      expr: re_qualification_eligible
      comment: "Flag indicating whether the supplier is eligible for re-qualification — used to manage disqualified supplier recovery pipeline."
  measures:
    - name: "total_qualification_count"
      expr: COUNT(DISTINCT qualification_id)
      comment: "Total number of qualification records. Measures qualification program activity volume and pipeline throughput."
    - name: "qualified_supplier_count"
      expr: COUNT(CASE WHEN qualification_status = 'Qualified' THEN qualification_id END)
      comment: "Count of fully qualified supplier-commodity combinations. Measures the depth of the approved supply base — critical for sourcing agility."
    - name: "disqualified_supplier_count"
      expr: COUNT(CASE WHEN qualification_status = 'Disqualified' THEN qualification_id END)
      comment: "Count of disqualified supplier-commodity combinations. Tracks supply base attrition — high disqualification rates signal quality or compliance failures."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score achieved during qualification. Measures the quality bar of newly qualified suppliers — declining scores indicate lowering qualification standards."
    - name: "conditional_approval_count"
      expr: COUNT(CASE WHEN qualification_status = 'Conditional' THEN qualification_id END)
      comment: "Count of suppliers with conditional qualification approval. Tracks suppliers operating under probationary conditions — high counts signal supply base quality risk."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supplier_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier agreement and contract metrics covering contract value, compliance, ESG obligations, and renewal risk. Used by procurement legal and strategic sourcing teams to manage contract portfolio health and compliance."
  source: "`manufacturing_ecm`.`supplier`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement (e.g., Active, Expired, Terminated, Draft) — used to filter the live contract portfolio."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of agreement (e.g., Master Supply Agreement, NDA, Framework, SOW) — used to segment contract portfolio by type."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the agreement — used for multi-currency contract value analysis."
    - name: "governing_law"
      expr: governing_law
      comment: "Governing law jurisdiction of the agreement — used for legal risk and compliance analysis."
    - name: "esg_compliance_flag"
      expr: esg_compliance_flag
      comment: "Flag indicating whether the agreement includes ESG compliance obligations — used to track ESG contract coverage."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Flag indicating whether the agreement auto-renews — used to manage renewal risk and proactive renegotiation planning."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year of agreement effective start — used for contract vintage and portfolio age analysis."
    - name: "effective_end_date"
      expr: DATE_TRUNC('quarter', effective_end_date)
      comment: "Quarter of agreement expiry — used for contract renewal pipeline and expiry risk horizon analysis."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total value of all supplier agreements. Primary contract portfolio KPI — used for spend under contract tracking and procurement governance reporting."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN agreement_id END)
      comment: "Count of currently active supplier agreements. Measures the live contract portfolio size — used for contract coverage and governance analysis."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_value AS DOUBLE))
      comment: "Average value per supplier agreement. Tracks contract consolidation effectiveness — rising average values indicate better spend aggregation."
    - name: "esg_compliant_agreement_count"
      expr: COUNT(CASE WHEN esg_compliance_flag = TRUE THEN agreement_id END)
      comment: "Count of agreements with ESG compliance clauses. Measures ESG obligation coverage in the contract portfolio — a key sustainability governance KPI."
    - name: "auto_renewal_agreement_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN agreement_id END)
      comment: "Count of agreements set to auto-renew. Tracks renewal risk exposure — auto-renewing contracts without review can lock in unfavorable terms."
    - name: "ip_protected_agreement_count"
      expr: COUNT(CASE WHEN ip_protection_clause_flag = TRUE THEN agreement_id END)
      comment: "Count of agreements containing IP protection clauses. Measures intellectual property risk coverage in supplier contracts — critical for technology and innovation-intensive procurement."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supplier_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase requisition metrics covering demand pipeline, approval cycle efficiency, spend estimation, and conversion to PO. Used by procurement operations and finance to manage demand intake, approval governance, and procurement cycle time."
  source: "`manufacturing_ecm`.`supplier`.`purchase_requisition`"
  dimensions:
    - name: "pr_status"
      expr: pr_status
      comment: "Current status of the purchase requisition (e.g., Open, Approved, Rejected, Converted) — used to track the procurement demand pipeline."
    - name: "pr_type"
      expr: pr_type
      comment: "Type of purchase requisition (e.g., Standard, Blanket, Service) — used to segment demand by procurement category."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority classification of the requisition — used to analyze urgency distribution and expediting patterns."
    - name: "requestor_department"
      expr: requestor_department
      comment: "Department originating the requisition — used for demand attribution and budget accountability analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the requisition — used for location-level demand analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the requisition — used for multi-currency demand value analysis."
    - name: "approval_level_required"
      expr: approval_level_required
      comment: "Approval level required for the requisition — used to analyze governance compliance and approval bottlenecks."
    - name: "pr_date"
      expr: DATE_TRUNC('month', pr_date)
      comment: "Month of requisition creation — used for time-series demand intake trending."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether the requisition is compliant with procurement policy — used to track maverick spend risk."
  measures:
    - name: "total_estimated_requisition_value"
      expr: SUM(CAST(estimated_total_value AS DOUBLE))
      comment: "Total estimated value of all purchase requisitions. Measures the procurement demand pipeline value — used for budget forecasting and cash flow planning."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity requested across all requisitions. Measures demand volume — used for supply planning and supplier capacity alignment."
    - name: "avg_estimated_unit_price"
      expr: AVG(CAST(estimated_unit_price AS DOUBLE))
      comment: "Average estimated unit price across requisitions. Used for price benchmarking and early detection of cost inflation in demand intake."
    - name: "open_requisition_count"
      expr: COUNT(CASE WHEN pr_status = 'Open' THEN purchase_requisition_id END)
      comment: "Count of open purchase requisitions. Measures the unprocessed procurement demand backlog — high counts signal approval bottlenecks or resource constraints."
    - name: "converted_to_po_count"
      expr: COUNT(CASE WHEN po_created_date IS NOT NULL THEN purchase_requisition_id END)
      comment: "Count of requisitions successfully converted to purchase orders. Measures procurement pipeline conversion effectiveness — low conversion rates signal approval or sourcing failures."
    - name: "rejected_requisition_count"
      expr: COUNT(CASE WHEN pr_status = 'Rejected' THEN purchase_requisition_id END)
      comment: "Count of rejected purchase requisitions. Tracks demand rejection rates — high rejection rates signal misaligned demand planning or policy non-compliance."
    - name: "non_compliant_requisition_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN purchase_requisition_id END)
      comment: "Count of requisitions flagged as non-compliant. Measures maverick spend risk and procurement policy adherence — a key governance KPI."
$$;