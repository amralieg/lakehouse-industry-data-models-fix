-- Metric views for domain: regulatory | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-23 23:38:27

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core regulatory registration KPIs tracking approval rates, renewal compliance, and registration portfolio health across jurisdictions and product categories."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the regulatory registration (approved, pending, expired, etc.)"
    - name: "registration_type"
      expr: registration_type
      comment: "Type of regulatory registration (product notification, market authorization, etc.)"
    - name: "jurisdiction_country"
      expr: country_code
      comment: "Country code for the regulatory jurisdiction"
    - name: "product_category"
      expr: product_category_code
      comment: "Product category code subject to registration"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the registration was approved"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the registration expires"
    - name: "gmp_compliant"
      expr: gmp_compliance_flag
      comment: "Whether the registration requires GMP compliance"
    - name: "post_market_surveillance_required"
      expr: post_market_surveillance_required
      comment: "Whether post-market surveillance is required for this registration"
  measures:
    - name: "total_registrations"
      expr: COUNT(1)
      comment: "Total number of regulatory registrations in the portfolio"
    - name: "total_registration_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total registration and renewal fees paid across all registrations"
    - name: "avg_registration_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average registration fee per registration"
    - name: "active_registrations"
      expr: COUNT(CASE WHEN registration_status = 'Active' THEN 1 END)
      comment: "Count of registrations currently in active status"
    - name: "expired_registrations"
      expr: COUNT(CASE WHEN registration_status = 'Expired' THEN 1 END)
      comment: "Count of registrations that have expired and require renewal"
    - name: "pending_registrations"
      expr: COUNT(CASE WHEN registration_status = 'Pending' THEN 1 END)
      comment: "Count of registrations awaiting approval from regulatory authorities"
    - name: "registrations_expiring_soon"
      expr: COUNT(CASE WHEN DATEDIFF(expiry_date, CURRENT_DATE()) <= 90 AND registration_status = 'Active' THEN 1 END)
      comment: "Count of active registrations expiring within 90 days requiring renewal action"
    - name: "gmp_compliant_registrations"
      expr: COUNT(CASE WHEN gmp_compliance_flag = TRUE THEN 1 END)
      comment: "Count of registrations requiring GMP compliance certification"
    - name: "distinct_jurisdictions"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of unique jurisdictions where products are registered"
    - name: "distinct_products_registered"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs with active regulatory registrations"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_product_recall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product recall effectiveness and financial impact KPIs tracking recall execution, recovery rates, and cost management across recall classifications."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`product_recall`"
  dimensions:
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the product recall (initiated, in progress, completed, etc.)"
    - name: "recall_class"
      expr: recall_class
      comment: "FDA recall classification (Class I, II, III) indicating severity"
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (voluntary, mandatory, market withdrawal)"
    - name: "recall_year"
      expr: YEAR(initiated_date)
      comment: "Year the recall was initiated"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the recall (national, regional, global)"
    - name: "consumer_remedy_type"
      expr: consumer_remedy_type
      comment: "Type of remedy offered to consumers (refund, replacement, repair)"
    - name: "regulatory_mandate"
      expr: regulatory_mandate_flag
      comment: "Whether the recall was mandated by regulatory authority"
    - name: "public_notification_issued"
      expr: public_notification_issued
      comment: "Whether public notification was issued for the recall"
  measures:
    - name: "total_recalls"
      expr: COUNT(1)
      comment: "Total number of product recalls initiated"
    - name: "total_recall_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated financial cost of all recalls"
    - name: "avg_recall_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per recall event"
    - name: "total_units_affected"
      expr: SUM(CAST(quantity_recalled_units AS DOUBLE))
      comment: "Total number of product units subject to recall"
    - name: "total_units_recovered"
      expr: SUM(CAST(quantity_recovered_units AS DOUBLE))
      comment: "Total number of recalled units successfully recovered from market"
    - name: "avg_recall_effectiveness_pct"
      expr: AVG(CAST(recall_effectiveness_percentage AS DOUBLE))
      comment: "Average recall effectiveness percentage across all recalls"
    - name: "class_i_recalls"
      expr: COUNT(CASE WHEN recall_class = 'Class I' THEN 1 END)
      comment: "Count of Class I recalls (most severe, risk of serious injury or death)"
    - name: "mandatory_recalls"
      expr: COUNT(CASE WHEN regulatory_mandate_flag = TRUE THEN 1 END)
      comment: "Count of recalls mandated by regulatory authorities"
    - name: "completed_recalls"
      expr: COUNT(CASE WHEN recall_status = 'Completed' THEN 1 END)
      comment: "Count of recalls that have been completed and closed"
    - name: "distinct_skus_recalled"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs subject to recall events"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_compliance_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance assessment performance KPIs tracking assessment outcomes, corrective action rates, and compliance risk across regulatory frameworks."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment`"
  dimensions:
    - name: "assessment_result"
      expr: assessment_result
      comment: "Overall result of the compliance assessment (compliant, non-compliant, conditional)"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of compliance assessment conducted (audit, inspection, self-assessment)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status following assessment"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned based on assessment findings (high, medium, low)"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the compliance assessment was conducted"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework assessed against (GMP, ISO, FDA, etc.)"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective actions are required based on assessment findings"
    - name: "certification_issued"
      expr: certification_issued
      comment: "Whether a compliance certification was issued following assessment"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of compliance assessments conducted"
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across all assessments"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all evaluations"
    - name: "compliant_assessments"
      expr: COUNT(CASE WHEN assessment_result = 'Compliant' THEN 1 END)
      comment: "Count of assessments resulting in compliant status"
    - name: "non_compliant_assessments"
      expr: COUNT(CASE WHEN assessment_result = 'Non-Compliant' THEN 1 END)
      comment: "Count of assessments resulting in non-compliant status requiring remediation"
    - name: "assessments_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of assessments requiring corrective action plans"
    - name: "high_risk_assessments"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Count of assessments identifying high compliance risk"
    - name: "certifications_issued"
      expr: COUNT(CASE WHEN certification_issued = TRUE THEN 1 END)
      comment: "Count of assessments resulting in compliance certification"
    - name: "distinct_facilities_assessed"
      expr: COUNT(DISTINCT manufacturing_facility_id)
      comment: "Number of unique manufacturing facilities undergoing compliance assessment"
    - name: "distinct_products_assessed"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique products subject to compliance assessment"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_surveillance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post-market surveillance KPIs tracking adverse events, investigation outcomes, and regulatory reporting compliance for marketed products."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`surveillance_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of surveillance event (adverse event, consumer complaint, quality issue)"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the surveillance event investigation"
    - name: "severity"
      expr: severity
      comment: "Severity classification of the surveillance event"
    - name: "event_year"
      expr: YEAR(event_date)
      comment: "Year the surveillance event occurred"
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market where the surveillance event was reported"
    - name: "reporter_type"
      expr: reporter_type
      comment: "Type of reporter (consumer, healthcare professional, retailer)"
    - name: "injury_reported"
      expr: injury_reported_flag
      comment: "Whether injury was reported in the surveillance event"
    - name: "recall_initiated"
      expr: recall_initiated_flag
      comment: "Whether the surveillance event resulted in a product recall"
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required_flag
      comment: "Whether the event requires mandatory reporting to regulatory authorities"
  measures:
    - name: "total_surveillance_events"
      expr: COUNT(1)
      comment: "Total number of post-market surveillance events reported"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Average estimated financial impact per surveillance event"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Total estimated financial impact of all surveillance events"
    - name: "events_with_injury"
      expr: COUNT(CASE WHEN injury_reported_flag = TRUE THEN 1 END)
      comment: "Count of surveillance events involving reported injury"
    - name: "events_requiring_regulatory_report"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 END)
      comment: "Count of events requiring mandatory regulatory authority notification"
    - name: "events_triggering_recall"
      expr: COUNT(CASE WHEN recall_initiated_flag = TRUE THEN 1 END)
      comment: "Count of surveillance events that resulted in product recall initiation"
    - name: "high_severity_events"
      expr: COUNT(CASE WHEN severity = 'High' THEN 1 END)
      comment: "Count of high-severity surveillance events requiring immediate action"
    - name: "events_under_investigation"
      expr: COUNT(CASE WHEN event_status = 'Under Investigation' THEN 1 END)
      comment: "Count of surveillance events currently under active investigation"
    - name: "distinct_skus_with_events"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs associated with surveillance events"
    - name: "distinct_lots_affected"
      expr: COUNT(DISTINCT lot_batch_id)
      comment: "Number of unique lot/batch numbers associated with surveillance events"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance obligation management KPIs tracking obligation portfolio, deadline adherence, and compliance cost across regulatory frameworks."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of compliance obligation (registration, reporting, testing, labeling)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the obligation (compliant, overdue, pending)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the compliance obligation (high, medium, low)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with non-compliance"
    - name: "frequency"
      expr: frequency
      comment: "Frequency of the compliance obligation (annual, quarterly, one-time)"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the obligation (FDA, EPA, REACH, etc.)"
    - name: "is_active"
      expr: is_active
      comment: "Whether the compliance obligation is currently active"
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year the compliance obligation is due"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of compliance obligations in the portfolio"
    - name: "total_compliance_cost"
      expr: SUM(CAST(estimated_compliance_cost AS DOUBLE))
      comment: "Total estimated cost to achieve compliance across all obligations"
    - name: "avg_compliance_cost"
      expr: AVG(CAST(estimated_compliance_cost AS DOUBLE))
      comment: "Average estimated cost per compliance obligation"
    - name: "active_obligations"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active compliance obligations"
    - name: "overdue_obligations"
      expr: COUNT(CASE WHEN compliance_status = 'Overdue' THEN 1 END)
      comment: "Count of compliance obligations past their due date"
    - name: "high_priority_obligations"
      expr: COUNT(CASE WHEN priority = 'High' THEN 1 END)
      comment: "Count of high-priority compliance obligations requiring immediate attention"
    - name: "high_risk_obligations"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Count of obligations with high non-compliance risk"
    - name: "obligations_due_soon"
      expr: COUNT(CASE WHEN DATEDIFF(due_date, CURRENT_DATE()) <= 30 AND is_active = TRUE THEN 1 END)
      comment: "Count of active obligations due within 30 days"
    - name: "distinct_jurisdictions"
      expr: COUNT(DISTINCT jurisdiction_id)
      comment: "Number of unique jurisdictions with compliance obligations"
    - name: "distinct_products_obligated"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique products subject to compliance obligations"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission performance KPIs tracking approval rates, cycle times, and submission portfolio health across regulatory authorities."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (new product, variation, renewal)"
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission (submitted, under review, approved, rejected)"
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Final decision outcome from regulatory authority"
    - name: "priority"
      expr: priority
      comment: "Priority level of the submission (expedited, standard)"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the submission was filed with regulatory authority"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority receiving the submission (FDA, EMA, etc.)"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action was required following review"
    - name: "deficiency_letter_received"
      expr: deficiency_letter_received
      comment: "Whether a deficiency letter was received requiring additional information"
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions filed"
    - name: "total_submission_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total submission fees paid to regulatory authorities"
    - name: "avg_submission_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average submission fee per filing"
    - name: "approved_submissions"
      expr: COUNT(CASE WHEN decision_outcome = 'Approved' THEN 1 END)
      comment: "Count of submissions approved by regulatory authorities"
    - name: "rejected_submissions"
      expr: COUNT(CASE WHEN decision_outcome = 'Rejected' THEN 1 END)
      comment: "Count of submissions rejected by regulatory authorities"
    - name: "submissions_under_review"
      expr: COUNT(CASE WHEN submission_status = 'Under Review' THEN 1 END)
      comment: "Count of submissions currently under regulatory review"
    - name: "submissions_with_deficiency"
      expr: COUNT(CASE WHEN deficiency_letter_received = TRUE THEN 1 END)
      comment: "Count of submissions receiving deficiency letters requiring response"
    - name: "submissions_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of submissions requiring corrective action before approval"
    - name: "expedited_submissions"
      expr: COUNT(CASE WHEN priority = 'Expedited' THEN 1 END)
      comment: "Count of submissions filed under expedited review pathways"
    - name: "distinct_products_submitted"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique products subject to regulatory submissions"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory action management KPIs tracking enforcement actions, corrective action completion, and financial penalties across regulatory authorities."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of regulatory action (warning letter, consent decree, injunction, fine)"
    - name: "action_status"
      expr: action_status
      comment: "Current status of the regulatory action (open, in progress, closed)"
    - name: "severity"
      expr: severity
      comment: "Severity level of the regulatory action"
    - name: "action_year"
      expr: YEAR(action_date)
      comment: "Year the regulatory action was issued"
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Regulatory authority issuing the action (FDA, EPA, CPSC, etc.)"
    - name: "recall_required"
      expr: recall_required_flag
      comment: "Whether the action requires a product recall"
    - name: "public_disclosure"
      expr: public_disclosure_flag
      comment: "Whether the action was publicly disclosed"
    - name: "repeat_violation"
      expr: repeat_violation_flag
      comment: "Whether the action is for a repeat violation"
  measures:
    - name: "total_actions"
      expr: COUNT(1)
      comment: "Total number of regulatory actions issued against the organization"
    - name: "total_financial_penalties"
      expr: SUM(CAST(financial_penalty_amount AS DOUBLE))
      comment: "Total financial penalties assessed across all regulatory actions"
    - name: "avg_financial_penalty"
      expr: AVG(CAST(financial_penalty_amount AS DOUBLE))
      comment: "Average financial penalty per regulatory action"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts levied across all actions"
    - name: "open_actions"
      expr: COUNT(CASE WHEN action_status = 'Open' THEN 1 END)
      comment: "Count of regulatory actions currently open and requiring response"
    - name: "closed_actions"
      expr: COUNT(CASE WHEN action_status = 'Closed' THEN 1 END)
      comment: "Count of regulatory actions that have been resolved and closed"
    - name: "actions_requiring_recall"
      expr: COUNT(CASE WHEN recall_required_flag = TRUE THEN 1 END)
      comment: "Count of regulatory actions requiring product recall"
    - name: "publicly_disclosed_actions"
      expr: COUNT(CASE WHEN public_disclosure_flag = TRUE THEN 1 END)
      comment: "Count of regulatory actions subject to public disclosure"
    - name: "repeat_violations"
      expr: COUNT(CASE WHEN repeat_violation_flag = TRUE THEN 1 END)
      comment: "Count of actions for repeat violations indicating systemic compliance issues"
    - name: "distinct_facilities_cited"
      expr: COUNT(DISTINCT manufacturing_facility_id)
      comment: "Number of unique manufacturing facilities subject to regulatory actions"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_ifra_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IFRA fragrance compliance KPIs tracking usage level compliance, allergen management, and restricted substance adherence for fragrance ingredients."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "IFRA compliance status of the fragrance ingredient (compliant, non-compliant, under review)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the IFRA compliance assessment"
    - name: "ifra_product_category"
      expr: ifra_product_category
      comment: "IFRA product category determining usage level limits (Category 1-11)"
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of IFRA restriction applied (prohibited, restricted, specification)"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the IFRA compliance assessment was conducted"
    - name: "allergen_declaration_required"
      expr: allergen_declaration_required
      comment: "Whether allergen declaration is required for the ingredient"
    - name: "allergen_threshold_exceeded"
      expr: allergen_threshold_exceeded
      comment: "Whether the ingredient usage exceeds allergen declaration thresholds"
    - name: "restricted_substances_present"
      expr: restricted_substances_present
      comment: "Whether restricted substances are present in the formulation"
    - name: "is_active"
      expr: is_active
      comment: "Whether the IFRA compliance record is currently active"
  measures:
    - name: "total_compliance_records"
      expr: COUNT(1)
      comment: "Total number of IFRA compliance records maintained"
    - name: "avg_usage_level"
      expr: AVG(CAST(actual_formulated_usage_level AS DOUBLE))
      comment: "Average actual usage level of fragrance ingredients in formulations"
    - name: "avg_max_permitted_level"
      expr: AVG(CAST(maximum_permitted_usage_level AS DOUBLE))
      comment: "Average maximum permitted usage level per IFRA standards"
    - name: "avg_safety_margin_pct"
      expr: AVG(CAST(safety_margin_percentage AS DOUBLE))
      comment: "Average safety margin percentage between actual and maximum permitted usage"
    - name: "compliant_records"
      expr: COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END)
      comment: "Count of fragrance ingredients in full IFRA compliance"
    - name: "non_compliant_records"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Count of fragrance ingredients not meeting IFRA standards requiring reformulation"
    - name: "records_with_allergen_declaration"
      expr: COUNT(CASE WHEN allergen_declaration_required = TRUE THEN 1 END)
      comment: "Count of ingredients requiring allergen declaration on product labels"
    - name: "records_exceeding_allergen_threshold"
      expr: COUNT(CASE WHEN allergen_threshold_exceeded = TRUE THEN 1 END)
      comment: "Count of ingredients exceeding allergen declaration thresholds"
    - name: "records_with_restricted_substances"
      expr: COUNT(CASE WHEN restricted_substances_present = TRUE THEN 1 END)
      comment: "Count of formulations containing IFRA-restricted substances"
    - name: "distinct_formulations_assessed"
      expr: COUNT(DISTINCT product_formulation_id)
      comment: "Number of unique product formulations assessed for IFRA compliance"
$$;