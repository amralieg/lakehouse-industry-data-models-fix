-- Metric views for domain: partner | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 19:19:28

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`partner_acquisition_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic content acquisition deal performance metrics tracking deal value, minimum guarantees, revenue share, and content volume economics"
  source: "`media_broadcasting_ecm`.`partner`.`acquisition_deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Current status of the acquisition deal (active, expired, pending, etc.)"
    - name: "deal_type"
      expr: deal_type
      comment: "Type of acquisition deal (exclusive, non-exclusive, first-run, library, etc.)"
    - name: "content_delivery_format"
      expr: content_delivery_format
      comment: "Format in which content is delivered (HD, 4K, SD, digital file, etc.)"
    - name: "territory_coverage"
      expr: territory_coverage
      comment: "Geographic territories covered by the acquisition deal"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which deal value and payments are denominated"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the deal grants exclusive rights to the content"
    - name: "deal_year"
      expr: YEAR(deal_effective_date)
      comment: "Year the acquisition deal became effective"
    - name: "deal_quarter"
      expr: CONCAT('Q', QUARTER(deal_effective_date), '-', YEAR(deal_effective_date))
      comment: "Quarter and year the acquisition deal became effective"
    - name: "windowing_strategy"
      expr: windowing_strategy
      comment: "Content windowing strategy (theatrical, SVOD, AVOD, linear, etc.)"
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Whether the deal includes renewal options"
  measures:
    - name: "total_deal_value"
      expr: SUM(CAST(deal_value_amount AS DOUBLE))
      comment: "Total value of all acquisition deals, representing committed content investment"
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee amounts committed across all deals, representing guaranteed partner payments"
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage across deals, indicating typical partner economics"
    - name: "total_content_runtime_hours"
      expr: SUM(CAST(total_runtime_hours AS DOUBLE))
      comment: "Total hours of content acquired across all deals, measuring content volume"
    - name: "deal_count"
      expr: COUNT(acquisition_deal_id)
      comment: "Number of acquisition deals, tracking deal volume and partner relationships"
    - name: "avg_deal_value"
      expr: AVG(CAST(deal_value_amount AS DOUBLE))
      comment: "Average value per acquisition deal, indicating typical deal size"
    - name: "exclusive_deal_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN acquisition_deal_id END)
      comment: "Number of exclusive acquisition deals, measuring competitive content positioning"
    - name: "cost_per_content_hour"
      expr: SUM(CAST(deal_value_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_runtime_hours AS DOUBLE)), 0)
      comment: "Average cost per hour of acquired content, measuring content acquisition efficiency"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`partner_acquisition_deal_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular content acquisition line-item metrics tracking individual title economics, license fees, and royalty rates"
  source: "`media_broadcasting_ecm`.`partner`.`acquisition_deal_line`"
  dimensions:
    - name: "content_type"
      expr: content_type
      comment: "Type of content (movie, series, documentary, sports, etc.)"
    - name: "line_status"
      expr: line_status
      comment: "Status of the deal line item (active, delivered, pending, cancelled)"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the content asset (delivered, pending, rejected, in-transit)"
    - name: "genre_primary"
      expr: genre_primary
      comment: "Primary genre of the content (drama, comedy, action, etc.)"
    - name: "language_code"
      expr: language_code
      comment: "Primary language of the content"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether this line item grants exclusive rights"
    - name: "production_year"
      expr: production_year
      comment: "Year the content was produced"
    - name: "delivery_format"
      expr: delivery_format
      comment: "Format in which content is delivered (ProRes, H.264, IMF, etc.)"
    - name: "license_year"
      expr: YEAR(license_term_start_date)
      comment: "Year the license term begins"
  measures:
    - name: "total_license_fees"
      expr: SUM(CAST(license_fee_amount AS DOUBLE))
      comment: "Total license fees paid for content, representing direct content acquisition costs"
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee amounts at line level, representing guaranteed title-level payments"
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate percentage across content, indicating typical revenue sharing terms"
    - name: "line_item_count"
      expr: COUNT(acquisition_deal_line_id)
      comment: "Number of acquisition deal line items, tracking content title volume"
    - name: "avg_license_fee_per_title"
      expr: AVG(CAST(license_fee_amount AS DOUBLE))
      comment: "Average license fee per content title, measuring typical title acquisition cost"
    - name: "exclusive_title_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN acquisition_deal_line_id END)
      comment: "Number of exclusive content titles acquired, measuring competitive content portfolio"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`partner_affiliate_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Affiliate network relationship metrics tracking affiliation fees, revenue share, clearance requirements, and network compensation economics"
  source: "`media_broadcasting_ecm`.`partner`.`affiliate_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the affiliate agreement (active, expired, pending renewal, terminated)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of affiliate agreement (primary, secondary, digital-only, etc.)"
    - name: "network_compensation_model"
      expr: network_compensation_model
      comment: "Model used for network compensation (flat fee, revenue share, hybrid, barter)"
    - name: "affiliation_fee_frequency"
      expr: affiliation_fee_frequency
      comment: "Frequency of affiliation fee payments (monthly, quarterly, annually)"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the affiliate agreement is exclusive"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the agreement automatically renews"
    - name: "retransmission_consent_included_flag"
      expr: retransmission_consent_included_flag
      comment: "Whether retransmission consent is included in the agreement"
    - name: "digital_rights_included_flag"
      expr: digital_rights_included_flag
      comment: "Whether digital distribution rights are included"
    - name: "agreement_year"
      expr: YEAR(effective_date)
      comment: "Year the affiliate agreement became effective"
  measures:
    - name: "total_affiliation_fees"
      expr: SUM(CAST(affiliation_fee_amount AS DOUBLE))
      comment: "Total affiliation fees paid to or received from affiliates, representing network distribution costs or revenue"
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage across affiliate agreements, indicating typical affiliate economics"
    - name: "avg_retransmission_revenue_split"
      expr: AVG(CAST(retransmission_revenue_split_percentage AS DOUBLE))
      comment: "Average retransmission revenue split percentage, measuring retransmission consent economics"
    - name: "avg_minimum_clearance_percentage"
      expr: AVG(CAST(minimum_clearance_percentage AS DOUBLE))
      comment: "Average minimum clearance percentage required, indicating network programming control"
    - name: "avg_local_ad_avails_per_hour"
      expr: AVG(CAST(local_ad_avails_minutes_per_hour AS DOUBLE))
      comment: "Average local ad availability minutes per hour, measuring local revenue opportunity"
    - name: "affiliate_agreement_count"
      expr: COUNT(affiliate_agreement_id)
      comment: "Number of affiliate agreements, tracking network distribution footprint"
    - name: "avg_affiliation_fee"
      expr: AVG(CAST(affiliation_fee_amount AS DOUBLE))
      comment: "Average affiliation fee per agreement, indicating typical affiliate relationship value"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`partner_distribution_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content distribution agreement metrics tracking carriage fees, minimum guarantees, rights windows, and distribution economics across platforms"
  source: "`media_broadcasting_ecm`.`partner`.`distribution_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the distribution agreement (active, expired, pending, terminated)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of distribution agreement (linear, VOD, SVOD, AVOD, TVOD, hybrid)"
    - name: "carriage_fee_structure"
      expr: carriage_fee_structure
      comment: "Structure of carriage fees (per-subscriber, flat fee, tiered, revenue share)"
    - name: "territory"
      expr: territory
      comment: "Geographic territory covered by the distribution agreement"
    - name: "channel_positioning_tier"
      expr: channel_positioning_tier
      comment: "Tier or positioning of channel in distribution lineup (basic, premium, sports, etc.)"
    - name: "streaming_rights_included"
      expr: streaming_rights_included
      comment: "Whether streaming rights are included in the agreement"
    - name: "svod_rights_included"
      expr: svod_rights_included
      comment: "Whether SVOD rights are included"
    - name: "vod_rights_included"
      expr: vod_rights_included
      comment: "Whether VOD rights are included"
    - name: "must_carry_obligation"
      expr: must_carry_obligation
      comment: "Whether distributor has must-carry obligation"
    - name: "agreement_year"
      expr: YEAR(effective_date)
      comment: "Year the distribution agreement became effective"
  measures:
    - name: "total_carriage_fees"
      expr: SUM(CAST(carriage_fee_amount AS DOUBLE))
      comment: "Total carriage fees from distribution agreements, representing distribution revenue or cost"
    - name: "total_minimum_guarantees"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee amounts in distribution agreements, representing guaranteed distribution revenue"
    - name: "avg_sla_uptime_percentage"
      expr: AVG(CAST(sla_uptime_percentage AS DOUBLE))
      comment: "Average SLA uptime percentage across distribution agreements, measuring service quality commitments"
    - name: "distribution_agreement_count"
      expr: COUNT(distribution_agreement_id)
      comment: "Number of distribution agreements, tracking distribution partner relationships"
    - name: "avg_carriage_fee"
      expr: AVG(CAST(carriage_fee_amount AS DOUBLE))
      comment: "Average carriage fee per distribution agreement, indicating typical distribution economics"
    - name: "streaming_enabled_agreement_count"
      expr: COUNT(CASE WHEN streaming_rights_included = TRUE THEN distribution_agreement_id END)
      comment: "Number of agreements with streaming rights, measuring digital distribution reach"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`partner_syndication_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content syndication agreement metrics tracking syndication fees, revenue share, run limits, and secondary market content monetization"
  source: "`media_broadcasting_ecm`.`partner`.`syndication_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the syndication agreement (active, expired, pending, terminated)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of syndication agreement (first-run, off-network, barter, cash-plus-barter)"
    - name: "syndication_fee_structure"
      expr: syndication_fee_structure
      comment: "Structure of syndication fees (flat fee, per-episode, revenue share, barter)"
    - name: "territory_grant"
      expr: territory_grant
      comment: "Geographic territory granted for syndication"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the syndication agreement is exclusive"
    - name: "broadcast_standard"
      expr: broadcast_standard
      comment: "Broadcast standard required (NTSC, PAL, ATSC, DVB, etc.)"
    - name: "delivery_format"
      expr: delivery_format
      comment: "Format for content delivery (tape, file, satellite, IP)"
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Whether the agreement includes renewal options"
    - name: "agreement_year"
      expr: YEAR(effective_start_date)
      comment: "Year the syndication agreement became effective"
  measures:
    - name: "total_flat_fees"
      expr: SUM(CAST(flat_fee_amount AS DOUBLE))
      comment: "Total flat syndication fees, representing guaranteed syndication revenue"
    - name: "total_per_episode_fees"
      expr: SUM(CAST(per_episode_fee_amount AS DOUBLE))
      comment: "Total per-episode syndication fees, representing episode-based syndication revenue"
    - name: "total_minimum_guarantees"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee amounts in syndication agreements, representing guaranteed partner payments"
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage across syndication agreements, indicating typical syndication economics"
    - name: "syndication_agreement_count"
      expr: COUNT(syndication_agreement_id)
      comment: "Number of syndication agreements, tracking secondary market distribution reach"
    - name: "exclusive_syndication_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN syndication_agreement_id END)
      comment: "Number of exclusive syndication agreements, measuring competitive syndication positioning"
    - name: "avg_flat_fee"
      expr: AVG(CAST(flat_fee_amount AS DOUBLE))
      comment: "Average flat fee per syndication agreement, indicating typical syndication deal value"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`partner_minimum_guarantee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Minimum guarantee recoupment and overage metrics tracking guaranteed payments, recouped amounts, outstanding balances, and partner payment performance"
  source: "`media_broadcasting_ecm`.`partner`.`minimum_guarantee`"
  dimensions:
    - name: "mg_status"
      expr: mg_status
      comment: "Status of the minimum guarantee (active, recouped, outstanding, written-off)"
    - name: "mg_type"
      expr: mg_type
      comment: "Type of minimum guarantee (acquisition, distribution, syndication, license)"
    - name: "is_recoupable"
      expr: is_recoupable
      comment: "Whether the minimum guarantee is recoupable from revenue"
    - name: "is_cross_collateralized"
      expr: is_cross_collateralized
      comment: "Whether the MG is cross-collateralized across multiple titles or deals"
    - name: "recoupment_basis"
      expr: recoupment_basis
      comment: "Basis for recoupment calculation (gross revenue, net revenue, adjusted gross)"
    - name: "payment_schedule_type"
      expr: payment_schedule_type
      comment: "Type of payment schedule (upfront, milestone-based, installment, delivery-based)"
    - name: "amortization_method"
      expr: amortization_method
      comment: "Method used for amortizing the minimum guarantee (straight-line, usage-based, accelerated)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the minimum guarantee is denominated"
    - name: "mg_year"
      expr: YEAR(effective_start_date)
      comment: "Year the minimum guarantee became effective"
  measures:
    - name: "total_mg_amount"
      expr: SUM(CAST(mg_amount AS DOUBLE))
      comment: "Total minimum guarantee amounts committed, representing guaranteed partner payments and financial exposure"
    - name: "total_recouped_amount"
      expr: SUM(CAST(recouped_to_date_amount AS DOUBLE))
      comment: "Total amount recouped from revenue against minimum guarantees, measuring revenue performance vs commitments"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance_amount AS DOUBLE))
      comment: "Total outstanding balance on minimum guarantees, representing unrecouped financial exposure"
    - name: "total_overage_amount"
      expr: SUM(CAST(overage_amount AS DOUBLE))
      comment: "Total overage amounts beyond minimum guarantees, representing incremental partner payments and content success"
    - name: "avg_recoupment_percentage"
      expr: AVG(CAST(recoupment_percentage AS DOUBLE))
      comment: "Average recoupment percentage across minimum guarantees, indicating typical revenue share terms"
    - name: "mg_count"
      expr: COUNT(minimum_guarantee_id)
      comment: "Number of minimum guarantee commitments, tracking partner payment obligations"
    - name: "recoupment_rate"
      expr: SUM(CAST(recouped_to_date_amount AS DOUBLE)) / NULLIF(SUM(CAST(mg_amount AS DOUBLE)), 0)
      comment: "Overall recoupment rate across all minimum guarantees, measuring content performance vs financial commitments"
    - name: "fully_recouped_count"
      expr: COUNT(CASE WHEN mg_status = 'recouped' THEN minimum_guarantee_id END)
      comment: "Number of fully recouped minimum guarantees, measuring successful content investments"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`partner_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner relationship portfolio metrics tracking partner value, content volume, strategic tier, and relationship health across the partner ecosystem"
  source: "`media_broadcasting_ecm`.`partner`.`partner_partner`"
  dimensions:
    - name: "partner_type"
      expr: partner_type
      comment: "Type of partner (content provider, distributor, affiliate, co-producer, vendor, licensor)"
    - name: "relationship_status"
      expr: relationship_status
      comment: "Current status of the partner relationship (active, inactive, pending, terminated)"
    - name: "strategic_tier"
      expr: strategic_tier
      comment: "Strategic tier of the partner (tier 1, tier 2, tier 3, strategic, tactical)"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier of the partner (low, medium, high, critical)"
    - name: "content_specialization"
      expr: content_specialization
      comment: "Content specialization of the partner (drama, sports, news, documentary, kids, etc.)"
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Whether the partnership is exclusive"
    - name: "domicile_country_code"
      expr: domicile_country_code
      comment: "Country code where the partner is domiciled"
    - name: "onboarding_stage"
      expr: onboarding_stage
      comment: "Current onboarding stage of the partner (prospect, onboarding, active, offboarding)"
    - name: "relationship_year"
      expr: YEAR(relationship_start_date)
      comment: "Year the partner relationship started"
  measures:
    - name: "total_annual_revenue_contribution"
      expr: SUM(CAST(annual_revenue_contribution_usd AS DOUBLE))
      comment: "Total annual revenue contribution from all partners, measuring partner ecosystem value"
    - name: "total_annual_content_volume_hours"
      expr: SUM(CAST(annual_content_volume_hours AS DOUBLE))
      comment: "Total annual content volume hours from all partners, measuring content supply"
    - name: "partner_count"
      expr: COUNT(partner_id)
      comment: "Number of partners, tracking partner ecosystem size and diversity"
    - name: "active_partner_count"
      expr: COUNT(CASE WHEN relationship_status = 'active' THEN partner_id END)
      comment: "Number of active partners, measuring current partner ecosystem health"
    - name: "strategic_partner_count"
      expr: COUNT(CASE WHEN strategic_tier IN ('tier 1', 'strategic') THEN partner_id END)
      comment: "Number of strategic tier partners, measuring high-value relationship concentration"
    - name: "exclusive_partner_count"
      expr: COUNT(CASE WHEN is_exclusive = TRUE THEN partner_id END)
      comment: "Number of exclusive partners, measuring competitive content positioning"
    - name: "avg_annual_revenue_per_partner"
      expr: AVG(CAST(annual_revenue_contribution_usd AS DOUBLE))
      comment: "Average annual revenue contribution per partner, indicating typical partner value"
    - name: "avg_content_volume_per_partner"
      expr: AVG(CAST(annual_content_volume_hours AS DOUBLE))
      comment: "Average annual content volume per partner, measuring typical partner content supply"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`partner_carriage_fee_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carriage fee schedule economics metrics tracking per-subscriber fees, volume discounts, escalation rates, and distribution pricing strategy"
  source: "`media_broadcasting_ecm`.`partner`.`carriage_fee_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the carriage fee schedule (active, expired, pending, superseded)"
    - name: "fee_type"
      expr: fee_type
      comment: "Type of carriage fee (per-subscriber, flat, tiered, revenue-share)"
    - name: "escalation_type"
      expr: escalation_type
      comment: "Type of fee escalation (fixed percentage, CPI-linked, performance-based, none)"
    - name: "escalation_frequency"
      expr: escalation_frequency
      comment: "Frequency of fee escalation (annual, biennial, contract-term)"
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of carriage fee payments (monthly, quarterly, annually)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which carriage fees are denominated"
    - name: "mfn_provision_flag"
      expr: mfn_provision_flag
      comment: "Whether most-favored-nation provision is included"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the fee schedule automatically renews"
    - name: "schedule_year"
      expr: YEAR(effective_start_date)
      comment: "Year the carriage fee schedule became effective"
  measures:
    - name: "avg_base_fee_per_subscriber"
      expr: AVG(CAST(base_fee_per_subscriber AS DOUBLE))
      comment: "Average base fee per subscriber across schedules, measuring typical per-subscriber carriage economics"
    - name: "avg_escalation_rate"
      expr: AVG(CAST(escalation_rate_percentage AS DOUBLE))
      comment: "Average escalation rate percentage, indicating typical fee growth trajectory"
    - name: "total_minimum_guaranteed_fees"
      expr: SUM(CAST(minimum_guaranteed_fee AS DOUBLE))
      comment: "Total minimum guaranteed fees across schedules, representing guaranteed carriage revenue floor"
    - name: "avg_late_payment_penalty_rate"
      expr: AVG(CAST(late_payment_penalty_rate AS DOUBLE))
      comment: "Average late payment penalty rate, measuring payment enforcement terms"
    - name: "carriage_fee_schedule_count"
      expr: COUNT(carriage_fee_schedule_id)
      comment: "Number of carriage fee schedules, tracking pricing structure complexity"
    - name: "avg_tier_1_discount_rate"
      expr: AVG(CAST(volume_discount_tier_1_rate AS DOUBLE))
      comment: "Average tier 1 volume discount rate, measuring volume pricing incentives"
    - name: "avg_maximum_fee_cap"
      expr: AVG(CAST(maximum_fee_cap AS DOUBLE))
      comment: "Average maximum fee cap, indicating typical fee ceiling in carriage agreements"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`partner_delivery_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content delivery obligation performance metrics tracking delivery timeliness, quality control, SLA compliance, and fulfillment efficiency"
  source: "`media_broadcasting_ecm`.`partner`.`delivery_obligation`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Status of the delivery obligation (pending, in-progress, delivered, accepted, rejected)"
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of delivery obligation (initial delivery, redelivery, supplemental, amendment)"
    - name: "quality_control_status"
      expr: quality_control_status
      comment: "Quality control status (pending QC, passed, failed, conditional pass)"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of content delivery (physical media, file transfer, satellite, IP streaming)"
    - name: "required_format"
      expr: required_format
      comment: "Required delivery format (ProRes, IMF, H.264, MPEG-2, etc.)"
    - name: "required_resolution"
      expr: required_resolution
      comment: "Required video resolution (SD, HD, 4K, 8K)"
    - name: "sla_compliance"
      expr: sla_compliance
      comment: "Whether delivery met SLA requirements"
    - name: "redelivery_required"
      expr: redelivery_required
      comment: "Whether redelivery is required due to quality or technical issues"
    - name: "closed_caption_required"
      expr: closed_caption_required
      comment: "Whether closed captions are required"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the delivery obligation (urgent, high, normal, low)"
    - name: "delivery_year"
      expr: YEAR(delivery_deadline)
      comment: "Year of the delivery deadline"
  measures:
    - name: "delivery_obligation_count"
      expr: COUNT(delivery_obligation_id)
      comment: "Number of delivery obligations, tracking content fulfillment workload"
    - name: "delivered_count"
      expr: COUNT(CASE WHEN delivery_status = 'delivered' THEN delivery_obligation_id END)
      comment: "Number of delivered obligations, measuring fulfillment completion"
    - name: "sla_compliant_count"
      expr: COUNT(CASE WHEN sla_compliance = TRUE THEN delivery_obligation_id END)
      comment: "Number of SLA-compliant deliveries, measuring service level performance"
    - name: "redelivery_required_count"
      expr: COUNT(CASE WHEN redelivery_required = TRUE THEN delivery_obligation_id END)
      comment: "Number of obligations requiring redelivery, measuring quality and technical issues"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts for missed delivery obligations, measuring financial impact of delivery failures"
    - name: "avg_file_size_gb"
      expr: AVG(CAST(file_size_gb AS DOUBLE))
      comment: "Average file size in GB, measuring typical content delivery payload"
    - name: "sla_compliance_rate"
      expr: COUNT(CASE WHEN sla_compliance = TRUE THEN delivery_obligation_id END) / NULLIF(COUNT(delivery_obligation_id), 0)
      comment: "SLA compliance rate, measuring percentage of deliveries meeting service level agreements"
    - name: "redelivery_rate"
      expr: COUNT(CASE WHEN redelivery_required = TRUE THEN delivery_obligation_id END) / NULLIF(COUNT(delivery_obligation_id), 0)
      comment: "Redelivery rate, measuring percentage of deliveries requiring rework due to quality issues"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`partner_payment_term`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner payment term performance metrics tracking payment amounts, timeliness, late payment penalties, and cash flow management"
  source: "`media_broadcasting_ecm`.`partner`.`payment_term`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment term (pending, scheduled, paid, overdue, disputed)"
    - name: "term_type"
      expr: term_type
      comment: "Type of payment term (upfront, milestone, installment, royalty, residual)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (wire transfer, ACH, check, credit card)"
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of payment (one-time, monthly, quarterly, annually, upon-delivery)"
    - name: "payment_milestone"
      expr: payment_milestone
      comment: "Milestone triggering payment (contract signing, delivery, acceptance, broadcast, revenue threshold)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which payment is denominated"
    - name: "invoice_required_flag"
      expr: invoice_required_flag
      comment: "Whether invoice is required for payment"
    - name: "payment_approval_required_flag"
      expr: payment_approval_required_flag
      comment: "Whether payment requires approval"
    - name: "payment_year"
      expr: YEAR(payment_due_date)
      comment: "Year the payment is due"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment amounts across all terms, representing total partner payment obligations or receivables"
    - name: "avg_late_payment_penalty_rate"
      expr: AVG(CAST(late_payment_penalty_rate AS DOUBLE))
      comment: "Average late payment penalty rate, measuring payment enforcement terms"
    - name: "avg_withholding_tax_rate"
      expr: AVG(CAST(withholding_tax_rate AS DOUBLE))
      comment: "Average withholding tax rate, measuring tax burden on partner payments"
    - name: "payment_term_count"
      expr: COUNT(payment_term_id)
      comment: "Number of payment terms, tracking payment obligation complexity"
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per term, indicating typical payment size"
$$;