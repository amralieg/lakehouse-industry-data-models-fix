-- Metric views for domain: risk | Business: Legal | Version: 1 | Generated on: 2026-05-07 14:29:57

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over risk assessments. Tracks inherent vs residual risk scores, financial exposure, treatment effectiveness, and escalation patterns to enable risk appetite governance and prioritisation decisions."
  source: "`legal_ecm`.`risk`.`assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current lifecycle status of the risk assessment (e.g. Draft, Active, Closed) — used to filter in-flight vs completed assessments."
    - name: "risk_domain"
      expr: risk_domain
      comment: "High-level risk domain (e.g. Operational, Legal, Regulatory, Cyber) enabling cross-domain portfolio analysis."
    - name: "risk_treatment_option"
      expr: risk_treatment_option
      comment: "Selected treatment strategy (Accept, Mitigate, Transfer, Avoid) — key dimension for treatment mix analysis."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation tier assigned to the assessment, indicating severity of management attention required."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Applicable regulatory framework (e.g. GDPR, SRA, FCA) for compliance-aligned risk segmentation."
    - name: "inherent_impact_rating"
      expr: inherent_impact_rating
      comment: "Qualitative inherent impact rating (Low/Medium/High/Critical) before controls are applied."
    - name: "residual_impact_rating"
      expr: residual_impact_rating
      comment: "Qualitative residual impact rating after controls — compared against inherent to measure control effectiveness."
    - name: "control_effectiveness_rating"
      expr: control_effectiveness_rating
      comment: "Overall effectiveness rating of controls applied to this assessment."
    - name: "within_appetite"
      expr: within_appetite
      comment: "Boolean flag indicating whether the residual risk falls within the firm's defined risk appetite threshold."
    - name: "is_dpia_required"
      expr: is_dpia_required
      comment: "Flags assessments requiring a Data Protection Impact Assessment under GDPR Article 35."
    - name: "is_lpp_sensitive"
      expr: is_lpp_sensitive
      comment: "Flags assessments involving Legal Professional Privilege-sensitive information."
    - name: "sanctions_flag"
      expr: sanctions_flag
      comment: "Indicates the assessment is linked to a sanctions-related risk, requiring heightened AML/CFT scrutiny."
    - name: "pii_data_involved"
      expr: pii_data_involved
      comment: "Flags assessments where personally identifiable information is in scope, driving data protection obligations."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment creation — enables trend analysis of risk assessment volumes and scores over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which financial exposure is denominated, required for multi-currency portfolio analysis."
    - name: "methodology"
      expr: methodology
      comment: "Risk scoring methodology applied (e.g. ISO 31000, COSO) — ensures comparability across assessments."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of risk assessments. Baseline volume metric for risk portfolio sizing and workload management."
    - name: "assessments_outside_appetite"
      expr: COUNT(CASE WHEN within_appetite = FALSE THEN 1 END)
      comment: "Count of assessments where residual risk exceeds the firm's risk appetite. A rising count signals governance escalation is required."
    - name: "appetite_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN within_appetite = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments breaching risk appetite. Key board-level risk governance KPI — sustained elevation triggers policy review."
    - name: "total_estimated_financial_exposure"
      expr: SUM(CAST(estimated_financial_exposure AS DOUBLE))
      comment: "Aggregate estimated financial exposure across all assessments. Drives capital provisioning, insurance coverage, and risk transfer decisions."
    - name: "avg_inherent_risk_score"
      expr: AVG(CAST(inherent_risk_score AS DOUBLE))
      comment: "Average inherent risk score before controls. Benchmarks the gross risk profile of the portfolio and tracks changes in the threat landscape."
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(residual_risk_score AS DOUBLE))
      comment: "Average residual risk score after controls. The primary indicator of the firm's net risk exposure after mitigation."
    - name: "total_inherent_risk_score"
      expr: SUM(CAST(inherent_risk_score AS DOUBLE))
      comment: "Sum of inherent risk scores across the portfolio — used to size the gross risk burden before control investment."
    - name: "total_residual_risk_score"
      expr: SUM(CAST(residual_risk_score AS DOUBLE))
      comment: "Sum of residual risk scores across the portfolio — used to size the net risk burden after control investment."
    - name: "risk_reduction_amount"
      expr: SUM(inherent_risk_score - residual_risk_score)
      comment: "Aggregate risk score reduction achieved by controls (inherent minus residual). Quantifies the value delivered by the control framework."
    - name: "avg_risk_reduction_per_assessment"
      expr: AVG(inherent_risk_score - residual_risk_score)
      comment: "Average risk score reduction per assessment. Measures typical control effectiveness and guides investment in risk mitigation programmes."
    - name: "dpia_required_count"
      expr: COUNT(CASE WHEN is_dpia_required = TRUE THEN 1 END)
      comment: "Number of assessments requiring a DPIA. Tracks GDPR Article 35 compliance obligations outstanding across the firm."
    - name: "sanctions_flagged_count"
      expr: COUNT(CASE WHEN sanctions_flag = TRUE THEN 1 END)
      comment: "Count of assessments with an active sanctions flag. Directly informs AML/CFT compliance reporting and client onboarding decisions."
    - name: "lpp_sensitive_count"
      expr: COUNT(CASE WHEN is_lpp_sensitive = TRUE THEN 1 END)
      comment: "Count of assessments involving LPP-sensitive matters. Ensures privileged information is appropriately ring-fenced in risk processes."
    - name: "avg_financial_exposure_per_assessment"
      expr: AVG(CAST(estimated_financial_exposure AS DOUBLE))
      comment: "Average financial exposure per risk assessment. Helps prioritise high-value risk items for senior management attention."
    - name: "distinct_matters_assessed"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters with at least one risk assessment. Measures breadth of risk coverage across the active matter portfolio."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and strategic KPI layer over the firm-wide risk register. Tracks risk status, financial exposure, treatment progress, and regulatory reporting obligations to support risk governance and board reporting."
  source: "`legal_ecm`.`risk`.`register`"
  dimensions:
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk entry (e.g. Open, Mitigated, Closed, Escalated) — primary filter for active risk portfolio views."
    - name: "risk_domain"
      expr: risk_domain
      comment: "Risk domain classification enabling portfolio segmentation by operational, legal, regulatory, or cyber risk type."
    - name: "inherent_risk_rating"
      expr: inherent_risk_rating
      comment: "Qualitative inherent risk rating (Low/Medium/High/Critical) before controls — used to size the gross risk portfolio."
    - name: "residual_risk_rating"
      expr: residual_risk_rating
      comment: "Qualitative residual risk rating after controls — the primary risk severity dimension for governance reporting."
    - name: "mitigation_status"
      expr: mitigation_status
      comment: "Status of the mitigation plan (e.g. Not Started, In Progress, Completed) — tracks treatment execution progress."
    - name: "risk_treatment"
      expr: risk_treatment
      comment: "Treatment strategy selected for the risk (Accept, Mitigate, Transfer, Avoid)."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation tier for the risk entry, indicating the management level responsible for oversight."
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Boolean flag indicating whether the risk triggers a mandatory regulatory notification obligation."
    - name: "lpp_applies"
      expr: lpp_applies
      comment: "Flags risks where Legal Professional Privilege applies, restricting disclosure in regulatory or litigation contexts."
    - name: "pii_involved"
      expr: pii_involved
      comment: "Flags risks involving personal data, driving GDPR and data protection compliance obligations."
    - name: "is_exception_approved"
      expr: is_exception_approved
      comment: "Indicates whether a formal risk exception has been approved, enabling exception portfolio monitoring."
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Granular risk sub-classification for detailed portfolio drill-down analysis."
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the risk was first identified — enables trend analysis of new risk emergence over time."
    - name: "source_system"
      expr: source_system
      comment: "Originating system of record for the risk entry, supporting data lineage and audit traceability."
  measures:
    - name: "total_risks"
      expr: COUNT(1)
      comment: "Total number of risks on the register. Baseline portfolio size metric for governance reporting and trend analysis."
    - name: "open_risks"
      expr: COUNT(CASE WHEN risk_status = 'Open' THEN 1 END)
      comment: "Count of currently open risks. The primary operational risk backlog metric — sustained growth signals capacity or control gaps."
    - name: "high_critical_residual_risks"
      expr: COUNT(CASE WHEN residual_risk_rating IN ('High', 'Critical') THEN 1 END)
      comment: "Count of risks with High or Critical residual rating after controls. Board-level KPI for net risk exposure severity."
    - name: "high_critical_residual_risk_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN residual_risk_rating IN ('High', 'Critical') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of register entries with High or Critical residual risk. Tracks whether the firm's control framework is adequately reducing severe risks."
    - name: "total_estimated_financial_exposure"
      expr: SUM(CAST(estimated_financial_exposure AS DOUBLE))
      comment: "Total estimated financial exposure across all register entries. Drives capital provisioning, insurance, and risk transfer strategy."
    - name: "avg_estimated_financial_exposure"
      expr: AVG(CAST(estimated_financial_exposure AS DOUBLE))
      comment: "Average financial exposure per risk entry. Benchmarks typical risk magnitude and identifies outlier high-value risks."
    - name: "regulatory_reporting_obligations"
      expr: COUNT(CASE WHEN regulatory_reporting_required = TRUE THEN 1 END)
      comment: "Count of risks with mandatory regulatory reporting obligations. Tracks compliance notification workload and deadline management."
    - name: "exception_approved_risks"
      expr: COUNT(CASE WHEN is_exception_approved = TRUE THEN 1 END)
      comment: "Count of risks operating under an approved exception. Elevated exception counts signal risk appetite erosion requiring board attention."
    - name: "exception_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_exception_approved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of register entries with approved exceptions. A rising exception rate is a leading indicator of risk appetite drift."
    - name: "mitigation_in_progress_count"
      expr: COUNT(CASE WHEN mitigation_status = 'In Progress' THEN 1 END)
      comment: "Count of risks with active mitigation plans in progress. Tracks treatment execution velocity across the risk portfolio."
    - name: "risks_past_target_closure"
      expr: COUNT(CASE WHEN target_closure_date < CURRENT_DATE AND risk_status != 'Closed' THEN 1 END)
      comment: "Count of open risks that have passed their target closure date. A key operational risk management KPI — overdue risks signal execution failures."
    - name: "pii_risk_count"
      expr: COUNT(CASE WHEN pii_involved = TRUE THEN 1 END)
      comment: "Count of risks involving personal data. Tracks the firm's data protection risk exposure for GDPR compliance governance."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`risk_pi_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Professional indemnity claims KPI layer. Tracks claim volumes, financial reserves, settlement outcomes, and coverage status to support PI insurance management, regulatory reporting, and practice area risk governance."
  source: "`legal_ecm`.`risk`.`pi_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the PI claim (e.g. Open, Settled, Withdrawn, Closed) — primary lifecycle dimension for claims portfolio management."
    - name: "claim_outcome"
      expr: claim_outcome
      comment: "Final outcome of the claim (e.g. Settled, Defended, Withdrawn) — used to analyse resolution patterns and success rates."
    - name: "practice_area"
      expr: practice_area
      comment: "Legal practice area associated with the claim (e.g. Corporate, Litigation, Property) — identifies high-risk practice areas."
    - name: "claimant_type"
      expr: claimant_type
      comment: "Type of claimant (e.g. Individual, Corporate, Regulator) — informs risk profiling and insurance underwriting."
    - name: "claimant_jurisdiction"
      expr: claimant_jurisdiction
      comment: "Jurisdiction in which the claim is brought — critical for multi-jurisdictional PI exposure analysis."
    - name: "claim_currency"
      expr: claim_currency
      comment: "Currency of the claim amount — required for multi-currency financial exposure aggregation."
    - name: "coverage_confirmed"
      expr: coverage_confirmed
      comment: "Boolean indicating whether PI insurance coverage has been confirmed for the claim."
    - name: "lpp_applies"
      expr: lpp_applies
      comment: "Flags claims where Legal Professional Privilege applies, restricting disclosure obligations."
    - name: "pii_data_involved"
      expr: pii_data_involved
      comment: "Flags claims involving personal data breaches, linking PI exposure to data protection obligations."
    - name: "regulatory_report_required"
      expr: regulatory_report_required
      comment: "Indicates whether the claim triggers a mandatory regulatory report (e.g. SRA notification)."
    - name: "adr_method"
      expr: adr_method
      comment: "Alternative dispute resolution method used (e.g. Mediation, Arbitration) — tracks ADR adoption and effectiveness."
    - name: "claim_month"
      expr: DATE_TRUNC('MONTH', claim_date)
      comment: "Month the claim was filed — enables trend analysis of claim frequency and seasonality."
    - name: "ethical_wall_required"
      expr: ethical_wall_required
      comment: "Flags claims requiring an ethical wall, indicating conflict-of-interest risk management obligations."
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of PI claims. Baseline volume metric for PI insurance programme sizing and trend monitoring."
    - name: "open_claims"
      expr: COUNT(CASE WHEN claim_status = 'Open' THEN 1 END)
      comment: "Count of currently open PI claims. Tracks active liability exposure requiring management attention and reserve provisioning."
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total value of all PI claims filed. Primary financial exposure metric for PI insurance programme adequacy assessment."
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total reserves provisioned against PI claims. Tracks financial provisioning adequacy relative to claim exposure."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total amount paid in claim settlements. Measures actual PI loss realisation and informs future premium and reserve strategy."
    - name: "total_defence_costs"
      expr: SUM(CAST(defence_costs_incurred AS DOUBLE))
      comment: "Total defence costs incurred across all PI claims. Tracks the cost of defending claims, a key component of total PI programme cost."
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible amounts across claims. Quantifies the firm's self-insured retention exposure across the claims portfolio."
    - name: "avg_claim_amount"
      expr: AVG(CAST(claim_amount AS DOUBLE))
      comment: "Average PI claim value. Benchmarks typical claim severity and informs minimum indemnity limit adequacy."
    - name: "avg_settlement_amount"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement amount per resolved claim. Tracks settlement efficiency and negotiation outcomes over time."
    - name: "coverage_confirmed_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN coverage_confirmed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims with confirmed PI insurance coverage. A low rate signals coverage gaps requiring urgent insurer engagement."
    - name: "regulatory_report_required_count"
      expr: COUNT(CASE WHEN regulatory_report_required = TRUE THEN 1 END)
      comment: "Count of claims requiring mandatory regulatory reporting. Tracks SRA and other regulatory notification obligations outstanding."
    - name: "settlement_to_reserve_ratio"
      expr: ROUND(SUM(CAST(settlement_amount AS DOUBLE)) / NULLIF(SUM(CAST(reserve_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of actual settlements to provisioned reserves. A ratio above 1.0 indicates under-reserving; below 1.0 indicates over-provisioning."
    - name: "distinct_matters_with_claims"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters that have generated PI claims. Identifies matters with disproportionate PI risk concentration."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`risk_data_breach_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data breach and incident KPI layer. Tracks breach severity, regulatory notification compliance (GDPR 72-hour rule), financial impact, and remediation status to support DPO governance, ICO reporting, and cyber risk management."
  source: "`legal_ecm`.`risk`.`data_breach_incident`"
  dimensions:
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the data breach incident (e.g. Open, Contained, Closed) — primary lifecycle dimension for incident management."
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity classification of the breach (e.g. Low, Medium, High, Critical) — drives escalation and regulatory notification decisions."
    - name: "breach_source"
      expr: breach_source
      comment: "Root cause category of the breach (e.g. Phishing, Insider Threat, System Failure) — informs preventive control investment."
    - name: "affected_system"
      expr: affected_system
      comment: "System or platform affected by the breach — identifies systemic vulnerabilities requiring remediation."
    - name: "ico_notification_status"
      expr: ico_notification_status
      comment: "Status of ICO (Information Commissioner's Office) notification — tracks GDPR Article 33 regulatory compliance."
    - name: "pii_compromised_flag"
      expr: pii_compromised_flag
      comment: "Flags incidents where personal data was compromised, triggering GDPR notification and remediation obligations."
    - name: "special_category_data_flag"
      expr: special_category_data_flag
      comment: "Flags incidents involving GDPR special category data (e.g. health, biometric), which carry heightened regulatory obligations."
    - name: "client_data_flag"
      expr: client_data_flag
      comment: "Indicates whether client data was involved in the breach — critical for client notification and reputational risk management."
    - name: "lpp_protected_data_flag"
      expr: lpp_protected_data_flag
      comment: "Flags incidents involving LPP-protected data, which may restrict disclosure to regulators and third parties."
    - name: "data_subject_notification_required_flag"
      expr: data_subject_notification_required_flag
      comment: "Indicates whether affected data subjects must be notified under GDPR Article 34."
    - name: "forensic_investigation_flag"
      expr: forensic_investigation_flag
      comment: "Flags incidents requiring forensic investigation — tracks the volume and cost of complex breach investigations."
    - name: "insurance_claim_filed_flag"
      expr: insurance_claim_filed_flag
      comment: "Indicates whether a cyber insurance claim has been filed for the incident."
    - name: "discovery_month"
      expr: DATE_TRUNC('MONTH', discovery_date)
      comment: "Month the breach was discovered — enables trend analysis of breach frequency and detection patterns."
    - name: "external_counsel_engaged_flag"
      expr: external_counsel_engaged_flag
      comment: "Flags incidents where external legal counsel was engaged, indicating complexity or regulatory exposure."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of data breach incidents. Baseline volume metric for cyber risk and data protection governance reporting."
    - name: "high_critical_severity_incidents"
      expr: COUNT(CASE WHEN breach_severity IN ('High', 'Critical') THEN 1 END)
      comment: "Count of High or Critical severity breaches. Board-level cyber risk KPI — each incident may trigger regulatory notification and reputational damage."
    - name: "pii_compromised_incidents"
      expr: COUNT(CASE WHEN pii_compromised_flag = TRUE THEN 1 END)
      comment: "Count of incidents where personal data was compromised. Directly drives GDPR notification obligations and regulatory risk exposure."
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial impact across all data breach incidents. Informs cyber insurance adequacy and breach response budget allocation."
    - name: "avg_estimated_financial_impact"
      expr: AVG(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Average financial impact per breach incident. Benchmarks typical breach cost and supports cyber risk quantification models."
    - name: "ico_notification_pending_count"
      expr: COUNT(CASE WHEN ico_notification_status NOT IN ('Notified', 'Not Required') AND pii_compromised_flag = TRUE THEN 1 END)
      comment: "Count of PII-compromised incidents where ICO notification is not yet complete. Tracks GDPR Article 33 compliance risk — each pending notification is a potential regulatory breach."
    - name: "data_subject_notification_required_count"
      expr: COUNT(CASE WHEN data_subject_notification_required_flag = TRUE THEN 1 END)
      comment: "Count of incidents requiring data subject notification under GDPR Article 34. Tracks notification obligation fulfilment workload."
    - name: "special_category_data_incident_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN special_category_data_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents involving GDPR special category data. Elevated rates signal heightened regulatory and reputational risk exposure."
    - name: "client_data_breach_count"
      expr: COUNT(CASE WHEN client_data_flag = TRUE THEN 1 END)
      comment: "Count of incidents involving client data. Directly impacts client trust, contractual obligations, and professional indemnity exposure."
    - name: "forensic_investigation_count"
      expr: COUNT(CASE WHEN forensic_investigation_flag = TRUE THEN 1 END)
      comment: "Count of incidents requiring forensic investigation. Tracks complex breach volume and associated investigation cost burden."
    - name: "insurance_claim_filed_count"
      expr: COUNT(CASE WHEN insurance_claim_filed_flag = TRUE THEN 1 END)
      comment: "Count of incidents where a cyber insurance claim was filed. Tracks insurance utilisation and informs renewal negotiations."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`risk_indemnity_exposure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Professional indemnity exposure KPI layer. Tracks estimated claim values, reserve adequacy, settlement outcomes, and regulatory referral patterns to support PI insurance management and practice risk governance."
  source: "`legal_ecm`.`risk`.`indemnity_exposure`"
  dimensions:
    - name: "exposure_status"
      expr: exposure_status
      comment: "Current status of the indemnity exposure (e.g. Identified, Under Investigation, Settled, Closed)."
    - name: "risk_severity"
      expr: risk_severity
      comment: "Severity classification of the exposure — drives prioritisation and reserve provisioning decisions."
    - name: "practice_area"
      expr: practice_area
      comment: "Legal practice area associated with the exposure — identifies practice areas generating disproportionate PI risk."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification of the exposure (e.g. Negligence, Conflict, Process Failure) — informs preventive action targeting."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction in which the exposure arises — critical for multi-jurisdictional PI programme management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of financial exposure amounts — required for multi-currency portfolio aggregation."
    - name: "lpp_applies_flag"
      expr: lpp_applies_flag
      comment: "Flags exposures where LPP applies, restricting disclosure in regulatory and litigation contexts."
    - name: "reputational_risk_flag"
      expr: reputational_risk_flag
      comment: "Flags exposures with significant reputational risk implications, requiring senior management awareness."
    - name: "regulatory_referral_flag"
      expr: regulatory_referral_flag
      comment: "Indicates whether the exposure has been referred to a regulatory body — tracks regulatory escalation volume."
    - name: "insurer_notified_flag"
      expr: insurer_notified_flag
      comment: "Indicates whether the PI insurer has been notified of the exposure — tracks notification compliance."
    - name: "external_counsel_engaged_flag"
      expr: external_counsel_engaged_flag
      comment: "Flags exposures where external counsel has been engaged, indicating complexity and additional cost."
    - name: "pi_renewal_submission_flag"
      expr: pi_renewal_submission_flag
      comment: "Flags exposures that must be disclosed on the PI insurance renewal submission."
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the exposure was identified — enables trend analysis of new exposure emergence."
  measures:
    - name: "total_exposures"
      expr: COUNT(1)
      comment: "Total number of indemnity exposures identified. Baseline portfolio size metric for PI risk governance."
    - name: "total_estimated_claim_value"
      expr: SUM(CAST(estimated_claim_value AS DOUBLE))
      comment: "Total estimated value of all indemnity exposures. Primary financial metric for PI insurance limit adequacy assessment."
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total reserves provisioned against indemnity exposures. Tracks financial provisioning adequacy relative to estimated claim values."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total amount paid in settlement of indemnity exposures. Measures actual PI loss realisation for insurance and financial reporting."
    - name: "total_excess_amount"
      expr: SUM(CAST(excess_amount AS DOUBLE))
      comment: "Total excess (deductible) amounts across all exposures. Quantifies the firm's self-insured retention burden."
    - name: "avg_estimated_claim_value"
      expr: AVG(CAST(estimated_claim_value AS DOUBLE))
      comment: "Average estimated claim value per exposure. Benchmarks typical exposure severity and informs minimum indemnity limit setting."
    - name: "reserve_to_claim_ratio"
      expr: ROUND(SUM(CAST(reserve_amount AS DOUBLE)) / NULLIF(SUM(CAST(estimated_claim_value AS DOUBLE)), 0), 4)
      comment: "Ratio of total reserves to total estimated claim value. A ratio below 1.0 signals under-provisioning; above 1.0 indicates conservative reserving."
    - name: "regulatory_referral_count"
      expr: COUNT(CASE WHEN regulatory_referral_flag = TRUE THEN 1 END)
      comment: "Count of exposures referred to a regulatory body. Tracks regulatory escalation volume and associated compliance risk."
    - name: "insurer_notification_pending_count"
      expr: COUNT(CASE WHEN insurer_notified_flag = FALSE AND exposure_status NOT IN ('Closed', 'Settled') THEN 1 END)
      comment: "Count of active exposures where the insurer has not yet been notified. Tracks notification compliance — late notification can void coverage."
    - name: "reputational_risk_exposure_count"
      expr: COUNT(CASE WHEN reputational_risk_flag = TRUE THEN 1 END)
      comment: "Count of exposures with reputational risk implications. Tracks the volume of matters requiring senior management and communications oversight."
    - name: "pi_renewal_disclosure_count"
      expr: COUNT(CASE WHEN pi_renewal_submission_flag = TRUE THEN 1 END)
      comment: "Count of exposures requiring disclosure on the PI renewal submission. Directly informs the annual PI insurance renewal process."
    - name: "distinct_matters_with_exposure"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters with indemnity exposures. Identifies matters with concentrated PI risk for targeted risk management."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`risk_mitigation_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk mitigation action KPI layer. Tracks action completion rates, cost efficiency, overdue actions, and escalation patterns to support risk treatment execution governance and control effectiveness reporting."
  source: "`legal_ecm`.`risk`.`mitigation_action`"
  dimensions:
    - name: "action_status"
      expr: action_status
      comment: "Current status of the mitigation action (e.g. Not Started, In Progress, Completed, Overdue) — primary lifecycle dimension."
    - name: "completion_status"
      expr: completion_status
      comment: "Completion status of the action — used to distinguish fully completed actions from those partially or nominally closed."
    - name: "action_type"
      expr: action_type
      comment: "Type of mitigation action (e.g. Control Enhancement, Process Change, Training, Technology) — informs treatment mix analysis."
    - name: "action_priority"
      expr: action_priority
      comment: "Priority level of the action (e.g. Critical, High, Medium, Low) — drives resource allocation and scheduling decisions."
    - name: "control_effectiveness_rating"
      expr: control_effectiveness_rating
      comment: "Effectiveness rating of the control associated with the mitigation action — measures treatment quality outcomes."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework the action is designed to address — enables compliance-aligned treatment tracking."
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Flags actions with mandatory regulatory reporting obligations."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Boolean indicating whether the action requires escalation to senior management."
    - name: "lpp_applies"
      expr: lpp_applies
      comment: "Flags actions involving LPP-sensitive matters, restricting certain disclosure obligations."
    - name: "pii_involved"
      expr: pii_involved
      comment: "Flags actions involving personal data, driving data protection compliance requirements."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which action costs are denominated."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the action is due — enables forward-looking workload planning and overdue trend analysis."
    - name: "action_owner_name"
      expr: action_owner_name
      comment: "Name of the individual responsible for the action — enables accountability and workload distribution analysis."
  measures:
    - name: "total_actions"
      expr: COUNT(1)
      comment: "Total number of mitigation actions. Baseline metric for risk treatment workload sizing and programme management."
    - name: "completed_actions"
      expr: COUNT(CASE WHEN action_status = 'Completed' THEN 1 END)
      comment: "Count of completed mitigation actions. Tracks risk treatment execution progress across the portfolio."
    - name: "action_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN action_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mitigation actions completed. Primary KPI for risk treatment programme effectiveness — low rates signal execution gaps."
    - name: "overdue_actions"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE AND action_status != 'Completed' THEN 1 END)
      comment: "Count of mitigation actions past their due date and not yet completed. A critical operational risk KPI — overdue actions leave risks unmitigated."
    - name: "overdue_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN due_date < CURRENT_DATE AND action_status != 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of actions that are overdue. Tracks execution discipline — sustained elevation requires programme intervention."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred on mitigation actions. Tracks risk treatment spend against budget for financial governance."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all mitigation actions. Enables budget planning and cost-benefit analysis of the risk treatment programme."
    - name: "cost_variance"
      expr: SUM(actual_cost - estimated_cost)
      comment: "Aggregate cost variance (actual minus estimated) across all actions. Positive values indicate cost overruns in the risk treatment programme."
    - name: "avg_actual_effort_hours"
      expr: AVG(CAST(actual_effort_hours AS DOUBLE))
      comment: "Average actual effort hours per mitigation action. Benchmarks resource intensity and informs future capacity planning."
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total actual effort hours expended on mitigation actions. Tracks the human capital investment in risk treatment across the portfolio."
    - name: "escalation_required_count"
      expr: COUNT(CASE WHEN escalation_required = TRUE THEN 1 END)
      comment: "Count of actions requiring escalation. Tracks the volume of risk treatment issues requiring senior management intervention."
    - name: "residual_reassessment_required_count"
      expr: COUNT(CASE WHEN residual_risk_reassessment_required = TRUE THEN 1 END)
      comment: "Count of actions requiring a residual risk reassessment post-completion. Tracks the pipeline of follow-on risk reviews needed to validate treatment effectiveness."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`risk_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk control effectiveness KPI layer. Tracks control design and operational effectiveness, testing outcomes, remediation status, and regulatory relevance to support the firm's control framework governance and ISO/GDPR compliance reporting."
  source: "`legal_ecm`.`risk`.`risk_control`"
  dimensions:
    - name: "control_type"
      expr: control_type
      comment: "Type of control (e.g. Preventive, Detective, Corrective) — fundamental dimension for control framework analysis."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Current implementation status of the control (e.g. Planned, Implemented, Decommissioned)."
    - name: "design_effectiveness_rating"
      expr: design_effectiveness_rating
      comment: "Rating of how well the control is designed to mitigate the target risk — a key control quality dimension."
    - name: "operational_effectiveness_rating"
      expr: operational_effectiveness_rating
      comment: "Rating of how effectively the control operates in practice — the primary control performance dimension."
    - name: "last_test_outcome"
      expr: last_test_outcome
      comment: "Outcome of the most recent control test (e.g. Pass, Fail, Partial) — drives remediation prioritisation."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of any remediation activity for deficient controls — tracks control improvement pipeline."
    - name: "domain"
      expr: domain
      comment: "Risk domain the control addresses (e.g. Cyber, Operational, Legal) — enables domain-level control coverage analysis."
    - name: "gdpr_relevant_flag"
      expr: gdpr_relevant_flag
      comment: "Flags controls relevant to GDPR compliance — enables data protection control coverage reporting."
    - name: "sra_reportable_flag"
      expr: sra_reportable_flag
      comment: "Flags controls subject to SRA (Solicitors Regulation Authority) reporting — tracks regulatory control obligations."
    - name: "lpp_scope_flag"
      expr: lpp_scope_flag
      comment: "Flags controls within the scope of Legal Professional Privilege protection."
    - name: "pii_scope_flag"
      expr: pii_scope_flag
      comment: "Flags controls within the scope of personal data protection obligations."
    - name: "automation_flag"
      expr: automation_flag
      comment: "Indicates whether the control is automated — automated controls typically have higher reliability and lower operational cost."
    - name: "remediation_required_flag"
      expr: remediation_required_flag
      comment: "Flags controls with identified deficiencies requiring remediation — primary filter for control improvement workload."
    - name: "iso_soa_included_flag"
      expr: iso_soa_included_flag
      comment: "Indicates whether the control is included in the ISO 27001 Statement of Applicability — tracks ISO certification scope."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the control — drives remediation sequencing and resource allocation."
  measures:
    - name: "total_controls"
      expr: COUNT(1)
      comment: "Total number of risk controls in the control framework. Baseline metric for control inventory management."
    - name: "implemented_controls"
      expr: COUNT(CASE WHEN implementation_status = 'Implemented' THEN 1 END)
      comment: "Count of fully implemented controls. Tracks control framework deployment completeness."
    - name: "control_implementation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN implementation_status = 'Implemented' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controls that are fully implemented. Key control framework maturity KPI for board and regulatory reporting."
    - name: "controls_failing_last_test"
      expr: COUNT(CASE WHEN last_test_outcome = 'Fail' THEN 1 END)
      comment: "Count of controls that failed their most recent test. Directly identifies control weaknesses requiring immediate remediation."
    - name: "control_test_failure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN last_test_outcome = 'Fail' THEN 1 END) / NULLIF(COUNT(CASE WHEN last_test_outcome IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of tested controls that failed. A rising failure rate signals systemic control degradation requiring programme-level intervention."
    - name: "controls_requiring_remediation"
      expr: COUNT(CASE WHEN remediation_required_flag = TRUE THEN 1 END)
      comment: "Count of controls with identified deficiencies requiring remediation. Tracks the control improvement backlog."
    - name: "remediation_backlog_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN remediation_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controls with outstanding remediation requirements. Elevated rates indicate systemic control framework weaknesses."
    - name: "automated_control_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN automation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controls that are automated. Higher automation rates correlate with greater control reliability and lower operational cost."
    - name: "gdpr_relevant_controls"
      expr: COUNT(CASE WHEN gdpr_relevant_flag = TRUE THEN 1 END)
      comment: "Count of controls relevant to GDPR compliance. Tracks the breadth of the data protection control framework."
    - name: "sra_reportable_controls"
      expr: COUNT(CASE WHEN sra_reportable_flag = TRUE THEN 1 END)
      comment: "Count of controls subject to SRA reporting obligations. Tracks regulatory control coverage for SRA compliance purposes."
    - name: "controls_overdue_for_review"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE AND implementation_status = 'Implemented' THEN 1 END)
      comment: "Count of implemented controls past their scheduled review date. Overdue reviews create undetected control drift and regulatory exposure."
    - name: "iso_soa_coverage_count"
      expr: COUNT(CASE WHEN iso_soa_included_flag = TRUE THEN 1 END)
      comment: "Count of controls included in the ISO 27001 Statement of Applicability. Tracks ISO certification scope and coverage completeness."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`risk_matter_risk_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Matter-level risk profile KPI layer. Tracks overall risk tier distribution, financial exposure, AML/sanctions screening, and escalation patterns across the active matter portfolio to support client risk governance and regulatory compliance."
  source: "`legal_ecm`.`risk`.`matter_risk_profile`"
  dimensions:
    - name: "overall_risk_tier"
      expr: overall_risk_tier
      comment: "Overall risk tier assigned to the matter (e.g. Low, Medium, High, Critical) — primary risk segmentation dimension for portfolio governance."
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the matter risk profile (e.g. Active, Under Review, Closed)."
    - name: "matter_complexity_rating"
      expr: matter_complexity_rating
      comment: "Complexity rating of the matter — correlates with risk exposure and resource requirements."
    - name: "jurisdictional_risk_level"
      expr: jurisdictional_risk_level
      comment: "Risk level associated with the matter's primary jurisdiction — critical for cross-border and sanctions risk analysis."
    - name: "primary_jurisdiction"
      expr: primary_jurisdiction
      comment: "Primary jurisdiction of the matter — enables geographic risk concentration analysis."
    - name: "aml_risk_flag"
      expr: aml_risk_flag
      comment: "Flags matters with identified AML risk — drives enhanced due diligence and regulatory reporting obligations."
    - name: "cross_border_flag"
      expr: cross_border_flag
      comment: "Indicates cross-border matters, which carry elevated jurisdictional, sanctions, and regulatory risk."
    - name: "sanctions_screening_required_flag"
      expr: sanctions_screening_required_flag
      comment: "Flags matters requiring sanctions screening — tracks AML/CFT compliance obligations."
    - name: "special_category_data_flag"
      expr: special_category_data_flag
      comment: "Flags matters involving GDPR special category data, driving heightened data protection obligations."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Indicates whether the matter risk profile has been escalated to senior management."
    - name: "insurance_notification_required_flag"
      expr: insurance_notification_required_flag
      comment: "Flags matters requiring PI insurance notification — tracks notification compliance obligations."
    - name: "regulatory_scrutiny_level"
      expr: regulatory_scrutiny_level
      comment: "Level of regulatory scrutiny applied to the matter — informs compliance monitoring intensity."
    - name: "reputational_risk_rating"
      expr: reputational_risk_rating
      comment: "Reputational risk rating for the matter — tracks matters with potential media or public interest exposure."
    - name: "profile_created_month"
      expr: DATE_TRUNC('MONTH', profile_created_date)
      comment: "Month the risk profile was created — enables trend analysis of new matter risk onboarding."
    - name: "lpp_sensitivity_level"
      expr: lpp_sensitivity_level
      comment: "LPP sensitivity level of the matter — drives information barrier and disclosure management decisions."
  measures:
    - name: "total_matter_risk_profiles"
      expr: COUNT(1)
      comment: "Total number of matter risk profiles. Baseline metric for risk-profiled matter portfolio sizing."
    - name: "high_critical_risk_matters"
      expr: COUNT(CASE WHEN overall_risk_tier IN ('High', 'Critical') THEN 1 END)
      comment: "Count of matters with High or Critical overall risk tier. Primary portfolio risk concentration KPI for senior management reporting."
    - name: "high_critical_risk_matter_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_risk_tier IN ('High', 'Critical') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of matters rated High or Critical risk. Tracks risk concentration in the active matter portfolio — rising rates signal portfolio risk escalation."
    - name: "total_estimated_matter_value"
      expr: SUM(CAST(estimated_matter_value AS DOUBLE))
      comment: "Total estimated value of all risk-profiled matters. Quantifies the financial scale of the risk-exposed matter portfolio."
    - name: "avg_estimated_matter_value"
      expr: AVG(CAST(estimated_matter_value AS DOUBLE))
      comment: "Average estimated matter value. Benchmarks typical matter size and identifies high-value matters requiring enhanced risk oversight."
    - name: "aml_risk_matter_count"
      expr: COUNT(CASE WHEN aml_risk_flag = TRUE THEN 1 END)
      comment: "Count of matters with identified AML risk. Tracks the AML-sensitive matter portfolio requiring enhanced due diligence."
    - name: "aml_risk_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN aml_risk_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of matters with AML risk flags. A rising rate signals increased exposure to money laundering risk across the client portfolio."
    - name: "cross_border_matter_count"
      expr: COUNT(CASE WHEN cross_border_flag = TRUE THEN 1 END)
      comment: "Count of cross-border matters. Tracks jurisdictional complexity and associated sanctions/regulatory risk exposure."
    - name: "escalated_matter_count"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END)
      comment: "Count of matters requiring risk escalation. Tracks the volume of matters demanding senior management attention."
    - name: "insurance_notification_pending_count"
      expr: COUNT(CASE WHEN insurance_notification_required_flag = TRUE THEN 1 END)
      comment: "Count of matters requiring PI insurance notification. Tracks notification compliance obligations — late notification can void coverage."
    - name: "avg_esi_volume_gb"
      expr: AVG(CAST(esi_volume_gb AS DOUBLE))
      comment: "Average electronically stored information volume in GB per matter. Tracks e-discovery cost exposure and data management risk across the portfolio."
    - name: "total_esi_volume_gb"
      expr: SUM(CAST(esi_volume_gb AS DOUBLE))
      comment: "Total ESI volume in GB across all risk-profiled matters. Quantifies the firm's aggregate e-discovery data burden and associated cost risk."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`risk_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk category taxonomy KPI layer. Tracks risk appetite thresholds, inherent vs residual risk scores by category, regulatory reporting obligations, and category coverage to support risk framework governance and appetite-setting decisions."
  source: "`legal_ecm`.`risk`.`category`"
  dimensions:
    - name: "risk_type"
      expr: risk_type
      comment: "Type of risk (e.g. Operational, Legal, Regulatory, Cyber, Financial) — top-level taxonomy dimension."
    - name: "risk_domain"
      expr: risk_domain
      comment: "Risk domain classification — enables cross-domain risk framework analysis."
    - name: "risk_appetite_level"
      expr: risk_appetite_level
      comment: "Defined risk appetite level for the category (e.g. Zero Tolerance, Low, Moderate) — the governance anchor for risk acceptance decisions."
    - name: "category_status"
      expr: category_status
      comment: "Current status of the risk category (e.g. Active, Deprecated) — filters the active taxonomy."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the risk category hierarchy — enables parent/child taxonomy navigation."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework associated with the category — enables compliance-aligned risk taxonomy analysis."
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Flags categories with mandatory regulatory reporting obligations."
    - name: "aml_relevance_flag"
      expr: aml_relevance_flag
      comment: "Flags categories relevant to AML risk — tracks AML taxonomy coverage."
    - name: "cybersecurity_relevance_flag"
      expr: cybersecurity_relevance_flag
      comment: "Flags categories relevant to cybersecurity risk — tracks cyber taxonomy coverage."
    - name: "pii_relevance_flag"
      expr: pii_relevance_flag
      comment: "Flags categories relevant to personal data risk — tracks data protection taxonomy coverage."
    - name: "professional_indemnity_flag"
      expr: professional_indemnity_flag
      comment: "Flags categories relevant to professional indemnity risk — tracks PI taxonomy coverage."
    - name: "lpp_relevance_flag"
      expr: lpp_relevance_flag
      comment: "Flags categories relevant to Legal Professional Privilege — tracks LPP taxonomy coverage."
    - name: "risk_impact_rating"
      expr: risk_impact_rating
      comment: "Default impact rating for the category — used to benchmark category-level risk severity."
    - name: "applicable_jurisdiction"
      expr: applicable_jurisdiction
      comment: "Jurisdiction(s) to which the risk category applies — enables jurisdictional taxonomy analysis."
  measures:
    - name: "total_categories"
      expr: COUNT(1)
      comment: "Total number of risk categories in the taxonomy. Tracks risk framework breadth and taxonomy completeness."
    - name: "active_categories"
      expr: COUNT(CASE WHEN category_status = 'Active' THEN 1 END)
      comment: "Count of active risk categories. Measures the current operational scope of the risk taxonomy."
    - name: "total_risk_appetite_threshold"
      expr: SUM(CAST(risk_appetite_threshold AS DOUBLE))
      comment: "Sum of risk appetite thresholds across all categories. Provides an aggregate view of the firm's total risk tolerance envelope."
    - name: "avg_inherent_risk_score"
      expr: AVG(CAST(inherent_risk_score AS DOUBLE))
      comment: "Average inherent risk score across categories. Benchmarks the gross risk profile of the taxonomy and identifies high-inherent-risk domains."
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(residual_risk_score AS DOUBLE))
      comment: "Average residual risk score across categories. Measures the net risk profile of the taxonomy after control application."
    - name: "avg_risk_reduction_by_category"
      expr: AVG(inherent_risk_score - residual_risk_score)
      comment: "Average risk score reduction (inherent minus residual) across categories. Measures the typical effectiveness of controls at the category level."
    - name: "categories_requiring_regulatory_reporting"
      expr: COUNT(CASE WHEN regulatory_reporting_required = TRUE THEN 1 END)
      comment: "Count of risk categories with mandatory regulatory reporting obligations. Tracks the regulatory reporting burden embedded in the risk taxonomy."
    - name: "aml_relevant_category_count"
      expr: COUNT(CASE WHEN aml_relevance_flag = TRUE THEN 1 END)
      comment: "Count of risk categories relevant to AML. Tracks AML risk taxonomy coverage for MLRO governance reporting."
    - name: "cyber_relevant_category_count"
      expr: COUNT(CASE WHEN cybersecurity_relevance_flag = TRUE THEN 1 END)
      comment: "Count of risk categories relevant to cybersecurity. Tracks cyber risk taxonomy coverage for CISO governance reporting."
    - name: "categories_overdue_for_review"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE AND category_status = 'Active' THEN 1 END)
      comment: "Count of active risk categories past their scheduled review date. Overdue category reviews create stale risk appetite thresholds and governance gaps."
$$;