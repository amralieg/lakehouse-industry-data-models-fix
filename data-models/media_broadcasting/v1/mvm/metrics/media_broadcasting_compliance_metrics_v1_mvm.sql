-- Metric views for domain: compliance | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 19:19:28

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`compliance_accessibility_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic accessibility compliance metrics tracking obligation fulfillment, cost efficiency, and regulatory risk across broadcast licenses and content types"
  source: "`media_broadcasting_ecm`.`compliance`.`accessibility_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of accessibility obligation (e.g., closed captioning, audio description, emergency information)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (e.g., compliant, non-compliant, in-progress, waived)"
    - name: "priority_level"
      expr: priority_level
      comment: "Business priority level for this obligation (e.g., critical, high, medium, low)"
    - name: "geographic_jurisdiction"
      expr: geographic_jurisdiction
      comment: "Geographic jurisdiction where the obligation applies (e.g., federal, state, local)"
    - name: "content_type_applicability"
      expr: content_type_applicability
      comment: "Content types to which this obligation applies (e.g., live programming, pre-recorded, news)"
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "How often compliance must be reported (e.g., monthly, quarterly, annually)"
    - name: "responsible_team"
      expr: responsible_team
      comment: "Team responsible for ensuring compliance with this obligation"
    - name: "compliance_year"
      expr: YEAR(compliance_deadline)
      comment: "Year of the compliance deadline for trend analysis"
    - name: "compliance_quarter"
      expr: CONCAT('Q', QUARTER(compliance_deadline), '-', YEAR(compliance_deadline))
      comment: "Quarter and year of compliance deadline for quarterly planning"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of accessibility obligations tracked"
    - name: "total_estimated_compliance_cost"
      expr: SUM(CAST(estimated_compliance_cost AS DOUBLE))
      comment: "Total estimated cost to achieve compliance across all obligations"
    - name: "avg_compliance_percentage"
      expr: AVG(CAST(compliance_percentage AS DOUBLE))
      comment: "Average compliance percentage achieved across obligations"
    - name: "avg_target_compliance_percentage"
      expr: AVG(CAST(target_compliance_percentage AS DOUBLE))
      comment: "Average target compliance percentage set for obligations"
    - name: "compliance_gap_percentage"
      expr: AVG(CAST(target_compliance_percentage AS DOUBLE)) - AVG(CAST(compliance_percentage AS DOUBLE))
      comment: "Average gap between target and actual compliance percentage - key risk indicator"
    - name: "distinct_broadcast_licenses"
      expr: COUNT(DISTINCT broadcast_license_id)
      comment: "Number of unique broadcast licenses with accessibility obligations"
    - name: "distinct_regulatory_obligations"
      expr: COUNT(DISTINCT regulatory_obligation_id)
      comment: "Number of unique regulatory obligations referenced"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`compliance_broadcast_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core broadcast license portfolio metrics tracking license status, renewal health, technical coverage, and regulatory fee obligations"
  source: "`media_broadcasting_ecm`.`compliance`.`broadcast_license`"
  dimensions:
    - name: "broadcast_license_status"
      expr: broadcast_license_status
      comment: "Current status of the broadcast license (e.g., active, expired, pending renewal, suspended)"
    - name: "license_type"
      expr: license_type
      comment: "Type of broadcast license (e.g., full power, low power, translator)"
    - name: "service_type"
      expr: service_type
      comment: "Service type provided under this license (e.g., television, radio, digital)"
    - name: "license_class"
      expr: license_class
      comment: "FCC license class designation"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory body issuing the license (e.g., FCC, state authority)"
    - name: "jurisdiction_country_code"
      expr: jurisdiction_country_code
      comment: "Country code of the licensing jurisdiction"
    - name: "renewal_status"
      expr: renewal_status
      comment: "Status of license renewal process (e.g., not due, pending, approved, denied)"
    - name: "closed_captioning_required"
      expr: closed_captioning_required
      comment: "Whether closed captioning is required for this license"
    - name: "eas_participation_required"
      expr: eas_participation_required
      comment: "Whether Emergency Alert System participation is required"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the license expires - critical for renewal planning"
  measures:
    - name: "total_licenses"
      expr: COUNT(1)
      comment: "Total number of broadcast licenses in the portfolio"
    - name: "total_annual_fee_amount"
      expr: SUM(CAST(annual_fee_amount AS DOUBLE))
      comment: "Total annual regulatory fees across all licenses - key cost driver"
    - name: "avg_annual_fee_per_license"
      expr: AVG(CAST(annual_fee_amount AS DOUBLE))
      comment: "Average annual fee per license for cost benchmarking"
    - name: "total_power_output_erp_watts"
      expr: SUM(CAST(power_output_erp_watts AS DOUBLE))
      comment: "Total effective radiated power across all licenses - technical capacity indicator"
    - name: "avg_antenna_height_meters"
      expr: AVG(CAST(antenna_height_meters AS DOUBLE))
      comment: "Average antenna height across licenses - coverage capability indicator"
    - name: "distinct_call_signs"
      expr: COUNT(DISTINCT call_sign)
      comment: "Number of unique call signs in the portfolio"
    - name: "distinct_communities_of_license"
      expr: COUNT(DISTINCT community_of_license)
      comment: "Number of unique communities served - market reach indicator"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`compliance_closed_caption_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Closed captioning quality and compliance metrics tracking accuracy, completeness, and regulatory adherence for accessibility obligations"
  source: "`media_broadcasting_ecm`.`compliance`.`closed_caption_record`"
  dimensions:
    - name: "caption_type"
      expr: caption_type
      comment: "Type of captioning (e.g., live, pre-recorded, real-time, offline)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the caption record (e.g., compliant, non-compliant, under review)"
    - name: "language_code"
      expr: language_code
      comment: "Language of the captions (e.g., en, es, fr)"
    - name: "caption_file_format"
      expr: caption_file_format
      comment: "File format of the caption file (e.g., SCC, SRT, WebVTT)"
    - name: "daypart"
      expr: daypart
      comment: "Broadcast daypart (e.g., prime time, daytime, late night)"
    - name: "exemption_category"
      expr: exemption_category
      comment: "Category of exemption if applicable (e.g., technical infeasibility, undue burden)"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation for non-compliant captions (e.g., pending, in-progress, completed)"
    - name: "complaint_type"
      expr: complaint_type
      comment: "Type of complaint received if any (e.g., accuracy, synchronization, completeness)"
    - name: "air_year"
      expr: YEAR(air_date)
      comment: "Year the content aired for trend analysis"
    - name: "air_month"
      expr: DATE_TRUNC('MONTH', air_date)
      comment: "Month the content aired for monthly compliance tracking"
  measures:
    - name: "total_caption_records"
      expr: COUNT(1)
      comment: "Total number of closed caption records tracked"
    - name: "avg_caption_accuracy_score"
      expr: AVG(CAST(caption_accuracy_score AS DOUBLE))
      comment: "Average caption accuracy score - key quality indicator for compliance"
    - name: "avg_caption_completeness_percentage"
      expr: AVG(CAST(caption_completeness_percentage AS DOUBLE))
      comment: "Average caption completeness percentage - measures coverage of spoken content"
    - name: "avg_caption_latency_seconds"
      expr: AVG(CAST(caption_latency_seconds AS DOUBLE))
      comment: "Average caption latency in seconds - critical for live captioning quality"
    - name: "caption_placement_compliance_rate"
      expr: AVG(CASE WHEN caption_placement_compliance = TRUE THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of records with compliant caption placement"
    - name: "caption_synchronization_compliance_rate"
      expr: AVG(CASE WHEN caption_synchronization_compliance = TRUE THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of records with compliant caption synchronization - regulatory requirement"
    - name: "distinct_content_titles"
      expr: COUNT(DISTINCT content_title_id)
      comment: "Number of unique content titles with caption records"
    - name: "distinct_broadcast_licenses"
      expr: COUNT(DISTINCT broadcast_license_id)
      comment: "Number of unique broadcast licenses with caption records"
    - name: "complaint_rate"
      expr: AVG(CASE WHEN complaint_reference_number IS NOT NULL THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of caption records with associated complaints - key risk indicator"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`compliance_content_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content rating compliance and cost metrics tracking rating distribution, appeal outcomes, and regulatory adherence across territories"
  source: "`media_broadcasting_ecm`.`compliance`.`content_rating`"
  dimensions:
    - name: "rating_system"
      expr: rating_system
      comment: "Rating system used (e.g., TV Parental Guidelines, MPAA, ESRB)"
    - name: "rating_authority"
      expr: rating_authority
      comment: "Authority that issued the rating (e.g., FCC, MPAA, independent board)"
    - name: "rating_status"
      expr: rating_status
      comment: "Status of the rating (e.g., active, expired, under appeal, revoked)"
    - name: "rating_type"
      expr: rating_type
      comment: "Type of rating (e.g., age-based, content-based, advisory)"
    - name: "territory_code"
      expr: territory_code
      comment: "Territory or country code where the rating applies"
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any rating appeal (e.g., none, pending, approved, denied)"
    - name: "parental_guidance_required"
      expr: parental_guidance_required
      comment: "Whether parental guidance is required for this rating"
    - name: "coppa_compliant"
      expr: coppa_compliant
      comment: "Whether the content is COPPA compliant (Children's Online Privacy Protection Act)"
    - name: "violence_descriptor"
      expr: violence_descriptor
      comment: "Whether violence content descriptor is present"
    - name: "sexual_content_descriptor"
      expr: sexual_content_descriptor
      comment: "Whether sexual content descriptor is present"
    - name: "drug_use_descriptor"
      expr: drug_use_descriptor
      comment: "Whether drug use content descriptor is present"
    - name: "language_descriptor"
      expr: language_descriptor
      comment: "Whether language content descriptor is present"
    - name: "rating_year"
      expr: YEAR(rating_date)
      comment: "Year the rating was issued for trend analysis"
  measures:
    - name: "total_content_ratings"
      expr: COUNT(1)
      comment: "Total number of content ratings tracked"
    - name: "total_rating_fee_amount"
      expr: SUM(CAST(rating_fee_amount AS DOUBLE))
      comment: "Total rating fees paid - key cost driver for content compliance"
    - name: "avg_rating_fee_per_title"
      expr: AVG(CAST(rating_fee_amount AS DOUBLE))
      comment: "Average rating fee per content title for cost benchmarking"
    - name: "avg_rating_value"
      expr: AVG(CAST(rating_value AS DOUBLE))
      comment: "Average numeric rating value across content portfolio"
    - name: "distinct_content_titles"
      expr: COUNT(DISTINCT content_title_id)
      comment: "Number of unique content titles with ratings"
    - name: "distinct_rating_systems"
      expr: COUNT(DISTINCT rating_system)
      comment: "Number of different rating systems used - complexity indicator"
    - name: "distinct_territories"
      expr: COUNT(DISTINCT territory_code)
      comment: "Number of unique territories with ratings - market reach indicator"
    - name: "coppa_compliance_rate"
      expr: AVG(CASE WHEN coppa_compliant = TRUE THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of content that is COPPA compliant - critical for children's programming"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`compliance_political_ad_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Political advertising compliance and revenue metrics tracking equal time obligations, LUC rate adherence, and public file disclosure requirements"
  source: "`media_broadcasting_ecm`.`compliance`.`political_ad_record`"
  dimensions:
    - name: "advertiser_type"
      expr: advertiser_type
      comment: "Type of political advertiser (e.g., candidate, PAC, party committee, issue advocacy)"
    - name: "election_type"
      expr: election_type
      comment: "Type of election (e.g., presidential, congressional, state, local)"
    - name: "jurisdiction_level"
      expr: jurisdiction_level
      comment: "Jurisdiction level of the election (e.g., federal, state, county, municipal)"
    - name: "office_sought"
      expr: office_sought
      comment: "Political office being sought (e.g., President, Senator, Governor, Mayor)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the political ad record (e.g., compliant, non-compliant, under review)"
    - name: "daypart"
      expr: daypart
      comment: "Broadcast daypart when ad aired (e.g., prime time, daytime, late night)"
    - name: "rate_class"
      expr: rate_class
      comment: "Rate class charged for the ad (e.g., LUC, preemptible, fixed)"
    - name: "luc_period_flag"
      expr: luc_period_flag
      comment: "Whether the ad aired during the Lowest Unit Charge period (45/60 days before election)"
    - name: "equal_opportunities_request_flag"
      expr: equal_opportunities_request_flag
      comment: "Whether an equal opportunities request was made by opposing candidate"
    - name: "reasonable_access_request_flag"
      expr: reasonable_access_request_flag
      comment: "Whether a reasonable access request was made (federal candidates only)"
    - name: "preemption_flag"
      expr: preemption_flag
      comment: "Whether the ad was preempted"
    - name: "makegood_flag"
      expr: makegood_flag
      comment: "Whether the ad is a makegood for a preempted spot"
    - name: "election_year"
      expr: YEAR(election_date)
      comment: "Year of the election for cycle analysis"
    - name: "air_year"
      expr: YEAR(air_date)
      comment: "Year the ad aired for revenue trend analysis"
  measures:
    - name: "total_political_ad_records"
      expr: COUNT(1)
      comment: "Total number of political ad records tracked"
    - name: "total_political_ad_revenue"
      expr: SUM(CAST(rate_charged AS DOUBLE))
      comment: "Total revenue from political advertising - key revenue stream during election cycles"
    - name: "avg_rate_charged"
      expr: AVG(CAST(rate_charged AS DOUBLE))
      comment: "Average rate charged per political ad spot"
    - name: "avg_luc_rate"
      expr: AVG(CAST(luc_rate AS DOUBLE))
      comment: "Average Lowest Unit Charge rate - regulatory compliance benchmark"
    - name: "luc_compliance_rate"
      expr: AVG(CASE WHEN luc_period_flag = TRUE AND rate_charged <= luc_rate THEN 100.0 WHEN luc_period_flag = FALSE THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of ads compliant with LUC requirements - critical regulatory metric"
    - name: "distinct_candidates"
      expr: COUNT(DISTINCT candidate_name)
      comment: "Number of unique candidates advertising - market diversity indicator"
    - name: "distinct_broadcast_licenses"
      expr: COUNT(DISTINCT broadcast_license_id)
      comment: "Number of unique broadcast licenses running political ads"
    - name: "preemption_rate"
      expr: AVG(CASE WHEN preemption_flag = TRUE THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of political ads preempted - service quality and legal risk indicator"
    - name: "equal_opportunities_request_rate"
      expr: AVG(CASE WHEN equal_opportunities_request_flag = TRUE THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of ads triggering equal opportunities requests - compliance workload indicator"
    - name: "public_file_disclosure_rate"
      expr: AVG(CASE WHEN public_file_disclosure_date IS NOT NULL THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of ads disclosed in public inspection file - regulatory compliance metric"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing performance metrics tracking submission timeliness, approval rates, fee obligations, and multi-jurisdiction compliance burden"
  source: "`media_broadcasting_ecm`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (e.g., license renewal, ownership report, EEO report, children's programming)"
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing (e.g., draft, submitted, accepted, rejected, under review)"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body receiving the filing (e.g., FCC, state commission, international authority)"
    - name: "compliance_category"
      expr: compliance_category
      comment: "Category of compliance (e.g., operational, financial, technical, programming)"
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the filing (e.g., electronic, paper, portal)"
    - name: "amendment_flag"
      expr: amendment_flag
      comment: "Whether this filing is an amendment to a previous filing"
    - name: "public_inspection_required"
      expr: public_inspection_required
      comment: "Whether the filing must be included in the public inspection file"
    - name: "gdpr_applicable"
      expr: gdpr_applicable
      comment: "Whether GDPR regulations apply to this filing"
    - name: "ccpa_applicable"
      expr: ccpa_applicable
      comment: "Whether CCPA regulations apply to this filing"
    - name: "coppa_applicable"
      expr: coppa_applicable
      comment: "Whether COPPA regulations apply to this filing"
    - name: "sox_applicable"
      expr: sox_applicable
      comment: "Whether Sarbanes-Oxley regulations apply to this filing"
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year the filing was submitted for trend analysis"
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year the filing was due for compliance tracking"
  measures:
    - name: "total_regulatory_filings"
      expr: COUNT(1)
      comment: "Total number of regulatory filings tracked"
    - name: "total_filing_fee_amount"
      expr: SUM(CAST(filing_fee_amount AS DOUBLE))
      comment: "Total regulatory filing fees paid - key compliance cost driver"
    - name: "avg_filing_fee"
      expr: AVG(CAST(filing_fee_amount AS DOUBLE))
      comment: "Average filing fee per submission for cost benchmarking"
    - name: "on_time_filing_rate"
      expr: AVG(CASE WHEN filing_date <= due_date THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of filings submitted on or before due date - critical compliance metric"
    - name: "approval_rate"
      expr: AVG(CASE WHEN approval_date IS NOT NULL THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of filings approved - regulatory relationship health indicator"
    - name: "rejection_rate"
      expr: AVG(CASE WHEN rejection_reason IS NOT NULL THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of filings rejected - quality and risk indicator"
    - name: "amendment_rate"
      expr: AVG(CASE WHEN amendment_flag = TRUE THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of filings that are amendments - rework and quality indicator"
    - name: "distinct_regulatory_bodies"
      expr: COUNT(DISTINCT regulatory_body)
      comment: "Number of unique regulatory bodies - compliance complexity indicator"
    - name: "distinct_broadcast_licenses"
      expr: COUNT(DISTINCT broadcast_license_id)
      comment: "Number of unique broadcast licenses with filings"
    - name: "distinct_filing_types"
      expr: COUNT(DISTINCT filing_type)
      comment: "Number of unique filing types - compliance scope indicator"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`compliance_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory obligation portfolio metrics tracking compliance status, risk exposure, automation maturity, and penalty exposure across jurisdictions"
  source: "`media_broadcasting_ecm`.`compliance`.`regulatory_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (e.g., reporting, disclosure, operational, technical)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (e.g., compliant, non-compliant, in-progress, not-applicable)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of non-compliance (e.g., critical, high, medium, low)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction where the obligation applies (e.g., federal, state, international)"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body enforcing the obligation (e.g., FCC, FTC, state commission)"
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for ensuring compliance"
    - name: "compliance_frequency"
      expr: compliance_frequency
      comment: "How often compliance must be demonstrated (e.g., daily, monthly, quarterly, annually)"
    - name: "automation_status"
      expr: automation_status
      comment: "Level of automation for compliance monitoring (e.g., manual, semi-automated, fully-automated)"
    - name: "is_active"
      expr: is_active
      comment: "Whether the obligation is currently active"
    - name: "documentation_required"
      expr: documentation_required
      comment: "Whether documentation is required for this obligation"
    - name: "external_reporting_required"
      expr: external_reporting_required
      comment: "Whether external reporting to regulators is required"
    - name: "public_disclosure_required"
      expr: public_disclosure_required
      comment: "Whether public disclosure is required"
    - name: "audit_trail_required"
      expr: audit_trail_required
      comment: "Whether an audit trail must be maintained"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the obligation became effective"
  measures:
    - name: "total_regulatory_obligations"
      expr: COUNT(1)
      comment: "Total number of regulatory obligations tracked"
    - name: "active_obligations"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Number of currently active regulatory obligations"
    - name: "total_maximum_penalty_exposure"
      expr: SUM(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Total maximum penalty exposure across all obligations - key risk metric for board reporting"
    - name: "avg_maximum_penalty"
      expr: AVG(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Average maximum penalty per obligation - risk severity indicator"
    - name: "compliance_rate"
      expr: AVG(CASE WHEN compliance_status = 'compliant' THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of obligations in compliant status - headline compliance metric"
    - name: "high_risk_obligation_rate"
      expr: AVG(CASE WHEN risk_level IN ('critical', 'high') THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of obligations classified as high or critical risk - risk concentration metric"
    - name: "automation_rate"
      expr: AVG(CASE WHEN automation_status = 'fully-automated' THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of obligations with full automation - operational efficiency indicator"
    - name: "distinct_regulatory_bodies"
      expr: COUNT(DISTINCT regulatory_body)
      comment: "Number of unique regulatory bodies - compliance complexity indicator"
    - name: "distinct_jurisdictions"
      expr: COUNT(DISTINCT jurisdiction)
      comment: "Number of unique jurisdictions - geographic compliance scope"
    - name: "external_reporting_obligation_rate"
      expr: AVG(CASE WHEN external_reporting_required = TRUE THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of obligations requiring external reporting - workload indicator"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`compliance_privacy_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy request fulfillment metrics tracking GDPR/CCPA compliance, response timeliness, processing efficiency, and data subject rights management"
  source: "`media_broadcasting_ecm`.`compliance`.`privacy_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of privacy request (e.g., access, deletion, portability, opt-out, correction)"
    - name: "request_status"
      expr: request_status
      comment: "Current status of the request (e.g., received, in-progress, fulfilled, rejected, closed)"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status (e.g., pending, completed, partially-completed, unable-to-fulfill)"
    - name: "requestor_jurisdiction"
      expr: requestor_jurisdiction
      comment: "Jurisdiction of the data subject making the request (e.g., EU, California, UK)"
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the request was submitted (e.g., web form, email, phone, mail)"
    - name: "verification_status"
      expr: verification_status
      comment: "Status of identity verification (e.g., verified, pending, failed, not-required)"
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify requestor identity (e.g., email confirmation, ID document, account login)"
    - name: "response_method"
      expr: response_method
      comment: "Method used to respond to the request (e.g., email, portal, mail, phone)"
    - name: "extension_granted"
      expr: extension_granted
      comment: "Whether a deadline extension was granted"
    - name: "submission_year"
      expr: YEAR(submission_timestamp)
      comment: "Year the request was submitted for trend analysis"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month the request was submitted for monthly volume tracking"
  measures:
    - name: "total_privacy_requests"
      expr: COUNT(1)
      comment: "Total number of privacy requests received"
    - name: "avg_processing_time_hours"
      expr: AVG(CAST(processing_time_hours AS DOUBLE))
      comment: "Average time to process a privacy request in hours - key efficiency metric"
    - name: "avg_data_volume_processed"
      expr: AVG(CAST(data_volume_processed AS DOUBLE))
      comment: "Average volume of data processed per request - workload complexity indicator"
    - name: "on_time_response_rate"
      expr: AVG(CASE WHEN response_date <= regulatory_deadline THEN 100.0 WHEN response_date IS NULL THEN NULL ELSE 0.0 END)
      comment: "Percentage of requests responded to within regulatory deadline - critical compliance metric"
    - name: "fulfillment_rate"
      expr: AVG(CASE WHEN fulfillment_status = 'completed' THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of requests successfully fulfilled - service quality indicator"
    - name: "rejection_rate"
      expr: AVG(CASE WHEN rejection_reason IS NOT NULL THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of requests rejected - may indicate verification or scope issues"
    - name: "extension_rate"
      expr: AVG(CASE WHEN extension_granted = TRUE THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of requests requiring deadline extensions - capacity planning indicator"
    - name: "verification_success_rate"
      expr: AVG(CASE WHEN verification_status = 'verified' THEN 100.0 WHEN verification_status = 'not-required' THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of requests with successful identity verification - security effectiveness metric"
    - name: "distinct_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Number of unique subscribers making privacy requests"
    - name: "distinct_jurisdictions"
      expr: COUNT(DISTINCT requestor_jurisdiction)
      comment: "Number of unique jurisdictions from which requests originate - geographic scope"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`compliance_eas_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Emergency Alert System compliance metrics tracking alert transmission success, equipment reliability, and regulatory test compliance"
  source: "`media_broadcasting_ecm`.`compliance`.`eas_log`"
  dimensions:
    - name: "alert_type"
      expr: alert_type
      comment: "Type of EAS alert (e.g., required monthly test, required weekly test, national alert, state alert, local alert)"
    - name: "event_code"
      expr: event_code
      comment: "EAS event code (e.g., RMT, RWT, EAN, TOR, SVR)"
    - name: "originator_code"
      expr: originator_code
      comment: "Code identifying the alert originator (e.g., EAS, PEP, WXR, CIV)"
    - name: "transmission_status"
      expr: transmission_status
      comment: "Status of the alert transmission (e.g., successful, failed, partial)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the EAS event (e.g., compliant, non-compliant, under review)"
    - name: "test_compliance_type"
      expr: test_compliance_type
      comment: "Type of compliance test (e.g., required monthly test, required weekly test, national test)"
    - name: "attention_signal_transmitted"
      expr: attention_signal_transmitted
      comment: "Whether the attention signal was transmitted"
    - name: "audio_message_transmitted"
      expr: audio_message_transmitted
      comment: "Whether the audio message was transmitted"
    - name: "end_of_message_transmitted"
      expr: end_of_message_transmitted
      comment: "Whether the end-of-message signal was transmitted"
    - name: "cap_message_received"
      expr: cap_message_received
      comment: "Whether a Common Alerting Protocol message was received"
    - name: "public_inspection_file_entry"
      expr: public_inspection_file_entry
      comment: "Whether the event was logged in the public inspection file"
    - name: "equipment_used"
      expr: equipment_used
      comment: "Equipment used to process the alert"
    - name: "alert_year"
      expr: YEAR(alert_timestamp)
      comment: "Year the alert occurred for trend analysis"
    - name: "alert_month"
      expr: DATE_TRUNC('MONTH', alert_timestamp)
      comment: "Month the alert occurred for monthly compliance tracking"
  measures:
    - name: "total_eas_events"
      expr: COUNT(1)
      comment: "Total number of EAS events logged"
    - name: "transmission_success_rate"
      expr: AVG(CASE WHEN transmission_status = 'successful' THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of EAS alerts successfully transmitted - critical public safety metric"
    - name: "compliance_rate"
      expr: AVG(CASE WHEN compliance_status = 'compliant' THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of EAS events in compliance with FCC requirements - regulatory metric"
    - name: "attention_signal_transmission_rate"
      expr: AVG(CASE WHEN attention_signal_transmitted = TRUE THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of events with attention signal transmitted - technical compliance indicator"
    - name: "audio_message_transmission_rate"
      expr: AVG(CASE WHEN audio_message_transmitted = TRUE THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of events with audio message transmitted - accessibility compliance indicator"
    - name: "end_of_message_transmission_rate"
      expr: AVG(CASE WHEN end_of_message_transmitted = TRUE THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of events with end-of-message signal transmitted - protocol compliance indicator"
    - name: "cap_message_reception_rate"
      expr: AVG(CASE WHEN cap_message_received = TRUE THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of events with CAP message received - IPAWS integration health indicator"
    - name: "public_file_documentation_rate"
      expr: AVG(CASE WHEN public_inspection_file_entry = TRUE THEN 100.0 ELSE 0.0 END)
      comment: "Percentage of events documented in public inspection file - record-keeping compliance metric"
    - name: "distinct_broadcast_licenses"
      expr: COUNT(DISTINCT broadcast_license_id)
      comment: "Number of unique broadcast licenses with EAS events"
    - name: "distinct_event_codes"
      expr: COUNT(DISTINCT event_code)
      comment: "Number of unique EAS event codes processed - alert diversity indicator"
$$;