-- Metric views for domain: client | Business: Legal | Version: 1 | Generated on: 2026-05-07 11:54:14

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`client_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core client profile metrics tracking client portfolio composition, credit exposure, and compliance status across the firm's client base"
  source: "`legal_ecm`.`client`.`profile`"
  dimensions:
    - name: "client_status"
      expr: client_status
      comment: "Current status of the client relationship (active, inactive, suspended, etc.)"
    - name: "client_type"
      expr: client_type
      comment: "Classification of client entity type (individual, corporate, government, etc.)"
    - name: "client_tier"
      expr: client_tier
      comment: "Strategic tier classification for client segmentation and service level"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Primary legal jurisdiction of the client"
    - name: "kyc_status"
      expr: kyc_status
      comment: "Know Your Customer compliance status"
    - name: "aml_risk_rating"
      expr: aml_risk_rating
      comment: "Anti-Money Laundering risk rating classification"
    - name: "conflict_check_status"
      expr: conflict_check_status
      comment: "Status of conflict of interest screening"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Standard billing cycle for the client"
    - name: "preferred_billing_currency"
      expr: preferred_billing_currency
      comment: "Currency preference for invoicing"
    - name: "data_protection_classification"
      expr: data_protection_classification
      comment: "Data privacy and protection classification level"
    - name: "engagement_year"
      expr: YEAR(first_engagement_date)
      comment: "Year of first client engagement for cohort analysis"
    - name: "engagement_quarter"
      expr: CONCAT(YEAR(first_engagement_date), '-Q', QUARTER(first_engagement_date))
      comment: "Quarter of first client engagement for cohort tracking"
    - name: "kyc_review_status"
      expr: CASE WHEN kyc_next_review_date < CURRENT_DATE() THEN 'Overdue' WHEN kyc_next_review_date <= DATE_ADD(CURRENT_DATE(), 30) THEN 'Due Soon' ELSE 'Current' END
      comment: "KYC review timeliness status for compliance monitoring"
    - name: "electronic_billing_flag"
      expr: electronic_billing_required_flag
      comment: "Whether client requires electronic billing"
    - name: "afa_eligible_flag"
      expr: afa_eligible_flag
      comment: "Whether client is eligible for alternative fee arrangements"
    - name: "marketing_consent_flag"
      expr: marketing_consent_flag
      comment: "Client consent status for marketing communications"
  measures:
    - name: "total_clients"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total number of unique client profiles"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all clients"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per client"
    - name: "clients_with_credit_limit"
      expr: COUNT(DISTINCT CASE WHEN credit_limit_amount > 0 THEN profile_id END)
      comment: "Number of clients with active credit limits"
    - name: "high_risk_aml_clients"
      expr: COUNT(DISTINCT CASE WHEN aml_risk_rating IN ('High', 'Critical') THEN profile_id END)
      comment: "Number of clients classified as high or critical AML risk"
    - name: "kyc_overdue_clients"
      expr: COUNT(DISTINCT CASE WHEN kyc_next_review_date < CURRENT_DATE() THEN profile_id END)
      comment: "Number of clients with overdue KYC reviews requiring immediate attention"
    - name: "active_clients"
      expr: COUNT(DISTINCT CASE WHEN client_status = 'Active' THEN profile_id END)
      comment: "Number of clients with active relationship status"
    - name: "electronic_billing_adoption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN electronic_billing_required_flag = TRUE THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of clients using electronic billing for operational efficiency tracking"
    - name: "afa_eligible_client_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN afa_eligible_flag = TRUE THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of clients eligible for alternative fee arrangements"
    - name: "conflict_cleared_clients"
      expr: COUNT(DISTINCT CASE WHEN conflict_check_status = 'Cleared' THEN profile_id END)
      comment: "Number of clients with cleared conflict checks"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`client_kyc_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KYC and AML compliance metrics tracking regulatory adherence, risk assessment quality, and review cycle performance"
  source: "`legal_ecm`.`client`.`kyc_record`"
  dimensions:
    - name: "kyc_status"
      expr: kyc_status
      comment: "Current KYC verification status"
    - name: "kyc_tier"
      expr: kyc_tier
      comment: "KYC due diligence tier (standard, enhanced, simplified)"
    - name: "aml_risk_rating"
      expr: aml_risk_rating
      comment: "Anti-Money Laundering risk classification"
    - name: "sanctions_screening_result"
      expr: sanctions_screening_result
      comment: "Result of sanctions list screening"
    - name: "pep_screening_result"
      expr: pep_screening_result
      comment: "Politically Exposed Person screening result"
    - name: "adverse_media_screening_result"
      expr: adverse_media_screening_result
      comment: "Adverse media screening outcome"
    - name: "high_risk_jurisdiction_flag"
      expr: high_risk_jurisdiction_flag
      comment: "Whether client is in a high-risk jurisdiction"
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether KYC record requires escalation to senior compliance"
    - name: "source_of_funds_verified"
      expr: source_of_funds_verified
      comment: "Whether source of funds has been verified"
    - name: "beneficial_ownership_verified"
      expr: beneficial_ownership_verified
      comment: "Whether beneficial ownership has been verified"
    - name: "review_year"
      expr: YEAR(kyc_review_date)
      comment: "Year of KYC review for trend analysis"
    - name: "review_quarter"
      expr: CONCAT(YEAR(kyc_review_date), '-Q', QUARTER(kyc_review_date))
      comment: "Quarter of KYC review for compliance reporting"
    - name: "review_timeliness"
      expr: CASE WHEN next_review_due_date < CURRENT_DATE() THEN 'Overdue' WHEN next_review_due_date <= DATE_ADD(CURRENT_DATE(), 30) THEN 'Due Soon' ELSE 'Current' END
      comment: "KYC review timeliness status for compliance monitoring"
    - name: "is_active"
      expr: is_active
      comment: "Whether KYC record is currently active"
  measures:
    - name: "total_kyc_records"
      expr: COUNT(DISTINCT kyc_record_id)
      comment: "Total number of KYC records in the system"
    - name: "high_risk_aml_records"
      expr: COUNT(DISTINCT CASE WHEN aml_risk_rating IN ('High', 'Critical') THEN kyc_record_id END)
      comment: "Number of KYC records classified as high or critical AML risk"
    - name: "overdue_kyc_reviews"
      expr: COUNT(DISTINCT CASE WHEN next_review_due_date < CURRENT_DATE() AND is_active = TRUE THEN kyc_record_id END)
      comment: "Number of active KYC records with overdue reviews requiring immediate action"
    - name: "escalation_required_records"
      expr: COUNT(DISTINCT CASE WHEN escalation_required_flag = TRUE THEN kyc_record_id END)
      comment: "Number of KYC records requiring senior compliance escalation"
    - name: "sanctions_hits"
      expr: COUNT(DISTINCT CASE WHEN sanctions_screening_result IN ('Match', 'Potential Match') THEN kyc_record_id END)
      comment: "Number of KYC records with sanctions list matches requiring investigation"
    - name: "pep_identified"
      expr: COUNT(DISTINCT CASE WHEN pep_screening_result IN ('Confirmed PEP', 'PEP') THEN kyc_record_id END)
      comment: "Number of KYC records identifying Politically Exposed Persons"
    - name: "adverse_media_hits"
      expr: COUNT(DISTINCT CASE WHEN adverse_media_screening_result IN ('Match', 'Adverse') THEN kyc_record_id END)
      comment: "Number of KYC records with adverse media findings"
    - name: "high_risk_jurisdiction_count"
      expr: COUNT(DISTINCT CASE WHEN high_risk_jurisdiction_flag = TRUE THEN kyc_record_id END)
      comment: "Number of KYC records for clients in high-risk jurisdictions"
    - name: "source_of_funds_verification_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN source_of_funds_verified = TRUE THEN kyc_record_id END) / NULLIF(COUNT(DISTINCT kyc_record_id), 0), 2)
      comment: "Percentage of KYC records with verified source of funds"
    - name: "beneficial_ownership_verification_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN beneficial_ownership_verified = TRUE THEN kyc_record_id END) / NULLIF(COUNT(DISTINCT kyc_record_id), 0), 2)
      comment: "Percentage of KYC records with verified beneficial ownership"
    - name: "kyc_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN kyc_status IN ('Approved', 'Complete') THEN kyc_record_id END) / NULLIF(COUNT(DISTINCT kyc_record_id), 0), 2)
      comment: "Percentage of KYC records with completed verification status"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`client_credit_standing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client credit and collections metrics tracking financial risk, payment performance, and accounts receivable exposure"
  source: "`legal_ecm`.`client`.`credit_standing`"
  dimensions:
    - name: "credit_rating"
      expr: credit_rating
      comment: "Internal credit rating classification"
    - name: "credit_standing_status"
      expr: credit_standing_status
      comment: "Current credit standing status"
    - name: "collections_tier"
      expr: collections_tier
      comment: "Collections priority tier based on risk and exposure"
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Whether client is on credit hold"
    - name: "credit_hold_reason"
      expr: credit_hold_reason
      comment: "Reason for credit hold if applicable"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Standard payment terms for the client"
    - name: "billing_currency_code"
      expr: billing_currency_code
      comment: "Currency used for billing"
    - name: "credit_insurance_flag"
      expr: credit_insurance_flag
      comment: "Whether credit insurance is in place"
    - name: "payment_method_preference"
      expr: payment_method_preference
      comment: "Client's preferred payment method"
    - name: "credit_review_year"
      expr: YEAR(credit_review_date)
      comment: "Year of most recent credit review"
    - name: "credit_review_quarter"
      expr: CONCAT(YEAR(credit_review_date), '-Q', QUARTER(credit_review_date))
      comment: "Quarter of most recent credit review"
    - name: "payment_performance"
      expr: CASE WHEN average_days_to_pay <= '30' THEN 'Excellent' WHEN average_days_to_pay <= '60' THEN 'Good' WHEN average_days_to_pay <= '90' THEN 'Fair' ELSE 'Poor' END
      comment: "Payment performance classification based on average days to pay"
  measures:
    - name: "total_clients_with_credit"
      expr: COUNT(DISTINCT credit_standing_id)
      comment: "Total number of clients with credit standing records"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all clients"
    - name: "total_outstanding_ar"
      expr: SUM(CAST(outstanding_ar_balance AS DOUBLE))
      comment: "Total outstanding accounts receivable balance"
    - name: "total_wip_exposure"
      expr: SUM(CAST(current_wip_exposure AS DOUBLE))
      comment: "Total work-in-progress exposure not yet billed"
    - name: "total_credit_exposure"
      expr: SUM(CAST(total_credit_exposure AS DOUBLE))
      comment: "Total credit exposure combining AR and WIP"
    - name: "total_bad_debt_writeoff"
      expr: SUM(CAST(bad_debt_write_off_total AS DOUBLE))
      comment: "Total bad debt written off"
    - name: "total_retainer_balance"
      expr: SUM(CAST(retainer_balance AS DOUBLE))
      comment: "Total retainer balances held"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per client"
    - name: "avg_outstanding_ar"
      expr: AVG(CAST(outstanding_ar_balance AS DOUBLE))
      comment: "Average outstanding AR balance per client"
    - name: "avg_credit_utilization_pct"
      expr: AVG(CAST(credit_utilization_percentage AS DOUBLE))
      comment: "Average credit utilization percentage across clients"
    - name: "clients_on_credit_hold"
      expr: COUNT(DISTINCT CASE WHEN credit_hold_flag = TRUE THEN credit_standing_id END)
      comment: "Number of clients currently on credit hold"
    - name: "clients_with_credit_insurance"
      expr: COUNT(DISTINCT CASE WHEN credit_insurance_flag = TRUE THEN credit_standing_id END)
      comment: "Number of clients with credit insurance coverage"
    - name: "credit_hold_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN credit_hold_flag = TRUE THEN credit_standing_id END) / NULLIF(COUNT(DISTINCT credit_standing_id), 0), 2)
      comment: "Percentage of clients on credit hold indicating collection risk"
    - name: "bad_debt_rate"
      expr: ROUND(100.0 * SUM(CAST(bad_debt_write_off_total AS DOUBLE)) / NULLIF(SUM(CAST(total_credit_exposure AS DOUBLE)), 0), 2)
      comment: "Bad debt as percentage of total credit exposure"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`client_organisation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corporate client metrics tracking organizational characteristics, compliance status, and relationship maturity"
  source: "`legal_ecm`.`client`.`organisation`"
  dimensions:
    - name: "relationship_status"
      expr: relationship_status
      comment: "Current status of the client relationship"
    - name: "entity_type"
      expr: entity_type
      comment: "Legal entity type classification"
    - name: "industry_sector"
      expr: industry_sector
      comment: "Primary industry sector"
    - name: "jurisdiction_of_incorporation"
      expr: jurisdiction_of_incorporation
      comment: "Legal jurisdiction where entity is incorporated"
    - name: "public_private_status"
      expr: public_private_status
      comment: "Whether organization is publicly traded or private"
    - name: "kyc_status"
      expr: kyc_status
      comment: "KYC verification status"
    - name: "aml_risk_tier"
      expr: aml_risk_tier
      comment: "AML risk tier classification"
    - name: "sanctions_screening_status"
      expr: sanctions_screening_status
      comment: "Sanctions screening status"
    - name: "annual_revenue_range"
      expr: annual_revenue_range
      comment: "Annual revenue range classification"
    - name: "employee_count_range"
      expr: employee_count_range
      comment: "Employee count range classification"
    - name: "payment_terms_days"
      expr: payment_terms_days
      comment: "Standard payment terms in days"
    - name: "is_ultimate_beneficial_owner"
      expr: is_ultimate_beneficial_owner
      comment: "Whether this is the ultimate beneficial owner entity"
    - name: "relationship_year"
      expr: YEAR(relationship_inception_date)
      comment: "Year relationship was established"
    - name: "relationship_quarter"
      expr: CONCAT(YEAR(relationship_inception_date), '-Q', QUARTER(relationship_inception_date))
      comment: "Quarter relationship was established"
    - name: "kyc_review_status"
      expr: CASE WHEN kyc_next_review_date < CURRENT_DATE() THEN 'Overdue' WHEN kyc_next_review_date <= DATE_ADD(CURRENT_DATE(), 30) THEN 'Due Soon' ELSE 'Current' END
      comment: "KYC review timeliness status"
  measures:
    - name: "total_organisations"
      expr: COUNT(DISTINCT organisation_id)
      comment: "Total number of organizational clients"
    - name: "active_organisations"
      expr: COUNT(DISTINCT CASE WHEN relationship_status = 'Active' THEN organisation_id END)
      comment: "Number of organizations with active relationships"
    - name: "public_companies"
      expr: COUNT(DISTINCT CASE WHEN public_private_status = 'Public' THEN organisation_id END)
      comment: "Number of publicly traded company clients"
    - name: "high_risk_aml_organisations"
      expr: COUNT(DISTINCT CASE WHEN aml_risk_tier IN ('High', 'Critical') THEN organisation_id END)
      comment: "Number of organizations classified as high AML risk"
    - name: "kyc_overdue_organisations"
      expr: COUNT(DISTINCT CASE WHEN kyc_next_review_date < CURRENT_DATE() THEN organisation_id END)
      comment: "Number of organizations with overdue KYC reviews"
    - name: "sanctions_cleared_organisations"
      expr: COUNT(DISTINCT CASE WHEN sanctions_screening_status = 'Cleared' THEN organisation_id END)
      comment: "Number of organizations with cleared sanctions screening"
    - name: "total_credit_limit_extended"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended to organizational clients"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per organizational client"
    - name: "ultimate_beneficial_owners"
      expr: COUNT(DISTINCT CASE WHEN is_ultimate_beneficial_owner = TRUE THEN organisation_id END)
      comment: "Number of organizations identified as ultimate beneficial owners"
    - name: "organisations_with_lei"
      expr: COUNT(DISTINCT CASE WHEN lei_code IS NOT NULL THEN organisation_id END)
      comment: "Number of organizations with Legal Entity Identifier codes"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`client_beneficial_owner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Beneficial ownership transparency metrics tracking ultimate ownership, control structures, and regulatory compliance"
  source: "`legal_ecm`.`client`.`beneficial_owner`"
  dimensions:
    - name: "beneficial_owner_status"
      expr: beneficial_owner_status
      comment: "Current status of beneficial owner record"
    - name: "nature_of_control"
      expr: nature_of_control
      comment: "Type of control exercised by beneficial owner"
    - name: "pep_status"
      expr: pep_status
      comment: "Politically Exposed Person status"
    - name: "sanctions_status"
      expr: sanctions_status
      comment: "Sanctions screening status"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating classification"
    - name: "country_of_residence"
      expr: country_of_residence
      comment: "Country of residence"
    - name: "nationality"
      expr: nationality
      comment: "Nationality of beneficial owner"
    - name: "tax_residence_country"
      expr: tax_residence_country
      comment: "Country of tax residence"
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify beneficial ownership"
    - name: "adverse_media_flag"
      expr: adverse_media_flag
      comment: "Whether adverse media was identified"
    - name: "sanctions_list_match"
      expr: sanctions_list_match
      comment: "Sanctions list match result"
    - name: "disclosure_year"
      expr: YEAR(disclosure_date)
      comment: "Year beneficial ownership was disclosed"
    - name: "review_timeliness"
      expr: CASE WHEN next_review_date < CURRENT_DATE() THEN 'Overdue' WHEN next_review_date <= DATE_ADD(CURRENT_DATE(), 30) THEN 'Due Soon' ELSE 'Current' END
      comment: "Review timeliness status"
    - name: "ownership_tier"
      expr: CASE WHEN ownership_percentage >= 50 THEN 'Majority' WHEN ownership_percentage >= 25 THEN 'Significant' WHEN ownership_percentage >= 10 THEN 'Material' ELSE 'Minor' END
      comment: "Ownership percentage tier classification"
  measures:
    - name: "total_beneficial_owners"
      expr: COUNT(DISTINCT beneficial_owner_id)
      comment: "Total number of beneficial owner records"
    - name: "pep_identified"
      expr: COUNT(DISTINCT CASE WHEN pep_status IN ('Confirmed', 'PEP') THEN beneficial_owner_id END)
      comment: "Number of beneficial owners identified as Politically Exposed Persons"
    - name: "sanctions_hits"
      expr: COUNT(DISTINCT CASE WHEN sanctions_status IN ('Match', 'Hit') THEN beneficial_owner_id END)
      comment: "Number of beneficial owners with sanctions list matches"
    - name: "adverse_media_identified"
      expr: COUNT(DISTINCT CASE WHEN adverse_media_flag = TRUE THEN beneficial_owner_id END)
      comment: "Number of beneficial owners with adverse media findings"
    - name: "high_risk_beneficial_owners"
      expr: COUNT(DISTINCT CASE WHEN risk_rating IN ('High', 'Critical') THEN beneficial_owner_id END)
      comment: "Number of beneficial owners classified as high risk"
    - name: "overdue_reviews"
      expr: COUNT(DISTINCT CASE WHEN next_review_date < CURRENT_DATE() THEN beneficial_owner_id END)
      comment: "Number of beneficial owner records with overdue reviews"
    - name: "avg_ownership_percentage"
      expr: AVG(CAST(ownership_percentage AS DOUBLE))
      comment: "Average ownership percentage across beneficial owners"
    - name: "majority_owners"
      expr: COUNT(DISTINCT CASE WHEN ownership_percentage >= 50 THEN beneficial_owner_id END)
      comment: "Number of beneficial owners with majority control"
    - name: "verified_beneficial_owners"
      expr: COUNT(DISTINCT CASE WHEN verification_date IS NOT NULL THEN beneficial_owner_id END)
      comment: "Number of beneficial owners with completed verification"
    - name: "pep_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pep_status IN ('Confirmed', 'PEP') THEN beneficial_owner_id END) / NULLIF(COUNT(DISTINCT beneficial_owner_id), 0), 2)
      comment: "Percentage of beneficial owners identified as PEPs"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`client_relationship_team`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client relationship team metrics tracking coverage, responsibility allocation, and relationship management effectiveness"
  source: "`legal_ecm`.`client`.`relationship_team`"
  dimensions:
    - name: "relationship_role_type"
      expr: relationship_role_type
      comment: "Type of relationship role (partner, manager, associate, etc.)"
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of team assignment"
    - name: "is_primary_contact"
      expr: is_primary_contact
      comment: "Whether this is the primary client contact"
    - name: "billing_authority_level"
      expr: billing_authority_level
      comment: "Level of billing authority granted"
    - name: "conflict_check_authority"
      expr: conflict_check_authority
      comment: "Whether team member has conflict check authority"
    - name: "client_satisfaction_responsibility"
      expr: client_satisfaction_responsibility
      comment: "Whether responsible for client satisfaction"
    - name: "cross_sell_target_flag"
      expr: cross_sell_target_flag
      comment: "Whether client is a cross-sell target"
    - name: "succession_plan_flag"
      expr: succession_plan_flag
      comment: "Whether succession plan is in place"
    - name: "practice_area_coverage"
      expr: practice_area_coverage
      comment: "Practice areas covered by team member"
    - name: "geographic_coverage_region"
      expr: geographic_coverage_region
      comment: "Geographic region covered"
    - name: "assignment_year"
      expr: YEAR(assignment_start_date)
      comment: "Year of team assignment"
    - name: "contact_recency"
      expr: CASE WHEN last_client_contact_date >= DATE_SUB(CURRENT_DATE(), 30) THEN 'Recent' WHEN last_client_contact_date >= DATE_SUB(CURRENT_DATE(), 90) THEN 'Moderate' ELSE 'Stale' END
      comment: "Recency of last client contact"
  measures:
    - name: "total_relationship_assignments"
      expr: COUNT(DISTINCT relationship_team_id)
      comment: "Total number of relationship team assignments"
    - name: "active_assignments"
      expr: COUNT(DISTINCT CASE WHEN assignment_status = 'Active' THEN relationship_team_id END)
      comment: "Number of active relationship team assignments"
    - name: "primary_contacts"
      expr: COUNT(DISTINCT CASE WHEN is_primary_contact = TRUE THEN relationship_team_id END)
      comment: "Number of primary client contact assignments"
    - name: "cross_sell_targets"
      expr: COUNT(DISTINCT CASE WHEN cross_sell_target_flag = TRUE THEN relationship_team_id END)
      comment: "Number of clients flagged as cross-sell targets"
    - name: "succession_plans_in_place"
      expr: COUNT(DISTINCT CASE WHEN succession_plan_flag = TRUE THEN relationship_team_id END)
      comment: "Number of relationship assignments with succession plans"
    - name: "avg_responsibility_percentage"
      expr: AVG(CAST(responsibility_percentage AS DOUBLE))
      comment: "Average responsibility percentage per team member"
    - name: "avg_origination_credit"
      expr: AVG(CAST(origination_credit_percentage AS DOUBLE))
      comment: "Average origination credit percentage"
    - name: "stale_relationships"
      expr: COUNT(DISTINCT CASE WHEN last_client_contact_date < DATE_SUB(CURRENT_DATE(), 90) THEN relationship_team_id END)
      comment: "Number of relationships with no contact in 90+ days requiring attention"
    - name: "unique_clients_covered"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique clients covered by relationship teams"
    - name: "succession_plan_coverage_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN succession_plan_flag = TRUE THEN relationship_team_id END) / NULLIF(COUNT(DISTINCT relationship_team_id), 0), 2)
      comment: "Percentage of relationships with succession plans for continuity risk management"
$$;