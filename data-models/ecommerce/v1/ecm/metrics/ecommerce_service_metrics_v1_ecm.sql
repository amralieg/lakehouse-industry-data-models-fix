-- Metric views for domain: service | Business: Ecommerce | Version: 1 | Generated on: 2026-05-04 23:19:28

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`service_agent_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for service agents, enabling leadership to monitor productivity, quality, and customer impact"
  source: "`ecommerce_ecm`.`service`.`agent`"
  dimensions:
    - name: "performance_tier"
      expr: performance_tier
      comment: "Tier classification of the agent (e.g., Tier 1, Tier 2)"
  measures:
    - name: "total_agents"
      expr: COUNT(1)
      comment: "Total number of agents in the service domain"
    - name: "active_agents"
      expr: SUM(CASE WHEN active_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of agents currently active"
    - name: "average_handle_time_minutes"
      expr: AVG(CAST(average_handle_time_minutes AS DOUBLE))
      comment: "Average handle time per case for agents (minutes)"
    - name: "average_escalation_rate"
      expr: AVG(CAST(escalation_rate AS DOUBLE))
      comment: "Average escalation rate across agents (percentage)"
    - name: "average_fcr_rate"
      expr: AVG(CAST(first_contact_resolution_rate AS DOUBLE))
      comment: "Average first‑contact resolution rate for agents (percentage)"
    - name: "average_nps"
      expr: AVG(CAST(net_promoter_score AS DOUBLE))
      comment: "Average Net Promoter Score for agents"
    - name: "average_quality_assurance_score"
      expr: AVG(CAST(quality_assurance_score AS DOUBLE))
      comment: "Average quality assurance score for agents"
    - name: "average_sla_compliance_rate"
      expr: AVG(CAST(sla_compliance_rate AS DOUBLE))
      comment: "Average SLA compliance rate for agents (percentage)"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`service_support_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and quality metrics for service support cases to drive SLA adherence and customer satisfaction"
  source: "`ecommerce_ecm`.`service`.`service_support_case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type/category of the support case"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the case"
    - name: "originating_channel"
      expr: originating_channel
      comment: "Channel through which the case originated (e.g., email, chat)"
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of service support cases"
    - name: "cases_with_sla_breach"
      expr: SUM(CASE WHEN sla_breach_flag THEN 1 ELSE 0 END)
      comment: "Count of cases that breached SLA"
    - name: "sla_breach_rate"
      expr: AVG(CASE WHEN sla_breach_flag THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of cases breaching SLA"
    - name: "total_compensation_amount"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total compensation amount paid for cases"
    - name: "average_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average Customer Satisfaction (CSAT) score across cases"
    - name: "average_first_response_seconds"
      expr: AVG(UNIX_TIMESTAMP(first_response_timestamp) - UNIX_TIMESTAMP(created_timestamp))
      comment: "Average time from case creation to first response (seconds)"
    - name: "average_resolution_seconds"
      expr: AVG(UNIX_TIMESTAMP(resolution_timestamp) - UNIX_TIMESTAMP(first_response_timestamp))
      comment: "Average time from first response to resolution (seconds)"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`service_case_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interaction‑level metrics to assess quality, escalation pressure, and SLA compliance of customer communications"
  source: "`ecommerce_ecm`.`service`.`case_interaction`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Communication channel used for the interaction (e.g., phone, chat)"
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of interaction (e.g., inbound, outbound)"
    - name: "language_code"
      expr: language_code
      comment: "Language of the interaction"
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total number of case interactions recorded"
    - name: "average_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across interactions"
    - name: "escalation_interaction_rate"
      expr: AVG(CASE WHEN escalation_flag THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of interactions that resulted in escalation"
    - name: "sla_compliance_interaction_rate"
      expr: AVG(CASE WHEN sla_compliance_flag THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of interactions that met SLA compliance"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`service_sla_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic SLA policy metrics to guide governance, risk, and financial impact decisions"
  source: "`ecommerce_ecm`.`service`.`sla_policy`"
  dimensions:
    - name: "policy_type"
      expr: policy_type
      comment: "Classification of the SLA policy (e.g., standard, premium)"
    - name: "case_type"
      expr: case_type
      comment: "Case type the policy applies to"
    - name: "channel"
      expr: channel
      comment: "Service channel covered by the policy"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment targeted by the policy"
  measures:
    - name: "total_policies"
      expr: COUNT(1)
      comment: "Total number of SLA policies defined"
    - name: "average_first_response_target_hours"
      expr: AVG(CAST(first_response_target_hours AS DOUBLE))
      comment: "Average target time for first response across policies (hours)"
    - name: "average_resolution_target_hours"
      expr: AVG(CAST(resolution_target_hours AS DOUBLE))
      comment: "Average target time for case resolution across policies (hours)"
    - name: "average_escalation_threshold_hours"
      expr: AVG(CAST(escalation_threshold_hours AS DOUBLE))
      comment: "Average escalation threshold time across policies (hours)"
    - name: "average_breach_penalty_amount"
      expr: AVG(CAST(breach_penalty_amount AS DOUBLE))
      comment: "Average monetary penalty for SLA breach"
    - name: "default_policy_count"
      expr: SUM(CASE WHEN is_default_policy THEN 1 ELSE 0 END)
      comment: "Number of policies marked as default"
$$;