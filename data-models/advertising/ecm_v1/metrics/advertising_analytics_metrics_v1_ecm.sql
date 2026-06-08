-- Metric views for domain: analytics | Business: Advertising | Version: 1 | Generated on: 2026-05-08 02:24:04

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`analytics_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core analytics request fulfillment metrics tracking request volume, effort, delivery performance, and client satisfaction across analytics services"
  source: "`advertising_ecm`.`analytics`.`analytics_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of analytics request (e.g., ad-hoc analysis, dashboard, insight report)"
    - name: "request_status"
      expr: request_status
      comment: "Current status of the analytics request (e.g., submitted, in progress, completed, cancelled)"
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority level assigned to the request (e.g., high, medium, low)"
    - name: "deliverable_type"
      expr: deliverable_type
      comment: "Type of deliverable produced (e.g., report, dashboard, dataset)"
    - name: "billable_flag"
      expr: billable_flag
      comment: "Whether the request is billable to the client"
    - name: "client_satisfaction_rating"
      expr: client_satisfaction_rating
      comment: "Client satisfaction rating for completed requests"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for request cancellation if applicable"
    - name: "requestor_type"
      expr: requestor_type
      comment: "Type of requestor (e.g., internal, external client)"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month when the request was submitted"
    - name: "requested_delivery_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month when delivery was requested"
  measures:
    - name: "total_requests"
      expr: COUNT(1)
      comment: "Total number of analytics requests submitted"
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total actual effort hours spent fulfilling analytics requests"
    - name: "total_estimated_effort_hours"
      expr: SUM(CAST(effort_estimate_hours AS DOUBLE))
      comment: "Total estimated effort hours for analytics requests"
    - name: "avg_actual_effort_hours"
      expr: AVG(CAST(actual_effort_hours AS DOUBLE))
      comment: "Average actual effort hours per analytics request"
    - name: "avg_estimated_effort_hours"
      expr: AVG(CAST(effort_estimate_hours AS DOUBLE))
      comment: "Average estimated effort hours per analytics request"
    - name: "effort_variance_hours"
      expr: SUM((CAST(actual_effort_hours AS DOUBLE)) - (CAST(effort_estimate_hours AS DOUBLE)))
      comment: "Total variance between actual and estimated effort hours (positive = over estimate)"
    - name: "distinct_advertisers"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of distinct advertisers submitting analytics requests"
    - name: "distinct_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns associated with analytics requests"
    - name: "billable_requests"
      expr: SUM(CASE WHEN billable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of billable analytics requests"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`analytics_attribution_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Attribution study performance metrics measuring marketing channel effectiveness, ROAS, conversion attribution, and model quality across multi-touch attribution analyses"
  source: "`advertising_ecm`.`analytics`.`attribution_study`"
  dimensions:
    - name: "attribution_methodology"
      expr: attribution_methodology
      comment: "Attribution methodology used (e.g., last-touch, first-touch, linear, time-decay, algorithmic)"
    - name: "study_status"
      expr: study_status
      comment: "Current status of the attribution study (e.g., planning, in progress, completed, archived)"
    - name: "study_type"
      expr: study_type
      comment: "Type of attribution study conducted"
    - name: "platform_tool_used"
      expr: platform_tool_used
      comment: "Platform or tool used to conduct the attribution study"
    - name: "top_performing_channel"
      expr: top_performing_channel
      comment: "Channel identified as top performer in the study"
    - name: "validation_approach"
      expr: validation_approach
      comment: "Approach used to validate attribution model results"
    - name: "study_completion_month"
      expr: DATE_TRUNC('MONTH', study_completion_date)
      comment: "Month when the attribution study was completed"
    - name: "study_start_month"
      expr: DATE_TRUNC('MONTH', study_start_date)
      comment: "Month when the attribution study started"
  measures:
    - name: "total_studies"
      expr: COUNT(1)
      comment: "Total number of attribution studies conducted"
    - name: "total_revenue_attributed"
      expr: SUM(CAST(total_revenue_attributed AS DOUBLE))
      comment: "Total revenue attributed across all studies"
    - name: "total_conversions_attributed"
      expr: SUM(CAST(total_conversions_attributed AS DOUBLE))
      comment: "Total conversions attributed across all studies"
    - name: "avg_roas_overall"
      expr: AVG(CAST(roas_overall AS DOUBLE))
      comment: "Average return on ad spend (ROAS) across attribution studies"
    - name: "avg_model_confidence_score"
      expr: AVG(CAST(model_confidence_score AS DOUBLE))
      comment: "Average confidence score of attribution models"
    - name: "distinct_advertisers"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of distinct advertisers with attribution studies"
    - name: "distinct_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns analyzed in attribution studies"
    - name: "avg_conversions_per_study"
      expr: AVG(CAST(total_conversions_attributed AS DOUBLE))
      comment: "Average number of conversions attributed per study"
    - name: "avg_revenue_per_study"
      expr: AVG(CAST(total_revenue_attributed AS DOUBLE))
      comment: "Average revenue attributed per study"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`analytics_brand_lift_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand lift study metrics measuring advertising impact on brand awareness, consideration, favorability, and purchase intent through controlled experimental designs"
  source: "`advertising_ecm`.`analytics`.`brand_lift_study`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Current status of the brand lift study (e.g., planning, fielding, completed)"
    - name: "study_type"
      expr: study_type
      comment: "Type of brand lift study (e.g., pre-post, control-exposed)"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the study results"
    - name: "statistical_significance_flag"
      expr: statistical_significance_flag
      comment: "Whether the study results achieved statistical significance"
    - name: "study_completion_month"
      expr: DATE_TRUNC('MONTH', study_end_date)
      comment: "Month when the brand lift study was completed"
    - name: "study_start_month"
      expr: DATE_TRUNC('MONTH', study_start_date)
      comment: "Month when the brand lift study started"
  measures:
    - name: "total_studies"
      expr: COUNT(1)
      comment: "Total number of brand lift studies conducted"
    - name: "avg_aided_awareness_lift_pct"
      expr: AVG(CAST(aided_awareness_lift_pct AS DOUBLE))
      comment: "Average aided brand awareness lift percentage across studies"
    - name: "avg_unaided_awareness_lift_pct"
      expr: AVG(CAST(unaided_awareness_lift_pct AS DOUBLE))
      comment: "Average unaided brand awareness lift percentage across studies"
    - name: "avg_consideration_lift_pct"
      expr: AVG(CAST(consideration_lift_pct AS DOUBLE))
      comment: "Average brand consideration lift percentage across studies"
    - name: "avg_purchase_intent_lift_pct"
      expr: AVG(CAST(purchase_intent_lift_pct AS DOUBLE))
      comment: "Average purchase intent lift percentage across studies"
    - name: "avg_brand_favorability_lift_pct"
      expr: AVG(CAST(brand_favorability_lift_pct AS DOUBLE))
      comment: "Average brand favorability lift percentage across studies"
    - name: "avg_brand_preference_lift_pct"
      expr: AVG(CAST(brand_preference_lift_pct AS DOUBLE))
      comment: "Average brand preference lift percentage across studies"
    - name: "avg_ad_recall_lift_pct"
      expr: AVG(CAST(ad_recall_lift_pct AS DOUBLE))
      comment: "Average ad recall lift percentage across studies"
    - name: "avg_message_association_lift_pct"
      expr: AVG(CAST(message_association_lift_pct AS DOUBLE))
      comment: "Average message association lift percentage across studies"
    - name: "total_study_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of brand lift studies conducted"
    - name: "avg_study_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per brand lift study"
    - name: "statistically_significant_studies"
      expr: SUM(CASE WHEN statistical_significance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of studies achieving statistical significance"
    - name: "distinct_advertisers"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of distinct advertisers with brand lift studies"
    - name: "distinct_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns measured in brand lift studies"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`analytics_incrementality_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incrementality test metrics measuring true causal impact of advertising through controlled experiments, tracking incremental lift, ROAS, and statistical significance"
  source: "`advertising_ecm`.`analytics`.`incrementality_test`"
  dimensions:
    - name: "test_status"
      expr: test_status
      comment: "Current status of the incrementality test (e.g., design, running, completed, cancelled)"
    - name: "test_type"
      expr: test_type
      comment: "Type of incrementality test (e.g., geo holdout, user holdout, PSA)"
    - name: "test_channel"
      expr: test_channel
      comment: "Marketing channel being tested for incrementality"
    - name: "outcome_metric"
      expr: outcome_metric
      comment: "Primary outcome metric measured (e.g., conversions, revenue, registrations)"
    - name: "statistical_methodology"
      expr: statistical_methodology
      comment: "Statistical methodology used for the test (e.g., difference-in-differences, synthetic control)"
    - name: "is_statistically_significant"
      expr: is_statistically_significant
      comment: "Whether the test results achieved statistical significance"
    - name: "test_completion_month"
      expr: DATE_TRUNC('MONTH', test_end_date)
      comment: "Month when the incrementality test was completed"
    - name: "test_start_month"
      expr: DATE_TRUNC('MONTH', test_start_date)
      comment: "Month when the incrementality test started"
  measures:
    - name: "total_tests"
      expr: COUNT(1)
      comment: "Total number of incrementality tests conducted"
    - name: "avg_incremental_lift_estimate"
      expr: AVG(CAST(incremental_lift_estimate AS DOUBLE))
      comment: "Average incremental lift estimate across tests"
    - name: "avg_incremental_roas"
      expr: AVG(CAST(incremental_roas AS DOUBLE))
      comment: "Average incremental return on ad spend across tests"
    - name: "avg_incremental_cost_per_outcome"
      expr: AVG(CAST(incremental_cost_per_outcome AS DOUBLE))
      comment: "Average incremental cost per outcome across tests"
    - name: "avg_treatment_group_outcome"
      expr: AVG(CAST(treatment_group_outcome_value AS DOUBLE))
      comment: "Average outcome value in treatment groups"
    - name: "avg_control_group_outcome"
      expr: AVG(CAST(control_group_outcome_value AS DOUBLE))
      comment: "Average outcome value in control groups"
    - name: "total_treatment_group_size"
      expr: SUM(CAST(treatment_group_size AS DOUBLE))
      comment: "Total size of treatment groups across all tests"
    - name: "total_control_group_size"
      expr: SUM(CAST(control_group_size AS DOUBLE))
      comment: "Total size of control groups across all tests"
    - name: "statistically_significant_tests"
      expr: SUM(CASE WHEN is_statistically_significant = TRUE THEN 1 ELSE 0 END)
      comment: "Number of tests achieving statistical significance"
    - name: "distinct_advertisers"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of distinct advertisers with incrementality tests"
    - name: "distinct_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns tested for incrementality"
    - name: "avg_p_value"
      expr: AVG(CAST(p_value AS DOUBLE))
      comment: "Average p-value across incrementality tests"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`analytics_mmm_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing mix modeling (MMM) study metrics tracking model quality, delivery performance, and budget optimization recommendations across econometric marketing effectiveness analyses"
  source: "`advertising_ecm`.`analytics`.`mmm_study`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Current status of the MMM study (e.g., scoping, modeling, validation, completed)"
    - name: "modeling_methodology"
      expr: modeling_methodology
      comment: "Modeling methodology used (e.g., linear regression, Bayesian, machine learning)"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the MMM study results"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status of the MMM model"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the MMM study (e.g., national, regional, global)"
    - name: "granularity_level"
      expr: granularity_level
      comment: "Granularity level of the model (e.g., weekly, monthly)"
    - name: "outcome_variable"
      expr: outcome_variable
      comment: "Primary outcome variable modeled (e.g., sales, revenue, conversions)"
    - name: "study_completion_month"
      expr: DATE_TRUNC('MONTH', actual_completion_date)
      comment: "Month when the MMM study was completed"
  measures:
    - name: "total_studies"
      expr: COUNT(1)
      comment: "Total number of MMM studies conducted"
    - name: "avg_r_squared"
      expr: AVG(CAST(r_squared AS DOUBLE))
      comment: "Average R-squared (model fit) across MMM studies"
    - name: "avg_mape"
      expr: AVG(CAST(mape AS DOUBLE))
      comment: "Average mean absolute percentage error (MAPE) across MMM studies"
    - name: "avg_rmse"
      expr: AVG(CAST(rmse AS DOUBLE))
      comment: "Average root mean squared error (RMSE) across MMM studies"
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total budget allocated to MMM studies"
    - name: "avg_budget_per_study"
      expr: AVG(CAST(budget_allocated AS DOUBLE))
      comment: "Average budget allocated per MMM study"
    - name: "distinct_advertisers"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of distinct advertisers with MMM studies"
    - name: "distinct_brands"
      expr: COUNT(DISTINCT brand_profile_id)
      comment: "Number of distinct brands analyzed in MMM studies"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`analytics_budget_optimization_scenario`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget optimization scenario metrics tracking projected performance, ROAS, and resource allocation recommendations across media planning scenarios"
  source: "`advertising_ecm`.`analytics`.`budget_optimization_scenario`"
  dimensions:
    - name: "scenario_status"
      expr: scenario_status
      comment: "Current status of the optimization scenario (e.g., draft, under review, approved, implemented)"
    - name: "optimization_objective"
      expr: optimization_objective
      comment: "Primary optimization objective (e.g., maximize ROAS, maximize reach, minimize CPA)"
    - name: "client_approval_status"
      expr: client_approval_status
      comment: "Client approval status for the scenario"
    - name: "scenario_created_month"
      expr: DATE_TRUNC('MONTH', scenario_created_timestamp)
      comment: "Month when the scenario was created"
    - name: "planning_period_start_month"
      expr: DATE_TRUNC('MONTH', planning_period_start_date)
      comment: "Start month of the planning period"
  measures:
    - name: "total_scenarios"
      expr: COUNT(1)
      comment: "Total number of budget optimization scenarios created"
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget amount across all optimization scenarios"
    - name: "avg_budget_per_scenario"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average budget amount per optimization scenario"
    - name: "avg_projected_roas"
      expr: AVG(CAST(projected_roas AS DOUBLE))
      comment: "Average projected return on ad spend across scenarios"
    - name: "avg_projected_cpa"
      expr: AVG(CAST(projected_cpa AS DOUBLE))
      comment: "Average projected cost per acquisition across scenarios"
    - name: "avg_projected_cpm"
      expr: AVG(CAST(projected_cpm AS DOUBLE))
      comment: "Average projected cost per thousand impressions across scenarios"
    - name: "total_projected_revenue"
      expr: SUM(CAST(projected_revenue AS DOUBLE))
      comment: "Total projected revenue across all optimization scenarios"
    - name: "total_projected_conversions"
      expr: SUM(CAST(projected_conversions AS DOUBLE))
      comment: "Total projected conversions across all optimization scenarios"
    - name: "total_projected_impressions"
      expr: SUM(CAST(projected_impressions AS DOUBLE))
      comment: "Total projected impressions across all optimization scenarios"
    - name: "total_projected_reach"
      expr: SUM(CAST(projected_reach AS DOUBLE))
      comment: "Total projected reach across all optimization scenarios"
    - name: "client_approved_scenarios"
      expr: SUM(CASE WHEN client_approval_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Number of scenarios approved by clients"
    - name: "distinct_advertisers"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of distinct advertisers with budget optimization scenarios"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`analytics_creative_effectiveness_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Creative effectiveness study metrics measuring creative asset performance across dimensions like brand linkage, emotional resonance, message clarity, and overall effectiveness scores"
  source: "`advertising_ecm`.`analytics`.`creative_effectiveness_study`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Current status of the creative effectiveness study"
    - name: "study_type"
      expr: study_type
      comment: "Type of creative effectiveness study (e.g., pre-test, post-test, A/B test)"
    - name: "study_methodology"
      expr: study_methodology
      comment: "Methodology used for the creative effectiveness study"
    - name: "study_completion_month"
      expr: DATE_TRUNC('MONTH', study_end_date)
      comment: "Month when the creative effectiveness study was completed"
  measures:
    - name: "total_studies"
      expr: COUNT(1)
      comment: "Total number of creative effectiveness studies conducted"
    - name: "avg_overall_effectiveness_score"
      expr: AVG(CAST(overall_effectiveness_score AS DOUBLE))
      comment: "Average overall creative effectiveness score across studies"
    - name: "avg_brand_linkage_score"
      expr: AVG(CAST(brand_linkage_score AS DOUBLE))
      comment: "Average brand linkage score measuring how well creative connects to brand"
    - name: "avg_emotional_resonance_score"
      expr: AVG(CAST(emotional_resonance_score AS DOUBLE))
      comment: "Average emotional resonance score measuring emotional impact of creative"
    - name: "avg_message_clarity_score"
      expr: AVG(CAST(message_clarity_score AS DOUBLE))
      comment: "Average message clarity score measuring how clearly creative communicates"
    - name: "avg_cta_effectiveness_score"
      expr: AVG(CAST(cta_effectiveness_score AS DOUBLE))
      comment: "Average call-to-action effectiveness score"
    - name: "avg_visual_attention_score"
      expr: AVG(CAST(visual_attention_score AS DOUBLE))
      comment: "Average visual attention score measuring creative's ability to capture attention"
    - name: "total_study_cost"
      expr: SUM(CAST(study_cost AS DOUBLE))
      comment: "Total cost of creative effectiveness studies conducted"
    - name: "avg_study_cost"
      expr: AVG(CAST(study_cost AS DOUBLE))
      comment: "Average cost per creative effectiveness study"
    - name: "distinct_advertisers"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of distinct advertisers with creative effectiveness studies"
    - name: "distinct_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns with creative effectiveness studies"
    - name: "distinct_creative_assets"
      expr: COUNT(DISTINCT creative_asset_id)
      comment: "Number of distinct creative assets tested"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`analytics_insight_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Insight report delivery and quality metrics tracking report production, approval cycles, client feedback, and knowledge asset reuse across analytics deliverables"
  source: "`advertising_ecm`.`analytics`.`insight_report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Current status of the insight report (e.g., draft, under review, approved, delivered)"
    - name: "report_type"
      expr: report_type
      comment: "Type of insight report (e.g., campaign analysis, market research, competitive intelligence)"
    - name: "report_format"
      expr: report_format
      comment: "Format of the report (e.g., PDF, PowerPoint, interactive dashboard)"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality level of the report"
    - name: "language"
      expr: language
      comment: "Language of the report"
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month when the report was delivered"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month when the report was approved"
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of insight reports produced"
    - name: "distinct_advertisers"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of distinct advertisers receiving insight reports"
    - name: "distinct_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns covered in insight reports"
    - name: "distinct_brands"
      expr: COUNT(DISTINCT brand_profile_id)
      comment: "Number of distinct brands covered in insight reports"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`analytics_dashboard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dashboard usage and governance metrics tracking dashboard inventory, refresh cadence, client sharing, and platform utilization across analytics visualization assets"
  source: "`advertising_ecm`.`analytics`.`dashboard`"
  dimensions:
    - name: "dashboard_type"
      expr: dashboard_type
      comment: "Type of dashboard (e.g., campaign performance, media analytics, executive summary)"
    - name: "publication_status"
      expr: publication_status
      comment: "Publication status of the dashboard (e.g., draft, published, archived)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the dashboard"
    - name: "platform_tool"
      expr: platform_tool
      comment: "Platform or tool used to build the dashboard (e.g., Tableau, Power BI, Looker)"
    - name: "access_tier"
      expr: access_tier
      comment: "Access tier or permission level for the dashboard"
    - name: "is_client_shared"
      expr: is_client_shared
      comment: "Whether the dashboard is shared with clients"
    - name: "is_automated"
      expr: is_automated
      comment: "Whether the dashboard has automated refresh"
    - name: "refresh_cadence"
      expr: refresh_cadence
      comment: "Refresh cadence of the dashboard (e.g., real-time, daily, weekly)"
    - name: "published_month"
      expr: DATE_TRUNC('MONTH', published_timestamp)
      comment: "Month when the dashboard was published"
  measures:
    - name: "total_dashboards"
      expr: COUNT(1)
      comment: "Total number of dashboards in inventory"
    - name: "client_shared_dashboards"
      expr: SUM(CASE WHEN is_client_shared = TRUE THEN 1 ELSE 0 END)
      comment: "Number of dashboards shared with clients"
    - name: "automated_dashboards"
      expr: SUM(CASE WHEN is_automated = TRUE THEN 1 ELSE 0 END)
      comment: "Number of dashboards with automated refresh"
    - name: "distinct_advertisers"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of distinct advertisers with dashboards"
    - name: "distinct_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns with dashboards"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`analytics_competitive_intelligence`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitive intelligence metrics tracking competitor monitoring, share of voice analysis, and strategic insights across competitive landscape studies"
  source: "`advertising_ecm`.`analytics`.`competitive_intelligence`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Current status of the competitive intelligence study"
    - name: "study_type"
      expr: study_type
      comment: "Type of competitive intelligence study (e.g., share of voice, creative analysis, spend tracking)"
    - name: "intelligence_source"
      expr: intelligence_source
      comment: "Source of competitive intelligence data"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality level of the intelligence"
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Whether follow-up analysis is required"
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month when the competitive intelligence was delivered"
    - name: "analysis_period_start_month"
      expr: DATE_TRUNC('MONTH', analysis_period_start_date)
      comment: "Start month of the analysis period"
  measures:
    - name: "total_studies"
      expr: COUNT(1)
      comment: "Total number of competitive intelligence studies conducted"
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average confidence score of competitive intelligence findings"
    - name: "distinct_advertisers"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of distinct advertisers with competitive intelligence"
    - name: "distinct_brands"
      expr: COUNT(DISTINCT brand_profile_id)
      comment: "Number of distinct brands analyzed in competitive intelligence"
    - name: "follow_up_required_count"
      expr: SUM(CASE WHEN follow_up_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of competitive intelligence studies requiring follow-up"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`analytics_audience_insight`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience insight metrics tracking audience analysis, segmentation quality, and activation recommendations across consumer research and targeting studies"
  source: "`advertising_ecm`.`analytics`.`audience_insight`"
  dimensions:
    - name: "insight_type"
      expr: insight_type
      comment: "Type of audience insight (e.g., behavioral, demographic, psychographic)"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the audience insight"
    - name: "analysis_methodology"
      expr: analysis_methodology
      comment: "Methodology used for audience analysis"
    - name: "demographic_focus"
      expr: demographic_focus
      comment: "Primary demographic focus of the insight"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the audience insight"
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month when the audience insight was delivered"
  measures:
    - name: "total_insights"
      expr: COUNT(1)
      comment: "Total number of audience insights produced"
    - name: "total_audience_size"
      expr: SUM(CAST(audience_size AS DOUBLE))
      comment: "Total audience size across all insights"
    - name: "avg_audience_size"
      expr: AVG(CAST(audience_size AS DOUBLE))
      comment: "Average audience size per insight"
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level AS DOUBLE))
      comment: "Average confidence level of audience insights"
    - name: "total_sample_size"
      expr: SUM(CAST(sample_size AS DOUBLE))
      comment: "Total sample size across all audience insights"
    - name: "avg_sample_size"
      expr: AVG(CAST(sample_size AS DOUBLE))
      comment: "Average sample size per audience insight"
    - name: "distinct_advertisers"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of distinct advertisers with audience insights"
    - name: "distinct_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns with audience insights"
    - name: "distinct_audience_segments"
      expr: COUNT(DISTINCT audience_segment_id)
      comment: "Number of distinct audience segments analyzed"
$$;