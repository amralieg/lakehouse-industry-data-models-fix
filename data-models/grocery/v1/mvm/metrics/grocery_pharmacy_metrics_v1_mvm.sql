-- Metric views for domain: pharmacy | Business: Grocery | Version: 1 | Generated on: 2026-05-04 20:38:05

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pharmacy_rx_fill`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core dispensing performance metrics derived from prescription fill events. Tracks fill volume, revenue, copay burden, insurance reimbursement, and dispensing quality indicators to steer pharmacy throughput and financial performance."
  source: "`grocery_ecm`.`pharmacy`.`rx_fill`"
  dimensions:
    - name: "fill_date"
      expr: fill_date
      comment: "Calendar date the prescription was dispensed. Primary time dimension for trend analysis."
    - name: "fill_status"
      expr: fill_status
      comment: "Current status of the fill (e.g. Dispensed, Returned, Voided). Used to filter active vs. exception fills."
    - name: "controlled_substance_schedule"
      expr: controlled_substance_schedule
      comment: "DEA schedule classification of the dispensed drug (II–V). Critical for regulatory reporting and controlled-substance oversight."
    - name: "adjudication_result"
      expr: adjudication_result
      comment: "Outcome of the insurance adjudication (e.g. Paid, Rejected, Reversed). Drives revenue recognition and claim quality analysis."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Direction of prescription transfer (In / Out / None). Indicates patient acquisition or loss to competing pharmacies."
    - name: "counseling_method"
      expr: counseling_method
      comment: "Method used to deliver patient counseling (In-Person, Phone, Waived). Supports compliance and quality-of-care reporting."
    - name: "days_supply"
      expr: days_supply
      comment: "Number of days of medication supplied per fill. Used to segment 30-day vs. 90-day fills and adherence analysis."
    - name: "fill_number"
      expr: fill_number
      comment: "Sequential fill number on the prescription (0 = new, 1+ = refill). Distinguishes new prescriptions from refills."
    - name: "dur_override_flag"
      expr: dur_override_flag
      comment: "Indicates whether a Drug Utilization Review alert was overridden by the pharmacist. Key patient-safety quality indicator."
    - name: "rems_acknowledgment_flag"
      expr: rems_acknowledgment_flag
      comment: "Whether REMS program acknowledgment was obtained before dispensing. Mandatory for high-risk medications."
  measures:
    - name: "total_fills"
      expr: COUNT(1)
      comment: "Total number of prescription fill events. Primary throughput KPI for pharmacy operations."
    - name: "total_rx_revenue"
      expr: SUM(CAST(total_price AS DOUBLE))
      comment: "Total prescription revenue across all fills. Top-line pharmacy financial performance indicator."
    - name: "total_insurance_paid_amount"
      expr: SUM(CAST(insurance_paid_amount AS DOUBLE))
      comment: "Total amount reimbursed by insurance plans. Measures payer contribution to pharmacy revenue."
    - name: "total_copay_collected"
      expr: SUM(CAST(copay_amount AS DOUBLE))
      comment: "Total patient out-of-pocket copay collected at point of dispensing. Indicates patient cost burden and cash flow."
    - name: "avg_copay_per_fill"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average patient copay per fill. Benchmarks patient affordability and plan design competitiveness."
    - name: "avg_revenue_per_fill"
      expr: AVG(CAST(total_price AS DOUBLE))
      comment: "Average revenue generated per prescription fill. Tracks revenue yield per dispensing event."
    - name: "total_quantity_dispensed"
      expr: SUM(CAST(dispensed_quantity AS DOUBLE))
      comment: "Total units of medication dispensed. Measures dispensing volume for inventory and capacity planning."
    - name: "unique_patients_filled"
      expr: COUNT(DISTINCT rx_patient_id)
      comment: "Number of distinct patients who received at least one fill. Measures active patient base served."
    - name: "unique_prescriptions_filled"
      expr: COUNT(DISTINCT prescription_id)
      comment: "Number of distinct prescriptions dispensed. Differentiates prescription volume from fill volume (refills)."
    - name: "counseling_acceptance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN counseling_accepted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN counseling_offered_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of counseling offers accepted by patients. Quality-of-care metric tied to patient safety and MTM program performance."
    - name: "dur_override_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dur_override_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fills where a DUR safety alert was overridden. High rates signal patient safety risk and require pharmacist review."
    - name: "transfer_in_fills"
      expr: SUM(CASE WHEN transfer_type = 'IN' THEN 1 ELSE 0 END)
      comment: "Number of fills received via inbound prescription transfer. Measures patient acquisition from competing pharmacies."
    - name: "transfer_out_fills"
      expr: SUM(CASE WHEN transfer_type = 'OUT' THEN 1 ELSE 0 END)
      comment: "Number of fills lost via outbound prescription transfer. Measures patient attrition to competing pharmacies."
    - name: "net_transfer_fills"
      expr: SUM(CASE WHEN transfer_type = 'IN' THEN 1 WHEN transfer_type = 'OUT' THEN -1 ELSE 0 END)
      comment: "Net prescription transfer balance (inbound minus outbound). Positive values indicate net patient acquisition."
    - name: "rems_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN rems_acknowledgment_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fills with REMS acknowledgment on file. Regulatory compliance KPI for high-risk medication programs."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pharmacy_rx_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Insurance claim adjudication and financial metrics. Tracks claim approval rates, reimbursement economics, DIR fee exposure, and reversal activity to manage payer relationships and pharmacy margin."
  source: "`grocery_ecm`.`pharmacy`.`rx_claim`"
  dimensions:
    - name: "service_date"
      expr: service_date
      comment: "Date the pharmacy service was rendered. Primary time dimension for claim trend and aging analysis."
    - name: "claim_status"
      expr: claim_status
      comment: "Current adjudication status of the claim (Paid, Rejected, Reversed, Pending). Drives revenue recognition and AR management."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of claim transaction (Claim, Reversal, Rebill). Distinguishes original submissions from corrections."
    - name: "daw_code"
      expr: daw_code
      comment: "Dispense As Written code indicating brand vs. generic substitution decision. Impacts reimbursement rates and generic fill rates."
    - name: "cob_indicator"
      expr: cob_indicator
      comment: "Coordination of Benefits indicator. Identifies claims with primary and secondary insurance coverage."
    - name: "reject_code"
      expr: reject_code
      comment: "Payer rejection reason code. Used to identify systemic claim submission issues and drive denial management."
    - name: "reversal_reason_code"
      expr: reversal_reason_code
      comment: "Reason code for claim reversal. Identifies patterns in returned or voided claims affecting revenue."
    - name: "mac_pricing_applied"
      expr: mac_pricing_applied
      comment: "Whether Maximum Allowable Cost pricing was applied by the payer. MAC pricing directly compresses pharmacy margin."
    - name: "compound_indicator"
      expr: compound_indicator
      comment: "Indicates whether the claim is for a compounded medication. Compound claims have distinct reimbursement and regulatory profiles."
    - name: "days_supply"
      expr: days_supply
      comment: "Days of supply on the claim. Used to segment 30-day vs. 90-day supply economics and adherence impact."
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of claim transactions submitted. Primary volume KPI for adjudication throughput."
    - name: "total_claim_revenue"
      expr: SUM(CAST(total_claim_amount AS DOUBLE))
      comment: "Total gross claim revenue across all submitted claims. Top-line insurance billing performance."
    - name: "total_plan_pay_amount"
      expr: SUM(CAST(plan_pay_amount AS DOUBLE))
      comment: "Total amount reimbursed by insurance plans. Core payer revenue stream for the pharmacy."
    - name: "total_patient_pay_amount"
      expr: SUM(CAST(patient_pay_amount AS DOUBLE))
      comment: "Total patient out-of-pocket payments collected via claims. Measures patient cost burden at point of sale."
    - name: "total_ingredient_cost"
      expr: SUM(CAST(ingredient_cost AS DOUBLE))
      comment: "Total drug ingredient cost across all claims. Primary cost driver for pharmacy gross margin calculation."
    - name: "total_dispensing_fee_revenue"
      expr: SUM(CAST(dispensing_fee AS DOUBLE))
      comment: "Total dispensing fee revenue earned. Represents the professional service component of pharmacy reimbursement."
    - name: "total_dir_fee_exposure"
      expr: SUM(CAST(dir_fee_amount AS DOUBLE))
      comment: "Total Direct and Indirect Remuneration fees assessed by payers post-adjudication. DIR fees are a major margin compression risk for pharmacy."
    - name: "total_sales_tax_collected"
      expr: SUM(CAST(sales_tax_amount AS DOUBLE))
      comment: "Total sales tax collected on applicable claims. Required for tax compliance reporting."
    - name: "total_reversals_amount"
      expr: SUM(CAST(amount_reversed AS DOUBLE))
      comment: "Total dollar value of reversed claims. High reversal amounts indicate billing quality issues or patient non-pickup."
    - name: "claim_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN claim_status = 'PAID' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submitted claims that were approved and paid. Key adjudication quality and revenue capture KPI."
    - name: "claim_rejection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN claim_status = 'REJECTED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims rejected by payers. Elevated rejection rates signal billing workflow or eligibility issues requiring intervention."
    - name: "claim_reversal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN transaction_type = 'REVERSAL' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claim transactions that are reversals. High reversal rates indicate dispensing or patient pickup failures."
    - name: "avg_plan_pay_per_claim"
      expr: AVG(CAST(plan_pay_amount AS DOUBLE))
      comment: "Average insurance reimbursement per claim. Benchmarks payer contract performance and reimbursement adequacy."
    - name: "avg_dir_fee_per_claim"
      expr: AVG(CAST(dir_fee_amount AS DOUBLE))
      comment: "Average DIR fee assessed per claim. Tracks per-claim margin erosion from post-adjudication payer clawbacks."
    - name: "mac_pricing_claim_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN mac_pricing_applied = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims subject to MAC pricing. High MAC rates indicate payer-driven margin compression on generic drugs."
    - name: "unique_patients_claimed"
      expr: COUNT(DISTINCT rx_patient_id)
      comment: "Number of distinct patients with at least one claim. Measures insured patient base generating revenue."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pharmacy_prescription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prescription intake and management metrics. Tracks new prescription volume, prior authorization burden, generic substitution rates, and prescriber activity to optimize intake workflows and formulary compliance."
  source: "`grocery_ecm`.`pharmacy`.`prescription`"
  dimensions:
    - name: "issue_date"
      expr: issue_date
      comment: "Date the prescription was written by the prescriber. Primary time dimension for new prescription trend analysis."
    - name: "prescription_status"
      expr: prescription_status
      comment: "Current lifecycle status of the prescription (Active, Expired, Transferred, Cancelled). Drives active prescription management."
    - name: "controlled_substance_schedule"
      expr: controlled_substance_schedule
      comment: "DEA schedule of the prescribed drug. Critical for controlled substance compliance and regulatory reporting."
    - name: "therapeutic_class"
      expr: therapeutic_class
      comment: "Therapeutic drug class of the prescription. Enables clinical and formulary performance analysis by drug category."
    - name: "daw_code"
      expr: daw_code
      comment: "Dispense As Written code. Indicates whether the prescriber mandated brand dispensing, impacting generic substitution rates."
    - name: "origin"
      expr: origin
      comment: "Channel through which the prescription was received (eRx, Phone, Paper, Fax). Tracks digital adoption and workflow efficiency."
    - name: "prior_authorization_required"
      expr: prior_authorization_required
      comment: "Whether the prescription requires prior authorization from the payer. PA-required prescriptions create workflow delays and abandonment risk."
    - name: "generic_available"
      expr: generic_available
      comment: "Whether a generic equivalent is available for the prescribed drug. Enables generic substitution opportunity analysis."
    - name: "compound_prescription"
      expr: compound_prescription
      comment: "Indicates whether the prescription is for a compounded medication. Compound prescriptions have distinct preparation and billing workflows."
    - name: "days_supply"
      expr: days_supply
      comment: "Days of medication supply prescribed. Segments 30-day vs. 90-day supply prescribing patterns."
  measures:
    - name: "total_prescriptions"
      expr: COUNT(1)
      comment: "Total number of prescriptions received. Primary intake volume KPI for pharmacy operations."
    - name: "unique_patients_prescribed"
      expr: COUNT(DISTINCT rx_patient_id)
      comment: "Number of distinct patients with at least one prescription. Measures active patient base."
    - name: "unique_prescribers"
      expr: COUNT(DISTINCT prescriber_id)
      comment: "Number of distinct prescribers sending prescriptions to the pharmacy. Measures prescriber network breadth and referral diversity."
    - name: "erx_prescription_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN origin = 'ERX' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prescriptions received electronically (eRx). Measures digital channel adoption and workflow efficiency gains."
    - name: "prior_auth_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN prior_authorization_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prescriptions requiring prior authorization. High PA rates increase dispensing delays and abandonment risk."
    - name: "generic_opportunity_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN generic_available = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prescriptions where a generic equivalent is available. Quantifies the generic substitution opportunity pool."
    - name: "brand_mandated_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN daw_code = '1' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prescriptions where the prescriber mandated brand dispensing (DAW=1). Impacts generic fill rate and payer reimbursement."
    - name: "controlled_substance_prescription_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN controlled_substance_schedule IS NOT NULL AND controlled_substance_schedule != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prescriptions for controlled substances. Tracks regulatory compliance burden and DEA reporting exposure."
    - name: "avg_quantity_prescribed"
      expr: AVG(CAST(quantity_prescribed AS DOUBLE))
      comment: "Average quantity prescribed per prescription. Benchmarks prescribing patterns and identifies outliers for clinical review."
    - name: "compound_prescription_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compound_prescription = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prescriptions that are compounded. Compound prescriptions require specialized preparation resources and distinct billing."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pharmacy_prior_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization workflow performance metrics. Tracks PA approval rates, denial patterns, appeal outcomes, and processing timeliness to reduce dispensing delays and improve patient access to medications."
  source: "`grocery_ecm`.`pharmacy`.`prior_authorization`"
  dimensions:
    - name: "request_date"
      expr: request_date
      comment: "Date the prior authorization was requested. Primary time dimension for PA volume and aging analysis."
    - name: "pa_status"
      expr: pa_status
      comment: "Current status of the prior authorization (Approved, Denied, Pending, Expired). Drives access-to-medication reporting."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Payer-assigned code for PA denial. Identifies systemic denial patterns to guide clinical criteria improvement."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the PA request (Electronic, Phone, Fax). Tracks digital adoption and processing efficiency."
    - name: "urgency_flag"
      expr: urgency_flag
      comment: "Whether the PA was flagged as urgent. Urgent PAs require expedited processing and have regulatory turnaround requirements."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal filed against a PA denial. Tracks appeal success rates and payer dispute outcomes."
    - name: "step_therapy_required_flag"
      expr: step_therapy_required_flag
      comment: "Whether step therapy was required by the payer before approving the PA. Step therapy requirements delay patient access to optimal therapy."
    - name: "formulary_exception_flag"
      expr: formulary_exception_flag
      comment: "Whether the PA was submitted as a formulary exception request. Formulary exceptions indicate gaps between payer formularies and prescriber preferences."
    - name: "diagnosis_code"
      expr: diagnosis_code
      comment: "ICD diagnosis code supporting the PA request. Enables clinical appropriateness analysis by condition."
  measures:
    - name: "total_pa_requests"
      expr: COUNT(1)
      comment: "Total number of prior authorization requests submitted. Primary PA workflow volume KPI."
    - name: "pa_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pa_status = 'APPROVED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PA requests approved by payers. Core patient access metric — low approval rates signal formulary or clinical criteria misalignment."
    - name: "pa_denial_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pa_status = 'DENIED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PA requests denied by payers. Elevated denial rates increase patient abandonment risk and pharmacist workload."
    - name: "pa_appeal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_status IS NOT NULL AND appeal_status != '' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN pa_status = 'DENIED' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of denied PAs that were appealed. Measures staff advocacy for patient access and identifies high-value appeal opportunities."
    - name: "pa_appeal_overturn_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_status = 'APPROVED' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN appeal_status IS NOT NULL AND appeal_status != '' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of appealed PA denials that were overturned to approval. High overturn rates indicate payer denials are clinically unjustified."
    - name: "avg_pa_processing_days"
      expr: AVG(CAST(DATEDIFF(decision_date, request_date) AS DOUBLE))
      comment: "Average calendar days from PA request to payer decision. Measures payer responsiveness and patient access delay duration."
    - name: "urgent_pa_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN urgency_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PA requests flagged as urgent. High urgent PA rates indicate acute patient access challenges requiring expedited payer engagement."
    - name: "step_therapy_pa_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN step_therapy_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PAs requiring step therapy compliance. Step therapy requirements delay optimal therapy and increase clinical burden."
    - name: "total_approved_quantity"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Total medication quantity approved across all PAs. Measures the volume of medication access secured through the PA process."
    - name: "unique_patients_with_pa"
      expr: COUNT(DISTINCT rx_patient_id)
      comment: "Number of distinct patients with at least one PA request. Measures the patient population affected by PA requirements."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pharmacy_drug_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy drug inventory health and compliance metrics. Tracks on-hand stock levels, inventory value, shrink, reorder adequacy, and controlled substance compliance to ensure medication availability and regulatory adherence."
  source: "`grocery_ecm`.`pharmacy`.`drug_inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of the inventory record (Active, Recalled, Quarantined, Expired). Drives stock availability and compliance reporting."
    - name: "controlled_substance_schedule"
      expr: controlled_substance_schedule
      comment: "DEA schedule classification of the stocked drug. Required for controlled substance inventory compliance and biennial count reporting."
    - name: "recall_status"
      expr: recall_status
      comment: "Drug recall status for the inventory lot. Active recalls require immediate quarantine and patient notification."
    - name: "fifo_rotation_status"
      expr: fifo_rotation_status
      comment: "FIFO stock rotation compliance status. Non-compliant rotation increases expiration waste and patient safety risk."
    - name: "refrigeration_required_flag"
      expr: refrigeration_required_flag
      comment: "Whether the drug requires refrigerated storage. Cold-chain inventory requires specialized monitoring and capacity management."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Whether the drug is classified as a hazardous material. Hazardous drug handling requires specialized safety protocols and compliance tracking."
    - name: "vault_storage_flag"
      expr: vault_storage_flag
      comment: "Whether the drug is stored in a controlled substance vault. Vault inventory requires heightened security and access controls."
    - name: "dea_biennial_count_flag"
      expr: dea_biennial_count_flag
      comment: "Whether the item is subject to DEA biennial inventory count requirements. Drives regulatory compliance scheduling."
    - name: "last_receipt_date"
      expr: last_receipt_date
      comment: "Date of the most recent inventory receipt. Used to identify slow-moving or stale inventory."
    - name: "expiration_date"
      expr: expiration_date
      comment: "Expiration date of the inventory lot. Near-expiry inventory requires proactive management to minimize waste."
  measures:
    - name: "total_inventory_value"
      expr: SUM(CAST(inventory_value AS DOUBLE))
      comment: "Total dollar value of pharmacy drug inventory on hand. Primary balance sheet asset metric for pharmacy operations."
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total units of medication currently on hand across all inventory records. Measures overall stock availability."
    - name: "total_shrink_quantity"
      expr: SUM(CAST(shrink_quantity AS DOUBLE))
      comment: "Total inventory lost to shrink (theft, breakage, expiration). Shrink directly reduces pharmacy profitability and requires loss prevention action."
    - name: "avg_inventory_value_per_drug"
      expr: AVG(CAST(inventory_value AS DOUBLE))
      comment: "Average inventory value per drug-location record. Identifies high-value inventory concentration risk."
    - name: "below_reorder_point_count"
      expr: SUM(CASE WHEN on_hand_quantity < reorder_point THEN 1 ELSE 0 END)
      comment: "Number of drug-location inventory records where on-hand quantity has fallen below the reorder point. Drives replenishment urgency and stockout risk management."
    - name: "stockout_risk_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN on_hand_quantity < reorder_point THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inventory records below reorder point. Elevated rates signal supply chain gaps that threaten patient medication access."
    - name: "avg_on_hand_vs_par_ratio"
      expr: ROUND(AVG(CAST(on_hand_quantity AS DOUBLE) / NULLIF(CAST(par_level AS DOUBLE), 0)), 4)
      comment: "Average ratio of on-hand quantity to PAR level. Values below 1.0 indicate understocking; values significantly above 1.0 indicate overstock and capital inefficiency."
    - name: "total_perpetual_adjustment_quantity"
      expr: SUM(CAST(perpetual_adjustment_quantity AS DOUBLE))
      comment: "Total quantity adjustments made to perpetual inventory records. Large adjustments indicate physical count discrepancies or diversion risk."
    - name: "recall_affected_records"
      expr: SUM(CASE WHEN recall_status IS NOT NULL AND recall_status != '' AND recall_status != 'NONE' THEN 1 ELSE 0 END)
      comment: "Number of inventory records affected by an active drug recall. Drives urgent quarantine and patient safety notification workflows."
    - name: "controlled_substance_inventory_value"
      expr: SUM(CASE WHEN controlled_substance_schedule IS NOT NULL AND controlled_substance_schedule != '' THEN CAST(inventory_value AS DOUBLE) ELSE 0 END)
      comment: "Total inventory value of controlled substances. Measures financial exposure in the highest-risk regulatory inventory category."
    - name: "unique_drugs_stocked"
      expr: COUNT(DISTINCT drug_id)
      comment: "Number of distinct drugs carried in inventory. Measures formulary breadth and assortment depth at the pharmacy."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pharmacy_patient_medication_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient medication adherence, clinical program enrollment, and medication therapy management metrics. Tracks PDC scores, MTM eligibility, MedSync enrollment, and adherence risk to drive clinical intervention and Star Ratings performance."
  source: "`grocery_ecm`.`pharmacy`.`patient_medication_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the patient medication profile (Active, Inactive, Deceased). Filters active patient population for clinical metrics."
    - name: "adherence_risk_level"
      expr: adherence_risk_level
      comment: "Risk stratification for medication non-adherence (High, Medium, Low). Primary dimension for targeted clinical outreach prioritization."
    - name: "medsync_status"
      expr: medsync_status
      comment: "Current MedSync enrollment status. MedSync improves adherence and increases fill frequency per patient."
    - name: "delivery_preference"
      expr: delivery_preference
      comment: "Patient preferred medication delivery method (Pickup, Mail, Delivery). Drives omnichannel fulfillment capacity planning."
    - name: "mtm_eligible"
      expr: mtm_eligible
      comment: "Whether the patient is eligible for Medication Therapy Management services. MTM eligibility drives CMS Star Ratings and clinical revenue."
    - name: "mtm_enrolled"
      expr: mtm_enrolled
      comment: "Whether the patient is actively enrolled in MTM. MTM enrollment rate is a key quality and revenue metric."
    - name: "auto_refill_enabled"
      expr: auto_refill_enabled
      comment: "Whether the patient has auto-refill enabled. Auto-refill patients have higher adherence and fill frequency."
    - name: "hipaa_consent_on_file"
      expr: hipaa_consent_on_file
      comment: "Whether HIPAA consent is on file for the patient. Required for clinical outreach and data sharing compliance."
    - name: "preferred_contact_method"
      expr: preferred_contact_method
      comment: "Patient preferred contact method for outreach (Phone, Text, Email). Drives personalized adherence intervention channel selection."
  measures:
    - name: "total_active_profiles"
      expr: COUNT(1)
      comment: "Total number of patient medication profiles. Measures the active clinical patient population managed by the pharmacy."
    - name: "avg_overall_adherence_score"
      expr: AVG(CAST(overall_adherence_score AS DOUBLE))
      comment: "Average medication adherence score across all patients. Core Star Ratings and quality performance KPI — directly tied to CMS reimbursement bonuses."
    - name: "avg_pdc_diabetes"
      expr: AVG(CAST(pdc_diabetes AS DOUBLE))
      comment: "Average Proportion of Days Covered for diabetes medications. CMS Star Ratings measure — directly impacts Medicare Part D plan quality scores."
    - name: "avg_pdc_hypertension"
      expr: AVG(CAST(pdc_hypertension AS DOUBLE))
      comment: "Average Proportion of Days Covered for hypertension medications. CMS Star Ratings measure — a top-weighted quality metric for Part D plans."
    - name: "avg_pdc_cholesterol"
      expr: AVG(CAST(pdc_cholesterol AS DOUBLE))
      comment: "Average Proportion of Days Covered for cholesterol medications (statins). CMS Star Ratings measure tied to cardiovascular outcomes."
    - name: "high_adherence_risk_patient_count"
      expr: SUM(CASE WHEN adherence_risk_level = 'HIGH' THEN 1 ELSE 0 END)
      comment: "Number of patients classified as high adherence risk. Drives prioritized clinical outreach to prevent medication gaps and hospitalizations."
    - name: "medsync_enrollment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN medsync_enrolled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patients enrolled in MedSync. MedSync enrollment improves adherence scores and increases predictable fill volume."
    - name: "mtm_enrollment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN mtm_enrolled = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN mtm_eligible = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of MTM-eligible patients who are enrolled in MTM services. Low enrollment rates represent missed clinical revenue and Star Ratings improvement opportunities."
    - name: "auto_refill_enrollment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_refill_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patients enrolled in auto-refill. Auto-refill drives adherence improvement and predictable dispensing volume."
    - name: "avg_active_medication_count"
      expr: AVG(CAST(active_medication_count AS DOUBLE))
      comment: "Average number of active medications per patient profile. High polypharmacy counts indicate complex patients requiring MTM and DUR attention."
    - name: "hipaa_consent_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hipaa_consent_on_file = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patients with HIPAA consent on file. Required for regulatory compliance and enables clinical outreach programs."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pharmacy_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy location operational readiness, regulatory compliance, and capability metrics. Tracks license status, DEA registration, immunization certification, and service capability to manage network compliance and capacity."
  source: "`grocery_ecm`.`pharmacy`.`pharmacy_location`"
  dimensions:
    - name: "pharmacy_status"
      expr: pharmacy_status
      comment: "Operational status of the pharmacy location (Open, Closed, Suspended). Primary filter for active network analysis."
    - name: "pharmacy_type"
      expr: pharmacy_type
      comment: "Type of pharmacy (Retail, Specialty, Compounding, Mail Order). Drives network segmentation and capability analysis."
    - name: "state_province"
      expr: state_province
      comment: "State or province where the pharmacy is located. Enables geographic performance and regulatory compliance analysis."
    - name: "immunization_certified_flag"
      expr: immunization_certified_flag
      comment: "Whether the pharmacy is certified to administer immunizations. Immunization capability drives clinical service revenue and patient traffic."
    - name: "drive_through_available_flag"
      expr: drive_through_available_flag
      comment: "Whether the pharmacy has a drive-through window. Drive-through availability impacts patient convenience and pickup volume."
    - name: "twenty_four_hour_flag"
      expr: twenty_four_hour_flag
      comment: "Whether the pharmacy operates 24 hours. 24-hour locations serve urgent medication needs and command higher patient loyalty."
    - name: "controlled_substance_vault_certified_flag"
      expr: controlled_substance_vault_certified_flag
      comment: "Whether the pharmacy has a DEA-certified controlled substance vault. Required for Schedule II dispensing and high-volume controlled substance programs."
  measures:
    - name: "total_pharmacy_locations"
      expr: COUNT(1)
      comment: "Total number of pharmacy locations in the network. Measures network scale and geographic reach."
    - name: "active_pharmacy_locations"
      expr: SUM(CASE WHEN pharmacy_status = 'OPEN' THEN 1 ELSE 0 END)
      comment: "Number of currently open and operational pharmacy locations. Measures active dispensing network capacity."
    - name: "immunization_certified_location_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN immunization_certified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pharmacy locations certified to administer immunizations. Measures clinical service capability breadth across the network."
    - name: "dea_registration_expiring_soon_count"
      expr: SUM(CASE WHEN dea_registration_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 ELSE 0 END)
      comment: "Number of pharmacy locations with DEA registration expiring within 90 days. Proactive compliance metric to prevent dispensing interruptions."
    - name: "state_license_expiring_soon_count"
      expr: SUM(CASE WHEN state_board_license_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 ELSE 0 END)
      comment: "Number of pharmacy locations with state board license expiring within 90 days. License lapses result in immediate dispensing suspension."
    - name: "drive_through_location_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN drive_through_available_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pharmacy locations with drive-through service. Measures omnichannel convenience capability across the network."
    - name: "twenty_four_hour_location_count"
      expr: SUM(CASE WHEN twenty_four_hour_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of pharmacy locations operating 24 hours. Measures urgent-access network coverage for patients requiring after-hours dispensing."
    - name: "vault_certified_location_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN controlled_substance_vault_certified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of locations with DEA-certified controlled substance vaults. Measures network capacity for high-security controlled substance dispensing programs."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pharmacy_prescriber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prescriber network quality, digital adoption, and relationship metrics. Tracks eRx enablement, DEA authorization scope, license compliance, and prescriber relationship tier to manage referral network performance."
  source: "`grocery_ecm`.`pharmacy`.`prescriber`"
  dimensions:
    - name: "prescriber_status"
      expr: prescriber_status
      comment: "Current status of the prescriber relationship (Active, Inactive, Suspended). Filters active prescribing network."
    - name: "specialty"
      expr: specialty
      comment: "Medical specialty of the prescriber. Enables prescribing pattern analysis by clinical specialty and drug category alignment."
    - name: "relationship_tier"
      expr: relationship_tier
      comment: "Pharmacy relationship tier with the prescriber (Preferred, Standard, New). Drives prescriber engagement and outreach prioritization."
    - name: "erx_enabled"
      expr: erx_enabled
      comment: "Whether the prescriber is enabled for electronic prescribing. eRx adoption reduces prescription errors and intake processing time."
    - name: "accepts_generic_substitution"
      expr: accepts_generic_substitution
      comment: "Whether the prescriber accepts generic substitution by default. Impacts generic fill rate and payer reimbursement economics."
    - name: "license_status"
      expr: license_status
      comment: "Current state license status of the prescriber. Prescriptions from unlicensed prescribers cannot be dispensed."
    - name: "practice_state"
      expr: practice_state
      comment: "State where the prescriber practices. Enables geographic prescriber network analysis and state-level compliance tracking."
  measures:
    - name: "total_prescribers"
      expr: COUNT(1)
      comment: "Total number of prescribers in the pharmacy network. Measures referral network breadth."
    - name: "active_prescribers"
      expr: SUM(CASE WHEN prescriber_status = 'ACTIVE' THEN 1 ELSE 0 END)
      comment: "Number of currently active prescribers. Measures the active referral network generating prescription volume."
    - name: "erx_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN erx_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prescribers enabled for electronic prescribing. eRx adoption reduces intake errors and processing time, improving pharmacy efficiency."
    - name: "generic_substitution_acceptance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN accepts_generic_substitution = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prescribers who accept generic substitution. Higher rates enable greater generic dispensing, improving patient affordability and payer reimbursement."
    - name: "schedule_ii_authorized_prescriber_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dea_schedule_ii_authorized = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prescribers authorized to prescribe Schedule II controlled substances. Measures the network capacity for high-acuity pain management and ADHD prescribing."
    - name: "license_expiring_soon_count"
      expr: SUM(CASE WHEN license_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 ELSE 0 END)
      comment: "Number of prescribers with licenses expiring within 90 days. Proactive compliance metric to prevent dispensing of prescriptions from lapsed-license providers."
    - name: "preferred_tier_prescriber_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN relationship_tier = 'PREFERRED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prescribers in the preferred relationship tier. Preferred prescribers generate disproportionate prescription volume and warrant targeted engagement."
$$;