-- Metric views for domain: service | Business: Ecommerce | Version: 1 | Generated on: 2026-05-05 00:54:17

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`service_agent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agent performance and quality metrics for the customer service workforce. Tracks efficiency, quality, and compliance KPIs used by service leadership to manage agent productivity, coaching priorities, and workforce planning."
  source: "`ecommerce_ecm`.`service`.`agent`"
  filter: active_status = 'Active'
  dimensions:
    - name: "performance_tier"
      expr: performance_tier
      comment: "Agent performance tier (e.g. Bronze, Silver, Gold, Platinum) used to segment workforce quality cohorts."
    - name: "team_assignment"
      expr: team_assignment
      comment: "Team the agent is assigned to, enabling team-level performance aggregation."
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status of the agent (e.g. Available, On Break, Offline) for capacity analysis."
    - name: "supported_channels"
      expr: supported_channels
      comment: "Channels the agent supports (e.g. Chat, Phone, Email) for channel-mix workforce analysis."
    - name: "hire_date_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month of hire date, used to analyze agent tenure cohorts and attrition trends."
    - name: "language_proficiencies"
      expr: language_proficiencies
      comment: "Languages the agent is proficient in, enabling multilingual workforce capacity analysis."
  measures:
    - name: "total_active_agents"
      expr: COUNT(1)
      comment: "Total number of active agents. Baseline headcount KPI used for capacity planning and workforce sizing."
    - name: "avg_handle_time_minutes"
      expr: AVG(CAST(average_handle_time_minutes AS DOUBLE))
      comment: "Average handle time in minutes across agents. A core efficiency KPI — rising AHT signals training gaps or process inefficiencies that increase cost-per-contact."
    - name: "avg_customer_satisfaction_score"
      expr: AVG(CAST(customer_satisfaction_score AS DOUBLE))
      comment: "Average CSAT score across agents. Directly measures customer experience quality and is a primary KPI in service QBRs and agent performance reviews."
    - name: "avg_first_contact_resolution_rate"
      expr: AVG(CAST(first_contact_resolution_rate AS DOUBLE))
      comment: "Average first contact resolution rate across agents. FCR is a leading indicator of service quality and cost efficiency — higher FCR reduces repeat contacts and operational cost."
    - name: "avg_escalation_rate"
      expr: AVG(CAST(escalation_rate AS DOUBLE))
      comment: "Average escalation rate across agents. High escalation rates indicate skill gaps or policy issues and drive up cost-per-case."
    - name: "avg_sla_compliance_rate"
      expr: AVG(CAST(sla_compliance_rate AS DOUBLE))
      comment: "Average SLA compliance rate across agents. Measures adherence to service level commitments — a critical operational and contractual KPI."
    - name: "avg_quality_assurance_score"
      expr: AVG(CAST(quality_assurance_score AS DOUBLE))
      comment: "Average QA score across agents. Used by quality management teams to identify coaching needs and maintain service standards."
    - name: "avg_net_promoter_score"
      expr: AVG(CAST(net_promoter_score AS DOUBLE))
      comment: "Average NPS attributed to agents. Ties agent-level interactions to customer loyalty outcomes, informing recognition and improvement programs."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`service_support_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Support case volume, quality, and resolution metrics. The primary operational dashboard for customer service leadership tracking case throughput, SLA compliance, customer satisfaction, and escalation health."
  source: "`ecommerce_ecm`.`service`.`support_case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of support case (e.g. Billing, Shipping, Returns, Technical) for issue-category analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the case (e.g. P1, P2, P3) for urgency-based performance segmentation."
    - name: "service_support_case_status"
      expr: service_support_case_status
      comment: "Current status of the support case (e.g. Open, In Progress, Closed) for pipeline health monitoring."
    - name: "escalation_status"
      expr: escalation_status
      comment: "Escalation status of the case, enabling analysis of escalated vs. non-escalated case volumes and outcomes."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the case, used to identify systemic issues driving contact volume."
    - name: "country_code"
      expr: country_code
      comment: "Country associated with the support case for geographic performance analysis."
    - name: "customer_entitlement_tier"
      expr: customer_entitlement_tier
      comment: "Customer entitlement tier (e.g. Standard, Premium, VIP) for tier-differentiated service analysis."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the case was created, used for trend analysis of case volume and resolution performance over time."
    - name: "outcome_disposition"
      expr: outcome_disposition
      comment: "Final outcome disposition of the case (e.g. Resolved, Unresolved, Escalated) for resolution quality analysis."
    - name: "language_code"
      expr: language_code
      comment: "Language of the support case for multilingual service capacity and quality analysis."
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of support cases. Baseline volume KPI used to track contact demand and workforce capacity needs."
    - name: "total_sla_breached_cases"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of cases that breached SLA. A critical compliance and customer experience KPI — high breach counts signal capacity or process failures."
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that breached SLA. The primary SLA health KPI for service operations — directly tied to contractual obligations and customer satisfaction."
    - name: "total_vip_cases"
      expr: COUNT(CASE WHEN is_vip_case = TRUE THEN 1 END)
      comment: "Number of VIP cases. Tracks high-priority customer case volume to ensure premium service delivery and retention."
    - name: "avg_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average customer satisfaction score across cases. A primary customer experience KPI used in QBRs and executive dashboards."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across cases. Provides an AI-driven signal of customer emotional state, complementing CSAT for proactive service intervention."
    - name: "total_compensation_amount"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total compensation amount issued across cases. Tracks the financial cost of service recovery — a key cost-of-poor-quality metric for finance and operations."
    - name: "avg_compensation_per_case"
      expr: AVG(CAST(compensation_amount AS DOUBLE))
      comment: "Average compensation amount per case. Identifies whether compensation is being applied consistently or if outlier cases are driving disproportionate cost."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_status IS NOT NULL AND escalation_status != 'None' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that were escalated. High escalation rates indicate systemic service quality issues and drive up cost-per-case."
    - name: "distinct_customers_with_cases"
      expr: COUNT(DISTINCT customer_profile_id)
      comment: "Number of distinct customers who opened support cases. Used to measure the breadth of service demand and identify customers with recurring issues."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`service_case_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Case interaction channel and quality metrics. Tracks interaction volume, resolution rates, escalation patterns, and sentiment across all customer touchpoints to optimize channel strategy and agent effectiveness."
  source: "`ecommerce_ecm`.`service`.`case_interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of interaction (e.g. Inbound Call, Chat, Email, Callback) for channel-mix analysis."
    - name: "contact_method"
      expr: contact_method
      comment: "Contact method used for the interaction, enabling channel preference and cost-per-channel analysis."
    - name: "interaction_status"
      expr: interaction_status
      comment: "Status of the interaction (e.g. Completed, Abandoned, Transferred) for quality and completion rate analysis."
    - name: "direction"
      expr: direction
      comment: "Direction of the interaction (Inbound vs. Outbound) for proactive vs. reactive service analysis."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the interaction (e.g. Resolved, Escalated, Follow-up Required) for resolution quality tracking."
    - name: "country_code"
      expr: country_code
      comment: "Country of the interaction for geographic service quality analysis."
    - name: "language_code"
      expr: language_code
      comment: "Language of the interaction for multilingual service capacity planning."
    - name: "interaction_month"
      expr: DATE_TRUNC('MONTH', interaction_timestamp)
      comment: "Month of the interaction timestamp for trend analysis of interaction volume and quality over time."
    - name: "priority"
      expr: priority
      comment: "Priority level of the interaction for urgency-based analysis."
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total number of case interactions. Baseline contact volume KPI for capacity planning and channel strategy."
    - name: "resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_provided_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interactions where resolution was provided. A core service effectiveness KPI — low resolution rates drive repeat contacts and customer dissatisfaction."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interactions that were escalated. High escalation rates signal agent skill gaps or policy issues increasing cost-per-contact."
    - name: "transfer_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN transfer_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interactions that were transferred. High transfer rates indicate routing inefficiencies and degrade customer experience."
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interactions that met SLA targets. Measures adherence to service level commitments at the interaction level."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across interactions. Provides a real-time signal of customer emotional state to guide coaching and process improvement."
    - name: "distinct_cases_with_interactions"
      expr: COUNT(DISTINCT support_case_id)
      comment: "Number of distinct support cases that had interactions. Used to measure interaction density and identify cases requiring excessive touchpoints."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`service_escalation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Escalation volume, cost, resolution, and SLA metrics. Tracks the health of the escalation pipeline — a critical operational KPI for service leadership to manage tier-2/3 capacity, compensation spend, and root cause elimination."
  source: "`ecommerce_ecm`.`service`.`escalation`"
  dimensions:
    - name: "escalation_type"
      expr: escalation_type
      comment: "Type of escalation (e.g. Billing, Technical, Delivery) for root cause and category analysis."
    - name: "escalation_status"
      expr: escalation_status
      comment: "Current status of the escalation (e.g. Open, Resolved, Pending) for pipeline health monitoring."
    - name: "priority"
      expr: priority
      comment: "Priority level of the escalation for urgency-based capacity and SLA analysis."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the escalation, used to identify systemic issues driving escalation volume."
    - name: "source_tier"
      expr: source_tier
      comment: "Tier from which the escalation originated (e.g. Tier 1, Tier 2) for tier-flow analysis."
    - name: "target_tier"
      expr: target_tier
      comment: "Tier to which the escalation was routed for capacity planning at each tier."
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation issued (e.g. Refund, Credit, Voucher) for cost-of-service-recovery analysis."
    - name: "escalation_month"
      expr: DATE_TRUNC('MONTH', escalation_timestamp)
      comment: "Month the escalation was created for trend analysis of escalation volume and resolution performance."
    - name: "resolution_code"
      expr: resolution_code
      comment: "Resolution code applied to the escalation for outcome quality analysis."
  measures:
    - name: "total_escalations"
      expr: COUNT(1)
      comment: "Total number of escalations. Baseline volume KPI for escalation pipeline capacity and trend monitoring."
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of escalations that breached SLA. A critical compliance KPI — escalation SLA breaches carry the highest customer satisfaction and contractual risk."
    - name: "resolution_at_escalated_tier_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_at_escalated_tier_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of escalations resolved at the escalated tier without further escalation. Measures escalation effectiveness and tier-2/3 resolution capability."
    - name: "compensation_issued_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compensation_issued_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of escalations where compensation was issued. Tracks the frequency of service recovery spend as a cost-of-quality indicator."
    - name: "total_compensation_amount"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total compensation amount issued for escalated cases. A direct financial cost-of-poor-quality metric used by finance and service leadership."
    - name: "avg_compensation_per_escalation"
      expr: AVG(CAST(compensation_amount AS DOUBLE))
      comment: "Average compensation amount per escalation. Identifies whether compensation is being applied consistently and flags outlier escalations driving disproportionate cost."
    - name: "total_escalation_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total operational cost of escalations. Captures the full cost burden of the escalation pipeline for budget and efficiency analysis."
    - name: "avg_escalation_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per escalation. Used to benchmark escalation handling efficiency and identify high-cost escalation categories."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`service_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return Merchandise Authorization (RMA) volume, financial, and operational metrics. Tracks return rates, refund costs, inspection outcomes, and policy compliance — critical for finance, operations, and product quality teams."
  source: "`ecommerce_ecm`.`service`.`rma`"
  dimensions:
    - name: "rma_status"
      expr: rma_status
      comment: "Current status of the RMA (e.g. Pending, Approved, Closed, Rejected) for pipeline health monitoring."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return (e.g. Defective, Wrong Item, Changed Mind) for root cause and product quality analysis."
    - name: "return_type"
      expr: return_type
      comment: "Type of return (e.g. Refund, Exchange, Store Credit) for financial impact analysis."
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Disposition decision for the returned item (e.g. Restock, Destroy, Refurbish) for inventory recovery analysis."
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to issue the refund (e.g. Original Payment, Store Credit) for payment operations analysis."
    - name: "refund_status"
      expr: refund_status
      comment: "Current status of the refund (e.g. Pending, Processed, Failed) for refund pipeline monitoring."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the item inspection (e.g. Pending, Completed, Waived) for returns processing efficiency analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the RMA transaction for multi-currency financial analysis."
    - name: "requested_month"
      expr: DATE_TRUNC('MONTH', requested_date)
      comment: "Month the RMA was requested for trend analysis of return volume and financial impact over time."
    - name: "is_within_policy"
      expr: CAST(is_within_policy AS STRING)
      comment: "Whether the return is within policy (True/False) for policy compliance analysis and exception tracking."
  measures:
    - name: "total_rmas"
      expr: COUNT(1)
      comment: "Total number of RMAs. Baseline return volume KPI used to track return demand and its impact on operations and financials."
    - name: "within_policy_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_within_policy = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RMAs that are within return policy. Measures policy compliance and flags potential abuse or policy gaps."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued across RMAs. A primary financial KPI for returns — directly impacts gross margin and revenue recognition."
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount per RMA. Used to benchmark refund levels and identify categories with disproportionately high refund values."
    - name: "total_restocking_fee_revenue"
      expr: SUM(CAST(restocking_fee AS DOUBLE))
      comment: "Total restocking fees collected. Measures the revenue offset from return processing costs — a key metric for returns policy optimization."
    - name: "total_return_label_cost"
      expr: SUM(CAST(return_label_cost AS DOUBLE))
      comment: "Total cost of return shipping labels issued. A direct operational cost metric for the returns program used in cost-per-return analysis."
    - name: "approval_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RMAs requiring manual approval. High rates indicate policy complexity or exception volume that drives processing cost."
    - name: "distinct_sellers_with_returns"
      expr: COUNT(DISTINCT seller_profile_id)
      comment: "Number of distinct sellers with RMAs. Used to identify sellers with high return rates for quality and compliance intervention."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`service_rma_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RMA line-item financial and disposition metrics. Provides SKU-level return analysis for product quality, inventory recovery, and refund cost management — essential for merchandising and supply chain teams."
  source: "`ecommerce_ecm`.`service`.`rma_line`"
  dimensions:
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Return reason code at the line level for SKU-level root cause analysis."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition code for the returned line item (e.g. Restock, Scrap, Refurbish) for inventory recovery analysis."
    - name: "item_condition_code"
      expr: item_condition_code
      comment: "Condition of the returned item (e.g. New, Used, Damaged) for quality and restocking eligibility analysis."
    - name: "line_status"
      expr: line_status
      comment: "Current status of the RMA line (e.g. Pending, Approved, Rejected) for processing pipeline monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line item for multi-currency financial analysis."
    - name: "restocking_eligible_flag"
      expr: CAST(restocking_eligible_flag AS STRING)
      comment: "Whether the returned item is eligible for restocking (True/False) for inventory recovery rate analysis."
    - name: "exchange_requested_flag"
      expr: CAST(exchange_requested_flag AS STRING)
      comment: "Whether an exchange was requested instead of a refund (True/False) for exchange vs. refund mix analysis."
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month the returned item was received for trend analysis of return line volume and financial impact."
  measures:
    - name: "total_return_lines"
      expr: COUNT(1)
      comment: "Total number of RMA line items. Baseline return line volume KPI for product-level return demand analysis."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount at the line level. Provides SKU-level financial impact of returns for merchandising and product quality decisions."
    - name: "total_line_subtotal"
      expr: SUM(CAST(line_subtotal AS DOUBLE))
      comment: "Total line subtotal value of returned items. Measures the gross merchandise value being returned — a key input to net revenue calculations."
    - name: "total_restocking_fee_amount"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected at the line level. Measures the revenue offset from return processing costs at SKU granularity."
    - name: "total_line_tax_amount"
      expr: SUM(CAST(line_tax_amount AS DOUBLE))
      comment: "Total tax amount on returned lines. Required for accurate tax liability reconciliation on returns."
    - name: "restocking_eligible_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN restocking_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of returned line items eligible for restocking. Measures inventory recovery rate — higher rates reduce the net cost of returns."
    - name: "exchange_request_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exchange_requested_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of return lines where an exchange was requested. High exchange rates indicate product satisfaction issues rather than pure return intent."
    - name: "avg_unit_price_returned"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price of returned items. Identifies whether high-value items are disproportionately returned, informing pricing and quality strategy."
    - name: "distinct_skus_returned"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs returned. Used to identify breadth of product quality issues and prioritize product improvement efforts."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`service_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service refund financial and operational metrics. Tracks refund volume, cost, approval patterns, and goodwill spend — a critical financial and customer experience KPI for finance, service operations, and retention teams."
  source: "`ecommerce_ecm`.`service`.`service_refund`"
  dimensions:
    - name: "service_refund_status"
      expr: service_refund_status
      comment: "Current status of the service refund (e.g. Pending, Approved, Processed, Rejected) for pipeline monitoring."
    - name: "reason_category"
      expr: reason_category
      comment: "Category of the refund reason (e.g. Shipping Delay, Defective Product, Billing Error) for root cause analysis."
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to issue the refund (e.g. Original Payment, Store Credit, Loyalty Points) for payment operations analysis."
    - name: "remediation_type"
      expr: remediation_type
      comment: "Type of remediation applied (e.g. Full Refund, Partial Refund, Replacement) for service recovery strategy analysis."
    - name: "approval_tier"
      expr: approval_tier
      comment: "Approval tier required for the refund (e.g. Agent, Supervisor, Manager) for authorization pattern analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the refund for multi-currency financial analysis."
    - name: "is_goodwill_gesture"
      expr: CAST(is_goodwill_gesture AS STRING)
      comment: "Whether the refund is a goodwill gesture (True/False) for discretionary spend analysis."
    - name: "is_retention_offer"
      expr: CAST(is_retention_offer AS STRING)
      comment: "Whether the refund is a retention offer (True/False) for customer retention investment analysis."
    - name: "original_payment_method_type"
      expr: original_payment_method_type
      comment: "Original payment method type for refund routing and payment operations analysis."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the refund was created for trend analysis of refund volume and financial impact over time."
  measures:
    - name: "total_refunds"
      expr: COUNT(1)
      comment: "Total number of service refunds. Baseline volume KPI for refund demand and financial exposure monitoring."
    - name: "total_refund_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total refund amount issued. The primary financial KPI for service refunds — directly impacts net revenue and gross margin."
    - name: "avg_refund_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average refund amount per transaction. Used to benchmark refund levels and detect outlier refunds requiring policy review."
    - name: "total_net_refund_cost"
      expr: SUM(CAST(net_refund_cost AS DOUBLE))
      comment: "Total net cost of refunds after processing fees. Provides the true financial burden of the refund program for P&L analysis."
    - name: "total_processing_fee"
      expr: SUM(CAST(processing_fee AS DOUBLE))
      comment: "Total processing fees incurred on refunds. Measures the operational cost of refund processing for cost optimization."
    - name: "goodwill_refund_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_goodwill_gesture = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of refunds issued as goodwill gestures. High rates indicate systemic service failures driving discretionary spend."
    - name: "retention_offer_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_retention_offer = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of refunds issued as retention offers. Measures the investment in customer retention through service recovery."
    - name: "manager_override_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN manager_override_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of refunds requiring manager override. High override rates signal policy gaps or agent empowerment issues."
    - name: "total_goodwill_refund_amount"
      expr: SUM(CASE WHEN is_goodwill_gesture = TRUE THEN amount ELSE 0 END)
      comment: "Total amount issued as goodwill gestures. Quantifies the financial cost of discretionary service recovery spend for budget governance."
    - name: "distinct_customers_refunded"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customer accounts receiving refunds. Used to measure refund breadth and identify customers with recurring refund patterns."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`service_feedback_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer feedback and survey response metrics. Tracks satisfaction scores, sentiment, first contact resolution, and follow-up completion — the voice-of-customer KPI layer for service quality and product improvement decisions."
  source: "`ecommerce_ecm`.`service`.`feedback_response`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of survey (e.g. CSAT, NPS, CES) for survey program performance analysis."
    - name: "survey_trigger_event"
      expr: survey_trigger_event
      comment: "Event that triggered the survey (e.g. Case Closed, Delivery, Purchase) for touchpoint-level satisfaction analysis."
    - name: "sentiment_classification"
      expr: sentiment_classification
      comment: "Sentiment classification of the feedback (e.g. Positive, Neutral, Negative) for voice-of-customer trend analysis."
    - name: "primary_feedback_theme"
      expr: primary_feedback_theme
      comment: "Primary theme of the feedback (e.g. Shipping, Product Quality, Agent Behavior) for issue prioritization."
    - name: "case_category"
      expr: case_category
      comment: "Category of the case associated with the feedback for issue-type satisfaction analysis."
    - name: "channel_of_service"
      expr: channel_of_service
      comment: "Channel through which service was delivered (e.g. Chat, Phone, Email) for channel satisfaction benchmarking."
    - name: "response_device_type"
      expr: response_device_type
      comment: "Device type used to submit the feedback (e.g. Mobile, Desktop) for survey experience optimization."
    - name: "response_language"
      expr: response_language
      comment: "Language of the feedback response for multilingual voice-of-customer analysis."
    - name: "response_month"
      expr: DATE_TRUNC('MONTH', response_timestamp)
      comment: "Month the feedback response was submitted for trend analysis of satisfaction scores over time."
  measures:
    - name: "total_feedback_responses"
      expr: COUNT(1)
      comment: "Total number of feedback responses received. Baseline survey volume KPI for response rate and program reach analysis."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across feedback responses. A primary voice-of-customer KPI used to track overall customer emotional state and service quality trends."
    - name: "first_contact_resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN first_contact_resolution_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of feedback responses indicating first contact resolution. FCR is a leading indicator of service quality and cost efficiency."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of feedback-linked cases that were escalated. Correlates escalation frequency with customer satisfaction outcomes."
    - name: "sla_met_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of feedback responses where SLA was met. Ties SLA compliance directly to customer satisfaction data."
    - name: "follow_up_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_completed_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN follow_up_action_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required follow-up actions that were completed. Measures service commitment fulfillment — incomplete follow-ups are a leading driver of customer churn."
    - name: "avg_case_resolution_time_hours"
      expr: AVG(CAST(case_resolution_time_hours AS DOUBLE))
      comment: "Average case resolution time in hours as reported in feedback. Provides a customer-perceived resolution speed metric to complement operational SLA data."
    - name: "incentive_offered_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN incentive_offered_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of feedback responses where an incentive was offered. Tracks the use of incentives in survey programs and their potential bias on satisfaction scores."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`service_knowledge_article`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Knowledge base effectiveness and self-service deflection metrics. Tracks article usage, helpfulness, and case deflection — critical KPIs for reducing contact volume and improving agent efficiency through knowledge management."
  source: "`ecommerce_ecm`.`service`.`knowledge_article`"
  dimensions:
    - name: "article_type"
      expr: article_type
      comment: "Type of knowledge article (e.g. FAQ, How-To, Troubleshooting) for content strategy analysis."
    - name: "knowledge_article_status"
      expr: knowledge_article_status
      comment: "Publication status of the article (e.g. Draft, Published, Archived) for content lifecycle management."
    - name: "visibility_scope"
      expr: visibility_scope
      comment: "Visibility scope of the article (e.g. Internal, External, Agent-Only) for audience segmentation analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the article for content governance and maintenance prioritization."
    - name: "locale"
      expr: locale
      comment: "Locale of the article for multilingual knowledge base coverage analysis."
    - name: "publish_month"
      expr: DATE_TRUNC('MONTH', publish_date)
      comment: "Month the article was published for content freshness and publication cadence analysis."
  measures:
    - name: "total_articles"
      expr: COUNT(1)
      comment: "Total number of knowledge articles. Baseline KPI for knowledge base size and content coverage."
    - name: "total_article_views"
      expr: SUM(CAST(view_count AS DOUBLE))
      comment: "Total article views across the knowledge base. Measures self-service engagement and knowledge base reach — a leading indicator of contact deflection."
    - name: "avg_helpfulness_score"
      expr: AVG(CAST(helpfulness_score AS DOUBLE))
      comment: "Average helpfulness score across articles. Measures content quality from the user perspective — low scores identify articles requiring revision."
    - name: "avg_views_per_article"
      expr: AVG(CAST(view_count AS DOUBLE))
      comment: "Average number of views per article. Identifies whether knowledge base traffic is concentrated on a few articles or broadly distributed."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`service_sla_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA policy configuration and financial risk metrics. Tracks policy coverage, target hours, breach penalties, and escalation thresholds — used by service operations and compliance teams to govern service level commitments."
  source: "`ecommerce_ecm`.`service`.`sla_policy`"
  filter: sla_policy_status = 'Active'
  dimensions:
    - name: "policy_type"
      expr: policy_type
      comment: "Type of SLA policy (e.g. Standard, Premium, Regulatory) for policy tier analysis."
    - name: "case_type"
      expr: case_type
      comment: "Case type the policy applies to for coverage analysis by issue category."
    - name: "case_priority"
      expr: case_priority
      comment: "Case priority level the policy governs for priority-tier SLA analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region the policy applies to for regional SLA coverage analysis."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level defined in the policy for tier-based SLA governance analysis."
    - name: "breach_penalty_type"
      expr: breach_penalty_type
      comment: "Type of breach penalty (e.g. Financial, Credit, Contractual) for financial risk analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the policy became effective for policy lifecycle and coverage trend analysis."
    - name: "is_default_policy"
      expr: CAST(is_default_policy AS STRING)
      comment: "Whether this is the default policy (True/False) for policy hierarchy analysis."
  measures:
    - name: "total_active_policies"
      expr: COUNT(1)
      comment: "Total number of active SLA policies. Baseline KPI for policy coverage and governance complexity."
    - name: "avg_first_response_target_hours"
      expr: AVG(CAST(first_response_target_hours AS DOUBLE))
      comment: "Average first response target hours across active policies. Benchmarks the stringency of first response commitments across the policy portfolio."
    - name: "avg_resolution_target_hours"
      expr: AVG(CAST(resolution_target_hours AS DOUBLE))
      comment: "Average resolution target hours across active policies. Measures the overall resolution commitment level — used to assess whether targets are achievable given current capacity."
    - name: "avg_escalation_threshold_hours"
      expr: AVG(CAST(escalation_threshold_hours AS DOUBLE))
      comment: "Average escalation threshold hours across policies. Measures how quickly cases are expected to escalate — a key input to tier-2/3 capacity planning."
    - name: "total_breach_penalty_amount"
      expr: SUM(CAST(breach_penalty_amount AS DOUBLE))
      comment: "Total potential breach penalty amount across active policies. Quantifies the maximum financial exposure from SLA non-compliance — a critical risk metric for finance and legal."
    - name: "avg_breach_penalty_amount"
      expr: AVG(CAST(breach_penalty_amount AS DOUBLE))
      comment: "Average breach penalty amount per policy. Used to benchmark penalty severity and prioritize compliance efforts on high-penalty policies."
    - name: "auto_escalation_enabled_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_escalation_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of policies with auto-escalation enabled. Measures automation coverage in the escalation process — low rates indicate manual escalation risk."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`service_team`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service team capacity, configuration, and performance target metrics. Used by service leadership for workforce planning, team benchmarking, and operational governance across the support organization."
  source: "`ecommerce_ecm`.`service`.`team`"
  filter: team_status = 'Active'
  dimensions:
    - name: "team_type"
      expr: team_type
      comment: "Type of team (e.g. Tier 1, Tier 2, Specialist, Escalation) for organizational structure analysis."
    - name: "primary_function"
      expr: primary_function
      comment: "Primary function of the team (e.g. Technical Support, Billing, Returns) for functional capacity analysis."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier the team operates under for tier-based performance benchmarking."
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Geographic coverage of the team for regional capacity planning."
    - name: "timezone"
      expr: timezone
      comment: "Timezone the team operates in for follow-the-sun coverage analysis."
    - name: "is_remote"
      expr: CAST(is_remote AS STRING)
      comment: "Whether the team is remote (True/False) for remote vs. on-site workforce analysis."
    - name: "operates_weekends"
      expr: CAST(operates_weekends AS STRING)
      comment: "Whether the team operates on weekends (True/False) for coverage gap analysis."
    - name: "operates_holidays"
      expr: CAST(operates_holidays AS STRING)
      comment: "Whether the team operates on holidays (True/False) for holiday coverage planning."
  measures:
    - name: "total_active_teams"
      expr: COUNT(1)
      comment: "Total number of active service teams. Baseline organizational capacity KPI."
    - name: "total_capacity_fte"
      expr: SUM(CAST(capacity_fte AS DOUBLE))
      comment: "Total FTE capacity across active teams. The primary workforce capacity KPI used for demand vs. supply analysis and hiring decisions."
    - name: "avg_capacity_fte_per_team"
      expr: AVG(CAST(capacity_fte AS DOUBLE))
      comment: "Average FTE capacity per team. Used to benchmark team sizing and identify under- or over-resourced teams."
    - name: "avg_csat_target"
      expr: AVG(CAST(csat_target AS DOUBLE))
      comment: "Average CSAT target across teams. Measures the ambition level of customer satisfaction commitments across the service organization."
    - name: "avg_resolution_target_hours"
      expr: AVG(CAST(target_resolution_hours AS DOUBLE))
      comment: "Average resolution target hours across teams. Benchmarks resolution speed commitments and identifies teams with aggressive vs. conservative targets."
    - name: "avg_quality_score_target"
      expr: AVG(CAST(quality_score_target AS DOUBLE))
      comment: "Average quality score target across teams. Measures the quality ambition level across the service organization for governance and benchmarking."
    - name: "weekend_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN operates_weekends = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of teams providing weekend coverage. Measures weekend service availability — gaps here directly impact customer satisfaction for weekend shoppers."
$$;