-- Metric views for domain: contract | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 22:39:52

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core contract portfolio metrics tracking active contract value, financial exposure, escalation economics, and lifecycle health across the waste management contract book."
  source: "`waste_management_ecm`.`contract`.`contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current lifecycle status of the contract (e.g. Active, Expired, Terminated, Pending) — primary segmentation for portfolio health analysis."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "How often the customer is billed (Monthly, Quarterly, Annual) — drives cash-flow forecasting and revenue recognition cadence."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the contract auto-renews — key dimension for retention risk and renewal pipeline sizing."
    - name: "performance_bond_required_flag"
      expr: performance_bond_required_flag
      comment: "Flags contracts requiring a performance bond — used to segment high-compliance-risk accounts."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the contract became effective — enables cohort and vintage analysis of the contract portfolio."
    - name: "expiration_year"
      expr: DATE_TRUNC('YEAR', expiration_date)
      comment: "Year the contract expires — critical for renewal pipeline and revenue-at-risk forecasting."
    - name: "governing_jurisdiction"
      expr: governing_jurisdiction
      comment: "Legal jurisdiction governing the contract — used for regulatory compliance segmentation and geographic risk analysis."
    - name: "source_system"
      expr: source_system
      comment: "Originating system of record (e.g. SAP, Salesforce) — supports data lineage and reconciliation reporting."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(value_total AS DOUBLE))
      comment: "Total contracted revenue value across all contracts in scope. Primary top-line KPI for the contract portfolio — directly informs revenue forecasting and executive pipeline reviews."
    - name: "avg_contract_value"
      expr: AVG(CAST(value_total AS DOUBLE))
      comment: "Average contract value per agreement. Tracks deal size trends over time and supports pricing strategy decisions."
    - name: "total_base_service_rate"
      expr: SUM(CAST(base_service_rate AS DOUBLE))
      comment: "Sum of base service rates across contracts. Represents the recurring revenue floor before escalations and surcharges — used in rate adequacy analysis."
    - name: "avg_annual_escalation_pct"
      expr: AVG(CAST(annual_escalation_percentage AS DOUBLE))
      comment: "Average annual rate escalation percentage across contracts. Directly informs revenue growth projections and pricing competitiveness assessments."
    - name: "total_early_termination_penalty_exposure"
      expr: SUM(CAST(early_termination_penalty AS DOUBLE))
      comment: "Total early termination penalty value across the portfolio. Quantifies financial protection against customer churn — key risk metric for CFO and legal teams."
    - name: "total_performance_bond_exposure"
      expr: SUM(CAST(performance_bond_amount AS DOUBLE))
      comment: "Total performance bond amounts committed across contracts. Measures compliance-related financial exposure and counterparty risk."
    - name: "total_minimum_tonnage_commitment"
      expr: SUM(CAST(minimum_tonnage_commitment AS DOUBLE))
      comment: "Aggregate minimum tonnage committed by customers across all contracts. Drives capacity planning for collection routes, transfer stations, and landfill operations."
    - name: "total_maximum_tonnage_limit"
      expr: SUM(CAST(maximum_tonnage_limit AS DOUBLE))
      comment: "Aggregate maximum tonnage limits across contracts. Used to assess capacity ceiling and identify contracts at risk of overage penalties."
    - name: "avg_late_payment_penalty_rate"
      expr: AVG(CAST(late_payment_penalty_rate AS DOUBLE))
      comment: "Average late payment penalty rate across contracts. Benchmarks penalty terms against industry norms and informs collections policy."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of contracts in scope. Baseline volume metric for portfolio sizing, trend analysis, and operational capacity planning."
    - name: "auto_renewal_contract_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of contracts eligible for automatic renewal. Measures the size of the self-renewing revenue base — a key retention and revenue stability indicator."
    - name: "performance_bond_contract_count"
      expr: COUNT(CASE WHEN performance_bond_required_flag = TRUE THEN 1 END)
      comment: "Number of contracts requiring a performance bond. Quantifies compliance-intensive contract volume for risk and legal resource planning."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`contract_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Amendment activity metrics tracking contract modification volume, financial impact, rate change economics, and approval cycle health across the contract lifecycle."
  source: "`waste_management_ecm`.`contract`.`amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g. Pending, Approved, Rejected, Executed) — primary filter for pipeline vs. closed amendment analysis."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Category of amendment (e.g. Rate Change, Scope Change, Term Extension) — enables root-cause analysis of contract modification drivers."
    - name: "reason_code"
      expr: reason_code
      comment: "Business reason driving the amendment — used to identify systemic contract issues and inform proactive contract management."
    - name: "legal_review_required"
      expr: legal_review_required
      comment: "Flags amendments requiring legal review — used to segment high-complexity amendments and manage legal team workload."
    - name: "customer_signature_required"
      expr: customer_signature_required
      comment: "Indicates whether customer signature is required — drives SLA tracking for amendment execution cycle time."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the amendment became effective — enables trend analysis of contract modification activity over time."
    - name: "approved_date_month"
      expr: DATE_TRUNC('MONTH', approved_date)
      comment: "Month the amendment was approved — used to track approval throughput and identify bottlenecks in the amendment process."
  measures:
    - name: "amendment_count"
      expr: COUNT(1)
      comment: "Total number of amendments processed. Baseline volume metric indicating contract instability, customer change requests, and operational complexity."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of all amendments. Directly measures revenue uplift or erosion from contract modifications — a critical P&L input."
    - name: "avg_financial_impact_per_amendment"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per amendment. Benchmarks the materiality of contract changes and informs approval threshold policies."
    - name: "total_rate_change_amount"
      expr: SUM(CAST(rate_change_amount AS DOUBLE))
      comment: "Aggregate rate change amounts across all amendments. Measures the cumulative pricing movement driven by contract modifications — key for revenue management."
    - name: "avg_rate_change_percentage"
      expr: AVG(CAST(rate_change_percentage AS DOUBLE))
      comment: "Average rate change percentage per amendment. Tracks pricing trend direction and magnitude — informs escalation strategy and competitive positioning."
    - name: "legal_review_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN legal_review_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amendments requiring legal review. High rates signal contract complexity or risk exposure — drives legal resource allocation decisions."
    - name: "amendments_with_positive_financial_impact"
      expr: COUNT(CASE WHEN financial_impact_amount > 0 THEN 1 END)
      comment: "Number of amendments with a positive (revenue-increasing) financial impact. Measures the success rate of upsell and rate improvement amendment activity."
    - name: "amendments_with_negative_financial_impact"
      expr: COUNT(CASE WHEN financial_impact_amount < 0 THEN 1 END)
      comment: "Number of amendments with a negative (revenue-reducing) financial impact. Quantifies concession and discount activity — a key churn and margin risk indicator."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`contract_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract renewal pipeline and outcome metrics tracking renewal rates, revenue retention, churn risk, and rate escalation performance — the primary dashboard for retention strategy execution."
  source: "`waste_management_ecm`.`contract`.`renewal`"
  dimensions:
    - name: "renewal_status"
      expr: renewal_status
      comment: "Current status of the renewal (e.g. Pending, Won, Lost, In Negotiation) — primary dimension for pipeline stage analysis."
    - name: "renewal_type"
      expr: renewal_type
      comment: "Type of renewal (e.g. Auto, Negotiated, Early) — distinguishes proactive retention from passive auto-renewal."
    - name: "outcome"
      expr: outcome
      comment: "Final renewal outcome (e.g. Renewed, Churned, Pending) — the definitive win/loss metric for retention performance."
    - name: "competitor_threat_flag"
      expr: competitor_threat_flag
      comment: "Flags renewals where a competitor threat was identified — enables competitive win-rate analysis and targeted retention investment."
    - name: "auto_renewal_eligible_flag"
      expr: auto_renewal_eligible_flag
      comment: "Indicates whether the contract qualifies for auto-renewal — segments the renewal book by effort required."
    - name: "rate_escalation_clause_applied"
      expr: rate_escalation_clause_applied
      comment: "Flags renewals where a rate escalation clause was applied — measures the effectiveness of contractual price protection mechanisms."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the renewed contract becomes effective — used for cohort-based retention analysis and revenue forecasting."
    - name: "expiration_year"
      expr: DATE_TRUNC('YEAR', expiration_date)
      comment: "Year the renewal window expires — critical for pipeline prioritization and at-risk revenue identification."
  measures:
    - name: "renewal_count"
      expr: COUNT(1)
      comment: "Total number of renewals in scope. Baseline volume metric for renewal pipeline sizing and workload planning."
    - name: "won_renewal_count"
      expr: COUNT(CASE WHEN outcome = 'Renewed' THEN 1 END)
      comment: "Number of successfully renewed contracts. Core retention KPI — directly measures the effectiveness of the renewal and retention program."
    - name: "renewal_win_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN outcome = 'Renewed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of renewals that resulted in a successful renewal. The primary retention rate KPI — tracked at every executive and operational review."
    - name: "total_renewed_annual_value"
      expr: SUM(CAST(renewed_annual_value AS DOUBLE))
      comment: "Total annual contract value secured through renewals. Measures the revenue retained through the renewal program — a direct P&L input."
    - name: "total_previous_annual_value"
      expr: SUM(CAST(previous_annual_value AS DOUBLE))
      comment: "Total annual contract value of contracts entering the renewal process. Denominator for revenue retention rate calculations and at-risk revenue quantification."
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across renewals in scope. Predictive health indicator for the renewal portfolio — drives proactive retention resource allocation."
    - name: "avg_rate_change_pct_on_renewal"
      expr: AVG(CAST(rate_change_percentage AS DOUBLE))
      comment: "Average rate change percentage achieved at renewal. Measures pricing power and the effectiveness of escalation clauses at contract renewal — key revenue management KPI."
    - name: "competitor_threat_renewal_count"
      expr: COUNT(CASE WHEN competitor_threat_flag = TRUE THEN 1 END)
      comment: "Number of renewals facing a competitive threat. Quantifies competitive exposure in the renewal book — informs sales strategy and retention investment prioritization."
    - name: "escalation_clause_applied_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rate_escalation_clause_applied = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of renewals where a rate escalation clause was applied. Measures the utilization of contractual price protection — informs contract template and negotiation strategy."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`contract_termination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract termination and churn metrics tracking revenue loss, early termination economics, penalty recovery, and win-back eligibility — the primary dashboard for churn management and customer retention post-mortem."
  source: "`waste_management_ecm`.`contract`.`termination`"
  dimensions:
    - name: "termination_status"
      expr: termination_status
      comment: "Current status of the termination (e.g. Pending, Completed, Cancelled) — primary filter for active vs. closed termination analysis."
    - name: "termination_type"
      expr: termination_type
      comment: "Type of termination (e.g. Customer-Initiated, Mutual, For-Cause) — critical for root-cause churn analysis and contract risk modeling."
    - name: "churn_classification"
      expr: churn_classification
      comment: "Business classification of the churn event (e.g. Voluntary, Involuntary, Competitive Loss) — drives targeted retention and win-back strategy."
    - name: "early_termination_flag"
      expr: early_termination_flag
      comment: "Flags contracts terminated before their natural expiration — used to segment penalty-eligible terminations and measure contract compliance."
    - name: "win_back_eligible_flag"
      expr: win_back_eligible_flag
      comment: "Indicates whether the terminated customer is eligible for a win-back campaign — directly drives win-back pipeline sizing."
    - name: "penalty_waived_flag"
      expr: penalty_waived_flag
      comment: "Flags terminations where the early termination penalty was waived — used to measure concession rates and their financial impact."
    - name: "effective_termination_year"
      expr: DATE_TRUNC('YEAR', effective_termination_date)
      comment: "Year the termination became effective — enables trend analysis of churn volume and revenue loss over time."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for termination — enables systematic root-cause analysis of churn drivers to inform product, pricing, and service improvements."
  measures:
    - name: "termination_count"
      expr: COUNT(1)
      comment: "Total number of contract terminations. Baseline churn volume metric — tracked at every retention and operations review."
    - name: "total_contract_value_lost"
      expr: SUM(CAST(contract_value_lost AS DOUBLE))
      comment: "Total contract value lost through terminations. The primary revenue churn KPI — directly informs retention investment decisions and revenue forecasting."
    - name: "avg_contract_value_lost"
      expr: AVG(CAST(contract_value_lost AS DOUBLE))
      comment: "Average contract value lost per termination. Measures the materiality of individual churn events — used to prioritize high-value retention interventions."
    - name: "total_early_termination_penalty_collected"
      expr: SUM(CAST(early_termination_penalty_amount AS DOUBLE))
      comment: "Total early termination penalties assessed. Measures financial recovery from premature contract exits — key input for contract risk and collections management."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance_amount AS DOUBLE))
      comment: "Total outstanding balance at time of termination. Quantifies accounts receivable risk from churned customers — drives collections prioritization."
    - name: "total_final_invoice_amount"
      expr: SUM(CAST(final_invoice_amount AS DOUBLE))
      comment: "Total final invoice amounts issued at termination. Measures the billing close-out value of terminated contracts — used in revenue recognition and AR reconciliation."
    - name: "early_termination_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN early_termination_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminations that occurred before natural contract expiration. High rates signal contract dissatisfaction or competitive pressure — a leading indicator of portfolio health risk."
    - name: "penalty_waiver_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN penalty_waived_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN early_termination_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of early terminations where the penalty was waived. Measures concession discipline — high waiver rates erode financial protection and signal negotiation weakness."
    - name: "win_back_eligible_count"
      expr: COUNT(CASE WHEN win_back_eligible_flag = TRUE THEN 1 END)
      comment: "Number of terminated customers eligible for win-back campaigns. Directly sizes the recoverable revenue opportunity from churned accounts."
    - name: "exit_interview_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exit_interview_completed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminations where an exit interview was completed. Measures the quality of churn intelligence gathering — low rates indicate gaps in understanding churn root causes."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`contract_performance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ASC 606 / IFRS 15 revenue recognition metrics tracking allocated transaction prices, revenue recognized, remaining revenue backlog, and obligation completion rates across the contract performance obligation portfolio."
  source: "`waste_management_ecm`.`contract`.`performance_obligation`"
  dimensions:
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the performance obligation (e.g. Active, Satisfied, Cancelled) — primary dimension for revenue recognition pipeline analysis."
    - name: "revenue_recognition_pattern"
      expr: revenue_recognition_pattern
      comment: "Method of revenue recognition (e.g. Over Time, Point in Time) — critical for financial reporting compliance under ASC 606 / IFRS 15."
    - name: "contract_asset_liability_indicator"
      expr: contract_asset_liability_indicator
      comment: "Indicates whether the obligation represents a contract asset or liability — drives balance sheet classification in financial reporting."
    - name: "is_distinct"
      expr: is_distinct
      comment: "Flags whether the performance obligation is distinct under ASC 606 — determines whether it must be accounted for separately."
    - name: "is_variable_consideration"
      expr: is_variable_consideration
      comment: "Flags obligations with variable consideration (e.g. volume-based pricing) — requires additional estimation and constraint analysis under ASC 606."
    - name: "effective_start_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the performance obligation period begins — used for revenue backlog vintage analysis and cohort-based recognition forecasting."
    - name: "satisfaction_year"
      expr: DATE_TRUNC('YEAR', satisfaction_date)
      comment: "Year the obligation was satisfied — enables trend analysis of revenue recognition timing and completion rates."
  measures:
    - name: "total_allocated_transaction_price"
      expr: SUM(CAST(allocated_transaction_price AS DOUBLE))
      comment: "Total transaction price allocated to performance obligations. The primary revenue backlog KPI under ASC 606 — directly informs revenue forecasting and investor disclosures."
    - name: "total_revenue_recognized_to_date"
      expr: SUM(CAST(revenue_recognized_to_date AS DOUBLE))
      comment: "Total revenue recognized to date across all obligations. Measures cumulative revenue recognition progress — key input for period-end financial close and audit."
    - name: "total_remaining_revenue"
      expr: SUM(CAST(remaining_revenue AS DOUBLE))
      comment: "Total remaining unrecognized revenue (backlog) across obligations. The remaining performance obligation (RPO) disclosure metric — a leading indicator of future revenue."
    - name: "total_standalone_selling_price"
      expr: SUM(CAST(standalone_selling_price AS DOUBLE))
      comment: "Sum of standalone selling prices across obligations. Used to validate transaction price allocation methodology and assess pricing consistency."
    - name: "total_cost_of_service"
      expr: SUM(CAST(cost_of_service AS DOUBLE))
      comment: "Total cost of service associated with performance obligations. Enables gross margin analysis at the obligation level — critical for profitability management."
    - name: "avg_percentage_complete"
      expr: AVG(CAST(percentage_complete AS DOUBLE))
      comment: "Average completion percentage across active performance obligations. Measures overall progress toward obligation satisfaction — used in revenue recognition forecasting."
    - name: "total_variable_consideration_estimate"
      expr: SUM(CAST(variable_consideration_estimate AS DOUBLE))
      comment: "Total estimated variable consideration across obligations. Quantifies revenue estimation uncertainty under ASC 606 — key input for constraint analysis and risk disclosure."
    - name: "revenue_recognition_rate"
      expr: ROUND(100.0 * SUM(CAST(revenue_recognized_to_date AS DOUBLE)) / NULLIF(SUM(CAST(allocated_transaction_price AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated transaction price that has been recognized as revenue. Measures overall revenue recognition progress across the obligation portfolio — a key financial close KPI."
    - name: "obligation_count"
      expr: COUNT(1)
      comment: "Total number of performance obligations. Baseline volume metric for obligation portfolio sizing and revenue recognition workload planning."
    - name: "variable_consideration_obligation_count"
      expr: COUNT(CASE WHEN is_variable_consideration = TRUE THEN 1 END)
      comment: "Number of obligations with variable consideration. Quantifies the portion of the portfolio requiring estimation — drives audit complexity and disclosure requirements."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`contract_service_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service commitment portfolio metrics tracking recurring revenue, overage economics, hazmat exposure, and commitment lifecycle health across all contracted service arrangements."
  source: "`waste_management_ecm`.`contract`.`service_commitment`"
  dimensions:
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current status of the service commitment (e.g. Active, Suspended, Terminated) — primary dimension for active revenue base analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the service commitment auto-renews — segments the recurring revenue base by retention risk profile."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Flags commitments involving hazardous materials — used to segment high-compliance-cost and high-risk service arrangements."
    - name: "permit_required_flag"
      expr: permit_required_flag
      comment: "Indicates whether a permit is required for the service — used to track regulatory compliance exposure across the commitment portfolio."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the service commitment — required for multi-currency revenue aggregation and FX risk analysis."
    - name: "service_state_province"
      expr: service_state_province
      comment: "State or province where the service is delivered — enables geographic revenue and volume analysis."
    - name: "effective_start_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the service commitment became effective — used for cohort analysis of the recurring revenue base."
    - name: "effective_end_year"
      expr: DATE_TRUNC('YEAR', effective_end_date)
      comment: "Year the service commitment expires — critical for renewal pipeline and at-risk recurring revenue forecasting."
  measures:
    - name: "total_monthly_service_charge"
      expr: SUM(CAST(monthly_service_charge AS DOUBLE))
      comment: "Total monthly recurring service charges across all active commitments. The primary recurring revenue KPI — directly drives MRR and ARR calculations for the contract portfolio."
    - name: "avg_monthly_service_charge"
      expr: AVG(CAST(monthly_service_charge AS DOUBLE))
      comment: "Average monthly service charge per commitment. Tracks average revenue per service unit — used in pricing benchmarking and upsell opportunity identification."
    - name: "total_overage_charge_rate"
      expr: SUM(CAST(overage_charge_rate AS DOUBLE))
      comment: "Sum of overage charge rates across commitments. Quantifies the potential upside revenue from volume overages — used in revenue forecasting and contract design optimization."
    - name: "total_per_pickup_charge"
      expr: SUM(CAST(per_pickup_charge AS DOUBLE))
      comment: "Total per-pickup charges across all commitments. Measures transactional revenue exposure alongside recurring charges — important for variable revenue forecasting."
    - name: "hazmat_commitment_count"
      expr: COUNT(CASE WHEN hazmat_flag = TRUE THEN 1 END)
      comment: "Number of service commitments involving hazardous materials. Quantifies the hazmat service portfolio — drives specialized fleet, compliance, and insurance resource planning."
    - name: "hazmat_commitment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazmat_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service commitments involving hazardous materials. Measures the compliance intensity of the service portfolio — high rates signal elevated regulatory and operational risk."
    - name: "commitment_count"
      expr: COUNT(1)
      comment: "Total number of service commitments. Baseline volume metric for service portfolio sizing and operational capacity planning."
    - name: "active_commitment_count"
      expr: COUNT(CASE WHEN commitment_status = 'Active' THEN 1 END)
      comment: "Number of currently active service commitments. Measures the live service base — the operational denominator for utilization and revenue-per-commitment analysis."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`contract_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract pricing metrics tracking rate levels, discount economics, escalation parameters, and pricing approval health across the waste management pricing portfolio."
  source: "`waste_management_ecm`.`contract`.`pricing`"
  dimensions:
    - name: "pricing_status"
      expr: pricing_status
      comment: "Current status of the pricing record (e.g. Active, Expired, Pending Approval) — primary filter for live vs. historical pricing analysis."
    - name: "pricing_type"
      expr: pricing_type
      comment: "Type of pricing structure (e.g. Flat Rate, Tiered, Per-Ton) — enables analysis of pricing model mix and its impact on revenue predictability."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the pricing record — used to track pricing governance compliance and identify unapproved rates in production."
    - name: "escalation_type"
      expr: escalation_type
      comment: "Type of escalation mechanism (e.g. CPI, Fixed, Fuel Index) — critical for understanding revenue growth drivers and inflation protection coverage."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing cadence for the pricing record — used to segment pricing by cash-flow impact and billing complexity."
    - name: "tax_exempt"
      expr: tax_exempt
      comment: "Flags tax-exempt pricing records — used for tax compliance reporting and revenue net-of-tax analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pricing record — required for multi-currency pricing analysis and FX exposure management."
    - name: "effective_start_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the pricing became effective — enables vintage analysis of pricing levels and escalation history."
  measures:
    - name: "total_base_rate"
      expr: SUM(CAST(base_rate AS DOUBLE))
      comment: "Sum of base rates across all pricing records. Measures the aggregate pricing floor across the portfolio — used in rate adequacy and margin analysis."
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base rate per pricing record. Tracks pricing level trends over time — key input for competitive benchmarking and pricing strategy reviews."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amounts granted across pricing records. Quantifies revenue leakage from discounting — a critical margin management KPI."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across pricing records. Measures discounting intensity — high averages signal pricing discipline issues and margin erosion risk."
    - name: "avg_escalation_rate"
      expr: AVG(CAST(escalation_rate AS DOUBLE))
      comment: "Average escalation rate across pricing records. Measures the average contractual price growth rate — directly informs revenue growth forecasting."
    - name: "total_minimum_charge"
      expr: SUM(CAST(minimum_charge AS DOUBLE))
      comment: "Total minimum charges across pricing records. Represents the guaranteed revenue floor from minimum charge provisions — used in downside revenue scenario planning."
    - name: "total_maximum_charge"
      expr: SUM(CAST(maximum_charge AS DOUBLE))
      comment: "Total maximum charges across pricing records. Represents the revenue ceiling from capped pricing arrangements — used in upside revenue scenario planning."
    - name: "pricing_record_count"
      expr: COUNT(1)
      comment: "Total number of pricing records. Baseline volume metric for pricing portfolio complexity and governance workload assessment."
    - name: "unapproved_pricing_count"
      expr: COUNT(CASE WHEN approval_status != 'Approved' THEN 1 END)
      comment: "Number of pricing records not yet approved. Measures pricing governance risk — unapproved rates in production represent compliance and audit exposure."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`contract_franchise_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise agreement metrics tracking fee economics, diversion rate commitments, GHG reduction targets, and agreement portfolio health across municipal franchise arrangements — a strategically critical revenue and regulatory compliance domain."
  source: "`waste_management_ecm`.`contract`.`franchise_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the franchise agreement (e.g. Active, Expired, Pending) — primary filter for live franchise portfolio analysis."
    - name: "franchise_fee_type"
      expr: franchise_fee_type
      comment: "Type of franchise fee structure (e.g. Percentage, Per-Ton, Fixed) — enables analysis of fee model mix and revenue predictability."
    - name: "exclusivity_type"
      expr: exclusivity_type
      comment: "Type of exclusivity granted (e.g. Exclusive, Non-Exclusive) — measures the competitive protection profile of the franchise portfolio."
    - name: "swis_reporting_required"
      expr: swis_reporting_required
      comment: "Flags agreements requiring SWIS (Solid Waste Information System) reporting — used to track California regulatory compliance obligations."
    - name: "performance_bond_required"
      expr: performance_bond_required
      comment: "Indicates whether a performance bond is required — segments high-compliance-risk franchise agreements."
    - name: "effective_start_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the franchise agreement became effective — used for portfolio vintage analysis and renewal pipeline planning."
    - name: "effective_end_year"
      expr: DATE_TRUNC('YEAR', effective_end_date)
      comment: "Year the franchise agreement expires — critical for renewal pipeline prioritization and at-risk revenue identification."
  measures:
    - name: "total_franchise_fee_fixed_amount"
      expr: SUM(CAST(franchise_fee_fixed_amount AS DOUBLE))
      comment: "Total fixed franchise fees across all agreements. Measures the guaranteed fee revenue from municipal franchise arrangements — a stable, high-margin revenue stream."
    - name: "avg_franchise_fee_percentage"
      expr: AVG(CAST(franchise_fee_percentage AS DOUBLE))
      comment: "Average franchise fee percentage across agreements. Benchmarks fee rates against municipal norms — used in contract negotiation and renewal strategy."
    - name: "avg_franchise_fee_per_ton_rate"
      expr: AVG(CAST(franchise_fee_per_ton_rate AS DOUBLE))
      comment: "Average per-ton franchise fee rate. Measures the unit economics of tonnage-based franchise fee structures — used in volume-based revenue forecasting."
    - name: "total_performance_bond_amount"
      expr: SUM(CAST(performance_bond_amount AS DOUBLE))
      comment: "Total performance bond amounts committed across franchise agreements. Quantifies compliance-related financial exposure to municipalities."
    - name: "avg_diversion_rate_requirement"
      expr: AVG(CAST(diversion_rate_requirement AS DOUBLE))
      comment: "Average diversion rate requirement across franchise agreements. Measures the aggregate recycling and diversion commitment — a key environmental compliance and regulatory risk KPI."
    - name: "avg_ghg_reduction_target_pct"
      expr: AVG(CAST(ghg_reduction_target_percentage AS DOUBLE))
      comment: "Average GHG reduction target percentage across franchise agreements. Measures the aggregate sustainability commitment — critical for ESG reporting and regulatory compliance."
    - name: "franchise_agreement_count"
      expr: COUNT(1)
      comment: "Total number of franchise agreements. Baseline portfolio size metric — used in market coverage and competitive position analysis."
    - name: "exclusive_franchise_count"
      expr: COUNT(CASE WHEN exclusivity_type = 'Exclusive' THEN 1 END)
      comment: "Number of exclusive franchise agreements. Measures the portion of the franchise portfolio with competitive protection — a key strategic market position indicator."
    - name: "exclusive_franchise_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exclusivity_type = 'Exclusive' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of franchise agreements that are exclusive. Measures the competitive moat of the franchise portfolio — higher rates indicate stronger market protection."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`contract_disposal_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disposal agreement metrics tracking tipping fee economics, contracted tonnage commitments, capacity utilization, and agreement portfolio health across landfill and transfer station disposal arrangements."
  source: "`waste_management_ecm`.`contract`.`disposal_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the disposal agreement (e.g. Active, Expired, Terminated) — primary filter for live disposal capacity analysis."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing cadence for the disposal agreement — used to segment agreements by cash-flow impact and billing complexity."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the disposal agreement auto-renews — segments the disposal capacity base by renewal risk."
    - name: "rcra_compliance_required"
      expr: rcra_compliance_required
      comment: "Flags agreements requiring RCRA (Resource Conservation and Recovery Act) compliance — used to segment high-regulatory-risk disposal arrangements."
    - name: "manifest_required"
      expr: manifest_required
      comment: "Indicates whether a waste manifest is required — used to track hazardous waste disposal compliance obligations."
    - name: "insurance_required"
      expr: insurance_required
      comment: "Flags agreements requiring insurance coverage — used to monitor compliance with insurance obligations across the disposal portfolio."
    - name: "effective_start_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the disposal agreement became effective — used for portfolio vintage analysis and capacity planning."
    - name: "tipping_fee_currency"
      expr: tipping_fee_currency
      comment: "Currency of the tipping fee — required for multi-currency disposal cost analysis."
  measures:
    - name: "avg_base_tipping_fee_rate"
      expr: AVG(CAST(base_tipping_fee_rate AS DOUBLE))
      comment: "Average base tipping fee rate across disposal agreements. The primary unit cost KPI for disposal operations — used in cost benchmarking, margin analysis, and disposal site selection."
    - name: "total_contracted_annual_tonnage"
      expr: SUM(CAST(contracted_annual_tonnage AS DOUBLE))
      comment: "Total contracted annual tonnage across all disposal agreements. Measures committed disposal capacity — critical for landfill capacity planning and throughput forecasting."
    - name: "total_minimum_tonnage_guarantee"
      expr: SUM(CAST(minimum_tonnage_guarantee AS DOUBLE))
      comment: "Total minimum tonnage guarantees across disposal agreements. Quantifies the guaranteed volume floor — used in disposal cost forecasting and take-or-pay liability analysis."
    - name: "total_maximum_tonnage_limit"
      expr: SUM(CAST(maximum_tonnage_limit AS DOUBLE))
      comment: "Total maximum tonnage limits across disposal agreements. Measures the aggregate disposal capacity ceiling — used in overflow planning and capacity constraint analysis."
    - name: "total_tpd_capacity"
      expr: SUM(CAST(tpd_capacity AS DOUBLE))
      comment: "Total tons-per-day capacity across all disposal agreements. Measures aggregate daily disposal throughput capacity — a key operational capacity planning KPI."
    - name: "total_insurance_coverage_amount"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage amounts across disposal agreements. Quantifies the aggregate risk coverage for disposal operations — used in risk management and compliance reporting."
    - name: "disposal_agreement_count"
      expr: COUNT(1)
      comment: "Total number of disposal agreements. Baseline portfolio size metric for disposal network coverage and vendor relationship management."
    - name: "rcra_compliant_agreement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rcra_compliance_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disposal agreements requiring RCRA compliance. Measures the regulatory intensity of the disposal portfolio — high rates signal elevated compliance cost and risk."
    - name: "tonnage_utilization_ratio"
      expr: ROUND(100.0 * SUM(CAST(minimum_tonnage_guarantee AS DOUBLE)) / NULLIF(SUM(CAST(maximum_tonnage_limit AS DOUBLE)), 0), 2)
      comment: "Ratio of minimum guaranteed tonnage to maximum tonnage limit. Measures how tightly committed the disposal capacity is — low ratios indicate underutilized capacity; high ratios signal capacity risk."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`contract_escalation_clause`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Escalation clause metrics tracking rate escalation economics, cap and floor parameters, and escalation activity across the contract portfolio — critical for revenue growth forecasting and inflation risk management."
  source: "`waste_management_ecm`.`contract`.`escalation_clause`"
  dimensions:
    - name: "escalation_clause_status"
      expr: escalation_clause_status
      comment: "Current status of the escalation clause (e.g. Active, Expired, Suspended) — primary filter for live escalation analysis."
    - name: "escalation_type"
      expr: escalation_type
      comment: "Type of escalation mechanism (e.g. CPI, Fixed, Fuel Index, PPI) — enables analysis of escalation driver mix and inflation protection coverage."
    - name: "compounding_method"
      expr: compounding_method
      comment: "Method of compounding escalation (e.g. Simple, Compound) — affects long-term revenue growth projections."
    - name: "customer_approval_required"
      expr: customer_approval_required
      comment: "Flags escalation clauses requiring customer approval — used to identify escalations at risk of customer dispute or delay."
    - name: "review_frequency"
      expr: review_frequency
      comment: "How often the escalation clause is reviewed (e.g. Annual, Semi-Annual) — used to schedule escalation review workload."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the escalation clause became effective — used for vintage analysis of escalation terms across the portfolio."
    - name: "next_review_year"
      expr: DATE_TRUNC('YEAR', next_review_date)
      comment: "Year of the next scheduled escalation review — used to prioritize upcoming escalation actions and revenue uplift opportunities."
  measures:
    - name: "avg_fixed_escalation_percentage"
      expr: AVG(CAST(fixed_escalation_percentage AS DOUBLE))
      comment: "Average fixed escalation percentage across clauses. Measures the average contractual price growth rate — directly informs revenue growth forecasting for fixed-escalation contracts."
    - name: "avg_escalation_cap_percentage"
      expr: AVG(CAST(escalation_cap_percentage AS DOUBLE))
      comment: "Average escalation cap percentage across clauses. Measures the average ceiling on contractual price increases — used to assess revenue upside limits under inflationary conditions."
    - name: "avg_escalation_floor_percentage"
      expr: AVG(CAST(escalation_floor_percentage AS DOUBLE))
      comment: "Average escalation floor percentage across clauses. Measures the average minimum guaranteed price increase — quantifies the revenue growth floor across the escalation portfolio."
    - name: "avg_last_escalation_percentage"
      expr: AVG(CAST(last_escalation_percentage AS DOUBLE))
      comment: "Average escalation percentage applied at the most recent escalation event. Measures actual realized price increases — used to validate escalation effectiveness and compare against caps/floors."
    - name: "avg_base_index_value"
      expr: AVG(CAST(base_index_value AS DOUBLE))
      comment: "Average base index value across index-linked escalation clauses. Provides the baseline reference for calculating future escalation amounts — used in revenue projection modeling."
    - name: "escalation_clause_count"
      expr: COUNT(1)
      comment: "Total number of escalation clauses. Baseline volume metric for escalation portfolio coverage and review workload planning."
    - name: "customer_approval_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN customer_approval_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of escalation clauses requiring customer approval. High rates indicate revenue growth at risk of customer pushback — informs negotiation strategy for future contract templates."
$$;