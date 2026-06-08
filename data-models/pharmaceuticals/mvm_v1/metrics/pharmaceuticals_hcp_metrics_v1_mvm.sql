-- Metric views for domain: hcp | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 21:06:11

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the HCP master registry — tracks active physician population, prescribing authority coverage, KOL tier distribution, board certification health, and DEA compliance. Used by commercial, medical affairs, and compliance leadership to steer HCP engagement strategy and data quality investments."
  source: "`pharmaceuticals_ecm`.`hcp`.`master`"
  dimensions:
    - name: "primary_specialty"
      expr: primary_specialty
      comment: "HCP primary medical specialty (e.g., Oncology, Cardiology) — key segmentation axis for targeting and resource allocation."
    - name: "hcp_status"
      expr: hcp_status
      comment: "Current lifecycle status of the HCP record (Active, Inactive, Deceased, etc.) — used to filter actionable universe."
    - name: "kol_tier"
      expr: kol_tier
      comment: "Key Opinion Leader tier classification (Tier 1, 2, 3, National, Regional) — drives MSL engagement prioritization."
    - name: "kol_status"
      expr: kol_status
      comment: "KOL designation status — distinguishes confirmed KOLs from candidates and non-KOLs."
    - name: "primary_practice_state"
      expr: primary_practice_state
      comment: "State of the HCP's primary practice — enables geographic performance analysis and territory planning."
    - name: "primary_practice_country"
      expr: primary_practice_country
      comment: "Country of the HCP's primary practice — supports global segmentation and regulatory jurisdiction analysis."
    - name: "gender"
      expr: gender
      comment: "HCP gender — used for diversity reporting and demographic analysis of the prescriber universe."
    - name: "board_certification_status"
      expr: board_certification_status
      comment: "Current board certification status — indicates clinical credentialing health of the HCP population."
    - name: "dea_status"
      expr: dea_status
      comment: "DEA registration status — critical for controlled substance prescribing eligibility and compliance monitoring."
    - name: "primary_license_status"
      expr: primary_license_status
      comment: "Status of the HCP's primary state medical license — core compliance and eligibility dimension."
    - name: "professional_designation"
      expr: professional_designation
      comment: "Professional designation (MD, DO, NP, PA, PharmD, etc.) — segments the HCP universe by credential type."
    - name: "sunshine_act_reportable"
      expr: sunshine_act_reportable
      comment: "Flag indicating whether the HCP is subject to Open Payments / Sunshine Act reporting obligations."
    - name: "record_created_year_month"
      expr: DATE_TRUNC('month', record_created_timestamp)
      comment: "Month the HCP master record was created — tracks data ingestion velocity and registry growth over time."
  measures:
    - name: "total_active_hcps"
      expr: COUNT(CASE WHEN hcp_status = 'Active' THEN master_id END)
      comment: "Total number of HCPs with Active status — the actionable prescriber universe for commercial and medical engagement."
    - name: "total_hcps"
      expr: COUNT(master_id)
      comment: "Total HCP records in the master registry — baseline population size for coverage and penetration calculations."
    - name: "total_kols"
      expr: COUNT(CASE WHEN kol_status IS NOT NULL AND kol_status <> '' AND kol_status <> 'Non-KOL' THEN master_id END)
      comment: "Total HCPs designated as Key Opinion Leaders — tracks the size of the KOL engagement pool for medical affairs."
    - name: "prescribing_authority_hcp_count"
      expr: COUNT(CASE WHEN prescribing_authority = TRUE THEN master_id END)
      comment: "Number of HCPs with active prescribing authority — defines the universe eligible for product sampling and Rx-focused engagement."
    - name: "sunshine_act_reportable_hcp_count"
      expr: COUNT(CASE WHEN sunshine_act_reportable = TRUE THEN master_id END)
      comment: "Count of HCPs subject to Open Payments / Sunshine Act reporting — drives compliance workload estimation and reporting scope."
    - name: "board_certified_hcp_count"
      expr: COUNT(CASE WHEN board_certification_status = 'Certified' THEN master_id END)
      comment: "Number of HCPs with current board certification — proxy for clinical credentialing quality within the target universe."
    - name: "active_dea_hcp_count"
      expr: COUNT(CASE WHEN dea_status = 'Active' THEN master_id END)
      comment: "Number of HCPs with an active DEA registration — critical for controlled substance sampling eligibility and compliance."
    - name: "expiring_primary_license_count"
      expr: COUNT(CASE WHEN primary_license_expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND primary_license_expiration_date >= CURRENT_DATE() THEN master_id END)
      comment: "HCPs whose primary license expires within 90 days — operational alert metric for compliance and data stewardship teams."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core commercial and medical affairs engagement KPIs — measures HCP interaction volume, channel mix, relationship strength, transfer of value, and follow-up discipline. Used by sales leadership, MSL teams, and brand managers to optimize field force effectiveness and HCP relationship quality."
  source: "`pharmaceuticals_ecm`.`hcp`.`engagement`"
  dimensions:
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of engagement (Detail, Speaker Program, Advisory Board, MSL Interaction, etc.) — primary segmentation for activity analysis."
    - name: "channel"
      expr: channel
      comment: "Engagement channel (Face-to-Face, Virtual, Email, Phone, etc.) — tracks omnichannel mix and digital adoption."
    - name: "engagement_status"
      expr: engagement_status
      comment: "Status of the engagement record (Completed, Planned, Cancelled, No-Show) — filters for realized vs. planned activity."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area associated with the engagement — enables TA-level performance benchmarking."
    - name: "relationship_status"
      expr: relationship_status
      comment: "Current relationship status with the HCP (Active, Lapsed, New, At-Risk) — tracks relationship lifecycle health."
    - name: "relationship_type"
      expr: relationship_type
      comment: "Type of relationship (Commercial, Medical, Clinical, KOL) — segments engagement by function."
    - name: "outcome"
      expr: outcome
      comment: "Recorded outcome of the engagement (Positive, Neutral, Negative, Follow-Up Required) — measures field force effectiveness."
    - name: "call_objective"
      expr: call_objective
      comment: "Primary objective of the engagement call — aligns activity to brand strategy and message delivery goals."
    - name: "territory_assignment"
      expr: territory_assignment
      comment: "Sales territory associated with the engagement — enables territory-level performance analysis."
    - name: "sunshine_act_reportable_flag"
      expr: sunshine_act_reportable_flag
      comment: "Indicates whether the engagement involves a reportable transfer of value under the Sunshine Act."
    - name: "engagement_month"
      expr: DATE_TRUNC('month', engagement_date)
      comment: "Month of the engagement date — supports trend analysis and period-over-period comparisons."
    - name: "engagement_quarter"
      expr: DATE_TRUNC('quarter', engagement_date)
      comment: "Quarter of the engagement date — aligns with quarterly business review cadence."
  measures:
    - name: "total_engagements"
      expr: COUNT(engagement_id)
      comment: "Total number of HCP engagements — baseline activity volume metric for field force productivity tracking."
    - name: "completed_engagements"
      expr: COUNT(CASE WHEN engagement_status = 'Completed' THEN engagement_id END)
      comment: "Number of successfully completed engagements — measures realized field force activity vs. planned."
    - name: "unique_hcps_engaged"
      expr: COUNT(DISTINCT master_id)
      comment: "Number of distinct HCPs reached — measures breadth of engagement coverage across the target universe."
    - name: "total_transfer_of_value_usd"
      expr: SUM(CAST(transfer_of_value_amount AS DOUBLE))
      comment: "Total transfer of value amount in USD across all engagements — critical for Sunshine Act compliance budget tracking and spend governance."
    - name: "avg_relationship_strength_score"
      expr: AVG(CAST(relationship_strength_score AS DOUBLE))
      comment: "Average relationship strength score across engagements — tracks overall quality of HCP relationships and field force effectiveness."
    - name: "medical_inquiry_count"
      expr: COUNT(CASE WHEN medical_inquiry_flag = TRUE THEN engagement_id END)
      comment: "Number of engagements that generated a medical inquiry — measures scientific dialogue depth and MSL pull-through."
    - name: "adverse_event_reported_count"
      expr: COUNT(CASE WHEN adverse_event_reported_flag = TRUE THEN engagement_id END)
      comment: "Number of engagements where an adverse event was reported — pharmacovigilance signal volume from field interactions."
    - name: "consent_obtained_count"
      expr: COUNT(CASE WHEN consent_obtained_flag = TRUE THEN engagement_id END)
      comment: "Number of engagements where HCP consent was captured — tracks consent compliance rate across field interactions."
    - name: "samples_provided_count"
      expr: COUNT(CASE WHEN samples_provided_flag = TRUE THEN engagement_id END)
      comment: "Number of engagements where product samples were provided — measures sampling program reach and execution."
    - name: "sunshine_reportable_engagement_count"
      expr: COUNT(CASE WHEN sunshine_act_reportable_flag = TRUE THEN engagement_id END)
      comment: "Number of engagements subject to Sunshine Act reporting — drives compliance workload and reporting scope estimation."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HCP contract portfolio KPIs — tracks contract volume, financial commitments (honoraria, FMV rates), compliance approval status, and Sunshine Act exposure. Used by legal, compliance, and commercial operations to govern HCP contracting spend and regulatory risk."
  source: "`pharmaceuticals_ecm`.`hcp`.`contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of HCP contract (Speaker, Advisory Board, Consulting, Research, etc.) — primary segmentation for spend governance."
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract (Active, Expired, Terminated, Pending) — filters for actionable contract portfolio."
    - name: "compliance_approval_status"
      expr: compliance_approval_status
      comment: "Compliance review and approval status — critical for regulatory risk monitoring and contract execution gating."
    - name: "legal_review_status"
      expr: legal_review_status
      comment: "Legal review status of the contract — tracks legal clearance pipeline and bottlenecks."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit sponsoring the contract — enables BU-level spend allocation and governance."
    - name: "specialty"
      expr: specialty
      comment: "HCP specialty associated with the contract — supports specialty-level FMV benchmarking."
    - name: "country_code"
      expr: country_code
      comment: "Country of the contract — supports multi-country compliance and spend reporting."
    - name: "region"
      expr: region
      comment: "Geographic region of the contract — enables regional spend and compliance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract — required for multi-currency spend normalization."
    - name: "fmv_rate_type"
      expr: fmv_rate_type
      comment: "Fair Market Value rate type applied to the contract — tracks FMV methodology consistency across the portfolio."
    - name: "sunshine_act_reportable"
      expr: sunshine_act_reportable
      comment: "Indicates whether the contract is subject to Sunshine Act / Open Payments reporting."
    - name: "oig_screening_result"
      expr: oig_screening_result
      comment: "OIG exclusion screening result — compliance gate for HCP contracting eligibility."
    - name: "contract_effective_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the contract became effective — supports contract pipeline and spend timing analysis."
  measures:
    - name: "total_contracts"
      expr: COUNT(contract_id)
      comment: "Total number of HCP contracts — baseline portfolio size for governance and compliance oversight."
    - name: "active_contracts"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN contract_id END)
      comment: "Number of currently active HCP contracts — defines the live financial obligation portfolio."
    - name: "total_annual_cap_amount"
      expr: SUM(CAST(annual_cap_amount AS DOUBLE))
      comment: "Total annual cap amount across all contracts — measures maximum financial exposure in the HCP contracting portfolio."
    - name: "avg_honorarium_rate"
      expr: AVG(CAST(honorarium_rate AS DOUBLE))
      comment: "Average honorarium rate across contracts — benchmarks FMV compliance and detects rate outliers requiring review."
    - name: "avg_hourly_rate_max"
      expr: AVG(CAST(hourly_rate_max AS DOUBLE))
      comment: "Average maximum hourly rate across contracts — supports FMV ceiling benchmarking by specialty and region."
    - name: "compliance_approved_contracts"
      expr: COUNT(CASE WHEN compliance_approval_status = 'Approved' THEN contract_id END)
      comment: "Number of contracts with compliance approval — measures compliance clearance rate and identifies bottlenecks."
    - name: "sunshine_reportable_contracts"
      expr: COUNT(CASE WHEN sunshine_act_reportable = TRUE THEN contract_id END)
      comment: "Number of contracts subject to Sunshine Act reporting — drives Open Payments submission scope and compliance workload."
    - name: "oig_flagged_contracts"
      expr: COUNT(CASE WHEN oig_screening_result NOT IN ('Clear', 'Pass') AND oig_screening_result IS NOT NULL THEN contract_id END)
      comment: "Number of contracts where OIG screening returned a non-clear result — critical compliance risk signal requiring immediate review."
    - name: "contracts_pending_compliance"
      expr: COUNT(CASE WHEN compliance_approval_status IN ('Pending', 'Under Review') THEN contract_id END)
      comment: "Number of contracts awaiting compliance approval — operational pipeline metric for compliance team workload management."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_sunshine_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Open Payments / Sunshine Act transfer of value KPIs — tracks payment amounts, nature of payment distribution, CMS reporting status, and dispute rates. Used by compliance, legal, and finance leadership to govern regulatory reporting obligations and financial transparency."
  source: "`pharmaceuticals_ecm`.`hcp`.`sunshine_transfer`"
  dimensions:
    - name: "nature_of_payment"
      expr: nature_of_payment
      comment: "Nature of payment category as defined by CMS Open Payments (Consulting Fee, Honoraria, Food & Beverage, Travel, Research, etc.)."
    - name: "payment_type"
      expr: payment_type
      comment: "Payment type classification — supports spend categorization for compliance and financial reporting."
    - name: "recipient_type"
      expr: recipient_type
      comment: "Recipient type (Physician, Teaching Hospital, Non-Physician Practitioner) — required for CMS Open Payments segmentation."
    - name: "cms_reporting_status"
      expr: cms_reporting_status
      comment: "CMS submission and reporting status (Submitted, Pending, Disputed, Published) — tracks Open Payments compliance pipeline."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Dispute status of the transfer record — identifies contested payments requiring resolution before CMS publication."
    - name: "form_of_payment"
      expr: form_of_payment
      comment: "Form of payment (Cash, Check, In-Kind, Stock) — supports payment method analysis for compliance review."
    - name: "payment_currency"
      expr: payment_currency
      comment: "Currency of the payment — required for multi-currency normalization and USD conversion validation."
    - name: "recipient_specialty"
      expr: recipient_specialty
      comment: "Specialty of the payment recipient — enables specialty-level spend analysis and FMV benchmarking."
    - name: "recipient_state"
      expr: recipient_state
      comment: "State of the payment recipient — supports geographic spend distribution and state-level compliance analysis."
    - name: "recipient_country"
      expr: recipient_country
      comment: "Country of the payment recipient — enables global spend reporting and jurisdiction-level compliance tracking."
    - name: "program_year"
      expr: program_year
      comment: "CMS program year of the transfer — aligns payments to annual Open Payments reporting cycles."
    - name: "product_name"
      expr: product_name
      comment: "Product associated with the transfer of value — enables product-level spend attribution for brand compliance."
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of the payment — supports spend trend analysis and period-over-period compliance monitoring."
    - name: "delay_publication_indicator"
      expr: delay_publication_indicator
      comment: "Indicates whether CMS publication of this transfer has been delayed (e.g., due to research exemption)."
    - name: "research_information_indicator"
      expr: research_information_indicator
      comment: "Indicates whether the transfer is associated with a research activity — affects CMS reporting categorization."
  measures:
    - name: "total_payment_amount_usd"
      expr: SUM(CAST(payment_amount_usd AS DOUBLE))
      comment: "Total transfer of value amount in USD — primary financial KPI for Sunshine Act compliance and spend governance."
    - name: "total_transfers"
      expr: COUNT(sunshine_transfer_id)
      comment: "Total number of transfer of value records — baseline volume metric for Open Payments reporting scope."
    - name: "unique_recipients"
      expr: COUNT(DISTINCT master_id)
      comment: "Number of distinct HCP recipients of transfers — measures breadth of financial relationship exposure."
    - name: "avg_payment_amount_usd"
      expr: AVG(CAST(payment_amount_usd AS DOUBLE))
      comment: "Average transfer of value per record in USD — benchmarks payment levels and detects outliers requiring FMV review."
    - name: "disputed_transfer_count"
      expr: COUNT(CASE WHEN dispute_status IS NOT NULL AND dispute_status <> 'Resolved' AND dispute_status <> 'No Dispute' THEN sunshine_transfer_id END)
      comment: "Number of transfers with an active dispute — tracks Open Payments dispute resolution backlog and compliance risk."
    - name: "disputed_transfer_amount_usd"
      expr: SUM(CASE WHEN dispute_status IS NOT NULL AND dispute_status <> 'Resolved' AND dispute_status <> 'No Dispute' THEN CAST(payment_amount_usd AS DOUBLE) ELSE 0 END)
      comment: "Total USD value of disputed transfers — quantifies financial exposure in the Open Payments dispute pipeline."
    - name: "cms_submitted_transfer_count"
      expr: COUNT(CASE WHEN cms_reporting_status = 'Submitted' THEN sunshine_transfer_id END)
      comment: "Number of transfers successfully submitted to CMS — measures Open Payments reporting completion rate."
    - name: "cms_pending_transfer_count"
      expr: COUNT(CASE WHEN cms_reporting_status = 'Pending' THEN sunshine_transfer_id END)
      comment: "Number of transfers pending CMS submission — operational compliance pipeline metric for submission deadline management."
    - name: "research_transfer_amount_usd"
      expr: SUM(CASE WHEN research_information_indicator = TRUE THEN CAST(payment_amount_usd AS DOUBLE) ELSE 0 END)
      comment: "Total USD value of research-associated transfers — tracks research spend subject to delayed CMS publication rules."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_speaker_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Speaker program financial and compliance KPIs — tracks honoraria spend, program delivery rates, compliance certification status, and Sunshine Act exposure. Used by commercial operations, compliance, and brand teams to govern speaker bureau investment and regulatory risk."
  source: "`pharmaceuticals_ecm`.`hcp`.`speaker_program`"
  dimensions:
    - name: "speaker_tier"
      expr: speaker_tier
      comment: "Speaker tier classification (Tier 1, 2, 3) — drives honoraria rate benchmarking and program investment prioritization."
    - name: "compliance_approval_status"
      expr: compliance_approval_status
      comment: "Compliance approval status of the speaker program — gates program execution and tracks regulatory clearance pipeline."
    - name: "compliance_certification_status"
      expr: compliance_certification_status
      comment: "Speaker compliance certification status — ensures speakers meet training and certification requirements before program delivery."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Speaker enrollment status in the bureau (Active, Pending, Suspended, Terminated) — tracks bureau roster health."
    - name: "sunshine_act_reportable_flag"
      expr: sunshine_act_reportable_flag
      comment: "Indicates whether the speaker program generates Sunshine Act reportable transfers of value."
    - name: "honorarium_currency_code"
      expr: honorarium_currency_code
      comment: "Currency of the honorarium payment — required for multi-currency spend normalization."
    - name: "program_event_number"
      expr: program_event_number
      comment: "Unique program event identifier — supports event-level drill-down and reconciliation."
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month the speaker was enrolled — tracks bureau growth and onboarding velocity over time."
    - name: "compliance_approval_month"
      expr: DATE_TRUNC('month', compliance_approval_date)
      comment: "Month compliance approval was granted — measures compliance clearance cycle time trends."
  measures:
    - name: "total_speaker_programs"
      expr: COUNT(speaker_program_id)
      comment: "Total number of speaker program records — baseline portfolio size for bureau governance."
    - name: "active_enrolled_speakers"
      expr: COUNT(CASE WHEN enrollment_status = 'Active' THEN speaker_program_id END)
      comment: "Number of actively enrolled speakers — measures available bureau capacity for program delivery."
    - name: "total_honorarium_paid_usd"
      expr: SUM(CAST(honorarium_paid_usd AS DOUBLE))
      comment: "Total honoraria paid to speakers in USD — primary financial KPI for speaker bureau spend governance and budget tracking."
    - name: "total_spend_usd"
      expr: SUM(CAST(total_spend_usd AS DOUBLE))
      comment: "Total program spend in USD including all costs — comprehensive financial exposure metric for speaker bureau investment."
    - name: "avg_honorarium_rate_usd"
      expr: AVG(CAST(honorarium_rate_usd AS DOUBLE))
      comment: "Average honorarium rate per speaker in USD — benchmarks FMV compliance and detects rate outliers."
    - name: "avg_speaker_performance_rating"
      expr: AVG(CAST(speaker_performance_rating AS DOUBLE))
      comment: "Average speaker performance rating — measures bureau quality and informs speaker tier review decisions."
    - name: "sunshine_reportable_program_count"
      expr: COUNT(CASE WHEN sunshine_act_reportable_flag = TRUE THEN speaker_program_id END)
      comment: "Number of speaker programs generating Sunshine Act reportable transfers — drives Open Payments reporting scope."
    - name: "compliance_approved_program_count"
      expr: COUNT(CASE WHEN compliance_approval_status = 'Approved' THEN speaker_program_id END)
      comment: "Number of speaker programs with compliance approval — measures clearance rate and identifies approval bottlenecks."
    - name: "certified_speaker_count"
      expr: COUNT(CASE WHEN compliance_certification_status = 'Certified' THEN speaker_program_id END)
      comment: "Number of speakers with current compliance certification — ensures bureau readiness and regulatory eligibility."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HCP consent and privacy compliance KPIs — tracks opt-in/opt-out rates, consent expiration, DNC flags, and channel sync status. Used by compliance, digital, and commercial operations to govern data privacy obligations (GDPR, CCPA, HIPAA) and ensure lawful HCP engagement."
  source: "`pharmaceuticals_ecm`.`hcp`.`consent_record`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (Marketing, Medical, Research, Digital, etc.) — primary segmentation for privacy compliance analysis."
    - name: "consent_status"
      expr: consent_status
      comment: "Current consent status (Active, Expired, Withdrawn, Pending) — determines HCP reachability for each channel."
    - name: "channel"
      expr: channel
      comment: "Communication channel covered by the consent (Email, Phone, Digital, In-Person) — enables channel-level compliance analysis."
    - name: "consent_method"
      expr: consent_method
      comment: "Method by which consent was obtained (Written, Electronic, Verbal, Implied) — tracks consent quality and enforceability."
    - name: "regulatory_basis"
      expr: regulatory_basis
      comment: "Legal basis for processing (GDPR Legitimate Interest, GDPR Consent, CCPA, HIPAA, etc.) — critical for jurisdiction-specific compliance."
    - name: "enforcement_status"
      expr: enforcement_status
      comment: "Enforcement status of the consent record — indicates whether restrictions are actively enforced in downstream systems."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of restriction applied (No Contact, No Email, No Samples, etc.) — drives engagement eligibility filtering."
    - name: "dnc_flag"
      expr: dnc_flag
      comment: "Do Not Contact flag — the most critical privacy compliance dimension; HCPs flagged must be excluded from all outreach."
    - name: "opt_in_flag"
      expr: opt_in_flag
      comment: "Indicates the HCP has affirmatively opted in to communications — required for opt-in jurisdictions."
    - name: "opt_out_flag"
      expr: opt_out_flag
      comment: "Indicates the HCP has opted out of communications — must be honored across all engagement channels."
    - name: "is_current_record"
      expr: is_current_record
      comment: "Indicates whether this is the current active consent record for the HCP-channel combination."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Indicates the consent record is under legal hold — restricts modification and deletion for litigation or regulatory purposes."
    - name: "consent_granted_month"
      expr: DATE_TRUNC('month', consent_granted_date)
      comment: "Month consent was granted — tracks consent acquisition velocity and campaign-driven consent collection."
    - name: "consent_expiration_month"
      expr: DATE_TRUNC('month', consent_expiration_date)
      comment: "Month consent expires — enables proactive consent renewal campaign planning."
  measures:
    - name: "total_consent_records"
      expr: COUNT(consent_record_id)
      comment: "Total consent records in the system — baseline volume for privacy compliance coverage assessment."
    - name: "active_consent_count"
      expr: COUNT(CASE WHEN consent_status = 'Active' AND is_current_record = TRUE THEN consent_record_id END)
      comment: "Number of current active consent records — defines the legally reachable HCP population for each channel."
    - name: "opt_in_hcp_count"
      expr: COUNT(CASE WHEN opt_in_flag = TRUE AND is_current_record = TRUE THEN consent_record_id END)
      comment: "Number of HCPs with active opt-in consent — the addressable universe for opt-in required jurisdictions and channels."
    - name: "opt_out_hcp_count"
      expr: COUNT(CASE WHEN opt_out_flag = TRUE AND is_current_record = TRUE THEN consent_record_id END)
      comment: "Number of HCPs who have opted out — must be excluded from all outreach; tracks suppression list size."
    - name: "dnc_hcp_count"
      expr: COUNT(CASE WHEN dnc_flag = TRUE AND is_current_record = TRUE THEN consent_record_id END)
      comment: "Number of HCPs on the Do Not Contact list — critical compliance metric; any engagement with DNC HCPs is a regulatory violation."
    - name: "expiring_consent_count_90d"
      expr: COUNT(CASE WHEN consent_expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND consent_expiration_date >= CURRENT_DATE() AND consent_status = 'Active' THEN consent_record_id END)
      comment: "Active consent records expiring within 90 days — drives proactive consent renewal campaigns to prevent reachable universe shrinkage."
    - name: "withdrawn_consent_count"
      expr: COUNT(CASE WHEN consent_status = 'Withdrawn' THEN consent_record_id END)
      comment: "Number of withdrawn consent records — tracks consent attrition rate and privacy risk exposure."
    - name: "legal_hold_record_count"
      expr: COUNT(CASE WHEN legal_hold_flag = TRUE THEN consent_record_id END)
      comment: "Number of consent records under legal hold — tracks litigation and regulatory investigation exposure."
    - name: "unique_hcps_with_consent"
      expr: COUNT(DISTINCT master_id)
      comment: "Number of distinct HCPs with at least one consent record — measures privacy program coverage across the HCP universe."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_kol_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key Opinion Leader scientific influence and engagement KPIs — tracks publication output, congress speaking activity, MSL interaction depth, compliance clearance, and KOL tier distribution. Used by medical affairs leadership to prioritize KOL investment and measure scientific engagement ROI."
  source: "`pharmaceuticals_ecm`.`hcp`.`kol_profile`"
  dimensions:
    - name: "kol_tier"
      expr: kol_tier
      comment: "KOL tier classification (National, Regional, Local, Emerging) — primary segmentation for MSL resource allocation."
    - name: "kol_status"
      expr: kol_status
      comment: "Current KOL status (Active, Inactive, Candidate, Disengaged) — tracks KOL lifecycle and engagement health."
    - name: "academic_rank"
      expr: academic_rank
      comment: "Academic rank of the KOL (Professor, Associate Professor, Assistant Professor, etc.) — proxy for institutional influence."
    - name: "compliance_clearance_status"
      expr: compliance_clearance_status
      comment: "Compliance clearance status for KOL engagement — gates MSL interactions and advisory board participation."
    - name: "msl_engagement_strategy"
      expr: msl_engagement_strategy
      comment: "MSL engagement strategy assigned to the KOL — aligns field medical resources to scientific engagement objectives."
    - name: "guideline_authorship_flag"
      expr: guideline_authorship_flag
      comment: "Indicates whether the KOL has authored clinical practice guidelines — highest-influence signal for medical affairs prioritization."
    - name: "department_chair_flag"
      expr: department_chair_flag
      comment: "Indicates whether the KOL holds a department chair position — institutional influence signal for access strategy."
    - name: "society_leadership_flag"
      expr: society_leadership_flag
      comment: "Indicates whether the KOL holds a leadership role in a medical society — key influence signal for guideline and policy impact."
    - name: "clinical_trial_investigator_flag"
      expr: clinical_trial_investigator_flag
      comment: "Indicates whether the KOL is an active clinical trial investigator — links scientific influence to clinical development pipeline."
    - name: "sunshine_act_reportable_flag"
      expr: sunshine_act_reportable_flag
      comment: "Indicates whether KOL engagements generate Sunshine Act reportable transfers — compliance gating dimension."
    - name: "last_publication_month"
      expr: DATE_TRUNC('month', last_publication_date)
      comment: "Month of the KOL's most recent publication — tracks scientific activity recency for engagement prioritization."
    - name: "last_msl_interaction_month"
      expr: DATE_TRUNC('month', last_msl_interaction_date)
      comment: "Month of the most recent MSL interaction — tracks engagement recency and identifies lapsed KOL relationships."
  measures:
    - name: "total_kol_profiles"
      expr: COUNT(kol_profile_id)
      comment: "Total KOL profiles in the system — baseline size of the KOL universe for medical affairs resource planning."
    - name: "active_kols"
      expr: COUNT(CASE WHEN kol_status = 'Active' THEN kol_profile_id END)
      comment: "Number of active KOLs — defines the engaged scientific community available for advisory, speaking, and research activities."
    - name: "compliance_cleared_kols"
      expr: COUNT(CASE WHEN compliance_clearance_status = 'Cleared' THEN kol_profile_id END)
      comment: "Number of KOLs with current compliance clearance — measures the pool eligible for paid engagements and advisory activities."
    - name: "guideline_authors_count"
      expr: COUNT(CASE WHEN guideline_authorship_flag = TRUE THEN kol_profile_id END)
      comment: "Number of KOLs who have authored clinical guidelines — highest-value scientific influence segment for medical affairs investment."
    - name: "society_leaders_count"
      expr: COUNT(CASE WHEN society_leadership_flag = TRUE THEN kol_profile_id END)
      comment: "Number of KOLs in medical society leadership roles — tracks policy and guideline influence network size."
    - name: "clinical_trial_investigator_kol_count"
      expr: COUNT(CASE WHEN clinical_trial_investigator_flag = TRUE THEN kol_profile_id END)
      comment: "Number of KOLs who are active clinical trial investigators — measures overlap between scientific influence and clinical development."
    - name: "kols_with_expiring_compliance_clearance_90d"
      expr: COUNT(CASE WHEN compliance_clearance_expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND compliance_clearance_expiry_date >= CURRENT_DATE() AND compliance_clearance_status = 'Cleared' THEN kol_profile_id END)
      comment: "KOLs whose compliance clearance expires within 90 days — operational alert for compliance renewal to prevent engagement disruption."
    - name: "kols_not_interacted_180d"
      expr: COUNT(CASE WHEN last_msl_interaction_date < DATE_ADD(CURRENT_DATE(), -180) OR last_msl_interaction_date IS NULL THEN kol_profile_id END)
      comment: "Number of KOLs with no MSL interaction in the past 180 days — identifies lapsed relationships requiring re-engagement to protect scientific influence network."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_investigator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical investigator qualification and performance KPIs — tracks GCP training compliance, IRB approval status, enrollment performance, protocol deviation rates, and financial disclosure. Used by clinical operations and medical affairs to govern investigator site selection, qualification, and performance management."
  source: "`pharmaceuticals_ecm`.`hcp`.`investigator`"
  dimensions:
    - name: "investigator_status"
      expr: investigator_status
      comment: "Current investigator status (Active, Qualified, Disqualified, Pending) — primary eligibility dimension for trial assignment."
    - name: "investigator_role"
      expr: investigator_role
      comment: "Role of the investigator (Principal Investigator, Sub-Investigator, Co-Investigator) — determines responsibility level and regulatory obligations."
    - name: "gcp_training_status"
      expr: gcp_training_status
      comment: "GCP training compliance status — mandatory regulatory requirement for all clinical trial investigators."
    - name: "irb_approval_status"
      expr: irb_approval_status
      comment: "IRB approval status for the investigator's site — gates trial initiation and ongoing conduct."
    - name: "financial_disclosure_status"
      expr: financial_disclosure_status
      comment: "Financial disclosure status — required FDA 21 CFR Part 54 compliance for all investigators."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Investigator performance rating — drives site selection decisions for future trials."
    - name: "kol_investigator_flag"
      expr: kol_investigator_flag
      comment: "Indicates whether the investigator is also a KOL — identifies high-value dual-role HCPs for medical affairs and clinical operations."
    - name: "sunshine_act_reportable"
      expr: sunshine_act_reportable
      comment: "Indicates whether investigator payments are subject to Sunshine Act reporting."
    - name: "gcp_training_expiration_month"
      expr: DATE_TRUNC('month', gcp_training_expiration_date)
      comment: "Month GCP training expires — enables proactive renewal planning to maintain investigator eligibility."
    - name: "irb_approval_expiration_month"
      expr: DATE_TRUNC('month', irb_approval_expiration_date)
      comment: "Month IRB approval expires — critical for trial continuity planning and site compliance management."
  measures:
    - name: "total_investigators"
      expr: COUNT(investigator_id)
      comment: "Total number of investigators in the registry — baseline pool size for clinical trial site selection."
    - name: "active_qualified_investigators"
      expr: COUNT(CASE WHEN investigator_status IN ('Active', 'Qualified') THEN investigator_id END)
      comment: "Number of investigators currently active and qualified — defines the eligible pool for new trial assignments."
    - name: "gcp_compliant_investigators"
      expr: COUNT(CASE WHEN gcp_training_status = 'Current' THEN investigator_id END)
      comment: "Number of investigators with current GCP training — measures regulatory compliance readiness of the investigator pool."
    - name: "irb_approved_investigators"
      expr: COUNT(CASE WHEN irb_approval_status = 'Approved' THEN investigator_id END)
      comment: "Number of investigators with current IRB approval — measures site activation readiness for trial initiation."
    - name: "avg_enrollment_rate"
      expr: AVG(CAST(average_enrollment_rate AS DOUBLE))
      comment: "Average patient enrollment rate across investigators — key performance indicator for clinical trial timeline and feasibility planning."
    - name: "investigators_with_expiring_gcp_90d"
      expr: COUNT(CASE WHEN gcp_training_expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND gcp_training_expiration_date >= CURRENT_DATE() THEN investigator_id END)
      comment: "Investigators whose GCP training expires within 90 days — operational alert to prevent compliance lapses that would halt trial conduct."
    - name: "investigators_with_expiring_irb_90d"
      expr: COUNT(CASE WHEN irb_approval_expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND irb_approval_expiration_date >= CURRENT_DATE() THEN investigator_id END)
      comment: "Investigators whose IRB approval expires within 90 days — critical operational alert for trial continuity and regulatory compliance."
    - name: "kol_investigator_count"
      expr: COUNT(CASE WHEN kol_investigator_flag = TRUE THEN investigator_id END)
      comment: "Number of investigators who are also KOLs — identifies the highest-value dual-role HCPs for integrated medical affairs and clinical strategy."
    - name: "financial_disclosure_complete_count"
      expr: COUNT(CASE WHEN financial_disclosure_status = 'Complete' THEN investigator_id END)
      comment: "Number of investigators with complete financial disclosures — measures FDA 21 CFR Part 54 compliance rate across the investigator pool."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_affiliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HCP-HCO affiliation network KPIs — tracks affiliation strength, credentialing status, KOL designations, prescribing authority, and Sunshine Act exposure across the HCP institutional network. Used by commercial, medical affairs, and compliance teams to map influence networks and govern institutional engagement."
  source: "`pharmaceuticals_ecm`.`hcp`.`affiliation`"
  dimensions:
    - name: "affiliation_type"
      expr: affiliation_type
      comment: "Type of HCP-HCO affiliation (Employment, Admitting Privileges, Consulting, Academic Appointment, etc.) — primary segmentation for network analysis."
    - name: "affiliation_status"
      expr: affiliation_status
      comment: "Current status of the affiliation (Active, Inactive, Terminated) — filters for live institutional relationships."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status at the affiliated institution — compliance gate for clinical privileges and engagement eligibility."
    - name: "specialty_at_affiliation"
      expr: specialty_at_affiliation
      comment: "HCP specialty as recorded at the affiliated institution — may differ from primary specialty; used for institution-specific targeting."
    - name: "role_title"
      expr: role_title
      comment: "HCP role title at the affiliated institution — indicates seniority and institutional influence level."
    - name: "formulary_influence_level"
      expr: formulary_influence_level
      comment: "Level of formulary influence the HCP holds at the affiliated institution — critical for market access and formulary strategy."
    - name: "is_primary_affiliation"
      expr: is_primary_affiliation
      comment: "Indicates whether this is the HCP's primary institutional affiliation — used to identify the most important HCO relationship."
    - name: "kol_designation_flag"
      expr: kol_designation_flag
      comment: "KOL designation at the affiliated institution — identifies institution-specific scientific leaders."
    - name: "prescribing_authority_flag"
      expr: prescribing_authority_flag
      comment: "Prescribing authority at the affiliated institution — determines sampling and Rx engagement eligibility at the site level."
    - name: "sunshine_act_reportable_flag"
      expr: sunshine_act_reportable_flag
      comment: "Indicates whether the affiliation relationship generates Sunshine Act reportable transfers."
    - name: "compensation_arrangement_type"
      expr: compensation_arrangement_type
      comment: "Type of compensation arrangement at the affiliation — relevant for FMV analysis and Sunshine Act categorization."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the affiliation record — measures data quality and currency of the HCP network map."
    - name: "affiliation_start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the affiliation began — tracks network growth and institutional relationship dynamics over time."
  measures:
    - name: "total_affiliations"
      expr: COUNT(affiliation_id)
      comment: "Total number of HCP-HCO affiliation records — baseline size of the institutional network map."
    - name: "active_affiliations"
      expr: COUNT(CASE WHEN affiliation_status = 'Active' THEN affiliation_id END)
      comment: "Number of currently active HCP-HCO affiliations — defines the live institutional network for engagement and access strategy."
    - name: "unique_hcps_affiliated"
      expr: COUNT(DISTINCT master_id)
      comment: "Number of distinct HCPs with at least one institutional affiliation — measures network coverage of the HCP universe."
    - name: "avg_affiliation_strength_score"
      expr: AVG(CAST(strength_score AS DOUBLE))
      comment: "Average affiliation strength score — measures overall quality and depth of HCP-HCO institutional relationships."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across affiliation records — tracks master data quality for the HCP network and drives remediation prioritization."
    - name: "kol_designated_affiliations"
      expr: COUNT(CASE WHEN kol_designation_flag = TRUE THEN affiliation_id END)
      comment: "Number of affiliations with KOL designation — maps the institutional distribution of scientific leaders for medical affairs targeting."
    - name: "formulary_influencer_affiliations"
      expr: COUNT(CASE WHEN formulary_influence_level IS NOT NULL AND formulary_influence_level <> 'None' AND formulary_influence_level <> 'Low' THEN affiliation_id END)
      comment: "Number of affiliations where the HCP holds medium or high formulary influence — critical for market access strategy and formulary pull-through."
    - name: "credentialing_expiring_90d"
      expr: COUNT(CASE WHEN credentialing_expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND credentialing_expiration_date >= CURRENT_DATE() AND affiliation_status = 'Active' THEN affiliation_id END)
      comment: "Active affiliations with credentialing expiring within 90 days — operational alert for credentialing renewal to maintain clinical privileges."
    - name: "sunshine_reportable_affiliation_count"
      expr: COUNT(CASE WHEN sunshine_act_reportable_flag = TRUE THEN affiliation_id END)
      comment: "Number of affiliations subject to Sunshine Act reporting — drives Open Payments reporting scope for institutional relationships."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_sample_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product sampling program KPIs — tracks sample request volume, fulfillment rates, sample value, controlled substance compliance, and Sunshine Act exposure. Used by commercial operations, compliance, and brand teams to govern sampling program effectiveness and regulatory adherence."
  source: "`pharmaceuticals_ecm`.`hcp`.`sample_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Status of the sample request (Approved, Pending, Rejected, Fulfilled, Cancelled) — tracks request pipeline health."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of sample delivery (In-Person, Mail, Courier) — tracks channel mix for sampling logistics optimization."
    - name: "controlled_substance_flag"
      expr: controlled_substance_flag
      comment: "Indicates whether the sample is a controlled substance — triggers DEA compliance requirements and enhanced tracking."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule classification of the sampled product — determines regulatory handling requirements."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Sample reconciliation status — tracks inventory accountability and compliance with PDMA sample reconciliation requirements."
    - name: "sunshine_reportable_flag"
      expr: sunshine_reportable_flag
      comment: "Indicates whether the sample transfer is reportable under the Sunshine Act / Open Payments."
    - name: "delivery_state_province"
      expr: delivery_state_province
      comment: "State/province of sample delivery — enables geographic sampling analysis and state-level compliance monitoring."
    - name: "delivery_country_code"
      expr: delivery_country_code
      comment: "Country of sample delivery — supports multi-country sampling compliance and regulatory reporting."
    - name: "request_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month the sample was requested — tracks sampling program activity trends and seasonal patterns."
    - name: "fulfillment_month"
      expr: DATE_TRUNC('month', fulfillment_date)
      comment: "Month the sample was fulfilled — measures fulfillment cycle time and logistics performance."
  measures:
    - name: "total_sample_requests"
      expr: COUNT(sample_request_id)
      comment: "Total number of sample requests — baseline volume metric for sampling program activity and field force execution."
    - name: "fulfilled_sample_requests"
      expr: COUNT(CASE WHEN request_status = 'Fulfilled' THEN sample_request_id END)
      comment: "Number of fulfilled sample requests — measures sampling program execution rate and supply chain effectiveness."
    - name: "total_sample_value_usd"
      expr: SUM(CAST(sample_value_usd AS DOUBLE))
      comment: "Total value of samples distributed in USD — primary financial KPI for sampling program spend governance and Sunshine Act reporting."
    - name: "avg_sample_value_usd"
      expr: AVG(CAST(sample_value_usd AS DOUBLE))
      comment: "Average value per sample request in USD — benchmarks sampling investment per HCP interaction."
    - name: "controlled_substance_request_count"
      expr: COUNT(CASE WHEN controlled_substance_flag = TRUE THEN sample_request_id END)
      comment: "Number of controlled substance sample requests — tracks DEA-regulated sampling volume requiring enhanced compliance oversight."
    - name: "sunshine_reportable_sample_count"
      expr: COUNT(CASE WHEN sunshine_reportable_flag = TRUE THEN sample_request_id END)
      comment: "Number of sample requests subject to Sunshine Act reporting — drives Open Payments sample reporting scope."
    - name: "sunshine_reportable_sample_value_usd"
      expr: SUM(CASE WHEN sunshine_reportable_flag = TRUE THEN CAST(sample_value_usd AS DOUBLE) ELSE 0 END)
      comment: "Total USD value of Sunshine Act reportable samples — quantifies Open Payments sample transfer obligation."
    - name: "rejected_sample_requests"
      expr: COUNT(CASE WHEN request_status = 'Rejected' THEN sample_request_id END)
      comment: "Number of rejected sample requests — tracks compliance rejection rate and identifies systemic issues in the sampling approval process."
    - name: "unique_hcps_sampled"
      expr: COUNT(DISTINCT master_id)
      comment: "Number of distinct HCPs who received samples — measures sampling program reach and HCP coverage."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HCP license and credentialing compliance KPIs — tracks license validity, expiration risk, prescribing authority coverage, disciplinary actions, and DEA schedule authorizations. Used by compliance, commercial operations, and data governance teams to ensure HCP engagement eligibility and regulatory compliance."
  source: "`pharmaceuticals_ecm`.`hcp`.`license`"
  dimensions:
    - name: "license_type"
      expr: license_type
      comment: "Type of license (Medical, DEA, State Controlled Substance, Board Certification, etc.) — primary segmentation for credentialing analysis."
    - name: "license_status"
      expr: license_status
      comment: "Current license status (Active, Expired, Suspended, Revoked, Pending) — determines HCP engagement eligibility."
    - name: "issuing_state"
      expr: issuing_state
      comment: "State that issued the license — enables state-level compliance monitoring and multi-state practice analysis."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the license (State Medical Board, DEA, etc.) — tracks regulatory body coverage."
    - name: "specialty"
      expr: specialty
      comment: "Specialty associated with the license — enables specialty-level credentialing coverage analysis."
    - name: "prescribing_authority"
      expr: prescribing_authority
      comment: "Indicates whether the license grants prescribing authority — critical for sampling and Rx engagement eligibility."
    - name: "controlled_substance_authority"
      expr: controlled_substance_authority
      comment: "Indicates whether the license grants controlled substance prescribing authority — DEA compliance dimension."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule authorized by the license — determines controlled substance prescribing scope."
    - name: "disciplinary_action_flag"
      expr: disciplinary_action_flag
      comment: "Indicates whether a disciplinary action has been recorded against this license — critical compliance risk signal."
    - name: "restriction_flag"
      expr: restriction_flag
      comment: "Indicates whether the license has restrictions — affects HCP engagement eligibility and compliance gating."
    - name: "primary_license_flag"
      expr: primary_license_flag
      comment: "Indicates whether this is the HCP's primary license — used to identify the most authoritative credentialing record."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify the license (Primary Source, NPDB, State Board Query) — tracks data quality and verification rigor."
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the license expires — enables proactive expiration monitoring and renewal campaign planning."
  measures:
    - name: "total_licenses"
      expr: COUNT(license_id)
      comment: "Total license records in the system — baseline credentialing portfolio size."
    - name: "active_licenses"
      expr: COUNT(CASE WHEN license_status = 'Active' AND record_active_flag = TRUE THEN license_id END)
      comment: "Number of currently active and valid licenses — defines the credentialed HCP population eligible for engagement."
    - name: "unique_licensed_hcps"
      expr: COUNT(DISTINCT master_id)
      comment: "Number of distinct HCPs with at least one license record — measures credentialing coverage of the HCP universe."
    - name: "licenses_expiring_90d"
      expr: COUNT(CASE WHEN expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND expiration_date >= CURRENT_DATE() AND license_status = 'Active' THEN license_id END)
      comment: "Active licenses expiring within 90 days — operational alert for compliance teams to trigger renewal outreach and prevent engagement eligibility lapses."
    - name: "disciplinary_action_license_count"
      expr: COUNT(CASE WHEN disciplinary_action_flag = TRUE THEN license_id END)
      comment: "Number of licenses with recorded disciplinary actions — critical compliance risk metric; HCPs with disciplinary actions may be ineligible for contracting."
    - name: "restricted_license_count"
      expr: COUNT(CASE WHEN restriction_flag = TRUE THEN license_id END)
      comment: "Number of licenses with active restrictions — tracks HCPs with limited practice scope that may affect engagement eligibility."
    - name: "prescribing_authority_license_count"
      expr: COUNT(CASE WHEN prescribing_authority = TRUE AND license_status = 'Active' THEN license_id END)
      comment: "Number of active licenses granting prescribing authority — defines the Rx-eligible HCP population for sampling and commercial engagement."
    - name: "controlled_substance_authority_count"
      expr: COUNT(CASE WHEN controlled_substance_authority = TRUE AND license_status = 'Active' THEN license_id END)
      comment: "Number of active licenses granting controlled substance authority — tracks DEA-eligible prescribers for controlled substance sampling programs."
$$;