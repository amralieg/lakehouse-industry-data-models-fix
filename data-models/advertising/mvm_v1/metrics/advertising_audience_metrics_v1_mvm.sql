-- Metric views for domain: audience | Business: Advertising | Version: 1 | Generated on: 2026-05-08 03:48:00

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_activation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience activation performance metrics tracking reach, match quality, cost efficiency, and delivery health across all activation events. Used by media and audience operations teams to evaluate activation effectiveness and optimize spend."
  source: "`advertising_ecm`.`audience`.`activation`"
  dimensions:
    - name: "activation_type"
      expr: activation_type
      comment: "Type of audience activation (e.g., prospecting, retargeting, suppression) used to segment performance by activation strategy."
    - name: "activation_method"
      expr: activation_method
      comment: "Method used to activate the audience (e.g., pixel, CRM upload, API sync) for diagnosing delivery and match rate differences."
    - name: "activation_status"
      expr: activation_status
      comment: "Current status of the activation (e.g., active, paused, completed, error) for operational monitoring."
    - name: "consent_framework"
      expr: consent_framework
      comment: "Privacy consent framework governing the activation (e.g., GDPR, CCPA, TCF 2.0) for compliance segmentation."
    - name: "consent_status"
      expr: consent_status
      comment: "Consent status of the audience at activation time, critical for privacy compliance reporting."
    - name: "data_source_type"
      expr: data_source_type
      comment: "Origin of the audience data (e.g., first-party, third-party, modeled) for data quality and cost analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which activation costs are denominated, enabling multi-currency cost analysis."
    - name: "activation_date"
      expr: activation_date
      comment: "Calendar date the activation was initiated, used for time-series trending of activation volume and performance."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority tier assigned to the activation, used to assess whether high-priority activations achieve better match rates and reach."
    - name: "sync_frequency"
      expr: sync_frequency
      comment: "How frequently the audience is synced to the activation platform, relevant for freshness and match rate analysis."
  measures:
    - name: "total_activations"
      expr: COUNT(1)
      comment: "Total number of activation records. Baseline volume metric for tracking activation throughput and operational scale."
    - name: "total_estimated_reach"
      expr: SUM(CAST(estimated_reach AS DOUBLE))
      comment: "Sum of estimated addressable users across all activations. Directly informs media planning capacity and audience scale decisions."
    - name: "total_matched_users"
      expr: SUM(CAST(matched_user_count AS DOUBLE))
      comment: "Total number of users successfully matched on the activation platform. Measures effective addressable audience delivered to media."
    - name: "total_unmatched_users"
      expr: SUM(CAST(unmatched_user_count AS DOUBLE))
      comment: "Total number of users that failed to match on the activation platform. High values indicate data quality or identity resolution issues requiring intervention."
    - name: "avg_match_rate_pct"
      expr: AVG(CAST(match_rate_percentage AS DOUBLE))
      comment: "Average match rate percentage across activations. A key quality KPI — declining match rates signal identity graph degradation or data supplier issues."
    - name: "avg_cost_cpm"
      expr: AVG(CAST(cost_cpm AS DOUBLE))
      comment: "Average CPM (cost per thousand impressions) across activations. Core efficiency metric for media cost benchmarking and supplier negotiation."
    - name: "total_cost_cpm_weighted"
      expr: SUM(CAST(cost_cpm AS DOUBLE))
      comment: "Sum of CPM values across activations, used as a proxy for total activation cost exposure when combined with reach metrics."
    - name: "avg_bid_modifier"
      expr: AVG(CAST(bid_modifier AS DOUBLE))
      comment: "Average bid modifier applied across activations. Indicates how aggressively the team is bidding on audience segments relative to base bids."
    - name: "match_rate_vs_estimated_reach_ratio"
      expr: ROUND(100.0 * SUM(CAST(matched_user_count AS DOUBLE)) / NULLIF(SUM(CAST(estimated_reach AS DOUBLE)), 0), 2)
      comment: "Ratio of matched users to estimated reach expressed as a percentage. Measures how well the activation platform delivers against the projected audience size — a critical data quality and platform performance KPI."
    - name: "error_activation_count"
      expr: COUNT(CASE WHEN activation_status = 'error' THEN 1 END)
      comment: "Count of activations currently in error state. Operational health KPI — elevated error counts require immediate investigation to prevent campaign delivery failures."
    - name: "active_activation_count"
      expr: COUNT(CASE WHEN activation_status = 'active' THEN 1 END)
      comment: "Count of currently active activations. Tracks live audience delivery footprint across the portfolio."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience segment inventory and quality metrics covering segment size, compliance posture, data freshness, and targeting eligibility. Used by audience strategy, data governance, and media planning teams to manage the segment library."
  source: "`advertising_ecm`.`audience`.`segment`"
  dimensions:
    - name: "audience_segment_type"
      expr: audience_segment_type
      comment: "Classification of the segment (e.g., behavioral, demographic, contextual, lookalike) for portfolio composition analysis."
    - name: "audience_segment_status"
      expr: audience_segment_status
      comment: "Operational status of the segment (e.g., active, expired, draft) for inventory health monitoring."
    - name: "activation_status"
      expr: activation_status
      comment: "Whether the segment is currently activated on a platform, used to track live deployment of the segment library."
    - name: "data_source_tier"
      expr: data_source_tier
      comment: "Quality tier of the data source (e.g., first-party, second-party, third-party) for data quality stratification."
    - name: "consent_status"
      expr: consent_status
      comment: "Consent status of the segment, critical for privacy compliance and activation eligibility gating."
    - name: "creation_method"
      expr: creation_method
      comment: "How the segment was created (e.g., rules-based, ML-modeled, manual) for methodology analysis."
    - name: "gender"
      expr: gender
      comment: "Gender targeting attribute of the segment for demographic composition analysis."
    - name: "income_tier"
      expr: income_tier
      comment: "Household income tier targeted by the segment, used for audience value and premium inventory alignment."
    - name: "refresh_cadence"
      expr: refresh_cadence
      comment: "How frequently the segment membership is refreshed, relevant for data freshness and recency analysis."
    - name: "gdpr_compliant_flag"
      expr: gdpr_compliant_flag
      comment: "Boolean flag indicating GDPR compliance of the segment. Used for compliance reporting and activation eligibility in EU markets."
    - name: "ccpa_compliant_flag"
      expr: ccpa_compliant_flag
      comment: "Boolean flag indicating CCPA compliance of the segment. Used for compliance reporting and activation eligibility in California."
  measures:
    - name: "total_segments"
      expr: COUNT(1)
      comment: "Total number of audience segments in the library. Baseline inventory metric for portfolio scale assessment."
    - name: "total_segment_size"
      expr: SUM(CAST(size AS DOUBLE))
      comment: "Total addressable audience size across all segments. Measures the aggregate reach potential of the segment library — a key input to media planning capacity."
    - name: "avg_segment_size"
      expr: AVG(CAST(size AS DOUBLE))
      comment: "Average size of audience segments. Segments that are too small reduce targeting scale; this KPI guides segment consolidation and expansion decisions."
    - name: "active_segment_count"
      expr: COUNT(CASE WHEN audience_segment_status = 'active' THEN 1 END)
      comment: "Number of segments currently in active status. Tracks the usable inventory available for campaign targeting."
    - name: "expired_segment_count"
      expr: COUNT(CASE WHEN audience_segment_status = 'expired' THEN 1 END)
      comment: "Number of expired segments. High counts indicate stale inventory requiring refresh or retirement — a data governance health KPI."
    - name: "gdpr_compliant_segment_count"
      expr: COUNT(CASE WHEN gdpr_compliant_flag = TRUE THEN 1 END)
      comment: "Number of segments flagged as GDPR compliant. Directly informs the addressable inventory available for EU market activation."
    - name: "ccpa_compliant_segment_count"
      expr: COUNT(CASE WHEN ccpa_compliant_flag = TRUE THEN 1 END)
      comment: "Number of segments flagged as CCPA compliant. Directly informs the addressable inventory available for US (California) market activation."
    - name: "gdpr_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gdpr_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of segments that are GDPR compliant. A compliance posture KPI — declining rates signal governance gaps requiring remediation before EU campaign activation."
    - name: "first_party_segment_count"
      expr: COUNT(CASE WHEN data_source_tier = 'first-party' THEN 1 END)
      comment: "Number of first-party data segments. Tracks the organization's owned data asset depth, which is strategically critical as third-party cookies deprecate."
    - name: "cross_device_segment_count"
      expr: COUNT(CASE WHEN cross_device_flag = TRUE THEN 1 END)
      comment: "Number of segments with cross-device targeting enabled. Measures the breadth of omnichannel audience reach capability."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_segment_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience segment membership metrics tracking member volume, match quality, cost per member, and activation health at the individual membership record level. Used by audience operations and data teams to optimize segment quality and cost efficiency."
  source: "`advertising_ecm`.`audience`.`segment_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the segment membership record (e.g., active, expired, suppressed) for operational health monitoring."
    - name: "activation_status"
      expr: activation_status
      comment: "Whether this membership record has been activated on a platform, used to track live deployment coverage."
    - name: "membership_source"
      expr: membership_source
      comment: "Origin of the membership record (e.g., CRM, pixel, modeled) for data provenance and quality analysis."
    - name: "identifier_type"
      expr: identifier_type
      comment: "Type of identifier used for the member (e.g., cookie, MAID, email hash, UID2) for identity graph composition analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type associated with the membership record (e.g., desktop, mobile, CTV) for cross-device reach analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the member, used for regional audience sizing and compliance gating."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which membership costs are denominated for multi-currency cost analysis."
    - name: "inclusion_flag"
      expr: inclusion_flag
      comment: "Boolean flag indicating whether the member is included (True) or excluded (False) from the segment, used to track suppression vs. targeting ratios."
    - name: "membership_start_date"
      expr: membership_start_date
      comment: "Date the membership became effective, used for cohort analysis and recency-based audience freshness tracking."
  measures:
    - name: "total_memberships"
      expr: COUNT(1)
      comment: "Total number of segment membership records. Baseline volume metric for audience scale and data ingestion throughput."
    - name: "active_membership_count"
      expr: COUNT(CASE WHEN membership_status = 'active' THEN 1 END)
      comment: "Number of currently active segment memberships. Measures the live addressable audience pool available for targeting."
    - name: "included_member_count"
      expr: COUNT(CASE WHEN inclusion_flag = TRUE THEN 1 END)
      comment: "Number of members flagged for inclusion (vs. exclusion/suppression). Tracks the net targetable audience size after suppression logic is applied."
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average confidence score of segment membership assignments. Low scores indicate poor signal quality and should trigger model retraining or data supplier review."
    - name: "avg_match_rate"
      expr: AVG(CAST(match_rate AS DOUBLE))
      comment: "Average match rate across segment membership records. Measures how effectively audience identifiers resolve on activation platforms — a core data quality KPI."
    - name: "avg_cost_per_member"
      expr: AVG(CAST(cost_per_member AS DOUBLE))
      comment: "Average cost per segment member. Key efficiency KPI for data procurement — rising costs signal need for supplier renegotiation or first-party data investment."
    - name: "total_data_cost"
      expr: SUM(CAST(cost_per_member AS DOUBLE))
      comment: "Total data cost across all membership records. Measures aggregate audience data spend, a direct input to campaign cost management and budget allocation."
    - name: "unique_audience_identifiers"
      expr: COUNT(DISTINCT audience_identifier)
      comment: "Count of distinct audience identifiers across memberships. Measures true unique reach potential, deduplicating members who may appear in multiple segments."
    - name: "high_confidence_membership_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN confidence_score >= 0.8 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of memberships with confidence score at or above 0.8. Tracks the proportion of high-quality audience signals — a data quality governance KPI."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_lookalike_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lookalike model performance and cost metrics tracking model accuracy, reach expansion, cost efficiency, and compliance posture. Used by data science, audience strategy, and finance teams to evaluate and govern the lookalike modeling program."
  source: "`advertising_ecm`.`audience`.`lookalike_model`"
  dimensions:
    - name: "model_status"
      expr: model_status
      comment: "Current operational status of the lookalike model (e.g., active, training, deprecated) for portfolio health monitoring."
    - name: "algorithm_type"
      expr: algorithm_type
      comment: "Algorithm used to build the model (e.g., logistic regression, gradient boosting, neural network) for methodology performance comparison."
    - name: "data_source_type"
      expr: data_source_type
      comment: "Type of seed data used to train the model (e.g., first-party, CRM, pixel) for data provenance and quality analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the model (e.g., national, regional, DMA) for market-level performance analysis."
    - name: "performance_metric_type"
      expr: performance_metric_type
      comment: "The primary KPI the model was optimized for (e.g., CTR, conversion rate, ROAS) for outcome-aligned performance evaluation."
    - name: "consent_compliant_flag"
      expr: consent_compliant_flag
      comment: "Boolean flag indicating whether the model was built using consent-compliant data. Critical for privacy governance and activation eligibility."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which model costs are denominated for multi-currency financial analysis."
    - name: "training_date"
      expr: training_date
      comment: "Date the model was last trained, used for model freshness and staleness analysis."
    - name: "feature_set"
      expr: feature_set
      comment: "Feature set used in model training, used to compare performance across different signal combinations."
  measures:
    - name: "total_models"
      expr: COUNT(1)
      comment: "Total number of lookalike models in the portfolio. Baseline inventory metric for modeling program scale."
    - name: "active_model_count"
      expr: COUNT(CASE WHEN model_status = 'active' THEN 1 END)
      comment: "Number of currently active lookalike models. Tracks the live modeling capacity available for campaign targeting."
    - name: "avg_validation_accuracy"
      expr: AVG(CAST(validation_accuracy AS DOUBLE))
      comment: "Average validation accuracy across all lookalike models. Primary model quality KPI — declining accuracy triggers model retraining or algorithm review."
    - name: "avg_similarity_threshold"
      expr: AVG(CAST(similarity_threshold AS DOUBLE))
      comment: "Average similarity threshold applied across models. Lower thresholds expand reach but reduce precision — this KPI informs the reach-quality tradeoff strategy."
    - name: "avg_expansion_ratio"
      expr: AVG(CAST(expansion_ratio AS DOUBLE))
      comment: "Average ratio of lookalike audience size to seed audience size. Measures how effectively models scale reach from first-party seeds — a core audience growth KPI."
    - name: "total_estimated_reach"
      expr: SUM(CAST(estimated_reach AS DOUBLE))
      comment: "Total estimated addressable reach generated by all lookalike models. Measures the aggregate audience expansion delivered by the modeling program."
    - name: "total_model_cost"
      expr: SUM(CAST(model_cost AS DOUBLE))
      comment: "Total investment in lookalike model development and licensing. Direct input to audience data cost management and ROI evaluation of the modeling program."
    - name: "avg_model_cost"
      expr: AVG(CAST(model_cost AS DOUBLE))
      comment: "Average cost per lookalike model. Used for benchmarking model development efficiency and supplier cost comparison."
    - name: "avg_baseline_performance_value"
      expr: AVG(CAST(baseline_performance_value AS DOUBLE))
      comment: "Average baseline performance value across models. Provides the benchmark against which model lift is measured — essential for evaluating incremental value of lookalike targeting."
    - name: "consent_compliant_model_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lookalike models built on consent-compliant data. A privacy governance KPI — non-compliant models cannot be activated in regulated markets, directly impacting campaign reach."
    - name: "reach_per_cost_unit"
      expr: ROUND(SUM(CAST(estimated_reach AS DOUBLE)) / NULLIF(SUM(CAST(model_cost AS DOUBLE)), 0), 2)
      comment: "Estimated reach generated per unit of model cost. Measures the cost efficiency of the lookalike modeling program — higher values indicate better return on modeling investment."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_suppression_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Suppression list governance and effectiveness metrics tracking list size, match quality, compliance posture, and cost. Used by privacy, legal, and campaign operations teams to ensure compliant audience exclusion and minimize wasted impressions."
  source: "`advertising_ecm`.`audience`.`suppression_list`"
  dimensions:
    - name: "suppression_type"
      expr: suppression_type
      comment: "Type of suppression (e.g., opt-out, frequency cap, competitor, brand safety) for categorizing suppression strategy and compliance obligations."
    - name: "list_status"
      expr: list_status
      comment: "Current operational status of the suppression list (e.g., active, archived, pending) for inventory health monitoring."
    - name: "identifier_type"
      expr: identifier_type
      comment: "Type of identifier used in the suppression list (e.g., email hash, MAID, cookie) for identity resolution analysis."
    - name: "scope_level"
      expr: scope_level
      comment: "Scope at which the suppression applies (e.g., campaign, advertiser, global) for understanding suppression coverage breadth."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the suppression list (e.g., approved, pending, rejected) for governance and compliance tracking."
    - name: "privacy_compliance_flag"
      expr: privacy_compliance_flag
      comment: "Boolean flag indicating whether the suppression list meets privacy compliance requirements. Critical for regulatory reporting."
    - name: "consent_withdrawal_flag"
      expr: consent_withdrawal_flag
      comment: "Boolean flag indicating whether the list was triggered by consent withdrawal. Used for GDPR/CCPA right-to-erasure compliance monitoring."
    - name: "platform_integration_status"
      expr: platform_integration_status
      comment: "Status of the suppression list sync to activation platforms (e.g., synced, pending, failed) for operational delivery assurance."
    - name: "source_system"
      expr: source_system
      comment: "System of record that generated the suppression list (e.g., CRM, CDP, legal portal) for data provenance tracking."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Date the suppression list became effective, used for time-series analysis of suppression coverage growth."
  measures:
    - name: "total_suppression_lists"
      expr: COUNT(1)
      comment: "Total number of suppression lists managed. Baseline inventory metric for suppression program scale and governance overhead."
    - name: "total_suppressed_users"
      expr: SUM(CAST(list_size AS DOUBLE))
      comment: "Total number of users suppressed across all lists. Measures the aggregate exclusion footprint — critical for understanding net addressable audience after suppression."
    - name: "avg_list_size"
      expr: AVG(CAST(list_size AS DOUBLE))
      comment: "Average size of suppression lists. Unusually large or small lists may indicate data quality issues or incomplete suppression coverage."
    - name: "avg_match_rate_pct"
      expr: AVG(CAST(match_rate_percentage AS DOUBLE))
      comment: "Average match rate of suppression lists on activation platforms. Low match rates mean suppressed users are still being targeted — a compliance and waste risk KPI."
    - name: "total_data_cost"
      expr: SUM(CAST(data_cost AS DOUBLE))
      comment: "Total cost of suppression list data procurement. Measures the financial investment in audience exclusion, informing build-vs-buy decisions for suppression data."
    - name: "privacy_compliant_list_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN privacy_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppression lists that meet privacy compliance requirements. A regulatory risk KPI — non-compliant lists expose the organization to legal liability."
    - name: "consent_withdrawal_list_count"
      expr: COUNT(CASE WHEN consent_withdrawal_flag = TRUE THEN 1 END)
      comment: "Number of suppression lists triggered by consent withdrawal. Tracks the volume of right-to-erasure and opt-out requests being honored — a GDPR/CCPA compliance KPI."
    - name: "active_suppression_list_count"
      expr: COUNT(CASE WHEN list_status = 'active' THEN 1 END)
      comment: "Number of currently active suppression lists. Measures the live exclusion coverage protecting brand safety and compliance obligations."
    - name: "platform_sync_failure_count"
      expr: COUNT(CASE WHEN platform_integration_status = 'failed' THEN 1 END)
      comment: "Number of suppression lists that failed to sync to activation platforms. Sync failures mean suppressed users may still be targeted — a critical operational and compliance risk KPI."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_taxonomy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience taxonomy governance and monetization metrics tracking category reach, CPM pricing, platform integration coverage, and compliance posture. Used by audience product, data governance, and revenue teams to manage the taxonomy library and optimize data monetization."
  source: "`advertising_ecm`.`audience`.`taxonomy`"
  dimensions:
    - name: "taxonomy_level"
      expr: taxonomy_level
      comment: "Hierarchical level of the taxonomy node (e.g., tier-1, tier-2, tier-3) for analyzing performance by taxonomy depth."
    - name: "data_type"
      expr: data_type
      comment: "Type of data represented by the taxonomy node (e.g., behavioral, demographic, contextual) for portfolio composition analysis."
    - name: "data_source_type"
      expr: data_source_type
      comment: "Origin of the data powering this taxonomy node (e.g., first-party, third-party, modeled) for data quality stratification."
    - name: "privacy_classification"
      expr: privacy_classification
      comment: "Privacy sensitivity classification of the taxonomy node (e.g., sensitive, standard, unrestricted) for compliance gating and activation eligibility."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the taxonomy node is currently active and available for use in targeting."
    - name: "dsp_activation_enabled"
      expr: dsp_activation_enabled
      comment: "Boolean flag indicating whether the taxonomy node can be activated via DSP. Measures the addressable activation surface of the taxonomy."
    - name: "cdp_integration_enabled"
      expr: cdp_integration_enabled
      comment: "Boolean flag indicating CDP integration availability for this taxonomy node, relevant for first-party data activation workflows."
    - name: "consent_required"
      expr: consent_required
      comment: "Boolean flag indicating whether explicit consent is required to use this taxonomy node, critical for privacy-compliant targeting."
    - name: "iab_standard_code"
      expr: iab_standard_code
      comment: "IAB standard taxonomy code for the category, enabling industry-standard benchmarking and cross-platform interoperability analysis."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Date the taxonomy node became effective, used for tracking taxonomy evolution and version adoption over time."
  measures:
    - name: "total_taxonomy_nodes"
      expr: COUNT(1)
      comment: "Total number of taxonomy nodes in the library. Baseline inventory metric for taxonomy breadth and coverage assessment."
    - name: "active_taxonomy_node_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active taxonomy nodes available for targeting. Measures the usable taxonomy inventory for campaign planning."
    - name: "dsp_enabled_node_count"
      expr: COUNT(CASE WHEN dsp_activation_enabled = TRUE THEN 1 END)
      comment: "Number of taxonomy nodes enabled for DSP activation. Measures the programmatic addressability of the taxonomy library — a key revenue enablement KPI."
    - name: "total_estimated_reach"
      expr: SUM(CAST(estimated_reach AS DOUBLE))
      comment: "Total estimated reach across all taxonomy nodes. Measures the aggregate addressable audience represented by the taxonomy library."
    - name: "avg_cpm_usd"
      expr: AVG(CAST(average_cpm_usd AS DOUBLE))
      comment: "Average CPM across all taxonomy nodes. Measures the average monetization rate of the taxonomy library — a direct revenue yield KPI."
    - name: "total_cpm_revenue_proxy"
      expr: SUM(CAST(average_cpm_usd AS DOUBLE))
      comment: "Sum of CPM values across taxonomy nodes, used as a proxy for total taxonomy monetization potential when combined with reach data."
    - name: "consent_required_node_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of taxonomy nodes requiring explicit consent. High rates indicate a privacy-sensitive taxonomy portfolio that may limit addressable reach in regulated markets."
    - name: "dsp_activation_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dsp_activation_enabled = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active taxonomy nodes that are DSP-activation enabled. Measures how much of the active taxonomy is monetizable via programmatic channels — a revenue coverage KPI."
    - name: "avg_reach_per_node"
      expr: ROUND(SUM(CAST(estimated_reach AS DOUBLE)) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 0)
      comment: "Average estimated reach per active taxonomy node. Measures the density of the taxonomy — low values may indicate over-fragmentation of the taxonomy structure."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_persona`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience persona quality and strategic value metrics tracking persona reach, conversion propensity, customer lifetime value estimates, and compliance posture. Used by brand strategy, creative, and audience planning teams to prioritize high-value personas for campaign investment."
  source: "`advertising_ecm`.`audience`.`persona`"
  dimensions:
    - name: "persona_status"
      expr: persona_status
      comment: "Current operational status of the persona (e.g., active, draft, archived) for portfolio health monitoring."
    - name: "data_source_type"
      expr: data_source_type
      comment: "Origin of the data used to construct the persona (e.g., first-party, research, modeled) for data quality and provenance analysis."
    - name: "preferred_channels"
      expr: preferred_channels
      comment: "Media channels preferred by the persona (e.g., social, video, display) for channel strategy alignment."
    - name: "consent_compliant_flag"
      expr: consent_compliant_flag
      comment: "Boolean flag indicating whether the persona was built using consent-compliant data. Required for activation eligibility in regulated markets."
    - name: "ccpa_opt_out_eligible"
      expr: ccpa_opt_out_eligible
      comment: "Boolean flag indicating whether the persona is subject to CCPA opt-out requirements, used for compliance-gated activation decisions."
    - name: "gdpr_lawful_basis"
      expr: gdpr_lawful_basis
      comment: "GDPR lawful basis for processing data associated with this persona (e.g., consent, legitimate interest) for EU compliance reporting."
    - name: "social_media_platforms"
      expr: social_media_platforms
      comment: "Social media platforms associated with the persona for social channel targeting strategy."
    - name: "last_validated_date"
      expr: last_validated_date
      comment: "Date the persona was last validated against current data, used for freshness and staleness analysis."
  measures:
    - name: "total_personas"
      expr: COUNT(1)
      comment: "Total number of audience personas in the library. Baseline inventory metric for persona portfolio scale."
    - name: "active_persona_count"
      expr: COUNT(CASE WHEN persona_status = 'active' THEN 1 END)
      comment: "Number of currently active personas available for campaign targeting and creative briefing."
    - name: "total_estimated_reach"
      expr: SUM(CAST(estimated_reach AS DOUBLE))
      comment: "Total estimated addressable reach across all personas. Measures the aggregate audience scale represented by the persona library."
    - name: "avg_estimated_reach"
      expr: AVG(CAST(estimated_reach AS DOUBLE))
      comment: "Average estimated reach per persona. Personas with very low reach may not justify dedicated creative investment — this KPI guides persona prioritization."
    - name: "avg_conversion_propensity"
      expr: AVG(CAST(conversion_propensity AS DOUBLE))
      comment: "Average conversion propensity score across personas. A strategic KPI for prioritizing high-value personas for performance campaign investment."
    - name: "avg_cltv_estimate"
      expr: AVG(CAST(cltv_estimate AS DOUBLE))
      comment: "Average customer lifetime value estimate across personas. Directly informs budget allocation decisions — higher CLTV personas justify higher CPM bids and premium creative investment."
    - name: "total_cltv_estimate"
      expr: SUM(CAST(cltv_estimate AS DOUBLE))
      comment: "Total estimated customer lifetime value across all personas. Measures the aggregate revenue potential represented by the persona library."
    - name: "consent_compliant_persona_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of personas built on consent-compliant data. A privacy governance KPI — non-compliant personas cannot be activated in regulated markets."
    - name: "high_propensity_persona_count"
      expr: COUNT(CASE WHEN conversion_propensity >= 0.7 THEN 1 END)
      comment: "Number of personas with conversion propensity at or above 0.7. Identifies the high-value targeting tier for performance campaign prioritization and budget concentration."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_behavioral_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Behavioral profile quality and targeting eligibility metrics tracking profile reach, quality scores, lookalike similarity, and consent posture. Used by audience data science and targeting teams to evaluate behavioral signal quality and optimize audience modeling inputs."
  source: "`advertising_ecm`.`audience`.`behavioral_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current operational status of the behavioral profile (e.g., active, expired, pending) for inventory health monitoring."
    - name: "profile_type"
      expr: profile_type
      comment: "Type of behavioral profile (e.g., intent, affinity, lifestyle) for portfolio composition and signal type analysis."
    - name: "engagement_level"
      expr: engagement_level
      comment: "Engagement tier of the behavioral profile (e.g., high, medium, low) for audience quality stratification."
    - name: "device_type_primary"
      expr: device_type_primary
      comment: "Primary device type associated with the behavioral profile (e.g., mobile, desktop, CTV) for cross-device reach analysis."
    - name: "consent_status"
      expr: consent_status
      comment: "Consent status of the behavioral profile, critical for privacy compliance and activation eligibility."
    - name: "targeting_eligibility_flag"
      expr: targeting_eligibility_flag
      comment: "Boolean flag indicating whether the profile is eligible for targeting. Used to measure the net usable behavioral audience pool."
    - name: "cross_device_activity_flag"
      expr: cross_device_activity_flag
      comment: "Boolean flag indicating cross-device behavioral signals are present, used to assess omnichannel audience quality."
    - name: "brand_affinity_category"
      expr: brand_affinity_category
      comment: "Primary brand affinity category of the profile, used for brand-aligned audience segmentation and targeting strategy."
    - name: "browsing_category_primary"
      expr: browsing_category_primary
      comment: "Primary browsing category of the profile for contextual and interest-based targeting alignment."
    - name: "last_observed_behavior_date"
      expr: last_observed_behavior_date
      comment: "Date of the most recent behavioral signal observed, used for recency analysis and data freshness monitoring."
  measures:
    - name: "total_behavioral_profiles"
      expr: COUNT(1)
      comment: "Total number of behavioral profiles in the library. Baseline inventory metric for behavioral data asset scale."
    - name: "targeting_eligible_profile_count"
      expr: COUNT(CASE WHEN targeting_eligibility_flag = TRUE THEN 1 END)
      comment: "Number of behavioral profiles eligible for targeting. Measures the net usable behavioral audience pool after consent and compliance gating."
    - name: "total_profile_reach_estimate"
      expr: SUM(CAST(profile_reach_estimate AS DOUBLE))
      comment: "Total estimated reach across all behavioral profiles. Measures the aggregate addressable audience represented by the behavioral data asset."
    - name: "avg_profile_quality_score"
      expr: AVG(CAST(profile_quality_score AS DOUBLE))
      comment: "Average quality score across behavioral profiles. A data asset health KPI — declining scores indicate signal degradation requiring data supplier review or model refresh."
    - name: "avg_lookalike_similarity_score"
      expr: AVG(CAST(lookalike_similarity_score AS DOUBLE))
      comment: "Average lookalike similarity score across behavioral profiles. Measures how well behavioral profiles align with seed audiences — a key input to lookalike model quality."
    - name: "targeting_eligibility_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN targeting_eligibility_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of behavioral profiles eligible for targeting. A compliance and data quality KPI — low rates indicate consent or data quality issues reducing addressable reach."
    - name: "cross_device_profile_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cross_device_activity_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of behavioral profiles with cross-device signals. Measures the omnichannel depth of the behavioral data asset — higher rates enable more effective cross-screen targeting."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_demographic_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demographic profile coverage and quality metrics tracking population size, profile confidence, consent posture, and geographic distribution. Used by audience planning, research, and compliance teams to assess demographic data asset quality and regulatory readiness."
  source: "`advertising_ecm`.`audience`.`demographic_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current operational status of the demographic profile (e.g., active, expired, pending) for inventory health monitoring."
    - name: "gender"
      expr: gender
      comment: "Gender attribute of the demographic profile for audience composition analysis."
    - name: "age_band"
      expr: age_band
      comment: "Age band of the demographic profile (e.g., 18-24, 25-34) for generational audience segmentation."
    - name: "household_income_tier"
      expr: household_income_tier
      comment: "Household income tier of the demographic profile for premium audience identification and value-based targeting."
    - name: "education_level"
      expr: education_level
      comment: "Education level of the demographic profile for audience quality and brand alignment analysis."
    - name: "parental_status"
      expr: parental_status
      comment: "Parental status of the demographic profile for family-oriented campaign targeting."
    - name: "urbanicity"
      expr: urbanicity
      comment: "Urbanicity classification (e.g., urban, suburban, rural) for geographic audience strategy."
    - name: "country_code"
      expr: country_code
      comment: "Country of the demographic profile for geographic market analysis and compliance jurisdiction determination."
    - name: "consent_status"
      expr: consent_status
      comment: "Consent status of the demographic profile, critical for privacy compliance and activation eligibility."
    - name: "psychographic_segment"
      expr: psychographic_segment
      comment: "Psychographic segment classification of the profile for values-based and lifestyle audience targeting."
  measures:
    - name: "total_demographic_profiles"
      expr: COUNT(1)
      comment: "Total number of demographic profiles in the library. Baseline inventory metric for demographic data asset scale."
    - name: "total_estimated_population"
      expr: SUM(CAST(estimated_population_size AS DOUBLE))
      comment: "Total estimated population represented by demographic profiles. Measures the aggregate addressable audience scale of the demographic data asset."
    - name: "avg_estimated_population"
      expr: AVG(CAST(estimated_population_size AS DOUBLE))
      comment: "Average estimated population size per demographic profile. Low values may indicate over-segmentation reducing targeting scale."
    - name: "avg_profile_confidence_score"
      expr: AVG(CAST(profile_confidence_score AS DOUBLE))
      comment: "Average confidence score of demographic profile assignments. A data quality KPI — low confidence scores indicate unreliable demographic signals that may degrade targeting precision."
    - name: "high_confidence_profile_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN profile_confidence_score >= 0.8 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of demographic profiles with confidence score at or above 0.8. Tracks the proportion of high-quality demographic signals available for precision targeting."
    - name: "active_profile_count"
      expr: COUNT(CASE WHEN profile_status = 'active' THEN 1 END)
      comment: "Number of currently active demographic profiles. Measures the usable demographic inventory available for campaign targeting."
    - name: "consented_profile_count"
      expr: COUNT(CASE WHEN consent_status = 'consented' THEN 1 END)
      comment: "Number of demographic profiles with confirmed consent status. Measures the privacy-compliant addressable demographic audience pool."
    - name: "consent_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_status = 'consented' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of demographic profiles with confirmed consent. A privacy governance KPI — low rates reduce the addressable audience in regulated markets and signal consent collection gaps."
$$;