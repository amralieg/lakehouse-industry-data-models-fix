-- Metric views for domain: site | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-07 02:29:00

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`site_activation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks site activation lifecycle KPIs including cycle-time performance, readiness milestones, and activation funnel health. Used by Clinical Operations leadership to identify bottlenecks in site start-up and accelerate first-patient-in timelines."
  source: "`clinical_trials_ecm`.`site`.`activation`"
  dimensions:
    - name: "activation_status"
      expr: activation_status
      comment: "Current status of the site activation record (e.g., Active, On Hold, Completed). Primary grouping for funnel analysis."
    - name: "activation_type"
      expr: activation_type
      comment: "Type of activation event (e.g., Initial, Re-activation). Enables segmentation of activation patterns."
    - name: "country_code"
      expr: country_code
      comment: "Country where the investigational site is located. Supports geographic performance benchmarking."
    - name: "irb_iec_status"
      expr: irb_iec_status
      comment: "Current IRB/IEC approval status for the activation. Critical regulatory gate dimension."
    - name: "siv_status"
      expr: siv_status
      comment: "Site Initiation Visit status. Indicates whether the SIV milestone has been completed, scheduled, or is pending."
    - name: "edc_access_status"
      expr: edc_access_status
      comment: "Status of EDC system access provisioning for the site. Operational readiness indicator."
    - name: "drug_shipment_auth_status"
      expr: drug_shipment_auth_status
      comment: "Authorization status for investigational product shipment to the site."
    - name: "actual_activation_month"
      expr: DATE_TRUNC('MONTH', actual_activation_date)
      comment: "Month of actual site activation. Enables trend analysis of activation throughput over time."
    - name: "target_activation_month"
      expr: DATE_TRUNC('MONTH', target_activation_date)
      comment: "Month of planned/target activation date. Used to compare planned vs. actual activation timelines."
    - name: "gcp_training_completed"
      expr: gcp_training_completed
      comment: "Boolean flag indicating whether GCP training has been completed at the site. Compliance readiness dimension."
    - name: "essential_docs_verified"
      expr: essential_docs_verified
      comment: "Boolean flag indicating whether essential regulatory documents have been verified. Gate-check dimension."
    - name: "financial_agreement_executed"
      expr: financial_agreement_executed
      comment: "Boolean flag indicating whether the financial agreement has been executed. Contractual readiness dimension."
  measures:
    - name: "total_activations"
      expr: COUNT(1)
      comment: "Total number of site activation records. Baseline volume metric for activation pipeline sizing."
    - name: "sites_with_siv_completed"
      expr: COUNT(CASE WHEN siv_status = 'Completed' THEN activation_id END)
      comment: "Number of sites that have completed the Site Initiation Visit. Measures progression through the critical SIV milestone."
    - name: "sites_with_edc_access_provisioned"
      expr: COUNT(CASE WHEN edc_access_status = 'Provisioned' THEN activation_id END)
      comment: "Number of sites with EDC access fully provisioned. Tracks operational readiness for data capture."
    - name: "sites_with_irb_approved"
      expr: COUNT(CASE WHEN irb_iec_status = 'Approved' THEN activation_id END)
      comment: "Number of sites with IRB/IEC approval obtained. Measures regulatory clearance throughput."
    - name: "sites_with_drug_shipment_authorized"
      expr: COUNT(CASE WHEN drug_shipment_auth_status = 'Authorized' THEN activation_id END)
      comment: "Number of sites authorized to receive investigational product shipments. Critical supply chain readiness KPI."
    - name: "sites_fully_ready"
      expr: COUNT(CASE WHEN gcp_training_completed = TRUE AND essential_docs_verified = TRUE AND financial_agreement_executed = TRUE THEN activation_id END)
      comment: "Number of sites meeting all three core readiness criteria: GCP training, essential docs verified, and financial agreement executed. Composite site readiness KPI."
    - name: "avg_activation_cycle_days"
      expr: AVG(DATEDIFF(actual_activation_date, target_activation_date))
      comment: "Average number of days between target and actual activation date. Positive values indicate delays; negative values indicate early activation. Key cycle-time performance indicator."
    - name: "avg_irb_to_activation_days"
      expr: AVG(DATEDIFF(actual_activation_date, irb_iec_approval_date))
      comment: "Average days from IRB/IEC approval to site activation. Measures post-approval activation efficiency."
    - name: "avg_siv_to_fpfv_days"
      expr: AVG(DATEDIFF(fpfv_date, siv_completed_date))
      comment: "Average days from Site Initiation Visit completion to First Patient First Visit. Measures how quickly sites begin enrolling after initiation."
    - name: "sites_on_hold"
      expr: COUNT(CASE WHEN activation_status = 'On Hold' THEN activation_id END)
      comment: "Number of sites currently on hold. Operational risk indicator requiring leadership attention and intervention."
    - name: "distinct_countries_activated"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries with active site activations. Measures geographic reach of the trial network."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`site_enrollment_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides enrollment efficiency, screen failure, dropout, and target achievement KPIs at the site level. The primary operational dashboard for Clinical Operations and Enrollment Strategy teams to manage patient recruitment performance."
  source: "`clinical_trials_ecm`.`site`.`enrollment_performance`"
  dimensions:
    - name: "performance_status"
      expr: performance_status
      comment: "Current enrollment performance status of the site (e.g., On Track, Behind, Ahead). Primary operational health dimension."
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Type of reporting period (e.g., Monthly, Quarterly). Enables consistent period-over-period comparisons."
    - name: "reporting_period_start_date"
      expr: DATE_TRUNC('MONTH', reporting_period_start_date)
      comment: "Start of the reporting period truncated to month. Enables time-series trend analysis of enrollment."
    - name: "irb_iec_approval_status"
      expr: irb_iec_approval_status
      comment: "IRB/IEC approval status at the time of the performance record. Regulatory compliance dimension."
    - name: "gcp_compliance_status"
      expr: gcp_compliance_status
      comment: "GCP compliance status of the site. Quality and compliance segmentation dimension."
    - name: "site_number"
      expr: site_number
      comment: "Unique site identifier used in CTMS. Primary site-level grouping dimension."
    - name: "data_source"
      expr: data_source
      comment: "Source system from which enrollment data was captured. Data lineage and reconciliation dimension."
  measures:
    - name: "total_performance_records"
      expr: COUNT(1)
      comment: "Total number of enrollment performance records. Baseline volume for coverage analysis."
    - name: "avg_enrollment_rate_per_month"
      expr: AVG(CAST(enrollment_rate_per_month AS DOUBLE))
      comment: "Average monthly enrollment rate across sites and periods. Core throughput KPI used to forecast trial completion timelines."
    - name: "avg_screen_failure_rate"
      expr: AVG(CAST(screen_failure_rate AS DOUBLE))
      comment: "Average screen failure rate across sites. High rates indicate patient eligibility or recruitment targeting issues requiring protocol or strategy adjustments."
    - name: "avg_dropout_rate"
      expr: AVG(CAST(dropout_rate AS DOUBLE))
      comment: "Average subject dropout rate across sites. Elevated dropout rates signal patient retention risks that can jeopardize trial completion and data integrity."
    - name: "avg_enrollment_target_achievement_pct"
      expr: AVG(CAST(enrollment_target_achievement_pct AS DOUBLE))
      comment: "Average percentage of enrollment target achieved across sites. Primary KPI for enrollment goal attainment used in executive steering reviews."
    - name: "sites_meeting_enrollment_target"
      expr: COUNT(CASE WHEN enrollment_target_achievement_pct >= 100.0 THEN enrollment_performance_id END)
      comment: "Number of site-period records where enrollment target was fully met or exceeded. Measures how many sites are delivering on their commitments."
    - name: "sites_below_50pct_target"
      expr: COUNT(CASE WHEN enrollment_target_achievement_pct < 50.0 THEN enrollment_performance_id END)
      comment: "Number of site-period records where enrollment is below 50% of target. Identifies critically underperforming sites requiring immediate intervention."
    - name: "total_sae_count"
      expr: SUM(CAST(sae_count AS BIGINT))
      comment: "Total number of Serious Adverse Events reported across sites. Patient safety KPI monitored by medical and regulatory leadership."
    - name: "total_protocol_deviation_count"
      expr: SUM(CAST(protocol_deviation_count AS BIGINT))
      comment: "Total protocol deviations across sites and periods. Quality compliance KPI; high counts trigger CAPA and site risk escalation."
    - name: "total_open_query_count"
      expr: SUM(CAST(open_query_count AS BIGINT))
      comment: "Total open data queries across sites. Data quality KPI; unresolved queries delay database lock and regulatory submission."
    - name: "distinct_sites_reporting"
      expr: COUNT(DISTINCT investigational_site_id)
      comment: "Number of distinct investigational sites with enrollment performance records. Measures active site network coverage."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`site_feasibility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures site selection quality, feasibility scoring, and capacity estimation KPIs. Used by Site Selection and Clinical Operations teams to make data-driven site selection decisions and predict enrollment success."
  source: "`clinical_trials_ecm`.`site`.`feasibility_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the feasibility assessment (e.g., Submitted, Reviewed, Approved, Rejected). Funnel stage dimension."
    - name: "selection_decision"
      expr: selection_decision
      comment: "Final site selection decision (e.g., Selected, Not Selected, Conditional). Primary outcome dimension for feasibility analysis."
    - name: "feasibility_score_tier"
      expr: feasibility_score_tier
      comment: "Categorical tier derived from the feasibility score (e.g., High, Medium, Low). Enables cohort-level performance benchmarking."
    - name: "site_country_code"
      expr: site_country_code
      comment: "Country of the assessed site. Geographic dimension for regional feasibility benchmarking."
    - name: "site_region"
      expr: site_region
      comment: "Geographic region of the assessed site. Supports regional enrollment strategy decisions."
    - name: "phase"
      expr: phase
      comment: "Clinical trial phase (e.g., Phase I, II, III). Enables phase-specific feasibility benchmarking."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of feasibility assessment. Enables trend analysis of site pipeline activity."
    - name: "gcp_training_current"
      expr: gcp_training_current
      comment: "Boolean indicating whether the site's GCP training is current at time of assessment. Compliance readiness filter."
    - name: "lab_capabilities_available"
      expr: lab_capabilities_available
      comment: "Boolean indicating whether the site has required laboratory capabilities. Infrastructure readiness dimension."
    - name: "pharmacy_capabilities_available"
      expr: pharmacy_capabilities_available
      comment: "Boolean indicating whether the site has pharmacy capabilities. Critical for IMP handling compliance."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of feasibility assessments conducted. Baseline measure of site pipeline activity."
    - name: "sites_selected"
      expr: COUNT(CASE WHEN selection_decision = 'Selected' THEN feasibility_assessment_id END)
      comment: "Number of sites selected following feasibility assessment. Measures site selection throughput."
    - name: "site_selection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN selection_decision = 'Selected' THEN feasibility_assessment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessed sites that were selected. Measures feasibility funnel conversion efficiency; low rates may indicate overly broad outreach or poor targeting."
    - name: "avg_feasibility_score"
      expr: AVG(CAST(feasibility_score AS DOUBLE))
      comment: "Average feasibility score across assessed sites. Composite quality indicator used to benchmark site network quality."
    - name: "avg_site_infrastructure_score"
      expr: AVG(CAST(site_infrastructure_score AS DOUBLE))
      comment: "Average infrastructure readiness score. Identifies systemic infrastructure gaps across the site network."
    - name: "avg_regulatory_compliance_score"
      expr: AVG(CAST(regulatory_compliance_score AS DOUBLE))
      comment: "Average regulatory compliance score at feasibility. Predicts regulatory risk exposure before site activation."
    - name: "avg_enrollment_experience_score"
      expr: AVG(CAST(enrollment_experience_score AS DOUBLE))
      comment: "Average enrollment experience score of assessed sites. Predicts enrollment performance based on historical site capability."
    - name: "avg_estimated_screen_failure_rate"
      expr: AVG(CAST(estimated_screen_failure_rate AS DOUBLE))
      comment: "Average estimated screen failure rate from feasibility questionnaires. Used to calibrate enrollment targets and patient recruitment budgets."
    - name: "distinct_countries_assessed"
      expr: COUNT(DISTINCT site_country_code)
      comment: "Number of distinct countries where feasibility assessments were conducted. Measures geographic diversity of the site selection pipeline."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`site_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks site financial agreement KPIs including budget commitments, per-patient economics, overhead rates, and contract execution timelines. Used by Finance, Legal, and Clinical Operations to manage site contracting efficiency and budget governance."
  source: "`clinical_trials_ecm`.`site`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the site agreement (e.g., Executed, In Negotiation, Terminated). Primary contract lifecycle dimension."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of agreement (e.g., Clinical Trial Agreement, CDA, Amendment). Enables segmentation by contract category."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the agreement. Required for multi-currency budget analysis and FX risk management."
    - name: "payment_schedule_type"
      expr: payment_schedule_type
      comment: "Type of payment schedule (e.g., Milestone, Per-Visit, Per-Patient). Enables cash flow planning by payment structure."
    - name: "governing_law_country"
      expr: governing_law_country
      comment: "Country whose law governs the agreement. Legal jurisdiction dimension for contract risk analysis."
    - name: "execution_month"
      expr: DATE_TRUNC('MONTH', execution_date)
      comment: "Month the agreement was executed. Enables trend analysis of contracting throughput."
    - name: "legal_review_completed"
      expr: legal_review_completed
      comment: "Boolean indicating whether legal review was completed. Compliance gate dimension."
    - name: "indemnification_clause"
      expr: indemnification_clause
      comment: "Boolean indicating presence of an indemnification clause. Legal risk dimension."
    - name: "data_privacy_addendum"
      expr: data_privacy_addendum
      comment: "Boolean indicating whether a data privacy addendum is included. Regulatory compliance dimension (GDPR, HIPAA)."
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of site agreements. Baseline volume for contracting pipeline management."
    - name: "total_budget_committed"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget committed across all site agreements. Primary financial exposure KPI for trial budget governance."
    - name: "avg_budget_per_agreement"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average budget per site agreement. Benchmarks site-level financial commitments and identifies outliers."
    - name: "total_startup_fees"
      expr: SUM(CAST(startup_fee AS DOUBLE))
      comment: "Total startup fees committed across all agreements. Measures upfront site activation cost exposure."
    - name: "avg_per_patient_fee"
      expr: AVG(CAST(per_patient_fee AS DOUBLE))
      comment: "Average per-patient fee across agreements. Core unit economics KPI for enrollment cost modeling and budget forecasting."
    - name: "total_closeout_fees"
      expr: SUM(CAST(closeout_fee AS DOUBLE))
      comment: "Total closeout fees committed across agreements. Measures end-of-trial financial obligations."
    - name: "avg_overhead_rate_pct"
      expr: AVG(CAST(overhead_rate_pct AS DOUBLE))
      comment: "Average overhead rate percentage across site agreements. Measures institutional overhead burden on trial budgets."
    - name: "agreements_in_negotiation"
      expr: COUNT(CASE WHEN agreement_status = 'In Negotiation' THEN agreement_id END)
      comment: "Number of agreements currently in negotiation. Measures contracting pipeline backlog and potential activation delays."
    - name: "avg_negotiation_cycle_days"
      expr: AVG(DATEDIFF(execution_date, negotiation_start_date))
      comment: "Average days from negotiation start to agreement execution. Measures contracting efficiency; long cycles delay site activation and enrollment start."
    - name: "agreements_with_ip_ownership_clause"
      expr: COUNT(CASE WHEN ip_ownership_clause = TRUE THEN agreement_id END)
      comment: "Number of agreements containing an IP ownership clause. Legal risk and IP governance KPI for sponsor legal teams."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`site_irb_iec_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors IRB/IEC approval status, submission-to-approval cycle times, and expiry risk across the site network. Used by Regulatory Affairs and Clinical Operations to ensure continuous ethical oversight compliance and prevent enrollment interruptions."
  source: "`clinical_trials_ecm`.`site`.`irb_iec_approval`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current IRB/IEC approval status (e.g., Approved, Pending, Suspended, Withdrawn). Primary regulatory compliance dimension."
    - name: "approval_type"
      expr: approval_type
      comment: "Type of IRB/IEC approval (e.g., Initial, Continuing Review, Amendment). Enables segmentation by review category."
    - name: "committee_type"
      expr: committee_type
      comment: "Type of ethics committee (e.g., Central IRB, Local IEC). Supports analysis by oversight body structure."
    - name: "review_type"
      expr: review_type
      comment: "Type of review conducted (e.g., Full Board, Expedited, Exempt). Regulatory process dimension."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month of IRB/IEC approval. Enables trend analysis of regulatory approval throughput."
    - name: "gcp_compliance_confirmed"
      expr: gcp_compliance_confirmed
      comment: "Boolean indicating GCP compliance was confirmed at approval. Quality assurance dimension."
    - name: "vulnerable_population_approved"
      expr: vulnerable_population_approved
      comment: "Boolean indicating approval for enrollment of vulnerable populations. Regulatory risk and ethics dimension."
    - name: "pediatric_enrollment_approved"
      expr: pediatric_enrollment_approved
      comment: "Boolean indicating approval for pediatric enrollment. Specialized regulatory compliance dimension."
    - name: "local_language_icf_approved"
      expr: local_language_icf_approved
      comment: "Boolean indicating whether a local language ICF was approved. Patient rights and regulatory compliance dimension."
  measures:
    - name: "total_irb_iec_approvals"
      expr: COUNT(1)
      comment: "Total number of IRB/IEC approval records. Baseline volume for regulatory oversight coverage."
    - name: "approvals_active"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN irb_iec_approval_id END)
      comment: "Number of currently active IRB/IEC approvals. Measures the size of the compliant, enrollable site network."
    - name: "approvals_suspended"
      expr: COUNT(CASE WHEN approval_status = 'Suspended' THEN irb_iec_approval_id END)
      comment: "Number of suspended IRB/IEC approvals. Critical risk KPI — suspended approvals halt enrollment and require immediate remediation."
    - name: "approvals_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN irb_iec_approval_id END)
      comment: "Number of IRB/IEC approvals expiring within the next 90 days. Proactive risk KPI to prevent enrollment interruptions due to lapsed approvals."
    - name: "avg_submission_to_approval_days"
      expr: AVG(DATEDIFF(approval_date, submission_date))
      comment: "Average days from IRB/IEC submission to approval. Measures regulatory review cycle time; long cycles delay site activation and enrollment start."
    - name: "avg_approval_validity_days"
      expr: AVG(DATEDIFF(expiration_date, approval_date))
      comment: "Average number of days an IRB/IEC approval remains valid. Informs continuing review scheduling and resource planning."
    - name: "distinct_sites_with_approval"
      expr: COUNT(DISTINCT investigational_site_id)
      comment: "Number of distinct investigational sites with at least one IRB/IEC approval record. Measures regulatory coverage of the site network."
    - name: "approvals_with_conditions"
      expr: COUNT(CASE WHEN approval_conditions IS NOT NULL AND approval_conditions <> '' THEN irb_iec_approval_id END)
      comment: "Number of approvals granted with conditions. Conditional approvals require follow-up actions and represent compliance risk if conditions are not resolved."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`site_closeout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks site closeout completion, financial settlement, document archival, and compliance status KPIs. Used by Clinical Operations and Finance to ensure timely, compliant site closure and final payment processing."
  source: "`clinical_trials_ecm`.`site`.`closeout`"
  dimensions:
    - name: "closeout_status"
      expr: closeout_status
      comment: "Current status of the site closeout process (e.g., Initiated, In Progress, Completed). Primary lifecycle dimension."
    - name: "closeout_type"
      expr: closeout_type
      comment: "Type of closeout (e.g., Planned, Early Termination). Distinguishes normal closure from premature termination events."
    - name: "gcp_compliance_status"
      expr: gcp_compliance_status
      comment: "GCP compliance status at closeout. Quality assurance dimension for regulatory inspection readiness."
    - name: "drug_accountability_status"
      expr: drug_accountability_status
      comment: "Status of investigational product accountability reconciliation. Regulatory compliance dimension for IMP closeout."
    - name: "essential_doc_archival_status"
      expr: essential_doc_archival_status
      comment: "Status of essential document archival. Regulatory compliance dimension; incomplete archival is an inspection finding risk."
    - name: "final_payment_status"
      expr: final_payment_status
      comment: "Status of final payment to the site. Financial settlement dimension."
    - name: "payment_currency_code"
      expr: payment_currency_code
      comment: "Currency of the final payment. Multi-currency financial analysis dimension."
    - name: "completed_month"
      expr: DATE_TRUNC('MONTH', completed_date)
      comment: "Month the closeout was completed. Enables trend analysis of closeout throughput."
    - name: "capa_required"
      expr: capa_required
      comment: "Boolean indicating whether a CAPA was required at closeout. Quality risk dimension."
    - name: "pi_acknowledgement_received"
      expr: pi_acknowledgement_received
      comment: "Boolean indicating whether the Principal Investigator acknowledgement was received. Closeout completeness dimension."
  measures:
    - name: "total_closeouts"
      expr: COUNT(1)
      comment: "Total number of site closeout records. Baseline volume for closeout pipeline management."
    - name: "closeouts_completed"
      expr: COUNT(CASE WHEN closeout_status = 'Completed' THEN closeout_id END)
      comment: "Number of fully completed site closeouts. Measures closeout throughput and trial wind-down progress."
    - name: "closeouts_with_capa"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN closeout_id END)
      comment: "Number of closeouts requiring a Corrective and Preventive Action. Quality risk KPI; high counts indicate systemic compliance issues."
    - name: "total_final_payments"
      expr: SUM(CAST(final_payment_amount AS DOUBLE))
      comment: "Total final payment amounts disbursed or committed across all closeouts. Financial settlement KPI for trial budget reconciliation."
    - name: "avg_final_payment_amount"
      expr: AVG(CAST(final_payment_amount AS DOUBLE))
      comment: "Average final payment per site closeout. Benchmarks closeout financial obligations and identifies outliers."
    - name: "avg_sdv_completion_pct"
      expr: AVG(CAST(sdv_completion_percentage AS DOUBLE))
      comment: "Average Source Data Verification completion percentage at closeout. Data quality KPI; low SDV completion at closeout is a regulatory inspection risk."
    - name: "avg_closeout_cycle_days"
      expr: AVG(DATEDIFF(completed_date, initiated_date))
      comment: "Average days from closeout initiation to completion. Measures closeout process efficiency; long cycles delay final payments and regulatory submissions."
    - name: "closeouts_with_doc_archival_complete"
      expr: COUNT(CASE WHEN essential_doc_archival_status = 'Completed' THEN closeout_id END)
      comment: "Number of closeouts with essential document archival completed. Regulatory compliance KPI for inspection readiness."
    - name: "early_termination_closeouts"
      expr: COUNT(CASE WHEN closeout_type = 'Early Termination' THEN closeout_id END)
      comment: "Number of sites closed out due to early termination. Risk indicator for trial execution quality and site performance issues."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`site_investigational_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master site network KPIs covering operational status, GCP compliance, infrastructure capabilities, and monitoring health. Used by Site Management and Clinical Operations leadership to govern the investigational site portfolio."
  source: "`clinical_trials_ecm`.`site`.`investigational_site`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the site (e.g., Active, Inactive, Closed). Primary site lifecycle dimension."
    - name: "country_code"
      expr: country_code
      comment: "Country where the site is located. Geographic dimension for regional network analysis."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g., Academic Medical Center, Community Hospital, Private Practice). Enables segmentation by site category."
    - name: "site_tier"
      expr: site_tier
      comment: "Strategic tier classification of the site (e.g., Tier 1, Tier 2, Tier 3). Used for resource allocation and prioritization decisions."
    - name: "gcp_compliance_status"
      expr: gcp_compliance_status
      comment: "Current GCP compliance status of the site. Regulatory quality dimension."
    - name: "gcp_certification_status"
      expr: gcp_certification_status
      comment: "GCP certification status. Compliance credential dimension."
    - name: "has_dedicated_research_staff"
      expr: has_dedicated_research_staff
      comment: "Boolean indicating whether the site has dedicated research staff. Infrastructure capability dimension."
    - name: "has_local_laboratory"
      expr: has_local_laboratory
      comment: "Boolean indicating whether the site has an on-site laboratory. Capability dimension affecting protocol feasibility."
    - name: "has_pharmacy"
      expr: has_pharmacy
      comment: "Boolean indicating whether the site has an on-site pharmacy. Critical for IMP handling and dispensing compliance."
    - name: "activation_year"
      expr: YEAR(activation_date)
      comment: "Year the site was activated. Enables cohort analysis of site network vintage and performance by activation year."
  measures:
    - name: "total_sites"
      expr: COUNT(1)
      comment: "Total number of investigational sites in the network. Baseline portfolio size metric."
    - name: "active_sites"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN investigational_site_id END)
      comment: "Number of currently active investigational sites. Measures the operational capacity of the trial network."
    - name: "sites_with_open_capas"
      expr: COUNT(CASE WHEN CAST(open_capa_count AS BIGINT) > 0 THEN investigational_site_id END)
      comment: "Number of sites with at least one open CAPA. Quality risk KPI; sites with open CAPAs require compliance follow-up."
    - name: "sites_gcp_compliant"
      expr: COUNT(CASE WHEN gcp_compliance_status = 'Compliant' THEN investigational_site_id END)
      comment: "Number of sites with confirmed GCP compliant status. Regulatory quality KPI for the site network."
    - name: "sites_with_pharmacy"
      expr: COUNT(CASE WHEN has_pharmacy = TRUE THEN investigational_site_id END)
      comment: "Number of sites with on-site pharmacy capability. Infrastructure KPI for IMP-handling protocol feasibility planning."
    - name: "sites_with_local_lab"
      expr: COUNT(CASE WHEN has_local_laboratory = TRUE THEN investigational_site_id END)
      comment: "Number of sites with on-site laboratory capability. Infrastructure KPI for protocol feasibility and sample logistics planning."
    - name: "sites_with_dedicated_research_staff"
      expr: COUNT(CASE WHEN has_dedicated_research_staff = TRUE THEN investigational_site_id END)
      comment: "Number of sites with dedicated research staff. Operational capacity KPI; dedicated staff correlates with higher enrollment performance."
    - name: "distinct_countries_in_network"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries represented in the site network. Geographic diversity KPI for global trial reach."
    - name: "avg_days_since_last_audit"
      expr: AVG(DATEDIFF(CURRENT_DATE, last_audit_date))
      comment: "Average number of days since the last site audit. Risk management KPI; sites with long audit gaps may have undetected compliance issues."
    - name: "avg_days_since_last_monitoring_visit"
      expr: AVG(DATEDIFF(CURRENT_DATE, last_monitoring_visit_date))
      comment: "Average days since the last monitoring visit across sites. Operational oversight KPI; high values indicate monitoring coverage gaps."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`site_selection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks site selection pipeline KPIs including selection rates, feasibility scores, enrollment projections, and geographic distribution. Used by Site Selection and Clinical Operations teams to optimize site identification and qualification strategies."
  source: "`clinical_trials_ecm`.`site`.`selection`"
  dimensions:
    - name: "selection_status"
      expr: selection_status
      comment: "Current status of the site selection record (e.g., Selected, Rejected, Conditional, Pending). Primary funnel stage dimension."
    - name: "selection_type"
      expr: selection_type
      comment: "Type of selection process (e.g., Competitive, Directed, Replacement). Enables analysis by selection methodology."
    - name: "country_code"
      expr: country_code
      comment: "Country of the candidate site. Geographic dimension for regional selection strategy analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the candidate site. Supports regional enrollment strategy and site distribution decisions."
    - name: "irb_iec_status"
      expr: irb_iec_status
      comment: "IRB/IEC status at time of selection. Regulatory readiness dimension."
    - name: "selection_month"
      expr: DATE_TRUNC('MONTH', selection_date)
      comment: "Month of site selection decision. Enables trend analysis of selection pipeline throughput."
    - name: "gcp_compliance_confirmed"
      expr: gcp_compliance_confirmed
      comment: "Boolean indicating GCP compliance was confirmed at selection. Compliance gate dimension."
    - name: "pi_qualification_verified"
      expr: pi_qualification_verified
      comment: "Boolean indicating PI qualification was verified. Investigator readiness dimension."
    - name: "prior_audit_finding"
      expr: prior_audit_finding
      comment: "Boolean indicating whether the site has prior audit findings. Risk dimension for site quality assessment."
    - name: "sponsor_approval_required"
      expr: sponsor_approval_required
      comment: "Boolean indicating whether sponsor approval is required for selection. Process governance dimension."
  measures:
    - name: "total_selections"
      expr: COUNT(1)
      comment: "Total number of site selection records. Baseline volume for selection pipeline management."
    - name: "sites_selected"
      expr: COUNT(CASE WHEN selection_status = 'Selected' THEN selection_id END)
      comment: "Number of sites with a confirmed selected status. Measures selection pipeline output."
    - name: "sites_rejected"
      expr: COUNT(CASE WHEN selection_status = 'Rejected' THEN selection_id END)
      comment: "Number of sites rejected during selection. Measures attrition in the site qualification funnel."
    - name: "selection_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN selection_status = 'Selected' THEN selection_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of site selection records resulting in a selected outcome. Measures site qualification funnel efficiency; low rates indicate poor targeting or high qualification barriers."
    - name: "avg_feasibility_score"
      expr: AVG(CAST(feasibility_score AS DOUBLE))
      comment: "Average feasibility score of selected and assessed sites. Measures the quality bar of the site selection process."
    - name: "avg_enrollment_rate_per_month"
      expr: AVG(CAST(enrollment_rate_per_month AS DOUBLE))
      comment: "Average projected monthly enrollment rate from selection assessments. Used to validate enrollment forecasts and trial timelines."
    - name: "sites_with_prior_audit_findings"
      expr: COUNT(CASE WHEN prior_audit_finding = TRUE THEN selection_id END)
      comment: "Number of selected sites with prior audit findings. Risk KPI for site quality governance; high counts increase regulatory inspection risk."
    - name: "distinct_countries_in_pipeline"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries represented in the selection pipeline. Geographic diversity KPI for global trial design."
    - name: "avg_days_to_activation_target"
      expr: AVG(DATEDIFF(activation_target_date, selection_date))
      comment: "Average days from site selection to planned activation target date. Measures the planned start-up timeline and informs resource scheduling."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`site_cra_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors CRA workload allocation, monitoring coverage, SDV rates, and assignment efficiency across the site network. Used by Clinical Operations and Monitoring leadership to optimize CRA resource deployment and ensure adequate site oversight."
  source: "`clinical_trials_ecm`.`site`.`site_cra_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the CRA assignment (e.g., Active, Completed, Terminated). Primary assignment lifecycle dimension."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of CRA assignment (e.g., Primary, Backup, Handover). Enables analysis by assignment role."
    - name: "monitoring_approach"
      expr: monitoring_approach
      comment: "Monitoring approach used (e.g., On-Site, Remote, Hybrid). Enables cost and efficiency analysis by monitoring modality."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier of the site assignment (e.g., High, Medium, Low). Enables risk-stratified monitoring analysis."
    - name: "geographic_territory"
      expr: geographic_territory
      comment: "Geographic territory of the CRA assignment. Enables workload analysis by territory."
    - name: "territory_country_code"
      expr: territory_country_code
      comment: "Country code of the assignment territory. Geographic dimension for regional monitoring coverage analysis."
    - name: "assignment_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the CRA assignment started. Enables trend analysis of assignment activity."
    - name: "gcp_training_current"
      expr: gcp_training_current
      comment: "Boolean indicating whether the assigned CRA's GCP training is current. Compliance readiness dimension."
    - name: "travel_required"
      expr: travel_required
      comment: "Boolean indicating whether travel is required for the assignment. Cost planning dimension."
  measures:
    - name: "total_cra_assignments"
      expr: COUNT(1)
      comment: "Total number of CRA-to-site assignments. Baseline volume for monitoring resource deployment."
    - name: "active_assignments"
      expr: COUNT(CASE WHEN assignment_status = 'Active' THEN site_cra_assignment_id END)
      comment: "Number of currently active CRA assignments. Measures current monitoring coverage capacity."
    - name: "avg_sdv_rate_pct"
      expr: AVG(CAST(sdv_rate_pct AS DOUBLE))
      comment: "Average Source Data Verification rate across CRA assignments. Data quality KPI; SDV rate directly impacts data integrity and regulatory submission readiness."
    - name: "avg_workload_allocation_pct"
      expr: AVG(CAST(workload_allocation_pct AS DOUBLE))
      comment: "Average workload allocation percentage per CRA assignment. Measures CRA capacity utilization; over-allocation risks monitoring quality."
    - name: "avg_estimated_travel_days_per_visit"
      expr: AVG(CAST(estimated_travel_days_per_visit AS DOUBLE))
      comment: "Average estimated travel days per monitoring visit. Operational cost KPI for monitoring budget planning."
    - name: "assignments_with_open_action_items"
      expr: COUNT(CASE WHEN CAST(open_action_items_count AS BIGINT) > 0 THEN site_cra_assignment_id END)
      comment: "Number of CRA assignments with open action items. Quality oversight KPI; unresolved action items indicate monitoring follow-up gaps."
    - name: "distinct_sites_monitored"
      expr: COUNT(DISTINCT investigational_site_id)
      comment: "Number of distinct sites with active or historical CRA assignments. Measures monitoring network coverage."
    - name: "high_risk_assignments"
      expr: COUNT(CASE WHEN risk_tier = 'High' THEN site_cra_assignment_id END)
      comment: "Number of CRA assignments classified as high risk. Risk management KPI; high-risk sites require intensified monitoring frequency and oversight."
    - name: "avg_assignment_duration_days"
      expr: AVG(DATEDIFF(end_date, start_date))
      comment: "Average duration of CRA assignments in days. Measures assignment stability; frequent short assignments may indicate high turnover and continuity risk."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`site_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks regulatory submission cycle times, approval rates, and compliance status at the site level. Used by Regulatory Affairs and Clinical Operations to manage submission timelines and ensure country-level regulatory clearance for site activation."
  source: "`clinical_trials_ecm`.`site`.`regulatory_submission_site`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the regulatory submission (e.g., Submitted, Approved, Rejected, Pending). Primary regulatory pipeline dimension."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (e.g., Initial, Amendment, Annual Report). Enables segmentation by submission category."
    - name: "submission_category"
      expr: submission_category
      comment: "Category of the submission (e.g., IND, CTA, Ethics). Regulatory classification dimension."
    - name: "country_code"
      expr: country_code
      comment: "Country of the regulatory submission. Geographic dimension for country-level regulatory performance analysis."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Name of the regulatory authority receiving the submission (e.g., FDA, EMA, MHRA). Enables benchmarking by authority."
    - name: "review_outcome"
      expr: review_outcome
      comment: "Outcome of the regulatory review (e.g., Approved, Rejected, Request for Information). Measures regulatory decision quality."
    - name: "submission_method"
      expr: submission_method
      comment: "Method of submission (e.g., Electronic, Paper, Portal). Operational process dimension."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of regulatory submission. Enables trend analysis of submission throughput."
    - name: "gcp_compliance_confirmed"
      expr: gcp_compliance_confirmed
      comment: "Boolean indicating GCP compliance was confirmed at submission. Regulatory quality dimension."
    - name: "sponsor_notified"
      expr: sponsor_notified
      comment: "Boolean indicating whether the sponsor was notified of the submission outcome. Communication compliance dimension."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions at site level. Baseline volume for regulatory pipeline management."
    - name: "submissions_approved"
      expr: COUNT(CASE WHEN submission_status = 'Approved' THEN regulatory_submission_site_id END)
      comment: "Number of regulatory submissions that received approval. Measures regulatory clearance throughput."
    - name: "submissions_rejected"
      expr: COUNT(CASE WHEN submission_status = 'Rejected' THEN regulatory_submission_site_id END)
      comment: "Number of regulatory submissions rejected. Quality KPI; high rejection rates indicate submission quality issues or regulatory strategy gaps."
    - name: "regulatory_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_status = 'Approved' THEN regulatory_submission_site_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions receiving regulatory approval. Measures regulatory submission quality and strategy effectiveness."
    - name: "avg_submission_to_approval_days"
      expr: AVG(DATEDIFF(approval_date, submission_date))
      comment: "Average days from submission to regulatory approval. Key cycle-time KPI; long approval timelines delay site activation and enrollment start."
    - name: "avg_submission_to_response_days"
      expr: AVG(DATEDIFF(response_date, submission_date))
      comment: "Average days from submission to any regulatory response. Measures regulatory authority responsiveness by country and authority."
    - name: "submissions_overdue_response"
      expr: COUNT(CASE WHEN response_date IS NULL AND response_due_date < CURRENT_DATE THEN regulatory_submission_site_id END)
      comment: "Number of submissions where a response is overdue. Risk KPI for regulatory timeline management; overdue responses delay site activation."
    - name: "distinct_countries_submitted"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries with regulatory submissions. Measures geographic regulatory coverage of the trial."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`site_principal_investigator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors Principal Investigator qualification, compliance credential status, and regulatory standing across the investigator network. Used by Site Management and Regulatory Affairs to ensure investigator eligibility and manage qualification risk."
  source: "`clinical_trials_ecm`.`site`.`principal_investigator`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the PI (e.g., Active, Inactive, Disqualified). Primary investigator status dimension."
    - name: "pi_type"
      expr: pi_type
      comment: "Type of PI role (e.g., Principal Investigator, Sub-Investigator, Coordinating Investigator). Role classification dimension."
    - name: "specialty"
      expr: specialty
      comment: "Medical specialty of the PI. Enables matching of investigators to protocol therapeutic area requirements."
    - name: "institution_country"
      expr: institution_country
      comment: "Country of the PI's institution. Geographic dimension for investigator network analysis."
    - name: "debarment_check_status"
      expr: debarment_check_status
      comment: "Status of FDA debarment check. Critical regulatory compliance dimension; debarred investigators cannot participate in trials."
    - name: "financial_disclosure_status"
      expr: financial_disclosure_status
      comment: "Status of financial disclosure filing. Regulatory compliance dimension required for FDA submissions."
    - name: "form_1572_status"
      expr: form_1572_status
      comment: "Status of FDA Form 1572 (Statement of Investigator). Regulatory compliance dimension required for IND studies."
    - name: "irb_iec_approval_status"
      expr: irb_iec_approval_status
      comment: "IRB/IEC approval status for the investigator. Regulatory clearance dimension."
    - name: "inspection_history_flag"
      expr: inspection_history_flag
      comment: "Boolean indicating whether the PI has a prior regulatory inspection history. Risk dimension for site selection and monitoring intensity decisions."
    - name: "protocol_training_complete"
      expr: protocol_training_complete
      comment: "Boolean indicating whether protocol training has been completed. Operational readiness dimension."
  measures:
    - name: "total_investigators"
      expr: COUNT(1)
      comment: "Total number of principal investigators in the network. Baseline portfolio size metric."
    - name: "active_investigators"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN principal_investigator_id END)
      comment: "Number of currently active investigators. Measures available investigator capacity for trial assignments."
    - name: "investigators_with_debarment_cleared"
      expr: COUNT(CASE WHEN debarment_check_status = 'Cleared' THEN principal_investigator_id END)
      comment: "Number of investigators with a cleared debarment check. Regulatory compliance KPI; uncleared investigators cannot be assigned to FDA-regulated studies."
    - name: "investigators_with_gcp_expired"
      expr: COUNT(CASE WHEN gcp_training_expiry_date < CURRENT_DATE THEN principal_investigator_id END)
      comment: "Number of investigators with expired GCP training. Compliance risk KPI; expired GCP training is a regulatory finding and blocks site activation."
    - name: "investigators_with_medical_license_expired"
      expr: COUNT(CASE WHEN medical_license_expiry_date < CURRENT_DATE THEN principal_investigator_id END)
      comment: "Number of investigators with expired medical licenses. Critical regulatory risk KPI; expired licenses invalidate investigator eligibility."
    - name: "investigators_with_inspection_history"
      expr: COUNT(CASE WHEN inspection_history_flag = TRUE THEN principal_investigator_id END)
      comment: "Number of investigators with prior regulatory inspection history. Risk management KPI for site selection and monitoring intensity planning."
    - name: "investigators_with_financial_disclosure_complete"
      expr: COUNT(CASE WHEN financial_disclosure_status = 'Completed' THEN principal_investigator_id END)
      comment: "Number of investigators with completed financial disclosure. Regulatory compliance KPI required for FDA submission integrity."
    - name: "distinct_countries_represented"
      expr: COUNT(DISTINCT institution_country)
      comment: "Number of distinct countries represented in the investigator network. Geographic diversity KPI for global trial capability."
$$;