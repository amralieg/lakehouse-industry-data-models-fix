-- Metric views for domain: vendor | Business: Advertising | Version: 1 | Generated on: 2026-05-08 02:24:04

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice financial performance and reconciliation metrics tracking vendor billing accuracy, payment timing, and variance management"
  source: "`advertising_ecm`.`vendor`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., pending, approved, paid, disputed)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., media, production, talent, platform fee)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice is denominated"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed with the vendor (e.g., Net 30, Net 60)"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month when the invoice was issued"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month when the invoice was paid"
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start)
      comment: "Month of the billing period start"
    - name: "brand_safety_compliant"
      expr: brand_safety_compliant
      comment: "Whether the invoice meets brand safety compliance requirements"
    - name: "invalid_traffic_flag"
      expr: invalid_traffic_flag
      comment: "Flag indicating presence of invalid traffic in the billed activity"
    - name: "discrepancy_reason_code"
      expr: discrepancy_reason_code
      comment: "Code categorizing the reason for billing discrepancies"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and adjustments"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts"
    - name: "total_approved_billing_amount"
      expr: SUM(CAST(approved_billing_amount AS DOUBLE))
      comment: "Total amount approved for billing after reconciliation"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between invoiced and approved amounts"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across invoices"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all invoices"
    - name: "total_payable_amount"
      expr: SUM(CAST(total_payable_amount AS DOUBLE))
      comment: "Total amount payable to vendors including all adjustments and taxes"
    - name: "invoice_count"
      expr: COUNT(invoice_id)
      comment: "Total number of invoices"
    - name: "disputed_invoice_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_id IS NOT NULL THEN invoice_id END)
      comment: "Number of invoices with active or historical disputes"
    - name: "avg_days_to_payment"
      expr: AVG(DATEDIFF(payment_date, issue_date))
      comment: "Average number of days from invoice issue to payment"
    - name: "overdue_invoice_count"
      expr: COUNT(DISTINCT CASE WHEN payment_date IS NULL AND payment_due_date < CURRENT_DATE() THEN invoice_id END)
      comment: "Number of unpaid invoices past their due date"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`vendor_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor billing reconciliation metrics tracking accuracy, variance tolerance, and resolution efficiency"
  source: "`advertising_ecm`.`vendor`.`reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current status of the reconciliation (e.g., pending, approved, disputed)"
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation (e.g., media delivery, talent payment, platform fee)"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Status of discrepancy resolution"
    - name: "discrepancy_reason_code"
      expr: discrepancy_reason_code
      comment: "Code categorizing the reason for reconciliation discrepancies"
    - name: "within_tolerance_flag"
      expr: within_tolerance_flag
      comment: "Whether the variance is within acceptable tolerance thresholds"
    - name: "makegood_flag"
      expr: makegood_flag
      comment: "Whether the reconciliation involves makegood inventory"
    - name: "channel_type"
      expr: channel_type
      comment: "Media channel type being reconciled"
    - name: "buying_method"
      expr: buying_method
      comment: "Method used to purchase the media (e.g., programmatic, direct)"
    - name: "period_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month of the reconciliation period start"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which amounts are reconciled"
  measures:
    - name: "total_vendor_invoiced_amount"
      expr: SUM(CAST(vendor_invoiced_amount AS DOUBLE))
      comment: "Total amount invoiced by vendors"
    - name: "total_adserver_delivered_amount"
      expr: SUM(CAST(adserver_delivered_amount AS DOUBLE))
      comment: "Total amount based on ad server delivery data"
    - name: "total_io_authorized_amount"
      expr: SUM(CAST(io_authorized_amount AS DOUBLE))
      comment: "Total amount authorized in insertion orders"
    - name: "total_approved_billing_amount"
      expr: SUM(CAST(approved_billing_amount AS DOUBLE))
      comment: "Total amount approved for billing after reconciliation"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between vendor invoiced and approved amounts"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average variance percentage across reconciliations"
    - name: "total_credit_note_amount"
      expr: SUM(CAST(credit_note_amount AS DOUBLE))
      comment: "Total value of credit notes issued during reconciliation"
    - name: "reconciliation_count"
      expr: COUNT(reconciliation_id)
      comment: "Total number of reconciliation records"
    - name: "within_tolerance_count"
      expr: COUNT(DISTINCT CASE WHEN within_tolerance_flag = TRUE THEN reconciliation_id END)
      comment: "Number of reconciliations within acceptable variance tolerance"
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(resolution_date, period_end_date))
      comment: "Average number of days from period end to discrepancy resolution"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`vendor_invoice_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice dispute resolution metrics tracking dispute volume, resolution efficiency, and financial impact"
  source: "`advertising_ecm`.`vendor`.`invoice_dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g., open, under review, resolved, escalated)"
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of dispute (e.g., billing error, delivery discrepancy, quality issue)"
    - name: "dispute_category"
      expr: dispute_category
      comment: "Category of the dispute for classification"
    - name: "dispute_reason"
      expr: dispute_reason
      comment: "Specific reason for the dispute"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the dispute"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation level of the dispute"
    - name: "resolution_method"
      expr: resolution_method
      comment: "Method used to resolve the dispute"
    - name: "is_recurring_issue"
      expr: is_recurring_issue
      comment: "Whether this dispute represents a recurring issue with the vendor"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the dispute involves compliance concerns"
    - name: "opened_month"
      expr: DATE_TRUNC('MONTH', dispute_opened_date)
      comment: "Month when the dispute was opened"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which disputed amounts are denominated"
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total amount approved after dispute resolution"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount resulting from dispute resolution"
    - name: "dispute_count"
      expr: COUNT(invoice_dispute_id)
      comment: "Total number of invoice disputes"
    - name: "resolved_dispute_count"
      expr: COUNT(DISTINCT CASE WHEN resolution_timestamp IS NOT NULL THEN invoice_dispute_id END)
      comment: "Number of disputes that have been resolved"
    - name: "escalated_dispute_count"
      expr: COUNT(DISTINCT CASE WHEN escalation_date IS NOT NULL THEN invoice_dispute_id END)
      comment: "Number of disputes that have been escalated"
    - name: "recurring_issue_count"
      expr: COUNT(DISTINCT CASE WHEN is_recurring_issue = TRUE THEN invoice_dispute_id END)
      comment: "Number of disputes flagged as recurring issues"
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(actual_resolution_date, dispute_opened_date))
      comment: "Average number of days from dispute opening to resolution"
    - name: "avg_days_to_escalation"
      expr: AVG(DATEDIFF(escalation_date, dispute_opened_date))
      comment: "Average number of days from dispute opening to escalation"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`vendor_performance_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance evaluation metrics tracking quality, compliance, delivery fulfillment, and strategic partnership value"
  source: "`advertising_ecm`.`vendor`.`performance_evaluation`"
  dimensions:
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the performance evaluation"
    - name: "evaluation_cycle"
      expr: evaluation_cycle
      comment: "Evaluation cycle period (e.g., quarterly, annual)"
    - name: "evaluation_year"
      expr: evaluation_year
      comment: "Year of the evaluation"
    - name: "vendor_category"
      expr: vendor_category
      comment: "Category of vendor being evaluated"
    - name: "preferred_vendor_tier"
      expr: preferred_vendor_tier
      comment: "Current preferred vendor tier assignment"
    - name: "prior_preferred_vendor_tier"
      expr: prior_preferred_vendor_tier
      comment: "Previous preferred vendor tier for trend analysis"
    - name: "contract_renewal_recommendation"
      expr: contract_renewal_recommendation
      comment: "Recommendation for contract renewal based on performance"
    - name: "mrc_accreditation_status"
      expr: mrc_accreditation_status
      comment: "MRC accreditation status of the vendor"
    - name: "tag_certification_status"
      expr: tag_certification_status
      comment: "TAG certification status for fraud prevention"
    - name: "vendor_dispute_flag"
      expr: vendor_dispute_flag
      comment: "Whether the vendor has active disputes"
    - name: "evaluation_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month when the evaluation was conducted"
    - name: "scorecard_rating_scale"
      expr: scorecard_rating_scale
      comment: "Scale used for scorecard rating"
  measures:
    - name: "avg_overall_scorecard_rating"
      expr: AVG(CAST(overall_scorecard_rating AS DOUBLE))
      comment: "Average overall scorecard rating across evaluations"
    - name: "avg_prior_scorecard_rating"
      expr: AVG(CAST(prior_scorecard_rating AS DOUBLE))
      comment: "Average prior scorecard rating for trend comparison"
    - name: "avg_delivery_fulfillment_rate"
      expr: AVG(CAST(delivery_fulfillment_rate AS DOUBLE))
      comment: "Average rate of delivery fulfillment against commitments"
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate"
    - name: "avg_response_time_sla_adherence_rate"
      expr: AVG(CAST(response_time_sla_adherence_rate AS DOUBLE))
      comment: "Average SLA adherence rate for response times"
    - name: "avg_viewability_rate"
      expr: AVG(CAST(viewability_rate AS DOUBLE))
      comment: "Average viewability rate for media placements"
    - name: "avg_invalid_traffic_rate"
      expr: AVG(CAST(invalid_traffic_rate AS DOUBLE))
      comment: "Average invalid traffic rate detected"
    - name: "total_io_committed_units"
      expr: SUM(CAST(io_committed_units AS BIGINT))
      comment: "Total units committed in insertion orders"
    - name: "total_actual_delivered_units"
      expr: SUM(CAST(actual_delivered_units AS BIGINT))
      comment: "Total units actually delivered"
    - name: "evaluation_count"
      expr: COUNT(performance_evaluation_id)
      comment: "Total number of performance evaluations conducted"
    - name: "vendor_with_disputes_count"
      expr: COUNT(DISTINCT CASE WHEN vendor_dispute_flag = TRUE THEN performance_evaluation_id END)
      comment: "Number of evaluations where vendor had active disputes"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`vendor_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier master metrics tracking vendor portfolio composition, accreditation status, and strategic partnership attributes"
  source: "`advertising_ecm`.`vendor`.`supplier`"
  dimensions:
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor (e.g., media, production, technology, talent)"
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current onboarding status of the supplier"
    - name: "media_channel"
      expr: media_channel
      comment: "Primary media channel the supplier operates in"
    - name: "platform_type"
      expr: platform_type
      comment: "Type of platform or service provided"
    - name: "programmatic_supply_role"
      expr: programmatic_supply_role
      comment: "Role in programmatic supply chain (e.g., SSP, DSP, exchange)"
    - name: "brand_safety_tier"
      expr: brand_safety_tier
      comment: "Brand safety tier classification"
    - name: "mrc_accredited"
      expr: mrc_accredited
      comment: "Whether the supplier is MRC accredited"
    - name: "tag_certified_against_fraud"
      expr: tag_certified_against_fraud
      comment: "Whether the supplier is TAG certified for fraud prevention"
    - name: "diversity_certified"
      expr: diversity_certified
      comment: "Whether the supplier holds diversity certification"
    - name: "diversity_cert_type"
      expr: diversity_cert_type
      comment: "Type of diversity certification held"
    - name: "spo_enabled"
      expr: spo_enabled
      comment: "Whether supply path optimization is enabled"
    - name: "ads_txt_verified"
      expr: ads_txt_verified
      comment: "Whether ads.txt verification is complete"
    - name: "data_sharing_agreement"
      expr: data_sharing_agreement
      comment: "Whether a data sharing agreement is in place"
    - name: "country_code"
      expr: country_code
      comment: "Country where the supplier is based"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Standard payment terms with the supplier"
    - name: "onboarding_year"
      expr: YEAR(onboarding_date)
      comment: "Year when the supplier was onboarded"
  measures:
    - name: "supplier_count"
      expr: COUNT(supplier_id)
      comment: "Total number of suppliers in the portfolio"
    - name: "mrc_accredited_count"
      expr: COUNT(DISTINCT CASE WHEN mrc_accredited = TRUE THEN supplier_id END)
      comment: "Number of MRC accredited suppliers"
    - name: "tag_certified_count"
      expr: COUNT(DISTINCT CASE WHEN tag_certified_against_fraud = TRUE THEN supplier_id END)
      comment: "Number of TAG certified suppliers"
    - name: "diversity_certified_count"
      expr: COUNT(DISTINCT CASE WHEN diversity_certified = TRUE THEN supplier_id END)
      comment: "Number of diversity certified suppliers"
    - name: "spo_enabled_count"
      expr: COUNT(DISTINCT CASE WHEN spo_enabled = TRUE THEN supplier_id END)
      comment: "Number of suppliers with supply path optimization enabled"
    - name: "ads_txt_verified_count"
      expr: COUNT(DISTINCT CASE WHEN ads_txt_verified = TRUE THEN supplier_id END)
      comment: "Number of suppliers with verified ads.txt"
    - name: "total_audience_reach"
      expr: SUM(CAST(audience_reach AS BIGINT))
      comment: "Total audience reach across all suppliers"
    - name: "avg_audience_reach"
      expr: AVG(CAST(audience_reach AS BIGINT))
      comment: "Average audience reach per supplier"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`vendor_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor risk assessment metrics tracking financial stability, compliance posture, data security, and overall risk exposure"
  source: "`advertising_ecm`.`vendor`.`risk_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the risk assessment"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment conducted"
    - name: "overall_risk_rating"
      expr: overall_risk_rating
      comment: "Overall risk rating classification (e.g., low, medium, high, critical)"
    - name: "financial_stability_rating"
      expr: financial_stability_rating
      comment: "Financial stability rating of the vendor"
    - name: "brand_safety_risk"
      expr: brand_safety_risk
      comment: "Brand safety risk level"
    - name: "business_continuity_risk"
      expr: business_continuity_risk
      comment: "Business continuity risk level"
    - name: "concentration_risk"
      expr: concentration_risk
      comment: "Concentration risk level (dependency on single vendor)"
    - name: "data_security_posture"
      expr: data_security_posture
      comment: "Data security posture assessment"
    - name: "gdpr_compliance_status"
      expr: gdpr_compliance_status
      comment: "GDPR compliance status"
    - name: "ccpa_compliance_status"
      expr: ccpa_compliance_status
      comment: "CCPA compliance status"
    - name: "gdpr_risk_level"
      expr: gdpr_risk_level
      comment: "GDPR-related risk level"
    - name: "ccpa_risk_level"
      expr: ccpa_risk_level
      comment: "CCPA-related risk level"
    - name: "iso27001_certified"
      expr: iso27001_certified
      comment: "Whether the vendor is ISO 27001 certified"
    - name: "soc2_compliant"
      expr: soc2_compliant
      comment: "Whether the vendor is SOC 2 compliant"
    - name: "mrc_accredited"
      expr: mrc_accredited
      comment: "Whether the vendor is MRC accredited"
    - name: "tag_certified"
      expr: tag_certified
      comment: "Whether the vendor is TAG certified"
    - name: "data_breach_history_flag"
      expr: data_breach_history_flag
      comment: "Whether the vendor has a history of data breaches"
    - name: "business_continuity_plan_verified"
      expr: business_continuity_plan_verified
      comment: "Whether the vendor's business continuity plan has been verified"
    - name: "insurance_coverage_verified"
      expr: insurance_coverage_verified
      comment: "Whether adequate insurance coverage has been verified"
    - name: "client_mandated_flag"
      expr: client_mandated_flag
      comment: "Whether the risk assessment is mandated by client requirements"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year when the risk assessment was conducted"
  measures:
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average overall risk score across assessments"
    - name: "avg_financial_risk_score"
      expr: AVG(CAST(financial_risk_score AS DOUBLE))
      comment: "Average financial risk score"
    - name: "avg_revenue_dependency_pct"
      expr: AVG(CAST(revenue_dependency_pct AS DOUBLE))
      comment: "Average percentage of revenue dependent on assessed vendors"
    - name: "total_insurance_coverage_amount"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage amount across vendors"
    - name: "assessment_count"
      expr: COUNT(risk_assessment_id)
      comment: "Total number of risk assessments conducted"
    - name: "high_risk_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN overall_risk_rating IN ('High', 'Critical') THEN risk_assessment_id END)
      comment: "Number of vendors classified as high or critical risk"
    - name: "data_breach_history_count"
      expr: COUNT(DISTINCT CASE WHEN data_breach_history_flag = TRUE THEN risk_assessment_id END)
      comment: "Number of vendors with data breach history"
    - name: "iso27001_certified_count"
      expr: COUNT(DISTINCT CASE WHEN iso27001_certified = TRUE THEN risk_assessment_id END)
      comment: "Number of ISO 27001 certified vendors"
    - name: "soc2_compliant_count"
      expr: COUNT(DISTINCT CASE WHEN soc2_compliant = TRUE THEN risk_assessment_id END)
      comment: "Number of SOC 2 compliant vendors"
    - name: "gdpr_compliant_count"
      expr: COUNT(DISTINCT CASE WHEN gdpr_compliance_status = 'Compliant' THEN risk_assessment_id END)
      comment: "Number of GDPR compliant vendors"
    - name: "ccpa_compliant_count"
      expr: COUNT(DISTINCT CASE WHEN ccpa_compliance_status = 'Compliant' THEN risk_assessment_id END)
      comment: "Number of CCPA compliant vendors"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`vendor_accreditation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor accreditation and certification metrics tracking compliance credentials, audit cycles, and regulatory adherence"
  source: "`advertising_ecm`.`vendor`.`accreditation`"
  dimensions:
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Current status of the accreditation"
    - name: "accreditation_tier"
      expr: accreditation_tier
      comment: "Tier level of the accreditation"
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification held"
    - name: "certification_name"
      expr: certification_name
      comment: "Name of the certification"
    - name: "certifying_body"
      expr: certifying_body
      comment: "Organization that issued the certification"
    - name: "audit_cycle"
      expr: audit_cycle
      comment: "Audit cycle frequency (e.g., annual, biennial)"
    - name: "mrc_accredited"
      expr: mrc_accredited
      comment: "Whether MRC accreditation is held"
    - name: "iab_gold_standard"
      expr: iab_gold_standard
      comment: "Whether IAB Gold Standard certification is held"
    - name: "brand_safety_certified"
      expr: brand_safety_certified
      comment: "Whether brand safety certification is held"
    - name: "anti_fraud_certified"
      expr: anti_fraud_certified
      comment: "Whether anti-fraud certification is held"
    - name: "gdpr_compliant"
      expr: gdpr_compliant
      comment: "Whether GDPR compliance is certified"
    - name: "ccpa_compliant"
      expr: ccpa_compliant
      comment: "Whether CCPA compliance is certified"
    - name: "channel_scope"
      expr: channel_scope
      comment: "Media channels covered by the accreditation"
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope of the accreditation"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year when the accreditation was issued"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year when the accreditation expires"
  measures:
    - name: "accreditation_count"
      expr: COUNT(accreditation_id)
      comment: "Total number of accreditations held"
    - name: "active_accreditation_count"
      expr: COUNT(DISTINCT CASE WHEN accreditation_status = 'Active' THEN accreditation_id END)
      comment: "Number of currently active accreditations"
    - name: "mrc_accredited_count"
      expr: COUNT(DISTINCT CASE WHEN mrc_accredited = TRUE THEN accreditation_id END)
      comment: "Number of MRC accreditations"
    - name: "iab_gold_standard_count"
      expr: COUNT(DISTINCT CASE WHEN iab_gold_standard = TRUE THEN accreditation_id END)
      comment: "Number of IAB Gold Standard certifications"
    - name: "brand_safety_certified_count"
      expr: COUNT(DISTINCT CASE WHEN brand_safety_certified = TRUE THEN accreditation_id END)
      comment: "Number of brand safety certifications"
    - name: "anti_fraud_certified_count"
      expr: COUNT(DISTINCT CASE WHEN anti_fraud_certified = TRUE THEN accreditation_id END)
      comment: "Number of anti-fraud certifications"
    - name: "gdpr_compliant_count"
      expr: COUNT(DISTINCT CASE WHEN gdpr_compliant = TRUE THEN accreditation_id END)
      comment: "Number of GDPR compliant certifications"
    - name: "ccpa_compliant_count"
      expr: COUNT(DISTINCT CASE WHEN ccpa_compliant = TRUE THEN accreditation_id END)
      comment: "Number of CCPA compliant certifications"
    - name: "total_accreditation_fees"
      expr: SUM(CAST(fee_usd AS DOUBLE))
      comment: "Total fees paid for accreditations in USD"
    - name: "avg_accreditation_fee"
      expr: AVG(CAST(fee_usd AS DOUBLE))
      comment: "Average fee per accreditation in USD"
    - name: "expiring_soon_count"
      expr: COUNT(DISTINCT CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN accreditation_id END)
      comment: "Number of accreditations expiring within 90 days"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`vendor_supply_chain_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain transparency and quality metrics tracking ads.txt verification, viewability, invalid traffic, and supply path optimization"
  source: "`advertising_ecm`.`vendor`.`supply_chain_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the supply chain profile"
    - name: "preferred_vendor_status"
      expr: preferred_vendor_status
      comment: "Preferred vendor status classification"
    - name: "brand_safety_tier"
      expr: brand_safety_tier
      comment: "Brand safety tier classification"
    - name: "supply_path_optimization_tier"
      expr: supply_path_optimization_tier
      comment: "Supply path optimization tier"
    - name: "content_adjacency_risk_rating"
      expr: content_adjacency_risk_rating
      comment: "Risk rating for content adjacency concerns"
    - name: "data_residency_region"
      expr: data_residency_region
      comment: "Region where data is stored and processed"
    - name: "ads_txt_authorized"
      expr: ads_txt_authorized
      comment: "Whether the vendor is authorized via ads.txt"
    - name: "sellers_json_verified"
      expr: sellers_json_verified
      comment: "Whether sellers.json verification is complete"
    - name: "mrc_accredited"
      expr: mrc_accredited
      comment: "Whether the vendor is MRC accredited"
    - name: "tag_certified_against_fraud"
      expr: tag_certified_against_fraud
      comment: "Whether TAG certification for fraud prevention is held"
    - name: "gdpr_compliant"
      expr: gdpr_compliant
      comment: "Whether GDPR compliance is verified"
    - name: "ccpa_compliant"
      expr: ccpa_compliant
      comment: "Whether CCPA compliance is verified"
    - name: "viewability_standard_met"
      expr: viewability_standard_met
      comment: "Whether viewability standards are met"
    - name: "supply_chain_documentation_complete"
      expr: supply_chain_documentation_complete
      comment: "Whether supply chain documentation is complete"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year when the profile was assessed"
  measures:
    - name: "profile_count"
      expr: COUNT(supply_chain_profile_id)
      comment: "Total number of supply chain profiles"
    - name: "avg_supply_chain_transparency_score"
      expr: AVG(CAST(supply_chain_transparency_score AS DOUBLE))
      comment: "Average supply chain transparency score"
    - name: "avg_brand_safety_verification_score"
      expr: AVG(CAST(brand_safety_verification_score AS DOUBLE))
      comment: "Average brand safety verification score"
    - name: "avg_viewability_rate"
      expr: AVG(CAST(average_viewability_rate AS DOUBLE))
      comment: "Average viewability rate across supply chain"
    - name: "avg_invalid_traffic_rate"
      expr: AVG(CAST(invalid_traffic_rate AS DOUBLE))
      comment: "Average invalid traffic rate detected"
    - name: "ads_txt_authorized_count"
      expr: COUNT(DISTINCT CASE WHEN ads_txt_authorized = TRUE THEN supply_chain_profile_id END)
      comment: "Number of vendors authorized via ads.txt"
    - name: "sellers_json_verified_count"
      expr: COUNT(DISTINCT CASE WHEN sellers_json_verified = TRUE THEN supply_chain_profile_id END)
      comment: "Number of vendors with verified sellers.json"
    - name: "mrc_accredited_count"
      expr: COUNT(DISTINCT CASE WHEN mrc_accredited = TRUE THEN supply_chain_profile_id END)
      comment: "Number of MRC accredited vendors in supply chain"
    - name: "tag_certified_count"
      expr: COUNT(DISTINCT CASE WHEN tag_certified_against_fraud = TRUE THEN supply_chain_profile_id END)
      comment: "Number of TAG certified vendors"
    - name: "viewability_standard_met_count"
      expr: COUNT(DISTINCT CASE WHEN viewability_standard_met = TRUE THEN supply_chain_profile_id END)
      comment: "Number of vendors meeting viewability standards"
    - name: "documentation_complete_count"
      expr: COUNT(DISTINCT CASE WHEN supply_chain_documentation_complete = TRUE THEN supply_chain_profile_id END)
      comment: "Number of vendors with complete supply chain documentation"
$$;