-- Metric views for domain: customer | Business: Mining | Version: 1 | Generated on: 2026-05-05 14:14:10

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`customer_counterparty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI view over the counterparty master, covering credit exposure, KYC compliance posture, and counterparty portfolio health for executive and risk management decision-making."
  source: "`mining_ecm`.`customer`.`counterparty`"
  dimensions:
    - name: "counterparty_status"
      expr: counterparty_status
      comment: "Operational status of the counterparty (e.g. Active, Suspended, Closed) — primary filter for portfolio health analysis."
    - name: "classification"
      expr: classification
      comment: "Business classification of the counterparty (e.g. Trader, End-User, Processor) — used to segment credit and revenue exposure by customer type."
    - name: "country_of_incorporation"
      expr: country_of_incorporation
      comment: "Country where the counterparty is legally incorporated — used for geographic risk concentration analysis."
    - name: "credit_rating"
      expr: credit_rating
      comment: "External or internal credit rating assigned to the counterparty — key dimension for credit risk segmentation."
    - name: "kyc_status"
      expr: kyc_status
      comment: "Current KYC compliance status of the counterparty — critical for regulatory and onboarding reporting."
    - name: "incoterm_preference"
      expr: incoterm_preference
      comment: "Preferred Incoterm for trade transactions — used to analyse logistics and risk transfer preferences across the customer base."
    - name: "registered_country"
      expr: registered_country
      comment: "Country of the counterparty's registered address — supports geographic segmentation distinct from country of incorporation."
    - name: "is_sanctioned_entity"
      expr: is_sanctioned_entity
      comment: "Flag indicating whether the counterparty is a sanctioned entity — mandatory compliance dimension."
    - name: "kyc_expiry_year_month"
      expr: DATE_TRUNC('MONTH', kyc_expiry_date)
      comment: "Month in which the counterparty's KYC expires — used to track upcoming compliance renewal obligations."
  measures:
    - name: "total_counterparties"
      expr: COUNT(DISTINCT counterparty_id)
      comment: "Total number of distinct counterparties in the portfolio — baseline measure for portfolio size and growth tracking."
    - name: "total_credit_limit_usd"
      expr: SUM(CAST(credit_limit_usd AS DOUBLE))
      comment: "Total credit limit extended across all counterparties in USD — measures aggregate credit exposure for risk management."
    - name: "avg_credit_limit_usd"
      expr: AVG(CAST(credit_limit_usd AS DOUBLE))
      comment: "Average credit limit per counterparty in USD — indicates typical credit exposure per customer and informs credit policy calibration."
    - name: "sanctioned_counterparty_count"
      expr: COUNT(DISTINCT CASE WHEN is_sanctioned_entity = TRUE THEN counterparty_id END)
      comment: "Number of counterparties flagged as sanctioned entities — a critical compliance KPI requiring immediate executive action if non-zero."
    - name: "kyc_non_compliant_count"
      expr: COUNT(DISTINCT CASE WHEN kyc_status NOT IN ('Approved', 'Verified', 'Complete') THEN counterparty_id END)
      comment: "Number of counterparties with a non-compliant or incomplete KYC status — drives regulatory risk remediation prioritisation."
    - name: "kyc_expired_count"
      expr: COUNT(DISTINCT CASE WHEN kyc_expiry_date < CURRENT_DATE() THEN counterparty_id END)
      comment: "Number of counterparties whose KYC has expired — a leading indicator of regulatory exposure requiring urgent renewal action."
    - name: "active_counterparty_count"
      expr: COUNT(DISTINCT CASE WHEN counterparty_status = 'Active' THEN counterparty_id END)
      comment: "Number of active counterparties — measures the live, revenue-generating customer base for commercial planning."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`customer_credit_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit facility KPI view tracking credit limit utilisation, availability, collateral coverage, and insurance across the counterparty portfolio — essential for treasury, credit risk, and CFO-level oversight."
  source: "`mining_ecm`.`customer`.`credit_limit`"
  dimensions:
    - name: "credit_limit_status"
      expr: credit_limit_status
      comment: "Current status of the credit limit record (e.g. Active, Expired, Suspended) — primary filter for active exposure analysis."
    - name: "credit_limit_type"
      expr: credit_limit_type
      comment: "Type of credit limit (e.g. Revolving, Term, Documentary) — used to segment exposure by facility structure."
    - name: "risk_classification"
      expr: risk_classification
      comment: "Risk classification assigned to the credit limit — key dimension for risk-tiered portfolio analysis."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating associated with the credit limit record — supports rating-band exposure analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the credit limit is denominated — required for multi-currency exposure reporting."
    - name: "collateral_type"
      expr: collateral_type
      comment: "Type of collateral securing the credit limit (e.g. Bank Guarantee, Cash, Property) — used to assess collateral quality distribution."
    - name: "expiry_year_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month in which the credit limit expires — used to track upcoming credit facility renewals and avoid unintended exposure gaps."
    - name: "next_review_year_month"
      expr: DATE_TRUNC('MONTH', next_review_date)
      comment: "Month of the next scheduled credit review — supports proactive credit management scheduling."
  measures:
    - name: "total_limit_amount"
      expr: SUM(CAST(limit_amount AS DOUBLE))
      comment: "Total approved credit limit amount across all facilities — headline measure of aggregate credit exposure."
    - name: "total_utilisation_amount"
      expr: SUM(CAST(utilisation_amount AS DOUBLE))
      comment: "Total drawn/utilised credit across all facilities — measures actual credit exposure outstanding."
    - name: "total_available_credit"
      expr: SUM(CAST(available_credit AS DOUBLE))
      comment: "Total remaining available credit across all facilities — indicates headroom for new transactions and customer capacity."
    - name: "total_collateral_amount"
      expr: SUM(CAST(collateral_amount AS DOUBLE))
      comment: "Total collateral value securing credit facilities — used to assess collateral coverage against exposure."
    - name: "avg_insurance_coverage_pct"
      expr: AVG(CAST(insurance_coverage_percentage AS DOUBLE))
      comment: "Average insurance coverage percentage across credit facilities — indicates the degree to which credit exposure is insured, informing risk transfer strategy."
    - name: "credit_facility_count"
      expr: COUNT(DISTINCT credit_limit_id)
      comment: "Total number of distinct credit facilities — baseline measure for portfolio breadth."
    - name: "expiring_within_90_days_count"
      expr: COUNT(DISTINCT CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN credit_limit_id END)
      comment: "Number of credit facilities expiring within the next 90 days — a critical operational KPI for proactive renewal management to avoid unintended credit gaps."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`customer_credit_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit review outcome and risk analytics view — tracks review cycle performance, rating migration, probability of default, and limit change decisions to support credit committee and CFO oversight."
  source: "`mining_ecm`.`customer`.`credit_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the credit review (e.g. Pending, Approved, Rejected) — primary filter for pipeline and outcome analysis."
    - name: "review_type"
      expr: review_type
      comment: "Type of credit review (e.g. Annual, Triggered, Interim) — used to segment review workload and outcomes by review category."
    - name: "approval_outcome"
      expr: approval_outcome
      comment: "Outcome of the credit review approval (e.g. Approved, Declined, Conditional) — key dimension for credit decision analytics."
    - name: "internal_credit_rating"
      expr: internal_credit_rating
      comment: "Internal credit rating assigned at review — used to track rating migration and portfolio quality trends."
    - name: "external_credit_rating"
      expr: external_credit_rating
      comment: "External credit rating at time of review — supports benchmarking internal vs external rating assessments."
    - name: "internal_rating_outlook"
      expr: internal_rating_outlook
      comment: "Outlook associated with the internal credit rating (e.g. Stable, Negative, Positive) — forward-looking risk dimension."
    - name: "collateral_required_flag"
      expr: collateral_required_flag
      comment: "Whether collateral was required as a condition of the credit review outcome — used to assess risk mitigation requirements across the portfolio."
    - name: "review_year_month"
      expr: DATE_TRUNC('MONTH', review_date)
      comment: "Month in which the credit review was conducted — supports trend analysis of review activity and outcomes over time."
  measures:
    - name: "total_reviews"
      expr: COUNT(DISTINCT credit_review_id)
      comment: "Total number of credit reviews conducted — baseline measure for credit review activity volume."
    - name: "total_approved_credit_limit_usd"
      expr: SUM(CAST(approved_credit_limit_usd AS DOUBLE))
      comment: "Total credit limit approved across all reviewed facilities — measures the aggregate credit capacity sanctioned by the credit committee."
    - name: "avg_approved_credit_limit_usd"
      expr: AVG(CAST(approved_credit_limit_usd AS DOUBLE))
      comment: "Average approved credit limit per review — indicates typical credit sanction size and informs credit policy benchmarking."
    - name: "avg_probability_of_default_pct"
      expr: AVG(CAST(probability_of_default_pct AS DOUBLE))
      comment: "Average probability of default across reviewed counterparties — a headline credit risk KPI used by the credit committee and CFO to assess portfolio risk quality."
    - name: "avg_loss_given_default_pct"
      expr: AVG(CAST(loss_given_default_pct AS DOUBLE))
      comment: "Average loss given default percentage — measures expected loss severity in default scenarios, informing provisioning and risk appetite decisions."
    - name: "avg_leverage_ratio"
      expr: AVG(CAST(leverage_ratio AS DOUBLE))
      comment: "Average leverage ratio of reviewed counterparties — a key financial health indicator used to assess counterparty solvency risk."
    - name: "avg_interest_coverage_ratio"
      expr: AVG(CAST(interest_coverage_ratio AS DOUBLE))
      comment: "Average interest coverage ratio of reviewed counterparties — measures ability to service debt, a critical input to credit limit decisions."
    - name: "limit_increase_count"
      expr: COUNT(DISTINCT CASE WHEN approved_credit_limit_usd > current_credit_limit_usd THEN credit_review_id END)
      comment: "Number of reviews resulting in a credit limit increase — indicates commercial expansion and improving counterparty creditworthiness."
    - name: "limit_decrease_count"
      expr: COUNT(DISTINCT CASE WHEN approved_credit_limit_usd < current_credit_limit_usd THEN credit_review_id END)
      comment: "Number of reviews resulting in a credit limit reduction — a risk signal indicating deteriorating counterparty credit quality requiring management attention."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`customer_kyc_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KYC compliance and AML risk KPI view — tracks documentation completeness, sanctions screening outcomes, PEP exposure, and review cycle health to support compliance, legal, and regulatory reporting obligations."
  source: "`mining_ecm`.`customer`.`kyc_record`"
  dimensions:
    - name: "kyc_status"
      expr: kyc_status
      comment: "Current KYC status of the record (e.g. Approved, Pending, Expired) — primary compliance status dimension."
    - name: "due_diligence_level"
      expr: due_diligence_level
      comment: "Level of due diligence applied (e.g. Standard, Enhanced, Simplified) — used to segment compliance workload and risk exposure."
    - name: "aml_risk_rating"
      expr: aml_risk_rating
      comment: "AML risk rating assigned to the counterparty (e.g. Low, Medium, High) — key dimension for AML risk portfolio analysis."
    - name: "jurisdiction_risk_level"
      expr: jurisdiction_risk_level
      comment: "Risk level of the counterparty's jurisdiction — used to identify geographic concentration of high-risk KYC records."
    - name: "pep_flag"
      expr: pep_flag
      comment: "Whether the counterparty is classified as a Politically Exposed Person — mandatory compliance dimension for enhanced due diligence tracking."
    - name: "sanctions_screening_result"
      expr: sanctions_screening_result
      comment: "Result of the most recent sanctions screening (e.g. Clear, Hit, Pending) — critical compliance dimension."
    - name: "documentation_complete"
      expr: documentation_complete
      comment: "Whether all required KYC documentation has been collected and verified — used to track onboarding completeness."
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Whether the KYC record triggers a regulatory reporting obligation — used to prioritise compliance team workload."
    - name: "expiry_year_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month in which the KYC record expires — used to manage proactive renewal scheduling and avoid compliance lapses."
  measures:
    - name: "total_kyc_records"
      expr: COUNT(DISTINCT kyc_record_id)
      comment: "Total number of KYC records — baseline measure for compliance portfolio size."
    - name: "documentation_complete_count"
      expr: COUNT(DISTINCT CASE WHEN documentation_complete = TRUE THEN kyc_record_id END)
      comment: "Number of KYC records with complete documentation — measures onboarding and compliance documentation health."
    - name: "documentation_incomplete_count"
      expr: COUNT(DISTINCT CASE WHEN documentation_complete = FALSE OR documentation_complete IS NULL THEN kyc_record_id END)
      comment: "Number of KYC records with incomplete documentation — a compliance risk KPI requiring remediation action."
    - name: "pep_flagged_count"
      expr: COUNT(DISTINCT CASE WHEN pep_flag = TRUE THEN kyc_record_id END)
      comment: "Number of counterparties classified as Politically Exposed Persons — a critical compliance KPI requiring enhanced due diligence and executive awareness."
    - name: "sanctions_hit_count"
      expr: COUNT(DISTINCT CASE WHEN sanctions_screening_result = 'Hit' THEN kyc_record_id END)
      comment: "Number of KYC records with a sanctions screening hit — a zero-tolerance compliance KPI requiring immediate escalation."
    - name: "kyc_expired_count"
      expr: COUNT(DISTINCT CASE WHEN expiry_date < CURRENT_DATE() THEN kyc_record_id END)
      comment: "Number of KYC records that have expired — measures the volume of overdue renewals creating regulatory exposure."
    - name: "expiring_within_60_days_count"
      expr: COUNT(DISTINCT CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 60) THEN kyc_record_id END)
      comment: "Number of KYC records expiring within 60 days — a leading compliance KPI enabling proactive renewal management."
    - name: "high_risk_aml_count"
      expr: COUNT(DISTINCT CASE WHEN aml_risk_rating = 'High' THEN kyc_record_id END)
      comment: "Number of counterparties with a High AML risk rating — a headline risk KPI for the compliance committee and board risk reporting."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`customer_letter_of_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Letter of credit portfolio KPI view — tracks LC exposure, utilisation, availability, and shipment compliance to support treasury, trade finance, and commercial management decisions."
  source: "`mining_ecm`.`customer`.`letter_of_credit`"
  dimensions:
    - name: "letter_of_credit_status"
      expr: letter_of_credit_status
      comment: "Current status of the letter of credit (e.g. Active, Expired, Drawn, Cancelled) — primary filter for live exposure analysis."
    - name: "lc_type"
      expr: lc_type
      comment: "Type of letter of credit (e.g. Sight, Usance, Standby) — used to segment trade finance exposure by instrument type."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the LC is denominated — required for multi-currency trade finance exposure reporting."
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterm governing the trade transaction — used to analyse risk transfer and logistics responsibility distribution across the LC portfolio."
    - name: "issuing_bank_name"
      expr: issuing_bank_name
      comment: "Name of the bank issuing the letter of credit — used to assess bank counterparty concentration risk."
    - name: "partial_shipment_allowed"
      expr: partial_shipment_allowed
      comment: "Whether partial shipment is permitted under the LC — used to analyse shipment flexibility across the trade portfolio."
    - name: "expiry_year_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month in which the LC expires — used to track upcoming LC expirations and manage trade finance pipeline."
    - name: "issue_year_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month in which the LC was issued — supports trend analysis of LC issuance activity over time."
  measures:
    - name: "total_lc_amount"
      expr: SUM(CAST(lc_amount AS DOUBLE))
      comment: "Total face value of all letters of credit — headline measure of trade finance exposure and commercial activity."
    - name: "total_utilised_amount"
      expr: SUM(CAST(utilised_amount AS DOUBLE))
      comment: "Total amount drawn against letters of credit — measures actual trade finance utilisation and cash flow exposure."
    - name: "total_available_amount"
      expr: SUM(CAST(available_amount AS DOUBLE))
      comment: "Total remaining available amount across all LCs — indicates uncommitted trade finance capacity."
    - name: "avg_lc_amount"
      expr: AVG(CAST(lc_amount AS DOUBLE))
      comment: "Average LC face value — indicates typical transaction size and informs trade finance facility sizing decisions."
    - name: "total_lc_count"
      expr: COUNT(DISTINCT letter_of_credit_id)
      comment: "Total number of letters of credit — baseline measure for trade finance transaction volume."
    - name: "expiring_within_30_days_count"
      expr: COUNT(DISTINCT CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN letter_of_credit_id END)
      comment: "Number of LCs expiring within 30 days — a critical treasury KPI for proactive LC renewal and shipment scheduling management."
    - name: "avg_tolerance_percentage"
      expr: AVG(CAST(tolerance_percentage AS DOUBLE))
      comment: "Average quantity tolerance percentage across LCs — indicates the typical flexibility in commodity quantity delivery terms, informing logistics and commercial planning."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segmentation KPI view — tracks segment portfolio composition, volume targets, strategic priorities, and review cycle health to support commercial strategy, account management, and executive portfolio steering."
  source: "`mining_ecm`.`customer`.`segment`"
  dimensions:
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the customer segment (e.g. Active, Inactive, Under Review) — primary filter for live segment portfolio analysis."
    - name: "tier_classification"
      expr: tier_classification
      comment: "Tier classification of the segment (e.g. Tier 1, Tier 2, Tier 3) — used to prioritise commercial resources and account management effort."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the customer segment — used for regional commercial performance and market development analysis."
    - name: "end_use_industry"
      expr: end_use_industry
      comment: "Industry in which the customer uses the mined commodity (e.g. Steel, Energy, Battery Manufacturing) — key dimension for demand-side market analysis."
    - name: "credit_risk_rating"
      expr: credit_risk_rating
      comment: "Credit risk rating of the segment — used to assess risk concentration across the customer portfolio."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy applied to the segment (e.g. Index-linked, Fixed, Spot) — used to analyse commercial terms distribution across the portfolio."
    - name: "service_level_tier"
      expr: service_level_tier
      comment: "Service level tier assigned to the segment — used to align operational resources with customer value tiers."
    - name: "strategic_priority_flag"
      expr: strategic_priority_flag
      comment: "Whether the segment is designated a strategic priority — used to filter and focus executive attention on highest-value customer groups."
    - name: "country_code"
      expr: country_code
      comment: "Country code of the customer segment — supports country-level commercial and risk analysis."
    - name: "volume_band"
      expr: volume_band
      comment: "Volume band classification of the segment (e.g. Large, Medium, Small) — used to segment customers by offtake scale."
  measures:
    - name: "total_segments"
      expr: COUNT(DISTINCT segment_id)
      comment: "Total number of customer segments — baseline measure for portfolio breadth and segmentation coverage."
    - name: "strategic_priority_segment_count"
      expr: COUNT(DISTINCT CASE WHEN strategic_priority_flag = TRUE THEN segment_id END)
      comment: "Number of segments designated as strategic priorities — measures the size of the high-value customer portfolio requiring focused executive attention."
    - name: "total_annual_volume_minimum_tonnes"
      expr: SUM(CAST(annual_volume_minimum_tonnes AS DOUBLE))
      comment: "Total minimum contracted annual volume across all segments in tonnes — a floor measure of committed offtake demand used in mine production planning."
    - name: "total_annual_volume_maximum_tonnes"
      expr: SUM(CAST(annual_volume_maximum_tonnes AS DOUBLE))
      comment: "Total maximum potential annual volume across all segments in tonnes — a ceiling measure of addressable demand used in capacity and logistics planning."
    - name: "avg_annual_volume_minimum_tonnes"
      expr: AVG(CAST(annual_volume_minimum_tonnes AS DOUBLE))
      comment: "Average minimum annual volume per segment in tonnes — indicates typical committed offtake size and informs segment-level commercial benchmarking."
    - name: "avg_annual_volume_maximum_tonnes"
      expr: AVG(CAST(annual_volume_maximum_tonnes AS DOUBLE))
      comment: "Average maximum annual volume per segment in tonnes — indicates typical volume ceiling per customer segment for capacity allocation decisions."
    - name: "diversification_target_segment_count"
      expr: COUNT(DISTINCT CASE WHEN diversification_target_flag = TRUE THEN segment_id END)
      comment: "Number of segments flagged as diversification targets — measures the breadth of the commercial diversification strategy and progress toward reducing customer concentration risk."
$$;