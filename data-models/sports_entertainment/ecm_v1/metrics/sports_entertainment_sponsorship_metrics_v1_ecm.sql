-- Metric views for domain: sponsorship | Business: Sports Entertainment | Version: 1 | Generated on: 2026-05-09 01:35:39

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`sponsorship_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core sponsorship deal performance metrics tracking contract value, audience commitments, and deal lifecycle"
  source: "`sports_entertainment_ecm`.`sponsorship`.`deal`"
  dimensions:
    - name: "deal_type"
      expr: deal_type
      comment: "Type of sponsorship deal (e.g., naming rights, jersey, broadcast integration)"
    - name: "deal_stage"
      expr: stage
      comment: "Current stage of the deal in the sales pipeline"
    - name: "exclusivity_category"
      expr: exclusivity_category
      comment: "Category of exclusivity granted to the sponsor"
    - name: "territory"
      expr: territory
      comment: "Geographic territory covered by the deal"
    - name: "digital_partnership_type"
      expr: digital_partnership_type
      comment: "Type of digital partnership included in the deal"
    - name: "payment_schedule_type"
      expr: payment_schedule_type
      comment: "Payment schedule structure (e.g., annual, quarterly, milestone-based)"
    - name: "contract_year"
      expr: YEAR(start_date)
      comment: "Year the contract started"
    - name: "contract_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the contract started"
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Whether the deal includes a renewal option"
    - name: "nil_rights_included"
      expr: nil_rights_included
      comment: "Whether Name, Image, Likeness rights are included"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contract value across all deals"
    - name: "annual_contract_value"
      expr: SUM(CAST(annual_contract_value AS DOUBLE))
      comment: "Annual contract value (ACV) across all deals"
    - name: "avg_deal_size"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average total contract value per deal"
    - name: "deal_count"
      expr: COUNT(DISTINCT deal_id)
      comment: "Number of unique sponsorship deals"
    - name: "avg_cpm_rate"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average cost per thousand impressions across deals"
    - name: "total_impression_commitment"
      expr: SUM(CAST(impression_commitment AS BIGINT))
      comment: "Total committed impressions across all deals"
    - name: "total_grp_commitment"
      expr: SUM(CAST(grp_commitment AS DOUBLE))
      comment: "Total Gross Rating Points committed across deals"
    - name: "avg_audience_commitment"
      expr: AVG(CAST(audience_commitment_size AS BIGINT))
      comment: "Average audience size commitment per deal"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`sponsorship_activation_fulfillment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sponsorship activation delivery and performance metrics tracking fulfillment quality, impressions, and media value"
  source: "`sports_entertainment_ecm`.`sponsorship`.`activation_fulfillment`"
  dimensions:
    - name: "activation_type"
      expr: activation_type
      comment: "Type of sponsorship activation (e.g., signage, broadcast mention, digital)"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current status of the activation fulfillment"
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Channel through which the activation was fulfilled"
    - name: "placement_location"
      expr: placement_location
      comment: "Physical or digital location of the activation placement"
    - name: "fulfillment_month"
      expr: DATE_TRUNC('MONTH', fulfillment_date)
      comment: "Month when the activation was fulfilled"
    - name: "brand_safety_compliant"
      expr: brand_safety_compliant
      comment: "Whether the activation met brand safety standards"
    - name: "makegood_required"
      expr: makegood_required
      comment: "Whether a makegood is required due to underdelivery"
    - name: "sponsor_acknowledged"
      expr: sponsor_acknowledged
      comment: "Whether the sponsor has acknowledged the fulfillment"
  measures:
    - name: "activation_count"
      expr: COUNT(DISTINCT activation_fulfillment_id)
      comment: "Number of unique activation fulfillments"
    - name: "total_fulfillment_value"
      expr: SUM(CAST(fulfillment_value_usd AS DOUBLE))
      comment: "Total value of fulfilled activations in USD"
    - name: "total_impressions_delivered"
      expr: SUM(CAST(impressions_delivered AS BIGINT))
      comment: "Total impressions delivered across all activations"
    - name: "total_impressions_contracted"
      expr: SUM(CAST(impressions_contracted AS BIGINT))
      comment: "Total impressions contracted across all activations"
    - name: "total_shortfall_impressions"
      expr: SUM(CAST(shortfall_impressions AS BIGINT))
      comment: "Total impressions underdelivered (shortfall)"
    - name: "delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(impressions_delivered AS BIGINT)) / NULLIF(SUM(CAST(impressions_contracted AS BIGINT)), 0), 2)
      comment: "Percentage of contracted impressions actually delivered"
    - name: "avg_fulfillment_quality_rating"
      expr: AVG(CAST(fulfillment_quality_rating AS DOUBLE))
      comment: "Average quality rating of fulfilled activations"
    - name: "total_grp_achieved"
      expr: SUM(CAST(grp_achieved AS DOUBLE))
      comment: "Total Gross Rating Points achieved across activations"
    - name: "total_grp_contracted"
      expr: SUM(CAST(grp_contracted AS DOUBLE))
      comment: "Total Gross Rating Points contracted across activations"
    - name: "grp_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(grp_achieved AS DOUBLE)) / NULLIF(SUM(CAST(grp_contracted AS DOUBLE)), 0), 2)
      comment: "Percentage of contracted GRPs actually achieved"
    - name: "avg_cpm_realized"
      expr: AVG(CAST(cpm_realized AS DOUBLE))
      comment: "Average realized cost per thousand impressions"
    - name: "total_audience_reach"
      expr: SUM(CAST(audience_reach AS BIGINT))
      comment: "Total audience reach across all activations"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`sponsorship_sponsor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sponsor relationship and investment metrics tracking partner value, engagement, and retention"
  source: "`sports_entertainment_ecm`.`sponsorship`.`sponsor`"
  dimensions:
    - name: "account_tier"
      expr: account_tier
      comment: "Tier classification of the sponsor account"
    - name: "industry_category"
      expr: industry_category
      comment: "Industry category of the sponsor organization"
    - name: "relationship_status"
      expr: relationship_status
      comment: "Current status of the sponsor relationship"
    - name: "exclusivity_category"
      expr: exclusivity_category
      comment: "Category of exclusivity granted to the sponsor"
    - name: "headquarters_country"
      expr: headquarters_country
      comment: "Country where the sponsor is headquartered"
    - name: "activation_region"
      expr: activation_region
      comment: "Geographic region where activations occur"
    - name: "relationship_year"
      expr: YEAR(relationship_start_date)
      comment: "Year the sponsor relationship started"
    - name: "jersey_sponsorship_flag"
      expr: jersey_sponsorship_flag
      comment: "Whether the sponsor has jersey sponsorship rights"
    - name: "naming_rights_flag"
      expr: naming_rights_flag
      comment: "Whether the sponsor has naming rights"
    - name: "nil_partnership_flag"
      expr: nil_partnership_flag
      comment: "Whether the sponsor has NIL partnership agreements"
  measures:
    - name: "sponsor_count"
      expr: COUNT(DISTINCT sponsor_id)
      comment: "Number of unique sponsors"
    - name: "total_annual_investment"
      expr: SUM(CAST(annual_investment_usd AS DOUBLE))
      comment: "Total annual investment from all sponsors in USD"
    - name: "avg_annual_investment"
      expr: AVG(CAST(annual_investment_usd AS DOUBLE))
      comment: "Average annual investment per sponsor in USD"
    - name: "total_value_in_kind"
      expr: SUM(CAST(value_in_kind_usd AS DOUBLE))
      comment: "Total value-in-kind contributions from sponsors in USD"
    - name: "avg_renewal_probability"
      expr: AVG(CAST(renewal_probability AS DOUBLE))
      comment: "Average renewal probability across all sponsors"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score across sponsors"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`sponsorship_performance_metric`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sponsorship performance measurement and ROI tracking metrics for activation effectiveness"
  source: "`sports_entertainment_ecm`.`sponsorship`.`performance_metric`"
  dimensions:
    - name: "metric_type"
      expr: metric_type
      comment: "Type of performance metric being measured"
    - name: "metric_category"
      expr: metric_category
      comment: "Category of the performance metric"
    - name: "activation_channel"
      expr: activation_channel
      comment: "Channel through which the activation occurred"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Status of the activation fulfillment"
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the performance measurement"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_period_start)
      comment: "Month when the measurement period started"
    - name: "is_contracted_kpi"
      expr: is_contracted_kpi
      comment: "Whether this is a contractually committed KPI"
    - name: "make_good_required"
      expr: make_good_required
      comment: "Whether a makegood is required due to underperformance"
    - name: "sponsor_verified"
      expr: sponsor_verified
      comment: "Whether the sponsor has verified the performance data"
  measures:
    - name: "metric_count"
      expr: COUNT(DISTINCT performance_metric_id)
      comment: "Number of unique performance metrics recorded"
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS BIGINT))
      comment: "Total impressions across all measured activations"
    - name: "avg_brand_recall_score"
      expr: AVG(CAST(brand_recall_score AS DOUBLE))
      comment: "Average brand recall score across measurements"
    - name: "total_grp_delivered"
      expr: SUM(CAST(grp_delivered AS DOUBLE))
      comment: "Total Gross Rating Points delivered"
    - name: "avg_cpm_realized"
      expr: AVG(CAST(cpm_realized AS DOUBLE))
      comment: "Average realized cost per thousand impressions"
    - name: "avg_social_engagement_rate"
      expr: AVG(CAST(social_engagement_rate AS DOUBLE))
      comment: "Average social media engagement rate"
    - name: "avg_nps_lift"
      expr: AVG(CAST(nps_lift AS DOUBLE))
      comment: "Average Net Promoter Score lift attributed to sponsorship"
    - name: "total_reach_thousands"
      expr: SUM(CAST(reach_000s AS DOUBLE))
      comment: "Total reach in thousands across all measurements"
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average percentage variance between actual and contracted performance"
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual performance value"
    - name: "avg_contracted_target"
      expr: AVG(CAST(contracted_target_value AS DOUBLE))
      comment: "Average contracted target performance value"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`sponsorship_payment_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sponsorship payment and revenue recognition metrics tracking cash flow, collections, and financial performance"
  source: "`sports_entertainment_ecm`.`sponsorship`.`payment_schedule`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment"
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g., milestone, recurring, final)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the payment is denominated"
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month when the payment is due"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month when the invoice was issued"
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month when the payment was received"
    - name: "forecast_period"
      expr: forecast_period
      comment: "Forecast period for the payment"
  measures:
    - name: "payment_count"
      expr: COUNT(DISTINCT payment_schedule_id)
      comment: "Number of unique scheduled payments"
    - name: "total_scheduled_amount"
      expr: SUM(CAST(scheduled_amount AS DOUBLE))
      comment: "Total scheduled payment amount"
    - name: "total_received_amount"
      expr: SUM(CAST(received_amount AS DOUBLE))
      comment: "Total amount actually received"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after adjustments"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total payment adjustments"
    - name: "total_late_fees"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late fees charged"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax amount"
    - name: "collection_rate"
      expr: ROUND(100.0 * SUM(CAST(received_amount AS DOUBLE)) / NULLIF(SUM(CAST(scheduled_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of scheduled payments actually collected"
    - name: "avg_days_overdue"
      expr: AVG(CAST(days_overdue AS DOUBLE))
      comment: "Average number of days payments are overdue"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`sponsorship_hospitality_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hospitality entitlement utilization and satisfaction metrics tracking sponsor guest experiences"
  source: "`sports_entertainment_ecm`.`sponsorship`.`hospitality_entitlement`"
  dimensions:
    - name: "entitlement_type"
      expr: entitlement_type
      comment: "Type of hospitality entitlement (e.g., suite, club access, VIP)"
    - name: "entitlement_status"
      expr: entitlement_status
      comment: "Current status of the entitlement"
    - name: "event_scope"
      expr: event_scope
      comment: "Scope of events covered by the entitlement"
    - name: "redemption_channel"
      expr: redemption_channel
      comment: "Channel through which entitlements are redeemed"
    - name: "catering_included_flag"
      expr: catering_included_flag
      comment: "Whether catering is included in the entitlement"
    - name: "transferable_flag"
      expr: transferable_flag
      comment: "Whether the entitlement can be transferred"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the entitlement became effective"
  measures:
    - name: "entitlement_count"
      expr: COUNT(DISTINCT hospitality_entitlement_id)
      comment: "Number of unique hospitality entitlements"
    - name: "total_contractual_value"
      expr: SUM(CAST(contractual_value AS DOUBLE))
      comment: "Total contractual value of all hospitality entitlements"
    - name: "total_quantity_allocated"
      expr: SUM(CAST(quantity_allocated AS BIGINT))
      comment: "Total quantity of entitlements allocated"
    - name: "total_quantity_redeemed"
      expr: SUM(CAST(quantity_redeemed AS BIGINT))
      comment: "Total quantity of entitlements redeemed"
    - name: "total_quantity_remaining"
      expr: SUM(CAST(quantity_remaining AS BIGINT))
      comment: "Total quantity of entitlements remaining"
    - name: "utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_redeemed AS BIGINT)) / NULLIF(SUM(CAST(quantity_allocated AS BIGINT)), 0), 2)
      comment: "Percentage of allocated entitlements actually redeemed"
    - name: "avg_satisfaction_rating"
      expr: AVG(CAST(avg_satisfaction_rating AS DOUBLE))
      comment: "Average satisfaction rating from hospitality guests"
    - name: "avg_face_value_per_unit"
      expr: AVG(CAST(face_value_per_unit AS DOUBLE))
      comment: "Average face value per entitlement unit"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`sponsorship_naming_right`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Naming rights deal performance and valuation metrics tracking premium sponsorship assets"
  source: "`sports_entertainment_ecm`.`sponsorship`.`naming_right`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of naming rights agreement"
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the naming rights agreement"
    - name: "named_asset_type"
      expr: named_asset_type
      comment: "Type of asset being named (e.g., venue, event, award)"
    - name: "exclusivity_category"
      expr: exclusivity_category
      comment: "Category of exclusivity granted"
    - name: "payment_schedule_type"
      expr: payment_schedule_type
      comment: "Payment schedule structure for the naming rights"
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Whether the agreement includes a renewal option"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the naming rights became effective"
    - name: "ip_rights_included_flag"
      expr: ip_rights_included_flag
      comment: "Whether intellectual property rights are included"
  measures:
    - name: "naming_rights_count"
      expr: COUNT(DISTINCT naming_right_id)
      comment: "Number of unique naming rights agreements"
    - name: "total_fee_amount"
      expr: SUM(CAST(total_fee_amount AS DOUBLE))
      comment: "Total fee amount across all naming rights agreements"
    - name: "total_annual_fee"
      expr: SUM(CAST(annual_fee_amount AS DOUBLE))
      comment: "Total annual fee amount across all naming rights"
    - name: "avg_annual_fee"
      expr: AVG(CAST(annual_fee_amount AS DOUBLE))
      comment: "Average annual fee per naming rights agreement"
    - name: "total_activation_budget"
      expr: SUM(CAST(activation_budget_amount AS DOUBLE))
      comment: "Total activation budget across all naming rights"
    - name: "avg_cpm_rate"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average cost per thousand impressions for naming rights"
    - name: "total_grp_commitment"
      expr: SUM(CAST(grp_commitment AS DOUBLE))
      comment: "Total Gross Rating Points committed across naming rights"
    - name: "avg_roi_target"
      expr: AVG(CAST(roi_target_pct AS DOUBLE))
      comment: "Average ROI target percentage for naming rights"
    - name: "avg_fee_escalation_rate"
      expr: AVG(CAST(fee_escalation_rate AS DOUBLE))
      comment: "Average annual fee escalation rate"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`sponsorship_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sponsorship renewal pipeline and conversion metrics tracking retention and growth"
  source: "`sports_entertainment_ecm`.`sponsorship`.`renewal`"
  dimensions:
    - name: "renewal_type"
      expr: renewal_type
      comment: "Type of renewal (e.g., standard, early, extended)"
    - name: "stage"
      expr: stage
      comment: "Current stage in the renewal pipeline"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the renewal process"
    - name: "sponsor_intent"
      expr: sponsor_intent
      comment: "Sponsor's stated intent regarding renewal"
    - name: "decline_reason_code"
      expr: decline_reason_code
      comment: "Reason code if renewal was declined"
    - name: "auto_renewal_clause"
      expr: auto_renewal_clause
      comment: "Whether the deal has an auto-renewal clause"
    - name: "initiation_year"
      expr: YEAR(initiation_date)
      comment: "Year the renewal process was initiated"
    - name: "naming_rights_included"
      expr: naming_rights_included
      comment: "Whether naming rights are included in the renewal"
    - name: "nil_rights_included"
      expr: nil_rights_included
      comment: "Whether NIL rights are included in the renewal"
  measures:
    - name: "renewal_count"
      expr: COUNT(DISTINCT renewal_id)
      comment: "Number of unique renewal opportunities"
    - name: "total_original_tcv"
      expr: SUM(CAST(original_tcv AS DOUBLE))
      comment: "Total original contract value of deals up for renewal"
    - name: "total_proposed_tcv"
      expr: SUM(CAST(proposed_tcv AS DOUBLE))
      comment: "Total proposed contract value for renewals"
    - name: "avg_uplift_percentage"
      expr: AVG(CAST(uplift_percentage AS DOUBLE))
      comment: "Average percentage uplift from original to proposed value"
    - name: "avg_probability"
      expr: AVG(CAST(probability_pct AS DOUBLE))
      comment: "Average probability of renewal success"
    - name: "weighted_renewal_value"
      expr: SUM(CAST(proposed_tcv AS DOUBLE) * CAST(probability_pct AS DOUBLE) / 100.0)
      comment: "Probability-weighted total proposed contract value"
    - name: "total_proposed_annual_value"
      expr: SUM(CAST(proposed_annual_value AS DOUBLE))
      comment: "Total proposed annual value across all renewals"
    - name: "avg_proposed_term_years"
      expr: AVG(CAST(proposed_term_years AS DOUBLE))
      comment: "Average proposed term length in years"
$$;