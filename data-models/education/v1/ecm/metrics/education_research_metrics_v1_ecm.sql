-- Metric views for domain: research | Business: Education | Version: 1 | Generated on: 2026-05-06 12:16:12

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`research_award`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core research award performance metrics tracking funding amounts, cost sharing, and award lifecycle"
  source: "`education_ecm`.`research`.`research_award`"
  dimensions:
    - name: "award_status"
      expr: award_status
      comment: "Current status of the research award (active, closed, pending, etc.)"
    - name: "award_type"
      expr: award_type
      comment: "Type classification of the award (grant, contract, cooperative agreement, etc.)"
    - name: "activity_type"
      expr: activity_type
      comment: "Research activity type classification"
    - name: "award_fiscal_year"
      expr: YEAR(effective_date)
      comment: "Fiscal year when the award became effective"
    - name: "award_start_year"
      expr: YEAR(project_start_date)
      comment: "Year the project started"
    - name: "cost_sharing_required"
      expr: cost_sharing_required_flag
      comment: "Whether cost sharing is required for this award"
    - name: "human_subjects_required"
      expr: human_subjects_approval_required_flag
      comment: "Whether human subjects approval is required"
    - name: "animal_subjects_required"
      expr: animal_subjects_approval_required_flag
      comment: "Whether animal subjects approval is required"
    - name: "no_cost_extension_granted"
      expr: no_cost_extension_flag
      comment: "Whether a no-cost extension has been granted"
  measures:
    - name: "total_award_funding"
      expr: SUM(CAST(total_award_amount AS DOUBLE))
      comment: "Total funding amount across all awards"
    - name: "total_direct_costs"
      expr: SUM(CAST(direct_cost_amount AS DOUBLE))
      comment: "Sum of direct costs across all awards"
    - name: "total_indirect_costs"
      expr: SUM(CAST(indirect_cost_amount AS DOUBLE))
      comment: "Sum of indirect costs (facilities and administrative) across all awards"
    - name: "total_cost_sharing_commitment"
      expr: SUM(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Total institutional cost sharing commitment across awards"
    - name: "avg_award_amount"
      expr: AVG(CAST(total_award_amount AS DOUBLE))
      comment: "Average award funding amount per award"
    - name: "indirect_cost_rate"
      expr: ROUND(100.0 * SUM(CAST(indirect_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(direct_cost_amount AS DOUBLE)), 0), 2)
      comment: "Effective indirect cost recovery rate as percentage of direct costs"
    - name: "cost_sharing_rate"
      expr: ROUND(100.0 * SUM(CAST(cost_sharing_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_award_amount AS DOUBLE)), 0), 2)
      comment: "Cost sharing as percentage of total award funding"
    - name: "award_count"
      expr: COUNT(DISTINCT research_award_id)
      comment: "Number of distinct research awards"
    - name: "pi_count"
      expr: COUNT(DISTINCT principal_investigator_id)
      comment: "Number of distinct principal investigators managing awards"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`research_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proposal pipeline and success metrics tracking submission activity, win rates, and funding requests"
  source: "`education_ecm`.`research`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the proposal (submitted, awarded, declined, pending, etc.)"
    - name: "proposal_type"
      expr: proposal_type
      comment: "Type of proposal (new, continuation, renewal, supplement, etc.)"
    - name: "activity_type"
      expr: activity_type
      comment: "Research activity type classification"
    - name: "submission_fiscal_year"
      expr: YEAR(submission_date)
      comment: "Fiscal year when the proposal was submitted"
    - name: "decision_fiscal_year"
      expr: YEAR(decision_date)
      comment: "Fiscal year when funding decision was made"
    - name: "cost_sharing_required"
      expr: cost_sharing_required_flag
      comment: "Whether cost sharing is required for this proposal"
    - name: "human_subjects_involved"
      expr: human_subjects_flag
      comment: "Whether human subjects research is involved"
    - name: "vertebrate_animals_involved"
      expr: vertebrate_animals_flag
      comment: "Whether vertebrate animals are involved in the research"
  measures:
    - name: "total_requested_funding"
      expr: SUM(CAST(requested_budget_amount AS DOUBLE))
      comment: "Total funding requested across all proposals"
    - name: "total_direct_costs_requested"
      expr: SUM(CAST(direct_cost_amount AS DOUBLE))
      comment: "Total direct costs requested across proposals"
    - name: "total_indirect_costs_requested"
      expr: SUM(CAST(indirect_cost_amount AS DOUBLE))
      comment: "Total indirect costs requested across proposals"
    - name: "total_cost_sharing_proposed"
      expr: SUM(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Total institutional cost sharing proposed"
    - name: "avg_proposal_amount"
      expr: AVG(CAST(requested_budget_amount AS DOUBLE))
      comment: "Average funding amount requested per proposal"
    - name: "proposal_count"
      expr: COUNT(DISTINCT proposal_id)
      comment: "Number of distinct proposals"
    - name: "pi_count"
      expr: COUNT(DISTINCT principal_investigator_id)
      comment: "Number of distinct principal investigators submitting proposals"
    - name: "sponsor_count"
      expr: COUNT(DISTINCT sponsor_id)
      comment: "Number of distinct sponsors receiving proposals"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`research_expenditure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research expenditure and burn rate metrics tracking spending patterns, compliance, and budget utilization"
  source: "`education_ecm`.`research`.`expenditure`"
  dimensions:
    - name: "expenditure_category"
      expr: expenditure_category
      comment: "Category of expenditure (personnel, equipment, travel, supplies, etc.)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the transaction (posted, pending, reversed, etc.)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the expenditure"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month) of the expenditure"
    - name: "transaction_year"
      expr: YEAR(transaction_date)
      comment: "Calendar year of the transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the transaction for time-series analysis"
    - name: "is_direct_cost"
      expr: direct_cost_flag
      comment: "Whether this is a direct cost expenditure"
    - name: "is_cost_share"
      expr: cost_share_flag
      comment: "Whether this expenditure is cost-shared"
    - name: "is_allowable"
      expr: allowable_flag
      comment: "Whether the expenditure is allowable under award terms"
    - name: "is_allocable"
      expr: allocable_flag
      comment: "Whether the expenditure is allocable to the award"
    - name: "is_reasonable"
      expr: reasonable_flag
      comment: "Whether the expenditure is reasonable per federal standards"
  measures:
    - name: "total_expenditures"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total expenditure amount across all transactions"
    - name: "total_idc_recovered"
      expr: SUM(CAST(idc_amount AS DOUBLE))
      comment: "Total indirect costs recovered"
    - name: "total_encumbrances"
      expr: SUM(CAST(encumbrance_amount AS DOUBLE))
      comment: "Total encumbered (committed but not yet spent) funds"
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average expenditure amount per transaction"
    - name: "transaction_count"
      expr: COUNT(DISTINCT expenditure_id)
      comment: "Number of distinct expenditure transactions"
    - name: "award_count"
      expr: COUNT(DISTINCT research_award_id)
      comment: "Number of distinct awards with expenditures"
    - name: "effective_idc_rate"
      expr: ROUND(100.0 * SUM(CAST(idc_amount AS DOUBLE)) / NULLIF(SUM(CAST(transaction_amount AS DOUBLE)) - SUM(CAST(idc_amount AS DOUBLE)), 0), 2)
      comment: "Effective IDC recovery rate as percentage of direct expenditures"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`research_principal_investigator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Principal investigator portfolio and productivity metrics tracking research leadership capacity and funding success"
  source: "`education_ecm`.`research`.`principal_investigator`"
  dimensions:
    - name: "pi_status"
      expr: pi_status
      comment: "Current status of the principal investigator (active, inactive, etc.)"
    - name: "pi_eligibility_status"
      expr: pi_eligibility_status
      comment: "Eligibility status for serving as PI"
    - name: "academic_rank"
      expr: academic_rank
      comment: "Academic rank (professor, associate professor, assistant professor, etc.)"
    - name: "tenure_status"
      expr: tenure_status
      comment: "Tenure status (tenured, tenure-track, non-tenure-track, etc.)"
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of appointment (faculty, research scientist, etc.)"
    - name: "college_school"
      expr: college_school_name
      comment: "College or school affiliation"
    - name: "home_department"
      expr: home_department_name
      comment: "Home department of the PI"
    - name: "coi_disclosure_status"
      expr: conflict_of_interest_disclosure_status
      comment: "Status of conflict of interest disclosure"
    - name: "debarment_check_status"
      expr: federal_debarment_check_status
      comment: "Status of federal debarment check"
  measures:
    - name: "total_active_funding"
      expr: SUM(CAST(total_active_funding_amount AS DOUBLE))
      comment: "Total active funding amount across all PIs"
    - name: "avg_active_funding_per_pi"
      expr: AVG(CAST(total_active_funding_amount AS DOUBLE))
      comment: "Average active funding amount per principal investigator"
    - name: "pi_count"
      expr: COUNT(DISTINCT principal_investigator_id)
      comment: "Number of distinct principal investigators"
    - name: "total_active_awards"
      expr: SUM(CAST(active_award_count AS BIGINT))
      comment: "Total number of active awards across all PIs"
    - name: "total_cumulative_awards"
      expr: SUM(CAST(cumulative_award_count AS BIGINT))
      comment: "Total cumulative awards across all PIs over their careers"
    - name: "avg_awards_per_pi"
      expr: AVG(CAST(active_award_count AS DOUBLE))
      comment: "Average number of active awards per principal investigator"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`research_award_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Award account financial health metrics tracking budget utilization, burn rates, and fund availability"
  source: "`education_ecm`.`research`.`award_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the award account (active, closed, suspended, etc.)"
    - name: "award_type"
      expr: award_type
      comment: "Type of award (grant, contract, cooperative agreement, etc.)"
    - name: "activity_type"
      expr: activity_type
      comment: "Research activity type classification"
    - name: "account_open_year"
      expr: YEAR(account_open_date)
      comment: "Year the account was opened"
    - name: "project_start_year"
      expr: YEAR(project_start_date)
      comment: "Year the project started"
    - name: "is_cost_sharing"
      expr: cost_sharing_account_flag
      comment: "Whether this is a cost-sharing account"
    - name: "export_controlled"
      expr: export_control_flag
      comment: "Whether the project involves export-controlled research"
    - name: "human_subjects_involved"
      expr: human_subjects_flag
      comment: "Whether human subjects research is involved"
    - name: "vertebrate_animals_involved"
      expr: vertebrate_animals_flag
      comment: "Whether vertebrate animals are involved"
  measures:
    - name: "total_authorized_budget"
      expr: SUM(CAST(total_authorized_budget AS DOUBLE))
      comment: "Total authorized budget across all award accounts"
    - name: "total_expenditures"
      expr: SUM(CAST(total_expenditures_to_date AS DOUBLE))
      comment: "Total expenditures to date across all accounts"
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Total available balance remaining across all accounts"
    - name: "total_encumbrances"
      expr: SUM(CAST(total_encumbrances AS DOUBLE))
      comment: "Total encumbered funds across all accounts"
    - name: "total_cost_sharing"
      expr: SUM(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Total cost sharing amount across accounts"
    - name: "total_unrecovered_fa"
      expr: SUM(CAST(unrecovered_fa_amount AS DOUBLE))
      comment: "Total unrecovered facilities and administrative costs"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(total_expenditures_to_date AS DOUBLE)) / NULLIF(SUM(CAST(total_authorized_budget AS DOUBLE)), 0), 2)
      comment: "Percentage of authorized budget that has been expended"
    - name: "avg_available_balance"
      expr: AVG(CAST(available_balance AS DOUBLE))
      comment: "Average available balance per award account"
    - name: "account_count"
      expr: COUNT(DISTINCT award_account_id)
      comment: "Number of distinct award accounts"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`research_compliance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research compliance and audit metrics tracking findings, corrective actions, and regulatory risk"
  source: "`education_ecm`.`research`.`compliance_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of compliance event (audit finding, protocol deviation, regulatory violation, etc.)"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the compliance event"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the compliance event (critical, major, minor, etc.)"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Status of event resolution"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action plan"
    - name: "event_year"
      expr: YEAR(event_date)
      comment: "Year the compliance event occurred"
    - name: "is_audit_finding"
      expr: audit_finding_flag
      comment: "Whether this is an audit finding"
    - name: "is_repeat_finding"
      expr: repeat_finding_flag
      comment: "Whether this is a repeat finding"
    - name: "is_systemic_issue"
      expr: systemic_issue_flag
      comment: "Whether this represents a systemic issue"
    - name: "sponsor_notified"
      expr: sponsor_notified_flag
      comment: "Whether the sponsor was notified of the event"
  measures:
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of compliance events"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per compliance event"
    - name: "compliance_event_count"
      expr: COUNT(DISTINCT compliance_event_id)
      comment: "Number of distinct compliance events"
    - name: "affected_award_count"
      expr: COUNT(DISTINCT research_award_id)
      comment: "Number of distinct awards affected by compliance events"
    - name: "affected_pi_count"
      expr: COUNT(DISTINCT principal_investigator_id)
      comment: "Number of distinct principal investigators involved in compliance events"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`research_scholarly_output`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research productivity and impact metrics tracking publications, citations, and scholarly dissemination"
  source: "`education_ecm`.`research`.`scholarly_output`"
  dimensions:
    - name: "output_type"
      expr: output_type
      comment: "Type of scholarly output (journal article, book chapter, conference paper, etc.)"
    - name: "output_status"
      expr: output_status
      comment: "Status of the scholarly output (published, accepted, submitted, etc.)"
    - name: "publication_year"
      expr: YEAR(publication_date)
      comment: "Year of publication"
    - name: "open_access_status"
      expr: open_access_status
      comment: "Open access status (gold, green, hybrid, closed, etc.)"
    - name: "is_peer_reviewed"
      expr: peer_reviewed_flag
      comment: "Whether the output is peer-reviewed"
    - name: "is_federal_sponsored"
      expr: federal_sponsor_flag
      comment: "Whether the research was federally sponsored"
    - name: "is_ipeds_reportable"
      expr: ipeds_reportable_flag
      comment: "Whether the output is reportable to IPEDS"
    - name: "repository_deposit_status"
      expr: repository_deposit_status
      comment: "Status of deposit in institutional repository"
  measures:
    - name: "total_citations"
      expr: SUM(CAST(citation_count AS BIGINT))
      comment: "Total citation count across all scholarly outputs"
    - name: "avg_citations_per_output"
      expr: AVG(CAST(citation_count AS DOUBLE))
      comment: "Average number of citations per scholarly output"
    - name: "output_count"
      expr: COUNT(DISTINCT scholarly_output_id)
      comment: "Number of distinct scholarly outputs"
    - name: "pi_count"
      expr: COUNT(DISTINCT principal_investigator_id)
      comment: "Number of distinct principal investigators with scholarly outputs"
    - name: "award_count"
      expr: COUNT(DISTINCT research_award_id)
      comment: "Number of distinct awards associated with scholarly outputs"
    - name: "total_institutional_authors"
      expr: SUM(CAST(institutional_author_count AS BIGINT))
      comment: "Total number of institutional authors across all outputs"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`research_sponsor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sponsor relationship and portfolio metrics tracking funding sources, compliance requirements, and partnership health"
  source: "`education_ecm`.`research`.`sponsor`"
  dimensions:
    - name: "sponsor_type"
      expr: sponsor_type
      comment: "Type of sponsor (federal, state, foundation, industry, nonprofit, etc.)"
    - name: "sponsor_status"
      expr: sponsor_status
      comment: "Current status of the sponsor relationship"
    - name: "is_federal"
      expr: is_federal_sponsor
      comment: "Whether this is a federal sponsor"
    - name: "requires_cost_sharing"
      expr: requires_cost_sharing
      comment: "Whether the sponsor requires cost sharing"
    - name: "allows_cost_sharing"
      expr: allows_cost_sharing
      comment: "Whether the sponsor allows cost sharing"
    - name: "requires_irb"
      expr: requires_institutional_review_board
      comment: "Whether the sponsor requires IRB approval"
    - name: "requires_iacuc"
      expr: requires_iacuc_approval
      comment: "Whether the sponsor requires IACUC approval"
    - name: "closeout_report_required"
      expr: closeout_report_required
      comment: "Whether closeout reports are required"
    - name: "sam_registration_status"
      expr: sam_registration_status
      comment: "Status of SAM (System for Award Management) registration"
  measures:
    - name: "sponsor_count"
      expr: COUNT(DISTINCT sponsor_id)
      comment: "Number of distinct sponsors"
    - name: "avg_idc_rate_cap"
      expr: AVG(CAST(idc_rate_cap_percentage AS DOUBLE))
      comment: "Average indirect cost rate cap percentage across sponsors"
    - name: "avg_audit_threshold"
      expr: AVG(CAST(audit_requirement_threshold AS DOUBLE))
      comment: "Average audit requirement threshold amount across sponsors"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`research_subaward`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subaward management and subrecipient monitoring metrics tracking pass-through funding and compliance oversight"
  source: "`education_ecm`.`research`.`subaward`"
  dimensions:
    - name: "subaward_status"
      expr: subaward_status
      comment: "Current status of the subaward (active, closed, pending, etc.)"
    - name: "subaward_type"
      expr: subaward_type
      comment: "Type of subaward (subcontract, consortium agreement, etc.)"
    - name: "monitoring_risk_level"
      expr: monitoring_risk_level
      comment: "Risk level for subrecipient monitoring (high, medium, low)"
    - name: "execution_year"
      expr: YEAR(execution_date)
      comment: "Year the subaward was executed"
    - name: "cost_sharing_required"
      expr: cost_sharing_required
      comment: "Whether cost sharing is required from the subrecipient"
    - name: "single_audit_required"
      expr: single_audit_required
      comment: "Whether a single audit is required for the subrecipient"
    - name: "federal_flow_down_applicable"
      expr: federal_flow_down_clauses_applicable
      comment: "Whether federal flow-down clauses apply"
  measures:
    - name: "total_subaward_amount"
      expr: SUM(CAST(total_subaward_amount AS DOUBLE))
      comment: "Total subaward funding amount"
    - name: "total_executed_amount"
      expr: SUM(CAST(executed_amount AS DOUBLE))
      comment: "Total executed subaward amount"
    - name: "total_cost_sharing"
      expr: SUM(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Total cost sharing required from subrecipients"
    - name: "avg_subaward_amount"
      expr: AVG(CAST(total_subaward_amount AS DOUBLE))
      comment: "Average subaward amount per subaward"
    - name: "subaward_count"
      expr: COUNT(DISTINCT subaward_id)
      comment: "Number of distinct subawards"
    - name: "subrecipient_count"
      expr: COUNT(DISTINCT subrecipient_id)
      comment: "Number of distinct subrecipients"
    - name: "prime_award_count"
      expr: COUNT(DISTINCT research_award_id)
      comment: "Number of distinct prime awards with subawards"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`research_irb_protocol`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Human subjects research compliance metrics tracking IRB protocol status, review cycles, and adverse events"
  source: "`education_ecm`.`research`.`irb_protocol`"
  dimensions:
    - name: "protocol_status"
      expr: protocol_status
      comment: "Current status of the IRB protocol (active, closed, suspended, etc.)"
    - name: "review_category"
      expr: review_category
      comment: "IRB review category (exempt, expedited, full board, etc.)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the research (minimal, more than minimal, etc.)"
    - name: "study_type"
      expr: study_type
      comment: "Type of study (clinical trial, survey, observational, etc.)"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the protocol was approved"
    - name: "is_clinical_trial"
      expr: clinical_trial_flag
      comment: "Whether this is a clinical trial"
    - name: "is_fda_regulated"
      expr: fda_regulated_flag
      comment: "Whether the research is FDA-regulated"
    - name: "is_multi_site"
      expr: multi_site_flag
      comment: "Whether this is a multi-site study"
    - name: "vulnerable_population_involved"
      expr: vulnerable_population_flag
      comment: "Whether vulnerable populations are involved"
    - name: "hipaa_authorization_required"
      expr: hipaa_authorization_required
      comment: "Whether HIPAA authorization is required"
  measures:
    - name: "protocol_count"
      expr: COUNT(DISTINCT irb_protocol_id)
      comment: "Number of distinct IRB protocols"
    - name: "pi_count"
      expr: COUNT(DISTINCT principal_investigator_id)
      comment: "Number of distinct principal investigators with IRB protocols"
    - name: "total_estimated_enrollment"
      expr: SUM(CAST(estimated_enrollment AS BIGINT))
      comment: "Total estimated subject enrollment across all protocols"
    - name: "total_actual_enrollment"
      expr: SUM(CAST(actual_enrollment AS BIGINT))
      comment: "Total actual subject enrollment across all protocols"
    - name: "total_adverse_events"
      expr: SUM(CAST(adverse_event_count AS BIGINT))
      comment: "Total number of adverse events reported across all protocols"
    - name: "total_serious_adverse_events"
      expr: SUM(CAST(serious_adverse_event_count AS BIGINT))
      comment: "Total number of serious adverse events reported"
    - name: "total_amendments"
      expr: SUM(CAST(amendment_count AS BIGINT))
      comment: "Total number of protocol amendments across all protocols"
    - name: "avg_amendments_per_protocol"
      expr: AVG(CAST(amendment_count AS DOUBLE))
      comment: "Average number of amendments per protocol"
$$;