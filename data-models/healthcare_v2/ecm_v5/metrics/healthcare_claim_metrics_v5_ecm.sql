-- Metric views for domain: claim | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core claims processing metrics tracking financial performance, denial rates, adjudication efficiency, and payment outcomes for revenue cycle management."
  source: "`healthcare_ecm_v1`.`claim`.`claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current processing status of the claim (submitted, adjudicated, paid, denied, appealed)"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim - professional (CMS-1500) vs institutional (UB-04) vs dental"
    - name: "submission_method"
      expr: submission_method
      comment: "How the claim was submitted (electronic, paper, clearinghouse, direct)"
    - name: "payer_type_indicator"
      expr: CASE WHEN primary_payer_flag = TRUE THEN 'Primary' ELSE 'Secondary/Tertiary' END
      comment: "Whether this claim is filed to the primary payer or secondary/tertiary"
    - name: "bill_type"
      expr: bill_type
      comment: "UB-04 bill type code indicating facility type, care type, and billing frequency"
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "CMS place of service code indicating where services were rendered"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Standardized denial reason code for denied claims analysis"
    - name: "source_system"
      expr: source_system
      comment: "Originating system for multi-system health organizations"
    - name: "submission_year_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month the claim was submitted for trend analysis"
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of patient admission for inpatient claim trending"
    - name: "appeal_filed_flag"
      expr: CASE WHEN appeal_filed_flag = TRUE THEN 'Appealed' ELSE 'Not Appealed' END
      comment: "Whether an appeal has been filed for this claim"
    - name: "rac_audit_flag_dim"
      expr: CASE WHEN rac_audit_flag = TRUE THEN 'RAC Audited' ELSE 'Not RAC Audited' END
      comment: "Whether the claim was flagged for Recovery Audit Contractor review"
  measures:
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total charges billed to payers across all claims - key revenue cycle top-line metric"
    - name: "total_paid_amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total payments received from payers - actual revenue collected"
    - name: "total_allowed_amount"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Total payer-allowed amounts representing contracted rates"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total contractual and other adjustments applied to claims"
    - name: "total_patient_responsibility"
      expr: SUM(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Total patient out-of-pocket responsibility (copays, coinsurance, deductibles)"
    - name: "claim_count"
      expr: COUNT(1)
      comment: "Total number of claims for volume tracking and workload management"
    - name: "denied_claim_count"
      expr: SUM(CASE WHEN claim_status = 'denied' THEN 1 ELSE 0 END)
      comment: "Number of denied claims - critical for denial management programs"
    - name: "avg_billed_per_claim"
      expr: AVG(CAST(total_billed_amount AS DOUBLE))
      comment: "Average billed amount per claim indicating case mix and charge capture effectiveness"
    - name: "avg_paid_per_claim"
      expr: AVG(CAST(total_paid_amount AS DOUBLE))
      comment: "Average payment per claim indicating payer reimbursement performance"
    - name: "appealed_claim_count"
      expr: SUM(CASE WHEN appeal_filed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of claims with appeals filed - measures denial management activity"
    - name: "cob_claim_count"
      expr: SUM(CASE WHEN coordination_of_benefits_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Claims involving coordination of benefits - complexity indicator for billing operations"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`claim_denial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Denial management metrics tracking denial volumes, financial impact, recovery rates, and root cause patterns to reduce revenue leakage."
  source: "`healthcare_ecm_v1`.`claim`.`claim_denial`"
  dimensions:
    - name: "claim_denial_category"
      expr: claim_denial_category
      comment: "High-level denial category (clinical, administrative, technical, authorization)"
    - name: "claim_denial_type"
      expr: claim_denial_type
      comment: "Specific denial type for targeted intervention strategies"
    - name: "claim_denial_source"
      expr: claim_denial_source
      comment: "Source of the denial (payer, clearinghouse, internal)"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the denial (open, appealed, overturned, written off)"
    - name: "carc_code"
      expr: carc_code
      comment: "Claim Adjustment Reason Code - industry standard denial reason classification"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Internal root cause classification for process improvement"
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the denial - drives accountability"
    - name: "is_preventable_dim"
      expr: CASE WHEN is_preventable = TRUE THEN 'Preventable' ELSE 'Non-Preventable' END
      comment: "Whether the denial was preventable through better processes"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for denial work queue management"
    - name: "denial_month"
      expr: DATE_TRUNC('MONTH', claim_denial_date)
      comment: "Month of denial for trend analysis and seasonality detection"
    - name: "claim_appeal_level"
      expr: claim_appeal_level
      comment: "Appeal level if denial was appealed (first, second, external review)"
  measures:
    - name: "total_denied_amount"
      expr: SUM(CAST(denied_amount AS DOUBLE))
      comment: "Total dollar value of denied claims - primary revenue leakage metric"
    - name: "total_recovered_amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Total dollars recovered through appeals and corrections - measures denial management effectiveness"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total dollars written off as unrecoverable - permanent revenue loss"
    - name: "total_billed_on_denied"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total originally billed amount on denied claims for impact sizing"
    - name: "denial_count"
      expr: COUNT(1)
      comment: "Total number of denials for volume and workload tracking"
    - name: "preventable_denial_count"
      expr: SUM(CASE WHEN is_preventable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of preventable denials - key process improvement target"
    - name: "avg_denied_amount"
      expr: AVG(CAST(denied_amount AS DOUBLE))
      comment: "Average denial dollar value for prioritization and impact assessment"
    - name: "rac_audit_denial_count"
      expr: SUM(CASE WHEN is_rac_audit = TRUE THEN 1 ELSE 0 END)
      comment: "Denials from Recovery Audit Contractor reviews - regulatory compliance indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`claim_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appeal management metrics tracking overturn rates, financial recovery, and appeal process efficiency for denied claims recovery."
  source: "`healthcare_ecm_v1`.`claim`.`claim_appeal`"
  dimensions:
    - name: "claim_appeal_status"
      expr: claim_appeal_status
      comment: "Current status of the appeal (submitted, in review, decided, closed)"
    - name: "claim_appeal_level"
      expr: claim_appeal_level
      comment: "Appeal level (first level, second level, external review, ALJ hearing)"
    - name: "claim_appeal_type"
      expr: claim_appeal_type
      comment: "Type of appeal (clinical, administrative, pre-service, post-service)"
    - name: "outcome_code"
      expr: outcome_code
      comment: "Appeal outcome (overturned, upheld, partially overturned)"
    - name: "submission_method"
      expr: submission_method
      comment: "How the appeal was submitted (electronic, fax, mail, portal)"
    - name: "claim_denial_reason_code"
      expr: claim_denial_reason_code
      comment: "Original denial reason being appealed - identifies which denials are worth appealing"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of appeal submission for trend and workload analysis"
    - name: "priority_flag_dim"
      expr: CASE WHEN priority_flag = TRUE THEN 'Priority' ELSE 'Standard' END
      comment: "Whether the appeal is flagged as priority for expedited processing"
  measures:
    - name: "total_overturn_amount"
      expr: SUM(CAST(overturn_amount AS DOUBLE))
      comment: "Total dollars recovered through successful appeals - ROI of denial management team"
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Total dollars requested in appeals - pipeline of potential recovery"
    - name: "total_original_claim_amount"
      expr: SUM(CAST(original_claim_amount AS DOUBLE))
      comment: "Total original claim value for appeals - measures scope of disputed claims"
    - name: "appeal_count"
      expr: COUNT(1)
      comment: "Total number of appeals filed for workload and capacity planning"
    - name: "overturned_appeal_count"
      expr: SUM(CASE WHEN outcome_code = 'overturned' THEN 1 ELSE 0 END)
      comment: "Number of appeals successfully overturned - measures appeal quality"
    - name: "avg_overturn_amount"
      expr: AVG(CAST(overturn_amount AS DOUBLE))
      comment: "Average recovery per successful appeal for ROI analysis"
    - name: "peer_review_required_count"
      expr: SUM(CASE WHEN peer_review_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Appeals requiring peer-to-peer review - resource planning for medical directors"
    - name: "external_review_count"
      expr: SUM(CASE WHEN external_review_requested_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Appeals escalated to external review - indicates payer dispute severity"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`claim_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service-line level metrics for granular analysis of reimbursement performance, procedure mix, and payment variance by service type."
  source: "`healthcare_ecm_v1`.`claim`.`claim_line`"
  dimensions:
    - name: "claim_line_status"
      expr: claim_line_status
      comment: "Payment status of the individual service line (paid, denied, adjusted)"
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service for the line item - drives reimbursement rate differences"
    - name: "revenue_code"
      expr: revenue_code
      comment: "Revenue code for institutional billing classification"
    - name: "procedure_code"
      expr: procedure_code
      comment: "CPT/HCPCS procedure code identifying the service rendered"
    - name: "modifier_1"
      expr: modifier_1
      comment: "Primary procedure modifier affecting reimbursement (e.g., 25, 59, TC, 26)"
    - name: "ndc_code"
      expr: ndc_code
      comment: "National Drug Code for pharmacy-related claim lines"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', facility_service_from_date)
      comment: "Month of service for temporal analysis of service volumes and payments"
    - name: "claim_denial_reason_code"
      expr: claim_denial_reason_code
      comment: "Line-level denial reason for granular denial pattern analysis"
  measures:
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total charges billed at the service line level"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total payments received at the service line level"
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total payer-allowed amounts at service line level"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments at service line level"
    - name: "total_patient_responsibility"
      expr: SUM(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Total patient responsibility at line level (copay, coinsurance, deductible)"
    - name: "total_units_of_service"
      expr: SUM(CAST(units_of_service AS DOUBLE))
      comment: "Total service units billed - volume indicator for utilization analysis"
    - name: "avg_paid_per_unit"
      expr: AVG(CAST(paid_amount AS DOUBLE))
      comment: "Average payment per service line for reimbursement benchmarking"
    - name: "total_outlier_payment"
      expr: SUM(CAST(outlier_payment_amount AS DOUBLE))
      comment: "Total outlier payments for high-cost cases exceeding DRG thresholds"
    - name: "claim_line_count"
      expr: COUNT(1)
      comment: "Total service lines for volume and complexity analysis"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`claim_remittance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Electronic Remittance Advice (ERA/835) metrics for cash posting performance, payer payment patterns, and reconciliation efficiency."
  source: "`healthcare_ecm_v1`.`claim`.`remittance`"
  dimensions:
    - name: "remittance_status"
      expr: remittance_status
      comment: "Processing status of the remittance (received, posted, reconciled, exception)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status for cash management"
    - name: "payment_method_code"
      expr: payment_method_code
      comment: "Payment method (EFT, check, virtual card) - impacts float and processing cost"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of payment for multi-currency health systems"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment for cash flow trending"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month payment was posted to AR for lag analysis"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payments received via remittance - primary cash inflow metric"
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total billed amounts on remittances for collection rate analysis"
    - name: "total_allowed_amount"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Total allowed amounts on remittances for contract compliance"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total adjustments on remittances - contractual write-downs and other adjustments"
    - name: "total_patient_responsibility"
      expr: SUM(CAST(total_patient_responsibility_amount AS DOUBLE))
      comment: "Total patient responsibility identified on remittances for patient billing"
    - name: "total_provider_adjustment"
      expr: SUM(CAST(provider_adjustment_amount AS DOUBLE))
      comment: "Provider-level adjustments (withhold, incentive, penalty) from payers"
    - name: "remittance_count"
      expr: COUNT(1)
      comment: "Number of remittance advices received for processing volume tracking"
    - name: "avg_payment_per_remittance"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment per ERA for payer payment pattern analysis"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`claim_prior_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization metrics tracking approval rates, turnaround times, and utilization management effectiveness for care access optimization."
  source: "`healthcare_ecm_v1`.`claim`.`prior_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current status of the prior auth (pending, approved, denied, expired, partially approved)"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification (routine, urgent, emergent) affecting turnaround requirements"
    - name: "facility_service_setting"
      expr: facility_service_setting
      comment: "Service setting (inpatient, outpatient, home health) for utilization patterns"
    - name: "payer_type"
      expr: payer_type
      comment: "Type of payer (commercial, Medicare, Medicaid, managed care) for payer-specific analysis"
    - name: "authorization_source"
      expr: authorization_source
      comment: "How authorization was obtained (phone, portal, fax, electronic)"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of prior auth submission for volume trending"
    - name: "appeal_filed_dim"
      expr: CASE WHEN claim_appeal_filed_flag = TRUE THEN 'Appealed' ELSE 'Not Appealed' END
      comment: "Whether a denied prior auth was appealed"
    - name: "peer_review_required_dim"
      expr: CASE WHEN peer_review_required_flag = TRUE THEN 'Peer Review Required' ELSE 'No Peer Review' END
      comment: "Whether peer-to-peer review was required for the authorization"
  measures:
    - name: "auth_request_count"
      expr: COUNT(1)
      comment: "Total prior authorization requests - workload and access barrier metric"
    - name: "total_approved_units"
      expr: SUM(CAST(approved_units AS DOUBLE))
      comment: "Total units approved across all authorizations"
    - name: "total_requested_units"
      expr: SUM(CAST(requested_units AS DOUBLE))
      comment: "Total units requested for approval rate calculation"
    - name: "total_units_consumed"
      expr: SUM(CAST(units_consumed AS DOUBLE))
      comment: "Total authorized units actually used - utilization of approved services"
    - name: "denied_auth_count"
      expr: SUM(CASE WHEN authorization_status = 'denied' THEN 1 ELSE 0 END)
      comment: "Number of denied prior authorizations - care access barrier metric"
    - name: "approved_auth_count"
      expr: SUM(CASE WHEN authorization_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Number of approved authorizations for approval rate trending"
    - name: "appealed_auth_count"
      expr: SUM(CASE WHEN claim_appeal_filed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of denied auths that were appealed - measures denial management activity"
    - name: "peer_review_count"
      expr: SUM(CASE WHEN peer_review_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Authorizations requiring peer-to-peer review - medical director workload indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`claim_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim submission metrics tracking clean claim rates, rejection patterns, and timely filing compliance for billing operations efficiency."
  source: "`healthcare_ecm_v1`.`claim`.`submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission (accepted, rejected, pending, acknowledged)"
    - name: "submission_method"
      expr: submission_method
      comment: "Submission channel (electronic, paper, direct entry) for process efficiency analysis"
    - name: "submission_type"
      expr: submission_type
      comment: "Type of submission (original, corrected, replacement, void)"
    - name: "edi_transaction_set"
      expr: edi_transaction_set
      comment: "EDI transaction type (837P professional, 837I institutional, 837D dental)"
    - name: "acknowledgment_status"
      expr: acknowledgment_status
      comment: "Clearinghouse/payer acknowledgment status for tracking acceptance"
    - name: "claim_filing_indicator_code"
      expr: claim_filing_indicator_code
      comment: "Filing indicator identifying payer type for routing"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission for volume and trend analysis"
    - name: "is_timely_filed_dim"
      expr: CASE WHEN is_timely_filed = TRUE THEN 'Timely' ELSE 'Late' END
      comment: "Whether the claim was filed within payer timely filing limits"
  measures:
    - name: "submission_count"
      expr: COUNT(1)
      comment: "Total claim submissions for billing operations volume tracking"
    - name: "rejected_submission_count"
      expr: SUM(CASE WHEN submission_status = 'rejected' THEN 1 ELSE 0 END)
      comment: "Number of rejected submissions - front-end edit failure indicator"
    - name: "total_charge_amount"
      expr: SUM(CAST(claim_charge_amount AS DOUBLE))
      comment: "Total dollar value of submitted claims for revenue pipeline tracking"
    - name: "resubmission_count"
      expr: SUM(CASE WHEN submission_type IN ('corrected', 'replacement') THEN 1 ELSE 0 END)
      comment: "Number of corrected/replacement submissions - rework indicator"
    - name: "timely_filed_count"
      expr: SUM(CASE WHEN is_timely_filed = TRUE THEN 1 ELSE 0 END)
      comment: "Claims filed within timely filing limits - compliance metric preventing write-offs"
    - name: "late_filed_count"
      expr: SUM(CASE WHEN is_timely_filed = FALSE THEN 1 ELSE 0 END)
      comment: "Claims filed after timely filing deadline - at risk for automatic denial"
    - name: "avg_charge_per_submission"
      expr: AVG(CAST(claim_charge_amount AS DOUBLE))
      comment: "Average charge amount per submission for case mix monitoring"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`claim_remittance_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level remittance metrics for detailed payment variance analysis, contractual adjustment monitoring, and payer contract compliance."
  source: "`healthcare_ecm_v1`.`claim`.`remittance_line`"
  dimensions:
    - name: "claim_line_payment_status"
      expr: claim_line_payment_status
      comment: "Payment status at line level (paid, denied, adjusted, pending)"
    - name: "adjustment_group_code"
      expr: adjustment_group_code
      comment: "ANSI adjustment group (CO=contractual, PR=patient responsibility, OA=other, PI=payer initiated)"
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment applied to the line"
    - name: "claim_adjustment_reason_code"
      expr: claim_adjustment_reason_code
      comment: "CARC code explaining why payment differs from billed amount"
    - name: "revenue_code"
      expr: revenue_code
      comment: "Revenue code for institutional billing analysis"
    - name: "procedure_code"
      expr: procedure_code
      comment: "Procedure code for service-level reimbursement analysis"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', facility_service_date)
      comment: "Month of service for temporal payment analysis"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month payment was posted for cash flow analysis"
  measures:
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total payments at line level for granular reimbursement analysis"
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total billed at line level for variance analysis"
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed amounts for contract rate compliance monitoring"
    - name: "total_contractual_adjustment"
      expr: SUM(CAST(contractual_adjustment_amount AS DOUBLE))
      comment: "Total contractual adjustments - expected write-downs per payer contracts"
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible applied - patient financial responsibility tracking"
    - name: "total_coinsurance_amount"
      expr: SUM(CAST(coinsurance_amount AS DOUBLE))
      comment: "Total coinsurance amounts for patient billing"
    - name: "total_copay_amount"
      expr: SUM(CAST(copay_amount AS DOUBLE))
      comment: "Total copay amounts identified on remittance for patient collections"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total payment variance from expected - contract underpayment detection"
    - name: "total_recoupment_amount"
      expr: SUM(CAST(recoupment_amount AS DOUBLE))
      comment: "Total recoupments (take-backs) by payers - monitors payer clawback activity"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Net revenue after all adjustments - true bottom-line reimbursement"
    - name: "remittance_line_count"
      expr: COUNT(1)
      comment: "Total remittance lines for processing volume and complexity tracking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`claim_cob`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coordination of Benefits metrics tracking multi-payer payment coordination, payment sequencing accuracy, and total patient financial exposure."
  source: "`healthcare_ecm_v1`.`claim`.`cob`"
  dimensions:
    - name: "cob_status"
      expr: cob_status
      comment: "Current COB determination status (active, resolved, disputed)"
    - name: "cob_method"
      expr: cob_method
      comment: "Method used for COB determination (birthday rule, gender rule, employment)"
    - name: "determination_method"
      expr: determination_method
      comment: "How the payer order was determined for audit trail"
    - name: "order_sequence"
      expr: order_sequence
      comment: "Payer payment sequence (primary, secondary, tertiary)"
    - name: "msp_indicator_dim"
      expr: CASE WHEN msp_indicator = TRUE THEN 'MSP Applicable' ELSE 'Non-MSP' END
      comment: "Whether Medicare Secondary Payer rules apply - critical for compliance"
    - name: "msp_type_code"
      expr: msp_type_code
      comment: "MSP type (working aged, ESRD, disability) for Medicare compliance"
    - name: "determination_month"
      expr: DATE_TRUNC('MONTH', determination_date)
      comment: "Month of COB determination for processing trend analysis"
  measures:
    - name: "total_primary_paid"
      expr: SUM(CAST(primary_paid_amount AS DOUBLE))
      comment: "Total paid by primary payer across COB claims"
    - name: "total_secondary_paid"
      expr: SUM(CAST(secondary_paid_amount AS DOUBLE))
      comment: "Total paid by secondary payer - measures secondary recovery effectiveness"
    - name: "total_tertiary_paid"
      expr: SUM(CAST(tertiary_paid_amount AS DOUBLE))
      comment: "Total paid by tertiary payer for complex multi-payer scenarios"
    - name: "total_patient_responsibility"
      expr: SUM(CAST(total_patient_responsibility_amount AS DOUBLE))
      comment: "Total remaining patient responsibility after all payers - patient billing target"
    - name: "total_primary_billed"
      expr: SUM(CAST(primary_billed_amount AS DOUBLE))
      comment: "Total billed to primary payer for COB claims"
    - name: "total_primary_adjustment"
      expr: SUM(CAST(primary_adjustment_amount AS DOUBLE))
      comment: "Total adjustments from primary payer affecting secondary billing"
    - name: "cob_claim_count"
      expr: COUNT(1)
      comment: "Total COB determinations for multi-payer complexity tracking"
    - name: "msp_claim_count"
      expr: SUM(CASE WHEN msp_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Medicare Secondary Payer claims - compliance monitoring for CMS audits"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`claim_eligibility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time eligibility verification metrics tracking verification success rates, coverage gaps, and front-end denial prevention effectiveness."
  source: "`healthcare_ecm_v1`.`claim`.`eligibility`"
  dimensions:
    - name: "coverage_status"
      expr: coverage_status
      comment: "Patient coverage status returned (active, inactive, terminated, pending)"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage (medical, dental, vision, pharmacy, behavioral health)"
    - name: "coverage_level"
      expr: coverage_level
      comment: "Coverage level (individual, family, employee+spouse, employee+children)"
    - name: "network_status"
      expr: network_status
      comment: "Provider network status (in-network, out-of-network, tier) affecting patient cost"
    - name: "consent_verification_status"
      expr: consent_verification_status
      comment: "Status of consent verification for eligibility check"
    - name: "response_code"
      expr: response_code
      comment: "Payer response code indicating verification outcome"
    - name: "verification_month"
      expr: DATE_TRUNC('MONTH', facility_service_date)
      comment: "Month of eligibility verification for volume trending"
    - name: "prior_auth_required_dim"
      expr: CASE WHEN prior_authorization_required = TRUE THEN 'Auth Required' ELSE 'No Auth Required' END
      comment: "Whether prior authorization is required - triggers auth workflow"
  measures:
    - name: "verification_count"
      expr: COUNT(1)
      comment: "Total eligibility verifications performed - front desk efficiency metric"
    - name: "total_copay_amount"
      expr: SUM(CAST(copay_amount AS DOUBLE))
      comment: "Total expected copay amounts for point-of-service collection targets"
    - name: "total_deductible_remaining"
      expr: SUM(CAST(deductible_remaining_amount AS DOUBLE))
      comment: "Total remaining deductible across patients - patient financial exposure indicator"
    - name: "total_coinsurance_pct"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage for patient cost estimation"
    - name: "auth_required_count"
      expr: SUM(CASE WHEN prior_authorization_required = TRUE THEN 1 ELSE 0 END)
      comment: "Verifications indicating prior auth required - triggers utilization management workflow"
    - name: "referral_required_count"
      expr: SUM(CASE WHEN referral_required = TRUE THEN 1 ELSE 0 END)
      comment: "Verifications indicating referral required - HMO plan compliance tracking"
    - name: "avg_out_of_pocket_max"
      expr: AVG(CAST(out_of_pocket_maximum AS DOUBLE))
      comment: "Average out-of-pocket maximum for patient financial counseling"
$$;