-- Metric views for domain: procurement | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 15:12:58

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for procurement purchase orders — tracks spend volume, order cycle efficiency, compliance, and supplier concentration to steer sourcing decisions."
  source: "`vibe_restaurants_v1`.`procurement`.`procurement_purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g., Draft, Approved, Received, Closed) for pipeline analysis."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g., Standard, Blanket, Emergency) to segment spend by procurement strategy."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status to identify bottlenecks in the PO authorization process."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency spend analysis and FX exposure reporting."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of order placement for trend analysis of procurement spend over time."
    - name: "priority"
      expr: priority
      comment: "Order priority level (e.g., Urgent, Normal) to assess emergency procurement frequency."
    - name: "is_urgent"
      expr: is_urgent
      comment: "Flag indicating whether the PO was raised as urgent, used to track reactive vs. planned procurement."
    - name: "receipt_status"
      expr: receipt_status
      comment: "Goods receipt status to monitor fulfillment completion and open order exposure."
    - name: "category_code"
      expr: category_code
      comment: "Spend category code for category-level procurement analysis and budget alignment."
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders raised — baseline volume metric for procurement activity."
    - name: "total_gross_spend"
      expr: SUM(CAST(total_amount_gross AS DOUBLE))
      comment: "Total gross procurement spend across all POs — primary financial KPI for budget vs. actuals tracking."
    - name: "total_net_spend"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net spend after discounts — used for true cost-of-goods analysis and savings measurement."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability on procurement orders — supports tax accrual and compliance reporting."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value captured across POs — measures effectiveness of negotiated pricing terms."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight and logistics cost — key input for total landed cost and logistics efficiency analysis."
    - name: "avg_po_gross_value"
      expr: AVG(CAST(total_amount_gross AS DOUBLE))
      comment: "Average gross value per purchase order — indicates order sizing trends and consolidation opportunities."
    - name: "urgent_po_count"
      expr: COUNT(CASE WHEN is_urgent = TRUE THEN 1 END)
      comment: "Number of urgent purchase orders — high values signal supply chain disruptions or poor demand planning."
    - name: "compliant_po_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Number of POs meeting compliance requirements — used to track procurement policy adherence."
    - name: "consolidated_po_count"
      expr: COUNT(CASE WHEN is_consolidated = TRUE THEN 1 END)
      comment: "Number of consolidated purchase orders — measures supplier consolidation and volume leverage effectiveness."
    - name: "avg_total_weight_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average weight per purchase order in kilograms — supports logistics planning and freight cost benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance KPIs derived from scorecards — tracks delivery reliability, quality, invoice accuracy, and overall supplier health to drive vendor management decisions."
  source: "`vibe_restaurants_v1`.`procurement`.`supplier_scorecard`"
  dimensions:
    - name: "supplier_category"
      expr: supplier_category
      comment: "Category of goods or services supplied — enables category-level supplier performance benchmarking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Supplier compliance status at time of evaluation — flags non-compliant suppliers for remediation."
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level of the supplier — critical for supply chain risk management and contingency planning."
    - name: "region"
      expr: region
      comment: "Geographic region of the supplier — supports regional sourcing strategy and risk diversification analysis."
    - name: "evaluation_period_start_month"
      expr: DATE_TRUNC('MONTH', evaluation_period_start)
      comment: "Month of evaluation period start for trend analysis of supplier performance over time."
    - name: "evaluator_department"
      expr: evaluator_department
      comment: "Department conducting the evaluation — identifies which business units are driving supplier assessments."
  measures:
    - name: "total_scorecards"
      expr: COUNT(1)
      comment: "Total number of supplier scorecards completed — baseline for supplier evaluation program coverage."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier performance score — primary KPI for vendor health and relationship management."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across evaluated suppliers — directly impacts restaurant operations and food availability."
    - name: "avg_quality_rejection_rate"
      expr: AVG(CAST(quality_rejection_rate AS DOUBLE))
      comment: "Average quality rejection rate — high values indicate supplier quality issues driving waste and rework costs."
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate — measures billing quality and AP processing efficiency with suppliers."
    - name: "avg_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average order fill rate — measures supplier ability to fulfill ordered quantities, critical for inventory planning."
    - name: "avg_cost_savings_percent"
      expr: AVG(CAST(cost_savings_percent AS DOUBLE))
      comment: "Average cost savings percentage achieved through supplier relationships — measures procurement value delivery."
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average supplier responsiveness score — indicates supplier service quality and issue resolution speed."
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score — tracks ESG compliance and sustainability performance across the supplier base."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(average_lead_time_days AS DOUBLE))
      comment: "Average supplier lead time in days — key input for inventory safety stock and replenishment planning."
    - name: "distinct_suppliers_evaluated"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers evaluated — measures breadth of supplier performance monitoring program."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_supplier_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and invoice management KPIs — tracks invoice volumes, payment performance, dispute rates, and cost accuracy to manage cash flow and supplier relationships."
  source: "`vibe_restaurants_v1`.`procurement`.`supplier_invoice`"
  dimensions:
    - name: "supplier_invoice_status"
      expr: supplier_invoice_status
      comment: "Current status of the invoice (e.g., Pending, Approved, Paid, Disputed) for AP pipeline management."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., Standard, Credit Note, Debit Note) for invoice mix analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Invoice approval workflow status — identifies bottlenecks in the AP approval process."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Flag indicating whether the invoice is under dispute — used to track supplier billing accuracy issues."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for AP accrual trending and period-over-period spend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AP exposure and FX risk reporting."
    - name: "category_code"
      expr: category_code
      comment: "Spend category code for category-level invoice and cost analysis."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Whether the invoice is tax-exempt — supports tax compliance and reporting."
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of supplier invoices — baseline AP volume metric."
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice value — primary AP liability metric for cash flow and budget management."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts — true cost basis for supplier spend reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on supplier invoices — supports tax accrual and compliance reporting."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment and negotiated discounts captured — measures AP discount optimization performance."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN is_disputed = TRUE THEN 1 END)
      comment: "Number of disputed invoices — high values indicate supplier billing quality issues requiring resolution."
    - name: "avg_gross_invoice_value"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice value — used to benchmark invoice sizing and identify outliers."
    - name: "avg_cogs_percentage"
      expr: AVG(CAST(cogs_percentage AS DOUBLE))
      comment: "Average cost-of-goods-sold percentage on invoices — key input for food cost and margin analysis."
    - name: "distinct_suppliers_invoiced"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers invoiced — measures active supplier base breadth in AP."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_supplier_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain risk KPIs — tracks supplier risk scores, financial stability, single-source dependencies, and compliance flags to protect supply continuity and regulatory standing."
  source: "`vibe_restaurants_v1`.`procurement`.`supplier_risk`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of risk (e.g., Financial, Operational, Compliance, Geopolitical) for risk portfolio analysis."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier classification (e.g., Critical, High, Medium, Low) for prioritizing mitigation efforts."
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk assessment — identifies open vs. mitigated risks."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the supplier — supports regional supply chain risk concentration analysis."
    - name: "single_source_dependency"
      expr: single_source_dependency
      comment: "Flag for single-source supplier dependency — critical for supply continuity risk management."
    - name: "compliance_fda_flag"
      expr: compliance_fda_flag
      comment: "FDA compliance flag — identifies suppliers with food safety regulatory compliance issues."
    - name: "compliance_osha_flag"
      expr: compliance_osha_flag
      comment: "OSHA compliance flag — identifies suppliers with workplace safety compliance issues."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_timestamp)
      comment: "Month of risk assessment for trend analysis of supplier risk profile changes over time."
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total number of supplier risk assessments — measures coverage of the risk monitoring program."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average supplier risk score — primary KPI for overall supply chain risk exposure level."
    - name: "avg_financial_stability_score"
      expr: AVG(CAST(financial_stability_score AS DOUBLE))
      comment: "Average financial stability score across suppliers — identifies financially vulnerable suppliers that could disrupt supply."
    - name: "avg_dependency_percentage"
      expr: AVG(CAST(dependency_percentage AS DOUBLE))
      comment: "Average spend dependency percentage per supplier — high values indicate dangerous supply concentration risk."
    - name: "single_source_supplier_count"
      expr: COUNT(CASE WHEN single_source_dependency = TRUE THEN 1 END)
      comment: "Number of single-source supplier dependencies — critical risk metric requiring executive attention and diversification planning."
    - name: "fda_non_compliant_count"
      expr: COUNT(CASE WHEN compliance_fda_flag = FALSE THEN 1 END)
      comment: "Number of suppliers with FDA compliance issues — directly impacts food safety regulatory risk."
    - name: "distinct_high_risk_suppliers"
      expr: COUNT(DISTINCT CASE WHEN risk_tier IN ('Critical', 'High') THEN procurement_supplier_id END)
      comment: "Number of distinct suppliers in Critical or High risk tiers — key metric for supply chain resilience planning."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_sourcing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic sourcing KPIs — tracks sourcing event activity, award values, and competitive bidding effectiveness to measure procurement value creation."
  source: "`vibe_restaurants_v1`.`procurement`.`sourcing_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of sourcing event (e.g., RFP, RFQ, Auction) — used to analyze sourcing strategy mix and effectiveness."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the sourcing event (e.g., Draft, Active, Awarded, Closed) for pipeline management."
    - name: "category_scope"
      expr: category_scope
      comment: "Spend category scope of the sourcing event — enables category-level sourcing activity analysis."
    - name: "is_confidential"
      expr: is_confidential
      comment: "Confidentiality flag for the sourcing event — used for access control and reporting segmentation."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_timestamp)
      comment: "Month the sourcing event started — for trend analysis of sourcing activity volume over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the sourcing event budget and award — for multi-currency sourcing portfolio analysis."
  measures:
    - name: "total_sourcing_events"
      expr: COUNT(1)
      comment: "Total number of sourcing events — baseline metric for strategic sourcing program activity."
    - name: "total_award_amount"
      expr: SUM(CAST(award_amount AS DOUBLE))
      comment: "Total value awarded through sourcing events — measures procurement value creation and contract coverage."
    - name: "total_sourcing_budget"
      expr: SUM(CAST(total_budget AS DOUBLE))
      comment: "Total budget allocated to sourcing events — used to track sourcing investment and ROI."
    - name: "avg_award_amount"
      expr: AVG(CAST(award_amount AS DOUBLE))
      comment: "Average award value per sourcing event — benchmarks deal size and sourcing event efficiency."
    - name: "awarded_event_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'Awarded' THEN 1 END)
      comment: "Number of sourcing events that resulted in an award — measures sourcing completion rate."
    - name: "distinct_suppliers_engaged"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers engaged in sourcing events — measures competitive bidding breadth."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_sourcing_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitive bidding KPIs — tracks supplier bid quality, pricing competitiveness, and award rates to optimize sourcing outcomes and supplier selection."
  source: "`vibe_restaurants_v1`.`procurement`.`sourcing_response`"
  dimensions:
    - name: "award_status"
      expr: award_status
      comment: "Whether the bid was awarded — used to analyze win rates and competitive dynamics."
    - name: "bid_type"
      expr: bid_type
      comment: "Type of bid submitted (e.g., Initial, Best and Final) — for bid round analysis."
    - name: "sourcing_response_status"
      expr: sourcing_response_status
      comment: "Current status of the sourcing response (e.g., Submitted, Evaluated, Awarded, Rejected)."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assessed for the supplier response — used to balance cost vs. risk in award decisions."
    - name: "is_eligible"
      expr: is_eligible
      comment: "Whether the supplier response met eligibility criteria — tracks disqualification rates."
    - name: "is_preferred_supplier"
      expr: is_preferred_supplier
      comment: "Whether the responding supplier is on the preferred vendor list — measures preferred supplier participation."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of bid submission for trend analysis of sourcing response activity."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bid — for multi-currency price comparison analysis."
  measures:
    - name: "total_responses"
      expr: COUNT(1)
      comment: "Total number of sourcing responses received — measures competitive bidding participation."
    - name: "avg_net_price"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net bid price — primary metric for price competitiveness analysis across supplier responses."
    - name: "avg_scoring_total"
      expr: AVG(CAST(scoring_total AS DOUBLE))
      comment: "Average total evaluation score across responses — measures overall bid quality and supplier capability."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score of supplier responses — tracks regulatory and specification adherence in bids."
    - name: "avg_supplier_rating"
      expr: AVG(CAST(supplier_rating AS DOUBLE))
      comment: "Average supplier rating at time of response — correlates historical performance with bid outcomes."
    - name: "total_bid_value"
      expr: SUM(CAST(total_price AS DOUBLE))
      comment: "Total value of all bids received — measures market pricing depth and competitive tension."
    - name: "eligible_response_count"
      expr: COUNT(CASE WHEN is_eligible = TRUE THEN 1 END)
      comment: "Number of eligible supplier responses — measures effective competitive pool size for sourcing decisions."
    - name: "distinct_bidding_suppliers"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers submitting bids — measures supplier market engagement and competition level."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_vendor_rebate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor rebate program KPIs — tracks earned, accrued, and paid rebate amounts to maximize procurement cost recovery and manage supplier incentive programs."
  source: "`vibe_restaurants_v1`.`procurement`.`vendor_rebate`"
  dimensions:
    - name: "rebate_type"
      expr: rebate_type
      comment: "Type of rebate (e.g., Volume, Growth, Promotional) — for rebate program mix and strategy analysis."
    - name: "rebate_status"
      expr: rebate_status
      comment: "Current status of the rebate (e.g., Accruing, Earned, Paid, Expired) — for rebate pipeline management."
    - name: "accrual_status"
      expr: accrual_status
      comment: "Accrual status of the rebate — used to track financial accrual accuracy and period-end close."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the rebate — identifies outstanding rebate receivables requiring follow-up."
    - name: "rebate_program"
      expr: rebate_program
      comment: "Name of the rebate program — enables program-level performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rebate — for multi-currency rebate portfolio reporting."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month of rebate period start — for trend analysis of rebate earnings over time."
    - name: "is_active"
      expr: is_active
      comment: "Whether the rebate program is currently active — filters active vs. historical rebate analysis."
  measures:
    - name: "total_rebate_programs"
      expr: COUNT(1)
      comment: "Total number of vendor rebate records — baseline metric for rebate program coverage."
    - name: "total_earned_amount"
      expr: SUM(CAST(earned_amount AS DOUBLE))
      comment: "Total rebate amount earned — primary KPI for procurement cost recovery through supplier incentive programs."
    - name: "total_accrued_amount"
      expr: SUM(CAST(accrued_amount AS DOUBLE))
      comment: "Total rebate amount accrued — used for financial period-end accrual and balance sheet accuracy."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total rebate amount actually received — measures cash realization of earned rebates."
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate value across all programs — aggregate cost reduction metric for procurement reporting."
    - name: "total_threshold_amount"
      expr: SUM(CAST(threshold_amount AS DOUBLE))
      comment: "Total spend threshold required to earn rebates — used to assess rebate attainment gap and purchasing strategy."
    - name: "avg_rebate_rate_percent"
      expr: AVG(CAST(rebate_rate_percent AS DOUBLE))
      comment: "Average rebate rate percentage — benchmarks rebate program competitiveness across suppliers."
    - name: "distinct_suppliers_with_rebates"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers with active rebate programs — measures rebate program breadth across supplier base."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_approved_vendor_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor qualification and compliance KPIs — tracks approved vendor status, risk scores, and audit results to maintain a compliant and high-quality supplier base."
  source: "`vibe_restaurants_v1`.`procurement`.`approved_vendor_list`"
  dimensions:
    - name: "approved_status"
      expr: approved_status
      comment: "Current approval status of the vendor (e.g., Approved, Pending, Suspended, Disqualified)."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor (e.g., Distributor, Manufacturer, Broker) for vendor base composition analysis."
    - name: "vendor_category_code"
      expr: vendor_category_code
      comment: "Category code of the vendor — enables category-level approved vendor analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the vendor — identifies non-compliant vendors requiring remediation."
    - name: "is_currently_approved"
      expr: is_currently_approved
      comment: "Whether the vendor is currently approved — primary filter for active vendor base reporting."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Whether the vendor is designated as preferred — used to track preferred vendor utilization."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the vendor approval — for regional vendor base analysis."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month of vendor approval — for trend analysis of vendor onboarding activity."
  measures:
    - name: "total_vendor_records"
      expr: COUNT(1)
      comment: "Total number of approved vendor list records — baseline metric for vendor base size."
    - name: "currently_approved_vendor_count"
      expr: COUNT(CASE WHEN is_currently_approved = TRUE THEN 1 END)
      comment: "Number of currently approved vendors — measures active qualified supplier base size."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average vendor risk score — primary KPI for overall approved vendor base risk profile."
    - name: "avg_vendor_rating"
      expr: AVG(CAST(vendor_rating AS DOUBLE))
      comment: "Average vendor rating — measures overall quality of the approved vendor base."
    - name: "preferred_vendor_count"
      expr: COUNT(CASE WHEN preferred_vendor_flag = TRUE THEN 1 END)
      comment: "Number of preferred vendors — measures strategic vendor concentration and preferred sourcing coverage."
    - name: "disqualified_vendor_count"
      expr: COUNT(CASE WHEN approved_status = 'Disqualified' THEN 1 END)
      comment: "Number of disqualified vendors — tracks vendor quality failures and supply base attrition."
    - name: "distinct_approved_suppliers"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct approved suppliers — measures breadth of qualified supply base."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract portfolio KPIs — tracks contract coverage, value, compliance, and renewal pipeline to maximize procurement leverage and minimize contractual risk."
  source: "`vibe_restaurants_v1`.`procurement`.`contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract (e.g., Active, Expired, Terminated, Pending) for portfolio management."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., Master Supply, Framework, Spot) — for contract strategy mix analysis."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model used in the contract (e.g., Fixed, Cost-Plus, Index-Linked) — for pricing strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency — for multi-currency contract portfolio reporting."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the contract auto-renews — used to manage renewal pipeline and avoid unintended commitments."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the contract includes exclusivity terms — tracks supply exclusivity exposure."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the contract became effective — for contract vintage and cohort analysis."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the contract — for access control and reporting segmentation."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of contracts in the portfolio — baseline metric for contract coverage."
    - name: "total_contract_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total committed contract value — primary KPI for procurement spend under contract and coverage ratio."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_value AS DOUBLE))
      comment: "Average contract value — benchmarks deal size and identifies opportunities for contract consolidation."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average negotiated discount rate across contracts — measures procurement negotiation effectiveness."
    - name: "avg_rebate_terms"
      expr: AVG(CAST(rebate_terms AS DOUBLE))
      comment: "Average rebate terms value across contracts — measures rebate program coverage in contract portfolio."
    - name: "auto_renewal_contract_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of contracts with auto-renewal — identifies contracts requiring proactive review to avoid unintended renewals."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Number of currently active contracts — measures active contract coverage of procurement spend."
    - name: "distinct_suppliers_under_contract"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers with active contracts — measures contracted supply base breadth."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier master KPIs — tracks supplier base composition, financial exposure, risk profile, and spend concentration to support strategic supplier relationship management."
  source: "`vibe_restaurants_v1`.`procurement`.`procurement_supplier`"
  dimensions:
    - name: "procurement_supplier_status"
      expr: procurement_supplier_status
      comment: "Current status of the supplier (e.g., Active, Inactive, Suspended) for supplier base health monitoring."
    - name: "supplier_type"
      expr: supplier_type
      comment: "Type of supplier (e.g., Distributor, Manufacturer, Broker) for supply base composition analysis."
    - name: "classification"
      expr: classification
      comment: "Supplier classification (e.g., Strategic, Preferred, Approved, Transactional) for tiered management."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier of the supplier — for risk-stratified supplier management and monitoring."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the supplier — identifies non-compliant suppliers requiring remediation."
    - name: "country"
      expr: country
      comment: "Country of the supplier — for geographic supply chain risk and sourcing diversity analysis."
    - name: "preferred_supplier_flag"
      expr: preferred_supplier_flag
      comment: "Whether the supplier is designated as preferred — measures preferred supplier base size."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Supplier onboarding status — tracks new supplier pipeline and qualification progress."
    - name: "currency_code"
      expr: currency_code
      comment: "Default transaction currency of the supplier — for multi-currency spend exposure analysis."
  measures:
    - name: "total_supplier_count"
      expr: COUNT(1)
      comment: "Total number of suppliers in the master list — baseline metric for supply base size."
    - name: "total_spend_ytd"
      expr: SUM(CAST(spend_ytd AS DOUBLE))
      comment: "Total year-to-date spend across all suppliers — primary KPI for procurement spend concentration analysis."
    - name: "avg_spend_ytd"
      expr: AVG(CAST(spend_ytd AS DOUBLE))
      comment: "Average year-to-date spend per supplier — benchmarks supplier spend distribution and identifies concentration risk."
    - name: "avg_default_tax_rate"
      expr: AVG(CAST(default_tax_rate AS DOUBLE))
      comment: "Average default tax rate across suppliers — supports tax planning and cost modeling."
    - name: "preferred_supplier_count"
      expr: COUNT(CASE WHEN preferred_supplier_flag = TRUE THEN 1 END)
      comment: "Number of preferred suppliers — measures strategic supplier base size and preferred sourcing coverage."
    - name: "active_supplier_count"
      expr: COUNT(CASE WHEN procurement_supplier_status = 'Active' THEN 1 END)
      comment: "Number of active suppliers — measures operational supply base size for capacity planning."
    - name: "avg_liability_limit"
      expr: AVG(CAST(liability_limit AS DOUBLE))
      comment: "Average supplier liability limit — measures contractual risk coverage across the supplier base."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order line-level KPIs — tracks order fulfillment accuracy, delivery performance, and spend at the line item level to drive operational procurement efficiency."
  source: "`vibe_restaurants_v1`.`procurement`.`po_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the PO line (e.g., Open, Received, Invoiced, Closed) for fulfillment tracking."
    - name: "line_type"
      expr: line_type
      comment: "Type of PO line (e.g., Goods, Services) for spend categorization."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the PO line — tracks fulfillment completion and open order exposure."
    - name: "is_late"
      expr: is_late
      comment: "Whether the delivery was late — used to measure supplier on-time delivery performance."
    - name: "is_three_way_match"
      expr: is_three_way_match
      comment: "Whether the PO line passed three-way match (PO, receipt, invoice) — measures AP control effectiveness."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the PO line is compliant with procurement policy — tracks maverick spend and policy adherence."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the PO line — for multi-currency spend analysis."
    - name: "expected_delivery_month"
      expr: DATE_TRUNC('MONTH', expected_delivery_date)
      comment: "Month of expected delivery — for delivery pipeline and capacity planning analysis."
  measures:
    - name: "total_po_lines"
      expr: COUNT(1)
      comment: "Total number of PO lines — baseline metric for procurement order line activity."
    - name: "total_extended_amount"
      expr: SUM(CAST(extended_amount AS DOUBLE))
      comment: "Total extended line amount (quantity × unit price) — primary spend metric at the line level."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after discounts at line level — true cost basis for line-level spend analysis."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all PO lines — measures procurement volume for capacity and demand planning."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received — used to calculate receipt rate and identify unfulfilled orders."
    - name: "total_invoiced_quantity"
      expr: SUM(CAST(invoiced_quantity AS DOUBLE))
      comment: "Total quantity invoiced — used for three-way match analysis and invoice accuracy measurement."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount captured at line level — measures negotiated pricing effectiveness."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on PO lines — supports tax accrual and compliance reporting."
    - name: "late_delivery_line_count"
      expr: COUNT(CASE WHEN is_late = TRUE THEN 1 END)
      comment: "Number of PO lines with late delivery — measures supplier delivery reliability at line level."
    - name: "three_way_match_line_count"
      expr: COUNT(CASE WHEN is_three_way_match = TRUE THEN 1 END)
      comment: "Number of PO lines passing three-way match — measures AP control quality and invoice accuracy."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across PO lines — benchmarks pricing competitiveness and tracks price inflation."
    - name: "avg_waste_percentage"
      expr: AVG(CAST(waste_percentage AS DOUBLE))
      comment: "Average waste percentage on PO lines — measures ingredient yield efficiency and supplier quality."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase requisition KPIs — tracks demand planning accuracy, approval cycle times, and spend authorization to improve procurement efficiency and budget control."
  source: "`vibe_restaurants_v1`.`procurement`.`requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the requisition (e.g., Draft, Pending Approval, Approved, Converted to PO)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status — identifies bottlenecks in the requisition authorization process."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the requisition — used to analyze urgent vs. planned demand patterns."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method selected (e.g., PO, P-Card, Direct) — for spend channel analysis."
    - name: "urgency_flag"
      expr: urgency_flag
      comment: "Whether the requisition is urgent — tracks reactive procurement frequency."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the requisition — for multi-currency demand analysis."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the requisition was created — for demand trend analysis over time."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Requested delivery method — for logistics planning and fulfillment analysis."
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total number of purchase requisitions — baseline metric for procurement demand volume."
    - name: "total_estimated_spend"
      expr: SUM(CAST(total_estimated_amount AS DOUBLE))
      comment: "Total estimated spend across all requisitions — primary metric for demand-side budget planning."
    - name: "total_net_estimated_amount"
      expr: SUM(CAST(net_estimated_amount AS DOUBLE))
      comment: "Total net estimated amount after discounts — used for budget vs. actuals variance analysis."
    - name: "avg_estimated_spend"
      expr: AVG(CAST(total_estimated_amount AS DOUBLE))
      comment: "Average estimated spend per requisition — benchmarks requisition sizing and identifies consolidation opportunities."
    - name: "urgent_requisition_count"
      expr: COUNT(CASE WHEN urgency_flag = TRUE THEN 1 END)
      comment: "Number of urgent requisitions — high values indicate poor demand planning or supply disruptions."
    - name: "approved_requisition_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved requisitions — measures requisition approval throughput."
    - name: "compliant_requisition_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Number of compliant requisitions — measures adherence to procurement policy and preferred supplier usage."
    - name: "distinct_requesting_units"
      expr: COUNT(DISTINCT requisition_unit_id)
      comment: "Number of distinct restaurant units raising requisitions — measures procurement demand breadth across the estate."
$$;