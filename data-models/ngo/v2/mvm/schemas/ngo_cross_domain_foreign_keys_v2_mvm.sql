-- Cross-Domain Foreign Keys for Business: Ngo | Version: v2_mvm
-- Generated on: 2026-06-23 02:07:10
-- Total cross-domain FK constraints: 413
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: beneficiary, donor, field, grant, mel, partnership, program, supply, volunteer

-- ========= beneficiary --> donor (2 constraint(s)) =========
-- Requires: beneficiary schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);

-- ========= beneficiary --> field (37 constraint(s)) =========
-- Requires: beneficiary schema, field schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ADD CONSTRAINT `fk_beneficiary_registrant_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ADD CONSTRAINT `fk_beneficiary_registrant_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ADD CONSTRAINT `fk_beneficiary_registrant_primary_registrant_country_id` FOREIGN KEY (`primary_registrant_country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ADD CONSTRAINT `fk_beneficiary_registrant_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ADD CONSTRAINT `fk_beneficiary_household_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ADD CONSTRAINT `fk_beneficiary_household_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ADD CONSTRAINT `fk_beneficiary_household_member_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ADD CONSTRAINT `fk_beneficiary_household_member_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_field_team_id` FOREIGN KEY (`field_team_id`) REFERENCES `vibe_ngo_v1`.`field`.`field_team`(`field_team_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_field_team_id` FOREIGN KEY (`field_team_id`) REFERENCES `vibe_ngo_v1`.`field`.`field_team`(`field_team_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_field_team_id` FOREIGN KEY (`field_team_id`) REFERENCES `vibe_ngo_v1`.`field`.`field_team`(`field_team_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ADD CONSTRAINT `fk_beneficiary_registration_event_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ADD CONSTRAINT `fk_beneficiary_registration_event_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ADD CONSTRAINT `fk_beneficiary_registration_event_field_team_id` FOREIGN KEY (`field_team_id`) REFERENCES `vibe_ngo_v1`.`field`.`field_team`(`field_team_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ADD CONSTRAINT `fk_beneficiary_registration_event_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ADD CONSTRAINT `fk_beneficiary_enrollment_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ADD CONSTRAINT `fk_beneficiary_enrollment_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ADD CONSTRAINT `fk_beneficiary_enrollment_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);

-- ========= beneficiary --> grant (4 constraint(s)) =========
-- Requires: beneficiary schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ADD CONSTRAINT `fk_beneficiary_enrollment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= beneficiary --> mel (12 constraint(s)) =========
-- Requires: beneficiary schema, mel schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ADD CONSTRAINT `fk_beneficiary_household_member_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_data_collection_tool_id` FOREIGN KEY (`data_collection_tool_id`) REFERENCES `vibe_ngo_v1`.`mel`.`data_collection_tool`(`data_collection_tool_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_data_collection_tool_id` FOREIGN KEY (`data_collection_tool_id`) REFERENCES `vibe_ngo_v1`.`mel`.`data_collection_tool`(`data_collection_tool_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_data_collection_tool_id` FOREIGN KEY (`data_collection_tool_id`) REFERENCES `vibe_ngo_v1`.`mel`.`data_collection_tool`(`data_collection_tool_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ADD CONSTRAINT `fk_beneficiary_registration_event_data_collection_tool_id` FOREIGN KEY (`data_collection_tool_id`) REFERENCES `vibe_ngo_v1`.`mel`.`data_collection_tool`(`data_collection_tool_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ADD CONSTRAINT `fk_beneficiary_registration_event_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ADD CONSTRAINT `fk_beneficiary_enrollment_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);

-- ========= beneficiary --> partnership (13 constraint(s)) =========
-- Requires: beneficiary schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_receiving_organization_partner_org_id` FOREIGN KEY (`receiving_organization_partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ADD CONSTRAINT `fk_beneficiary_registration_event_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ADD CONSTRAINT `fk_beneficiary_enrollment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ADD CONSTRAINT `fk_beneficiary_enrollment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= beneficiary --> program (15 constraint(s)) =========
-- Requires: beneficiary schema, program schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ADD CONSTRAINT `fk_beneficiary_household_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_target_population_id` FOREIGN KEY (`target_population_id`) REFERENCES `vibe_ngo_v1`.`program`.`target_population`(`target_population_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ADD CONSTRAINT `fk_beneficiary_registration_event_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ADD CONSTRAINT `fk_beneficiary_enrollment_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= beneficiary --> supply (5 constraint(s)) =========
-- Requires: beneficiary schema, supply schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_plan`(`distribution_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);

-- ========= beneficiary --> volunteer (6 constraint(s)) =========
-- Requires: beneficiary schema, volunteer schema
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`needs_assessment` ADD CONSTRAINT `fk_beneficiary_needs_assessment_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ADD CONSTRAINT `fk_beneficiary_registration_event_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);

-- ========= donor --> field (10 constraint(s)) =========
-- Requires: donor schema, field schema
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ADD CONSTRAINT `fk_donor_constituent_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ADD CONSTRAINT `fk_donor_constituent_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ADD CONSTRAINT `fk_donor_major_gift_opportunity_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ADD CONSTRAINT `fk_donor_major_gift_opportunity_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ADD CONSTRAINT `fk_donor_fund_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);

-- ========= donor --> mel (7 constraint(s)) =========
-- Requires: donor schema, mel schema
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ADD CONSTRAINT `fk_donor_prospect_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_meal_plan_id` FOREIGN KEY (`meal_plan_id`) REFERENCES `vibe_ngo_v1`.`mel`.`meal_plan`(`meal_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ADD CONSTRAINT `fk_donor_fund_mel_logframe_id` FOREIGN KEY (`mel_logframe_id`) REFERENCES `vibe_ngo_v1`.`mel`.`mel_logframe`(`mel_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ADD CONSTRAINT `fk_donor_fund_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `vibe_ngo_v1`.`mel`.`evaluation`(`evaluation_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_indicator_result_id` FOREIGN KEY (`indicator_result_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator_result`(`indicator_result_id`);

-- ========= donor --> partnership (1 constraint(s)) =========
-- Requires: donor schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);

-- ========= donor --> program (5 constraint(s)) =========
-- Requires: donor schema, program schema
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ADD CONSTRAINT `fk_donor_prospect_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ADD CONSTRAINT `fk_donor_major_gift_opportunity_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ADD CONSTRAINT `fk_donor_fund_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= field --> beneficiary (3 constraint(s)) =========
-- Requires: field schema, beneficiary schema
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ADD CONSTRAINT `fk_field_assessment_response_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ADD CONSTRAINT `fk_field_assessment_response_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);

-- ========= field --> grant (4 constraint(s)) =========
-- Requires: field schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ADD CONSTRAINT `fk_field_distribution_line_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ADD CONSTRAINT `fk_field_distribution_line_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_team` ADD CONSTRAINT `fk_field_field_team_funding_source_id` FOREIGN KEY (`funding_source_id`) REFERENCES `vibe_ngo_v1`.`grant`.`funding_source`(`funding_source_id`);

-- ========= field --> mel (4 constraint(s)) =========
-- Requires: field schema, mel schema
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ADD CONSTRAINT `fk_field_assessment_response_data_collection_tool_id` FOREIGN KEY (`data_collection_tool_id`) REFERENCES `vibe_ngo_v1`.`mel`.`data_collection_tool`(`data_collection_tool_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_team` ADD CONSTRAINT `fk_field_field_team_meal_plan_id` FOREIGN KEY (`meal_plan_id`) REFERENCES `vibe_ngo_v1`.`mel`.`meal_plan`(`meal_plan_id`);

-- ========= field --> partnership (10 constraint(s)) =========
-- Requires: field schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_consortium_id` FOREIGN KEY (`consortium_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`consortium`(`consortium_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_consortium_id` FOREIGN KEY (`consortium_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`consortium`(`consortium_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_consortium_id` FOREIGN KEY (`consortium_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`consortium`(`consortium_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_consortium_id` FOREIGN KEY (`consortium_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`consortium`(`consortium_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_team` ADD CONSTRAINT `fk_field_field_team_consortium_id` FOREIGN KEY (`consortium_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`consortium`(`consortium_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_team` ADD CONSTRAINT `fk_field_field_team_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= field --> program (5 constraint(s)) =========
-- Requires: field schema, program schema
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_team` ADD CONSTRAINT `fk_field_field_team_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= field --> supply (9 constraint(s)) =========
-- Requires: field schema, supply schema
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_distribution_order_id` FOREIGN KEY (`distribution_order_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_order`(`distribution_order_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_plan`(`distribution_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ADD CONSTRAINT `fk_field_distribution_line_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ADD CONSTRAINT `fk_field_distribution_line_distribution_order_id` FOREIGN KEY (`distribution_order_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_order`(`distribution_order_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_plan`(`distribution_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`field_team` ADD CONSTRAINT `fk_field_field_team_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_plan`(`distribution_plan_id`);

-- ========= grant --> donor (10 constraint(s)) =========
-- Requires: grant schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ADD CONSTRAINT `fk_grant_sub_award_disbursement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_major_gift_opportunity_id` FOREIGN KEY (`major_gift_opportunity_id`) REFERENCES `vibe_ngo_v1`.`donor`.`major_gift_opportunity`(`major_gift_opportunity_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ADD CONSTRAINT `fk_grant_award_budget_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ADD CONSTRAINT `fk_grant_solicitation_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ADD CONSTRAINT `fk_grant_solicitation_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);

-- ========= grant --> field (17 constraint(s)) =========
-- Requires: grant schema, field schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ADD CONSTRAINT `fk_grant_sub_award_disbursement_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ADD CONSTRAINT `fk_grant_sub_award_disbursement_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ADD CONSTRAINT `fk_grant_sub_award_disbursement_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ADD CONSTRAINT `fk_grant_award_budget_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ADD CONSTRAINT `fk_grant_funding_source_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ADD CONSTRAINT `fk_grant_solicitation_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ADD CONSTRAINT `fk_grant_solicitation_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);

-- ========= grant --> mel (6 constraint(s)) =========
-- Requires: grant schema, mel schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_mel_logframe_id` FOREIGN KEY (`mel_logframe_id`) REFERENCES `vibe_ngo_v1`.`mel`.`mel_logframe`(`mel_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `vibe_ngo_v1`.`mel`.`evaluation`(`evaluation_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_mel_logframe_id` FOREIGN KEY (`mel_logframe_id`) REFERENCES `vibe_ngo_v1`.`mel`.`mel_logframe`(`mel_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ADD CONSTRAINT `fk_grant_solicitation_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);

-- ========= grant --> partnership (8 constraint(s)) =========
-- Requires: grant schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ADD CONSTRAINT `fk_grant_sub_award_disbursement_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_capacity_assessment_id` FOREIGN KEY (`capacity_assessment_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_due_diligence_record_id` FOREIGN KEY (`due_diligence_record_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`due_diligence_record`(`due_diligence_record_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ADD CONSTRAINT `fk_grant_funding_source_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= grant --> program (14 constraint(s)) =========
-- Requires: grant schema, program schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ADD CONSTRAINT `fk_grant_sub_award_disbursement_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_ngo_v1`.`program`.`program`(`program_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_ngo_v1`.`program`.`program`(`program_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ADD CONSTRAINT `fk_grant_award_budget_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ADD CONSTRAINT `fk_grant_solicitation_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_ngo_v1`.`program`.`program`(`program_id`);

-- ========= grant --> supply (1 constraint(s)) =========
-- Requires: grant schema, supply schema
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_plan`(`distribution_plan_id`);

-- ========= mel --> donor (2 constraint(s)) =========
-- Requires: mel schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);

-- ========= mel --> field (2 constraint(s)) =========
-- Requires: mel schema, field schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `vibe_ngo_v1`.`field`.`assessment`(`assessment_id`);

-- ========= mel --> grant (5 constraint(s)) =========
-- Requires: mel schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= mel --> partnership (15 constraint(s)) =========
-- Requires: mel schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ADD CONSTRAINT `fk_mel_mel_logframe_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_capacity_building_plan_id` FOREIGN KEY (`capacity_building_plan_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_building_plan`(`capacity_building_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_capacity_building_plan_id` FOREIGN KEY (`capacity_building_plan_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_building_plan`(`capacity_building_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_capacity_assessment_id` FOREIGN KEY (`capacity_assessment_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_capacity_assessment_id` FOREIGN KEY (`capacity_assessment_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_capacity_building_plan_id` FOREIGN KEY (`capacity_building_plan_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_building_plan`(`capacity_building_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_partner_performance_review_id` FOREIGN KEY (`partner_performance_review_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_performance_review`(`partner_performance_review_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ADD CONSTRAINT `fk_mel_reporting_period_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= mel --> program (20 constraint(s)) =========
-- Requires: mel schema, program schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_logframe_row_id` FOREIGN KEY (`logframe_row_id`) REFERENCES `vibe_ngo_v1`.`program`.`logframe_row`(`logframe_row_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_target_population_id` FOREIGN KEY (`target_population_id`) REFERENCES `vibe_ngo_v1`.`program`.`target_population`(`target_population_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`mel_logframe` ADD CONSTRAINT `fk_mel_mel_logframe_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_logframe_row_id` FOREIGN KEY (`logframe_row_id`) REFERENCES `vibe_ngo_v1`.`program`.`logframe_row`(`logframe_row_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_program_logframe_id` FOREIGN KEY (`program_logframe_id`) REFERENCES `vibe_ngo_v1`.`program`.`program_logframe`(`program_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_logframe_row_id` FOREIGN KEY (`logframe_row_id`) REFERENCES `vibe_ngo_v1`.`program`.`logframe_row`(`logframe_row_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `vibe_ngo_v1`.`program`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_theory_of_change_id` FOREIGN KEY (`theory_of_change_id`) REFERENCES `vibe_ngo_v1`.`program`.`theory_of_change`(`theory_of_change_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_logframe_row_id` FOREIGN KEY (`logframe_row_id`) REFERENCES `vibe_ngo_v1`.`program`.`logframe_row`(`logframe_row_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_program_logframe_id` FOREIGN KEY (`program_logframe_id`) REFERENCES `vibe_ngo_v1`.`program`.`program_logframe`(`program_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ADD CONSTRAINT `fk_mel_reporting_period_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`reporting_period` ADD CONSTRAINT `fk_mel_reporting_period_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= mel --> supply (6 constraint(s)) =========
-- Requires: mel schema, supply schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator` ADD CONSTRAINT `fk_mel_indicator_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_distribution_order_id` FOREIGN KEY (`distribution_order_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_order`(`distribution_order_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_plan`(`distribution_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_plan`(`distribution_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_plan`(`distribution_plan_id`);

-- ========= mel --> volunteer (2 constraint(s)) =========
-- Requires: mel schema, volunteer schema
ALTER TABLE `vibe_ngo_v1`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_deployment_id` FOREIGN KEY (`deployment_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`deployment`(`deployment_id`);
ALTER TABLE `vibe_ngo_v1`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`role`(`role_id`);

-- ========= partnership --> donor (1 constraint(s)) =========
-- Requires: partnership schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ADD CONSTRAINT `fk_partnership_consortium_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);

-- ========= partnership --> field (11 constraint(s)) =========
-- Requires: partnership schema, field schema
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ADD CONSTRAINT `fk_partnership_agreement_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ADD CONSTRAINT `fk_partnership_agreement_primary_agreement_country_id` FOREIGN KEY (`primary_agreement_country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ADD CONSTRAINT `fk_partnership_capacity_assessment_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ADD CONSTRAINT `fk_partnership_due_diligence_record_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ADD CONSTRAINT `fk_partnership_partner_contact_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ADD CONSTRAINT `fk_partnership_partner_performance_review_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ADD CONSTRAINT `fk_partnership_consortium_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ADD CONSTRAINT `fk_partnership_capacity_building_plan_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ADD CONSTRAINT `fk_partnership_capacity_building_plan_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);

-- ========= partnership --> grant (3 constraint(s)) =========
-- Requires: partnership schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ADD CONSTRAINT `fk_partnership_consortium_member_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ADD CONSTRAINT `fk_partnership_capacity_building_plan_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= partnership --> program (11 constraint(s)) =========
-- Requires: partnership schema, program schema
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ADD CONSTRAINT `fk_partnership_agreement_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ADD CONSTRAINT `fk_partnership_capacity_assessment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ADD CONSTRAINT `fk_partnership_partner_performance_review_implementation_plan_id` FOREIGN KEY (`implementation_plan_id`) REFERENCES `vibe_ngo_v1`.`program`.`implementation_plan`(`implementation_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ADD CONSTRAINT `fk_partnership_partner_performance_review_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ADD CONSTRAINT `fk_partnership_partner_performance_review_program_logframe_id` FOREIGN KEY (`program_logframe_id`) REFERENCES `vibe_ngo_v1`.`program`.`program_logframe`(`program_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ADD CONSTRAINT `fk_partnership_consortium_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `vibe_ngo_v1`.`program`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_implementation_plan_id` FOREIGN KEY (`implementation_plan_id`) REFERENCES `vibe_ngo_v1`.`program`.`implementation_plan`(`implementation_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_program_logframe_id` FOREIGN KEY (`program_logframe_id`) REFERENCES `vibe_ngo_v1`.`program`.`program_logframe`(`program_logframe_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ADD CONSTRAINT `fk_partnership_capacity_building_plan_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= program --> donor (3 constraint(s)) =========
-- Requires: program schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ADD CONSTRAINT `fk_program_program_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);

-- ========= program --> field (11 constraint(s)) =========
-- Requires: program schema, field schema
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ADD CONSTRAINT `fk_program_component_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ADD CONSTRAINT `fk_program_target_population_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`target_population` ADD CONSTRAINT `fk_program_target_population_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ADD CONSTRAINT `fk_program_risk_register_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ADD CONSTRAINT `fk_program_program_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ADD CONSTRAINT `fk_program_program_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ADD CONSTRAINT `fk_program_program_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);

-- ========= program --> grant (2 constraint(s)) =========
-- Requires: program schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ADD CONSTRAINT `fk_program_risk_register_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);

-- ========= program --> mel (1 constraint(s)) =========
-- Requires: program schema, mel schema
ALTER TABLE `vibe_ngo_v1`.`program`.`program_logframe` ADD CONSTRAINT `fk_program_program_logframe_mel_logframe_id` FOREIGN KEY (`mel_logframe_id`) REFERENCES `vibe_ngo_v1`.`mel`.`mel_logframe`(`mel_logframe_id`);

-- ========= program --> partnership (5 constraint(s)) =========
-- Requires: program schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`program`.`component` ADD CONSTRAINT `fk_program_component_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`risk_register` ADD CONSTRAINT `fk_program_risk_register_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`program`.`program` ADD CONSTRAINT `fk_program_program_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= supply --> beneficiary (1 constraint(s)) =========
-- Requires: supply schema, beneficiary schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_case_record_id` FOREIGN KEY (`case_record_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`case_record`(`case_record_id`);

-- ========= supply --> donor (3 constraint(s)) =========
-- Requires: supply schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);

-- ========= supply --> field (11 constraint(s)) =========
-- Requires: supply schema, field schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ADD CONSTRAINT `fk_supply_warehouse_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ADD CONSTRAINT `fk_supply_warehouse_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `vibe_ngo_v1`.`field`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);

-- ========= supply --> grant (6 constraint(s)) =========
-- Requires: supply schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_funding_source_id` FOREIGN KEY (`funding_source_id`) REFERENCES `vibe_ngo_v1`.`grant`.`funding_source`(`funding_source_id`);

-- ========= supply --> mel (1 constraint(s)) =========
-- Requires: supply schema, mel schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);

-- ========= supply --> partnership (11 constraint(s)) =========
-- Requires: supply schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`warehouse` ADD CONSTRAINT `fk_supply_warehouse_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_consortium_id` FOREIGN KEY (`consortium_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`consortium`(`consortium_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= supply --> program (12 constraint(s)) =========
-- Requires: supply schema, program schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_implementation_plan_id` FOREIGN KEY (`implementation_plan_id`) REFERENCES `vibe_ngo_v1`.`program`.`implementation_plan`(`implementation_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_logframe_row_id` FOREIGN KEY (`logframe_row_id`) REFERENCES `vibe_ngo_v1`.`program`.`logframe_row`(`logframe_row_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_plan` ADD CONSTRAINT `fk_supply_distribution_plan_target_population_id` FOREIGN KEY (`target_population_id`) REFERENCES `vibe_ngo_v1`.`program`.`target_population`(`target_population_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`distribution_order` ADD CONSTRAINT `fk_supply_distribution_order_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `vibe_ngo_v1`.`program`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`supply`.`procurement_request` ADD CONSTRAINT `fk_supply_procurement_request_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= supply --> volunteer (1 constraint(s)) =========
-- Requires: supply schema, volunteer schema
ALTER TABLE `vibe_ngo_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_deployment_id` FOREIGN KEY (`deployment_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`deployment`(`deployment_id`);

-- ========= volunteer --> beneficiary (3 constraint(s)) =========
-- Requires: volunteer schema, beneficiary schema
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_case_record_id` FOREIGN KEY (`case_record_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`case_record`(`case_record_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);

-- ========= volunteer --> donor (6 constraint(s)) =========
-- Requires: volunteer schema, donor schema
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ADD CONSTRAINT `fk_volunteer_volunteer_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ADD CONSTRAINT `fk_volunteer_deployment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ADD CONSTRAINT `fk_volunteer_deployment_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);

-- ========= volunteer --> field (17 constraint(s)) =========
-- Requires: volunteer schema, field schema
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ADD CONSTRAINT `fk_volunteer_volunteer_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ADD CONSTRAINT `fk_volunteer_deployment_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `vibe_ngo_v1`.`field`.`assessment`(`assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ADD CONSTRAINT `fk_volunteer_deployment_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ADD CONSTRAINT `fk_volunteer_deployment_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ADD CONSTRAINT `fk_volunteer_deployment_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ADD CONSTRAINT `fk_volunteer_deployment_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `vibe_ngo_v1`.`field`.`assessment`(`assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `vibe_ngo_v1`.`field`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_field_team_id` FOREIGN KEY (`field_team_id`) REFERENCES `vibe_ngo_v1`.`field`.`field_team`(`field_team_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);

-- ========= volunteer --> grant (5 constraint(s)) =========
-- Requires: volunteer schema, grant schema
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ADD CONSTRAINT `fk_volunteer_deployment_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ADD CONSTRAINT `fk_volunteer_deployment_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_award_budget_line_id` FOREIGN KEY (`award_budget_line_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award_budget_line`(`award_budget_line_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ADD CONSTRAINT `fk_volunteer_training_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ADD CONSTRAINT `fk_volunteer_training_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);

-- ========= volunteer --> mel (4 constraint(s)) =========
-- Requires: volunteer schema, mel schema
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ADD CONSTRAINT `fk_volunteer_deployment_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `vibe_ngo_v1`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `vibe_ngo_v1`.`mel`.`reporting_period`(`reporting_period_id`);

-- ========= volunteer --> partnership (9 constraint(s)) =========
-- Requires: volunteer schema, partnership schema
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ADD CONSTRAINT `fk_volunteer_deployment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ADD CONSTRAINT `fk_volunteer_deployment_consortium_id` FOREIGN KEY (`consortium_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`consortium`(`consortium_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ADD CONSTRAINT `fk_volunteer_deployment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ADD CONSTRAINT `fk_volunteer_training_capacity_building_plan_id` FOREIGN KEY (`capacity_building_plan_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_building_plan`(`capacity_building_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ADD CONSTRAINT `fk_volunteer_training_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ADD CONSTRAINT `fk_volunteer_certification_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= volunteer --> program (8 constraint(s)) =========
-- Requires: volunteer schema, program schema
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ADD CONSTRAINT `fk_volunteer_deployment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_budget_plan_line_id` FOREIGN KEY (`budget_plan_line_id`) REFERENCES `vibe_ngo_v1`.`program`.`budget_plan_line`(`budget_plan_line_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ADD CONSTRAINT `fk_volunteer_training_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_component_id` FOREIGN KEY (`component_id`) REFERENCES `vibe_ngo_v1`.`program`.`component`(`component_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `vibe_ngo_v1`.`program`.`intervention`(`intervention_id`);

-- ========= volunteer --> supply (7 constraint(s)) =========
-- Requires: volunteer schema, supply schema
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ADD CONSTRAINT `fk_volunteer_deployment_distribution_order_id` FOREIGN KEY (`distribution_order_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_order`(`distribution_order_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ADD CONSTRAINT `fk_volunteer_deployment_distribution_plan_id` FOREIGN KEY (`distribution_plan_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_plan`(`distribution_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_distribution_order_id` FOREIGN KEY (`distribution_order_id`) REFERENCES `vibe_ngo_v1`.`supply`.`distribution_order`(`distribution_order_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ADD CONSTRAINT `fk_volunteer_training_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ADD CONSTRAINT `fk_volunteer_certification_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `vibe_ngo_v1`.`supply`.`commodity`(`commodity_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_ngo_v1`.`supply`.`warehouse`(`warehouse_id`);

