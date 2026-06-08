-- Metric views for domain: tenement | Business: Mining | Version: 1 | Generated on: 2026-05-05 14:14:10

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core tenement portfolio metrics covering area under tenure, expenditure commitments, royalty rates, and lifecycle status distribution. Used by portfolio managers and executives to assess the health, scale, and strategic value of the tenement portfolio."
  source: "`mining_ecm`.`tenement`.`tenement`"
  dimensions:
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction in which the tenement is held — used to slice portfolio metrics by operating region."
    - name: "licence_type"
      expr: licence_type
      comment: "Type of mining licence (e.g. exploration licence, mining lease) — key dimension for portfolio composition analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the tenement (e.g. active, pending, surrendered) — critical for pipeline and attrition analysis."
    - name: "strategic_priority"
      expr: strategic_priority
      comment: "Strategic priority classification assigned to the tenement — used to focus investment and renewal decisions."
    - name: "granted_commodities"
      expr: granted_commodities
      comment: "Commodities authorised under the tenement (e.g. iron ore, copper, lithium) — enables commodity-level portfolio analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country in which the tenement is located — supports geographic portfolio segmentation."
    - name: "joint_venture_flag"
      expr: joint_venture_flag
      comment: "Indicates whether the tenement is held under a joint venture arrangement — used to distinguish wholly-owned vs. JV assets."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year in which the tenement expires — used to identify renewal cliffs and prioritise renewal workload."
    - name: "grant_year"
      expr: YEAR(grant_date)
      comment: "Year the tenement was granted — supports vintage analysis of the portfolio."
    - name: "royalty_type"
      expr: royalty_type
      comment: "Type of royalty obligation attached to the tenement (e.g. ad valorem, specific) — used in royalty cost analysis."
    - name: "native_title_status"
      expr: native_title_status
      comment: "Current native title clearance status — used to track regulatory risk and compliance posture."
    - name: "heritage_clearance_status"
      expr: heritage_clearance_status
      comment: "Current heritage clearance status — used to identify tenements at risk of operational delay."
  measures:
    - name: "total_tenements"
      expr: COUNT(1)
      comment: "Total number of tenements in the portfolio. Baseline KPI for portfolio scale used in executive dashboards."
    - name: "total_area_hectares"
      expr: SUM(CAST(area_hectares AS DOUBLE))
      comment: "Total land area under tenure in hectares. Measures the physical footprint of the tenement portfolio — a primary indicator of exploration and mining scale."
    - name: "avg_area_hectares"
      expr: AVG(CAST(area_hectares AS DOUBLE))
      comment: "Average area per tenement in hectares. Used to benchmark tenement size and identify outliers in the portfolio."
    - name: "total_annual_expenditure_commitment"
      expr: SUM(CAST(annual_expenditure_commitment AS DOUBLE))
      comment: "Total annual minimum expenditure commitment across all tenements. Directly informs capital planning and cash flow forecasting for the tenement portfolio."
    - name: "avg_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate (%) across tenements. Used by finance and commercial teams to assess the blended royalty cost burden of the portfolio."
    - name: "avg_holder_percentage"
      expr: AVG(CAST(holder_percentage AS DOUBLE))
      comment: "Average ownership percentage held across tenements. Indicates the degree of ownership concentration vs. joint venture dilution in the portfolio."
    - name: "tenements_expiring_within_1_year"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 365) THEN 1 END)
      comment: "Number of tenements expiring within the next 12 months. A critical renewal risk KPI — drives prioritisation of renewal lodgement workload."
    - name: "joint_venture_tenement_count"
      expr: COUNT(CASE WHEN joint_venture_flag = TRUE THEN 1 END)
      comment: "Number of tenements held under joint venture arrangements. Used to assess JV exposure and governance obligations in the portfolio."
    - name: "active_tenement_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'active' THEN 1 END)
      comment: "Number of tenements with an active lifecycle status. Core operational KPI for portfolio health monitoring."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_expenditure_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Expenditure commitment compliance and financial performance metrics for tenement obligations. Used by finance, compliance, and portfolio teams to monitor whether minimum spend obligations are being met and to identify forfeiture risk."
  source: "`mining_ecm`.`tenement`.`expenditure_commitment`"
  dimensions:
    - name: "expenditure_category"
      expr: expenditure_category
      comment: "Category of expenditure (e.g. drilling, geophysics, administration) — used to analyse spend composition against commitments."
    - name: "commitment_type"
      expr: commitment_type
      comment: "Type of expenditure commitment (e.g. minimum spend, carry-forward) — used to distinguish obligation types."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the expenditure commitment — key dimension for regulatory risk reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the commitment is denominated — used for multi-currency portfolio analysis."
    - name: "forfeiture_risk_flag"
      expr: forfeiture_risk_flag
      comment: "Indicates whether the tenement is at risk of forfeiture due to expenditure non-compliance — critical risk flag."
    - name: "exemption_granted_flag"
      expr: exemption_granted_flag
      comment: "Indicates whether a regulatory exemption has been granted for the commitment — used to adjust compliance reporting."
    - name: "reporting_period_end_year"
      expr: YEAR(reporting_period_end_date)
      comment: "Year of the reporting period end date — used to trend expenditure compliance over time."
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for meeting the expenditure commitment — used to allocate accountability in compliance reporting."
  measures:
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed expenditure amount across all obligations. Baseline financial KPI for tenement expenditure planning."
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditure incurred against commitments. Used to assess whether minimum spend obligations are being fulfilled."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between committed and actual expenditure. Negative variance signals under-spend risk and potential regulatory non-compliance."
    - name: "total_carry_forward_amount"
      expr: SUM(CAST(carry_forward_amount AS DOUBLE))
      comment: "Total expenditure carried forward to future periods. High carry-forward balances indicate deferred compliance risk."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalties incurred for expenditure non-compliance. A direct financial cost of compliance failure — monitored by finance and legal."
    - name: "expenditure_achievement_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_expenditure_amount AS DOUBLE)) / NULLIF(SUM(CAST(committed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of committed expenditure actually incurred (actual / committed × 100). Core compliance KPI — values below 100% indicate under-spend risk and potential tenement forfeiture."
    - name: "forfeiture_risk_commitment_count"
      expr: COUNT(CASE WHEN forfeiture_risk_flag = TRUE THEN 1 END)
      comment: "Number of expenditure commitments flagged as forfeiture risk. Directly drives regulatory intervention and remediation prioritisation."
    - name: "avg_committed_amount"
      expr: AVG(CAST(committed_amount AS DOUBLE))
      comment: "Average committed expenditure per obligation. Used to benchmark commitment levels across tenements and categories."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_royalty_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty payment financial metrics covering amounts calculated, paid, and adjusted. Used by finance, commercial, and regulatory teams to monitor royalty obligations, payment timeliness, and reconciliation status."
  source: "`mining_ecm`.`tenement`.`royalty_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the royalty payment (e.g. paid, overdue, pending) — primary dimension for payment health monitoring."
    - name: "royalty_basis"
      expr: royalty_basis
      comment: "Basis on which the royalty is calculated (e.g. revenue, profit, tonnage) — used to analyse royalty cost drivers."
    - name: "payee_type"
      expr: payee_type
      comment: "Type of royalty payee (e.g. government, private landowner, native title group) — used to segment royalty obligations by counterparty type."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the royalty payment — used for multi-currency royalty cost analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the payment — used to identify unreconciled payments requiring finance action."
    - name: "production_period_end_year"
      expr: YEAR(production_period_end_date)
      comment: "Year of the production period to which the royalty relates — used to trend royalty costs over time."
    - name: "payment_due_month"
      expr: DATE_TRUNC('MONTH', payment_due_date)
      comment: "Month in which the royalty payment is due — used for cash flow planning and overdue payment monitoring."
  measures:
    - name: "total_calculated_royalty_amount"
      expr: SUM(CAST(calculated_royalty_amount AS DOUBLE))
      comment: "Total royalty amount calculated across all payment records. Primary financial KPI for royalty cost burden on the business."
    - name: "total_net_royalty_amount"
      expr: SUM(CAST(net_royalty_amount AS DOUBLE))
      comment: "Total net royalty amount after adjustments. Represents the actual cash outflow for royalty obligations — used in P&L and cash flow reporting."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to royalty payments. Large or frequent adjustments indicate calculation errors or disputes requiring investigation."
    - name: "total_production_value"
      expr: SUM(CAST(production_value_amount AS DOUBLE))
      comment: "Total production value on which royalties are calculated. Used to assess the royalty cost as a proportion of production value."
    - name: "total_production_tonnage"
      expr: SUM(CAST(production_tonnage AS DOUBLE))
      comment: "Total production tonnage subject to royalty. Used to calculate effective royalty cost per tonne and benchmark against industry norms."
    - name: "avg_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average effective royalty rate (%) across all payments. Used by commercial teams to monitor blended royalty cost and negotiate future agreements."
    - name: "royalty_cost_per_tonne"
      expr: ROUND(SUM(CAST(net_royalty_amount AS DOUBLE)) / NULLIF(SUM(CAST(production_tonnage AS DOUBLE)), 0), 4)
      comment: "Net royalty cost per tonne of production. A key unit economics KPI used to benchmark royalty efficiency and inform mine planning decisions."
    - name: "overdue_payment_count"
      expr: COUNT(CASE WHEN payment_status = 'overdue' AND actual_payment_date IS NULL THEN 1 END)
      comment: "Number of royalty payments that are overdue and unpaid. Drives regulatory compliance action and counterparty relationship management."
    - name: "unreconciled_payment_count"
      expr: COUNT(CASE WHEN reconciliation_status != 'reconciled' THEN 1 END)
      comment: "Number of royalty payments not yet reconciled. Unreconciled payments represent financial reporting risk and require finance team action."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tenement application pipeline metrics covering lodgement volumes, approval rates, processing timelines, and fee commitments. Used by portfolio managers and regulatory affairs teams to manage the application pipeline and optimise grant success rates."
  source: "`mining_ecm`.`tenement`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the tenement application (e.g. lodged, under assessment, granted, refused) — primary pipeline dimension."
    - name: "application_type"
      expr: application_type
      comment: "Type of tenement application (e.g. new grant, renewal, transfer) — used to segment pipeline by application category."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction of the application — used to analyse pipeline performance by jurisdiction."
    - name: "mineral_sought"
      expr: mineral_sought
      comment: "Mineral targeted by the application — used to align pipeline analysis with commodity strategy."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority processing the application — used to benchmark processing times by authority."
    - name: "environmental_assessment_required_flag"
      expr: environmental_assessment_required_flag
      comment: "Indicates whether an environmental assessment is required — used to identify applications with extended processing timelines."
    - name: "objection_received_flag"
      expr: objection_received_flag
      comment: "Indicates whether an objection has been lodged against the application — used to flag at-risk applications."
    - name: "lodgement_year"
      expr: YEAR(lodgement_date)
      comment: "Year the application was lodged — used to trend application volumes and approval rates over time."
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of the application (e.g. granted, refused, withdrawn) — used to calculate grant success rates."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of tenement applications lodged. Baseline pipeline volume KPI used in regulatory affairs reporting."
    - name: "total_application_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees paid or committed for tenement applications. Used in cost management and budget forecasting for the regulatory affairs function."
    - name: "total_expenditure_commitment_amount"
      expr: SUM(CAST(expenditure_commitment_amount AS DOUBLE))
      comment: "Total expenditure commitments associated with applications. Used to assess the forward financial obligation pipeline from new applications."
    - name: "total_area_applied_hectares"
      expr: SUM(CAST(area_hectares AS DOUBLE))
      comment: "Total area applied for across all applications in hectares. Measures the scale of the exploration and mining footprint being sought."
    - name: "grant_success_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN outcome = 'granted' THEN 1 END) / NULLIF(COUNT(CASE WHEN outcome IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of decided applications that were granted. A strategic KPI for regulatory affairs — low rates signal jurisdictional risk or application quality issues."
    - name: "objection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN objection_received_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications that received an objection. High objection rates indicate community or competitor opposition risk in specific jurisdictions."
    - name: "avg_processing_days"
      expr: AVG(CAST(DATEDIFF(decision_date, lodgement_date) AS DOUBLE))
      comment: "Average number of days from application lodgement to decision. A key efficiency KPI for regulatory processing — long lead times delay project timelines and capital deployment."
    - name: "environmental_assessment_required_count"
      expr: COUNT(CASE WHEN environmental_assessment_required_flag = TRUE THEN 1 END)
      comment: "Number of applications requiring environmental assessment. Drives resource planning for the environmental compliance function."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_regulatory_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory condition compliance metrics covering breach rates, enforcement actions, penalty exposure, and remediation status. Used by compliance, legal, and executive teams to manage regulatory risk across the tenement portfolio."
  source: "`mining_ecm`.`tenement`.`regulatory_condition`"
  dimensions:
    - name: "condition_type"
      expr: condition_type
      comment: "Type of regulatory condition (e.g. environmental, expenditure, reporting) — used to segment compliance risk by obligation category."
    - name: "condition_status"
      expr: condition_status
      comment: "Current status of the regulatory condition (e.g. compliant, breached, under review) — primary compliance health dimension."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the condition (e.g. high, medium, low) — used to prioritise compliance remediation effort."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the condition — used to focus management attention on the most critical obligations."
    - name: "granting_authority"
      expr: granting_authority
      comment: "Authority that granted the condition — used to segment compliance reporting by regulator."
    - name: "breach_flag"
      expr: breach_flag
      comment: "Indicates whether the condition has been breached — primary flag for compliance failure identification."
    - name: "remediation_required_flag"
      expr: remediation_required_flag
      comment: "Indicates whether remediation is required for the condition — used to track remediation workload."
    - name: "enforcement_action_type"
      expr: enforcement_action_type
      comment: "Type of enforcement action taken (e.g. warning, fine, suspension) — used to assess regulatory relationship health."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency at which compliance must be reported (e.g. monthly, quarterly, annually) — used to plan compliance reporting workload."
  measures:
    - name: "total_conditions"
      expr: COUNT(1)
      comment: "Total number of regulatory conditions across the tenement portfolio. Baseline compliance obligation volume KPI."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalties incurred for regulatory condition breaches. Direct financial cost of non-compliance — monitored by finance and legal leadership."
    - name: "breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of regulatory conditions currently in breach. A critical compliance KPI — high breach rates signal systemic non-compliance risk and potential licence suspension."
    - name: "breached_condition_count"
      expr: COUNT(CASE WHEN breach_flag = TRUE THEN 1 END)
      comment: "Absolute number of conditions in breach. Used alongside breach rate to assess the scale of compliance failure."
    - name: "remediation_required_count"
      expr: COUNT(CASE WHEN remediation_required_flag = TRUE THEN 1 END)
      comment: "Number of conditions requiring remediation. Drives remediation project planning and resource allocation."
    - name: "high_risk_condition_count"
      expr: COUNT(CASE WHEN risk_rating = 'high' THEN 1 END)
      comment: "Number of conditions rated as high risk. Used by executives and compliance leads to focus attention on the most consequential obligations."
    - name: "avg_days_to_compliance_review"
      expr: AVG(CAST(DATEDIFF(last_compliance_review_date, effective_date) AS DOUBLE))
      comment: "Average number of days from condition effective date to last compliance review. Measures the timeliness of compliance monitoring — long gaps indicate oversight risk."
    - name: "overdue_condition_count"
      expr: COUNT(CASE WHEN compliance_due_date < CURRENT_DATE AND condition_status != 'compliant' THEN 1 END)
      comment: "Number of conditions past their compliance due date and not yet compliant. A leading indicator of enforcement action risk — requires immediate management attention."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_renewal_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tenement renewal obligation metrics covering renewal pipeline, fee commitments, lodgement timeliness, and relinquishment requirements. Used by portfolio managers and regulatory affairs teams to ensure no tenements are lost through missed renewal deadlines."
  source: "`mining_ecm`.`tenement`.`renewal_obligation`"
  dimensions:
    - name: "renewal_status"
      expr: renewal_status
      comment: "Current status of the renewal obligation (e.g. pending, lodged, approved, lapsed) — primary pipeline health dimension."
    - name: "renewal_type"
      expr: renewal_type
      comment: "Type of renewal (e.g. standard, conditional, partial) — used to segment renewal workload by complexity."
    - name: "renewal_outcome"
      expr: renewal_outcome
      comment: "Outcome of the renewal process (e.g. granted, refused, withdrawn) — used to calculate renewal success rates."
    - name: "renewal_priority"
      expr: renewal_priority
      comment: "Priority assigned to the renewal — used to focus resources on the most strategically important renewals."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Jurisdiction governing the renewal — used to analyse renewal performance and workload by regulatory region."
    - name: "environmental_compliance_status"
      expr: environmental_compliance_status
      comment: "Environmental compliance status at time of renewal — used to identify renewals at risk due to environmental non-compliance."
    - name: "area_relinquishment_required_flag"
      expr: area_relinquishment_required_flag
      comment: "Indicates whether area relinquishment is required as a condition of renewal — used to forecast portfolio area changes."
    - name: "renewal_due_year"
      expr: YEAR(renewal_due_date)
      comment: "Year in which the renewal is due — used to identify renewal cliffs and plan lodgement workload."
  measures:
    - name: "total_renewal_obligations"
      expr: COUNT(1)
      comment: "Total number of renewal obligations in the portfolio. Baseline workload KPI for the regulatory affairs function."
    - name: "total_renewal_fee_amount"
      expr: SUM(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Total renewal fees payable across all obligations. Used in budget planning for the tenement management function."
    - name: "total_expenditure_commitment_amount"
      expr: SUM(CAST(expenditure_commitment_amount AS DOUBLE))
      comment: "Total expenditure commitments associated with renewal obligations. Used to assess the forward financial obligation from the renewal pipeline."
    - name: "total_relinquishment_area_hectares"
      expr: SUM(CAST(relinquishment_area_hectares AS DOUBLE))
      comment: "Total area to be relinquished as part of renewal conditions. Measures the portfolio area reduction from renewal obligations — informs strategic land position planning."
    - name: "renewal_success_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN renewal_outcome = 'granted' THEN 1 END) / NULLIF(COUNT(CASE WHEN renewal_outcome IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of decided renewals that were granted. A strategic KPI for portfolio retention — low rates signal jurisdictional risk or compliance issues."
    - name: "overdue_lodgement_count"
      expr: COUNT(CASE WHEN lodgement_deadline_date < CURRENT_DATE AND lodgement_submitted_date IS NULL THEN 1 END)
      comment: "Number of renewal lodgements past their deadline and not yet submitted. A critical operational risk KPI — missed lodgements can result in automatic tenement lapse."
    - name: "avg_relinquishment_percentage"
      expr: AVG(CAST(relinquishment_percentage AS DOUBLE))
      comment: "Average area relinquishment percentage required at renewal. Used to forecast portfolio area reduction and assess the cost of retaining tenements."
    - name: "renewals_due_within_90_days"
      expr: COUNT(CASE WHEN renewal_due_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Number of renewals due within the next 90 days. A forward-looking workload KPI that drives immediate action in the regulatory affairs team."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_relinquishment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tenement relinquishment metrics covering area surrendered, financial impacts, and rehabilitation status. Used by portfolio managers and executives to track voluntary and statutory relinquishments and their effect on the portfolio footprint and financial position."
  source: "`mining_ecm`.`tenement`.`relinquishment`"
  dimensions:
    - name: "relinquishment_status"
      expr: relinquishment_status
      comment: "Current status of the relinquishment (e.g. pending, approved, completed) — primary pipeline dimension."
    - name: "relinquishment_type"
      expr: relinquishment_type
      comment: "Type of relinquishment (e.g. voluntary, statutory, partial) — used to distinguish strategic exits from regulatory obligations."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the relinquishment — used to analyse the drivers of portfolio area reduction."
    - name: "environmental_condition_status"
      expr: environmental_condition_status
      comment: "Environmental condition status at time of relinquishment — used to identify relinquishments with outstanding environmental obligations."
    - name: "statutory_obligation_flag"
      expr: statutory_obligation_flag
      comment: "Indicates whether the relinquishment is driven by a statutory obligation — used to distinguish mandatory from discretionary relinquishments."
    - name: "relinquishment_year"
      expr: YEAR(relinquishment_date)
      comment: "Year of relinquishment — used to trend portfolio area reduction over time."
    - name: "approving_authority"
      expr: approving_authority
      comment: "Authority that approved the relinquishment — used to segment relinquishment activity by regulator."
  measures:
    - name: "total_area_relinquished_hectares"
      expr: SUM(CAST(area_relinquished_hectares AS DOUBLE))
      comment: "Total area relinquished across all relinquishment events in hectares. Primary portfolio footprint reduction KPI — used in strategic land position reporting."
    - name: "total_remaining_area_hectares"
      expr: SUM(CAST(remaining_area_hectares AS DOUBLE))
      comment: "Total remaining area retained after relinquishment. Used to assess the net portfolio area position following relinquishment activity."
    - name: "total_financial_impact_amount"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of relinquishments. Captures the cost or value impact of surrendering tenement areas — used in portfolio optimisation decisions."
    - name: "avg_relinquishment_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average percentage of tenement area relinquished per event. Used to benchmark the scale of relinquishments and assess portfolio concentration risk."
    - name: "statutory_relinquishment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN statutory_obligation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of relinquishments driven by statutory obligations. High rates indicate the portfolio is being shaped by regulatory requirements rather than strategic choice."
    - name: "relinquishment_area_retention_ratio"
      expr: ROUND(SUM(CAST(remaining_area_hectares AS DOUBLE)) / NULLIF(SUM(CAST(area_relinquished_hectares AS DOUBLE)), 0), 4)
      comment: "Ratio of remaining area to relinquished area. A portfolio efficiency KPI — high ratios indicate the business is retaining most of its land position despite relinquishment activity."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_holder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tenement holder ownership and transaction metrics covering ownership percentages, royalty obligations, stamp duty, and transfer activity. Used by legal, commercial, and finance teams to manage ownership structures and associated financial obligations."
  source: "`mining_ecm`.`tenement`.`holder`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of ownership transaction (e.g. transfer, acquisition, dilution) — used to analyse ownership change activity."
    - name: "registration_status"
      expr: registration_status
      comment: "Registration status of the holder record — used to identify unregistered ownership changes requiring regulatory action."
    - name: "operator_flag"
      expr: operator_flag
      comment: "Indicates whether the holder is the designated operator — used to distinguish operator from non-operator interests."
    - name: "royalty_obligation_flag"
      expr: royalty_obligation_flag
      comment: "Indicates whether the holder has a royalty obligation — used to identify holders with financial royalty commitments."
    - name: "stamp_duty_paid_flag"
      expr: stamp_duty_paid_flag
      comment: "Indicates whether stamp duty has been paid on the transaction — used to identify outstanding stamp duty liabilities."
    - name: "contributing_interest_flag"
      expr: contributing_interest_flag
      comment: "Indicates whether the holder has a contributing interest — used to distinguish contributing from free-carried interests."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the holder record became effective — used to trend ownership change activity over time."
  measures:
    - name: "total_consideration_amount"
      expr: SUM(CAST(consideration_amount AS DOUBLE))
      comment: "Total consideration paid for tenement ownership transactions. Measures the financial value of tenement acquisitions and transfers — a key M&A and portfolio investment KPI."
    - name: "total_stamp_duty_amount"
      expr: SUM(CAST(stamp_duty_amount AS DOUBLE))
      comment: "Total stamp duty incurred on tenement transactions. A direct transaction cost monitored by finance and legal teams."
    - name: "avg_ownership_percentage"
      expr: AVG(CAST(ownership_percentage AS DOUBLE))
      comment: "Average ownership percentage held across all holder records. Used to assess the degree of ownership concentration vs. dilution in the portfolio."
    - name: "avg_royalty_rate_percentage"
      expr: AVG(CAST(royalty_rate_percentage AS DOUBLE))
      comment: "Average royalty rate (%) applicable to holders with royalty obligations. Used by commercial teams to monitor the blended royalty cost of the ownership structure."
    - name: "avg_free_carried_percentage"
      expr: AVG(CAST(free_carried_percentage AS DOUBLE))
      comment: "Average free-carried interest percentage across holder records. Used to assess the dilution risk from free-carried arrangements in joint ventures."
    - name: "stamp_duty_outstanding_count"
      expr: COUNT(CASE WHEN stamp_duty_paid_flag = FALSE AND stamp_duty_amount > 0 THEN 1 END)
      comment: "Number of holder transactions with outstanding stamp duty. Identifies financial liabilities requiring immediate payment to avoid penalties."
    - name: "unregistered_holder_count"
      expr: COUNT(CASE WHEN registration_status != 'registered' THEN 1 END)
      comment: "Number of holder records not yet registered with the relevant authority. Unregistered holders represent regulatory compliance risk and potential ownership disputes."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`tenement_native_title_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Native title agreement compliance and financial metrics covering compensation commitments, agreement status, and compliance audit currency. Used by legal, community relations, and executive teams to manage native title obligations and associated financial exposures."
  source: "`mining_ecm`.`tenement`.`native_title_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the native title agreement (e.g. active, expired, under negotiation) — primary compliance health dimension."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of native title agreement (e.g. ILUA, heritage agreement, access agreement) — used to segment obligations by agreement category."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the agreement — used to identify agreements with outstanding obligations."
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation provided under the agreement (e.g. cash, in-kind, employment) — used to analyse compensation structure."
    - name: "ilua_type"
      expr: ilua_type
      comment: "Type of Indigenous Land Use Agreement — used to segment ILUA-specific compliance and financial metrics."
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Indicates whether the agreement has a renewal option — used to plan future negotiation workload."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the agreement expires — used to identify upcoming renegotiation requirements."
  measures:
    - name: "total_compensation_amount"
      expr: SUM(CAST(total_compensation_amount AS DOUBLE))
      comment: "Total compensation committed under native title agreements. A significant financial obligation — monitored by finance and legal leadership for provisioning and cash flow purposes."
    - name: "avg_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate (%) committed under native title agreements. Used to assess the blended royalty cost of native title obligations across the portfolio."
    - name: "agreements_expiring_within_1_year"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 365) THEN 1 END)
      comment: "Number of native title agreements expiring within 12 months. Drives renegotiation planning — expired agreements without renewal create operational and legal risk."
    - name: "non_compliant_agreement_count"
      expr: COUNT(CASE WHEN compliance_status != 'compliant' THEN 1 END)
      comment: "Number of native title agreements not in compliance. Non-compliance with native title agreements carries significant legal, reputational, and operational risk."
    - name: "avg_days_since_compliance_audit"
      expr: AVG(CAST(DATEDIFF(CURRENT_DATE, last_compliance_audit_date) AS DOUBLE))
      comment: "Average number of days since the last compliance audit for each agreement. Long gaps indicate oversight risk — agreements should be audited at regular intervals."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'active' THEN 1 END)
      comment: "Number of currently active native title agreements. Baseline KPI for the scale of native title obligations being managed."
$$;