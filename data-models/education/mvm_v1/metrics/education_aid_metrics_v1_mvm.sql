-- Metric views for domain: aid | Business: Education | Version: 1 | Generated on: 2026-05-06 15:08:33

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial aid application pipeline metrics tracking application volume, financial need, cost of attendance, and eligibility flags. Used by financial aid directors to monitor application throughput, need-based demand, and compliance posture across award years."
  source: "`education_ecm`.`aid`.`aid_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the aid application (e.g., submitted, pending, awarded, denied). Primary grouping for pipeline stage analysis."
    - name: "enrollment_intensity"
      expr: enrollment_intensity
      comment: "Student enrollment intensity (full-time, half-time, less-than-half-time). Drives COA budget and award eligibility calculations."
    - name: "housing_plan_code"
      expr: housing_plan_code
      comment: "Student housing plan (on-campus, off-campus, with parent). Affects COA budget component and aid packaging."
    - name: "pell_eligible_flag"
      expr: pell_eligible_flag
      comment: "Indicates whether the student is eligible for Pell Grant. Key segmentation for need-based aid analysis."
    - name: "direct_loan_eligible_flag"
      expr: direct_loan_eligible_flag
      comment: "Indicates eligibility for federal direct loans. Used to segment loan-eligible applicant population."
    - name: "state_aid_eligible_flag"
      expr: state_aid_eligible_flag
      comment: "Indicates eligibility for state-funded aid programs. Used for state reporting and aid mix analysis."
    - name: "professional_judgment_flag"
      expr: professional_judgment_flag
      comment: "Indicates a professional judgment override was applied. Tracks discretionary aid decisions for audit and compliance."
    - name: "veteran_benefits_flag"
      expr: veteran_benefits_flag
      comment: "Indicates the student is receiving veteran benefits. Used for veteran student population reporting."
    - name: "fafsa_receipt_date_month"
      expr: DATE_TRUNC('MONTH', fafsa_receipt_date)
      comment: "Month the FAFSA was received. Used to analyze application timing trends and early vs. late filer patterns."
    - name: "submitted_date_month"
      expr: DATE_TRUNC('MONTH', submitted_date)
      comment: "Month the aid application was submitted. Used for application volume trending over time."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of aid applications submitted. Baseline volume metric for pipeline monitoring and year-over-year comparison."
    - name: "total_financial_need_amount"
      expr: SUM(CAST(financial_need_amount AS DOUBLE))
      comment: "Total demonstrated financial need across all applications. Drives institutional aid budget planning and gap analysis."
    - name: "total_coa_amount"
      expr: SUM(CAST(coa_amount AS DOUBLE))
      comment: "Total cost of attendance across all applications. Used to assess aggregate student cost burden and aid coverage gaps."
    - name: "avg_financial_need_amount"
      expr: AVG(CAST(financial_need_amount AS DOUBLE))
      comment: "Average demonstrated financial need per application. Benchmarks need intensity across cohorts and enrollment types."
    - name: "avg_coa_amount"
      expr: AVG(CAST(coa_amount AS DOUBLE))
      comment: "Average cost of attendance per application. Used to track affordability trends and COA budget accuracy."
    - name: "avg_institutional_methodology_efc"
      expr: AVG(CAST(institutional_methodology_efc AS DOUBLE))
      comment: "Average Expected Family Contribution (EFC) using institutional methodology. Informs need-based packaging strategy and institutional grant budgeting."
    - name: "avg_pell_leu_percentage"
      expr: AVG(CAST(pell_leu_percentage AS DOUBLE))
      comment: "Average Pell Lifetime Eligibility Used (LEU) percentage across applicants. Monitors Pell exhaustion risk in the student population."
    - name: "pell_eligible_applications"
      expr: COUNT(CASE WHEN pell_eligible_flag = TRUE THEN 1 END)
      comment: "Number of applications from Pell-eligible students. Key indicator of low-income student demand and federal grant exposure."
    - name: "professional_judgment_applications"
      expr: COUNT(CASE WHEN professional_judgment_flag = TRUE THEN 1 END)
      comment: "Number of applications with a professional judgment override. Tracks discretionary aid volume for compliance and workload management."
    - name: "drug_conviction_ineligible_applications"
      expr: COUNT(CASE WHEN drug_conviction_flag = TRUE THEN 1 END)
      comment: "Number of applications flagged for drug conviction, rendering the student ineligible for federal aid. Compliance and risk monitoring metric."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_award`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aid award lifecycle metrics covering offered, accepted, disbursed, cancelled, and remaining award amounts by fund type, need basis, and packaging group. Core KPI layer for financial aid directors and CFOs to monitor award execution and budget utilization."
  source: "`education_ecm`.`aid`.`aid_award`"
  dimensions:
    - name: "award_status"
      expr: award_status
      comment: "Current status of the aid award (e.g., offered, accepted, cancelled, disbursed). Primary dimension for award pipeline stage analysis."
    - name: "federal_fund_code"
      expr: federal_fund_code
      comment: "Federal program fund code (e.g., Pell, SEOG, Direct Loan). Used to segment awards by federal program for compliance reporting."
    - name: "packaging_group"
      expr: packaging_group
      comment: "Aid packaging group assignment. Used to analyze award distribution across packaging cohorts and strategies."
    - name: "need_based_flag"
      expr: need_based_flag
      comment: "Indicates whether the award is need-based. Enables need-based vs. merit-based aid mix analysis."
    - name: "subsidized_flag"
      expr: subsidized_flag
      comment: "Indicates whether the loan award is subsidized. Used to track subsidized vs. unsubsidized loan volume."
    - name: "self_help_flag"
      expr: self_help_flag
      comment: "Indicates whether the award is a self-help type (loan or work-study). Used for aid mix and student debt analysis."
    - name: "renewable_flag"
      expr: renewable_flag
      comment: "Indicates whether the award is renewable in future years. Used for multi-year aid commitment forecasting."
    - name: "enrollment_status_requirement"
      expr: enrollment_status_requirement
      comment: "Enrollment status required to maintain the award (e.g., full-time, half-time). Used to assess award retention risk."
    - name: "priority"
      expr: priority
      comment: "Award priority level within the packaging sequence. Used to analyze packaging order and aid allocation strategy."
    - name: "offer_date_month"
      expr: DATE_TRUNC('MONTH', offer_date)
      comment: "Month the award was offered. Used to track offer timing trends and early packaging performance."
    - name: "acceptance_date_month"
      expr: DATE_TRUNC('MONTH', acceptance_date)
      comment: "Month the award was accepted by the student. Used to measure acceptance lag and yield timing."
  measures:
    - name: "total_offered_amount"
      expr: SUM(CAST(offered_amount AS DOUBLE))
      comment: "Total aid amount offered to students. Primary measure of institutional aid commitment and budget exposure."
    - name: "total_accepted_amount"
      expr: SUM(CAST(accepted_amount AS DOUBLE))
      comment: "Total aid amount accepted by students. Measures actual student uptake of offered aid."
    - name: "total_disbursed_amount"
      expr: SUM(CAST(disbursed_amount AS DOUBLE))
      comment: "Total aid amount disbursed to student accounts. Core cash-flow and budget execution metric."
    - name: "total_cancelled_amount"
      expr: SUM(CAST(cancelled_amount AS DOUBLE))
      comment: "Total aid amount cancelled. Tracks award attrition and recaptured budget for reallocation."
    - name: "total_remaining_amount"
      expr: SUM(CAST(remaining_amount AS DOUBLE))
      comment: "Total undisbursed remaining award balance. Indicates pending aid liability and disbursement pipeline."
    - name: "avg_offered_amount"
      expr: AVG(CAST(offered_amount AS DOUBLE))
      comment: "Average aid amount offered per award. Benchmarks award generosity and packaging strategy effectiveness."
    - name: "total_origination_fee_amount"
      expr: SUM(CAST(origination_fee_amount AS DOUBLE))
      comment: "Total loan origination fees charged across all awards. Tracks student loan cost burden beyond principal."
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate across loan awards. Monitors student debt cost and loan program mix."
    - name: "total_awards"
      expr: COUNT(1)
      comment: "Total number of aid awards issued. Baseline volume metric for award activity monitoring."
    - name: "need_based_awards"
      expr: COUNT(CASE WHEN need_based_flag = TRUE THEN 1 END)
      comment: "Number of need-based awards. Tracks institutional commitment to need-based aid access."
    - name: "acceptance_rate"
      expr: ROUND(100.0 * SUM(CAST(accepted_amount AS DOUBLE)) / NULLIF(SUM(CAST(offered_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of offered aid amount that was accepted by students. Measures aid offer effectiveness and student engagement with the aid package."
    - name: "disbursement_execution_rate"
      expr: ROUND(100.0 * SUM(CAST(disbursed_amount AS DOUBLE)) / NULLIF(SUM(CAST(accepted_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of accepted aid that has been disbursed. Tracks disbursement pipeline efficiency and identifies bottlenecks."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * SUM(CAST(cancelled_amount AS DOUBLE)) / NULLIF(SUM(CAST(offered_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of offered aid that was cancelled. High cancellation rates signal enrollment attrition or eligibility loss risk."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aid fund portfolio metrics covering allocation, remaining balance, award limits, and fund eligibility characteristics. Used by financial aid and finance leadership to manage fund utilization, compliance, and endowment performance."
  source: "`education_ecm`.`aid`.`aid_fund`"
  dimensions:
    - name: "fund_type"
      expr: fund_type
      comment: "Type of aid fund (e.g., grant, loan, scholarship, work-study). Primary segmentation for aid mix analysis."
    - name: "fund_category"
      expr: fund_category
      comment: "Categorical grouping of the fund (e.g., federal, state, institutional, private). Used for funding source analysis and compliance reporting."
    - name: "fund_status"
      expr: fund_status
      comment: "Current operational status of the fund (e.g., active, inactive, exhausted). Used to monitor fund availability."
    - name: "need_based_flag"
      expr: need_based_flag
      comment: "Indicates whether the fund is need-based. Used to analyze need-based vs. merit-based fund portfolio composition."
    - name: "merit_based_flag"
      expr: merit_based_flag
      comment: "Indicates whether the fund is merit-based. Used to track merit aid investment and academic excellence incentives."
    - name: "endowed_flag"
      expr: endowed_flag
      comment: "Indicates whether the fund is endowment-funded. Used to distinguish recurring endowment income from one-time allocations."
    - name: "renewable_flag"
      expr: renewable_flag
      comment: "Indicates whether the fund supports renewable awards. Used for multi-year aid commitment planning."
    - name: "disbursement_method"
      expr: disbursement_method
      comment: "Method by which the fund is disbursed (e.g., direct deposit, check, credit to account). Operational efficiency dimension."
    - name: "reporting_category"
      expr: reporting_category
      comment: "Regulatory or institutional reporting category for the fund. Used for FISAP, IPEDS, and other compliance reports."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the fund became effective. Used to analyze fund portfolio growth and vintage composition."
  measures:
    - name: "total_annual_allocation_amount"
      expr: SUM(CAST(annual_allocation_amount AS DOUBLE))
      comment: "Total annual allocation across all aid funds. Measures total institutional and external aid budget available for packaging."
    - name: "total_remaining_balance_amount"
      expr: SUM(CAST(remaining_balance_amount AS DOUBLE))
      comment: "Total remaining unawarded balance across all funds. Tracks undeployed aid capacity and budget utilization gaps."
    - name: "total_maximum_award_amount"
      expr: SUM(CAST(maximum_award_amount AS DOUBLE))
      comment: "Sum of maximum award amounts across all funds. Represents the upper bound of per-student award capacity in the fund portfolio."
    - name: "avg_annual_allocation_amount"
      expr: AVG(CAST(annual_allocation_amount AS DOUBLE))
      comment: "Average annual allocation per fund. Benchmarks fund size and informs portfolio diversification decisions."
    - name: "avg_gpa_requirement"
      expr: AVG(CAST(gpa_requirement AS DOUBLE))
      comment: "Average GPA requirement across merit-based funds. Tracks academic standard thresholds in the scholarship portfolio."
    - name: "avg_payout_rate"
      expr: AVG(CAST(payout_rate AS DOUBLE))
      comment: "Average endowment payout rate across endowed funds. Key metric for endowment sustainability and spending policy compliance."
    - name: "fund_utilization_rate"
      expr: ROUND(100.0 * (SUM(CAST(annual_allocation_amount AS DOUBLE)) - SUM(CAST(remaining_balance_amount AS DOUBLE))) / NULLIF(SUM(CAST(annual_allocation_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of annual fund allocation that has been awarded. Measures how effectively the institution is deploying available aid resources."
    - name: "active_fund_count"
      expr: COUNT(CASE WHEN fund_status = 'Active' THEN 1 END)
      comment: "Number of currently active aid funds. Tracks fund portfolio size and availability for packaging."
    - name: "endowed_fund_count"
      expr: COUNT(CASE WHEN endowed_flag = TRUE THEN 1 END)
      comment: "Number of endowment-funded aid funds. Measures the institution's endowed aid capacity and donor-funded sustainability."
    - name: "avg_matching_percentage"
      expr: AVG(CAST(matching_percentage AS DOUBLE))
      comment: "Average matching percentage for funds with matching requirements. Used to assess leverage of external matching contributions."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_award_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Award package metrics covering total aid awarded, grant/loan/scholarship/work-study composition, unmet need, overaward detection, and packaging methodology. Core executive dashboard layer for financial aid strategy, affordability, and compliance oversight."
  source: "`education_ecm`.`aid`.`award_package`"
  dimensions:
    - name: "package_status"
      expr: package_status
      comment: "Current status of the award package (e.g., packaged, offered, accepted, revised). Primary pipeline stage dimension."
    - name: "packaging_methodology"
      expr: packaging_methodology
      comment: "Methodology used to construct the package (e.g., federal, institutional, hybrid). Used to analyze packaging strategy effectiveness."
    - name: "dependency_status"
      expr: dependency_status
      comment: "Student dependency status (dependent, independent). Drives EFC calculation and aid eligibility rules."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Student enrollment status at time of packaging (full-time, part-time). Affects COA and award eligibility."
    - name: "housing_status"
      expr: housing_status
      comment: "Student housing status (on-campus, off-campus, with parent). Affects COA budget and aid packaging."
    - name: "pell_eligible_flag"
      expr: pell_eligible_flag
      comment: "Indicates Pell Grant eligibility. Key segmentation for need-based aid analysis and federal program reporting."
    - name: "sap_status"
      expr: sap_status
      comment: "Satisfactory Academic Progress status at time of packaging. Tracks compliance with federal aid eligibility requirements."
    - name: "overaward_detected_flag"
      expr: overaward_detected_flag
      comment: "Indicates an overaward condition was detected. Critical compliance flag for federal aid regulatory adherence."
    - name: "professional_judgment_applied_flag"
      expr: professional_judgment_applied_flag
      comment: "Indicates a professional judgment was applied to the package. Tracks discretionary packaging decisions for audit purposes."
    - name: "packaging_date_month"
      expr: DATE_TRUNC('MONTH', packaging_date)
      comment: "Month the package was created. Used to track packaging throughput and early vs. late packaging trends."
  measures:
    - name: "total_awarded_amount"
      expr: SUM(CAST(total_awarded_amount AS DOUBLE))
      comment: "Total aid awarded across all packages. Primary measure of institutional aid investment and student financial support."
    - name: "total_grant_amount"
      expr: SUM(CAST(total_grant_amount AS DOUBLE))
      comment: "Total grant aid awarded. Measures free-money aid investment and institutional commitment to access."
    - name: "total_loan_amount"
      expr: SUM(CAST(total_loan_amount AS DOUBLE))
      comment: "Total loan aid included in packages. Tracks student debt load and self-help aid reliance."
    - name: "total_scholarship_amount"
      expr: SUM(CAST(total_scholarship_amount AS DOUBLE))
      comment: "Total scholarship aid awarded. Measures merit and donor-funded scholarship investment."
    - name: "total_work_study_amount"
      expr: SUM(CAST(total_work_study_amount AS DOUBLE))
      comment: "Total work-study aid included in packages. Tracks employment-based aid allocation."
    - name: "total_unmet_need_amount"
      expr: SUM(CAST(unmet_need_amount AS DOUBLE))
      comment: "Total unmet financial need across all packages. Critical affordability metric — high unmet need signals enrollment risk and access gaps."
    - name: "total_overaward_amount"
      expr: SUM(CAST(overaward_amount AS DOUBLE))
      comment: "Total overaward amount detected across packages. Compliance risk metric — overawards must be resolved to maintain federal program eligibility."
    - name: "avg_efc_amount"
      expr: AVG(CAST(efc_amount AS DOUBLE))
      comment: "Average Expected Family Contribution per package. Benchmarks student financial capacity and need-based aid targeting."
    - name: "avg_unmet_need_amount"
      expr: AVG(CAST(unmet_need_amount AS DOUBLE))
      comment: "Average unmet financial need per package. Tracks affordability gap at the individual student level."
    - name: "avg_pell_lifetime_eligibility_used_percent"
      expr: AVG(CAST(pell_lifetime_eligibility_used_percent AS DOUBLE))
      comment: "Average Pell Lifetime Eligibility Used (LEU) percentage across packaged students. Monitors Pell exhaustion risk in the enrolled population."
    - name: "grant_to_total_aid_ratio"
      expr: ROUND(100.0 * SUM(CAST(total_grant_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_awarded_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total aid composed of grants. Measures aid quality — higher grant ratios indicate better affordability and lower student debt burden."
    - name: "loan_to_total_aid_ratio"
      expr: ROUND(100.0 * SUM(CAST(total_loan_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_awarded_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total aid composed of loans. Tracks student debt reliance in the aid mix — a key affordability and access indicator."
    - name: "overaward_package_count"
      expr: COUNT(CASE WHEN overaward_detected_flag = TRUE THEN 1 END)
      comment: "Number of packages with a detected overaward condition. Compliance monitoring metric for federal aid program integrity."
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total number of award packages created. Baseline volume metric for packaging throughput and year-over-year comparison."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_disbursement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aid disbursement execution metrics covering disbursed amounts, net disbursements, origination fees, hold rates, late disbursements, and Title IV eligibility. Used by financial aid operations and finance leadership to monitor cash flow, compliance, and disbursement pipeline health."
  source: "`education_ecm`.`aid`.`disbursement`"
  dimensions:
    - name: "disbursement_status"
      expr: disbursement_status
      comment: "Current status of the disbursement (e.g., pending, processed, cancelled, returned). Primary pipeline stage dimension."
    - name: "disbursement_method"
      expr: disbursement_method
      comment: "Method of disbursement (e.g., EFT, check, credit to account). Used for operational efficiency and channel analysis."
    - name: "channel"
      expr: channel
      comment: "Disbursement channel. Used to analyze delivery method mix and operational cost."
    - name: "title_iv_eligible_flag"
      expr: title_iv_eligible_flag
      comment: "Indicates whether the disbursement is Title IV eligible. Critical compliance dimension for federal aid program reporting."
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates whether the disbursement is on hold. Used to monitor disbursement bottlenecks and student account issues."
    - name: "late_disbursement_flag"
      expr: late_disbursement_flag
      comment: "Indicates a late disbursement condition. Tracks compliance risk and student financial hardship exposure."
    - name: "anticipated_disbursement_flag"
      expr: anticipated_disbursement_flag
      comment: "Indicates the disbursement is anticipated (not yet processed). Used to distinguish actual vs. projected cash flow."
    - name: "sap_status_at_disbursement"
      expr: sap_status_at_disbursement
      comment: "SAP status of the student at the time of disbursement. Used to verify compliance with federal eligibility requirements at point of payment."
    - name: "disbursement_date_month"
      expr: DATE_TRUNC('MONTH', disbursement_date)
      comment: "Month of disbursement. Used for cash flow trending and disbursement cycle analysis."
    - name: "scheduled_disbursement_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_disbursement_date)
      comment: "Month the disbursement was scheduled. Used to compare scheduled vs. actual disbursement timing."
  measures:
    - name: "total_disbursed_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross amount disbursed to students. Primary cash flow metric for financial aid operations and finance reporting."
    - name: "total_net_disbursement_amount"
      expr: SUM(CAST(net_disbursement_amount AS DOUBLE))
      comment: "Total net disbursement amount after fees. Measures actual student-received aid value net of origination fees."
    - name: "total_origination_fee_amount"
      expr: SUM(CAST(origination_fee_amount AS DOUBLE))
      comment: "Total origination fees deducted from disbursements. Tracks student loan cost burden and fee revenue."
    - name: "avg_disbursed_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average disbursement amount per transaction. Benchmarks disbursement size and detects anomalies."
    - name: "total_disbursements"
      expr: COUNT(1)
      comment: "Total number of disbursement transactions. Baseline volume metric for operational throughput monitoring."
    - name: "held_disbursements"
      expr: COUNT(CASE WHEN hold_flag = TRUE THEN 1 END)
      comment: "Number of disbursements currently on hold. Tracks operational bottlenecks and student account issues requiring resolution."
    - name: "late_disbursements"
      expr: COUNT(CASE WHEN late_disbursement_flag = TRUE THEN 1 END)
      comment: "Number of late disbursements. Compliance risk metric — late disbursements may violate federal timing requirements and cause student hardship."
    - name: "hold_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hold_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disbursements on hold. Operational health metric — high hold rates indicate systemic issues in student account or eligibility processing."
    - name: "late_disbursement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN late_disbursement_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disbursements that were late. Federal compliance metric — late disbursement rates above thresholds trigger regulatory scrutiny."
    - name: "net_to_gross_disbursement_ratio"
      expr: ROUND(100.0 * SUM(CAST(net_disbursement_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Ratio of net to gross disbursement amount. Measures the fee impact on student-received aid — lower ratios indicate higher fee burden."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_sap_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Satisfactory Academic Progress (SAP) evaluation metrics covering GPA, completion rates, credit progress, appeal outcomes, and eligibility status. Used by financial aid directors and academic affairs to monitor federal compliance, student retention risk, and appeal workload."
  source: "`education_ecm`.`aid`.`sap_evaluation`"
  dimensions:
    - name: "overall_sap_status"
      expr: overall_sap_status
      comment: "Overall SAP determination (e.g., satisfactory, warning, suspension, probation). Primary compliance status dimension."
    - name: "financial_aid_eligibility_status"
      expr: financial_aid_eligibility_status
      comment: "Financial aid eligibility status resulting from SAP evaluation. Directly determines whether aid can be disbursed."
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of SAP evaluation (e.g., annual, mid-year, appeal). Used to segment routine vs. exception evaluations."
    - name: "qualitative_measure_status"
      expr: qualitative_measure_status
      comment: "Status of the qualitative (GPA) SAP measure. Used to identify students failing the GPA standard."
    - name: "quantitative_measure_status"
      expr: quantitative_measure_status
      comment: "Status of the quantitative (completion rate) SAP measure. Used to identify students failing the pace standard."
    - name: "maximum_timeframe_status"
      expr: maximum_timeframe_status
      comment: "Status of the maximum timeframe SAP measure. Identifies students approaching or exceeding the 150% credit limit."
    - name: "appeal_submitted_flag"
      expr: appeal_submitted_flag
      comment: "Indicates whether a SAP appeal was submitted. Used to track appeal volume and workload."
    - name: "appeal_decision"
      expr: appeal_decision
      comment: "Outcome of the SAP appeal (e.g., approved, denied). Used to analyze appeal approval rates and policy consistency."
    - name: "academic_plan_required_flag"
      expr: academic_plan_required_flag
      comment: "Indicates whether an academic plan is required as a condition of reinstatement. Tracks probationary aid conditions."
    - name: "evaluation_date_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of SAP evaluation. Used to track evaluation cycle timing and volume trends."
  measures:
    - name: "total_evaluations"
      expr: COUNT(1)
      comment: "Total number of SAP evaluations conducted. Baseline volume metric for compliance workload and cycle monitoring."
    - name: "avg_cumulative_gpa"
      expr: AVG(CAST(cumulative_gpa AS DOUBLE))
      comment: "Average cumulative GPA across evaluated students. Tracks academic performance trends in the aid-receiving population."
    - name: "avg_completion_rate_percentage"
      expr: AVG(CAST(completion_rate_percentage AS DOUBLE))
      comment: "Average credit completion rate (pace) across evaluated students. Measures student progress toward degree completion."
    - name: "avg_cumulative_credits_attempted"
      expr: AVG(CAST(cumulative_credits_attempted AS DOUBLE))
      comment: "Average cumulative credits attempted per student. Used to assess academic load and maximum timeframe risk."
    - name: "avg_cumulative_credits_earned"
      expr: AVG(CAST(cumulative_credits_earned AS DOUBLE))
      comment: "Average cumulative credits earned per student. Tracks academic progress and degree completion trajectory."
    - name: "sap_suspension_count"
      expr: COUNT(CASE WHEN overall_sap_status = 'Suspension' THEN 1 END)
      comment: "Number of students on SAP suspension (aid ineligible). Critical compliance and retention risk metric."
    - name: "appeal_submitted_count"
      expr: COUNT(CASE WHEN appeal_submitted_flag = TRUE THEN 1 END)
      comment: "Number of SAP appeals submitted. Tracks appeal workload and student reinstatement demand."
    - name: "appeal_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_decision = 'Approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN appeal_submitted_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of submitted SAP appeals that were approved. Measures appeal policy consistency and reinstatement rate."
    - name: "sap_failure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_sap_status IN ('Suspension', 'Warning') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of evaluations resulting in SAP warning or suspension. Key compliance and student success indicator — high rates signal systemic academic risk."
    - name: "avg_credits_to_max_timeframe_ratio"
      expr: ROUND(100.0 * AVG(CAST(cumulative_credits_attempted AS DOUBLE)) / NULLIF(AVG(CAST(maximum_credits_allowed AS DOUBLE)), 0), 2)
      comment: "Average ratio of credits attempted to maximum allowed credits. Measures how close the student population is to exhausting maximum timeframe eligibility."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_loan_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Student loan origination and lifecycle metrics covering gross/net loan amounts, origination fees, interest rates, aggregate balances, and compliance milestones. Used by financial aid directors and compliance officers to monitor federal loan program execution, student debt levels, and regulatory reporting."
  source: "`education_ecm`.`aid`.`loan_record`"
  dimensions:
    - name: "loan_type_code"
      expr: loan_type_code
      comment: "Federal loan type code (e.g., SUB, UNSUB, PLUS, GradPLUS). Primary segmentation for loan program analysis."
    - name: "loan_status"
      expr: loan_status
      comment: "Current status of the loan record (e.g., originated, disbursed, cancelled, returned). Pipeline stage dimension."
    - name: "borrower_type"
      expr: borrower_type
      comment: "Type of borrower (e.g., student, parent). Used to segment student vs. parent PLUS loan volume."
    - name: "subsidized_indicator"
      expr: subsidized_indicator
      comment: "Indicates whether the loan is subsidized. Used to track subsidized vs. unsubsidized loan mix and interest subsidy cost."
    - name: "dependency_status"
      expr: dependency_status
      comment: "Student dependency status at loan origination. Affects annual and aggregate loan limits."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Student enrollment status at loan origination. Required for federal loan eligibility and certification."
    - name: "grade_level"
      expr: grade_level
      comment: "Student grade level at loan origination. Determines annual loan limits under federal regulations."
    - name: "loan_servicer_code"
      expr: loan_servicer_code
      comment: "Code identifying the federal loan servicer. Used for servicer performance analysis and transfer tracking."
    - name: "origination_date_month"
      expr: DATE_TRUNC('MONTH', origination_date)
      comment: "Month of loan origination. Used for loan volume trending and disbursement cycle analysis."
  measures:
    - name: "total_gross_loan_amount"
      expr: SUM(CAST(gross_loan_amount AS DOUBLE))
      comment: "Total gross loan amount originated. Primary measure of federal loan program volume and student debt generation."
    - name: "total_net_loan_amount"
      expr: SUM(CAST(net_loan_amount AS DOUBLE))
      comment: "Total net loan amount after origination fees. Measures actual student-received loan proceeds."
    - name: "total_origination_fee_amount"
      expr: SUM(CAST(origination_fee_amount AS DOUBLE))
      comment: "Total origination fees charged across all loans. Tracks fee burden on student borrowers."
    - name: "total_aggregate_loan_balance"
      expr: SUM(CAST(aggregate_loan_balance AS DOUBLE))
      comment: "Total aggregate loan balance across all borrowers. Measures cumulative student debt exposure in the portfolio."
    - name: "avg_gross_loan_amount"
      expr: AVG(CAST(gross_loan_amount AS DOUBLE))
      comment: "Average gross loan amount per origination. Benchmarks borrowing levels and detects over-borrowing patterns."
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate across originated loans. Monitors student debt cost and loan program mix."
    - name: "total_loan_originations"
      expr: COUNT(1)
      comment: "Total number of loan originations. Baseline volume metric for federal loan program activity."
    - name: "net_to_gross_loan_ratio"
      expr: ROUND(100.0 * SUM(CAST(net_loan_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_loan_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of net to gross loan amount. Measures origination fee impact — lower ratios indicate higher fee burden on student borrowers."
    - name: "aggregate_limit_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(aggregate_loan_balance AS DOUBLE)) / NULLIF(SUM(CAST(aggregate_loan_limit AS DOUBLE)), 0), 2)
      comment: "Percentage of aggregate loan limit utilized. Tracks how close borrowers are to federal lifetime borrowing caps — critical for loan eligibility monitoring."
    - name: "mpn_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN mpn_signed_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of loan originations with a signed Master Promissory Note. Federal compliance metric — loans cannot disburse without a valid MPN."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FAFSA verification process metrics covering completion rates, correction requirements, professional judgment usage, and conflicting information detection. Used by financial aid compliance officers to monitor verification workload, turnaround times, and regulatory adherence."
  source: "`education_ecm`.`aid`.`verification`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Current status of the verification process (e.g., selected, in-progress, complete, waived). Primary pipeline stage dimension."
    - name: "selection_source"
      expr: selection_source
      comment: "Source of verification selection (e.g., CPS, institutional). Used to distinguish federally-mandated vs. institutional verification."
    - name: "tracking_group"
      expr: tracking_group
      comment: "Federal verification tracking group (V1-V6). Determines which documents are required for verification completion."
    - name: "income_verification_method"
      expr: income_verification_method
      comment: "Method used to verify income (e.g., IRS DRT, tax transcript, signed return). Used to analyze verification method mix and efficiency."
    - name: "correction_required_indicator"
      expr: correction_required_indicator
      comment: "Indicates whether a FAFSA correction is required based on verification findings. Tracks correction workload and data quality."
    - name: "conflicting_information_indicator"
      expr: conflicting_information_indicator
      comment: "Indicates conflicting information was found during verification. Compliance flag requiring resolution before aid disbursement."
    - name: "professional_judgment_indicator"
      expr: professional_judgment_indicator
      comment: "Indicates a professional judgment was applied during verification. Tracks discretionary decisions for audit and compliance."
    - name: "dependency_override_indicator"
      expr: dependency_override_indicator
      comment: "Indicates a dependency override was granted. Tracks special circumstance determinations affecting aid eligibility."
    - name: "selection_date_month"
      expr: DATE_TRUNC('MONTH', selection_date)
      comment: "Month the student was selected for verification. Used to analyze verification selection volume trends."
    - name: "completion_date_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month verification was completed. Used to track verification throughput and seasonal processing patterns."
  measures:
    - name: "total_verifications"
      expr: COUNT(1)
      comment: "Total number of verification cases. Baseline volume metric for compliance workload monitoring."
    - name: "completed_verifications"
      expr: COUNT(CASE WHEN verification_status = 'Complete' THEN 1 END)
      comment: "Number of completed verification cases. Tracks verification throughput and pipeline clearance rate."
    - name: "verification_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Complete' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verification cases completed. Operational efficiency metric — low completion rates delay aid disbursement and create compliance risk."
    - name: "correction_required_count"
      expr: COUNT(CASE WHEN correction_required_indicator = TRUE THEN 1 END)
      comment: "Number of verifications requiring FAFSA corrections. Tracks data quality issues and correction workload."
    - name: "conflicting_information_count"
      expr: COUNT(CASE WHEN conflicting_information_indicator = TRUE THEN 1 END)
      comment: "Number of verifications with conflicting information. Compliance risk metric — unresolved conflicts block aid disbursement."
    - name: "professional_judgment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN professional_judgment_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verifications involving a professional judgment. Tracks discretionary decision volume for audit and policy review."
    - name: "dependency_override_count"
      expr: COUNT(CASE WHEN dependency_override_indicator = TRUE THEN 1 END)
      comment: "Number of dependency overrides granted during verification. Tracks special circumstance determinations affecting aid eligibility."
    - name: "correction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN correction_required_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verifications requiring FAFSA corrections. High correction rates indicate systemic data quality issues in FAFSA submissions."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`aid_veteran_benefit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Veteran education benefit metrics covering tuition payments, housing allowances, book stipends, Yellow Ribbon contributions, entitlement utilization, and certification compliance. Used by School Certifying Officials (SCOs) and financial aid leadership to monitor VA benefit delivery, compliance, and veteran student support."
  source: "`education_ecm`.`aid`.`veteran_benefit`"
  dimensions:
    - name: "benefit_chapter"
      expr: benefit_chapter
      comment: "VA benefit chapter (e.g., Chapter 33 Post-9/11, Chapter 30 Montgomery GI Bill). Primary segmentation for veteran benefit program analysis."
    - name: "benefit_status"
      expr: benefit_status
      comment: "Current status of the veteran benefit (e.g., active, pending, terminated). Used to monitor benefit pipeline and eligibility."
    - name: "payment_status"
      expr: payment_status
      comment: "Status of VA payment (e.g., paid, pending, returned). Used to track payment execution and reconciliation."
    - name: "yellow_ribbon_participant_flag"
      expr: yellow_ribbon_participant_flag
      comment: "Indicates Yellow Ribbon Program participation. Used to track institutional Yellow Ribbon commitment and VA matching."
    - name: "vocational_rehab_flag"
      expr: vocational_rehab_flag
      comment: "Indicates Vocational Rehabilitation and Employment (VR&E) benefit usage. Used to segment Chapter 31 beneficiaries."
    - name: "kicker_eligible_flag"
      expr: kicker_eligible_flag
      comment: "Indicates eligibility for a kicker (college fund) supplement. Used to identify enhanced benefit recipients."
    - name: "certification_date_month"
      expr: DATE_TRUNC('MONTH', certification_date)
      comment: "Month of VA enrollment certification. Used to track certification volume and timing compliance."
    - name: "eligibility_begin_date_year"
      expr: DATE_TRUNC('YEAR', eligibility_begin_date)
      comment: "Year veteran benefit eligibility began. Used to analyze benefit cohort vintage and entitlement exhaustion trends."
  measures:
    - name: "total_tuition_and_fees_paid_to_school"
      expr: SUM(CAST(tuition_and_fees_paid_to_school AS DOUBLE))
      comment: "Total tuition and fees paid directly to the institution by the VA. Primary revenue metric for veteran benefit program financial impact."
    - name: "total_monthly_housing_allowance_amount"
      expr: SUM(CAST(monthly_housing_allowance_amount AS DOUBLE))
      comment: "Total monthly housing allowance (MHA) paid to veteran students. Measures VA housing support investment in the student population."
    - name: "total_book_stipend_amount"
      expr: SUM(CAST(book_stipend_amount AS DOUBLE))
      comment: "Total book and supply stipend paid to veteran students. Tracks VA support for educational materials costs."
    - name: "total_yellow_ribbon_institution_contribution"
      expr: SUM(CAST(yellow_ribbon_institution_contribution AS DOUBLE))
      comment: "Total institutional Yellow Ribbon contribution. Measures the institution's financial commitment to veteran students beyond VA coverage."
    - name: "total_yellow_ribbon_va_contribution"
      expr: SUM(CAST(yellow_ribbon_va_contribution AS DOUBLE))
      comment: "Total VA Yellow Ribbon matching contribution. Tracks federal matching funds leveraged through the Yellow Ribbon Program."
    - name: "avg_benefit_percentage"
      expr: AVG(CAST(benefit_percentage AS DOUBLE))
      comment: "Average VA benefit percentage across certified students. Measures entitlement utilization intensity in the veteran population."
    - name: "avg_remaining_entitlement_months"
      expr: AVG(CAST(remaining_entitlement_months AS DOUBLE))
      comment: "Average remaining entitlement months across veteran students. Tracks benefit exhaustion risk and time-to-completion alignment."
    - name: "avg_certified_credit_hours"
      expr: AVG(CAST(certified_credit_hours AS DOUBLE))
      comment: "Average credit hours certified per veteran student. Used to verify enrollment intensity and housing allowance accuracy."
    - name: "total_veteran_benefit_recipients"
      expr: COUNT(1)
      comment: "Total number of veteran benefit certifications. Baseline volume metric for veteran student population monitoring."
    - name: "yellow_ribbon_participation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN yellow_ribbon_participant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of veteran benefit recipients participating in the Yellow Ribbon Program. Measures institutional commitment to fully funding veteran education costs."
    - name: "total_kicker_monthly_amount"
      expr: SUM(CAST(kicker_monthly_amount AS DOUBLE))
      comment: "Total kicker (college fund) monthly supplement amounts. Tracks enhanced benefit payments to eligible veteran students."
$$;