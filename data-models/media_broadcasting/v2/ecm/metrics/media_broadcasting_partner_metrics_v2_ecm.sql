-- Metric views for domain: partner | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-22 23:42:33

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_acquisition_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for content acquisition deals — tracks deal value, minimum guarantees, revenue share commitments, and exclusivity exposure across the acquisition portfolio."
  source: "`vibe_media_broadcasting_v1`.`partner`.`acquisition_deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status_id
      comment: "Current status of the acquisition deal (active, expired, pending) via FK to partner_deal_status reference."
    - name: "deal_type"
      expr: deal_type_id
      comment: "Type of acquisition deal (first-run, library, co-production, etc.) via FK to partner_deal_type reference."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the deal carries exclusivity restrictions, used to segment exclusive vs. non-exclusive deal economics."
    - name: "sublicensing_allowed_flag"
      expr: sublicensing_allowed_flag
      comment: "Whether sublicensing is permitted under this deal, affecting downstream revenue potential."
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Whether the deal includes a renewal option, used to forecast future commitment exposure."
    - name: "deal_effective_date"
      expr: DATE_TRUNC('month', deal_effective_date)
      comment: "Month the deal became effective, used for cohort and vintage analysis of acquisition spend."
    - name: "deal_expiration_date"
      expr: DATE_TRUNC('quarter', deal_expiration_date)
      comment: "Quarter the deal expires, used to forecast renewal pipeline and expiring commitment exposure."
    - name: "windowing_strategy"
      expr: windowing_strategy
      comment: "Windowing strategy applied to the deal (SVOD-first, linear-first, etc.) for rights utilisation analysis."
  measures:
    - name: "total_deal_value"
      expr: SUM(CAST(deal_value_amount AS DOUBLE))
      comment: "Total contracted deal value across all acquisition deals. Core investment KPI for content acquisition spend."
    - name: "avg_deal_value"
      expr: AVG(CAST(deal_value_amount AS DOUBLE))
      comment: "Average deal value per acquisition deal. Benchmarks deal size and informs negotiation strategy."
    - name: "total_minimum_guarantee_committed"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee obligations committed across all acquisition deals. Critical for cash-flow forecasting and balance-sheet exposure."
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage across acquisition deals. Informs margin impact of revenue-share structures vs. flat-fee deals."
    - name: "total_runtime_hours_acquired"
      expr: SUM(CAST(total_runtime_hours AS DOUBLE))
      comment: "Total content runtime hours acquired across all deals. Measures content volume secured for scheduling and distribution."
    - name: "avg_runtime_hours_per_deal"
      expr: AVG(CAST(total_runtime_hours AS DOUBLE))
      comment: "Average runtime hours per acquisition deal. Used to benchmark content volume efficiency per deal."
    - name: "deal_count"
      expr: COUNT(1)
      comment: "Total number of acquisition deals. Baseline volume metric for deal pipeline and portfolio size."
    - name: "exclusive_deal_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of deals with exclusivity clauses. Tracks exclusivity exposure and competitive lock-in commitments."
    - name: "exclusive_deal_value"
      expr: SUM(CASE WHEN exclusivity_flag = TRUE THEN deal_value_amount ELSE 0 END)
      comment: "Total deal value tied to exclusive agreements. Quantifies financial exposure from exclusivity commitments."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_acquisition_deal_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level KPIs for content acquisition deal lines — tracks per-title license fees, royalty rates, minimum guarantees, and delivery status across the acquisition line portfolio."
  source: "`vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line`"
  dimensions:
    - name: "line_status"
      expr: line_status_id
      comment: "Current status of the deal line (active, delivered, expired) via FK to partner_line_status reference."
    - name: "delivery_status"
      expr: delivery_status_id
      comment: "Delivery status of the content for this line (pending, delivered, rejected) via FK to partner_delivery_status."
    - name: "content_type"
      expr: content_type_id
      comment: "Type of content covered by this line (movie, series, documentary, etc.) via FK to partner_content_type."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether this line carries exclusivity, used to segment exclusive vs. non-exclusive line economics."
    - name: "license_term_start_date"
      expr: DATE_TRUNC('quarter', license_term_start_date)
      comment: "Quarter the license term starts, used for cohort analysis of license commencement."
    - name: "license_term_end_date"
      expr: DATE_TRUNC('quarter', license_term_end_date)
      comment: "Quarter the license term ends, used to forecast expiring content rights."
    - name: "delivery_due_date"
      expr: DATE_TRUNC('month', delivery_due_date)
      comment: "Month delivery is due, used to track delivery pipeline and SLA compliance."
  measures:
    - name: "total_license_fee"
      expr: SUM(CAST(license_fee_amount AS DOUBLE))
      comment: "Total license fees committed across all acquisition deal lines. Core content cost KPI."
    - name: "avg_license_fee_per_line"
      expr: AVG(CAST(license_fee_amount AS DOUBLE))
      comment: "Average license fee per deal line. Benchmarks per-title acquisition cost."
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee obligations at the line level. Tracks granular MG exposure per title."
    - name: "avg_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate across deal lines. Informs blended royalty cost structure for content portfolio."
    - name: "deal_line_count"
      expr: COUNT(1)
      comment: "Total number of acquisition deal lines. Baseline volume metric for content line portfolio."
    - name: "distinct_titles_licensed"
      expr: COUNT(DISTINCT content_title_id)
      comment: "Number of distinct content titles under active acquisition deal lines. Measures breadth of licensed content portfolio."
    - name: "exclusive_line_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of deal lines with exclusivity. Tracks exclusivity exposure at the title level."
    - name: "total_exclusive_license_fee"
      expr: SUM(CASE WHEN exclusivity_flag = TRUE THEN license_fee_amount ELSE 0 END)
      comment: "Total license fees for exclusive deal lines. Quantifies premium paid for exclusivity at the title level."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_distribution_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for distribution agreements — tracks carriage fees, minimum guarantees, SLA uptime commitments, and agreement portfolio health across distribution partners."
  source: "`vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status_id
      comment: "Current status of the distribution agreement (active, expired, terminated) via FK to partner_agreement_status."
    - name: "agreement_type"
      expr: agreement_type_id
      comment: "Type of distribution agreement (MVPD, OTT, satellite, etc.) via FK to partner_agreement_type."
    - name: "territory"
      expr: territory
      comment: "Geographic territory covered by the agreement, used for regional distribution portfolio analysis."
    - name: "vod_rights_included"
      expr: vod_rights_included
      comment: "Whether VOD rights are included, used to segment agreements by rights scope."
    - name: "svod_rights_included"
      expr: svod_rights_included
      comment: "Whether SVOD rights are included, used to track streaming rights coverage across distribution partners."
    - name: "streaming_rights_included"
      expr: streaming_rights_included
      comment: "Whether streaming rights are included in the agreement."
    - name: "must_carry_obligation"
      expr: must_carry_obligation
      comment: "Whether the agreement carries a must-carry obligation, relevant for regulatory and carriage strategy."
    - name: "effective_date"
      expr: DATE_TRUNC('quarter', effective_date)
      comment: "Quarter the agreement became effective, used for vintage and cohort analysis."
    - name: "expiration_date"
      expr: DATE_TRUNC('quarter', expiration_date)
      comment: "Quarter the agreement expires, used to forecast renewal pipeline."
  measures:
    - name: "total_carriage_fee_committed"
      expr: SUM(CAST(carriage_fee_amount AS DOUBLE))
      comment: "Total carriage fees committed across all distribution agreements. Core revenue KPI for distribution economics."
    - name: "avg_carriage_fee"
      expr: AVG(CAST(carriage_fee_amount AS DOUBLE))
      comment: "Average carriage fee per distribution agreement. Benchmarks per-partner carriage economics."
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee obligations across distribution agreements. Tracks guaranteed revenue floor."
    - name: "avg_sla_uptime_commitment"
      expr: AVG(CAST(sla_uptime_percentage AS DOUBLE))
      comment: "Average SLA uptime percentage committed across distribution agreements. Tracks service quality obligations."
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Total number of distribution agreements. Baseline portfolio size metric."
    - name: "active_agreement_count"
      expr: COUNT(DISTINCT partner_id)
      comment: "Number of distinct distribution partners with agreements. Measures breadth of distribution network."
    - name: "vod_enabled_agreement_count"
      expr: COUNT(CASE WHEN vod_rights_included = TRUE THEN 1 END)
      comment: "Number of distribution agreements that include VOD rights. Tracks digital rights coverage across the distribution network."
    - name: "streaming_enabled_agreement_count"
      expr: COUNT(CASE WHEN streaming_rights_included = TRUE THEN 1 END)
      comment: "Number of distribution agreements that include streaming rights. Measures OTT distribution reach."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_syndication_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for syndication agreements — tracks flat fees, per-episode fees, minimum guarantees, revenue share, and exclusivity across the syndication portfolio."
  source: "`vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status_id
      comment: "Current status of the syndication agreement via FK to partner_agreement_status."
    - name: "agreement_type"
      expr: agreement_type_id
      comment: "Type of syndication agreement via FK to partner_agreement_type."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the syndication agreement is exclusive, used to segment exclusive vs. non-exclusive syndication economics."
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Whether the agreement includes a renewal option, used to forecast renewal pipeline."
    - name: "effective_start_date"
      expr: DATE_TRUNC('quarter', effective_start_date)
      comment: "Quarter the syndication agreement started, used for vintage analysis."
    - name: "effective_end_date"
      expr: DATE_TRUNC('quarter', effective_end_date)
      comment: "Quarter the syndication agreement ends, used to forecast expiring agreements."
    - name: "syndication_fee_structure"
      expr: syndication_fee_structure
      comment: "Fee structure type (flat fee, per-episode, revenue share, barter) for segmenting syndication economics."
  measures:
    - name: "total_flat_fee_committed"
      expr: SUM(CAST(flat_fee_amount AS DOUBLE))
      comment: "Total flat fees committed across all syndication agreements. Tracks guaranteed syndication revenue."
    - name: "total_per_episode_fee_committed"
      expr: SUM(CAST(per_episode_fee_amount AS DOUBLE))
      comment: "Total per-episode fees committed across syndication agreements. Tracks episodic syndication revenue potential."
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee obligations across syndication agreements. Tracks guaranteed revenue floor."
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage across syndication agreements. Informs blended syndication margin."
    - name: "syndication_agreement_count"
      expr: COUNT(1)
      comment: "Total number of syndication agreements. Baseline portfolio size metric."
    - name: "exclusive_syndication_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of exclusive syndication agreements. Tracks exclusivity exposure in the syndication portfolio."
    - name: "distinct_syndication_partners"
      expr: COUNT(DISTINCT syndication_partner_id)
      comment: "Number of distinct syndication partners. Measures breadth of syndication distribution network."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_affiliate_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for affiliate agreements — tracks affiliation fees, local ad avail inventory, retransmission revenue splits, and performance standards across the affiliate network."
  source: "`vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status_id
      comment: "Current status of the affiliate agreement via FK to partner_agreement_status."
    - name: "agreement_type"
      expr: agreement_type_id
      comment: "Type of affiliate agreement via FK to partner_agreement_type."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the affiliate agreement is exclusive in its territory."
    - name: "digital_rights_included_flag"
      expr: digital_rights_included_flag
      comment: "Whether digital rights are included in the affiliate agreement, used to track digital coverage."
    - name: "retransmission_consent_included_flag"
      expr: retransmission_consent_included_flag
      comment: "Whether retransmission consent is included, relevant for regulatory and revenue analysis."
    - name: "simulcast_requirement_flag"
      expr: simulcast_requirement_flag
      comment: "Whether simulcast is required under the agreement."
    - name: "effective_date"
      expr: DATE_TRUNC('quarter', effective_date)
      comment: "Quarter the affiliate agreement became effective."
    - name: "expiration_date"
      expr: DATE_TRUNC('quarter', expiration_date)
      comment: "Quarter the affiliate agreement expires, used to forecast renewal pipeline."
    - name: "affiliation_fee_frequency"
      expr: affiliation_fee_frequency
      comment: "Frequency of affiliation fee payments (monthly, quarterly, annual) for cash-flow analysis."
  measures:
    - name: "total_affiliation_fee_committed"
      expr: SUM(CAST(affiliation_fee_amount AS DOUBLE))
      comment: "Total affiliation fees committed across all affiliate agreements. Core affiliate network cost KPI."
    - name: "avg_affiliation_fee"
      expr: AVG(CAST(affiliation_fee_amount AS DOUBLE))
      comment: "Average affiliation fee per affiliate agreement. Benchmarks per-affiliate economics."
    - name: "avg_local_ad_avails_per_hour"
      expr: AVG(CAST(local_ad_avails_minutes_per_hour AS DOUBLE))
      comment: "Average local ad avail minutes per hour across affiliate agreements. Tracks local advertising inventory available to affiliates."
    - name: "total_local_ad_avails_per_hour"
      expr: SUM(CAST(local_ad_avails_minutes_per_hour AS DOUBLE))
      comment: "Total local ad avail minutes per hour across all affiliate agreements. Measures aggregate local advertising inventory."
    - name: "avg_retransmission_revenue_split"
      expr: AVG(CAST(retransmission_revenue_split_percentage AS DOUBLE))
      comment: "Average retransmission revenue split percentage. Informs retransmission consent economics across the affiliate network."
    - name: "avg_minimum_clearance_percentage"
      expr: AVG(CAST(minimum_clearance_percentage AS DOUBLE))
      comment: "Average minimum clearance percentage required across affiliate agreements. Tracks programming clearance obligations."
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage across affiliate agreements."
    - name: "affiliate_agreement_count"
      expr: COUNT(1)
      comment: "Total number of affiliate agreements. Baseline affiliate network size metric."
    - name: "digital_rights_enabled_count"
      expr: COUNT(CASE WHEN digital_rights_included_flag = TRUE THEN 1 END)
      comment: "Number of affiliate agreements that include digital rights. Tracks digital coverage across the affiliate network."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_carriage_fee_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for carriage fee schedules — tracks per-subscriber fees, volume discount tiers, escalation rates, and minimum guaranteed fees across carriage arrangements."
  source: "`vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status_id
      comment: "Current status of the carriage fee schedule via FK to partner_schedule_status."
    - name: "escalation_type"
      expr: escalation_type_id
      comment: "Type of fee escalation mechanism (CPI, fixed rate, etc.) via FK to escalation_type."
    - name: "fee_type"
      expr: fee_type
      comment: "Type of carriage fee (per-subscriber, flat, tiered) for segmenting fee structure analysis."
    - name: "mfn_provision_flag"
      expr: mfn_provision_flag
      comment: "Whether the schedule includes a Most Favored Nation provision, used to track MFN exposure."
    - name: "audit_rights_flag"
      expr: audit_rights_flag
      comment: "Whether audit rights are included in the carriage fee schedule."
    - name: "effective_start_date"
      expr: DATE_TRUNC('quarter', effective_start_date)
      comment: "Quarter the carriage fee schedule became effective."
    - name: "effective_end_date"
      expr: DATE_TRUNC('quarter', effective_end_date)
      comment: "Quarter the carriage fee schedule expires."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of carriage fee payments for cash-flow analysis."
  measures:
    - name: "avg_base_fee_per_subscriber"
      expr: AVG(CAST(base_fee_per_subscriber AS DOUBLE))
      comment: "Average base carriage fee per subscriber across all schedules. Core per-subscriber economics KPI."
    - name: "max_base_fee_per_subscriber"
      expr: MAX(base_fee_per_subscriber)
      comment: "Maximum base carriage fee per subscriber. Identifies highest-cost carriage arrangements."
    - name: "min_base_fee_per_subscriber"
      expr: MIN(base_fee_per_subscriber)
      comment: "Minimum base carriage fee per subscriber. Identifies lowest-cost carriage arrangements for benchmarking."
    - name: "total_minimum_guaranteed_fee"
      expr: SUM(CAST(minimum_guaranteed_fee AS DOUBLE))
      comment: "Total minimum guaranteed carriage fees across all schedules. Tracks guaranteed carriage revenue floor."
    - name: "avg_escalation_rate_percentage"
      expr: AVG(CAST(escalation_rate_percentage AS DOUBLE))
      comment: "Average fee escalation rate across carriage schedules. Informs future carriage cost trajectory."
    - name: "avg_late_payment_penalty_rate"
      expr: AVG(CAST(late_payment_penalty_rate AS DOUBLE))
      comment: "Average late payment penalty rate across carriage fee schedules. Tracks financial risk from late payments."
    - name: "total_maximum_fee_cap"
      expr: SUM(CAST(maximum_fee_cap AS DOUBLE))
      comment: "Total maximum fee cap across all carriage schedules. Tracks upper bound of carriage fee exposure."
    - name: "carriage_fee_schedule_count"
      expr: COUNT(1)
      comment: "Total number of carriage fee schedules. Baseline portfolio size metric."
    - name: "mfn_schedule_count"
      expr: COUNT(CASE WHEN mfn_provision_flag = TRUE THEN 1 END)
      comment: "Number of carriage fee schedules with MFN provisions. Tracks MFN exposure across the carriage portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_minimum_guarantee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for minimum guarantee obligations — tracks MG amounts, recoupment progress, outstanding balances, and overage economics across the content acquisition portfolio."
  source: "`vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee`"
  dimensions:
    - name: "mg_status"
      expr: mg_status_id
      comment: "Current status of the minimum guarantee (active, recouped, in-default) via FK to mg_status."
    - name: "mg_type"
      expr: mg_type_id
      comment: "Type of minimum guarantee (advance, guarantee, cross-collateralized) via FK to mg_type."
    - name: "is_recoupable"
      expr: is_recoupable
      comment: "Whether the MG is recoupable against future royalties. Segments recoupable vs. non-recoupable MG exposure."
    - name: "is_cross_collateralized"
      expr: is_cross_collateralized
      comment: "Whether the MG is cross-collateralized across multiple titles. Tracks cross-collateralization risk."
    - name: "amortization_method"
      expr: amortization_method_id
      comment: "Amortization method applied to the MG via FK to amortization_method."
    - name: "effective_start_date"
      expr: DATE_TRUNC('quarter', effective_start_date)
      comment: "Quarter the MG obligation started."
    - name: "effective_end_date"
      expr: DATE_TRUNC('quarter', effective_end_date)
      comment: "Quarter the MG obligation ends."
    - name: "payment_schedule_type"
      expr: payment_schedule_type
      comment: "Type of payment schedule for the MG (upfront, milestone, quarterly) for cash-flow analysis."
  measures:
    - name: "total_mg_amount"
      expr: SUM(CAST(mg_amount AS DOUBLE))
      comment: "Total minimum guarantee amounts committed across all MG obligations. Core content investment KPI."
    - name: "avg_mg_amount"
      expr: AVG(CAST(mg_amount AS DOUBLE))
      comment: "Average minimum guarantee amount per obligation. Benchmarks per-deal MG size."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance_amount AS DOUBLE))
      comment: "Total outstanding MG balance not yet recouped. Critical cash-flow and balance-sheet exposure metric."
    - name: "total_recouped_to_date"
      expr: SUM(CAST(recouped_to_date_amount AS DOUBLE))
      comment: "Total MG amounts recouped to date. Tracks recoupment progress against committed MG obligations."
    - name: "total_overage_amount"
      expr: SUM(CAST(overage_amount AS DOUBLE))
      comment: "Total overage amounts earned above MG thresholds. Measures incremental royalty revenue beyond guaranteed minimums."
    - name: "avg_recoupment_percentage"
      expr: AVG(CAST(recoupment_percentage AS DOUBLE))
      comment: "Average recoupment percentage across MG obligations. Tracks overall recoupment efficiency."
    - name: "avg_overage_royalty_rate"
      expr: AVG(CAST(overage_royalty_rate AS DOUBLE))
      comment: "Average overage royalty rate applied once MG is recouped. Informs post-recoupment earnings potential."
    - name: "mg_obligation_count"
      expr: COUNT(1)
      comment: "Total number of minimum guarantee obligations. Baseline portfolio size metric."
    - name: "cross_collateralized_mg_count"
      expr: COUNT(CASE WHEN is_cross_collateralized = TRUE THEN 1 END)
      comment: "Number of cross-collateralized MG obligations. Tracks cross-collateralization complexity in the portfolio."
    - name: "recoupable_mg_total"
      expr: SUM(CASE WHEN is_recoupable = TRUE THEN mg_amount ELSE 0 END)
      comment: "Total MG amount that is recoupable against future royalties. Distinguishes recoverable from sunk-cost MG exposure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partner disputes — tracks disputed amounts, settlement amounts, resolution timelines, and dispute portfolio health across all partner relationships."
  source: "`vibe_media_broadcasting_v1`.`partner`.`partner_dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status_id
      comment: "Current status of the dispute (open, in-mediation, resolved, escalated) via FK to partner_dispute_status."
    - name: "dispute_type"
      expr: dispute_type_id
      comment: "Type of dispute (royalty, delivery, rights, billing) via FK to partner_dispute_type."
    - name: "dispute_category"
      expr: dispute_category_id
      comment: "Category of dispute via FK to dispute_category for granular classification."
    - name: "escalation_level"
      expr: escalation_level_id
      comment: "Current escalation level of the dispute via FK to partner_escalation_level."
    - name: "arbitration_required"
      expr: arbitration_required
      comment: "Whether arbitration is required, used to segment disputes by resolution complexity."
    - name: "mediation_required"
      expr: mediation_required
      comment: "Whether mediation is required, used to track disputes requiring formal mediation."
    - name: "legal_hold_status"
      expr: legal_hold_status
      comment: "Whether the dispute is under legal hold, used to track legally sensitive disputes."
    - name: "filed_date"
      expr: DATE_TRUNC('quarter', filed_date)
      comment: "Quarter the dispute was filed, used for dispute volume trend analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the dispute (high, medium, low) for triage and resource allocation."
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount_usd AS DOUBLE))
      comment: "Total amount in dispute across all partner disputes. Core financial risk KPI for dispute portfolio."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount_usd AS DOUBLE))
      comment: "Average disputed amount per dispute. Benchmarks dispute size and financial exposure per case."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount_usd AS DOUBLE))
      comment: "Total settlement amounts paid across resolved disputes. Tracks actual financial cost of dispute resolution."
    - name: "avg_settlement_amount"
      expr: AVG(CAST(settlement_amount_usd AS DOUBLE))
      comment: "Average settlement amount per resolved dispute. Benchmarks settlement economics."
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Total number of partner disputes. Baseline dispute volume metric for relationship health monitoring."
    - name: "arbitration_dispute_count"
      expr: COUNT(CASE WHEN arbitration_required = TRUE THEN 1 END)
      comment: "Number of disputes requiring arbitration. Tracks high-complexity dispute exposure."
    - name: "legal_hold_dispute_count"
      expr: COUNT(CASE WHEN legal_hold_status = TRUE THEN 1 END)
      comment: "Number of disputes under legal hold. Tracks legally sensitive dispute exposure."
    - name: "distinct_partners_in_dispute"
      expr: COUNT(DISTINCT partner_id)
      comment: "Number of distinct partners with active disputes. Measures breadth of dispute exposure across the partner network."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_audit_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partner audit events — tracks audit costs, disputed amounts, adjustment amounts, corrective action rates, and audit cycle efficiency across the partner audit programme."
  source: "`vibe_media_broadcasting_v1`.`partner`.`partner_audit_event`"
  dimensions:
    - name: "audit_status"
      expr: audit_status_id
      comment: "Current status of the audit (planned, in-progress, complete, follow-up) via FK to partner_audit_status."
    - name: "audit_type"
      expr: audit_type_id
      comment: "Type of audit (royalty, delivery, compliance, financial) via FK to partner_audit_type."
    - name: "finding_category"
      expr: finding_category_id
      comment: "Category of audit finding via FK to partner_finding_category."
    - name: "resolution_status"
      expr: resolution_status_id
      comment: "Resolution status of the audit via FK to partner_resolution_status."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required, used to segment audits by remediation need."
    - name: "follow_up_audit_required"
      expr: follow_up_audit_required
      comment: "Whether a follow-up audit is required, used to track audit recurrence."
    - name: "audit_initiated_date"
      expr: DATE_TRUNC('quarter', audit_initiated_date)
      comment: "Quarter the audit was initiated, used for audit volume trend analysis."
    - name: "audit_period_start_date"
      expr: DATE_TRUNC('year', audit_period_start_date)
      comment: "Year of the audit period start, used for audit coverage analysis."
  measures:
    - name: "total_audit_cost"
      expr: SUM(CAST(audit_cost AS DOUBLE))
      comment: "Total cost of conducting partner audits. Tracks audit programme investment and ROI."
    - name: "avg_audit_cost"
      expr: AVG(CAST(audit_cost AS DOUBLE))
      comment: "Average cost per partner audit. Benchmarks audit efficiency."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amounts disputed as a result of audit findings. Measures financial recovery opportunity from audits."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts resulting from audit findings. Tracks actual financial recovery from audit programme."
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(adjustment_amount AS DOUBLE))
      comment: "Average adjustment amount per audit. Benchmarks audit yield per engagement."
    - name: "audit_event_count"
      expr: COUNT(1)
      comment: "Total number of partner audit events. Baseline audit programme volume metric."
    - name: "corrective_action_audit_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of audits requiring corrective action. Tracks partner compliance remediation workload."
    - name: "follow_up_audit_count"
      expr: COUNT(CASE WHEN follow_up_audit_required = TRUE THEN 1 END)
      comment: "Number of audits requiring follow-up. Tracks audit recurrence and persistent compliance issues."
    - name: "distinct_partners_audited"
      expr: COUNT(DISTINCT partner_id)
      comment: "Number of distinct partners audited. Measures audit programme coverage across the partner network."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_deal_negotiation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for deal negotiations — tracks proposed vs. agreed deal values, negotiation cycle times, escalation rates, and pipeline health across the deal negotiation process."
  source: "`vibe_media_broadcasting_v1`.`partner`.`deal_negotiation`"
  dimensions:
    - name: "negotiation_status"
      expr: negotiation_status_id
      comment: "Current status of the negotiation (in-progress, stalled, closed, abandoned) via FK to negotiation_status."
    - name: "deal_type"
      expr: deal_type_id
      comment: "Type of deal being negotiated via FK to partner_deal_type."
    - name: "legal_review_status"
      expr: legal_review_status_id
      comment: "Legal review status of the negotiation via FK to legal_review_status."
    - name: "risk_rating"
      expr: risk_rating_id
      comment: "Risk rating assigned to the negotiation via FK to partner_risk_rating."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the negotiation has been escalated, used to track escalation rate."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the deal being negotiated includes exclusivity."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "Whether the deal is subject to SOX controls, used to segment high-governance deals."
    - name: "negotiation_start_date"
      expr: DATE_TRUNC('quarter', negotiation_start_date)
      comment: "Quarter the negotiation started, used for pipeline vintage analysis."
    - name: "target_close_date"
      expr: DATE_TRUNC('quarter', target_close_date)
      comment: "Quarter the deal is targeted to close, used for pipeline forecasting."
  measures:
    - name: "total_proposed_deal_value"
      expr: SUM(CAST(proposed_deal_value AS DOUBLE))
      comment: "Total proposed deal value across all active negotiations. Tracks deal pipeline value."
    - name: "total_agreed_deal_value"
      expr: SUM(CAST(agreed_deal_value AS DOUBLE))
      comment: "Total agreed deal value across closed negotiations. Tracks actual deal value secured."
    - name: "avg_proposed_deal_value"
      expr: AVG(CAST(proposed_deal_value AS DOUBLE))
      comment: "Average proposed deal value per negotiation. Benchmarks deal size in the pipeline."
    - name: "avg_agreed_deal_value"
      expr: AVG(CAST(agreed_deal_value AS DOUBLE))
      comment: "Average agreed deal value per closed negotiation. Benchmarks actual deal size achieved."
    - name: "negotiation_count"
      expr: COUNT(1)
      comment: "Total number of deal negotiations. Baseline pipeline volume metric."
    - name: "escalated_negotiation_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of negotiations that have been escalated. Tracks negotiation complexity and escalation rate."
    - name: "distinct_partners_in_negotiation"
      expr: COUNT(DISTINCT partner_id)
      comment: "Number of distinct partners with active negotiations. Measures breadth of deal pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_deal_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for deal approval workflows — tracks deal values under approval, approval cycle efficiency, finance and legal review completion rates, and approval threshold breaches."
  source: "`vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval`"
  dimensions:
    - name: "approval_status"
      expr: approval_status_id
      comment: "Current approval status (pending, approved, rejected, escalated) via FK to partner_approval_status."
    - name: "approval_level"
      expr: approval_level_id
      comment: "Approval level required for the deal via FK to approval_level."
    - name: "deal_type"
      expr: deal_type_id
      comment: "Type of deal under approval via FK to partner_deal_type."
    - name: "risk_tier"
      expr: risk_tier_id
      comment: "Risk tier of the deal under approval via FK to risk_tier."
    - name: "strategic_tier"
      expr: strategic_tier_id
      comment: "Strategic tier of the deal via FK to strategic_tier."
    - name: "approval_threshold_exceeded_flag"
      expr: approval_threshold_exceeded_flag
      comment: "Whether the deal value exceeds the standard approval threshold, used to track high-value deal approvals."
    - name: "finance_review_required_flag"
      expr: finance_review_required_flag
      comment: "Whether finance review is required for this deal approval."
    - name: "legal_review_required_flag"
      expr: legal_review_required_flag
      comment: "Whether legal review is required for this deal approval."
    - name: "submission_timestamp"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month the approval was submitted, used for approval volume trend analysis."
  measures:
    - name: "total_deal_value_under_approval"
      expr: SUM(CAST(deal_value_amount AS DOUBLE))
      comment: "Total deal value currently under or pending approval. Tracks financial exposure in the approval pipeline."
    - name: "avg_deal_value_under_approval"
      expr: AVG(CAST(deal_value_amount AS DOUBLE))
      comment: "Average deal value per approval request. Benchmarks deal size requiring governance oversight."
    - name: "total_minimum_guarantee_under_approval"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee amounts under approval. Tracks MG commitment exposure in the approval pipeline."
    - name: "total_carriage_fee_under_approval"
      expr: SUM(CAST(carriage_fee_commitment_amount AS DOUBLE))
      comment: "Total carriage fee commitments under approval. Tracks carriage cost exposure in the approval pipeline."
    - name: "approval_request_count"
      expr: COUNT(1)
      comment: "Total number of deal approval requests. Baseline approval workflow volume metric."
    - name: "threshold_exceeded_count"
      expr: COUNT(CASE WHEN approval_threshold_exceeded_flag = TRUE THEN 1 END)
      comment: "Number of approvals where deal value exceeds standard threshold. Tracks high-value deal governance workload."
    - name: "finance_review_required_count"
      expr: COUNT(CASE WHEN finance_review_required_flag = TRUE THEN 1 END)
      comment: "Number of approvals requiring finance review. Tracks finance team governance workload."
    - name: "legal_review_required_count"
      expr: COUNT(CASE WHEN legal_review_required_flag = TRUE THEN 1 END)
      comment: "Number of approvals requiring legal review. Tracks legal team governance workload."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_delivery_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for content delivery obligations — tracks delivery SLA compliance, penalty exposure, file sizes, and quality control outcomes across all partner delivery commitments."
  source: "`vibe_media_broadcasting_v1`.`partner`.`delivery_obligation`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status_id
      comment: "Current delivery status (pending, delivered, rejected, overdue) via FK to partner_delivery_status."
    - name: "obligation_type"
      expr: obligation_type_id
      comment: "Type of delivery obligation (master, promo, metadata, subtitle) via FK to partner_obligation_type."
    - name: "delivery_method"
      expr: delivery_method_id
      comment: "Method of delivery (FTP, cloud, physical, API) via FK to partner_delivery_method."
    - name: "quality_control_status"
      expr: quality_control_status_id
      comment: "QC status of the delivered content via FK to quality_control_status."
    - name: "priority_level"
      expr: priority_level_id
      comment: "Priority level of the delivery obligation via FK to partner_priority_level."
    - name: "sla_compliance"
      expr: sla_compliance
      comment: "Whether the delivery met SLA requirements. Used to segment compliant vs. non-compliant deliveries."
    - name: "redelivery_required"
      expr: redelivery_required
      comment: "Whether redelivery is required due to rejection or quality failure."
    - name: "closed_caption_required"
      expr: closed_caption_required
      comment: "Whether closed captions are required for this delivery obligation."
    - name: "delivery_deadline"
      expr: DATE_TRUNC('month', delivery_deadline)
      comment: "Month the delivery is due, used for delivery pipeline and SLA trend analysis."
  measures:
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts at risk across all delivery obligations. Core financial risk KPI for delivery SLA management."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per delivery obligation. Benchmarks per-obligation penalty exposure."
    - name: "total_file_size_gb"
      expr: SUM(CAST(file_size_gb AS DOUBLE))
      comment: "Total file size in GB across all delivery obligations. Tracks content delivery volume and infrastructure requirements."
    - name: "avg_file_size_gb"
      expr: AVG(CAST(file_size_gb AS DOUBLE))
      comment: "Average file size per delivery obligation. Benchmarks content delivery size for infrastructure planning."
    - name: "avg_required_bitrate_mbps"
      expr: AVG(CAST(required_bitrate_mbps AS DOUBLE))
      comment: "Average required bitrate across delivery obligations. Tracks technical quality standards across the delivery portfolio."
    - name: "delivery_obligation_count"
      expr: COUNT(1)
      comment: "Total number of delivery obligations. Baseline delivery pipeline volume metric."
    - name: "sla_compliant_count"
      expr: COUNT(CASE WHEN sla_compliance = TRUE THEN 1 END)
      comment: "Number of delivery obligations meeting SLA requirements. Tracks delivery SLA compliance rate."
    - name: "redelivery_required_count"
      expr: COUNT(CASE WHEN redelivery_required = TRUE THEN 1 END)
      comment: "Number of delivery obligations requiring redelivery. Tracks delivery quality failure rate."
    - name: "distinct_partners_with_obligations"
      expr: COUNT(DISTINCT partner_id)
      comment: "Number of distinct partners with active delivery obligations. Measures delivery obligation breadth."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_performance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partner performance obligations — tracks penalty exposure, threshold compliance, breach counts, and SLA measurement outcomes across all contractual performance commitments."
  source: "`vibe_media_broadcasting_v1`.`partner`.`performance_obligation`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status_id
      comment: "Current compliance status of the performance obligation via FK to partner_compliance_status."
    - name: "obligation_type"
      expr: obligation_type_id
      comment: "Type of performance obligation (viewership, clearance, uptime, delivery) via FK to partner_obligation_type."
    - name: "obligation_code"
      expr: obligation_code_id
      comment: "Specific obligation code via FK to partner_obligation_code for granular obligation classification."
    - name: "escalation_level"
      expr: escalation_level_id
      comment: "Current escalation level of the obligation via FK to partner_escalation_level."
    - name: "makegood_provision_flag"
      expr: makegood_provision_flag
      comment: "Whether a makegood provision applies, used to track obligations with makegood remediation options."
    - name: "notification_required_flag"
      expr: notification_required_flag
      comment: "Whether notification is required upon breach, used to track notification obligations."
    - name: "effective_start_date"
      expr: DATE_TRUNC('quarter', effective_start_date)
      comment: "Quarter the performance obligation started."
    - name: "measurement_period"
      expr: measurement_period
      comment: "Measurement period for the obligation (monthly, quarterly, annual) for performance cadence analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the obligation threshold (GRP, percentage, hours, etc.)."
  measures:
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts at risk across all performance obligations. Core financial risk KPI for partner SLA management."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per performance obligation. Benchmarks per-obligation penalty exposure."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average performance threshold value across obligations. Benchmarks contractual performance standards."
    - name: "avg_last_measured_value"
      expr: AVG(CAST(last_measured_value AS DOUBLE))
      comment: "Average last measured performance value across obligations. Tracks actual performance against thresholds."
    - name: "performance_obligation_count"
      expr: COUNT(1)
      comment: "Total number of performance obligations. Baseline obligation portfolio size metric."
    - name: "makegood_obligation_count"
      expr: COUNT(CASE WHEN makegood_provision_flag = TRUE THEN 1 END)
      comment: "Number of obligations with makegood provisions. Tracks obligations with remediation flexibility."
    - name: "distinct_partners_with_obligations"
      expr: COUNT(DISTINCT partner_id)
      comment: "Number of distinct partners with active performance obligations. Measures obligation coverage across the partner network."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partner agreement renewals — tracks proposed vs. original deal values, renewal pipeline health, value change economics, and strategic renewal prioritisation."
  source: "`vibe_media_broadcasting_v1`.`partner`.`renewal`"
  dimensions:
    - name: "renewal_status"
      expr: renewal_status_id
      comment: "Current status of the renewal (in-progress, approved, declined, auto-renewed) via FK to partner_renewal_status."
    - name: "agreement_type"
      expr: agreement_type_id
      comment: "Type of agreement being renewed via FK to partner_agreement_type."
    - name: "partner_performance_rating"
      expr: partner_performance_rating_id
      comment: "Performance rating of the partner at renewal time via FK to partner_performance_rating."
    - name: "auto_renewal_clause_flag"
      expr: auto_renewal_clause_flag
      comment: "Whether the agreement has an auto-renewal clause, used to segment auto vs. manual renewals."
    - name: "renegotiation_required_flag"
      expr: renegotiation_required_flag
      comment: "Whether renegotiation is required, used to track renewal complexity."
    - name: "renegotiation_priority"
      expr: renegotiation_priority
      comment: "Priority level for renegotiation (high, medium, low) for renewal resource allocation."
    - name: "strategic_importance"
      expr: strategic_importance
      comment: "Strategic importance of the renewal (critical, high, standard) for executive prioritisation."
    - name: "trigger_date"
      expr: DATE_TRUNC('quarter', trigger_date)
      comment: "Quarter the renewal was triggered, used for renewal pipeline timing analysis."
    - name: "decision_due_date"
      expr: DATE_TRUNC('quarter', decision_due_date)
      comment: "Quarter the renewal decision is due, used for renewal pipeline forecasting."
  measures:
    - name: "total_original_deal_value"
      expr: SUM(CAST(original_deal_value_amount AS DOUBLE))
      comment: "Total original deal value across all renewals. Baseline for measuring renewal value change."
    - name: "total_proposed_renewal_value"
      expr: SUM(CAST(proposed_deal_value_amount AS DOUBLE))
      comment: "Total proposed deal value across all renewals. Tracks renewal pipeline value and investment trajectory."
    - name: "avg_value_change_percentage"
      expr: AVG(CAST(value_change_percentage AS DOUBLE))
      comment: "Average percentage change in deal value at renewal. Measures pricing power and negotiation outcomes."
    - name: "max_value_change_percentage"
      expr: MAX(value_change_percentage)
      comment: "Maximum value change percentage at renewal. Identifies highest-impact renewal negotiations."
    - name: "renewal_count"
      expr: COUNT(1)
      comment: "Total number of renewals in the pipeline. Baseline renewal volume metric."
    - name: "auto_renewal_count"
      expr: COUNT(CASE WHEN auto_renewal_clause_flag = TRUE THEN 1 END)
      comment: "Number of renewals with auto-renewal clauses. Tracks automatic renewal exposure."
    - name: "renegotiation_required_count"
      expr: COUNT(CASE WHEN renegotiation_required_flag = TRUE THEN 1 END)
      comment: "Number of renewals requiring active renegotiation. Tracks renewal workload and complexity."
    - name: "distinct_partners_renewing"
      expr: COUNT(DISTINCT partner_id)
      comment: "Number of distinct partners with renewals in the pipeline. Measures renewal pipeline breadth."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_coproduction_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for co-production agreements — tracks investment amounts, IP ownership percentages, budget commitments, and co-production portfolio health."
  source: "`vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status_id
      comment: "Current status of the co-production agreement via FK to partner_agreement_status."
    - name: "agreement_type"
      expr: agreement_type_id
      comment: "Type of co-production agreement via FK to partner_agreement_type."
    - name: "production_type"
      expr: production_type_id
      comment: "Type of production (scripted, unscripted, documentary, animation) via FK to partner_production_type."
    - name: "creative_control_level"
      expr: creative_control_level_id
      comment: "Level of creative control retained via FK to creative_control_level."
    - name: "effective_date"
      expr: DATE_TRUNC('quarter', effective_date)
      comment: "Quarter the co-production agreement became effective."
    - name: "production_start_date"
      expr: DATE_TRUNC('quarter', production_start_date)
      comment: "Quarter production starts, used for production pipeline analysis."
    - name: "production_end_date"
      expr: DATE_TRUNC('quarter', production_end_date)
      comment: "Quarter production ends, used for production completion forecasting."
  measures:
    - name: "total_budget_committed"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget committed across all co-production agreements. Core co-production investment KPI."
    - name: "total_our_investment"
      expr: SUM(CAST(our_investment_amount AS DOUBLE))
      comment: "Total investment amount contributed by our organisation across co-productions. Tracks co-production capital deployment."
    - name: "avg_our_investment_percentage"
      expr: AVG(CAST(our_investment_percentage AS DOUBLE))
      comment: "Average percentage of co-production budget contributed by our organisation. Benchmarks co-production investment share."
    - name: "avg_our_ip_ownership_percentage"
      expr: AVG(CAST(our_ip_ownership_percentage AS DOUBLE))
      comment: "Average IP ownership percentage retained by our organisation. Tracks IP asset creation from co-productions."
    - name: "avg_budget_per_coproduction"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average total budget per co-production agreement. Benchmarks co-production scale."
    - name: "coproduction_count"
      expr: COUNT(1)
      comment: "Total number of co-production agreements. Baseline co-production portfolio size metric."
    - name: "distinct_coproduction_partners"
      expr: COUNT(DISTINCT lead_partner_id)
      comment: "Number of distinct lead co-production partners. Measures breadth of co-production relationships."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_payment_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partner payment schedules — tracks total contract values, advance amounts, minimum guarantees, escalation rates, and payment schedule portfolio health."
  source: "`vibe_media_broadcasting_v1`.`partner`.`payment_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status_id
      comment: "Current status of the payment schedule via FK to partner_schedule_status."
    - name: "schedule_type"
      expr: schedule_type_id
      comment: "Type of payment schedule (milestone, recurring, upfront) via FK to partner_schedule_type."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of payments (monthly, quarterly, annual) for cash-flow analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (wire, ACH, check) for payment operations analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the payment schedule auto-renews."
    - name: "recoupment_flag"
      expr: recoupment_flag
      comment: "Whether the schedule includes recoupment provisions."
    - name: "escalation_clause_flag"
      expr: escalation_clause_flag
      comment: "Whether the schedule includes an escalation clause."
    - name: "effective_start_date"
      expr: DATE_TRUNC('quarter', effective_start_date)
      comment: "Quarter the payment schedule starts."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contract value across all payment schedules. Core financial commitment KPI."
    - name: "total_advance_amount"
      expr: SUM(CAST(advance_amount AS DOUBLE))
      comment: "Total advance amounts committed across payment schedules. Tracks upfront cash outflow obligations."
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee amounts across payment schedules. Tracks guaranteed payment obligations."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per schedule. Benchmarks per-schedule payment size."
    - name: "avg_escalation_percentage"
      expr: AVG(CAST(escalation_percentage AS DOUBLE))
      comment: "Average escalation percentage across payment schedules with escalation clauses. Informs future payment cost trajectory."
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage across payment schedules. Informs blended revenue share economics."
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate across payment schedules. Benchmarks royalty economics across the partner portfolio."
    - name: "payment_schedule_count"
      expr: COUNT(1)
      comment: "Total number of payment schedules. Baseline payment obligation portfolio size metric."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_territory_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for territory grants — tracks minimum guarantees, royalty rates, rights coverage (linear, SVOD, AVOD, TVOD), and geographic distribution of content rights grants."
  source: "`vibe_media_broadcasting_v1`.`partner`.`territory_grant`"
  dimensions:
    - name: "clearance_status"
      expr: clearance_status_id
      comment: "Clearance status of the territory grant via FK to partner_clearance_status."
    - name: "grant_type"
      expr: grant_type_id
      comment: "Type of territory grant (exclusive, non-exclusive, holdback) via FK to grant_type."
    - name: "window_type"
      expr: window_type_id
      comment: "Window type for the territory grant (theatrical, SVOD, linear, etc.) via FK to partner_window_type."
    - name: "country_code"
      expr: country_code_id
      comment: "Country covered by the territory grant via FK to partner_country_code."
    - name: "linear_rights_flag"
      expr: linear_rights_flag
      comment: "Whether linear broadcast rights are included in the territory grant."
    - name: "svod_rights_flag"
      expr: svod_rights_flag
      comment: "Whether SVOD rights are included in the territory grant."
    - name: "avod_rights_flag"
      expr: avod_rights_flag
      comment: "Whether AVOD rights are included in the territory grant."
    - name: "tvod_rights_flag"
      expr: tvod_rights_flag
      comment: "Whether TVOD rights are included in the territory grant."
    - name: "blackout_zone_indicator"
      expr: blackout_zone_indicator
      comment: "Whether the territory is subject to blackout restrictions."
    - name: "effective_start_date"
      expr: DATE_TRUNC('quarter', effective_start_date)
      comment: "Quarter the territory grant becomes effective."
  measures:
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee amounts across territory grants. Tracks guaranteed revenue by territory."
    - name: "avg_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate across territory grants. Benchmarks per-territory royalty economics."
    - name: "territory_grant_count"
      expr: COUNT(1)
      comment: "Total number of territory grants. Baseline rights coverage volume metric."
    - name: "linear_rights_grant_count"
      expr: COUNT(CASE WHEN linear_rights_flag = TRUE THEN 1 END)
      comment: "Number of territory grants including linear broadcast rights. Tracks linear rights coverage."
    - name: "svod_rights_grant_count"
      expr: COUNT(CASE WHEN svod_rights_flag = TRUE THEN 1 END)
      comment: "Number of territory grants including SVOD rights. Tracks streaming rights coverage."
    - name: "avod_rights_grant_count"
      expr: COUNT(CASE WHEN avod_rights_flag = TRUE THEN 1 END)
      comment: "Number of territory grants including AVOD rights. Tracks ad-supported streaming rights coverage."
    - name: "blackout_territory_count"
      expr: COUNT(CASE WHEN blackout_zone_indicator = TRUE THEN 1 END)
      comment: "Number of territory grants with blackout restrictions. Tracks blackout exposure across the rights portfolio."
    - name: "distinct_titles_with_territory_grants"
      expr: COUNT(DISTINCT content_title_id)
      comment: "Number of distinct titles with territory grants. Measures breadth of content rights coverage."
$$;