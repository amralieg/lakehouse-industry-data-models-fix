-- Metric views for domain: client | Business: Legal | Version: 1 | Generated on: 2026-05-07 14:29:57

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`client_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the client profile master entity. Tracks client portfolio health, KYC compliance posture, billing configuration, and segment distribution — core inputs for client relationship management, risk governance, and revenue planning."
  source: "`legal_ecm`.`client`.`profile`"
  dimensions:
    - name: "client_type"
      expr: client_type
      comment: "Classifies the client as individual, corporate, government, etc. — primary segmentation axis for portfolio analysis."
    - name: "client_status"
      expr: client_status
      comment: "Current lifecycle status of the client (Active, Inactive, Prospect, Suspended) — used to filter active book of business."
    - name: "kyc_status"
      expr: kyc_status
      comment: "Know-Your-Client compliance status (Approved, Pending, Expired, Failed) — critical for regulatory risk dashboards."
    - name: "aml_risk_rating"
      expr: aml_risk_rating
      comment: "Anti-money-laundering risk tier assigned to the client — drives enhanced due diligence workflows and regulatory reporting."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the client — used for cross-border regulatory analysis and practice area routing."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Agreed billing cadence (Monthly, Quarterly, etc.) — informs cash-flow forecasting and billing operations."
    - name: "preferred_billing_currency"
      expr: preferred_billing_currency
      comment: "Currency in which the client is billed — relevant for multi-currency revenue reporting."
    - name: "electronic_billing_required_flag"
      expr: electronic_billing_required_flag
      comment: "Indicates whether the client mandates electronic billing — used to track e-billing adoption and compliance."
    - name: "outside_counsel_guidelines_flag"
      expr: outside_counsel_guidelines_flag
      comment: "Indicates whether the client has active Outside Counsel Guidelines — flags clients with billing and staffing restrictions."
    - name: "conflict_check_status"
      expr: conflict_check_status
      comment: "Status of the most recent conflict-of-interest check — essential for matter intake governance."
    - name: "sanctions_screening_status"
      expr: sanctions_screening_status
      comment: "Result of the latest sanctions screening — mandatory compliance dimension for AML/CFT reporting."
    - name: "data_protection_classification"
      expr: data_protection_classification
      comment: "Data sensitivity classification of the client record — used for GDPR and data governance reporting."
    - name: "first_engagement_year"
      expr: YEAR(first_engagement_date)
      comment: "Year the client was first engaged — enables client vintage cohort analysis."
    - name: "kyc_next_review_year"
      expr: YEAR(kyc_next_review_date)
      comment: "Year the next KYC review is due — used to plan compliance workload and avoid lapses."
  measures:
    - name: "total_active_clients"
      expr: COUNT(CASE WHEN client_status = 'Active' THEN profile_id END)
      comment: "Total number of active client profiles. Core portfolio size KPI used by leadership to track book-of-business growth."
    - name: "kyc_compliant_client_count"
      expr: COUNT(CASE WHEN kyc_status = 'Approved' THEN profile_id END)
      comment: "Number of clients with an approved KYC status. Directly measures regulatory compliance posture of the client portfolio."
    - name: "kyc_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN kyc_status = 'Approved' THEN profile_id END) / NULLIF(COUNT(profile_id), 0), 2)
      comment: "Percentage of client profiles with approved KYC. A key risk governance KPI — low rates trigger regulatory escalation."
    - name: "high_aml_risk_client_count"
      expr: COUNT(CASE WHEN aml_risk_rating IN ('High', 'Very High') THEN profile_id END)
      comment: "Number of clients rated High or Very High AML risk. Drives enhanced due diligence resource allocation and partner-level oversight."
    - name: "sanctions_flagged_client_count"
      expr: COUNT(CASE WHEN sanctions_screening_status NOT IN ('Clear', 'Passed') THEN profile_id END)
      comment: "Number of clients with a non-clear sanctions screening status. Critical compliance KPI — any non-zero value requires immediate legal review."
    - name: "ebilling_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN electronic_billing_required_flag = TRUE THEN profile_id END) / NULLIF(COUNT(profile_id), 0), 2)
      comment: "Percentage of clients mandating electronic billing. Tracks operational modernisation and billing efficiency across the portfolio."
    - name: "avg_credit_limit_amount"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit across all client profiles. Informs credit risk exposure and financial risk management decisions."
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total aggregate credit limit extended to all clients. Measures maximum financial exposure from the client portfolio."
    - name: "clients_with_ocg_count"
      expr: COUNT(CASE WHEN outside_counsel_guidelines_flag = TRUE THEN profile_id END)
      comment: "Number of clients with active Outside Counsel Guidelines. Indicates the volume of clients imposing billing and staffing constraints on the firm."
    - name: "conflict_check_pending_count"
      expr: COUNT(CASE WHEN conflict_check_status = 'Pending' THEN profile_id END)
      comment: "Number of clients with an outstanding conflict-of-interest check. Operational risk KPI — unresolved conflicts block matter intake."
    - name: "kyc_overdue_review_count"
      expr: COUNT(CASE WHEN kyc_next_review_date < CURRENT_DATE() AND kyc_status = 'Approved' THEN profile_id END)
      comment: "Number of clients whose KYC review date has passed without renewal. Directly measures regulatory compliance breach risk."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`client_organisation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over the corporate client organisation entity. Tracks organisational portfolio composition, KYC compliance, credit exposure, and sanctions risk across corporate clients — essential for relationship management and risk governance."
  source: "`legal_ecm`.`client`.`organisation`"
  dimensions:
    - name: "entity_type"
      expr: entity_type
      comment: "Legal entity type of the organisation (LLC, PLC, Partnership, etc.) — primary classification for corporate client analysis."
    - name: "industry_sector"
      expr: industry_sector
      comment: "Industry sector of the client organisation — used for sector-based portfolio concentration and cross-sell analysis."
    - name: "jurisdiction_of_incorporation"
      expr: jurisdiction_of_incorporation
      comment: "Jurisdiction where the organisation is incorporated — drives regulatory compliance requirements and conflict-check scope."
    - name: "relationship_status"
      expr: relationship_status
      comment: "Current relationship status with the organisation (Active, Dormant, Terminated) — filters active corporate client base."
    - name: "kyc_status"
      expr: kyc_status
      comment: "KYC compliance status of the organisation — critical for AML/CFT regulatory reporting."
    - name: "aml_risk_tier"
      expr: aml_risk_tier
      comment: "AML risk tier assigned to the organisation — determines level of due diligence and monitoring required."
    - name: "public_private_status"
      expr: public_private_status
      comment: "Whether the organisation is publicly listed or privately held — relevant for disclosure obligations and risk profiling."
    - name: "sanctions_screening_status"
      expr: sanctions_screening_status
      comment: "Latest sanctions screening result for the organisation — mandatory compliance dimension."
    - name: "annual_revenue_range"
      expr: annual_revenue_range
      comment: "Revenue band of the client organisation — used for client tiering and commercial strategy."
    - name: "relationship_inception_year"
      expr: YEAR(relationship_inception_date)
      comment: "Year the relationship with the organisation commenced — enables client vintage and retention cohort analysis."
    - name: "kyc_next_review_year"
      expr: YEAR(kyc_next_review_date)
      comment: "Year the next KYC review is due for the organisation — used for compliance workload planning."
  measures:
    - name: "total_corporate_clients"
      expr: COUNT(organisation_id)
      comment: "Total number of corporate client organisations on record. Baseline portfolio size metric for corporate relationship management."
    - name: "active_corporate_client_count"
      expr: COUNT(CASE WHEN relationship_status = 'Active' THEN organisation_id END)
      comment: "Number of organisations with an active client relationship. Core book-of-business metric for corporate practice groups."
    - name: "kyc_approved_organisation_count"
      expr: COUNT(CASE WHEN kyc_status = 'Approved' THEN organisation_id END)
      comment: "Number of corporate clients with approved KYC. Measures regulatory compliance coverage across the corporate portfolio."
    - name: "kyc_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN kyc_status = 'Approved' THEN organisation_id END) / NULLIF(COUNT(organisation_id), 0), 2)
      comment: "Percentage of corporate clients with approved KYC status. Key risk governance KPI reported to compliance committees."
    - name: "high_aml_risk_organisation_count"
      expr: COUNT(CASE WHEN aml_risk_tier IN ('High', 'Very High') THEN organisation_id END)
      comment: "Number of corporate clients in high or very-high AML risk tiers. Drives enhanced due diligence resource planning."
    - name: "sanctions_flagged_organisation_count"
      expr: COUNT(CASE WHEN sanctions_screening_status NOT IN ('Clear', 'Passed') THEN organisation_id END)
      comment: "Number of corporate clients with a non-clear sanctions screening result. Any non-zero value requires immediate compliance escalation."
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total aggregate credit limit extended to all corporate clients. Measures maximum financial exposure from the corporate portfolio."
    - name: "avg_credit_limit_per_organisation"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per corporate client organisation. Benchmarks credit risk appetite across the corporate client base."
    - name: "kyc_overdue_review_count"
      expr: COUNT(CASE WHEN kyc_next_review_date < CURRENT_DATE() AND kyc_status = 'Approved' THEN organisation_id END)
      comment: "Number of corporate clients whose KYC review is overdue. Directly measures regulatory compliance breach risk in the corporate portfolio."
    - name: "ultimate_beneficial_owner_count"
      expr: COUNT(CASE WHEN is_ultimate_beneficial_owner = TRUE THEN organisation_id END)
      comment: "Number of organisations identified as ultimate beneficial owners. Critical for corporate structure transparency and AML compliance."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`client_kyc_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance-focused KPI layer over KYC records. Tracks KYC approval rates, risk distribution, screening outcomes, escalation volumes, and review cycle health — essential for AML/CFT regulatory reporting and compliance operations management."
  source: "`legal_ecm`.`client`.`kyc_record`"
  dimensions:
    - name: "kyc_status"
      expr: kyc_status
      comment: "Current status of the KYC record (Approved, Pending, Expired, Rejected) — primary compliance status dimension."
    - name: "kyc_tier"
      expr: kyc_tier
      comment: "KYC due diligence tier (Standard, Enhanced, Simplified) — reflects the level of scrutiny applied to the client."
    - name: "aml_risk_rating"
      expr: aml_risk_rating
      comment: "AML risk rating assigned during KYC review — drives enhanced due diligence and monitoring requirements."
    - name: "pep_screening_result"
      expr: pep_screening_result
      comment: "Result of the Politically Exposed Person screening — critical for regulatory compliance and reputational risk management."
    - name: "sanctions_screening_result"
      expr: sanctions_screening_result
      comment: "Result of the sanctions list screening — mandatory compliance dimension for AML/CFT reporting."
    - name: "adverse_media_screening_result"
      expr: adverse_media_screening_result
      comment: "Result of adverse media screening — used to identify reputational risk associated with clients."
    - name: "high_risk_jurisdiction_flag"
      expr: high_risk_jurisdiction_flag
      comment: "Indicates whether the client is associated with a high-risk jurisdiction — triggers enhanced due diligence requirements."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Indicates whether the KYC record requires escalation to senior compliance staff — used to track escalation workload."
    - name: "source_of_funds_verified"
      expr: source_of_funds_verified
      comment: "Whether the client's source of funds has been verified — key AML compliance checkpoint."
    - name: "beneficial_ownership_verified"
      expr: beneficial_ownership_verified
      comment: "Whether beneficial ownership has been verified — mandatory for corporate client AML compliance."
    - name: "jurisdiction_of_incorporation"
      expr: jurisdiction_of_incorporation
      comment: "Jurisdiction of incorporation recorded on the KYC record — used for geographic risk concentration analysis."
    - name: "kyc_approval_year"
      expr: YEAR(kyc_approval_date)
      comment: "Year the KYC record was approved — enables trend analysis of KYC throughput over time."
    - name: "kyc_expiry_year"
      expr: YEAR(kyc_expiry_date)
      comment: "Year the KYC record expires — used for forward-looking compliance workload planning."
  measures:
    - name: "total_kyc_records"
      expr: COUNT(kyc_record_id)
      comment: "Total number of KYC records. Baseline measure for compliance portfolio sizing and workload management."
    - name: "kyc_approved_count"
      expr: COUNT(CASE WHEN kyc_status = 'Approved' THEN kyc_record_id END)
      comment: "Number of KYC records with Approved status. Core compliance throughput metric reported to the compliance committee."
    - name: "kyc_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN kyc_status = 'Approved' THEN kyc_record_id END) / NULLIF(COUNT(kyc_record_id), 0), 2)
      comment: "Percentage of KYC records that have been approved. Key compliance efficiency KPI — low rates indicate bottlenecks or quality issues."
    - name: "kyc_expired_count"
      expr: COUNT(CASE WHEN kyc_expiry_date < CURRENT_DATE() AND kyc_status = 'Approved' THEN kyc_record_id END)
      comment: "Number of KYC records that have expired without renewal. Directly measures regulatory compliance breach risk — requires immediate remediation."
    - name: "kyc_overdue_review_count"
      expr: COUNT(CASE WHEN next_review_due_date < CURRENT_DATE() AND is_active = TRUE THEN kyc_record_id END)
      comment: "Number of active KYC records where the review due date has passed. Operational compliance KPI — drives review scheduling and resource allocation."
    - name: "escalation_required_count"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN kyc_record_id END)
      comment: "Number of KYC records flagged for escalation. Measures compliance escalation workload and identifies systemic risk concentration."
    - name: "high_risk_jurisdiction_client_count"
      expr: COUNT(CASE WHEN high_risk_jurisdiction_flag = TRUE THEN kyc_record_id END)
      comment: "Number of KYC records associated with high-risk jurisdictions. Drives enhanced due diligence resource allocation and regulatory reporting."
    - name: "source_of_funds_unverified_count"
      expr: COUNT(CASE WHEN source_of_funds_verified = FALSE THEN kyc_record_id END)
      comment: "Number of KYC records where source of funds has not been verified. Critical AML compliance gap metric — unverified records represent regulatory exposure."
    - name: "beneficial_ownership_unverified_count"
      expr: COUNT(CASE WHEN beneficial_ownership_verified = FALSE THEN kyc_record_id END)
      comment: "Number of KYC records where beneficial ownership has not been verified. Mandatory AML compliance metric — unverified records breach regulatory requirements."
    - name: "sanctions_match_count"
      expr: COUNT(CASE WHEN sanctions_screening_result NOT IN ('Clear', 'No Match') THEN kyc_record_id END)
      comment: "Number of KYC records with a potential sanctions list match. Any non-zero value requires immediate legal and compliance escalation."
    - name: "pep_identified_count"
      expr: COUNT(CASE WHEN pep_screening_result NOT IN ('Clear', 'No Match') THEN kyc_record_id END)
      comment: "Number of KYC records where a Politically Exposed Person has been identified. Drives enhanced due diligence and senior partner sign-off requirements."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`client_beneficial_owner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance and ownership transparency KPI layer over beneficial owner records. Tracks ownership concentration, PEP exposure, sanctions risk, adverse media flags, and verification completeness — critical for AML/CFT regulatory compliance and corporate governance."
  source: "`legal_ecm`.`client`.`beneficial_owner`"
  dimensions:
    - name: "beneficial_owner_status"
      expr: beneficial_owner_status
      comment: "Current status of the beneficial owner record (Active, Inactive, Under Review) — primary lifecycle dimension."
    - name: "pep_status"
      expr: pep_status
      comment: "Politically Exposed Person status of the beneficial owner — triggers enhanced due diligence and senior oversight."
    - name: "sanctions_status"
      expr: sanctions_status
      comment: "Sanctions screening status of the beneficial owner — mandatory AML/CFT compliance dimension."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Overall risk rating assigned to the beneficial owner — drives monitoring frequency and due diligence intensity."
    - name: "nationality"
      expr: nationality
      comment: "Nationality of the beneficial owner — used for geographic risk concentration and cross-border compliance analysis."
    - name: "country_of_residence"
      expr: country_of_residence
      comment: "Country of residence of the beneficial owner — relevant for tax residency and sanctions jurisdiction analysis."
    - name: "nature_of_control"
      expr: nature_of_control
      comment: "Nature of control exercised by the beneficial owner (Ownership, Voting Rights, Significant Influence) — key corporate governance dimension."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify the beneficial owner's identity — used to assess verification quality and compliance standards."
    - name: "adverse_media_flag"
      expr: adverse_media_flag
      comment: "Indicates whether adverse media has been identified for the beneficial owner — reputational risk indicator."
    - name: "next_review_year"
      expr: YEAR(next_review_date)
      comment: "Year the next beneficial owner review is due — used for compliance workload planning."
    - name: "risk_assessment_year"
      expr: YEAR(risk_assessment_date)
      comment: "Year the most recent risk assessment was conducted — enables trend analysis of risk review cadence."
  measures:
    - name: "total_beneficial_owners"
      expr: COUNT(beneficial_owner_id)
      comment: "Total number of beneficial owner records. Baseline measure for ownership transparency portfolio sizing."
    - name: "pep_beneficial_owner_count"
      expr: COUNT(CASE WHEN pep_status NOT IN ('None', 'Clear', 'Not PEP') THEN beneficial_owner_id END)
      comment: "Number of beneficial owners identified as Politically Exposed Persons. Drives enhanced due diligence and senior partner oversight requirements."
    - name: "pep_exposure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pep_status NOT IN ('None', 'Clear', 'Not PEP') THEN beneficial_owner_id END) / NULLIF(COUNT(beneficial_owner_id), 0), 2)
      comment: "Percentage of beneficial owners with PEP status. Key AML risk concentration metric reported to the compliance committee."
    - name: "sanctions_flagged_count"
      expr: COUNT(CASE WHEN sanctions_status NOT IN ('Clear', 'Passed', 'No Match') THEN beneficial_owner_id END)
      comment: "Number of beneficial owners with a non-clear sanctions status. Any non-zero value requires immediate legal escalation and matter suspension."
    - name: "adverse_media_flagged_count"
      expr: COUNT(CASE WHEN adverse_media_flag = TRUE THEN beneficial_owner_id END)
      comment: "Number of beneficial owners with adverse media identified. Reputational risk KPI — informs client acceptance and continuation decisions."
    - name: "high_risk_beneficial_owner_count"
      expr: COUNT(CASE WHEN risk_rating IN ('High', 'Very High') THEN beneficial_owner_id END)
      comment: "Number of beneficial owners rated High or Very High risk. Drives enhanced monitoring frequency and senior compliance sign-off."
    - name: "avg_ownership_percentage"
      expr: AVG(CAST(ownership_percentage AS DOUBLE))
      comment: "Average ownership percentage held by beneficial owners. Informs ownership concentration analysis and control structure assessment."
    - name: "majority_ownership_count"
      expr: COUNT(CASE WHEN ownership_percentage >= 25.0 THEN beneficial_owner_id END)
      comment: "Number of beneficial owners holding 25% or more ownership — the standard regulatory threshold for significant control. Critical for AML/CFT beneficial ownership registers."
    - name: "overdue_review_count"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE() AND beneficial_owner_status = 'Active' THEN beneficial_owner_id END)
      comment: "Number of active beneficial owners whose review date has passed. Compliance breach risk metric — overdue reviews represent regulatory exposure."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`client_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over client segments. Tracks segment commercial performance targets, AML/KYC requirements, discount authority, and review health — used by business development and client relationship leadership to manage portfolio strategy."
  source: "`legal_ecm`.`client`.`segment`"
  dimensions:
    - name: "segment_name"
      expr: segment_name
      comment: "Name of the client segment — primary grouping dimension for portfolio strategy analysis."
    - name: "segment_tier"
      expr: segment_tier
      comment: "Tier classification of the segment (Platinum, Gold, Silver, etc.) — drives service level and commercial priority decisions."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment definition (Active, Archived) — filters to active segments for operational reporting."
    - name: "target_client_type"
      expr: target_client_type
      comment: "Type of client targeted by this segment — used to align business development efforts."
    - name: "requires_kyc_enhanced"
      expr: requires_kyc_enhanced
      comment: "Indicates whether clients in this segment require enhanced KYC — drives compliance resource planning."
    - name: "requires_aml_screening"
      expr: requires_aml_screening
      comment: "Indicates whether clients in this segment require AML screening — used for compliance workload forecasting."
    - name: "partner_attention_required"
      expr: partner_attention_required
      comment: "Indicates whether segments require direct partner-level attention — used for relationship management prioritisation."
    - name: "cross_sell_priority"
      expr: cross_sell_priority
      comment: "Cross-sell priority level for the segment — informs business development targeting and revenue growth strategy."
    - name: "review_cycle"
      expr: review_cycle
      comment: "Frequency at which the segment definition is reviewed — used for governance and segment management planning."
  measures:
    - name: "total_active_segments"
      expr: COUNT(CASE WHEN segment_status = 'Active' THEN segment_id END)
      comment: "Total number of active client segments. Baseline measure for portfolio segmentation coverage and strategy completeness."
    - name: "avg_target_realization_rate"
      expr: AVG(CAST(target_realization_rate AS DOUBLE))
      comment: "Average target realization rate across segments. Measures how ambitiously the firm is pricing relative to standard rates — a key profitability lever."
    - name: "avg_target_revenue_per_equity_partner"
      expr: AVG(CAST(target_rpe AS DOUBLE))
      comment: "Average target revenue per equity partner across segments. Strategic KPI used by firm leadership to set partner performance expectations."
    - name: "avg_standard_discount_pct"
      expr: AVG(CAST(standard_discount_percentage AS DOUBLE))
      comment: "Average standard discount percentage offered across segments. Informs pricing strategy and margin management decisions."
    - name: "total_minimum_revenue_threshold"
      expr: SUM(CAST(minimum_revenue_threshold AS DOUBLE))
      comment: "Sum of minimum revenue thresholds across all segments. Represents the aggregate minimum revenue floor the firm targets from its segmented client base."
    - name: "enhanced_kyc_segment_count"
      expr: COUNT(CASE WHEN requires_kyc_enhanced = TRUE THEN segment_id END)
      comment: "Number of segments requiring enhanced KYC. Drives compliance resource planning and cost allocation for due diligence operations."
    - name: "segments_overdue_review_count"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE() AND segment_status = 'Active' THEN segment_id END)
      comment: "Number of active segments whose review date has passed. Governance KPI — outdated segment definitions lead to misaligned commercial strategy."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`client_engagement_scope`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commercial and governance KPI layer over client engagement scopes. Tracks panel appointments, billing configuration, AFA adoption, conflict check requirements, and scope lifecycle — used by practice group leaders and client relationship partners to manage commercial arrangements."
  source: "`legal_ecm`.`client`.`engagement_scope`"
  dimensions:
    - name: "scope_type"
      expr: scope_type
      comment: "Type of engagement scope (Panel, Retainer, Matter-Specific, Framework) — primary commercial arrangement classification."
    - name: "scope_status"
      expr: scope_status
      comment: "Current status of the engagement scope (Active, Expired, Pending, Terminated) — filters to active commercial arrangements."
    - name: "afa_framework_type"
      expr: afa_framework_type
      comment: "Alternative Fee Arrangement framework type (Fixed Fee, Capped Fee, Success Fee, etc.) — used to track AFA adoption across the client portfolio."
    - name: "aml_risk_rating"
      expr: aml_risk_rating
      comment: "AML risk rating associated with the engagement scope — used for compliance monitoring of active engagements."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing cadence for the engagement scope — informs cash-flow forecasting and billing operations planning."
    - name: "electronic_billing_required"
      expr: electronic_billing_required
      comment: "Whether electronic billing is required for this scope — tracks e-billing mandate compliance."
    - name: "conflict_check_required"
      expr: conflict_check_required
      comment: "Whether a conflict check is required before matters can be opened under this scope — governance dimension for matter intake."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the engagement scope auto-renews — used to forecast future revenue continuity."
    - name: "preferred_counsel_designation"
      expr: preferred_counsel_designation
      comment: "Whether the firm holds preferred counsel status under this scope — a key competitive positioning indicator."
    - name: "originating_office_code"
      expr: originating_office_code
      comment: "Office that originated the engagement scope — used for office-level commercial performance analysis."
    - name: "panel_start_year"
      expr: YEAR(panel_start_date)
      comment: "Year the panel appointment commenced — enables panel vintage and renewal cycle analysis."
    - name: "panel_expiry_year"
      expr: YEAR(panel_expiry_date)
      comment: "Year the panel appointment expires — used for forward-looking panel renewal pipeline management."
    - name: "kyc_documentation_status"
      expr: kyc_documentation_status
      comment: "KYC documentation completeness status for the engagement scope — compliance gate for matter activation."
    - name: "data_protection_classification"
      expr: data_protection_classification
      comment: "Data sensitivity classification of the engagement scope — used for GDPR and data governance reporting."
  measures:
    - name: "total_active_engagement_scopes"
      expr: COUNT(CASE WHEN scope_status = 'Active' THEN engagement_scope_id END)
      comment: "Total number of active engagement scopes. Measures the breadth of active commercial arrangements — a leading indicator of revenue pipeline."
    - name: "preferred_counsel_scope_count"
      expr: COUNT(CASE WHEN preferred_counsel_designation = TRUE THEN engagement_scope_id END)
      comment: "Number of scopes where the firm holds preferred counsel designation. Strategic KPI — preferred counsel status drives higher matter volume and revenue certainty."
    - name: "preferred_counsel_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN preferred_counsel_designation = TRUE THEN engagement_scope_id END) / NULLIF(COUNT(CASE WHEN scope_status = 'Active' THEN engagement_scope_id END), 0), 2)
      comment: "Percentage of active engagement scopes with preferred counsel designation. Measures competitive positioning strength across the active client portfolio."
    - name: "afa_scope_count"
      expr: COUNT(CASE WHEN afa_framework_type IS NOT NULL AND afa_framework_type != '' THEN engagement_scope_id END)
      comment: "Number of engagement scopes with an Alternative Fee Arrangement. Tracks AFA adoption — a key indicator of client-centric pricing maturity."
    - name: "afa_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN afa_framework_type IS NOT NULL AND afa_framework_type != '' THEN engagement_scope_id END) / NULLIF(COUNT(CASE WHEN scope_status = 'Active' THEN engagement_scope_id END), 0), 2)
      comment: "Percentage of active scopes using an AFA framework. Strategic pricing KPI — higher AFA rates indicate stronger client relationships and pricing innovation."
    - name: "auto_renewal_scope_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE AND scope_status = 'Active' THEN engagement_scope_id END)
      comment: "Number of active scopes set to auto-renew. Measures revenue continuity and relationship stickiness in the client portfolio."
    - name: "panel_expiring_within_90_days_count"
      expr: COUNT(CASE WHEN panel_expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN engagement_scope_id END)
      comment: "Number of panel appointments expiring within the next 90 days. Critical pipeline management KPI — drives proactive renewal conversations to protect revenue."
    - name: "kyc_incomplete_scope_count"
      expr: COUNT(CASE WHEN kyc_documentation_status NOT IN ('Complete', 'Approved') AND scope_status = 'Active' THEN engagement_scope_id END)
      comment: "Number of active scopes with incomplete KYC documentation. Compliance risk KPI — incomplete KYC blocks matter activation and creates regulatory exposure."
    - name: "conflict_check_required_scope_count"
      expr: COUNT(CASE WHEN conflict_check_required = TRUE THEN engagement_scope_id END)
      comment: "Number of engagement scopes requiring a conflict check before matter opening. Operational governance metric — informs conflict check workload planning."
    - name: "matter_budget_approval_required_count"
      expr: COUNT(CASE WHEN matter_budget_approval_required = TRUE AND scope_status = 'Active' THEN engagement_scope_id END)
      comment: "Number of active scopes requiring matter budget approval. Measures the volume of engagements with budget governance controls — relevant for financial risk management."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`client_outside_counsel_guideline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commercial governance KPI layer over Outside Counsel Guidelines (OCGs). Tracks billing rate caps, budget thresholds, AFA permissions, diversity reporting mandates, and guideline lifecycle — used by billing operations, practice group leaders, and client relationship partners to manage compliance with client billing requirements."
  source: "`legal_ecm`.`client`.`outside_counsel_guideline`"
  dimensions:
    - name: "outside_counsel_guideline_status"
      expr: outside_counsel_guideline_status
      comment: "Current status of the OCG (Active, Expired, Pending Acceptance, Superseded) — primary lifecycle dimension."
    - name: "guideline_type"
      expr: guideline_type
      comment: "Type of OCG (Standard, Enhanced, Panel-Specific) — classifies the commercial governance framework applied."
    - name: "acceptance_status"
      expr: acceptance_status
      comment: "Whether the firm has formally accepted the OCG — tracks compliance with client onboarding requirements."
    - name: "afa_permitted"
      expr: afa_permitted
      comment: "Whether the OCG permits Alternative Fee Arrangements — key commercial flexibility indicator."
    - name: "block_billing_prohibited"
      expr: block_billing_prohibited
      comment: "Whether block billing is prohibited under the OCG — billing compliance dimension."
    - name: "diversity_reporting_required"
      expr: diversity_reporting_required
      comment: "Whether the OCG requires diversity reporting — tracks ESG and diversity compliance obligations."
    - name: "sustainability_reporting_required"
      expr: sustainability_reporting_required
      comment: "Whether the OCG requires sustainability reporting — tracks ESG reporting obligations."
    - name: "utbms_task_code_required"
      expr: utbms_task_code_required
      comment: "Whether UTBMS task codes are required for billing — billing format compliance dimension."
    - name: "invoice_delivery_method"
      expr: invoice_delivery_method
      comment: "Preferred invoice delivery method (e-billing platform, email, portal) — billing operations dimension."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of matter reporting required by the client — informs reporting workload planning."
    - name: "budget_threshold_currency_code"
      expr: budget_threshold_currency_code
      comment: "Currency of the budget approval threshold — used for multi-currency commercial analysis."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the OCG became effective — enables vintage analysis of client billing governance frameworks."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the OCG expires — used for forward-looking renewal pipeline management."
  measures:
    - name: "total_active_ocgs"
      expr: COUNT(CASE WHEN outside_counsel_guideline_status = 'Active' THEN outside_counsel_guideline_id END)
      comment: "Total number of active Outside Counsel Guidelines. Measures the volume of active client billing governance frameworks the firm must comply with."
    - name: "ocg_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acceptance_status = 'Accepted' THEN outside_counsel_guideline_id END) / NULLIF(COUNT(outside_counsel_guideline_id), 0), 2)
      comment: "Percentage of OCGs formally accepted by the firm. Measures compliance with client onboarding requirements — unaccepted OCGs create billing dispute risk."
    - name: "avg_partner_rate_cap"
      expr: AVG(CAST(billing_rate_cap_partner AS DOUBLE))
      comment: "Average partner billing rate cap across all OCGs. Benchmarks client-imposed rate constraints — informs partner rate negotiation strategy."
    - name: "avg_associate_rate_cap"
      expr: AVG(CAST(billing_rate_cap_associate AS DOUBLE))
      comment: "Average associate billing rate cap across all OCGs. Benchmarks client-imposed rate constraints for associate-level work."
    - name: "avg_budget_approval_threshold"
      expr: AVG(CAST(budget_approval_threshold AS DOUBLE))
      comment: "Average budget approval threshold across OCGs. Informs matter budget governance — lower thresholds increase approval workload and billing friction."
    - name: "diversity_reporting_mandate_count"
      expr: COUNT(CASE WHEN diversity_reporting_required = TRUE THEN outside_counsel_guideline_id END)
      comment: "Number of OCGs requiring diversity reporting. Measures the volume of ESG/diversity compliance obligations imposed by clients — drives D&I reporting workload."
    - name: "afa_permitted_ocg_count"
      expr: COUNT(CASE WHEN afa_permitted = TRUE THEN outside_counsel_guideline_id END)
      comment: "Number of OCGs that permit Alternative Fee Arrangements. Measures commercial flexibility available under client guidelines — informs AFA pricing strategy."
    - name: "ocgs_expiring_within_90_days_count"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND outside_counsel_guideline_status = 'Active' THEN outside_counsel_guideline_id END)
      comment: "Number of active OCGs expiring within 90 days. Pipeline management KPI — drives proactive renewal to avoid billing compliance gaps."
    - name: "block_billing_prohibited_count"
      expr: COUNT(CASE WHEN block_billing_prohibited = TRUE THEN outside_counsel_guideline_id END)
      comment: "Number of OCGs prohibiting block billing. Billing operations KPI — informs time-recording compliance requirements and billing system configuration."
    - name: "avg_min_time_increment"
      expr: AVG(CAST(minimum_time_increment AS DOUBLE))
      comment: "Average minimum time increment (in hours) required across OCGs. Informs time-recording policy and billing system configuration to ensure client compliance."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`client_relationship_team`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client relationship management KPI layer over relationship team assignments. Tracks team coverage, origination credit distribution, cross-sell targeting, contact frequency compliance, and succession planning — used by managing partners and business development leadership to optimise client relationship governance."
  source: "`legal_ecm`.`client`.`relationship_team`"
  dimensions:
    - name: "relationship_role_type"
      expr: relationship_role_type
      comment: "Role of the team member in the client relationship (Relationship Partner, Billing Partner, Supervising Associate, etc.) — primary role classification."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the team assignment (Active, Inactive, Pending) — filters to active relationship team coverage."
    - name: "is_primary_contact"
      expr: is_primary_contact
      comment: "Whether the team member is the primary client contact — identifies lead relationship owners."
    - name: "cross_sell_target_flag"
      expr: cross_sell_target_flag
      comment: "Whether the client is a cross-sell target for this team member — used to track business development pipeline coverage."
    - name: "client_satisfaction_responsibility"
      expr: client_satisfaction_responsibility
      comment: "Whether the team member has formal client satisfaction responsibility — governance dimension for relationship quality management."
    - name: "conflict_check_authority"
      expr: conflict_check_authority
      comment: "Whether the team member has authority to approve conflict checks — governance dimension for matter intake."
    - name: "succession_plan_flag"
      expr: succession_plan_flag
      comment: "Whether a succession plan is in place for this assignment — risk management dimension for key client relationship continuity."
    - name: "billing_authority_level"
      expr: billing_authority_level
      comment: "Level of billing authority held by the team member — used for billing governance and write-off approval analysis."
    - name: "escalation_priority"
      expr: escalation_priority
      comment: "Priority level for escalating client issues to this team member — used for service quality and SLA management."
    - name: "geographic_coverage_region"
      expr: geographic_coverage_region
      comment: "Geographic region covered by the team member — used for regional relationship coverage analysis."
    - name: "client_contact_frequency"
      expr: client_contact_frequency
      comment: "Required frequency of client contact for this assignment — used to monitor relationship engagement compliance."
    - name: "assignment_start_year"
      expr: YEAR(assignment_start_date)
      comment: "Year the team assignment commenced — enables tenure analysis of client relationship team stability."
  measures:
    - name: "total_active_assignments"
      expr: COUNT(CASE WHEN assignment_status = 'Active' THEN relationship_team_id END)
      comment: "Total number of active relationship team assignments. Baseline measure for client coverage capacity and relationship team workload."
    - name: "cross_sell_targeted_client_count"
      expr: COUNT(DISTINCT CASE WHEN cross_sell_target_flag = TRUE AND assignment_status = 'Active' THEN client_profile_fk END)
      comment: "Number of distinct clients actively targeted for cross-sell. Measures business development pipeline breadth — a leading indicator of revenue growth."
    - name: "clients_without_succession_plan_count"
      expr: COUNT(DISTINCT CASE WHEN succession_plan_flag = FALSE AND assignment_status = 'Active' AND is_primary_contact = TRUE THEN client_profile_fk END)
      comment: "Number of clients whose primary relationship contact has no succession plan. Key relationship continuity risk KPI — unplanned departures can cause client attrition."
    - name: "avg_origination_credit_pct"
      expr: AVG(CAST(origination_credit_percentage AS DOUBLE))
      comment: "Average origination credit percentage across active assignments. Informs partner compensation equity and origination credit allocation governance."
    - name: "avg_responsibility_pct"
      expr: AVG(CAST(responsibility_percentage AS DOUBLE))
      comment: "Average responsibility percentage across active team assignments. Measures how evenly client relationship responsibility is distributed across the team."
    - name: "overdue_contact_count"
      expr: COUNT(CASE WHEN next_scheduled_contact_date < CURRENT_DATE() AND assignment_status = 'Active' THEN relationship_team_id END)
      comment: "Number of active assignments where the next scheduled client contact is overdue. Relationship quality KPI — overdue contacts indicate engagement gaps that risk client satisfaction."
    - name: "succession_plan_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN succession_plan_flag = TRUE AND assignment_status = 'Active' THEN relationship_team_id END) / NULLIF(COUNT(CASE WHEN assignment_status = 'Active' THEN relationship_team_id END), 0), 2)
      comment: "Percentage of active assignments with a succession plan in place. Relationship continuity governance KPI — low rates indicate key-person dependency risk."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`client_corporate_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corporate structure and compliance KPI layer over corporate hierarchy records. Tracks cross-border relationships, ownership concentration, AML screening status, verification completeness, and hierarchy data quality — used by compliance officers and relationship partners managing complex corporate group clients."
  source: "`legal_ecm`.`client`.`corporate_hierarchy`"
  dimensions:
    - name: "relationship_type"
      expr: relationship_type
      comment: "Type of corporate relationship (Parent-Subsidiary, Affiliate, Joint Venture, etc.) — primary classification for corporate structure analysis."
    - name: "relationship_status"
      expr: relationship_status
      comment: "Current status of the corporate hierarchy relationship (Active, Inactive, Dissolved) — filters to active corporate structures."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level within the corporate hierarchy (Ultimate Parent, Intermediate Holding, Operating Entity) — used for ownership chain analysis."
    - name: "aml_screening_status"
      expr: aml_screening_status
      comment: "AML screening status of the corporate relationship — compliance dimension for group-level AML monitoring."
    - name: "kyc_risk_rating"
      expr: kyc_risk_rating
      comment: "KYC risk rating assigned to the corporate relationship — drives enhanced due diligence for high-risk corporate groups."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the corporate relationship record — compliance quality dimension."
    - name: "cross_border_flag"
      expr: cross_border_flag
      comment: "Indicates whether the relationship spans multiple jurisdictions — triggers additional regulatory compliance requirements."
    - name: "consolidation_flag"
      expr: consolidation_flag
      comment: "Indicates whether billing is consolidated at the group level — used for billing operations and revenue attribution."
    - name: "billing_consolidation_type"
      expr: billing_consolidation_type
      comment: "Type of billing consolidation applied to the corporate group — informs billing configuration and revenue reporting."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the corporate relationship — used for geographic risk concentration and regulatory compliance analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the corporate hierarchy record is currently active — primary filter for operational reporting."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the corporate relationship became effective — enables vintage analysis of corporate group structures."
  measures:
    - name: "total_active_corporate_relationships"
      expr: COUNT(CASE WHEN is_active = TRUE THEN corporate_hierarchy_id END)
      comment: "Total number of active corporate hierarchy relationships. Baseline measure for corporate group complexity and relationship management scope."
    - name: "cross_border_relationship_count"
      expr: COUNT(CASE WHEN cross_border_flag = TRUE AND is_active = TRUE THEN corporate_hierarchy_id END)
      comment: "Number of active cross-border corporate relationships. Measures multi-jurisdictional complexity — drives regulatory compliance resource allocation."
    - name: "cross_border_relationship_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cross_border_flag = TRUE AND is_active = TRUE THEN corporate_hierarchy_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN corporate_hierarchy_id END), 0), 2)
      comment: "Percentage of active corporate relationships that are cross-border. Strategic KPI — high rates indicate international practice complexity and regulatory compliance burden."
    - name: "aml_screening_pending_count"
      expr: COUNT(CASE WHEN aml_screening_status NOT IN ('Clear', 'Passed', 'Approved') AND is_active = TRUE THEN corporate_hierarchy_id END)
      comment: "Number of active corporate relationships with incomplete or non-clear AML screening. Compliance risk KPI — unscreened corporate relationships represent regulatory exposure."
    - name: "unverified_relationship_count"
      expr: COUNT(CASE WHEN verification_status NOT IN ('Verified', 'Approved') AND is_active = TRUE THEN corporate_hierarchy_id END)
      comment: "Number of active corporate relationships that have not been verified. Data quality and compliance KPI — unverified relationships undermine AML/KYC integrity."
    - name: "avg_ownership_percentage"
      expr: AVG(CAST(ownership_percentage AS DOUBLE))
      comment: "Average ownership percentage across corporate hierarchy relationships. Informs ownership concentration analysis and control structure assessment for AML compliance."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across corporate hierarchy records. Measures the integrity of corporate structure data — low scores indicate data governance issues affecting compliance."
    - name: "billing_consolidated_group_count"
      expr: COUNT(CASE WHEN consolidation_flag = TRUE AND is_active = TRUE THEN corporate_hierarchy_id END)
      comment: "Number of active corporate relationships with billing consolidation enabled. Informs billing operations complexity and group-level revenue attribution."
    - name: "relationships_expiring_within_90_days_count"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND is_active = TRUE THEN corporate_hierarchy_id END)
      comment: "Number of active corporate relationships expiring within 90 days. Relationship management KPI — drives proactive renewal to maintain corporate group coverage."
$$;