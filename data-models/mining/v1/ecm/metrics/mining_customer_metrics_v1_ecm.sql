-- Metric views for domain: customer | Business: Mining | Version: 1 | Generated on: 2026-05-05 10:43:42

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`customer_counterparty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer/counterparty metrics tracking credit exposure, relationship health, and strategic account management for mining commodity trading partners"
  source: "`mining_ecm`.`customer`.`counterparty`"
  dimensions:
    - name: "counterparty_status"
      expr: counterparty_status
      comment: "Current operational status of the counterparty relationship (active, suspended, inactive)"
    - name: "classification"
      expr: classification
      comment: "Counterparty classification (customer, supplier, both, prospect)"
    - name: "country_of_incorporation"
      expr: country_of_incorporation
      comment: "Legal jurisdiction where counterparty is incorporated"
    - name: "credit_rating"
      expr: credit_rating
      comment: "External credit rating assigned to counterparty"
    - name: "credit_rating_agency"
      expr: credit_rating_agency
      comment: "Agency providing the credit rating (Moody's, S&P, Fitch)"
    - name: "kyc_status"
      expr: kyc_status
      comment: "Know Your Customer compliance status"
    - name: "is_sanctioned_entity"
      expr: is_sanctioned_entity
      comment: "Flag indicating if counterparty is on sanctions lists"
    - name: "registered_country"
      expr: registered_country
      comment: "Country of registered address"
    - name: "payment_terms_days"
      expr: payment_terms_days
      comment: "Standard payment terms in days"
    - name: "relationship_manager"
      expr: employee_id
      comment: "Employee ID of assigned relationship manager"
  measures:
    - name: "total_counterparties"
      expr: COUNT(1)
      comment: "Total number of counterparty records"
    - name: "unique_counterparties"
      expr: COUNT(DISTINCT counterparty_id)
      comment: "Distinct count of counterparties"
    - name: "total_credit_limit_usd"
      expr: SUM(CAST(credit_limit_usd AS DOUBLE))
      comment: "Total credit exposure limit across all counterparties in USD"
    - name: "avg_credit_limit_usd"
      expr: AVG(CAST(credit_limit_usd AS DOUBLE))
      comment: "Average credit limit per counterparty in USD"
    - name: "sanctioned_counterparties"
      expr: SUM(CASE WHEN is_sanctioned_entity = TRUE THEN 1 ELSE 0 END)
      comment: "Count of counterparties flagged as sanctioned entities"
    - name: "kyc_compliant_counterparties"
      expr: SUM(CASE WHEN kyc_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of counterparties with approved KYC status"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`customer_credit_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and utilization metrics tracking available credit, exposure, and limit management for mining commodity counterparties"
  source: "`mining_ecm`.`customer`.`credit_limit`"
  dimensions:
    - name: "credit_limit_status"
      expr: credit_limit_status
      comment: "Current status of the credit limit (active, suspended, expired)"
    - name: "credit_limit_type"
      expr: credit_limit_type
      comment: "Type of credit facility (revolving, term, spot)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the credit limit"
    - name: "risk_classification"
      expr: risk_classification
      comment: "Risk tier assigned to the credit facility"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating associated with this limit"
    - name: "collateral_type"
      expr: collateral_type
      comment: "Type of collateral securing the credit limit"
    - name: "payment_terms_days"
      expr: payment_terms_days
      comment: "Payment terms in days for this credit facility"
  measures:
    - name: "total_credit_limits"
      expr: COUNT(1)
      comment: "Total number of credit limit records"
    - name: "total_limit_amount"
      expr: SUM(CAST(limit_amount AS DOUBLE))
      comment: "Total approved credit limit amount across all facilities"
    - name: "total_utilised_amount"
      expr: SUM(CAST(utilisation_amount AS DOUBLE))
      comment: "Total credit currently utilized across all facilities"
    - name: "total_available_credit"
      expr: SUM(CAST(available_credit AS DOUBLE))
      comment: "Total available credit remaining across all facilities"
    - name: "avg_utilization_rate"
      expr: AVG(CAST(utilisation_amount AS DOUBLE) / NULLIF(CAST(limit_amount AS DOUBLE), 0))
      comment: "Average credit utilization rate as a decimal (utilized/limit)"
    - name: "total_collateral_amount"
      expr: SUM(CAST(collateral_amount AS DOUBLE))
      comment: "Total collateral value securing credit facilities"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average early payment discount percentage offered"
    - name: "avg_late_payment_penalty_rate"
      expr: AVG(CAST(late_payment_penalty_rate AS DOUBLE))
      comment: "Average late payment penalty rate across facilities"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`customer_credit_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit assessment and risk evaluation metrics tracking counterparty creditworthiness, financial ratios, and approval outcomes for mining commodity trading"
  source: "`mining_ecm`.`customer`.`credit_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the credit review (pending, approved, rejected)"
    - name: "review_type"
      expr: review_type
      comment: "Type of credit review (annual, ad-hoc, renewal, new)"
    - name: "approval_outcome"
      expr: approval_outcome
      comment: "Final outcome of the credit review decision"
    - name: "internal_credit_rating"
      expr: internal_credit_rating
      comment: "Internal credit rating assigned by risk team"
    - name: "internal_rating_outlook"
      expr: internal_rating_outlook
      comment: "Outlook for internal rating (stable, positive, negative)"
    - name: "external_credit_rating"
      expr: external_credit_rating
      comment: "External credit rating from rating agency"
    - name: "external_rating_agency"
      expr: external_rating_agency
      comment: "Agency providing external credit rating"
    - name: "collateral_required_flag"
      expr: collateral_required_flag
      comment: "Whether collateral is required for this counterparty"
    - name: "collateral_type"
      expr: collateral_type
      comment: "Type of collateral required"
  measures:
    - name: "total_credit_reviews"
      expr: COUNT(1)
      comment: "Total number of credit reviews conducted"
    - name: "approved_reviews"
      expr: SUM(CASE WHEN approval_outcome = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of credit reviews with approved outcome"
    - name: "total_approved_credit_limit_usd"
      expr: SUM(CAST(approved_credit_limit_usd AS DOUBLE))
      comment: "Total credit limit approved through reviews in USD"
    - name: "avg_approved_credit_limit_usd"
      expr: AVG(CAST(approved_credit_limit_usd AS DOUBLE))
      comment: "Average approved credit limit per review in USD"
    - name: "avg_current_ratio"
      expr: AVG(CAST(current_ratio AS DOUBLE))
      comment: "Average current ratio (current assets/current liabilities) across reviewed counterparties"
    - name: "avg_leverage_ratio"
      expr: AVG(CAST(leverage_ratio AS DOUBLE))
      comment: "Average leverage ratio (debt/equity) across reviewed counterparties"
    - name: "avg_interest_coverage_ratio"
      expr: AVG(CAST(interest_coverage_ratio AS DOUBLE))
      comment: "Average interest coverage ratio (EBIT/interest expense) indicating debt servicing ability"
    - name: "avg_probability_of_default_pct"
      expr: AVG(CAST(probability_of_default_pct AS DOUBLE))
      comment: "Average probability of default percentage across counterparties"
    - name: "avg_loss_given_default_pct"
      expr: AVG(CAST(loss_given_default_pct AS DOUBLE))
      comment: "Average loss given default percentage (expected loss severity)"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`customer_letter_of_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade finance metrics tracking letter of credit utilization, exposure, and documentary compliance for mining commodity shipments"
  source: "`mining_ecm`.`customer`.`letter_of_credit`"
  dimensions:
    - name: "letter_of_credit_status"
      expr: letter_of_credit_status
      comment: "Current status of the LC (issued, amended, utilized, expired)"
    - name: "lc_type"
      expr: lc_type
      comment: "Type of letter of credit (sight, usance, standby, revolving)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the LC"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms governing delivery (FOB, CIF, CFR)"
    - name: "issuing_bank_name"
      expr: issuing_bank_name
      comment: "Name of the bank issuing the LC"
    - name: "advising_bank_name"
      expr: advising_bank_name
      comment: "Name of the advising bank"
    - name: "commodity_description"
      expr: commodity_description
      comment: "Description of commodity covered by the LC"
    - name: "partial_shipment_allowed"
      expr: partial_shipment_allowed
      comment: "Whether partial shipments are permitted under the LC"
    - name: "transhipment_allowed"
      expr: transhipment_allowed
      comment: "Whether transhipment is permitted under the LC"
  measures:
    - name: "total_letters_of_credit"
      expr: COUNT(1)
      comment: "Total number of letter of credit records"
    - name: "unique_lcs"
      expr: COUNT(DISTINCT letter_of_credit_id)
      comment: "Distinct count of letters of credit"
    - name: "total_lc_amount"
      expr: SUM(CAST(lc_amount AS DOUBLE))
      comment: "Total face value of all letters of credit"
    - name: "total_utilised_amount"
      expr: SUM(CAST(utilised_amount AS DOUBLE))
      comment: "Total amount utilized against letters of credit"
    - name: "total_available_amount"
      expr: SUM(CAST(available_amount AS DOUBLE))
      comment: "Total remaining available amount on letters of credit"
    - name: "avg_lc_utilization_rate"
      expr: AVG(CAST(utilised_amount AS DOUBLE) / NULLIF(CAST(lc_amount AS DOUBLE), 0))
      comment: "Average LC utilization rate as a decimal (utilized/total)"
    - name: "total_commodity_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total commodity quantity covered by letters of credit"
    - name: "avg_tolerance_percentage"
      expr: AVG(CAST(tolerance_percentage AS DOUBLE))
      comment: "Average quantity tolerance percentage allowed in LCs"
    - name: "amended_lcs"
      expr: SUM(CASE WHEN CAST(amendment_count AS INT) > 0 THEN 1 ELSE 0 END)
      comment: "Count of letters of credit that have been amended"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`customer_commercial_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer engagement and relationship management metrics tracking interaction frequency, outcomes, and strategic account activity for mining commodity sales"
  source: "`mining_ecm`.`customer`.`commercial_interaction`"
  dimensions:
    - name: "interaction_status"
      expr: interaction_status
      comment: "Current status of the interaction (scheduled, completed, cancelled)"
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of commercial interaction (meeting, call, site visit, negotiation)"
    - name: "interaction_mode"
      expr: interaction_mode
      comment: "Mode of interaction (in-person, virtual, phone, email)"
    - name: "interaction_outcome"
      expr: interaction_outcome
      comment: "Outcome of the interaction (successful, pending, unsuccessful)"
    - name: "outcome_classification"
      expr: outcome_classification
      comment: "Classification of outcome (contract signed, quote provided, information only)"
    - name: "interaction_priority"
      expr: interaction_priority
      comment: "Priority level of the interaction (high, medium, low)"
    - name: "commodity_discussed"
      expr: commodity_discussed
      comment: "Primary commodity discussed during interaction"
    - name: "strategic_account_flag"
      expr: strategic_account_flag
      comment: "Whether this interaction is with a strategic account"
    - name: "price_negotiation_flag"
      expr: price_negotiation_flag
      comment: "Whether price negotiation occurred during interaction"
    - name: "contract_renewal_flag"
      expr: contract_renewal_flag
      comment: "Whether contract renewal was discussed"
    - name: "market_intelligence_flag"
      expr: market_intelligence_flag
      comment: "Whether market intelligence was gathered"
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total number of commercial interactions recorded"
    - name: "unique_counterparties_engaged"
      expr: COUNT(DISTINCT counterparty_id)
      comment: "Distinct count of counterparties engaged"
    - name: "successful_interactions"
      expr: SUM(CASE WHEN interaction_outcome = 'Successful' THEN 1 ELSE 0 END)
      comment: "Count of interactions with successful outcome"
    - name: "strategic_account_interactions"
      expr: SUM(CASE WHEN strategic_account_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of interactions with strategic accounts"
    - name: "price_negotiation_interactions"
      expr: SUM(CASE WHEN price_negotiation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of interactions involving price negotiation"
    - name: "contract_renewal_interactions"
      expr: SUM(CASE WHEN contract_renewal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of interactions discussing contract renewal"
    - name: "market_intelligence_interactions"
      expr: SUM(CASE WHEN market_intelligence_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of interactions yielding market intelligence"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`customer_kyc_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance and risk management metrics tracking KYC status, sanctions screening, and AML risk for mining commodity counterparties"
  source: "`mining_ecm`.`customer`.`kyc_record`"
  dimensions:
    - name: "kyc_status"
      expr: kyc_status
      comment: "Current KYC compliance status (approved, pending, expired, rejected)"
    - name: "due_diligence_level"
      expr: due_diligence_level
      comment: "Level of due diligence applied (standard, enhanced, simplified)"
    - name: "aml_risk_rating"
      expr: aml_risk_rating
      comment: "Anti-money laundering risk rating (low, medium, high)"
    - name: "jurisdiction_risk_level"
      expr: jurisdiction_risk_level
      comment: "Risk level of counterparty's jurisdiction"
    - name: "pep_flag"
      expr: pep_flag
      comment: "Whether counterparty is a politically exposed person"
    - name: "pep_classification"
      expr: pep_classification
      comment: "Classification of PEP status if applicable"
    - name: "sanctions_screening_result"
      expr: sanctions_screening_result
      comment: "Result of sanctions screening (clear, match, potential match)"
    - name: "adverse_media_screening_result"
      expr: adverse_media_screening_result
      comment: "Result of adverse media screening"
    - name: "documentation_complete"
      expr: documentation_complete
      comment: "Whether KYC documentation is complete"
    - name: "ongoing_monitoring_flag"
      expr: ongoing_monitoring_flag
      comment: "Whether counterparty is under ongoing monitoring"
  measures:
    - name: "total_kyc_records"
      expr: COUNT(1)
      comment: "Total number of KYC records"
    - name: "approved_kyc_records"
      expr: SUM(CASE WHEN kyc_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of KYC records with approved status"
    - name: "expired_kyc_records"
      expr: SUM(CASE WHEN kyc_status = 'Expired' THEN 1 ELSE 0 END)
      comment: "Count of KYC records that have expired"
    - name: "high_risk_aml_counterparties"
      expr: SUM(CASE WHEN aml_risk_rating = 'High' THEN 1 ELSE 0 END)
      comment: "Count of counterparties with high AML risk rating"
    - name: "pep_counterparties"
      expr: SUM(CASE WHEN pep_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of counterparties flagged as politically exposed persons"
    - name: "sanctions_matches"
      expr: SUM(CASE WHEN sanctions_screening_result = 'Match' THEN 1 ELSE 0 END)
      comment: "Count of counterparties with sanctions screening matches"
    - name: "enhanced_due_diligence_count"
      expr: SUM(CASE WHEN due_diligence_level = 'Enhanced' THEN 1 ELSE 0 END)
      comment: "Count of counterparties requiring enhanced due diligence"
    - name: "ongoing_monitoring_count"
      expr: SUM(CASE WHEN ongoing_monitoring_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of counterparties under ongoing monitoring"
    - name: "documentation_complete_count"
      expr: SUM(CASE WHEN documentation_complete = TRUE THEN 1 ELSE 0 END)
      comment: "Count of counterparties with complete KYC documentation"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`customer_delivery_destination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Logistics and port infrastructure metrics tracking delivery capacity, vessel specifications, and operational capabilities for mining commodity shipments"
  source: "`mining_ecm`.`customer`.`delivery_destination`"
  dimensions:
    - name: "delivery_destination_status"
      expr: delivery_destination_status
      comment: "Current operational status of the delivery destination"
    - name: "destination_type"
      expr: destination_type
      comment: "Type of delivery destination (port, warehouse, customer site, rail terminal)"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the delivery destination"
    - name: "region"
      expr: region
      comment: "Geographic region of the destination"
    - name: "port_code"
      expr: port_code
      comment: "Standard port code if applicable"
    - name: "commodity_types_accepted"
      expr: commodity_types_accepted
      comment: "Types of commodities accepted at this destination"
    - name: "rail_access_available"
      expr: rail_access_available
      comment: "Whether rail access is available"
    - name: "road_access_available"
      expr: road_access_available
      comment: "Whether road access is available"
    - name: "conveyor_system_available"
      expr: conveyor_system_available
      comment: "Whether conveyor system is available"
    - name: "customs_clearance_available"
      expr: customs_clearance_available
      comment: "Whether customs clearance services are available"
  measures:
    - name: "total_delivery_destinations"
      expr: COUNT(1)
      comment: "Total number of delivery destinations"
    - name: "active_destinations"
      expr: SUM(CASE WHEN delivery_destination_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active delivery destinations"
    - name: "total_storage_capacity_tonnes"
      expr: SUM(CAST(storage_capacity_tonnes AS DOUBLE))
      comment: "Total storage capacity across all destinations in tonnes"
    - name: "avg_storage_capacity_tonnes"
      expr: AVG(CAST(storage_capacity_tonnes AS DOUBLE))
      comment: "Average storage capacity per destination in tonnes"
    - name: "avg_loading_rate_tph"
      expr: AVG(CAST(loading_rate_tph AS DOUBLE))
      comment: "Average loading rate in tonnes per hour across destinations"
    - name: "avg_maximum_vessel_loa_m"
      expr: AVG(CAST(maximum_vessel_loa_m AS DOUBLE))
      comment: "Average maximum vessel length overall in meters"
    - name: "avg_maximum_vessel_draft_m"
      expr: AVG(CAST(maximum_vessel_draft_m AS DOUBLE))
      comment: "Average maximum vessel draft in meters"
    - name: "avg_maximum_vessel_beam_m"
      expr: AVG(CAST(maximum_vessel_beam_m AS DOUBLE))
      comment: "Average maximum vessel beam (width) in meters"
    - name: "rail_accessible_destinations"
      expr: SUM(CASE WHEN rail_access_available = TRUE THEN 1 ELSE 0 END)
      comment: "Count of destinations with rail access"
    - name: "conveyor_equipped_destinations"
      expr: SUM(CASE WHEN conveyor_system_available = TRUE THEN 1 ELSE 0 END)
      comment: "Count of destinations with conveyor systems"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segmentation and strategic account metrics tracking volume bands, service tiers, and relationship priorities for mining commodity customers"
  source: "`mining_ecm`.`customer`.`segment`"
  dimensions:
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the customer segment"
    - name: "segment_name"
      expr: segment_name
      comment: "Name of the customer segment"
    - name: "tier_classification"
      expr: tier_classification
      comment: "Tier classification (Tier 1, Tier 2, Tier 3)"
    - name: "volume_band"
      expr: volume_band
      comment: "Annual volume band classification"
    - name: "service_level_tier"
      expr: service_level_tier
      comment: "Service level tier (premium, standard, basic)"
    - name: "commodity_focus"
      expr: commodity_focus
      comment: "Primary commodity focus of the segment"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the segment"
    - name: "country_code"
      expr: country_code
      comment: "Country code for the segment"
    - name: "end_use_industry"
      expr: end_use_industry
      comment: "End-use industry of customers in this segment"
    - name: "strategic_priority_flag"
      expr: strategic_priority_flag
      comment: "Whether this segment is a strategic priority"
    - name: "diversification_target_flag"
      expr: diversification_target_flag
      comment: "Whether this segment is a diversification target"
    - name: "credit_risk_rating"
      expr: credit_risk_rating
      comment: "Credit risk rating for the segment"
  measures:
    - name: "total_segments"
      expr: COUNT(1)
      comment: "Total number of customer segments"
    - name: "active_segments"
      expr: SUM(CASE WHEN segment_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active customer segments"
    - name: "strategic_priority_segments"
      expr: SUM(CASE WHEN strategic_priority_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of segments flagged as strategic priority"
    - name: "diversification_target_segments"
      expr: SUM(CASE WHEN diversification_target_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of segments targeted for diversification"
    - name: "total_min_annual_volume_tonnes"
      expr: SUM(CAST(annual_volume_minimum_tonnes AS DOUBLE))
      comment: "Total minimum annual volume commitment across segments in tonnes"
    - name: "total_max_annual_volume_tonnes"
      expr: SUM(CAST(annual_volume_maximum_tonnes AS DOUBLE))
      comment: "Total maximum annual volume potential across segments in tonnes"
    - name: "avg_min_annual_volume_tonnes"
      expr: AVG(CAST(annual_volume_minimum_tonnes AS DOUBLE))
      comment: "Average minimum annual volume per segment in tonnes"
    - name: "avg_max_annual_volume_tonnes"
      expr: AVG(CAST(annual_volume_maximum_tonnes AS DOUBLE))
      comment: "Average maximum annual volume per segment in tonnes"
$$;