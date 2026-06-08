-- Metric views for domain: policyholder | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 06:54:29

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_insured`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core KPIs for the insured population — face amount exposure, net amount at risk, underwriting quality, and rider adoption rates. Used by actuarial, underwriting, and product leadership to monitor in-force risk profile and product mix."
  source: "`life_insurance_ecm`.`policyholder`.`insured`"
  dimensions:
    - name: "gender"
      expr: gender
      comment: "Biological gender of the insured, used for mortality segmentation and actuarial analysis."
    - name: "tobacco_status"
      expr: tobacco_status
      comment: "Tobacco use classification (smoker/non-smoker/unknown) — primary underwriting risk factor affecting premium rates."
    - name: "underwriting_decision"
      expr: underwriting_decision
      comment: "Final underwriting decision (approved, rated, declined, postponed) — key quality indicator for the underwriting pipeline."
    - name: "occupation_class"
      expr: occupation_class
      comment: "Occupational risk class assigned during underwriting — drives premium loading and risk segmentation."
    - name: "residency_state"
      expr: residency_state
      comment: "State of residency of the insured — used for geographic risk concentration and regulatory reporting."
    - name: "insured_status"
      expr: insured_status
      comment: "Current lifecycle status of the insured record (active, terminated, deceased, etc.)."
    - name: "role_type"
      expr: role_type
      comment: "Role of the insured on the policy (primary insured, joint insured, etc.)."
    - name: "issue_age_band"
      expr: CASE WHEN CAST(issue_age AS INT) < 30 THEN 'Under 30' WHEN CAST(issue_age AS INT) < 45 THEN '30-44' WHEN CAST(issue_age AS INT) < 60 THEN '45-59' WHEN CAST(issue_age AS INT) < 70 THEN '60-69' ELSE '70+' END
      comment: "Banded issue age grouping for actuarial cohort analysis and mortality risk segmentation."
    - name: "table_rating"
      expr: table_rating
      comment: "Substandard table rating applied to the insured — indicates degree of mortality risk above standard."
    - name: "reinsurance_cession_flag"
      expr: reinsurance_cession_flag
      comment: "Indicates whether the insured's risk has been ceded to a reinsurer — critical for net retained exposure reporting."
    - name: "coverage_effective_year"
      expr: DATE_TRUNC('YEAR', coverage_effective_date)
      comment: "Year the coverage became effective — used for vintage cohort analysis of in-force block."
  measures:
    - name: "total_face_amount"
      expr: SUM(CAST(face_amount AS DOUBLE))
      comment: "Total face amount (death benefit) across all insured records. Primary measure of gross mortality exposure — directly drives reinsurance treaties, reserve calculations, and capital requirements."
    - name: "total_net_amount_at_risk"
      expr: SUM(CAST(nar_amount AS DOUBLE))
      comment: "Total net amount at risk (NAR) — face amount minus policy reserve/cash value. The true economic mortality exposure retained by the company; key input to pricing, reinsurance, and capital modeling."
    - name: "avg_face_amount_per_insured"
      expr: AVG(CAST(face_amount AS DOUBLE))
      comment: "Average face amount per insured record. Tracks policy size trends over time — shifts indicate changes in target market, distribution mix, or product design."
    - name: "avg_flat_extra_premium"
      expr: AVG(CAST(flat_extra_premium AS DOUBLE))
      comment: "Average flat extra premium loading per insured. Measures the average substandard risk surcharge — rising values indicate deteriorating underwriting quality or adverse selection."
    - name: "total_flat_extra_premium"
      expr: SUM(CAST(flat_extra_premium AS DOUBLE))
      comment: "Total flat extra premium revenue from substandard risks. Quantifies the financial contribution of rated policies to the premium base."
    - name: "rated_insured_count"
      expr: COUNT(CASE WHEN table_rating IS NOT NULL AND table_rating <> '' THEN insured_id END)
      comment: "Count of insureds with a substandard table rating applied. Tracks the volume of rated risks in the in-force block — used to monitor underwriting risk concentration."
    - name: "reinsurance_cession_count"
      expr: COUNT(CASE WHEN reinsurance_cession_flag = TRUE THEN insured_id END)
      comment: "Number of insured records where risk has been ceded to reinsurers. Used to validate reinsurance treaty utilization and ensure cession limits are respected."
    - name: "reinsurance_cession_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reinsurance_cession_flag = TRUE THEN insured_id END) / NULLIF(COUNT(insured_id), 0), 2)
      comment: "Percentage of insured records with reinsurance cession. Monitors the proportion of the in-force block covered by reinsurance — a key risk management and capital efficiency metric."
    - name: "ltc_rider_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ltc_rider_flag = TRUE THEN insured_id END) / NULLIF(COUNT(insured_id), 0), 2)
      comment: "Percentage of insureds with a long-term care (LTC) rider attached. Tracks LTC rider penetration — a strategic product cross-sell metric and a driver of long-term liability exposure."
    - name: "waiver_of_premium_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_of_premium_flag = TRUE THEN insured_id END) / NULLIF(COUNT(insured_id), 0), 2)
      comment: "Percentage of insureds with waiver of premium rider. Indicates disability-linked benefit exposure and rider revenue contribution."
    - name: "exclusion_rider_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exclusion_rider_flag = TRUE THEN insured_id END) / NULLIF(COUNT(insured_id), 0), 2)
      comment: "Percentage of insureds with an exclusion rider applied. High rates may indicate adverse selection or underwriting conservatism — monitored by product and actuarial teams."
    - name: "mib_adverse_hit_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mib_check_status = 'HIT' THEN insured_id END) / NULLIF(COUNT(CASE WHEN mib_check_status IS NOT NULL THEN insured_id END), 0), 2)
      comment: "Percentage of MIB checks returning a hit (adverse medical history flag). A leading indicator of underwriting risk quality — rising rates may signal adverse selection in the applicant pool."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_annuitant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the annuitant population — benefit base exposure, guaranteed benefit rider adoption, mortality risk, and payout structure. Used by actuarial, product, and finance leadership to manage annuity liability and longevity risk."
  source: "`life_insurance_ecm`.`policyholder`.`annuitant`"
  dimensions:
    - name: "annuity_type"
      expr: annuity_type
      comment: "Type of annuity contract (fixed, variable, indexed, immediate, deferred) — primary product segmentation dimension."
    - name: "gender"
      expr: gender
      comment: "Gender of the annuitant — key longevity risk factor for actuarial pricing and reserve calculations."
    - name: "role_status"
      expr: role_status
      comment: "Current status of the annuitant role (active, deceased, terminated) — used to filter in-force vs. terminated populations."
    - name: "role_type"
      expr: role_type
      comment: "Role type of the annuitant (primary, joint) — determines payout structure and survivor benefit obligations."
    - name: "payout_option_code"
      expr: payout_option_code
      comment: "Selected payout option (life only, period certain, joint and survivor, etc.) — drives liability duration and cash flow projections."
    - name: "death_benefit_option"
      expr: death_benefit_option
      comment: "Death benefit option selected — determines the guaranteed minimum death benefit structure and associated liability."
    - name: "contract_qualification_type"
      expr: contract_qualification_type
      comment: "Tax qualification type of the annuity contract (qualified/non-qualified, IRA, 403b, etc.) — affects RMD obligations and tax reporting."
    - name: "state_of_issue"
      expr: state_of_issue
      comment: "State where the annuity contract was issued — used for geographic concentration and regulatory compliance reporting."
    - name: "kyc_status"
      expr: kyc_status
      comment: "Know Your Customer verification status of the annuitant — compliance monitoring dimension."
    - name: "issue_age_band"
      expr: CASE WHEN CAST(issue_age AS INT) < 50 THEN 'Under 50' WHEN CAST(issue_age AS INT) < 60 THEN '50-59' WHEN CAST(issue_age AS INT) < 70 THEN '60-69' WHEN CAST(issue_age AS INT) < 80 THEN '70-79' ELSE '80+' END
      comment: "Banded issue age for longevity risk cohort analysis — older issue ages carry higher longevity and payout risk."
    - name: "annuity_start_year"
      expr: DATE_TRUNC('YEAR', annuity_start_date)
      comment: "Year the annuity payout phase commenced — used for vintage cohort analysis of payout liability."
    - name: "suitability_review_status"
      expr: suitability_review_status
      comment: "Status of the suitability review for the annuitant — regulatory compliance dimension required by FINRA/SEC rules."
  measures:
    - name: "total_benefit_base_amount"
      expr: SUM(CAST(benefit_base_amount AS DOUBLE))
      comment: "Total guaranteed benefit base across all annuitants. The benefit base is the foundation for GMIB/GMWB/GMAB calculations — a primary driver of annuity reserve and capital requirements."
    - name: "avg_benefit_base_amount"
      expr: AVG(CAST(benefit_base_amount AS DOUBLE))
      comment: "Average benefit base per annuitant. Tracks average contract size trends — shifts indicate changes in distribution mix or product design effectiveness."
    - name: "total_death_benefit_amount"
      expr: SUM(CAST(death_benefit_amount AS DOUBLE))
      comment: "Total guaranteed minimum death benefit (GMDB) exposure across all annuitants. A key liability metric for actuarial reserving and reinsurance treaty sizing."
    - name: "avg_death_benefit_amount"
      expr: AVG(CAST(death_benefit_amount AS DOUBLE))
      comment: "Average guaranteed minimum death benefit per annuitant. Used to benchmark product design against market and assess average liability per contract."
    - name: "gmib_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gmib_indicator = TRUE THEN annuitant_id END) / NULLIF(COUNT(annuitant_id), 0), 2)
      comment: "Percentage of annuitants with a Guaranteed Minimum Income Benefit (GMIB) rider. GMIB riders represent significant long-term liability — adoption rate is a critical product risk and revenue metric."
    - name: "gmwb_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gmwb_indicator = TRUE THEN annuitant_id END) / NULLIF(COUNT(annuitant_id), 0), 2)
      comment: "Percentage of annuitants with a Guaranteed Minimum Withdrawal Benefit (GMWB) rider. GMWB is the most common living benefit rider — adoption rate drives fee revenue and longevity reserve requirements."
    - name: "gmab_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gmab_indicator = TRUE THEN annuitant_id END) / NULLIF(COUNT(annuitant_id), 0), 2)
      comment: "Percentage of annuitants with a Guaranteed Minimum Accumulation Benefit (GMAB) rider. GMAB adoption indicates market risk exposure — rising rates increase hedging program costs."
    - name: "gmdb_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gmdb_indicator = TRUE THEN annuitant_id END) / NULLIF(COUNT(annuitant_id), 0), 2)
      comment: "Percentage of annuitants with a Guaranteed Minimum Death Benefit (GMDB) rider. Tracks mortality-linked liability exposure within the annuity block."
    - name: "joint_annuitant_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_joint_annuitant = TRUE THEN annuitant_id END) / NULLIF(COUNT(annuitant_id), 0), 2)
      comment: "Percentage of annuitants designated as joint annuitants. Joint contracts extend payout duration and increase longevity liability — a key actuarial risk concentration metric."
    - name: "avg_joint_survivor_pct"
      expr: AVG(CAST(joint_survivor_pct AS DOUBLE))
      comment: "Average joint and survivor continuation percentage across joint annuity contracts. Determines the fraction of benefit continuing to the surviving annuitant — directly impacts long-term cash flow projections."
    - name: "avg_withholding_pct"
      expr: AVG(CAST(withholding_pct AS DOUBLE))
      comment: "Average tax withholding election percentage across annuitants. Monitors compliance with IRS withholding requirements and operational tax processing efficiency."
    - name: "rmd_required_annuitant_count"
      expr: COUNT(CASE WHEN rmd_required_begin_date IS NOT NULL THEN annuitant_id END)
      comment: "Number of annuitants subject to Required Minimum Distribution (RMD) rules. RMD compliance is a regulatory obligation — this count drives operational workload and IRS penalty risk exposure."
    - name: "deceased_annuitant_count"
      expr: COUNT(CASE WHEN death_date IS NOT NULL THEN annuitant_id END)
      comment: "Number of annuitants with a recorded death date. Tracks mortality experience against actuarial assumptions — a key input to experience studies and reserve adequacy reviews."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_party`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master party (customer) KPIs covering compliance risk ratings, KYC/OFAC screening status, and demographic profile. Used by compliance, operations, and customer management leadership to monitor the quality and risk profile of the policyholder master data."
  source: "`life_insurance_ecm`.`policyholder`.`party`"
  dimensions:
    - name: "party_type"
      expr: party_type
      comment: "Type of party (individual, corporation, trust, estate, etc.) — primary segmentation for customer analytics and compliance workflows."
    - name: "party_status"
      expr: party_status
      comment: "Current lifecycle status of the party record (active, inactive, deceased, merged) — used to filter active customer population."
    - name: "gender"
      expr: gender
      comment: "Gender of the party — used for demographic analysis and actuarial segmentation."
    - name: "residency_state"
      expr: residency_state
      comment: "State of residency — used for geographic concentration analysis and state regulatory reporting."
    - name: "residency_country"
      expr: residency_country
      comment: "Country of residency — used for foreign national risk identification and FATCA/CRS compliance."
    - name: "citizenship_country"
      expr: citizenship_country
      comment: "Country of citizenship — key compliance dimension for OFAC sanctions screening and foreign national underwriting."
    - name: "kyc_status"
      expr: kyc_status
      comment: "Know Your Customer verification status — primary compliance health indicator for the party master."
    - name: "ofac_screening_status"
      expr: ofac_screening_status
      comment: "OFAC sanctions screening status (clear, hit, pending) — critical regulatory compliance dimension."
    - name: "aml_risk_rating"
      expr: aml_risk_rating
      comment: "Anti-Money Laundering risk rating assigned to the party (low, medium, high) — drives enhanced due diligence requirements and monitoring intensity."
    - name: "tin_certification_status"
      expr: tin_certification_status
      comment: "IRS TIN certification status — drives B-Notice and backup withholding obligations."
    - name: "trust_type"
      expr: trust_type
      comment: "Type of trust entity (revocable, irrevocable, ILIT, etc.) — used for trust-specific compliance and ownership analysis."
  measures:
    - name: "active_party_count"
      expr: COUNT(CASE WHEN party_status = 'ACTIVE' THEN party_id END)
      comment: "Count of active party records. The primary measure of the active customer base — used to track growth, attrition, and operational scale."
    - name: "kyc_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN kyc_status = 'VERIFIED' THEN party_id END) / NULLIF(COUNT(party_id), 0), 2)
      comment: "Percentage of parties with a verified KYC status. A core compliance health metric — regulators and internal audit use this to assess AML program effectiveness. Falling rates trigger remediation programs."
    - name: "ofac_hit_count"
      expr: COUNT(CASE WHEN ofac_screening_status = 'HIT' THEN party_id END)
      comment: "Number of parties with an active OFAC sanctions hit. A critical regulatory risk metric — any unresolved OFAC hits represent potential regulatory violations with severe financial penalties."
    - name: "pep_flagged_party_count"
      expr: COUNT(CASE WHEN pep_flag = TRUE THEN party_id END)
      comment: "Number of parties flagged as Politically Exposed Persons (PEPs). PEP relationships require enhanced due diligence — this count drives compliance resource allocation and regulatory reporting."
    - name: "sar_flagged_party_count"
      expr: COUNT(CASE WHEN sar_flag = TRUE THEN party_id END)
      comment: "Number of parties with a Suspicious Activity Report (SAR) flag. SAR-flagged parties represent active AML investigations — monitored by compliance leadership and reported to FinCEN."
    - name: "stoli_flagged_party_count"
      expr: COUNT(CASE WHEN stoli_indicator = TRUE THEN party_id END)
      comment: "Number of parties flagged for Stranger-Originated Life Insurance (STOLI) indicators. STOLI represents a significant fraud and insurable interest risk — flagged parties require immediate underwriting review."
    - name: "high_aml_risk_party_count"
      expr: COUNT(CASE WHEN aml_risk_rating = 'HIGH' THEN party_id END)
      comment: "Number of parties rated as high AML risk. High-risk parties require enhanced due diligence and more frequent monitoring — this count drives compliance program resourcing and risk concentration reporting."
    - name: "high_aml_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN aml_risk_rating = 'HIGH' THEN party_id END) / NULLIF(COUNT(party_id), 0), 2)
      comment: "Percentage of parties rated as high AML risk. Tracks the risk concentration trend in the customer base — rising rates indicate deteriorating portfolio risk quality and increased compliance burden."
    - name: "deceased_party_count"
      expr: COUNT(CASE WHEN deceased_date IS NOT NULL THEN party_id END)
      comment: "Number of parties with a recorded deceased date. Tracks mortality experience in the customer base — used to trigger claims processing, beneficiary notifications, and estate settlement workflows."
    - name: "tin_uncertified_party_count"
      expr: COUNT(CASE WHEN tin_certification_status <> 'CERTIFIED' OR tin_certification_status IS NULL THEN party_id END)
      comment: "Number of parties without a certified TIN. Uncertified TINs trigger IRS B-Notice obligations and backup withholding requirements — a key tax compliance operational metric."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_kyc_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KYC and AML compliance KPIs covering verification outcomes, risk scores, enhanced due diligence rates, and OFAC/PEP screening results. Used by compliance, legal, and risk leadership to monitor regulatory program effectiveness and identify remediation needs."
  source: "`life_insurance_ecm`.`policyholder`.`kyc_verification`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Outcome of the KYC verification (passed, failed, pending, escalated) — primary compliance health dimension."
    - name: "verification_type"
      expr: verification_type
      comment: "Type of KYC verification performed (initial, periodic review, trigger-based) — used to segment compliance workload and program coverage."
    - name: "kyc_program_type"
      expr: kyc_program_type
      comment: "KYC program under which the verification was conducted (CIP, CDD, EDD) — maps to regulatory requirement tiers."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned as a result of the KYC review (low, medium, high) — drives ongoing monitoring intensity and EDD requirements."
    - name: "party_role"
      expr: party_role
      comment: "Role of the party being verified (policyholder, beneficiary, owner, annuitant) — used to segment compliance coverage by party function."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction under which the KYC verification was conducted — used for cross-border compliance reporting."
    - name: "identity_document_type"
      expr: identity_document_type
      comment: "Type of identity document used for verification (passport, driver license, national ID) — tracks document quality and fraud risk."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify identity (in-person, electronic, third-party service) — used to assess verification quality and cost efficiency."
    - name: "trigger_event"
      expr: trigger_event
      comment: "Event that triggered the KYC review (new business, ownership change, periodic review, suspicious activity) — used to analyze compliance workload drivers."
    - name: "verification_year"
      expr: DATE_TRUNC('YEAR', verification_date)
      comment: "Year of KYC verification — used for trend analysis of compliance program throughput and pass rates over time."
  measures:
    - name: "kyc_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'PASSED' THEN kyc_verification_id END) / NULLIF(COUNT(kyc_verification_id), 0), 2)
      comment: "Percentage of KYC verifications that passed. The primary KYC program effectiveness metric — falling pass rates indicate data quality issues, adverse selection, or process failures requiring immediate remediation."
    - name: "edd_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN enhanced_due_diligence_required = TRUE THEN kyc_verification_id END) / NULLIF(COUNT(kyc_verification_id), 0), 2)
      comment: "Percentage of KYC verifications requiring Enhanced Due Diligence (EDD). EDD is resource-intensive — this rate drives compliance staffing decisions and indicates the risk concentration in the customer base."
    - name: "ofac_match_count"
      expr: COUNT(CASE WHEN ofac_match_flag = TRUE THEN kyc_verification_id END)
      comment: "Number of KYC verifications with an OFAC sanctions match. Any OFAC match requires immediate escalation and potential transaction blocking — a zero-tolerance regulatory compliance metric."
    - name: "ofac_match_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ofac_match_flag = TRUE THEN kyc_verification_id END) / NULLIF(COUNT(kyc_verification_id), 0), 2)
      comment: "Percentage of KYC verifications resulting in an OFAC match. Tracks the sanctions risk concentration in new and existing business — used to calibrate screening program sensitivity."
    - name: "avg_ofac_match_score"
      expr: AVG(CAST(ofac_match_score AS DOUBLE))
      comment: "Average OFAC screening match score across all verifications. Higher average scores indicate more ambiguous matches requiring manual review — drives false positive rate and operational cost of the screening program."
    - name: "pep_flagged_verification_count"
      expr: COUNT(CASE WHEN pep_flag = TRUE THEN kyc_verification_id END)
      comment: "Number of KYC verifications where the party was identified as a Politically Exposed Person (PEP). PEP relationships require EDD and senior management approval — this count drives compliance escalation workload."
    - name: "sar_filed_count"
      expr: COUNT(CASE WHEN sar_flag = TRUE THEN kyc_verification_id END)
      comment: "Number of KYC verifications resulting in a Suspicious Activity Report (SAR) filing. SAR filings represent the most serious AML compliance outcomes — tracked by compliance leadership and reported to FinCEN."
    - name: "source_of_funds_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN source_of_funds_verified = TRUE THEN kyc_verification_id END) / NULLIF(COUNT(kyc_verification_id), 0), 2)
      comment: "Percentage of KYC verifications where source of funds was successfully verified. Source of funds verification is a core AML control — low rates indicate gaps in the CDD program that regulators will cite."
    - name: "beneficial_owner_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN beneficial_owner_verified = TRUE THEN kyc_verification_id END) / NULLIF(COUNT(kyc_verification_id), 0), 2)
      comment: "Percentage of KYC verifications where beneficial ownership was verified. FinCEN's Beneficial Ownership Rule requires verification for legal entity customers — this rate measures regulatory compliance with that requirement."
    - name: "stoli_flagged_verification_count"
      expr: COUNT(CASE WHEN stoli_indicator = TRUE THEN kyc_verification_id END)
      comment: "Number of KYC verifications flagging a STOLI (Stranger-Originated Life Insurance) indicator. STOLI represents insurable interest fraud — flagged cases require immediate underwriting and legal review."
    - name: "expiring_kyc_count"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND expiry_date >= CURRENT_DATE() THEN kyc_verification_id END)
      comment: "Number of KYC verifications expiring within the next 90 days. Drives the periodic review workload pipeline — used by compliance operations to plan staffing and prioritize renewal outreach."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_death_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Death verification process KPIs covering verification completeness, DMF match rates, proactive search activity, and claim initiation timeliness. Used by claims, compliance, and operations leadership to monitor mortality processing quality and regulatory compliance with unclaimed property laws."
  source: "`life_insurance_ecm`.`policyholder`.`death_verification`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Current status of the death verification (pending, verified, rejected, under review) — primary operational health dimension."
    - name: "verification_type"
      expr: verification_type
      comment: "Method by which death was verified (death certificate, DMF match, obituary, third-party service) — used to assess verification quality and cost."
    - name: "verification_confidence_level"
      expr: verification_confidence_level
      comment: "Confidence level of the death verification (high, medium, low) — used to prioritize manual review and escalation workflows."
    - name: "cause_of_death"
      expr: cause_of_death
      comment: "Cause of death classification — used for mortality experience studies and contestability analysis."
    - name: "manner_of_death"
      expr: manner_of_death
      comment: "Manner of death (natural, accidental, suicide, homicide) — critical for contestability, exclusion clause application, and accidental death benefit eligibility."
    - name: "place_of_death_state"
      expr: place_of_death_state
      comment: "State where death occurred — used for geographic mortality analysis and state-specific unclaimed property compliance."
    - name: "death_certificate_issuing_state"
      expr: death_certificate_issuing_state
      comment: "State that issued the death certificate — used for document validation and jurisdictional compliance."
    - name: "death_year"
      expr: DATE_TRUNC('YEAR', death_date)
      comment: "Year of death — used for mortality experience cohort analysis and trend reporting."
    - name: "proactive_search_flag"
      expr: proactive_search_flag
      comment: "Indicates whether the death was identified through a proactive search program (vs. claim-initiated). Proactive identification is required by state unclaimed property laws — a key regulatory compliance dimension."
  measures:
    - name: "death_verification_count"
      expr: COUNT(death_verification_id)
      comment: "Total number of death verification records processed. Tracks mortality processing volume — used to monitor operational capacity and compare against actuarial mortality assumptions."
    - name: "verified_death_count"
      expr: COUNT(CASE WHEN verification_status = 'VERIFIED' THEN death_verification_id END)
      comment: "Number of deaths successfully verified. The primary throughput metric for the death verification process — used to track completion rates and identify processing backlogs."
    - name: "death_certificate_receipt_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN death_certificate_received_flag = TRUE THEN death_verification_id END) / NULLIF(COUNT(death_verification_id), 0), 2)
      comment: "Percentage of death verifications with a death certificate received. Death certificate receipt is a prerequisite for claim payment — low rates indicate documentation gaps that delay benefit payments and create regulatory risk."
    - name: "dmf_match_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dmf_match_flag = TRUE THEN death_verification_id END) / NULLIF(COUNT(death_verification_id), 0), 2)
      comment: "Percentage of death verifications matched via the Death Master File (DMF). DMF matching is the primary proactive death identification tool — match rates indicate the effectiveness of the proactive search program required by state regulators."
    - name: "avg_dmf_match_score"
      expr: AVG(CAST(dmf_match_score AS DOUBLE))
      comment: "Average DMF match confidence score. Lower average scores indicate more ambiguous matches requiring manual review — used to calibrate DMF matching thresholds and manage false positive rates."
    - name: "proactive_search_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN proactive_search_flag = TRUE THEN death_verification_id END) / NULLIF(COUNT(death_verification_id), 0), 2)
      comment: "Percentage of deaths identified through proactive search programs. State regulators (e.g., CA, FL, NY) require proactive death identification — this rate is a direct measure of unclaimed property law compliance."
    - name: "claim_initiation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN claim_initiated_flag = TRUE THEN death_verification_id END) / NULLIF(COUNT(CASE WHEN verification_status = 'VERIFIED' THEN death_verification_id END), 0), 2)
      comment: "Percentage of verified deaths where a claim has been initiated. Low rates on verified deaths indicate operational failures in the claims handoff process — a key customer service and regulatory compliance metric."
    - name: "beneficiary_notification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN beneficiary_notified_flag = TRUE THEN death_verification_id END) / NULLIF(COUNT(CASE WHEN verification_status = 'VERIFIED' THEN death_verification_id END), 0), 2)
      comment: "Percentage of verified deaths where beneficiaries have been notified. Timely beneficiary notification is a regulatory requirement in most states — low rates create unclaimed property liability and regulatory penalty risk."
    - name: "obituary_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN obituary_verified_flag = TRUE THEN death_verification_id END) / NULLIF(COUNT(death_verification_id), 0), 2)
      comment: "Percentage of death verifications corroborated by an obituary. Obituary verification provides secondary evidence supporting death certificate validity — used to assess verification robustness."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_ownership_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy ownership transfer KPIs covering transfer volume, consideration amounts, compliance review rates, and STOLI/NIGO quality metrics. Used by compliance, legal, and operations leadership to monitor ownership change risk and processing quality."
  source: "`life_insurance_ecm`.`policyholder`.`ownership_transfer`"
  dimensions:
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the ownership transfer (pending, approved, completed, rejected, cancelled) — primary operational health dimension."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of ownership transfer (absolute assignment, collateral assignment, gift, sale, divorce, trust) — used to segment transfer risk and compliance requirements."
    - name: "transfer_reason"
      expr: transfer_reason
      comment: "Business reason for the ownership transfer — used to identify high-risk transfer patterns (e.g., life settlement, divorce, estate planning)."
    - name: "new_owner_type"
      expr: new_owner_type
      comment: "Type of the new owner (individual, trust, corporation, life settlement company) — used to identify institutional buyer concentration and STOLI risk."
    - name: "aml_review_status"
      expr: aml_review_status
      comment: "Status of the AML review for the transfer (not required, pending, cleared, escalated) — compliance monitoring dimension."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction governing the ownership transfer — used for state-specific regulatory compliance reporting."
    - name: "transfer_for_value_flag"
      expr: transfer_for_value_flag
      comment: "Indicates whether the transfer was for value (consideration paid). Transfer-for-value transactions have specific tax and insurable interest implications — a critical compliance segmentation dimension."
    - name: "ilit_indicator"
      expr: ilit_indicator
      comment: "Indicates whether the transfer involves an Irrevocable Life Insurance Trust (ILIT) — used for estate planning product analysis."
    - name: "request_year"
      expr: DATE_TRUNC('YEAR', request_date)
      comment: "Year the ownership transfer was requested — used for trend analysis of transfer volume and processing timeliness."
  measures:
    - name: "total_consideration_amount"
      expr: SUM(CAST(consideration_amount AS DOUBLE))
      comment: "Total consideration paid across all ownership transfers. Tracks the aggregate economic value of policy ownership changes — high values may indicate life settlement activity requiring enhanced AML and insurable interest review."
    - name: "avg_consideration_amount"
      expr: AVG(CAST(consideration_amount AS DOUBLE))
      comment: "Average consideration amount per ownership transfer. Benchmarks transfer economics — significant deviations from face value may indicate distressed sales or life settlement transactions."
    - name: "total_policy_csv_at_transfer"
      expr: SUM(CAST(policy_csv_at_transfer AS DOUBLE))
      comment: "Total cash surrender value of policies at the time of transfer. Measures the aggregate asset value changing hands — used to assess the financial significance of the transfer portfolio and potential tax implications."
    - name: "avg_policy_csv_at_transfer"
      expr: AVG(CAST(policy_csv_at_transfer AS DOUBLE))
      comment: "Average cash surrender value per policy at transfer. Used to benchmark transfer economics and identify below-market transfers that may indicate distressed sales or fraud."
    - name: "total_collateral_assignment_amount"
      expr: SUM(CAST(collateral_assignment_amount AS DOUBLE))
      comment: "Total collateral assignment amount across all transfers. Measures the aggregate policy value pledged as loan collateral — used to monitor credit risk concentration and lender exposure."
    - name: "nigo_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nigo_flag = TRUE THEN ownership_transfer_id END) / NULLIF(COUNT(ownership_transfer_id), 0), 2)
      comment: "Percentage of ownership transfers flagged as Not In Good Order (NIGO). NIGO rates measure documentation quality and operational efficiency — high rates increase processing costs and create regulatory risk."
    - name: "stoli_review_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN stoli_review_flag = TRUE THEN ownership_transfer_id END) / NULLIF(COUNT(ownership_transfer_id), 0), 2)
      comment: "Percentage of ownership transfers flagged for STOLI review. STOLI (Stranger-Originated Life Insurance) transfers represent insurable interest fraud — this rate monitors the prevalence of high-risk transfer patterns."
    - name: "aml_review_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN aml_review_required = TRUE THEN ownership_transfer_id END) / NULLIF(COUNT(ownership_transfer_id), 0), 2)
      comment: "Percentage of ownership transfers requiring AML review. Tracks the compliance burden of the transfer portfolio — used to resource the AML review team and identify high-risk transfer patterns."
    - name: "transfer_for_value_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN transfer_for_value_flag = TRUE THEN ownership_transfer_id END) / NULLIF(COUNT(ownership_transfer_id), 0), 2)
      comment: "Percentage of ownership transfers that were for value (consideration paid). Transfer-for-value transactions trigger specific tax consequences and insurable interest requirements — this rate monitors life settlement activity in the portfolio."
    - name: "insurable_interest_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN insurable_interest_verified = TRUE THEN ownership_transfer_id END) / NULLIF(COUNT(ownership_transfer_id), 0), 2)
      comment: "Percentage of ownership transfers where insurable interest was verified. Insurable interest verification is a legal requirement for valid life insurance contracts — low rates create policy contestability and fraud risk."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_beneficiary_designation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Beneficiary designation quality and compliance KPIs covering designation completeness, NIGO rates, AML screening, and irrevocable designation concentration. Used by operations, compliance, and customer service leadership to ensure beneficiary records are complete, compliant, and actionable at time of claim."
  source: "`life_insurance_ecm`.`policyholder`.`beneficiary_designation`"
  dimensions:
    - name: "designation_status"
      expr: designation_status
      comment: "Current status of the beneficiary designation (active, superseded, cancelled, pending) — primary operational health dimension."
    - name: "designation_type"
      expr: designation_type
      comment: "Type of beneficiary designation (primary, contingent, tertiary) — used to assess designation completeness and claim payment readiness."
    - name: "beneficiary_entity_type"
      expr: beneficiary_entity_type
      comment: "Entity type of the beneficiary (individual, trust, estate, charity, minor) — used to segment designation complexity and claim processing requirements."
    - name: "beneficiary_relationship"
      expr: beneficiary_relationship
      comment: "Relationship of the beneficiary to the insured/annuitant (spouse, child, parent, etc.) — used for insurable interest analysis and demographic reporting."
    - name: "designation_method"
      expr: designation_method
      comment: "Method used to submit the designation (paper form, e-signature, online portal) — used to track digital adoption and processing efficiency."
    - name: "aml_screening_status"
      expr: aml_screening_status
      comment: "AML screening status of the beneficiary (clear, hit, pending) — compliance monitoring dimension for beneficiary-level AML controls."
    - name: "jurisdiction_state_code"
      expr: jurisdiction_state_code
      comment: "State jurisdiction governing the designation — used for state-specific regulatory compliance and unclaimed property reporting."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the beneficiary designation became effective — used for trend analysis of designation activity and change frequency."
  measures:
    - name: "active_designation_count"
      expr: COUNT(CASE WHEN designation_status = 'ACTIVE' THEN beneficiary_designation_id END)
      comment: "Number of active beneficiary designations. Tracks the volume of current, actionable beneficiary records — used to assess claim payment readiness across the in-force portfolio."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage per beneficiary designation. Used to monitor designation completeness — average values significantly below 100% may indicate missing co-beneficiary records or data quality issues."
    - name: "nigo_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_nigo = TRUE THEN beneficiary_designation_id END) / NULLIF(COUNT(beneficiary_designation_id), 0), 2)
      comment: "Percentage of beneficiary designations flagged as Not In Good Order (NIGO). NIGO designations cannot be processed at claim time — high rates create customer service failures and regulatory risk at the moment of truth."
    - name: "irrevocable_designation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_irrevocable = TRUE THEN beneficiary_designation_id END) / NULLIF(COUNT(beneficiary_designation_id), 0), 2)
      comment: "Percentage of beneficiary designations that are irrevocable. Irrevocable designations restrict policyholder flexibility and require beneficiary consent for changes — high rates increase operational complexity and customer friction."
    - name: "minor_beneficiary_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN minor_beneficiary_flag = TRUE THEN beneficiary_designation_id END) / NULLIF(COUNT(beneficiary_designation_id), 0), 2)
      comment: "Percentage of beneficiary designations naming a minor. Minor beneficiaries require guardian appointment for claim payment — high rates increase claim processing complexity and potential for payment delays."
    - name: "notarization_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN notarization_required = TRUE THEN beneficiary_designation_id END) / NULLIF(COUNT(beneficiary_designation_id), 0), 2)
      comment: "Percentage of beneficiary designations requiring notarization. Notarization requirements add friction to the designation process — this rate tracks the operational burden of high-formality designation workflows."
    - name: "stoli_review_flagged_count"
      expr: COUNT(CASE WHEN stoli_review_flag = TRUE THEN beneficiary_designation_id END)
      comment: "Number of beneficiary designations flagged for STOLI review. STOLI-flagged designations indicate potential insurable interest fraud — requires immediate underwriting and legal escalation."
    - name: "aml_screened_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN aml_screening_status IS NOT NULL AND aml_screening_status <> '' THEN beneficiary_designation_id END) / NULLIF(COUNT(beneficiary_designation_id), 0), 2)
      comment: "Percentage of beneficiary designations that have undergone AML screening. Beneficiary AML screening is required under enhanced CDD rules — low coverage rates indicate gaps in the AML program that regulators will cite."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_contract_owner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract owner KPIs covering ownership structure, compliance status, collateral assignment exposure, and 1035 exchange activity. Used by compliance, operations, and product leadership to monitor owner-level risk concentration and regulatory compliance."
  source: "`life_insurance_ecm`.`policyholder`.`contract_owner`"
  dimensions:
    - name: "ownership_status"
      expr: ownership_status
      comment: "Current status of the ownership record (active, transferred, terminated) — primary lifecycle dimension."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Type of ownership (individual, joint, trust, corporate, custodial) — used to segment ownership structure complexity and compliance requirements."
    - name: "kyc_status"
      expr: kyc_status
      comment: "KYC verification status of the contract owner — compliance health dimension."
    - name: "ofac_screening_status"
      expr: ofac_screening_status
      comment: "OFAC sanctions screening status of the contract owner — critical regulatory compliance dimension."
    - name: "aml_risk_rating"
      expr: aml_risk_rating
      comment: "AML risk rating of the contract owner (low, medium, high) — drives enhanced due diligence and monitoring requirements."
    - name: "tin_certification_status"
      expr: tin_certification_status
      comment: "IRS TIN certification status — drives backup withholding and B-Notice obligations."
    - name: "insurable_interest_type"
      expr: insurable_interest_type
      comment: "Basis of insurable interest between owner and insured (self, spouse, dependent, business) — used for insurable interest compliance monitoring."
    - name: "ownership_effective_year"
      expr: DATE_TRUNC('YEAR', ownership_effective_date)
      comment: "Year the ownership became effective — used for vintage analysis of the owner portfolio."
  measures:
    - name: "active_owner_count"
      expr: COUNT(CASE WHEN ownership_status = 'ACTIVE' THEN contract_owner_id END)
      comment: "Number of active contract owners. Tracks the active owner population — used to monitor portfolio scale and operational servicing workload."
    - name: "collateral_assignment_count"
      expr: COUNT(CASE WHEN collateral_assignment_flag = TRUE THEN contract_owner_id END)
      comment: "Number of contracts with an active collateral assignment. Collateral assignments pledge policy value as loan security — this count tracks credit-linked policy exposure and lender relationship volume."
    - name: "collateral_assignment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN collateral_assignment_flag = TRUE THEN contract_owner_id END) / NULLIF(COUNT(contract_owner_id), 0), 2)
      comment: "Percentage of contract owners with a collateral assignment. Tracks the proportion of the portfolio pledged as collateral — used to monitor credit risk concentration and lender dependency."
    - name: "exchange_1035_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exchange_1035_flag = TRUE THEN contract_owner_id END) / NULLIF(COUNT(contract_owner_id), 0), 2)
      comment: "Percentage of contract owners who executed a 1035 tax-free exchange. 1035 exchange rates indicate replacement activity — high rates may signal competitive pressure or churning by producers, requiring suitability review."
    - name: "absolute_assignment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN absolute_assignment_flag = TRUE THEN contract_owner_id END) / NULLIF(COUNT(contract_owner_id), 0), 2)
      comment: "Percentage of contract owners with an absolute assignment (full transfer of ownership rights). Absolute assignments permanently transfer all policy rights — high rates may indicate life settlement activity or estate planning transactions."
    - name: "stoli_review_flagged_count"
      expr: COUNT(CASE WHEN stoli_review_flag = TRUE THEN contract_owner_id END)
      comment: "Number of contract owners flagged for STOLI review. STOLI-flagged owners represent insurable interest fraud risk — requires immediate underwriting and legal escalation."
    - name: "electronic_consent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN electronic_consent_flag = TRUE THEN contract_owner_id END) / NULLIF(COUNT(contract_owner_id), 0), 2)
      comment: "Percentage of contract owners who have provided electronic consent for paperless communications. Tracks digital adoption — a key operational efficiency metric that reduces print/mail costs and improves communication speed."
    - name: "avg_ownership_percentage"
      expr: AVG(CAST(ownership_percentage AS DOUBLE))
      comment: "Average ownership percentage per contract owner record. For joint ownership structures, values below 100% indicate shared ownership — used to validate that total ownership percentages sum correctly across co-owners."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_trust`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trust entity KPIs covering trust compliance status, beneficial ownership verification, ILIT concentration, and AML/OFAC screening. Used by compliance, legal, and underwriting leadership to monitor trust-owned policy risk and regulatory compliance."
  source: "`life_insurance_ecm`.`policyholder`.`trust`"
  dimensions:
    - name: "trust_status"
      expr: trust_status
      comment: "Current status of the trust (active, terminated, revoked, pending) — primary lifecycle dimension."
    - name: "trust_type"
      expr: trust_type
      comment: "Type of trust (revocable living trust, irrevocable trust, ILIT, charitable trust, etc.) — primary product and compliance segmentation dimension."
    - name: "kyc_status"
      expr: kyc_status
      comment: "KYC verification status of the trust entity — compliance health dimension."
    - name: "ofac_screening_status"
      expr: ofac_screening_status
      comment: "OFAC sanctions screening status of the trust — critical regulatory compliance dimension."
    - name: "aml_risk_rating"
      expr: aml_risk_rating
      comment: "AML risk rating of the trust entity (low, medium, high) — drives enhanced due diligence requirements."
    - name: "state_of_formation"
      expr: state_of_formation
      comment: "State where the trust was formed — used for jurisdictional compliance and governing law analysis."
    - name: "tin_certification_status"
      expr: tin_certification_status
      comment: "IRS TIN certification status of the trust — drives backup withholding and tax reporting obligations."
    - name: "establishment_year"
      expr: DATE_TRUNC('YEAR', establishment_date)
      comment: "Year the trust was established — used for vintage analysis of the trust portfolio."
  measures:
    - name: "active_trust_count"
      expr: COUNT(CASE WHEN trust_status = 'ACTIVE' THEN assignment_id END)
      comment: "Number of active trust entities. Tracks the active trust-owned policy population — used to monitor the scale of trust-related compliance and servicing obligations."
    - name: "ilit_count"
      expr: COUNT(CASE WHEN ilit_indicator = TRUE THEN assignment_id END)
      comment: "Number of Irrevocable Life Insurance Trusts (ILITs). ILITs are the primary vehicle for estate tax planning with life insurance — this count tracks the estate planning segment of the portfolio."
    - name: "ilit_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ilit_indicator = TRUE THEN assignment_id END) / NULLIF(COUNT(assignment_id), 0), 2)
      comment: "Percentage of trusts that are ILITs. Tracks the concentration of estate planning trusts in the portfolio — used to assess product mix and associated long-term liability characteristics."
    - name: "beneficial_owner_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN beneficial_owner_verified = TRUE THEN assignment_id END) / NULLIF(COUNT(assignment_id), 0), 2)
      comment: "Percentage of trusts with verified beneficial ownership. FinCEN's Beneficial Ownership Rule requires identification and verification of beneficial owners of legal entity customers — this rate measures compliance with that requirement."
    - name: "insurable_interest_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN insurable_interest_verified = TRUE THEN assignment_id END) / NULLIF(COUNT(assignment_id), 0), 2)
      comment: "Percentage of trusts with verified insurable interest. Insurable interest verification is a legal requirement for trust-owned life insurance — low rates create policy contestability risk and potential fraud exposure."
    - name: "stoli_review_flagged_count"
      expr: COUNT(CASE WHEN stoli_review_flag = TRUE THEN assignment_id END)
      comment: "Number of trusts flagged for STOLI review. STOLI-flagged trusts represent the highest-risk insurable interest fraud scenario — requires immediate legal and underwriting escalation."
    - name: "document_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN document_verified = TRUE THEN assignment_id END) / NULLIF(COUNT(assignment_id), 0), 2)
      comment: "Percentage of trusts with verified trust documents on file. Document verification is required for trust-owned policy administration — low rates indicate documentation gaps that create legal and operational risk."
    - name: "revocable_trust_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN revocable_flag = TRUE THEN assignment_id END) / NULLIF(COUNT(assignment_id), 0), 2)
      comment: "Percentage of trusts that are revocable. Revocable trusts have different tax and estate planning implications than irrevocable trusts — this ratio tracks the structural composition of the trust portfolio."
$$;