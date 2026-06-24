-- Metric views for domain: pharmacy | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 01:44:05

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core pharmacy claims financial and operational KPIs. Tracks plan spend, member cost-sharing, ingredient costs, and dispensing economics across all adjudicated pharmacy claims. Used by pharmacy directors, CFOs, and actuaries to manage drug spend, evaluate benefit design, and monitor PBM performance."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim`"
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (e.g., Medicare Part D, Medicaid, Commercial) for segmenting pharmacy spend by program."
    - name: "pharmacy_channel"
      expr: pharmacy_channel
      comment: "Dispensing channel (retail, mail order, specialty) used to analyze channel mix and cost differentials."
    - name: "claim_status"
      expr: claim_status
      comment: "Adjudication status of the claim (paid, reversed, rejected) for filtering active vs. voided claims."
    - name: "fill_month"
      expr: DATE_TRUNC('MONTH', fill_date)
      comment: "Month of prescription fill date for trend analysis of drug utilization and spend over time."
    - name: "fill_year"
      expr: YEAR(fill_date)
      comment: "Year of prescription fill date for annual pharmacy spend and utilization reporting."
    - name: "is_340b_claim"
      expr: is_340b_claim
      comment: "Indicates whether the claim was processed under the 340B drug pricing program, enabling 340B savings tracking."
    - name: "is_compound_claim"
      expr: is_compound_claim
      comment: "Flags compound drug claims, which carry higher cost and fraud risk, for targeted oversight."
    - name: "daw_code"
      expr: daw_code
      comment: "Dispense As Written code indicating whether brand was dispensed when generic was available — key for generic substitution analysis."
    - name: "step_therapy_override"
      expr: step_therapy_override
      comment: "Flags claims where step therapy protocol was overridden, supporting utilization management review."
    - name: "cob_indicator"
      expr: cob_indicator
      comment: "Coordination of Benefits indicator — identifies claims with secondary payer involvement affecting net plan liability."
  measures:
    - name: "total_plan_paid_amount"
      expr: SUM(CAST(plan_paid_amount AS DOUBLE))
      comment: "Total amount paid by the health plan across all pharmacy claims. Primary KPI for pharmacy spend management and budget variance analysis."
    - name: "total_ingredient_cost"
      expr: SUM(CAST(ingredient_cost AS DOUBLE))
      comment: "Total ingredient cost (drug acquisition cost) across claims. Drives PBM contract performance evaluation and AWP discount analysis."
    - name: "total_dispensing_fee"
      expr: SUM(CAST(dispensing_fee AS DOUBLE))
      comment: "Total dispensing fees paid to pharmacies. Used to evaluate dispensing fee guarantees in PBM contracts."
    - name: "total_member_copay"
      expr: SUM(CAST(member_copay AS DOUBLE))
      comment: "Total member copay collected across claims. Measures member cost-sharing burden and benefit design effectiveness."
    - name: "total_member_coinsurance"
      expr: SUM(CAST(member_coinsurance AS DOUBLE))
      comment: "Total member coinsurance collected. Combined with copay, represents total member out-of-pocket contribution."
    - name: "total_deductible_applied"
      expr: SUM(CAST(deductible_applied AS DOUBLE))
      comment: "Total deductible amounts applied to pharmacy claims. Tracks deductible accumulation pace and benefit period exposure."
    - name: "total_sales_tax"
      expr: SUM(CAST(sales_tax AS DOUBLE))
      comment: "Total sales tax paid on pharmacy claims. Required for state tax compliance reporting and total cost of drug calculation."
    - name: "total_quantity_dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total drug units dispensed across all claims. Supports utilization management and drug volume trend analysis."
    - name: "claim_count"
      expr: COUNT(1)
      comment: "Total number of pharmacy claims adjudicated. Baseline volume metric for utilization rate and per-member-per-month calculations."
    - name: "avg_plan_paid_per_claim"
      expr: AVG(CAST(plan_paid_amount AS DOUBLE))
      comment: "Average plan-paid amount per pharmacy claim. Benchmarks claim-level cost efficiency and detects high-cost outlier patterns."
    - name: "avg_ingredient_cost_per_claim"
      expr: AVG(CAST(ingredient_cost AS DOUBLE))
      comment: "Average ingredient cost per claim. Key input for drug cost trend analysis and formulary tier optimization decisions."
    - name: "total_gross_drug_cost"
      expr: SUM(CAST(ingredient_cost AS DOUBLE) + CAST(dispensing_fee AS DOUBLE) + CAST(sales_tax AS DOUBLE))
      comment: "Approximated gross drug cost (ingredient cost + dispensing fee + sales tax). Represents total pharmacy expenditure before rebates and COB recoveries."
    - name: "member_cost_share_total"
      expr: SUM(CAST(member_copay AS DOUBLE) + CAST(member_coinsurance AS DOUBLE) + CAST(deductible_applied AS DOUBLE))
      comment: "Total member out-of-pocket cost share (copay + coinsurance + deductible). Measures member financial burden and informs benefit design adequacy reviews."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_claim_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy claim line-level financial and clinical KPIs. Provides granular drug dispensing economics, cost-sharing, and utilization management signals at the NDC and fill level. Used by pharmacy benefit managers, clinical pharmacists, and finance teams to evaluate drug-level cost drivers and formulary compliance."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`claim_line`"
  dimensions:
    - name: "pharmacy_channel"
      expr: pharmacy_channel
      comment: "Dispensing channel (retail, mail order, specialty) for channel-level cost and utilization analysis."
    - name: "drug_coverage_status"
      expr: drug_coverage_status
      comment: "Coverage status of the drug on the formulary at time of dispensing — drives formulary compliance reporting."
    - name: "line_status"
      expr: line_status
      comment: "Adjudication status of the claim line (paid, reversed, rejected) for filtering active vs. voided lines."
    - name: "line_type"
      expr: line_type
      comment: "Type of claim line (original, adjustment, reversal) for accurate financial reconciliation."
    - name: "generic_indicator"
      expr: generic_indicator
      comment: "Indicates whether a generic drug was dispensed. Core dimension for generic dispensing rate analysis."
    - name: "specialty_drug_indicator"
      expr: specialty_drug_indicator
      comment: "Flags specialty drug claims, which represent disproportionate share of pharmacy spend."
    - name: "catastrophic_coverage_indicator"
      expr: catastrophic_coverage_indicator
      comment: "Indicates claim falls in the catastrophic coverage phase of Part D benefit — critical for CMS cost-sharing and TrOOP reporting."
    - name: "coverage_gap_indicator"
      expr: coverage_gap_indicator
      comment: "Indicates claim falls in the coverage gap (donut hole) phase — affects member liability and manufacturer discount calculations."
    - name: "step_therapy_indicator"
      expr: step_therapy_indicator
      comment: "Flags claims subject to step therapy requirements — supports utilization management compliance tracking."
    - name: "dispensed_month"
      expr: DATE_TRUNC('MONTH', dispensed_date)
      comment: "Month of drug dispensing for trend analysis of utilization and cost over time."
    - name: "ndc_code"
      expr: ndc_code
      comment: "National Drug Code identifying the specific drug dispensed — enables drug-level cost and utilization analysis."
  measures:
    - name: "total_plan_paid_amount"
      expr: SUM(CAST(plan_paid_amount AS DOUBLE))
      comment: "Total plan-paid amount at the claim line level. Primary financial KPI for drug-level spend analysis and formulary cost management."
    - name: "total_ingredient_cost"
      expr: SUM(CAST(ingredient_cost_amount AS DOUBLE))
      comment: "Total ingredient cost across claim lines. Drives AWP discount performance evaluation and MAC pricing effectiveness."
    - name: "total_dispensing_fee"
      expr: SUM(CAST(dispensing_fee_amount AS DOUBLE))
      comment: "Total dispensing fees at line level. Used to validate PBM dispensing fee guarantees by channel."
    - name: "total_patient_pay"
      expr: SUM(CAST(patient_pay_amount AS DOUBLE))
      comment: "Total patient out-of-pocket payment at line level. Measures member cost burden and informs benefit design adequacy."
    - name: "total_true_oop"
      expr: SUM(CAST(true_oop_amount AS DOUBLE))
      comment: "Total True Out-of-Pocket (TrOOP) cost — the CMS-defined member cost that counts toward catastrophic threshold. Critical for Part D compliance and member protection reporting."
    - name: "total_gross_drug_cost"
      expr: SUM(CAST(gross_drug_cost_amount AS DOUBLE))
      comment: "Total gross drug cost before rebates and adjustments. Represents full drug expenditure exposure for actuarial and financial planning."
    - name: "total_manufacturer_discount"
      expr: SUM(CAST(manufacturer_discount_amount AS DOUBLE))
      comment: "Total manufacturer discounts applied (coverage gap discounts). Tracks ACA-mandated manufacturer contributions and net cost reduction."
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive payments on claim lines. Monitors PBM performance incentive payouts and their impact on net drug cost."
    - name: "total_sales_tax"
      expr: SUM(CAST(sales_tax_amount AS DOUBLE))
      comment: "Total sales tax on dispensed drugs. Required for state tax compliance and total cost of drug calculations."
    - name: "total_quantity_dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total drug units dispensed at line level. Supports drug utilization review and quantity limit compliance monitoring."
    - name: "claim_line_count"
      expr: COUNT(1)
      comment: "Total number of claim lines. Baseline volume metric for utilization rate calculations and PBM performance benchmarking."
    - name: "avg_patient_pay_per_line"
      expr: AVG(CAST(patient_pay_amount AS DOUBLE))
      comment: "Average patient out-of-pocket per claim line. Benchmarks member cost burden by drug tier, channel, and coverage phase."
    - name: "avg_gross_drug_cost_per_line"
      expr: AVG(CAST(gross_drug_cost_amount AS DOUBLE))
      comment: "Average gross drug cost per claim line. Key metric for identifying high-cost drug categories and formulary optimization opportunities."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_benefit_accumulator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member benefit accumulator KPIs tracking deductible, out-of-pocket, TrOOP, and catastrophic threshold progress. Used by actuaries, member services, and compliance teams to monitor benefit period liability, CMS reconciliation status, and member financial protection under Part D and commercial plans."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator`"
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Medicare Part D, Commercial, Medicaid) for segmenting accumulator balances by program."
    - name: "accumulator_status"
      expr: accumulator_status
      comment: "Current status of the accumulator record (active, closed, reconciled) for filtering valid benefit period balances."
    - name: "part_d_benefit_phase"
      expr: part_d_benefit_phase
      comment: "Current Part D benefit phase (deductible, initial coverage, coverage gap, catastrophic) — critical for CMS cost-sharing and TrOOP reporting."
    - name: "is_deductible_met"
      expr: is_deductible_met
      comment: "Indicates whether the member has met their deductible for the benefit period — key for benefit design analysis and member communication."
    - name: "is_moop_met"
      expr: is_moop_met
      comment: "Indicates whether the member has met their Maximum Out-of-Pocket limit — triggers catastrophic coverage and full plan liability."
    - name: "cms_reconciliation_status"
      expr: cms_reconciliation_status
      comment: "CMS reconciliation status for Part D accumulators — essential for regulatory compliance and DIR/reconciliation reporting."
    - name: "coordination_of_benefits_type"
      expr: coordination_of_benefits_type
      comment: "COB type indicating primary/secondary payer arrangement — affects net plan liability and accumulator credit allocation."
    - name: "lis_level"
      expr: lis_level
      comment: "Low Income Subsidy level (Full, Partial, None) — determines member cost-sharing obligations and CMS subsidy amounts."
    - name: "benefit_period_start_year"
      expr: YEAR(benefit_period_start_date)
      comment: "Benefit period year for annual accumulator trend analysis and year-over-year cost exposure comparison."
    - name: "eob_generated_flag"
      expr: eob_generated_flag
      comment: "Indicates whether an Explanation of Benefits was generated for this accumulator record — supports member communication compliance."
  measures:
    - name: "total_oop_applied"
      expr: SUM(CAST(oop_applied_amt AS DOUBLE))
      comment: "Total out-of-pocket amounts applied toward member MOOP limits. Primary metric for member financial protection monitoring and MOOP liability forecasting."
    - name: "total_deductible_applied"
      expr: SUM(CAST(deductible_applied_amt AS DOUBLE))
      comment: "Total deductible amounts applied across members. Tracks deductible accumulation pace and informs benefit period liability projections."
    - name: "total_troop_applied"
      expr: SUM(CAST(troop_applied_amt AS DOUBLE))
      comment: "Total True Out-of-Pocket (TrOOP) amounts applied. CMS-mandated metric for Part D catastrophic threshold tracking and DIR reconciliation."
    - name: "total_catastrophic_applied"
      expr: SUM(CAST(catastrophic_applied_amt AS DOUBLE))
      comment: "Total amounts applied in the catastrophic coverage phase. Measures plan liability after MOOP is met — key for actuarial reserve calculations."
    - name: "total_coverage_gap_discount_applied"
      expr: SUM(CAST(coverage_gap_discount_applied_amt AS DOUBLE))
      comment: "Total manufacturer coverage gap discounts applied. Tracks ACA-mandated 70% manufacturer discount contributions and their impact on TrOOP."
    - name: "total_icl_applied"
      expr: SUM(CAST(icl_applied_amt AS DOUBLE))
      comment: "Total Initial Coverage Limit (ICL) amounts applied. Tracks member progress toward the coverage gap threshold under Part D."
    - name: "total_specialty_drug_applied"
      expr: SUM(CAST(specialty_drug_applied_amt AS DOUBLE))
      comment: "Total specialty drug cost applied to accumulators. Monitors specialty drug spend contribution to OOP and deductible thresholds."
    - name: "total_family_oop_applied"
      expr: SUM(CAST(family_oop_applied_amt AS DOUBLE))
      comment: "Total family-level out-of-pocket amounts applied. Tracks aggregate family cost-sharing exposure for embedded deductible plan designs."
    - name: "total_mail_order_applied"
      expr: SUM(CAST(mail_order_applied_amt AS DOUBLE))
      comment: "Total mail order drug costs applied to accumulators. Supports mail order channel cost analysis and benefit design optimization."
    - name: "total_hsa_eligible_applied"
      expr: SUM(CAST(hsa_eligible_applied_amt AS DOUBLE))
      comment: "Total HSA-eligible amounts applied. Required for HDHP/HSA compliance reporting and member HSA contribution guidance."
    - name: "avg_oop_applied_per_member"
      expr: AVG(CAST(oop_applied_amt AS DOUBLE))
      comment: "Average out-of-pocket amount applied per accumulator record. Benchmarks member cost burden across benefit designs and lines of business."
    - name: "avg_troop_applied_per_member"
      expr: AVG(CAST(troop_applied_amt AS DOUBLE))
      comment: "Average TrOOP applied per accumulator record. Key input for Part D catastrophic threshold attainment rate modeling and CMS DIR projections."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_prior_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization (PA) operational and clinical KPIs for pharmacy. Tracks PA approval rates, denial patterns, turnaround times, and specialty drug utilization management effectiveness. Used by medical directors, compliance officers, and pharmacy benefit managers to optimize PA workflows and ensure regulatory compliance."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`prior_authorization`"
  dimensions:
    - name: "pa_status"
      expr: pa_status
      comment: "Current status of the prior authorization (approved, denied, pending, appealed) — primary dimension for PA outcome analysis."
    - name: "pa_type"
      expr: pa_type
      comment: "Type of prior authorization request (new, renewal, appeal) for workflow volume and outcome segmentation."
    - name: "lob"
      expr: lob
      comment: "Line of business for the PA request — enables program-level PA performance comparison."
    - name: "drug_tier"
      expr: drug_tier
      comment: "Formulary tier of the drug requiring PA — identifies which tiers drive the highest PA volume and denial rates."
    - name: "dispensing_channel"
      expr: dispensing_channel
      comment: "Dispensing channel (retail, mail, specialty) for the authorized drug — supports channel-level PA management analysis."
    - name: "specialty_drug_flag"
      expr: specialty_drug_flag
      comment: "Flags PA requests for specialty drugs — specialty PAs require heightened clinical oversight and represent high-cost exposure."
    - name: "appeal_indicator"
      expr: appeal_indicator
      comment: "Indicates whether the PA was subject to an appeal — tracks appeal volume and reversal rates for compliance and quality reporting."
    - name: "criteria_met"
      expr: criteria_met
      comment: "Indicates whether clinical criteria were met at time of decision — core dimension for clinical appropriateness analysis."
    - name: "step_therapy_required"
      expr: step_therapy_required
      comment: "Indicates whether step therapy was required as part of the PA — supports step therapy compliance and override rate tracking."
    - name: "cms_part_d_reportable"
      expr: cms_part_d_reportable
      comment: "Flags PAs that must be reported to CMS under Part D regulations — critical for regulatory compliance monitoring."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month of PA request for trend analysis of PA volume, approval rates, and turnaround times."
    - name: "review_level"
      expr: review_level
      comment: "Level of clinical review applied (standard, expedited, peer-to-peer) — informs staffing and workflow optimization."
  measures:
    - name: "pa_request_count"
      expr: COUNT(1)
      comment: "Total number of prior authorization requests. Baseline volume metric for PA workload management and staffing decisions."
    - name: "approved_pa_count"
      expr: COUNT(CASE WHEN pa_status = 'approved' THEN 1 END)
      comment: "Count of approved prior authorization requests. Used with total PA count to compute approval rate — key clinical appropriateness KPI."
    - name: "denied_pa_count"
      expr: COUNT(CASE WHEN pa_status = 'denied' THEN 1 END)
      comment: "Count of denied prior authorization requests. Tracks denial volume by drug, tier, and LOB for formulary management and regulatory oversight."
    - name: "appeal_pa_count"
      expr: COUNT(CASE WHEN appeal_indicator = TRUE THEN 1 END)
      comment: "Count of PA requests that were appealed. High appeal rates signal potential over-denial and regulatory risk under CMS and state mandates."
    - name: "criteria_met_count"
      expr: COUNT(CASE WHEN criteria_met = TRUE THEN 1 END)
      comment: "Count of PAs where clinical criteria were met. Measures clinical appropriateness of PA decisions and formulary restriction effectiveness."
    - name: "step_therapy_completed_count"
      expr: COUNT(CASE WHEN step_therapy_completed = TRUE THEN 1 END)
      comment: "Count of PAs where step therapy was completed prior to approval. Validates step therapy protocol adherence and cost-avoidance effectiveness."
    - name: "total_approved_quantity"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Total drug quantity approved across all PA decisions. Supports drug utilization forecasting and specialty drug volume management."
    - name: "unique_member_count"
      expr: COUNT(DISTINCT policy_id)
      comment: "Count of distinct members (by policy) with PA requests. Measures PA burden on the member population and identifies high-utilization cohorts."
    - name: "unique_drug_count"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Count of distinct drugs requiring prior authorization. Tracks formulary restriction breadth and identifies drugs with high PA friction."
    - name: "cms_reportable_pa_count"
      expr: COUNT(CASE WHEN cms_part_d_reportable = TRUE THEN 1 END)
      comment: "Count of PAs subject to CMS Part D reporting requirements. Ensures regulatory submission completeness and avoids CMS audit findings."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_formulary_drug_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulary drug tier configuration and cost-sharing KPIs. Tracks formulary coverage, tier cost-sharing levels, and utilization management restrictions across benefit years and lines of business. Used by pharmacy directors and actuaries to optimize formulary design, manage drug tier placement, and ensure CMS compliance."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier`"
  dimensions:
    - name: "tier_name"
      expr: tier_name
      comment: "Formulary tier name (e.g., Generic, Preferred Brand, Non-Preferred, Specialty) — primary dimension for cost-sharing structure analysis."
    - name: "tier_number"
      expr: tier_number
      comment: "Numeric tier identifier for ordering and comparing cost-sharing levels across formulary tiers."
    - name: "benefit_year"
      expr: benefit_year
      comment: "Benefit year for the formulary tier configuration — enables year-over-year formulary change analysis."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code for the formulary tier — supports program-level formulary design comparison."
    - name: "coverage_status"
      expr: coverage_status
      comment: "Coverage status of the drug on this tier (covered, not covered, prior auth required) — tracks formulary access restrictions."
    - name: "prior_auth_required"
      expr: prior_auth_required
      comment: "Indicates whether prior authorization is required for this drug tier placement — key for utilization management burden analysis."
    - name: "step_therapy_required"
      expr: step_therapy_required
      comment: "Indicates whether step therapy is required — tracks step therapy restriction breadth across the formulary."
    - name: "quantity_limit_required"
      expr: quantity_limit_required
      comment: "Indicates whether quantity limits apply — measures formulary restriction intensity and clinical management scope."
    - name: "specialty_drug_flag"
      expr: specialty_drug_flag
      comment: "Flags specialty drug tier placements — specialty tier management is critical for high-cost drug spend control."
    - name: "dispensing_channel"
      expr: dispensing_channel
      comment: "Dispensing channel for which this tier configuration applies — supports channel-specific cost-sharing analysis."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the tier configuration became effective — tracks formulary change timing and mid-year tier movement."
  measures:
    - name: "formulary_drug_count"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Count of distinct drugs on the formulary by tier. Measures formulary breadth and tier composition for benefit design adequacy assessment."
    - name: "avg_copay_retail_30"
      expr: AVG(CAST(copay_retail_30 AS DOUBLE))
      comment: "Average 30-day retail copay by tier. Benchmarks member cost-sharing levels and informs benefit design competitiveness analysis."
    - name: "avg_copay_retail_90"
      expr: AVG(CAST(copay_retail_90 AS DOUBLE))
      comment: "Average 90-day retail copay by tier. Supports mail order vs. retail cost-sharing differential analysis and member incentive design."
    - name: "avg_copay_mail_order"
      expr: AVG(CAST(copay_mail_order AS DOUBLE))
      comment: "Average mail order copay by tier. Used to evaluate mail order cost incentives and their effectiveness in driving channel shift."
    - name: "avg_coinsurance_rate"
      expr: AVG(CAST(coinsurance_rate AS DOUBLE))
      comment: "Average coinsurance rate by tier. Measures member cost-sharing percentage exposure, particularly relevant for specialty and non-preferred tiers."
    - name: "avg_quantity_limit_max"
      expr: AVG(CAST(ql_max_quantity AS DOUBLE))
      comment: "Average maximum quantity limit applied across formulary drug tiers. Supports quantity limit policy calibration and clinical appropriateness review."
    - name: "prior_auth_drug_count"
      expr: COUNT(CASE WHEN prior_auth_required = TRUE THEN drug_master_id END)
      comment: "Count of formulary drugs requiring prior authorization. Measures PA burden scope and informs PA staffing and workflow planning."
    - name: "step_therapy_drug_count"
      expr: COUNT(CASE WHEN step_therapy_required = TRUE THEN drug_master_id END)
      comment: "Count of formulary drugs subject to step therapy requirements. Tracks utilization management restriction breadth and cost-avoidance program scope."
    - name: "specialty_drug_tier_count"
      expr: COUNT(CASE WHEN specialty_drug_flag = TRUE THEN drug_master_id END)
      comment: "Count of specialty drugs on the formulary. Monitors specialty formulary size and informs specialty spend management strategy."
    - name: "total_deductible_applies"
      expr: SUM(CAST(deductible_applies AS DOUBLE))
      comment: "Sum of deductible applicability indicators across tier configurations. Measures the scope of deductible-subject drug placements in the formulary."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_drug_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug pricing KPIs tracking AWP, WAC, MAC, and contracted pricing levels across formularies and PBM contracts. Used by pharmacy finance, contracting, and actuarial teams to monitor drug cost trends, evaluate PBM pricing guarantees, and identify pricing anomalies."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`drug_pricing`"
  dimensions:
    - name: "pricing_source"
      expr: pricing_source
      comment: "Source of the drug pricing data (e.g., Medi-Span, Red Book, PBM) — critical for pricing data quality and source reconciliation."
    - name: "pricing_status"
      expr: pricing_status
      comment: "Status of the pricing record (active, expired, pending) for filtering current vs. historical pricing."
    - name: "dispensing_channel"
      expr: dispensing_channel
      comment: "Dispensing channel for which pricing applies (retail, mail, specialty) — enables channel-specific pricing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pricing record — required for multi-currency pricing normalization."
    - name: "multi_source_code"
      expr: multi_source_code
      comment: "Multi-source code indicating brand/generic status — key for AWP discount and MAC pricing applicability analysis."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the pricing became effective — enables annual drug price trend analysis and inflation monitoring."
    - name: "pricing_file_date_month"
      expr: DATE_TRUNC('MONTH', pricing_file_date)
      comment: "Month of the pricing file update — tracks pricing file currency and identifies stale pricing records."
  measures:
    - name: "avg_awp_price"
      expr: AVG(CAST(awp_price AS DOUBLE))
      comment: "Average AWP (Average Wholesale Price) across drugs. Baseline benchmark for PBM AWP discount negotiation and drug cost benchmarking."
    - name: "avg_wac_price"
      expr: AVG(CAST(wac_price AS DOUBLE))
      comment: "Average WAC (Wholesale Acquisition Cost) across drugs. Used as the manufacturer list price baseline for rebate and discount calculations."
    - name: "avg_mac_price"
      expr: AVG(CAST(mac_price AS DOUBLE))
      comment: "Average MAC (Maximum Allowable Cost) price. Measures generic drug pricing ceiling effectiveness and MAC list competitiveness."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average contracted unit price across all drug pricing records. Represents the effective negotiated price paid — key for PBM contract performance evaluation."
    - name: "avg_rbp_price"
      expr: AVG(CAST(rbp_price AS DOUBLE))
      comment: "Average Reference-Based Pricing (RBP) price. Tracks RBP methodology effectiveness and cost savings vs. AWP-based pricing."
    - name: "avg_awp_discount_pct"
      expr: AVG(CAST(awp_discount_pct AS DOUBLE))
      comment: "Average AWP discount percentage achieved. Core PBM contract performance metric — measures discount depth vs. guaranteed discount levels."
    - name: "avg_dispensing_fee"
      expr: AVG(CAST(dispensing_fee AS DOUBLE))
      comment: "Average dispensing fee in pricing contracts. Benchmarks dispensing fee levels against PBM contract guarantees by channel."
    - name: "avg_price_change_pct"
      expr: AVG(CAST(price_change_pct AS DOUBLE))
      comment: "Average price change percentage from prior period. Monitors drug price inflation trends and triggers formulary tier review when thresholds are exceeded."
    - name: "drug_pricing_record_count"
      expr: COUNT(1)
      comment: "Total number of active drug pricing records. Measures pricing file completeness and coverage for formulary drug population."
    - name: "avg_awp_vs_unit_price_spread"
      expr: AVG(CAST(awp_price AS DOUBLE) - CAST(unit_price AS DOUBLE))
      comment: "Average spread between AWP and contracted unit price. Directly measures the dollar value of AWP discount achieved — key PBM savings metric."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_dispensing_pharmacy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispensing pharmacy network KPIs tracking network composition, participation status, and contracted economics. Used by network management, contracting, and compliance teams to monitor pharmacy network adequacy, tier distribution, and PBM contract performance."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy`"
  dimensions:
    - name: "network_participation_status"
      expr: network_participation_status
      comment: "Current network participation status (in-network, out-of-network, terminated) — primary dimension for network adequacy analysis."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier designation (preferred, standard, non-preferred) — drives member cost-sharing differentials and network steering strategy."
    - name: "pharmacy_type"
      expr: pharmacy_type
      comment: "Type of pharmacy (retail, mail order, specialty, long-term care) — enables network composition and channel mix analysis."
    - name: "dispensing_state_code"
      expr: dispensing_state_code
      comment: "State where the pharmacy is located — supports geographic network adequacy analysis and state regulatory compliance."
    - name: "chain_independent_flag"
      expr: chain_independent_flag
      comment: "Distinguishes chain pharmacies from independent pharmacies — informs network diversity and independent pharmacy access metrics."
    - name: "mail_order_capable"
      expr: mail_order_capable
      comment: "Indicates mail order dispensing capability — used to assess mail order network capacity and channel expansion opportunities."
    - name: "cold_chain_certified"
      expr: cold_chain_certified
      comment: "Indicates cold chain certification for temperature-sensitive drugs (biologics, vaccines) — critical for specialty drug network adequacy."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for which the pharmacy is contracted — enables LOB-specific network adequacy assessment."
    - name: "network_effective_year"
      expr: YEAR(network_effective_date)
      comment: "Year the pharmacy joined the network — supports network tenure analysis and contract renewal planning."
  measures:
    - name: "total_pharmacy_count"
      expr: COUNT(1)
      comment: "Total number of dispensing pharmacies in the network. Primary network adequacy metric used by CMS and state regulators to assess member access."
    - name: "in_network_pharmacy_count"
      expr: COUNT(CASE WHEN network_participation_status = 'active' THEN 1 END)
      comment: "Count of currently active in-network pharmacies. Core network adequacy KPI for CMS network adequacy standards and member access reporting."
    - name: "mail_order_pharmacy_count"
      expr: COUNT(CASE WHEN mail_order_capable = TRUE THEN 1 END)
      comment: "Count of mail order capable pharmacies. Measures mail order network capacity to support channel shift initiatives and member convenience."
    - name: "cold_chain_pharmacy_count"
      expr: COUNT(CASE WHEN cold_chain_certified = TRUE THEN 1 END)
      comment: "Count of cold chain certified pharmacies. Measures specialty drug dispensing network adequacy for biologics and temperature-sensitive medications."
    - name: "avg_awp_discount_percent"
      expr: AVG(CAST(awp_discount_percent AS DOUBLE))
      comment: "Average AWP discount percentage across contracted pharmacies. Benchmarks network-level discount depth against PBM contract guarantees."
    - name: "avg_dispensing_fee"
      expr: AVG(CAST(dispensing_fee_amount AS DOUBLE))
      comment: "Average contracted dispensing fee across network pharmacies. Used to validate PBM dispensing fee guarantees and benchmark network economics."
    - name: "avg_ingredient_cost_basis"
      expr: AVG(CAST(ingredient_cost_basis AS DOUBLE))
      comment: "Average ingredient cost basis across contracted pharmacies. Measures the pricing methodology (AWP%, MAC, WAC%) applied across the network."
    - name: "unique_chain_count"
      expr: COUNT(DISTINCT chain_organization_name)
      comment: "Count of distinct pharmacy chain organizations in the network. Measures network diversity and chain concentration risk for contract negotiation leverage."
    - name: "unique_state_count"
      expr: COUNT(DISTINCT dispensing_state_code)
      comment: "Count of distinct states with network pharmacy coverage. Measures geographic network breadth for multi-state plan adequacy compliance."
$$;