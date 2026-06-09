-- Metric views for domain: brokerage | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 01:37:58

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`brokerage_commission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core commission revenue and payment metrics for brokerage operations, tracking gross commission income, agent splits, co-broker arrangements, and payment status across transaction types and brokerage sides."
  source: "`real_estate_ecm`.`brokerage`.`commission`"
  dimensions:
    - name: "commission_status"
      expr: commission_status
      comment: "Current status of the commission (e.g., pending, approved, paid, disputed)"
    - name: "commission_type"
      expr: commission_type
      comment: "Type of commission structure (e.g., percentage, flat fee, tiered)"
    - name: "brokerage_side"
      expr: brokerage_side
      comment: "Side of the transaction (buyer-side or seller-side representation)"
    - name: "payment_schedule"
      expr: payment_schedule
      comment: "Payment schedule type (e.g., at closing, installment, milestone-based)"
    - name: "trigger_event"
      expr: trigger_event
      comment: "Event that triggered commission calculation (e.g., lease execution, sale closing, occupancy)"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the commission was approved"
    - name: "approval_quarter"
      expr: CONCAT('Q', QUARTER(approval_date), '-', YEAR(approval_date))
      comment: "Quarter and year the commission was approved"
    - name: "paid_year"
      expr: YEAR(paid_date)
      comment: "Year the commission was paid"
    - name: "paid_month"
      expr: DATE_TRUNC('MONTH', paid_date)
      comment: "Month the commission was paid"
    - name: "is_co_broker"
      expr: is_co_broker
      comment: "Flag indicating whether commission involves co-brokerage arrangement"
    - name: "is_referral"
      expr: is_referral
      comment: "Flag indicating whether commission originated from a referral"
  measures:
    - name: "total_gross_commission"
      expr: SUM(CAST(gross_commission_amount AS DOUBLE))
      comment: "Total gross commission income before any splits or deductions"
    - name: "total_agent_commission"
      expr: SUM(CAST(agent_commission_amount AS DOUBLE))
      comment: "Total commission amount paid to individual agents after house split"
    - name: "total_net_commission_to_house"
      expr: SUM(CAST(net_commission_to_house AS DOUBLE))
      comment: "Total net commission retained by the brokerage house after agent splits"
    - name: "total_co_broker_commission"
      expr: SUM(CAST(co_broker_commission_amount AS DOUBLE))
      comment: "Total commission paid to cooperating brokers in co-brokerage arrangements"
    - name: "total_referral_fees"
      expr: SUM(CAST(referral_fee_amount AS DOUBLE))
      comment: "Total referral fees paid for referred business"
    - name: "total_consideration"
      expr: SUM(CAST(consideration_amount AS DOUBLE))
      comment: "Total transaction consideration amount (sale price or lease value) on which commissions are based"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount of commission actually disbursed to date"
    - name: "total_tax_withholding"
      expr: SUM(CAST(tax_withholding_amount AS DOUBLE))
      comment: "Total tax withholding amount deducted from commission payments"
    - name: "avg_commission_rate"
      expr: AVG(CAST(rate_pct AS DOUBLE))
      comment: "Average commission rate percentage across transactions"
    - name: "avg_agent_split_pct"
      expr: AVG(CAST(agent_split_pct AS DOUBLE))
      comment: "Average agent split percentage of gross commission"
    - name: "avg_co_broker_split_pct"
      expr: AVG(CAST(co_broker_split_pct AS DOUBLE))
      comment: "Average co-broker split percentage in cooperative deals"
    - name: "commission_count"
      expr: COUNT(1)
      comment: "Total number of commission records"
    - name: "co_broker_deal_count"
      expr: SUM(CASE WHEN is_co_broker = TRUE THEN 1 ELSE 0 END)
      comment: "Number of deals involving co-brokerage arrangements"
    - name: "referral_deal_count"
      expr: SUM(CASE WHEN is_referral = TRUE THEN 1 ELSE 0 END)
      comment: "Number of deals originating from referrals"
    - name: "paid_commission_count"
      expr: COUNT(DISTINCT CASE WHEN paid_date IS NOT NULL THEN commission_id END)
      comment: "Number of commissions that have been paid"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`brokerage_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pipeline and deal performance metrics tracking deal progression, win rates, deal value, and sales cycle efficiency across stages, sources, and transaction types."
  source: "`real_estate_ecm`.`brokerage`.`brokerage_deal`"
  dimensions:
    - name: "stage"
      expr: stage
      comment: "Current pipeline stage of the deal (e.g., prospecting, qualification, proposal, negotiation, closing)"
    - name: "deal_type"
      expr: deal_type
      comment: "Type of deal (e.g., new lease, lease renewal, sale, sublease)"
    - name: "deal_source"
      expr: deal_source
      comment: "Source channel of the deal (e.g., inbound, outbound, referral, marketing campaign)"
    - name: "side"
      expr: side
      comment: "Representation side (landlord/seller or tenant/buyer)"
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Flag indicating whether the deal is under exclusive representation"
    - name: "is_co_brokerage"
      expr: is_co_brokerage
      comment: "Flag indicating whether the deal involves co-brokerage"
    - name: "projected_close_quarter"
      expr: CONCAT('Q', QUARTER(projected_close_date), '-', YEAR(projected_close_date))
      comment: "Quarter and year of projected close date"
    - name: "actual_close_quarter"
      expr: CONCAT('Q', QUARTER(actual_close_date), '-', YEAR(actual_close_date))
      comment: "Quarter and year of actual close date"
    - name: "actual_close_month"
      expr: DATE_TRUNC('MONTH', actual_close_date)
      comment: "Month of actual close date"
    - name: "dead_reason"
      expr: dead_reason
      comment: "Reason the deal was marked as dead/lost"
    - name: "loi_year"
      expr: YEAR(loi_date)
      comment: "Year the letter of intent was signed"
  measures:
    - name: "total_deal_value"
      expr: SUM(CAST(total_consideration AS DOUBLE))
      comment: "Total consideration value across all deals (sale price or total lease value)"
    - name: "total_sale_price"
      expr: SUM(CAST(sale_price AS DOUBLE))
      comment: "Total sale price for sale transactions"
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total expected commission amount across all deals"
    - name: "total_square_footage"
      expr: SUM(CAST(size_sqft AS DOUBLE))
      comment: "Total square footage across all deals"
    - name: "total_ti_allowance"
      expr: SUM(CAST(tenant_improvement_allowance AS DOUBLE))
      comment: "Total tenant improvement allowance committed across deals"
    - name: "avg_deal_value"
      expr: AVG(CAST(total_consideration AS DOUBLE))
      comment: "Average deal consideration value"
    - name: "avg_lease_rate_psf"
      expr: AVG(CAST(lease_rate_psf AS DOUBLE))
      comment: "Average lease rate per square foot"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage"
    - name: "avg_probability"
      expr: AVG(CAST(probability_pct AS DOUBLE))
      comment: "Average win probability percentage across deals"
    - name: "avg_co_broker_commission_pct"
      expr: AVG(CAST(co_broker_commission_pct AS DOUBLE))
      comment: "Average co-broker commission split percentage"
    - name: "deal_count"
      expr: COUNT(1)
      comment: "Total number of deals in pipeline"
    - name: "closed_deal_count"
      expr: COUNT(DISTINCT CASE WHEN actual_close_date IS NOT NULL THEN brokerage_deal_id END)
      comment: "Number of deals that have closed"
    - name: "dead_deal_count"
      expr: COUNT(DISTINCT CASE WHEN dead_date IS NOT NULL THEN brokerage_deal_id END)
      comment: "Number of deals marked as dead/lost"
    - name: "exclusive_deal_count"
      expr: SUM(CASE WHEN is_exclusive = TRUE THEN 1 ELSE 0 END)
      comment: "Number of deals under exclusive representation"
    - name: "co_brokerage_deal_count"
      expr: SUM(CASE WHEN is_co_brokerage = TRUE THEN 1 ELSE 0 END)
      comment: "Number of deals involving co-brokerage arrangements"
    - name: "loi_count"
      expr: COUNT(DISTINCT CASE WHEN loi_date IS NOT NULL THEN brokerage_deal_id END)
      comment: "Number of deals with signed letters of intent"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`brokerage_listing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Listing inventory and performance metrics tracking active listings, days on market, pricing trends, and syndication effectiveness across property types and markets."
  source: "`real_estate_ecm`.`brokerage`.`listing`"
  dimensions:
    - name: "listing_status"
      expr: listing_status
      comment: "Current status of the listing (e.g., active, pending, closed, expired, withdrawn)"
    - name: "listing_type"
      expr: listing_type
      comment: "Type of listing (e.g., exclusive, open, pocket)"
    - name: "deal_stage"
      expr: deal_stage
      comment: "Current deal stage for listings with active prospects"
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Flag indicating whether listing is under exclusive agreement"
    - name: "is_mls_syndicated"
      expr: is_mls_syndicated
      comment: "Flag indicating whether listing is syndicated to MLS"
    - name: "is_costar_syndicated"
      expr: is_costar_syndicated
      comment: "Flag indicating whether listing is syndicated to CoStar"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the listing became active"
    - name: "start_quarter"
      expr: CONCAT('Q', QUARTER(start_date), '-', YEAR(start_date))
      comment: "Quarter and year the listing became active"
    - name: "close_year"
      expr: YEAR(close_date)
      comment: "Year the listing closed"
    - name: "close_month"
      expr: DATE_TRUNC('MONTH', close_date)
      comment: "Month the listing closed"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the listing agreement expires"
  measures:
    - name: "total_listing_price"
      expr: SUM(CAST(price AS DOUBLE))
      comment: "Total asking price across all listings"
    - name: "total_close_price"
      expr: SUM(CAST(close_price AS DOUBLE))
      comment: "Total closed price for sold/leased listings"
    - name: "total_gla_sqft"
      expr: SUM(CAST(gla_sqft AS DOUBLE))
      comment: "Total gross leasable area in square feet across listings"
    - name: "total_nla_sqft"
      expr: SUM(CAST(nla_sqft AS DOUBLE))
      comment: "Total net leasable area in square feet across listings"
    - name: "total_ti_allowance"
      expr: SUM(CAST(tenant_improvement_allowance AS DOUBLE))
      comment: "Total tenant improvement allowance offered across listings"
    - name: "avg_listing_price"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average asking price per listing"
    - name: "avg_lease_rate_psf"
      expr: AVG(CAST(lease_rate_psf AS DOUBLE))
      comment: "Average lease rate per square foot"
    - name: "avg_cam_rate_psf"
      expr: AVG(CAST(cam_rate_psf AS DOUBLE))
      comment: "Average common area maintenance rate per square foot"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage offered"
    - name: "avg_co_broker_commission_pct"
      expr: AVG(CAST(co_broker_commission_pct AS DOUBLE))
      comment: "Average co-broker commission split percentage"
    - name: "avg_parking_ratio"
      expr: AVG(CAST(parking_ratio AS DOUBLE))
      comment: "Average parking ratio (spaces per 1,000 SF)"
    - name: "listing_count"
      expr: COUNT(1)
      comment: "Total number of listings"
    - name: "closed_listing_count"
      expr: COUNT(DISTINCT CASE WHEN close_date IS NOT NULL THEN listing_id END)
      comment: "Number of listings that have closed"
    - name: "exclusive_listing_count"
      expr: SUM(CASE WHEN is_exclusive = TRUE THEN 1 ELSE 0 END)
      comment: "Number of exclusive listings"
    - name: "mls_syndicated_count"
      expr: SUM(CASE WHEN is_mls_syndicated = TRUE THEN 1 ELSE 0 END)
      comment: "Number of listings syndicated to MLS"
    - name: "costar_syndicated_count"
      expr: SUM(CASE WHEN is_costar_syndicated = TRUE THEN 1 ELSE 0 END)
      comment: "Number of listings syndicated to CoStar"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`brokerage_broker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broker productivity and performance metrics tracking GCI, transaction volume, license compliance, and workforce composition across broker types and specializations."
  source: "`real_estate_ecm`.`brokerage`.`brokerage_broker`"
  dimensions:
    - name: "broker_type"
      expr: broker_type
      comment: "Type of broker (e.g., associate, senior, managing broker)"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment classification (e.g., W-2, 1099, independent contractor)"
    - name: "specialization"
      expr: specialization
      comment: "Broker specialization area (e.g., office, industrial, retail, multifamily)"
    - name: "production_tier"
      expr: production_tier
      comment: "Production tier classification based on GCI performance"
    - name: "license_status"
      expr: license_status
      comment: "Current license status (e.g., active, inactive, suspended, expired)"
    - name: "license_state"
      expr: license_state
      comment: "Primary state where broker is licensed"
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether broker is currently active"
    - name: "dual_agency_authorized"
      expr: dual_agency_authorized
      comment: "Flag indicating whether broker is authorized for dual agency representation"
    - name: "ccim_designation"
      expr: ccim_designation
      comment: "Flag indicating CCIM (Certified Commercial Investment Member) designation"
    - name: "sior_designation"
      expr: sior_designation
      comment: "Flag indicating SIOR (Society of Industrial and Office Realtors) designation"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year the broker was hired"
    - name: "license_expiration_year"
      expr: YEAR(license_expiration_date)
      comment: "Year the broker license expires"
    - name: "team_name"
      expr: team_name
      comment: "Name of the broker team"
    - name: "office_location"
      expr: office_location
      comment: "Office location where broker is based"
  measures:
    - name: "total_gci_ytd"
      expr: SUM(CAST(gci_ytd AS DOUBLE))
      comment: "Total gross commission income year-to-date across all brokers"
    - name: "total_gci_prior_year"
      expr: SUM(CAST(gci_prior_year AS DOUBLE))
      comment: "Total gross commission income for prior year across all brokers"
    - name: "avg_gci_ytd"
      expr: AVG(CAST(gci_ytd AS DOUBLE))
      comment: "Average gross commission income year-to-date per broker"
    - name: "avg_gci_prior_year"
      expr: AVG(CAST(gci_prior_year AS DOUBLE))
      comment: "Average gross commission income prior year per broker"
    - name: "avg_ce_hours_completed"
      expr: AVG(CAST(continuing_education_hours_completed AS DOUBLE))
      comment: "Average continuing education hours completed per broker"
    - name: "broker_count"
      expr: COUNT(1)
      comment: "Total number of brokers"
    - name: "active_broker_count"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Number of active brokers"
    - name: "dual_agency_authorized_count"
      expr: SUM(CASE WHEN dual_agency_authorized = TRUE THEN 1 ELSE 0 END)
      comment: "Number of brokers authorized for dual agency"
    - name: "ccim_designated_count"
      expr: SUM(CASE WHEN ccim_designation = TRUE THEN 1 ELSE 0 END)
      comment: "Number of brokers with CCIM designation"
    - name: "sior_designated_count"
      expr: SUM(CASE WHEN sior_designation = TRUE THEN 1 ELSE 0 END)
      comment: "Number of brokers with SIOR designation"
    - name: "terminated_broker_count"
      expr: COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL THEN brokerage_broker_id END)
      comment: "Number of brokers who have been terminated"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`brokerage_commission_split`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission disbursement and split metrics tracking agent payouts, deductions, approval workflow, and payment timing across recipient types and disbursement methods."
  source: "`real_estate_ecm`.`brokerage`.`commission_split`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the commission split (e.g., pending, approved, rejected)"
    - name: "disbursement_status"
      expr: disbursement_status
      comment: "Current disbursement status (e.g., scheduled, paid, failed, reversed)"
    - name: "recipient_type"
      expr: recipient_type
      comment: "Type of commission recipient (e.g., agent, co-broker, referral partner, team)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment disbursement (e.g., direct deposit, check, wire transfer)"
    - name: "brokerage_side"
      expr: brokerage_side
      comment: "Side of the transaction (buyer-side or seller-side)"
    - name: "is_1099_reportable"
      expr: is_1099_reportable
      comment: "Flag indicating whether split is reportable on 1099 tax form"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the split was approved"
    - name: "disbursement_year"
      expr: YEAR(actual_disbursement_date)
      comment: "Year the split was actually disbursed"
    - name: "disbursement_month"
      expr: DATE_TRUNC('MONTH', actual_disbursement_date)
      comment: "Month the split was actually disbursed"
    - name: "transaction_close_year"
      expr: YEAR(transaction_close_date)
      comment: "Year the underlying transaction closed"
    - name: "has_reversal"
      expr: CASE WHEN reversal_date IS NOT NULL THEN TRUE ELSE FALSE END
      comment: "Flag indicating whether the split has been reversed"
  measures:
    - name: "total_gross_commission"
      expr: SUM(CAST(gross_commission_amount AS DOUBLE))
      comment: "Total gross commission amount before splits and deductions"
    - name: "total_split_amount"
      expr: SUM(CAST(split_amount AS DOUBLE))
      comment: "Total commission split amount allocated to recipients"
    - name: "total_net_disbursement"
      expr: SUM(CAST(net_disbursement_amount AS DOUBLE))
      comment: "Total net amount disbursed after all deductions"
    - name: "total_desk_fee_deduction"
      expr: SUM(CAST(desk_fee_deduction AS DOUBLE))
      comment: "Total desk fee deductions across all splits"
    - name: "total_eo_deduction"
      expr: SUM(CAST(errors_omissions_deduction AS DOUBLE))
      comment: "Total errors and omissions insurance deductions"
    - name: "total_withholding"
      expr: SUM(CAST(withholding_amount AS DOUBLE))
      comment: "Total tax withholding amount deducted"
    - name: "total_override_adjustment"
      expr: SUM(CAST(override_adjustment_amount AS DOUBLE))
      comment: "Total override adjustment amounts (positive or negative)"
    - name: "avg_split_pct"
      expr: AVG(CAST(split_pct AS DOUBLE))
      comment: "Average commission split percentage"
    - name: "split_count"
      expr: COUNT(1)
      comment: "Total number of commission splits"
    - name: "approved_split_count"
      expr: COUNT(DISTINCT CASE WHEN approval_date IS NOT NULL THEN commission_split_id END)
      comment: "Number of splits that have been approved"
    - name: "disbursed_split_count"
      expr: COUNT(DISTINCT CASE WHEN actual_disbursement_date IS NOT NULL THEN commission_split_id END)
      comment: "Number of splits that have been disbursed"
    - name: "reportable_1099_count"
      expr: SUM(CASE WHEN is_1099_reportable = TRUE THEN 1 ELSE 0 END)
      comment: "Number of splits reportable on 1099 tax forms"
    - name: "reversed_split_count"
      expr: COUNT(DISTINCT CASE WHEN reversal_date IS NOT NULL THEN commission_split_id END)
      comment: "Number of splits that have been reversed"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`brokerage_showing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Showing activity and conversion metrics tracking prospect engagement, feedback quality, follow-up effectiveness, and showing-to-deal conversion across property types and showing formats."
  source: "`real_estate_ecm`.`brokerage`.`showing`"
  dimensions:
    - name: "showing_status"
      expr: showing_status
      comment: "Current status of the showing (e.g., scheduled, completed, cancelled, no-show)"
    - name: "showing_type"
      expr: showing_type
      comment: "Type of showing (e.g., in-person, virtual, open house, private tour)"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the showing (e.g., interested, not interested, offer submitted, needs follow-up)"
    - name: "prospect_interest_level"
      expr: prospect_interest_level
      comment: "Prospect interest level after showing (e.g., high, medium, low, none)"
    - name: "deal_stage"
      expr: deal_stage
      comment: "Current deal stage if showing led to active deal"
    - name: "prospect_side"
      expr: prospect_side
      comment: "Side the prospect represents (buyer/tenant or seller/landlord)"
    - name: "access_method"
      expr: access_method
      comment: "Method used to access property (e.g., lockbox, on-site staff, owner present)"
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Flag indicating whether follow-up action is required"
    - name: "nda_executed"
      expr: nda_executed
      comment: "Flag indicating whether NDA was executed before showing"
    - name: "is_confidential_listing"
      expr: is_confidential_listing
      comment: "Flag indicating whether listing is confidential/pocket listing"
    - name: "scheduled_year"
      expr: YEAR(CAST(scheduled_start AS DATE))
      comment: "Year the showing was scheduled"
    - name: "scheduled_quarter"
      expr: CONCAT('Q', QUARTER(CAST(scheduled_start AS DATE)), '-', YEAR(CAST(scheduled_start AS DATE)))
      comment: "Quarter and year the showing was scheduled"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', CAST(scheduled_start AS DATE))
      comment: "Month the showing was scheduled"
    - name: "virtual_platform"
      expr: virtual_platform
      comment: "Platform used for virtual showings (e.g., Zoom, Teams, Matterport)"
  measures:
    - name: "total_budget_psf"
      expr: SUM(CAST(budget_psf AS DOUBLE))
      comment: "Total prospect budget per square foot across all showings"
    - name: "avg_budget_psf"
      expr: AVG(CAST(budget_psf AS DOUBLE))
      comment: "Average prospect budget per square foot"
    - name: "showing_count"
      expr: COUNT(1)
      comment: "Total number of showings"
    - name: "completed_showing_count"
      expr: COUNT(DISTINCT CASE WHEN actual_start IS NOT NULL THEN showing_id END)
      comment: "Number of showings that were completed"
    - name: "cancelled_showing_count"
      expr: COUNT(DISTINCT CASE WHEN cancellation_reason IS NOT NULL THEN showing_id END)
      comment: "Number of showings that were cancelled"
    - name: "follow_up_required_count"
      expr: SUM(CASE WHEN follow_up_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of showings requiring follow-up action"
    - name: "nda_executed_count"
      expr: SUM(CASE WHEN nda_executed = TRUE THEN 1 ELSE 0 END)
      comment: "Number of showings where NDA was executed"
    - name: "confidential_listing_count"
      expr: SUM(CASE WHEN is_confidential_listing = TRUE THEN 1 ELSE 0 END)
      comment: "Number of showings for confidential/pocket listings"
    - name: "unique_prospect_count"
      expr: COUNT(DISTINCT brokerage_prospect_id)
      comment: "Number of unique prospects who attended showings"
    - name: "unique_listing_count"
      expr: COUNT(DISTINCT listing_id)
      comment: "Number of unique listings shown"
    - name: "unique_property_count"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique properties shown"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`brokerage_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral network and fee metrics tracking inbound and outbound referrals, referral conversion rates, fee structures, and network partner performance."
  source: "`real_estate_ecm`.`brokerage`.`referral`"
  dimensions:
    - name: "referral_status"
      expr: referral_status
      comment: "Current status of the referral (e.g., pending, accepted, converted, expired, declined)"
    - name: "referral_type"
      expr: referral_type
      comment: "Type of referral (e.g., broker-to-broker, client, network, strategic partner)"
    - name: "direction"
      expr: direction
      comment: "Direction of referral (inbound or outbound)"
    - name: "payment_direction"
      expr: payment_direction
      comment: "Direction of fee payment (paid or received)"
    - name: "deal_outcome"
      expr: deal_outcome
      comment: "Outcome of the referred deal (e.g., closed, lost, pending)"
    - name: "fee_structure"
      expr: fee_structure
      comment: "Structure of referral fee (e.g., percentage, flat fee, tiered)"
    - name: "source_network"
      expr: source_network
      comment: "Referral network source (e.g., Leading Real Estate Companies, CCIM, SIOR)"
    - name: "is_reciprocal"
      expr: is_reciprocal
      comment: "Flag indicating whether referral is part of reciprocal arrangement"
    - name: "referring_firm_name"
      expr: referring_firm_name
      comment: "Name of the referring brokerage firm"
    - name: "agreement_year"
      expr: YEAR(agreement_date)
      comment: "Year the referral agreement was signed"
    - name: "close_year"
      expr: YEAR(deal_close_date)
      comment: "Year the referred deal closed"
    - name: "close_quarter"
      expr: CONCAT('Q', QUARTER(deal_close_date), '-', YEAR(deal_close_date))
      comment: "Quarter and year the referred deal closed"
    - name: "fee_paid_year"
      expr: YEAR(fee_paid_date)
      comment: "Year the referral fee was paid"
  measures:
    - name: "total_estimated_deal_value"
      expr: SUM(CAST(estimated_deal_value AS DOUBLE))
      comment: "Total estimated value of referred deals"
    - name: "total_actual_deal_value"
      expr: SUM(CAST(actual_deal_value AS DOUBLE))
      comment: "Total actual closed value of referred deals"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total referral fee amount (paid or received)"
    - name: "total_flat_fee"
      expr: SUM(CAST(fee_flat_amount AS DOUBLE))
      comment: "Total flat referral fees"
    - name: "total_gross_commission_income"
      expr: SUM(CAST(gross_commission_income AS DOUBLE))
      comment: "Total gross commission income generated from referred deals"
    - name: "avg_fee_pct"
      expr: AVG(CAST(fee_pct AS DOUBLE))
      comment: "Average referral fee percentage"
    - name: "referral_count"
      expr: COUNT(1)
      comment: "Total number of referrals"
    - name: "closed_referral_count"
      expr: COUNT(DISTINCT CASE WHEN deal_close_date IS NOT NULL THEN referral_id END)
      comment: "Number of referrals that resulted in closed deals"
    - name: "paid_referral_count"
      expr: COUNT(DISTINCT CASE WHEN fee_paid_date IS NOT NULL THEN referral_id END)
      comment: "Number of referrals where fee has been paid"
    - name: "reciprocal_referral_count"
      expr: SUM(CASE WHEN is_reciprocal = TRUE THEN 1 ELSE 0 END)
      comment: "Number of referrals under reciprocal arrangements"
    - name: "unique_referring_firm_count"
      expr: COUNT(DISTINCT referring_firm_name)
      comment: "Number of unique referring firms"
    - name: "unique_prospect_count"
      expr: COUNT(DISTINCT brokerage_prospect_id)
      comment: "Number of unique prospects from referrals"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`brokerage_broker_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "License compliance and continuing education metrics tracking license status, renewal cycles, CE completion, disciplinary actions, and E&O insurance coverage across jurisdictions."
  source: "`real_estate_ecm`.`brokerage`.`broker_license`"
  dimensions:
    - name: "license_status"
      expr: license_status
      comment: "Current status of the license (e.g., active, inactive, expired, suspended, revoked)"
    - name: "license_type"
      expr: license_type
      comment: "Type of license (e.g., salesperson, broker, managing broker)"
    - name: "license_class"
      expr: license_class
      comment: "Class of license (e.g., residential, commercial, dual)"
    - name: "issuing_state"
      expr: issuing_state
      comment: "State that issued the license"
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the license"
    - name: "renewal_status"
      expr: renewal_status
      comment: "Current renewal status (e.g., current, pending, overdue)"
    - name: "ce_compliance_status"
      expr: ce_compliance_status
      comment: "Continuing education compliance status (e.g., compliant, deficient, exempt)"
    - name: "disciplinary_flag"
      expr: disciplinary_flag
      comment: "Flag indicating whether license has disciplinary action"
    - name: "disciplinary_action_type"
      expr: disciplinary_action_type
      comment: "Type of disciplinary action (e.g., fine, suspension, probation)"
    - name: "errors_omissions_insured"
      expr: errors_omissions_insured
      comment: "Flag indicating whether broker has active E&O insurance"
    - name: "reciprocal_license"
      expr: reciprocal_license
      comment: "Flag indicating whether license is reciprocal from another state"
    - name: "primary_practice_state"
      expr: primary_practice_state
      comment: "Flag indicating whether this is the broker primary practice state"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the license was issued"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the license expires"
    - name: "renewal_year"
      expr: YEAR(renewal_date)
      comment: "Year the license is due for renewal"
  measures:
    - name: "license_count"
      expr: COUNT(1)
      comment: "Total number of broker licenses"
    - name: "active_license_count"
      expr: COUNT(DISTINCT CASE WHEN license_status = 'active' THEN broker_license_id END)
      comment: "Number of active licenses"
    - name: "expired_license_count"
      expr: COUNT(DISTINCT CASE WHEN license_status = 'expired' THEN broker_license_id END)
      comment: "Number of expired licenses"
    - name: "disciplinary_action_count"
      expr: SUM(CASE WHEN disciplinary_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of licenses with disciplinary actions"
    - name: "eo_insured_count"
      expr: SUM(CASE WHEN errors_omissions_insured = TRUE THEN 1 ELSE 0 END)
      comment: "Number of licenses with active E&O insurance"
    - name: "reciprocal_license_count"
      expr: SUM(CASE WHEN reciprocal_license = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reciprocal licenses from other states"
    - name: "primary_state_license_count"
      expr: SUM(CASE WHEN primary_practice_state = TRUE THEN 1 ELSE 0 END)
      comment: "Number of licenses in broker primary practice state"
    - name: "ce_compliant_count"
      expr: COUNT(DISTINCT CASE WHEN ce_compliance_status = 'compliant' THEN broker_license_id END)
      comment: "Number of licenses in CE compliance"
    - name: "ce_deficient_count"
      expr: COUNT(DISTINCT CASE WHEN ce_compliance_status = 'deficient' THEN broker_license_id END)
      comment: "Number of licenses deficient in CE requirements"
    - name: "unique_broker_count"
      expr: COUNT(DISTINCT brokerage_broker_id)
      comment: "Number of unique brokers with licenses"
    - name: "unique_jurisdiction_count"
      expr: COUNT(DISTINCT jurisdiction_id)
      comment: "Number of unique jurisdictions where licenses are held"
$$;