-- Metric views for domain: vendor | Business: Advertising | Version: 1 | Generated on: 2026-05-08 03:48:00

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`vendor_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the supplier master — tracks supplier portfolio composition, compliance posture, programmatic readiness, and diversity certification coverage to guide vendor selection and risk management decisions."
  source: "`advertising_ecm`.`vendor`.`supplier`"
  dimensions:
    - name: "vendor_type"
      expr: vendor_type
      comment: "Classifies the supplier by vendor type (e.g. publisher, DSP, measurement partner) for portfolio segmentation."
    - name: "media_channel"
      expr: media_channel
      comment: "The primary media channel the supplier operates in (e.g. digital, OOH, broadcast) for channel-level analysis."
    - name: "platform_type"
      expr: platform_type
      comment: "Technology platform type (e.g. SSP, DSP, ad server) enabling platform-mix analysis."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current onboarding lifecycle status of the supplier, used to track pipeline health."
    - name: "brand_safety_tier"
      expr: brand_safety_tier
      comment: "Brand safety classification tier assigned to the supplier, critical for risk-based vendor segmentation."
    - name: "country_code"
      expr: country_code
      comment: "Country of the supplier, enabling geographic distribution analysis of the vendor portfolio."
    - name: "mrc_accredited"
      expr: mrc_accredited
      comment: "Indicates whether the supplier holds MRC accreditation, a key quality and trust signal."
    - name: "diversity_certified"
      expr: diversity_certified
      comment: "Indicates whether the supplier holds a diversity certification, supporting DEI spend reporting."
    - name: "spo_enabled"
      expr: spo_enabled
      comment: "Indicates whether the supplier is enabled for Supply Path Optimization, relevant for programmatic efficiency."
    - name: "programmatic_supply_role"
      expr: programmatic_supply_role
      comment: "Role of the supplier in the programmatic supply chain (e.g. direct, reseller)."
    - name: "tag_certified_against_fraud"
      expr: tag_certified_against_fraud
      comment: "Indicates TAG fraud certification status, a key anti-fraud compliance signal."
    - name: "onboarding_year"
      expr: DATE_TRUNC('YEAR', onboarding_date)
      comment: "Year the supplier was onboarded, enabling cohort and growth trend analysis."
  measures:
    - name: "total_active_suppliers"
      expr: COUNT(CASE WHEN onboarding_status = 'active' THEN supplier_id END)
      comment: "Count of suppliers currently in active status — baseline measure of the live vendor pool available for media buying."
    - name: "total_suppliers"
      expr: COUNT(1)
      comment: "Total number of supplier records across all statuses — used as the denominator for compliance and certification rate calculations."
    - name: "mrc_accredited_supplier_count"
      expr: COUNT(CASE WHEN mrc_accredited = TRUE THEN supplier_id END)
      comment: "Number of suppliers holding MRC accreditation — a key quality gate metric for media investment governance."
    - name: "tag_certified_supplier_count"
      expr: COUNT(CASE WHEN tag_certified_against_fraud = TRUE THEN supplier_id END)
      comment: "Number of suppliers with TAG fraud certification — directly informs anti-fraud risk exposure of the vendor portfolio."
    - name: "diversity_certified_supplier_count"
      expr: COUNT(CASE WHEN diversity_certified = TRUE THEN supplier_id END)
      comment: "Number of diversity-certified suppliers — supports DEI spend commitment tracking and ESG reporting."
    - name: "spo_enabled_supplier_count"
      expr: COUNT(CASE WHEN spo_enabled = TRUE THEN supplier_id END)
      comment: "Number of suppliers enabled for Supply Path Optimization — measures programmatic supply chain efficiency coverage."
    - name: "ads_txt_verified_supplier_count"
      expr: COUNT(CASE WHEN ads_txt_verified = TRUE THEN supplier_id END)
      comment: "Number of suppliers with ads.txt verification — a critical inventory authenticity and fraud prevention signal."
    - name: "total_audience_reach"
      expr: SUM(CAST(audience_reach AS BIGINT))
      comment: "Aggregate audience reach across all suppliers — indicates the total addressable audience the vendor portfolio can deliver."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPIs for vendor invoicing — tracks billed amounts, payment performance, discrepancy exposure, and reconciliation health to govern media spend payables and cash flow."
  source: "`advertising_ecm`.`vendor`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g. pending, approved, disputed, paid) for payables pipeline analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g. media, production, tech fee) enabling spend category breakdown."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice is denominated, required for multi-currency financial reporting."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms (e.g. Net 30, Net 60) for cash flow and working capital analysis."
    - name: "invalid_traffic_flag"
      expr: invalid_traffic_flag
      comment: "Flags invoices containing invalid traffic, enabling IVT-related financial exposure quantification."
    - name: "brand_safety_compliant"
      expr: brand_safety_compliant
      comment: "Indicates whether the invoice relates to brand-safe inventory, supporting compliance-based payment decisions."
    - name: "discrepancy_reason_code"
      expr: discrepancy_reason_code
      comment: "Reason code for billing discrepancies, enabling root-cause analysis of invoice disputes."
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start)
      comment: "Month of the billing period start date, enabling monthly spend trend analysis."
    - name: "issue_year"
      expr: DATE_TRUNC('YEAR', issue_date)
      comment: "Year the invoice was issued, supporting annual financial reporting and trend analysis."
  measures:
    - name: "total_gross_billed_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross billed amount across all invoices — the top-line vendor payables figure used in budget reconciliation."
    - name: "total_net_billed_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net billed amount after agency discounts — the actual payable liability to vendors."
    - name: "total_approved_billing_amount"
      expr: SUM(CAST(approved_billing_amount AS DOUBLE))
      comment: "Total amount approved for payment — the confirmed payables figure used in cash flow forecasting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged across invoices — required for tax liability reporting and financial close."
    - name: "total_agency_discount_amount"
      expr: SUM(CAST(agency_discount_amount AS DOUBLE))
      comment: "Total agency discount applied — measures the value of negotiated discounts captured from vendors."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total billing variance (invoiced vs. delivered) — a key financial risk indicator for over/under-billing exposure."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average billing variance percentage across invoices — indicates systemic discrepancy levels that may signal vendor billing quality issues."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_raised_date IS NOT NULL THEN invoice_id END)
      comment: "Number of invoices with a dispute raised — a direct measure of vendor billing quality and financial risk."
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total invoice count — baseline volume measure used as denominator for dispute rate and other ratio KPIs."
    - name: "invalid_traffic_invoice_count"
      expr: COUNT(CASE WHEN invalid_traffic_flag = TRUE THEN invoice_id END)
      comment: "Number of invoices flagged for invalid traffic — quantifies IVT-related financial exposure requiring credit or clawback."
    - name: "total_io_authorized_amount"
      expr: SUM(CAST(io_authorized_amount AS DOUBLE))
      comment: "Total IO-authorized spend amount — the contractually committed budget ceiling against which invoices are validated."
    - name: "total_delivered_spend_amount"
      expr: SUM(CAST(delivered_spend_amount AS DOUBLE))
      comment: "Total delivered spend as reported by the vendor — used to compare against IO authorization and identify over-delivery."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`vendor_io_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Execution KPIs for IO line items — tracks contracted vs. actual delivery, spend pacing, viewability commitments, and agency commission to govern campaign execution and vendor accountability."
  source: "`advertising_ecm`.`vendor`.`io_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the IO line (e.g. active, completed, cancelled) for execution pipeline monitoring."
    - name: "buying_type"
      expr: buying_type
      comment: "Buying type (e.g. programmatic, direct, guaranteed) enabling spend analysis by procurement method."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method (e.g. standard, accelerated) for pacing and delivery performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the IO line for multi-currency financial reporting."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the IO line — identifies lines pending financial close."
    - name: "makegood_flag"
      expr: makegood_flag
      comment: "Indicates whether the line is a makegood (compensatory placement) — tracks vendor obligation fulfillment."
    - name: "added_value_flag"
      expr: added_value_flag
      comment: "Indicates whether the line represents added value (bonus inventory) — measures value captured beyond contracted commitments."
    - name: "flight_start_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month the IO line flight begins, enabling monthly pacing and spend trend analysis."
    - name: "geo_targeting"
      expr: geo_targeting
      comment: "Geographic targeting applied to the IO line for regional spend analysis."
  measures:
    - name: "total_contracted_spend"
      expr: SUM(CAST(contracted_spend AS DOUBLE))
      comment: "Total contracted spend across IO lines — the committed budget baseline for vendor accountability and budget governance."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend delivered against IO lines — the realized cost used for budget reconciliation and pacing analysis."
    - name: "total_contracted_units"
      expr: SUM(CAST(contracted_units AS DOUBLE))
      comment: "Total contracted delivery units (impressions, clicks, etc.) — the volume commitment baseline for delivery performance tracking."
    - name: "total_actual_units_delivered"
      expr: SUM(CAST(actual_units_delivered AS DOUBLE))
      comment: "Total actual units delivered — measures vendor fulfillment against contracted volume commitments."
    - name: "total_grp_contracted"
      expr: SUM(CAST(grp_contracted AS DOUBLE))
      comment: "Total contracted GRP (Gross Rating Points) — the audience delivery commitment for broadcast and video campaigns."
    - name: "total_trp_contracted"
      expr: SUM(CAST(trp_contracted AS DOUBLE))
      comment: "Total contracted TRP (Target Rating Points) — the targeted audience delivery commitment for demographic-focused campaigns."
    - name: "avg_viewability_target_pct"
      expr: AVG(CAST(viewability_target_pct AS DOUBLE))
      comment: "Average viewability target percentage across IO lines — indicates the quality standard committed to in vendor contracts."
    - name: "avg_net_rate"
      expr: AVG(CAST(net_rate AS DOUBLE))
      comment: "Average net rate across IO lines — a pricing efficiency indicator used to benchmark vendor rate competitiveness."
    - name: "avg_agency_commission_pct"
      expr: AVG(CAST(agency_commission_pct AS DOUBLE))
      comment: "Average agency commission percentage across IO lines — monitors commission cost as a proportion of media investment."
    - name: "makegood_line_count"
      expr: COUNT(CASE WHEN makegood_flag = TRUE THEN io_line_id END)
      comment: "Number of makegood IO lines — quantifies vendor under-delivery remediation obligations outstanding."
    - name: "total_io_lines"
      expr: COUNT(1)
      comment: "Total IO line count — baseline volume measure for execution pipeline monitoring."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`vendor_performance_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor scorecard KPIs — tracks delivery fulfillment, invoice accuracy, viewability, IVT rates, and SLA adherence to drive vendor tier decisions, contract renewals, and strategic partnership management."
  source: "`advertising_ecm`.`vendor`.`performance_evaluation`"
  dimensions:
    - name: "vendor_category"
      expr: vendor_category
      comment: "Category of the vendor being evaluated (e.g. publisher, DSP, measurement) for segment-level performance benchmarking."
    - name: "evaluation_cycle"
      expr: evaluation_cycle
      comment: "Evaluation cycle (e.g. quarterly, annual) enabling period-over-period performance trend analysis."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the evaluation (e.g. draft, approved, final) for governance workflow tracking."
    - name: "preferred_vendor_tier"
      expr: preferred_vendor_tier
      comment: "Current preferred vendor tier assigned — the primary output of the scorecard used for investment allocation decisions."
    - name: "prior_preferred_vendor_tier"
      expr: prior_preferred_vendor_tier
      comment: "Prior preferred vendor tier — enables tier movement analysis to identify improving or declining vendors."
    - name: "contract_renewal_recommendation"
      expr: contract_renewal_recommendation
      comment: "Renewal recommendation outcome (e.g. renew, renegotiate, terminate) — the key decision output of the evaluation process."
    - name: "mrc_accreditation_status"
      expr: mrc_accreditation_status
      comment: "MRC accreditation status at time of evaluation — a quality gate dimension for premium vendor classification."
    - name: "vendor_dispute_flag"
      expr: vendor_dispute_flag
      comment: "Indicates whether the vendor has an active dispute — flags vendors requiring financial or contractual intervention."
    - name: "evaluation_year"
      expr: evaluation_year
      comment: "Year of the evaluation cycle for annual performance trend reporting."
    - name: "evaluation_period_start_month"
      expr: DATE_TRUNC('MONTH', evaluation_period_start_date)
      comment: "Month the evaluation period begins, enabling rolling performance window analysis."
  measures:
    - name: "avg_overall_scorecard_rating"
      expr: AVG(CAST(overall_scorecard_rating AS DOUBLE))
      comment: "Average overall vendor scorecard rating — the primary KPI for vendor performance benchmarking and tier assignment decisions."
    - name: "avg_delivery_fulfillment_rate"
      expr: AVG(CAST(delivery_fulfillment_rate AS DOUBLE))
      comment: "Average delivery fulfillment rate across evaluations — measures vendor reliability in meeting contracted impression/unit commitments."
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate — quantifies billing quality; low rates signal systemic invoicing issues requiring remediation."
    - name: "avg_viewability_rate"
      expr: AVG(CAST(viewability_rate AS DOUBLE))
      comment: "Average viewability rate across vendor evaluations — a core media quality KPI tied directly to advertising effectiveness."
    - name: "avg_invalid_traffic_rate"
      expr: AVG(CAST(invalid_traffic_rate AS DOUBLE))
      comment: "Average invalid traffic rate — a critical fraud risk KPI; elevated rates trigger vendor remediation or termination decisions."
    - name: "avg_sla_adherence_rate"
      expr: AVG(CAST(response_time_sla_adherence_rate AS DOUBLE))
      comment: "Average SLA response time adherence rate — measures vendor operational responsiveness against contractual service commitments."
    - name: "total_io_committed_units"
      expr: SUM(CAST(io_committed_units AS BIGINT))
      comment: "Total IO-committed units across evaluations — the aggregate delivery obligation baseline for fulfillment rate context."
    - name: "total_actual_delivered_units"
      expr: SUM(CAST(actual_delivered_units AS BIGINT))
      comment: "Total actual units delivered across evaluations — the realized delivery volume used to assess fulfillment against commitments."
    - name: "vendor_dispute_count"
      expr: COUNT(CASE WHEN vendor_dispute_flag = TRUE THEN performance_evaluation_id END)
      comment: "Number of evaluations with an active vendor dispute — a risk signal for contract and financial management escalation."
    - name: "total_evaluations"
      expr: COUNT(1)
      comment: "Total number of vendor performance evaluations — baseline volume measure for coverage and governance completeness tracking."
    - name: "avg_prior_scorecard_rating"
      expr: AVG(CAST(prior_scorecard_rating AS DOUBLE))
      comment: "Average prior scorecard rating — used alongside current rating to compute period-over-period vendor performance movement."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`vendor_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial reconciliation KPIs — tracks billing variances, credit notes, tolerance breaches, and resolution status to govern the accuracy of vendor payments and identify systemic discrepancy patterns."
  source: "`advertising_ecm`.`vendor`.`reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current status of the reconciliation (e.g. pending, approved, disputed) for payables pipeline monitoring."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation (e.g. monthly, campaign-end) enabling process-level analysis."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the reconciliation — identifies unresolved items requiring financial intervention."
    - name: "discrepancy_reason_code"
      expr: discrepancy_reason_code
      comment: "Reason code for the billing discrepancy — enables root-cause analysis and vendor accountability tracking."
    - name: "within_tolerance_flag"
      expr: within_tolerance_flag
      comment: "Indicates whether the variance falls within the agreed tolerance threshold — the primary pass/fail gate for automated payment approval."
    - name: "makegood_flag"
      expr: makegood_flag
      comment: "Indicates whether the reconciliation relates to a makegood placement — tracks vendor remediation fulfillment."
    - name: "buying_method"
      expr: buying_method
      comment: "Buying method (e.g. programmatic, direct) enabling discrepancy pattern analysis by procurement channel."
    - name: "channel_type"
      expr: channel_type
      comment: "Media channel type for the reconciliation — enables channel-level variance and discrepancy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the reconciliation for multi-currency financial reporting."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month of the reconciliation period start — enables monthly trend analysis of billing variances."
  measures:
    - name: "total_vendor_invoiced_amount"
      expr: SUM(CAST(vendor_invoiced_amount AS DOUBLE))
      comment: "Total amount invoiced by vendors — the gross payables figure before reconciliation adjustments."
    - name: "total_adserver_delivered_amount"
      expr: SUM(CAST(adserver_delivered_amount AS DOUBLE))
      comment: "Total delivery amount as measured by the ad server — the agency-side benchmark for validating vendor invoices."
    - name: "total_approved_billing_amount"
      expr: SUM(CAST(approved_billing_amount AS DOUBLE))
      comment: "Total approved billing amount post-reconciliation — the confirmed payables figure used for vendor payment processing."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total billing variance amount (vendor invoiced vs. ad server delivered) — the aggregate financial exposure from discrepancies."
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average variance percentage across reconciliations — a systemic billing quality indicator; high averages signal vendor invoicing issues."
    - name: "total_credit_note_amount"
      expr: SUM(CAST(credit_note_amount AS DOUBLE))
      comment: "Total credit note value issued — measures the financial recovery from disputed or over-billed vendor invoices."
    - name: "out_of_tolerance_reconciliation_count"
      expr: COUNT(CASE WHEN within_tolerance_flag = FALSE THEN reconciliation_id END)
      comment: "Number of reconciliations exceeding the agreed variance tolerance — the primary escalation trigger for manual review and dispute resolution."
    - name: "total_reconciliations"
      expr: COUNT(1)
      comment: "Total reconciliation record count — baseline volume measure for process coverage and throughput monitoring."
    - name: "total_io_authorized_amount"
      expr: SUM(CAST(io_authorized_amount AS DOUBLE))
      comment: "Total IO-authorized amount across reconciliations — the contractual budget ceiling used to validate vendor billing."
    - name: "avg_tolerance_threshold_pct"
      expr: AVG(CAST(tolerance_threshold_pct AS DOUBLE))
      comment: "Average tolerance threshold percentage applied across reconciliations — monitors whether tolerance policies are consistently applied."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`vendor_accreditation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor accreditation compliance KPIs — tracks certification coverage, expiry risk, audit cycle health, and regulatory compliance posture (GDPR, CCPA, brand safety, anti-fraud) to govern vendor quality standards."
  source: "`advertising_ecm`.`vendor`.`accreditation`"
  dimensions:
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Current status of the accreditation (e.g. active, expired, suspended) for compliance portfolio monitoring."
    - name: "accreditation_tier"
      expr: accreditation_tier
      comment: "Tier level of the accreditation — enables quality-tier segmentation of the vendor compliance portfolio."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g. MRC, TAG, IAB) for compliance coverage analysis by certification body."
    - name: "certifying_body"
      expr: certifying_body
      comment: "Organization that issued the certification — enables analysis of compliance coverage by governing body."
    - name: "channel_scope"
      expr: channel_scope
      comment: "Media channel scope of the accreditation (e.g. display, video, mobile) for channel-level compliance analysis."
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope of the accreditation — identifies regional compliance gaps in the vendor portfolio."
    - name: "mrc_accredited"
      expr: mrc_accredited
      comment: "Indicates MRC accreditation status — the gold standard for media measurement quality."
    - name: "gdpr_compliant"
      expr: gdpr_compliant
      comment: "Indicates GDPR compliance status — a mandatory regulatory requirement for EU media operations."
    - name: "ccpa_compliant"
      expr: ccpa_compliant
      comment: "Indicates CCPA compliance status — a mandatory regulatory requirement for California consumer data operations."
    - name: "brand_safety_certified"
      expr: brand_safety_certified
      comment: "Indicates brand safety certification — a key quality gate for premium advertiser vendor approval."
    - name: "anti_fraud_certified"
      expr: anti_fraud_certified
      comment: "Indicates anti-fraud certification — a critical risk management signal for vendor approval decisions."
    - name: "iab_gold_standard"
      expr: iab_gold_standard
      comment: "Indicates IAB Gold Standard compliance — the industry benchmark for responsible digital advertising."
    - name: "expiry_year"
      expr: DATE_TRUNC('YEAR', expiry_date)
      comment: "Year the accreditation expires — enables forward-looking renewal risk planning."
    - name: "audit_cycle"
      expr: audit_cycle
      comment: "Audit cycle frequency (e.g. annual, biennial) for audit schedule governance."
  measures:
    - name: "total_active_accreditations"
      expr: COUNT(CASE WHEN accreditation_status = 'active' THEN accreditation_id END)
      comment: "Number of currently active accreditations — the baseline compliance coverage measure for the vendor portfolio."
    - name: "total_accreditations"
      expr: COUNT(1)
      comment: "Total accreditation records — baseline volume measure used as denominator for compliance rate calculations."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN accreditation_id END)
      comment: "Number of accreditations expiring within 90 days — a forward-looking risk signal triggering renewal action to avoid compliance gaps."
    - name: "suspended_accreditation_count"
      expr: COUNT(CASE WHEN accreditation_status = 'suspended' THEN accreditation_id END)
      comment: "Number of suspended accreditations — identifies vendors with active compliance failures requiring immediate remediation."
    - name: "gdpr_compliant_count"
      expr: COUNT(CASE WHEN gdpr_compliant = TRUE THEN accreditation_id END)
      comment: "Number of accreditations with GDPR compliance — measures regulatory coverage for EU data privacy obligations."
    - name: "ccpa_compliant_count"
      expr: COUNT(CASE WHEN ccpa_compliant = TRUE THEN accreditation_id END)
      comment: "Number of accreditations with CCPA compliance — measures regulatory coverage for US state privacy law obligations."
    - name: "brand_safety_certified_count"
      expr: COUNT(CASE WHEN brand_safety_certified = TRUE THEN accreditation_id END)
      comment: "Number of brand-safety-certified accreditations — quantifies the vendor portfolio's brand protection coverage."
    - name: "anti_fraud_certified_count"
      expr: COUNT(CASE WHEN anti_fraud_certified = TRUE THEN accreditation_id END)
      comment: "Number of anti-fraud-certified accreditations — measures the portfolio's fraud risk mitigation coverage."
    - name: "total_accreditation_fee_usd"
      expr: SUM(CAST(fee_usd AS DOUBLE))
      comment: "Total cost of accreditations in USD — tracks the financial investment in vendor compliance and certification programs."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`vendor_rate_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate card KPIs — tracks pricing levels, discount capture, viewability guarantees, and minimum spend commitments across vendor rate cards to govern media buying efficiency and rate negotiation outcomes."
  source: "`advertising_ecm`.`vendor`.`vendor_rate_card`"
  dimensions:
    - name: "rate_card_status"
      expr: rate_card_status
      comment: "Current status of the rate card (e.g. active, expired, draft) for rate card portfolio governance."
    - name: "rate_card_type"
      expr: rate_card_type
      comment: "Type of rate card (e.g. standard, negotiated, programmatic) enabling pricing strategy analysis."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model (e.g. CPM, CPC, CPV) for buying model mix analysis and cost efficiency benchmarking."
    - name: "channel_category"
      expr: channel_category
      comment: "Media channel category for the rate card — enables channel-level pricing analysis."
    - name: "inventory_type"
      expr: inventory_type
      comment: "Inventory type (e.g. premium, remnant, programmatic guaranteed) for inventory quality and pricing tier analysis."
    - name: "brand_safety_tier"
      expr: brand_safety_tier
      comment: "Brand safety tier associated with the rate card — enables pricing analysis by safety classification."
    - name: "geo_market"
      expr: geo_market
      comment: "Geographic market for the rate card — enables regional pricing benchmarking and market-level rate analysis."
    - name: "is_negotiated_rate"
      expr: is_negotiated_rate
      comment: "Indicates whether the rate is negotiated vs. published — enables analysis of negotiated discount capture."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rate card for multi-currency pricing analysis."
    - name: "effective_start_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the rate card becomes effective — enables year-over-year pricing trend analysis."
    - name: "ad_format"
      expr: ad_format
      comment: "Ad format associated with the rate card (e.g. display, video, native) for format-level pricing analysis."
  measures:
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base rate across rate cards — the primary pricing benchmark for vendor rate competitiveness analysis."
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate_pct AS DOUBLE))
      comment: "Average discount rate percentage — measures the depth of pricing concessions negotiated from vendors."
    - name: "avg_agency_commission_pct"
      expr: AVG(CAST(agency_commission_pct AS DOUBLE))
      comment: "Average agency commission percentage across rate cards — monitors commission cost as a proportion of media investment."
    - name: "avg_guaranteed_viewability_pct"
      expr: AVG(CAST(guaranteed_viewability_pct AS DOUBLE))
      comment: "Average guaranteed viewability percentage — measures the quality commitment level embedded in vendor rate cards."
    - name: "total_minimum_spend"
      expr: SUM(CAST(minimum_spend AS DOUBLE))
      comment: "Total minimum spend commitments across rate cards — quantifies the aggregate contractual spend floor with vendors."
    - name: "negotiated_rate_card_count"
      expr: COUNT(CASE WHEN is_negotiated_rate = TRUE THEN vendor_rate_card_id END)
      comment: "Number of negotiated rate cards — measures the proportion of the rate portfolio secured through active negotiation vs. published rates."
    - name: "total_active_rate_cards"
      expr: COUNT(CASE WHEN rate_card_status = 'active' THEN vendor_rate_card_id END)
      comment: "Number of currently active rate cards — the live pricing inventory available for media planning and buying."
    - name: "total_rate_cards"
      expr: COUNT(1)
      comment: "Total rate card count — baseline volume measure for rate portfolio coverage analysis."
$$;