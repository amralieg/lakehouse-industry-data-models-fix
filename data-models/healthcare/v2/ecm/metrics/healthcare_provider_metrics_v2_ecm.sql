-- Metric views for domain: provider | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_clinician`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider workforce roster KPIs covering active headcount, credentialing readiness, payer enrollment, and exclusion screening compliance — used by Medical Staff Office and network leadership to steer provider lifecycle and compliance risk."
  source: "`vibe_healthcare_v1`.`provider`.`clinician`"
  dimensions:
    - name: "clinician_type"
      expr: clinician_type
      comment: "Type/classification of the clinician (e.g., physician, APP) for workforce segmentation."
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status used to segment active vs terminated providers."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment arrangement (e.g., employed, contracted) for workforce mix analysis."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing lifecycle status used to monitor credentialing readiness."
    - name: "payer_enrollment_status"
      expr: payer_enrollment_status
      comment: "Payer enrollment status indicating revenue-readiness for the provider."
    - name: "license_state"
      expr: license_state
      comment: "State of licensure for geographic coverage and network adequacy analysis."
    - name: "professional_designation"
      expr: professional_designation
      comment: "Professional designation for specialty/role workforce reporting."
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Hire month for provider onboarding trend analysis."
  measures:
    - name: "Provider Count"
      expr: COUNT(1)
      comment: "Total provider records — baseline workforce headcount."
    - name: "Distinct Provider Count"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Distinct clinicians — true provider headcount for capacity and network adequacy decisions."
    - name: "Active Provider Count"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN clinician_id END)
      comment: "Active clinicians — capacity available to deliver care; drives staffing and recruitment decisions."
    - name: "Board Certified Provider Count"
      expr: COUNT(DISTINCT CASE WHEN board_certified = TRUE THEN clinician_id END)
      comment: "Board-certified providers — quality and payer-contract eligibility indicator."
    - name: "Board Certification Rate Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN board_certified = TRUE THEN clinician_id END) / NULLIF(COUNT(DISTINCT clinician_id),0), 2)
      comment: "Percent of providers board-certified — quality benchmark steering credentialing and recruiting standards."
    - name: "Primary Source Verified Count"
      expr: COUNT(DISTINCT CASE WHEN primary_source_verified = TRUE THEN clinician_id END)
      comment: "Providers with primary source verification complete — credentialing compliance readiness."
    - name: "OIG Exclusion Screened Count"
      expr: COUNT(DISTINCT CASE WHEN oig_exclusion_checked = TRUE THEN clinician_id END)
      comment: "Providers screened against OIG exclusion list — compliance risk control."
    - name: "OIG Screening Compliance Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN oig_exclusion_checked = TRUE THEN clinician_id END) / NULLIF(COUNT(DISTINCT clinician_id),0), 2)
      comment: "Percent of providers OIG-screened — billing compliance risk metric leadership monitors."
    - name: "Medicare Enrolled Count"
      expr: COUNT(DISTINCT CASE WHEN medicare_enrolled = TRUE THEN clinician_id END)
      comment: "Providers enrolled with Medicare — revenue-readiness and network participation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_credentialing_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credentialing application throughput and turnaround KPIs — used by Medical Staff Office to manage onboarding velocity, NPDB/exclusion risk, and approval bottlenecks that delay provider revenue."
  source: "`vibe_healthcare_v1`.`provider`.`credentialing_application`"
  dimensions:
    - name: "application_type"
      expr: application_type
      comment: "Type of credentialing application (initial, recredentialing) for throughput segmentation."
    - name: "application_status"
      expr: application_status
      comment: "Current application status used to track pipeline stage and backlog."
    - name: "decision_type"
      expr: decision_type
      comment: "Decision outcome type for approval vs denial analysis."
    - name: "medical_staff_category"
      expr: medical_staff_category
      comment: "Medical staff category for cohort credentialing reporting."
    - name: "application_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Application submission month for onboarding velocity trends."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Decision month for credentialing committee throughput trends."
  measures:
    - name: "Application Count"
      expr: COUNT(1)
      comment: "Total credentialing applications — pipeline volume baseline."
    - name: "Approved Application Count"
      expr: COUNT(CASE WHEN decision_type = 'Approved' THEN 1 END)
      comment: "Applications approved — successful onboarding throughput."
    - name: "Denied Application Count"
      expr: COUNT(CASE WHEN denial_reason IS NOT NULL THEN 1 END)
      comment: "Applications denied — risk and rework indicator for credentialing leadership."
    - name: "NPDB Adverse Action Count"
      expr: COUNT(CASE WHEN npdb_adverse_action_flag = TRUE THEN 1 END)
      comment: "Applications with NPDB adverse action flags — provider risk requiring committee review."
    - name: "NPDB Malpractice Flag Count"
      expr: COUNT(CASE WHEN npdb_malpractice_flag = TRUE THEN 1 END)
      comment: "Applications with NPDB malpractice findings — liability risk indicator."
    - name: "Provisional Privileges Count"
      expr: COUNT(CASE WHEN provisional_privileges_flag = TRUE THEN 1 END)
      comment: "Applications granted provisional privileges — expedited-access risk to monitor."
    - name: "Avg Credentialing Cycle Days"
      expr: ROUND(AVG(DATEDIFF(decision_date, application_date)), 1)
      comment: "Average days from application to decision — turnaround KPI steering staffing and onboarding speed."
    - name: "Avg Malpractice Per Occurrence Limit"
      expr: ROUND(AVG(CAST(malpractice_per_occurrence_limit AS DOUBLE)), 2)
      comment: "Average malpractice per-occurrence coverage — liability coverage adequacy benchmark."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_privileging`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical privileging KPIs covering active privileges, provisional status, FPPE/OPPE compliance, and suspensions — used by Medical Staff and quality leadership to manage scope-of-practice risk."
  source: "`vibe_healthcare_v1`.`provider`.`privileging`"
  dimensions:
    - name: "privilege_category"
      expr: privilege_category
      comment: "Privilege category for scope-of-practice grouping."
    - name: "privilege_type"
      expr: privilege_type
      comment: "Type of privilege for clinical-area reporting."
    - name: "privilege_status"
      expr: privilege_status
      comment: "Privilege status used to monitor active vs suspended/revoked privileges."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Privilege approval month for granting-trend analysis."
  measures:
    - name: "Privilege Count"
      expr: COUNT(1)
      comment: "Total privilege records — baseline scope volume."
    - name: "Active Privilege Count"
      expr: COUNT(CASE WHEN privilege_status = 'Active' THEN 1 END)
      comment: "Active privileges — current clinical scope leadership relies on for coverage decisions."
    - name: "Provisional Privilege Count"
      expr: COUNT(CASE WHEN is_provisional = TRUE THEN 1 END)
      comment: "Provisional privileges — providers under heightened FPPE monitoring."
    - name: "FPPE Required Count"
      expr: COUNT(CASE WHEN fppe_required = TRUE THEN 1 END)
      comment: "Privileges requiring FPPE — focused performance evaluation workload."
    - name: "Suspended Privilege Count"
      expr: COUNT(CASE WHEN suspension_date IS NOT NULL THEN 1 END)
      comment: "Suspended privileges — patient-safety risk requiring leadership intervention."
    - name: "Revoked Privilege Count"
      expr: COUNT(CASE WHEN revocation_date IS NOT NULL THEN 1 END)
      comment: "Revoked privileges — adverse-action volume tied to NPDB reporting."
    - name: "Avg Peer Review Score"
      expr: ROUND(AVG(CAST(peer_review_score AS DOUBLE)), 2)
      comment: "Average peer review score — clinical quality benchmark for privilege renewal decisions."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_sanction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider sanction and exclusion KPIs covering federal program exclusions, civil monetary penalties, and corporate integrity agreements — critical compliance risk metrics for the board and Chief Compliance Officer."
  source: "`vibe_healthcare_v1`.`provider`.`sanction`"
  dimensions:
    - name: "sanction_type"
      expr: sanction_type
      comment: "Type of sanction for risk categorization."
    - name: "sanction_status"
      expr: sanction_status
      comment: "Current sanction status to distinguish active vs resolved sanctions."
    - name: "issuing_authority_type"
      expr: issuing_authority_type
      comment: "Type of issuing authority (federal, state, board) for jurisdictional reporting."
    - name: "exclusion_type_code"
      expr: exclusion_type_code
      comment: "Exclusion type code for OIG/SAM exclusion analysis."
    - name: "sanction_month"
      expr: DATE_TRUNC('MONTH', sanction_date)
      comment: "Sanction date month for compliance trend monitoring."
  measures:
    - name: "Sanction Count"
      expr: COUNT(1)
      comment: "Total sanction records — compliance event volume baseline."
    - name: "Federal Program Exclusion Count"
      expr: COUNT(CASE WHEN federal_program_exclusion = TRUE THEN 1 END)
      comment: "Federal program exclusions — billing-prohibition risk leadership must remediate immediately."
    - name: "Medicare Exclusion Count"
      expr: COUNT(CASE WHEN medicare_exclusion = TRUE THEN 1 END)
      comment: "Medicare exclusions — direct reimbursement and compliance risk."
    - name: "CIA Count"
      expr: COUNT(CASE WHEN corporate_integrity_agreement = TRUE THEN 1 END)
      comment: "Corporate integrity agreements in force — enterprise-level compliance obligation indicator."
    - name: "Total Civil Monetary Penalty"
      expr: SUM(CAST(civil_monetary_penalty_amount AS DOUBLE))
      comment: "Total civil monetary penalties — financial exposure from sanctions for the board."
    - name: "Total Settlement Amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement dollars — quantified compliance cost steering risk investment."
    - name: "NPDB Reported Sanction Count"
      expr: COUNT(CASE WHEN reported_to_npdb = TRUE THEN 1 END)
      comment: "Sanctions reported to NPDB — regulatory reporting compliance metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_malpractice_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider malpractice insurance KPIs covering active coverage, lapses, open claims, and coverage limits — used by Risk Management and credentialing to ensure liability coverage adequacy."
  source: "`vibe_healthcare_v1`.`provider`.`malpractice_coverage`"
  dimensions:
    - name: "coverage_type"
      expr: coverage_type
      comment: "Malpractice coverage type for liability program analysis."
    - name: "coverage_status"
      expr: coverage_status
      comment: "Coverage status to monitor active vs lapsed coverage."
    - name: "coverage_state"
      expr: coverage_state
      comment: "State of coverage for jurisdictional risk reporting."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Coverage effective month for renewal-cycle trend analysis."
  measures:
    - name: "Coverage Record Count"
      expr: COUNT(1)
      comment: "Total malpractice coverage records — baseline policy volume."
    - name: "Coverage Lapse Count"
      expr: COUNT(CASE WHEN coverage_lapse_indicator = TRUE THEN 1 END)
      comment: "Policies with coverage lapses — uninsured-liability risk requiring immediate action."
    - name: "Self Insured Count"
      expr: COUNT(CASE WHEN self_insured_indicator = TRUE THEN 1 END)
      comment: "Self-insured policies — captive-program exposure leadership monitors."
    - name: "Total Open Claims"
      expr: SUM(CAST(open_claims_count AS DOUBLE))
      comment: "Total open malpractice claims — active liability volume for risk reserves planning."
    - name: "Avg Aggregate Limit"
      expr: ROUND(AVG(CAST(aggregate_limit AS DOUBLE)), 2)
      comment: "Average aggregate coverage limit — liability adequacy benchmark for credentialing standards."
    - name: "Avg Per Occurrence Limit"
      expr: ROUND(AVG(CAST(per_occurrence_limit AS DOUBLE)), 2)
      comment: "Average per-occurrence coverage limit — single-event liability adequacy."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_network_affiliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider network participation KPIs covering active affiliations, panel capacity, new-patient access, and directory accuracy — used by network management and access leadership to steer adequacy and growth."
  source: "`vibe_healthcare_v1`.`provider`.`network_affiliation`"
  dimensions:
    - name: "affiliation_status"
      expr: affiliation_status
      comment: "Network affiliation status used to track active participation."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier for product/network design analysis."
    - name: "participation_type"
      expr: participation_type
      comment: "Participation type for in/out-of-network reporting."
    - name: "network_adequacy_category"
      expr: network_adequacy_category
      comment: "Network adequacy category for regulatory adequacy monitoring."
    - name: "service_area_state"
      expr: service_area_state
      comment: "Service area state for geographic network coverage analysis."
  measures:
    - name: "Affiliation Count"
      expr: COUNT(1)
      comment: "Total network affiliation records — baseline participation volume."
    - name: "Distinct Affiliated Provider Count"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Distinct providers in network — network size for adequacy and access decisions."
    - name: "Accepting New Patients Count"
      expr: COUNT(CASE WHEN accepts_new_patients = TRUE THEN 1 END)
      comment: "Affiliations accepting new patients — access capacity for member growth steering."
    - name: "Accepting New Patients Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accepts_new_patients = TRUE THEN 1 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of affiliations open to new patients — patient access KPI leadership monitors."
    - name: "Directory Published Count"
      expr: COUNT(CASE WHEN directory_published_flag = TRUE THEN 1 END)
      comment: "Affiliations published in directory — directory accuracy/compliance indicator."
    - name: "Primary Care Designation Count"
      expr: COUNT(CASE WHEN primary_care_designation = TRUE THEN 1 END)
      comment: "Primary care affiliations — PCP capacity for attribution and adequacy planning."
    - name: "Telehealth Eligible Count"
      expr: COUNT(CASE WHEN telehealth_eligible = TRUE THEN 1 END)
      comment: "Telehealth-eligible affiliations — virtual-access capacity for service strategy."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_reappointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider reappointment KPIs covering CME compliance, OPPE outcomes, NPDB findings, and approval decisions — used by Medical Staff Office to manage recredentialing cycles and quality-driven retention."
  source: "`vibe_healthcare_v1`.`provider`.`reappointment`"
  dimensions:
    - name: "reappointment_status"
      expr: reappointment_status
      comment: "Reappointment status to track cycle progress and backlog."
    - name: "decision"
      expr: decision
      comment: "Reappointment decision outcome for approval/denial analysis."
    - name: "medical_staff_category"
      expr: medical_staff_category
      comment: "Medical staff category for reappointment cohort reporting."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Decision month for reappointment committee throughput trends."
  measures:
    - name: "Reappointment Count"
      expr: COUNT(1)
      comment: "Total reappointment records — recredentialing volume baseline."
    - name: "CME Compliant Count"
      expr: COUNT(CASE WHEN quality_indicator_met = TRUE THEN 1 END)
      comment: "Reappointments meeting quality indicators — quality-based retention metric."
    - name: "NPDB Adverse Finding Count"
      expr: COUNT(CASE WHEN npdb_adverse_finding = TRUE THEN 1 END)
      comment: "Reappointments with NPDB adverse findings — provider risk requiring committee scrutiny."
    - name: "Sanctions Finding Count"
      expr: COUNT(CASE WHEN sanctions_finding = TRUE THEN 1 END)
      comment: "Reappointments with sanction findings — compliance risk in the recredentialing population."
    - name: "Due Process Initiated Count"
      expr: COUNT(CASE WHEN due_process_initiated = TRUE THEN 1 END)
      comment: "Reappointments triggering due process — adverse-action workload and legal risk."
    - name: "Avg CME Hours Completed"
      expr: ROUND(AVG(CAST(cme_hours_completed AS DOUBLE)), 1)
      comment: "Average CME hours completed — provider continuing-education compliance benchmark."
    - name: "Avg CME Hours Required"
      expr: ROUND(AVG(CAST(cme_hours_required AS DOUBLE)), 1)
      comment: "Average CME hours required — baseline to compare against completion for compliance gaps."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider assignment and FTE allocation KPIs covering clinical/administrative/research effort, productivity targets, and credentialing readiness — used by service-line and finance leadership to manage provider capacity and productivity."
  source: "`vibe_healthcare_v1`.`provider`.`assignment`"
  dimensions:
    - name: "assignment_type"
      expr: assignment_type
      comment: "Assignment type for capacity allocation analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Assignment status to track active vs ended assignments."
    - name: "service_line"
      expr: service_line
      comment: "Service line for productivity and capacity reporting by clinical area."
    - name: "compensation_model"
      expr: compensation_model
      comment: "Compensation model for productivity-vs-pay alignment analysis."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Assignment effective month for staffing trend analysis."
  measures:
    - name: "Assignment Count"
      expr: COUNT(1)
      comment: "Total assignment records — staffing allocation baseline."
    - name: "Total Clinical FTE"
      expr: SUM(CAST(clinical_fte AS DOUBLE))
      comment: "Total clinical FTE allocated — direct patient-care capacity for staffing decisions."
    - name: "Total Administrative FTE"
      expr: SUM(CAST(administrative_fte AS DOUBLE))
      comment: "Total administrative FTE — non-clinical effort leadership balances against clinical need."
    - name: "Total Research FTE"
      expr: SUM(CAST(research_fte AS DOUBLE))
      comment: "Total research FTE — academic-mission effort allocation."
    - name: "Avg FTE Allocation"
      expr: ROUND(AVG(CAST(fte_allocation AS DOUBLE)), 3)
      comment: "Average FTE allocation per assignment — workload distribution benchmark."
    - name: "Total wRVU Target"
      expr: SUM(CAST(wrvu_target AS DOUBLE))
      comment: "Total work RVU productivity target — productivity planning and compensation alignment."
    - name: "Credentialing Verified Count"
      expr: COUNT(CASE WHEN credentialing_verified_flag = TRUE THEN 1 END)
      comment: "Assignments with credentialing verified — billing-readiness indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_dea_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DEA controlled-substance registration KPIs covering active registrations, expirations, and scheduling authorizations — used by pharmacy compliance and credentialing to manage prescribing-authority risk."
  source: "`vibe_healthcare_v1`.`provider`.`dea_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "DEA registration status to monitor active vs lapsed registrations."
    - name: "registration_type"
      expr: registration_type
      comment: "Registration type for prescribing-authority categorization."
    - name: "registration_state"
      expr: registration_state
      comment: "State of registration for jurisdictional compliance reporting."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Expiration month for renewal pipeline planning."
  measures:
    - name: "Registration Count"
      expr: COUNT(1)
      comment: "Total DEA registration records — controlled-substance authorization volume."
    - name: "Active Registration Count"
      expr: COUNT(CASE WHEN registration_status = 'Active' THEN 1 END)
      comment: "Active DEA registrations — prescribing capacity leadership relies on."
    - name: "Schedule II Authorized Count"
      expr: COUNT(CASE WHEN schedule_ii_authorized = TRUE THEN 1 END)
      comment: "Schedule II authorized registrations — high-risk prescribing population for monitoring."
    - name: "X Waiver Authorized Count"
      expr: COUNT(CASE WHEN x_waiver_authorized = TRUE THEN 1 END)
      comment: "X-waiver authorized providers — MAT prescribing capacity for SUD treatment access."
    - name: "Suspended Registration Count"
      expr: COUNT(CASE WHEN suspension_date IS NOT NULL THEN 1 END)
      comment: "Suspended DEA registrations — prescribing-authority risk requiring action."
    - name: "PDMP Reporting Required Count"
      expr: COUNT(CASE WHEN pdmp_reporting_required = TRUE THEN 1 END)
      comment: "Registrations requiring PDMP reporting — opioid-stewardship compliance scope."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_board_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Board certification coverage by status and privilege requirement"
  source: "`vibe_healthcare_v1`.`provider`.`board_certification`"
  filter: certification_status = 'Active'
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification"
    - name: "is_active_privileges_required"
      expr: is_active_privileges_required
      comment: "Whether active privileges are required for the certification"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the certification became effective"
  measures:
    - name: "certified_clinician_count"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Number of clinicians with active board certification"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_network_affiliation_active`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Active participation in provider networks"
  source: "`vibe_healthcare_v1`.`provider`.`network_affiliation`"
  dimensions:
    - name: "network_tier"
      expr: network_tier
      comment: "Tier level of the network participation"
    - name: "provider_network_id"
      expr: provider_network_id
      comment: "Identifier of the provider network"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year of affiliation effectiveness"
  measures:
    - name: "active_network_affiliation_count"
      expr: COUNT(1)
      comment: "Count of active network affiliations"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_location_access`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Access availability of provider locations"
  source: "`vibe_healthcare_v1`.`provider`.`provider_location`"
  filter: is_accepting_new_patients = true
  dimensions:
    - name: "state_code"
      expr: state_code
      comment: "State code of the location"
    - name: "location_type"
      expr: location_type
      comment: "Type of location (e.g., clinic, hospital)"
    - name: "is_telehealth_enabled"
      expr: is_telehealth_enabled
      comment: "Whether telehealth services are enabled at the location"
  measures:
    - name: "accepting_location_count"
      expr: COUNT(1)
      comment: "Count of provider locations currently accepting new patients"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_reappointment_pending`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pending reappointments by specialty"
  source: "`vibe_healthcare_v1`.`provider`.`reappointment`"
  filter: reappointment_status = 'Pending'
  dimensions:
    - name: "specialty_id"
      expr: specialty_id
      comment: "Specialty associated with the reappointment"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year of the reappointment record"
  measures:
    - name: "pending_reappointment_count"
      expr: COUNT(1)
      comment: "Number of pending reappointments"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_active_sanctions`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Active sanctions impacting providers"
  source: "`vibe_healthcare_v1`.`provider`.`sanction`"
  filter: sanction_status = 'Active'
  dimensions:
    - name: "sanction_type"
      expr: sanction_type
      comment: "Type/category of the sanction"
    - name: "sanction_status"
      expr: sanction_status
      comment: "Current status of the sanction"
    - name: "effective_year"
      expr: DATE_TRUNC('year', sanction_date)
      comment: "Year the sanction was recorded"
  measures:
    - name: "active_sanction_count"
      expr: COUNT(1)
      comment: "Count of sanctions currently active"
$$;