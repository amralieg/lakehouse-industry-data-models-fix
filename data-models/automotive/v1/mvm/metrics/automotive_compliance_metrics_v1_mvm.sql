-- Metric views for domain: compliance | Business: Automotive | Version: 1 | Generated on: 2026-05-07 02:15:05

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`compliance_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance test performance metrics tracking pass/fail rates, measurement accuracy, and regulatory adherence across test parameters and jurisdictions"
  source: "`automotive_ecm`.`compliance`.`compliance_test_result`"
  dimensions:
    - name: "compliance_regulation_code"
      expr: compliance_regulation_code
      comment: "Regulatory standard code being tested (e.g., EPA Tier 3, Euro 6d)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Geographic jurisdiction where compliance is required"
    - name: "parameter_name"
      expr: parameter_name
      comment: "Specific parameter being measured (e.g., NOx, CO2, particulate matter)"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Test outcome: pass or fail against regulatory limit"
    - name: "test_phase"
      expr: test_phase
      comment: "Testing phase (e.g., pre-production, certification, production validation)"
    - name: "lab_location_code"
      expr: lab_location_code
      comment: "Testing laboratory location identifier"
    - name: "measurement_method"
      expr: measurement_method
      comment: "Test methodology used for measurement"
    - name: "test_result_status"
      expr: test_result_status
      comment: "Overall status of test result record"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Equipment calibration status at time of test"
    - name: "is_outlier"
      expr: is_outlier
      comment: "Flag indicating if result is statistical outlier"
    - name: "test_year"
      expr: YEAR(test_timestamp)
      comment: "Year when test was conducted"
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_timestamp)
      comment: "Month when test was conducted"
  measures:
    - name: "total_tests_conducted"
      expr: COUNT(1)
      comment: "Total number of compliance tests performed"
    - name: "total_tests_passed"
      expr: COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END)
      comment: "Number of tests that passed regulatory limits"
    - name: "total_tests_failed"
      expr: COUNT(CASE WHEN pass_fail_status = 'Fail' THEN 1 END)
      comment: "Number of tests that failed regulatory limits"
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests passing regulatory compliance (key quality indicator)"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across tests"
    - name: "avg_regulatory_limit"
      expr: AVG(CAST(regulatory_limit AS DOUBLE))
      comment: "Average regulatory limit threshold"
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty indicating test precision"
    - name: "total_outlier_tests"
      expr: COUNT(CASE WHEN is_outlier = TRUE THEN 1 END)
      comment: "Number of tests flagged as statistical outliers requiring investigation"
    - name: "avg_compliance_margin"
      expr: AVG(CAST(regulatory_limit AS DOUBLE) - CAST(measured_value AS DOUBLE))
      comment: "Average margin between regulatory limit and measured value (positive = passing margin, negative = exceedance)"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`compliance_homologation_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle type approval and certification metrics tracking homologation status, emissions performance, and regulatory approval timelines"
  source: "`automotive_ecm`.`compliance`.`homologation_record`"
  dimensions:
    - name: "approval_type"
      expr: approval_type
      comment: "Type of regulatory approval (e.g., whole vehicle, individual approval)"
    - name: "homologation_record_status"
      expr: homologation_record_status
      comment: "Current status of homologation record"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority granting approval"
    - name: "test_cycle"
      expr: test_cycle
      comment: "Emissions test cycle used (e.g., WLTP, NEDC, FTP-75)"
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Category of vehicle being homologated"
    - name: "test_lab"
      expr: test_lab
      comment: "Laboratory conducting homologation testing"
    - name: "approval_year"
      expr: YEAR(approval_status_date)
      comment: "Year approval was granted"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_status_date)
      comment: "Month approval was granted"
    - name: "test_year"
      expr: YEAR(test_date)
      comment: "Year testing was conducted"
  measures:
    - name: "total_homologations"
      expr: COUNT(1)
      comment: "Total number of homologation records"
    - name: "distinct_vehicle_configurations"
      expr: COUNT(DISTINCT configuration_id)
      comment: "Number of unique vehicle configurations homologated"
    - name: "distinct_vehicle_programs"
      expr: COUNT(DISTINCT vehicle_program_id)
      comment: "Number of distinct vehicle programs with homologation"
    - name: "avg_co2_emissions_g_per_km"
      expr: AVG(CAST(co2_emissions_g_per_km AS DOUBLE))
      comment: "Average CO2 emissions across homologated vehicles (key environmental KPI)"
    - name: "avg_fuel_consumption_l_per_100km"
      expr: AVG(CAST(fuel_consumption_l_per_100km AS DOUBLE))
      comment: "Average fuel consumption across homologated vehicles"
    - name: "total_active_approvals"
      expr: COUNT(CASE WHEN homologation_record_status = 'Active' THEN 1 END)
      comment: "Number of currently active homologation approvals"
    - name: "total_expired_approvals"
      expr: COUNT(CASE WHEN expiration_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of expired homologation approvals requiring renewal"
    - name: "avg_approval_validity_days"
      expr: AVG(DATEDIFF(expiration_date, effective_date))
      comment: "Average validity period of homologation approvals in days"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory obligation tracking metrics measuring compliance status, certification timeliness, and risk exposure across vehicle programs"
  source: "`automotive_ecm`.`compliance`.`obligation`"
  dimensions:
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of compliance obligation"
    - name: "priority"
      expr: priority
      comment: "Business priority level of obligation"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level if obligation is not met"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating critical obligation requiring immediate attention"
    - name: "is_regulatory"
      expr: is_regulatory
      comment: "Flag indicating regulatory vs. voluntary obligation"
    - name: "certification_body"
      expr: certification_body
      comment: "Organization responsible for certification"
    - name: "responsible_engineering_group"
      expr: responsible_engineering_group
      comment: "Engineering team accountable for obligation"
    - name: "model_year"
      expr: model_year
      comment: "Vehicle model year associated with obligation"
    - name: "test_facility"
      expr: test_facility
      comment: "Facility conducting compliance testing"
    - name: "test_result"
      expr: test_result
      comment: "Outcome of compliance test"
    - name: "target_cert_year"
      expr: YEAR(target_certification_date)
      comment: "Target year for certification completion"
    - name: "actual_cert_year"
      expr: YEAR(actual_certification_date)
      comment: "Actual year certification was achieved"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of compliance obligations"
    - name: "total_critical_obligations"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical obligations requiring immediate action"
    - name: "total_regulatory_obligations"
      expr: COUNT(CASE WHEN is_regulatory = TRUE THEN 1 END)
      comment: "Number of mandatory regulatory obligations"
    - name: "total_high_risk_obligations"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of high-risk obligations"
    - name: "total_overdue_obligations"
      expr: COUNT(CASE WHEN target_certification_date < CURRENT_DATE() AND actual_certification_date IS NULL THEN 1 END)
      comment: "Number of obligations past target certification date (key risk indicator)"
    - name: "total_completed_obligations"
      expr: COUNT(CASE WHEN actual_certification_date IS NOT NULL THEN 1 END)
      comment: "Number of obligations with completed certification"
    - name: "on_time_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_certification_date <= target_certification_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_certification_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of obligations completed on or before target date (key performance indicator)"
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across obligations"
    - name: "avg_emission_value"
      expr: AVG(CAST(emission_value AS DOUBLE))
      comment: "Average emission value measured for obligations"
    - name: "avg_fuel_economy_value"
      expr: AVG(CAST(fuel_economy_value AS DOUBLE))
      comment: "Average fuel economy value for obligations"
    - name: "distinct_vehicle_programs"
      expr: COUNT(DISTINCT vehicle_program_id)
      comment: "Number of unique vehicle programs with compliance obligations"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`compliance_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission performance metrics tracking approval rates, processing times, and submission costs across jurisdictions"
  source: "`automotive_ecm`.`compliance`.`regulatory_submission`"
  dimensions:
    - name: "regulatory_submission_status"
      expr: regulatory_submission_status
      comment: "Current status of regulatory submission"
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission"
    - name: "submission_category"
      expr: submission_category
      comment: "Category of submission"
    - name: "regulatory_body_name"
      expr: regulatory_body_name
      comment: "Name of regulatory authority receiving submission"
    - name: "emission_standard"
      expr: emission_standard
      comment: "Emissions standard being certified"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type of vehicle in submission"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating critical submission"
    - name: "is_urgent"
      expr: is_urgent
      comment: "Flag indicating urgent submission requiring expedited processing"
    - name: "fee_currency"
      expr: fee_currency
      comment: "Currency of submission fees"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year submission was filed"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month submission was filed"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year approval was granted"
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions"
    - name: "total_approved_submissions"
      expr: COUNT(CASE WHEN regulatory_submission_status = 'Approved' THEN 1 END)
      comment: "Number of approved submissions"
    - name: "total_rejected_submissions"
      expr: COUNT(CASE WHEN regulatory_submission_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected submissions requiring rework"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_submission_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions approved (key efficiency indicator)"
    - name: "total_critical_submissions"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical submissions"
    - name: "total_urgent_submissions"
      expr: COUNT(CASE WHEN is_urgent = TRUE THEN 1 END)
      comment: "Number of urgent submissions"
    - name: "total_fee_gross_amount"
      expr: SUM(CAST(fee_gross_amount AS DOUBLE))
      comment: "Total gross submission fees paid"
    - name: "total_fee_net_amount"
      expr: SUM(CAST(fee_net_amount AS DOUBLE))
      comment: "Total net submission fees paid"
    - name: "total_fee_tax_amount"
      expr: SUM(CAST(fee_tax_amount AS DOUBLE))
      comment: "Total tax on submission fees"
    - name: "avg_fee_gross_amount"
      expr: AVG(CAST(fee_gross_amount AS DOUBLE))
      comment: "Average gross fee per submission"
    - name: "avg_processing_days"
      expr: AVG(DATEDIFF(approval_date, submission_date))
      comment: "Average days from submission to approval (key cycle time metric)"
    - name: "avg_cafe_value"
      expr: AVG(CAST(cafe_value AS DOUBLE))
      comment: "Average CAFE (Corporate Average Fuel Economy) value across submissions"
    - name: "distinct_jurisdictions"
      expr: COUNT(DISTINCT jurisdiction_id)
      comment: "Number of unique jurisdictions receiving submissions"
    - name: "distinct_vehicle_programs"
      expr: COUNT(DISTINCT vehicle_program_id)
      comment: "Number of unique vehicle programs with submissions"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`compliance_test_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance test event metrics tracking test execution, pass/fail outcomes, retest frequency, and environmental test conditions"
  source: "`automotive_ecm`.`compliance`.`test_event`"
  dimensions:
    - name: "test_event_status"
      expr: test_event_status
      comment: "Current status of test event"
    - name: "test_type"
      expr: test_type
      comment: "Type of compliance test conducted"
    - name: "test_category"
      expr: test_category
      comment: "Category of test event"
    - name: "test_facility"
      expr: test_facility
      comment: "Facility where test was conducted"
    - name: "test_location"
      expr: test_location
      comment: "Geographic location of test"
    - name: "certification_body"
      expr: certification_body
      comment: "Certification authority overseeing test"
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status resulting from test"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Jurisdiction for which test is conducted"
    - name: "pass_fail_flag"
      expr: pass_fail_flag
      comment: "Boolean flag indicating test pass or fail"
    - name: "is_retest"
      expr: is_retest
      comment: "Flag indicating if this is a retest event"
    - name: "test_program"
      expr: test_program
      comment: "Testing program under which test was conducted"
    - name: "test_condition"
      expr: test_condition
      comment: "Environmental or operational conditions during test"
    - name: "result"
      expr: result
      comment: "Test result outcome"
    - name: "retest_reason"
      expr: retest_reason
      comment: "Reason for retest if applicable"
    - name: "test_year"
      expr: YEAR(test_timestamp)
      comment: "Year test was conducted"
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_timestamp)
      comment: "Month test was conducted"
  measures:
    - name: "total_test_events"
      expr: COUNT(1)
      comment: "Total number of test events conducted"
    - name: "total_tests_passed"
      expr: COUNT(CASE WHEN pass_fail_flag = TRUE THEN 1 END)
      comment: "Number of test events that passed"
    - name: "total_tests_failed"
      expr: COUNT(CASE WHEN pass_fail_flag = FALSE THEN 1 END)
      comment: "Number of test events that failed"
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of test events passing (key quality indicator)"
    - name: "total_retests"
      expr: COUNT(CASE WHEN is_retest = TRUE THEN 1 END)
      comment: "Number of retest events indicating initial failures"
    - name: "retest_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_retest = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests requiring retest (key efficiency indicator)"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across test events"
    - name: "avg_ambient_temperature_c"
      expr: AVG(CAST(ambient_temperature_c AS DOUBLE))
      comment: "Average ambient temperature during testing"
    - name: "avg_ambient_humidity_percent"
      expr: AVG(CAST(ambient_humidity_percent AS DOUBLE))
      comment: "Average ambient humidity during testing"
    - name: "avg_ambient_pressure_kpa"
      expr: AVG(CAST(ambient_pressure_kpa AS DOUBLE))
      comment: "Average ambient pressure during testing"
    - name: "distinct_vehicle_programs"
      expr: COUNT(DISTINCT vehicle_program_id)
      comment: "Number of unique vehicle programs tested"
    - name: "distinct_test_facilities"
      expr: COUNT(DISTINCT test_facility)
      comment: "Number of unique test facilities used"
    - name: "distinct_configurations_tested"
      expr: COUNT(DISTINCT configuration_id)
      comment: "Number of unique vehicle configurations tested"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`compliance_zev_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Zero-emission vehicle credit portfolio metrics tracking credit generation, trading activity, pricing, and regulatory compliance value"
  source: "`automotive_ecm`.`compliance`.`zev_credit`"
  dimensions:
    - name: "credit_type"
      expr: credit_type
      comment: "Type of ZEV credit (e.g., BEV, PHEV, FCEV)"
    - name: "credit_status"
      expr: credit_status
      comment: "Current status of credit (e.g., active, retired, traded)"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of credit transaction (e.g., generation, sale, purchase, retirement)"
    - name: "credit_vintage_year"
      expr: credit_vintage_year
      comment: "Year credit was generated"
    - name: "model_year"
      expr: model_year
      comment: "Vehicle model year generating credit"
    - name: "region"
      expr: region
      comment: "Geographic region where credit is valid"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority administering credit program"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type of vehicle generating credit"
    - name: "credit_basis"
      expr: credit_basis
      comment: "Basis for credit calculation"
    - name: "counterparty_role"
      expr: counterparty_role
      comment: "Role of counterparty in transaction (buyer/seller)"
    - name: "retirement_reason"
      expr: retirement_reason
      comment: "Reason credit was retired"
    - name: "transaction_year"
      expr: YEAR(transaction_date)
      comment: "Year transaction occurred"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month transaction occurred"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year credit became effective"
  measures:
    - name: "total_credit_transactions"
      expr: COUNT(1)
      comment: "Total number of ZEV credit transactions"
    - name: "total_credit_quantity"
      expr: SUM(CAST(credit_quantity AS DOUBLE))
      comment: "Total quantity of ZEV credits in portfolio"
    - name: "total_credit_value_usd"
      expr: SUM(CAST(credit_quantity AS DOUBLE) * CAST(credit_price_usd AS DOUBLE))
      comment: "Total dollar value of ZEV credit portfolio (key financial metric)"
    - name: "avg_credit_price_usd"
      expr: AVG(CAST(credit_price_usd AS DOUBLE))
      comment: "Average price per ZEV credit in USD"
    - name: "total_credits_generated"
      expr: SUM(CASE WHEN transaction_type = 'Generation' THEN CAST(credit_quantity AS DOUBLE) ELSE 0 END)
      comment: "Total credits generated from vehicle sales"
    - name: "total_credits_sold"
      expr: SUM(CASE WHEN transaction_type = 'Sale' THEN CAST(credit_quantity AS DOUBLE) ELSE 0 END)
      comment: "Total credits sold to other manufacturers"
    - name: "total_credits_purchased"
      expr: SUM(CASE WHEN transaction_type = 'Purchase' THEN CAST(credit_quantity AS DOUBLE) ELSE 0 END)
      comment: "Total credits purchased from other manufacturers"
    - name: "total_credits_retired"
      expr: SUM(CASE WHEN transaction_type = 'Retirement' THEN CAST(credit_quantity AS DOUBLE) ELSE 0 END)
      comment: "Total credits retired for compliance"
    - name: "net_credit_position"
      expr: SUM(CASE WHEN transaction_type IN ('Generation', 'Purchase') THEN CAST(credit_quantity AS DOUBLE) WHEN transaction_type IN ('Sale', 'Retirement') THEN -CAST(credit_quantity AS DOUBLE) ELSE 0 END)
      comment: "Net credit position (generation + purchases - sales - retirements, key compliance metric)"
    - name: "total_active_credits"
      expr: SUM(CASE WHEN credit_status = 'Active' THEN CAST(credit_quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity of active credits available for use"
    - name: "total_sale_revenue_usd"
      expr: SUM(CASE WHEN transaction_type = 'Sale' THEN CAST(credit_quantity AS DOUBLE) * CAST(credit_price_usd AS DOUBLE) ELSE 0 END)
      comment: "Total revenue from credit sales (key revenue metric)"
    - name: "total_purchase_cost_usd"
      expr: SUM(CASE WHEN transaction_type = 'Purchase' THEN CAST(credit_quantity AS DOUBLE) * CAST(credit_price_usd AS DOUBLE) ELSE 0 END)
      comment: "Total cost of credit purchases (key cost metric)"
    - name: "distinct_vehicle_programs"
      expr: COUNT(DISTINCT vehicle_program_id)
      comment: "Number of unique vehicle programs generating credits"
    - name: "distinct_jurisdictions"
      expr: COUNT(DISTINCT jurisdiction_id)
      comment: "Number of unique jurisdictions with credit activity"
    - name: "distinct_counterparties"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of unique trading counterparties"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`compliance_regulatory_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory requirement inventory metrics tracking active regulations, compliance deadlines, and regulatory coverage across markets"
  source: "`automotive_ecm`.`compliance`.`regulatory_requirement`"
  dimensions:
    - name: "regulation_type"
      expr: regulation_type
      comment: "Type of regulation (e.g., emissions, safety, fuel economy)"
    - name: "regulatory_requirement_status"
      expr: regulatory_requirement_status
      comment: "Current status of regulatory requirement"
    - name: "issuing_body"
      expr: issuing_body
      comment: "Regulatory authority issuing requirement"
    - name: "market"
      expr: market
      comment: "Market where regulation applies"
    - name: "vehicle_category"
      expr: vehicle_category
      comment: "Vehicle category subject to regulation"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type subject to regulation"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Flag indicating mandatory vs. voluntary regulation"
    - name: "is_global"
      expr: is_global
      comment: "Flag indicating global vs. regional regulation"
    - name: "regulation_code"
      expr: regulation_code
      comment: "Unique code identifying regulation"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year regulation becomes effective"
    - name: "compliance_deadline_year"
      expr: YEAR(compliance_deadline)
      comment: "Year compliance must be achieved"
  measures:
    - name: "total_regulatory_requirements"
      expr: COUNT(1)
      comment: "Total number of regulatory requirements tracked"
    - name: "total_active_requirements"
      expr: COUNT(CASE WHEN regulatory_requirement_status = 'Active' THEN 1 END)
      comment: "Number of currently active regulatory requirements"
    - name: "total_mandatory_requirements"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Number of mandatory regulatory requirements"
    - name: "total_global_requirements"
      expr: COUNT(CASE WHEN is_global = TRUE THEN 1 END)
      comment: "Number of global regulatory requirements"
    - name: "total_upcoming_deadlines"
      expr: COUNT(CASE WHEN compliance_deadline >= CURRENT_DATE() AND compliance_deadline <= DATE_ADD(CURRENT_DATE(), 365) THEN 1 END)
      comment: "Number of requirements with compliance deadlines in next 12 months (key planning metric)"
    - name: "total_overdue_requirements"
      expr: COUNT(CASE WHEN compliance_deadline < CURRENT_DATE() AND regulatory_requirement_status = 'Active' THEN 1 END)
      comment: "Number of requirements past compliance deadline (key risk indicator)"
    - name: "distinct_jurisdictions"
      expr: COUNT(DISTINCT jurisdiction_id)
      comment: "Number of unique jurisdictions with regulatory requirements"
    - name: "distinct_issuing_bodies"
      expr: COUNT(DISTINCT issuing_body)
      comment: "Number of unique regulatory authorities"
    - name: "distinct_markets"
      expr: COUNT(DISTINCT market)
      comment: "Number of unique markets with regulatory requirements"
    - name: "avg_days_to_compliance_deadline"
      expr: AVG(DATEDIFF(compliance_deadline, CURRENT_DATE()))
      comment: "Average days remaining until compliance deadline"
$$;