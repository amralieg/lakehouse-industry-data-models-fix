-- Metric views for domain: contract | Business: Advertising | Version: 1 | Generated on: 2026-05-08 02:24:04

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`contract_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core contract agreement metrics tracking committed value, active agreements, and contract lifecycle performance"
  source: "`advertising_ecm`.`contract`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement (e.g., draft, active, expired, terminated)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of agreement (e.g., master service agreement, insertion order, SOW)"
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model used in the agreement (e.g., fixed fee, time and materials, performance-based)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for agreement financial values"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the agreement has auto-renewal enabled"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the agreement became effective"
    - name: "effective_quarter"
      expr: CONCAT('Q', QUARTER(effective_date), '-', YEAR(effective_date))
      comment: "Quarter and year the agreement became effective"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the agreement expires"
    - name: "governing_law"
      expr: governing_law
      comment: "Jurisdiction governing the agreement"
    - name: "counterparty_type"
      expr: counterparty_type
      comment: "Type of counterparty (e.g., client, vendor, partner)"
  measures:
    - name: "total_committed_value"
      expr: SUM(CAST(total_committed_value AS DOUBLE))
      comment: "Total committed contract value across all agreements"
    - name: "avg_committed_value"
      expr: AVG(CAST(total_committed_value AS DOUBLE))
      comment: "Average committed value per agreement"
    - name: "agreement_count"
      expr: COUNT(DISTINCT agreement_id)
      comment: "Number of unique agreements"
    - name: "active_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN agreement_status = 'active' THEN agreement_id END)
      comment: "Number of agreements currently in active status"
    - name: "auto_renewal_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN auto_renewal_flag = TRUE THEN agreement_id END)
      comment: "Number of agreements with auto-renewal enabled"
    - name: "avg_liability_cap"
      expr: AVG(CAST(liability_cap_amount AS DOUBLE))
      comment: "Average liability cap amount across agreements"
    - name: "agreements_with_sla_count"
      expr: COUNT(DISTINCT CASE WHEN sla_included_flag = TRUE THEN agreement_id END)
      comment: "Number of agreements that include service level agreements"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`contract_sow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statement of Work metrics tracking project scope, budget allocation, and SOW performance"
  source: "`advertising_ecm`.`contract`.`sow`"
  dimensions:
    - name: "sow_status"
      expr: sow_status
      comment: "Current status of the statement of work"
    - name: "sow_type"
      expr: sow_type
      comment: "Type of statement of work"
    - name: "billing_model"
      expr: billing_model
      comment: "Billing model for the SOW (e.g., fixed price, time and materials)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for SOW financial values"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the SOW became effective"
    - name: "effective_quarter"
      expr: CONCAT('Q', QUARTER(effective_start_date), '-', YEAR(effective_start_date))
      comment: "Quarter and year the SOW became effective"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the SOW has auto-renewal enabled"
    - name: "intellectual_property_ownership"
      expr: intellectual_property_ownership
      comment: "Intellectual property ownership terms"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contract value across all SOWs"
    - name: "total_media_budget"
      expr: SUM(CAST(media_budget_amount AS DOUBLE))
      comment: "Total media budget allocated across SOWs"
    - name: "total_production_budget"
      expr: SUM(CAST(production_budget_amount AS DOUBLE))
      comment: "Total production budget allocated across SOWs"
    - name: "total_agency_fees"
      expr: SUM(CAST(agency_fee_amount AS DOUBLE))
      comment: "Total agency fees across all SOWs"
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value per SOW"
    - name: "sow_count"
      expr: COUNT(DISTINCT sow_id)
      comment: "Number of unique statements of work"
    - name: "active_sow_count"
      expr: COUNT(DISTINCT CASE WHEN sow_status = 'active' THEN sow_id END)
      comment: "Number of SOWs currently in active status"
    - name: "total_performance_bonus"
      expr: SUM(CAST(performance_bonus_amount AS DOUBLE))
      comment: "Total performance bonus amounts across SOWs"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`contract_insertion_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media insertion order metrics tracking authorized spend, media commitments, and campaign execution"
  source: "`advertising_ecm`.`contract`.`contract_insertion_order`"
  dimensions:
    - name: "io_status"
      expr: io_status
      comment: "Current status of the insertion order"
    - name: "io_type"
      expr: io_type
      comment: "Type of insertion order"
    - name: "media_channel"
      expr: media_channel
      comment: "Media channel for the insertion order (e.g., digital, TV, print)"
    - name: "buying_method"
      expr: buying_method
      comment: "Method used for media buying (e.g., programmatic, direct)"
    - name: "rate_type"
      expr: rate_type
      comment: "Type of rate structure (e.g., CPM, CPC, flat fee)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for insertion order financial values"
    - name: "flight_year"
      expr: YEAR(flight_start_date)
      comment: "Year the media flight starts"
    - name: "flight_quarter"
      expr: CONCAT('Q', QUARTER(flight_start_date), '-', YEAR(flight_start_date))
      comment: "Quarter and year the media flight starts"
  measures:
    - name: "total_authorized_spend"
      expr: SUM(CAST(total_authorized_spend AS DOUBLE))
      comment: "Total authorized media spend across all insertion orders"
    - name: "avg_authorized_spend"
      expr: AVG(CAST(total_authorized_spend AS DOUBLE))
      comment: "Average authorized spend per insertion order"
    - name: "insertion_order_count"
      expr: COUNT(DISTINCT contract_insertion_order_id)
      comment: "Number of unique insertion orders"
    - name: "active_io_count"
      expr: COUNT(DISTINCT CASE WHEN io_status = 'active' THEN contract_insertion_order_id END)
      comment: "Number of insertion orders currently active"
    - name: "total_committed_impressions"
      expr: SUM(CAST(committed_impressions AS DOUBLE))
      comment: "Total committed impressions across all insertion orders"
    - name: "total_committed_clicks"
      expr: SUM(CAST(committed_clicks AS DOUBLE))
      comment: "Total committed clicks across all insertion orders"
    - name: "total_committed_conversions"
      expr: SUM(CAST(committed_conversions AS DOUBLE))
      comment: "Total committed conversions across all insertion orders"
    - name: "avg_agency_commission_rate"
      expr: AVG(CAST(agency_commission_rate AS DOUBLE))
      comment: "Average agency commission rate across insertion orders"
    - name: "total_third_party_ad_serving_fees"
      expr: SUM(CAST(third_party_ad_serving_fee AS DOUBLE))
      comment: "Total third-party ad serving fees across insertion orders"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`contract_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract amendment metrics tracking change orders, budget adjustments, and contract modifications"
  source: "`advertising_ecm`.`contract`.`amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment"
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g., budget change, scope change, term extension)"
    - name: "change_reason"
      expr: change_reason
      comment: "Reason for the contract amendment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for amendment financial values"
    - name: "legal_review_required"
      expr: legal_review_required
      comment: "Indicates whether legal review is required for the amendment"
    - name: "legal_review_completed"
      expr: legal_review_completed
      comment: "Indicates whether legal review has been completed"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the amendment becomes effective"
    - name: "effective_quarter"
      expr: CONCAT('Q', QUARTER(effective_date), '-', YEAR(effective_date))
      comment: "Quarter and year the amendment becomes effective"
  measures:
    - name: "amendment_count"
      expr: COUNT(DISTINCT amendment_id)
      comment: "Number of unique contract amendments"
    - name: "approved_amendment_count"
      expr: COUNT(DISTINCT CASE WHEN amendment_status = 'approved' THEN amendment_id END)
      comment: "Number of approved amendments"
    - name: "total_budget_delta"
      expr: SUM(CAST(budget_delta_amount AS DOUBLE))
      comment: "Total budget change amount across all amendments (positive or negative)"
    - name: "avg_budget_delta"
      expr: AVG(CAST(budget_delta_amount AS DOUBLE))
      comment: "Average budget change per amendment"
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Total original budget amounts before amendments"
    - name: "total_revised_budget"
      expr: SUM(CAST(revised_budget_amount AS DOUBLE))
      comment: "Total revised budget amounts after amendments"
    - name: "total_value_change"
      expr: SUM((CAST(revised_value AS DOUBLE)) - (CAST(original_value AS DOUBLE)))
      comment: "Total net value change from amendments (revised minus original)"
    - name: "amendments_requiring_legal_review_count"
      expr: COUNT(DISTINCT CASE WHEN legal_review_required = TRUE THEN amendment_id END)
      comment: "Number of amendments requiring legal review"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`contract_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract renewal metrics tracking renewal rates, value retention, and churn risk"
  source: "`advertising_ecm`.`contract`.`renewal`"
  dimensions:
    - name: "renewal_status"
      expr: renewal_status
      comment: "Current status of the renewal"
    - name: "renewal_type"
      expr: renewal_type
      comment: "Type of renewal (e.g., standard, early, extended)"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the renewal process (e.g., renewed, not renewed, pending)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for renewal financial values"
    - name: "churn_risk_flag"
      expr: churn_risk_flag
      comment: "Indicates whether the renewal is at risk of churn"
    - name: "auto_renewal_clause_flag"
      expr: auto_renewal_clause_flag
      comment: "Indicates whether the contract has an auto-renewal clause"
    - name: "pricing_model_change_flag"
      expr: pricing_model_change_flag
      comment: "Indicates whether the pricing model changed during renewal"
    - name: "scope_change_flag"
      expr: scope_change_flag
      comment: "Indicates whether the scope changed during renewal"
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year the renewal decision was made"
    - name: "decision_quarter"
      expr: CONCAT('Q', QUARTER(decision_date), '-', YEAR(decision_date))
      comment: "Quarter and year the renewal decision was made"
  measures:
    - name: "renewal_count"
      expr: COUNT(DISTINCT renewal_id)
      comment: "Number of unique renewal events"
    - name: "successful_renewal_count"
      expr: COUNT(DISTINCT CASE WHEN outcome = 'renewed' THEN renewal_id END)
      comment: "Number of renewals that were successfully completed"
    - name: "at_risk_renewal_count"
      expr: COUNT(DISTINCT CASE WHEN churn_risk_flag = TRUE THEN renewal_id END)
      comment: "Number of renewals flagged as at risk of churn"
    - name: "total_prior_term_value"
      expr: SUM(CAST(prior_term_value AS DOUBLE))
      comment: "Total contract value from prior terms before renewal"
    - name: "total_new_term_value"
      expr: SUM(CAST(new_term_value AS DOUBLE))
      comment: "Total contract value from new terms after renewal"
    - name: "total_value_change"
      expr: SUM(CAST(value_change_amount AS DOUBLE))
      comment: "Total net value change from renewals (new term minus prior term)"
    - name: "avg_value_change_percentage"
      expr: AVG(CAST(value_change_percentage AS DOUBLE))
      comment: "Average percentage change in contract value at renewal"
    - name: "avg_probability_score"
      expr: AVG(CAST(probability_score AS DOUBLE))
      comment: "Average probability score for renewal success"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`contract_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract milestone metrics tracking delivery performance, payment triggers, and project progress"
  source: "`advertising_ecm`.`contract`.`contract_milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone"
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g., deliverable, payment, approval)"
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Indicates whether the milestone is on the critical path"
    - name: "payment_trigger_flag"
      expr: payment_trigger_flag
      comment: "Indicates whether the milestone triggers a payment"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the milestone"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for milestone payment amounts"
    - name: "planned_year"
      expr: YEAR(planned_date)
      comment: "Year the milestone is planned for completion"
    - name: "planned_quarter"
      expr: CONCAT('Q', QUARTER(planned_date), '-', YEAR(planned_date))
      comment: "Quarter and year the milestone is planned for completion"
  measures:
    - name: "milestone_count"
      expr: COUNT(DISTINCT contract_milestone_id)
      comment: "Number of unique contract milestones"
    - name: "completed_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN milestone_status = 'completed' THEN contract_milestone_id END)
      comment: "Number of milestones that have been completed"
    - name: "critical_path_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN critical_path_flag = TRUE THEN contract_milestone_id END)
      comment: "Number of milestones on the critical path"
    - name: "payment_trigger_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN payment_trigger_flag = TRUE THEN contract_milestone_id END)
      comment: "Number of milestones that trigger payments"
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment amounts associated with milestones"
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per milestone"
    - name: "avg_payment_percentage"
      expr: AVG(CAST(payment_percentage AS DOUBLE))
      comment: "Average payment percentage per milestone"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`contract_vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor contract metrics tracking supplier spend, contract compliance, and vendor performance"
  source: "`advertising_ecm`.`contract`.`vendor_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the vendor contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of vendor contract"
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model for the vendor contract"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for vendor contract financial values"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the vendor contract has auto-renewal enabled"
    - name: "data_processing_addendum_flag"
      expr: data_processing_addendum_flag
      comment: "Indicates whether a data processing addendum is included"
    - name: "governing_law_jurisdiction"
      expr: governing_law_jurisdiction
      comment: "Jurisdiction governing the vendor contract"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the vendor contract became effective"
    - name: "effective_quarter"
      expr: CONCAT('Q', QUARTER(effective_start_date), '-', YEAR(effective_start_date))
      comment: "Quarter and year the vendor contract became effective"
  measures:
    - name: "total_committed_spend"
      expr: SUM(CAST(total_committed_spend AS DOUBLE))
      comment: "Total committed spend across all vendor contracts"
    - name: "avg_committed_spend"
      expr: AVG(CAST(total_committed_spend AS DOUBLE))
      comment: "Average committed spend per vendor contract"
    - name: "vendor_contract_count"
      expr: COUNT(DISTINCT vendor_contract_id)
      comment: "Number of unique vendor contracts"
    - name: "active_vendor_contract_count"
      expr: COUNT(DISTINCT CASE WHEN contract_status = 'active' THEN vendor_contract_id END)
      comment: "Number of vendor contracts currently active"
    - name: "avg_liability_cap"
      expr: AVG(CAST(liability_cap_amount AS DOUBLE))
      comment: "Average liability cap amount across vendor contracts"
    - name: "avg_sla_target_uptime"
      expr: AVG(CAST(sla_target_uptime_percent AS DOUBLE))
      comment: "Average SLA target uptime percentage across vendor contracts"
    - name: "total_volume_discount_threshold"
      expr: SUM(CAST(volume_discount_threshold AS DOUBLE))
      comment: "Total volume discount thresholds across vendor contracts"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`contract_rfp_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFP response metrics tracking win rates, proposal pipeline, and new business development"
  source: "`advertising_ecm`.`contract`.`rfp_response`"
  dimensions:
    - name: "response_status"
      expr: response_status
      comment: "Current status of the RFP response"
    - name: "rfp_type"
      expr: rfp_type
      comment: "Type of RFP (e.g., media, creative, integrated)"
    - name: "win_loss_category"
      expr: win_loss_category
      comment: "Category of win/loss outcome"
    - name: "win_loss_reason"
      expr: win_loss_reason
      comment: "Reason for win or loss"
    - name: "client_industry"
      expr: client_industry
      comment: "Industry of the prospective client"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the RFP"
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency code for RFP budget values"
    - name: "received_year"
      expr: YEAR(rfp_received_date)
      comment: "Year the RFP was received"
    - name: "received_quarter"
      expr: CONCAT('Q', QUARTER(rfp_received_date), '-', YEAR(rfp_received_date))
      comment: "Quarter and year the RFP was received"
  measures:
    - name: "rfp_response_count"
      expr: COUNT(DISTINCT rfp_response_id)
      comment: "Number of unique RFP responses"
    - name: "won_rfp_count"
      expr: COUNT(DISTINCT CASE WHEN win_loss_category = 'won' THEN rfp_response_id END)
      comment: "Number of RFPs won"
    - name: "lost_rfp_count"
      expr: COUNT(DISTINCT CASE WHEN win_loss_category = 'lost' THEN rfp_response_id END)
      comment: "Number of RFPs lost"
    - name: "total_estimated_contract_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Total estimated contract value across all RFP responses"
    - name: "avg_estimated_contract_value"
      expr: AVG(CAST(estimated_contract_value AS DOUBLE))
      comment: "Average estimated contract value per RFP response"
    - name: "avg_probability_of_win"
      expr: AVG(CAST(probability_of_win_percent AS DOUBLE))
      comment: "Average probability of win percentage across RFP responses"
    - name: "total_proposed_budget_min"
      expr: SUM(CAST(proposed_budget_min AS DOUBLE))
      comment: "Total minimum proposed budget across RFP responses"
    - name: "total_proposed_budget_max"
      expr: SUM(CAST(proposed_budget_max AS DOUBLE))
      comment: "Total maximum proposed budget across RFP responses"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`contract_compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance obligation metrics tracking regulatory adherence, audit status, and risk exposure"
  source: "`advertising_ecm`.`contract`.`compliance_obligation`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the obligation"
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of compliance obligation"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the compliance obligation"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the obligation"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body governing the obligation"
    - name: "escalation_required"
      expr: escalation_required
      comment: "Indicates whether escalation is required"
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the obligation is currently active"
    - name: "penalty_currency_code"
      expr: penalty_currency_code
      comment: "Currency code for penalty amounts"
    - name: "compliance_deadline_year"
      expr: YEAR(compliance_deadline)
      comment: "Year of the compliance deadline"
    - name: "compliance_deadline_quarter"
      expr: CONCAT('Q', QUARTER(compliance_deadline), '-', YEAR(compliance_deadline))
      comment: "Quarter and year of the compliance deadline"
  measures:
    - name: "compliance_obligation_count"
      expr: COUNT(DISTINCT compliance_obligation_id)
      comment: "Number of unique compliance obligations"
    - name: "active_obligation_count"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN compliance_obligation_id END)
      comment: "Number of active compliance obligations"
    - name: "compliant_obligation_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_status = 'compliant' THEN compliance_obligation_id END)
      comment: "Number of obligations in compliant status"
    - name: "non_compliant_obligation_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_status = 'non-compliant' THEN compliance_obligation_id END)
      comment: "Number of obligations in non-compliant status"
    - name: "escalation_required_count"
      expr: COUNT(DISTINCT CASE WHEN escalation_required = TRUE THEN compliance_obligation_id END)
      comment: "Number of obligations requiring escalation"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts across all compliance obligations"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per compliance obligation"
$$;