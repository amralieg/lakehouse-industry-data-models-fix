-- Metric views for domain: supplier | Business: Retail | Version: 1 | Generated on: 2026-05-04 13:23:00

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplier_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the vendor master, tracking supplier performance health, compliance posture, and operational readiness across the active vendor base."
  source: "`retail_ecm`.`supplier`.`vendor`"
  filter: vendor_status = 'ACTIVE'
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current lifecycle status of the vendor (ACTIVE, INACTIVE, SUSPENDED, etc.) — primary segmentation for vendor health analysis."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Classification of the vendor (e.g. Direct, Broker, Distributor) — used to segment performance by supply chain tier."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Vendor risk tier assigned by procurement (e.g. LOW, MEDIUM, HIGH) — critical for risk-weighted portfolio analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Standard payment terms code (e.g. NET30, NET60) — used to analyze working capital exposure by vendor cohort."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the vendor — enables multi-currency performance segmentation."
    - name: "diversity_certification"
      expr: diversity_certification
      comment: "Diversity certification type (e.g. MBE, WBE, SDVOB) — supports ESG and supplier diversity reporting."
    - name: "sustainability_certified_flag"
      expr: sustainability_certified_flag
      comment: "Boolean indicating whether the vendor holds a sustainability certification — used for ESG compliance tracking."
    - name: "edi_capable_flag"
      expr: edi_capable_flag
      comment: "Boolean indicating EDI capability — used to segment vendors by digital integration maturity."
    - name: "vmi_enabled_flag"
      expr: vmi_enabled_flag
      comment: "Boolean indicating Vendor Managed Inventory participation — used to track VMI program adoption."
    - name: "onboarding_year_month"
      expr: DATE_TRUNC('MONTH', onboarding_date)
      comment: "Month of vendor onboarding — enables cohort analysis of vendor performance by onboarding vintage."
    - name: "contract_expiry_date"
      expr: contract_expiry_date
      comment: "Date the vendor contract expires — used to identify vendors requiring renewal action."
  measures:
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average fill rate percentage across vendors — measures the proportion of ordered quantities fulfilled; a key supply reliability KPI for procurement leadership."
    - name: "avg_on_time_delivery_rate_pct"
      expr: AVG(CAST(on_time_delivery_rate_pct AS DOUBLE))
      comment: "Average on-time delivery rate across vendors — directly measures supplier delivery reliability and impacts in-stock performance."
    - name: "avg_quality_acceptance_rate_pct"
      expr: AVG(CAST(quality_acceptance_rate_pct AS DOUBLE))
      comment: "Average quality acceptance rate across vendors — measures the proportion of received goods passing quality inspection; drives vendor qualification decisions."
    - name: "avg_moq_units"
      expr: AVG(CAST(moq_units AS DOUBLE))
      comment: "Average minimum order quantity in units across vendors — informs inventory planning and working capital requirements."
    - name: "total_active_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Count of distinct active vendors — baseline measure of supplier base breadth used in portfolio and concentration risk analysis."
    - name: "edi_capable_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN edi_capable_flag = TRUE THEN vendor_id END)
      comment: "Count of vendors with EDI capability — measures digital integration adoption across the supplier base, a key operational efficiency KPI."
    - name: "sustainability_certified_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN sustainability_certified_flag = TRUE THEN vendor_id END)
      comment: "Count of sustainability-certified vendors — tracks ESG compliance progress and supports regulatory and investor reporting."
    - name: "vmi_enabled_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN vmi_enabled_flag = TRUE THEN vendor_id END)
      comment: "Count of vendors enrolled in VMI programs — measures VMI program scale, which directly reduces inventory carrying costs."
    - name: "high_risk_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN risk_rating = 'HIGH' THEN vendor_id END)
      comment: "Count of vendors rated HIGH risk — a critical supply chain risk KPI that triggers mitigation and diversification actions."
    - name: "contracts_expiring_within_90_days"
      expr: COUNT(DISTINCT CASE WHEN contract_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN vendor_id END)
      comment: "Count of vendors whose contracts expire within 90 days — an operational urgency KPI that drives procurement renewal pipeline management."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplier_vendor_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Comprehensive supplier performance scorecard metrics covering delivery, quality, fill rate, EDI compliance, invoice accuracy, and chargeback exposure — the primary executive dashboard for vendor performance management."
  source: "`retail_ecm`.`supplier`.`vendor_scorecard`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor identifier — primary grouping key for all scorecard KPIs, enabling per-vendor performance drill-down."
    - name: "vendor_tier"
      expr: vendor_tier
      comment: "Vendor performance tier (e.g. GOLD, SILVER, BRONZE) — used to segment scorecard results by strategic supplier classification."
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Status of the scorecard record (e.g. FINAL, DRAFT, ACKNOWLEDGED) — used to filter to finalized performance periods."
    - name: "score_trend"
      expr: score_trend
      comment: "Directional trend of the composite score (IMPROVING, DECLINING, STABLE) — enables trend-based vendor segmentation for proactive management."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean flag indicating a corrective action plan is required — used to identify vendors in remediation status."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of financial scorecard values — required for multi-currency financial aggregations."
    - name: "scoring_period_start_date"
      expr: DATE_TRUNC('MONTH', scoring_period_start_date)
      comment: "Start of the scoring period truncated to month — enables time-series trending of vendor performance."
    - name: "evaluation_date"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of scorecard evaluation — used for period-over-period performance comparison."
    - name: "dc_facility_id"
      expr: dc_facility_id
      comment: "Distribution center facility identifier — enables scorecard analysis by receiving location."
    - name: "category_id"
      expr: category_id
      comment: "Merchandise category identifier — enables scorecard performance segmentation by product category."
  measures:
    - name: "avg_composite_score"
      expr: AVG(CAST(composite_score AS DOUBLE))
      comment: "Average composite vendor performance score — the headline KPI for vendor performance management; drives tier assignment and strategic sourcing decisions."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate from scorecards — measures supplier delivery reliability across scoring periods; directly impacts in-stock and customer satisfaction."
    - name: "avg_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average fill rate from scorecards — measures the proportion of ordered quantities fulfilled; a primary supply reliability KPI."
    - name: "avg_product_quality_score"
      expr: AVG(CAST(product_quality_score AS DOUBLE))
      comment: "Average product quality score — measures inbound product quality; drives vendor qualification and delisting decisions."
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate — measures billing compliance; high inaccuracy drives AP processing costs and disputes."
    - name: "avg_edi_compliance_rate"
      expr: AVG(CAST(edi_compliance_rate AS DOUBLE))
      comment: "Average EDI compliance rate — measures electronic transaction accuracy; low compliance increases manual processing overhead."
    - name: "avg_lead_time_adherence_rate"
      expr: AVG(CAST(lead_time_adherence_rate AS DOUBLE))
      comment: "Average lead time adherence rate — measures how consistently vendors meet agreed lead times; impacts inventory planning accuracy."
    - name: "avg_moq_compliance_rate"
      expr: AVG(CAST(minimum_order_quantity_compliance_rate AS DOUBLE))
      comment: "Average minimum order quantity compliance rate — measures vendor adherence to MOQ agreements; non-compliance drives supply chain inefficiency."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount assessed via scorecards — measures financial penalties levied on vendors; a key cost recovery and compliance KPI."
    - name: "total_purchase_order_value"
      expr: SUM(CAST(total_purchase_order_value AS DOUBLE))
      comment: "Total purchase order value covered by scorecards — measures the financial scale of vendor relationships being evaluated."
    - name: "total_return_to_vendor_amount"
      expr: SUM(CAST(return_to_vendor_amount AS DOUBLE))
      comment: "Total return-to-vendor amount from scorecards — measures the financial impact of quality and compliance failures requiring returns."
    - name: "avg_score_improvement"
      expr: AVG(CAST(composite_score AS DOUBLE) - CAST(prior_period_composite_score AS DOUBLE))
      comment: "Average period-over-period composite score change — measures whether vendor performance is improving or declining; a leading indicator for proactive vendor management."
    - name: "vendors_requiring_corrective_action"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_required = TRUE THEN vendor_id END)
      comment: "Count of distinct vendors with an active corrective action requirement — a critical risk KPI that drives procurement intervention prioritization."
    - name: "chargeback_to_po_value_ratio"
      expr: ROUND(100.0 * SUM(CAST(chargeback_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_purchase_order_value AS DOUBLE)), 0), 4)
      comment: "Chargeback amount as a percentage of total PO value — measures the financial burden of vendor non-compliance relative to spend; a key procurement efficiency KPI."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplier_chargeback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier chargeback analytics covering penalty volumes, recovery rates, dispute patterns, and repeat violation trends — enables procurement to manage vendor compliance costs and recovery efficiency."
  source: "`retail_ecm`.`supplier`.`chargeback`"
  dimensions:
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Current status of the chargeback (e.g. OPEN, DISPUTED, RECOVERED, WRITTEN_OFF) — primary filter for active vs. resolved chargeback analysis."
    - name: "chargeback_type"
      expr: chargeback_type
      comment: "Type of chargeback (e.g. ROUTING, LABELING, SHORTAGE, COMPLIANCE) — used to identify the most costly non-compliance categories."
    - name: "violation_category"
      expr: violation_category
      comment: "Category of the underlying vendor violation — enables root-cause analysis of chargeback drivers."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Status of any vendor dispute against the chargeback — used to track dispute resolution pipeline and recovery risk."
    - name: "is_repeat_violation"
      expr: is_repeat_violation
      comment: "Boolean flag indicating whether this is a repeat violation by the vendor — used to identify chronic non-compliance patterns."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the chargeback penalty amount — required for accurate financial aggregation."
    - name: "notification_method"
      expr: notification_method
      comment: "Method used to notify the vendor of the chargeback — used to assess communication channel effectiveness."
    - name: "recovery_method"
      expr: recovery_method
      comment: "Method used to recover the chargeback amount (e.g. DEDUCTION, INVOICE) — used to analyze recovery channel efficiency."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor identifier — enables per-vendor chargeback exposure analysis."
    - name: "violation_date_month"
      expr: DATE_TRUNC('MONTH', violation_date)
      comment: "Month of the violation — enables time-series trending of chargeback volumes and amounts."
    - name: "penalty_calculation_method"
      expr: penalty_calculation_method
      comment: "Method used to calculate the penalty (e.g. FLAT_FEE, PERCENTAGE) — used to analyze penalty structure effectiveness."
  measures:
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total chargeback penalty amount assessed — the headline financial KPI for vendor compliance cost recovery; directly impacts cost of goods."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average chargeback penalty per incident — measures the typical financial impact of a vendor violation; used to calibrate penalty structures."
    - name: "total_chargeback_count"
      expr: COUNT(DISTINCT chargeback_id)
      comment: "Total number of distinct chargebacks issued — measures the volume of vendor compliance failures; a key operational KPI for procurement."
    - name: "repeat_violation_chargeback_count"
      expr: COUNT(DISTINCT CASE WHEN is_repeat_violation = TRUE THEN chargeback_id END)
      comment: "Count of chargebacks flagged as repeat violations — identifies chronic non-compliance; drives escalation and vendor remediation decisions."
    - name: "disputed_chargeback_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_status IS NOT NULL AND dispute_status != '' THEN chargeback_id END)
      comment: "Count of chargebacks that have been disputed by the vendor — measures dispute volume; high dispute rates signal unclear compliance standards or vendor relations issues."
    - name: "total_vendor_scorecard_impact"
      expr: SUM(CAST(vendor_scorecard_impact AS DOUBLE))
      comment: "Total scorecard impact points deducted via chargebacks — measures the aggregate effect of compliance failures on vendor performance ratings."
    - name: "avg_penalty_percentage"
      expr: AVG(CAST(penalty_percentage AS DOUBLE))
      comment: "Average penalty percentage applied to chargebacks — measures the severity of penalty rates; used to benchmark against industry standards and contract terms."
    - name: "distinct_vendors_charged"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Count of distinct vendors who received chargebacks — measures the breadth of compliance issues across the supplier base."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplier_rtv_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return-to-vendor analytics covering return volumes, values, freight costs, chargeback recovery, and quality-driven returns — enables supply chain and procurement teams to manage vendor return efficiency and cost recovery."
  source: "`retail_ecm`.`supplier`.`rtv_request`"
  dimensions:
    - name: "rtv_status"
      expr: rtv_status
      comment: "Current status of the RTV request (e.g. PENDING, APPROVED, SHIPPED, CLOSED) — primary lifecycle filter for return pipeline management."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Standardized reason code for the return (e.g. DEFECTIVE, OVERSTOCK, RECALL) — used to identify the primary drivers of vendor returns."
    - name: "disposition_method"
      expr: disposition_method
      comment: "How returned goods are handled (e.g. RETURN_TO_VENDOR, DESTROY, DONATE) — used to analyze disposition cost and recovery efficiency."
    - name: "freight_responsibility"
      expr: freight_responsibility
      comment: "Party responsible for return freight costs (VENDOR or RETAILER) — used to track freight cost allocation and contract compliance."
    - name: "is_recall_related"
      expr: is_recall_related
      comment: "Boolean flag indicating whether the return is related to a product recall — used to isolate recall-driven return costs for regulatory and risk reporting."
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Boolean flag indicating whether a quality inspection is required before return — used to track inspection workload and compliance."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Result of the quality inspection (e.g. PASS, FAIL, PARTIAL) — used to analyze quality failure rates driving returns."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the return financial values — required for accurate multi-currency financial aggregation."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor identifier — enables per-vendor return volume and value analysis."
    - name: "request_date_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month of the RTV request — enables time-series trending of return volumes and values."
    - name: "chargeback_reason"
      expr: chargeback_reason
      comment: "Reason for any associated chargeback on the RTV — used to link return root causes to financial recovery actions."
  measures:
    - name: "total_return_value"
      expr: SUM(CAST(total_return_value AS DOUBLE))
      comment: "Total financial value of all return-to-vendor requests — the headline financial KPI for RTV management; measures cost of goods returned to suppliers."
    - name: "total_return_quantity"
      expr: SUM(CAST(total_return_quantity AS DOUBLE))
      comment: "Total units returned to vendors — measures the volume of inventory removed from stock via RTVs; impacts inventory availability and shrink."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost incurred for RTV shipments — measures the logistics cost of vendor returns; used to negotiate freight responsibility terms."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount recovered via RTV requests — measures financial recovery from vendor non-compliance associated with returns."
    - name: "avg_return_value_per_request"
      expr: AVG(CAST(total_return_value AS DOUBLE))
      comment: "Average return value per RTV request — measures the typical financial scale of a vendor return; used to prioritize high-value return processing."
    - name: "total_rtv_requests"
      expr: COUNT(DISTINCT rtv_request_id)
      comment: "Total number of distinct RTV requests — measures the operational volume of vendor returns; a key supply chain quality KPI."
    - name: "recall_related_return_value"
      expr: SUM(CASE WHEN is_recall_related = TRUE THEN CAST(total_return_value AS DOUBLE) ELSE 0 END)
      comment: "Total return value attributable to product recalls — isolates recall-driven financial exposure for risk and regulatory reporting."
    - name: "distinct_vendors_with_returns"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Count of distinct vendors with active RTV requests — measures the breadth of return issues across the supplier base."
    - name: "freight_cost_to_return_value_ratio"
      expr: ROUND(100.0 * SUM(CAST(freight_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_return_value AS DOUBLE)), 0), 4)
      comment: "Freight cost as a percentage of total return value — measures the efficiency of the return logistics process; high ratios indicate costly return operations."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplier_vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor contract portfolio analytics covering contract values, payment terms, compliance requirements, and expiry risk — enables procurement leadership to manage contract lifecycle, financial exposure, and compliance obligations."
  source: "`retail_ecm`.`supplier`.`vendor_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the vendor contract (e.g. ACTIVE, EXPIRED, TERMINATED, PENDING) — primary lifecycle segmentation for contract portfolio analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of vendor contract (e.g. MASTER, ADDENDUM, SPOT) — used to segment contract portfolio by agreement structure."
    - name: "contract_currency_code"
      expr: contract_currency_code
      comment: "Currency of the contract value — required for multi-currency financial exposure analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code on the contract (e.g. NET30, NET60) — used to analyze working capital exposure by payment terms cohort."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code governing delivery responsibility — used to segment contracts by logistics risk allocation."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Boolean indicating whether the contract auto-renews — used to identify contracts requiring active renewal management."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Boolean indicating whether the contract includes exclusivity terms — used to track exclusive supplier relationships and associated risk."
    - name: "edi_enabled_flag"
      expr: edi_enabled_flag
      comment: "Boolean indicating EDI is enabled on the contract — used to measure digital integration coverage across the contract portfolio."
    - name: "vmi_enabled_flag"
      expr: vmi_enabled_flag
      comment: "Boolean indicating VMI is enabled on the contract — used to track VMI program coverage across vendor agreements."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor identifier — enables per-vendor contract portfolio analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the contract became effective — enables cohort analysis of contract portfolio by vintage."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_amount AS DOUBLE))
      comment: "Total committed contract value across the vendor portfolio — the headline financial KPI for procurement spend under contract; measures sourcing commitment scale."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value_amount AS DOUBLE))
      comment: "Average contract value per vendor agreement — measures the typical financial scale of vendor relationships; used to segment strategic vs. tactical suppliers."
    - name: "total_active_contracts"
      expr: COUNT(DISTINCT CASE WHEN contract_status = 'ACTIVE' THEN vendor_contract_id END)
      comment: "Count of currently active vendor contracts — measures the scale of the active supplier agreement portfolio."
    - name: "contracts_expiring_within_90_days"
      expr: COUNT(DISTINCT CASE WHEN effective_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN vendor_contract_id END)
      comment: "Count of contracts expiring within 90 days — a critical procurement urgency KPI that drives renewal pipeline prioritization."
    - name: "total_contract_value_expiring_90_days"
      expr: SUM(CASE WHEN effective_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN CAST(contract_value_amount AS DOUBLE) ELSE 0 END)
      comment: "Total contract value at risk of expiry within 90 days — measures the financial exposure from contracts requiring immediate renewal action."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage negotiated across contracts — measures the commercial effectiveness of procurement negotiations."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across contracts — informs inventory planning and working capital requirements at the portfolio level."
    - name: "exclusivity_contract_value"
      expr: SUM(CASE WHEN exclusivity_flag = TRUE THEN CAST(contract_value_amount AS DOUBLE) ELSE 0 END)
      comment: "Total contract value under exclusivity agreements — measures concentration risk from exclusive supplier relationships."
    - name: "distinct_vendors_under_contract"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Count of distinct vendors with at least one contract — measures the contracted supplier base size."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplier_vendor_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor item catalog analytics covering unit costs, preferred vendor coverage, private label penetration, and VMI/DSD eligibility — enables merchandising and procurement to optimize sourcing decisions at the item level."
  source: "`retail_ecm`.`supplier`.`vendor_item`"
  dimensions:
    - name: "vendor_item_status"
      expr: vendor_item_status
      comment: "Current status of the vendor item (e.g. ACTIVE, DISCONTINUED, SEASONAL) — primary lifecycle filter for active assortment analysis."
    - name: "vendor_item_category"
      expr: vendor_item_category
      comment: "Category classification of the vendor item — enables cost and performance analysis by merchandise category."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the item is manufactured — used for sourcing diversification, tariff impact, and supply chain risk analysis."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Boolean indicating whether this vendor is the preferred source for the item — used to measure preferred vendor program coverage."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Boolean indicating whether the item is a private label product — used to track private label penetration and margin contribution."
    - name: "dsd_eligible_flag"
      expr: dsd_eligible_flag
      comment: "Boolean indicating Direct Store Delivery eligibility — used to analyze DSD program coverage and logistics cost avoidance."
    - name: "vmi_enabled_flag"
      expr: vmi_enabled_flag
      comment: "Boolean indicating VMI is enabled for this item — used to track VMI program item coverage."
    - name: "edi_enabled_flag"
      expr: edi_enabled_flag
      comment: "Boolean indicating EDI ordering is enabled for this item — used to measure digital ordering coverage at the item level."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of the unit cost — required for multi-currency cost analysis."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor identifier — enables per-vendor item portfolio analysis."
    - name: "cost_effective_date_month"
      expr: DATE_TRUNC('MONTH', cost_effective_date)
      comment: "Month the current cost became effective — enables cost trend analysis over time."
  measures:
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across vendor items — the primary cost benchmarking KPI for procurement; drives cost negotiation and margin management decisions."
    - name: "total_active_vendor_items"
      expr: COUNT(DISTINCT CASE WHEN vendor_item_status = 'ACTIVE' THEN vendor_item_id END)
      comment: "Count of active vendor item records — measures the breadth of the active vendor assortment catalog."
    - name: "preferred_vendor_item_count"
      expr: COUNT(DISTINCT CASE WHEN preferred_vendor_flag = TRUE THEN vendor_item_id END)
      comment: "Count of items sourced from preferred vendors — measures preferred vendor program coverage; preferred sourcing drives better terms and reliability."
    - name: "private_label_item_count"
      expr: COUNT(DISTINCT CASE WHEN private_label_flag = TRUE THEN vendor_item_id END)
      comment: "Count of private label vendor items — measures private label assortment depth; private label drives higher margins and brand differentiation."
    - name: "dsd_eligible_item_count"
      expr: COUNT(DISTINCT CASE WHEN dsd_eligible_flag = TRUE THEN vendor_item_id END)
      comment: "Count of DSD-eligible vendor items — measures DSD program scale; DSD reduces distribution center handling costs."
    - name: "vmi_enabled_item_count"
      expr: COUNT(DISTINCT CASE WHEN vmi_enabled_flag = TRUE THEN vendor_item_id END)
      comment: "Count of VMI-enabled vendor items — measures VMI program item coverage; VMI reduces inventory carrying costs and stockouts."
    - name: "distinct_vendors_with_items"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Count of distinct vendors with active item records — measures the breadth of the sourcing vendor base at the item level."
    - name: "distinct_skus_sourced"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs with at least one vendor item record — measures the breadth of the sourced assortment."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplier_lead_time_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead time agreement analytics covering SLA commitments, fill rate targets, on-time delivery standards, and VMI/EDI adoption — enables supply chain planning teams to manage replenishment lead time risk and vendor SLA compliance."
  source: "`retail_ecm`.`supplier`.`lead_time_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the lead time agreement (e.g. ACTIVE, EXPIRED, PENDING) — primary lifecycle filter for active SLA analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of lead time agreement (e.g. STANDARD, EXPEDITED, SEASONAL) — used to segment SLA analysis by agreement structure."
    - name: "scope_level"
      expr: scope_level
      comment: "Scope of the agreement (e.g. VENDOR, CATEGORY, SKU) — used to understand the granularity of lead time commitments."
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Mode of transportation specified in the agreement (e.g. TRUCK, RAIL, AIR) — used to analyze lead time by logistics mode."
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterms governing delivery responsibility — used to segment lead time agreements by risk allocation."
    - name: "vmi_enabled_flag"
      expr: vmi_enabled_flag
      comment: "Boolean indicating VMI is enabled under this agreement — used to track VMI program coverage in lead time agreements."
    - name: "edi_enabled_flag"
      expr: edi_enabled_flag
      comment: "Boolean indicating EDI is enabled under this agreement — used to measure digital ordering coverage in lead time agreements."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Boolean indicating whether the agreement auto-renews — used to identify agreements requiring active renewal management."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor identifier — enables per-vendor lead time SLA analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the agreement became effective — enables cohort analysis of lead time agreements by vintage."
    - name: "delivery_frequency"
      expr: delivery_frequency
      comment: "Frequency of deliveries under the agreement (e.g. DAILY, WEEKLY, MONTHLY) — used to analyze replenishment cadence across the supplier base."
  measures:
    - name: "avg_fill_rate_sla_pct"
      expr: AVG(CAST(fill_rate_sla_percent AS DOUBLE))
      comment: "Average fill rate SLA commitment across lead time agreements — measures the contracted supply reliability standard; gaps vs. actuals drive vendor performance actions."
    - name: "avg_on_time_delivery_sla_pct"
      expr: AVG(CAST(on_time_delivery_sla_percent AS DOUBLE))
      comment: "Average on-time delivery SLA commitment across agreements — measures the contracted delivery reliability standard; used to benchmark against actual scorecard performance."
    - name: "avg_compliance_penalty_rate"
      expr: AVG(CAST(compliance_penalty_rate AS DOUBLE))
      comment: "Average compliance penalty rate across lead time agreements — measures the financial consequence of SLA breaches; used to assess penalty structure adequacy."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across lead time agreements — informs inventory planning and order consolidation strategies."
    - name: "avg_order_increment_quantity"
      expr: AVG(CAST(order_increment_quantity AS DOUBLE))
      comment: "Average order increment quantity across agreements — used to optimize order sizing and reduce excess inventory from over-ordering."
    - name: "total_active_agreements"
      expr: COUNT(DISTINCT CASE WHEN agreement_status = 'ACTIVE' THEN lead_time_agreement_id END)
      comment: "Count of active lead time agreements — measures the scale of the active SLA portfolio governing replenishment."
    - name: "vmi_enabled_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN vmi_enabled_flag = TRUE THEN lead_time_agreement_id END)
      comment: "Count of lead time agreements with VMI enabled — measures VMI program coverage in replenishment agreements."
    - name: "agreements_expiring_within_90_days"
      expr: COUNT(DISTINCT CASE WHEN effective_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN lead_time_agreement_id END)
      comment: "Count of lead time agreements expiring within 90 days — a supply chain risk KPI that drives proactive SLA renewal to avoid replenishment disruption."
    - name: "distinct_vendors_with_agreements"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Count of distinct vendors with active lead time agreements — measures the breadth of the SLA-governed supplier base."
$$;