-- Metric views for domain: vendor | Business: Grocery | Version: 1 | Generated on: 2026-05-04 20:38:05

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`vendor_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic supplier master metrics covering supplier portfolio composition, diversity, certification status, and onboarding health. Used by Vendor Management and Procurement leadership to evaluate supplier base quality and diversity commitments."
  source: "`grocery_ecm`.`vendor`.`supplier`"
  dimensions:
    - name: "supplier_status"
      expr: supplier_status
      comment: "Current operational status of the supplier (e.g., Active, Inactive, Suspended). Primary filter for active supplier analysis."
    - name: "vendor_tier"
      expr: vendor_tier
      comment: "Tier classification of the supplier (e.g., Tier 1, Tier 2, Strategic). Used to segment supplier base by strategic importance."
    - name: "business_type"
      expr: business_type
      comment: "Type of business entity (e.g., Manufacturer, Distributor, Broker). Enables category-level supplier mix analysis."
    - name: "headquarters_country"
      expr: headquarters_country
      comment: "Country where the supplier is headquartered. Supports geographic concentration and sourcing risk analysis."
    - name: "headquarters_state"
      expr: headquarters_state
      comment: "State/province of supplier headquarters. Enables domestic regional sourcing analysis."
    - name: "dsd_flag"
      expr: dsd_flag
      comment: "Indicates whether the supplier operates via Direct Store Delivery. Differentiates DSD vs. warehouse-routed supplier segments."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Indicates whether the supplier produces private-label products. Critical for own-brand portfolio management."
    - name: "organic_certified_flag"
      expr: organic_certified_flag
      comment: "Indicates whether the supplier holds organic certification. Supports organic sourcing strategy tracking."
    - name: "edi_capable_flag"
      expr: edi_capable_flag
      comment: "Indicates whether the supplier supports EDI transactions. Measures supply chain digitization readiness."
    - name: "onboarding_date"
      expr: DATE_TRUNC('month', onboarding_date)
      comment: "Month the supplier was onboarded. Used to track supplier acquisition trends over time."
    - name: "ownership_structure"
      expr: ownership_structure
      comment: "Legal ownership structure of the supplier (e.g., Public, Private, Cooperative). Supports risk and governance segmentation."
  measures:
    - name: "total_active_suppliers"
      expr: COUNT(CASE WHEN supplier_status = 'Active' THEN supplier_id END)
      comment: "Count of currently active suppliers. Core KPI for vendor base size and health monitoring used in executive supplier reviews."
    - name: "total_suppliers"
      expr: COUNT(supplier_id)
      comment: "Total count of all suppliers regardless of status. Baseline for portfolio size and attrition rate calculations."
    - name: "diversity_supplier_count"
      expr: COUNT(CASE WHEN minority_owned_flag = TRUE OR woman_owned_flag = TRUE OR veteran_owned_flag = TRUE OR small_business_flag = TRUE THEN supplier_id END)
      comment: "Count of suppliers meeting at least one diversity criterion (minority-owned, woman-owned, veteran-owned, or small business). Tracks ESG and supplier diversity program performance."
    - name: "organic_certified_supplier_count"
      expr: COUNT(CASE WHEN organic_certified_flag = TRUE THEN supplier_id END)
      comment: "Count of organic-certified suppliers. Supports organic and natural product sourcing strategy and category expansion decisions."
    - name: "edi_capable_supplier_count"
      expr: COUNT(CASE WHEN edi_capable_flag = TRUE THEN supplier_id END)
      comment: "Count of EDI-capable suppliers. Measures supply chain digitization coverage and identifies manual-process risk."
    - name: "private_label_supplier_count"
      expr: COUNT(CASE WHEN private_label_flag = TRUE THEN supplier_id END)
      comment: "Count of suppliers producing private-label products. Directly tied to own-brand margin strategy and exclusivity risk."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across suppliers. Informs inventory planning and working capital requirements for procurement teams."
    - name: "total_organic_acreage"
      expr: SUM(CAST(organic_acreage AS DOUBLE))
      comment: "Total organic acreage across all certified suppliers. Strategic KPI for organic sourcing capacity and sustainability reporting."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`vendor_performance_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance KPIs derived from periodic scorecards covering delivery, fill rate, quality, invoice accuracy, and composite scoring. Used by Vendor Management, Supply Chain, and Category Management to evaluate and tier suppliers."
  source: "`grocery_ecm`.`vendor`.`performance_scorecard`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier. Primary grouping dimension for per-supplier performance analysis."
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Type of measurement period (e.g., Monthly, Quarterly, Annual). Enables period-over-period performance comparison."
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Current status of the scorecard (e.g., Draft, Finalized, Disputed). Filters analysis to finalized, authoritative records."
    - name: "vendor_tier_classification"
      expr: vendor_tier_classification
      comment: "Tier classification assigned on the scorecard (e.g., Preferred, Approved, Probationary). Drives supplier relationship decisions."
    - name: "scorecard_period_start_date"
      expr: DATE_TRUNC('month', scorecard_period_start_date)
      comment: "Start month of the scorecard measurement period. Enables time-series trending of vendor performance."
    - name: "scorecard_period_end_date"
      expr: DATE_TRUNC('month', scorecard_period_end_date)
      comment: "End month of the scorecard measurement period. Used alongside start date for period-range filtering."
    - name: "action_plan_required_flag"
      expr: action_plan_required_flag
      comment: "Indicates whether a corrective action plan was required. Segments underperforming suppliers requiring intervention."
    - name: "contract_compliance_flag"
      expr: contract_compliance_flag
      comment: "Indicates whether the supplier met contract compliance requirements during the period. Key governance and legal risk indicator."
    - name: "performance_improvement_flag"
      expr: performance_improvement_flag
      comment: "Indicates whether the supplier is on a performance improvement plan. Tracks remediation pipeline."
    - name: "node_id"
      expr: node_id
      comment: "Fulfillment node associated with the scorecard. Enables distribution center or region-level vendor performance analysis."
  measures:
    - name: "avg_composite_score"
      expr: AVG(CAST(composite_score AS DOUBLE))
      comment: "Average composite vendor performance score across scorecards. The single most-watched KPI in quarterly vendor business reviews — drives tier reclassification and contract renegotiation decisions."
    - name: "avg_otif_score_pct"
      expr: AVG(CAST(otif_score_percentage AS DOUBLE))
      comment: "Average On-Time In-Full (OTIF) score percentage. Industry-standard supply chain KPI directly tied to shelf availability and customer satisfaction."
    - name: "avg_on_time_delivery_rate_pct"
      expr: AVG(CAST(on_time_delivery_rate_percentage AS DOUBLE))
      comment: "Average on-time delivery rate across scorecards. Measures supplier logistics reliability; low scores trigger carrier or routing reviews."
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_percentage AS DOUBLE))
      comment: "Average order fill rate percentage. Directly linked to in-stock position and lost sales risk; a primary lever for replenishment strategy."
    - name: "avg_case_fill_rate_pct"
      expr: AVG(CAST(case_fill_rate_percentage AS DOUBLE))
      comment: "Average case-level fill rate. Granular fill metric used by supply chain teams to identify case-pack compliance issues."
    - name: "avg_invoice_accuracy_rate_pct"
      expr: AVG(CAST(invoice_accuracy_rate_percentage AS DOUBLE))
      comment: "Average invoice accuracy rate. Measures AP process efficiency; low accuracy drives deduction disputes and finance overhead."
    - name: "avg_quality_defect_rate_pct"
      expr: AVG(CAST(quality_defect_rate_percentage AS DOUBLE))
      comment: "Average quality defect rate percentage. Tracks product quality compliance; high defect rates trigger supplier audits and potential delisting."
    - name: "avg_lead_time_adherence_pct"
      expr: AVG(CAST(lead_time_adherence_percentage AS DOUBLE))
      comment: "Average lead time adherence percentage. Measures supplier reliability against committed lead times; informs safety stock and reorder point settings."
    - name: "avg_edi_compliance_rate_pct"
      expr: AVG(CAST(edi_compliance_rate_percentage AS DOUBLE))
      comment: "Average EDI compliance rate. Tracks electronic transaction accuracy; low compliance increases manual processing costs and error rates."
    - name: "avg_asn_accuracy_rate_pct"
      expr: AVG(CAST(asn_accuracy_rate_percentage AS DOUBLE))
      comment: "Average Advance Ship Notice (ASN) accuracy rate. Accurate ASNs are prerequisite for automated receiving; low rates increase DC labor costs."
    - name: "total_cases_delivered"
      expr: SUM(CAST(total_cases_delivered AS DOUBLE))
      comment: "Total cases delivered across all scored periods. Volume baseline for fill rate and OTIF rate normalization in executive dashboards."
    - name: "total_cases_ordered"
      expr: SUM(CAST(total_cases_ordered AS DOUBLE))
      comment: "Total cases ordered across all scored periods. Denominator for aggregate fill rate calculations and demand fulfillment analysis."
    - name: "total_order_value_amount"
      expr: SUM(CAST(total_order_value_amount AS DOUBLE))
      comment: "Total value of orders placed with the supplier during scored periods. Measures supplier revenue contribution and informs negotiation leverage."
    - name: "total_shrink_contribution_amount"
      expr: SUM(CAST(shrink_contribution_amount AS DOUBLE))
      comment: "Total shrink contribution amount attributed to the supplier. Directly impacts gross margin; high shrink suppliers are candidates for quality audits or delisting."
    - name: "suppliers_requiring_action_plan"
      expr: COUNT(CASE WHEN action_plan_required_flag = TRUE THEN performance_scorecard_id END)
      comment: "Count of scorecard periods where a corrective action plan was required. Tracks the remediation pipeline and vendor risk exposure."
    - name: "contract_renegotiation_flag_count"
      expr: COUNT(CASE WHEN contract_renegotiation_flag = TRUE THEN performance_scorecard_id END)
      comment: "Count of scorecard periods flagged for contract renegotiation. Signals volume of upcoming contract events requiring procurement attention."
    - name: "total_units_delivered"
      expr: SUM(CAST(total_units_delivered AS DOUBLE))
      comment: "Total units delivered by suppliers across scored periods. Unit-level fulfillment volume used for per-unit cost and efficiency benchmarking."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`vendor_cost_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor cost and allowance metrics derived from cost schedules. Tracks unit costs, net costs, freight, and allowances by supplier, cost type, and period. Used by Merchandising, Finance, and Procurement to manage COGS and vendor funding."
  source: "`grocery_ecm`.`vendor`.`cost_schedule`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier associated with the cost schedule. Primary grouping for supplier-level cost analysis."
    - name: "cost_type"
      expr: cost_type
      comment: "Type of cost record (e.g., Base Cost, Promotional, Bracket). Enables cost structure decomposition."
    - name: "cost_status"
      expr: cost_status
      comment: "Current status of the cost schedule (e.g., Active, Pending, Expired). Filters to active, approved cost records."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the cost record. Ensures only approved costs are included in financial reporting."
    - name: "cost_basis"
      expr: cost_basis
      comment: "Basis on which cost is calculated (e.g., Per Unit, Per Case). Supports cost normalization analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the cost is denominated. Required for multi-currency cost consolidation."
    - name: "dsd_flag"
      expr: dsd_flag
      comment: "Indicates whether the cost schedule applies to a DSD item. Differentiates DSD vs. warehouse cost structures."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Indicates whether the cost schedule applies to a private-label item. Supports own-brand margin analysis."
    - name: "allowance_type"
      expr: allowance_type
      comment: "Type of vendor allowance applied (e.g., Off-Invoice, Bill-Back, Scan). Enables allowance mix analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the cost schedule became effective. Enables cost trend analysis over time."
    - name: "cost_change_reason"
      expr: cost_change_reason
      comment: "Reason for the cost change (e.g., Commodity Increase, Negotiated Reduction). Supports cost variance root-cause analysis."
  measures:
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across cost schedule records. Core COGS input used by Merchandising to benchmark and negotiate vendor pricing."
    - name: "avg_net_cost"
      expr: AVG(CAST(net_cost AS DOUBLE))
      comment: "Average net cost after allowances. The true landed cost metric used for margin calculation and pricing decisions."
    - name: "avg_case_cost"
      expr: AVG(CAST(case_cost AS DOUBLE))
      comment: "Average case cost. Used by buyers and replenishment teams for order economics and cost-per-case benchmarking."
    - name: "total_allowance_amount"
      expr: SUM(CAST(allowance_amount AS DOUBLE))
      comment: "Total vendor allowance dollars across cost schedules. Measures total vendor funding contribution to gross margin."
    - name: "avg_allowance_percentage"
      expr: AVG(CAST(allowance_percentage AS DOUBLE))
      comment: "Average allowance percentage across cost schedules. Benchmarks vendor funding rates for negotiation and category planning."
    - name: "avg_freight_cost_per_unit"
      expr: AVG(CAST(freight_cost_per_unit AS DOUBLE))
      comment: "Average freight cost per unit. Informs landed cost calculations and logistics sourcing decisions."
    - name: "total_net_cost"
      expr: SUM(CAST(net_cost AS DOUBLE))
      comment: "Total net cost across all active cost schedules. Aggregate COGS exposure metric used in financial planning and budget variance analysis."
    - name: "cost_schedule_count"
      expr: COUNT(cost_schedule_id)
      comment: "Total number of cost schedule records. Baseline for cost schedule coverage and complexity management."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`vendor_trade_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade agreement portfolio metrics covering contract status, financial terms, rebates, and slotting fees. Used by Merchandising, Legal, and Finance to manage vendor contract lifecycle and funding commitments."
  source: "`grocery_ecm`.`vendor`.`trade_agreement`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier associated with the trade agreement. Primary grouping for supplier-level contract analysis."
    - name: "trade_agreement_status"
      expr: trade_agreement_status
      comment: "Current status of the trade agreement (e.g., Active, Expired, Pending). Filters to active contracts for financial exposure analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of trade agreement (e.g., Master Supply, Promotional, Rebate). Enables contract mix and complexity analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the trade agreement. Required for multi-currency contract portfolio consolidation."
    - name: "dsd_flag"
      expr: dsd_flag
      comment: "Indicates whether the agreement covers DSD items. Differentiates DSD vs. warehouse contract structures."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Indicates whether the agreement covers private-label products. Supports own-brand contract governance."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the agreement auto-renews. Identifies contracts requiring proactive renegotiation before expiry."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Indicates whether the agreement includes exclusivity provisions. Tracks competitive sourcing constraints."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the trade agreement became effective. Enables contract vintage and renewal cycle analysis."
    - name: "effective_end_date"
      expr: DATE_TRUNC('month', effective_end_date)
      comment: "Month the trade agreement expires. Used to identify upcoming contract expirations requiring action."
    - name: "rebate_structure_type"
      expr: rebate_structure_type
      comment: "Type of rebate structure (e.g., Tiered, Flat, Volume). Enables rebate program mix analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed with the supplier (e.g., Net 30, 2/10 Net 30). Supports cash flow and working capital analysis."
  measures:
    - name: "total_active_agreements"
      expr: COUNT(CASE WHEN trade_agreement_status = 'Active' THEN trade_agreement_id END)
      comment: "Count of currently active trade agreements. Baseline for contract portfolio size and coverage monitoring."
    - name: "total_slotting_fee_amount"
      expr: SUM(CAST(slotting_fee_amount AS DOUBLE))
      comment: "Total slotting fees committed across trade agreements. Measures vendor investment in shelf placement; key input to category profitability analysis."
    - name: "avg_rebate_percentage"
      expr: AVG(CAST(rebate_percentage AS DOUBLE))
      comment: "Average rebate percentage across trade agreements. Benchmarks vendor rebate rates for negotiation strategy and margin planning."
    - name: "total_minimum_order_value"
      expr: SUM(CAST(minimum_order_value AS DOUBLE))
      comment: "Total minimum order value commitments across agreements. Measures procurement volume obligations and working capital requirements."
    - name: "agreements_expiring_count"
      expr: COUNT(CASE WHEN effective_end_date <= DATE_ADD(CURRENT_DATE(), 90) AND trade_agreement_status = 'Active' THEN trade_agreement_id END)
      comment: "Count of active agreements expiring within 90 days. Critical pipeline metric for contract renewal management and sourcing continuity risk."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across trade agreements. Informs inventory planning and order consolidation strategy."
    - name: "exclusive_agreement_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN trade_agreement_id END)
      comment: "Count of agreements with exclusivity provisions. Tracks competitive sourcing constraints and single-source dependency risk."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`vendor_trade_allowance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor trade allowance and promotional funding metrics covering accruals, claims, settlements, and disputes. Used by Finance, Merchandising, and Vendor Accounting to manage vendor funding recovery and promotional ROI."
  source: "`grocery_ecm`.`vendor`.`trade_allowance`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier providing the trade allowance. Primary grouping for supplier-level funding analysis."
    - name: "allowance_type"
      expr: allowance_type
      comment: "Type of trade allowance (e.g., Off-Invoice, Bill-Back, Scan, Promotional). Enables funding mix and recovery rate analysis by type."
    - name: "allowance_status"
      expr: allowance_status
      comment: "Current status of the allowance (e.g., Active, Expired, Cancelled). Filters to active and claimable allowances."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of the allowance (e.g., Settled, Pending, Disputed). Tracks collection pipeline and dispute exposure."
    - name: "allowance_rate_type"
      expr: allowance_rate_type
      comment: "Rate type of the allowance (e.g., Fixed, Percentage, Per Unit). Supports allowance structure analysis."
    - name: "accrual_method"
      expr: accrual_method
      comment: "Method used to accrue the allowance (e.g., Purchase-Based, Sales-Based). Impacts timing of income recognition."
    - name: "allowance_currency_code"
      expr: allowance_currency_code
      comment: "Currency of the allowance. Required for multi-currency vendor funding consolidation."
    - name: "promotion_period_start_date"
      expr: DATE_TRUNC('month', promotion_period_start_date)
      comment: "Month the promotional period started. Enables seasonal and event-based allowance trend analysis."
    - name: "category_captain_flag"
      expr: category_captain_flag
      comment: "Indicates whether the allowance is associated with a category captain arrangement. Tracks category captain funding contributions."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of allowance payment (e.g., Check, EFT, Off-Invoice). Supports cash flow and settlement process analysis."
  measures:
    - name: "total_accrued_amount"
      expr: SUM(CAST(accrued_amount AS DOUBLE))
      comment: "Total accrued vendor allowance dollars. Represents the gross vendor funding earned; key input to gross margin and P&L reporting."
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total amount claimed from vendors. Measures the portion of accrued allowances submitted for collection."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total allowance dollars actually received from vendors. The realized vendor funding metric used in financial close and margin reporting."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total allowance dollars currently in dispute. Measures financial risk from unresolved vendor deductions; triggers escalation when high."
    - name: "total_maximum_allowance_amount"
      expr: SUM(CAST(maximum_allowance_amount AS DOUBLE))
      comment: "Total maximum allowable vendor funding across all allowances. Represents the ceiling of vendor funding opportunity for budget planning."
    - name: "avg_allowance_rate_value"
      expr: AVG(CAST(allowance_rate_value AS DOUBLE))
      comment: "Average allowance rate value across all trade allowances. Benchmarks vendor funding rates for negotiation and category planning."
    - name: "allowance_collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(accrued_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of accrued allowances actually collected (paid / accrued). Measures vendor funding recovery efficiency; low rates indicate collection process gaps or vendor disputes."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(disputed_amount AS DOUBLE)) / NULLIF(SUM(CAST(claimed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of claimed allowances currently in dispute. Tracks vendor relationship friction and financial risk concentration."
    - name: "total_performance_actual_value"
      expr: SUM(CAST(performance_actual_value AS DOUBLE))
      comment: "Total actual performance value achieved against performance-based allowances. Used to validate performance-triggered funding claims."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`vendor_compliance_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor compliance tracking metrics covering certification status, risk levels, audit schedules, and non-compliance incidents. Used by Compliance, Quality Assurance, and Legal teams to manage regulatory risk and supplier certification health."
  source: "`grocery_ecm`.`vendor`.`compliance_record`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier associated with the compliance record. Primary grouping for supplier-level compliance analysis."
    - name: "compliance_requirement_type"
      expr: compliance_requirement_type
      comment: "Type of compliance requirement (e.g., Food Safety, Organic, Labor). Enables compliance gap analysis by regulatory category."
    - name: "verification_status"
      expr: verification_status
      comment: "Current verification status of the compliance record (e.g., Verified, Pending, Failed). Core filter for compliance dashboard views."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the compliance record (e.g., High, Medium, Low). Prioritizes compliance remediation efforts."
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Regulatory program governing the compliance requirement (e.g., FSMA, USDA Organic, FDA). Enables program-level compliance tracking."
    - name: "certification_body"
      expr: certification_body
      comment: "Organization that issued the certification. Supports certification authority concentration and accreditation analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the compliance certification auto-renews. Identifies certifications requiring proactive renewal action."
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Indicates whether a compliance notification was sent to the supplier. Tracks communication completeness for audit trail purposes."
    - name: "expiration_date"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the compliance certification expires. Used to identify upcoming compliance gaps requiring action."
    - name: "last_audit_date"
      expr: DATE_TRUNC('month', last_audit_date)
      comment: "Month of the most recent audit. Enables audit frequency and recency analysis."
    - name: "compliance_scope"
      expr: compliance_scope
      comment: "Scope of the compliance requirement (e.g., Site-Level, Product-Level, Corporate). Supports compliance coverage analysis."
  measures:
    - name: "total_compliance_records"
      expr: COUNT(compliance_record_id)
      comment: "Total count of compliance records. Baseline for compliance portfolio size and coverage monitoring."
    - name: "verified_compliance_count"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN compliance_record_id END)
      comment: "Count of compliance records with verified status. Measures the active, confirmed compliance posture of the supplier base."
    - name: "non_compliant_record_count"
      expr: COUNT(CASE WHEN verification_status = 'Failed' OR verification_status = 'Non-Compliant' THEN compliance_record_id END)
      comment: "Count of compliance records in a non-compliant state. Critical risk metric — high counts trigger regulatory escalation and potential supplier suspension."
    - name: "high_risk_compliance_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN compliance_record_id END)
      comment: "Count of compliance records classified as high risk. Prioritizes compliance remediation resources and executive risk reporting."
    - name: "expiring_certifications_count"
      expr: COUNT(CASE WHEN expiration_date <= DATE_ADD(CURRENT_DATE(), 60) AND expiration_date >= CURRENT_DATE() THEN compliance_record_id END)
      comment: "Count of certifications expiring within 60 days. Proactive risk metric for compliance renewal pipeline management."
    - name: "compliance_verification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Verified' THEN compliance_record_id END) / NULLIF(COUNT(compliance_record_id), 0), 2)
      comment: "Percentage of compliance records that are verified. Overall compliance health rate used in executive risk dashboards and regulatory reporting."
    - name: "overdue_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_due_date < CURRENT_DATE() AND verification_status != 'Verified' THEN compliance_record_id END)
      comment: "Count of compliance records with overdue corrective action plans. Measures unresolved compliance risk exposure requiring immediate management attention."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`vendor_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor item catalog metrics covering item portfolio composition, cost currency, organic certification, and supply chain attributes. Used by Merchandising, Category Management, and Procurement to manage the vendor item assortment and sourcing strategy."
  source: "`grocery_ecm`.`vendor`.`vendor_item`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier associated with the vendor item. Primary grouping for supplier-level item portfolio analysis."
    - name: "vendor_item_status"
      expr: vendor_item_status
      comment: "Current status of the vendor item (e.g., Active, Discontinued, Pending). Filters to active assortment for planning purposes."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the item is produced. Supports sourcing diversification and trade compliance analysis."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone required for the item (e.g., Ambient, Refrigerated, Frozen). Enables cold chain capacity planning."
    - name: "dsd_flag"
      expr: dsd_flag
      comment: "Indicates whether the item is delivered via Direct Store Delivery. Differentiates DSD vs. warehouse-routed item economics."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Indicates whether the item is a private-label product. Supports own-brand assortment and margin analysis."
    - name: "organic_certified_flag"
      expr: organic_certified_flag
      comment: "Indicates whether the item holds organic certification. Tracks organic assortment breadth and sourcing compliance."
    - name: "primary_vendor_flag"
      expr: primary_vendor_flag
      comment: "Indicates whether this supplier is the primary vendor for the item. Identifies single-source dependency and backup sourcing gaps."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the item is classified as hazardous material. Supports regulatory compliance and logistics routing decisions."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency in which the vendor item cost is denominated. Required for multi-currency cost consolidation."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the vendor item became effective. Enables new item introduction trend analysis."
  measures:
    - name: "total_active_vendor_items"
      expr: COUNT(CASE WHEN vendor_item_status = 'Active' THEN vendor_item_id END)
      comment: "Count of currently active vendor items. Baseline for assortment size and vendor item portfolio management."
    - name: "avg_vendor_cost_amount"
      expr: AVG(CAST(vendor_cost_amount AS DOUBLE))
      comment: "Average vendor cost per item. Core COGS input used by Merchandising for pricing, margin, and negotiation benchmarking."
    - name: "avg_case_weight_pounds"
      expr: AVG(CAST(case_weight_pounds AS DOUBLE))
      comment: "Average case weight in pounds across vendor items. Informs freight cost modeling and logistics capacity planning."
    - name: "avg_case_cube_cubic_feet"
      expr: AVG(CAST(case_cube_cubic_feet AS DOUBLE))
      comment: "Average case cube in cubic feet. Used for DC slotting, truck utilization, and warehouse capacity planning."
    - name: "organic_item_count"
      expr: COUNT(CASE WHEN organic_certified_flag = TRUE THEN vendor_item_id END)
      comment: "Count of organic-certified vendor items. Tracks organic assortment depth for category strategy and consumer demand alignment."
    - name: "private_label_item_count"
      expr: COUNT(CASE WHEN private_label_flag = TRUE THEN vendor_item_id END)
      comment: "Count of private-label vendor items. Measures own-brand assortment breadth; directly tied to margin strategy and brand differentiation."
    - name: "single_source_item_count"
      expr: COUNT(CASE WHEN primary_vendor_flag = TRUE THEN vendor_item_id END)
      comment: "Count of items where this supplier is the primary vendor. Measures single-source dependency and supply continuity risk exposure."
    - name: "total_vendor_cost_amount"
      expr: SUM(CAST(vendor_cost_amount AS DOUBLE))
      comment: "Total vendor cost across all vendor items. Aggregate COGS exposure metric used in financial planning and category budget analysis."
$$;