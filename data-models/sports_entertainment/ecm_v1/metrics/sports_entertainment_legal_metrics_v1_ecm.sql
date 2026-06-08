-- Metric views for domain: legal | Business: Sports Entertainment | Version: 1 | Generated on: 2026-05-09 01:35:39

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`legal_litigation_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic litigation performance metrics tracking case exposure, legal spend efficiency, and resolution outcomes for risk management and budget steering"
  source: "`sports_entertainment_ecm`.`legal`.`litigation_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the litigation case (active, settled, dismissed, etc.)"
    - name: "case_type"
      expr: case_type
      comment: "Type of litigation (contract dispute, employment, IP infringement, etc.)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction where the case is being heard"
    - name: "party_role"
      expr: party_role
      comment: "Role of the organization in the case (plaintiff, defendant, etc.)"
    - name: "is_material"
      expr: is_material
      comment: "Whether the case is material to financial reporting"
    - name: "cba_related"
      expr: cba_related
      comment: "Whether the case relates to collective bargaining agreements"
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year the case was filed"
    - name: "disposition_type"
      expr: disposition_type
      comment: "How the case was resolved (settlement, judgment, dismissal, etc.)"
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of litigation cases"
    - name: "total_estimated_exposure"
      expr: SUM(CAST(estimated_exposure_amount AS DOUBLE))
      comment: "Total estimated financial exposure across all cases"
    - name: "total_legal_fees_incurred"
      expr: SUM(CAST(legal_fees_incurred AS DOUBLE))
      comment: "Total legal fees incurred across all cases"
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amounts paid across all cases"
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total reserve amounts set aside for litigation risk"
    - name: "avg_estimated_exposure_per_case"
      expr: AVG(CAST(estimated_exposure_amount AS DOUBLE))
      comment: "Average estimated exposure per litigation case"
    - name: "avg_legal_fees_per_case"
      expr: AVG(CAST(legal_fees_incurred AS DOUBLE))
      comment: "Average legal fees incurred per case"
    - name: "material_cases_count"
      expr: COUNT(CASE WHEN is_material = TRUE THEN 1 END)
      comment: "Count of cases flagged as material to financial reporting"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`legal_matter`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Legal matter portfolio metrics tracking spend efficiency, matter lifecycle, and risk exposure across all legal work streams"
  source: "`sports_entertainment_ecm`.`legal`.`matter`"
  dimensions:
    - name: "matter_status"
      expr: matter_status
      comment: "Current status of the legal matter"
    - name: "matter_type"
      expr: matter_type
      comment: "Type of legal matter (litigation, transactional, regulatory, etc.)"
    - name: "legal_practice_area"
      expr: legal_practice_area
      comment: "Practice area of law (corporate, IP, employment, etc.)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the matter (high, medium, low)"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit associated with the matter"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the matter"
    - name: "litigation_risk_flag"
      expr: litigation_risk_flag
      comment: "Whether the matter carries litigation risk"
    - name: "open_year"
      expr: YEAR(open_date)
      comment: "Year the matter was opened"
  measures:
    - name: "total_matters"
      expr: COUNT(1)
      comment: "Total number of legal matters"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_to_date AS DOUBLE))
      comment: "Total actual legal spend across all matters"
    - name: "total_estimated_spend"
      expr: SUM(CAST(estimated_legal_spend AS DOUBLE))
      comment: "Total estimated legal spend across all matters"
    - name: "total_financial_exposure"
      expr: SUM(CAST(financial_exposure_amount AS DOUBLE))
      comment: "Total financial exposure across all matters"
    - name: "avg_actual_spend_per_matter"
      expr: AVG(CAST(actual_spend_to_date AS DOUBLE))
      comment: "Average actual spend per matter"
    - name: "high_priority_matters_count"
      expr: COUNT(CASE WHEN priority_level = 'High' THEN 1 END)
      comment: "Count of high-priority matters requiring immediate attention"
    - name: "litigation_risk_matters_count"
      expr: COUNT(CASE WHEN litigation_risk_flag = TRUE THEN 1 END)
      comment: "Count of matters flagged with litigation risk"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`legal_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Legal spend invoice metrics tracking billing compliance, payment efficiency, and outside counsel cost management"
  source: "`sports_entertainment_ecm`.`legal`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (pending, approved, paid, disputed, etc.)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (standard, credit memo, etc.)"
    - name: "billing_format"
      expr: billing_format
      comment: "Format of the billing (LEDES, narrative, etc.)"
    - name: "matter_type"
      expr: matter_type
      comment: "Type of matter being billed"
    - name: "is_ebilling_compliant"
      expr: is_ebilling_compliant
      comment: "Whether the invoice complies with e-billing standards"
    - name: "guideline_violation_flag"
      expr: guideline_violation_flag
      comment: "Whether the invoice violates billing guidelines"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year the invoice was issued"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was issued"
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of legal invoices"
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total amount billed across all invoices"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total amount approved for payment"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount actually paid"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount disputed across all invoices"
    - name: "total_fees_billed"
      expr: SUM(CAST(fees_billed_amount AS DOUBLE))
      comment: "Total legal fees billed (excluding expenses)"
    - name: "total_expenses_billed"
      expr: SUM(CAST(expenses_billed_amount AS DOUBLE))
      comment: "Total expenses billed"
    - name: "avg_billed_amount_per_invoice"
      expr: AVG(CAST(billed_amount AS DOUBLE))
      comment: "Average billed amount per invoice"
    - name: "guideline_violation_count"
      expr: COUNT(CASE WHEN guideline_violation_flag = TRUE THEN 1 END)
      comment: "Count of invoices with billing guideline violations"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`legal_outside_counsel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outside counsel performance and spend metrics for vendor management, rate benchmarking, and panel optimization"
  source: "`sports_entertainment_ecm`.`legal`.`outside_counsel`"
  dimensions:
    - name: "firm_name"
      expr: firm_name
      comment: "Name of the outside counsel firm"
    - name: "firm_type"
      expr: firm_type
      comment: "Type of firm (large, mid-size, boutique, solo practitioner)"
    - name: "engagement_status"
      expr: engagement_status
      comment: "Current engagement status with the firm"
    - name: "primary_jurisdiction"
      expr: primary_jurisdiction
      comment: "Primary jurisdiction where the firm practices"
    - name: "panel_counsel_flag"
      expr: panel_counsel_flag
      comment: "Whether the firm is on the preferred panel"
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Whether the firm is a preferred vendor"
    - name: "diversity_certification_type"
      expr: diversity_certification_type
      comment: "Type of diversity certification held by the firm"
    - name: "hq_country_code"
      expr: hq_country_code
      comment: "Country code of the firm's headquarters"
  measures:
    - name: "total_firms"
      expr: COUNT(1)
      comment: "Total number of outside counsel firms"
    - name: "total_annual_spend_budget"
      expr: SUM(CAST(annual_spend_budget_usd AS DOUBLE))
      comment: "Total annual spend budget allocated across all firms"
    - name: "avg_partner_rate"
      expr: AVG(CAST(standard_partner_rate_usd AS DOUBLE))
      comment: "Average standard partner billing rate across firms"
    - name: "avg_associate_rate"
      expr: AVG(CAST(standard_associate_rate_usd AS DOUBLE))
      comment: "Average standard associate billing rate across firms"
    - name: "avg_paralegal_rate"
      expr: AVG(CAST(standard_paralegal_rate_usd AS DOUBLE))
      comment: "Average standard paralegal billing rate across firms"
    - name: "panel_counsel_count"
      expr: COUNT(CASE WHEN panel_counsel_flag = TRUE THEN 1 END)
      comment: "Count of firms on the preferred panel"
    - name: "preferred_vendor_count"
      expr: COUNT(CASE WHEN preferred_vendor_flag = TRUE THEN 1 END)
      comment: "Count of firms designated as preferred vendors"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`legal_insurance_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Insurance claim performance metrics tracking claim resolution efficiency, recovery rates, and coverage utilization for risk transfer optimization"
  source: "`sports_entertainment_ecm`.`legal`.`insurance_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the insurance claim"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of insurance claim (liability, property, workers comp, etc.)"
    - name: "coverage_line"
      expr: coverage_line
      comment: "Insurance coverage line under which the claim is filed"
    - name: "claimant_type"
      expr: claimant_type
      comment: "Type of claimant (employee, fan, vendor, etc.)"
    - name: "coverage_confirmed"
      expr: coverage_confirmed
      comment: "Whether insurance coverage has been confirmed for the claim"
    - name: "is_subrogation_applicable"
      expr: is_subrogation_applicable
      comment: "Whether subrogation recovery is applicable"
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year the claim was filed"
    - name: "incident_country_code"
      expr: incident_country_code
      comment: "Country code where the incident occurred"
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of insurance claims"
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total amount claimed across all claims"
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amounts paid by insurers"
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total reserve amounts set aside for claims"
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible amounts across all claims"
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total recovery amounts from third parties"
    - name: "total_subrogation_recovery"
      expr: SUM(CAST(subrogation_recovery_amount AS DOUBLE))
      comment: "Total subrogation recovery amounts"
    - name: "avg_claimed_amount_per_claim"
      expr: AVG(CAST(claimed_amount AS DOUBLE))
      comment: "Average claimed amount per claim"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`legal_contract_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract obligation tracking metrics for compliance monitoring, payment scheduling, and obligation fulfillment performance"
  source: "`sports_entertainment_ecm`.`legal`.`contract_obligation`"
  dimensions:
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the contract obligation"
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of obligation (payment, delivery, performance, reporting, etc.)"
    - name: "contract_domain"
      expr: contract_domain
      comment: "Domain of the contract (athlete, sponsorship, licensing, etc.)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the obligation"
    - name: "completion_status"
      expr: completion_status
      comment: "Whether the obligation has been completed"
    - name: "is_material_obligation"
      expr: is_material_obligation
      comment: "Whether the obligation is material to the contract"
    - name: "is_recurring"
      expr: is_recurring
      comment: "Whether the obligation recurs on a schedule"
    - name: "escalation_required"
      expr: escalation_required
      comment: "Whether the obligation requires escalation"
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year the obligation is due"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of contract obligations"
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment amounts across all obligations"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts for non-compliance"
    - name: "avg_payment_amount_per_obligation"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per obligation"
    - name: "material_obligations_count"
      expr: COUNT(CASE WHEN is_material_obligation = TRUE THEN 1 END)
      comment: "Count of material obligations requiring executive attention"
    - name: "escalated_obligations_count"
      expr: COUNT(CASE WHEN escalation_required = TRUE THEN 1 END)
      comment: "Count of obligations requiring escalation"
    - name: "completed_obligations_count"
      expr: COUNT(CASE WHEN completion_status = TRUE THEN 1 END)
      comment: "Count of completed obligations"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`legal_ip_portfolio`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intellectual property portfolio metrics tracking asset valuation, registration status, and IP protection coverage for brand and content monetization"
  source: "`sports_entertainment_ecm`.`legal`.`ip_portfolio`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type of IP asset (trademark, copyright, patent, domain, etc.)"
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status of the IP asset"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction where the IP is registered"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of IP protection (national, regional, international)"
    - name: "licensing_eligible"
      expr: licensing_eligible
      comment: "Whether the IP asset is eligible for licensing"
    - name: "enforcement_watch_active"
      expr: enforcement_watch_active
      comment: "Whether active enforcement monitoring is in place"
    - name: "opposition_filed"
      expr: opposition_filed
      comment: "Whether an opposition has been filed against the IP"
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year the IP application was filed"
  measures:
    - name: "total_ip_assets"
      expr: COUNT(1)
      comment: "Total number of IP assets in the portfolio"
    - name: "total_estimated_valuation"
      expr: SUM(CAST(estimated_valuation_usd AS DOUBLE))
      comment: "Total estimated valuation of all IP assets"
    - name: "avg_valuation_per_asset"
      expr: AVG(CAST(estimated_valuation_usd AS DOUBLE))
      comment: "Average estimated valuation per IP asset"
    - name: "licensing_eligible_count"
      expr: COUNT(CASE WHEN licensing_eligible = TRUE THEN 1 END)
      comment: "Count of IP assets eligible for licensing revenue"
    - name: "enforcement_watch_count"
      expr: COUNT(CASE WHEN enforcement_watch_active = TRUE THEN 1 END)
      comment: "Count of IP assets under active enforcement monitoring"
    - name: "opposed_assets_count"
      expr: COUNT(CASE WHEN opposition_filed = TRUE THEN 1 END)
      comment: "Count of IP assets facing opposition proceedings"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`legal_spend_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Legal spend budget performance metrics tracking budget utilization, variance analysis, and cost control for financial planning and resource allocation"
  source: "`sports_entertainment_ecm`.`legal`.`spend_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget (active, closed, exceeded, etc.)"
    - name: "budget_category"
      expr: budget_category
      comment: "Category of legal spend (litigation, transactional, compliance, etc.)"
    - name: "matter_type"
      expr: matter_type
      comment: "Type of matter associated with the budget"
    - name: "business_unit_name"
      expr: business_unit_name
      comment: "Business unit responsible for the budget"
    - name: "budget_period_year"
      expr: budget_period_year
      comment: "Fiscal year of the budget period"
    - name: "is_material_litigation_reserve"
      expr: is_material_litigation_reserve
      comment: "Whether the budget includes material litigation reserves"
    - name: "outside_counsel_engagement_type"
      expr: outside_counsel_engagement_type
      comment: "Type of outside counsel engagement (hourly, fixed fee, contingency, etc.)"
  measures:
    - name: "total_budgets"
      expr: COUNT(1)
      comment: "Total number of legal spend budgets"
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved budget amount across all budgets"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend against budgets"
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed amounts not yet spent"
    - name: "total_reforecast_amount"
      expr: SUM(CAST(reforecast_amount AS DOUBLE))
      comment: "Total reforecast budget amounts"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between approved budget and actual spend"
    - name: "total_litigation_reserve"
      expr: SUM(CAST(litigation_reserve_amount AS DOUBLE))
      comment: "Total litigation reserve amounts set aside"
    - name: "avg_spend_to_budget_pct"
      expr: AVG(CAST(spend_to_budget_pct AS DOUBLE))
      comment: "Average spend-to-budget percentage across all budgets"
$$;