-- Cross-Domain Foreign Keys for Business: Ngo | Version: v1_mvm
-- Generated on: 2026-05-07 03:36:32
-- Total cross-domain FK constraints: 1048
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: beneficiary, compliance, donor, field, finance, grant, mel, partnership, program, supply, volunteer, workforce

-- ========= beneficiary --> compliance (18 constraint(s)) =========
-- Requires: beneficiary schema, compliance schema
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ADD CONSTRAINT `fk_beneficiary_registrant_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `ngo_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `ngo_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `ngo_ecm`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `ngo_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `ngo_ecm`.`compliance`.`statutory_registration`(`statutory_registration_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `ngo_ecm`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `ngo_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `ngo_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ADD CONSTRAINT `fk_beneficiary_protection_flag_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ADD CONSTRAINT `fk_beneficiary_protection_flag_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `ngo_ecm`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ADD CONSTRAINT `fk_beneficiary_protection_flag_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `ngo_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ADD CONSTRAINT `fk_beneficiary_document_record_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ADD CONSTRAINT `fk_beneficiary_document_record_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `ngo_ecm`.`compliance`.`incident`(`incident_id`);

-- ========= beneficiary --> field (18 constraint(s)) =========
-- Requires: beneficiary schema, field schema
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ADD CONSTRAINT `fk_beneficiary_registrant_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ADD CONSTRAINT `fk_beneficiary_household_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ADD CONSTRAINT `fk_beneficiary_household_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_field_team_id` FOREIGN KEY (`field_team_id`) REFERENCES `ngo_ecm`.`field`.`field_team`(`field_team_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ADD CONSTRAINT `fk_beneficiary_protection_flag_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ADD CONSTRAINT `fk_beneficiary_protection_flag_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ADD CONSTRAINT `fk_beneficiary_protection_flag_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ADD CONSTRAINT `fk_beneficiary_document_record_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ADD CONSTRAINT `fk_beneficiary_community_field_team_id` FOREIGN KEY (`field_team_id`) REFERENCES `ngo_ecm`.`field`.`field_team`(`field_team_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ADD CONSTRAINT `fk_beneficiary_community_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);

-- ========= beneficiary --> finance (4 constraint(s)) =========
-- Requires: beneficiary schema, finance schema
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ADD CONSTRAINT `fk_beneficiary_community_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= beneficiary --> grant (4 constraint(s)) =========
-- Requires: beneficiary schema, grant schema
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ADD CONSTRAINT `fk_beneficiary_household_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ADD CONSTRAINT `fk_beneficiary_household_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `ngo_ecm`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `ngo_ecm`.`grant`.`subaward`(`subaward_id`);

-- ========= beneficiary --> mel (3 constraint(s)) =========
-- Requires: beneficiary schema, mel schema
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `ngo_ecm`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_data_collection_tool_id` FOREIGN KEY (`data_collection_tool_id`) REFERENCES `ngo_ecm`.`mel`.`data_collection_tool`(`data_collection_tool_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `ngo_ecm`.`mel`.`reporting_period`(`reporting_period_id`);

-- ========= beneficiary --> partnership (9 constraint(s)) =========
-- Requires: beneficiary schema, partnership schema
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_referral_partner_org_id` FOREIGN KEY (`referral_partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ADD CONSTRAINT `fk_beneficiary_community_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= beneficiary --> program (15 constraint(s)) =========
-- Requires: beneficiary schema, program schema
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ADD CONSTRAINT `fk_beneficiary_registrant_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ADD CONSTRAINT `fk_beneficiary_household_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ADD CONSTRAINT `fk_beneficiary_household_member_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ADD CONSTRAINT `fk_beneficiary_protection_flag_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ADD CONSTRAINT `fk_beneficiary_document_record_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ADD CONSTRAINT `fk_beneficiary_community_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);

-- ========= beneficiary --> supply (7 constraint(s)) =========
-- Requires: beneficiary schema, supply schema
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ADD CONSTRAINT `fk_beneficiary_registrant_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `ngo_ecm`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ADD CONSTRAINT `fk_beneficiary_household_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `ngo_ecm`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `ngo_ecm`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_distribution_order_id` FOREIGN KEY (`distribution_order_id`) REFERENCES `ngo_ecm`.`supply`.`distribution_order`(`distribution_order_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `ngo_ecm`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_distribution_order_id` FOREIGN KEY (`distribution_order_id`) REFERENCES `ngo_ecm`.`supply`.`distribution_order`(`distribution_order_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ADD CONSTRAINT `fk_beneficiary_community_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `ngo_ecm`.`supply`.`warehouse`(`warehouse_id`);

-- ========= beneficiary --> volunteer (10 constraint(s)) =========
-- Requires: beneficiary schema, volunteer schema
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ADD CONSTRAINT `fk_beneficiary_household_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `ngo_ecm`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `ngo_ecm`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `ngo_ecm`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `ngo_ecm`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `ngo_ecm`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `ngo_ecm`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `ngo_ecm`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ADD CONSTRAINT `fk_beneficiary_protection_flag_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `ngo_ecm`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ADD CONSTRAINT `fk_beneficiary_document_record_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `ngo_ecm`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ADD CONSTRAINT `fk_beneficiary_community_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `ngo_ecm`.`volunteer`.`volunteer`(`volunteer_id`);

-- ========= beneficiary --> workforce (22 constraint(s)) =========
-- Requires: beneficiary schema, workforce schema
ALTER TABLE `ngo_ecm`.`beneficiary`.`registrant` ADD CONSTRAINT `fk_beneficiary_registrant_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`household` ADD CONSTRAINT `fk_beneficiary_household_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`household_member` ADD CONSTRAINT `fk_beneficiary_household_member_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_position_id` FOREIGN KEY (`position_id`) REFERENCES `ngo_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_position_id` FOREIGN KEY (`position_id`) REFERENCES `ngo_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_position_id` FOREIGN KEY (`position_id`) REFERENCES `ngo_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_referral_staff_member_id` FOREIGN KEY (`referral_staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ADD CONSTRAINT `fk_beneficiary_protection_flag_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`protection_flag` ADD CONSTRAINT `fk_beneficiary_protection_flag_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`document_record` ADD CONSTRAINT `fk_beneficiary_document_record_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ADD CONSTRAINT `fk_beneficiary_community_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`beneficiary`.`community` ADD CONSTRAINT `fk_beneficiary_community_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= compliance --> donor (2 constraint(s)) =========
-- Requires: compliance schema, donor schema
ALTER TABLE `ngo_ecm`.`compliance`.`donor_requirement` ADD CONSTRAINT `fk_compliance_donor_requirement_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `ngo_ecm`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `ngo_ecm`.`donor`.`constituent`(`constituent_id`);

-- ========= compliance --> field (13 constraint(s)) =========
-- Requires: compliance schema, field schema
ALTER TABLE `ngo_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`single_audit` ADD CONSTRAINT `fk_compliance_single_audit_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`governance_policy` ADD CONSTRAINT `fk_compliance_governance_policy_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`donor_requirement` ADD CONSTRAINT `fk_compliance_donor_requirement_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`statutory_registration` ADD CONSTRAINT `fk_compliance_statutory_registration_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`internal_review` ADD CONSTRAINT `fk_compliance_internal_review_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`internal_review` ADD CONSTRAINT `fk_compliance_internal_review_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);

-- ========= compliance --> grant (8 constraint(s)) =========
-- Requires: compliance schema, grant schema
ALTER TABLE `ngo_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `ngo_ecm`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`donor_requirement` ADD CONSTRAINT `fk_compliance_donor_requirement_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `ngo_ecm`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`internal_review` ADD CONSTRAINT `fk_compliance_internal_review_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`internal_review` ADD CONSTRAINT `fk_compliance_internal_review_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `ngo_ecm`.`grant`.`subaward`(`subaward_id`);

-- ========= compliance --> partnership (1 constraint(s)) =========
-- Requires: compliance schema, partnership schema
ALTER TABLE `ngo_ecm`.`compliance`.`single_audit` ADD CONSTRAINT `fk_compliance_single_audit_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= compliance --> program (7 constraint(s)) =========
-- Requires: compliance schema, program schema
ALTER TABLE `ngo_ecm`.`compliance`.`single_audit` ADD CONSTRAINT `fk_compliance_single_audit_program_id` FOREIGN KEY (`program_id`) REFERENCES `ngo_ecm`.`program`.`program`(`program_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`internal_review` ADD CONSTRAINT `fk_compliance_internal_review_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`internal_review` ADD CONSTRAINT `fk_compliance_internal_review_program_id` FOREIGN KEY (`program_id`) REFERENCES `ngo_ecm`.`program`.`program`(`program_id`);

-- ========= compliance --> workforce (11 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `ngo_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_tertiary_corrective_responsible_manager_staff_member_id` FOREIGN KEY (`tertiary_corrective_responsible_manager_staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_tertiary_corrective_staff_member_id` FOREIGN KEY (`tertiary_corrective_staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`governance_policy` ADD CONSTRAINT `fk_compliance_governance_policy_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`donor_requirement` ADD CONSTRAINT `fk_compliance_donor_requirement_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`donor_requirement` ADD CONSTRAINT `fk_compliance_donor_requirement_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`internal_review` ADD CONSTRAINT `fk_compliance_internal_review_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`internal_review` ADD CONSTRAINT `fk_compliance_internal_review_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= donor --> beneficiary (1 constraint(s)) =========
-- Requires: donor schema, beneficiary schema
ALTER TABLE `ngo_ecm`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_community_id` FOREIGN KEY (`community_id`) REFERENCES `ngo_ecm`.`beneficiary`.`community`(`community_id`);

-- ========= donor --> compliance (16 constraint(s)) =========
-- Requires: donor schema, compliance schema
ALTER TABLE `ngo_ecm`.`donor`.`prospect` ADD CONSTRAINT `fk_donor_prospect_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `ngo_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `ngo_ecm`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `ngo_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `ngo_ecm`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `ngo_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `ngo_ecm`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `ngo_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `ngo_ecm`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ngo_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ngo_ecm`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `ngo_ecm`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `ngo_ecm`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `ngo_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `ngo_ecm`.`donor`.`donor_fund` ADD CONSTRAINT `fk_donor_donor_fund_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ngo_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ngo_ecm`.`donor`.`donor_fund` ADD CONSTRAINT `fk_donor_donor_fund_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`donor`.`donor_fund` ADD CONSTRAINT `fk_donor_donor_fund_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `ngo_ecm`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `ngo_ecm`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `ngo_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `ngo_ecm`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ngo_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ngo_ecm`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `ngo_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `ngo_ecm`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `ngo_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= donor --> field (12 constraint(s)) =========
-- Requires: donor schema, field schema
ALTER TABLE `ngo_ecm`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`donor`.`appeal` ADD CONSTRAINT `fk_donor_appeal_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`donor`.`donor_fund` ADD CONSTRAINT `fk_donor_donor_fund_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`donor`.`donor_fund` ADD CONSTRAINT `fk_donor_donor_fund_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);

-- ========= donor --> finance (20 constraint(s)) =========
-- Requires: donor schema, finance schema
ALTER TABLE `ngo_ecm`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `ngo_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `ngo_ecm`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ngo_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ngo_ecm`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_receivable_id` FOREIGN KEY (`receivable_id`) REFERENCES `ngo_ecm`.`finance`.`receivable`(`receivable_id`);
ALTER TABLE `ngo_ecm`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ngo_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ngo_ecm`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_receivable_id` FOREIGN KEY (`receivable_id`) REFERENCES `ngo_ecm`.`finance`.`receivable`(`receivable_id`);
ALTER TABLE `ngo_ecm`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `ngo_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `ngo_ecm`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`donor`.`appeal` ADD CONSTRAINT `fk_donor_appeal_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`donor`.`appeal` ADD CONSTRAINT `fk_donor_appeal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`donor`.`donor_fund` ADD CONSTRAINT `fk_donor_donor_fund_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `ngo_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `ngo_ecm`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= donor --> grant (1 constraint(s)) =========
-- Requires: donor schema, grant schema
ALTER TABLE `ngo_ecm`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);

-- ========= donor --> mel (6 constraint(s)) =========
-- Requires: donor schema, mel schema
ALTER TABLE `ngo_ecm`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_indicator_target_id` FOREIGN KEY (`indicator_target_id`) REFERENCES `ngo_ecm`.`mel`.`indicator_target`(`indicator_target_id`);
ALTER TABLE `ngo_ecm`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_indicator_target_id` FOREIGN KEY (`indicator_target_id`) REFERENCES `ngo_ecm`.`mel`.`indicator_target`(`indicator_target_id`);
ALTER TABLE `ngo_ecm`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_evaluation_finding_id` FOREIGN KEY (`evaluation_finding_id`) REFERENCES `ngo_ecm`.`mel`.`evaluation_finding`(`evaluation_finding_id`);
ALTER TABLE `ngo_ecm`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `ngo_ecm`.`mel`.`evaluation`(`evaluation_id`);
ALTER TABLE `ngo_ecm`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_indicator_result_id` FOREIGN KEY (`indicator_result_id`) REFERENCES `ngo_ecm`.`mel`.`indicator_result`(`indicator_result_id`);
ALTER TABLE `ngo_ecm`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `ngo_ecm`.`mel`.`reporting_period`(`reporting_period_id`);

-- ========= donor --> program (2 constraint(s)) =========
-- Requires: donor schema, program schema
ALTER TABLE `ngo_ecm`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);

-- ========= donor --> supply (1 constraint(s)) =========
-- Requires: donor schema, supply schema
ALTER TABLE `ngo_ecm`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `ngo_ecm`.`supply`.`distribution_plan`(`distribution_plan_id`);

-- ========= donor --> workforce (15 constraint(s)) =========
-- Requires: donor schema, workforce schema
ALTER TABLE `ngo_ecm`.`donor`.`prospect` ADD CONSTRAINT `fk_donor_prospect_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`donor`.`prospect` ADD CONSTRAINT `fk_donor_prospect_prospect_staff_member_id` FOREIGN KEY (`prospect_staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`donor`.`appeal` ADD CONSTRAINT `fk_donor_appeal_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`donor`.`donor_fund` ADD CONSTRAINT `fk_donor_donor_fund_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`donor`.`segment` ADD CONSTRAINT `fk_donor_segment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`donor`.`segment` ADD CONSTRAINT `fk_donor_segment_segment_created_by_staff_staff_member_id` FOREIGN KEY (`segment_created_by_staff_staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`donor`.`segment` ADD CONSTRAINT `fk_donor_segment_segment_last_modified_by_staff_staff_member_id` FOREIGN KEY (`segment_last_modified_by_staff_staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`donor`.`segment` ADD CONSTRAINT `fk_donor_segment_segment_staff_member_id` FOREIGN KEY (`segment_staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`donor`.`portfolio_assignment` ADD CONSTRAINT `fk_donor_portfolio_assignment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`donor`.`fundraising_event` ADD CONSTRAINT `fk_donor_fundraising_event_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= field --> beneficiary (4 constraint(s)) =========
-- Requires: field schema, beneficiary schema
ALTER TABLE `ngo_ecm`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_household_id` FOREIGN KEY (`household_id`) REFERENCES `ngo_ecm`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `ngo_ecm`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `ngo_ecm`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `ngo_ecm`.`field`.`assessment_response` ADD CONSTRAINT `fk_field_assessment_response_household_id` FOREIGN KEY (`household_id`) REFERENCES `ngo_ecm`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `ngo_ecm`.`field`.`assessment_response` ADD CONSTRAINT `fk_field_assessment_response_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `ngo_ecm`.`beneficiary`.`registrant`(`registrant_id`);

-- ========= field --> compliance (14 constraint(s)) =========
-- Requires: field schema, compliance schema
ALTER TABLE `ngo_ecm`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ngo_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ngo_ecm`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `ngo_ecm`.`compliance`.`statutory_registration`(`statutory_registration_id`);
ALTER TABLE `ngo_ecm`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`field`.`distribution_line` ADD CONSTRAINT `fk_field_distribution_line_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_internal_review_id` FOREIGN KEY (`internal_review_id`) REFERENCES `ngo_ecm`.`compliance`.`internal_review`(`internal_review_id`);
ALTER TABLE `ngo_ecm`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ngo_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ngo_ecm`.`field`.`field_team` ADD CONSTRAINT `fk_field_field_team_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `ngo_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `ngo_ecm`.`field`.`field_deployment` ADD CONSTRAINT `fk_field_field_deployment_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`field`.`access_constraint` ADD CONSTRAINT `fk_field_access_constraint_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `ngo_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `ngo_ecm`.`field`.`security_incident` ADD CONSTRAINT `fk_field_security_incident_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `ngo_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `ngo_ecm`.`field`.`country` ADD CONSTRAINT `fk_field_country_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ngo_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ngo_ecm`.`field`.`emergency` ADD CONSTRAINT `fk_field_emergency_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ngo_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= field --> finance (15 constraint(s)) =========
-- Requires: field schema, finance schema
ALTER TABLE `ngo_ecm`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`field`.`country_office` ADD CONSTRAINT `fk_field_country_office_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`field`.`distribution_line` ADD CONSTRAINT `fk_field_distribution_line_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`field`.`distribution_line` ADD CONSTRAINT `fk_field_distribution_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`field`.`field_team` ADD CONSTRAINT `fk_field_field_team_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`field`.`field_deployment` ADD CONSTRAINT `fk_field_field_deployment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`field`.`field_deployment` ADD CONSTRAINT `fk_field_field_deployment_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`field`.`emergency` ADD CONSTRAINT `fk_field_emergency_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);

-- ========= field --> grant (8 constraint(s)) =========
-- Requires: field schema, grant schema
ALTER TABLE `ngo_ecm`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`field`.`distribution_line` ADD CONSTRAINT `fk_field_distribution_line_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`field`.`field_team` ADD CONSTRAINT `fk_field_field_team_funding_source_id` FOREIGN KEY (`funding_source_id`) REFERENCES `ngo_ecm`.`grant`.`funding_source`(`funding_source_id`);
ALTER TABLE `ngo_ecm`.`field`.`field_deployment` ADD CONSTRAINT `fk_field_field_deployment_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`field`.`access_constraint` ADD CONSTRAINT `fk_field_access_constraint_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`field`.`security_incident` ADD CONSTRAINT `fk_field_security_incident_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);

-- ========= field --> mel (8 constraint(s)) =========
-- Requires: field schema, mel schema
ALTER TABLE `ngo_ecm`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_meal_plan_id` FOREIGN KEY (`meal_plan_id`) REFERENCES `ngo_ecm`.`mel`.`meal_plan`(`meal_plan_id`);
ALTER TABLE `ngo_ecm`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `ngo_ecm`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `ngo_ecm`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `ngo_ecm`.`mel`.`evaluation`(`evaluation_id`);
ALTER TABLE `ngo_ecm`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `ngo_ecm`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `ngo_ecm`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_meal_plan_id` FOREIGN KEY (`meal_plan_id`) REFERENCES `ngo_ecm`.`mel`.`meal_plan`(`meal_plan_id`);
ALTER TABLE `ngo_ecm`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `ngo_ecm`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `ngo_ecm`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `ngo_ecm`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `ngo_ecm`.`field`.`field_deployment` ADD CONSTRAINT `fk_field_field_deployment_meal_plan_id` FOREIGN KEY (`meal_plan_id`) REFERENCES `ngo_ecm`.`mel`.`meal_plan`(`meal_plan_id`);

-- ========= field --> partnership (19 constraint(s)) =========
-- Requires: field schema, partnership schema
ALTER TABLE `ngo_ecm`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`field`.`distribution_line` ADD CONSTRAINT `fk_field_distribution_line_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`field`.`distribution_line` ADD CONSTRAINT `fk_field_distribution_line_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`field`.`field_team` ADD CONSTRAINT `fk_field_field_team_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`field`.`field_team` ADD CONSTRAINT `fk_field_field_team_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`field`.`field_deployment` ADD CONSTRAINT `fk_field_field_deployment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`field`.`field_deployment` ADD CONSTRAINT `fk_field_field_deployment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`field`.`access_constraint` ADD CONSTRAINT `fk_field_access_constraint_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`field`.`access_constraint` ADD CONSTRAINT `fk_field_access_constraint_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`field`.`security_incident` ADD CONSTRAINT `fk_field_security_incident_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`field`.`security_incident` ADD CONSTRAINT `fk_field_security_incident_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`field`.`emergency` ADD CONSTRAINT `fk_field_emergency_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= field --> program (7 constraint(s)) =========
-- Requires: field schema, program schema
ALTER TABLE `ngo_ecm`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`field`.`field_deployment` ADD CONSTRAINT `fk_field_field_deployment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`field`.`access_constraint` ADD CONSTRAINT `fk_field_access_constraint_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`field`.`security_incident` ADD CONSTRAINT `fk_field_security_incident_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);

-- ========= field --> supply (2 constraint(s)) =========
-- Requires: field schema, supply schema
ALTER TABLE `ngo_ecm`.`field`.`access_constraint` ADD CONSTRAINT `fk_field_access_constraint_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `ngo_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `ngo_ecm`.`field`.`security_incident` ADD CONSTRAINT `fk_field_security_incident_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `ngo_ecm`.`supply`.`shipment`(`shipment_id`);

-- ========= field --> workforce (15 constraint(s)) =========
-- Requires: field schema, workforce schema
ALTER TABLE `ngo_ecm`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`field`.`country_office` ADD CONSTRAINT `fk_field_country_office_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`field`.`assessment_response` ADD CONSTRAINT `fk_field_assessment_response_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_sitrep_staff_member_id` FOREIGN KEY (`sitrep_staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`field`.`field_team` ADD CONSTRAINT `fk_field_field_team_position_id` FOREIGN KEY (`position_id`) REFERENCES `ngo_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `ngo_ecm`.`field`.`field_team` ADD CONSTRAINT `fk_field_field_team_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`field`.`field_team` ADD CONSTRAINT `fk_field_field_team_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`field`.`field_deployment` ADD CONSTRAINT `fk_field_field_deployment_position_id` FOREIGN KEY (`position_id`) REFERENCES `ngo_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `ngo_ecm`.`field`.`field_deployment` ADD CONSTRAINT `fk_field_field_deployment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`field`.`access_constraint` ADD CONSTRAINT `fk_field_access_constraint_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`field`.`security_incident` ADD CONSTRAINT `fk_field_security_incident_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`field`.`emergency` ADD CONSTRAINT `fk_field_emergency_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= finance --> compliance (11 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ADD CONSTRAINT `fk_finance_finance_fund_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ngo_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ngo_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ngo_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ngo_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `ngo_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `ngo_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ADD CONSTRAINT `fk_finance_payable_payment_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `ngo_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ADD CONSTRAINT `fk_finance_grant_budget_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `ngo_ecm`.`compliance`.`statutory_registration`(`statutory_registration_id`);

-- ========= finance --> donor (8 constraint(s)) =========
-- Requires: finance schema, donor schema
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ADD CONSTRAINT `fk_finance_finance_fund_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `ngo_ecm`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `ngo_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `ngo_ecm`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `ngo_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_donor_fund_id` FOREIGN KEY (`donor_fund_id`) REFERENCES `ngo_ecm`.`donor`.`donor_fund`(`donor_fund_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `ngo_ecm`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_donor_fund_id` FOREIGN KEY (`donor_fund_id`) REFERENCES `ngo_ecm`.`donor`.`donor_fund`(`donor_fund_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ADD CONSTRAINT `fk_finance_receivable_receipt_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `ngo_ecm`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ADD CONSTRAINT `fk_finance_grant_budget_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `ngo_ecm`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `ngo_ecm`.`donor`.`constituent`(`constituent_id`);

-- ========= finance --> field (19 constraint(s)) =========
-- Requires: finance schema, field schema
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_field_deployment_id` FOREIGN KEY (`field_deployment_id`) REFERENCES `ngo_ecm`.`field`.`field_deployment`(`field_deployment_id`);
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_field_team_id` FOREIGN KEY (`field_team_id`) REFERENCES `ngo_ecm`.`field`.`field_team`(`field_team_id`);
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `ngo_ecm`.`field`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_field_deployment_id` FOREIGN KEY (`field_deployment_id`) REFERENCES `ngo_ecm`.`field`.`field_deployment`(`field_deployment_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ADD CONSTRAINT `fk_finance_grant_budget_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ADD CONSTRAINT `fk_finance_grant_budget_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_field_team_id` FOREIGN KEY (`field_team_id`) REFERENCES `ngo_ecm`.`field`.`field_team`(`field_team_id`);
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);

-- ========= finance --> grant (13 constraint(s)) =========
-- Requires: finance schema, grant schema
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ADD CONSTRAINT `fk_finance_finance_fund_funding_source_id` FOREIGN KEY (`funding_source_id`) REFERENCES `ngo_ecm`.`grant`.`funding_source`(`funding_source_id`);
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `ngo_ecm`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ADD CONSTRAINT `fk_finance_payable_payment_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ADD CONSTRAINT `fk_finance_receivable_receipt_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ADD CONSTRAINT `fk_finance_grant_budget_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);

-- ========= finance --> program (3 constraint(s)) =========
-- Requires: finance schema, program schema
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ADD CONSTRAINT `fk_finance_grant_budget_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);

-- ========= finance --> supply (9 constraint(s)) =========
-- Requires: finance schema, supply schema
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `ngo_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `ngo_ecm`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `ngo_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `ngo_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `ngo_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `ngo_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_waybill_id` FOREIGN KEY (`waybill_id`) REFERENCES `ngo_ecm`.`supply`.`waybill`(`waybill_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ADD CONSTRAINT `fk_finance_payable_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `ngo_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_distribution_order_id` FOREIGN KEY (`distribution_order_id`) REFERENCES `ngo_ecm`.`supply`.`distribution_order`(`distribution_order_id`);

-- ========= finance --> workforce (11 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ADD CONSTRAINT `fk_finance_finance_fund_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ADD CONSTRAINT `fk_finance_receivable_receipt_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ADD CONSTRAINT `fk_finance_grant_budget_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ADD CONSTRAINT `fk_finance_grant_budget_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= grant --> compliance (5 constraint(s)) =========
-- Requires: grant schema, compliance schema
ALTER TABLE `ngo_ecm`.`grant`.`grant_amendment` ADD CONSTRAINT `fk_grant_grant_amendment_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_single_audit_id` FOREIGN KEY (`single_audit_id`) REFERENCES `ngo_ecm`.`compliance`.`single_audit`(`single_audit_id`);
ALTER TABLE `ngo_ecm`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ngo_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ngo_ecm`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `ngo_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `ngo_ecm`.`grant`.`cost_share_commitment` ADD CONSTRAINT `fk_grant_cost_share_commitment_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);

-- ========= grant --> donor (9 constraint(s)) =========
-- Requires: grant schema, donor schema
ALTER TABLE `ngo_ecm`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `ngo_ecm`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `ngo_ecm`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `ngo_ecm`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `ngo_ecm`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `ngo_ecm`.`donor`.`prospect`(`prospect_id`);
ALTER TABLE `ngo_ecm`.`grant`.`grant_amendment` ADD CONSTRAINT `fk_grant_grant_amendment_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `ngo_ecm`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `ngo_ecm`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `ngo_ecm`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `ngo_ecm`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `ngo_ecm`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `ngo_ecm`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_donor_fund_id` FOREIGN KEY (`donor_fund_id`) REFERENCES `ngo_ecm`.`donor`.`donor_fund`(`donor_fund_id`);
ALTER TABLE `ngo_ecm`.`grant`.`funding_source` ADD CONSTRAINT `fk_grant_funding_source_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `ngo_ecm`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `ngo_ecm`.`grant`.`cost_share_commitment` ADD CONSTRAINT `fk_grant_cost_share_commitment_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `ngo_ecm`.`donor`.`constituent`(`constituent_id`);

-- ========= grant --> field (11 constraint(s)) =========
-- Requires: grant schema, field schema
ALTER TABLE `ngo_ecm`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`grant`.`cost_share_commitment` ADD CONSTRAINT `fk_grant_cost_share_commitment_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);

-- ========= grant --> finance (17 constraint(s)) =========
-- Requires: grant schema, finance schema
ALTER TABLE `ngo_ecm`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `ngo_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `ngo_ecm`.`grant`.`award_budget` ADD CONSTRAINT `fk_grant_award_budget_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `ngo_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `ngo_ecm`.`grant`.`award_budget` ADD CONSTRAINT `fk_grant_award_budget_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`grant`.`award_budget` ADD CONSTRAINT `fk_grant_award_budget_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`grant`.`grant_amendment` ADD CONSTRAINT `fk_grant_grant_amendment_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`grant`.`cost_share_commitment` ADD CONSTRAINT `fk_grant_cost_share_commitment_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`grant`.`cost_share_commitment` ADD CONSTRAINT `fk_grant_cost_share_commitment_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`grant`.`cost_share_commitment` ADD CONSTRAINT `fk_grant_cost_share_commitment_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);

-- ========= grant --> mel (10 constraint(s)) =========
-- Requires: grant schema, mel schema
ALTER TABLE `ngo_ecm`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_logframe_id` FOREIGN KEY (`logframe_id`) REFERENCES `ngo_ecm`.`mel`.`logframe`(`logframe_id`);
ALTER TABLE `ngo_ecm`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `ngo_ecm`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `ngo_ecm`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `ngo_ecm`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `ngo_ecm`.`grant`.`grant_amendment` ADD CONSTRAINT `fk_grant_grant_amendment_logframe_id` FOREIGN KEY (`logframe_id`) REFERENCES `ngo_ecm`.`mel`.`logframe`(`logframe_id`);
ALTER TABLE `ngo_ecm`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `ngo_ecm`.`mel`.`evaluation`(`evaluation_id`);
ALTER TABLE `ngo_ecm`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `ngo_ecm`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `ngo_ecm`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_indicator_target_id` FOREIGN KEY (`indicator_target_id`) REFERENCES `ngo_ecm`.`mel`.`indicator_target`(`indicator_target_id`);
ALTER TABLE `ngo_ecm`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `ngo_ecm`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `ngo_ecm`.`grant`.`cost_share_commitment` ADD CONSTRAINT `fk_grant_cost_share_commitment_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `ngo_ecm`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `ngo_ecm`.`grant`.`cost_share_commitment` ADD CONSTRAINT `fk_grant_cost_share_commitment_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `ngo_ecm`.`mel`.`reporting_period`(`reporting_period_id`);

-- ========= grant --> partnership (8 constraint(s)) =========
-- Requires: grant schema, partnership schema
ALTER TABLE `ngo_ecm`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`grant`.`grant_amendment` ADD CONSTRAINT `fk_grant_grant_amendment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`grant`.`funding_source` ADD CONSTRAINT `fk_grant_funding_source_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`grant`.`cost_share_commitment` ADD CONSTRAINT `fk_grant_cost_share_commitment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`grant`.`cost_share_commitment` ADD CONSTRAINT `fk_grant_cost_share_commitment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= grant --> program (11 constraint(s)) =========
-- Requires: grant schema, program schema
ALTER TABLE `ngo_ecm`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_program_id` FOREIGN KEY (`program_id`) REFERENCES `ngo_ecm`.`program`.`program`(`program_id`);
ALTER TABLE `ngo_ecm`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`grant`.`cost_share_commitment` ADD CONSTRAINT `fk_grant_cost_share_commitment_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `ngo_ecm`.`program`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `ngo_ecm`.`grant`.`cost_share_commitment` ADD CONSTRAINT `fk_grant_cost_share_commitment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);

-- ========= grant --> supply (3 constraint(s)) =========
-- Requires: grant schema, supply schema
ALTER TABLE `ngo_ecm`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `ngo_ecm`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `ngo_ecm`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `ngo_ecm`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `ngo_ecm`.`grant`.`cost_share_commitment` ADD CONSTRAINT `fk_grant_cost_share_commitment_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `ngo_ecm`.`supply`.`commodity`(`commodity_id`);

-- ========= grant --> volunteer (1 constraint(s)) =========
-- Requires: grant schema, volunteer schema
ALTER TABLE `ngo_ecm`.`grant`.`cost_share_commitment` ADD CONSTRAINT `fk_grant_cost_share_commitment_volunteer_deployment_id` FOREIGN KEY (`volunteer_deployment_id`) REFERENCES `ngo_ecm`.`volunteer`.`volunteer_deployment`(`volunteer_deployment_id`);

-- ========= grant --> workforce (9 constraint(s)) =========
-- Requires: grant schema, workforce schema
ALTER TABLE `ngo_ecm`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`grant`.`award_budget` ADD CONSTRAINT `fk_grant_award_budget_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_position_id` FOREIGN KEY (`position_id`) REFERENCES `ngo_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `ngo_ecm`.`grant`.`grant_amendment` ADD CONSTRAINT `fk_grant_grant_amendment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`grant`.`cost_share_commitment` ADD CONSTRAINT `fk_grant_cost_share_commitment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= mel --> beneficiary (3 constraint(s)) =========
-- Requires: mel schema, beneficiary schema
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_needs_assessment_id` FOREIGN KEY (`needs_assessment_id`) REFERENCES `ngo_ecm`.`beneficiary`.`needs_assessment`(`needs_assessment_id`);
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_community_id` FOREIGN KEY (`community_id`) REFERENCES `ngo_ecm`.`beneficiary`.`community`(`community_id`);
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `ngo_ecm`.`beneficiary`.`registrant`(`registrant_id`);

-- ========= mel --> compliance (17 constraint(s)) =========
-- Requires: mel schema, compliance schema
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ngo_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ADD CONSTRAINT `fk_mel_logframe_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ngo_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ADD CONSTRAINT `fk_mel_logframe_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ngo_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `ngo_ecm`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_single_audit_id` FOREIGN KEY (`single_audit_id`) REFERENCES `ngo_ecm`.`compliance`.`single_audit`(`single_audit_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `ngo_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `ngo_ecm`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `ngo_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_internal_review_id` FOREIGN KEY (`internal_review_id`) REFERENCES `ngo_ecm`.`compliance`.`internal_review`(`internal_review_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_single_audit_id` FOREIGN KEY (`single_audit_id`) REFERENCES `ngo_ecm`.`compliance`.`single_audit`(`single_audit_id`);
ALTER TABLE `ngo_ecm`.`mel`.`reporting_period` ADD CONSTRAINT `fk_mel_reporting_period_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);

-- ========= mel --> donor (1 constraint(s)) =========
-- Requires: mel schema, donor schema
ALTER TABLE `ngo_ecm`.`mel`.`reporting_period` ADD CONSTRAINT `fk_mel_reporting_period_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `ngo_ecm`.`donor`.`constituent`(`constituent_id`);

-- ========= mel --> field (4 constraint(s)) =========
-- Requires: mel schema, field schema
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `ngo_ecm`.`field`.`assessment`(`assessment_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);

-- ========= mel --> finance (15 constraint(s)) =========
-- Requires: mel schema, finance schema
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ADD CONSTRAINT `fk_mel_logframe_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `ngo_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `ngo_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`mel`.`reporting_period` ADD CONSTRAINT `fk_mel_reporting_period_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);

-- ========= mel --> grant (10 constraint(s)) =========
-- Requires: mel schema, grant schema
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ADD CONSTRAINT `fk_mel_logframe_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_donor_report_id` FOREIGN KEY (`donor_report_id`) REFERENCES `ngo_ecm`.`grant`.`donor_report`(`donor_report_id`);
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);

-- ========= mel --> partnership (33 constraint(s)) =========
-- Requires: mel schema, partnership schema
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ADD CONSTRAINT `fk_mel_logframe_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ADD CONSTRAINT `fk_mel_logframe_consortium_id` FOREIGN KEY (`consortium_id`) REFERENCES `ngo_ecm`.`partnership`.`consortium`(`consortium_id`);
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ADD CONSTRAINT `fk_mel_logframe_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_capacity_building_plan_id` FOREIGN KEY (`capacity_building_plan_id`) REFERENCES `ngo_ecm`.`partnership`.`capacity_building_plan`(`capacity_building_plan_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_partner_performance_review_id` FOREIGN KEY (`partner_performance_review_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_performance_review`(`partner_performance_review_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_partner_report_submission_id` FOREIGN KEY (`partner_report_submission_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_report_submission`(`partner_report_submission_id`);
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_capacity_assessment_id` FOREIGN KEY (`capacity_assessment_id`) REFERENCES `ngo_ecm`.`partnership`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_consortium_id` FOREIGN KEY (`consortium_id`) REFERENCES `ngo_ecm`.`partnership`.`consortium`(`consortium_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_partner_report_submission_id` FOREIGN KEY (`partner_report_submission_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_report_submission`(`partner_report_submission_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_capacity_assessment_id` FOREIGN KEY (`capacity_assessment_id`) REFERENCES `ngo_ecm`.`partnership`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_capacity_building_plan_id` FOREIGN KEY (`capacity_building_plan_id`) REFERENCES `ngo_ecm`.`partnership`.`capacity_building_plan`(`capacity_building_plan_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_partner_performance_review_id` FOREIGN KEY (`partner_performance_review_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_performance_review`(`partner_performance_review_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_agreement_amendment_id` FOREIGN KEY (`agreement_amendment_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement_amendment`(`agreement_amendment_id`);
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_capacity_assessment_id` FOREIGN KEY (`capacity_assessment_id`) REFERENCES `ngo_ecm`.`partnership`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_capacity_assessment_id` FOREIGN KEY (`capacity_assessment_id`) REFERENCES `ngo_ecm`.`partnership`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_partner_performance_review_id` FOREIGN KEY (`partner_performance_review_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_performance_review`(`partner_performance_review_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_partner_report_submission_id` FOREIGN KEY (`partner_report_submission_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_report_submission`(`partner_report_submission_id`);

-- ========= mel --> program (16 constraint(s)) =========
-- Requires: mel schema, program schema
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ADD CONSTRAINT `fk_mel_logframe_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ADD CONSTRAINT `fk_mel_logframe_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_target_population_id` FOREIGN KEY (`target_population_id`) REFERENCES `ngo_ecm`.`program`.`target_population`(`target_population_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `ngo_ecm`.`program`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_risk_register_id` FOREIGN KEY (`risk_register_id`) REFERENCES `ngo_ecm`.`program`.`risk_register`(`risk_register_id`);
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`mel`.`reporting_period` ADD CONSTRAINT `fk_mel_reporting_period_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);

-- ========= mel --> supply (4 constraint(s)) =========
-- Requires: mel schema, supply schema
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `ngo_ecm`.`supply`.`distribution_plan`(`distribution_plan_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `ngo_ecm`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_distribution_order_id` FOREIGN KEY (`distribution_order_id`) REFERENCES `ngo_ecm`.`supply`.`distribution_order`(`distribution_order_id`);
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_distribution_order_id` FOREIGN KEY (`distribution_order_id`) REFERENCES `ngo_ecm`.`supply`.`distribution_order`(`distribution_order_id`);

-- ========= mel --> volunteer (10 constraint(s)) =========
-- Requires: mel schema, volunteer schema
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_role_id` FOREIGN KEY (`role_id`) REFERENCES `ngo_ecm`.`volunteer`.`role`(`role_id`);
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ADD CONSTRAINT `fk_mel_logframe_role_id` FOREIGN KEY (`role_id`) REFERENCES `ngo_ecm`.`volunteer`.`role`(`role_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_role_id` FOREIGN KEY (`role_id`) REFERENCES `ngo_ecm`.`volunteer`.`role`(`role_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_volunteer_deployment_id` FOREIGN KEY (`volunteer_deployment_id`) REFERENCES `ngo_ecm`.`volunteer`.`volunteer_deployment`(`volunteer_deployment_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `ngo_ecm`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `ngo_ecm`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_volunteer_deployment_id` FOREIGN KEY (`volunteer_deployment_id`) REFERENCES `ngo_ecm`.`volunteer`.`volunteer_deployment`(`volunteer_deployment_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_role_id` FOREIGN KEY (`role_id`) REFERENCES `ngo_ecm`.`volunteer`.`role`(`role_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_training_id` FOREIGN KEY (`training_id`) REFERENCES `ngo_ecm`.`volunteer`.`training`(`training_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `ngo_ecm`.`volunteer`.`volunteer`(`volunteer_id`);

-- ========= mel --> workforce (23 constraint(s)) =========
-- Requires: mel schema, workforce schema
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ADD CONSTRAINT `fk_mel_logframe_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ADD CONSTRAINT `fk_mel_logframe_position_id` FOREIGN KEY (`position_id`) REFERENCES `ngo_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ADD CONSTRAINT `fk_mel_logframe_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_tertiary_qualitative_translator_staff_staff_member_id` FOREIGN KEY (`tertiary_qualitative_translator_staff_staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_reviewer_staff_staff_member_id` FOREIGN KEY (`reviewer_staff_staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= partnership --> compliance (13 constraint(s)) =========
-- Requires: partnership schema, compliance schema
ALTER TABLE `ngo_ecm`.`partnership`.`partner_org` ADD CONSTRAINT `fk_partnership_partner_org_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `ngo_ecm`.`compliance`.`statutory_registration`(`statutory_registration_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`agreement` ADD CONSTRAINT `fk_partnership_agreement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ngo_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`capacity_assessment` ADD CONSTRAINT `fk_partnership_capacity_assessment_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`due_diligence_record` ADD CONSTRAINT `fk_partnership_due_diligence_record_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`due_diligence_record` ADD CONSTRAINT `fk_partnership_due_diligence_record_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `ngo_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`partner_contact` ADD CONSTRAINT `fk_partnership_partner_contact_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `ngo_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`agreement_amendment` ADD CONSTRAINT `fk_partnership_agreement_amendment_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`partner_performance_review` ADD CONSTRAINT `fk_partnership_partner_performance_review_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`partner_performance_review` ADD CONSTRAINT `fk_partnership_partner_performance_review_internal_review_id` FOREIGN KEY (`internal_review_id`) REFERENCES `ngo_ecm`.`compliance`.`internal_review`(`internal_review_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`consortium` ADD CONSTRAINT `fk_partnership_consortium_single_audit_id` FOREIGN KEY (`single_audit_id`) REFERENCES `ngo_ecm`.`compliance`.`single_audit`(`single_audit_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`capacity_building_plan` ADD CONSTRAINT `fk_partnership_capacity_building_plan_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `ngo_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`capacity_building_plan` ADD CONSTRAINT `fk_partnership_capacity_building_plan_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);

-- ========= partnership --> donor (4 constraint(s)) =========
-- Requires: partnership schema, donor schema
ALTER TABLE `ngo_ecm`.`partnership`.`agreement_amendment` ADD CONSTRAINT `fk_partnership_agreement_amendment_donor_fund_id` FOREIGN KEY (`donor_fund_id`) REFERENCES `ngo_ecm`.`donor`.`donor_fund`(`donor_fund_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`consortium` ADD CONSTRAINT `fk_partnership_consortium_donor_fund_id` FOREIGN KEY (`donor_fund_id`) REFERENCES `ngo_ecm`.`donor`.`donor_fund`(`donor_fund_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`consortium` ADD CONSTRAINT `fk_partnership_consortium_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `ngo_ecm`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_donor_fund_id` FOREIGN KEY (`donor_fund_id`) REFERENCES `ngo_ecm`.`donor`.`donor_fund`(`donor_fund_id`);

-- ========= partnership --> finance (7 constraint(s)) =========
-- Requires: partnership schema, finance schema
ALTER TABLE `ngo_ecm`.`partnership`.`agreement` ADD CONSTRAINT `fk_partnership_agreement_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`agreement` ADD CONSTRAINT `fk_partnership_agreement_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`agreement_amendment` ADD CONSTRAINT `fk_partnership_agreement_amendment_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`partner_performance_review` ADD CONSTRAINT `fk_partnership_partner_performance_review_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `ngo_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `ngo_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ngo_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`capacity_building_plan` ADD CONSTRAINT `fk_partnership_capacity_building_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `ngo_ecm`.`finance`.`budget`(`budget_id`);

-- ========= partnership --> grant (10 constraint(s)) =========
-- Requires: partnership schema, grant schema
ALTER TABLE `ngo_ecm`.`partnership`.`agreement` ADD CONSTRAINT `fk_partnership_agreement_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`capacity_assessment` ADD CONSTRAINT `fk_partnership_capacity_assessment_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`capacity_assessment` ADD CONSTRAINT `fk_partnership_capacity_assessment_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `ngo_ecm`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`due_diligence_record` ADD CONSTRAINT `fk_partnership_due_diligence_record_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`due_diligence_record` ADD CONSTRAINT `fk_partnership_due_diligence_record_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `ngo_ecm`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`agreement_amendment` ADD CONSTRAINT `fk_partnership_agreement_amendment_grant_amendment_id` FOREIGN KEY (`grant_amendment_id`) REFERENCES `ngo_ecm`.`grant`.`grant_amendment`(`grant_amendment_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_donor_report_id` FOREIGN KEY (`donor_report_id`) REFERENCES `ngo_ecm`.`grant`.`donor_report`(`donor_report_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `ngo_ecm`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`capacity_building_plan` ADD CONSTRAINT `fk_partnership_capacity_building_plan_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);

-- ========= partnership --> program (5 constraint(s)) =========
-- Requires: partnership schema, program schema
ALTER TABLE `ngo_ecm`.`partnership`.`agreement` ADD CONSTRAINT `fk_partnership_agreement_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`partner_performance_review` ADD CONSTRAINT `fk_partnership_partner_performance_review_implementation_plan_id` FOREIGN KEY (`implementation_plan_id`) REFERENCES `ngo_ecm`.`program`.`implementation_plan`(`implementation_plan_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`consortium` ADD CONSTRAINT `fk_partnership_consortium_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `ngo_ecm`.`program`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);

-- ========= partnership --> workforce (11 constraint(s)) =========
-- Requires: partnership schema, workforce schema
ALTER TABLE `ngo_ecm`.`partnership`.`partner_org` ADD CONSTRAINT `fk_partnership_partner_org_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`agreement` ADD CONSTRAINT `fk_partnership_agreement_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`capacity_assessment` ADD CONSTRAINT `fk_partnership_capacity_assessment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`due_diligence_record` ADD CONSTRAINT `fk_partnership_due_diligence_record_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`partner_contact` ADD CONSTRAINT `fk_partnership_partner_contact_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`agreement_amendment` ADD CONSTRAINT `fk_partnership_agreement_amendment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`partner_performance_review` ADD CONSTRAINT `fk_partnership_partner_performance_review_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`consortium` ADD CONSTRAINT `fk_partnership_consortium_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`consortium` ADD CONSTRAINT `fk_partnership_consortium_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`partnership`.`capacity_building_plan` ADD CONSTRAINT `fk_partnership_capacity_building_plan_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= program --> compliance (17 constraint(s)) =========
-- Requires: program schema, compliance schema
ALTER TABLE `ngo_ecm`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ngo_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ngo_ecm`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `ngo_ecm`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `ngo_ecm`.`program`.`component` ADD CONSTRAINT `fk_program_component_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`program`.`target_population` ADD CONSTRAINT `fk_program_target_population_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ADD CONSTRAINT `fk_program_program_amendment_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ADD CONSTRAINT `fk_program_program_amendment_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `ngo_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ADD CONSTRAINT `fk_program_risk_register_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `ngo_ecm`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ADD CONSTRAINT `fk_program_risk_register_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `ngo_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `ngo_ecm`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ADD CONSTRAINT `fk_program_partner_linkage_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ADD CONSTRAINT `fk_program_partner_linkage_internal_review_id` FOREIGN KEY (`internal_review_id`) REFERENCES `ngo_ecm`.`compliance`.`internal_review`(`internal_review_id`);
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ADD CONSTRAINT `fk_program_partner_linkage_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `ngo_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `ngo_ecm`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `ngo_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `ngo_ecm`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_internal_review_id` FOREIGN KEY (`internal_review_id`) REFERENCES `ngo_ecm`.`compliance`.`internal_review`(`internal_review_id`);

-- ========= program --> donor (7 constraint(s)) =========
-- Requires: program schema, donor schema
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ADD CONSTRAINT `fk_program_program_amendment_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `ngo_ecm`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_donor_fund_id` FOREIGN KEY (`donor_fund_id`) REFERENCES `ngo_ecm`.`donor`.`donor_fund`(`donor_fund_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_donor_fund_id` FOREIGN KEY (`donor_fund_id`) REFERENCES `ngo_ecm`.`donor`.`donor_fund`(`donor_fund_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_donor_fund_id` FOREIGN KEY (`donor_fund_id`) REFERENCES `ngo_ecm`.`donor`.`donor_fund`(`donor_fund_id`);
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ADD CONSTRAINT `fk_program_partner_linkage_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `ngo_ecm`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `ngo_ecm`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_donor_fund_id` FOREIGN KEY (`donor_fund_id`) REFERENCES `ngo_ecm`.`donor`.`donor_fund`(`donor_fund_id`);
ALTER TABLE `ngo_ecm`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `ngo_ecm`.`donor`.`constituent`(`constituent_id`);

-- ========= program --> field (5 constraint(s)) =========
-- Requires: program schema, field schema
ALTER TABLE `ngo_ecm`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`program`.`program` ADD CONSTRAINT `fk_program_program_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`program`.`program` ADD CONSTRAINT `fk_program_program_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);

-- ========= program --> finance (23 constraint(s)) =========
-- Requires: program schema, finance schema
ALTER TABLE `ngo_ecm`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`program`.`component` ADD CONSTRAINT `fk_program_component_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `ngo_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `ngo_ecm`.`program`.`component` ADD CONSTRAINT `fk_program_component_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`program`.`component` ADD CONSTRAINT `fk_program_component_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ADD CONSTRAINT `fk_program_program_amendment_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `ngo_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ADD CONSTRAINT `fk_program_partner_linkage_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ADD CONSTRAINT `fk_program_partner_linkage_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `ngo_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `ngo_ecm`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`program`.`program` ADD CONSTRAINT `fk_program_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= program --> grant (12 constraint(s)) =========
-- Requires: program schema, grant schema
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ADD CONSTRAINT `fk_program_program_amendment_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ADD CONSTRAINT `fk_program_program_amendment_grant_amendment_id` FOREIGN KEY (`grant_amendment_id`) REFERENCES `ngo_ecm`.`grant`.`grant_amendment`(`grant_amendment_id`);
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ADD CONSTRAINT `fk_program_risk_register_grant_amendment_id` FOREIGN KEY (`grant_amendment_id`) REFERENCES `ngo_ecm`.`grant`.`grant_amendment`(`grant_amendment_id`);
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_grant_amendment_id` FOREIGN KEY (`grant_amendment_id`) REFERENCES `ngo_ecm`.`grant`.`grant_amendment`(`grant_amendment_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_grant_amendment_id` FOREIGN KEY (`grant_amendment_id`) REFERENCES `ngo_ecm`.`grant`.`grant_amendment`(`grant_amendment_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ADD CONSTRAINT `fk_program_partner_linkage_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ADD CONSTRAINT `fk_program_partner_linkage_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `ngo_ecm`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `ngo_ecm`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_grant_amendment_id` FOREIGN KEY (`grant_amendment_id`) REFERENCES `ngo_ecm`.`grant`.`grant_amendment`(`grant_amendment_id`);

-- ========= program --> mel (3 constraint(s)) =========
-- Requires: program schema, mel schema
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ADD CONSTRAINT `fk_program_program_amendment_logframe_id` FOREIGN KEY (`logframe_id`) REFERENCES `ngo_ecm`.`mel`.`logframe`(`logframe_id`);
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_meal_plan_id` FOREIGN KEY (`meal_plan_id`) REFERENCES `ngo_ecm`.`mel`.`meal_plan`(`meal_plan_id`);
ALTER TABLE `ngo_ecm`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `ngo_ecm`.`mel`.`reporting_period`(`reporting_period_id`);

-- ========= program --> partnership (10 constraint(s)) =========
-- Requires: program schema, partnership schema
ALTER TABLE `ngo_ecm`.`program`.`component` ADD CONSTRAINT `fk_program_component_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ADD CONSTRAINT `fk_program_risk_register_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ADD CONSTRAINT `fk_program_partner_linkage_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ADD CONSTRAINT `fk_program_partner_linkage_capacity_assessment_id` FOREIGN KEY (`capacity_assessment_id`) REFERENCES `ngo_ecm`.`partnership`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ADD CONSTRAINT `fk_program_partner_linkage_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= program --> supply (2 constraint(s)) =========
-- Requires: program schema, supply schema
ALTER TABLE `ngo_ecm`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `ngo_ecm`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `ngo_ecm`.`supply`.`distribution_plan`(`distribution_plan_id`);

-- ========= program --> volunteer (1 constraint(s)) =========
-- Requires: program schema, volunteer schema
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_volunteer_team_id` FOREIGN KEY (`volunteer_team_id`) REFERENCES `ngo_ecm`.`volunteer`.`volunteer_team`(`volunteer_team_id`);

-- ========= program --> workforce (15 constraint(s)) =========
-- Requires: program schema, workforce schema
ALTER TABLE `ngo_ecm`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`program`.`component` ADD CONSTRAINT `fk_program_component_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`program`.`component` ADD CONSTRAINT `fk_program_component_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ADD CONSTRAINT `fk_program_program_amendment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ADD CONSTRAINT `fk_program_risk_register_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ADD CONSTRAINT `fk_program_risk_register_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ADD CONSTRAINT `fk_program_partner_linkage_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ADD CONSTRAINT `fk_program_partner_linkage_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`program`.`program` ADD CONSTRAINT `fk_program_program_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= supply --> beneficiary (6 constraint(s)) =========
-- Requires: supply schema, beneficiary schema
ALTER TABLE `ngo_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_needs_assessment_id` FOREIGN KEY (`needs_assessment_id`) REFERENCES `ngo_ecm`.`beneficiary`.`needs_assessment`(`needs_assessment_id`);
ALTER TABLE `ngo_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_case_record_id` FOREIGN KEY (`case_record_id`) REFERENCES `ngo_ecm`.`beneficiary`.`case_record`(`case_record_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_community_id` FOREIGN KEY (`community_id`) REFERENCES `ngo_ecm`.`beneficiary`.`community`(`community_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_household_id` FOREIGN KEY (`household_id`) REFERENCES `ngo_ecm`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `ngo_ecm`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `ngo_ecm`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_needs_assessment_id` FOREIGN KEY (`needs_assessment_id`) REFERENCES `ngo_ecm`.`beneficiary`.`needs_assessment`(`needs_assessment_id`);

-- ========= supply --> compliance (18 constraint(s)) =========
-- Requires: supply schema, compliance schema
ALTER TABLE `ngo_ecm`.`supply`.`warehouse` ADD CONSTRAINT `fk_supply_warehouse_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `ngo_ecm`.`compliance`.`statutory_registration`(`statutory_registration_id`);
ALTER TABLE `ngo_ecm`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `ngo_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `ngo_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `ngo_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `ngo_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `ngo_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `ngo_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `ngo_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_internal_review_id` FOREIGN KEY (`internal_review_id`) REFERENCES `ngo_ecm`.`compliance`.`internal_review`(`internal_review_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `ngo_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `ngo_ecm`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `ngo_ecm`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `ngo_ecm`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_internal_review_id` FOREIGN KEY (`internal_review_id`) REFERENCES `ngo_ecm`.`compliance`.`internal_review`(`internal_review_id`);
ALTER TABLE `ngo_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `ngo_ecm`.`compliance`.`incident`(`incident_id`);

-- ========= supply --> donor (2 constraint(s)) =========
-- Requires: supply schema, donor schema
ALTER TABLE `ngo_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_donor_fund_id` FOREIGN KEY (`donor_fund_id`) REFERENCES `ngo_ecm`.`donor`.`donor_fund`(`donor_fund_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `ngo_ecm`.`donor`.`constituent`(`constituent_id`);

-- ========= supply --> field (21 constraint(s)) =========
-- Requires: supply schema, field schema
ALTER TABLE `ngo_ecm`.`supply`.`warehouse` ADD CONSTRAINT `fk_supply_warehouse_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `ngo_ecm`.`field`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `ngo_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_field_team_id` FOREIGN KEY (`field_team_id`) REFERENCES `ngo_ecm`.`field`.`field_team`(`field_team_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_field_team_id` FOREIGN KEY (`field_team_id`) REFERENCES `ngo_ecm`.`field`.`field_team`(`field_team_id`);
ALTER TABLE `ngo_ecm`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `ngo_ecm`.`field`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `ngo_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);

-- ========= supply --> finance (33 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `ngo_ecm`.`supply`.`commodity` ADD CONSTRAINT `fk_supply_commodity_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `ngo_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `ngo_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= supply --> grant (15 constraint(s)) =========
-- Requires: supply schema, grant schema
ALTER TABLE `ngo_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_award_budget_line_id` FOREIGN KEY (`award_budget_line_id`) REFERENCES `ngo_ecm`.`grant`.`award_budget_line`(`award_budget_line_id`);
ALTER TABLE `ngo_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_award_budget_id` FOREIGN KEY (`award_budget_id`) REFERENCES `ngo_ecm`.`grant`.`award_budget`(`award_budget_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_grant_amendment_id` FOREIGN KEY (`grant_amendment_id`) REFERENCES `ngo_ecm`.`grant`.`grant_amendment`(`grant_amendment_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_grant_amendment_id` FOREIGN KEY (`grant_amendment_id`) REFERENCES `ngo_ecm`.`grant`.`grant_amendment`(`grant_amendment_id`);
ALTER TABLE `ngo_ecm`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_award_budget_line_id` FOREIGN KEY (`award_budget_line_id`) REFERENCES `ngo_ecm`.`grant`.`award_budget_line`(`award_budget_line_id`);
ALTER TABLE `ngo_ecm`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_award_budget_line_id` FOREIGN KEY (`award_budget_line_id`) REFERENCES `ngo_ecm`.`grant`.`award_budget_line`(`award_budget_line_id`);

-- ========= supply --> partnership (12 constraint(s)) =========
-- Requires: supply schema, partnership schema
ALTER TABLE `ngo_ecm`.`supply`.`warehouse` ADD CONSTRAINT `fk_supply_warehouse_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= supply --> program (21 constraint(s)) =========
-- Requires: supply schema, program schema
ALTER TABLE `ngo_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `ngo_ecm`.`program`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_target_population_id` FOREIGN KEY (`target_population_id`) REFERENCES `ngo_ecm`.`program`.`target_population`(`target_population_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `ngo_ecm`.`program`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `ngo_ecm`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_implementation_plan_id` FOREIGN KEY (`implementation_plan_id`) REFERENCES `ngo_ecm`.`program`.`implementation_plan`(`implementation_plan_id`);
ALTER TABLE `ngo_ecm`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_budget_plan_line_id` FOREIGN KEY (`budget_plan_line_id`) REFERENCES `ngo_ecm`.`program`.`budget_plan_line`(`budget_plan_line_id`);

-- ========= supply --> workforce (14 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `ngo_ecm`.`supply`.`warehouse` ADD CONSTRAINT `fk_supply_warehouse_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`supply`.`waybill` ADD CONSTRAINT `fk_supply_waybill_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= volunteer --> beneficiary (5 constraint(s)) =========
-- Requires: volunteer schema, beneficiary schema
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_community_id` FOREIGN KEY (`community_id`) REFERENCES `ngo_ecm`.`beneficiary`.`community`(`community_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_community_id` FOREIGN KEY (`community_id`) REFERENCES `ngo_ecm`.`beneficiary`.`community`(`community_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `ngo_ecm`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `ngo_ecm`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_community_id` FOREIGN KEY (`community_id`) REFERENCES `ngo_ecm`.`beneficiary`.`community`(`community_id`);

-- ========= volunteer --> compliance (14 constraint(s)) =========
-- Requires: volunteer schema, compliance schema
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer` ADD CONSTRAINT `fk_volunteer_volunteer_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `ngo_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `ngo_ecm`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`role` ADD CONSTRAINT `fk_volunteer_role_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `ngo_ecm`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`role` ADD CONSTRAINT `fk_volunteer_role_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ngo_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `ngo_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_internal_review_id` FOREIGN KEY (`internal_review_id`) REFERENCES `ngo_ecm`.`compliance`.`internal_review`(`internal_review_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `ngo_ecm`.`compliance`.`statutory_registration`(`statutory_registration_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `ngo_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`training` ADD CONSTRAINT `fk_volunteer_training_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `ngo_ecm`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ngo_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`certification` ADD CONSTRAINT `fk_volunteer_certification_governance_policy_id` FOREIGN KEY (`governance_policy_id`) REFERENCES `ngo_ecm`.`compliance`.`governance_policy`(`governance_policy_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`certification` ADD CONSTRAINT `fk_volunteer_certification_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ngo_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= volunteer --> donor (6 constraint(s)) =========
-- Requires: volunteer schema, donor schema
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer` ADD CONSTRAINT `fk_volunteer_volunteer_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `ngo_ecm`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_fundraising_event_id` FOREIGN KEY (`fundraising_event_id`) REFERENCES `ngo_ecm`.`donor`.`fundraising_event`(`fundraising_event_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ngo_ecm`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_fundraising_event_id` FOREIGN KEY (`fundraising_event_id`) REFERENCES `ngo_ecm`.`donor`.`fundraising_event`(`fundraising_event_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `ngo_ecm`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_fundraising_event_id` FOREIGN KEY (`fundraising_event_id`) REFERENCES `ngo_ecm`.`donor`.`fundraising_event`(`fundraising_event_id`);

-- ========= volunteer --> field (16 constraint(s)) =========
-- Requires: volunteer schema, field schema
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer` ADD CONSTRAINT `fk_volunteer_volunteer_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `ngo_ecm`.`field`.`assessment`(`assessment_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `ngo_ecm`.`field`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`training` ADD CONSTRAINT `fk_volunteer_training_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_field_team_id` FOREIGN KEY (`field_team_id`) REFERENCES `ngo_ecm`.`field`.`field_team`(`field_team_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);

-- ========= volunteer --> finance (21 constraint(s)) =========
-- Requires: volunteer schema, finance schema
ALTER TABLE `ngo_ecm`.`volunteer`.`role` ADD CONSTRAINT `fk_volunteer_role_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`training` ADD CONSTRAINT `fk_volunteer_training_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`certification` ADD CONSTRAINT `fk_volunteer_certification_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);

-- ========= volunteer --> grant (4 constraint(s)) =========
-- Requires: volunteer schema, grant schema
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `ngo_ecm`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);

-- ========= volunteer --> mel (3 constraint(s)) =========
-- Requires: volunteer schema, mel schema
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `ngo_ecm`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_meal_plan_id` FOREIGN KEY (`meal_plan_id`) REFERENCES `ngo_ecm`.`mel`.`meal_plan`(`meal_plan_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `ngo_ecm`.`mel`.`indicator`(`indicator_id`);

-- ========= volunteer --> partnership (9 constraint(s)) =========
-- Requires: volunteer schema, partnership schema
ALTER TABLE `ngo_ecm`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`training` ADD CONSTRAINT `fk_volunteer_training_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`training` ADD CONSTRAINT `fk_volunteer_training_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= volunteer --> program (8 constraint(s)) =========
-- Requires: volunteer schema, program schema
ALTER TABLE `ngo_ecm`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_implementation_plan_id` FOREIGN KEY (`implementation_plan_id`) REFERENCES `ngo_ecm`.`program`.`implementation_plan`(`implementation_plan_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`training` ADD CONSTRAINT `fk_volunteer_training_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);

-- ========= volunteer --> supply (10 constraint(s)) =========
-- Requires: volunteer schema, supply schema
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_distribution_order_id` FOREIGN KEY (`distribution_order_id`) REFERENCES `ngo_ecm`.`supply`.`distribution_order`(`distribution_order_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `ngo_ecm`.`supply`.`distribution_plan`(`distribution_plan_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `ngo_ecm`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_distribution_order_id` FOREIGN KEY (`distribution_order_id`) REFERENCES `ngo_ecm`.`supply`.`distribution_order`(`distribution_order_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `ngo_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `ngo_ecm`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`training` ADD CONSTRAINT `fk_volunteer_training_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `ngo_ecm`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`certification` ADD CONSTRAINT `fk_volunteer_certification_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `ngo_ecm`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `ngo_ecm`.`supply`.`distribution_plan`(`distribution_plan_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `ngo_ecm`.`supply`.`warehouse`(`warehouse_id`);

-- ========= volunteer --> workforce (11 constraint(s)) =========
-- Requires: volunteer schema, workforce schema
ALTER TABLE `ngo_ecm`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`training` ADD CONSTRAINT `fk_volunteer_training_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `ngo_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`certification` ADD CONSTRAINT `fk_volunteer_certification_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `ngo_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`certification` ADD CONSTRAINT `fk_volunteer_certification_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= workforce --> compliance (4 constraint(s)) =========
-- Requires: workforce schema, compliance schema
ALTER TABLE `ngo_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ngo_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ADD CONSTRAINT `fk_workforce_job_profile_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `ngo_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_statutory_registration_id` FOREIGN KEY (`statutory_registration_id`) REFERENCES `ngo_ecm`.`compliance`.`statutory_registration`(`statutory_registration_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ADD CONSTRAINT `fk_workforce_staff_assignment_donor_requirement_id` FOREIGN KEY (`donor_requirement_id`) REFERENCES `ngo_ecm`.`compliance`.`donor_requirement`(`donor_requirement_id`);

-- ========= workforce --> field (5 constraint(s)) =========
-- Requires: workforce schema, field schema
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ADD CONSTRAINT `fk_workforce_staff_assignment_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `ngo_ecm`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ADD CONSTRAINT `fk_workforce_staff_assignment_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `ngo_ecm`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ADD CONSTRAINT `fk_workforce_staff_assignment_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `ngo_ecm`.`field`.`project_site`(`project_site_id`);

-- ========= workforce --> finance (20 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `ngo_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `ngo_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ngo_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ngo_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ADD CONSTRAINT `fk_workforce_staff_assignment_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ADD CONSTRAINT `fk_workforce_staff_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ADD CONSTRAINT `fk_workforce_staff_assignment_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);

-- ========= workforce --> grant (5 constraint(s)) =========
-- Requires: workforce schema, grant schema
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_funding_source_id` FOREIGN KEY (`funding_source_id`) REFERENCES `ngo_ecm`.`grant`.`funding_source`(`funding_source_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ADD CONSTRAINT `fk_workforce_staff_assignment_award_id` FOREIGN KEY (`award_id`) REFERENCES `ngo_ecm`.`grant`.`award`(`award_id`);

-- ========= workforce --> partnership (4 constraint(s)) =========
-- Requires: workforce schema, partnership schema
ALTER TABLE `ngo_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ADD CONSTRAINT `fk_workforce_staff_assignment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `ngo_ecm`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ADD CONSTRAINT `fk_workforce_staff_assignment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `ngo_ecm`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= workforce --> program (4 constraint(s)) =========
-- Requires: workforce schema, program schema
ALTER TABLE `ngo_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_program_id` FOREIGN KEY (`program_id`) REFERENCES `ngo_ecm`.`program`.`program`(`program_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ADD CONSTRAINT `fk_workforce_staff_assignment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);

