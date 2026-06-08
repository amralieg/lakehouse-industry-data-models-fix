-- Metric views for domain: recruitment | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 22:27:45

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`recruitment_submittal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core recruitment funnel metrics tracking submittal volume, conversion to placement, offer outcomes, and rate competitiveness. Enables pipeline health monitoring and recruiter performance benchmarking."
  source: "`staffing_hr_ecm_v1`.`recruitment`.`submittal`"
  dimensions:
    - name: "submittal_status"
      expr: submittal_status
      comment: "Current status of the submittal (e.g., Submitted, Interviewing, Offered, Placed, Rejected) for funnel stage analysis."
    - name: "placement_type"
      expr: placement_type
      comment: "Type of placement (e.g., Temporary, Permanent, Contract-to-Hire) for workforce mix analysis."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model (e.g., MSP, RPO, Direct) to segment submittal performance by program type."
    - name: "interview_type"
      expr: interview_type
      comment: "Type of interview associated with the submittal for process analysis."
    - name: "submittal_source"
      expr: submittal_source
      comment: "Source channel that generated the submittal (e.g., ATS, VMS, Direct) for sourcing effectiveness analysis."
    - name: "rate_type"
      expr: rate_type
      comment: "Rate type (e.g., Hourly, Daily, Annual) for compensation benchmarking segmentation."
    - name: "is_redeployment"
      expr: is_redeployment
      comment: "Flags whether the submittal is a redeployment of an existing worker, supporting redeployment rate tracking."
    - name: "is_backfill"
      expr: is_backfill
      comment: "Flags whether the submittal is a backfill requisition, supporting demand pattern analysis."
    - name: "submittal_month"
      expr: DATE_TRUNC('MONTH', submittal_date)
      comment: "Month of submittal for trend and seasonality analysis."
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Reason code for submittal rejection to identify systemic disqualification patterns."
  measures:
    - name: "total_submittals"
      expr: COUNT(1)
      comment: "Total number of candidate submittals. Baseline pipeline volume metric used to assess recruiter throughput and demand coverage."
    - name: "submittals_converted_to_placement"
      expr: COUNT(CASE WHEN converted_to_placement = TRUE THEN 1 END)
      comment: "Number of submittals that resulted in a confirmed placement. Directly measures recruitment effectiveness and revenue generation."
    - name: "submittal_to_placement_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN converted_to_placement = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submittals that converted to placements. A primary KPI for recruiter quality and pipeline efficiency — low rates signal candidate-job fit issues or process friction."
    - name: "offer_acceptance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN offer_accepted_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN offer_extended_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of extended offers that were accepted. Indicates compensation competitiveness and candidate experience quality — a declining rate signals rate or process issues."
    - name: "avg_proposed_bill_rate"
      expr: AVG(CAST(proposed_bill_rate AS DOUBLE))
      comment: "Average proposed bill rate across submittals. Used by finance and account management to benchmark pricing and margin targets."
    - name: "avg_proposed_pay_rate"
      expr: AVG(CAST(proposed_pay_rate AS DOUBLE))
      comment: "Average proposed pay rate across submittals. Used to assess compensation competitiveness and gross margin spread."
    - name: "avg_bill_pay_spread"
      expr: AVG(CAST(proposed_bill_rate AS DOUBLE) - CAST(proposed_pay_rate AS DOUBLE))
      comment: "Average gross margin spread (bill rate minus pay rate) per submittal. A direct proxy for per-placement profitability and pricing health."
    - name: "submittals_with_rtr"
      expr: COUNT(CASE WHEN rtr_flag = TRUE THEN 1 END)
      comment: "Number of submittals with Right-to-Represent confirmation obtained. Measures compliance with RTR protocols, which reduces legal and competitive risk."
    - name: "rtr_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rtr_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submittals with RTR obtained. A compliance KPI — low rates expose the firm to candidate double-submission disputes and client relationship risk."
    - name: "avg_qos_rating"
      expr: AVG(CAST(qos_rating AS DOUBLE))
      comment: "Average quality-of-service rating on submittals. Tracks client satisfaction with candidate quality at the submittal stage, informing recruiter coaching and process improvement."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`recruitment_hiring_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hiring outcome metrics covering offer extension, acceptance, time-to-fill, bill/pay rate decisions, and rejection analysis. Enables executive visibility into placement yield and workforce cost."
  source: "`staffing_hr_ecm_v1`.`recruitment`.`hiring_decision`"
  dimensions:
    - name: "decision_status"
      expr: decision_status
      comment: "Current status of the hiring decision (e.g., Pending, Approved, Rejected, Offer Extended) for funnel stage analysis."
    - name: "decision_type"
      expr: decision_type
      comment: "Type of hiring decision (e.g., Direct Hire, Temp-to-Perm, Contract) for workforce mix analysis."
    - name: "placement_type"
      expr: placement_type
      comment: "Placement type associated with the hiring decision for program-level performance segmentation."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model (MSP, RPO, Direct) to segment hiring outcomes by program type."
    - name: "sourcing_channel"
      expr: sourcing_channel
      comment: "Channel through which the candidate was sourced, enabling ROI analysis by sourcing investment."
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA classification (Exempt/Non-Exempt) for compliance and workforce cost segmentation."
    - name: "rejection_reason_category"
      expr: rejection_reason_category
      comment: "High-level category of rejection reason to identify systemic hiring barriers."
    - name: "is_temp_to_perm"
      expr: is_temp_to_perm
      comment: "Flags temp-to-perm conversions for tracking conversion pipeline value."
    - name: "is_backfill"
      expr: is_backfill
      comment: "Flags backfill positions to distinguish organic growth demand from attrition-driven demand."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month of hiring decision for trend analysis and capacity planning."
    - name: "bgc_status"
      expr: bgc_status
      comment: "Background check status at time of decision, used for compliance and onboarding readiness tracking."
  measures:
    - name: "total_hiring_decisions"
      expr: COUNT(1)
      comment: "Total hiring decisions made. Baseline volume metric for recruitment throughput and capacity planning."
    - name: "offers_extended"
      expr: COUNT(CASE WHEN offer_extended = TRUE THEN 1 END)
      comment: "Number of offers extended to candidates. Measures the output of the interview-to-offer stage of the funnel."
    - name: "offers_accepted"
      expr: COUNT(CASE WHEN offer_accepted = TRUE THEN 1 END)
      comment: "Number of offers accepted by candidates. A direct measure of placement yield and compensation competitiveness."
    - name: "offer_acceptance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN offer_accepted = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN offer_extended = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of extended offers accepted. A critical KPI — declining rates signal compensation gaps, candidate experience issues, or competitive market pressure."
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate on hiring decisions. Used by finance to track revenue per placement and pricing strategy effectiveness."
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate on hiring decisions. Used to monitor compensation spend and gross margin."
    - name: "avg_gross_margin_spread"
      expr: AVG(CAST(bill_rate AS DOUBLE) - CAST(pay_rate AS DOUBLE))
      comment: "Average gross margin spread (bill minus pay) per hiring decision. A direct profitability indicator at the placement level."
    - name: "avg_qos_score"
      expr: AVG(CAST(qos_score AS DOUBLE))
      comment: "Average quality-of-service score on hiring decisions. Tracks client satisfaction with the hiring process and candidate quality."
    - name: "fall_off_risk_count"
      expr: COUNT(CASE WHEN fall_off_risk_flag = TRUE THEN 1 END)
      comment: "Number of hiring decisions flagged as fall-off risk. Enables proactive intervention to protect placed revenue."
    - name: "fall_off_risk_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fall_off_risk_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of hiring decisions with fall-off risk flag. A leading indicator of placement stability and revenue at risk."
    - name: "temp_to_perm_conversion_count"
      expr: COUNT(CASE WHEN is_temp_to_perm = TRUE THEN 1 END)
      comment: "Number of temp-to-perm conversions. Tracks a high-value revenue event and measures the effectiveness of the temp-to-perm pipeline."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`recruitment_candidate_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Candidate screening quality and throughput metrics including pass rates, score distributions, RTR compliance, and advancement to submittal. Supports recruiter quality management and process optimization."
  source: "`staffing_hr_ecm_v1`.`recruitment`.`candidate_screening`"
  dimensions:
    - name: "screening_status"
      expr: screening_status
      comment: "Current status of the screening record (e.g., Scheduled, Completed, Cancelled) for pipeline stage analysis."
    - name: "screening_type"
      expr: screening_type
      comment: "Type of screening conducted (e.g., Phone, Video, In-Person, Skills Assessment) for process mix analysis."
    - name: "screening_channel"
      expr: screening_channel
      comment: "Channel used for screening (e.g., Phone, Video, In-Person) to assess channel effectiveness and cost."
    - name: "screening_source"
      expr: screening_source
      comment: "Source that generated the screening (e.g., Job Board, Referral, Direct) for sourcing quality analysis."
    - name: "outcome"
      expr: outcome
      comment: "Screening outcome (e.g., Pass, Fail, Pending) for funnel conversion analysis."
    - name: "disqualification_category"
      expr: disqualification_category
      comment: "High-level category of disqualification reason to identify systemic candidate quality gaps."
    - name: "placement_type"
      expr: placement_type
      comment: "Placement type associated with the screening for program-level quality segmentation."
    - name: "is_rescreening"
      expr: is_rescreening
      comment: "Flags re-screening events to measure rework volume and process efficiency."
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_date)
      comment: "Month of screening for trend and capacity analysis."
    - name: "screener_role"
      expr: screener_role
      comment: "Role of the screener (e.g., Recruiter, Hiring Manager) for quality attribution analysis."
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of candidate screenings conducted. Baseline throughput metric for recruiter capacity and pipeline volume."
    - name: "screenings_advanced_to_submittal"
      expr: COUNT(CASE WHEN advanced_to_submittal = TRUE THEN 1 END)
      comment: "Number of screenings that advanced to a formal submittal. Measures screening-to-submittal conversion, a key funnel efficiency indicator."
    - name: "screening_to_submittal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN advanced_to_submittal = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings that advanced to submittal. A quality yield metric — low rates indicate poor candidate sourcing quality or misaligned job requirements."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average candidate screening score. Tracks the quality of the candidate pool entering the pipeline and supports threshold calibration."
    - name: "avg_score_vs_threshold"
      expr: AVG(CAST(overall_score AS DOUBLE) - CAST(passing_threshold AS DOUBLE))
      comment: "Average margin between candidate score and passing threshold. Positive values indicate a healthy candidate pool; negative values signal sourcing quality issues."
    - name: "rtr_obtained_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rtr_obtained = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings where RTR was obtained. A compliance KPI protecting the firm from double-submission disputes and legal exposure."
    - name: "eeoc_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN eeoc_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings conducted in EEOC-compliant manner. A regulatory compliance KPI with direct legal and reputational risk implications."
    - name: "rescreening_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_rescreening = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings that are re-screenings. High rates indicate process rework, increasing cost-per-hire and time-to-fill."
    - name: "avg_pay_rate_expectation"
      expr: AVG(CAST(pay_rate_expectation AS DOUBLE))
      comment: "Average candidate pay rate expectation at screening. Used to assess alignment between candidate compensation expectations and job order rate ranges."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`recruitment_interview`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interview process quality and outcome metrics including completion rates, candidate ratings, reschedule frequency, and hire recommendations. Supports interview process optimization and client satisfaction management."
  source: "`staffing_hr_ecm_v1`.`recruitment`.`interview`"
  dimensions:
    - name: "interview_status"
      expr: interview_status
      comment: "Current status of the interview (e.g., Scheduled, Completed, Cancelled, No-Show) for process health monitoring."
    - name: "interview_type"
      expr: interview_type
      comment: "Type of interview (e.g., Phone Screen, Technical, Panel, Final) for stage-level quality analysis."
    - name: "format"
      expr: format
      comment: "Interview format (e.g., Video, In-Person, Phone) for channel effectiveness analysis."
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Outcome of the interview (e.g., Advance, Reject, Hold) for funnel conversion analysis."
    - name: "hire_recommendation"
      expr: hire_recommendation
      comment: "Interviewer hire recommendation (e.g., Strong Hire, Hire, No Hire) for quality signal analysis."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model (MSP, RPO, Direct) for program-level interview performance segmentation."
    - name: "is_reschedule"
      expr: is_reschedule
      comment: "Flags rescheduled interviews to measure process disruption and candidate/client reliability."
    - name: "round"
      expr: round
      comment: "Interview round number (e.g., 1st, 2nd, Final) for stage-level funnel analysis."
    - name: "interview_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_timestamp)
      comment: "Month of scheduled interview for trend and capacity planning."
  measures:
    - name: "total_interviews"
      expr: COUNT(1)
      comment: "Total interviews scheduled or conducted. Baseline throughput metric for interview pipeline volume and recruiter activity."
    - name: "interviews_completed"
      expr: COUNT(CASE WHEN interview_status = 'Completed' THEN 1 END)
      comment: "Number of interviews successfully completed. Measures interview process execution effectiveness."
    - name: "interview_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN interview_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scheduled interviews that were completed. Low rates indicate candidate or client reliability issues, increasing cost-per-hire."
    - name: "reschedule_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_reschedule = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interviews that were rescheduled. A process friction KPI — high rates extend time-to-fill and signal coordination inefficiencies."
    - name: "avg_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall candidate rating from interviews. Tracks candidate quality entering the offer stage and supports hiring standard calibration."
    - name: "avg_technical_skills_rating"
      expr: AVG(CAST(technical_skills_rating AS DOUBLE))
      comment: "Average technical skills rating from interviews. Used by account managers and clients to assess candidate technical quality and sourcing effectiveness."
    - name: "avg_communication_rating"
      expr: AVG(CAST(communication_rating AS DOUBLE))
      comment: "Average communication skills rating from interviews. A key soft-skill quality indicator used in candidate quality reporting."
    - name: "avg_culture_fit_rating"
      expr: AVG(CAST(culture_fit_rating AS DOUBLE))
      comment: "Average culture fit rating from interviews. Tracks alignment between candidate profile and client culture, a predictor of placement retention."
    - name: "strong_hire_recommendation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hire_recommendation = 'Strong Hire' THEN 1 END) / NULLIF(COUNT(CASE WHEN interview_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed interviews resulting in a Strong Hire recommendation. A leading indicator of placement yield and candidate pool quality."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`recruitment_req_pipeline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Requisition pipeline velocity and health metrics tracking stage progression, bottlenecks, offer rates, and time-in-stage. Enables operations leaders to identify pipeline stalls and optimize time-to-fill."
  source: "`staffing_hr_ecm_v1`.`recruitment`.`req_pipeline`"
  dimensions:
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Current stage of the requisition pipeline (e.g., Sourcing, Screening, Interview, Offer, Placed) for funnel analysis."
    - name: "pipeline_status"
      expr: pipeline_status
      comment: "Current status of the pipeline record (e.g., Active, On Hold, Closed) for active pipeline management."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model (MSP, RPO, Direct) for program-level pipeline performance segmentation."
    - name: "sourcing_channel"
      expr: sourcing_channel
      comment: "Sourcing channel that generated the pipeline record for ROI and channel effectiveness analysis."
    - name: "placement_type"
      expr: placement_type
      comment: "Placement type for workforce mix and program performance segmentation."
    - name: "worker_type"
      expr: worker_type
      comment: "Worker classification type (e.g., W2, 1099, Corp-to-Corp) for compliance and cost segmentation."
    - name: "rtr_status"
      expr: rtr_status
      comment: "RTR status of the pipeline record for compliance monitoring."
    - name: "is_priority"
      expr: is_priority
      comment: "Flags high-priority requisitions for escalation and resource allocation decisions."
    - name: "is_bottleneck_flag"
      expr: is_bottleneck_flag
      comment: "Flags pipeline records identified as bottlenecks for operational intervention."
    - name: "pipeline_entry_month"
      expr: DATE_TRUNC('MONTH', stage_entry_timestamp)
      comment: "Month the record entered the current pipeline stage for trend and aging analysis."
  measures:
    - name: "total_pipeline_records"
      expr: COUNT(1)
      comment: "Total active pipeline records. Baseline volume metric for pipeline capacity and recruiter workload management."
    - name: "bottleneck_count"
      expr: COUNT(CASE WHEN is_bottleneck_flag = TRUE THEN 1 END)
      comment: "Number of pipeline records flagged as bottlenecks. A critical operational KPI — high counts indicate process stalls that extend time-to-fill and risk client SLA breaches."
    - name: "bottleneck_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_bottleneck_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pipeline records flagged as bottlenecks. Used by operations leaders to assess pipeline health and prioritize intervention."
    - name: "priority_pipeline_count"
      expr: COUNT(CASE WHEN is_priority = TRUE THEN 1 END)
      comment: "Number of high-priority pipeline records. Used for resource allocation and escalation management."
    - name: "aging_alert_count"
      expr: COUNT(CASE WHEN is_aging_alert = TRUE THEN 1 END)
      comment: "Number of pipeline records with aging alerts. Tracks stalled requisitions at risk of SLA breach or client dissatisfaction."
    - name: "avg_offer_bill_rate"
      expr: AVG(CAST(offer_bill_rate AS DOUBLE))
      comment: "Average bill rate at offer stage in the pipeline. Used by finance and account management to track pricing realization versus targets."
    - name: "avg_offer_pay_rate"
      expr: AVG(CAST(offer_pay_rate AS DOUBLE))
      comment: "Average pay rate at offer stage in the pipeline. Used to monitor compensation spend and gross margin at the offer decision point."
    - name: "avg_qos_score"
      expr: AVG(CAST(qos_score AS DOUBLE))
      comment: "Average quality-of-service score across pipeline records. Tracks overall service delivery quality and client satisfaction at the requisition level."
    - name: "placements_from_pipeline"
      expr: COUNT(CASE WHEN hire_date IS NOT NULL THEN 1 END)
      comment: "Number of pipeline records that resulted in a hire. Measures pipeline-to-placement conversion, the ultimate output of the recruitment process."
    - name: "pipeline_to_placement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hire_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pipeline records that converted to a placement. A top-level recruitment effectiveness KPI used in executive dashboards and QBRs."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`recruitment_recruiter_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruiter performance and workload metrics including submittal-to-hire ratios, interview-to-offer ratios, SLA adherence, and assignment throughput. Enables talent delivery leadership to manage recruiter capacity and quality."
  source: "`staffing_hr_ecm_v1`.`recruitment`.`recruiter_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the recruiter assignment (e.g., Active, Filled, Cancelled) for workload and performance analysis."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of recruiter assignment (e.g., Exclusive, Shared, RPO) for performance benchmarking by engagement model."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model (MSP, RPO, Direct) for program-level recruiter performance segmentation."
    - name: "sourcing_strategy"
      expr: sourcing_strategy
      comment: "Sourcing strategy employed by the recruiter for effectiveness analysis by approach."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the assignment for resource allocation and escalation management."
    - name: "is_exclusive_assignment"
      expr: is_exclusive_assignment
      comment: "Flags exclusive recruiter assignments for performance comparison between exclusive and shared models."
    - name: "is_rpo_engagement"
      expr: is_rpo_engagement
      comment: "Flags RPO engagements for program-specific performance tracking."
    - name: "fall_off_risk_flag"
      expr: fall_off_risk_flag
      comment: "Flags assignments at risk of fall-off for proactive revenue protection."
    - name: "assigned_month"
      expr: DATE_TRUNC('MONTH', assigned_date)
      comment: "Month the recruiter was assigned for trend and capacity planning."
  measures:
    - name: "total_recruiter_assignments"
      expr: COUNT(1)
      comment: "Total recruiter assignments. Baseline workload metric for capacity planning and recruiter utilization management."
    - name: "avg_submittal_to_hire_ratio"
      expr: AVG(CAST(submittal_to_hire_ratio AS DOUBLE))
      comment: "Average submittals required per hire across recruiter assignments. A core recruiter efficiency KPI — high ratios indicate poor candidate quality or misaligned sourcing."
    - name: "avg_interview_to_offer_ratio"
      expr: AVG(CAST(interview_to_offer_ratio AS DOUBLE))
      comment: "Average interviews required per offer extended. Measures interview process efficiency and candidate quality at the interview stage."
    - name: "avg_performance_score"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average recruiter performance score. A composite KPI used in recruiter reviews, incentive calculations, and talent delivery quality management."
    - name: "avg_workload_weight"
      expr: AVG(CAST(workload_weight AS DOUBLE))
      comment: "Average workload weight per recruiter assignment. Used by delivery managers to balance recruiter capacity and prevent burnout or quality degradation."
    - name: "fall_off_risk_assignments"
      expr: COUNT(CASE WHEN fall_off_risk_flag = TRUE THEN 1 END)
      comment: "Number of recruiter assignments flagged as fall-off risk. Enables proactive intervention to protect placed revenue and client relationships."
    - name: "fall_off_risk_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fall_off_risk_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recruiter assignments with fall-off risk. A leading indicator of placement stability and revenue at risk by recruiter."
    - name: "exclusive_assignment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_exclusive_assignment = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments that are exclusive. Tracks the mix of exclusive vs. shared engagements, which impacts fill rates and margin."
    - name: "avg_split_fee_percentage"
      expr: AVG(CAST(split_fee_percentage AS DOUBLE))
      comment: "Average split fee percentage on recruiter assignments. Used by finance to track revenue sharing arrangements and net margin impact."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`recruitment_onboarding_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Onboarding efficiency and completion metrics tracking task completion rates, SLA adherence, time-to-ready, and onboarding status. Enables operations to reduce time-to-productivity and prevent start-date failures."
  source: "`staffing_hr_ecm_v1`.`recruitment`.`onboarding_engagement`"
  dimensions:
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current onboarding status (e.g., In Progress, Completed, On Hold, Cancelled) for pipeline health monitoring."
    - name: "onboarding_type"
      expr: onboarding_type
      comment: "Type of onboarding engagement (e.g., Standard, Expedited, RPO) for process mix and SLA analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (e.g., Temporary, Permanent, Contract) for workforce mix and compliance segmentation."
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification (e.g., W2, 1099) for compliance and cost segmentation."
    - name: "onboarding_priority"
      expr: onboarding_priority
      comment: "Priority level of the onboarding engagement for resource allocation and escalation management."
    - name: "orientation_status"
      expr: orientation_status
      comment: "Status of orientation completion for readiness tracking."
    - name: "training_status"
      expr: training_status
      comment: "Status of training completion for readiness and compliance tracking."
    - name: "direct_deposit_status"
      expr: direct_deposit_status
      comment: "Status of direct deposit setup for payroll readiness monitoring."
    - name: "onboarding_start_month"
      expr: DATE_TRUNC('MONTH', onboarding_start_date)
      comment: "Month onboarding started for trend and capacity analysis."
  measures:
    - name: "total_onboarding_engagements"
      expr: COUNT(1)
      comment: "Total onboarding engagements initiated. Baseline volume metric for onboarding capacity and operations planning."
    - name: "onboarding_completed_count"
      expr: COUNT(CASE WHEN onboarding_status = 'Completed' THEN 1 END)
      comment: "Number of onboarding engagements successfully completed. Measures onboarding throughput and operational effectiveness."
    - name: "onboarding_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN onboarding_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of onboarding engagements completed. A critical KPI — low rates indicate process failures that delay worker start dates and risk client SLA breaches."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average task completion percentage across active onboarding engagements. Tracks overall onboarding progress and identifies systemic task completion gaps."
    - name: "avg_fte_value"
      expr: AVG(CAST(fte_value AS DOUBLE))
      comment: "Average FTE value of onboarding engagements. Used by workforce planning to track headcount contribution of onboarding pipeline."
    - name: "sla_breach_risk_count"
      expr: COUNT(CASE WHEN actual_ready_date > target_ready_date THEN 1 END)
      comment: "Number of onboarding engagements where actual ready date exceeded target ready date. Measures SLA breach frequency with direct client satisfaction and contractual penalty implications."
    - name: "sla_on_time_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_ready_date <= target_ready_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_ready_date IS NOT NULL AND target_ready_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of onboarding engagements completed on or before the target ready date. A primary SLA compliance KPI with direct contractual and client retention implications."
    - name: "avg_overdue_tasks"
      expr: AVG(CAST(overdue_tasks_count AS DOUBLE))
      comment: "Average number of overdue tasks per onboarding engagement. Identifies systemic task bottlenecks that delay worker readiness and increase operational risk."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`recruitment_sourcing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing campaign ROI and effectiveness metrics tracking budget utilization, spend efficiency, headcount targets, and channel performance. Enables talent acquisition leaders to optimize sourcing investment allocation."
  source: "`staffing_hr_ecm_v1`.`recruitment`.`sourcing_campaign`"
  dimensions:
    - name: "sourcing_campaign_status"
      expr: sourcing_campaign_status
      comment: "Current status of the sourcing campaign (e.g., Active, Completed, Paused, Cancelled) for portfolio management."
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of sourcing campaign (e.g., Job Board, Social, Referral, Direct Outreach) for channel ROI analysis."
    - name: "primary_channel"
      expr: primary_channel
      comment: "Primary sourcing channel for the campaign to enable channel-level spend and yield analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type targeted by the campaign for workforce mix and program alignment analysis."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model (MSP, RPO, Direct) for program-level campaign performance segmentation."
    - name: "experience_level"
      expr: experience_level
      comment: "Experience level targeted by the campaign (e.g., Entry, Mid, Senior) for talent pool segmentation."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the campaign for regional talent supply analysis."
    - name: "diversity_sourcing_flag"
      expr: diversity_sourcing_flag
      comment: "Flags diversity-focused sourcing campaigns for DEI program tracking and reporting."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the campaign for resource allocation and investment decisions."
    - name: "campaign_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the campaign started for trend and seasonality analysis."
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total sourcing campaigns. Baseline volume metric for sourcing activity and investment portfolio management."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated across sourcing campaigns. Used by finance and talent acquisition leadership to track sourcing investment levels."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend across sourcing campaigns. Measures realized sourcing investment for budget variance and ROI analysis."
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_spend AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated budget actually spent. Tracks sourcing investment efficiency — under-utilization signals execution gaps; over-utilization signals budget management issues."
    - name: "avg_pay_rate_max"
      expr: AVG(CAST(pay_rate_max AS DOUBLE))
      comment: "Average maximum pay rate targeted by sourcing campaigns. Used to benchmark compensation competitiveness of active sourcing efforts."
    - name: "avg_pay_rate_min"
      expr: AVG(CAST(pay_rate_min AS DOUBLE))
      comment: "Average minimum pay rate targeted by sourcing campaigns. Used alongside pay_rate_max to assess compensation range breadth and market alignment."
    - name: "avg_bill_rate_target"
      expr: AVG(CAST(bill_rate_target AS DOUBLE))
      comment: "Average target bill rate across sourcing campaigns. Used by account management to assess pricing strategy alignment with sourcing investment."
    - name: "diversity_campaign_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN diversity_sourcing_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sourcing campaigns with a diversity focus. A DEI program KPI tracked by HR leadership and reported to clients with diversity commitments."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`recruitment_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee and candidate referral program metrics tracking referral volume, placement conversion, bonus economics, and program ROI. Enables talent acquisition to optimize referral program investment and design."
  source: "`staffing_hr_ecm_v1`.`recruitment`.`referral`"
  dimensions:
    - name: "referral_status"
      expr: referral_status
      comment: "Current status of the referral (e.g., Submitted, Under Review, Placed, Rejected) for funnel analysis."
    - name: "referrer_type"
      expr: referrer_type
      comment: "Type of referrer (e.g., Employee, Candidate, Client Contact) for program segment performance analysis."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the referral was submitted for program channel effectiveness analysis."
    - name: "bonus_payment_status"
      expr: bonus_payment_status
      comment: "Status of referral bonus payment (e.g., Pending, Paid, Denied) for program cost tracking."
    - name: "bonus_eligible"
      expr: bonus_eligible
      comment: "Flags referrals eligible for bonus payment for program cost and liability analysis."
    - name: "relationship_to_candidate"
      expr: relationship_to_candidate
      comment: "Referrer relationship to the candidate (e.g., Colleague, Friend, Manager) for network quality analysis."
    - name: "referral_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Month the referral was submitted for trend and program activity analysis."
  measures:
    - name: "total_referrals"
      expr: COUNT(1)
      comment: "Total referrals submitted. Baseline volume metric for referral program activity and engagement."
    - name: "referrals_placed"
      expr: COUNT(CASE WHEN placement_date IS NOT NULL THEN 1 END)
      comment: "Number of referrals that resulted in a placement. Measures referral program effectiveness and its contribution to placement volume."
    - name: "referral_to_placement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN placement_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of referrals that converted to placements. A primary referral program ROI KPI — higher rates indicate a high-quality referral network."
    - name: "total_bonus_amount_paid"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total referral bonus amount paid or committed. Used by finance to track referral program cost and calculate cost-per-hire via referral channel."
    - name: "avg_bonus_amount"
      expr: AVG(CAST(bonus_amount AS DOUBLE))
      comment: "Average referral bonus amount. Used to benchmark program competitiveness and assess incentive design effectiveness."
    - name: "duplicate_referral_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_duplicate_referral = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of referrals flagged as duplicates. High rates indicate program abuse or poor deduplication controls, inflating program cost."
    - name: "bonus_eligible_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN bonus_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of referrals eligible for bonus payment. Used to assess program design effectiveness and forecast bonus liability."
$$;