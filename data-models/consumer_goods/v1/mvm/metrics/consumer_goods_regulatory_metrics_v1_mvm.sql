-- Metric views for domain: regulatory | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 10:59:38

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`regulatory_compliance_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks the health and outcomes of regulatory compliance assessments across jurisdictions, suppliers, SKUs, and facilities. Enables leadership to monitor compliance posture, corrective action backlog, and risk exposure."
  source: "`consumer_goods_ecm`.`regulatory`.`compliance_assessment`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the assessment (e.g., Compliant, Non-Compliant, Pending). Primary grouping for compliance posture analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the assessment (e.g., High, Medium, Low). Used to prioritize remediation and escalation."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of compliance assessment performed (e.g., Audit, Self-Assessment, Third-Party). Helps segment assessment coverage."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework under which the assessment was conducted (e.g., EU Cosmetics Regulation, FDA, REACH). Enables framework-level compliance tracking."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority that mandated or oversees the assessment. Used for authority-level compliance reporting."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean flag indicating whether a corrective action was required as a result of the assessment. Key filter for remediation tracking."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Current status of the corrective action (e.g., Open, In Progress, Closed). Tracks remediation pipeline."
    - name: "assessment_method"
      expr: assessment_method
      comment: "Method used to conduct the assessment (e.g., Document Review, On-Site Audit). Provides context for assessment quality."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month in which the assessment was conducted. Enables trend analysis of compliance activity over time."
    - name: "corrective_action_due_month"
      expr: DATE_TRUNC('MONTH', corrective_action_due_date)
      comment: "Month in which corrective actions are due. Used to forecast and manage remediation deadlines."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of compliance assessments conducted. Baseline measure for assessment volume and coverage tracking."
    - name: "non_compliant_assessments"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of assessments resulting in a non-compliant finding. Critical KPI for regulatory risk exposure — a rising count triggers immediate executive escalation."
    - name: "compliant_assessments"
      expr: COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END)
      comment: "Number of assessments with a compliant outcome. Used as the numerator for compliance pass rate calculation in BI."
    - name: "open_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE AND corrective_action_status NOT IN ('Closed', 'Completed') THEN 1 END)
      comment: "Number of assessments with open corrective actions. Directly measures remediation backlog — a key operational risk KPI for regulatory leadership."
    - name: "high_risk_non_compliant_assessments"
      expr: COUNT(CASE WHEN risk_level = 'High' AND compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of high-risk assessments with non-compliant findings. The most critical leading indicator of regulatory enforcement exposure."
    - name: "distinct_skus_assessed"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs covered by compliance assessments. Measures breadth of compliance coverage across the product portfolio."
    - name: "distinct_suppliers_assessed"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers assessed for compliance. Tracks supplier compliance program coverage."
    - name: "distinct_jurisdictions_assessed"
      expr: COUNT(DISTINCT jurisdiction_id)
      comment: "Number of distinct jurisdictions covered by assessments. Measures geographic compliance program reach."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`regulatory_compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors the portfolio of regulatory compliance obligations — their status, cost, deadlines, and risk levels. Enables finance and regulatory leadership to manage compliance spend, prioritize obligations, and avoid penalties."
  source: "`consumer_goods_ecm`.`regulatory`.`compliance_obligation`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the obligation (e.g., Compliant, Non-Compliant, In Progress). Primary dimension for obligation health monitoring."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (e.g., Registration, Labeling, Testing, Reporting). Enables obligation portfolio segmentation."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the obligation (e.g., High, Medium, Low). Used to prioritize compliance investment and escalation."
    - name: "priority"
      expr: priority
      comment: "Business priority assigned to the obligation. Supports resource allocation decisions."
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory governing body responsible for the obligation (e.g., FDA, EMA, CPSC). Enables authority-level obligation tracking."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Internal department responsible for fulfilling the obligation. Supports accountability and workload distribution analysis."
    - name: "applicable_product_category"
      expr: applicable_product_category
      comment: "Product category to which the obligation applies. Enables category-level compliance obligation analysis."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the obligation is currently active. Used to filter active vs. archived obligations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which compliance costs are denominated. Required for multi-currency cost aggregation context."
    - name: "compliance_deadline_month"
      expr: DATE_TRUNC('MONTH', compliance_deadline)
      comment: "Month of the compliance deadline. Enables deadline pipeline and capacity planning analysis."
    - name: "next_renewal_month"
      expr: DATE_TRUNC('MONTH', next_renewal_date)
      comment: "Month of the next renewal date. Used to forecast upcoming compliance renewal workload."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of compliance obligations in the portfolio. Baseline measure for obligation volume and scope."
    - name: "active_obligations"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active compliance obligations. Measures the live regulatory burden on the organization."
    - name: "non_compliant_obligations"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of obligations currently in non-compliant status. A critical risk KPI — each non-compliant obligation represents potential regulatory penalty exposure."
    - name: "high_risk_obligations"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of high-risk compliance obligations. Used by regulatory leadership to prioritize remediation investment."
    - name: "total_estimated_compliance_cost"
      expr: SUM(CAST(estimated_compliance_cost AS DOUBLE))
      comment: "Total estimated cost to fulfill all compliance obligations. Key financial KPI for regulatory budget planning and CFO reporting."
    - name: "avg_estimated_compliance_cost"
      expr: AVG(CAST(estimated_compliance_cost AS DOUBLE))
      comment: "Average estimated compliance cost per obligation. Benchmarks cost efficiency and identifies outlier obligations driving disproportionate spend."
    - name: "obligations_past_deadline"
      expr: COUNT(CASE WHEN compliance_deadline < CURRENT_DATE() AND compliance_status != 'Compliant' THEN 1 END)
      comment: "Number of obligations past their compliance deadline and not yet compliant. Directly measures overdue regulatory exposure — a board-level risk indicator."
    - name: "obligations_due_next_30_days"
      expr: COUNT(CASE WHEN compliance_deadline BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN 1 END)
      comment: "Number of compliance obligations due within the next 30 days. Operational urgency KPI for regulatory team capacity planning."
    - name: "distinct_governing_bodies"
      expr: COUNT(DISTINCT governing_body)
      comment: "Number of distinct regulatory governing bodies with active obligations. Measures the breadth of regulatory authority relationships."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`regulatory_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks the lifecycle and financial profile of product registrations across jurisdictions and markets. Enables regulatory and commercial leadership to manage registration coverage, renewal risk, and registration fees."
  source: "`consumer_goods_ecm`.`regulatory`.`registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the registration (e.g., Active, Expired, Pending, Withdrawn). Primary dimension for registration portfolio health."
    - name: "registration_type"
      expr: registration_type
      comment: "Type of registration (e.g., Product, Facility, Ingredient). Enables segmentation of the registration portfolio by type."
    - name: "registration_category"
      expr: registration_category
      comment: "Regulatory category of the registration (e.g., Cosmetic, OTC Drug, Biocide). Supports category-level portfolio analysis."
    - name: "registering_authority"
      expr: registering_authority
      comment: "Regulatory authority with which the product is registered. Enables authority-level registration tracking."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Boolean flag indicating GMP compliance status of the registration. Used to filter GMP-compliant registrations for quality reporting."
    - name: "fee_currency_code"
      expr: fee_currency_code
      comment: "Currency of the registration fee. Required for multi-currency fee aggregation context."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year of registration approval. Enables cohort analysis of registration approvals over time."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of registration expiry. Critical for renewal pipeline management and avoiding lapses in market authorization."
    - name: "renewal_due_month"
      expr: DATE_TRUNC('MONTH', renewal_due_date)
      comment: "Month when registration renewal is due. Used for proactive renewal workload forecasting."
  measures:
    - name: "total_registrations"
      expr: COUNT(1)
      comment: "Total number of product registrations. Baseline measure for registration portfolio size and market coverage."
    - name: "active_registrations"
      expr: COUNT(CASE WHEN registration_status = 'Active' THEN 1 END)
      comment: "Number of currently active registrations. Measures the live authorized market footprint of the product portfolio."
    - name: "expired_registrations"
      expr: COUNT(CASE WHEN registration_status = 'Expired' THEN 1 END)
      comment: "Number of expired registrations. Indicates potential market access gaps — a critical commercial and regulatory risk KPI."
    - name: "registrations_expiring_next_90_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND registration_status = 'Active' THEN 1 END)
      comment: "Number of active registrations expiring within 90 days. Forward-looking risk KPI for renewal prioritization and resource allocation."
    - name: "total_registration_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total registration fees across all registrations. Key financial KPI for regulatory budget management and cost-of-market-access reporting."
    - name: "avg_registration_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average registration fee per registration. Benchmarks cost efficiency and identifies high-cost jurisdictions or categories."
    - name: "distinct_skus_registered"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with at least one registration. Measures the breadth of the registered product portfolio."
    - name: "distinct_jurisdictions_registered"
      expr: COUNT(DISTINCT jurisdiction_id)
      comment: "Number of distinct jurisdictions where products are registered. Measures geographic market authorization coverage."
    - name: "gmp_compliant_registrations"
      expr: COUNT(CASE WHEN gmp_compliance_flag = TRUE THEN 1 END)
      comment: "Number of registrations with GMP compliance confirmed. Measures quality compliance coverage across the registration portfolio."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures the volume, cycle time, outcomes, and financial profile of regulatory submissions. Enables regulatory affairs leadership to track submission throughput, approval rates, and fee spend."
  source: "`consumer_goods_ecm`.`regulatory`.`submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission (e.g., Submitted, Approved, Rejected, Pending). Primary dimension for submission pipeline health."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (e.g., New Product, Renewal, Variation, Adverse Event). Enables submission portfolio segmentation."
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Outcome of the regulatory decision (e.g., Approved, Rejected, Withdrawn). Key dimension for approval rate analysis."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority to which the submission was made. Enables authority-level submission performance benchmarking."
    - name: "priority"
      expr: priority
      comment: "Priority level of the submission (e.g., High, Standard). Used to segment submission pipeline by urgency."
    - name: "channel"
      expr: channel
      comment: "Submission channel used (e.g., Electronic, Paper, Portal). Tracks modernization of submission processes."
    - name: "fee_currency_code"
      expr: fee_currency_code
      comment: "Currency of the submission fee. Required for multi-currency fee aggregation context."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission. Enables trend analysis of submission activity and throughput over time."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', actual_decision_date)
      comment: "Month of the regulatory decision. Used to track decision throughput and approval timelines."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions. Baseline measure for submission volume and regulatory affairs workload."
    - name: "approved_submissions"
      expr: COUNT(CASE WHEN decision_outcome = 'Approved' THEN 1 END)
      comment: "Number of submissions that received regulatory approval. Numerator for approval rate calculation — a core regulatory affairs KPI."
    - name: "rejected_submissions"
      expr: COUNT(CASE WHEN decision_outcome = 'Rejected' THEN 1 END)
      comment: "Number of submissions rejected by regulatory authorities. Tracks quality of submission packages and authority relationship health."
    - name: "pending_submissions"
      expr: COUNT(CASE WHEN submission_status = 'Submitted' AND decision_outcome IS NULL THEN 1 END)
      comment: "Number of submissions awaiting a regulatory decision. Measures the active submission pipeline and pending market access."
    - name: "total_submission_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees paid for regulatory submissions. Key financial KPI for regulatory affairs budget management."
    - name: "avg_submission_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average fee per submission. Benchmarks submission cost efficiency across authorities and submission types."
    - name: "submissions_with_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of submissions requiring corrective action. Indicates submission quality issues and rework burden on the regulatory team."
    - name: "distinct_skus_submitted"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with regulatory submissions. Measures the breadth of the active submission program."
    - name: "distinct_jurisdictions_submitted"
      expr: COUNT(DISTINCT jurisdiction_id)
      comment: "Number of distinct jurisdictions with active submissions. Measures geographic regulatory engagement breadth."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`regulatory_product_recall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks the scope, financial impact, and effectiveness of product recalls. Enables executive leadership to monitor recall risk, recovery performance, and financial exposure — one of the highest-stakes regulatory KPIs in consumer goods."
  source: "`consumer_goods_ecm`.`regulatory`.`product_recall`"
  dimensions:
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall (e.g., Active, Completed, Terminated). Primary dimension for recall portfolio monitoring."
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (e.g., Voluntary, Mandatory, Market Withdrawal). Distinguishes regulatory-mandated from proactive recalls."
    - name: "recall_classification"
      expr: recall_classification
      comment: "Regulatory classification of the recall (e.g., Class I, Class II, Class III). Directly indicates severity and consumer risk level."
    - name: "recall_reason_code"
      expr: recall_reason_code
      comment: "Coded reason for the recall (e.g., Contamination, Labeling Error, Safety Defect). Enables root cause trend analysis."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority overseeing the recall. Used for authority-level recall reporting."
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Boolean flag indicating whether the recall was mandated by a regulatory authority. Distinguishes voluntary from forced recalls."
    - name: "recall_scope"
      expr: recall_scope
      comment: "Geographic or channel scope of the recall (e.g., National, Regional, Global). Measures recall breadth."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which financial impact is denominated. Required for multi-currency financial aggregation context."
    - name: "recall_initiation_month"
      expr: DATE_TRUNC('MONTH', recall_initiation_date)
      comment: "Month the recall was initiated. Enables trend analysis of recall frequency over time."
  measures:
    - name: "total_recalls"
      expr: COUNT(1)
      comment: "Total number of product recalls. Baseline measure for recall frequency — a key product safety and brand risk KPI."
    - name: "active_recalls"
      expr: COUNT(CASE WHEN recall_status = 'Active' THEN 1 END)
      comment: "Number of currently active recalls. Measures live consumer safety exposure and operational recall management burden."
    - name: "mandatory_recalls"
      expr: COUNT(CASE WHEN regulatory_mandate_flag = TRUE THEN 1 END)
      comment: "Number of recalls mandated by regulatory authorities. Tracks forced regulatory interventions — a critical brand and compliance risk indicator."
    - name: "total_units_recalled"
      expr: SUM(CAST(quantity_recalled_units AS DOUBLE))
      comment: "Total units recalled across all recall events. Measures the scale of product safety exposure and supply chain disruption."
    - name: "total_units_recovered"
      expr: SUM(CAST(quantity_recovered_units AS DOUBLE))
      comment: "Total units recovered from the market. Numerator for recall effectiveness rate — measures consumer protection program performance."
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact_amount AS DOUBLE))
      comment: "Total estimated financial impact of all recalls. Critical CFO and board-level KPI for recall cost exposure and insurance provisioning."
    - name: "avg_recall_effectiveness_percentage"
      expr: AVG(CAST(recall_effectiveness_percentage AS DOUBLE))
      comment: "Average recall effectiveness percentage across all recalls. Measures how successfully recalled products are being recovered from the market — a key consumer safety KPI."
    - name: "class_one_recalls"
      expr: COUNT(CASE WHEN recall_classification = 'Class I' THEN 1 END)
      comment: "Number of Class I (most severe) recalls. The highest-priority safety KPI — Class I recalls indicate serious health hazard risk and trigger immediate executive action."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`regulatory_dossier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors the completeness, status, and lifecycle of regulatory dossiers supporting product registrations and submissions. Enables regulatory affairs teams to track dossier readiness and identify gaps blocking market authorization."
  source: "`consumer_goods_ecm`.`regulatory`.`dossier`"
  dimensions:
    - name: "dossier_status"
      expr: dossier_status
      comment: "Current status of the dossier (e.g., Draft, Submitted, Approved, Expired). Primary dimension for dossier pipeline health."
    - name: "dossier_type"
      expr: dossier_type
      comment: "Type of dossier (e.g., Product Information File, Technical Dossier, Safety Assessment). Enables dossier portfolio segmentation."
    - name: "completeness_status"
      expr: completeness_status
      comment: "Qualitative completeness status of the dossier (e.g., Complete, Incomplete, Partial). Used to identify dossiers blocking submission."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority for which the dossier was compiled. Enables authority-level dossier coverage analysis."
    - name: "regulatory_category"
      expr: regulatory_category
      comment: "Regulatory product category of the dossier (e.g., Cosmetic, OTC, Biocide). Supports category-level dossier portfolio management."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Boolean flag indicating GMP compliance inclusion in the dossier. Used to filter GMP-ready dossiers."
    - name: "safety_assessment_included"
      expr: safety_assessment_included
      comment: "Boolean flag indicating whether a safety assessment is included in the dossier. Critical for EU Cosmetics Regulation compliance readiness."
    - name: "owning_team"
      expr: owning_team
      comment: "Internal team responsible for the dossier. Supports workload distribution and accountability analysis."
    - name: "compilation_month"
      expr: DATE_TRUNC('MONTH', compilation_date)
      comment: "Month the dossier was compiled. Enables trend analysis of dossier production throughput."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the dossier expires. Used for proactive dossier renewal planning."
  measures:
    - name: "total_dossiers"
      expr: COUNT(1)
      comment: "Total number of regulatory dossiers. Baseline measure for dossier portfolio size."
    - name: "complete_dossiers"
      expr: COUNT(CASE WHEN completeness_status = 'Complete' THEN 1 END)
      comment: "Number of dossiers with complete status. Numerator for dossier completeness rate — measures regulatory submission readiness."
    - name: "incomplete_dossiers"
      expr: COUNT(CASE WHEN completeness_status != 'Complete' OR completeness_status IS NULL THEN 1 END)
      comment: "Number of dossiers that are not yet complete. Measures the gap in regulatory submission readiness — directly impacts time-to-market."
    - name: "avg_completeness_percentage"
      expr: AVG(CAST(completeness_percentage AS DOUBLE))
      comment: "Average dossier completeness percentage across all dossiers. Tracks overall regulatory documentation readiness as a portfolio-level KPI."
    - name: "dossiers_expiring_next_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND dossier_status = 'Approved' THEN 1 END)
      comment: "Number of approved dossiers expiring within 90 days. Forward-looking risk KPI for dossier renewal prioritization."
    - name: "dossiers_with_safety_assessment"
      expr: COUNT(CASE WHEN safety_assessment_included = TRUE THEN 1 END)
      comment: "Number of dossiers that include a safety assessment. Measures compliance readiness for safety-assessment-mandatory markets (e.g., EU)."
    - name: "distinct_skus_with_dossier"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs covered by at least one dossier. Measures the breadth of regulatory documentation coverage across the product portfolio."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`regulatory_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks the approval status, compliance health, and renewal pipeline of regulatory claims on products. Enables marketing and regulatory leadership to manage claim substantiation, approval rates, and expiry risk."
  source: "`consumer_goods_ecm`.`regulatory`.`regulatory_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the regulatory claim (e.g., Active, Expired, Under Review). Primary dimension for claim portfolio health."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of regulatory claim (e.g., Efficacy, Safety, Environmental, Organic). Enables claim portfolio segmentation by type."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the claim (e.g., Approved, Pending, Rejected). Key dimension for claim approval pipeline analysis."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority that approved or oversees the claim. Enables authority-level claim tracking."
    - name: "product_category"
      expr: product_category
      comment: "Product category to which the claim applies. Supports category-level claim portfolio management."
    - name: "compliance_review_outcome"
      expr: compliance_review_outcome
      comment: "Outcome of the most recent compliance review of the claim. Used to identify claims at risk of non-compliance."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Boolean flag indicating whether the claim requires periodic renewal. Used to filter claims in the renewal pipeline."
    - name: "owning_team"
      expr: owning_team
      comment: "Internal team responsible for the claim. Supports accountability and workload distribution analysis."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the claim was approved. Enables cohort analysis of claim approvals over time."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the claim expires. Critical for proactive claim renewal management."
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of regulatory claims. Baseline measure for claim portfolio size."
    - name: "approved_claims"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved regulatory claims. Measures the active authorized claim portfolio supporting marketing and commercial activities."
    - name: "rejected_claims"
      expr: COUNT(CASE WHEN approval_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected claims. Tracks claim substantiation quality and regulatory authority relationship health."
    - name: "claims_expiring_next_90_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved claims expiring within 90 days. Forward-looking risk KPI — expired claims cannot be used in marketing, creating commercial exposure."
    - name: "claims_requiring_renewal"
      expr: COUNT(CASE WHEN renewal_required_flag = TRUE AND claim_status = 'Active' THEN 1 END)
      comment: "Number of active claims that require periodic renewal. Measures the ongoing renewal workload for the regulatory claims team."
    - name: "distinct_skus_with_claims"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with at least one regulatory claim. Measures the breadth of the claims-supported product portfolio."
    - name: "distinct_jurisdictions_with_claims"
      expr: COUNT(DISTINCT jurisdiction_id)
      comment: "Number of distinct jurisdictions where regulatory claims are active. Measures geographic claim authorization coverage."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`regulatory_restricted_substance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors the portfolio of restricted substances, their regulatory status, and concentration limits. Enables regulatory and R&D leadership to manage ingredient compliance risk, SVHC exposure, and reformulation priorities."
  source: "`consumer_goods_ecm`.`regulatory`.`restricted_substance`"
  dimensions:
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of restriction applied to the substance (e.g., Prohibited, Restricted, Conditionally Permitted). Primary dimension for restriction severity analysis."
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "GHS or regulatory hazard classification of the substance. Used to segment substances by health and environmental risk."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority that imposed the restriction. Enables authority-level restricted substance tracking."
    - name: "svhc_status"
      expr: svhc_status
      comment: "Boolean flag indicating whether the substance is classified as a Substance of Very High Concern (SVHC) under REACH. Critical dimension for EU market compliance."
    - name: "fda_prohibited_flag"
      expr: fda_prohibited_flag
      comment: "Boolean flag indicating FDA prohibition status. Used to identify substances banned in the US market."
    - name: "prop_65_listing"
      expr: prop_65_listing
      comment: "Boolean flag indicating California Proposition 65 listing status. Used for US market labeling compliance analysis."
    - name: "epa_restricted_flag"
      expr: epa_restricted_flag
      comment: "Boolean flag indicating EPA restriction status. Used for US environmental compliance analysis."
    - name: "owning_team"
      expr: owning_team
      comment: "Internal team responsible for managing the restricted substance. Supports accountability and workload distribution."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the restriction became effective. Enables trend analysis of regulatory tightening over time."
    - name: "sunset_month"
      expr: DATE_TRUNC('MONTH', sunset_date)
      comment: "Month the substance restriction sunsets or expires. Used to track upcoming regulatory changes requiring reformulation."
  measures:
    - name: "total_restricted_substances"
      expr: COUNT(1)
      comment: "Total number of restricted substances tracked. Baseline measure for the regulatory restricted substance portfolio."
    - name: "svhc_substances"
      expr: COUNT(CASE WHEN svhc_status = TRUE THEN 1 END)
      comment: "Number of substances classified as SVHC under REACH. Critical KPI for EU market compliance — SVHC presence triggers authorization and communication obligations."
    - name: "fda_prohibited_substances"
      expr: COUNT(CASE WHEN fda_prohibited_flag = TRUE THEN 1 END)
      comment: "Number of FDA-prohibited substances in the portfolio. Measures US market compliance risk exposure."
    - name: "prop_65_listed_substances"
      expr: COUNT(CASE WHEN prop_65_listing = TRUE THEN 1 END)
      comment: "Number of substances on the California Proposition 65 list. Measures labeling compliance risk for the US market."
    - name: "avg_maximum_permitted_concentration"
      expr: AVG(CAST(maximum_permitted_concentration AS DOUBLE))
      comment: "Average maximum permitted concentration across restricted substances. Provides a portfolio-level view of concentration limit stringency."
    - name: "substances_sunsetting_next_180_days"
      expr: COUNT(CASE WHEN sunset_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 180) THEN 1 END)
      comment: "Number of restricted substances with sunset dates within 180 days. Forward-looking KPI for reformulation planning — substances sunsetting require proactive R&D action."
    - name: "distinct_jurisdictions_with_restrictions"
      expr: COUNT(DISTINCT jurisdiction_id)
      comment: "Number of distinct jurisdictions with restricted substance regulations. Measures the geographic breadth of ingredient compliance obligations."
$$;