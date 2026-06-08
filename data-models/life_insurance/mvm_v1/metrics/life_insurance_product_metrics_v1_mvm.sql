-- Metric views for domain: product | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 06:54:29

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic product plan metrics covering the active product portfolio, face amount capacity, premium range, and profitability targets. Used by Product Management and Finance to evaluate portfolio composition, pricing adequacy, and IRR targets across the life insurance product suite."
  source: "`life_insurance_ecm`.`product`.`plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current lifecycle status of the plan (e.g. Active, Retired, Pending). Primary filter for active portfolio analysis."
    - name: "insurance_type"
      expr: insurance_type
      comment: "Type of insurance product (e.g. Term, Whole Life, UL, VUL, Annuity). Core segmentation dimension for portfolio mix analysis."
    - name: "product_family"
      expr: product_family
      comment: "Product family grouping (e.g. Protection, Accumulation, Income). Enables executive-level portfolio roll-up reporting."
    - name: "distribution_channel_availability"
      expr: distribution_channel_availability
      comment: "Distribution channels through which the plan is available (e.g. Agent, Direct, Broker-Dealer). Used to assess channel strategy coverage."
    - name: "tax_qualification_status"
      expr: tax_qualification_status
      comment: "Tax qualification status of the plan (e.g. Qualified, Non-Qualified). Critical for regulatory and customer suitability segmentation."
    - name: "irc_7702_compliant"
      expr: irc_7702_compliant
      comment: "Whether the plan is IRC Section 7702 compliant. Regulatory compliance dimension for tax-advantaged product reporting."
    - name: "participating_product"
      expr: participating_product
      comment: "Indicates whether the plan is a participating product eligible for dividends. Differentiates mutual vs. non-participating product lines."
    - name: "naic_product_type_code"
      expr: naic_product_type_code
      comment: "NAIC standardized product type code. Used for regulatory reporting and industry benchmarking."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the plan became effective. Enables cohort analysis of product launches over time."
  measures:
    - name: "active_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'Active' THEN plan_id END)
      comment: "Number of currently active plans in the product portfolio. Core KPI for portfolio breadth and product lifecycle management."
    - name: "avg_profitability_target_irr"
      expr: AVG(CAST(profitability_target_irr AS DOUBLE))
      comment: "Average target Internal Rate of Return across all plans. Indicates whether the portfolio is priced to meet profitability thresholds; a decline signals pricing pressure or adverse product mix."
    - name: "total_maximum_face_amount_capacity"
      expr: SUM(CAST(maximum_face_amount AS DOUBLE))
      comment: "Sum of maximum face amounts across all plans. Represents the theoretical maximum insurance capacity the product portfolio can underwrite; used in capital adequacy and reinsurance planning."
    - name: "avg_minimum_premium_amount"
      expr: AVG(CAST(minimum_premium_amount AS DOUBLE))
      comment: "Average minimum premium amount across plans. Reflects the accessibility threshold of the product portfolio; lower values indicate broader market reach."
    - name: "avg_maximum_premium_amount"
      expr: AVG(CAST(maximum_premium_amount AS DOUBLE))
      comment: "Average maximum premium amount across plans. Indicates the upper premium capacity of the portfolio, relevant for high-net-worth and jumbo market strategy."
    - name: "avg_gpt_corridor_factor"
      expr: AVG(CAST(gpt_corridor_factor AS DOUBLE))
      comment: "Average Guideline Premium Test corridor factor across plans. A key IRC 7702 compliance parameter; deviations from expected ranges trigger actuarial and legal review."
    - name: "irc_7702_compliant_plan_count"
      expr: COUNT(CASE WHEN irc_7702_compliant = TRUE THEN plan_id END)
      comment: "Number of plans confirmed as IRC 7702 compliant. Directly measures regulatory compliance posture of the product portfolio."
    - name: "guaranteed_issue_plan_count"
      expr: COUNT(CASE WHEN guaranteed_issue = TRUE THEN plan_id END)
      comment: "Number of guaranteed issue plans requiring no underwriting. Measures the portfolio's exposure to adverse selection risk and accessibility strategy."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_plan_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product version lifecycle metrics tracking approval rates, version velocity, profitability targets, and compliance posture across plan versions. Used by Product Development, Actuarial, and Compliance teams to manage product change governance and version health."
  source: "`life_insurance_ecm`.`product`.`plan_version`"
  dimensions:
    - name: "version_status"
      expr: version_status
      comment: "Current status of the plan version (e.g. Active, Superseded, Pending Approval). Primary lifecycle filter."
    - name: "version_type"
      expr: version_type
      comment: "Type of version change (e.g. Rate Change, Form Change, Regulatory Update). Enables analysis of change driver patterns."
    - name: "approval_status"
      expr: approval_status
      comment: "Regulatory approval status of the version. Critical for tracking versions pending approval vs. approved and deployable."
    - name: "irc_7702_compliant"
      expr: irc_7702_compliant
      comment: "Whether this version is IRC 7702 compliant. Compliance segmentation for tax-qualified product versions."
    - name: "gpt_compliant"
      expr: gpt_compliant
      comment: "Whether this version passes the Guideline Premium Test. Key IRC 7702 sub-test compliance indicator."
    - name: "pbr_applicable"
      expr: pbr_applicable
      comment: "Whether Principle-Based Reserving applies to this version. Affects reserve methodology and capital requirements."
    - name: "mec_risk_indicator"
      expr: mec_risk_indicator
      comment: "Whether this version carries Modified Endowment Contract risk. MEC status has significant tax consequences for policyholders."
    - name: "closed_block_indicator"
      expr: closed_block_indicator
      comment: "Whether this version belongs to a closed block. Closed block versions require separate financial management and reporting."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the plan version became effective. Enables trend analysis of product version launches and regulatory approvals over time."
    - name: "approval_year"
      expr: DATE_TRUNC('YEAR', approval_date)
      comment: "Year the version received regulatory approval. Used to measure approval cycle time and regulatory throughput."
  measures:
    - name: "total_plan_version_count"
      expr: COUNT(1)
      comment: "Total number of plan versions across all plans. Measures product change velocity and version management complexity."
    - name: "active_version_count"
      expr: COUNT(CASE WHEN version_status = 'Active' THEN plan_version_id END)
      comment: "Number of currently active plan versions. Indicates the live product version footprint requiring ongoing maintenance and compliance monitoring."
    - name: "pending_approval_version_count"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN plan_version_id END)
      comment: "Number of plan versions awaiting regulatory approval. A high backlog signals regulatory pipeline risk and potential product launch delays."
    - name: "avg_profitability_target_irr"
      expr: AVG(CAST(profitability_target_irr AS DOUBLE))
      comment: "Average target IRR across plan versions. Tracks whether product repricing actions are maintaining or improving profitability targets over version generations."
    - name: "avg_expected_nbv_per_policy"
      expr: AVG(CAST(expected_nbv_per_policy AS DOUBLE))
      comment: "Average expected New Business Value per policy across versions. A primary value creation metric; declining NBV per policy signals deteriorating product economics."
    - name: "total_expected_nbv_per_policy"
      expr: SUM(CAST(expected_nbv_per_policy AS DOUBLE))
      comment: "Sum of expected NBV per policy across all versions in scope. Used as a portfolio-level value creation indicator when filtered to active versions."
    - name: "mec_risk_version_count"
      expr: COUNT(CASE WHEN mec_risk_indicator = TRUE THEN plan_version_id END)
      comment: "Number of plan versions carrying MEC risk. MEC-flagged versions require enhanced policyholder disclosure and carry tax consequence risk; executives monitor this to manage regulatory exposure."
    - name: "pbr_applicable_version_count"
      expr: COUNT(CASE WHEN pbr_applicable = TRUE THEN plan_version_id END)
      comment: "Number of versions subject to Principle-Based Reserving. PBR versions require more complex actuarial modeling; tracking this drives resource allocation for actuarial teams."
    - name: "avg_maximum_face_amount"
      expr: AVG(CAST(maximum_face_amount AS DOUBLE))
      comment: "Average maximum face amount across plan versions. Tracks how product capacity limits evolve across version generations, informing reinsurance treaty adequacy."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_underwriting_class`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Underwriting class performance and risk metrics covering mortality experience, profitability margins, reinsurance retention, and premium loading. Used by Actuarial, Underwriting, and Finance to evaluate risk segmentation quality and pricing adequacy by underwriting class."
  source: "`life_insurance_ecm`.`product`.`underwriting_class`"
  dimensions:
    - name: "underwriting_class_status"
      expr: underwriting_class_status
      comment: "Current status of the underwriting class (e.g. Active, Retired). Primary lifecycle filter for active risk segmentation analysis."
    - name: "class_category"
      expr: class_category
      comment: "Category of the underwriting class (e.g. Preferred, Standard, Substandard). Core risk tier dimension for mortality and profitability analysis."
    - name: "tobacco_status"
      expr: tobacco_status
      comment: "Tobacco use status associated with the class (e.g. Tobacco, Non-Tobacco). One of the most significant mortality risk differentiators in life insurance pricing."
    - name: "table_rating"
      expr: table_rating
      comment: "Table rating assigned to the class (e.g. Standard, Table B, Table D). Indicates degree of substandard risk and associated premium surcharge level."
    - name: "gender_specific_flag"
      expr: gender_specific_flag
      comment: "Whether the class applies gender-specific rates. Relevant for state compliance (some states prohibit gender-distinct pricing) and product design."
    - name: "reinsurance_eligible_flag"
      expr: reinsurance_eligible_flag
      comment: "Whether policies in this class are eligible for reinsurance. Drives reinsurance treaty utilization and net retention risk analysis."
    - name: "irc_7702_compliant_flag"
      expr: irc_7702_compliant_flag
      comment: "Whether the underwriting class structure is IRC 7702 compliant. Compliance dimension for tax-qualified product underwriting."
    - name: "principle_based_reserving_category"
      expr: principle_based_reserving_category
      comment: "PBR category assigned to the class. Determines reserve methodology and capital requirements for policies in this class."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the underwriting class became effective. Enables trend analysis of class introductions and risk segmentation evolution."
  measures:
    - name: "avg_experience_study_mortality_ratio"
      expr: AVG(CAST(experience_study_mortality_ratio AS DOUBLE))
      comment: "Average actual-to-expected mortality ratio from experience studies. The primary indicator of mortality experience vs. pricing assumptions; ratios above 1.0 signal adverse mortality requiring repricing or reserve strengthening."
    - name: "avg_mortality_loading_factor"
      expr: AVG(CAST(mortality_loading_factor AS DOUBLE))
      comment: "Average mortality loading factor applied to base mortality rates. Measures the risk margin embedded in pricing; declining factors may indicate competitive pressure eroding safety margins."
    - name: "avg_actual_profit_margin"
      expr: AVG(CAST(actual_profit_margin AS DOUBLE))
      comment: "Average actual profit margin realized across underwriting classes. Direct measure of underwriting profitability; classes with margins below target trigger actuarial review and potential repricing."
    - name: "avg_profitability_target_margin"
      expr: AVG(CAST(profitability_target_margin AS DOUBLE))
      comment: "Average target profit margin across underwriting classes. Benchmark for comparing actual vs. target profitability to identify classes underperforming their pricing assumptions."
    - name: "avg_premium_loading_percentage"
      expr: AVG(CAST(premium_loading_percentage AS DOUBLE))
      comment: "Average premium loading percentage applied to base rates. Indicates the aggregate risk surcharge level across the underwriting portfolio; used to assess competitive positioning vs. risk adequacy."
    - name: "avg_reinsurance_retention_limit"
      expr: AVG(CAST(reinsurance_retention_limit AS DOUBLE))
      comment: "Average net retention limit per life before ceding to reinsurers. A key capital management metric; lower retention limits indicate higher reinsurance dependency and cession costs."
    - name: "avg_cash_value_accumulation_test_factor"
      expr: AVG(CAST(cash_value_accumulation_test_factor AS DOUBLE))
      comment: "Average IRC 7702 Cash Value Accumulation Test factor across classes. Monitors compliance with the CVAT definition of life insurance; deviations risk MEC classification."
    - name: "avg_guideline_premium_test_factor"
      expr: AVG(CAST(guideline_premium_test_factor AS DOUBLE))
      comment: "Average Guideline Premium Test factor across underwriting classes. Tracks IRC 7702 GPT compliance parameters; used by actuarial teams to ensure products remain within tax-qualified limits."
    - name: "avg_face_amount_maximum"
      expr: AVG(CAST(face_amount_maximum AS DOUBLE))
      comment: "Average maximum face amount eligible per underwriting class. Indicates the risk capacity ceiling by class; used in reinsurance treaty sizing and capital allocation."
    - name: "reinsurance_eligible_class_count"
      expr: COUNT(CASE WHEN reinsurance_eligible_flag = TRUE THEN underwriting_class_id END)
      comment: "Number of underwriting classes eligible for reinsurance. Measures the breadth of reinsurance coverage across the risk segmentation structure."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_benefit_structure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit structure design metrics covering death benefit options, disability income parameters, living benefit availability, and nonforfeiture provisions. Used by Product Design, Actuarial, and Compliance to evaluate benefit richness, IRC compliance, and product feature coverage across the portfolio."
  source: "`life_insurance_ecm`.`product`.`benefit_structure`"
  dimensions:
    - name: "product_type"
      expr: product_type
      comment: "Product type associated with the benefit structure (e.g. Term, UL, VUL, DI). Primary segmentation for benefit design analysis."
    - name: "benefit_structure_status"
      expr: benefit_structure_status
      comment: "Current status of the benefit structure (e.g. Active, Retired). Lifecycle filter for active benefit design inventory."
    - name: "death_benefit_type"
      expr: death_benefit_type
      comment: "Type of death benefit (e.g. Level, Increasing, Return of Premium). Core product design dimension affecting mortality risk and pricing."
    - name: "death_benefit_option"
      expr: death_benefit_option
      comment: "Death benefit option (e.g. Option A Level, Option B Increasing). Determines how the death benefit interacts with cash value accumulation."
    - name: "cash_value_accumulation_method"
      expr: cash_value_accumulation_method
      comment: "Method used to accumulate cash value (e.g. Fixed, Indexed, Variable). Drives investment risk allocation between insurer and policyholder."
    - name: "irc_7702_compliant"
      expr: irc_7702_compliant
      comment: "Whether the benefit structure is IRC 7702 compliant. Regulatory compliance dimension for tax-advantaged life insurance benefit designs."
    - name: "irc_7702_test_type"
      expr: irc_7702_test_type
      comment: "IRC 7702 test type used (CVAT or GPT). Determines the compliance pathway and affects premium flexibility and benefit design constraints."
    - name: "gmib_available"
      expr: gmib_available
      comment: "Whether a Guaranteed Minimum Income Benefit is available. GMIB availability is a key competitive differentiator for annuity and UL products."
    - name: "gmwb_available"
      expr: gmwb_available
      comment: "Whether a Guaranteed Minimum Withdrawal Benefit is available. GMWB is a primary retirement income guarantee feature driving annuity product selection."
    - name: "ltc_acceleration_available"
      expr: ltc_acceleration_available
      comment: "Whether Long-Term Care acceleration of death benefit is available. LTC riders are a growing product feature with significant regulatory and actuarial implications."
  measures:
    - name: "active_benefit_structure_count"
      expr: COUNT(CASE WHEN benefit_structure_status = 'Active' THEN benefit_structure_id END)
      comment: "Number of active benefit structures in the product portfolio. Measures the breadth of benefit design inventory available for product configuration."
    - name: "avg_benefit_ceiling_value"
      expr: AVG(CAST(benefit_ceiling_value AS DOUBLE))
      comment: "Average maximum benefit ceiling across benefit structures. Indicates the upper bound of benefit exposure; used in liability modeling and reinsurance capacity planning."
    - name: "avg_benefit_floor_value"
      expr: AVG(CAST(benefit_floor_value AS DOUBLE))
      comment: "Average minimum guaranteed benefit floor. Measures the minimum benefit commitment embedded in product designs; higher floors increase guaranteed liability exposure."
    - name: "avg_di_monthly_benefit_maximum"
      expr: AVG(CAST(di_monthly_benefit_maximum AS DOUBLE))
      comment: "Average maximum monthly disability income benefit. Key DI product sizing metric used to assess benefit adequacy and claims liability exposure."
    - name: "avg_di_cola_rate_percent"
      expr: AVG(CAST(di_cola_rate_percent AS DOUBLE))
      comment: "Average Cost of Living Adjustment rate for DI benefits. COLA provisions increase long-term claims costs; monitoring average COLA rates informs DI reserve adequacy."
    - name: "gmib_available_count"
      expr: COUNT(CASE WHEN gmib_available = TRUE THEN benefit_structure_id END)
      comment: "Number of benefit structures offering GMIB. Tracks the portfolio's guaranteed income benefit footprint, a key competitive and liability management metric."
    - name: "gmwb_available_count"
      expr: COUNT(CASE WHEN gmwb_available = TRUE THEN benefit_structure_id END)
      comment: "Number of benefit structures offering GMWB. Measures guaranteed withdrawal benefit exposure across the product portfolio; critical for hedging program sizing."
    - name: "ltc_acceleration_available_count"
      expr: COUNT(CASE WHEN ltc_acceleration_available = TRUE THEN benefit_structure_id END)
      comment: "Number of benefit structures with LTC acceleration available. Tracks the portfolio's long-term care benefit exposure, which carries significant morbidity risk and regulatory requirements."
    - name: "irc_7702_compliant_structure_count"
      expr: COUNT(CASE WHEN irc_7702_compliant = TRUE THEN benefit_structure_id END)
      comment: "Number of benefit structures confirmed IRC 7702 compliant. Measures the tax-qualified benefit design compliance posture of the product portfolio."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_charge_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Charge schedule economics metrics covering current vs. guaranteed charge rates, profitability margins, free withdrawal provisions, and charge structure competitiveness. Used by Pricing, Product Management, and Finance to evaluate fee adequacy, competitive positioning, and revenue sustainability."
  source: "`life_insurance_ecm`.`product`.`charge_schedule`"
  dimensions:
    - name: "charge_schedule_status"
      expr: charge_schedule_status
      comment: "Current status of the charge schedule (e.g. Active, Expired, Superseded). Lifecycle filter for active fee structure analysis."
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge (e.g. M&E, Admin, Surrender, COI). Primary segmentation for fee revenue analysis by charge category."
    - name: "charge_basis"
      expr: charge_basis
      comment: "Basis on which the charge is calculated (e.g. Per Unit, Percent of AV, Flat). Determines how charge revenue scales with policy size and account value."
    - name: "charge_frequency"
      expr: charge_frequency
      comment: "Frequency at which the charge is assessed (e.g. Monthly, Annual, One-Time). Affects cash flow timing and policyholder cost recognition."
    - name: "competitive_positioning"
      expr: competitive_positioning
      comment: "Competitive positioning of the charge schedule (e.g. Below Market, At Market, Above Market). Strategic dimension for pricing committee review."
    - name: "gaap_revenue_recognition"
      expr: gaap_revenue_recognition
      comment: "GAAP revenue recognition method for the charge. Affects financial statement presentation and DAC amortization patterns."
    - name: "dac_tax_treatment"
      expr: dac_tax_treatment
      comment: "DAC tax treatment applied to the charge. Impacts deferred acquisition cost amortization and statutory tax calculations."
    - name: "mva_applicable_flag"
      expr: mva_applicable_flag
      comment: "Whether a Market Value Adjustment applies to this charge schedule. MVA provisions affect surrender charge economics and policyholder behavior modeling."
    - name: "irc_7702_compliant_flag"
      expr: irc_7702_compliant_flag
      comment: "Whether the charge schedule is IRC 7702 compliant. Compliance dimension ensuring charges do not cause policies to fail the definition of life insurance."
    - name: "state_jurisdiction"
      expr: state_jurisdiction
      comment: "State jurisdiction for which the charge schedule is approved. Enables state-level fee structure compliance and competitive analysis."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the charge schedule became effective. Enables trend analysis of fee structure changes and repricing actions over time."
  measures:
    - name: "avg_current_charge_rate"
      expr: AVG(CAST(current_charge_rate AS DOUBLE))
      comment: "Average current charge rate across active schedules. Primary fee level indicator; compared against guaranteed rates to assess pricing headroom and competitive positioning."
    - name: "avg_guaranteed_charge_rate"
      expr: AVG(CAST(guaranteed_charge_rate AS DOUBLE))
      comment: "Average guaranteed maximum charge rate. Represents the contractual ceiling on charges; the spread between current and guaranteed rates is a key pricing flexibility metric."
    - name: "avg_charge_rate_headroom"
      expr: AVG(CAST(guaranteed_charge_rate AS DOUBLE) - CAST(current_charge_rate AS DOUBLE))
      comment: "Average difference between guaranteed maximum and current charge rates. Measures pricing flexibility headroom; low headroom limits the company's ability to increase charges if experience deteriorates."
    - name: "avg_profitability_target_margin"
      expr: AVG(CAST(profitability_target_margin AS DOUBLE))
      comment: "Average target profit margin embedded in charge schedules. Tracks whether fee structures are designed to meet profitability objectives; declining margins signal competitive pricing pressure."
    - name: "avg_free_withdrawal_percentage"
      expr: AVG(CAST(free_withdrawal_percentage AS DOUBLE))
      comment: "Average free withdrawal percentage allowed without surrender charges. Higher free withdrawal provisions reduce surrender charge revenue and increase liquidity risk; monitored for product design adequacy."
    - name: "avg_charge_amount_flat"
      expr: AVG(CAST(charge_amount_flat AS DOUBLE))
      comment: "Average flat charge amount across schedules with flat fee structures. Used to assess the absolute fee burden on policyholders and compare against industry benchmarks."
    - name: "avg_charge_cap_amount"
      expr: AVG(CAST(charge_cap_amount AS DOUBLE))
      comment: "Average maximum charge cap amount. Charge caps limit fee revenue on large policies; monitoring average caps informs revenue modeling for high-face-amount business."
    - name: "mva_applicable_schedule_count"
      expr: COUNT(CASE WHEN mva_applicable_flag = TRUE THEN charge_schedule_id END)
      comment: "Number of charge schedules with Market Value Adjustment provisions. MVA schedules create interest rate sensitivity in surrender economics; tracked for ALM and policyholder behavior modeling."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_coi_rate_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost of Insurance rate schedule metrics covering mortality pricing levels, rate adjustment factors, and compliance posture. Used by Actuarial and Pricing to monitor COI rate adequacy, mortality table currency, and IRC 7702 compliance across the in-force and new business rate structures."
  source: "`life_insurance_ecm`.`product`.`coi_rate_schedule`"
  dimensions:
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of COI rate schedule (e.g. Current, Guaranteed Maximum, Illustrated). Distinguishes between contractual guarantees and current pricing levels."
    - name: "gender"
      expr: gender
      comment: "Gender classification for the COI rate (Male, Female, Unisex). Key mortality pricing dimension; unisex rates required in some states."
    - name: "tobacco_status"
      expr: tobacco_status
      comment: "Tobacco use status for the COI rate (Tobacco, Non-Tobacco). One of the largest mortality risk differentiators in COI pricing."
    - name: "mortality_table_basis"
      expr: mortality_table_basis
      comment: "Mortality table used as the basis for COI rates (e.g. 2001 CSO, 2017 CSO). Indicates the currency of mortality assumptions; older tables may be inadequate for current mortality experience."
    - name: "is_guaranteed_maximum"
      expr: is_guaranteed_maximum
      comment: "Whether this schedule represents guaranteed maximum COI rates. Guaranteed rates define the contractual ceiling on mortality charges."
    - name: "is_current_rate"
      expr: is_current_rate
      comment: "Whether this schedule represents currently charged COI rates. Distinguishes active pricing from historical or guaranteed schedules."
    - name: "irc_7702_compliant"
      expr: irc_7702_compliant
      comment: "Whether the COI rate schedule is IRC 7702 compliant. COI rates must not exceed the IRC 7702 mortality charge limits to maintain tax-qualified status."
    - name: "profitability_tier"
      expr: profitability_tier
      comment: "Profitability tier assigned to the rate schedule. Enables analysis of COI rate adequacy by profitability segment."
    - name: "state_approval_jurisdiction"
      expr: state_approval_jurisdiction
      comment: "State jurisdiction where the COI rate schedule is approved. Enables state-level COI rate compliance and competitive analysis."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the COI rate schedule became effective. Enables trend analysis of mortality pricing changes over time."
  measures:
    - name: "avg_rate_per_thousand_nar"
      expr: AVG(CAST(rate_per_thousand_nar AS DOUBLE))
      comment: "Average COI rate per thousand dollars of Net Amount at Risk. The primary mortality pricing metric; increases indicate adverse mortality experience or repricing actions."
    - name: "avg_rate_adjustment_factor"
      expr: AVG(CAST(rate_adjustment_factor AS DOUBLE))
      comment: "Average rate adjustment factor applied to base mortality rates. Factors above 1.0 indicate mortality surcharges; monitoring trends reveals experience deterioration or competitive repricing."
    - name: "current_rate_schedule_count"
      expr: COUNT(CASE WHEN is_current_rate = TRUE THEN coi_rate_schedule_id END)
      comment: "Number of currently active COI rate schedules. Measures the complexity of the active mortality pricing structure across the product portfolio."
    - name: "guaranteed_maximum_schedule_count"
      expr: COUNT(CASE WHEN is_guaranteed_maximum = TRUE THEN coi_rate_schedule_id END)
      comment: "Number of guaranteed maximum COI rate schedules. Guaranteed schedules define contractual mortality charge ceilings; tracking their count ensures complete coverage of contractual obligations."
    - name: "irc_7702_compliant_schedule_count"
      expr: COUNT(CASE WHEN irc_7702_compliant = TRUE THEN coi_rate_schedule_id END)
      comment: "Number of COI rate schedules confirmed IRC 7702 compliant. Measures the compliance posture of the mortality pricing structure; non-compliant schedules risk policy disqualification."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_crediting_strategy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crediting strategy economics metrics covering declared rates, participation rates, caps, floors, spreads, and guaranteed minimums for fixed, indexed, and variable crediting strategies. Used by Product Management, ALM, and Finance to monitor credited rate competitiveness, hedging cost alignment, and guaranteed rate exposure."
  source: "`life_insurance_ecm`.`product`.`crediting_strategy`"
  dimensions:
    - name: "strategy_type"
      expr: strategy_type
      comment: "Type of crediting strategy (e.g. Fixed, Indexed, Variable). Primary segmentation for investment risk and ALM analysis."
    - name: "crediting_method"
      expr: crediting_method
      comment: "Method used to credit interest (e.g. Annual Point-to-Point, Monthly Average, Daily Average). Determines how index performance translates to policyholder credits."
    - name: "index_type"
      expr: index_type
      comment: "Underlying index for indexed crediting strategies (e.g. S&P 500, MSCI, Bloomberg US Aggregate). Drives hedging instrument selection and basis risk."
    - name: "strategy_availability_status"
      expr: strategy_availability_status
      comment: "Current availability status of the crediting strategy (e.g. Available, Closed, Discontinued). Lifecycle filter for active strategy analysis."
    - name: "reset_frequency"
      expr: reset_frequency
      comment: "Frequency at which crediting parameters reset (e.g. Annual, Monthly). Affects policyholder behavior, lapse risk, and hedging program design."
    - name: "target_market_segment"
      expr: target_market_segment
      comment: "Target market segment for the crediting strategy (e.g. Conservative, Moderate, Aggressive). Enables product design alignment with customer risk profiles."
    - name: "irc_7702_compliant_flag"
      expr: irc_7702_compliant_flag
      comment: "Whether the crediting strategy is IRC 7702 compliant. Credited rates must not cause policies to fail the definition of life insurance."
    - name: "renewal_rate_adjustment_flag"
      expr: renewal_rate_adjustment_flag
      comment: "Whether renewal rate adjustments are permitted. Renewal rate flexibility is critical for managing credited rate competitiveness and spread income."
    - name: "state_approval_jurisdiction"
      expr: state_approval_jurisdiction
      comment: "State jurisdiction where the crediting strategy is approved. Enables state-level credited rate compliance analysis."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the crediting strategy became effective. Enables trend analysis of credited rate parameter changes over time."
  measures:
    - name: "avg_declared_rate"
      expr: AVG(CAST(declared_rate AS DOUBLE))
      comment: "Average declared crediting rate across active strategies. Primary competitiveness metric for fixed and indexed products; compared against competitor rates and new money yields."
    - name: "avg_guaranteed_minimum_rate"
      expr: AVG(CAST(guaranteed_minimum_rate AS DOUBLE))
      comment: "Average guaranteed minimum crediting rate. Represents the floor on investment returns guaranteed to policyholders; a key liability metric for ALM and reserve adequacy."
    - name: "avg_spread_over_guaranteed_minimum"
      expr: AVG(CAST(declared_rate AS DOUBLE) - CAST(guaranteed_minimum_rate AS DOUBLE))
      comment: "Average spread between declared rate and guaranteed minimum rate. Measures the buffer above guaranteed floors; declining spreads signal reduced ability to lower rates if investment yields fall."
    - name: "avg_cap_rate"
      expr: AVG(CAST(cap_rate AS DOUBLE))
      comment: "Average cap rate on indexed crediting strategies. Cap rates limit policyholder upside and reduce hedging costs; monitoring trends reveals competitive positioning and hedging budget changes."
    - name: "avg_participation_rate"
      expr: AVG(CAST(participation_rate AS DOUBLE))
      comment: "Average participation rate in index performance. Participation rates determine how much of index gains are credited to policyholders; a key product competitiveness and hedging cost driver."
    - name: "avg_spread_rate"
      expr: AVG(CAST(spread_rate AS DOUBLE))
      comment: "Average spread deducted from index performance before crediting. Spread rates are an alternative to caps for limiting policyholder credits; monitoring ensures competitive and hedging cost alignment."
    - name: "avg_floor_rate"
      expr: AVG(CAST(floor_rate AS DOUBLE))
      comment: "Average floor rate protecting policyholders from negative index returns. Floor rates above zero (e.g. 0%) reduce downside risk for policyholders but increase hedging costs."
    - name: "avg_illustration_rate"
      expr: AVG(CAST(illustration_rate AS DOUBLE))
      comment: "Average illustration rate used in policy illustrations. Illustration rates must comply with regulatory maximums; rates significantly above historical averages create suitability and regulatory risk."
    - name: "avg_historical_average_credit_rate"
      expr: AVG(CAST(historical_average_credit_rate AS DOUBLE))
      comment: "Average historical credited rate across strategies. Provides context for illustration rate reasonableness and policyholder expectation management."
    - name: "avg_buffer_rate"
      expr: AVG(CAST(buffer_rate AS DOUBLE))
      comment: "Average buffer rate absorbing index losses before policyholder impact. Buffer rates are a key differentiator for buffered annuity products; higher buffers increase hedging costs."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_premium_rate_table`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium rate table metrics covering COI rates, modal factors, table rating factors, and face amount band economics. Used by Actuarial and Pricing to monitor rate adequacy, rate table currency, and pricing structure across the product portfolio."
  source: "`life_insurance_ecm`.`product`.`premium_rate_table`"
  dimensions:
    - name: "rate_table_status"
      expr: rate_table_status
      comment: "Current status of the rate table (e.g. Active, Expired, Superseded). Lifecycle filter for active pricing structure analysis."
    - name: "rate_type"
      expr: rate_type
      comment: "Type of rate in the table (e.g. COI, Premium, Annuity). Primary segmentation for rate adequacy analysis by rate category."
    - name: "rate_schedule_type"
      expr: rate_schedule_type
      comment: "Schedule type (e.g. Current, Guaranteed, Illustrated). Distinguishes contractual guarantees from current pricing levels."
    - name: "gender"
      expr: gender
      comment: "Gender classification for the rate (Male, Female, Unisex). Key mortality pricing dimension."
    - name: "tobacco_status"
      expr: tobacco_status
      comment: "Tobacco use status for the rate (Tobacco, Non-Tobacco). Major mortality risk differentiator in premium pricing."
    - name: "mortality_table_basis"
      expr: mortality_table_basis
      comment: "Mortality table underlying the rate (e.g. 2001 CSO, 2017 CSO). Indicates the currency of mortality assumptions used in pricing."
    - name: "payment_mode"
      expr: payment_mode
      comment: "Premium payment mode (e.g. Annual, Semi-Annual, Monthly). Affects modal factor application and cash flow timing."
    - name: "guaranteed_flag"
      expr: guaranteed_flag
      comment: "Whether the rate is a guaranteed rate. Guaranteed rates define contractual pricing commitments that cannot be increased."
    - name: "irc_7702_compliant_flag"
      expr: irc_7702_compliant_flag
      comment: "Whether the rate table is IRC 7702 compliant. Ensures premium rates do not cause policies to exceed the definition of life insurance limits."
    - name: "state_jurisdiction"
      expr: state_jurisdiction
      comment: "State jurisdiction for which the rate table is approved. Enables state-level rate adequacy and compliance analysis."
    - name: "rate_effective_year"
      expr: DATE_TRUNC('YEAR', rate_effective_date)
      comment: "Year the rate table became effective. Enables trend analysis of premium rate changes and repricing actions."
  measures:
    - name: "avg_rate_per_unit"
      expr: AVG(CAST(rate_per_unit AS DOUBLE))
      comment: "Average premium rate per unit of coverage. Primary pricing level metric; compared against competitor rates and experience to assess rate adequacy."
    - name: "avg_coi_rate_per_thousand"
      expr: AVG(CAST(coi_rate_per_thousand AS DOUBLE))
      comment: "Average COI rate per thousand dollars of coverage. Core mortality pricing metric; increases signal adverse mortality experience or proactive repricing."
    - name: "avg_modal_factor"
      expr: AVG(CAST(modal_factor AS DOUBLE))
      comment: "Average modal factor applied to annual premium for non-annual payment modes. Modal factors generate additional revenue; monitoring ensures competitive and actuarially sound modal pricing."
    - name: "avg_table_rating_factor"
      expr: AVG(CAST(table_rating_factor AS DOUBLE))
      comment: "Average table rating factor applied to standard rates for substandard risks. Higher average factors indicate a more substandard risk mix; used to assess underwriting quality and adverse selection."
    - name: "avg_flat_extra_amount"
      expr: AVG(CAST(flat_extra_amount AS DOUBLE))
      comment: "Average flat extra premium amount for substandard risks. Flat extras are charged for specific occupational or avocational hazards; monitoring average levels tracks substandard risk pricing adequacy."
    - name: "avg_face_amount_band_max"
      expr: AVG(CAST(face_amount_band_max AS DOUBLE))
      comment: "Average maximum face amount in rate table bands. Indicates the upper coverage tier structure of the pricing architecture; used in reinsurance treaty alignment."
    - name: "guaranteed_rate_table_count"
      expr: COUNT(CASE WHEN guaranteed_flag = TRUE THEN premium_rate_table_id END)
      comment: "Number of guaranteed rate tables. Guaranteed tables define contractual pricing commitments; tracking their count ensures complete coverage of guaranteed pricing obligations."
    - name: "active_rate_table_count"
      expr: COUNT(CASE WHEN rate_table_status = 'Active' THEN premium_rate_table_id END)
      comment: "Number of currently active rate tables. Measures the complexity of the active pricing structure; high counts may indicate rate table proliferation requiring rationalization."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_rate_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate action metrics tracking the frequency, magnitude, financial impact, and policyholder communication of rate changes across the product portfolio. Used by Pricing, Actuarial, and Executive leadership to monitor repricing activity, financial impact of rate actions, and regulatory compliance with rate change notifications."
  source: "`life_insurance_ecm`.`product`.`rate_action`"
  dimensions:
    - name: "rate_action_type"
      expr: rate_action_type
      comment: "Type of rate action (e.g. COI Increase, Credited Rate Change, Charge Adjustment). Primary segmentation for rate action impact analysis."
    - name: "rate_action_status"
      expr: rate_action_status
      comment: "Current status of the rate action (e.g. Approved, Pending, Implemented, Withdrawn). Lifecycle filter for active rate action pipeline management."
    - name: "rate_change_direction"
      expr: rate_change_direction
      comment: "Direction of the rate change (Increase, Decrease, No Change). Critical dimension for policyholder impact and regulatory notification analysis."
    - name: "state_jurisdiction"
      expr: state_jurisdiction
      comment: "State jurisdiction affected by the rate action. Enables state-level rate action compliance and impact analysis."
    - name: "guaranteed_rate_flag"
      expr: guaranteed_rate_flag
      comment: "Whether the rate action affects guaranteed rates. Rate actions on guaranteed rates have contractual implications and require heightened regulatory scrutiny."
    - name: "irc_7702_impact_flag"
      expr: irc_7702_impact_flag
      comment: "Whether the rate action has IRC 7702 compliance implications. Rate actions with 7702 impact require actuarial certification and may affect policy tax status."
    - name: "reinsurance_impact_flag"
      expr: reinsurance_impact_flag
      comment: "Whether the rate action impacts reinsurance treaties. Reinsurance-impacted rate actions require treaty renegotiation or notification."
    - name: "opt_out_available_flag"
      expr: opt_out_available_flag
      comment: "Whether policyholders have an opt-out option for the rate action. Opt-out provisions affect lapse risk modeling and financial impact estimates."
    - name: "state_notification_required_flag"
      expr: state_notification_required_flag
      comment: "Whether state regulatory notification is required for the rate action. Tracks regulatory compliance obligations associated with rate changes."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the rate action became effective. Enables trend analysis of repricing activity and financial impact over time."
    - name: "announcement_year"
      expr: DATE_TRUNC('YEAR', announcement_date)
      comment: "Year the rate action was announced. Used to measure lead time between announcement and effective date for policyholder communication planning."
  measures:
    - name: "total_rate_action_count"
      expr: COUNT(1)
      comment: "Total number of rate actions. Measures repricing activity volume; high counts may indicate deteriorating experience or competitive pressure requiring frequent adjustments."
    - name: "avg_average_rate_change_percent"
      expr: AVG(CAST(average_rate_change_percent AS DOUBLE))
      comment: "Average rate change percentage across all rate actions. Primary magnitude metric for repricing activity; large average changes signal significant experience deterioration or competitive repositioning."
    - name: "total_financial_impact_estimate"
      expr: SUM(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Total estimated financial impact of rate actions. Aggregates the projected revenue or cost impact of all rate changes; a primary metric for pricing committee and CFO review."
    - name: "avg_financial_impact_estimate"
      expr: AVG(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Average financial impact per rate action. Measures the typical magnitude of individual rate actions; used to prioritize high-impact repricing decisions."
    - name: "total_impacted_face_amount"
      expr: SUM(CAST(impacted_face_amount_total AS DOUBLE))
      comment: "Total face amount impacted by rate actions. Measures the aggregate insurance exposure affected by repricing; used to assess the breadth of rate action impact on the in-force block."
    - name: "irc_7702_impacted_action_count"
      expr: COUNT(CASE WHEN irc_7702_impact_flag = TRUE THEN rate_action_id END)
      comment: "Number of rate actions with IRC 7702 compliance implications. Tracks the volume of rate changes requiring actuarial certification and potential policy tax status review."
    - name: "rate_increase_action_count"
      expr: COUNT(CASE WHEN rate_change_direction = 'Increase' THEN rate_action_id END)
      comment: "Number of rate increase actions. A rising count of rate increases signals deteriorating product economics and potential policyholder retention risk."
    - name: "reinsurance_impacted_action_count"
      expr: COUNT(CASE WHEN reinsurance_impact_flag = TRUE THEN rate_action_id END)
      comment: "Number of rate actions impacting reinsurance treaties. Tracks the volume of rate changes requiring reinsurer notification or treaty renegotiation."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product filing pipeline metrics covering filing volumes, approval rates, review cycle times, fee expenditures, and regulatory objection patterns. Used by Regulatory Affairs, Product Development, and Compliance to manage the state filing pipeline, track approval efficiency, and monitor regulatory risk."
  source: "`life_insurance_ecm`.`product`.`filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing (e.g. Pending, Approved, Objected, Withdrawn, Rejected). Primary lifecycle filter for filing pipeline management."
    - name: "filing_type"
      expr: filing_type
      comment: "Type of filing (e.g. New Product, Rate Change, Form Amendment, Rider). Segmentation for filing volume and approval rate analysis by filing category."
    - name: "filing_method"
      expr: filing_method
      comment: "Method used to submit the filing (e.g. SERFF, Paper, Electronic). Enables analysis of filing efficiency by submission channel."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the filing (e.g. High, Medium, Low). Used to manage regulatory affairs workload and escalation decisions."
    - name: "irc_7702_compliance_certification"
      expr: irc_7702_compliance_certification
      comment: "Whether the filing includes an IRC 7702 compliance certification. Tracks the volume of filings requiring actuarial tax compliance certification."
    - name: "sec_registration_required"
      expr: sec_registration_required
      comment: "Whether SEC registration is required for the filed product. SEC-registered products require additional disclosure and prospectus filing obligations."
    - name: "filing_year"
      expr: DATE_TRUNC('YEAR', filing_date)
      comment: "Year the filing was submitted. Enables trend analysis of filing volume and approval rates over time."
    - name: "approval_year"
      expr: DATE_TRUNC('YEAR', approval_date)
      comment: "Year the filing received approval. Used to measure regulatory approval throughput and cycle time trends."
  measures:
    - name: "total_filing_count"
      expr: COUNT(1)
      comment: "Total number of product filings. Measures regulatory affairs workload and product development activity volume."
    - name: "approved_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'Approved' THEN filing_id END)
      comment: "Number of approved filings. Primary throughput metric for the regulatory filing pipeline; low approval counts signal regulatory bottlenecks or product design issues."
    - name: "pending_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'Pending' THEN filing_id END)
      comment: "Number of filings currently pending regulatory review. Measures the active regulatory pipeline backlog; high pending counts delay product launches and revenue generation."
    - name: "objected_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'Objected' THEN filing_id END)
      comment: "Number of filings that received regulatory objections. Objections indicate product design or compliance issues; high objection rates signal systemic filing quality problems."
    - name: "total_filing_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total regulatory filing fees paid. Measures the direct cost of the state filing program; used in product launch cost-benefit analysis and regulatory affairs budget management."
    - name: "avg_filing_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average regulatory filing fee per filing. Benchmarks filing cost efficiency; significant increases may indicate new state fee schedules requiring budget adjustment."
    - name: "irc_7702_certified_filing_count"
      expr: COUNT(CASE WHEN irc_7702_compliance_certification = TRUE THEN filing_id END)
      comment: "Number of filings with IRC 7702 compliance certification. Tracks the volume of filings requiring actuarial tax compliance sign-off, informing actuarial resource planning."
    - name: "withdrawn_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'Withdrawn' THEN filing_id END)
      comment: "Number of withdrawn filings. Withdrawn filings represent sunk regulatory costs without product launch benefit; high withdrawal rates signal product development or regulatory strategy issues."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_state_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "State approval coverage metrics tracking the geographic footprint of approved products, approval conditions, and compliance requirements by state. Used by Regulatory Affairs and Product Management to monitor state market access, identify approval gaps, and manage state-specific product restrictions."
  source: "`life_insurance_ecm`.`product`.`state_approval`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the state approval filing (e.g. Approved, Pending, Withdrawn). Primary lifecycle filter for state approval pipeline analysis."
    - name: "filing_type"
      expr: filing_type
      comment: "Type of state filing (e.g. New Product, Rate Change, Form Amendment). Segmentation for approval analysis by filing category."
    - name: "irc_7702_compliance_confirmed"
      expr: irc_7702_compliance_confirmed
      comment: "Whether IRC 7702 compliance has been confirmed for this state approval. Tracks state-level tax compliance confirmation status."
    - name: "finra_review_required"
      expr: finra_review_required
      comment: "Whether FINRA review is required for this state approval. FINRA-reviewed products require additional securities compliance oversight."
    - name: "sec_filing_required"
      expr: sec_filing_required
      comment: "Whether an SEC filing is required for this state approval. SEC-required approvals involve additional federal regulatory obligations."
    - name: "replacement_regulations_apply"
      expr: replacement_regulations_apply
      comment: "Whether replacement regulations apply to this state approval. Replacement regulations impose additional disclosure and suitability requirements."
    - name: "illustration_actuary_certification_required"
      expr: illustration_actuary_certification_required
      comment: "Whether actuarial certification of illustrations is required by the state. Tracks states with enhanced illustration compliance requirements."
    - name: "policy_loan_provisions_approved"
      expr: policy_loan_provisions_approved
      comment: "Whether policy loan provisions are approved in this state. Policy loan approval status affects product feature availability by state."
    - name: "approval_year"
      expr: DATE_TRUNC('YEAR', approval_date)
      comment: "Year the state approval was granted. Enables trend analysis of state approval throughput and geographic expansion over time."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the state approval became effective. Tracks when approved products became available for sale in each state."
  measures:
    - name: "total_state_approval_count"
      expr: COUNT(1)
      comment: "Total number of state approvals across all products and states. Measures the breadth of the geographic product approval footprint."
    - name: "approved_state_count"
      expr: COUNT(CASE WHEN filing_status = 'Approved' THEN state_approval_id END)
      comment: "Number of approved state filings. Primary metric for geographic market access; directly determines where products can be sold."
    - name: "pending_state_approval_count"
      expr: COUNT(CASE WHEN filing_status = 'Pending' THEN state_approval_id END)
      comment: "Number of state approvals currently pending. Measures the active state approval pipeline; pending approvals represent potential market expansion opportunities."
    - name: "avg_maximum_face_amount_approved"
      expr: AVG(CAST(maximum_face_amount AS DOUBLE))
      comment: "Average maximum face amount approved by states. State-imposed face amount limits constrain product capacity; monitoring average limits informs market segmentation strategy."
    - name: "avg_minimum_face_amount_approved"
      expr: AVG(CAST(minimum_face_amount AS DOUBLE))
      comment: "Average minimum face amount required by states. State minimum face amount requirements affect product accessibility and market reach."
    - name: "irc_7702_confirmed_approval_count"
      expr: COUNT(CASE WHEN irc_7702_compliance_confirmed = TRUE THEN state_approval_id END)
      comment: "Number of state approvals with confirmed IRC 7702 compliance. Measures the geographic scope of tax-qualified product compliance confirmation."
    - name: "finra_review_required_count"
      expr: COUNT(CASE WHEN finra_review_required = TRUE THEN state_approval_id END)
      comment: "Number of state approvals requiring FINRA review. Tracks the volume of securities-regulated product approvals requiring additional compliance oversight."
    - name: "replacement_regulation_applicable_count"
      expr: COUNT(CASE WHEN replacement_regulations_apply = TRUE THEN state_approval_id END)
      comment: "Number of state approvals where replacement regulations apply. Replacement regulation requirements increase sales compliance burden; tracking by state informs agent training and supervision needs."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_rider_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rider definition portfolio metrics covering benefit amounts, compliance status, underwriting requirements, and feature availability across the rider catalog. Used by Product Management, Actuarial, and Compliance to evaluate rider portfolio breadth, pricing adequacy, and regulatory compliance."
  source: "`life_insurance_ecm`.`product`.`rider_definition`"
  dimensions:
    - name: "rider_definition_status"
      expr: rider_definition_status
      comment: "Current status of the rider definition (e.g. Active, Retired, Pending). Lifecycle filter for active rider catalog analysis."
    - name: "rider_type"
      expr: rider_type
      comment: "Type of rider (e.g. Waiver of Premium, Accidental Death, LTC, GMIB). Primary segmentation for rider portfolio composition analysis."
    - name: "rider_category"
      expr: rider_category
      comment: "Category of the rider (e.g. Protection, Living Benefit, Income). Enables executive-level rider portfolio roll-up reporting."
    - name: "irc_7702_compliant"
      expr: irc_7702_compliant
      comment: "Whether the rider is IRC 7702 compliant. Rider charges must not cause the base policy to fail the definition of life insurance."
    - name: "ltc_qualified_flag"
      expr: ltc_qualified_flag
      comment: "Whether the rider qualifies as a Long-Term Care benefit under IRC Section 7702B. LTC-qualified riders provide tax-advantaged benefits and require specific regulatory compliance."
    - name: "accelerated_benefit_flag"
      expr: accelerated_benefit_flag
      comment: "Whether the rider provides an accelerated death benefit. Accelerated benefit riders have specific regulatory disclosure and tax treatment requirements."
    - name: "guaranteed_insurability_flag"
      expr: guaranteed_insurability_flag
      comment: "Whether the rider provides guaranteed insurability options. GI riders create future underwriting risk exposure that must be reserved for."
    - name: "waiver_of_premium_flag"
      expr: waiver_of_premium_flag
      comment: "Whether the rider provides waiver of premium benefit. WOP riders create disability-linked premium liability exposure."
    - name: "reinsurance_treaty_applicable"
      expr: reinsurance_treaty_applicable
      comment: "Whether a reinsurance treaty applies to this rider. Tracks rider-level reinsurance coverage for net retention risk management."
    - name: "medical_evidence_required"
      expr: medical_evidence_required
      comment: "Whether medical evidence is required to add this rider. Affects rider take-up rates and adverse selection risk."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the rider definition became effective. Enables trend analysis of rider catalog expansion and product feature evolution."
  measures:
    - name: "active_rider_count"
      expr: COUNT(CASE WHEN rider_definition_status = 'Active' THEN rider_definition_id END)
      comment: "Number of active rider definitions in the product catalog. Measures the breadth of the living and protection benefit feature set available to policyholders."
    - name: "avg_maximum_benefit_amount"
      expr: AVG(CAST(maximum_benefit_amount AS DOUBLE))
      comment: "Average maximum benefit amount across rider definitions. Indicates the upper bound of rider benefit exposure; used in liability modeling and reinsurance capacity planning."
    - name: "avg_minimum_benefit_amount"
      expr: AVG(CAST(minimum_benefit_amount AS DOUBLE))
      comment: "Average minimum benefit amount across rider definitions. Reflects the minimum benefit commitment embedded in rider designs; used in product accessibility and pricing analysis."
    - name: "ltc_qualified_rider_count"
      expr: COUNT(CASE WHEN ltc_qualified_flag = TRUE THEN rider_definition_id END)
      comment: "Number of LTC-qualified riders in the catalog. Measures the portfolio's long-term care benefit offering breadth; a growing strategic priority for aging population markets."
    - name: "irc_7702_compliant_rider_count"
      expr: COUNT(CASE WHEN irc_7702_compliant = TRUE THEN rider_definition_id END)
      comment: "Number of IRC 7702 compliant rider definitions. Measures the tax-qualified compliance posture of the rider catalog."
    - name: "accelerated_benefit_rider_count"
      expr: COUNT(CASE WHEN accelerated_benefit_flag = TRUE THEN rider_definition_id END)
      comment: "Number of riders providing accelerated death benefits. Tracks the portfolio's living benefit feature footprint, a key competitive differentiator in the life insurance market."
    - name: "reinsurance_applicable_rider_count"
      expr: COUNT(CASE WHEN reinsurance_treaty_applicable = TRUE THEN rider_definition_id END)
      comment: "Number of riders covered by reinsurance treaties. Measures the reinsurance coverage breadth across the rider catalog; uncovered riders represent net retention risk."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_separate_account_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Separate account fund metrics covering expense ratios, allocation limits, fund availability, and investment characteristics for variable life and annuity products. Used by Product Management, Investment, and Compliance to monitor fund lineup competitiveness, cost efficiency, and regulatory compliance."
  source: "`life_insurance_ecm`.`product`.`separate_account_fund`"
  dimensions:
    - name: "fund_status"
      expr: fund_status
      comment: "Current status of the fund (e.g. Available, Closed, Discontinued). Primary lifecycle filter for active fund lineup analysis."
    - name: "availability_status"
      expr: availability_status
      comment: "Availability status of the fund for new allocations. Distinguishes funds open to new money from those closed to new investments."
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class of the fund (e.g. Equity, Fixed Income, Balanced, Money Market). Primary investment segmentation dimension for fund lineup analysis."
    - name: "investment_style"
      expr: investment_style
      comment: "Investment style of the fund (e.g. Growth, Value, Blend, Index). Enables analysis of fund lineup style diversification."
    - name: "morningstar_category"
      expr: morningstar_category
      comment: "Morningstar category classification. Industry-standard fund categorization used for competitive benchmarking and fund lineup analysis."
    - name: "morningstar_rating"
      expr: morningstar_rating
      comment: "Morningstar star rating (1-5 stars). Quality indicator for fund lineup; low-rated funds may require replacement to maintain competitive product positioning."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the fund. Enables suitability analysis and fund lineup risk profile assessment."
    - name: "product_line"
      expr: product_line
      comment: "Product line to which the fund is available (e.g. Variable UL, Variable Annuity). Enables fund lineup analysis by product type."
    - name: "fund_family"
      expr: fund_family
      comment: "Fund family or investment manager. Enables analysis of fund manager concentration and diversification in the fund lineup."
    - name: "rebalancing_eligible_flag"
      expr: rebalancing_eligible_flag
      comment: "Whether the fund is eligible for automatic rebalancing. Rebalancing eligibility is a key product feature for retirement-focused variable products."
    - name: "transfer_restriction_flag"
      expr: transfer_restriction_flag
      comment: "Whether transfer restrictions apply to the fund. Transfer restrictions affect policyholder flexibility and may impact product competitiveness."
    - name: "inception_year"
      expr: DATE_TRUNC('YEAR', inception_date)
      comment: "Year the fund was incepted. Enables analysis of fund lineup vintage and track record length."
  measures:
    - name: "active_fund_count"
      expr: COUNT(CASE WHEN fund_status = 'Available' THEN separate_account_fund_id END)
      comment: "Number of available funds in the separate account lineup. Measures the breadth of investment options offered to policyholders; a key competitive differentiator for variable products."
    - name: "avg_expense_ratio_percent"
      expr: AVG(CAST(expense_ratio_percent AS DOUBLE))
      comment: "Average fund expense ratio across the separate account lineup. Primary cost efficiency metric for the fund lineup; high average expense ratios reduce policyholder net returns and competitive positioning."
    - name: "avg_mortality_expense_charge_percent"
      expr: AVG(CAST(mortality_expense_charge_percent AS DOUBLE))
      comment: "Average mortality and expense charge percentage across funds. M&E charges are a primary revenue source for variable products; monitoring ensures competitive pricing and adequate profitability."
    - name: "avg_total_fund_cost"
      expr: AVG(CAST(expense_ratio_percent AS DOUBLE) + CAST(mortality_expense_charge_percent AS DOUBLE))
      comment: "Average total fund cost (expense ratio plus M&E charge) as a percentage. Represents the all-in cost to policyholders for fund investments; a key competitive and suitability metric."
    - name: "avg_maximum_allocation_percent"
      expr: AVG(CAST(maximum_allocation_percent AS DOUBLE))
      comment: "Average maximum allocation percentage per fund. Allocation limits control concentration risk; monitoring average limits ensures adequate diversification requirements are in place."
    - name: "avg_minimum_initial_investment_amount"
      expr: AVG(CAST(minimum_initial_investment_amount AS DOUBLE))
      comment: "Average minimum initial investment amount per fund. Higher minimums reduce product accessibility; monitoring ensures the fund lineup serves the target market segment."
    - name: "closed_to_new_fund_count"
      expr: COUNT(CASE WHEN closed_to_new_date IS NOT NULL THEN separate_account_fund_id END)
      comment: "Number of funds closed to new investments. A rising count of closed funds signals fund lineup deterioration requiring replacement with competitive alternatives."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_suitability_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Suitability rule metrics covering financial eligibility thresholds, risk tolerance requirements, and regulatory framework compliance across the product suitability framework. Used by Compliance, Distribution, and Product Management to monitor suitability rule coverage, financial threshold adequacy, and best interest obligation compliance."
  source: "`life_insurance_ecm`.`product`.`suitability_rule`"
  dimensions:
    - name: "rule_status"
      expr: rule_status
      comment: "Current status of the suitability rule (e.g. Active, Expired, Superseded). Lifecycle filter for active suitability framework analysis."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the suitability rule (e.g. NAIC Model, SEC Reg BI, DOL Fiduciary). Primary compliance segmentation dimension."
    - name: "best_interest_obligation_level"
      expr: best_interest_obligation_level
      comment: "Level of best interest obligation required (e.g. Suitability, Best Interest, Fiduciary). Tracks the regulatory standard applied to product sales."
    - name: "product_complexity_classification"
      expr: product_complexity_classification
      comment: "Complexity classification of the product (e.g. Simple, Moderate, Complex). Higher complexity products require more stringent suitability standards."
    - name: "risk_tolerance_required"
      expr: risk_tolerance_required
      comment: "Minimum risk tolerance required for product suitability (e.g. Conservative, Moderate, Aggressive). Ensures products are sold to appropriately risk-tolerant customers."
    - name: "senior_investor_protection_flag"
      expr: senior_investor_protection_flag
      comment: "Whether enhanced senior investor protections apply. Senior investor rules impose additional suitability and disclosure requirements for sales to older customers."
    - name: "suitability_questionnaire_required"
      expr: suitability_questionnaire_required
      comment: "Whether a suitability questionnaire is required. Questionnaire requirements ensure documented evidence of suitability determination."
    - name: "supervisory_approval_required"
      expr: supervisory_approval_required
      comment: "Whether supervisory approval is required for sales under this rule. Supervisory requirements add a compliance control layer for complex or high-risk product sales."
    - name: "replacement_transaction_flag"
      expr: replacement_transaction_flag
      comment: "Whether the rule applies to replacement transactions. Replacement rules impose additional disclosure and comparison requirements to protect policyholders from unsuitable replacements."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the suitability rule became effective. Enables trend analysis of suitability framework evolution and regulatory requirement changes."
  measures:
    - name: "active_suitability_rule_count"
      expr: COUNT(CASE WHEN rule_status = 'Active' THEN suitability_rule_id END)
      comment: "Number of active suitability rules. Measures the complexity of the suitability compliance framework; high counts may indicate rule proliferation requiring rationalization."
    - name: "avg_minimum_annual_income"
      expr: AVG(CAST(minimum_annual_income AS DOUBLE))
      comment: "Average minimum annual income threshold across suitability rules. Measures the financial eligibility floor for product sales; used to assess whether products are appropriately targeted to financially capable customers."
    - name: "avg_minimum_net_worth"
      expr: AVG(CAST(minimum_net_worth AS DOUBLE))
      comment: "Average minimum net worth threshold across suitability rules. Net worth requirements ensure products are sold to customers with adequate financial resources to sustain long-term commitments."
    - name: "avg_minimum_liquid_net_worth"
      expr: AVG(CAST(minimum_liquid_net_worth AS DOUBLE))
      comment: "Average minimum liquid net worth threshold. Liquid net worth requirements protect customers from over-allocating illiquid insurance products relative to their liquid assets."
    - name: "avg_maximum_premium_as_percent_of_income"
      expr: AVG(CAST(maximum_premium_as_percent_of_income AS DOUBLE))
      comment: "Average maximum premium as a percentage of income across suitability rules. This affordability constraint protects customers from over-insuring relative to their income; monitoring ensures rules remain appropriate for target markets."
    - name: "avg_maximum_premium_as_percent_of_net_worth"
      expr: AVG(CAST(maximum_premium_as_percent_of_net_worth AS DOUBLE))
      comment: "Average maximum premium as a percentage of net worth. Concentration limits prevent customers from allocating an excessive portion of their wealth to insurance products."
    - name: "senior_investor_protection_rule_count"
      expr: COUNT(CASE WHEN senior_investor_protection_flag = TRUE THEN suitability_rule_id END)
      comment: "Number of suitability rules with senior investor protections. Tracks the regulatory compliance posture for senior customer sales; a growing regulatory focus area requiring dedicated oversight."
    - name: "supervisory_approval_required_count"
      expr: COUNT(CASE WHEN supervisory_approval_required = TRUE THEN suitability_rule_id END)
      comment: "Number of suitability rules requiring supervisory approval. Measures the volume of product sales requiring compliance oversight; high counts indicate significant supervisory resource requirements."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_irc7702_parameter`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IRC 7702 compliance parameter metrics covering guideline premiums, corridor percentages, contribution limits, and MEC status across the product portfolio. Used by Actuarial, Tax, and Compliance to monitor tax-qualified product compliance, MEC risk exposure, and regulatory parameter adequacy."
  source: "`life_insurance_ecm`.`product`.`irc7702_parameter`"
  dimensions:
    - name: "definition_test_type"
      expr: definition_test_type
      comment: "IRC 7702 definition test type (CVAT or GPT). Determines the compliance pathway and affects premium flexibility and benefit design constraints."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Tax qualification type of the product (e.g. Life Insurance, Annuity, Modified Endowment). Primary tax compliance segmentation dimension."
    - name: "qualified_plan_type"
      expr: qualified_plan_type
      comment: "Type of qualified plan (e.g. IRA, 401k, 403b, Non-Qualified). Determines applicable contribution limits and distribution rules."
    - name: "irc_section_code"
      expr: irc_section_code
      comment: "IRC section code governing the product (e.g. 7702, 7702A, 72, 401). Primary regulatory framework identifier for tax compliance analysis."
    - name: "mec_status_flag"
      expr: mec_status_flag
      comment: "Whether the product has Modified Endowment Contract status. MEC status has significant adverse tax consequences for policyholders; a critical compliance risk indicator."
    - name: "actuarial_certification_flag"
      expr: actuarial_certification_flag
      comment: "Whether actuarial certification has been obtained for the IRC 7702 parameters. Certification is required for regulatory compliance; uncertified parameters represent compliance risk."
    - name: "erisa_applicability_flag"
      expr: erisa_applicability_flag
      comment: "Whether ERISA applies to the product. ERISA applicability imposes additional fiduciary, reporting, and disclosure requirements."
    - name: "rmd_applicability_flag"
      expr: rmd_applicability_flag
      comment: "Whether Required Minimum Distribution rules apply. RMD applicability affects product design for qualified retirement products."
    - name: "tamra_compliance_flag"
      expr: tamra_compliance_flag
      comment: "Whether the product is TAMRA compliant. TAMRA compliance is required to avoid MEC classification under the seven-pay test."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the IRC 7702 parameters became effective. Enables trend analysis of compliance parameter updates and regulatory changes."
  measures:
    - name: "avg_guideline_single_premium"
      expr: AVG(CAST(guideline_single_premium AS DOUBLE))
      comment: "Average Guideline Single Premium across IRC 7702 parameter sets. The GSP is the maximum single premium allowed under the GPT test; monitoring ensures product designs remain within tax-qualified limits."
    - name: "avg_guideline_level_premium"
      expr: AVG(CAST(guideline_level_premium AS DOUBLE))
      comment: "Average Guideline Level Premium across parameter sets. The GLP defines the maximum annual premium under the GPT test; a primary IRC 7702 compliance boundary metric."
    - name: "avg_seven_pay_premium_limit"
      expr: AVG(CAST(seven_pay_premium_limit AS DOUBLE))
      comment: "Average seven-pay premium limit across parameter sets. The seven-pay limit determines MEC status under IRC 7702A; exceeding this limit triggers adverse tax treatment for policyholders."
    - name: "avg_corridor_percentage"
      expr: AVG(CAST(corridor_percentage AS DOUBLE))
      comment: "Average death benefit corridor percentage under the CVAT test. The corridor percentage defines the minimum death benefit relative to cash value required to maintain life insurance status."
    - name: "avg_interest_rate_assumption"
      expr: AVG(CAST(interest_rate_assumption AS DOUBLE))
      comment: "Average interest rate assumption used in IRC 7702 calculations. The interest rate assumption affects guideline premium calculations; monitoring ensures assumptions remain within IRS-prescribed limits."
    - name: "avg_contribution_limit_annual"
      expr: AVG(CAST(contribution_limit_annual AS DOUBLE))
      comment: "Average annual contribution limit across qualified plan parameter sets. Contribution limits are IRS-mandated; monitoring ensures product designs and illustrations comply with current limits."
    - name: "avg_early_withdrawal_penalty_rate"
      expr: AVG(CAST(early_withdrawal_penalty_rate AS DOUBLE))
      comment: "Average early withdrawal penalty rate across parameter sets. The 10% early withdrawal penalty applies to pre-59½ distributions; monitoring ensures correct penalty rates are applied in product illustrations and disclosures."
    - name: "mec_status_product_count"
      expr: COUNT(CASE WHEN mec_status_flag = TRUE THEN irc7702_parameter_id END)
      comment: "Number of product parameter sets with MEC status. MEC-classified products have adverse tax treatment; a non-zero count requires immediate actuarial and tax counsel review."
    - name: "uncertified_parameter_count"
      expr: COUNT(CASE WHEN actuarial_certification_flag = FALSE THEN irc7702_parameter_id END)
      comment: "Number of IRC 7702 parameter sets lacking actuarial certification. Uncertified parameters represent a compliance gap; this metric drives actuarial certification workload prioritization."
$$;