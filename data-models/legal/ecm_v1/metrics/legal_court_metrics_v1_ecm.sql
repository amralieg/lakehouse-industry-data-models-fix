-- Metric views for domain: court | Business: Legal | Version: 1 | Generated on: 2026-05-07 11:54:14

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`court_adr_proceeding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Alternative Dispute Resolution (ADR) proceeding performance metrics tracking arbitration and mediation case outcomes, settlement rates, cost efficiency, and timeline performance for dispute resolution management."
  source: "`legal_ecm`.`court`.`adr_proceeding`"
  dimensions:
    - name: "adr_type"
      expr: adr_type
      comment: "Type of alternative dispute resolution mechanism (arbitration, mediation, conciliation, etc.)"
    - name: "proceeding_status"
      expr: proceeding_status
      comment: "Current status of the ADR proceeding (active, settled, terminated, award issued, etc.)"
    - name: "administering_institution"
      expr: administering_institution
      comment: "Institution administering the ADR proceeding (ICC, AAA, LCIA, etc.)"
    - name: "seat_of_arbitration"
      expr: seat_of_arbitration
      comment: "Legal seat/jurisdiction of the arbitration proceeding"
    - name: "governing_law"
      expr: governing_law
      comment: "Governing law applicable to the dispute"
    - name: "number_of_arbitrators"
      expr: number_of_arbitrators
      comment: "Number of arbitrators constituting the tribunal (sole, three-member, etc.)"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the proceeding"
    - name: "settlement_reached"
      expr: settlement_reached_flag
      comment: "Whether the parties reached a settlement"
    - name: "emergency_arbitrator_appointed"
      expr: emergency_arbitrator_appointed_flag
      comment: "Whether an emergency arbitrator was appointed for urgent interim relief"
    - name: "interim_measures_granted"
      expr: interim_measures_granted_flag
      comment: "Whether interim or provisional measures were granted during the proceeding"
    - name: "commencement_year"
      expr: YEAR(commencement_date)
      comment: "Year the ADR proceeding was commenced"
    - name: "commencement_quarter"
      expr: CONCAT('Q', QUARTER(commencement_date), '-', YEAR(commencement_date))
      comment: "Quarter and year the ADR proceeding was commenced"
    - name: "award_year"
      expr: YEAR(award_date)
      comment: "Year the award was issued"
    - name: "underlying_contract_type"
      expr: underlying_contract_type
      comment: "Type of underlying contract giving rise to the dispute"
    - name: "dispute_subject_matter"
      expr: dispute_subject_matter
      comment: "Subject matter of the dispute"
    - name: "enforcement_status"
      expr: enforcement_status
      comment: "Status of award enforcement"
  measures:
    - name: "total_adr_proceedings"
      expr: COUNT(1)
      comment: "Total number of ADR proceedings"
    - name: "total_claim_value"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total value of claims across all ADR proceedings"
    - name: "total_award_value"
      expr: SUM(CAST(award_amount AS DOUBLE))
      comment: "Total value of awards issued across all ADR proceedings"
    - name: "total_counterclaim_value"
      expr: SUM(CAST(counterclaim_amount AS DOUBLE))
      comment: "Total value of counterclaims filed across all ADR proceedings"
    - name: "total_costs_awarded_to_claimant"
      expr: SUM(CAST(costs_awarded_to_claimant AS DOUBLE))
      comment: "Total costs awarded to claimants across all proceedings"
    - name: "total_costs_awarded_to_respondent"
      expr: SUM(CAST(costs_awarded_to_respondent AS DOUBLE))
      comment: "Total costs awarded to respondents across all proceedings"
    - name: "settlement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN settlement_reached_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ADR proceedings that resulted in settlement"
    - name: "emergency_arbitrator_utilization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN emergency_arbitrator_appointed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of proceedings where emergency arbitrator was appointed"
    - name: "interim_measures_grant_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN interim_measures_granted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of proceedings where interim measures were granted"
    - name: "avg_claim_amount"
      expr: AVG(CAST(claim_amount AS DOUBLE))
      comment: "Average claim amount per ADR proceeding"
    - name: "avg_award_amount"
      expr: AVG(CAST(award_amount AS DOUBLE))
      comment: "Average award amount per ADR proceeding"
    - name: "distinct_matters"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters associated with ADR proceedings"
    - name: "distinct_clients"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct clients involved in ADR proceedings"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`court_arbitral_award`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Arbitral award outcome and enforcement metrics tracking award values, cost allocations, challenge rates, enforcement success, and New York Convention applicability for international arbitration portfolio management."
  source: "`legal_ecm`.`court`.`arbitral_award`"
  dimensions:
    - name: "award_type"
      expr: award_type
      comment: "Type of arbitral award (final, partial, interim, consent, etc.)"
    - name: "award_status"
      expr: award_status
      comment: "Current status of the arbitral award (issued, enforced, challenged, set aside, etc.)"
    - name: "arbitral_institution"
      expr: arbitral_institution
      comment: "Arbitral institution that administered the proceeding"
    - name: "seat_of_arbitration"
      expr: seat_of_arbitration
      comment: "Legal seat of the arbitration"
    - name: "governing_law"
      expr: governing_law
      comment: "Governing law applied to the dispute"
    - name: "challenge_filed"
      expr: challenge_filed_flag
      comment: "Whether a challenge to the award was filed"
    - name: "challenge_outcome"
      expr: challenge_outcome
      comment: "Outcome of any challenge filed against the award"
    - name: "new_york_convention_applicable"
      expr: new_york_convention_applicable_flag
      comment: "Whether the New York Convention on Recognition and Enforcement of Foreign Arbitral Awards applies"
    - name: "confidentiality_flag"
      expr: confidentiality_flag
      comment: "Whether the award is subject to confidentiality restrictions"
    - name: "publication_permitted"
      expr: publication_permitted_flag
      comment: "Whether publication of the award is permitted"
    - name: "interest_provision"
      expr: interest_provision_flag
      comment: "Whether the award includes interest provisions"
    - name: "cost_allocation_basis"
      expr: cost_allocation_basis
      comment: "Basis on which costs were allocated between parties"
    - name: "enforcement_jurisdiction"
      expr: enforcement_jurisdiction
      comment: "Jurisdiction where enforcement is sought or granted"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the award was issued"
    - name: "issue_quarter"
      expr: CONCAT('Q', QUARTER(issue_date), '-', YEAR(issue_date))
      comment: "Quarter and year the award was issued"
    - name: "tribunal_composition"
      expr: tribunal_composition
      comment: "Composition of the arbitral tribunal"
    - name: "adr_mechanism"
      expr: adr_mechanism
      comment: "Alternative dispute resolution mechanism used"
  measures:
    - name: "total_arbitral_awards"
      expr: COUNT(1)
      comment: "Total number of arbitral awards issued"
    - name: "total_awarded_amount"
      expr: SUM(CAST(awarded_amount AS DOUBLE))
      comment: "Total monetary value awarded across all arbitral awards"
    - name: "total_costs_to_claimant"
      expr: SUM(CAST(costs_awarded_to_claimant AS DOUBLE))
      comment: "Total costs awarded to claimants across all awards"
    - name: "total_costs_to_respondent"
      expr: SUM(CAST(costs_awarded_to_respondent AS DOUBLE))
      comment: "Total costs awarded to respondents across all awards"
    - name: "net_cost_allocation"
      expr: SUM((CAST(costs_awarded_to_claimant AS DOUBLE)) - (CAST(costs_awarded_to_respondent AS DOUBLE)))
      comment: "Net cost allocation (claimant costs minus respondent costs) indicating overall cost burden direction"
    - name: "challenge_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN challenge_filed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of awards that were challenged"
    - name: "new_york_convention_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN new_york_convention_applicable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of awards covered by the New York Convention for international enforcement"
    - name: "interest_provision_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN interest_provision_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of awards that include interest provisions"
    - name: "avg_awarded_amount"
      expr: AVG(CAST(awarded_amount AS DOUBLE))
      comment: "Average monetary value per arbitral award"
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate applied across awards with interest provisions"
    - name: "distinct_matters"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters associated with arbitral awards"
    - name: "distinct_clients"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct clients involved in arbitral awards"
    - name: "matter_closure_trigger_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN matter_closure_trigger_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of awards that triggered matter closure"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`court_service_of_process`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service of process operational efficiency metrics tracking service success rates, compliance timeliness, objection rates, cost per service, and international service complexity for litigation support operations."
  source: "`legal_ecm`.`court`.`service_of_process`"
  dimensions:
    - name: "service_status"
      expr: service_status
      comment: "Current status of the service of process (completed, pending, failed, etc.)"
    - name: "service_method"
      expr: service_method
      comment: "Method used to serve process (personal, substituted, certified mail, electronic, etc.)"
    - name: "document_type"
      expr: document_type
      comment: "Type of legal document being served"
    - name: "party_served_role"
      expr: party_served_role
      comment: "Role of the party being served (defendant, witness, third party, etc.)"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction code where service is being executed"
    - name: "service_country_code"
      expr: service_country_code
      comment: "Country code where service is being executed"
    - name: "hague_convention_applicable"
      expr: hague_convention_flag
      comment: "Whether the Hague Service Convention applies to this service"
    - name: "objection_filed"
      expr: objection_filed_flag
      comment: "Whether an objection to service was filed"
    - name: "service_validity_status"
      expr: service_validity_status
      comment: "Validity status of the service (valid, invalid, contested, etc.)"
    - name: "esi_ediscovery_flag"
      expr: esi_ediscovery_flag
      comment: "Whether electronically stored information (ESI) or e-discovery is involved"
    - name: "service_year"
      expr: YEAR(service_date)
      comment: "Year the service was executed"
    - name: "service_quarter"
      expr: CONCAT('Q', QUARTER(service_date), '-', YEAR(service_date))
      comment: "Quarter and year the service was executed"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month the service was executed"
    - name: "proof_filed_year"
      expr: YEAR(proof_of_service_filed_date)
      comment: "Year the proof of service was filed"
  measures:
    - name: "total_service_attempts"
      expr: COUNT(1)
      comment: "Total number of service of process attempts"
    - name: "total_service_cost"
      expr: SUM(CAST(service_cost_amount AS DOUBLE))
      comment: "Total cost incurred for all service of process activities"
    - name: "avg_service_cost"
      expr: AVG(CAST(service_cost_amount AS DOUBLE))
      comment: "Average cost per service of process attempt"
    - name: "objection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN objection_filed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service attempts that resulted in objections being filed"
    - name: "hague_convention_utilization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hague_convention_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service attempts requiring Hague Convention procedures for international service"
    - name: "esi_involvement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN esi_ediscovery_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service attempts involving electronically stored information or e-discovery"
    - name: "distinct_matters"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters requiring service of process"
    - name: "distinct_clients"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct clients for whom service of process was executed"
    - name: "distinct_process_servers"
      expr: COUNT(DISTINCT process_server_license_number)
      comment: "Number of distinct licensed process servers utilized"
$$;