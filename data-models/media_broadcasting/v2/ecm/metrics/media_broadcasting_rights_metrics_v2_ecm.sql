-- Metric views for domain: rights | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-22 23:42:33

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_license_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive KPI view over license agreements tracking deal value, royalty economics, and portfolio health for rights management steering decisions."
  source: "`vibe_media_broadcasting_v1`.`rights`.`license_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status_id
      comment: "Status of the license agreement (FK to rights_agreement_status reference) — used to slice active vs expired vs terminated deals."
    - name: "agreement_type"
      expr: agreement_type_id
      comment: "Type of license agreement (FK to rights_agreement_type reference) — e.g. acquisition, distribution, sync."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the agreement grants exclusive rights — key dimension for portfolio exclusivity analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the agreement auto-renews — used to forecast future committed deal value."
    - name: "sublicensing_allowed_flag"
      expr: sublicensing_allowed_flag
      comment: "Whether sublicensing is permitted — affects downstream revenue potential."
    - name: "music_sync_license_flag"
      expr: music_sync_license_flag
      comment: "Whether the agreement includes a music sync license obligation — used to track music clearance exposure."
    - name: "residuals_obligation_flag"
      expr: residuals_obligation_flag
      comment: "Whether the agreement carries residuals obligations — critical for talent cost forecasting."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the agreement became effective — used for cohort and vintage analysis of deal portfolios."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the agreement expires — used for renewal pipeline and expiry cliff analysis."
  measures:
    - name: "total_license_fee_value"
      expr: SUM(CAST(total_license_fee AS DOUBLE))
      comment: "Total contracted license fee value across agreements — primary revenue/cost commitment KPI for rights portfolio valuation."
    - name: "avg_license_fee_value"
      expr: AVG(CAST(total_license_fee AS DOUBLE))
      comment: "Average license fee per agreement — benchmarks deal size and informs negotiation strategy."
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments across all agreements — represents floor-level financial exposure for rights holders."
    - name: "avg_minimum_guarantee"
      expr: AVG(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Average minimum guarantee per agreement — used to assess deal structure and risk concentration."
    - name: "total_advance_payments"
      expr: SUM(CAST(advance_payment_amount AS DOUBLE))
      comment: "Total advance payments committed across agreements — cash flow and recoupment tracking KPI."
    - name: "avg_royalty_percentage"
      expr: AVG(CAST(royalty_percentage AS DOUBLE))
      comment: "Average royalty rate across license agreements — benchmarks royalty economics and informs rate negotiation."
    - name: "total_per_episode_fee"
      expr: SUM(CAST(per_episode_fee AS DOUBLE))
      comment: "Total per-episode license fees across agreements — used for episodic content cost modeling."
    - name: "active_agreement_count"
      expr: COUNT(1)
      comment: "Total number of license agreements — baseline portfolio size metric for rights management capacity planning."
    - name: "exclusive_agreement_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of exclusive license agreements — tracks exclusivity concentration risk and competitive positioning."
    - name: "auto_renewal_agreement_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of agreements set to auto-renew — used to forecast committed future deal value without renegotiation."
    - name: "residuals_bearing_agreement_count"
      expr: COUNT(CASE WHEN residuals_obligation_flag = TRUE THEN 1 END)
      comment: "Number of agreements with residuals obligations — drives talent cost liability forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_royalty_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive KPI view over royalty statements tracking gross and net royalty flows, advance recoupment, and withholding tax obligations for rights holder payment management."
  source: "`vibe_media_broadcasting_v1`.`rights`.`royalty_statement`"
  dimensions:
    - name: "statement_status"
      expr: statement_status_id
      comment: "Current status of the royalty statement (FK to statement_status reference) — used to track payment pipeline from draft to paid."
    - name: "statement_period_start_month"
      expr: DATE_TRUNC('MONTH', statement_period_start_date)
      comment: "Month the royalty statement period begins — used for period-over-period royalty trend analysis."
    - name: "statement_period_end_month"
      expr: DATE_TRUNC('MONTH', statement_period_end_date)
      comment: "Month the royalty statement period ends — used for cohort and seasonal royalty analysis."
    - name: "mechanical_royalty_flag"
      expr: mechanical_royalty_flag
      comment: "Whether the statement includes mechanical royalties — used to segment music vs non-music royalty flows."
    - name: "neighbouring_rights_flag"
      expr: neighbouring_rights_flag
      comment: "Whether the statement includes neighbouring rights — used to segment performance rights royalty flows."
    - name: "statement_frequency"
      expr: statement_frequency
      comment: "Frequency of royalty statement issuance (e.g. quarterly, annual) — used to analyze payment cadence and cash flow timing."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of royalty payment — used to analyze payment channel distribution and operational efficiency."
  measures:
    - name: "total_gross_royalty"
      expr: SUM(CAST(gross_royalty_amount AS DOUBLE))
      comment: "Total gross royalty amount across all statements — top-line royalty obligation KPI for rights holder management."
    - name: "total_net_royalty"
      expr: SUM(CAST(net_royalty_amount AS DOUBLE))
      comment: "Total net royalty payable after deductions — actual cash outflow KPI for rights payment forecasting."
    - name: "total_advance_recoupment"
      expr: SUM(CAST(advance_recoupment_amount AS DOUBLE))
      comment: "Total advance amounts recouped across statements — tracks recovery of advance payments against earned royalties."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax withheld across royalty statements — tax compliance and cash flow KPI."
    - name: "total_adjustments"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total royalty adjustments applied across statements — tracks correction volume and data quality in royalty processing."
    - name: "total_minimum_guarantee_shortfall"
      expr: SUM(CAST(minimum_guarantee_shortfall AS DOUBLE))
      comment: "Total minimum guarantee shortfall across statements — measures gap between guaranteed and earned royalties, a key financial risk indicator."
    - name: "avg_gross_royalty_per_statement"
      expr: AVG(CAST(gross_royalty_amount AS DOUBLE))
      comment: "Average gross royalty per statement — benchmarks royalty statement size and informs holder tier segmentation."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied across statements — used to assess currency risk exposure in multi-territory royalty flows."
    - name: "statement_count"
      expr: COUNT(1)
      comment: "Total number of royalty statements issued — baseline volume metric for rights payment operations capacity."
    - name: "distinct_holder_count"
      expr: COUNT(DISTINCT holder_id)
      comment: "Number of distinct rights holders receiving royalty statements — measures breadth of rights holder relationships."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_royalty_statement_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular KPI view over royalty statement lines enabling per-title, per-territory, per-exploitation-type royalty analysis for rights accounting and dispute management."
  source: "`vibe_media_broadcasting_v1`.`rights`.`royalty_statement_line`"
  dimensions:
    - name: "exploitation_type"
      expr: exploitation_type_id
      comment: "Type of exploitation generating the royalty line (FK to exploitation_type reference) — e.g. broadcast, streaming, download."
    - name: "rights_territory"
      expr: rights_territory_id
      comment: "Territory in which exploitation occurred (FK to rights_territory) — used for geographic royalty analysis."
    - name: "window_type"
      expr: window_type_id
      comment: "Rights window type for the exploitation (FK to rights_window_type) — e.g. theatrical, home video, SVOD."
    - name: "dispute_status"
      expr: dispute_status_id
      comment: "Dispute status of the royalty line (FK to rights_dispute_status) — used to track contested royalty amounts."
    - name: "holdback_status"
      expr: holdback_status_id
      comment: "Holdback status of the royalty line (FK to holdback_status) — used to identify lines blocked from payment."
    - name: "residual_type"
      expr: residual_type_id
      comment: "Type of residual on the line (FK to residual_type) — used to segment guild/union residual obligations."
    - name: "exploitation_period_start_month"
      expr: DATE_TRUNC('MONTH', exploitation_period_start_date)
      comment: "Month exploitation period began — used for period-over-period royalty trend analysis at line level."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the royalty line — used to track unpaid vs paid royalty line volumes."
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Total gross revenue base across royalty lines — top-line exploitation revenue KPI driving royalty calculations."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after allowable deductions — basis for royalty rate application and net payable calculation."
    - name: "total_calculated_royalty"
      expr: SUM(CAST(calculated_royalty_amount AS DOUBLE))
      comment: "Total calculated royalty amount across all lines — primary royalty obligation KPI for rights accounting."
    - name: "total_net_payable"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net payable royalty after all deductions and adjustments — actual cash obligation to rights holders."
    - name: "total_deductions"
      expr: SUM(CAST(deductions_amount AS DOUBLE))
      comment: "Total deductions applied across royalty lines — tracks contractual deduction utilization and impact on net payables."
    - name: "total_adjustments"
      expr: SUM(CAST(adjustments_amount AS DOUBLE))
      comment: "Total adjustments applied to royalty lines — measures correction volume and data quality in line-level royalty processing."
    - name: "total_advance_recoupment"
      expr: SUM(CAST(advance_recoupment_amount AS DOUBLE))
      comment: "Total advance recoupment applied at line level — tracks granular advance recovery against earned royalties."
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate_percentage AS DOUBLE))
      comment: "Average royalty rate percentage across lines — benchmarks effective royalty rates by territory, window, and exploitation type."
    - name: "total_units_exploited"
      expr: SUM(CAST(units_exploited AS DOUBLE))
      comment: "Total units exploited (streams, downloads, broadcasts) across royalty lines — volume KPI for exploitation intensity analysis."
    - name: "royalty_line_count"
      expr: COUNT(1)
      comment: "Total number of royalty statement lines — baseline volume metric for royalty processing operations."
    - name: "disputed_line_count"
      expr: COUNT(CASE WHEN dispute_status_id IS NOT NULL THEN 1 END)
      comment: "Number of royalty lines in dispute — tracks dispute volume and financial exposure requiring resolution."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI view over rights grants tracking grant portfolio composition, financial terms, and exclusivity structure for rights management and deal strategy."
  source: "`vibe_media_broadcasting_v1`.`rights`.`grant`"
  dimensions:
    - name: "grant_status"
      expr: grant_status_id
      comment: "Status of the rights grant (FK to rights_grant_status) — used to track active vs expired vs revoked grants."
    - name: "right_type"
      expr: right_type_id
      comment: "Type of right granted (FK to right_type) — e.g. broadcast, streaming, theatrical, home video."
    - name: "media_type"
      expr: media_type_id
      comment: "Media type covered by the grant (FK to media_type) — used to segment grants by distribution medium."
    - name: "rights_territory"
      expr: rights_territory_id
      comment: "Territory covered by the grant (FK to rights_territory) — used for geographic rights portfolio analysis."
    - name: "exclusivity_indicator"
      expr: exclusivity_indicator
      comment: "Whether the grant is exclusive — key dimension for exclusivity concentration and competitive positioning analysis."
    - name: "sublicense_permitted"
      expr: sublicense_permitted
      comment: "Whether sublicensing is permitted under the grant — affects downstream revenue potential."
    - name: "drm_required"
      expr: drm_required
      comment: "Whether DRM is required for this grant — used to assess content protection obligations."
    - name: "talent_residuals_applicable"
      expr: talent_residuals_applicable
      comment: "Whether talent residuals apply to this grant — drives talent cost liability forecasting."
    - name: "grant_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the grant becomes effective — used for grant vintage and cohort analysis."
    - name: "grant_end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the grant expires — used for expiry cliff and renewal pipeline analysis."
  measures:
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee value across all grants — floor-level financial commitment KPI for rights portfolio."
    - name: "avg_minimum_guarantee"
      expr: AVG(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Average minimum guarantee per grant — benchmarks deal floor economics across right types and territories."
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate across grants — benchmarks effective royalty economics for negotiation strategy."
    - name: "grant_count"
      expr: COUNT(1)
      comment: "Total number of rights grants — baseline portfolio size metric for rights management capacity."
    - name: "exclusive_grant_count"
      expr: COUNT(CASE WHEN exclusivity_indicator = TRUE THEN 1 END)
      comment: "Number of exclusive grants — tracks exclusivity concentration and competitive rights positioning."
    - name: "residuals_bearing_grant_count"
      expr: COUNT(CASE WHEN talent_residuals_applicable = TRUE THEN 1 END)
      comment: "Number of grants with talent residuals obligations — drives talent cost liability forecasting."
    - name: "drm_required_grant_count"
      expr: COUNT(CASE WHEN drm_required = TRUE THEN 1 END)
      comment: "Number of grants requiring DRM — used to assess content protection infrastructure obligations."
    - name: "distinct_territory_count"
      expr: COUNT(DISTINCT rights_territory_id)
      comment: "Number of distinct territories covered by grants — measures geographic breadth of rights portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_clearance_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and executive KPI view over clearance requests tracking SLA performance, clearance throughput, and financial exposure for rights clearance operations management."
  source: "`vibe_media_broadcasting_v1`.`rights`.`clearance_request`"
  dimensions:
    - name: "clearance_status"
      expr: clearance_status_id
      comment: "Current clearance status (FK to rights_clearance_status) — used to track pipeline from pending to cleared to blocked."
    - name: "priority_level"
      expr: priority_level_id
      comment: "Priority level of the clearance request (FK to rights_priority_level) — used to analyze SLA performance by priority tier."
    - name: "blocking_category"
      expr: blocking_category_id
      comment: "Category of blocking issue (FK to blocking_category) — used to identify systemic clearance blockers."
    - name: "exploitation_type"
      expr: exploitation_type_id
      comment: "Type of exploitation requiring clearance (FK to exploitation_type) — used to segment clearance volume by use type."
    - name: "music_clearance_required"
      expr: music_clearance_required
      comment: "Whether music clearance is required — used to segment music vs non-music clearance workload."
    - name: "talent_approval_required"
      expr: talent_approval_required
      comment: "Whether talent approval is required — used to identify requests with talent dependency delays."
    - name: "sla_met"
      expr: sla_met
      comment: "Whether the SLA was met for this clearance request — primary SLA compliance dimension."
    - name: "residuals_triggered"
      expr: residuals_triggered
      comment: "Whether residuals were triggered by this clearance — used to track residual liability generation."
    - name: "requested_air_date_month"
      expr: DATE_TRUNC('MONTH', requested_air_date)
      comment: "Month of the requested air date — used for clearance demand forecasting and scheduling alignment."
  measures:
    - name: "clearance_request_count"
      expr: COUNT(1)
      comment: "Total number of clearance requests — baseline volume metric for clearance operations capacity planning."
    - name: "sla_met_count"
      expr: COUNT(CASE WHEN sla_met = TRUE THEN 1 END)
      comment: "Number of clearance requests where SLA was met — numerator for SLA compliance rate calculation."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_met = FALSE THEN 1 END)
      comment: "Number of clearance requests where SLA was breached — tracks operational failure volume requiring management attention."
    - name: "total_estimated_residuals"
      expr: SUM(CAST(estimated_residuals_amount AS DOUBLE))
      comment: "Total estimated residuals exposure across clearance requests — forward-looking talent cost liability KPI."
    - name: "avg_estimated_residuals"
      expr: AVG(CAST(estimated_residuals_amount AS DOUBLE))
      comment: "Average estimated residuals per clearance request — benchmarks per-request talent cost exposure."
    - name: "total_estimated_audience_reach"
      expr: SUM(CAST(estimated_audience_reach AS DOUBLE))
      comment: "Total estimated audience reach across clearance requests — used to prioritize high-impact clearances and assess rights value."
    - name: "avg_estimated_grp"
      expr: AVG(CAST(estimated_grp AS DOUBLE))
      comment: "Average estimated GRP (Gross Rating Points) across clearance requests — links clearance pipeline to audience delivery commitments."
    - name: "music_clearance_request_count"
      expr: COUNT(CASE WHEN music_clearance_required = TRUE THEN 1 END)
      comment: "Number of requests requiring music clearance — tracks music clearance workload for sync licensing operations."
    - name: "residuals_triggered_count"
      expr: COUNT(CASE WHEN residuals_triggered = TRUE THEN 1 END)
      comment: "Number of clearance requests that triggered residuals — tracks residual liability generation volume."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_conflict`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk management KPI view over rights conflicts tracking financial exposure, resolution performance, and conflict severity for rights compliance and legal risk management."
  source: "`vibe_media_broadcasting_v1`.`rights`.`conflict`"
  dimensions:
    - name: "conflict_type"
      expr: conflict_type_id
      comment: "Type of rights conflict (FK to conflict_type) — used to categorize conflicts by nature (territorial, platform, exclusivity)."
    - name: "resolution_status"
      expr: resolution_status_id
      comment: "Current resolution status of the conflict (FK to rights_resolution_status) — used to track open vs resolved conflict pipeline."
    - name: "resolution_method"
      expr: resolution_method_id
      comment: "Method used to resolve the conflict (FK to resolution_method) — used to analyze resolution effectiveness and cost."
    - name: "platform_type"
      expr: platform_type_id
      comment: "Platform type involved in the conflict (FK to rights_platform_type) — used to identify platform-specific conflict patterns."
    - name: "rights_territory"
      expr: rights_territory_id
      comment: "Territory where the conflict occurred (FK to rights_territory) — used for geographic conflict risk analysis."
    - name: "legal_review_required_flag"
      expr: legal_review_required_flag
      comment: "Whether legal review is required — used to segment conflicts by legal complexity and resource demand."
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Whether notification was sent to affected parties — used to track communication compliance in conflict management."
    - name: "severity"
      expr: severity
      comment: "Severity level of the conflict — used to prioritize resolution resources and escalation decisions."
    - name: "detected_month"
      expr: DATE_TRUNC('MONTH', detected_timestamp)
      comment: "Month the conflict was detected — used for conflict trend analysis and detection rate monitoring."
  measures:
    - name: "conflict_count"
      expr: COUNT(1)
      comment: "Total number of rights conflicts — baseline risk volume metric for rights compliance management."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of rights conflicts — primary financial risk KPI for rights management and legal teams."
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per conflict — benchmarks conflict severity and informs risk prioritization."
    - name: "open_conflict_count"
      expr: COUNT(CASE WHEN resolution_status_id IS NOT NULL AND end_date IS NULL THEN 1 END)
      comment: "Number of conflicts without a resolution end date — proxy for open/unresolved conflict backlog requiring management attention."
    - name: "legal_review_required_count"
      expr: COUNT(CASE WHEN legal_review_required_flag = TRUE THEN 1 END)
      comment: "Number of conflicts requiring legal review — tracks legal resource demand from rights conflict pipeline."
    - name: "distinct_territory_conflict_count"
      expr: COUNT(DISTINCT rights_territory_id)
      comment: "Number of distinct territories with active conflicts — measures geographic spread of rights conflict risk."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_holdback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPI view over holdback restrictions tracking holdback portfolio, enforcement status, and windowing strategy for content availability management."
  source: "`vibe_media_broadcasting_v1`.`rights`.`holdback`"
  dimensions:
    - name: "enforcement_status"
      expr: enforcement_status_id
      comment: "Current enforcement status of the holdback (FK to enforcement_status) — used to track active vs lifted holdbacks."
    - name: "restriction_type"
      expr: restriction_type_id
      comment: "Type of restriction imposed by the holdback (FK to restriction_type) — used to categorize holdback nature."
    - name: "restricted_format"
      expr: restricted_format_id
      comment: "Format restricted by the holdback (FK to restricted_format) — used to analyze format-specific holdback exposure."
    - name: "rights_territory"
      expr: rights_territory_id
      comment: "Territory covered by the holdback (FK to rights_territory) — used for geographic holdback analysis."
    - name: "automated_enforcement_flag"
      expr: automated_enforcement_flag
      comment: "Whether holdback enforcement is automated — used to assess automation coverage and manual enforcement risk."
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Whether notification was sent for this holdback — used to track communication compliance."
    - name: "holdback_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the holdback begins — used for holdback pipeline and scheduling impact analysis."
    - name: "holdback_end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the holdback expires — used for content availability forecasting and window planning."
  measures:
    - name: "holdback_count"
      expr: COUNT(1)
      comment: "Total number of holdback restrictions — baseline volume metric for content availability constraint management."
    - name: "automated_holdback_count"
      expr: COUNT(CASE WHEN automated_enforcement_flag = TRUE THEN 1 END)
      comment: "Number of holdbacks with automated enforcement — tracks automation coverage and reduces manual enforcement risk."
    - name: "manual_holdback_count"
      expr: COUNT(CASE WHEN automated_enforcement_flag = FALSE THEN 1 END)
      comment: "Number of holdbacks requiring manual enforcement — identifies operational risk from non-automated holdback management."
    - name: "distinct_territory_holdback_count"
      expr: COUNT(DISTINCT rights_territory_id)
      comment: "Number of distinct territories with holdback restrictions — measures geographic breadth of content availability constraints."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_exploitation_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and audience KPI view over exploitation reports tracking gross/net revenue, viewing volume, and reporting compliance for rights exploitation monitoring."
  source: "`vibe_media_broadcasting_v1`.`rights`.`exploitation_report`"
  dimensions:
    - name: "exploitation_type"
      expr: exploitation_type_id
      comment: "Type of exploitation reported (FK to exploitation_type) — used to segment revenue by broadcast, streaming, download, etc."
    - name: "report_status"
      expr: report_status_id
      comment: "Status of the exploitation report (FK to rights_report_status) — used to track reporting pipeline from submitted to validated."
    - name: "report_type"
      expr: report_type_id
      comment: "Type of exploitation report (FK to report_type) — used to categorize reports by regulatory or contractual requirement."
    - name: "rights_territory"
      expr: rights_territory_id
      comment: "Territory covered by the exploitation report (FK to rights_territory) — used for geographic revenue analysis."
    - name: "reporting_period_start_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start_date)
      comment: "Month the reporting period begins — used for period-over-period exploitation revenue trend analysis."
    - name: "reporting_period_end_month"
      expr: DATE_TRUNC('MONTH', reporting_period_end_date)
      comment: "Month the reporting period ends — used for cohort and seasonal exploitation analysis."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the report was submitted — used to track reporting timeliness and compliance."
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Total gross exploitation revenue across all reports — top-line revenue KPI for rights exploitation performance."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net exploitation revenue after deductions — basis for royalty calculation and rights holder payment."
    - name: "total_streams"
      expr: SUM(CAST(total_streams AS DOUBLE))
      comment: "Total streaming plays reported across exploitation reports — volume KPI for digital exploitation intensity."
    - name: "total_viewing_hours"
      expr: SUM(CAST(total_viewing_hours AS DOUBLE))
      comment: "Total viewing hours reported — engagement depth KPI linking exploitation to audience consumption."
    - name: "total_unique_viewers"
      expr: SUM(CAST(unique_viewers AS DOUBLE))
      comment: "Total unique viewers reported across exploitation reports — reach KPI for rights exploitation audience measurement."
    - name: "exploitation_report_count"
      expr: COUNT(1)
      comment: "Total number of exploitation reports — baseline volume metric for reporting compliance monitoring."
    - name: "avg_gross_revenue_per_report"
      expr: AVG(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Average gross revenue per exploitation report — benchmarks report-level revenue and informs deal performance assessment."
    - name: "distinct_holder_count"
      expr: COUNT(DISTINCT holder_id)
      comment: "Number of distinct rights holders covered by exploitation reports — measures breadth of active exploitation relationships."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_residual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent cost and compliance KPI view over residuals tracking calculated residual obligations, payment status, and guild reporting for talent residuals management."
  source: "`vibe_media_broadcasting_v1`.`rights`.`residual`"
  dimensions:
    - name: "exploitation_type"
      expr: exploitation_type_id
      comment: "Type of exploitation triggering the residual (FK to exploitation_type) — used to segment residual obligations by use type."
    - name: "formula_type"
      expr: formula_type_id
      comment: "Residual calculation formula type (FK to formula_type) — used to analyze residual calculation methodology distribution."
    - name: "guild_union_code"
      expr: guild_union_code_id
      comment: "Guild or union code associated with the residual (FK to guild_union_code) — used to segment residual obligations by guild (SAG-AFTRA, WGA, DGA)."
    - name: "rights_territory"
      expr: rights_territory_id
      comment: "Territory in which exploitation occurred (FK to rights_territory) — used for geographic residual obligation analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the residual — used to track unpaid vs paid residual obligations."
    - name: "guild_report_submitted_flag"
      expr: guild_report_submitted_flag
      comment: "Whether the guild report was submitted for this residual — tracks guild reporting compliance."
    - name: "calculation_date_month"
      expr: DATE_TRUNC('MONTH', calculation_date)
      comment: "Month residual was calculated — used for period-over-period residual obligation trend analysis."
    - name: "payment_due_date_month"
      expr: DATE_TRUNC('MONTH', payment_due_date)
      comment: "Month residual payment is due — used for cash flow forecasting and payment deadline management."
  measures:
    - name: "total_calculated_residual"
      expr: SUM(CAST(calculated_residual_amount AS DOUBLE))
      comment: "Total calculated residual obligations — primary talent cost liability KPI for guild/union compliance management."
    - name: "total_net_payment"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net residual payments after withholding — actual cash outflow KPI for talent residuals payment management."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax on residual payments — tax compliance KPI for international residual payments."
    - name: "total_calculation_basis"
      expr: SUM(CAST(calculation_basis_amount AS DOUBLE))
      comment: "Total calculation basis amount (gross revenue base) used for residual computation — tracks exploitation revenue subject to residuals."
    - name: "avg_residual_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average residual rate percentage across residuals — benchmarks effective residual rates by guild and exploitation type."
    - name: "residual_count"
      expr: COUNT(1)
      comment: "Total number of residual obligations — baseline volume metric for guild compliance operations."
    - name: "guild_report_submitted_count"
      expr: COUNT(CASE WHEN guild_report_submitted_flag = TRUE THEN 1 END)
      comment: "Number of residuals with guild reports submitted — tracks guild reporting compliance rate."
    - name: "distinct_talent_count"
      expr: COUNT(DISTINCT talent_profile_id)
      comment: "Number of distinct talent profiles with residual obligations — measures breadth of talent residual liability."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_mechanical_royalty_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Music rights KPI view over mechanical royalty reports tracking streaming/download volumes, royalty amounts, and MLC compliance for music licensing operations."
  source: "`vibe_media_broadcasting_v1`.`rights`.`mechanical_royalty_report`"
  dimensions:
    - name: "rights_territory"
      expr: rights_territory_id
      comment: "Territory covered by the mechanical royalty report (FK to rights_territory) — used for geographic mechanical royalty analysis."
    - name: "is_mma_compliant_flag"
      expr: is_mma_compliant_flag
      comment: "Whether the report is compliant with the Music Modernization Act — tracks US MMA regulatory compliance."
    - name: "is_matched_flag"
      expr: is_matched_flag
      comment: "Whether the composition was matched to a rights holder — tracks matching rate and unmatched (black box) exposure."
    - name: "paid_flag"
      expr: paid_flag
      comment: "Whether the mechanical royalty has been paid — used to track payment completion rate."
    - name: "black_box_flag"
      expr: black_box_flag
      comment: "Whether royalties are held as black box (unmatched) — tracks unmatched royalty liability."
    - name: "report_period_start_month"
      expr: DATE_TRUNC('MONTH', report_period_start_date)
      comment: "Month the report period begins — used for period-over-period mechanical royalty trend analysis."
    - name: "report_period_end_month"
      expr: DATE_TRUNC('MONTH', report_period_end_date)
      comment: "Month the report period ends — used for cohort and seasonal mechanical royalty analysis."
  measures:
    - name: "total_gross_royalty"
      expr: SUM(CAST(gross_royalty_amount AS DOUBLE))
      comment: "Total gross mechanical royalty amount — top-line music rights obligation KPI for label and publisher management."
    - name: "total_net_royalty"
      expr: SUM(CAST(net_royalty_amount AS DOUBLE))
      comment: "Total net mechanical royalty after administration fees — actual payable amount to rights holders."
    - name: "total_mechanical_royalty"
      expr: SUM(CAST(mechanical_royalty_amount AS DOUBLE))
      comment: "Total mechanical royalty calculated — primary mechanical licensing cost KPI."
    - name: "total_administration_fee"
      expr: SUM(CAST(administration_fee_amount AS DOUBLE))
      comment: "Total administration fees charged by collecting societies — tracks MLC/PRO administration cost."
    - name: "total_interactive_streams"
      expr: SUM(CAST(interactive_stream_count AS DOUBLE))
      comment: "Total interactive streams reported — volume KPI for on-demand streaming mechanical royalty exposure."
    - name: "total_downloads"
      expr: SUM(CAST(download_count AS DOUBLE))
      comment: "Total downloads reported — volume KPI for download mechanical royalty exposure."
    - name: "total_play_count"
      expr: SUM(CAST(play_count AS DOUBLE))
      comment: "Total plays reported across all mechanical royalty reports — aggregate exploitation volume for music rights."
    - name: "avg_mechanical_rate"
      expr: AVG(CAST(mechanical_rate AS DOUBLE))
      comment: "Average mechanical royalty rate — benchmarks effective mechanical rates against statutory rates."
    - name: "avg_publisher_share_percent"
      expr: AVG(CAST(publisher_share_percent AS DOUBLE))
      comment: "Average publisher share percentage — tracks publisher vs writer split economics across the catalog."
    - name: "report_count"
      expr: COUNT(1)
      comment: "Total number of mechanical royalty reports — baseline volume metric for music rights reporting operations."
    - name: "unmatched_report_count"
      expr: COUNT(CASE WHEN black_box_flag = TRUE THEN 1 END)
      comment: "Number of reports with unmatched (black box) royalties — tracks matching failure rate and unresolved royalty liability."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_neighbouring_rights_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Music performance rights KPI view over neighbouring rights claims tracking claim amounts, dispute rates, and collection society performance for SoundExchange-style non-interactive digital rights."
  source: "`vibe_media_broadcasting_v1`.`rights`.`neighbouring_rights_claim`"
  dimensions:
    - name: "rights_territory"
      expr: rights_territory_id
      comment: "Territory of the neighbouring rights claim (FK to rights_territory) — used for geographic claim analysis."
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the neighbouring rights claim — used to track claim pipeline from filed to paid."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of neighbouring rights claim — used to categorize claims by performer vs master owner rights."
    - name: "is_disputed_flag"
      expr: is_disputed_flag
      comment: "Whether the claim is disputed — used to track dispute rate and contested claim exposure."
    - name: "is_non_interactive_flag"
      expr: is_non_interactive_flag
      comment: "Whether the claim is for non-interactive digital performance — used to segment SoundExchange-style claims."
    - name: "claim_period_start_month"
      expr: DATE_TRUNC('MONTH', claim_period_start_date)
      comment: "Month the claim period begins — used for period-over-period neighbouring rights trend analysis."
    - name: "claim_period_end_month"
      expr: DATE_TRUNC('MONTH', claim_period_end_date)
      comment: "Month the claim period ends — used for cohort and seasonal neighbouring rights analysis."
  measures:
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total neighbouring rights claim amount — primary performance rights obligation KPI for label and artist management."
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total amount formally claimed across neighbouring rights claims — tracks gross claim exposure."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid on neighbouring rights claims — tracks payment completion against claim obligations."
    - name: "avg_ownership_share_percent"
      expr: AVG(CAST(ownership_share_percent AS DOUBLE))
      comment: "Average ownership share percentage across claims — benchmarks ownership concentration in neighbouring rights portfolio."
    - name: "avg_performer_share_percent"
      expr: AVG(CAST(performer_share_percent AS DOUBLE))
      comment: "Average performer share percentage — tracks performer vs master owner split economics."
    - name: "total_play_count"
      expr: SUM(CAST(play_count AS DOUBLE))
      comment: "Total plays reported across neighbouring rights claims — volume KPI for non-interactive digital performance exposure."
    - name: "claim_count"
      expr: COUNT(1)
      comment: "Total number of neighbouring rights claims — baseline volume metric for performance rights management."
    - name: "disputed_claim_count"
      expr: COUNT(CASE WHEN is_disputed_flag = TRUE THEN 1 END)
      comment: "Number of disputed neighbouring rights claims — tracks dispute volume and contested financial exposure."
    - name: "distinct_master_recording_count"
      expr: COUNT(DISTINCT master_recording_id)
      comment: "Number of distinct master recordings with neighbouring rights claims — measures breadth of performance rights exposure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_audit_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance and compliance KPI view over rights audit sessions tracking audit coverage, financial discrepancies, and remediation performance for rights compliance management."
  source: "`vibe_media_broadcasting_v1`.`rights`.`rights_audit_session`"
  dimensions:
    - name: "audit_type"
      expr: audit_type_id
      comment: "Type of rights audit (FK to rights_audit_type) — used to categorize audits by scope and methodology."
    - name: "approval_status"
      expr: approval_status_id
      comment: "Approval status of the audit session (FK to rights_approval_status) — used to track audit sign-off pipeline."
    - name: "rightsline_sync_status"
      expr: rightsline_sync_status_id
      comment: "Sync status with Rightsline rights management system — used to track data synchronization compliance."
    - name: "remediation_required_flag"
      expr: remediation_required_flag
      comment: "Whether remediation is required following the audit — used to track audit findings requiring corrective action."
    - name: "audit_period_start_month"
      expr: DATE_TRUNC('MONTH', audit_period_start_date)
      comment: "Month the audit period begins — used for audit coverage trend analysis."
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Month the audit was scheduled to start — used for audit planning and capacity analysis."
  measures:
    - name: "audit_session_count"
      expr: COUNT(1)
      comment: "Total number of rights audit sessions — baseline volume metric for rights governance activity."
    - name: "total_financial_discrepancy"
      expr: SUM(CAST(financial_discrepancy_amount AS DOUBLE))
      comment: "Total financial discrepancy identified across audit sessions — primary financial risk KPI for rights compliance management."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across audit sessions — tracks overall rights compliance health and trend."
    - name: "total_records_reviewed"
      expr: SUM(CAST(total_records_reviewed AS DOUBLE))
      comment: "Total rights records reviewed across audit sessions — measures audit coverage and thoroughness."
    - name: "remediation_required_count"
      expr: COUNT(CASE WHEN remediation_required_flag = TRUE THEN 1 END)
      comment: "Number of audit sessions requiring remediation — tracks corrective action demand from rights audits."
    - name: "avg_financial_discrepancy"
      expr: AVG(CAST(financial_discrepancy_amount AS DOUBLE))
      comment: "Average financial discrepancy per audit session — benchmarks audit finding severity and informs audit prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_license_fee_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial operations KPI view over license fee schedules tracking payment amounts, withholding tax, and payment status for rights payment management and cash flow forecasting."
  source: "`vibe_media_broadcasting_v1`.`rights`.`license_fee_schedule`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the scheduled fee — used to track payment pipeline from scheduled to paid."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of license fee payment (e.g. advance, installment, final) — used to segment payment flows by type."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment — used to analyze payment channel distribution and operational efficiency."
    - name: "late_fee_applicable"
      expr: late_fee_applicable
      comment: "Whether a late fee applies to this payment — used to track late payment exposure and vendor relationship risk."
    - name: "payment_approval_status"
      expr: payment_approval_status
      comment: "Approval status of the payment — used to track payment authorization pipeline."
    - name: "scheduled_payment_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_payment_date)
      comment: "Month the payment is scheduled — used for cash flow forecasting and payment calendar management."
    - name: "actual_payment_date_month"
      expr: DATE_TRUNC('MONTH', actual_payment_date)
      comment: "Month the payment was actually made — used to measure payment timeliness against schedule."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total scheduled license fee payment amounts — primary cash outflow KPI for rights payment management."
    - name: "total_net_payment"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amounts after withholding — actual cash disbursement KPI for rights payment operations."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax across license fee payments — tax compliance and cash flow KPI."
    - name: "avg_late_fee_percentage"
      expr: AVG(CAST(late_fee_percentage AS DOUBLE))
      comment: "Average late fee percentage across applicable payments — benchmarks late payment penalty exposure."
    - name: "avg_withholding_tax_rate"
      expr: AVG(CAST(withholding_tax_rate AS DOUBLE))
      comment: "Average withholding tax rate applied — tracks effective withholding rate across territories and payment types."
    - name: "payment_schedule_count"
      expr: COUNT(1)
      comment: "Total number of license fee payment schedule entries — baseline volume metric for payment operations capacity."
    - name: "late_fee_applicable_count"
      expr: COUNT(CASE WHEN late_fee_applicable = TRUE THEN 1 END)
      comment: "Number of payment schedule entries with late fees applicable — tracks late payment exposure volume."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`rights_syndication_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and deal management KPI view over syndication deals tracking deal value, exclusivity, and run utilization for content syndication strategy."
  source: "`vibe_media_broadcasting_v1`.`rights`.`rights_syndication_deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status_id
      comment: "Current status of the syndication deal (FK to rights_deal_status) — used to track active vs expired vs terminated deals."
    - name: "syndication_type"
      expr: syndication_type_id
      comment: "Type of syndication deal (FK to syndication_type) — used to categorize deals by distribution model."
    - name: "licensee_type"
      expr: licensee_type_id
      comment: "Type of licensee (FK to rights_licensee_type) — used to segment deals by licensee category (broadcaster, OTT, cable)."
    - name: "rights_territory"
      expr: rights_territory_id
      comment: "Territory covered by the syndication deal (FK to rights_territory) — used for geographic syndication revenue analysis."
    - name: "exclusivity_indicator"
      expr: exclusivity_indicator
      comment: "Whether the syndication deal is exclusive — used to analyze exclusivity concentration in syndication portfolio."
    - name: "auto_renewal_indicator"
      expr: auto_renewal_indicator
      comment: "Whether the deal auto-renews — used to forecast committed future syndication revenue."
    - name: "talent_residuals_applicable"
      expr: talent_residuals_applicable
      comment: "Whether talent residuals apply to this syndication deal — drives talent cost liability forecasting."
    - name: "deal_start_month"
      expr: DATE_TRUNC('MONTH', deal_start_date)
      comment: "Month the syndication deal begins — used for deal vintage and cohort analysis."
  measures:
    - name: "total_flat_fee_value"
      expr: SUM(CAST(flat_fee_amount AS DOUBLE))
      comment: "Total flat fee value across syndication deals — primary syndication revenue KPI for content distribution strategy."
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments across syndication deals — floor-level syndication revenue KPI."
    - name: "total_per_episode_fee"
      expr: SUM(CAST(per_episode_fee_amount AS DOUBLE))
      comment: "Total per-episode fees across syndication deals — episodic syndication revenue KPI."
    - name: "avg_revenue_share_percent"
      expr: AVG(CAST(revenue_share_percent AS DOUBLE))
      comment: "Average revenue share percentage across syndication deals — benchmarks revenue share economics in syndication portfolio."
    - name: "syndication_deal_count"
      expr: COUNT(1)
      comment: "Total number of syndication deals — baseline portfolio size metric for syndication operations."
    - name: "exclusive_deal_count"
      expr: COUNT(CASE WHEN exclusivity_indicator = TRUE THEN 1 END)
      comment: "Number of exclusive syndication deals — tracks exclusivity concentration and competitive positioning."
    - name: "distinct_territory_count"
      expr: COUNT(DISTINCT rights_territory_id)
      comment: "Number of distinct territories covered by syndication deals — measures geographic breadth of syndication distribution."
$$;