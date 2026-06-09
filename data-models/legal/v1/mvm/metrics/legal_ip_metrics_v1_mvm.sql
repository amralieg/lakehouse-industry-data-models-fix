-- Metric views for domain: ip | Business: Legal | Version: 1 | Generated on: 2026-05-07 14:29:57

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`ip_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the IP asset portfolio — covering portfolio valuation, annuity obligations, asset lifecycle status, and jurisdictional spread. Used by IP counsel and C-suite to steer portfolio investment, renewal decisions, and risk exposure."
  source: "`legal_ecm`.`ip`.`asset`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type of IP asset (patent, trademark, copyright, trade secret, etc.) for portfolio segmentation."
    - name: "ip_asset_status"
      expr: ip_asset_status
      comment: "Current lifecycle status of the asset (active, lapsed, abandoned, expired) for portfolio health analysis."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction in which the asset is registered, enabling geographic portfolio analysis."
    - name: "technology_area"
      expr: technology_area
      comment: "Technology domain of the asset, used to segment portfolio by innovation area."
    - name: "portfolio_category"
      expr: portfolio_category
      comment: "Strategic portfolio category assigned to the asset (core, defensive, licensing, etc.)."
    - name: "licensing_status"
      expr: licensing_status
      comment: "Current licensing status of the asset (unlicensed, licensed, exclusively licensed) for revenue opportunity analysis."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the asset record."
    - name: "annuity_due_year"
      expr: DATE_TRUNC('year', annuity_due_date)
      comment: "Year in which annuity payments are due, for forward-looking cash-flow planning."
    - name: "expiration_year"
      expr: DATE_TRUNC('year', expiration_date)
      comment: "Year the asset expires, used to track portfolio attrition over time."
    - name: "filing_year"
      expr: DATE_TRUNC('year', filing_date)
      comment: "Year the asset was filed, used for vintage cohort analysis of the portfolio."
    - name: "subtype"
      expr: subtype
      comment: "Sub-classification of the asset type for granular portfolio segmentation."
    - name: "ip_office_name"
      expr: ip_office_name
      comment: "IP office where the asset is registered (USPTO, EPO, WIPO, etc.)."
    - name: "pct_application_flag"
      expr: pct_application_flag
      comment: "Indicates whether the asset was filed under the PCT international application route."
    - name: "frand_declaration_flag"
      expr: frand_declaration_flag
      comment: "Indicates whether the asset is subject to FRAND (fair, reasonable, non-discriminatory) licensing obligations."
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of IP assets in the portfolio. Baseline KPI for portfolio size tracking."
    - name: "total_portfolio_valuation"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Aggregate declared valuation of all IP assets. Directly informs balance-sheet IP value and M&A due diligence."
    - name: "avg_asset_valuation"
      expr: AVG(CAST(valuation_amount AS DOUBLE))
      comment: "Average valuation per IP asset. Used to benchmark asset quality and identify under-valued or over-valued segments."
    - name: "total_annuity_obligations"
      expr: SUM(CAST(annuity_amount AS DOUBLE))
      comment: "Total annuity payment obligations across the portfolio. Critical for annual IP maintenance budget planning."
    - name: "avg_annuity_per_asset"
      expr: AVG(CAST(annuity_amount AS DOUBLE))
      comment: "Average annuity cost per asset. Helps identify high-maintenance assets for cost-benefit renewal decisions."
    - name: "active_asset_count"
      expr: COUNT(CASE WHEN ip_asset_status = 'active' THEN 1 END)
      comment: "Number of currently active IP assets. Core portfolio health indicator for executive dashboards."
    - name: "lapsed_or_abandoned_asset_count"
      expr: COUNT(CASE WHEN ip_asset_status IN ('lapsed', 'abandoned') THEN 1 END)
      comment: "Number of lapsed or abandoned assets. Signals portfolio attrition risk and potential IP gaps."
    - name: "licensed_asset_count"
      expr: COUNT(CASE WHEN licensing_status = 'licensed' THEN 1 END)
      comment: "Number of assets currently under a licensing arrangement. Indicates monetisation breadth of the portfolio."
    - name: "frand_obligated_asset_count"
      expr: COUNT(CASE WHEN frand_declaration_flag = TRUE THEN 1 END)
      comment: "Number of assets subject to FRAND obligations. Relevant for SEP (standard-essential patent) compliance risk management."
    - name: "pct_filed_asset_count"
      expr: COUNT(CASE WHEN pct_application_flag = TRUE THEN 1 END)
      comment: "Number of assets filed via the PCT international route. Indicates international protection strategy breadth."
    - name: "distinct_jurisdiction_count"
      expr: COUNT(DISTINCT jurisdiction_code)
      comment: "Number of distinct jurisdictions in which IP assets are registered. Measures geographic coverage of the portfolio."
    - name: "assets_expiring_within_1_year"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 365) THEN 1 END)
      comment: "Number of assets expiring within the next 12 months. Drives urgent renewal and abandonment decision pipeline."
    - name: "total_valuation_of_licensed_assets"
      expr: SUM(CASE WHEN licensing_status = 'licensed' THEN CAST(valuation_amount AS DOUBLE) ELSE 0 END)
      comment: "Aggregate valuation of assets currently under license. Measures the monetised value of the portfolio."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`ip_patent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the patent portfolio — covering prosecution status, grant rates, litigation exposure, SEP obligations, and portfolio value. Used by patent counsel, IP directors, and CFOs to manage patent strategy and investment."
  source: "`legal_ecm`.`ip`.`patent`"
  dimensions:
    - name: "patent_type"
      expr: patent_type
      comment: "Type of patent (utility, design, plant, etc.) for portfolio segmentation."
    - name: "prosecution_status"
      expr: prosecution_status
      comment: "Current prosecution stage of the patent application (pending, granted, abandoned, etc.)."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction in which the patent is filed or granted."
    - name: "licensing_status"
      expr: licensing_status
      comment: "Current licensing status of the patent (unlicensed, licensed, exclusively licensed)."
    - name: "annuity_payment_status"
      expr: annuity_payment_status
      comment: "Status of annuity payments for the patent (current, overdue, waived)."
    - name: "frand_obligation_flag"
      expr: frand_obligation_flag
      comment: "Indicates whether the patent is subject to FRAND licensing obligations (standard-essential patent)."
    - name: "litigation_flag"
      expr: litigation_flag
      comment: "Indicates whether the patent is currently involved in litigation."
    - name: "standard_essential_patent_flag"
      expr: standard_essential_patent_flag
      comment: "Indicates whether the patent has been declared standard-essential."
    - name: "pph_eligible_flag"
      expr: pph_eligible_flag
      comment: "Indicates eligibility for Patent Prosecution Highway (PPH) accelerated examination."
    - name: "filing_year"
      expr: DATE_TRUNC('year', filing_date)
      comment: "Year of patent filing for vintage cohort analysis."
    - name: "grant_year"
      expr: DATE_TRUNC('year', grant_date)
      comment: "Year of patent grant for tracking prosecution throughput over time."
    - name: "expiry_year"
      expr: DATE_TRUNC('year', expiry_date)
      comment: "Year of patent expiry for portfolio attrition planning."
    - name: "priority_country_code"
      expr: jurisdiction_code
      comment: "Country of priority filing, used for geographic strategy analysis."
  measures:
    - name: "total_patents"
      expr: COUNT(1)
      comment: "Total number of patents in the portfolio. Baseline portfolio size KPI."
    - name: "granted_patent_count"
      expr: COUNT(CASE WHEN prosecution_status = 'granted' THEN 1 END)
      comment: "Number of granted patents. Core indicator of prosecution success and portfolio strength."
    - name: "pending_patent_count"
      expr: COUNT(CASE WHEN prosecution_status = 'pending' THEN 1 END)
      comment: "Number of patents currently pending examination. Indicates future portfolio growth pipeline."
    - name: "abandoned_patent_count"
      expr: COUNT(CASE WHEN prosecution_status = 'abandoned' THEN 1 END)
      comment: "Number of abandoned patents. Signals prosecution failure rate and potential IP gaps."
    - name: "litigated_patent_count"
      expr: COUNT(CASE WHEN litigation_flag = TRUE THEN 1 END)
      comment: "Number of patents currently in litigation. Directly informs legal risk exposure and litigation budget."
    - name: "sep_patent_count"
      expr: COUNT(CASE WHEN standard_essential_patent_flag = TRUE THEN 1 END)
      comment: "Number of standard-essential patents. Critical for FRAND licensing strategy and regulatory compliance."
    - name: "total_estimated_portfolio_value"
      expr: SUM(CAST(estimated_portfolio_value AS DOUBLE))
      comment: "Total estimated value of the patent portfolio. Informs M&A valuation, licensing strategy, and balance-sheet reporting."
    - name: "avg_estimated_patent_value"
      expr: AVG(CAST(estimated_portfolio_value AS DOUBLE))
      comment: "Average estimated value per patent. Used to identify high-value patents and prioritise prosecution investment."
    - name: "overdue_annuity_patent_count"
      expr: COUNT(CASE WHEN annuity_payment_status = 'overdue' THEN 1 END)
      comment: "Number of patents with overdue annuity payments. Drives urgent maintenance action to prevent lapse."
    - name: "pph_eligible_patent_count"
      expr: COUNT(CASE WHEN pph_eligible_flag = TRUE THEN 1 END)
      comment: "Number of patents eligible for PPH accelerated examination. Informs prosecution efficiency strategy."
    - name: "distinct_jurisdiction_count"
      expr: COUNT(DISTINCT jurisdiction_code)
      comment: "Number of distinct jurisdictions covered by the patent portfolio. Measures international protection breadth."
    - name: "patents_expiring_within_1_year"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 365) THEN 1 END)
      comment: "Number of patents expiring within 12 months. Drives renewal and licensing urgency decisions."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`ip_patent_family`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portfolio-level KPIs aggregated at the patent family level — covering family valuation, SEP exposure, litigation involvement, licensing status, and annuity health. Used by IP directors and portfolio managers to make family-level prosecution and monetisation decisions."
  source: "`legal_ecm`.`ip`.`patent_family`"
  dimensions:
    - name: "family_status"
      expr: family_status
      comment: "Current status of the patent family (active, expired, abandoned, etc.)."
    - name: "family_type"
      expr: family_type
      comment: "Type of patent family (simple, extended, domestic, international)."
    - name: "technology_area"
      expr: technology_area
      comment: "Technology domain of the patent family for R&D portfolio alignment."
    - name: "licensing_status"
      expr: licensing_status
      comment: "Licensing status of the patent family (unlicensed, licensed, exclusively licensed)."
    - name: "annuity_payment_status"
      expr: annuity_payment_status
      comment: "Annuity payment status for the family (current, overdue, waived)."
    - name: "frand_obligation_indicator"
      expr: frand_obligation_indicator
      comment: "Indicates whether the family carries FRAND obligations."
    - name: "standard_essential_patent_indicator"
      expr: standard_essential_patent_indicator
      comment: "Indicates whether any member of the family is a standard-essential patent."
    - name: "litigation_involvement_indicator"
      expr: litigation_involvement_indicator
      comment: "Indicates whether the family is involved in active litigation."
    - name: "pct_application_indicator"
      expr: pct_application_indicator
      comment: "Indicates whether the family includes a PCT international application."
    - name: "strategic_importance_rating"
      expr: strategic_importance_rating
      comment: "Strategic importance rating assigned to the family (core, defensive, licensing, etc.)."
    - name: "priority_country_code"
      expr: priority_country_code
      comment: "Country of priority filing for the family."
    - name: "priority_year"
      expr: DATE_TRUNC('year', priority_date)
      comment: "Year of priority date for vintage cohort analysis of patent families."
    - name: "next_annuity_due_year"
      expr: DATE_TRUNC('year', next_annuity_due_date)
      comment: "Year in which the next annuity payment is due for cash-flow planning."
    - name: "freedom_to_operate_status"
      expr: freedom_to_operate_status
      comment: "Freedom-to-operate clearance status for the family, relevant for product launch risk management."
  measures:
    - name: "total_patent_families"
      expr: COUNT(1)
      comment: "Total number of patent families. Baseline measure of portfolio breadth at the family level."
    - name: "active_family_count"
      expr: COUNT(CASE WHEN active_indicator = TRUE THEN 1 END)
      comment: "Number of currently active patent families. Core portfolio health KPI."
    - name: "total_portfolio_valuation"
      expr: SUM(CAST(portfolio_valuation_amount AS DOUBLE))
      comment: "Total declared valuation across all patent families. Informs IP asset value on the balance sheet and M&A strategy."
    - name: "avg_family_valuation"
      expr: AVG(CAST(portfolio_valuation_amount AS DOUBLE))
      comment: "Average valuation per patent family. Used to identify high-value families for prioritised prosecution and licensing."
    - name: "litigated_family_count"
      expr: COUNT(CASE WHEN litigation_involvement_indicator = TRUE THEN 1 END)
      comment: "Number of patent families involved in active litigation. Directly informs litigation risk exposure and budget."
    - name: "sep_family_count"
      expr: COUNT(CASE WHEN standard_essential_patent_indicator = TRUE THEN 1 END)
      comment: "Number of patent families containing standard-essential patents. Critical for FRAND licensing strategy."
    - name: "frand_obligated_family_count"
      expr: COUNT(CASE WHEN frand_obligation_indicator = TRUE THEN 1 END)
      comment: "Number of families with FRAND obligations. Informs regulatory compliance and licensing negotiation posture."
    - name: "licensed_family_count"
      expr: COUNT(CASE WHEN licensing_status = 'licensed' THEN 1 END)
      comment: "Number of patent families currently under a licensing arrangement. Measures portfolio monetisation breadth."
    - name: "overdue_annuity_family_count"
      expr: COUNT(CASE WHEN annuity_payment_status = 'overdue' THEN 1 END)
      comment: "Number of families with overdue annuity payments. Drives urgent maintenance action to prevent lapse."
    - name: "families_with_annuity_due_within_90_days"
      expr: COUNT(CASE WHEN next_annuity_due_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Number of families with annuity payments due within 90 days. Drives near-term cash-flow and payment scheduling."
    - name: "total_valuation_of_litigated_families"
      expr: SUM(CASE WHEN litigation_involvement_indicator = TRUE THEN CAST(portfolio_valuation_amount AS DOUBLE) ELSE 0 END)
      comment: "Total valuation of patent families currently in litigation. Quantifies the financial value at risk from litigation."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`ip_prosecution_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and strategic KPIs for patent prosecution activity — covering event throughput, response compliance, fee spend, and outcome quality. Used by patent attorneys and IP operations managers to manage prosecution efficiency and deadline compliance."
  source: "`legal_ecm`.`ip`.`prosecution_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of prosecution event (office action, response, interview, grant, etc.)."
    - name: "prosecution_stage"
      expr: prosecution_stage
      comment: "Stage of prosecution at which the event occurred (examination, appeal, allowance, etc.)."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction in which the prosecution event occurred."
    - name: "office_action_type"
      expr: office_action_type
      comment: "Type of office action received (restriction, rejection, allowance, etc.)."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the prosecution event (allowed, rejected, withdrawn, etc.)."
    - name: "rejection_basis"
      expr: rejection_basis
      comment: "Legal basis for rejection (35 USC 102, 103, 112, etc.). Informs prosecution strategy adjustments."
    - name: "attorney_of_record"
      expr: attorney_of_record
      comment: "Attorney responsible for the prosecution event. Used for workload and performance analysis."
    - name: "docketing_trigger_flag"
      expr: docketing_trigger_flag
      comment: "Indicates whether the event triggered a docketing action."
    - name: "extension_granted_flag"
      expr: extension_granted_flag
      comment: "Indicates whether a deadline extension was granted for this event."
    - name: "estoppel_risk_flag"
      expr: estoppel_risk_flag
      comment: "Indicates whether the event carries prosecution history estoppel risk."
    - name: "interview_conducted_flag"
      expr: interview_conducted_flag
      comment: "Indicates whether an examiner interview was conducted as part of this event."
    - name: "event_year"
      expr: DATE_TRUNC('year', event_date)
      comment: "Year of the prosecution event for trend analysis."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_date)
      comment: "Month of the prosecution event for operational throughput monitoring."
    - name: "fee_currency_code"
      expr: fee_currency_code
      comment: "Currency in which prosecution fees were paid."
  measures:
    - name: "total_prosecution_events"
      expr: COUNT(1)
      comment: "Total number of prosecution events. Baseline throughput KPI for IP operations."
    - name: "total_prosecution_fee_spend"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees paid across all prosecution events. Core cost management KPI for IP operations budget."
    - name: "avg_prosecution_fee_per_event"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average fee per prosecution event. Used to benchmark prosecution cost efficiency across jurisdictions and attorneys."
    - name: "office_action_count"
      expr: COUNT(CASE WHEN event_type = 'office_action' THEN 1 END)
      comment: "Number of office actions received. Indicates prosecution complexity and examiner engagement volume."
    - name: "rejection_event_count"
      expr: COUNT(CASE WHEN outcome = 'rejected' THEN 1 END)
      comment: "Number of prosecution events resulting in rejection. Informs prosecution strategy quality and attorney performance."
    - name: "allowance_event_count"
      expr: COUNT(CASE WHEN outcome = 'allowed' THEN 1 END)
      comment: "Number of prosecution events resulting in allowance. Measures prosecution success rate."
    - name: "extension_granted_count"
      expr: COUNT(CASE WHEN extension_granted_flag = TRUE THEN 1 END)
      comment: "Number of events where a deadline extension was granted. Indicates prosecution timeline slippage."
    - name: "estoppel_risk_event_count"
      expr: COUNT(CASE WHEN estoppel_risk_flag = TRUE THEN 1 END)
      comment: "Number of prosecution events carrying estoppel risk. Informs claim scope and litigation risk management."
    - name: "interview_conducted_count"
      expr: COUNT(CASE WHEN interview_conducted_flag = TRUE THEN 1 END)
      comment: "Number of events where an examiner interview was conducted. Interviews typically improve allowance rates."
    - name: "overdue_response_count"
      expr: COUNT(CASE WHEN response_filed_date > response_deadline THEN 1 END)
      comment: "Number of prosecution events where the response was filed after the deadline. Critical compliance and malpractice risk KPI."
    - name: "distinct_jurisdictions_active"
      expr: COUNT(DISTINCT jurisdiction_code)
      comment: "Number of distinct jurisdictions with active prosecution events. Measures international prosecution footprint."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`ip_docket_deadline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deadline compliance and cost KPIs for IP docketing — covering missed deadlines, escalations, extension fees, and completion rates. Used by IP operations managers and risk officers to manage docketing compliance and malpractice risk."
  source: "`legal_ecm`.`ip`.`docket_deadline`"
  dimensions:
    - name: "deadline_type"
      expr: deadline_type
      comment: "Type of docketing deadline (annuity, response, filing, renewal, etc.)."
    - name: "completion_status"
      expr: completion_status
      comment: "Current completion status of the deadline (pending, completed, missed, escalated)."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction to which the deadline applies."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the deadline (critical, high, medium, low)."
    - name: "active_flag"
      expr: active_flag
      comment: "Indicates whether the deadline is currently active."
    - name: "missed_deadline_flag"
      expr: missed_deadline_flag
      comment: "Indicates whether the deadline was missed."
    - name: "missed_deadline_escalation_flag"
      expr: missed_deadline_escalation_flag
      comment: "Indicates whether a missed deadline has been escalated."
    - name: "extension_fee_required_flag"
      expr: extension_fee_required_flag
      comment: "Indicates whether an extension fee is required for this deadline."
    - name: "calculated_due_year"
      expr: DATE_TRUNC('year', calculated_due_date)
      comment: "Year in which the deadline falls, for forward-looking workload planning."
    - name: "calculated_due_month"
      expr: DATE_TRUNC('month', calculated_due_date)
      comment: "Month in which the deadline falls, for near-term operational scheduling."
    - name: "docket_system_code"
      expr: docket_system_code
      comment: "Docketing system from which the deadline originates."
    - name: "estimated_cost_currency_code"
      expr: estimated_cost_currency_code
      comment: "Currency of the estimated cost for the deadline action."
  measures:
    - name: "total_deadlines"
      expr: COUNT(1)
      comment: "Total number of docketed deadlines. Baseline workload KPI for IP operations."
    - name: "missed_deadline_count"
      expr: COUNT(CASE WHEN missed_deadline_flag = TRUE THEN 1 END)
      comment: "Number of missed deadlines. Critical malpractice and IP lapse risk KPI — directly triggers management intervention."
    - name: "escalated_missed_deadline_count"
      expr: COUNT(CASE WHEN missed_deadline_escalation_flag = TRUE THEN 1 END)
      comment: "Number of missed deadlines that have been escalated. Indicates severity of compliance failures requiring senior attention."
    - name: "completed_deadline_count"
      expr: COUNT(CASE WHEN completion_status = 'completed' THEN 1 END)
      comment: "Number of deadlines successfully completed. Used to compute completion rate alongside total_deadlines."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all docketed deadline actions. Informs IP operations budget planning."
    - name: "total_extension_fees"
      expr: SUM(CAST(extension_fee_amount AS DOUBLE))
      comment: "Total extension fees incurred across all deadlines. Measures cost of prosecution timeline slippage."
    - name: "avg_extension_fee"
      expr: AVG(CAST(extension_fee_amount AS DOUBLE))
      comment: "Average extension fee per deadline. Used to benchmark extension cost efficiency across jurisdictions."
    - name: "deadlines_due_within_30_days"
      expr: COUNT(CASE WHEN active_flag = TRUE AND calculated_due_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) THEN 1 END)
      comment: "Number of active deadlines due within 30 days. Drives immediate operational prioritisation."
    - name: "critical_priority_deadline_count"
      expr: COUNT(CASE WHEN priority_level = 'critical' THEN 1 END)
      comment: "Number of deadlines classified as critical priority. Informs resource allocation for high-stakes IP actions."
    - name: "extension_fee_required_count"
      expr: COUNT(CASE WHEN extension_fee_required_flag = TRUE THEN 1 END)
      comment: "Number of deadlines requiring an extension fee. Indicates prosecution timeline management quality."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`ip_license_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for IP licensing agreements — covering royalty rates, agreement execution, exclusivity, FRAND obligations, and portfolio monetisation. Used by licensing managers, CFOs, and IP counsel to steer licensing strategy and revenue."
  source: "`legal_ecm`.`ip`.`license_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of license agreement (exclusive, non-exclusive, cross-license, FRAND, etc.)."
    - name: "execution_status"
      expr: execution_status
      comment: "Current execution status of the agreement (draft, executed, expired, terminated)."
    - name: "territory"
      expr: territory
      comment: "Geographic territory covered by the license agreement."
    - name: "field_of_use"
      expr: field_of_use
      comment: "Field of use restriction in the license agreement."
    - name: "royalty_structure"
      expr: royalty_structure
      comment: "Structure of royalty payments (running royalty, lump sum, milestone-based, hybrid)."
    - name: "frand_obligation_flag"
      expr: frand_obligation_flag
      comment: "Indicates whether the agreement is subject to FRAND licensing obligations."
    - name: "sublicensing_permitted_flag"
      expr: sublicensing_permitted_flag
      comment: "Indicates whether sublicensing is permitted under the agreement."
    - name: "governing_law"
      expr: governing_law
      comment: "Governing law jurisdiction of the license agreement."
    - name: "dispute_resolution_mechanism"
      expr: dispute_resolution_mechanism
      comment: "Dispute resolution mechanism specified in the agreement (arbitration, litigation, mediation)."
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the agreement became effective, for vintage cohort analysis."
    - name: "expiry_year"
      expr: DATE_TRUNC('year', expiry_date)
      comment: "Year the agreement expires, for renewal pipeline management."
    - name: "royalty_currency_code"
      expr: royalty_currency_code
      comment: "Currency in which royalties are denominated."
    - name: "practice_group_code"
      expr: practice_group_code
      comment: "Practice group responsible for the agreement."
  measures:
    - name: "total_license_agreements"
      expr: COUNT(1)
      comment: "Total number of license agreements. Baseline KPI for licensing portfolio size."
    - name: "executed_agreement_count"
      expr: COUNT(CASE WHEN execution_status = 'executed' THEN 1 END)
      comment: "Number of fully executed license agreements. Measures active licensing portfolio breadth."
    - name: "expired_agreement_count"
      expr: COUNT(CASE WHEN execution_status = 'expired' THEN 1 END)
      comment: "Number of expired agreements. Informs renewal pipeline and revenue continuity risk."
    - name: "total_fixed_royalty_value"
      expr: SUM(CAST(fixed_royalty_amount AS DOUBLE))
      comment: "Total fixed royalty amounts across all agreements. Informs predictable licensing revenue baseline."
    - name: "avg_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate across all agreements. Benchmarks licensing terms against industry norms."
    - name: "frand_agreement_count"
      expr: COUNT(CASE WHEN frand_obligation_flag = TRUE THEN 1 END)
      comment: "Number of agreements subject to FRAND obligations. Informs SEP licensing compliance posture."
    - name: "sublicensing_permitted_count"
      expr: COUNT(CASE WHEN sublicensing_permitted_flag = TRUE THEN 1 END)
      comment: "Number of agreements permitting sublicensing. Indicates downstream IP distribution risk and opportunity."
    - name: "agreements_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Number of agreements expiring within 90 days. Drives urgent renewal negotiation pipeline."
    - name: "distinct_territory_count"
      expr: COUNT(DISTINCT territory)
      comment: "Number of distinct territories covered by license agreements. Measures geographic licensing reach."
    - name: "avg_fixed_royalty_amount"
      expr: AVG(CAST(fixed_royalty_amount AS DOUBLE))
      comment: "Average fixed royalty amount per agreement. Used to benchmark deal size and identify outliers."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`ip_royalty_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPIs for royalty payment flows — covering payment volumes, net receipts, withholding tax, audit findings, and reconciliation status. Used by finance, licensing managers, and compliance officers to manage royalty revenue and payment integrity."
  source: "`legal_ecm`.`ip`.`royalty_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the royalty payment (pending, paid, overdue, disputed)."
    - name: "payment_direction"
      expr: payment_direction
      comment: "Direction of the royalty payment (inbound/outbound) for revenue vs. cost analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (wire transfer, ACH, cheque, etc.)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the royalty payment is denominated."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction associated with the royalty payment, relevant for withholding tax analysis."
    - name: "royalty_base_type"
      expr: royalty_base_type
      comment: "Type of royalty base (net sales, units sold, revenue, etc.)."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the payment (reconciled, unreconciled, disputed)."
    - name: "audit_flag"
      expr: audit_flag
      comment: "Indicates whether the payment has been flagged for audit."
    - name: "frand_obligation_flag"
      expr: frand_obligation_flag
      comment: "Indicates whether the payment relates to a FRAND-obligated license."
    - name: "payment_year"
      expr: DATE_TRUNC('year', payment_date)
      comment: "Year of payment for annual royalty revenue trend analysis."
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of payment for monthly cash-flow monitoring."
    - name: "payment_period_start_year"
      expr: DATE_TRUNC('year', payment_period_start_date)
      comment: "Year of the royalty period start date for period-over-period analysis."
  measures:
    - name: "total_royalty_payments"
      expr: COUNT(1)
      comment: "Total number of royalty payment transactions. Baseline volume KPI."
    - name: "total_calculated_royalty_amount"
      expr: SUM(CAST(calculated_royalty_amount AS DOUBLE))
      comment: "Total calculated royalty amounts across all payment records. Core licensing revenue KPI."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net royalty payments after adjustments and withholding tax. Actual cash received/paid KPI."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from royalty payments. Informs tax planning and treaty benefit analysis."
    - name: "total_royalty_base_amount"
      expr: SUM(CAST(royalty_base_amount AS DOUBLE))
      comment: "Total royalty base (e.g. net sales) across all payment periods. Used to validate royalty rate application."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to royalty payments. Large adjustment totals signal audit or dispute activity."
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average effective royalty rate across all payment records. Benchmarks actual rates against contracted rates."
    - name: "overdue_payment_count"
      expr: COUNT(CASE WHEN payment_status = 'overdue' THEN 1 END)
      comment: "Number of overdue royalty payments. Drives collections action and counterparty relationship management."
    - name: "audited_payment_count"
      expr: COUNT(CASE WHEN audit_flag = TRUE THEN 1 END)
      comment: "Number of payments flagged for audit. Indicates royalty compliance scrutiny level."
    - name: "unreconciled_payment_count"
      expr: COUNT(CASE WHEN reconciliation_status = 'unreconciled' THEN 1 END)
      comment: "Number of unreconciled royalty payments. Signals financial close risk and potential revenue leakage."
    - name: "avg_withholding_tax_rate"
      expr: AVG(CAST(withholding_tax_rate AS DOUBLE))
      comment: "Average withholding tax rate applied across royalty payments. Informs tax treaty optimisation strategy."
    - name: "inbound_royalty_net_amount"
      expr: SUM(CASE WHEN payment_direction = 'inbound' THEN CAST(net_payment_amount AS DOUBLE) ELSE 0 END)
      comment: "Total net inbound royalty receipts. Core licensing revenue KPI for the P&L."
    - name: "outbound_royalty_net_amount"
      expr: SUM(CASE WHEN payment_direction = 'outbound' THEN CAST(net_payment_amount AS DOUBLE) ELSE 0 END)
      comment: "Total net outbound royalty payments. Core licensing cost KPI for the P&L."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`ip_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPIs for IP-related payments — covering annuity fees, official fees, late payment surcharges, and royalty disbursements. Used by IP finance teams and operations managers to manage IP payment spend, late payment risk, and budget compliance."
  source: "`legal_ecm`.`ip`.`ip_payment`"
  dimensions:
    - name: "payment_type"
      expr: payment_type
      comment: "Type of IP payment (annuity, official fee, royalty, extension fee, etc.)."
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (pending, paid, failed, refunded)."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to make the payment (wire, credit card, deposit account, etc.)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the payment was made."
    - name: "jurisdiction_country_code"
      expr: jurisdiction_country_code
      comment: "Country jurisdiction for which the payment was made."
    - name: "ip_office_code"
      expr: ip_office_code
      comment: "IP office to which the payment was directed (USPTO, EPO, JPO, etc.)."
    - name: "late_payment_flag"
      expr: late_payment_flag
      comment: "Indicates whether the payment was made after the due date."
    - name: "audit_adjustment_flag"
      expr: audit_adjustment_flag
      comment: "Indicates whether the payment record has been subject to an audit adjustment."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the payment (reconciled, unreconciled, disputed)."
    - name: "payment_year"
      expr: DATE_TRUNC('year', payment_date)
      comment: "Year of payment for annual spend trend analysis."
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of payment for monthly cash-flow monitoring."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center to which the IP payment is allocated."
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code for the payment."
  measures:
    - name: "total_ip_payments"
      expr: COUNT(1)
      comment: "Total number of IP payment transactions. Baseline volume KPI for IP operations."
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross IP payment amount. Core IP spend KPI for budget management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net IP payment amount after adjustments. Actual cash outflow KPI."
    - name: "total_late_payment_surcharge"
      expr: SUM(CAST(late_payment_surcharge_amount AS DOUBLE))
      comment: "Total late payment surcharges incurred. Measures cost of payment deadline non-compliance."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from IP payments. Informs cross-border tax planning."
    - name: "total_royalty_base_amount"
      expr: SUM(CAST(royalty_base_amount AS DOUBLE))
      comment: "Total royalty base amount across all IP payments. Used to validate royalty rate application."
    - name: "late_payment_count"
      expr: COUNT(CASE WHEN late_payment_flag = TRUE THEN 1 END)
      comment: "Number of late IP payments. Drives process improvement to reduce surcharges and lapse risk."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average IP payment amount. Used to benchmark transaction size and identify anomalies."
    - name: "unreconciled_payment_count"
      expr: COUNT(CASE WHEN reconciliation_status = 'unreconciled' THEN 1 END)
      comment: "Number of unreconciled IP payments. Signals financial close risk and potential payment errors."
    - name: "audit_adjusted_payment_count"
      expr: COUNT(CASE WHEN audit_adjustment_flag = TRUE THEN 1 END)
      comment: "Number of payments subject to audit adjustment. Indicates payment accuracy and control quality."
    - name: "avg_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate percent across royalty-type IP payments. Benchmarks effective royalty rates."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`ip_trademark`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the trademark portfolio — covering registration status, renewal pipeline, opposition activity, portfolio valuation, and geographic coverage. Used by brand managers, IP counsel, and CMOs to steer trademark strategy and brand protection."
  source: "`legal_ecm`.`ip`.`trademark`"
  dimensions:
    - name: "trademark_status"
      expr: trademark_status
      comment: "Current status of the trademark (registered, pending, abandoned, expired, opposed)."
    - name: "mark_type"
      expr: mark_type
      comment: "Type of trademark mark (word, figurative, combined, 3D, sound, etc.)."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction in which the trademark is registered or pending."
    - name: "opposition_status"
      expr: opposition_status
      comment: "Current opposition status of the trademark application."
    - name: "filing_basis"
      expr: filing_basis
      comment: "Basis for filing the trademark application (use in commerce, intent to use, foreign registration, etc.)."
    - name: "madrid_protocol_indicator"
      expr: madrid_protocol_indicator
      comment: "Indicates whether the trademark was filed under the Madrid Protocol international system."
    - name: "multi_class_indicator"
      expr: multi_class_indicator
      comment: "Indicates whether the trademark covers multiple Nice classification classes."
    - name: "filing_year"
      expr: DATE_TRUNC('year', filing_date)
      comment: "Year of trademark filing for vintage cohort analysis."
    - name: "registration_year"
      expr: DATE_TRUNC('year', registration_date)
      comment: "Year of trademark registration for portfolio growth tracking."
    - name: "renewal_due_year"
      expr: DATE_TRUNC('year', renewal_due_date)
      comment: "Year in which trademark renewal is due for renewal pipeline management."
    - name: "annuity_currency_code"
      expr: annuity_currency_code
      comment: "Currency of trademark annuity/renewal fees."
  measures:
    - name: "total_trademarks"
      expr: COUNT(1)
      comment: "Total number of trademarks in the portfolio. Baseline brand protection portfolio size KPI."
    - name: "registered_trademark_count"
      expr: COUNT(CASE WHEN trademark_status = 'registered' THEN 1 END)
      comment: "Number of registered trademarks. Core brand protection strength indicator."
    - name: "pending_trademark_count"
      expr: COUNT(CASE WHEN trademark_status = 'pending' THEN 1 END)
      comment: "Number of trademark applications currently pending. Indicates brand protection pipeline."
    - name: "opposed_trademark_count"
      expr: COUNT(CASE WHEN trademark_status = 'opposed' OR opposition_status IS NOT NULL THEN 1 END)
      comment: "Number of trademarks facing opposition proceedings. Informs brand protection risk and litigation budget."
    - name: "total_portfolio_valuation"
      expr: SUM(CAST(portfolio_valuation_amount AS DOUBLE))
      comment: "Total declared valuation of the trademark portfolio. Informs brand asset value on the balance sheet."
    - name: "avg_trademark_valuation"
      expr: AVG(CAST(portfolio_valuation_amount AS DOUBLE))
      comment: "Average valuation per trademark. Used to identify high-value marks for prioritised protection."
    - name: "total_annuity_obligations"
      expr: SUM(CAST(annuity_amount AS DOUBLE))
      comment: "Total trademark renewal/annuity fee obligations. Informs brand maintenance budget planning."
    - name: "renewals_due_within_90_days"
      expr: COUNT(CASE WHEN renewal_due_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Number of trademarks with renewal due within 90 days. Drives urgent renewal action pipeline."
    - name: "madrid_protocol_trademark_count"
      expr: COUNT(CASE WHEN madrid_protocol_indicator = TRUE THEN 1 END)
      comment: "Number of trademarks filed under the Madrid Protocol. Measures international brand protection strategy breadth."
    - name: "distinct_jurisdiction_count"
      expr: COUNT(DISTINCT jurisdiction_code)
      comment: "Number of distinct jurisdictions in which trademarks are registered or pending. Measures geographic brand coverage."
    - name: "trademarks_expiring_within_1_year"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 365) THEN 1 END)
      comment: "Number of trademarks expiring within 12 months. Drives renewal and abandonment decision pipeline."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`ip_ownership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for IP ownership records — covering ownership concentration, FRAND commitments, security interests, joint ownership, and verification status. Used by IP counsel and compliance officers to manage chain-of-title integrity and ownership risk."
  source: "`legal_ecm`.`ip`.`ownership`"
  dimensions:
    - name: "ownership_status"
      expr: ownership_status
      comment: "Current status of the ownership record (current, historical, disputed, transferred)."
    - name: "owner_type"
      expr: owner_type
      comment: "Type of owner (individual, corporation, government, university, etc.)."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction in which the ownership is recorded."
    - name: "basis"
      expr: basis
      comment: "Legal basis for ownership (assignment, inheritance, work-for-hire, joint development, etc.)."
    - name: "is_current_owner"
      expr: is_current_owner
      comment: "Indicates whether this ownership record represents the current owner."
    - name: "joint_ownership_flag"
      expr: joint_ownership_flag
      comment: "Indicates whether the asset is jointly owned. Joint ownership creates licensing and enforcement complexity."
    - name: "frand_obligation_flag"
      expr: frand_obligation_flag
      comment: "Indicates whether the ownership carries FRAND licensing obligations."
    - name: "security_interest_flag"
      expr: security_interest_flag
      comment: "Indicates whether a security interest (lien) has been recorded against the asset."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the ownership record (verified, pending, disputed)."
    - name: "owner_country_code"
      expr: owner_country_code
      comment: "Country of the owner entity. Used for geographic ownership concentration analysis."
    - name: "assignment_year"
      expr: DATE_TRUNC('year', assignment_date)
      comment: "Year of ownership assignment for transaction volume trend analysis."
    - name: "license_back_flag"
      expr: license_back_flag
      comment: "Indicates whether a license-back arrangement exists in the ownership transfer."
  measures:
    - name: "total_ownership_records"
      expr: COUNT(1)
      comment: "Total number of ownership records. Baseline KPI for chain-of-title completeness."
    - name: "current_ownership_count"
      expr: COUNT(CASE WHEN is_current_owner = TRUE THEN 1 END)
      comment: "Number of current ownership records. Measures active ownership positions in the IP portfolio."
    - name: "joint_ownership_count"
      expr: COUNT(CASE WHEN joint_ownership_flag = TRUE THEN 1 END)
      comment: "Number of jointly owned IP assets. Joint ownership creates enforcement and licensing complexity requiring management attention."
    - name: "security_interest_count"
      expr: COUNT(CASE WHEN security_interest_flag = TRUE THEN 1 END)
      comment: "Number of ownership records with a security interest recorded. Informs IP collateral and financing risk."
    - name: "frand_obligated_ownership_count"
      expr: COUNT(CASE WHEN frand_obligation_flag = TRUE THEN 1 END)
      comment: "Number of ownership records carrying FRAND obligations. Informs SEP licensing compliance posture."
    - name: "unverified_ownership_count"
      expr: COUNT(CASE WHEN verification_status != 'verified' THEN 1 END)
      comment: "Number of ownership records not yet verified. Signals chain-of-title integrity risk requiring remediation."
    - name: "total_consideration_amount"
      expr: SUM(CAST(consideration_amount AS DOUBLE))
      comment: "Total consideration paid across all ownership transfers. Measures IP transaction value flowing through the portfolio."
    - name: "avg_ownership_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average ownership percentage per record. Used to identify fragmented ownership structures."
    - name: "distinct_owner_count"
      expr: COUNT(DISTINCT owner_entity_name)
      comment: "Number of distinct owner entities in the portfolio. Measures ownership concentration and diversity."
    - name: "license_back_arrangement_count"
      expr: COUNT(CASE WHEN license_back_flag = TRUE THEN 1 END)
      comment: "Number of ownership transfers with license-back arrangements. Informs retained IP usage rights analysis."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`ip_copyright`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the copyright portfolio — covering registration status, infringement detection, licensing, valuation, and work-for-hire composition. Used by IP counsel and content strategy teams to manage copyright protection and enforcement."
  source: "`legal_ecm`.`ip`.`copyright`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status of the copyright (registered, pending, unregistered)."
    - name: "work_type"
      expr: work_type
      comment: "Type of copyrighted work (literary, musical, artistic, software, audiovisual, etc.)."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction in which the copyright is registered."
    - name: "licensing_status"
      expr: licensing_status
      comment: "Current licensing status of the copyright (unlicensed, licensed, exclusively licensed)."
    - name: "portfolio_category"
      expr: portfolio_category
      comment: "Strategic portfolio category of the copyright."
    - name: "infringement_detected_flag"
      expr: infringement_detected_flag
      comment: "Indicates whether infringement has been detected for this copyright."
    - name: "derivative_work_flag"
      expr: derivative_work_flag
      comment: "Indicates whether the work is a derivative work."
    - name: "work_made_for_hire_flag"
      expr: work_made_for_hire_flag
      comment: "Indicates whether the work was created as a work-made-for-hire."
    - name: "fair_use_analysis_flag"
      expr: fair_use_analysis_flag
      comment: "Indicates whether a fair use analysis has been conducted."
    - name: "registration_year"
      expr: DATE_TRUNC('year', registration_date)
      comment: "Year of copyright registration for portfolio growth tracking."
    - name: "application_year"
      expr: DATE_TRUNC('year', application_date)
      comment: "Year of copyright application for pipeline analysis."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the copyright record."
  measures:
    - name: "total_copyrights"
      expr: COUNT(1)
      comment: "Total number of copyright records. Baseline portfolio size KPI."
    - name: "registered_copyright_count"
      expr: COUNT(CASE WHEN registration_status = 'registered' THEN 1 END)
      comment: "Number of registered copyrights. Registered works have stronger enforcement rights."
    - name: "infringement_detected_count"
      expr: COUNT(CASE WHEN infringement_detected_flag = TRUE THEN 1 END)
      comment: "Number of copyrights with detected infringement. Drives enforcement action prioritisation and litigation budget."
    - name: "licensed_copyright_count"
      expr: COUNT(CASE WHEN licensing_status = 'licensed' THEN 1 END)
      comment: "Number of copyrights currently under a licensing arrangement. Measures copyright monetisation breadth."
    - name: "total_portfolio_valuation"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total declared valuation of the copyright portfolio. Informs IP asset value on the balance sheet."
    - name: "avg_copyright_valuation"
      expr: AVG(CAST(valuation_amount AS DOUBLE))
      comment: "Average valuation per copyright. Used to identify high-value works for prioritised protection."
    - name: "work_for_hire_count"
      expr: COUNT(CASE WHEN work_made_for_hire_flag = TRUE THEN 1 END)
      comment: "Number of works created as work-for-hire. Informs employer ownership rights and contractor IP policy."
    - name: "derivative_work_count"
      expr: COUNT(CASE WHEN derivative_work_flag = TRUE THEN 1 END)
      comment: "Number of derivative works in the portfolio. Derivative works carry additional licensing complexity."
    - name: "copyrights_expiring_within_1_year"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 365) THEN 1 END)
      comment: "Number of copyrights expiring within 12 months. Informs content strategy and public domain transition planning."
    - name: "distinct_jurisdiction_count"
      expr: COUNT(DISTINCT jurisdiction_code)
      comment: "Number of distinct jurisdictions in which copyrights are registered. Measures geographic protection coverage."
$$;