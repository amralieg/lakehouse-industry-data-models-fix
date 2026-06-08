-- Metric views for domain: customs | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 22:31:03

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customs_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customs declaration metrics tracking declaration volumes, values, duty assessments, and processing efficiency across trade lanes and customs authorities"
  source: "`transport_shipping_ecm`.`customs`.`declaration`"
  dimensions:
    - name: "declaration_type"
      expr: declaration_type
      comment: "Type of customs declaration (import, export, transit, etc.)"
    - name: "declaration_status"
      expr: declaration_status
      comment: "Current status of the declaration (submitted, accepted, rejected, released, etc.)"
    - name: "customs_authority"
      expr: customs_authority
      comment: "Customs authority processing the declaration"
    - name: "country_of_destination"
      expr: country_of_destination
      comment: "Destination country for the goods"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Origin country of the goods"
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms governing the shipment"
    - name: "customs_procedure_code"
      expr: customs_procedure_code
      comment: "Customs procedure code applied to the declaration"
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year the declaration was filed"
    - name: "filing_month"
      expr: DATE_TRUNC('MONTH', filing_date)
      comment: "Month the declaration was filed"
    - name: "inspection_required"
      expr: inspection_required
      comment: "Whether physical inspection is required"
    - name: "denied_party_screening_status"
      expr: denied_party_screening_status
      comment: "Status of denied party screening for the declaration"
  measures:
    - name: "total_declarations"
      expr: COUNT(1)
      comment: "Total number of customs declarations filed"
    - name: "total_declared_value"
      expr: SUM(CAST(total_declared_value AS DOUBLE))
      comment: "Total declared value of goods across all declarations"
    - name: "total_duty_amount"
      expr: SUM(CAST(total_duty_amount AS DOUBLE))
      comment: "Total customs duty assessed across all declarations"
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax amount assessed across all declarations"
    - name: "avg_declared_value_per_declaration"
      expr: AVG(CAST(total_declared_value AS DOUBLE))
      comment: "Average declared value per customs declaration"
    - name: "avg_duty_per_declaration"
      expr: AVG(CAST(total_duty_amount AS DOUBLE))
      comment: "Average duty amount per customs declaration"
    - name: "effective_duty_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_duty_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_declared_value AS DOUBLE)), 0), 2)
      comment: "Effective duty rate as percentage of declared value (total duty / total declared value)"
    - name: "inspection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN inspection_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of declarations requiring physical inspection"
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN declaration_status = 'rejected' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of declarations rejected by customs"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customs_duty_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Duty and tax assessment metrics tracking revenue collection, assessment accuracy, payment compliance, and dispute rates across customs entries"
  source: "`transport_shipping_ecm`.`customs`.`duty_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the duty assessment (pending, assessed, paid, disputed, etc.)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of assessed duties and taxes"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the goods being assessed"
    - name: "entry_type"
      expr: entry_type
      comment: "Type of customs entry (formal, informal, etc.)"
    - name: "import_export_indicator"
      expr: import_export_indicator
      comment: "Whether this is an import or export assessment"
    - name: "preferential_tariff_program"
      expr: preferential_tariff_program
      comment: "Preferential tariff program applied (FTA, GSP, etc.)"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the duty was assessed"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month the duty was assessed"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which duties and taxes are assessed"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of duty assessments processed"
    - name: "total_customs_duty"
      expr: SUM(CAST(customs_duty_amount AS DOUBLE))
      comment: "Total customs duty assessed"
    - name: "total_vat"
      expr: SUM(CAST(vat_amount AS DOUBLE))
      comment: "Total VAT assessed"
    - name: "total_anti_dumping_duty"
      expr: SUM(CAST(anti_dumping_duty_amount AS DOUBLE))
      comment: "Total anti-dumping duty assessed"
    - name: "total_countervailing_duty"
      expr: SUM(CAST(countervailing_duty_amount AS DOUBLE))
      comment: "Total countervailing duty assessed"
    - name: "total_excise_tax"
      expr: SUM(CAST(excise_tax_amount AS DOUBLE))
      comment: "Total excise tax assessed"
    - name: "total_duty_tax_revenue"
      expr: SUM(CAST(total_duty_tax_amount AS DOUBLE))
      comment: "Total duty and tax revenue assessed across all types"
    - name: "total_customs_value"
      expr: SUM(CAST(customs_value_amount AS DOUBLE))
      comment: "Total customs value of goods assessed"
    - name: "avg_duty_per_assessment"
      expr: AVG(CAST(total_duty_tax_amount AS DOUBLE))
      comment: "Average duty and tax amount per assessment"
    - name: "effective_total_duty_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_duty_tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(customs_value_amount AS DOUBLE)), 0), 2)
      comment: "Effective total duty rate as percentage of customs value"
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN dispute_filed_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments with disputes filed"
    - name: "payment_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN payment_status = 'paid' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments with payment completed"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customs_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customs hold and examination metrics tracking hold frequency, duration, resolution efficiency, and financial impact on supply chain operations"
  source: "`transport_shipping_ecm`.`customs`.`hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the customs hold"
    - name: "type_code"
      expr: type_code
      comment: "Type code of the customs hold"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the hold being placed"
    - name: "examination_type_code"
      expr: examination_type_code
      comment: "Type of examination required (physical, documentary, etc.)"
    - name: "examination_result_code"
      expr: examination_result_code
      comment: "Result of the examination conducted"
    - name: "issuing_authority_code"
      expr: issuing_authority_code
      comment: "Authority that issued the hold"
    - name: "country_of_examination_code"
      expr: country_of_examination_code
      comment: "Country where examination took place"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the hold"
    - name: "placed_year"
      expr: YEAR(CAST(placed_timestamp AS DATE))
      comment: "Year the hold was placed"
    - name: "placed_month"
      expr: DATE_TRUNC('MONTH', CAST(placed_timestamp AS DATE))
      comment: "Month the hold was placed"
    - name: "sla_breach_indicator"
      expr: sla_breach_indicator
      comment: "Whether the hold breached service level agreement"
  measures:
    - name: "total_holds"
      expr: COUNT(1)
      comment: "Total number of customs holds placed"
    - name: "total_hold_duration_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total duration of all holds in hours"
    - name: "avg_hold_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average hold duration in hours"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount assessed from holds"
    - name: "total_financial_impact"
      expr: SUM(CAST(total_financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of holds including penalties and delays"
    - name: "avg_financial_impact_per_hold"
      expr: AVG(CAST(total_financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per hold"
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds that breached service level agreements"
    - name: "hold_release_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_release_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds that have been released"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of holds placed"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customs_broker_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customs broker performance metrics tracking assignment efficiency, filing accuracy, release times, and service quality across brokerage operations"
  source: "`transport_shipping_ecm`.`customs`.`broker_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the broker assignment"
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of broker assignment"
    - name: "assignment_priority"
      expr: assignment_priority
      comment: "Priority level of the assignment"
    - name: "brokerage_office_location"
      expr: brokerage_office_location
      comment: "Location of the brokerage office handling the assignment"
    - name: "assigned_country_code"
      expr: assigned_country_code
      comment: "Country code where broker is assigned"
    - name: "service_level_agreement"
      expr: service_level_agreement
      comment: "Service level agreement tier for the assignment"
    - name: "assignment_year"
      expr: YEAR(assignment_date)
      comment: "Year the broker was assigned"
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month the broker was assigned"
    - name: "aeo_certified_flag"
      expr: aeo_certified_flag
      comment: "Whether the broker is AEO certified"
    - name: "ctpat_certified_flag"
      expr: ctpat_certified_flag
      comment: "Whether the broker is C-TPAT certified"
    - name: "exception_flag"
      expr: exception_flag
      comment: "Whether the assignment has exceptions"
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of broker assignments"
    - name: "total_broker_fees"
      expr: SUM(CAST(broker_fee_amount AS DOUBLE))
      comment: "Total broker fees charged across all assignments"
    - name: "avg_broker_fee"
      expr: AVG(CAST(broker_fee_amount AS DOUBLE))
      comment: "Average broker fee per assignment"
    - name: "avg_release_time_hours"
      expr: AVG(CAST(average_release_time_hours AS DOUBLE))
      comment: "Average release time in hours across broker assignments"
    - name: "avg_filing_accuracy_rate"
      expr: AVG(CAST(filing_accuracy_rate AS DOUBLE))
      comment: "Average filing accuracy rate across broker assignments"
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN exception_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments with exceptions"
    - name: "on_time_filing_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_filing_date <= estimated_filing_date THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments filed on or before estimated date"
    - name: "on_time_release_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_release_date <= estimated_release_date THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments released on or before estimated date"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customs_denied_party_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Denied party screening metrics tracking compliance screening effectiveness, match rates, false positives, and regulatory hold impact"
  source: "`transport_shipping_ecm`.`customs`.`denied_party_screening`"
  dimensions:
    - name: "screening_status"
      expr: screening_status
      comment: "Status of the denied party screening"
    - name: "match_status"
      expr: match_status
      comment: "Match status from screening (clear, potential match, confirmed match)"
    - name: "party_type"
      expr: party_type
      comment: "Type of party being screened (shipper, consignee, etc.)"
    - name: "matched_list_name"
      expr: matched_list_name
      comment: "Name of the denied party list where match was found"
    - name: "matched_entity_program"
      expr: matched_entity_program
      comment: "Sanctions or denied party program of matched entity"
    - name: "compliance_program"
      expr: compliance_program
      comment: "Compliance program under which screening was conducted"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the screening result"
    - name: "screening_year"
      expr: YEAR(CAST(screening_run_timestamp AS DATE))
      comment: "Year the screening was run"
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', CAST(screening_run_timestamp AS DATE))
      comment: "Month the screening was run"
    - name: "analyst_review_required_flag"
      expr: analyst_review_required_flag
      comment: "Whether analyst review is required"
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Whether a regulatory hold was placed"
    - name: "false_positive_flag"
      expr: false_positive_flag
      comment: "Whether the match was determined to be a false positive"
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of denied party screenings conducted"
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match score across all screenings"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all screenings"
    - name: "match_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN match_status IN ('potential_match', 'confirmed_match') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings resulting in potential or confirmed matches"
    - name: "false_positive_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN false_positive_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings determined to be false positives"
    - name: "regulatory_hold_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_hold_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings resulting in regulatory holds"
    - name: "analyst_review_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN analyst_review_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings requiring analyst review"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customs_origin_determination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Origin determination and preferential tariff metrics tracking duty savings, regional value content, origin criteria compliance, and FTA utilization"
  source: "`transport_shipping_ecm`.`customs`.`origin_determination`"
  dimensions:
    - name: "determination_status"
      expr: determination_status
      comment: "Status of the origin determination"
    - name: "determination_method"
      expr: determination_method
      comment: "Method used to determine origin"
    - name: "country_of_origin_code"
      expr: country_of_origin_code
      comment: "Determined country of origin code"
    - name: "origin_criterion_met"
      expr: origin_criterion_met
      comment: "Origin criterion that was met for preferential treatment"
    - name: "rvc_calculation_method"
      expr: rvc_calculation_method
      comment: "Regional value content calculation method used"
    - name: "issuing_authority_country_code"
      expr: issuing_authority_country_code
      comment: "Country code of the issuing authority"
    - name: "determination_year"
      expr: YEAR(determination_date)
      comment: "Year the origin determination was made"
    - name: "determination_month"
      expr: DATE_TRUNC('MONTH', determination_date)
      comment: "Month the origin determination was made"
    - name: "verified_by_customs_authority"
      expr: verified_by_customs_authority
      comment: "Whether the determination was verified by customs authority"
  measures:
    - name: "total_determinations"
      expr: COUNT(1)
      comment: "Total number of origin determinations made"
    - name: "total_duty_savings"
      expr: SUM(CAST(duty_savings_amount AS DOUBLE))
      comment: "Total duty savings achieved through preferential origin determinations"
    - name: "avg_duty_savings_per_determination"
      expr: AVG(CAST(duty_savings_amount AS DOUBLE))
      comment: "Average duty savings per origin determination"
    - name: "avg_regional_value_content_pct"
      expr: AVG(CAST(regional_value_content_percent AS DOUBLE))
      comment: "Average regional value content percentage across determinations"
    - name: "avg_preferential_tariff_rate"
      expr: AVG(CAST(preferential_tariff_rate_percent AS DOUBLE))
      comment: "Average preferential tariff rate applied"
    - name: "avg_standard_tariff_rate"
      expr: AVG(CAST(standard_tariff_rate_percent AS DOUBLE))
      comment: "Average standard tariff rate that would have applied"
    - name: "tariff_rate_reduction_pct"
      expr: ROUND(AVG(CAST(standard_tariff_rate_percent AS DOUBLE)) - AVG(CAST(preferential_tariff_rate_percent AS DOUBLE)), 2)
      comment: "Average tariff rate reduction achieved through preferential treatment"
    - name: "customs_verification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN verified_by_customs_authority = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of determinations verified by customs authority"
    - name: "total_originating_materials_value"
      expr: SUM(CAST(originating_materials_value AS DOUBLE))
      comment: "Total value of originating materials across all determinations"
    - name: "total_non_originating_materials_value"
      expr: SUM(CAST(non_originating_materials_value AS DOUBLE))
      comment: "Total value of non-originating materials across all determinations"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customs_compliance_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trusted trader and compliance program metrics tracking AEO/C-TPAT membership, certification status, audit outcomes, and program benefits utilization"
  source: "`transport_shipping_ecm`.`customs`.`compliance_program`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Type of compliance program (AEO, C-TPAT, etc.)"
    - name: "program_name"
      expr: program_name
      comment: "Name of the compliance program"
    - name: "membership_status"
      expr: membership_status
      comment: "Current membership status in the program"
    - name: "membership_tier"
      expr: membership_tier
      comment: "Membership tier or level within the program"
    - name: "participant_type"
      expr: participant_type
      comment: "Type of participant (importer, exporter, carrier, etc.)"
    - name: "authority_country_code"
      expr: authority_country_code
      comment: "Country code of the certifying authority"
    - name: "certifying_authority"
      expr: certifying_authority
      comment: "Authority that certified the participant"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the program membership was approved"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the program membership was approved"
    - name: "expedited_release_flag"
      expr: expedited_release_flag
      comment: "Whether expedited release benefit is available"
    - name: "reduced_examination_rate_flag"
      expr: reduced_examination_rate_flag
      comment: "Whether reduced examination rate benefit is available"
  measures:
    - name: "total_program_memberships"
      expr: COUNT(1)
      comment: "Total number of compliance program memberships"
    - name: "active_membership_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN membership_status = 'active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of memberships that are currently active"
    - name: "expedited_release_eligibility_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN expedited_release_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of memberships eligible for expedited release"
    - name: "reduced_examination_eligibility_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reduced_examination_rate_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of memberships eligible for reduced examination rates"
$$;