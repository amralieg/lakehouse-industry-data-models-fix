-- Metric views for domain: subcontractor | Business: Construction | Version: 2 | Generated on: 2026-06-22 15:07:26

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`subcontractor_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks subcontractor change order financial exposure, approval cycle performance, and schedule impact — key levers for managing subcontract cost growth and programme risk."
  source: "`vibe_construction_v1`.`subcontractor`.`subcontractor_change_order`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project the change order belongs to — enables project-level cost-growth analysis."
    - name: "change_type"
      expr: change_type
      comment: "Category of change (scope addition, omission, variation, etc.) for root-cause analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval state (pending, approved, rejected) to track pipeline of unapproved cost."
    - name: "subcontractor_change_order_status"
      expr: subcontractor_change_order_status
      comment: "Lifecycle status of the change order for workflow monitoring."
    - name: "trade_package"
      expr: trade_package
      comment: "Trade discipline (civil, MEP, structural, etc.) to identify which packages drive most variation."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardised reason code for the change — supports Pareto analysis of change drivers."
    - name: "is_back_charge"
      expr: is_back_charge
      comment: "Flags change orders that are back-charges, enabling separate tracking of recovery actions."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the change order for multi-currency project reporting."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission for trend analysis of change order volume over time."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month of approval for cycle-time and backlog trending."
  measures:
    - name: "total_change_order_count"
      expr: COUNT(1)
      comment: "Total number of subcontractor change orders — baseline volume metric for change management oversight."
    - name: "total_change_amount"
      expr: SUM(CAST(change_amount AS DOUBLE))
      comment: "Aggregate financial value of all change orders — measures total subcontract cost growth exposure."
    - name: "total_original_contract_value"
      expr: SUM(CAST(original_contract_value AS DOUBLE))
      comment: "Sum of original subcontract values across change orders — denominator for cost-growth rate calculation."
    - name: "total_revised_contract_value"
      expr: SUM(CAST(revised_contract_value AS DOUBLE))
      comment: "Sum of revised contract values post-change — measures total committed subcontract spend."
    - name: "avg_change_amount"
      expr: AVG(CAST(change_amount AS DOUBLE))
      comment: "Average value per change order — identifies whether changes are large strategic variations or high-frequency small adjustments."
    - name: "total_contingency_allocated"
      expr: SUM(CAST(contingency_allocation AS DOUBLE))
      comment: "Total contingency consumed by change orders — critical for project contingency burn-rate monitoring."
    - name: "pending_change_order_count"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN 1 END)
      comment: "Number of change orders awaiting approval — measures backlog risk and cash-flow uncertainty."
    - name: "pending_change_amount"
      expr: SUM(CASE WHEN approval_status = 'Pending' THEN change_amount ELSE 0 END)
      comment: "Financial value of unapproved change orders — quantifies unresolved cost exposure on the project."
    - name: "back_charge_change_order_count"
      expr: COUNT(CASE WHEN is_back_charge = TRUE THEN 1 END)
      comment: "Number of change orders classified as back-charges — tracks recovery actions against subcontractors."
    - name: "back_charge_change_amount"
      expr: SUM(CASE WHEN is_back_charge = TRUE THEN change_amount ELSE 0 END)
      comment: "Total value of back-charge change orders — measures financial recovery from subcontractor non-performance."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`subcontractor_back_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors back-charge activity against subcontractors — tracks financial recovery, dispute rates, and cost breakdown to protect project margins."
  source: "`vibe_construction_v1`.`subcontractor`.`back_charge`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project the back-charge relates to — enables project-level recovery analysis."
    - name: "back_charge_status"
      expr: back_charge_status
      comment: "Current status of the back-charge (raised, approved, disputed, closed) for pipeline management."
    - name: "charge_status"
      expr: charge_status
      comment: "Processing status of the charge for operational workflow tracking."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardised reason code for the back-charge — supports root-cause analysis of subcontractor failures."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the back-charge is under dispute — critical for legal and commercial risk monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the back-charge for multi-currency project reporting."
    - name: "incident_date_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month the triggering incident occurred — enables trend analysis of back-charge frequency."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month of approval for cycle-time analysis."
  measures:
    - name: "total_back_charge_count"
      expr: COUNT(1)
      comment: "Total number of back-charges raised — baseline volume metric for subcontractor performance management."
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total value of back-charges raised — measures gross financial recovery sought from subcontractors."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total value of back-charges formally approved — measures confirmed financial recovery."
    - name: "total_deduction_applied"
      expr: SUM(CAST(deduction_applied_amount AS DOUBLE))
      comment: "Total deductions actually applied to subcontractor payments — measures realised recovery."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Labor cost component of back-charges — identifies workforce remediation costs."
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost_amount AS DOUBLE))
      comment: "Material cost component of back-charges — identifies material remediation costs."
    - name: "total_equipment_cost"
      expr: SUM(CAST(equipment_cost_amount AS DOUBLE))
      comment: "Equipment cost component of back-charges — identifies plant/equipment remediation costs."
    - name: "total_overhead_cost"
      expr: SUM(CAST(overhead_cost_amount AS DOUBLE))
      comment: "Overhead cost component of back-charges — captures indirect costs of remediation."
    - name: "total_claimed_amount"
      expr: SUM(CAST(total_claimed_amount AS DOUBLE))
      comment: "Total amount claimed across all back-charges — measures full financial exposure sought."
    - name: "disputed_back_charge_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of back-charges under dispute — measures commercial conflict risk with subcontractors."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of back-charges that are disputed — high rates signal systemic subcontractor relationship issues."
    - name: "recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(deduction_applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_claimed_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of deductions applied to total claimed — measures effectiveness of back-charge recovery process."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`subcontractor_final_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides executive-level visibility into subcontract financial close-out — tracks settlement values, retention release, LD deductions, and dispute resolution to confirm project financial completion."
  source: "`vibe_construction_v1`.`subcontractor`.`final_account`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project the final account belongs to — enables project-level close-out financial analysis."
    - name: "final_account_status"
      expr: final_account_status
      comment: "Lifecycle status of the final account (draft, submitted, agreed, closed) for close-out pipeline management."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement state of the final account — tracks whether financial close-out is complete."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the final account for governance and sign-off tracking."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Flags final accounts under dispute — critical for legal and commercial risk monitoring."
    - name: "is_finalized"
      expr: is_finalized
      comment: "Indicates whether the final account has been fully closed — key close-out completion indicator."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the final account for multi-currency project reporting."
    - name: "settlement_date_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month of settlement for close-out trend analysis."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission for pipeline and cycle-time analysis."
  measures:
    - name: "total_final_account_count"
      expr: COUNT(1)
      comment: "Total number of final accounts — baseline metric for close-out pipeline management."
    - name: "total_original_subcontract_value"
      expr: SUM(CAST(original_subcontract_value AS DOUBLE))
      comment: "Sum of original subcontract values — baseline for measuring total cost growth at close-out."
    - name: "total_agreed_final_amount"
      expr: SUM(CAST(agreed_final_amount AS DOUBLE))
      comment: "Total agreed final settlement value — the definitive measure of subcontract financial close-out."
    - name: "total_net_payable_amount"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net amount payable after all deductions — measures actual cash outflow at close-out."
    - name: "total_retention_released"
      expr: SUM(CAST(retention_released_amount AS DOUBLE))
      comment: "Total retention released at final account — measures cash released to subcontractors at close-out."
    - name: "total_retention_balance"
      expr: SUM(CAST(retention_balance AS DOUBLE))
      comment: "Total retention still held — measures outstanding retention liability on the project."
    - name: "total_ld_deductions"
      expr: SUM(CAST(liquidated_damages_deducted AS DOUBLE))
      comment: "Total liquidated damages deducted at final account — measures financial penalties applied for delays."
    - name: "total_back_charges_value"
      expr: SUM(CAST(back_charges_value AS DOUBLE))
      comment: "Total back-charges included in final account — measures cumulative recovery from subcontractor non-performance."
    - name: "total_approved_change_orders_value"
      expr: SUM(CAST(approved_change_orders_value AS DOUBLE))
      comment: "Total approved variation value at close-out — measures cumulative scope growth over contract life."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between original and final values — key indicator of subcontract cost performance."
    - name: "total_eot_settlement_amount"
      expr: SUM(CAST(eot_settlement_amount AS DOUBLE))
      comment: "Total EOT-related settlement amounts — measures cost of time-related claims at close-out."
    - name: "disputed_final_account_count"
      expr: COUNT(CASE WHEN is_disputed = TRUE THEN 1 END)
      comment: "Number of final accounts under dispute — measures close-out risk and potential legal exposure."
    - name: "finalized_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_finalized = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of final accounts fully closed — measures project close-out completion rate."
    - name: "avg_cost_growth_pct"
      expr: ROUND(100.0 * AVG((agreed_final_amount - original_subcontract_value) / NULLIF(original_subcontract_value, 0)), 2)
      comment: "Average percentage cost growth from original to final value — strategic KPI for subcontract cost performance benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`subcontractor_eot_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks subcontractor extension-of-time claims — monitors claim volumes, approved days, financial exposure, and critical-path impact to manage programme risk and LD liability."
  source: "`vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project the EOT claim relates to — enables project-level programme risk analysis."
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the EOT claim (submitted, under review, approved, rejected) for pipeline management."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of EOT claim (employer risk, force majeure, neutral event, etc.) for entitlement analysis."
    - name: "delay_cause_category"
      expr: delay_cause_category
      comment: "Category of delay cause — supports Pareto analysis of programme disruption drivers."
    - name: "subcontractor_eot_claim_status"
      expr: subcontractor_eot_claim_status
      comment: "Lifecycle status of the claim for workflow and governance tracking."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flags claims affecting the critical path — highest-priority claims for programme management."
    - name: "concurrent_delay_flag"
      expr: concurrent_delay_flag
      comment: "Indicates concurrent delay — affects entitlement assessment and LD exposure."
    - name: "notice_compliance_flag"
      expr: notice_compliance_flag
      comment: "Indicates whether contractual notice was given — affects claim validity and legal standing."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the claim for multi-currency project reporting."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of claim submission for trend analysis of EOT claim frequency."
  measures:
    - name: "total_eot_claim_count"
      expr: COUNT(1)
      comment: "Total number of subcontractor EOT claims — baseline volume metric for programme risk management."
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total financial value of EOT claims — measures cumulative prolongation cost exposure."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved EOT claim value — measures confirmed prolongation cost liability."
    - name: "total_prolongation_cost"
      expr: SUM(CAST(prolongation_cost_amount AS DOUBLE))
      comment: "Total prolongation costs claimed — measures site overhead and standing cost exposure from delays."
    - name: "critical_path_claim_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of EOT claims affecting the critical path — highest-priority claims for programme management."
    - name: "notice_non_compliance_count"
      expr: COUNT(CASE WHEN notice_compliance_flag = FALSE THEN 1 END)
      comment: "Number of claims where contractual notice was not given — measures claims at risk of rejection on procedural grounds."
    - name: "concurrent_delay_claim_count"
      expr: COUNT(CASE WHEN concurrent_delay_flag = TRUE THEN 1 END)
      comment: "Number of claims involving concurrent delay — affects entitlement and LD exposure assessment."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN claim_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EOT claims approved — measures subcontractor claim success rate and contract administration effectiveness."
    - name: "avg_claim_amount"
      expr: AVG(CAST(claim_amount AS DOUBLE))
      comment: "Average financial value per EOT claim — benchmarks claim size for commercial risk assessment."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`subcontractor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors subcontractor invoice processing — tracks payment status, retention, dispute rates, and work progress to manage cash flow and subcontractor payment obligations."
  source: "`vibe_construction_v1`.`subcontractor`.`subcontractor_invoice`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project the invoice relates to — enables project-level payment liability analysis."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (submitted, approved, paid, disputed) for payment pipeline management."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment processing status — tracks whether invoices have been paid, partially paid, or are overdue."
    - name: "subcontractor_invoice_status"
      expr: subcontractor_invoice_status
      comment: "Lifecycle status of the invoice for workflow tracking."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Flags disputed invoices — critical for cash-flow and commercial risk monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice for multi-currency project reporting."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice for payment trend and cash-flow analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month payment is due — enables overdue payment analysis."
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of subcontractor invoices — baseline volume metric for accounts payable management."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice value — measures total subcontractor payment obligations before deductions."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice value after deductions — measures actual cash outflow to subcontractors."
    - name: "total_retention_held"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld from invoices — measures outstanding retention liability to subcontractors."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on subcontractor invoices — required for tax compliance and reporting."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN is_disputed = TRUE THEN 1 END)
      comment: "Number of disputed invoices — measures commercial conflict risk and payment delay exposure."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_disputed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices under dispute — high rates signal systemic payment or scope disagreements."
    - name: "avg_work_progress_pct"
      expr: AVG(CAST(work_progress_percent AS DOUBLE))
      comment: "Average work progress percentage across invoiced subcontracts — measures overall subcontract delivery progress."
    - name: "retention_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(retention_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Retention as a percentage of gross invoice value — monitors retention policy compliance and cash-flow impact."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`subcontractor_payment_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks subcontractor payment certification — monitors certified amounts, retention, payment status, and work progress to manage subcontractor cash flow and contract compliance."
  source: "`vibe_construction_v1`.`subcontractor`.`subcontractor_payment_certificate`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project the payment certificate relates to — enables project-level payment analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment processing status — tracks whether certified amounts have been paid."
    - name: "subcontractor_payment_certificate_status"
      expr: subcontractor_payment_certificate_status
      comment: "Lifecycle status of the certificate for governance and workflow tracking."
    - name: "is_retention_applied"
      expr: is_retention_applied
      comment: "Indicates whether retention was withheld on this certificate — for retention liability tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the certificate for multi-currency project reporting."
    - name: "certification_date_month"
      expr: DATE_TRUNC('MONTH', certification_date)
      comment: "Month of certification for payment trend and cash-flow analysis."
    - name: "payment_due_date_month"
      expr: DATE_TRUNC('MONTH', payment_due_date)
      comment: "Month payment is due — enables overdue payment and cash-flow forecasting."
  measures:
    - name: "total_certificate_count"
      expr: COUNT(1)
      comment: "Total number of payment certificates issued — baseline metric for payment cycle management."
    - name: "total_certified_amount"
      expr: SUM(CAST(certified_amount AS DOUBLE))
      comment: "Total value certified for payment — measures cumulative subcontractor payment entitlement."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due after retention — measures actual cash obligation to subcontractors."
    - name: "total_retention_withheld"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld across all certificates — measures outstanding retention liability."
    - name: "avg_work_progress_pct"
      expr: AVG(CAST(work_progress_percent AS DOUBLE))
      comment: "Average work progress percentage at time of certification — measures subcontract delivery progress."
    - name: "retention_withholding_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(retention_amount AS DOUBLE)) / NULLIF(SUM(CAST(certified_amount AS DOUBLE)), 0), 2)
      comment: "Retention as a percentage of certified amount — monitors retention policy compliance across subcontracts."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`subcontractor_performance_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides strategic visibility into subcontractor performance across quality, safety, schedule, and cost dimensions — drives vendor selection, re-engagement decisions, and supply chain improvement."
  source: "`vibe_construction_v1`.`subcontractor`.`subcontractor_performance_evaluation`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor/subcontractor being evaluated — enables vendor-level performance benchmarking."
    - name: "evaluation_period"
      expr: evaluation_period
      comment: "Period covered by the evaluation (e.g., Q1 2024) for trend analysis over time."
    - name: "rating_grade"
      expr: rating_grade
      comment: "Overall performance grade (A/B/C/D or Excellent/Good/Poor) for executive-level performance segmentation."
    - name: "is_recommended"
      expr: is_recommended
      comment: "Indicates whether the subcontractor is recommended for future work — key re-engagement decision flag."
    - name: "evaluation_date_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of evaluation for performance trend analysis."
  measures:
    - name: "total_evaluation_count"
      expr: COUNT(1)
      comment: "Total number of performance evaluations — baseline metric for subcontractor performance management coverage."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall performance score — primary KPI for subcontractor performance benchmarking and ranking."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality performance score — measures subcontractor workmanship and defect rates."
    - name: "avg_safety_score"
      expr: AVG(CAST(safety_score AS DOUBLE))
      comment: "Average safety performance score — critical KPI for HSE compliance and incident prevention."
    - name: "avg_schedule_score"
      expr: AVG(CAST(schedule_score AS DOUBLE))
      comment: "Average schedule performance score — measures subcontractor on-time delivery performance."
    - name: "avg_cost_score"
      expr: AVG(CAST(cost_score AS DOUBLE))
      comment: "Average cost performance score — measures subcontractor cost management and variation control."
    - name: "recommended_subcontractor_count"
      expr: COUNT(CASE WHEN is_recommended = TRUE THEN 1 END)
      comment: "Number of evaluations resulting in a recommendation for re-engagement — measures approved vendor pool size."
    - name: "recommendation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_recommended = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of evaluated subcontractors recommended for future work — strategic KPI for supply chain quality."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`subcontractor_compliance_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors subcontractor compliance status across insurance, licences, certifications, and regulatory requirements — critical for project risk management and contractual obligation enforcement."
  source: "`vibe_construction_v1`.`subcontractor`.`subcontractor_compliance_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project the compliance record relates to — enables project-level compliance risk analysis."
    - name: "compliance_type"
      expr: compliance_type
      comment: "Type of compliance requirement (insurance, licence, certification, etc.) for category-level analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (compliant, non-compliant, expired, pending) for risk monitoring."
    - name: "is_compliant"
      expr: is_compliant
      comment: "Boolean compliance flag — primary indicator for subcontractor compliance gate management."
    - name: "is_verified"
      expr: is_verified
      comment: "Indicates whether compliance has been independently verified — measures verification coverage."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the compliance record is currently active — filters to current obligations."
    - name: "record_type"
      expr: record_type
      comment: "Type classification of the compliance record for structured reporting."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of expiry — enables proactive compliance renewal management."
  measures:
    - name: "total_compliance_record_count"
      expr: COUNT(1)
      comment: "Total number of compliance records — baseline metric for compliance obligation coverage."
    - name: "compliant_record_count"
      expr: COUNT(CASE WHEN is_compliant = TRUE THEN 1 END)
      comment: "Number of compliant records — measures current compliance coverage across subcontractors."
    - name: "non_compliant_record_count"
      expr: COUNT(CASE WHEN is_compliant = FALSE THEN 1 END)
      comment: "Number of non-compliant records — critical risk indicator requiring immediate management action."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance records in compliant status — primary KPI for subcontractor compliance management."
    - name: "verified_record_count"
      expr: COUNT(CASE WHEN is_verified = TRUE THEN 1 END)
      comment: "Number of independently verified compliance records — measures verification coverage and assurance quality."
    - name: "verification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance records that have been independently verified — measures assurance process effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`subcontractor_prequalification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks subcontractor prequalification pipeline — monitors approval rates, financial capacity, risk ratings, and trade category coverage to manage the approved subcontractor pool."
  source: "`vibe_construction_v1`.`subcontractor`.`subcontractor_prequalification`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project the prequalification relates to — enables project-specific vendor pool analysis."
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Current prequalification status (pending, approved, rejected, expired) for pipeline management."
    - name: "subcontractor_prequalification_status"
      expr: subcontractor_prequalification_status
      comment: "Lifecycle status of the prequalification record for workflow tracking."
    - name: "trade_category"
      expr: trade_category
      comment: "Trade discipline category — enables analysis of approved vendor pool coverage by trade."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned during prequalification — critical for vendor selection and risk management."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the prequalification is currently active — filters to current approved vendors."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month of approval for vendor pool growth trend analysis."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of expiry — enables proactive prequalification renewal management."
  measures:
    - name: "total_prequalification_count"
      expr: COUNT(1)
      comment: "Total number of prequalification records — baseline metric for vendor pool management."
    - name: "approved_prequalification_count"
      expr: COUNT(CASE WHEN prequalification_status = 'Approved' THEN 1 END)
      comment: "Number of approved prequalifications — measures size of the active approved subcontractor pool."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN prequalification_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prequalifications approved — measures vendor qualification success rate and pool quality."
    - name: "total_financial_capacity"
      expr: SUM(CAST(financial_capacity_amount AS DOUBLE))
      comment: "Total financial capacity of prequalified subcontractors — measures aggregate bonding and financial strength of the vendor pool."
    - name: "avg_financial_capacity"
      expr: AVG(CAST(financial_capacity_amount AS DOUBLE))
      comment: "Average financial capacity per prequalified subcontractor — benchmarks vendor financial strength."
    - name: "active_prequalification_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active prequalifications — measures the live approved vendor pool size."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`subcontractor_scope_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors subcontractor scope package delivery — tracks progress, value, and schedule performance at the work-package level to manage subcontract execution and identify delivery risks."
  source: "`vibe_construction_v1`.`subcontractor`.`subcontractor_scope_package`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project the scope package belongs to — enables project-level delivery analysis."
    - name: "package_status"
      expr: package_status
      comment: "Current status of the scope package (not started, in progress, complete) for delivery pipeline management."
    - name: "subcontractor_scope_package_status"
      expr: subcontractor_scope_package_status
      comment: "Lifecycle status of the scope package for workflow tracking."
    - name: "trade_discipline"
      expr: trade_discipline
      comment: "Trade discipline of the scope package — enables analysis of delivery performance by trade."
    - name: "is_critical"
      expr: is_critical
      comment: "Flags critical scope packages — highest-priority packages for programme management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the package value for multi-currency project reporting."
    - name: "planned_start_date_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Planned start month for schedule analysis."
    - name: "planned_end_date_month"
      expr: DATE_TRUNC('MONTH', planned_end_date)
      comment: "Planned completion month for delivery trend analysis."
  measures:
    - name: "total_scope_package_count"
      expr: COUNT(1)
      comment: "Total number of scope packages — baseline metric for subcontract delivery management."
    - name: "total_package_value"
      expr: SUM(CAST(package_value AS DOUBLE))
      comment: "Total value of all scope packages — measures total subcontracted work value under management."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average completion percentage across scope packages — measures overall subcontract delivery progress."
    - name: "total_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of work across scope packages — measures physical work volume under subcontract."
    - name: "critical_package_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical scope packages — measures programme-critical subcontract delivery exposure."
    - name: "complete_package_count"
      expr: COUNT(CASE WHEN package_status = 'Complete' THEN 1 END)
      comment: "Number of completed scope packages — measures subcontract delivery completion rate."
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN package_status = 'Complete' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scope packages completed — strategic KPI for subcontract delivery performance."
    - name: "avg_package_value"
      expr: AVG(CAST(package_value AS DOUBLE))
      comment: "Average value per scope package — benchmarks package sizing for procurement and planning."
$$;