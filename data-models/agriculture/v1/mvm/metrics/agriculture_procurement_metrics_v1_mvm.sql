-- Metric views for domain: procurement | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 18:41:06

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order volume, value, approval efficiency, and compliance posture. Enables procurement leadership to monitor spend commitments, PO pipeline health, and regulatory compliance across input categories, vendors, and farm units."
  source: "`agriculture_ecm`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g. Open, Closed, Cancelled) — used to segment active vs. completed spend commitments."
    - name: "po_type"
      expr: po_type
      comment: "Classification of the purchase order type (e.g. Standard, Blanket, Service) — drives procurement strategy analysis."
    - name: "input_category"
      expr: input_category
      comment: "Agricultural input category (e.g. Seed, Fertilizer, Chemical, Equipment) — primary spend segmentation dimension for procurement."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the PO — identifies bottlenecks in the authorization pipeline."
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "Capital vs. operational expenditure classification — critical for financial reporting and budget governance."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the purchase order — supports multi-currency spend analysis."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "International commercial terms governing delivery risk and cost transfer — relevant for supply chain risk management."
    - name: "gmo_status"
      expr: gmo_status
      comment: "GMO classification of the procured input — supports regulatory and consumer transparency reporting."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms agreed with the vendor — used to model cash flow timing and early payment discount opportunities."
    - name: "po_date_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month of PO creation — enables trend analysis of procurement activity over time."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month of PO approval — used to measure approval cycle time trends."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the procured goods — supports supply chain diversification and trade compliance analysis."
    - name: "fsma_compliance_flag"
      expr: fsma_compliance_flag
      comment: "Indicates whether the PO is subject to FSMA (Food Safety Modernization Act) preventive controls — regulatory risk dimension."
    - name: "epa_compliance_flag"
      expr: epa_compliance_flag
      comment: "Indicates whether the PO requires EPA compliance — used to track regulatory exposure in chemical procurement."
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders — baseline volume metric for procurement activity tracking."
    - name: "total_po_value"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total gross value of all purchase orders including tax — primary spend commitment KPI for budget governance and vendor spend analysis."
    - name: "total_net_po_value"
      expr: SUM(CAST(net_po_value AS DOUBLE))
      comment: "Total net value of purchase orders excluding tax — used for clean spend analysis and budget utilization tracking."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability across all purchase orders — supports tax accrual and financial close processes."
    - name: "avg_po_value"
      expr: AVG(CAST(total_po_value AS DOUBLE))
      comment: "Average purchase order value — benchmarks procurement transaction size and identifies outlier spend events."
    - name: "approved_po_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of purchase orders that have received full approval — measures throughput of the procurement authorization process."
    - name: "pending_approval_po_count"
      expr: COUNT(CASE WHEN approval_status NOT IN ('Approved', 'Rejected', 'Cancelled') THEN 1 END)
      comment: "Number of purchase orders awaiting approval — operational KPI for identifying authorization bottlenecks and procurement cycle delays."
    - name: "po_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of purchase orders that are approved — measures procurement governance effectiveness and approval pipeline health."
    - name: "fsma_compliant_po_count"
      expr: COUNT(CASE WHEN fsma_compliance_flag = TRUE THEN 1 END)
      comment: "Number of purchase orders flagged for FSMA compliance — tracks regulatory exposure in the procurement portfolio."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with active purchase orders — measures supply base breadth and concentration risk."
    - name: "distinct_input_category_count"
      expr: COUNT(DISTINCT input_category)
      comment: "Number of distinct agricultural input categories procured — indicates procurement portfolio diversity."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`procurement_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial governance KPIs for procurement budget allocation, utilization, variance, and commitment tracking. Enables finance and procurement leadership to monitor budget health, identify overspend risk, and manage fiscal period performance across cost centers, input categories, and farm units."
  source: "`agriculture_ecm`.`procurement`.`budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget record (e.g. Active, Closed, Draft) — used to filter to live budgets for operational monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget — primary time dimension for annual budget performance reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) within the fiscal year — enables sub-annual budget tracking and period-over-period comparison."
    - name: "input_category"
      expr: input_category
      comment: "Agricultural input category (e.g. Seed, Fertilizer, Chemical) — primary spend category dimension for budget analysis."
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "Capital vs. operational expenditure classification — required for financial statement alignment and budget governance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget — supports multi-currency budget consolidation."
    - name: "is_locked"
      expr: is_locked
      comment: "Indicates whether the budget is locked for further modification — used to identify finalized vs. editable budget records."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Budget period start month — enables time-series analysis of budget allocation and utilization trends."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the budget was approved — used to track budget approval cycle times and governance compliance."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total budget allocated across all records — primary measure of procurement budget authorization for a given period and category."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend recorded against budgets — core KPI for budget utilization and financial close reporting."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (encumbered) spend not yet invoiced — critical for cash flow forecasting and remaining budget availability."
    - name: "total_remaining_amount"
      expr: SUM(CAST(remaining_amount AS DOUBLE))
      comment: "Total unspent and uncommitted budget remaining — key liquidity and budget health indicator for procurement leadership."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (allocated minus actual) — measures aggregate over/underspend for financial performance review."
    - name: "total_transfer_in_amount"
      expr: SUM(CAST(transfer_in_amount AS DOUBLE))
      comment: "Total budget transferred into these records from other cost centers — tracks budget reallocation activity."
    - name: "total_transfer_out_amount"
      expr: SUM(CAST(transfer_out_amount AS DOUBLE))
      comment: "Total budget transferred out of these records to other cost centers — tracks budget reallocation activity."
    - name: "avg_spend_to_budget_pct"
      expr: AVG(CAST(spend_to_budget_pct AS DOUBLE))
      comment: "Average spend-to-budget utilization percentage across budget records — executive KPI for budget consumption rate and overspend risk identification."
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average budget variance percentage — measures systematic over or underspend patterns across the procurement portfolio."
    - name: "over_budget_record_count"
      expr: COUNT(CASE WHEN actual_spend_amount > allocated_amount THEN 1 END)
      comment: "Number of budget records where actual spend exceeds allocation — operational risk KPI for identifying budget breaches requiring management intervention."
    - name: "budget_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(allocated_amount AS DOUBLE)), 0), 2)
      comment: "Overall budget utilization rate as a percentage of total allocated amount — primary executive KPI for procurement budget efficiency and fiscal discipline."
    - name: "commitment_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(committed_amount AS DOUBLE)) / NULLIF(SUM(CAST(allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of budget already committed (encumbered) — forward-looking KPI for cash flow planning and remaining budget availability assessment."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`procurement_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance and risk KPIs covering delivery reliability, quality acceptance, invoice accuracy, and regulatory compliance. Enables procurement and supply chain leadership to manage vendor relationships, identify underperformers, and mitigate supply risk."
  source: "`agriculture_ecm`.`procurement`.`vendor`"
  dimensions:
    - name: "vendor_type"
      expr: vendor_type
      comment: "Classification of the vendor (e.g. Seed Supplier, Chemical Distributor, Equipment Vendor) — primary segmentation for vendor portfolio analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status of the vendor (e.g. Qualified, Probationary, Suspended) — critical for supply risk and approved vendor list management."
    - name: "overall_scorecard_rating"
      expr: overall_scorecard_rating
      comment: "Composite vendor scorecard rating — executive-level vendor performance tier for strategic sourcing decisions."
    - name: "country_code"
      expr: country_code
      comment: "Country of the vendor — supports geographic supply chain diversification and trade compliance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Default transaction currency for the vendor — used in multi-currency spend and payment analysis."
    - name: "fsma_svcp_compliant"
      expr: fsma_svcp_compliant
      comment: "Indicates FSMA Supplier Verification Control Program compliance — regulatory risk dimension for food safety governance."
    - name: "sds_compliance_flag"
      expr: sds_compliance_flag
      comment: "Indicates whether the vendor maintains current Safety Data Sheets — chemical safety compliance dimension."
    - name: "requalification_due_date_month"
      expr: DATE_TRUNC('MONTH', requalification_due_date)
      comment: "Month when vendor requalification is due — used to proactively manage vendor qualification renewal pipeline."
    - name: "last_audit_date_month"
      expr: DATE_TRUNC('MONTH', last_audit_date)
      comment: "Month of the most recent vendor audit — supports audit cycle management and compliance monitoring."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Standard payment terms for the vendor — used in cash flow and working capital analysis."
  measures:
    - name: "total_vendor_count"
      expr: COUNT(1)
      comment: "Total number of vendors in the approved vendor master — baseline measure for supply base size and diversity tracking."
    - name: "qualified_vendor_count"
      expr: COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END)
      comment: "Number of fully qualified vendors — measures the size of the approved supply base available for procurement."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across vendors — primary supply reliability KPI used in vendor scorecards and sourcing decisions."
    - name: "avg_quality_acceptance_rate"
      expr: AVG(CAST(quality_acceptance_rate AS DOUBLE))
      comment: "Average quality acceptance rate across vendors — measures incoming material quality and vendor quality management effectiveness."
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate across vendors — measures billing quality and AP processing efficiency impact."
    - name: "avg_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average order fill rate across vendors — measures vendor ability to fulfill ordered quantities, critical for agricultural input availability planning."
    - name: "avg_regulatory_compliance_score"
      expr: AVG(CAST(regulatory_compliance_score AS DOUBLE))
      comment: "Average regulatory compliance score across vendors — executive KPI for supply chain regulatory risk exposure."
    - name: "avg_last_audit_score"
      expr: AVG(CAST(last_audit_score AS DOUBLE))
      comment: "Average vendor audit score — measures overall vendor quality management system performance across the supply base."
    - name: "fsma_compliant_vendor_count"
      expr: COUNT(CASE WHEN fsma_svcp_compliant = TRUE THEN 1 END)
      comment: "Number of vendors compliant with FSMA Supplier Verification Control Program — regulatory compliance KPI for food safety risk management."
    - name: "vendors_due_requalification_count"
      expr: COUNT(CASE WHEN requalification_due_date <= CURRENT_DATE() THEN 1 END)
      comment: "Number of vendors with overdue requalification — operational risk KPI for procurement compliance and supply continuity management."
    - name: "high_performing_vendor_count"
      expr: COUNT(CASE WHEN on_time_delivery_rate >= 95.0 AND quality_acceptance_rate >= 95.0 THEN 1 END)
      comment: "Number of vendors meeting both on-time delivery and quality acceptance thresholds of 95%+ — strategic KPI for preferred vendor identification and partnership investment decisions."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`procurement_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice KPIs covering payment liability, dispute management, three-way match compliance, and early payment discount capture. Enables finance and procurement leadership to manage payables efficiency, cash flow, and vendor invoice quality."
  source: "`agriculture_ecm`.`procurement`.`procurement_ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the AP invoice (e.g. Pending, Approved, Paid, Disputed) — primary dimension for payables pipeline management."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g. Standard, Credit Note, Debit Memo) — used to segment payables by transaction type."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the invoice — identifies bottlenecks in the AP authorization process."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of the three-way match (PO / GR / Invoice) — critical compliance dimension for procurement controls and audit readiness."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the invoice is under dispute — used to isolate disputed payables for resolution tracking."
    - name: "dispute_type"
      expr: dispute_type
      comment: "Category of invoice dispute (e.g. Price, Quantity, Quality) — enables root cause analysis of AP disputes."
    - name: "input_category"
      expr: input_category
      comment: "Agricultural input category of the invoiced goods — enables spend analysis by input type."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency — supports multi-currency payables analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms on the invoice — used for cash flow forecasting and early payment discount analysis."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date — primary time dimension for AP aging and period-over-period payables trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month payment is due — used for cash flow forecasting and payment scheduling."
    - name: "match_discrepancy_type"
      expr: match_discrepancy_type
      comment: "Type of three-way match discrepancy (e.g. Price Variance, Quantity Variance) — root cause dimension for invoice matching failures."
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices — baseline volume metric for payables processing throughput."
    - name: "total_gross_payable_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross payable amount across all invoices — primary AP liability KPI for cash flow management and financial close."
    - name: "total_net_payable_amount"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net amount payable after discounts and adjustments — actual cash outflow KPI for treasury and working capital management."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AP invoices — supports tax accrual, VAT reclaim, and financial reporting."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total value of invoices under dispute — measures financial exposure from AP disputes and vendor billing quality issues."
    - name: "total_match_discrepancy_amount"
      expr: SUM(CAST(match_discrepancy_amount AS DOUBLE))
      comment: "Total value of three-way match discrepancies — KPI for procurement controls effectiveness and invoice accuracy."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices currently under dispute — operational KPI for AP dispute resolution workload and vendor relationship health."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices under dispute — executive KPI for vendor invoice quality and AP process efficiency."
    - name: "three_way_match_pass_count"
      expr: COUNT(CASE WHEN three_way_match_status = 'Matched' THEN 1 END)
      comment: "Number of invoices that passed three-way match — measures procurement controls compliance and straight-through processing rate."
    - name: "three_way_match_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN three_way_match_status = 'Matched' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices passing three-way match — primary AP controls KPI; low rates indicate systemic procurement or receiving process failures."
    - name: "early_payment_discount_eligible_count"
      expr: COUNT(CASE WHEN early_payment_discount_pct > 0 THEN 1 END)
      comment: "Number of invoices eligible for early payment discount — identifies cash management opportunities for working capital optimization."
    - name: "avg_early_payment_discount_pct"
      expr: AVG(CAST(early_payment_discount_pct AS DOUBLE))
      comment: "Average early payment discount percentage available — used to quantify the financial benefit of accelerating AP payments."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt KPIs covering receiving accuracy, quality acceptance, rejection rates, and temperature compliance. Enables supply chain and quality leadership to monitor inbound material quality, receiving efficiency, and food safety compliance at the point of receipt."
  source: "`agriculture_ecm`.`procurement`.`procurement_goods_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the goods receipt (e.g. Posted, Pending, Reversed) — primary dimension for receiving pipeline management."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome for the received goods — used to segment receipts by quality disposition."
    - name: "invoice_match_status"
      expr: invoice_match_status
      comment: "Status of invoice matching for this receipt — identifies GR records contributing to AP three-way match failures."
    - name: "input_category"
      expr: input_category
      comment: "Agricultural input category of received goods — primary segmentation for inbound quality and volume analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of received goods — supports trade compliance and supply chain traceability."
    - name: "gmo_status"
      expr: gmo_status
      comment: "GMO status of received material — regulatory and consumer transparency dimension."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for received quantities — required for accurate volume aggregation and comparison."
    - name: "temperature_exceedance_flag"
      expr: temperature_exceedance_flag
      comment: "Indicates whether temperature limits were exceeded at receipt — food safety and cold chain compliance dimension."
    - name: "mrl_testing_required"
      expr: mrl_testing_required
      comment: "Indicates whether Maximum Residue Level testing is required for this receipt — regulatory compliance dimension for chemical inputs."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the goods receipt was posted — primary time dimension for inbound volume and quality trend analysis."
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Reason code for rejected quantities — root cause dimension for inbound quality failure analysis."
    - name: "coa_received"
      expr: coa_received
      comment: "Indicates whether a Certificate of Analysis was received with the shipment — compliance dimension for regulated inputs."
  measures:
    - name: "total_receipt_count"
      expr: COUNT(1)
      comment: "Total number of goods receipts — baseline volume metric for inbound supply chain activity."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received across all goods receipts — primary inbound volume KPI for supply planning and inventory management."
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total quantity accepted after quality inspection — measures usable inbound supply and vendor quality performance."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at receipt — KPI for inbound quality failures, vendor performance, and supply disruption risk."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered per goods receipt — used as denominator for fill rate and receipt accuracy calculations."
    - name: "total_receipt_value"
      expr: SUM(CAST(total_receipt_value AS DOUBLE))
      comment: "Total value of goods received — primary financial KPI for inventory valuation and AP accrual at receipt."
    - name: "quality_rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity rejected due to quality failures — executive KPI for vendor quality management and inbound supply risk."
    - name: "receipt_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity actually received — measures vendor delivery completeness and supply reliability."
    - name: "temperature_exceedance_count"
      expr: COUNT(CASE WHEN temperature_exceedance_flag = TRUE THEN 1 END)
      comment: "Number of receipts with temperature exceedances — food safety and cold chain compliance KPI requiring immediate operational response."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price of received goods — used for price variance analysis against PO and contract pricing."
    - name: "avg_temperature_at_receipt"
      expr: AVG(CAST(temperature_at_receipt_c AS DOUBLE))
      comment: "Average temperature recorded at receipt in Celsius — cold chain monitoring KPI for perishable and temperature-sensitive agricultural inputs."
    - name: "coa_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN coa_received = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts accompanied by a Certificate of Analysis — regulatory compliance KPI for chemical and seed inputs."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`procurement_vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor contract portfolio KPIs covering contract value, volume commitments, pricing, and compliance requirements. Enables procurement leadership to manage contract coverage, renewal risk, and strategic sourcing commitments across the agricultural input supply base."
  source: "`agriculture_ecm`.`procurement`.`vendor_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the vendor contract (e.g. Active, Expired, Pending Renewal) — primary dimension for contract portfolio health management."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of vendor contract (e.g. Fixed Price, Volume-Based, Framework) — used to segment contract portfolio by commercial structure."
    - name: "price_type"
      expr: price_type
      comment: "Pricing mechanism in the contract (e.g. Fixed, Market-Linked, Formula) — critical for commodity price risk management."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency — supports multi-currency contract value analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the contract auto-renews — used to identify contracts requiring proactive renewal management."
    - name: "organic_certification_required"
      expr: organic_certification_required
      comment: "Indicates whether organic certification is required under the contract — supports organic supply chain compliance tracking."
    - name: "epa_registration_required"
      expr: epa_registration_required
      comment: "Indicates whether EPA registration is required — regulatory compliance dimension for chemical input contracts."
    - name: "penalty_clause_flag"
      expr: penalty_clause_flag
      comment: "Indicates whether the contract contains penalty clauses — risk dimension for contract performance management."
    - name: "force_majeure_flag"
      expr: force_majeure_flag
      comment: "Indicates whether force majeure provisions are active — supply continuity risk dimension."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the contract became effective — used for contract cohort analysis and portfolio vintage tracking."
    - name: "end_date_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the contract expires — primary dimension for contract renewal pipeline management."
    - name: "delivery_terms"
      expr: delivery_terms
      comment: "Delivery terms specified in the contract — used for supply chain risk and logistics cost analysis."
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of vendor contracts — baseline measure for contract portfolio size and coverage."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Number of currently active vendor contracts — measures live contract coverage of the procurement supply base."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total committed contract value across all vendor contracts — primary KPI for procurement spend under contract and strategic sourcing coverage."
    - name: "total_released_value"
      expr: SUM(CAST(released_value AS DOUBLE))
      comment: "Total value released (called off) against contracts — measures contract utilization and procurement execution against strategic commitments."
    - name: "total_contracted_volume"
      expr: SUM(CAST(contracted_volume AS DOUBLE))
      comment: "Total volume committed under vendor contracts — critical for agricultural input supply planning and seasonal availability assurance."
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price across vendor contracts — used for price benchmarking and negotiation performance tracking."
    - name: "contract_release_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(released_value AS DOUBLE)) / NULLIF(SUM(CAST(contract_value AS DOUBLE)), 0), 2)
      comment: "Percentage of total contract value that has been released/called off — measures contract utilization efficiency and procurement execution against strategic commitments."
    - name: "expiring_contract_count"
      expr: COUNT(CASE WHEN end_date <= DATE_ADD(CURRENT_DATE(), 90) AND contract_status = 'Active' THEN 1 END)
      comment: "Number of active contracts expiring within 90 days — operational risk KPI for procurement leadership to prioritize contract renewal negotiations."
    - name: "contracts_with_penalty_clause_count"
      expr: COUNT(CASE WHEN penalty_clause_flag = TRUE THEN 1 END)
      comment: "Number of contracts containing penalty clauses — risk exposure KPI for procurement performance management and vendor relationship governance."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with active contracts — measures strategic supplier relationship breadth and supply base concentration."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase requisition pipeline KPIs covering demand origination, approval cycle efficiency, budget availability, and conversion to purchase orders. Enables procurement operations to monitor demand-to-order cycle performance and identify process bottlenecks."
  source: "`agriculture_ecm`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the purchase requisition (e.g. Draft, Pending Approval, Approved, Converted) — primary dimension for PR pipeline management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the requisition — identifies authorization bottlenecks in the procurement demand pipeline."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval authority level required for the requisition — used to analyze approval workload distribution and escalation patterns."
    - name: "input_category"
      expr: input_category
      comment: "Agricultural input category requested — primary demand segmentation dimension for procurement planning."
    - name: "priority"
      expr: priority
      comment: "Priority level of the requisition (e.g. Urgent, Normal, Low) — used to triage procurement demand and manage critical input availability."
    - name: "requesting_department"
      expr: requesting_department
      comment: "Department originating the requisition — enables demand analysis by organizational unit and cost center."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the requisition — supports multi-currency demand analysis."
    - name: "converted_to_po_flag"
      expr: converted_to_po_flag
      comment: "Indicates whether the requisition has been converted to a purchase order — key conversion funnel dimension."
    - name: "budget_available_flag"
      expr: budget_available_flag
      comment: "Indicates whether budget was available at time of requisition — used to identify demand blocked by budget constraints."
    - name: "regulatory_approval_required_flag"
      expr: regulatory_approval_required_flag
      comment: "Indicates whether regulatory approval is required — compliance dimension for controlled agricultural inputs."
    - name: "requisition_date_month"
      expr: DATE_TRUNC('MONTH', requisition_date)
      comment: "Month the requisition was created — primary time dimension for demand trend analysis and seasonal procurement planning."
    - name: "required_delivery_date_month"
      expr: DATE_TRUNC('MONTH', required_delivery_date)
      comment: "Month the requested delivery is needed — used for demand timing analysis and procurement lead time planning."
  measures:
    - name: "total_requisition_count"
      expr: COUNT(1)
      comment: "Total number of purchase requisitions — baseline volume metric for procurement demand pipeline activity."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Total estimated cost of all requisitions — forward-looking spend demand KPI for budget planning and procurement workload forecasting."
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested across all requisitions — demand volume KPI for supply planning and vendor capacity alignment."
    - name: "avg_estimated_unit_cost"
      expr: AVG(CAST(estimated_unit_cost AS DOUBLE))
      comment: "Average estimated unit cost across requisitions — used for price benchmarking and budget estimation accuracy analysis."
    - name: "converted_to_po_count"
      expr: COUNT(CASE WHEN converted_to_po_flag = TRUE THEN 1 END)
      comment: "Number of requisitions successfully converted to purchase orders — measures procurement execution throughput."
    - name: "pr_to_po_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN converted_to_po_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of purchase requisitions converted to purchase orders — primary procurement process efficiency KPI measuring demand fulfillment rate."
    - name: "pending_approval_requisition_count"
      expr: COUNT(CASE WHEN approval_status NOT IN ('Approved', 'Rejected', 'Cancelled') THEN 1 END)
      comment: "Number of requisitions awaiting approval — operational KPI for identifying authorization bottlenecks and procurement cycle delays."
    - name: "budget_blocked_requisition_count"
      expr: COUNT(CASE WHEN budget_available_flag = FALSE THEN 1 END)
      comment: "Number of requisitions blocked due to insufficient budget — KPI for identifying demand constrained by budget availability, informing budget reallocation decisions."
    - name: "urgent_requisition_count"
      expr: COUNT(CASE WHEN priority = 'Urgent' THEN 1 END)
      comment: "Number of urgent priority requisitions — operational risk KPI for identifying critical input shortages requiring expedited procurement action."
    - name: "total_estimated_cost_pending"
      expr: SUM(CASE WHEN converted_to_po_flag = FALSE AND approval_status NOT IN ('Rejected', 'Cancelled') THEN CAST(estimated_total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total estimated cost of requisitions not yet converted to POs — forward procurement liability KPI for cash flow and budget commitment forecasting."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`procurement_delivery_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery schedule KPIs covering on-time delivery performance, quantity fulfillment, and schedule adherence for agricultural input deliveries. Enables supply chain and procurement operations to monitor vendor delivery reliability and identify supply continuity risks."
  source: "`agriculture_ecm`.`procurement`.`delivery_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the delivery schedule line (e.g. Scheduled, In Transit, Delivered, Delayed) — primary dimension for delivery pipeline management."
    - name: "input_category"
      expr: input_category
      comment: "Agricultural input category being delivered — primary segmentation for delivery performance analysis by input type."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the delivery (e.g. Truck, Rail, Air) — used for logistics cost and lead time analysis."
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "Incoterms governing the delivery — used for supply chain risk and cost responsibility analysis."
    - name: "delivery_location_type"
      expr: delivery_location_type
      comment: "Type of delivery destination (e.g. Farm, Warehouse, Field) — used to analyze delivery patterns by location type."
    - name: "is_perishable"
      expr: is_perishable
      comment: "Indicates whether the delivered goods are perishable — critical dimension for cold chain and time-sensitive delivery monitoring."
    - name: "phi_compliance_required"
      expr: phi_compliance_required
      comment: "Indicates whether Pre-Harvest Interval compliance is required — regulatory dimension for chemical input deliveries."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the delivery schedule line — supports multi-currency delivery value analysis."
    - name: "planned_delivery_date_month"
      expr: DATE_TRUNC('MONTH', planned_delivery_date)
      comment: "Month of planned delivery — primary time dimension for delivery schedule analysis and seasonal supply planning."
    - name: "actual_delivery_date_month"
      expr: DATE_TRUNC('MONTH', actual_delivery_date)
      comment: "Month of actual delivery — used for on-time delivery trend analysis and seasonal performance benchmarking."
    - name: "delay_reason"
      expr: delay_reason
      comment: "Root cause of delivery delay — used for supply chain disruption analysis and vendor performance improvement."
    - name: "seasonal_program"
      expr: seasonal_program
      comment: "Seasonal procurement program associated with the delivery — used to track delivery performance within seasonal input programs."
  measures:
    - name: "total_scheduled_deliveries"
      expr: COUNT(1)
      comment: "Total number of delivery schedule lines — baseline volume metric for inbound supply chain activity."
    - name: "total_scheduled_quantity"
      expr: SUM(CAST(scheduled_quantity AS DOUBLE))
      comment: "Total quantity scheduled for delivery — primary supply planning KPI for input availability forecasting."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity actually received against delivery schedules — measures vendor delivery fulfillment against commitments."
    - name: "total_delivery_value"
      expr: SUM(CAST(unit_price * received_quantity AS DOUBLE))
      comment: "Total value of goods received based on unit price and received quantity — financial KPI for inbound inventory valuation."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date <= planned_delivery_date THEN 1 END)
      comment: "Number of deliveries completed on or before the planned delivery date — measures vendor delivery reliability."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date <= planned_delivery_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed deliveries that arrived on time — primary vendor delivery performance KPI for supply chain reliability management."
    - name: "delivery_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(scheduled_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of scheduled quantity actually received — measures vendor order fulfillment completeness and supply availability risk."
    - name: "delayed_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date > planned_delivery_date THEN 1 END)
      comment: "Number of deliveries that arrived after the planned delivery date — operational KPI for supply disruption monitoring and vendor performance management."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across delivery schedule lines — used for price variance analysis against contract and PO pricing."
    - name: "perishable_delivery_count"
      expr: COUNT(CASE WHEN is_perishable = TRUE THEN 1 END)
      comment: "Number of deliveries involving perishable goods — used to size cold chain management requirements and prioritize time-sensitive delivery monitoring."
$$;