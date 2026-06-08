-- Metric views for domain: ip | Business: Legal | Version: 1 | Generated on: 2026-05-07 11:54:14

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`ip_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core IP asset portfolio metrics tracking valuation, annuity obligations, and asset lifecycle across patents, trademarks, copyrights, and trade secrets"
  source: "`legal_ecm`.`ip`.`ip_asset`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type of intellectual property asset (patent, trademark, copyright, trade secret)"
    - name: "asset_status"
      expr: ip_asset_status
      comment: "Current lifecycle status of the IP asset"
    - name: "jurisdiction"
      expr: jurisdiction_code
      comment: "Legal jurisdiction where the IP asset is registered or protected"
    - name: "portfolio_category"
      expr: portfolio_category
      comment: "Strategic portfolio classification for asset management"
    - name: "technology_area"
      expr: technology_area
      comment: "Technology domain or field of the IP asset"
    - name: "licensing_status"
      expr: licensing_status
      comment: "Current licensing state of the asset"
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year the IP asset was filed"
    - name: "registration_year"
      expr: YEAR(registration_date)
      comment: "Year the IP asset was registered"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the IP asset expires"
    - name: "is_frand_declared"
      expr: frand_declaration_flag
      comment: "Whether asset is subject to FRAND (Fair, Reasonable, and Non-Discriminatory) obligations"
    - name: "has_opposition"
      expr: opposition_filed_flag
      comment: "Whether an opposition has been filed against this asset"
    - name: "is_pct_application"
      expr: pct_application_flag
      comment: "Whether asset was filed under Patent Cooperation Treaty"
  measures:
    - name: "total_ip_assets"
      expr: COUNT(1)
      comment: "Total count of IP assets in portfolio"
    - name: "total_portfolio_valuation"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total valuation of IP asset portfolio"
    - name: "avg_asset_valuation"
      expr: AVG(CAST(valuation_amount AS DOUBLE))
      comment: "Average valuation per IP asset"
    - name: "total_annuity_obligations"
      expr: SUM(CAST(annuity_amount AS DOUBLE))
      comment: "Total annuity payment obligations across portfolio"
    - name: "avg_annuity_per_asset"
      expr: AVG(CAST(annuity_amount AS DOUBLE))
      comment: "Average annuity payment per asset"
    - name: "assets_with_valuation"
      expr: COUNT(DISTINCT CASE WHEN valuation_amount IS NOT NULL THEN ip_asset_id END)
      comment: "Count of assets with recorded valuations"
    - name: "assets_expiring_soon"
      expr: COUNT(DISTINCT CASE WHEN expiration_date <= DATE_ADD(CURRENT_DATE(), 365) THEN ip_asset_id END)
      comment: "Count of assets expiring within next 12 months"
    - name: "frand_asset_count"
      expr: COUNT(DISTINCT CASE WHEN frand_declaration_flag = TRUE THEN ip_asset_id END)
      comment: "Count of assets with FRAND obligations"
    - name: "opposed_asset_count"
      expr: COUNT(DISTINCT CASE WHEN opposition_filed_flag = TRUE THEN ip_asset_id END)
      comment: "Count of assets facing opposition proceedings"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`ip_patent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patent portfolio metrics tracking prosecution status, claims, litigation exposure, and strategic patent indicators"
  source: "`legal_ecm`.`ip`.`patent`"
  dimensions:
    - name: "prosecution_status"
      expr: prosecution_status
      comment: "Current status in patent prosecution lifecycle"
    - name: "patent_type"
      expr: patent_type
      comment: "Type of patent (utility, design, plant, etc.)"
    - name: "jurisdiction"
      expr: jurisdiction_code
      comment: "Patent jurisdiction or country code"
    - name: "licensing_status"
      expr: licensing_status
      comment: "Current licensing state of the patent"
    - name: "is_standard_essential"
      expr: standard_essential_patent_flag
      comment: "Whether patent is declared as standard-essential (SEP)"
    - name: "is_frand_obligated"
      expr: frand_obligation_flag
      comment: "Whether patent is subject to FRAND licensing obligations"
    - name: "is_in_litigation"
      expr: litigation_flag
      comment: "Whether patent is currently involved in litigation"
    - name: "is_pct_filed"
      expr: pct_application_number IS NOT NULL
      comment: "Whether patent was filed via Patent Cooperation Treaty"
    - name: "is_pph_eligible"
      expr: pph_eligible_flag
      comment: "Whether patent is eligible for Patent Prosecution Highway"
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year patent application was filed"
    - name: "grant_year"
      expr: YEAR(grant_date)
      comment: "Year patent was granted"
    - name: "priority_year"
      expr: YEAR(priority_date)
      comment: "Year of earliest priority claim"
  measures:
    - name: "total_patents"
      expr: COUNT(1)
      comment: "Total count of patents in portfolio"
    - name: "total_portfolio_value"
      expr: SUM(CAST(estimated_portfolio_value AS DOUBLE))
      comment: "Total estimated value of patent portfolio"
    - name: "avg_patent_value"
      expr: AVG(CAST(estimated_portfolio_value AS DOUBLE))
      comment: "Average estimated value per patent"
    - name: "granted_patents"
      expr: COUNT(DISTINCT CASE WHEN grant_date IS NOT NULL THEN patent_id END)
      comment: "Count of granted patents"
    - name: "pending_patents"
      expr: COUNT(DISTINCT CASE WHEN grant_date IS NULL AND filing_date IS NOT NULL THEN patent_id END)
      comment: "Count of pending patent applications"
    - name: "litigated_patents"
      expr: COUNT(DISTINCT CASE WHEN litigation_flag = TRUE THEN patent_id END)
      comment: "Count of patents involved in litigation"
    - name: "standard_essential_patents"
      expr: COUNT(DISTINCT CASE WHEN standard_essential_patent_flag = TRUE THEN patent_id END)
      comment: "Count of standard-essential patents (SEPs)"
    - name: "frand_obligated_patents"
      expr: COUNT(DISTINCT CASE WHEN frand_obligation_flag = TRUE THEN patent_id END)
      comment: "Count of patents with FRAND obligations"
    - name: "licensed_patents"
      expr: COUNT(DISTINCT CASE WHEN licensing_status IS NOT NULL AND licensing_status != 'Unlicensed' THEN patent_id END)
      comment: "Count of patents with active licensing arrangements"
    - name: "pct_filed_patents"
      expr: COUNT(DISTINCT CASE WHEN pct_application_number IS NOT NULL THEN patent_id END)
      comment: "Count of patents filed via PCT route"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`ip_license_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP licensing revenue and agreement metrics tracking royalty structures, territory coverage, and licensing performance"
  source: "`legal_ecm`.`ip`.`license_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of license agreement (exclusive, non-exclusive, cross-license, etc.)"
    - name: "execution_status"
      expr: execution_status
      comment: "Current execution status of the agreement"
    - name: "territory"
      expr: territory
      comment: "Geographic territory covered by the license"
    - name: "field_of_use"
      expr: field_of_use
      comment: "Technical or market field where license applies"
    - name: "royalty_structure"
      expr: royalty_structure
      comment: "Structure of royalty payments (fixed, percentage, hybrid, etc.)"
    - name: "is_exclusive"
      expr: exclusivity_terms IS NOT NULL AND exclusivity_terms != ''
      comment: "Whether license grants exclusive rights"
    - name: "is_frand_obligated"
      expr: frand_obligation_flag
      comment: "Whether license is subject to FRAND terms"
    - name: "allows_sublicensing"
      expr: sublicensing_permitted_flag
      comment: "Whether sublicensing is permitted under agreement"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the license agreement became effective"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the license agreement expires"
    - name: "governing_law"
      expr: governing_law
      comment: "Legal jurisdiction governing the agreement"
  measures:
    - name: "total_license_agreements"
      expr: COUNT(1)
      comment: "Total count of license agreements"
    - name: "active_licenses"
      expr: COUNT(DISTINCT CASE WHEN execution_status = 'Active' OR execution_status = 'Executed' THEN license_agreement_id END)
      comment: "Count of currently active license agreements"
    - name: "total_fixed_royalty_value"
      expr: SUM(CAST(fixed_royalty_amount AS DOUBLE))
      comment: "Total fixed royalty amounts across all agreements"
    - name: "avg_fixed_royalty"
      expr: AVG(CAST(fixed_royalty_amount AS DOUBLE))
      comment: "Average fixed royalty amount per agreement"
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average percentage royalty rate across agreements"
    - name: "exclusive_licenses"
      expr: COUNT(DISTINCT CASE WHEN exclusivity_terms IS NOT NULL AND exclusivity_terms != '' THEN license_agreement_id END)
      comment: "Count of exclusive license agreements"
    - name: "frand_licenses"
      expr: COUNT(DISTINCT CASE WHEN frand_obligation_flag = TRUE THEN license_agreement_id END)
      comment: "Count of licenses with FRAND obligations"
    - name: "sublicensable_agreements"
      expr: COUNT(DISTINCT CASE WHEN sublicensing_permitted_flag = TRUE THEN license_agreement_id END)
      comment: "Count of agreements permitting sublicensing"
    - name: "expiring_soon_licenses"
      expr: COUNT(DISTINCT CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 180) THEN license_agreement_id END)
      comment: "Count of licenses expiring within next 6 months"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`ip_royalty_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty payment performance metrics tracking revenue realization, payment compliance, audit findings, and withholding tax impact"
  source: "`legal_ecm`.`ip`.`royalty_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the royalty payment"
    - name: "payment_direction"
      expr: payment_direction
      comment: "Direction of payment flow (inbound revenue vs outbound obligation)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment processing"
    - name: "royalty_base_type"
      expr: royalty_base_type
      comment: "Type of base used for royalty calculation (revenue, units, etc.)"
    - name: "jurisdiction"
      expr: jurisdiction_code
      comment: "Tax jurisdiction for the payment"
    - name: "currency"
      expr: currency_code
      comment: "Currency of the royalty payment"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of payment reconciliation process"
    - name: "is_audited"
      expr: audit_flag
      comment: "Whether payment has been audited"
    - name: "is_frand_obligated"
      expr: frand_obligation_flag
      comment: "Whether payment is under FRAND terms"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year payment was made"
    - name: "payment_quarter"
      expr: CONCAT('Q', QUARTER(payment_date), '-', YEAR(payment_date))
      comment: "Quarter and year of payment"
    - name: "period_year"
      expr: YEAR(payment_period_start_date)
      comment: "Year of the royalty period being paid"
  measures:
    - name: "total_royalty_payments"
      expr: COUNT(1)
      comment: "Total count of royalty payment transactions"
    - name: "total_calculated_royalty"
      expr: SUM(CAST(calculated_royalty_amount AS DOUBLE))
      comment: "Total calculated royalty amounts before adjustments"
    - name: "total_net_payment"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net royalty payments after all adjustments and withholdings"
    - name: "total_adjustments"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts applied to royalty payments"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from royalty payments"
    - name: "total_royalty_base"
      expr: SUM(CAST(royalty_base_amount AS DOUBLE))
      comment: "Total base amounts used for royalty calculations"
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate percentage across payments"
    - name: "avg_net_payment"
      expr: AVG(CAST(net_payment_amount AS DOUBLE))
      comment: "Average net payment amount per transaction"
    - name: "audited_payments"
      expr: COUNT(DISTINCT CASE WHEN audit_flag = TRUE THEN royalty_payment_id END)
      comment: "Count of payments that have been audited"
    - name: "reconciled_payments"
      expr: COUNT(DISTINCT CASE WHEN reconciliation_status = 'Reconciled' THEN royalty_payment_id END)
      comment: "Count of successfully reconciled payments"
    - name: "overdue_payments"
      expr: COUNT(DISTINCT CASE WHEN payment_due_date < CURRENT_DATE() AND payment_status != 'Paid' THEN royalty_payment_id END)
      comment: "Count of overdue unpaid royalty obligations"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`ip_enforcement_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP enforcement and infringement response metrics tracking costs, outcomes, settlement rates, and enforcement effectiveness"
  source: "`legal_ecm`.`ip`.`enforcement_action`"
  dimensions:
    - name: "enforcement_type"
      expr: enforcement_type
      comment: "Type of enforcement action (cease and desist, litigation, customs seizure, etc.)"
    - name: "enforcement_status"
      expr: enforcement_status
      comment: "Current status of the enforcement action"
    - name: "infringement_type"
      expr: infringement_type
      comment: "Type of infringement being addressed"
    - name: "enforcement_venue"
      expr: enforcement_venue
      comment: "Venue or forum for enforcement action"
    - name: "jurisdiction"
      expr: jurisdiction_code
      comment: "Legal jurisdiction of enforcement action"
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of the enforcement action"
    - name: "priority_level"
      expr: priority_level
      comment: "Strategic priority level of the enforcement action"
    - name: "is_settled"
      expr: settlement_reached_flag
      comment: "Whether enforcement action resulted in settlement"
    - name: "is_litigation_referred"
      expr: litigation_referral_flag
      comment: "Whether action was escalated to litigation"
    - name: "action_year"
      expr: YEAR(action_date)
      comment: "Year enforcement action was initiated"
    - name: "settlement_year"
      expr: YEAR(settlement_date)
      comment: "Year settlement was reached"
  measures:
    - name: "total_enforcement_actions"
      expr: COUNT(1)
      comment: "Total count of enforcement actions initiated"
    - name: "total_enforcement_cost"
      expr: SUM(CAST(enforcement_cost_amount AS DOUBLE))
      comment: "Total cost of enforcement actions"
    - name: "avg_enforcement_cost"
      expr: AVG(CAST(enforcement_cost_amount AS DOUBLE))
      comment: "Average cost per enforcement action"
    - name: "total_settlement_value"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total value of settlements reached"
    - name: "avg_settlement_value"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement amount per action"
    - name: "settled_actions"
      expr: COUNT(DISTINCT CASE WHEN settlement_reached_flag = TRUE THEN enforcement_action_id END)
      comment: "Count of enforcement actions resulting in settlement"
    - name: "litigated_actions"
      expr: COUNT(DISTINCT CASE WHEN litigation_referral_flag = TRUE THEN enforcement_action_id END)
      comment: "Count of actions escalated to litigation"
    - name: "high_priority_actions"
      expr: COUNT(DISTINCT CASE WHEN priority_level = 'High' OR priority_level = 'Critical' THEN enforcement_action_id END)
      comment: "Count of high-priority enforcement actions"
    - name: "active_enforcement_actions"
      expr: COUNT(DISTINCT CASE WHEN enforcement_status IN ('Active', 'In Progress', 'Pending') THEN enforcement_action_id END)
      comment: "Count of currently active enforcement actions"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`ip_docket_deadline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP prosecution docket management metrics tracking deadline compliance, extension costs, and docketing risk exposure"
  source: "`legal_ecm`.`ip`.`docket_deadline`"
  dimensions:
    - name: "deadline_type"
      expr: deadline_type
      comment: "Type of prosecution deadline (response, filing, payment, etc.)"
    - name: "completion_status"
      expr: completion_status
      comment: "Status of deadline completion"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the deadline"
    - name: "jurisdiction"
      expr: jurisdiction_code
      comment: "Jurisdiction of the deadline"
    - name: "docket_system"
      expr: docket_system_code
      comment: "Docketing system managing the deadline"
    - name: "is_active"
      expr: active_flag
      comment: "Whether deadline is currently active"
    - name: "is_missed"
      expr: missed_deadline_flag
      comment: "Whether deadline was missed"
    - name: "is_escalated"
      expr: missed_deadline_escalation_flag
      comment: "Whether missed deadline was escalated"
    - name: "requires_extension_fee"
      expr: extension_fee_required_flag
      comment: "Whether extension requires additional fee payment"
    - name: "due_year"
      expr: YEAR(calculated_due_date)
      comment: "Year deadline is due"
    - name: "due_quarter"
      expr: CONCAT('Q', QUARTER(calculated_due_date), '-', YEAR(calculated_due_date))
      comment: "Quarter and year deadline is due"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year deadline was completed"
  measures:
    - name: "total_deadlines"
      expr: COUNT(1)
      comment: "Total count of docket deadlines"
    - name: "active_deadlines"
      expr: COUNT(DISTINCT CASE WHEN active_flag = TRUE THEN docket_deadline_id END)
      comment: "Count of currently active deadlines"
    - name: "missed_deadlines"
      expr: COUNT(DISTINCT CASE WHEN missed_deadline_flag = TRUE THEN docket_deadline_id END)
      comment: "Count of missed deadlines"
    - name: "escalated_deadlines"
      expr: COUNT(DISTINCT CASE WHEN missed_deadline_escalation_flag = TRUE THEN docket_deadline_id END)
      comment: "Count of escalated missed deadlines"
    - name: "completed_deadlines"
      expr: COUNT(DISTINCT CASE WHEN completion_status = 'Completed' THEN docket_deadline_id END)
      comment: "Count of successfully completed deadlines"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost for upcoming deadlines"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per deadline"
    - name: "total_extension_fees"
      expr: SUM(CAST(extension_fee_amount AS DOUBLE))
      comment: "Total extension fees paid or required"
    - name: "deadlines_requiring_extension_fee"
      expr: COUNT(DISTINCT CASE WHEN extension_fee_required_flag = TRUE THEN docket_deadline_id END)
      comment: "Count of deadlines requiring extension fees"
    - name: "high_priority_deadlines"
      expr: COUNT(DISTINCT CASE WHEN priority_level = 'High' OR priority_level = 'Critical' THEN docket_deadline_id END)
      comment: "Count of high-priority deadlines"
    - name: "upcoming_deadlines_30d"
      expr: COUNT(DISTINCT CASE WHEN calculated_due_date <= DATE_ADD(CURRENT_DATE(), 30) AND active_flag = TRUE THEN docket_deadline_id END)
      comment: "Count of active deadlines due within next 30 days"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`ip_opposition_proceeding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP opposition and challenge proceeding metrics tracking costs, outcomes, settlement rates, and strategic risk assessment"
  source: "`legal_ecm`.`ip`.`opposition_proceeding`"
  dimensions:
    - name: "proceeding_type"
      expr: proceeding_type
      comment: "Type of opposition proceeding (IPR, PGR, opposition, cancellation, etc.)"
    - name: "proceeding_status"
      expr: opposition_proceeding_status
      comment: "Current status of the opposition proceeding"
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Final decision outcome of the proceeding"
    - name: "jurisdiction"
      expr: jurisdiction_code
      comment: "Jurisdiction where proceeding is filed"
    - name: "tribunal"
      expr: tribunal_name
      comment: "Tribunal or board hearing the proceeding"
    - name: "grounds_of_challenge"
      expr: grounds_of_challenge
      comment: "Legal grounds for the opposition challenge"
    - name: "risk_assessment"
      expr: risk_assessment_level
      comment: "Strategic risk assessment level"
    - name: "strategic_importance"
      expr: strategic_importance
      comment: "Strategic importance rating of the proceeding"
    - name: "is_settled"
      expr: settlement_reached_flag
      comment: "Whether proceeding was settled"
    - name: "is_appealed"
      expr: appeal_filed_flag
      comment: "Whether decision was appealed"
    - name: "has_claim_amendments"
      expr: claim_amendments_proposed_flag
      comment: "Whether claim amendments were proposed"
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year proceeding was filed"
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year decision was issued"
  measures:
    - name: "total_opposition_proceedings"
      expr: COUNT(1)
      comment: "Total count of opposition proceedings"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated cost of opposition proceedings"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost incurred for opposition proceedings"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Average estimated cost per opposition proceeding"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average actual cost per opposition proceeding"
    - name: "settled_proceedings"
      expr: COUNT(DISTINCT CASE WHEN settlement_reached_flag = TRUE THEN opposition_proceeding_id END)
      comment: "Count of proceedings resolved through settlement"
    - name: "appealed_proceedings"
      expr: COUNT(DISTINCT CASE WHEN appeal_filed_flag = TRUE THEN opposition_proceeding_id END)
      comment: "Count of proceedings that were appealed"
    - name: "high_risk_proceedings"
      expr: COUNT(DISTINCT CASE WHEN risk_assessment_level = 'High' OR risk_assessment_level = 'Critical' THEN opposition_proceeding_id END)
      comment: "Count of high-risk opposition proceedings"
    - name: "strategically_important_proceedings"
      expr: COUNT(DISTINCT CASE WHEN strategic_importance = 'High' OR strategic_importance = 'Critical' THEN opposition_proceeding_id END)
      comment: "Count of strategically important proceedings"
    - name: "active_proceedings"
      expr: COUNT(DISTINCT CASE WHEN opposition_proceeding_status IN ('Active', 'Instituted', 'Pending') THEN opposition_proceeding_id END)
      comment: "Count of currently active opposition proceedings"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`ip_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP asset valuation metrics tracking appraisal values, methodologies, FRAND considerations, and portfolio allocation for strategic decision-making"
  source: "`legal_ecm`.`ip`.`valuation`"
  dimensions:
    - name: "valuation_status"
      expr: valuation_status
      comment: "Current status of the valuation"
    - name: "methodology"
      expr: methodology
      comment: "Valuation methodology applied (income, market, cost approach, etc.)"
    - name: "purpose"
      expr: purpose
      comment: "Business purpose of the valuation (transaction, litigation, financial reporting, etc.)"
    - name: "currency"
      expr: currency_code
      comment: "Currency of valuation amount"
    - name: "appraiser_firm"
      expr: appraiser_firm
      comment: "Firm conducting the valuation"
    - name: "has_frand_consideration"
      expr: frand_consideration_flag
      comment: "Whether FRAND obligations were considered in valuation"
    - name: "has_tax_benefit"
      expr: tax_amortization_benefit_flag
      comment: "Whether tax amortization benefits were factored"
    - name: "terminal_value_method"
      expr: terminal_value_method
      comment: "Method used for terminal value calculation"
    - name: "valuation_year"
      expr: YEAR(valuation_date)
      comment: "Year of valuation"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year valuation was approved"
  measures:
    - name: "total_valuations"
      expr: COUNT(1)
      comment: "Total count of IP asset valuations"
    - name: "total_valuation_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total appraised value across all valuations"
    - name: "avg_valuation_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average valuation amount per asset"
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate applied in valuations"
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate used in income-based valuations"
    - name: "avg_litigation_adjustment"
      expr: AVG(CAST(litigation_impact_adjustment AS DOUBLE))
      comment: "Average litigation impact adjustment applied"
    - name: "avg_portfolio_allocation"
      expr: AVG(CAST(portfolio_allocation_percentage AS DOUBLE))
      comment: "Average portfolio allocation percentage per asset"
    - name: "approved_valuations"
      expr: COUNT(DISTINCT CASE WHEN valuation_status = 'Approved' THEN valuation_id END)
      comment: "Count of approved valuations"
    - name: "frand_adjusted_valuations"
      expr: COUNT(DISTINCT CASE WHEN frand_consideration_flag = TRUE THEN valuation_id END)
      comment: "Count of valuations with FRAND adjustments"
    - name: "tax_benefit_valuations"
      expr: COUNT(DISTINCT CASE WHEN tax_amortization_benefit_flag = TRUE THEN valuation_id END)
      comment: "Count of valuations considering tax amortization benefits"
$$;