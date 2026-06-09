-- Metric views for domain: intellectual | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 17:48:18

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_annuity_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Annuity Fee business metrics"
  source: "`pharmaceuticals_ecm`.`intellectual`.`annuity_fee`"
  dimensions:
    - name: "Bank Reference Number"
      expr: bank_reference_number
    - name: "Confirmation Receipt Number"
      expr: confirmation_receipt_number
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Covered Product Name"
      expr: covered_product_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Due Date"
      expr: due_date
    - name: "Entity Size Category"
      expr: entity_size_category
    - name: "Fee Reference Number"
      expr: fee_reference_number
    - name: "Fee Schedule Version"
      expr: fee_schedule_version
    - name: "Fee Year"
      expr: fee_year
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Grace Period End Date"
      expr: grace_period_end_date
    - name: "Instruction Date"
      expr: instruction_date
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Lapse Date"
      expr: lapse_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Annuity Fee"
      expr: COUNT(DISTINCT annuity_fee_id)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Fee Amount"
      expr: SUM(fee_amount)
    - name: "Average Fee Amount"
      expr: AVG(fee_amount)
    - name: "Total Functional Currency Amount"
      expr: SUM(functional_currency_amount)
    - name: "Average Functional Currency Amount"
      expr: AVG(functional_currency_amount)
    - name: "Total Surcharge Amount"
      expr: SUM(surcharge_amount)
    - name: "Average Surcharge Amount"
      expr: AVG(surcharge_amount)
    - name: "Total Total Payment Amount"
      expr: SUM(total_payment_amount)
    - name: "Average Total Payment Amount"
      expr: AVG(total_payment_amount)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_blocking_patent_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blocking Patent Assessment business metrics"
  source: "`pharmaceuticals_ecm`.`intellectual`.`blocking_patent_assessment`"
  dimensions:
    - name: "Assessing Attorney"
      expr: assessing_attorney
    - name: "Assessment Date"
      expr: assessment_date
    - name: "Blocking Patent Count"
      expr: blocking_patent_count
    - name: "Blocking Patent Numbers"
      expr: blocking_patent_numbers
    - name: "Claim Mapping"
      expr: claim_mapping
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Around Strategy"
      expr: design_around_strategy
    - name: "Invalidity Assessment"
      expr: invalidity_assessment
    - name: "Licensing Recommendation"
      expr: licensing_recommendation
    - name: "Non Infringement Rationale"
      expr: non_infringement_rationale
    - name: "Risk Level Per Patent"
      expr: risk_level_per_patent
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Assessment Date Month"
      expr: DATE_TRUNC('MONTH', assessment_date)
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Blocking Patent Assessment"
      expr: COUNT(DISTINCT blocking_patent_assessment_id)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_drug_master_file`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug Master File business metrics"
  source: "`pharmaceuticals_ecm`.`intellectual`.`drug_master_file`"
  dimensions:
    - name: "Api Manufacturer Flag"
      expr: api_manufacturer_flag
    - name: "Atc Code"
      expr: atc_code
    - name: "Cas Number"
      expr: cas_number
    - name: "Cmc Section Reference"
      expr: cmc_section_reference
    - name: "Confidentiality Commitment Date"
      expr: confidentiality_commitment_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cross Reference Count"
      expr: cross_reference_count
    - name: "Dmf Number"
      expr: dmf_number
    - name: "Dmf Status"
      expr: dmf_status
    - name: "Dmf Type"
      expr: dmf_type
    - name: "Dosage Form"
      expr: dosage_form
    - name: "Ectd Sequence Number"
      expr: ectd_sequence_number
    - name: "Effective Date"
      expr: effective_date
    - name: "Fda Establishment Identifier"
      expr: fda_establishment_identifier
    - name: "Gmp Certificate Expiry Date"
      expr: gmp_certificate_expiry_date
    - name: "Gmp Certificate Number"
      expr: gmp_certificate_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Drug Master File"
      expr: COUNT(DISTINCT drug_master_file_id)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_exclusivity_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Exclusivity Period business metrics"
  source: "`pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Brand Name"
      expr: brand_name
    - name: "Challenge Status"
      expr: challenge_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Package Type"
      expr: data_package_type
    - name: "Dmf Number"
      expr: dmf_number
    - name: "Dosage Form"
      expr: dosage_form
    - name: "Exclusivity Category"
      expr: exclusivity_category
    - name: "Exclusivity Code"
      expr: exclusivity_code
    - name: "Exclusivity Duration Months"
      expr: exclusivity_duration_months
    - name: "Exclusivity Expiry Date"
      expr: exclusivity_expiry_date
    - name: "Exclusivity Start Date"
      expr: exclusivity_start_date
    - name: "Exclusivity Status"
      expr: exclusivity_status
    - name: "Exclusivity Type"
      expr: exclusivity_type
    - name: "First Generic Entry Date"
      expr: first_generic_entry_date
    - name: "Granting Authority"
      expr: granting_authority
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Exclusivity Period"
      expr: COUNT(DISTINCT exclusivity_period_id)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_fto_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fto Analysis business metrics"
  source: "`pharmaceuticals_ecm`.`intellectual`.`fto_analysis`"
  dimensions:
    - name: "Affected Product Names"
      expr: affected_product_names
    - name: "Analysis Date"
      expr: analysis_date
    - name: "Analysis Number"
      expr: analysis_number
    - name: "Analysis Status"
      expr: analysis_status
    - name: "Analysis Title"
      expr: analysis_title
    - name: "Analysis Type"
      expr: analysis_type
    - name: "Competitor Filing Date"
      expr: competitor_filing_date
    - name: "Competitor Name"
      expr: competitor_name
    - name: "Competitor Reference Number"
      expr: competitor_reference_number
    - name: "Conducting Attorney"
      expr: conducting_attorney
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Around Required"
      expr: design_around_required
    - name: "Dmf Reference Number"
      expr: dmf_reference_number
    - name: "Exclusivity Expiry Date"
      expr: exclusivity_expiry_date
    - name: "Exclusivity Type"
      expr: exclusivity_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fto Analysis"
      expr: COUNT(DISTINCT fto_analysis_id)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_invention_disclosure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invention Disclosure business metrics"
  source: "`pharmaceuticals_ecm`.`intellectual`.`invention_disclosure`"
  dimensions:
    - name: "Business Unit"
      expr: business_unit
    - name: "Co Inventor Names"
      expr: co_inventor_names
    - name: "Commercial Relevance Score"
      expr: commercial_relevance_score
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decision Date"
      expr: decision_date
    - name: "Defensive Publication Date"
      expr: defensive_publication_date
    - name: "Disclosure Number"
      expr: disclosure_number
    - name: "Disclosure Status"
      expr: disclosure_status
    - name: "Disclosure Type"
      expr: disclosure_type
    - name: "Elb Reference"
      expr: elb_reference
    - name: "External Counsel Ref"
      expr: external_counsel_ref
    - name: "Fto Assessment Status"
      expr: fto_assessment_status
    - name: "Fto Clearance Opinion"
      expr: fto_clearance_opinion
    - name: "Inventive Step Assessment"
      expr: inventive_step_assessment
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Invention Disclosure"
      expr: COUNT(DISTINCT invention_disclosure_id)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_ip_agreement_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ip Agreement Milestone business metrics"
  source: "`pharmaceuticals_ecm`.`intellectual`.`ip_agreement_milestone`"
  dimensions:
    - name: "Achieved Date"
      expr: achieved_date
    - name: "Clinical Phase"
      expr: clinical_phase
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Due Date"
      expr: due_date
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Legal Counsel Reference"
      expr: legal_counsel_reference
    - name: "Licensed Product Name"
      expr: licensed_product_name
    - name: "Milestone Description"
      expr: milestone_description
    - name: "Milestone Number"
      expr: milestone_number
    - name: "Milestone Status"
      expr: milestone_status
    - name: "Milestone Subtype"
      expr: milestone_subtype
    - name: "Milestone Type"
      expr: milestone_type
    - name: "Notification Date"
      expr: notification_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ip Agreement Milestone"
      expr: COUNT(DISTINCT ip_agreement_milestone_id)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Functional Currency Amount"
      expr: SUM(functional_currency_amount)
    - name: "Average Functional Currency Amount"
      expr: AVG(functional_currency_amount)
    - name: "Total Milestone Payment Amount"
      expr: SUM(milestone_payment_amount)
    - name: "Average Milestone Payment Amount"
      expr: AVG(milestone_payment_amount)
    - name: "Total Sales Threshold Amount"
      expr: SUM(sales_threshold_amount)
    - name: "Average Sales Threshold Amount"
      expr: AVG(sales_threshold_amount)
    - name: "Total Withholding Tax Amount"
      expr: SUM(withholding_tax_amount)
    - name: "Average Withholding Tax Amount"
      expr: AVG(withholding_tax_amount)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_ip_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ip Valuation business metrics"
  source: "`pharmaceuticals_ecm`.`intellectual`.`ip_valuation`"
  dimensions:
    - name: "Amortization Method"
      expr: amortization_method
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Development Stage"
      expr: development_stage
    - name: "Exclusivity Expiry Date"
      expr: exclusivity_expiry_date
    - name: "Impairment Indicator Flag"
      expr: impairment_indicator_flag
    - name: "Ip Asset Type"
      expr: ip_asset_type
    - name: "Litigation Support Flag"
      expr: litigation_support_flag
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Rd Capitalization Flag"
      expr: rd_capitalization_flag
    - name: "Report Issue Date"
      expr: report_issue_date
    - name: "Sap Asset Number"
      expr: sap_asset_number
    - name: "Therapeutic Area"
      expr: therapeutic_area
    - name: "Transfer Pricing Flag"
      expr: transfer_pricing_flag
    - name: "Updated Timestamp"
      expr: updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ip Valuation"
      expr: COUNT(DISTINCT ip_valuation_id)
    - name: "Total Annual Amortization Charge"
      expr: SUM(annual_amortization_charge)
    - name: "Average Annual Amortization Charge"
      expr: AVG(annual_amortization_charge)
    - name: "Total Carrying Value"
      expr: SUM(carrying_value)
    - name: "Average Carrying Value"
      expr: AVG(carrying_value)
    - name: "Total Discount Rate Pct"
      expr: SUM(discount_rate_pct)
    - name: "Average Discount Rate Pct"
      expr: AVG(discount_rate_pct)
    - name: "Total Fair Market Value"
      expr: SUM(fair_market_value)
    - name: "Average Fair Market Value"
      expr: AVG(fair_market_value)
    - name: "Total Impairment Loss Amount"
      expr: SUM(impairment_loss_amount)
    - name: "Average Impairment Loss Amount"
      expr: AVG(impairment_loss_amount)
    - name: "Total Peak Sales Forecast"
      expr: SUM(peak_sales_forecast)
    - name: "Average Peak Sales Forecast"
      expr: AVG(peak_sales_forecast)
    - name: "Total Probability Of Success Pct"
      expr: SUM(probability_of_success_pct)
    - name: "Average Probability Of Success Pct"
      expr: AVG(probability_of_success_pct)
    - name: "Total Risk Adjusted Npv"
      expr: SUM(risk_adjusted_npv)
    - name: "Average Risk Adjusted Npv"
      expr: AVG(risk_adjusted_npv)
    - name: "Total Royalty Rate Pct"
      expr: SUM(royalty_rate_pct)
    - name: "Average Royalty Rate Pct"
      expr: AVG(royalty_rate_pct)
    - name: "Total Useful Economic Life Years"
      expr: SUM(useful_economic_life_years)
    - name: "Average Useful Economic Life Years"
      expr: AVG(useful_economic_life_years)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_ip_watch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ip Watch business metrics"
  source: "`pharmaceuticals_ecm`.`intellectual`.`ip_watch`"
  dimensions:
    - name: "Affected Ndc"
      expr: affected_ndc
    - name: "Affected Product Name"
      expr: affected_product_name
    - name: "Authority Name"
      expr: authority_name
    - name: "Biosimilar Interchangeability"
      expr: biosimilar_interchangeability
    - name: "Closed Date"
      expr: closed_date
    - name: "Competitor Country"
      expr: competitor_country
    - name: "Competitor Name"
      expr: competitor_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Detected Date"
      expr: detected_date
    - name: "Estimated Generic Entry Date"
      expr: estimated_generic_entry_date
    - name: "Exclusivity At Risk"
      expr: exclusivity_at_risk
    - name: "Filing Date"
      expr: filing_date
    - name: "Filing Reference Number"
      expr: filing_reference_number
    - name: "Fto Analysis Required"
      expr: fto_analysis_required
    - name: "Fto Analysis Status"
      expr: fto_analysis_status
    - name: "Lawsuit Filed"
      expr: lawsuit_filed
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ip Watch"
      expr: COUNT(DISTINCT ip_watch_id)
    - name: "Total Commercial Revenue At Risk"
      expr: SUM(commercial_revenue_at_risk)
    - name: "Average Commercial Revenue At Risk"
      expr: AVG(commercial_revenue_at_risk)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_licensing_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Licensing Agreement business metrics"
  source: "`pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`"
  dimensions:
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Change Of Control Provision"
      expr: change_of_control_provision
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Diligence Obligations"
      expr: diligence_obligations
    - name: "Dispute Resolution Mechanism"
      expr: dispute_resolution_mechanism
    - name: "Effective Date"
      expr: effective_date
    - name: "Exclusivity Type"
      expr: exclusivity_type
    - name: "Execution Date"
      expr: execution_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Field Of Use"
      expr: field_of_use
    - name: "Governing Law"
      expr: governing_law
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Legal Counsel Reference"
      expr: legal_counsel_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Licensing Agreement"
      expr: COUNT(DISTINCT licensing_agreement_id)
    - name: "Total Commercial Milestone Value"
      expr: SUM(commercial_milestone_value)
    - name: "Average Commercial Milestone Value"
      expr: AVG(commercial_milestone_value)
    - name: "Total Development Milestone Value"
      expr: SUM(development_milestone_value)
    - name: "Average Development Milestone Value"
      expr: AVG(development_milestone_value)
    - name: "Total Regulatory Milestone Value"
      expr: SUM(regulatory_milestone_value)
    - name: "Average Regulatory Milestone Value"
      expr: AVG(regulatory_milestone_value)
    - name: "Total Royalty Rate"
      expr: SUM(royalty_rate)
    - name: "Average Royalty Rate"
      expr: AVG(royalty_rate)
    - name: "Total Total Deal Value"
      expr: SUM(total_deal_value)
    - name: "Average Total Deal Value"
      expr: AVG(total_deal_value)
    - name: "Total Total Milestone Value"
      expr: SUM(total_milestone_value)
    - name: "Average Total Milestone Value"
      expr: AVG(total_milestone_value)
    - name: "Total Upfront Payment Amount"
      expr: SUM(upfront_payment_amount)
    - name: "Average Upfront Payment Amount"
      expr: AVG(upfront_payment_amount)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_orange_book_listing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Orange Book Listing business metrics"
  source: "`pharmaceuticals_ecm`.`intellectual`.`orange_book_listing`"
  dimensions:
    - name: "Anda First Filer Flag"
      expr: anda_first_filer_flag
    - name: "Applicant Name"
      expr: applicant_name
    - name: "Atc Code"
      expr: atc_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delisting Date"
      expr: delisting_date
    - name: "Dosage Form"
      expr: dosage_form
    - name: "First Generic Eligibility Date"
      expr: first_generic_eligibility_date
    - name: "Listing Date"
      expr: listing_date
    - name: "Listing Status"
      expr: listing_status
    - name: "Litigation Status"
      expr: litigation_status
    - name: "Market"
      expr: market
    - name: "Nda Number"
      expr: nda_number
    - name: "Orphan Drug Designation Flag"
      expr: orphan_drug_designation_flag
    - name: "Paragraph Iv Date"
      expr: paragraph_iv_date
    - name: "Paragraph Iv Flag"
      expr: paragraph_iv_flag
    - name: "Patent Expiry Date"
      expr: patent_expiry_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Orange Book Listing"
      expr: COUNT(DISTINCT orange_book_listing_id)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_patent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patent business metrics"
  source: "`pharmaceuticals_ecm`.`intellectual`.`patent`"
  dimensions:
    - name: "Adjusted Expiry Date"
      expr: adjusted_expiry_date
    - name: "Annuity Paid Through Date"
      expr: annuity_paid_through_date
    - name: "Asset Classification"
      expr: asset_classification
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Exclusivity Expiry"
      expr: data_exclusivity_expiry
    - name: "Expiry Date"
      expr: expiry_date
    - name: "External Counsel Ref"
      expr: external_counsel_ref
    - name: "Filing Date"
      expr: filing_date
    - name: "Fto Clearance Status"
      expr: fto_clearance_status
    - name: "Grant Date"
      expr: grant_date
    - name: "Legal Status"
      expr: legal_status
    - name: "Litigation Flag"
      expr: litigation_flag
    - name: "Maintenance Fee Due Date"
      expr: maintenance_fee_due_date
    - name: "Orange Book Listed"
      expr: orange_book_listed
    - name: "Orphan Drug Exclusivity Expiry"
      expr: orphan_drug_exclusivity_expiry
    - name: "Ownership Type"
      expr: ownership_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Patent"
      expr: COUNT(DISTINCT patent_id)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_patent_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patent Claim business metrics"
  source: "`pharmaceuticals_ecm`.`intellectual`.`patent_claim`"
  dimensions:
    - name: "Amendment Date"
      expr: amendment_date
    - name: "Application Number"
      expr: application_number
    - name: "Challenge Status"
      expr: challenge_status
    - name: "Claim Amendment Version"
      expr: claim_amendment_version
    - name: "Claim Category"
      expr: claim_category
    - name: "Claim Number"
      expr: claim_number
    - name: "Claim Priority Date"
      expr: claim_priority_date
    - name: "Claim Scope Classification"
      expr: claim_scope_classification
    - name: "Claim Text"
      expr: claim_text
    - name: "Claim Type"
      expr: claim_type
    - name: "Cpc Classification Code"
      expr: cpc_classification_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Filing Date"
      expr: filing_date
    - name: "Fto Relevance Flag"
      expr: fto_relevance_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Patent Claim"
      expr: COUNT(DISTINCT patent_claim_id)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_patent_family`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patent Family business metrics"
  source: "`pharmaceuticals_ecm`.`intellectual`.`patent_family`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Exclusivity Expiry Date"
      expr: data_exclusivity_expiry_date
    - name: "Dmf Reference Number"
      expr: dmf_reference_number
    - name: "Earliest Expiry Date"
      expr: earliest_expiry_date
    - name: "Family Code"
      expr: family_code
    - name: "Family Name"
      expr: family_name
    - name: "Family Status"
      expr: family_status
    - name: "Family Type"
      expr: family_type
    - name: "Filing Date"
      expr: filing_date
    - name: "Freedom To Operate Status"
      expr: freedom_to_operate_status
    - name: "Granted Member Count"
      expr: granted_member_count
    - name: "Invention Category"
      expr: invention_category
    - name: "Invention Title"
      expr: invention_title
    - name: "Jurisdiction Count"
      expr: jurisdiction_count
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Latest Expiry Date"
      expr: latest_expiry_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Patent Family"
      expr: COUNT(DISTINCT patent_family_id)
    - name: "Total Annual Maintenance Cost Usd"
      expr: SUM(annual_maintenance_cost_usd)
    - name: "Average Annual Maintenance Cost Usd"
      expr: AVG(annual_maintenance_cost_usd)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_patent_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patent License business metrics"
  source: "`pharmaceuticals_ecm`.`intellectual`.`patent_license`"
  dimensions:
    - name: "Diligence Obligations"
      expr: diligence_obligations
    - name: "Enforcement Rights"
      expr: enforcement_rights
    - name: "Exclusion Date"
      expr: exclusion_date
    - name: "Exclusivity Type"
      expr: exclusivity_type
    - name: "Field Of Use"
      expr: field_of_use
    - name: "Inclusion Date"
      expr: inclusion_date
    - name: "License Scope"
      expr: license_scope
    - name: "License Status"
      expr: license_status
    - name: "Maintenance Fee Responsibility"
      expr: maintenance_fee_responsibility
    - name: "Prosecution Control"
      expr: prosecution_control
    - name: "Sublicensing Permitted"
      expr: sublicensing_permitted
    - name: "Territory"
      expr: territory
    - name: "Exclusion Date Month"
      expr: DATE_TRUNC('MONTH', exclusion_date)
    - name: "Inclusion Date Month"
      expr: DATE_TRUNC('MONTH', inclusion_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Patent License"
      expr: COUNT(DISTINCT patent_license_id)
    - name: "Total Patent Specific Milestone Value"
      expr: SUM(patent_specific_milestone_value)
    - name: "Average Patent Specific Milestone Value"
      expr: AVG(patent_specific_milestone_value)
    - name: "Total Patent Specific Upfront Payment"
      expr: SUM(patent_specific_upfront_payment)
    - name: "Average Patent Specific Upfront Payment"
      expr: AVG(patent_specific_upfront_payment)
    - name: "Total Royalty Rate"
      expr: SUM(royalty_rate)
    - name: "Average Royalty Rate"
      expr: AVG(royalty_rate)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_patent_litigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patent Litigation business metrics"
  source: "`pharmaceuticals_ecm`.`intellectual`.`patent_litigation`"
  dimensions:
    - name: "Appeal Court"
      expr: appeal_court
    - name: "Appeal Filed"
      expr: appeal_filed
    - name: "Asserted Patent Numbers"
      expr: asserted_patent_numbers
    - name: "Case Notes"
      expr: case_notes
    - name: "Case Number"
      expr: case_number
    - name: "Case Priority"
      expr: case_priority
    - name: "Case Type"
      expr: case_type
    - name: "Court Or Tribunal"
      expr: court_or_tribunal
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Filing Date"
      expr: filing_date
    - name: "First Filer Status"
      expr: first_filer_status
    - name: "Institution Decision Date"
      expr: institution_decision_date
    - name: "Ipr Petition Number"
      expr: ipr_petition_number
    - name: "Judgment Date"
      expr: judgment_date
    - name: "Lead Outside Counsel"
      expr: lead_outside_counsel
    - name: "Litigation Status"
      expr: litigation_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Patent Litigation"
      expr: COUNT(DISTINCT patent_litigation_id)
    - name: "Total Actual Legal Spend Usd"
      expr: SUM(actual_legal_spend_usd)
    - name: "Average Actual Legal Spend Usd"
      expr: AVG(actual_legal_spend_usd)
    - name: "Total Estimated Liability Usd"
      expr: SUM(estimated_liability_usd)
    - name: "Average Estimated Liability Usd"
      expr: AVG(estimated_liability_usd)
    - name: "Total Legal Budget Usd"
      expr: SUM(legal_budget_usd)
    - name: "Average Legal Budget Usd"
      expr: AVG(legal_budget_usd)
    - name: "Total Revenue At Risk Usd"
      expr: SUM(revenue_at_risk_usd)
    - name: "Average Revenue At Risk Usd"
      expr: AVG(revenue_at_risk_usd)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_patent_prosecution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patent Prosecution business metrics"
  source: "`pharmaceuticals_ecm`.`intellectual`.`patent_prosecution`"
  dimensions:
    - name: "Abandonment Date"
      expr: abandonment_date
    - name: "Annuity Due Date"
      expr: annuity_due_date
    - name: "Annuity Fee Currency"
      expr: annuity_fee_currency
    - name: "Annuity Fee Year"
      expr: annuity_fee_year
    - name: "Annuity Grace Period End Date"
      expr: annuity_grace_period_end_date
    - name: "Annuity Payment Date"
      expr: annuity_payment_date
    - name: "Annuity Payment Status"
      expr: annuity_payment_status
    - name: "Application Number"
      expr: application_number
    - name: "Application Type"
      expr: application_type
    - name: "Claim Count"
      expr: claim_count
    - name: "Cpc Classification"
      expr: cpc_classification
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Examiner Art Unit"
      expr: examiner_art_unit
    - name: "Examiner Name"
      expr: examiner_name
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Filing Date"
      expr: filing_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Patent Prosecution"
      expr: COUNT(DISTINCT patent_prosecution_id)
    - name: "Total Annuity Fee Amount"
      expr: SUM(annuity_fee_amount)
    - name: "Average Annuity Fee Amount"
      expr: AVG(annuity_fee_amount)
    - name: "Total Annuity Surcharge Amount"
      expr: SUM(annuity_surcharge_amount)
    - name: "Average Annuity Surcharge Amount"
      expr: AVG(annuity_surcharge_amount)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_patent_term_extension`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patent Term Extension business metrics"
  source: "`pharmaceuticals_ecm`.`intellectual`.`patent_term_extension`"
  dimensions:
    - name: "Adjusted Expiry Date"
      expr: adjusted_expiry_date
    - name: "Applicant Delay Days"
      expr: applicant_delay_days
    - name: "Application Number"
      expr: application_number
    - name: "Approval Phase Start Date"
      expr: approval_phase_start_date
    - name: "Atc Code"
      expr: atc_code
    - name: "Base Patent Expiry Date"
      expr: base_patent_expiry_date
    - name: "Base Patent Number"
      expr: base_patent_number
    - name: "Calculated Extension Days"
      expr: calculated_extension_days
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Exclusivity Expiry Date"
      expr: data_exclusivity_expiry_date
    - name: "Decision Status"
      expr: decision_status
    - name: "External Counsel Reference"
      expr: external_counsel_reference
    - name: "Filing Date"
      expr: filing_date
    - name: "Grant Date"
      expr: grant_date
    - name: "Granted Extension Days"
      expr: granted_extension_days
    - name: "Granting Authority"
      expr: granting_authority
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Patent Term Extension"
      expr: COUNT(DISTINCT patent_term_extension_id)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_royalty_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty Payment business metrics"
  source: "`pharmaceuticals_ecm`.`intellectual`.`royalty_payment`"
  dimensions:
    - name: "Audit Flag"
      expr: audit_flag
    - name: "Bank Reference Number"
      expr: bank_reference_number
    - name: "Calculation Period End Date"
      expr: calculation_period_end_date
    - name: "Calculation Period Start Date"
      expr: calculation_period_start_date
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Due Date"
      expr: due_date
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Licensed Territory"
      expr: licensed_territory
    - name: "Payment Date"
      expr: payment_date
    - name: "Payment Direction"
      expr: payment_direction
    - name: "Payment Method"
      expr: payment_method
    - name: "Payment Reference Number"
      expr: payment_reference_number
    - name: "Payment Status"
      expr: payment_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Royalty Payment"
      expr: COUNT(DISTINCT royalty_payment_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Deductions Amount"
      expr: SUM(deductions_amount)
    - name: "Average Deductions Amount"
      expr: AVG(deductions_amount)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Functional Currency Amount"
      expr: SUM(functional_currency_amount)
    - name: "Average Functional Currency Amount"
      expr: AVG(functional_currency_amount)
    - name: "Total Gross Sales Amount"
      expr: SUM(gross_sales_amount)
    - name: "Average Gross Sales Amount"
      expr: AVG(gross_sales_amount)
    - name: "Total Minimum Royalty Amount"
      expr: SUM(minimum_royalty_amount)
    - name: "Average Minimum Royalty Amount"
      expr: AVG(minimum_royalty_amount)
    - name: "Total Net Sales Amount"
      expr: SUM(net_sales_amount)
    - name: "Average Net Sales Amount"
      expr: AVG(net_sales_amount)
    - name: "Total Royalty Amount"
      expr: SUM(royalty_amount)
    - name: "Average Royalty Amount"
      expr: AVG(royalty_amount)
    - name: "Total Royalty Rate"
      expr: SUM(royalty_rate)
    - name: "Average Royalty Rate"
      expr: AVG(royalty_rate)
    - name: "Total Total Payment Amount"
      expr: SUM(total_payment_amount)
    - name: "Average Total Payment Amount"
      expr: AVG(total_payment_amount)
    - name: "Total Units Sold"
      expr: SUM(units_sold)
    - name: "Average Units Sold"
      expr: AVG(units_sold)
    - name: "Total Withholding Tax Amount"
      expr: SUM(withholding_tax_amount)
    - name: "Average Withholding Tax Amount"
      expr: AVG(withholding_tax_amount)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_spc_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spc Filing business metrics"
  source: "`pharmaceuticals_ecm`.`intellectual`.`spc_filing`"
  dimensions:
    - name: "Annuity Due Date"
      expr: annuity_due_date
    - name: "Annuity Fee Currency"
      expr: annuity_fee_currency
    - name: "Application Number"
      expr: application_number
    - name: "Atc Code"
      expr: atc_code
    - name: "Basic Patent Expiry Date"
      expr: basic_patent_expiry_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Exclusivity Expiry Date"
      expr: data_exclusivity_expiry_date
    - name: "External Law Firm"
      expr: external_law_firm
    - name: "Filing Date"
      expr: filing_date
    - name: "Filing Status"
      expr: filing_status
    - name: "First Eu Ma Date"
      expr: first_eu_ma_date
    - name: "Grant Date"
      expr: grant_date
    - name: "Granting Authority"
      expr: granting_authority
    - name: "Marketing Authorization Date"
      expr: marketing_authorization_date
    - name: "Marketing Authorization Number"
      expr: marketing_authorization_number
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Spc Filing"
      expr: COUNT(DISTINCT spc_filing_id)
    - name: "Total Annuity Fee Amount"
      expr: SUM(annuity_fee_amount)
    - name: "Average Annuity Fee Amount"
      expr: AVG(annuity_fee_amount)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`intellectual_trademark`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trademark business metrics"
  source: "`pharmaceuticals_ecm`.`intellectual`.`trademark`"
  dimensions:
    - name: "Application Number"
      expr: application_number
    - name: "Associated Brand Name"
      expr: associated_brand_name
    - name: "Colour Claim"
      expr: colour_claim
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Disclaimer Text"
      expr: disclaimer_text
    - name: "Expiry Date"
      expr: expiry_date
    - name: "External Counsel Firm"
      expr: external_counsel_firm
    - name: "Filing Date"
      expr: filing_date
    - name: "Goods Services Description"
      expr: goods_services_description
    - name: "Inn Name"
      expr: inn_name
    - name: "Internal Reference Code"
      expr: internal_reference_code
    - name: "Licensing Flag"
      expr: licensing_flag
    - name: "Litigation Flag"
      expr: litigation_flag
    - name: "Madrid International Number"
      expr: madrid_international_number
    - name: "Madrid Protocol Flag"
      expr: madrid_protocol_flag
    - name: "Mark Type"
      expr: mark_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Trademark"
      expr: COUNT(DISTINCT trademark_id)
$$;