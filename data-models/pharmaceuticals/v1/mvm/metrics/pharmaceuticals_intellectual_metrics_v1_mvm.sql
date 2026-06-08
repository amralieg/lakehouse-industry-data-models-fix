-- Metric views for domain: intellectual | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 21:06:11

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_patent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the patent portfolio. Tracks portfolio health, lifecycle risk, litigation exposure, and exclusivity coverage to support IP investment and loss-of-exclusivity planning decisions."
  source: "`pharmaceuticals_ecm`.`intellectual`.`patent`"
  dimensions:
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area the patent protects, enabling portfolio analysis by disease area (e.g., oncology, immunology)."
    - name: "patent_type"
      expr: patent_type
      comment: "Classification of the patent (e.g., compound, formulation, method-of-use) for portfolio segmentation."
    - name: "legal_status"
      expr: legal_status
      comment: "Current legal standing of the patent (e.g., granted, pending, lapsed) for active portfolio monitoring."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Whether the patent is owned, licensed-in, or co-owned, relevant for IP strategy and cost allocation."
    - name: "asset_classification"
      expr: asset_classification
      comment: "Strategic classification of the patent asset (e.g., core, non-core) for portfolio prioritization."
    - name: "prosecution_status"
      expr: prosecution_status
      comment: "Current prosecution stage (e.g., examination, allowed, abandoned) for pipeline tracking."
    - name: "fto_clearance_status"
      expr: fto_clearance_status
      comment: "Freedom-to-operate clearance status indicating whether the patent poses a freedom-to-operate risk."
    - name: "orange_book_listed"
      expr: orange_book_listed
      comment: "Flag indicating whether the patent is listed in the FDA Orange Book, critical for generic entry defense."
    - name: "litigation_flag"
      expr: litigation_flag
      comment: "Indicates whether the patent is currently subject to litigation, used for risk monitoring."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the patent expires, used for loss-of-exclusivity cliff analysis and revenue-at-risk planning."
    - name: "grant_year"
      expr: YEAR(grant_date)
      comment: "Year the patent was granted, used for portfolio vintage analysis."
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year the patent was filed, used for R&D pipeline age analysis."
  measures:
    - name: "total_patents"
      expr: COUNT(DISTINCT patent_id)
      comment: "Total number of distinct patents in the portfolio. Baseline KPI for portfolio size and coverage reporting."
    - name: "patents_expiring_within_3_years"
      expr: COUNT(DISTINCT CASE WHEN expiry_date BETWEEN CURRENT_DATE AND ADD_MONTHS(CURRENT_DATE, 36) THEN patent_id END)
      comment: "Number of patents expiring within the next 3 years. Critical for loss-of-exclusivity (LOE) cliff planning and revenue protection strategy."
    - name: "patents_with_spc"
      expr: COUNT(DISTINCT CASE WHEN spc_number IS NOT NULL AND spc_number <> '' THEN patent_id END)
      comment: "Number of patents with a Supplementary Protection Certificate (SPC), extending effective exclusivity beyond base patent expiry."
    - name: "patents_in_litigation"
      expr: COUNT(DISTINCT CASE WHEN litigation_flag = TRUE THEN patent_id END)
      comment: "Number of patents currently under litigation. Drives legal resource allocation and risk provisioning decisions."
    - name: "orange_book_listed_patents"
      expr: COUNT(DISTINCT CASE WHEN orange_book_listed = TRUE THEN patent_id END)
      comment: "Number of patents listed in the FDA Orange Book. Directly tied to generic entry defense and 30-month stay eligibility."
    - name: "patents_with_pediatric_exclusivity"
      expr: COUNT(DISTINCT CASE WHEN pediatric_exclusivity_expiry IS NOT NULL THEN patent_id END)
      comment: "Number of patents with pediatric exclusivity extensions, representing additional market protection earned through pediatric studies."
    - name: "avg_term_adjustment_days"
      expr: AVG(CAST(term_adjustment_days AS DOUBLE))
      comment: "Average patent term adjustment days across the portfolio, reflecting regulatory delay compensation and effective exclusivity extension."
    - name: "avg_term_extension_days"
      expr: AVG(CAST(term_extension_days AS DOUBLE))
      comment: "Average patent term extension days, indicating the portfolio's ability to recover time lost during regulatory review."
    - name: "litigation_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN litigation_flag = TRUE THEN patent_id END) / NULLIF(COUNT(DISTINCT patent_id), 0), 2)
      comment: "Percentage of patents under active litigation. High rates signal IP portfolio vulnerability and elevated legal spend risk."
    - name: "orange_book_coverage_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN orange_book_listed = TRUE THEN patent_id END) / NULLIF(COUNT(DISTINCT patent_id), 0), 2)
      comment: "Percentage of patents listed in the Orange Book relative to total portfolio. Measures the breadth of regulatory exclusivity protection."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_patent_litigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational KPI layer over patent litigation cases. Tracks legal spend, liability exposure, revenue at risk, and case outcomes to support litigation strategy and budget decisions."
  source: "`pharmaceuticals_ecm`.`intellectual`.`patent_litigation`"
  dimensions:
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area associated with the litigated patent, enabling spend and risk analysis by disease area."
    - name: "litigation_status"
      expr: litigation_status
      comment: "Current status of the litigation case (e.g., active, settled, dismissed) for pipeline and resolution tracking."
    - name: "case_type"
      expr: case_type
      comment: "Type of litigation case (e.g., ANDA challenge, IPR, infringement) for categorizing legal risk."
    - name: "case_priority"
      expr: case_priority
      comment: "Priority level assigned to the case, used for resource allocation and escalation decisions."
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of the case (e.g., won, lost, settled) for win-rate and strategy effectiveness analysis."
    - name: "appeal_filed"
      expr: appeal_filed
      comment: "Indicates whether an appeal has been filed, relevant for tracking extended litigation timelines and costs."
    - name: "first_filer_status"
      expr: first_filer_status
      comment: "Indicates whether the opposing party is a first-filer generic, which triggers 180-day exclusivity and revenue impact."
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year the litigation was filed, used for cohort analysis of case resolution timelines and spend trends."
    - name: "suit_filed_year"
      expr: YEAR(suit_filed_date)
      comment: "Year the suit was formally filed, used for litigation pipeline vintage analysis."
  measures:
    - name: "total_active_cases"
      expr: COUNT(DISTINCT CASE WHEN litigation_status = 'active' THEN patent_litigation_id END)
      comment: "Number of currently active litigation cases. Baseline KPI for legal workload and resource planning."
    - name: "total_actual_legal_spend_usd"
      expr: SUM(CAST(actual_legal_spend_usd AS DOUBLE))
      comment: "Total actual legal spend in USD across all litigation cases. Core financial KPI for IP legal budget management."
    - name: "total_legal_budget_usd"
      expr: SUM(CAST(legal_budget_usd AS DOUBLE))
      comment: "Total approved legal budget in USD for litigation cases. Used to assess budget utilization and forecast overruns."
    - name: "total_revenue_at_risk_usd"
      expr: SUM(CAST(revenue_at_risk_usd AS DOUBLE))
      comment: "Total revenue at risk from patent litigation outcomes. Critical strategic KPI for executive risk provisioning and LOE scenario planning."
    - name: "total_estimated_liability_usd"
      expr: SUM(CAST(estimated_liability_usd AS DOUBLE))
      comment: "Total estimated financial liability from ongoing litigation. Drives legal reserve and balance sheet provisioning decisions."
    - name: "avg_actual_legal_spend_usd"
      expr: AVG(CAST(actual_legal_spend_usd AS DOUBLE))
      comment: "Average legal spend per litigation case in USD. Benchmarks case cost efficiency and outside counsel performance."
    - name: "legal_spend_vs_budget_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_legal_spend_usd AS DOUBLE)) / NULLIF(SUM(CAST(legal_budget_usd AS DOUBLE)), 0), 2)
      comment: "Actual legal spend as a percentage of approved budget. Identifies budget overruns and informs future litigation budget planning."
    - name: "avg_revenue_at_risk_per_case_usd"
      expr: AVG(CAST(revenue_at_risk_usd AS DOUBLE))
      comment: "Average revenue at risk per litigation case. Helps prioritize high-stakes cases for senior legal and commercial attention."
    - name: "cases_with_paragraph_iv"
      expr: COUNT(DISTINCT CASE WHEN paragraph_iv_notice_date IS NOT NULL THEN patent_litigation_id END)
      comment: "Number of cases involving a Paragraph IV ANDA challenge. Directly signals imminent generic entry threat and triggers 30-month stay analysis."
    - name: "settled_cases"
      expr: COUNT(DISTINCT CASE WHEN settlement_date IS NOT NULL THEN patent_litigation_id END)
      comment: "Number of cases resolved via settlement. Tracks settlement rate as an indicator of litigation strategy effectiveness."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_licensing_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and strategic KPI layer over licensing agreements. Tracks deal value, milestone economics, royalty rates, and agreement lifecycle to support business development and IP monetization decisions."
  source: "`pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of licensing agreement (e.g., in-license, out-license, cross-license) for portfolio strategy segmentation."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement (e.g., active, expired, terminated) for lifecycle management."
    - name: "licensed_asset_type"
      expr: licensed_asset_type
      comment: "Type of asset being licensed (e.g., patent, know-how, trademark) for deal structure analysis."
    - name: "exclusivity_type"
      expr: exclusivity_type
      comment: "Exclusivity scope granted under the agreement (e.g., exclusive, non-exclusive, co-exclusive)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the agreement financials are denominated, required for multi-currency portfolio analysis."
    - name: "sublicensing_permitted"
      expr: sublicensing_permitted
      comment: "Indicates whether sublicensing is permitted under the agreement, affecting downstream IP monetization potential."
    - name: "right_of_first_negotiation"
      expr: right_of_first_negotiation
      comment: "Indicates whether a right of first negotiation clause exists, relevant for partnership and M&A strategy."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the agreement became effective, used for deal vintage and cohort analysis."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the agreement expires, used for renewal pipeline and revenue continuity planning."
  measures:
    - name: "total_active_agreements"
      expr: COUNT(DISTINCT CASE WHEN agreement_status = 'active' THEN licensing_agreement_id END)
      comment: "Number of currently active licensing agreements. Baseline KPI for IP monetization portfolio breadth."
    - name: "total_deal_value_usd"
      expr: SUM(CAST(total_deal_value AS DOUBLE))
      comment: "Total deal value across all licensing agreements. Primary financial KPI for IP monetization and business development performance."
    - name: "total_upfront_payments_usd"
      expr: SUM(CAST(upfront_payment_amount AS DOUBLE))
      comment: "Total upfront payments received or paid across agreements. Measures immediate cash impact of licensing activity."
    - name: "total_milestone_value_usd"
      expr: SUM(CAST(total_milestone_value AS DOUBLE))
      comment: "Total potential milestone payments across all agreements. Represents contingent value in the licensing portfolio."
    - name: "total_commercial_milestone_value_usd"
      expr: SUM(CAST(commercial_milestone_value AS DOUBLE))
      comment: "Total commercial milestone value across agreements. Tracks revenue-linked deal economics tied to product commercialization success."
    - name: "total_development_milestone_value_usd"
      expr: SUM(CAST(development_milestone_value AS DOUBLE))
      comment: "Total development milestone value across agreements. Tracks R&D-linked deal economics tied to clinical and regulatory progress."
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate across licensing agreements. Benchmarks deal terms and informs negotiation strategy for new agreements."
    - name: "avg_deal_value_usd"
      expr: AVG(CAST(total_deal_value AS DOUBLE))
      comment: "Average total deal value per licensing agreement. Tracks deal quality and business development effectiveness over time."
    - name: "agreements_expiring_within_12_months"
      expr: COUNT(DISTINCT CASE WHEN expiry_date BETWEEN CURRENT_DATE AND ADD_MONTHS(CURRENT_DATE, 12) THEN licensing_agreement_id END)
      comment: "Number of agreements expiring within 12 months. Drives renewal pipeline management and revenue continuity planning."
    - name: "upfront_to_total_deal_value_pct"
      expr: ROUND(100.0 * SUM(CAST(upfront_payment_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_deal_value AS DOUBLE)), 0), 2)
      comment: "Upfront payment as a percentage of total deal value. Measures deal structure risk — higher ratios indicate more certain near-term cash flows."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_royalty_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPI layer over royalty payment transactions. Tracks royalty revenue, net sales bases, withholding tax, payment compliance, and reconciliation status to support IP revenue management and audit decisions."
  source: "`pharmaceuticals_ecm`.`intellectual`.`royalty_payment`"
  dimensions:
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area associated with the royalty-bearing product, enabling revenue analysis by disease area."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status (e.g., paid, pending, overdue) for cash flow and compliance monitoring."
    - name: "payment_direction"
      expr: payment_direction
      comment: "Direction of payment (inbound royalty received vs. outbound royalty paid) for net royalty position analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the royalty payment, required for multi-currency financial consolidation."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the payment (e.g., reconciled, disputed, pending) for financial close and audit readiness."
    - name: "royalty_tier_label"
      expr: royalty_tier_label
      comment: "Royalty tier label from the agreement schedule, used to analyze tiered royalty structure performance."
    - name: "licensed_territory"
      expr: licensed_territory
      comment: "Geographic territory covered by the royalty payment, enabling regional IP revenue analysis."
    - name: "audit_flag"
      expr: audit_flag
      comment: "Indicates whether the payment has been flagged for audit, used for compliance and dispute management."
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year of payment, used for annual royalty revenue trend analysis."
    - name: "calculation_period_end_year"
      expr: YEAR(calculation_period_end_date)
      comment: "Year of the royalty calculation period end, used for period-over-period royalty performance comparison."
  measures:
    - name: "total_royalty_amount"
      expr: SUM(CAST(royalty_amount AS DOUBLE))
      comment: "Total royalty amount across all payments. Primary IP revenue KPI for licensing portfolio financial performance."
    - name: "total_net_sales_amount"
      expr: SUM(CAST(net_sales_amount AS DOUBLE))
      comment: "Total net sales base underlying royalty calculations. Tracks the commercial scale of royalty-bearing products."
    - name: "total_gross_sales_amount"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales amount reported for royalty calculation. Used to assess gross-to-net deduction impact on royalty base."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from royalty payments. Tracks tax leakage on IP income for treasury and tax planning."
    - name: "total_deductions_amount"
      expr: SUM(CAST(deductions_amount AS DOUBLE))
      comment: "Total deductions applied to royalty payments. Monitors contractual deduction levels and potential under-reporting risk."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total royalty payments in functional currency after FX conversion. Used for consolidated financial reporting."
    - name: "avg_royalty_amount_per_payment"
      expr: AVG(CAST(royalty_amount AS DOUBLE))
      comment: "Average royalty amount per payment transaction. Benchmarks payment size and detects anomalies in royalty reporting."
    - name: "effective_royalty_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(royalty_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_sales_amount AS DOUBLE)), 0), 2)
      comment: "Effective royalty rate as royalty amount divided by net sales. Validates contractual royalty rates are being applied correctly and detects under-reporting."
    - name: "withholding_tax_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(withholding_tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(royalty_amount AS DOUBLE)), 0), 2)
      comment: "Effective withholding tax rate on royalty payments. Informs tax treaty optimization and cross-border IP structure decisions."
    - name: "payments_flagged_for_audit"
      expr: COUNT(DISTINCT CASE WHEN audit_flag = TRUE THEN royalty_payment_id END)
      comment: "Number of royalty payments flagged for audit. Tracks compliance risk and drives audit prioritization decisions."
    - name: "unreconciled_payments"
      expr: COUNT(DISTINCT CASE WHEN reconciliation_status <> 'reconciled' THEN royalty_payment_id END)
      comment: "Number of royalty payments not yet reconciled. Measures financial close readiness and royalty reporting accuracy risk."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_exclusivity_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over regulatory exclusivity periods. Tracks exclusivity coverage, LOE risk, orphan and pediatric designations, and generic entry timelines to support commercial and regulatory strategy decisions."
  source: "`pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`"
  dimensions:
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the product with exclusivity, enabling LOE risk analysis by disease area."
    - name: "exclusivity_type"
      expr: exclusivity_type
      comment: "Type of exclusivity (e.g., NCE, orphan, pediatric, data exclusivity) for regulatory protection portfolio analysis."
    - name: "exclusivity_category"
      expr: exclusivity_category
      comment: "Category of exclusivity protection for grouping and prioritization in regulatory strategy."
    - name: "exclusivity_status"
      expr: exclusivity_status
      comment: "Current status of the exclusivity period (e.g., active, expired, pending) for portfolio lifecycle management."
    - name: "loe_risk_level"
      expr: loe_risk_level
      comment: "Loss-of-exclusivity risk level assigned to the product. Critical dimension for commercial revenue protection planning."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Product lifecycle stage (e.g., launch, growth, mature, LOE) for portfolio segmentation and strategic planning."
    - name: "is_orphan_designated"
      expr: is_orphan_designated
      comment: "Indicates orphan drug designation, which confers 7-year US or 10-year EU market exclusivity."
    - name: "pediatric_extension_granted"
      expr: pediatric_extension_granted
      comment: "Indicates whether a pediatric exclusivity extension has been granted, adding 6 months to base exclusivity."
    - name: "patent_linkage_flag"
      expr: patent_linkage_flag
      comment: "Indicates whether the exclusivity period is linked to a listed patent, relevant for ANDA challenge defense."
    - name: "exclusivity_expiry_year"
      expr: YEAR(exclusivity_expiry_date)
      comment: "Year the exclusivity expires, used for LOE cliff analysis and revenue-at-risk forecasting."
    - name: "granting_authority"
      expr: granting_authority
      comment: "Regulatory authority that granted the exclusivity (e.g., FDA, EMA), enabling jurisdiction-level analysis."
  measures:
    - name: "total_active_exclusivities"
      expr: COUNT(DISTINCT CASE WHEN exclusivity_status = 'active' THEN exclusivity_period_id END)
      comment: "Number of currently active exclusivity periods. Baseline KPI for regulatory protection portfolio breadth."
    - name: "exclusivities_expiring_within_2_years"
      expr: COUNT(DISTINCT CASE WHEN exclusivity_expiry_date BETWEEN CURRENT_DATE AND ADD_MONTHS(CURRENT_DATE, 24) THEN exclusivity_period_id END)
      comment: "Number of exclusivity periods expiring within 2 years. Critical LOE cliff indicator for commercial revenue protection planning."
    - name: "orphan_designated_products"
      expr: COUNT(DISTINCT CASE WHEN is_orphan_designated = TRUE THEN exclusivity_period_id END)
      comment: "Number of products with orphan drug designation. Tracks rare disease portfolio exclusivity and associated premium pricing protection."
    - name: "pediatric_extensions_granted"
      expr: COUNT(DISTINCT CASE WHEN pediatric_extension_granted = TRUE THEN exclusivity_period_id END)
      comment: "Number of products with pediatric exclusivity extensions. Measures success in earning additional exclusivity through pediatric studies."
    - name: "high_loe_risk_count"
      expr: COUNT(DISTINCT CASE WHEN loe_risk_level = 'high' THEN exclusivity_period_id END)
      comment: "Number of exclusivity periods classified as high LOE risk. Drives prioritization of patent defense and lifecycle management investments."
    - name: "patent_linked_exclusivities"
      expr: COUNT(DISTINCT CASE WHEN patent_linkage_flag = TRUE THEN exclusivity_period_id END)
      comment: "Number of exclusivity periods linked to Orange Book patents. Measures the strength of integrated patent-exclusivity protection."
    - name: "high_loe_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN loe_risk_level = 'high' THEN exclusivity_period_id END) / NULLIF(COUNT(DISTINCT exclusivity_period_id), 0), 2)
      comment: "Percentage of exclusivity periods classified as high LOE risk. Portfolio-level risk concentration metric for executive LOE strategy reviews."
    - name: "pediatric_extension_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pediatric_extension_granted = TRUE THEN exclusivity_period_id END) / NULLIF(COUNT(DISTINCT exclusivity_period_id), 0), 2)
      comment: "Percentage of eligible products that have received pediatric exclusivity extensions. Measures regulatory lifecycle management effectiveness."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_patent_prosecution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPI layer over patent prosecution activities. Tracks annuity costs, prosecution pipeline health, response deadlines, and grant rates to support IP operations and cost management decisions."
  source: "`pharmaceuticals_ecm`.`intellectual`.`patent_prosecution`"
  dimensions:
    - name: "prosecution_stage"
      expr: prosecution_stage
      comment: "Current stage of patent prosecution (e.g., examination, appeal, allowed) for pipeline status monitoring."
    - name: "annuity_payment_status"
      expr: annuity_payment_status
      comment: "Status of annuity fee payment (e.g., paid, overdue, waived) for maintenance compliance monitoring."
    - name: "application_type"
      expr: application_type
      comment: "Type of patent application (e.g., utility, continuation, PCT national phase) for prosecution portfolio segmentation."
    - name: "invention_type"
      expr: invention_type
      comment: "Type of invention (e.g., compound, process, formulation) for R&D portfolio alignment analysis."
    - name: "patent_office_code"
      expr: patent_office_code
      comment: "Patent office jurisdiction code (e.g., USPTO, EPO, JPO) for geographic prosecution cost and success analysis."
    - name: "office_action_type"
      expr: office_action_type
      comment: "Type of office action received (e.g., rejection, restriction, allowance) for prosecution quality analysis."
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year of patent application filing, used for prosecution pipeline vintage and grant lag analysis."
    - name: "grant_year"
      expr: YEAR(grant_date)
      comment: "Year the patent was granted, used for prosecution success rate trend analysis."
  measures:
    - name: "total_applications_in_prosecution"
      expr: COUNT(DISTINCT patent_prosecution_id)
      comment: "Total number of patent applications currently in prosecution. Baseline KPI for IP operations workload and resource planning."
    - name: "total_annuity_fees"
      expr: SUM(CAST(annuity_fee_amount AS DOUBLE))
      comment: "Total annuity fees payable across the prosecution portfolio. Core IP maintenance cost KPI for budget planning and cost optimization."
    - name: "total_annuity_surcharges"
      expr: SUM(CAST(annuity_surcharge_amount AS DOUBLE))
      comment: "Total annuity surcharges incurred due to late payments. Measures IP operations efficiency and avoidable cost leakage."
    - name: "avg_annuity_fee_per_application"
      expr: AVG(CAST(annuity_fee_amount AS DOUBLE))
      comment: "Average annuity fee per patent application. Benchmarks maintenance cost per asset for portfolio cost optimization decisions."
    - name: "applications_with_overdue_response"
      expr: COUNT(DISTINCT CASE WHEN response_deadline < CURRENT_DATE AND grant_date IS NULL AND abandonment_date IS NULL THEN patent_prosecution_id END)
      comment: "Number of applications with overdue office action responses. Critical operational risk KPI — missed deadlines result in irreversible patent abandonment."
    - name: "granted_applications"
      expr: COUNT(DISTINCT CASE WHEN grant_date IS NOT NULL THEN patent_prosecution_id END)
      comment: "Number of applications that have been granted. Measures prosecution success and IP portfolio growth rate."
    - name: "abandoned_applications"
      expr: COUNT(DISTINCT CASE WHEN abandonment_date IS NOT NULL THEN patent_prosecution_id END)
      comment: "Number of applications that have been abandoned. Tracks IP asset attrition and informs prosecution strategy effectiveness."
    - name: "grant_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN grant_date IS NOT NULL THEN patent_prosecution_id END) / NULLIF(COUNT(DISTINCT patent_prosecution_id), 0), 2)
      comment: "Percentage of applications that have been granted. Key prosecution quality KPI used to evaluate patent drafting and prosecution strategy effectiveness."
    - name: "surcharge_to_annuity_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(annuity_surcharge_amount AS DOUBLE)) / NULLIF(SUM(CAST(annuity_fee_amount AS DOUBLE)), 0), 2)
      comment: "Annuity surcharges as a percentage of base annuity fees. Measures IP operations payment discipline and avoidable cost as a share of total maintenance spend."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_patent_term_extension`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over patent term extensions (PTEs and SPCs). Tracks extension grants, duration, pediatric eligibility, and LOE dates to support exclusivity maximization and lifecycle management decisions."
  source: "`pharmaceuticals_ecm`.`intellectual`.`patent_term_extension`"
  dimensions:
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the product seeking term extension, enabling LOE analysis by disease area."
    - name: "mechanism_type"
      expr: mechanism_type
      comment: "Type of extension mechanism (e.g., PTE, SPC, pediatric extension) for regulatory strategy segmentation."
    - name: "decision_status"
      expr: decision_status
      comment: "Current decision status of the extension application (e.g., granted, pending, refused) for pipeline tracking."
    - name: "granting_authority"
      expr: granting_authority
      comment: "Regulatory authority granting the extension (e.g., USPTO, EPO national office) for jurisdiction analysis."
    - name: "pediatric_extension_eligible"
      expr: pediatric_extension_eligible
      comment: "Indicates whether the product is eligible for a pediatric extension, used for lifecycle management opportunity tracking."
    - name: "pediatric_extension_granted"
      expr: pediatric_extension_granted
      comment: "Indicates whether the pediatric extension has been granted, measuring success in earning additional exclusivity."
    - name: "opposition_filed"
      expr: opposition_filed
      comment: "Indicates whether an opposition has been filed against the extension, signaling legal risk to exclusivity."
    - name: "orphan_drug_exclusivity"
      expr: orphan_drug_exclusivity
      comment: "Indicates whether orphan drug exclusivity applies, conferring additional market protection."
    - name: "loe_year"
      expr: YEAR(loe_date)
      comment: "Year of loss of exclusivity, used for revenue cliff analysis and commercial planning."
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year the extension application was filed, used for pipeline vintage analysis."
  measures:
    - name: "total_extension_applications"
      expr: COUNT(DISTINCT patent_term_extension_id)
      comment: "Total number of patent term extension applications. Baseline KPI for exclusivity maximization pipeline breadth."
    - name: "granted_extensions"
      expr: COUNT(DISTINCT CASE WHEN decision_status = 'granted' THEN patent_term_extension_id END)
      comment: "Number of patent term extensions successfully granted. Measures effectiveness of regulatory exclusivity maximization strategy."
    - name: "avg_granted_extension_days"
      expr: AVG(CAST(granted_extension_days AS DOUBLE))
      comment: "Average number of days of patent term extension granted. Quantifies the effective exclusivity gained through PTE/SPC applications."
    - name: "avg_calculated_extension_days"
      expr: AVG(CAST(calculated_extension_days AS DOUBLE))
      comment: "Average calculated extension days based on regulatory review period. Benchmarks expected vs. granted extension duration."
    - name: "pediatric_extensions_granted"
      expr: COUNT(DISTINCT CASE WHEN pediatric_extension_granted = TRUE THEN patent_term_extension_id END)
      comment: "Number of pediatric extensions granted. Tracks success in earning 6-month pediatric exclusivity bonuses through pediatric study commitments."
    - name: "extensions_with_opposition"
      expr: COUNT(DISTINCT CASE WHEN opposition_filed = TRUE THEN patent_term_extension_id END)
      comment: "Number of extension applications facing opposition. Signals legal risk to exclusivity and drives prioritization of defense resources."
    - name: "extension_grant_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN decision_status = 'granted' THEN patent_term_extension_id END) / NULLIF(COUNT(DISTINCT patent_term_extension_id), 0), 2)
      comment: "Percentage of extension applications that have been granted. Measures regulatory strategy effectiveness in securing maximum exclusivity."
    - name: "pediatric_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pediatric_extension_granted = TRUE THEN patent_term_extension_id END) / NULLIF(COUNT(DISTINCT CASE WHEN pediatric_extension_eligible = TRUE THEN patent_term_extension_id END), 0), 2)
      comment: "Percentage of pediatric-eligible products that successfully obtained a pediatric extension. Measures lifecycle management execution effectiveness."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_fto_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk and operational KPI layer over freedom-to-operate (FTO) analyses. Tracks FTO risk levels, design-around requirements, litigation flags, and analysis pipeline to support product launch and IP clearance decisions."
  source: "`pharmaceuticals_ecm`.`intellectual`.`fto_analysis`"
  dimensions:
    - name: "technology_area"
      expr: technology_area
      comment: "Technology area covered by the FTO analysis, enabling risk analysis by scientific domain."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned by the FTO analysis (e.g., high, medium, low) for prioritizing IP clearance actions."
    - name: "analysis_status"
      expr: analysis_status
      comment: "Current status of the FTO analysis (e.g., in-progress, complete, pending review) for pipeline management."
    - name: "analysis_type"
      expr: analysis_type
      comment: "Type of FTO analysis (e.g., product clearance, process clearance, competitor watch) for workload categorization."
    - name: "final_opinion"
      expr: final_opinion
      comment: "Final FTO opinion (e.g., clear, risk identified, design-around required) for executive risk reporting."
    - name: "design_around_required"
      expr: design_around_required
      comment: "Indicates whether a design-around is required to avoid infringement, triggering R&D and legal resource allocation."
    - name: "licensing_required"
      expr: licensing_required
      comment: "Indicates whether licensing is required to proceed, triggering business development and deal-making activity."
    - name: "litigation_flag"
      expr: litigation_flag
      comment: "Indicates whether the FTO analysis is associated with active litigation, elevating its strategic priority."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the FTO analysis, used for access control and information governance."
    - name: "analysis_year"
      expr: YEAR(analysis_date)
      comment: "Year the FTO analysis was conducted, used for trend analysis of IP risk exposure over time."
  measures:
    - name: "total_fto_analyses"
      expr: COUNT(DISTINCT fto_analysis_id)
      comment: "Total number of FTO analyses conducted. Baseline KPI for IP clearance workload and R&D pipeline coverage."
    - name: "high_risk_analyses"
      expr: COUNT(DISTINCT CASE WHEN risk_level = 'high' THEN fto_analysis_id END)
      comment: "Number of FTO analyses with high risk classification. Drives prioritization of design-around, licensing, and litigation defense resources."
    - name: "design_around_required_count"
      expr: COUNT(DISTINCT CASE WHEN design_around_required = TRUE THEN fto_analysis_id END)
      comment: "Number of FTO analyses requiring a design-around solution. Quantifies R&D rework burden from IP clearance constraints."
    - name: "licensing_required_count"
      expr: COUNT(DISTINCT CASE WHEN licensing_required = TRUE THEN fto_analysis_id END)
      comment: "Number of FTO analyses where licensing is required. Drives business development pipeline for in-licensing negotiations."
    - name: "analyses_with_litigation"
      expr: COUNT(DISTINCT CASE WHEN litigation_flag = TRUE THEN fto_analysis_id END)
      comment: "Number of FTO analyses associated with active litigation. Measures the intersection of FTO risk and active legal disputes."
    - name: "high_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN risk_level = 'high' THEN fto_analysis_id END) / NULLIF(COUNT(DISTINCT fto_analysis_id), 0), 2)
      comment: "Percentage of FTO analyses classified as high risk. Portfolio-level IP clearance risk concentration metric for executive review."
    - name: "design_around_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN design_around_required = TRUE THEN fto_analysis_id END) / NULLIF(COUNT(DISTINCT fto_analysis_id), 0), 2)
      comment: "Percentage of FTO analyses requiring design-around. Measures the R&D constraint burden imposed by third-party IP on the product pipeline."
    - name: "analyses_overdue_for_review"
      expr: COUNT(DISTINCT CASE WHEN review_due_date < CURRENT_DATE AND analysis_status <> 'complete' THEN fto_analysis_id END)
      comment: "Number of FTO analyses overdue for review. Operational risk KPI — stale FTO opinions expose the company to undetected IP infringement risk."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_trademark`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portfolio and compliance KPI layer over trademark registrations. Tracks registration coverage, renewal pipeline, opposition risk, and litigation exposure to support brand protection and market entry decisions."
  source: "`pharmaceuticals_ecm`.`intellectual`.`trademark`"
  dimensions:
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area associated with the trademark, enabling brand protection analysis by disease area."
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status of the trademark (e.g., registered, pending, abandoned) for portfolio lifecycle management."
    - name: "mark_type"
      expr: mark_type
      comment: "Type of trademark mark (e.g., word mark, figurative, combined) for portfolio composition analysis."
    - name: "opposition_status"
      expr: opposition_status
      comment: "Status of any opposition proceedings against the trademark, used for brand risk monitoring."
    - name: "madrid_protocol_flag"
      expr: madrid_protocol_flag
      comment: "Indicates whether the trademark was filed via the Madrid Protocol for international registration efficiency analysis."
    - name: "litigation_flag"
      expr: litigation_flag
      comment: "Indicates whether the trademark is subject to active litigation, used for brand protection risk monitoring."
    - name: "watch_service_flag"
      expr: watch_service_flag
      comment: "Indicates whether a watch service is active for the trademark, measuring proactive brand monitoring coverage."
    - name: "office_code"
      expr: office_code
      comment: "Trademark office jurisdiction code, enabling geographic brand protection coverage analysis."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the trademark registration expires, used for renewal pipeline planning."
    - name: "renewal_year"
      expr: YEAR(renewal_date)
      comment: "Year the trademark is due for renewal, used for proactive renewal management."
  measures:
    - name: "total_registered_trademarks"
      expr: COUNT(DISTINCT CASE WHEN registration_status = 'registered' THEN trademark_id END)
      comment: "Number of active registered trademarks. Baseline KPI for brand protection portfolio breadth and geographic coverage."
    - name: "trademarks_expiring_within_12_months"
      expr: COUNT(DISTINCT CASE WHEN expiry_date BETWEEN CURRENT_DATE AND ADD_MONTHS(CURRENT_DATE, 12) THEN trademark_id END)
      comment: "Number of trademarks expiring within 12 months. Drives renewal pipeline management to prevent unintentional brand protection lapses."
    - name: "trademarks_in_opposition"
      expr: COUNT(DISTINCT CASE WHEN opposition_status IS NOT NULL AND opposition_status <> '' AND opposition_status <> 'none' THEN trademark_id END)
      comment: "Number of trademarks facing opposition proceedings. Tracks brand protection legal risk and drives resource allocation for opposition defense."
    - name: "trademarks_in_litigation"
      expr: COUNT(DISTINCT CASE WHEN litigation_flag = TRUE THEN trademark_id END)
      comment: "Number of trademarks subject to active litigation. Measures brand enforcement activity and associated legal cost exposure."
    - name: "madrid_protocol_coverage_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN madrid_protocol_flag = TRUE THEN trademark_id END) / NULLIF(COUNT(DISTINCT trademark_id), 0), 2)
      comment: "Percentage of trademarks filed via the Madrid Protocol. Measures international registration efficiency and cost optimization in brand protection strategy."
    - name: "watch_service_coverage_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN watch_service_flag = TRUE THEN trademark_id END) / NULLIF(COUNT(DISTINCT trademark_id), 0), 2)
      comment: "Percentage of trademarks covered by an active watch service. Measures proactive brand monitoring coverage — gaps expose the company to undetected infringement."
    - name: "renewal_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN registration_status = 'registered' AND expiry_date > CURRENT_DATE THEN trademark_id END) / NULLIF(COUNT(DISTINCT CASE WHEN registration_status = 'registered' THEN trademark_id END), 0), 2)
      comment: "Percentage of registered trademarks with a future expiry date, indicating active renewal compliance. Measures brand protection portfolio maintenance effectiveness."
$$;