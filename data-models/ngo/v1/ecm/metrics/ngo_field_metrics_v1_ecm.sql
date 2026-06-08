-- Metric views for domain: field | Business: Ngo | Version: 1 | Generated on: 2026-05-07 01:23:35

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`field_distribution_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core distribution event metrics tracking beneficiary reach, budget execution, and operational efficiency for humanitarian aid distributions"
  source: "`ngo_ecm`.`field`.`distribution_event`"
  dimensions:
    - name: "distribution_status"
      expr: distribution_status
      comment: "Current status of the distribution event (planned, in-progress, completed, cancelled)"
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (emergency, regular, seasonal)"
    - name: "distribution_modality"
      expr: distribution_modality
      comment: "Modality of distribution (in-kind, cash, voucher, hybrid)"
    - name: "commodity_category"
      expr: commodity_category
      comment: "Category of commodities distributed (food, NFI, WASH, shelter)"
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First-level administrative division (province/state)"
    - name: "admin_level_2"
      expr: admin_level_2
      comment: "Second-level administrative division (district/county)"
    - name: "scheduled_year"
      expr: YEAR(scheduled_date)
      comment: "Year of scheduled distribution"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month of scheduled distribution"
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify beneficiary identity and entitlement"
    - name: "incident_reported_flag"
      expr: incident_reported_flag
      comment: "Whether any incident was reported during distribution"
    - name: "pdm_scheduled_flag"
      expr: pdm_scheduled_flag
      comment: "Whether post-distribution monitoring is scheduled"
    - name: "sitrep_included_flag"
      expr: sitrep_included_flag
      comment: "Whether distribution is included in situation report"
  measures:
    - name: "total_distributions"
      expr: COUNT(1)
      comment: "Total number of distribution events"
    - name: "total_beneficiaries_reached"
      expr: SUM(CAST(actual_beneficiary_count AS BIGINT))
      comment: "Total number of beneficiaries reached across all distributions"
    - name: "total_households_reached"
      expr: SUM(CAST(actual_household_count AS BIGINT))
      comment: "Total number of households reached across all distributions"
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated for distributions in local currency"
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditure across distributions in local currency"
    - name: "avg_beneficiaries_per_distribution"
      expr: AVG(CAST(actual_beneficiary_count AS BIGINT))
      comment: "Average number of beneficiaries reached per distribution event"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_expenditure_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated budget actually spent (budget execution efficiency)"
    - name: "beneficiary_target_achievement_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_beneficiary_count AS BIGINT)) / NULLIF(SUM(CAST(planned_beneficiary_count AS BIGINT)), 0), 2)
      comment: "Percentage of planned beneficiaries actually reached (targeting effectiveness)"
    - name: "distributions_with_incidents"
      expr: SUM(CASE WHEN incident_reported_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of distributions where incidents were reported"
    - name: "incident_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN incident_reported_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of distributions with reported incidents (operational risk indicator)"
    - name: "pdm_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pdm_scheduled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of distributions with post-distribution monitoring scheduled (accountability coverage)"
    - name: "unique_distribution_locations"
      expr: COUNT(DISTINCT distribution_location_name)
      comment: "Number of unique distribution locations (geographic reach)"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`field_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assessment metrics tracking needs assessment quality, coverage, and protection concerns for evidence-based programming"
  source: "`ngo_ecm`.`field`.`assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment (rapid, detailed, baseline, endline, PDM)"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of assessment (planned, ongoing, completed, validated)"
    - name: "methodology"
      expr: methodology
      comment: "Assessment methodology used (survey, FGD, KII, observation)"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of assessment (community, district, regional, national)"
    - name: "protection_concerns_noted"
      expr: protection_concerns_noted
      comment: "Whether protection concerns were identified during assessment"
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether assessment has donor visibility requirements"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year assessment was conducted"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month assessment was conducted"
    - name: "data_collection_tool"
      expr: data_collection_tool
      comment: "Tool used for data collection (KoBoToolbox, ODK, paper)"
    - name: "sample_methodology"
      expr: sample_methodology
      comment: "Sampling methodology used (random, purposive, cluster, convenience)"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of assessments conducted"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across assessments (assessment reliability indicator)"
    - name: "avg_adequacy_score"
      expr: AVG(CAST(adequacy_score AS DOUBLE))
      comment: "Average adequacy score measuring sufficiency of assistance (program effectiveness)"
    - name: "avg_beneficiary_satisfaction_score"
      expr: AVG(CAST(beneficiary_satisfaction_score AS DOUBLE))
      comment: "Average beneficiary satisfaction score (accountability and quality indicator)"
    - name: "avg_utilization_rate"
      expr: AVG(CAST(utilization_rate_percent AS DOUBLE))
      comment: "Average utilization rate of distributed items or services (program efficiency)"
    - name: "assessments_with_protection_concerns"
      expr: SUM(CASE WHEN protection_concerns_noted = TRUE THEN 1 ELSE 0 END)
      comment: "Number of assessments identifying protection concerns"
    - name: "protection_concern_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN protection_concerns_noted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments identifying protection concerns (protection risk prevalence)"
    - name: "total_complaints_received"
      expr: SUM(CAST(complaints_received_count AS BIGINT))
      comment: "Total number of complaints received across assessments (accountability feedback volume)"
    - name: "avg_team_size"
      expr: AVG(CAST(team_size AS BIGINT))
      comment: "Average assessment team size (resource deployment indicator)"
    - name: "avg_sample_size"
      expr: AVG(CAST(sample_size AS BIGINT))
      comment: "Average sample size per assessment (statistical robustness indicator)"
    - name: "validated_assessments"
      expr: SUM(CASE WHEN validation_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of assessments that have been validated"
    - name: "validation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN validation_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments validated (quality assurance coverage)"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`field_security_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Security incident metrics tracking staff safety, asset loss, and incident response effectiveness for humanitarian operations"
  source: "`ngo_ecm`.`field`.`security_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of security incident (theft, assault, kidnapping, armed conflict, etc.)"
    - name: "incident_severity"
      expr: incident_severity
      comment: "Severity level of incident (low, medium, high, critical)"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of incident (reported, under investigation, closed)"
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First-level administrative division where incident occurred"
    - name: "admin_level_2"
      expr: admin_level_2
      comment: "Second-level administrative division where incident occurred"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year incident occurred"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month incident occurred"
    - name: "reported_to_undss"
      expr: reported_to_undss
      comment: "Whether incident was reported to UN Department of Safety and Security"
    - name: "reported_to_local_authorities"
      expr: reported_to_local_authorities
      comment: "Whether incident was reported to local authorities"
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of incident investigation"
    - name: "sitrep_included"
      expr: sitrep_included
      comment: "Whether incident was included in situation report"
  measures:
    - name: "total_security_incidents"
      expr: COUNT(1)
      comment: "Total number of security incidents reported"
    - name: "total_staff_affected"
      expr: SUM(CAST(affected_personnel_count AS BIGINT))
      comment: "Total number of staff members affected by security incidents"
    - name: "total_staff_injured"
      expr: SUM(CAST(staff_injured_count AS BIGINT))
      comment: "Total number of staff members injured in security incidents (staff safety indicator)"
    - name: "total_staff_fatalities"
      expr: SUM(CAST(staff_fatality_count AS BIGINT))
      comment: "Total number of staff fatalities from security incidents (critical safety metric)"
    - name: "total_estimated_asset_loss"
      expr: SUM(CAST(estimated_asset_loss_usd AS DOUBLE))
      comment: "Total estimated asset loss in USD from security incidents (financial impact)"
    - name: "avg_asset_loss_per_incident"
      expr: AVG(CAST(estimated_asset_loss_usd AS DOUBLE))
      comment: "Average asset loss per security incident in USD"
    - name: "critical_severity_incidents"
      expr: SUM(CASE WHEN incident_severity = 'critical' THEN 1 ELSE 0 END)
      comment: "Number of critical severity security incidents"
    - name: "high_severity_incidents"
      expr: SUM(CASE WHEN incident_severity = 'high' THEN 1 ELSE 0 END)
      comment: "Number of high severity security incidents"
    - name: "undss_reporting_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reported_to_undss = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents reported to UNDSS (compliance with UN security protocols)"
    - name: "local_authority_reporting_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reported_to_local_authorities = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents reported to local authorities (local compliance rate)"
    - name: "incident_closure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN case_closed_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that have been closed (incident resolution efficiency)"
    - name: "avg_days_to_closure"
      expr: AVG(DATEDIFF(case_closed_date, incident_date))
      comment: "Average number of days from incident to case closure (response time efficiency)"
    - name: "unique_incident_locations"
      expr: COUNT(DISTINCT incident_location_name)
      comment: "Number of unique locations where incidents occurred (geographic risk spread)"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`field_project_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project site metrics tracking operational infrastructure, accessibility, and site readiness for program delivery"
  source: "`ngo_ecm`.`field`.`project_site`"
  dimensions:
    - name: "site_type"
      expr: site_type
      comment: "Type of project site (office, warehouse, health facility, distribution point, camp)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of site (active, inactive, under construction, decommissioned)"
    - name: "security_level"
      expr: security_level
      comment: "Security risk level at site location (low, medium, high, critical)"
    - name: "accessibility_rating"
      expr: accessibility_rating
      comment: "Accessibility rating for site (easy, moderate, difficult, very difficult)"
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First-level administrative division of site"
    - name: "admin_level_2"
      expr: admin_level_2
      comment: "Second-level administrative division of site"
    - name: "cluster_affiliation"
      expr: cluster_affiliation
      comment: "Humanitarian cluster affiliation of site"
    - name: "electricity_available"
      expr: electricity_available
      comment: "Whether electricity is available at site"
    - name: "water_source_available"
      expr: water_source_available
      comment: "Whether water source is available at site"
    - name: "internet_connectivity"
      expr: internet_connectivity
      comment: "Type of internet connectivity at site (none, mobile, satellite, fiber)"
    - name: "facility_ownership"
      expr: facility_ownership
      comment: "Ownership type of facility (owned, rented, government-provided, partner)"
    - name: "establishment_year"
      expr: YEAR(establishment_date)
      comment: "Year site was established"
  measures:
    - name: "total_project_sites"
      expr: COUNT(1)
      comment: "Total number of project sites"
    - name: "active_sites"
      expr: SUM(CASE WHEN operational_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of currently active project sites"
    - name: "site_activation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN operational_status = 'active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites that are operationally active (infrastructure utilization)"
    - name: "total_site_area"
      expr: SUM(CAST(site_area_sqm AS DOUBLE))
      comment: "Total site area in square meters across all sites"
    - name: "avg_site_area"
      expr: AVG(CAST(site_area_sqm AS DOUBLE))
      comment: "Average site area in square meters"
    - name: "sites_with_electricity"
      expr: SUM(CASE WHEN electricity_available = TRUE THEN 1 ELSE 0 END)
      comment: "Number of sites with electricity available"
    - name: "electricity_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN electricity_available = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites with electricity (infrastructure readiness indicator)"
    - name: "sites_with_water"
      expr: SUM(CASE WHEN water_source_available = TRUE THEN 1 ELSE 0 END)
      comment: "Number of sites with water source available"
    - name: "water_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN water_source_available = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites with water source (infrastructure readiness indicator)"
    - name: "sites_with_internet"
      expr: SUM(CASE WHEN internet_connectivity IS NOT NULL AND internet_connectivity != 'none' THEN 1 ELSE 0 END)
      comment: "Number of sites with internet connectivity"
    - name: "internet_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN internet_connectivity IS NOT NULL AND internet_connectivity != 'none' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites with internet connectivity (digital readiness indicator)"
    - name: "high_security_risk_sites"
      expr: SUM(CASE WHEN security_level IN ('high', 'critical') THEN 1 ELSE 0 END)
      comment: "Number of sites in high or critical security risk areas"
    - name: "high_security_risk_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN security_level IN ('high', 'critical') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites in high-risk security areas (operational risk exposure)"
    - name: "avg_population_catchment"
      expr: AVG(CAST(population_catchment AS BIGINT))
      comment: "Average population catchment area served by sites (coverage reach indicator)"
    - name: "unique_admin_level_1_coverage"
      expr: COUNT(DISTINCT admin_level_1)
      comment: "Number of unique first-level administrative divisions covered (geographic reach)"
    - name: "unique_admin_level_2_coverage"
      expr: COUNT(DISTINCT admin_level_2)
      comment: "Number of unique second-level administrative divisions covered (geographic reach)"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`field_emergency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Emergency response metrics tracking crisis scale, funding gaps, and humanitarian response effectiveness"
  source: "`ngo_ecm`.`field`.`emergency`"
  dimensions:
    - name: "emergency_type"
      expr: emergency_type
      comment: "Type of emergency (natural disaster, conflict, epidemic, complex emergency)"
    - name: "disaster_category"
      expr: disaster_category
      comment: "Category of disaster (earthquake, flood, drought, cyclone, conflict, etc.)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of emergency (minor, moderate, severe, catastrophic)"
    - name: "status"
      expr: status
      comment: "Current status of emergency response (active, monitoring, closed)"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of emergency (local, regional, national, multi-country)"
    - name: "is_active"
      expr: is_active
      comment: "Whether emergency is currently active"
    - name: "hrp_issued"
      expr: hrp_issued
      comment: "Whether Humanitarian Response Plan has been issued"
    - name: "flash_appeal_issued"
      expr: flash_appeal_issued
      comment: "Whether Flash Appeal has been issued"
    - name: "cerf_allocation_received"
      expr: cerf_allocation_received
      comment: "Whether Central Emergency Response Fund allocation was received"
    - name: "declaration_year"
      expr: YEAR(declaration_date)
      comment: "Year emergency was declared"
    - name: "onset_year"
      expr: YEAR(onset_date)
      comment: "Year emergency onset occurred"
    - name: "response_modality"
      expr: response_modality
      comment: "Modality of response (direct implementation, partnership, remote management)"
  measures:
    - name: "total_emergencies"
      expr: COUNT(1)
      comment: "Total number of emergencies tracked"
    - name: "active_emergencies"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Number of currently active emergencies"
    - name: "total_affected_population"
      expr: SUM(CAST(affected_population_count AS BIGINT))
      comment: "Total population affected across all emergencies (crisis scale indicator)"
    - name: "total_displaced_population"
      expr: SUM(CAST(displaced_population_count AS BIGINT))
      comment: "Total displaced population across all emergencies (displacement crisis scale)"
    - name: "total_targeted_beneficiaries"
      expr: SUM(CAST(targeted_beneficiaries_count AS BIGINT))
      comment: "Total beneficiaries targeted for assistance across emergencies"
    - name: "total_funding_requirement"
      expr: SUM(CAST(funding_requirement_usd AS DOUBLE))
      comment: "Total funding requirement in USD across all emergencies"
    - name: "total_funding_received"
      expr: SUM(CAST(funding_received_usd AS DOUBLE))
      comment: "Total funding received in USD across all emergencies"
    - name: "funding_gap"
      expr: SUM((CAST(funding_requirement_usd AS DOUBLE)) - (CAST(funding_received_usd AS DOUBLE)))
      comment: "Total funding gap in USD (unmet funding needs)"
    - name: "funding_coverage_rate"
      expr: ROUND(100.0 * SUM(CAST(funding_received_usd AS DOUBLE)) / NULLIF(SUM(CAST(funding_requirement_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of funding requirement met (resource mobilization effectiveness)"
    - name: "beneficiary_coverage_rate"
      expr: ROUND(100.0 * SUM(CAST(targeted_beneficiaries_count AS BIGINT)) / NULLIF(SUM(CAST(affected_population_count AS BIGINT)), 0), 2)
      comment: "Percentage of affected population targeted for assistance (response coverage)"
    - name: "avg_implementing_partners"
      expr: AVG(CAST(implementing_partners_count AS BIGINT))
      comment: "Average number of implementing partners per emergency (coordination scale)"
    - name: "hrp_issuance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hrp_issued = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of emergencies with Humanitarian Response Plan issued (strategic planning coverage)"
    - name: "flash_appeal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN flash_appeal_issued = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of emergencies with Flash Appeal issued (rapid response activation rate)"
    - name: "cerf_allocation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cerf_allocation_received = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of emergencies receiving CERF allocation (emergency funding access rate)"
    - name: "avg_response_duration_days"
      expr: AVG(DATEDIFF(response_end_date, response_start_date))
      comment: "Average duration of emergency response in days (response timeline indicator)"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`field_access_constraint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Access constraint metrics tracking operational impediments, severity, and impact on program delivery"
  source: "`ngo_ecm`.`field`.`access_constraint`"
  dimensions:
    - name: "constraint_type"
      expr: constraint_type
      comment: "Type of access constraint (security, administrative, physical, political)"
    - name: "constraint_status"
      expr: constraint_status
      comment: "Current status of constraint (active, resolved, escalated, monitoring)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of constraint (low, medium, high, critical)"
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First-level administrative division affected"
    - name: "admin_level_2"
      expr: admin_level_2
      comment: "Second-level administrative division affected"
    - name: "alternative_route_available"
      expr: alternative_route_available
      comment: "Whether alternative route or approach is available"
    - name: "negotiation_required"
      expr: negotiation_required
      comment: "Whether negotiation with authorities or armed actors is required"
    - name: "donor_notification_required"
      expr: donor_notification_required
      comment: "Whether donor notification is required for this constraint"
    - name: "security_incident_linked"
      expr: security_incident_linked
      comment: "Whether constraint is linked to a security incident"
    - name: "escalation_status"
      expr: escalation_status
      comment: "Escalation status of constraint (none, escalated, resolved)"
    - name: "constraint_year"
      expr: YEAR(constraint_start_date)
      comment: "Year constraint started"
    - name: "constraint_month"
      expr: DATE_TRUNC('MONTH', constraint_start_date)
      comment: "Month constraint started"
  measures:
    - name: "total_access_constraints"
      expr: COUNT(1)
      comment: "Total number of access constraints reported"
    - name: "active_constraints"
      expr: SUM(CASE WHEN constraint_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of currently active access constraints"
    - name: "critical_severity_constraints"
      expr: SUM(CASE WHEN severity_level = 'critical' THEN 1 ELSE 0 END)
      comment: "Number of critical severity access constraints"
    - name: "high_severity_constraints"
      expr: SUM(CASE WHEN severity_level = 'high' THEN 1 ELSE 0 END)
      comment: "Number of high severity access constraints"
    - name: "constraints_with_alternatives"
      expr: SUM(CASE WHEN alternative_route_available = TRUE THEN 1 ELSE 0 END)
      comment: "Number of constraints with alternative routes available"
    - name: "alternative_availability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN alternative_route_available = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of constraints with alternative routes (operational flexibility indicator)"
    - name: "constraints_requiring_negotiation"
      expr: SUM(CASE WHEN negotiation_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of constraints requiring negotiation"
    - name: "negotiation_requirement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN negotiation_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of constraints requiring negotiation (access diplomacy workload)"
    - name: "constraints_linked_to_security"
      expr: SUM(CASE WHEN security_incident_linked = TRUE THEN 1 ELSE 0 END)
      comment: "Number of constraints linked to security incidents"
    - name: "security_linkage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN security_incident_linked = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of constraints linked to security incidents (security-driven access impediment rate)"
    - name: "escalated_constraints"
      expr: SUM(CASE WHEN escalation_status = 'escalated' THEN 1 ELSE 0 END)
      comment: "Number of constraints that have been escalated"
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_status = 'escalated' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of constraints requiring escalation (access challenge severity indicator)"
    - name: "avg_constraint_duration_days"
      expr: AVG(DATEDIFF(constraint_end_date, constraint_start_date))
      comment: "Average duration of access constraints in days (constraint resolution time)"
    - name: "resolved_constraints"
      expr: SUM(CASE WHEN constraint_status = 'resolved' THEN 1 ELSE 0 END)
      comment: "Number of resolved access constraints"
    - name: "resolution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN constraint_status = 'resolved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of constraints resolved (access negotiation effectiveness)"
    - name: "unique_affected_locations"
      expr: COUNT(DISTINCT affected_location_name)
      comment: "Number of unique locations affected by access constraints (geographic access challenge spread)"
$$;