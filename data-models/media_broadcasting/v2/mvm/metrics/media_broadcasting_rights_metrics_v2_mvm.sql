-- Metric views for domain: rights | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-23 04:34:26

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_clearance_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for rights clearance requests, covering SLA performance, residuals exposure, audience reach, and escalation patterns. Used by Rights Operations and Finance to monitor clearance throughput, cost exposure, and compliance risk."
  source: "`vibe_media_broadcasting_v1`.`rights`.`clearance_request`"
  dimensions:
    - name: "clearance_decision"
      expr: clearance_decision
      comment: "Outcome of the clearance review (e.g. Approved, Denied, Conditional). Enables analysis of approval rates and denial patterns by decision type."
    - name: "requesting_department"
      expr: requesting_department
      comment: "Business unit or department that submitted the clearance request. Supports departmental cost allocation and workload distribution analysis."
    - name: "platform_channel"
      expr: platform_channel
      comment: "Distribution platform or channel for which clearance is sought (e.g. Linear, OTT, Streaming). Drives platform-level rights cost and risk reporting."
    - name: "sla_met"
      expr: sla_met
      comment: "Boolean flag indicating whether the clearance request was resolved within the agreed SLA window. Key dimension for SLA compliance segmentation."
    - name: "music_clearance_required"
      expr: music_clearance_required
      comment: "Indicates whether music synchronisation clearance is required for this request. Separates music-rights-intensive requests from general clearances."
    - name: "talent_approval_required"
      expr: talent_approval_required
      comment: "Indicates whether talent approval is a prerequisite for clearance. Highlights requests with additional talent-relations complexity."
    - name: "residuals_triggered"
      expr: residuals_triggered
      comment: "Indicates whether residuals obligations are triggered by this clearance. Critical for financial liability forecasting."
    - name: "requested_air_date"
      expr: DATE_TRUNC('month', requested_air_date)
      comment: "Month of the requested air date. Enables trend analysis of clearance demand and residuals exposure over time."
    - name: "blocking_reason"
      expr: blocking_reason
      comment: "Reason a clearance request is blocked or denied. Supports root-cause analysis of clearance bottlenecks."
    - name: "escalation_reason"
      expr: escalation_reason
      comment: "Reason a clearance request was escalated for senior review. Identifies systemic issues driving escalation volume."
  measures:
    - name: "total_clearance_requests"
      expr: COUNT(1)
      comment: "Total number of clearance requests submitted. Baseline volume metric for workload and capacity planning."
    - name: "sla_compliant_requests"
      expr: COUNT(CASE WHEN sla_met = TRUE THEN 1 END)
      comment: "Number of clearance requests resolved within the agreed SLA. Numerator for SLA compliance rate calculation."
    - name: "sla_breach_requests"
      expr: COUNT(CASE WHEN sla_met = FALSE THEN 1 END)
      comment: "Number of clearance requests that breached the SLA. Directly signals operational risk and potential contractual penalties."
    - name: "escalated_requests"
      expr: COUNT(CASE WHEN escalation_reason IS NOT NULL THEN 1 END)
      comment: "Number of clearance requests that required escalation. High escalation volume indicates systemic clearance complexity or resource gaps."
    - name: "residuals_triggered_requests"
      expr: COUNT(CASE WHEN residuals_triggered = TRUE THEN 1 END)
      comment: "Number of clearance requests that triggered residuals obligations. Drives financial liability forecasting for talent and guild payments."
    - name: "total_estimated_residuals_amount"
      expr: SUM(CAST(estimated_residuals_amount AS DOUBLE))
      comment: "Total estimated residuals financial exposure across all clearance requests. Critical for budgeting talent and guild payment obligations."
    - name: "avg_estimated_residuals_per_request"
      expr: AVG(CAST(estimated_residuals_amount AS DOUBLE))
      comment: "Average estimated residuals amount per clearance request. Benchmarks per-request cost exposure for financial planning."
    - name: "total_estimated_audience_reach"
      expr: SUM(CAST(estimated_audience_reach AS DOUBLE))
      comment: "Aggregate estimated audience reach across all clearance requests. Informs rights valuation and negotiation leverage based on distribution scale."
    - name: "avg_estimated_grp"
      expr: AVG(CAST(estimated_grp AS DOUBLE))
      comment: "Average estimated Gross Rating Points (GRP) per clearance request. Measures advertising and audience impact weight for rights pricing decisions."
    - name: "music_clearance_required_requests"
      expr: COUNT(CASE WHEN music_clearance_required = TRUE THEN 1 END)
      comment: "Number of requests requiring music synchronisation clearance. Highlights music-rights complexity volume for sync licensing resource planning."
    - name: "approved_requests"
      expr: COUNT(CASE WHEN clearance_decision = 'Approved' THEN 1 END)
      comment: "Number of clearance requests with an Approved decision. Numerator for approval rate; tracks clearance success throughput."
    - name: "denied_requests"
      expr: COUNT(CASE WHEN clearance_decision = 'Denied' THEN 1 END)
      comment: "Number of clearance requests denied. Elevated denial rates signal rights availability gaps or policy misalignment."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_content_window`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational KPIs for content distribution windows, covering license fee economics, royalty rates, revenue share, and geo-blocking exposure. Used by Rights Finance and Distribution Strategy teams to optimise window economics and platform coverage."
  source: "`vibe_media_broadcasting_v1`.`rights`.`content_window`"
  dimensions:
    - name: "platform_scope"
      expr: platform_scope
      comment: "Distribution platform or scope covered by the content window (e.g. SVOD, Linear, AVOD). Enables platform-level financial performance comparison."
    - name: "active_flag"
      expr: active_flag
      comment: "Indicates whether the content window is currently active. Separates live revenue-generating windows from expired or inactive ones."
    - name: "blackout_flag"
      expr: blackout_flag
      comment: "Indicates whether a blackout restriction applies to this window. Blackout windows represent constrained distribution and potential revenue loss."
    - name: "geo_blocking_required_flag"
      expr: geo_blocking_required_flag
      comment: "Indicates whether geo-blocking enforcement is required. Drives compliance cost and technical implementation planning."
    - name: "sublicense_permitted_flag"
      expr: sublicense_permitted_flag
      comment: "Indicates whether sublicensing is permitted under this window. Sublicensable windows represent incremental revenue opportunities."
    - name: "drm_requirement"
      expr: drm_requirement
      comment: "DRM technology requirement for this window (e.g. Widevine, PlayReady). Informs technology cost and compliance overhead by DRM tier."
    - name: "window_priority"
      expr: window_priority
      comment: "Priority ranking of the distribution window (e.g. First Run, Second Run). Enables analysis of economics by window tier."
    - name: "license_fee_currency"
      expr: license_fee_currency
      comment: "Currency denomination of the license fee. Supports multi-currency financial consolidation and FX exposure analysis."
    - name: "window_open_date"
      expr: DATE_TRUNC('month', window_open_date)
      comment: "Month the content window opens. Enables trend analysis of new window activations and associated revenue commitments over time."
    - name: "window_close_date"
      expr: DATE_TRUNC('month', window_close_date)
      comment: "Month the content window closes. Supports expiry pipeline management and renewal planning."
  measures:
    - name: "total_content_windows"
      expr: COUNT(1)
      comment: "Total number of content distribution windows. Baseline volume for portfolio size and window management capacity."
    - name: "active_content_windows"
      expr: COUNT(CASE WHEN active_flag = TRUE THEN 1 END)
      comment: "Number of currently active content windows. Represents the live distribution footprint generating revenue."
    - name: "blackout_windows"
      expr: COUNT(CASE WHEN blackout_flag = TRUE THEN 1 END)
      comment: "Number of windows subject to blackout restrictions. Quantifies constrained distribution exposure and potential revenue at risk."
    - name: "total_license_fee_amount"
      expr: SUM(CAST(license_fee_amount AS DOUBLE))
      comment: "Total license fee value across all content windows. Primary revenue KPI for the content distribution portfolio."
    - name: "avg_license_fee_amount"
      expr: AVG(CAST(license_fee_amount AS DOUBLE))
      comment: "Average license fee per content window. Benchmarks per-window deal value for negotiation and pricing strategy."
    - name: "total_minimum_guarantee_amount"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments across all content windows. Represents the floor revenue obligation regardless of actual exploitation."
    - name: "avg_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate percentage across content windows. Tracks blended royalty cost burden on the distribution portfolio."
    - name: "avg_revenue_share_percent"
      expr: AVG(CAST(revenue_share_percent AS DOUBLE))
      comment: "Average revenue share percentage across content windows. Measures the blended revenue share obligation to rights holders."
    - name: "sublicensable_windows"
      expr: COUNT(CASE WHEN sublicense_permitted_flag = TRUE THEN 1 END)
      comment: "Number of windows where sublicensing is permitted. Quantifies the incremental revenue opportunity from sublicensing rights."
    - name: "geo_blocked_windows"
      expr: COUNT(CASE WHEN geo_blocking_required_flag = TRUE THEN 1 END)
      comment: "Number of windows requiring geo-blocking enforcement. Drives compliance infrastructure cost estimation."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for rights grants, covering exclusivity, holdback exposure, sublicensing, royalty economics, and minimum guarantee commitments. Used by Rights Strategy and Legal teams to manage the rights portfolio and negotiate future agreements."
  source: "`vibe_media_broadcasting_v1`.`rights`.`grant`"
  dimensions:
    - name: "exclusivity_indicator"
      expr: exclusivity_indicator
      comment: "Indicates whether the grant is exclusive. Exclusive grants command premium pricing and restrict competitive distribution."
    - name: "sublicense_permitted"
      expr: sublicense_permitted
      comment: "Indicates whether sublicensing is permitted under this grant. Sublicensable grants represent incremental monetisation opportunities."
    - name: "holdback_applicable"
      expr: holdback_applicable
      comment: "Indicates whether a holdback restriction applies to this grant. Holdback grants constrain distribution windows and affect revenue timing."
    - name: "drm_required"
      expr: drm_required
      comment: "Indicates whether DRM protection is required for this grant. Drives technology compliance cost planning."
    - name: "music_sync_license_required"
      expr: music_sync_license_required
      comment: "Indicates whether a music synchronisation licence is required. Flags grants with additional music rights complexity and cost."
    - name: "talent_residuals_applicable"
      expr: talent_residuals_applicable
      comment: "Indicates whether talent residuals obligations apply to this grant. Critical for financial liability forecasting."
    - name: "language_version"
      expr: language_version
      comment: "Language version covered by the grant (e.g. English, Spanish Dub). Enables analysis of rights portfolio breadth by language market."
    - name: "window_name"
      expr: window_name
      comment: "Name of the distribution window associated with the grant (e.g. Theatrical, Home Video, SVOD). Supports window-tier economics analysis."
    - name: "start_date"
      expr: DATE_TRUNC('year', start_date)
      comment: "Year the grant becomes effective. Enables cohort analysis of rights grants by vintage year."
    - name: "end_date"
      expr: DATE_TRUNC('year', end_date)
      comment: "Year the grant expires. Supports expiry pipeline management and renewal forecasting."
  measures:
    - name: "total_grants"
      expr: COUNT(1)
      comment: "Total number of rights grants in the portfolio. Baseline measure for portfolio size and rights coverage."
    - name: "exclusive_grants"
      expr: COUNT(CASE WHEN exclusivity_indicator = TRUE THEN 1 END)
      comment: "Number of exclusive rights grants. Exclusive grants represent premium strategic assets and competitive moats."
    - name: "grants_with_holdback"
      expr: COUNT(CASE WHEN holdback_applicable = TRUE THEN 1 END)
      comment: "Number of grants subject to holdback restrictions. Quantifies the portion of the portfolio with constrained distribution timing."
    - name: "grants_with_residuals"
      expr: COUNT(CASE WHEN talent_residuals_applicable = TRUE THEN 1 END)
      comment: "Number of grants triggering talent residuals obligations. Drives financial liability forecasting for talent and guild payments."
    - name: "sublicensable_grants"
      expr: COUNT(CASE WHEN sublicense_permitted = TRUE THEN 1 END)
      comment: "Number of grants where sublicensing is permitted. Represents the monetisable sublicensing opportunity within the rights portfolio."
    - name: "total_minimum_guarantee_amount"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments across all grants. Represents the contractual floor payment obligation to rights holders."
    - name: "avg_minimum_guarantee_amount"
      expr: AVG(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Average minimum guarantee per grant. Benchmarks per-deal financial commitment for negotiation strategy."
    - name: "avg_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate percentage across all grants. Tracks the blended royalty cost burden on the rights portfolio."
    - name: "distinct_media_assets_granted"
      expr: COUNT(DISTINCT media_asset_id)
      comment: "Number of distinct media assets covered by rights grants. Measures the breadth of the content portfolio under active rights management."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_license_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and contractual KPIs for license agreements, covering total fee commitments, royalty economics, advance payments, per-episode fees, and agreement lifecycle. Used by Rights Finance, Legal, and Business Affairs to manage contract value, renewal risk, and financial obligations."
  source: "`vibe_media_broadcasting_v1`.`rights`.`license_agreement`"
  dimensions:
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Indicates whether the license agreement grants exclusive rights. Exclusive agreements command premium fees and restrict competitive licensing."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the agreement auto-renews. Auto-renewal agreements represent recurring committed revenue or cost."
    - name: "sublicensing_allowed_flag"
      expr: sublicensing_allowed_flag
      comment: "Indicates whether sublicensing is permitted. Sublicensable agreements represent incremental revenue opportunities."
    - name: "residuals_obligation_flag"
      expr: residuals_obligation_flag
      comment: "Indicates whether residuals obligations are embedded in the agreement. Drives financial liability forecasting."
    - name: "clearance_required_flag"
      expr: clearance_required_flag
      comment: "Indicates whether clearance is required before exploitation. Flags agreements with additional operational overhead."
    - name: "music_sync_license_flag"
      expr: music_sync_license_flag
      comment: "Indicates whether a music synchronisation licence is included. Separates music-rights-intensive agreements for cost analysis."
    - name: "mechanical_license_flag"
      expr: mechanical_license_flag
      comment: "Indicates whether a mechanical licence is included. Relevant for music publishing cost tracking."
    - name: "payment_schedule_type"
      expr: payment_schedule_type
      comment: "Type of payment schedule (e.g. Upfront, Quarterly, Per-Episode). Drives cash flow forecasting and treasury planning."
    - name: "royalty_calculation_method"
      expr: royalty_calculation_method
      comment: "Method used to calculate royalties (e.g. Net Revenue, Gross Revenue). Affects royalty liability magnitude and comparability."
    - name: "governing_law_jurisdiction"
      expr: governing_law_jurisdiction
      comment: "Legal jurisdiction governing the agreement. Supports legal risk and compliance analysis by jurisdiction."
    - name: "effective_date"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the license agreement becomes effective. Enables vintage cohort analysis of agreement economics."
    - name: "expiry_date"
      expr: DATE_TRUNC('year', expiry_date)
      comment: "Year the license agreement expires. Supports renewal pipeline management and revenue cliff forecasting."
  measures:
    - name: "total_license_agreements"
      expr: COUNT(1)
      comment: "Total number of license agreements. Baseline portfolio size metric for Business Affairs capacity and contract management."
    - name: "total_license_fee_value"
      expr: SUM(CAST(total_license_fee AS DOUBLE))
      comment: "Total contracted license fee value across all agreements. Primary revenue KPI for the rights licensing portfolio."
    - name: "avg_license_fee_value"
      expr: AVG(CAST(total_license_fee AS DOUBLE))
      comment: "Average license fee per agreement. Benchmarks per-deal value for negotiation strategy and portfolio mix analysis."
    - name: "total_advance_payment_amount"
      expr: SUM(CAST(advance_payment_amount AS DOUBLE))
      comment: "Total advance payments committed across all license agreements. Represents upfront cash outflow and recoupment liability."
    - name: "total_minimum_guarantee_amount"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee obligations across all agreements. Represents the contractual floor payment regardless of actual exploitation."
    - name: "avg_royalty_percentage"
      expr: AVG(CAST(royalty_percentage AS DOUBLE))
      comment: "Average royalty percentage across all license agreements. Tracks the blended royalty cost rate across the portfolio."
    - name: "total_per_episode_fee_commitment"
      expr: SUM(CAST(per_episode_fee AS DOUBLE))
      comment: "Total per-episode fee commitments across all agreements. Critical for episodic content financial planning and production budget alignment."
    - name: "avg_per_episode_fee"
      expr: AVG(CAST(per_episode_fee AS DOUBLE))
      comment: "Average per-episode fee across agreements with episodic fee structures. Benchmarks episodic rights cost for content acquisition decisions."
    - name: "exclusive_agreements"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of exclusive license agreements. Exclusive agreements represent premium strategic commitments and competitive barriers."
    - name: "auto_renewal_agreements"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of agreements set to auto-renew. Represents recurring committed revenue or cost exposure requiring proactive management."
    - name: "agreements_with_residuals_obligation"
      expr: COUNT(CASE WHEN residuals_obligation_flag = TRUE THEN 1 END)
      comment: "Number of agreements carrying residuals obligations. Quantifies the scope of talent and guild payment liability across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_royalty_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPIs for royalty statements, covering gross and net royalty payments, advance recoupment, withholding tax, adjustments, and dispute activity. Used by Rights Finance and Royalty Accounting teams to manage payment accuracy, dispute resolution, and financial close."
  source: "`vibe_media_broadcasting_v1`.`rights`.`royalty_statement`"
  dimensions:
    - name: "statement_status"
      expr: statement_status
      comment: "Current status of the royalty statement (e.g. Draft, Approved, Paid, Disputed). Enables pipeline and aging analysis of royalty obligations."
    - name: "statement_frequency"
      expr: statement_frequency
      comment: "Frequency at which statements are issued (e.g. Monthly, Quarterly, Annual). Supports cash flow forecasting by payment cycle."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the royalty statement. Supports multi-currency financial consolidation and FX exposure analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of royalty payment (e.g. Wire Transfer, ACH). Supports treasury and payment operations analysis."
    - name: "mechanical_royalty_flag"
      expr: mechanical_royalty_flag
      comment: "Indicates whether the statement includes mechanical royalties. Separates music mechanical royalty obligations from other royalty types."
    - name: "neighbouring_rights_flag"
      expr: neighbouring_rights_flag
      comment: "Indicates whether the statement includes neighbouring rights royalties. Relevant for broadcast and performance rights financial tracking."
    - name: "statement_period_start_date"
      expr: DATE_TRUNC('quarter', statement_period_start_date)
      comment: "Quarter of the royalty statement period start. Enables quarterly trend analysis of royalty payment volumes and amounts."
    - name: "statement_issue_date"
      expr: DATE_TRUNC('month', statement_issue_date)
      comment: "Month the royalty statement was issued. Supports timeliness analysis and financial close calendar management."
  measures:
    - name: "total_royalty_statements"
      expr: COUNT(1)
      comment: "Total number of royalty statements issued. Baseline volume metric for royalty accounting workload and payment pipeline."
    - name: "total_gross_royalty_amount"
      expr: SUM(CAST(gross_royalty_amount AS DOUBLE))
      comment: "Total gross royalty amount across all statements before deductions. Primary financial KPI for total royalty obligation magnitude."
    - name: "total_net_royalty_amount"
      expr: SUM(CAST(net_royalty_amount AS DOUBLE))
      comment: "Total net royalty amount after deductions and adjustments. Represents actual cash outflow to rights holders."
    - name: "total_advance_recoupment_amount"
      expr: SUM(CAST(advance_recoupment_amount AS DOUBLE))
      comment: "Total advance recoupment applied across all statements. Tracks the pace of advance recovery against royalty obligations."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax withheld across all royalty statements. Critical for tax compliance reporting and cross-border payment management."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to royalty statements. Large adjustment volumes signal data quality or contractual interpretation issues."
    - name: "total_minimum_guarantee_shortfall"
      expr: SUM(CAST(minimum_guarantee_shortfall AS DOUBLE))
      comment: "Total minimum guarantee shortfall across all statements. Quantifies the gap between actual royalties earned and guaranteed minimums — a direct financial liability."
    - name: "avg_net_royalty_per_statement"
      expr: AVG(CAST(net_royalty_amount AS DOUBLE))
      comment: "Average net royalty amount per statement. Benchmarks per-statement payment size for anomaly detection and holder-level analysis."
    - name: "disputed_statements"
      expr: COUNT(CASE WHEN dispute_reason IS NOT NULL THEN 1 END)
      comment: "Number of royalty statements with an active dispute. Elevated dispute counts signal contractual ambiguity or calculation errors requiring resolution."
    - name: "paid_statements"
      expr: COUNT(CASE WHEN statement_status = 'Paid' THEN 1 END)
      comment: "Number of royalty statements with Paid status. Tracks payment completion rate and outstanding obligations."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied across royalty statements. Supports FX impact analysis on royalty payment obligations."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_royalty_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance and financial KPIs for royalty rules, covering rate structures, minimum guarantees, recoupment thresholds, deduction policies, and rule lifecycle. Used by Rights Finance and Legal teams to audit royalty rule coverage, identify rate anomalies, and ensure contractual compliance."
  source: "`vibe_media_broadcasting_v1`.`rights`.`royalty_rule`"
  dimensions:
    - name: "royalty_type"
      expr: royalty_type
      comment: "Type of royalty covered by the rule (e.g. Mechanical, Performance, Sync). Enables analysis of royalty obligation by rights category."
    - name: "royalty_rule_status"
      expr: royalty_rule_status
      comment: "Current status of the royalty rule (e.g. Active, Expired, Pending). Separates live rules from inactive ones for compliance auditing."
    - name: "calculation_basis"
      expr: calculation_basis
      comment: "Basis for royalty calculation (e.g. Gross Revenue, Net Revenue, Per Unit). Affects comparability of rate values across rules."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of royalty payments under this rule (e.g. Monthly, Quarterly). Drives cash flow forecasting by payment cycle."
    - name: "recoupment_flag"
      expr: recoupment_flag
      comment: "Indicates whether advance recoupment applies under this rule. Recoupment rules affect net cash outflow timing."
    - name: "deduction_allowed_flag"
      expr: deduction_allowed_flag
      comment: "Indicates whether deductions are permitted under this rule. Deduction-eligible rules reduce net royalty obligations."
    - name: "audit_rights_flag"
      expr: audit_rights_flag
      comment: "Indicates whether the rights holder has audit rights under this rule. Audit-eligible rules carry additional compliance and disclosure obligations."
    - name: "territory_scope"
      expr: territory_scope
      comment: "Geographic scope of the royalty rule. Enables analysis of royalty rate structures by territory or region."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the royalty rule becomes effective. Enables vintage analysis of rule economics and rate evolution over time."
  measures:
    - name: "total_royalty_rules"
      expr: COUNT(1)
      comment: "Total number of royalty rules in the system. Baseline measure for rules governance coverage and complexity."
    - name: "active_royalty_rules"
      expr: COUNT(CASE WHEN royalty_rule_status = 'Active' THEN 1 END)
      comment: "Number of currently active royalty rules. Represents the live rules governing royalty calculations across the portfolio."
    - name: "avg_rate_value"
      expr: AVG(CAST(rate_value AS DOUBLE))
      comment: "Average royalty rate value across all rules. Tracks the blended rate level for benchmarking and anomaly detection."
    - name: "total_minimum_guarantee_amount"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee amounts embedded in royalty rules. Represents the contractual floor payment obligations governed by these rules."
    - name: "avg_minimum_guarantee_amount"
      expr: AVG(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Average minimum guarantee per royalty rule. Benchmarks per-rule floor commitment for financial planning."
    - name: "total_maximum_cap_amount"
      expr: SUM(CAST(maximum_cap_amount AS DOUBLE))
      comment: "Total maximum cap amounts across royalty rules. Quantifies the ceiling on royalty obligations, limiting financial exposure."
    - name: "avg_deduction_percentage"
      expr: AVG(CASE WHEN deduction_allowed_flag = TRUE THEN CAST(deduction_percentage AS DOUBLE) END)
      comment: "Average deduction percentage among rules where deductions are permitted. Measures the effective deduction benefit reducing net royalty obligations."
    - name: "rules_with_recoupment"
      expr: COUNT(CASE WHEN recoupment_flag = TRUE THEN 1 END)
      comment: "Number of royalty rules with advance recoupment provisions. Quantifies the scope of recoupment mechanics affecting net payment timing."
    - name: "rules_with_audit_rights"
      expr: COUNT(CASE WHEN audit_rights_flag = TRUE THEN 1 END)
      comment: "Number of royalty rules granting audit rights to the rights holder. Audit-eligible rules carry compliance disclosure obligations and audit cost exposure."
    - name: "avg_recoupment_threshold"
      expr: AVG(CASE WHEN recoupment_flag = TRUE THEN CAST(recoupment_threshold AS DOUBLE) END)
      comment: "Average recoupment threshold among rules with recoupment provisions. Tracks the typical advance amount that must be recovered before royalties are paid out."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_holder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for rights holders, covering financial terms, royalty economics, credit exposure, and holder classification. Used by Rights Finance and Business Affairs to manage holder relationships, financial risk, and payment obligations."
  source: "`vibe_media_broadcasting_v1`.`rights`.`holder`"
  dimensions:
    - name: "guild_affiliation"
      expr: guild_affiliation
      comment: "Guild or union affiliation of the rights holder (e.g. WGA, SAG-AFTRA, ASCAP). Drives guild-specific royalty and residuals obligation analysis."
    - name: "most_favored_nations_flag"
      expr: most_favored_nations_flag
      comment: "Indicates whether the holder has Most Favored Nations (MFN) status. MFN holders require rate parity with the best terms offered to any comparable holder."
    - name: "music_publisher_flag"
      expr: music_publisher_flag
      comment: "Indicates whether the holder is a music publisher. Separates music publishing rights holders for sync and mechanical royalty analysis."
    - name: "record_label_flag"
      expr: record_label_flag
      comment: "Indicates whether the holder is a record label. Separates master recording rights holders for neighbouring rights analysis."
    - name: "audit_rights_flag"
      expr: audit_rights_flag
      comment: "Indicates whether the holder has contractual audit rights. Audit-eligible holders carry additional compliance and disclosure obligations."
    - name: "payment_method"
      expr: payment_method
      comment: "Preferred payment method for the holder (e.g. Wire Transfer, ACH). Supports treasury and payment operations planning."
    - name: "preferred_currency"
      expr: preferred_currency
      comment: "Preferred payment currency of the rights holder. Supports multi-currency payment planning and FX exposure analysis."
    - name: "royalty_calculation_method"
      expr: royalty_calculation_method
      comment: "Method used to calculate royalties for this holder (e.g. Net Revenue, Gross Revenue). Affects royalty liability magnitude and comparability."
    - name: "territory_of_incorporation"
      expr: territory_of_incorporation
      comment: "Territory where the rights holder is incorporated. Drives withholding tax applicability and cross-border payment compliance."
    - name: "relationship_start_date"
      expr: DATE_TRUNC('year', relationship_start_date)
      comment: "Year the holder relationship commenced. Enables cohort analysis of holder economics and relationship longevity."
  measures:
    - name: "total_rights_holders"
      expr: COUNT(1)
      comment: "Total number of rights holders in the system. Baseline measure for portfolio breadth and relationship management scope."
    - name: "mfn_holders"
      expr: COUNT(CASE WHEN most_favored_nations_flag = TRUE THEN 1 END)
      comment: "Number of holders with Most Favored Nations status. MFN holders require rate parity monitoring and represent elevated contractual risk."
    - name: "holders_with_audit_rights"
      expr: COUNT(CASE WHEN audit_rights_flag = TRUE THEN 1 END)
      comment: "Number of holders with contractual audit rights. Quantifies the compliance disclosure obligation and audit cost exposure across the holder portfolio."
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all rights holders. Represents aggregate financial exposure from credit-based payment arrangements."
    - name: "avg_default_royalty_rate"
      expr: AVG(CAST(default_royalty_rate AS DOUBLE))
      comment: "Average default royalty rate across all rights holders. Tracks the blended royalty cost rate for the holder portfolio."
    - name: "total_minimum_guarantee_threshold"
      expr: SUM(CAST(minimum_guarantee_threshold AS DOUBLE))
      comment: "Total minimum guarantee thresholds across all holders. Represents the aggregate floor payment obligation to the holder portfolio."
    - name: "avg_tax_withholding_rate"
      expr: AVG(CAST(tax_withholding_rate AS DOUBLE))
      comment: "Average withholding tax rate across all rights holders. Tracks the blended tax withholding burden on royalty payments for treasury planning."
    - name: "music_publisher_holders"
      expr: COUNT(CASE WHEN music_publisher_flag = TRUE THEN 1 END)
      comment: "Number of rights holders classified as music publishers. Quantifies the music publishing rights exposure within the holder portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_holdback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and strategic KPIs for rights holdbacks, covering holdback scope, enforcement automation, waiver activity, and exclusivity constraints. Used by Rights Operations and Distribution Strategy teams to manage holdback compliance, waiver risk, and windowing strategy."
  source: "`vibe_media_broadcasting_v1`.`rights`.`holdback`"
  dimensions:
    - name: "exclusivity_scope"
      expr: exclusivity_scope
      comment: "Scope of exclusivity covered by the holdback (e.g. Platform, Territory, Media Type). Enables analysis of holdback constraints by exclusivity dimension."
    - name: "restricted_platform"
      expr: restricted_platform
      comment: "Platform restricted by the holdback (e.g. Netflix, Hulu, Linear). Identifies which distribution platforms are constrained by holdback obligations."
    - name: "restricted_channel"
      expr: restricted_channel
      comment: "Channel restricted by the holdback. Supports channel-level distribution constraint analysis."
    - name: "automated_enforcement_flag"
      expr: automated_enforcement_flag
      comment: "Indicates whether holdback enforcement is automated. Non-automated holdbacks carry higher compliance risk from manual oversight gaps."
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Indicates whether a holdback notification has been sent to relevant parties. Tracks communication compliance for holdback obligations."
    - name: "start_date"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the holdback period begins. Enables trend analysis of holdback activations and their impact on distribution availability."
    - name: "end_date"
      expr: DATE_TRUNC('month', end_date)
      comment: "Month the holdback period ends. Supports holdback expiry pipeline management and distribution window planning."
  measures:
    - name: "total_holdbacks"
      expr: COUNT(1)
      comment: "Total number of holdback records. Baseline measure for holdback portfolio size and compliance management scope."
    - name: "automated_holdbacks"
      expr: COUNT(CASE WHEN automated_enforcement_flag = TRUE THEN 1 END)
      comment: "Number of holdbacks with automated enforcement. Higher automation rates reduce compliance risk from manual oversight failures."
    - name: "manual_enforcement_holdbacks"
      expr: COUNT(CASE WHEN automated_enforcement_flag = FALSE THEN 1 END)
      comment: "Number of holdbacks requiring manual enforcement. Manual holdbacks represent elevated compliance risk and operational overhead."
    - name: "holdbacks_with_waiver"
      expr: COUNT(CASE WHEN waiver_approved_by IS NOT NULL THEN 1 END)
      comment: "Number of holdbacks where a waiver has been approved. Waiver volume indicates the frequency of holdback exceptions and associated contractual risk."
    - name: "notification_sent_holdbacks"
      expr: COUNT(CASE WHEN notification_sent_flag = TRUE THEN 1 END)
      comment: "Number of holdbacks for which notifications have been sent. Tracks communication compliance across the holdback portfolio."
    - name: "distinct_media_assets_under_holdback"
      expr: COUNT(DISTINCT media_asset_id)
      comment: "Number of distinct media assets subject to holdback restrictions. Quantifies the breadth of content distribution constrained by holdback obligations."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory and market KPIs for rights territories, covering compliance flags, market maturity, tax rates, and population reach. Used by Rights Strategy and Regulatory Affairs teams to prioritise territory expansion, manage compliance obligations, and assess market opportunity."
  source: "`vibe_media_broadcasting_v1`.`rights`.`territory`"
  dimensions:
    - name: "territory_group"
      expr: territory_group
      comment: "Regional grouping of the territory (e.g. EMEA, APAC, LATAM). Enables regional aggregation of rights portfolio and compliance metrics."
    - name: "ott_market_maturity"
      expr: ott_market_maturity
      comment: "Maturity level of the OTT market in the territory (e.g. Emerging, Developing, Mature). Drives territory prioritisation for digital distribution investment."
    - name: "gdpr_applicable_flag"
      expr: gdpr_applicable_flag
      comment: "Indicates whether GDPR applies in this territory. GDPR territories carry additional data privacy compliance obligations."
    - name: "coppa_applicable_flag"
      expr: coppa_applicable_flag
      comment: "Indicates whether COPPA applies in this territory. COPPA territories require additional content and data handling compliance."
    - name: "vat_applicable_flag"
      expr: vat_applicable_flag
      comment: "Indicates whether VAT applies in this territory. VAT territories affect net royalty and license fee economics."
    - name: "quota_requirement_flag"
      expr: quota_requirement_flag
      comment: "Indicates whether local content quota requirements apply. Quota territories constrain content scheduling and require local production investment."
    - name: "blackout_restricted_flag"
      expr: blackout_restricted_flag
      comment: "Indicates whether blackout restrictions apply in this territory. Blackout territories represent constrained distribution and potential revenue loss."
    - name: "holdback_eligible_flag"
      expr: holdback_eligible_flag
      comment: "Indicates whether holdback restrictions are applicable in this territory. Drives windowing strategy complexity by territory."
    - name: "language_primary"
      expr: language_primary
      comment: "Primary language of the territory. Supports language-version rights planning and localisation investment decisions."
  measures:
    - name: "total_territories"
      expr: COUNT(1)
      comment: "Total number of territories in the rights system. Baseline measure for geographic rights portfolio coverage."
    - name: "gdpr_applicable_territories"
      expr: COUNT(CASE WHEN gdpr_applicable_flag = TRUE THEN 1 END)
      comment: "Number of territories where GDPR applies. Quantifies the scope of data privacy compliance obligations across the rights portfolio."
    - name: "quota_requirement_territories"
      expr: COUNT(CASE WHEN quota_requirement_flag = TRUE THEN 1 END)
      comment: "Number of territories with local content quota requirements. Drives local production investment planning and scheduling compliance."
    - name: "blackout_restricted_territories"
      expr: COUNT(CASE WHEN blackout_restricted_flag = TRUE THEN 1 END)
      comment: "Number of territories with blackout restrictions. Quantifies the geographic scope of constrained distribution."
    - name: "total_population_reach"
      expr: SUM(CAST(population AS DOUBLE))
      comment: "Total addressable population across all territories in the rights portfolio. Measures the aggregate audience reach potential for rights exploitation."
    - name: "avg_internet_penetration_percent"
      expr: AVG(CAST(internet_penetration_percent AS DOUBLE))
      comment: "Average internet penetration rate across territories. Proxy for digital distribution addressable market size and OTT revenue potential."
    - name: "avg_vat_rate_percent"
      expr: AVG(CASE WHEN vat_applicable_flag = TRUE THEN CAST(vat_rate_percent AS DOUBLE) END)
      comment: "Average VAT rate among territories where VAT applies. Informs net revenue calculations and pricing strategy for VAT-applicable markets."
    - name: "avg_withholding_tax_rate_percent"
      expr: AVG(CAST(withholding_tax_rate_percent AS DOUBLE))
      comment: "Average withholding tax rate across all territories. Tracks the blended cross-border tax burden on royalty and license fee payments."
    - name: "avg_quota_percentage"
      expr: AVG(CASE WHEN quota_requirement_flag = TRUE THEN CAST(quota_percentage AS DOUBLE) END)
      comment: "Average local content quota percentage among territories with quota requirements. Benchmarks the local content obligation intensity for scheduling and production planning."
$$;