-- Cross-Domain Foreign Keys for Business: Education | Version: v1_ecm
-- Generated on: 2026-05-06 12:28:04
-- Total cross-domain FK constraints: 1351
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: advancement, aid, athletics, billing, compliance, curriculum, enrollment, facility, faculty, finance, hr, instruction, library, research, student, studentlife, technology

-- ========= advancement --> billing (2 constraint(s)) =========
-- Requires: advancement schema, billing schema
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ADD CONSTRAINT `fk_advancement_lifelong_learning_enrollment_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ADD CONSTRAINT `fk_advancement_lifelong_learning_enrollment_tuition_charge_id` FOREIGN KEY (`tuition_charge_id`) REFERENCES `education_ecm`.`billing`.`tuition_charge`(`tuition_charge_id`);

-- ========= advancement --> compliance (10 constraint(s)) =========
-- Requires: advancement schema, compliance schema
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ADD CONSTRAINT `fk_advancement_volunteer_assignment_ada_accommodation_id` FOREIGN KEY (`ada_accommodation_id`) REFERENCES `education_ecm`.`compliance`.`ada_accommodation`(`ada_accommodation_id`);
ALTER TABLE `education_ecm`.`advancement`.`career_record` ADD CONSTRAINT `fk_advancement_career_record_accreditation_review_id` FOREIGN KEY (`accreditation_review_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_review`(`accreditation_review_id`);
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ADD CONSTRAINT `fk_advancement_mentorship_match_ada_accommodation_id` FOREIGN KEY (`ada_accommodation_id`) REFERENCES `education_ecm`.`compliance`.`ada_accommodation`(`ada_accommodation_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ADD CONSTRAINT `fk_advancement_alumni_survey_accreditation_review_id` FOREIGN KEY (`accreditation_review_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_review`(`accreditation_review_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift` ADD CONSTRAINT `fk_advancement_gift_ipeds_submission_id` FOREIGN KEY (`ipeds_submission_id`) REFERENCES `education_ecm`.`compliance`.`ipeds_submission`(`ipeds_submission_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift` ADD CONSTRAINT `fk_advancement_gift_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ADD CONSTRAINT `fk_advancement_planned_gift_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ADD CONSTRAINT `fk_advancement_stewardship_action_ferpa_disclosure_id` FOREIGN KEY (`ferpa_disclosure_id`) REFERENCES `education_ecm`.`compliance`.`ferpa_disclosure`(`ferpa_disclosure_id`);
ALTER TABLE `education_ecm`.`advancement`.`event` ADD CONSTRAINT `fk_advancement_event_clery_incident_id` FOREIGN KEY (`clery_incident_id`) REFERENCES `education_ecm`.`compliance`.`clery_incident`(`clery_incident_id`);
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ADD CONSTRAINT `fk_advancement_corporate_sponsorship_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= advancement --> curriculum (6 constraint(s)) =========
-- Requires: advancement schema, curriculum schema
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ADD CONSTRAINT `fk_advancement_alumnus_cip_code_id` FOREIGN KEY (`cip_code_id`) REFERENCES `education_ecm`.`curriculum`.`cip_code`(`cip_code_id`);
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ADD CONSTRAINT `fk_advancement_affinity_group_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`advancement`.`career_record` ADD CONSTRAINT `fk_advancement_career_record_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ADD CONSTRAINT `fk_advancement_advanced_degree_cip_code_id` FOREIGN KEY (`cip_code_id`) REFERENCES `education_ecm`.`curriculum`.`cip_code`(`cip_code_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ADD CONSTRAINT `fk_advancement_alumni_survey_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ADD CONSTRAINT `fk_advancement_survey_response_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);

-- ========= advancement --> enrollment (2 constraint(s)) =========
-- Requires: advancement schema, enrollment schema
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ADD CONSTRAINT `fk_advancement_lifelong_learning_enrollment_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ADD CONSTRAINT `fk_advancement_alumni_award_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);

-- ========= advancement --> facility (1 constraint(s)) =========
-- Requires: advancement schema, facility schema
ALTER TABLE `education_ecm`.`advancement`.`event` ADD CONSTRAINT `fk_advancement_event_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);

-- ========= advancement --> faculty (1 constraint(s)) =========
-- Requires: advancement schema, faculty schema
ALTER TABLE `education_ecm`.`advancement`.`campaign_volunteer` ADD CONSTRAINT `fk_advancement_campaign_volunteer_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);

-- ========= advancement --> finance (46 constraint(s)) =========
-- Requires: advancement schema, finance schema
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ADD CONSTRAINT `fk_advancement_affinity_group_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ADD CONSTRAINT `fk_advancement_affinity_group_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ADD CONSTRAINT `fk_advancement_group_membership_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ADD CONSTRAINT `fk_advancement_engagement_activity_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ADD CONSTRAINT `fk_advancement_alumni_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ADD CONSTRAINT `fk_advancement_alumni_event_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ADD CONSTRAINT `fk_advancement_alumni_event_registration_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ADD CONSTRAINT `fk_advancement_volunteer_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ADD CONSTRAINT `fk_advancement_volunteer_assignment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ADD CONSTRAINT `fk_advancement_mentorship_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ADD CONSTRAINT `fk_advancement_mentorship_program_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ADD CONSTRAINT `fk_advancement_mentorship_match_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ADD CONSTRAINT `fk_advancement_lifelong_learning_enrollment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ADD CONSTRAINT `fk_advancement_alumni_survey_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ADD CONSTRAINT `fk_advancement_alumni_survey_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ADD CONSTRAINT `fk_advancement_alumni_award_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ADD CONSTRAINT `fk_advancement_alumni_award_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ADD CONSTRAINT `fk_advancement_outreach_communication_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift` ADD CONSTRAINT `fk_advancement_gift_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift` ADD CONSTRAINT `fk_advancement_gift_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`advancement`.`pledge` ADD CONSTRAINT `fk_advancement_pledge_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`pledge` ADD CONSTRAINT `fk_advancement_pledge_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`advancement`.`campaign` ADD CONSTRAINT `fk_advancement_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`advancement`.`campaign` ADD CONSTRAINT `fk_advancement_campaign_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ADD CONSTRAINT `fk_advancement_advancement_fund_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ADD CONSTRAINT `fk_advancement_advancement_fund_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ADD CONSTRAINT `fk_advancement_advancement_fund_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`advancement`.`appeal` ADD CONSTRAINT `fk_advancement_appeal_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ADD CONSTRAINT `fk_advancement_major_gift_proposal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ADD CONSTRAINT `fk_advancement_major_gift_proposal_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ADD CONSTRAINT `fk_advancement_planned_gift_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ADD CONSTRAINT `fk_advancement_prospect_rating_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ADD CONSTRAINT `fk_advancement_stewardship_action_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`endowment` ADD CONSTRAINT `fk_advancement_endowment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`endowment` ADD CONSTRAINT `fk_advancement_endowment_investment_pool_id` FOREIGN KEY (`investment_pool_id`) REFERENCES `education_ecm`.`finance`.`investment_pool`(`investment_pool_id`);
ALTER TABLE `education_ecm`.`advancement`.`endowment` ADD CONSTRAINT `fk_advancement_endowment_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ADD CONSTRAINT `fk_advancement_matching_gift_claim_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ADD CONSTRAINT `fk_advancement_matching_gift_claim_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `education_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ADD CONSTRAINT `fk_advancement_matching_gift_claim_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`advancement`.`event` ADD CONSTRAINT `fk_advancement_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`advancement`.`event` ADD CONSTRAINT `fk_advancement_event_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ADD CONSTRAINT `fk_advancement_recognition_society_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ADD CONSTRAINT `fk_advancement_recognition_society_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ADD CONSTRAINT `fk_advancement_corporate_sponsorship_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ADD CONSTRAINT `fk_advancement_corporate_sponsorship_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ADD CONSTRAINT `fk_advancement_corporate_sponsorship_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);

-- ========= advancement --> hr (32 constraint(s)) =========
-- Requires: advancement schema, hr schema
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ADD CONSTRAINT `fk_advancement_affinity_group_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ADD CONSTRAINT `fk_advancement_engagement_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ADD CONSTRAINT `fk_advancement_alumni_event_registration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ADD CONSTRAINT `fk_advancement_volunteer_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ADD CONSTRAINT `fk_advancement_mentorship_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ADD CONSTRAINT `fk_advancement_mentorship_program_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ADD CONSTRAINT `fk_advancement_mentorship_program_owning_org_unit_id` FOREIGN KEY (`owning_org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ADD CONSTRAINT `fk_advancement_mentorship_match_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ADD CONSTRAINT `fk_advancement_survey_response_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ADD CONSTRAINT `fk_advancement_outreach_communication_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`donor` ADD CONSTRAINT `fk_advancement_donor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift` ADD CONSTRAINT `fk_advancement_gift_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift` ADD CONSTRAINT `fk_advancement_gift_gift_officer_employee_id` FOREIGN KEY (`gift_officer_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`pledge` ADD CONSTRAINT `fk_advancement_pledge_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`campaign` ADD CONSTRAINT `fk_advancement_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`campaign` ADD CONSTRAINT `fk_advancement_campaign_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ADD CONSTRAINT `fk_advancement_advancement_fund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ADD CONSTRAINT `fk_advancement_advancement_fund_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`advancement`.`appeal` ADD CONSTRAINT `fk_advancement_appeal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`appeal` ADD CONSTRAINT `fk_advancement_appeal_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ADD CONSTRAINT `fk_advancement_major_gift_proposal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ADD CONSTRAINT `fk_advancement_planned_gift_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ADD CONSTRAINT `fk_advancement_prospect_rating_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ADD CONSTRAINT `fk_advancement_stewardship_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`endowment` ADD CONSTRAINT `fk_advancement_endowment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ADD CONSTRAINT `fk_advancement_matching_gift_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`event` ADD CONSTRAINT `fk_advancement_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ADD CONSTRAINT `fk_advancement_recognition_society_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ADD CONSTRAINT `fk_advancement_recognition_society_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ADD CONSTRAINT `fk_advancement_corporate_sponsorship_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift_agreement` ADD CONSTRAINT `fk_advancement_gift_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_plan` ADD CONSTRAINT `fk_advancement_stewardship_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= advancement --> instruction (4 constraint(s)) =========
-- Requires: advancement schema, instruction schema
ALTER TABLE `education_ecm`.`advancement`.`career_record` ADD CONSTRAINT `fk_advancement_career_record_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ADD CONSTRAINT `fk_advancement_mentorship_match_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ADD CONSTRAINT `fk_advancement_lifelong_learning_enrollment_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ADD CONSTRAINT `fk_advancement_survey_response_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);

-- ========= advancement --> research (9 constraint(s)) =========
-- Requires: advancement schema, research schema
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ADD CONSTRAINT `fk_advancement_engagement_activity_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ADD CONSTRAINT `fk_advancement_volunteer_assignment_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ADD CONSTRAINT `fk_advancement_mentorship_match_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift` ADD CONSTRAINT `fk_advancement_gift_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`advancement`.`pledge` ADD CONSTRAINT `fk_advancement_pledge_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ADD CONSTRAINT `fk_advancement_advancement_fund_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ADD CONSTRAINT `fk_advancement_planned_gift_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ADD CONSTRAINT `fk_advancement_stewardship_action_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ADD CONSTRAINT `fk_advancement_matching_gift_claim_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);

-- ========= advancement --> student (2 constraint(s)) =========
-- Requires: advancement schema, student schema
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ADD CONSTRAINT `fk_advancement_alumnus_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ADD CONSTRAINT `fk_advancement_mentorship_match_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= advancement --> studentlife (1 constraint(s)) =========
-- Requires: advancement schema, studentlife schema
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ADD CONSTRAINT `fk_advancement_alumnus_cocurricular_record_id` FOREIGN KEY (`cocurricular_record_id`) REFERENCES `education_ecm`.`studentlife`.`cocurricular_record`(`cocurricular_record_id`);

-- ========= advancement --> technology (12 constraint(s)) =========
-- Requires: advancement schema, technology schema
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ADD CONSTRAINT `fk_advancement_engagement_activity_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ADD CONSTRAINT `fk_advancement_volunteer_assignment_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `education_ecm`.`technology`.`service_request`(`service_request_id`);
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ADD CONSTRAINT `fk_advancement_mentorship_match_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ADD CONSTRAINT `fk_advancement_lifelong_learning_enrollment_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ADD CONSTRAINT `fk_advancement_alumni_survey_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ADD CONSTRAINT `fk_advancement_outreach_communication_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`advancement`.`donor` ADD CONSTRAINT `fk_advancement_donor_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift` ADD CONSTRAINT `fk_advancement_gift_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`advancement`.`event` ADD CONSTRAINT `fk_advancement_event_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `education_ecm`.`technology`.`service_request`(`service_request_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_application_access` ADD CONSTRAINT `fk_advancement_advancement_application_access_access_entitlement_id` FOREIGN KEY (`access_entitlement_id`) REFERENCES `education_ecm`.`technology`.`access_entitlement`(`access_entitlement_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_application_access` ADD CONSTRAINT `fk_advancement_advancement_application_access_access_provisioning_event_id` FOREIGN KEY (`access_provisioning_event_id`) REFERENCES `education_ecm`.`technology`.`access_provisioning_event`(`access_provisioning_event_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_application_access` ADD CONSTRAINT `fk_advancement_advancement_application_access_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);

-- ========= aid --> advancement (2 constraint(s)) =========
-- Requires: aid schema, advancement schema
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ADD CONSTRAINT `fk_aid_aid_fund_endowment_id` FOREIGN KEY (`endowment_id`) REFERENCES `education_ecm`.`advancement`.`endowment`(`endowment_id`);
ALTER TABLE `education_ecm`.`aid`.`scholarship` ADD CONSTRAINT `fk_aid_scholarship_endowment_id` FOREIGN KEY (`endowment_id`) REFERENCES `education_ecm`.`advancement`.`endowment`(`endowment_id`);

-- ========= aid --> athletics (1 constraint(s)) =========
-- Requires: aid schema, athletics schema
ALTER TABLE `education_ecm`.`aid`.`r2t4_calculation` ADD CONSTRAINT `fk_aid_r2t4_calculation_student_athlete_id` FOREIGN KEY (`student_athlete_id`) REFERENCES `education_ecm`.`athletics`.`student_athlete`(`student_athlete_id`);

-- ========= aid --> billing (7 constraint(s)) =========
-- Requires: aid schema, billing schema
ALTER TABLE `education_ecm`.`aid`.`aid_application` ADD CONSTRAINT `fk_aid_aid_application_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`aid`.`award_package` ADD CONSTRAINT `fk_aid_award_package_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_award` ADD CONSTRAINT `fk_aid_aid_award_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`aid`.`loan_record` ADD CONSTRAINT `fk_aid_loan_record_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`aid`.`workstudy_assignment` ADD CONSTRAINT `fk_aid_workstudy_assignment_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`aid`.`fund_fee_coverage` ADD CONSTRAINT `fk_aid_fund_fee_coverage_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `education_ecm`.`billing`.`fee_schedule`(`fee_schedule_id`);

-- ========= aid --> compliance (14 constraint(s)) =========
-- Requires: aid schema, compliance schema
ALTER TABLE `education_ecm`.`aid`.`aid_application` ADD CONSTRAINT `fk_aid_aid_application_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`aid`.`award_package` ADD CONSTRAINT `fk_aid_award_package_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_award` ADD CONSTRAINT `fk_aid_aid_award_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ADD CONSTRAINT `fk_aid_aid_fund_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ADD CONSTRAINT `fk_aid_coa_budget_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`aid`.`isir_record` ADD CONSTRAINT `fk_aid_isir_record_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`aid`.`verification` ADD CONSTRAINT `fk_aid_verification_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_sap_evaluation` ADD CONSTRAINT `fk_aid_aid_sap_evaluation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`aid`.`loan_record` ADD CONSTRAINT `fk_aid_loan_record_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`aid`.`scholarship` ADD CONSTRAINT `fk_aid_scholarship_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`aid`.`r2t4_calculation` ADD CONSTRAINT `fk_aid_r2t4_calculation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`aid`.`professional_judgment` ADD CONSTRAINT `fk_aid_professional_judgment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`aid`.`workstudy_assignment` ADD CONSTRAINT `fk_aid_workstudy_assignment_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= aid --> curriculum (9 constraint(s)) =========
-- Requires: aid schema, curriculum schema
ALTER TABLE `education_ecm`.`aid`.`aid_application` ADD CONSTRAINT `fk_aid_aid_application_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`aid`.`award_package` ADD CONSTRAINT `fk_aid_award_package_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_award` ADD CONSTRAINT `fk_aid_aid_award_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ADD CONSTRAINT `fk_aid_coa_budget_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_sap_evaluation` ADD CONSTRAINT `fk_aid_aid_sap_evaluation_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`aid`.`scholarship` ADD CONSTRAINT `fk_aid_scholarship_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`aid`.`scholarship` ADD CONSTRAINT `fk_aid_scholarship_concentration_id` FOREIGN KEY (`concentration_id`) REFERENCES `education_ecm`.`curriculum`.`concentration`(`concentration_id`);
ALTER TABLE `education_ecm`.`aid`.`workstudy_assignment` ADD CONSTRAINT `fk_aid_workstudy_assignment_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ADD CONSTRAINT `fk_aid_veteran_benefit_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);

-- ========= aid --> enrollment (5 constraint(s)) =========
-- Requires: aid schema, enrollment schema
ALTER TABLE `education_ecm`.`aid`.`aid_award` ADD CONSTRAINT `fk_aid_aid_award_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_sap_evaluation` ADD CONSTRAINT `fk_aid_aid_sap_evaluation_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`aid`.`r2t4_calculation` ADD CONSTRAINT `fk_aid_r2t4_calculation_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ADD CONSTRAINT `fk_aid_veteran_benefit_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);

-- ========= aid --> facility (3 constraint(s)) =========
-- Requires: aid schema, facility schema
ALTER TABLE `education_ecm`.`aid`.`aid_application` ADD CONSTRAINT `fk_aid_aid_application_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`aid`.`workstudy_assignment` ADD CONSTRAINT `fk_aid_workstudy_assignment_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`aid`.`workstudy_assignment` ADD CONSTRAINT `fk_aid_workstudy_assignment_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);

-- ========= aid --> faculty (1 constraint(s)) =========
-- Requires: aid schema, faculty schema
ALTER TABLE `education_ecm`.`aid`.`workstudy_assignment` ADD CONSTRAINT `fk_aid_workstudy_assignment_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);

-- ========= aid --> finance (6 constraint(s)) =========
-- Requires: aid schema, finance schema
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `education_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ADD CONSTRAINT `fk_aid_aid_fund_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`aid`.`loan_record` ADD CONSTRAINT `fk_aid_loan_record_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `education_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `education_ecm`.`aid`.`scholarship` ADD CONSTRAINT `fk_aid_scholarship_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`aid`.`r2t4_calculation` ADD CONSTRAINT `fk_aid_r2t4_calculation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `education_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `education_ecm`.`aid`.`workstudy_assignment` ADD CONSTRAINT `fk_aid_workstudy_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= aid --> hr (10 constraint(s)) =========
-- Requires: aid schema, hr schema
ALTER TABLE `education_ecm`.`aid`.`aid_application` ADD CONSTRAINT `fk_aid_aid_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`aid`.`award_package` ADD CONSTRAINT `fk_aid_award_package_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`aid`.`verification` ADD CONSTRAINT `fk_aid_verification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_sap_evaluation` ADD CONSTRAINT `fk_aid_aid_sap_evaluation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`aid`.`r2t4_calculation` ADD CONSTRAINT `fk_aid_r2t4_calculation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`aid`.`professional_judgment` ADD CONSTRAINT `fk_aid_professional_judgment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`aid`.`workstudy_assignment` ADD CONSTRAINT `fk_aid_workstudy_assignment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`aid`.`workstudy_assignment` ADD CONSTRAINT `fk_aid_workstudy_assignment_position_id` FOREIGN KEY (`position_id`) REFERENCES `education_ecm`.`hr`.`position`(`position_id`);
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ADD CONSTRAINT `fk_aid_veteran_benefit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= aid --> instruction (2 constraint(s)) =========
-- Requires: aid schema, instruction schema
ALTER TABLE `education_ecm`.`aid`.`aid_award` ADD CONSTRAINT `fk_aid_aid_award_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`aid`.`workstudy_assignment` ADD CONSTRAINT `fk_aid_workstudy_assignment_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);

-- ========= aid --> research (2 constraint(s)) =========
-- Requires: aid schema, research schema
ALTER TABLE `education_ecm`.`aid`.`scholarship` ADD CONSTRAINT `fk_aid_scholarship_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`aid`.`workstudy_assignment` ADD CONSTRAINT `fk_aid_workstudy_assignment_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);

-- ========= aid --> student (14 constraint(s)) =========
-- Requires: aid schema, student schema
ALTER TABLE `education_ecm`.`aid`.`aid_application` ADD CONSTRAINT `fk_aid_aid_application_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`aid`.`award_package` ADD CONSTRAINT `fk_aid_award_package_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_award` ADD CONSTRAINT `fk_aid_aid_award_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`aid`.`isir_record` ADD CONSTRAINT `fk_aid_isir_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`aid`.`verification` ADD CONSTRAINT `fk_aid_verification_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_sap_evaluation` ADD CONSTRAINT `fk_aid_aid_sap_evaluation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`aid`.`loan_record` ADD CONSTRAINT `fk_aid_loan_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`aid`.`r2t4_calculation` ADD CONSTRAINT `fk_aid_r2t4_calculation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`aid`.`professional_judgment` ADD CONSTRAINT `fk_aid_professional_judgment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`aid`.`workstudy_assignment` ADD CONSTRAINT `fk_aid_workstudy_assignment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ADD CONSTRAINT `fk_aid_veteran_benefit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`aid`.`master_promissory_note` ADD CONSTRAINT `fk_aid_master_promissory_note_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`aid`.`borrower` ADD CONSTRAINT `fk_aid_borrower_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= aid --> studentlife (7 constraint(s)) =========
-- Requires: aid schema, studentlife schema
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_studentlife_housing_assignment_id` FOREIGN KEY (`studentlife_housing_assignment_id`) REFERENCES `education_ecm`.`studentlife`.`studentlife_housing_assignment`(`studentlife_housing_assignment_id`);
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ADD CONSTRAINT `fk_aid_coa_budget_dining_plan_id` FOREIGN KEY (`dining_plan_id`) REFERENCES `education_ecm`.`studentlife`.`dining_plan`(`dining_plan_id`);
ALTER TABLE `education_ecm`.`aid`.`scholarship` ADD CONSTRAINT `fk_aid_scholarship_student_org_id` FOREIGN KEY (`student_org_id`) REFERENCES `education_ecm`.`studentlife`.`student_org`(`student_org_id`);
ALTER TABLE `education_ecm`.`aid`.`r2t4_calculation` ADD CONSTRAINT `fk_aid_r2t4_calculation_studentlife_housing_assignment_id` FOREIGN KEY (`studentlife_housing_assignment_id`) REFERENCES `education_ecm`.`studentlife`.`studentlife_housing_assignment`(`studentlife_housing_assignment_id`);
ALTER TABLE `education_ecm`.`aid`.`professional_judgment` ADD CONSTRAINT `fk_aid_professional_judgment_housing_application_id` FOREIGN KEY (`housing_application_id`) REFERENCES `education_ecm`.`studentlife`.`housing_application`(`housing_application_id`);
ALTER TABLE `education_ecm`.`aid`.`workstudy_assignment` ADD CONSTRAINT `fk_aid_workstudy_assignment_studentlife_housing_assignment_id` FOREIGN KEY (`studentlife_housing_assignment_id`) REFERENCES `education_ecm`.`studentlife`.`studentlife_housing_assignment`(`studentlife_housing_assignment_id`);
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ADD CONSTRAINT `fk_aid_veteran_benefit_studentlife_housing_assignment_id` FOREIGN KEY (`studentlife_housing_assignment_id`) REFERENCES `education_ecm`.`studentlife`.`studentlife_housing_assignment`(`studentlife_housing_assignment_id`);

-- ========= aid --> technology (5 constraint(s)) =========
-- Requires: aid schema, technology schema
ALTER TABLE `education_ecm`.`aid`.`aid_application` ADD CONSTRAINT `fk_aid_aid_application_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `education_ecm`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `education_ecm`.`aid`.`isir_record` ADD CONSTRAINT `fk_aid_isir_record_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`aid`.`isir_record` ADD CONSTRAINT `fk_aid_isir_record_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `education_ecm`.`technology`.`it_service`(`it_service_id`);

-- ========= athletics --> advancement (1 constraint(s)) =========
-- Requires: athletics schema, advancement schema
ALTER TABLE `education_ecm`.`athletics`.`booster` ADD CONSTRAINT `fk_athletics_booster_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);

-- ========= athletics --> aid (1 constraint(s)) =========
-- Requires: athletics schema, aid schema
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ADD CONSTRAINT `fk_athletics_athletic_scholarship_aid_award_id` FOREIGN KEY (`aid_award_id`) REFERENCES `education_ecm`.`aid`.`aid_award`(`aid_award_id`);

-- ========= athletics --> billing (5 constraint(s)) =========
-- Requires: athletics schema, billing schema
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ADD CONSTRAINT `fk_athletics_student_athlete_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ADD CONSTRAINT `fk_athletics_athletic_scholarship_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ADD CONSTRAINT `fk_athletics_athletic_scholarship_tuition_charge_id` FOREIGN KEY (`tuition_charge_id`) REFERENCES `education_ecm`.`billing`.`tuition_charge`(`tuition_charge_id`);
ALTER TABLE `education_ecm`.`athletics`.`nli` ADD CONSTRAINT `fk_athletics_nli_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`athletics`.`booster` ADD CONSTRAINT `fk_athletics_booster_third_party_contract_id` FOREIGN KEY (`third_party_contract_id`) REFERENCES `education_ecm`.`billing`.`third_party_contract`(`third_party_contract_id`);

-- ========= athletics --> compliance (23 constraint(s)) =========
-- Requires: athletics schema, compliance schema
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ADD CONSTRAINT `fk_athletics_athletic_eligibility_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ADD CONSTRAINT `fk_athletics_athletic_eligibility_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ADD CONSTRAINT `fk_athletics_athletic_eligibility_title_ix_case_id` FOREIGN KEY (`title_ix_case_id`) REFERENCES `education_ecm`.`compliance`.`title_ix_case`(`title_ix_case_id`);
ALTER TABLE `education_ecm`.`athletics`.`sport` ADD CONSTRAINT `fk_athletics_sport_accreditation_standard_id` FOREIGN KEY (`accreditation_standard_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_standard`(`accreditation_standard_id`);
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ADD CONSTRAINT `fk_athletics_student_athlete_ada_accommodation_id` FOREIGN KEY (`ada_accommodation_id`) REFERENCES `education_ecm`.`compliance`.`ada_accommodation`(`ada_accommodation_id`);
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ADD CONSTRAINT `fk_athletics_student_athlete_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `education_ecm`.`compliance`.`training_program`(`training_program_id`);
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ADD CONSTRAINT `fk_athletics_eligibility_certification_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ADD CONSTRAINT `fk_athletics_athletic_scholarship_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ADD CONSTRAINT `fk_athletics_athletic_scholarship_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`athletics`.`nli` ADD CONSTRAINT `fk_athletics_nli_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ADD CONSTRAINT `fk_athletics_recruiting_contact_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ADD CONSTRAINT `fk_athletics_recruiting_contact_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ADD CONSTRAINT `fk_athletics_official_visit_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ADD CONSTRAINT `fk_athletics_official_visit_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ADD CONSTRAINT `fk_athletics_athletic_facility_clery_incident_id` FOREIGN KEY (`clery_incident_id`) REFERENCES `education_ecm`.`compliance`.`clery_incident`(`clery_incident_id`);
ALTER TABLE `education_ecm`.`athletics`.`coach` ADD CONSTRAINT `fk_athletics_coach_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `education_ecm`.`compliance`.`training_program`(`training_program_id`);
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ADD CONSTRAINT `fk_athletics_compliance_waiver_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `education_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ADD CONSTRAINT `fk_athletics_compliance_waiver_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ADD CONSTRAINT `fk_athletics_secondary_violation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ADD CONSTRAINT `fk_athletics_eada_report_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ADD CONSTRAINT `fk_athletics_drug_test_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`athletics`.`booster` ADD CONSTRAINT `fk_athletics_booster_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `education_ecm`.`compliance`.`training_program`(`training_program_id`);
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ADD CONSTRAINT `fk_athletics_nil_activity_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= athletics --> curriculum (3 constraint(s)) =========
-- Requires: athletics schema, curriculum schema
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ADD CONSTRAINT `fk_athletics_athletic_eligibility_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ADD CONSTRAINT `fk_athletics_student_athlete_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ADD CONSTRAINT `fk_athletics_eligibility_certification_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);

-- ========= athletics --> enrollment (3 constraint(s)) =========
-- Requires: athletics schema, enrollment schema
ALTER TABLE `education_ecm`.`athletics`.`nli` ADD CONSTRAINT `fk_athletics_nli_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `education_ecm`.`enrollment`.`prospect`(`prospect_id`);
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ADD CONSTRAINT `fk_athletics_recruiting_contact_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `education_ecm`.`enrollment`.`prospect`(`prospect_id`);
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ADD CONSTRAINT `fk_athletics_official_visit_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `education_ecm`.`enrollment`.`prospect`(`prospect_id`);

-- ========= athletics --> facility (2 constraint(s)) =========
-- Requires: athletics schema, facility schema
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ADD CONSTRAINT `fk_athletics_athletic_facility_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ADD CONSTRAINT `fk_athletics_eada_report_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);

-- ========= athletics --> finance (11 constraint(s)) =========
-- Requires: athletics schema, finance schema
ALTER TABLE `education_ecm`.`athletics`.`team` ADD CONSTRAINT `fk_athletics_team_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `education_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `education_ecm`.`athletics`.`team` ADD CONSTRAINT `fk_athletics_team_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ADD CONSTRAINT `fk_athletics_athletic_scholarship_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ADD CONSTRAINT `fk_athletics_athletic_scholarship_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ADD CONSTRAINT `fk_athletics_official_visit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ADD CONSTRAINT `fk_athletics_official_visit_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ADD CONSTRAINT `fk_athletics_athletic_facility_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `education_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ADD CONSTRAINT `fk_athletics_athletic_facility_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ADD CONSTRAINT `fk_athletics_facility_event_booking_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `education_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `education_ecm`.`athletics`.`coach` ADD CONSTRAINT `fk_athletics_coach_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ADD CONSTRAINT `fk_athletics_secondary_violation_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);

-- ========= athletics --> hr (29 constraint(s)) =========
-- Requires: athletics schema, hr schema
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ADD CONSTRAINT `fk_athletics_athletic_eligibility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`roster` ADD CONSTRAINT `fk_athletics_roster_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ADD CONSTRAINT `fk_athletics_student_athlete_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ADD CONSTRAINT `fk_athletics_eligibility_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ADD CONSTRAINT `fk_athletics_athletic_scholarship_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`nli` ADD CONSTRAINT `fk_athletics_nli_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`nli` ADD CONSTRAINT `fk_athletics_nli_nli_employee_id` FOREIGN KEY (`nli_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ADD CONSTRAINT `fk_athletics_recruiting_contact_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ADD CONSTRAINT `fk_athletics_recruiting_contact_tertiary_recruiting_record_created_by_staff_employee_id` FOREIGN KEY (`tertiary_recruiting_record_created_by_staff_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ADD CONSTRAINT `fk_athletics_official_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ADD CONSTRAINT `fk_athletics_official_visit_tertiary_official_compliance_post_certified_by_staff_employee_id` FOREIGN KEY (`tertiary_official_compliance_post_certified_by_staff_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`game` ADD CONSTRAINT `fk_athletics_game_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ADD CONSTRAINT `fk_athletics_game_participation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ADD CONSTRAINT `fk_athletics_practice_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ADD CONSTRAINT `fk_athletics_athletic_facility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ADD CONSTRAINT `fk_athletics_facility_event_booking_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`coach` ADD CONSTRAINT `fk_athletics_coach_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`coach` ADD CONSTRAINT `fk_athletics_coach_staff_employee_id` FOREIGN KEY (`staff_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ADD CONSTRAINT `fk_athletics_athletic_award_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ADD CONSTRAINT `fk_athletics_athletic_award_tertiary_athletic_last_updated_by_staff_employee_id` FOREIGN KEY (`tertiary_athletic_last_updated_by_staff_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ADD CONSTRAINT `fk_athletics_compliance_waiver_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ADD CONSTRAINT `fk_athletics_secondary_violation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ADD CONSTRAINT `fk_athletics_secondary_violation_secondary_employee_id` FOREIGN KEY (`secondary_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ADD CONSTRAINT `fk_athletics_sports_medicine_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ADD CONSTRAINT `fk_athletics_sports_medicine_case_quaternary_sports_record_updated_by_staff_employee_id` FOREIGN KEY (`quaternary_sports_record_updated_by_staff_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ADD CONSTRAINT `fk_athletics_sports_medicine_case_tertiary_sports_cleared_by_physician_employee_id` FOREIGN KEY (`tertiary_sports_cleared_by_physician_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ADD CONSTRAINT `fk_athletics_drug_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`booster` ADD CONSTRAINT `fk_athletics_booster_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ADD CONSTRAINT `fk_athletics_nil_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= athletics --> library (1 constraint(s)) =========
-- Requires: athletics schema, library schema
ALTER TABLE `education_ecm`.`athletics`.`coach` ADD CONSTRAINT `fk_athletics_coach_patron_id` FOREIGN KEY (`patron_id`) REFERENCES `education_ecm`.`library`.`patron`(`patron_id`);

-- ========= athletics --> research (4 constraint(s)) =========
-- Requires: athletics schema, research schema
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ADD CONSTRAINT `fk_athletics_student_athlete_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`athletics`.`coach` ADD CONSTRAINT `fk_athletics_coach_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ADD CONSTRAINT `fk_athletics_sports_medicine_case_irb_protocol_id` FOREIGN KEY (`irb_protocol_id`) REFERENCES `education_ecm`.`research`.`irb_protocol`(`irb_protocol_id`);
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ADD CONSTRAINT `fk_athletics_drug_test_irb_protocol_id` FOREIGN KEY (`irb_protocol_id`) REFERENCES `education_ecm`.`research`.`irb_protocol`(`irb_protocol_id`);

-- ========= athletics --> student (1 constraint(s)) =========
-- Requires: athletics schema, student schema
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ADD CONSTRAINT `fk_athletics_student_athlete_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= billing --> advancement (10 constraint(s)) =========
-- Requires: billing schema, advancement schema
ALTER TABLE `education_ecm`.`billing`.`student_account` ADD CONSTRAINT `fk_billing_student_account_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ADD CONSTRAINT `fk_billing_third_party_contract_corporate_sponsorship_id` FOREIGN KEY (`corporate_sponsorship_id`) REFERENCES `education_ecm`.`advancement`.`corporate_sponsorship`(`corporate_sponsorship_id`);
ALTER TABLE `education_ecm`.`billing`.`sponsor_invoice` ADD CONSTRAINT `fk_billing_sponsor_invoice_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`billing`.`account_hold` ADD CONSTRAINT `fk_billing_account_hold_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`billing`.`collections_case` ADD CONSTRAINT `fk_billing_collections_case_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ADD CONSTRAINT `fk_billing_tax_form_1098t_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`billing`.`late_fee` ADD CONSTRAINT `fk_billing_late_fee_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);

-- ========= billing --> aid (1 constraint(s)) =========
-- Requires: billing schema, aid schema
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_aid_award_id` FOREIGN KEY (`aid_award_id`) REFERENCES `education_ecm`.`aid`.`aid_award`(`aid_award_id`);

-- ========= billing --> compliance (11 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ADD CONSTRAINT `fk_billing_third_party_contract_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ADD CONSTRAINT `fk_billing_third_party_contract_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`billing`.`account_hold` ADD CONSTRAINT `fk_billing_account_hold_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`billing`.`collections_case` ADD CONSTRAINT `fk_billing_collections_case_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`billing`.`collections_case` ADD CONSTRAINT `fk_billing_collections_case_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ADD CONSTRAINT `fk_billing_tax_form_1098t_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`billing`.`charge_adjustment` ADD CONSTRAINT `fk_billing_charge_adjustment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ADD CONSTRAINT `fk_billing_fee_schedule_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`billing`.`late_fee` ADD CONSTRAINT `fk_billing_late_fee_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);

-- ========= billing --> curriculum (4 constraint(s)) =========
-- Requires: billing schema, curriculum schema
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ADD CONSTRAINT `fk_billing_fee_schedule_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ADD CONSTRAINT `fk_billing_fee_schedule_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);

-- ========= billing --> enrollment (8 constraint(s)) =========
-- Requires: billing schema, enrollment schema
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`billing`.`sponsor_invoice` ADD CONSTRAINT `fk_billing_sponsor_invoice_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ADD CONSTRAINT `fk_billing_fee_schedule_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`billing`.`late_fee` ADD CONSTRAINT `fk_billing_late_fee_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`billing`.`cashier_session` ADD CONSTRAINT `fk_billing_cashier_session_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);

-- ========= billing --> facility (1 constraint(s)) =========
-- Requires: billing schema, facility schema
ALTER TABLE `education_ecm`.`billing`.`cashier_session` ADD CONSTRAINT `fk_billing_cashier_session_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);

-- ========= billing --> faculty (1 constraint(s)) =========
-- Requires: billing schema, faculty schema
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);

-- ========= billing --> finance (12 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `education_ecm`.`billing`.`student_account` ADD CONSTRAINT `fk_billing_student_account_finance_vendor_id` FOREIGN KEY (`finance_vendor_id`) REFERENCES `education_ecm`.`finance`.`finance_vendor`(`finance_vendor_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_finance_vendor_id` FOREIGN KEY (`finance_vendor_id`) REFERENCES `education_ecm`.`finance`.`finance_vendor`(`finance_vendor_id`);
ALTER TABLE `education_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `education_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ADD CONSTRAINT `fk_billing_third_party_contract_finance_vendor_id` FOREIGN KEY (`finance_vendor_id`) REFERENCES `education_ecm`.`finance`.`finance_vendor`(`finance_vendor_id`);
ALTER TABLE `education_ecm`.`billing`.`sponsor_invoice` ADD CONSTRAINT `fk_billing_sponsor_invoice_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`billing`.`collections_case` ADD CONSTRAINT `fk_billing_collections_case_finance_vendor_id` FOREIGN KEY (`finance_vendor_id`) REFERENCES `education_ecm`.`finance`.`finance_vendor`(`finance_vendor_id`);
ALTER TABLE `education_ecm`.`billing`.`charge_adjustment` ADD CONSTRAINT `fk_billing_charge_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `education_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `education_ecm`.`billing`.`charge_adjustment` ADD CONSTRAINT `fk_billing_charge_adjustment_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`billing`.`late_fee` ADD CONSTRAINT `fk_billing_late_fee_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`billing`.`cashier_session` ADD CONSTRAINT `fk_billing_cashier_session_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `education_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= billing --> hr (17 constraint(s)) =========
-- Requires: billing schema, hr schema
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_refund_processed_by_user_employee_id` FOREIGN KEY (`refund_processed_by_user_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ADD CONSTRAINT `fk_billing_third_party_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ADD CONSTRAINT `fk_billing_third_party_contract_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`billing`.`account_hold` ADD CONSTRAINT `fk_billing_account_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`billing`.`account_hold` ADD CONSTRAINT `fk_billing_account_hold_tertiary_account_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_account_last_modified_by_user_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`billing`.`collections_case` ADD CONSTRAINT `fk_billing_collections_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`billing`.`charge_adjustment` ADD CONSTRAINT `fk_billing_charge_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ADD CONSTRAINT `fk_billing_fee_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ADD CONSTRAINT `fk_billing_fee_schedule_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`billing`.`late_fee` ADD CONSTRAINT `fk_billing_late_fee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`billing`.`cashier_session` ADD CONSTRAINT `fk_billing_cashier_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`billing`.`cashier_session` ADD CONSTRAINT `fk_billing_cashier_session_quaternary_cashier_last_modified_by_user_employee_id` FOREIGN KEY (`quaternary_cashier_last_modified_by_user_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`billing`.`cashier_session` ADD CONSTRAINT `fk_billing_cashier_session_tertiary_cashier_supervisor_employee_id` FOREIGN KEY (`tertiary_cashier_supervisor_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= billing --> library (1 constraint(s)) =========
-- Requires: billing schema, library schema
ALTER TABLE `education_ecm`.`billing`.`student_account` ADD CONSTRAINT `fk_billing_student_account_patron_id` FOREIGN KEY (`patron_id`) REFERENCES `education_ecm`.`library`.`patron`(`patron_id`);

-- ========= billing --> research (5 constraint(s)) =========
-- Requires: billing schema, research schema
ALTER TABLE `education_ecm`.`billing`.`student_account` ADD CONSTRAINT `fk_billing_student_account_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `education_ecm`.`research`.`sponsor`(`sponsor_id`);
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`billing`.`sponsor_invoice` ADD CONSTRAINT `fk_billing_sponsor_invoice_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `education_ecm`.`research`.`sponsor`(`sponsor_id`);
ALTER TABLE `education_ecm`.`billing`.`charge_adjustment` ADD CONSTRAINT `fk_billing_charge_adjustment_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`billing`.`charge_adjustment` ADD CONSTRAINT `fk_billing_charge_adjustment_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `education_ecm`.`research`.`sponsor`(`sponsor_id`);

-- ========= billing --> student (11 constraint(s)) =========
-- Requires: billing schema, student schema
ALTER TABLE `education_ecm`.`billing`.`student_account` ADD CONSTRAINT `fk_billing_student_account_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`billing`.`account_hold` ADD CONSTRAINT `fk_billing_account_hold_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`billing`.`collections_case` ADD CONSTRAINT `fk_billing_collections_case_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ADD CONSTRAINT `fk_billing_tax_form_1098t_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`billing`.`charge_adjustment` ADD CONSTRAINT `fk_billing_charge_adjustment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`billing`.`late_fee` ADD CONSTRAINT `fk_billing_late_fee_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= billing --> technology (4 constraint(s)) =========
-- Requires: billing schema, technology schema
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ADD CONSTRAINT `fk_billing_third_party_contract_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`billing`.`collections_case` ADD CONSTRAINT `fk_billing_collections_case_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ADD CONSTRAINT `fk_billing_fee_schedule_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`billing`.`cashier_session` ADD CONSTRAINT `fk_billing_cashier_session_configuration_item_id` FOREIGN KEY (`configuration_item_id`) REFERENCES `education_ecm`.`technology`.`configuration_item`(`configuration_item_id`);

-- ========= compliance --> curriculum (2 constraint(s)) =========
-- Requires: compliance schema, curriculum schema
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ADD CONSTRAINT `fk_compliance_accreditation_review_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`compliance`.`certificate_template` ADD CONSTRAINT `fk_compliance_certificate_template_competency_framework_id` FOREIGN KEY (`competency_framework_id`) REFERENCES `education_ecm`.`curriculum`.`competency_framework`(`competency_framework_id`);

-- ========= compliance --> enrollment (1 constraint(s)) =========
-- Requires: compliance schema, enrollment schema
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ADD CONSTRAINT `fk_compliance_ada_accommodation_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);

-- ========= compliance --> facility (1 constraint(s)) =========
-- Requires: compliance schema, facility schema
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ADD CONSTRAINT `fk_compliance_clery_incident_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);

-- ========= compliance --> finance (3 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `education_ecm`.`compliance`.`certificate_template` ADD CONSTRAINT `fk_compliance_certificate_template_division_id` FOREIGN KEY (`division_id`) REFERENCES `education_ecm`.`finance`.`division`(`division_id`);
ALTER TABLE `education_ecm`.`compliance`.`certificate_template` ADD CONSTRAINT `fk_compliance_certificate_template_finance_vendor_id` FOREIGN KEY (`finance_vendor_id`) REFERENCES `education_ecm`.`finance`.`finance_vendor`(`finance_vendor_id`);
ALTER TABLE `education_ecm`.`compliance`.`certificate_template` ADD CONSTRAINT `fk_compliance_certificate_template_program_id` FOREIGN KEY (`program_id`) REFERENCES `education_ecm`.`finance`.`program`(`program_id`);

-- ========= compliance --> hr (26 constraint(s)) =========
-- Requires: compliance schema, hr schema
ALTER TABLE `education_ecm`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ADD CONSTRAINT `fk_compliance_policy_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ADD CONSTRAINT `fk_compliance_policy_version_primary_policy_author_employee_id` FOREIGN KEY (`primary_policy_author_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`policy_version` ADD CONSTRAINT `fk_compliance_policy_version_tertiary_policy_contact_employee_id` FOREIGN KEY (`tertiary_policy_contact_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ADD CONSTRAINT `fk_compliance_title_ix_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ADD CONSTRAINT `fk_compliance_title_ix_case_quaternary_title_modified_by_user_employee_id` FOREIGN KEY (`quaternary_title_modified_by_user_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ADD CONSTRAINT `fk_compliance_title_ix_case_tertiary_title_decision_maker_employee_id` FOREIGN KEY (`tertiary_title_decision_maker_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ADD CONSTRAINT `fk_compliance_clery_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ADD CONSTRAINT `fk_compliance_ada_accommodation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ADD CONSTRAINT `fk_compliance_ada_accommodation_tertiary_ada_modified_by_employee_id` FOREIGN KEY (`tertiary_ada_modified_by_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ADD CONSTRAINT `fk_compliance_ferpa_disclosure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ADD CONSTRAINT `fk_compliance_accreditation_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`accreditation_standard` ADD CONSTRAINT `fk_compliance_accreditation_standard_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`training_program` ADD CONSTRAINT `fk_compliance_training_program_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ADD CONSTRAINT `fk_compliance_compliance_training_completion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`state_authorization` ADD CONSTRAINT `fk_compliance_state_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ADD CONSTRAINT `fk_compliance_internal_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`internal_review` ADD CONSTRAINT `fk_compliance_internal_review_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`compliance`.`ipeds_submission` ADD CONSTRAINT `fk_compliance_ipeds_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= compliance --> instruction (1 constraint(s)) =========
-- Requires: compliance schema, instruction schema
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ADD CONSTRAINT `fk_compliance_compliance_training_completion_lms_course_shell_id` FOREIGN KEY (`lms_course_shell_id`) REFERENCES `education_ecm`.`instruction`.`lms_course_shell`(`lms_course_shell_id`);

-- ========= compliance --> student (3 constraint(s)) =========
-- Requires: compliance schema, student schema
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ADD CONSTRAINT `fk_compliance_title_ix_case_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ADD CONSTRAINT `fk_compliance_ada_accommodation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ADD CONSTRAINT `fk_compliance_ferpa_disclosure_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= compliance --> studentlife (6 constraint(s)) =========
-- Requires: compliance schema, studentlife schema
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ADD CONSTRAINT `fk_compliance_clery_incident_residence_hall_id` FOREIGN KEY (`residence_hall_id`) REFERENCES `education_ecm`.`studentlife`.`residence_hall`(`residence_hall_id`);
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ADD CONSTRAINT `fk_compliance_clery_incident_studentlife_housing_assignment_id` FOREIGN KEY (`studentlife_housing_assignment_id`) REFERENCES `education_ecm`.`studentlife`.`studentlife_housing_assignment`(`studentlife_housing_assignment_id`);
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ADD CONSTRAINT `fk_compliance_ada_accommodation_residence_room_id` FOREIGN KEY (`residence_room_id`) REFERENCES `education_ecm`.`studentlife`.`residence_room`(`residence_room_id`);
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ADD CONSTRAINT `fk_compliance_ada_accommodation_studentlife_housing_assignment_id` FOREIGN KEY (`studentlife_housing_assignment_id`) REFERENCES `education_ecm`.`studentlife`.`studentlife_housing_assignment`(`studentlife_housing_assignment_id`);
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ADD CONSTRAINT `fk_compliance_ferpa_disclosure_health_visit_id` FOREIGN KEY (`health_visit_id`) REFERENCES `education_ecm`.`studentlife`.`health_visit`(`health_visit_id`);
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ADD CONSTRAINT `fk_compliance_accreditation_review_student_org_id` FOREIGN KEY (`student_org_id`) REFERENCES `education_ecm`.`studentlife`.`student_org`(`student_org_id`);

-- ========= compliance --> technology (19 constraint(s)) =========
-- Requires: compliance schema, technology schema
ALTER TABLE `education_ecm`.`compliance`.`policy` ADD CONSTRAINT `fk_compliance_policy_it_policy_id` FOREIGN KEY (`it_policy_id`) REFERENCES `education_ecm`.`technology`.`it_policy`(`it_policy_id`);
ALTER TABLE `education_ecm`.`compliance`.`title_ix_case` ADD CONSTRAINT `fk_compliance_title_ix_case_cybersecurity_incident_id` FOREIGN KEY (`cybersecurity_incident_id`) REFERENCES `education_ecm`.`technology`.`cybersecurity_incident`(`cybersecurity_incident_id`);
ALTER TABLE `education_ecm`.`compliance`.`clery_incident` ADD CONSTRAINT `fk_compliance_clery_incident_cybersecurity_incident_id` FOREIGN KEY (`cybersecurity_incident_id`) REFERENCES `education_ecm`.`technology`.`cybersecurity_incident`(`cybersecurity_incident_id`);
ALTER TABLE `education_ecm`.`compliance`.`ada_accommodation` ADD CONSTRAINT `fk_compliance_ada_accommodation_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ADD CONSTRAINT `fk_compliance_ferpa_disclosure_authorizing_identity_account_id` FOREIGN KEY (`authorizing_identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`compliance`.`ferpa_disclosure` ADD CONSTRAINT `fk_compliance_ferpa_disclosure_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ADD CONSTRAINT `fk_compliance_accreditation_review_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ADD CONSTRAINT `fk_compliance_accreditation_review_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`compliance`.`accreditation_review` ADD CONSTRAINT `fk_compliance_accreditation_review_updated_by_user_identity_account_id` FOREIGN KEY (`updated_by_user_identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`compliance`.`training_program` ADD CONSTRAINT `fk_compliance_training_program_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`compliance`.`training_program` ADD CONSTRAINT `fk_compliance_training_program_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`compliance`.`training_program` ADD CONSTRAINT `fk_compliance_training_program_updated_by_user_identity_account_id` FOREIGN KEY (`updated_by_user_identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`compliance`.`compliance_training_completion` ADD CONSTRAINT `fk_compliance_compliance_training_completion_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_modified_by_user_identity_account_id` FOREIGN KEY (`modified_by_user_identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`compliance`.`certificate_template` ADD CONSTRAINT `fk_compliance_certificate_template_approved_by_user_identity_account_id` FOREIGN KEY (`approved_by_user_identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`compliance`.`certificate_template` ADD CONSTRAINT `fk_compliance_certificate_template_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`compliance`.`certificate_template` ADD CONSTRAINT `fk_compliance_certificate_template_last_modified_by_user_identity_account_id` FOREIGN KEY (`last_modified_by_user_identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);

-- ========= curriculum --> athletics (1 constraint(s)) =========
-- Requires: curriculum schema, athletics schema
ALTER TABLE `education_ecm`.`curriculum`.`curriculum_enrollment` ADD CONSTRAINT `fk_curriculum_curriculum_enrollment_student_athlete_id` FOREIGN KEY (`student_athlete_id`) REFERENCES `education_ecm`.`athletics`.`student_athlete`(`student_athlete_id`);

-- ========= curriculum --> compliance (10 constraint(s)) =========
-- Requires: curriculum schema, compliance schema
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ADD CONSTRAINT `fk_curriculum_academic_program_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ADD CONSTRAINT `fk_curriculum_academic_program_state_authorization_id` FOREIGN KEY (`state_authorization_id`) REFERENCES `education_ecm`.`compliance`.`state_authorization`(`state_authorization_id`);
ALTER TABLE `education_ecm`.`curriculum`.`map` ADD CONSTRAINT `fk_curriculum_map_accreditation_standard_id` FOREIGN KEY (`accreditation_standard_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_standard`(`accreditation_standard_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ADD CONSTRAINT `fk_curriculum_course_proposal_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ADD CONSTRAINT `fk_curriculum_program_proposal_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ADD CONSTRAINT `fk_curriculum_program_proposal_state_authorization_id` FOREIGN KEY (`state_authorization_id`) REFERENCES `education_ecm`.`compliance`.`state_authorization`(`state_authorization_id`);
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ADD CONSTRAINT `fk_curriculum_articulation_agreement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ADD CONSTRAINT `fk_curriculum_transfer_equivalency_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ADD CONSTRAINT `fk_curriculum_assessment_cycle_accreditation_standard_id` FOREIGN KEY (`accreditation_standard_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_standard`(`accreditation_standard_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course_training_requirement` ADD CONSTRAINT `fk_curriculum_course_training_requirement_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `education_ecm`.`compliance`.`training_program`(`training_program_id`);

-- ========= curriculum --> enrollment (6 constraint(s)) =========
-- Requires: curriculum schema, enrollment schema
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ADD CONSTRAINT `fk_curriculum_prerequisite_rule_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ADD CONSTRAINT `fk_curriculum_course_proposal_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ADD CONSTRAINT `fk_curriculum_program_proposal_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ADD CONSTRAINT `fk_curriculum_transfer_equivalency_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`curriculum`.`curriculum_enrollment` ADD CONSTRAINT `fk_curriculum_curriculum_enrollment_enrollment_registration_id` FOREIGN KEY (`enrollment_registration_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_registration`(`enrollment_registration_id`);
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_group` ADD CONSTRAINT `fk_curriculum_prerequisite_group_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);

-- ========= curriculum --> facility (4 constraint(s)) =========
-- Requires: curriculum schema, facility schema
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ADD CONSTRAINT `fk_curriculum_academic_program_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ADD CONSTRAINT `fk_curriculum_academic_program_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course` ADD CONSTRAINT `fk_curriculum_course_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course` ADD CONSTRAINT `fk_curriculum_course_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);

-- ========= curriculum --> faculty (3 constraint(s)) =========
-- Requires: curriculum schema, faculty schema
ALTER TABLE `education_ecm`.`curriculum`.`map` ADD CONSTRAINT `fk_curriculum_map_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`curriculum`.`program_affiliation` ADD CONSTRAINT `fk_curriculum_program_affiliation_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`curriculum`.`section` ADD CONSTRAINT `fk_curriculum_section_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);

-- ========= curriculum --> finance (3 constraint(s)) =========
-- Requires: curriculum schema, finance schema
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ADD CONSTRAINT `fk_curriculum_academic_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ADD CONSTRAINT `fk_curriculum_academic_program_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ADD CONSTRAINT `fk_curriculum_academic_program_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);

-- ========= curriculum --> hr (20 constraint(s)) =========
-- Requires: curriculum schema, hr schema
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ADD CONSTRAINT `fk_curriculum_academic_program_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ADD CONSTRAINT `fk_curriculum_academic_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course` ADD CONSTRAINT `fk_curriculum_course_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course` ADD CONSTRAINT `fk_curriculum_course_course_org_unit_id` FOREIGN KEY (`course_org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ADD CONSTRAINT `fk_curriculum_prerequisite_rule_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`curriculum`.`plo` ADD CONSTRAINT `fk_curriculum_plo_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ADD CONSTRAINT `fk_curriculum_course_proposal_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ADD CONSTRAINT `fk_curriculum_course_proposal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ADD CONSTRAINT `fk_curriculum_program_proposal_department_org_unit_id` FOREIGN KEY (`department_org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ADD CONSTRAINT `fk_curriculum_program_proposal_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ADD CONSTRAINT `fk_curriculum_program_proposal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ADD CONSTRAINT `fk_curriculum_transfer_equivalency_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ADD CONSTRAINT `fk_curriculum_program_accreditation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ADD CONSTRAINT `fk_curriculum_program_accreditation_tertiary_program_updated_by_employee_id` FOREIGN KEY (`tertiary_program_updated_by_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ADD CONSTRAINT `fk_curriculum_assessment_cycle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ADD CONSTRAINT `fk_curriculum_concentration_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ADD CONSTRAINT `fk_curriculum_concentration_concentration_org_unit_id` FOREIGN KEY (`concentration_org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ADD CONSTRAINT `fk_curriculum_concentration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` ADD CONSTRAINT `fk_curriculum_teaching_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_group` ADD CONSTRAINT `fk_curriculum_prerequisite_group_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);

-- ========= curriculum --> instruction (1 constraint(s)) =========
-- Requires: curriculum schema, instruction schema
ALTER TABLE `education_ecm`.`curriculum`.`assessment_instrument` ADD CONSTRAINT `fk_curriculum_assessment_instrument_rubric_id` FOREIGN KEY (`rubric_id`) REFERENCES `education_ecm`.`instruction`.`rubric`(`rubric_id`);

-- ========= curriculum --> library (4 constraint(s)) =========
-- Requires: curriculum schema, library schema
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ADD CONSTRAINT `fk_curriculum_academic_program_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `education_ecm`.`library`.`collection`(`collection_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course` ADD CONSTRAINT `fk_curriculum_course_bib_record_id` FOREIGN KEY (`bib_record_id`) REFERENCES `education_ecm`.`library`.`bib_record`(`bib_record_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ADD CONSTRAINT `fk_curriculum_course_proposal_bib_record_id` FOREIGN KEY (`bib_record_id`) REFERENCES `education_ecm`.`library`.`bib_record`(`bib_record_id`);
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ADD CONSTRAINT `fk_curriculum_program_proposal_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `education_ecm`.`library`.`collection`(`collection_id`);

-- ========= curriculum --> technology (8 constraint(s)) =========
-- Requires: curriculum schema, technology schema
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ADD CONSTRAINT `fk_curriculum_academic_program_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course` ADD CONSTRAINT `fk_curriculum_course_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`curriculum`.`slo` ADD CONSTRAINT `fk_curriculum_slo_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`curriculum`.`map` ADD CONSTRAINT `fk_curriculum_map_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ADD CONSTRAINT `fk_curriculum_course_proposal_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `education_ecm`.`technology`.`service_request`(`service_request_id`);
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ADD CONSTRAINT `fk_curriculum_program_proposal_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `education_ecm`.`technology`.`service_request`(`service_request_id`);
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ADD CONSTRAINT `fk_curriculum_assessment_cycle_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course_asset_requirement` ADD CONSTRAINT `fk_curriculum_course_asset_requirement_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `education_ecm`.`technology`.`it_asset`(`it_asset_id`);

-- ========= enrollment --> advancement (1 constraint(s)) =========
-- Requires: enrollment schema, advancement schema
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ADD CONSTRAINT `fk_enrollment_communication_activity_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);

-- ========= enrollment --> aid (8 constraint(s)) =========
-- Requires: enrollment schema, aid schema
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ADD CONSTRAINT `fk_enrollment_enrollment_application_aid_application_id` FOREIGN KEY (`aid_application_id`) REFERENCES `education_ecm`.`aid`.`aid_application`(`aid_application_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ADD CONSTRAINT `fk_enrollment_admission_decision_award_package_id` FOREIGN KEY (`award_package_id`) REFERENCES `education_ecm`.`aid`.`award_package`(`award_package_id`);
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ADD CONSTRAINT `fk_enrollment_matriculation_aid_application_id` FOREIGN KEY (`aid_application_id`) REFERENCES `education_ecm`.`aid`.`aid_application`(`aid_application_id`);
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ADD CONSTRAINT `fk_enrollment_transfer_credit_eval_aid_sap_evaluation_id` FOREIGN KEY (`aid_sap_evaluation_id`) REFERENCES `education_ecm`.`aid`.`aid_sap_evaluation`(`aid_sap_evaluation_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ADD CONSTRAINT `fk_enrollment_enrollment_registration_disbursement_id` FOREIGN KEY (`disbursement_id`) REFERENCES `education_ecm`.`aid`.`disbursement`(`disbursement_id`);
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ADD CONSTRAINT `fk_enrollment_add_drop_transaction_r2t4_calculation_id` FOREIGN KEY (`r2t4_calculation_id`) REFERENCES `education_ecm`.`aid`.`r2t4_calculation`(`r2t4_calculation_id`);
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ADD CONSTRAINT `fk_enrollment_student_term_record_aid_sap_evaluation_id` FOREIGN KEY (`aid_sap_evaluation_id`) REFERENCES `education_ecm`.`aid`.`aid_sap_evaluation`(`aid_sap_evaluation_id`);
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ADD CONSTRAINT `fk_enrollment_concurrent_enrollment_aid_application_id` FOREIGN KEY (`aid_application_id`) REFERENCES `education_ecm`.`aid`.`aid_application`(`aid_application_id`);

-- ========= enrollment --> athletics (6 constraint(s)) =========
-- Requires: enrollment schema, athletics schema
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ADD CONSTRAINT `fk_enrollment_event_registration_recruit_id` FOREIGN KEY (`recruit_id`) REFERENCES `education_ecm`.`athletics`.`recruit`(`recruit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ADD CONSTRAINT `fk_enrollment_communication_activity_recruit_id` FOREIGN KEY (`recruit_id`) REFERENCES `education_ecm`.`athletics`.`recruit`(`recruit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ADD CONSTRAINT `fk_enrollment_matriculation_student_athlete_id` FOREIGN KEY (`student_athlete_id`) REFERENCES `education_ecm`.`athletics`.`student_athlete`(`student_athlete_id`);
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ADD CONSTRAINT `fk_enrollment_transfer_credit_eval_athletic_eligibility_id` FOREIGN KEY (`athletic_eligibility_id`) REFERENCES `education_ecm`.`athletics`.`athletic_eligibility`(`athletic_eligibility_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ADD CONSTRAINT `fk_enrollment_registration_hold_athletic_eligibility_id` FOREIGN KEY (`athletic_eligibility_id`) REFERENCES `education_ecm`.`athletics`.`athletic_eligibility`(`athletic_eligibility_id`);
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ADD CONSTRAINT `fk_enrollment_athletic_recruitment_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);

-- ========= enrollment --> billing (4 constraint(s)) =========
-- Requires: enrollment schema, billing schema
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ADD CONSTRAINT `fk_enrollment_enrollment_application_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ADD CONSTRAINT `fk_enrollment_enrollment_registration_tuition_charge_id` FOREIGN KEY (`tuition_charge_id`) REFERENCES `education_ecm`.`billing`.`tuition_charge`(`tuition_charge_id`);
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ADD CONSTRAINT `fk_enrollment_add_drop_transaction_charge_adjustment_id` FOREIGN KEY (`charge_adjustment_id`) REFERENCES `education_ecm`.`billing`.`charge_adjustment`(`charge_adjustment_id`);
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ADD CONSTRAINT `fk_enrollment_concurrent_enrollment_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);

-- ========= enrollment --> compliance (8 constraint(s)) =========
-- Requires: enrollment schema, compliance schema
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ADD CONSTRAINT `fk_enrollment_enrollment_application_title_ix_case_id` FOREIGN KEY (`title_ix_case_id`) REFERENCES `education_ecm`.`compliance`.`title_ix_case`(`title_ix_case_id`);
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ADD CONSTRAINT `fk_enrollment_recommendation_ferpa_disclosure_id` FOREIGN KEY (`ferpa_disclosure_id`) REFERENCES `education_ecm`.`compliance`.`ferpa_disclosure`(`ferpa_disclosure_id`);
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ADD CONSTRAINT `fk_enrollment_transcript_ferpa_disclosure_id` FOREIGN KEY (`ferpa_disclosure_id`) REFERENCES `education_ecm`.`compliance`.`ferpa_disclosure`(`ferpa_disclosure_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ADD CONSTRAINT `fk_enrollment_admission_criteria_accreditation_standard_id` FOREIGN KEY (`accreditation_standard_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_standard`(`accreditation_standard_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ADD CONSTRAINT `fk_enrollment_enrollment_registration_ada_accommodation_id` FOREIGN KEY (`ada_accommodation_id`) REFERENCES `education_ecm`.`compliance`.`ada_accommodation`(`ada_accommodation_id`);
ALTER TABLE `education_ecm`.`enrollment`.`census` ADD CONSTRAINT `fk_enrollment_census_ipeds_submission_id` FOREIGN KEY (`ipeds_submission_id`) REFERENCES `education_ecm`.`compliance`.`ipeds_submission`(`ipeds_submission_id`);
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ADD CONSTRAINT `fk_enrollment_student_term_record_accreditation_review_id` FOREIGN KEY (`accreditation_review_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_review`(`accreditation_review_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ADD CONSTRAINT `fk_enrollment_registration_hold_ada_accommodation_id` FOREIGN KEY (`ada_accommodation_id`) REFERENCES `education_ecm`.`compliance`.`ada_accommodation`(`ada_accommodation_id`);

-- ========= enrollment --> curriculum (15 constraint(s)) =========
-- Requires: enrollment schema, curriculum schema
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ADD CONSTRAINT `fk_enrollment_enrollment_application_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ADD CONSTRAINT `fk_enrollment_application_program_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ADD CONSTRAINT `fk_enrollment_application_program_plan_academic_program_id` FOREIGN KEY (`plan_academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ADD CONSTRAINT `fk_enrollment_admission_decision_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ADD CONSTRAINT `fk_enrollment_admission_criteria_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ADD CONSTRAINT `fk_enrollment_waitlist_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ADD CONSTRAINT `fk_enrollment_application_review_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ADD CONSTRAINT `fk_enrollment_admission_offer_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ADD CONSTRAINT `fk_enrollment_transfer_credit_eval_articulation_agreement_id` FOREIGN KEY (`articulation_agreement_id`) REFERENCES `education_ecm`.`curriculum`.`articulation_agreement`(`articulation_agreement_id`);
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ADD CONSTRAINT `fk_enrollment_transfer_credit_eval_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ADD CONSTRAINT `fk_enrollment_student_term_record_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ADD CONSTRAINT `fk_enrollment_restriction_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ADD CONSTRAINT `fk_enrollment_restriction_restriction_prerequisite_course_id` FOREIGN KEY (`restriction_prerequisite_course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ADD CONSTRAINT `fk_enrollment_repeat_course_record_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event_session` ADD CONSTRAINT `fk_enrollment_recruitment_event_session_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);

-- ========= enrollment --> facility (8 constraint(s)) =========
-- Requires: enrollment schema, facility schema
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ADD CONSTRAINT `fk_enrollment_enrollment_application_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ADD CONSTRAINT `fk_enrollment_recruitment_event_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ADD CONSTRAINT `fk_enrollment_matriculation_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`enrollment`.`term` ADD CONSTRAINT `fk_enrollment_term_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ADD CONSTRAINT `fk_enrollment_enrollment_registration_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ADD CONSTRAINT `fk_enrollment_student_term_record_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ADD CONSTRAINT `fk_enrollment_cross_list_group_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event_session` ADD CONSTRAINT `fk_enrollment_recruitment_event_session_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);

-- ========= enrollment --> faculty (5 constraint(s)) =========
-- Requires: enrollment schema, faculty schema
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ADD CONSTRAINT `fk_enrollment_matriculation_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ADD CONSTRAINT `fk_enrollment_application_review_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ADD CONSTRAINT `fk_enrollment_student_term_record_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ADD CONSTRAINT `fk_enrollment_cross_list_group_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ADD CONSTRAINT `fk_enrollment_concurrent_enrollment_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);

-- ========= enrollment --> finance (3 constraint(s)) =========
-- Requires: enrollment schema, finance schema
ALTER TABLE `education_ecm`.`enrollment`.`term` ADD CONSTRAINT `fk_enrollment_term_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event_session` ADD CONSTRAINT `fk_enrollment_recruitment_event_session_college_school_id` FOREIGN KEY (`college_school_id`) REFERENCES `education_ecm`.`finance`.`college_school`(`college_school_id`);
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event_session` ADD CONSTRAINT `fk_enrollment_recruitment_event_session_division_id` FOREIGN KEY (`division_id`) REFERENCES `education_ecm`.`finance`.`division`(`division_id`);

-- ========= enrollment --> hr (33 constraint(s)) =========
-- Requires: enrollment schema, hr schema
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ADD CONSTRAINT `fk_enrollment_prospect_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ADD CONSTRAINT `fk_enrollment_enrollment_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ADD CONSTRAINT `fk_enrollment_enrollment_application_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ADD CONSTRAINT `fk_enrollment_application_program_department_org_unit_id` FOREIGN KEY (`department_org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ADD CONSTRAINT `fk_enrollment_application_program_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ADD CONSTRAINT `fk_enrollment_admission_decision_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ADD CONSTRAINT `fk_enrollment_transcript_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ADD CONSTRAINT `fk_enrollment_admission_criteria_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ADD CONSTRAINT `fk_enrollment_recruitment_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ADD CONSTRAINT `fk_enrollment_event_registration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ADD CONSTRAINT `fk_enrollment_communication_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ADD CONSTRAINT `fk_enrollment_waitlist_department_org_unit_id` FOREIGN KEY (`department_org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ADD CONSTRAINT `fk_enrollment_waitlist_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ADD CONSTRAINT `fk_enrollment_waitlist_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ADD CONSTRAINT `fk_enrollment_application_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ADD CONSTRAINT `fk_enrollment_admission_offer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ADD CONSTRAINT `fk_enrollment_transfer_credit_eval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ADD CONSTRAINT `fk_enrollment_transfer_credit_eval_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ADD CONSTRAINT `fk_enrollment_recruitment_territory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ADD CONSTRAINT `fk_enrollment_recruitment_territory_tertiary_recruitment_assigned_counselor_employee_id` FOREIGN KEY (`tertiary_recruitment_assigned_counselor_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ADD CONSTRAINT `fk_enrollment_add_drop_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`census` ADD CONSTRAINT `fk_enrollment_census_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ADD CONSTRAINT `fk_enrollment_registration_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ADD CONSTRAINT `fk_enrollment_registration_override_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ADD CONSTRAINT `fk_enrollment_registration_period_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ADD CONSTRAINT `fk_enrollment_cross_list_group_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ADD CONSTRAINT `fk_enrollment_repeat_course_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ADD CONSTRAINT `fk_enrollment_athletic_recruitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`review_committee` ADD CONSTRAINT `fk_enrollment_review_committee_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`review_committee` ADD CONSTRAINT `fk_enrollment_review_committee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`review_committee` ADD CONSTRAINT `fk_enrollment_review_committee_secretary_employee_id` FOREIGN KEY (`secretary_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`review_committee` ADD CONSTRAINT `fk_enrollment_review_committee_vice_chair_employee_id` FOREIGN KEY (`vice_chair_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event_session` ADD CONSTRAINT `fk_enrollment_recruitment_event_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= enrollment --> instruction (6 constraint(s)) =========
-- Requires: enrollment schema, instruction schema
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ADD CONSTRAINT `fk_enrollment_enrollment_registration_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ADD CONSTRAINT `fk_enrollment_waitlist_entry_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ADD CONSTRAINT `fk_enrollment_add_drop_transaction_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ADD CONSTRAINT `fk_enrollment_registration_override_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ADD CONSTRAINT `fk_enrollment_restriction_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ADD CONSTRAINT `fk_enrollment_cross_list_group_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);

-- ========= enrollment --> research (7 constraint(s)) =========
-- Requires: enrollment schema, research schema
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ADD CONSTRAINT `fk_enrollment_prospect_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ADD CONSTRAINT `fk_enrollment_enrollment_application_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ADD CONSTRAINT `fk_enrollment_enrollment_applicant_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ADD CONSTRAINT `fk_enrollment_application_program_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ADD CONSTRAINT `fk_enrollment_communication_activity_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ADD CONSTRAINT `fk_enrollment_matriculation_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ADD CONSTRAINT `fk_enrollment_admission_offer_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);

-- ========= enrollment --> student (11 constraint(s)) =========
-- Requires: enrollment schema, student schema
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ADD CONSTRAINT `fk_enrollment_deposit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ADD CONSTRAINT `fk_enrollment_matriculation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ADD CONSTRAINT `fk_enrollment_transfer_credit_eval_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ADD CONSTRAINT `fk_enrollment_enrollment_registration_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ADD CONSTRAINT `fk_enrollment_waitlist_entry_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ADD CONSTRAINT `fk_enrollment_add_drop_transaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ADD CONSTRAINT `fk_enrollment_student_term_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ADD CONSTRAINT `fk_enrollment_registration_hold_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ADD CONSTRAINT `fk_enrollment_registration_override_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ADD CONSTRAINT `fk_enrollment_concurrent_enrollment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ADD CONSTRAINT `fk_enrollment_repeat_course_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= enrollment --> technology (10 constraint(s)) =========
-- Requires: enrollment schema, technology schema
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ADD CONSTRAINT `fk_enrollment_prospect_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ADD CONSTRAINT `fk_enrollment_enrollment_applicant_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ADD CONSTRAINT `fk_enrollment_application_checklist_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ADD CONSTRAINT `fk_enrollment_communication_activity_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ADD CONSTRAINT `fk_enrollment_restriction_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ADD CONSTRAINT `fk_enrollment_restriction_updated_by_user_identity_account_id` FOREIGN KEY (`updated_by_user_identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ADD CONSTRAINT `fk_enrollment_cross_list_group_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ADD CONSTRAINT `fk_enrollment_cross_list_group_updated_by_user_identity_account_id` FOREIGN KEY (`updated_by_user_identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event_session` ADD CONSTRAINT `fk_enrollment_recruitment_event_session_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event_session` ADD CONSTRAINT `fk_enrollment_recruitment_event_session_updated_by_user_identity_account_id` FOREIGN KEY (`updated_by_user_identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);

-- ========= facility --> advancement (5 constraint(s)) =========
-- Requires: facility schema, advancement schema
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ADD CONSTRAINT `fk_facility_space_assignment_advancement_fund_id` FOREIGN KEY (`advancement_fund_id`) REFERENCES `education_ecm`.`advancement`.`advancement_fund`(`advancement_fund_id`);
ALTER TABLE `education_ecm`.`facility`.`room_booking` ADD CONSTRAINT `fk_facility_room_booking_event_id` FOREIGN KEY (`event_id`) REFERENCES `education_ecm`.`advancement`.`event`(`event_id`);
ALTER TABLE `education_ecm`.`facility`.`capital_project` ADD CONSTRAINT `fk_facility_capital_project_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`facility`.`capital_project` ADD CONSTRAINT `fk_facility_capital_project_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`facility`.`project_funding` ADD CONSTRAINT `fk_facility_project_funding_advancement_fund_id` FOREIGN KEY (`advancement_fund_id`) REFERENCES `education_ecm`.`advancement`.`advancement_fund`(`advancement_fund_id`);

-- ========= facility --> compliance (10 constraint(s)) =========
-- Requires: facility schema, compliance schema
ALTER TABLE `education_ecm`.`facility`.`room` ADD CONSTRAINT `fk_facility_room_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ADD CONSTRAINT `fk_facility_space_assignment_accreditation_review_id` FOREIGN KEY (`accreditation_review_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_review`(`accreditation_review_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `education_ecm`.`compliance`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `education_ecm`.`facility`.`capital_project` ADD CONSTRAINT `fk_facility_capital_project_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ADD CONSTRAINT `fk_facility_utility_meter_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ADD CONSTRAINT `fk_facility_accessibility_feature_ada_accommodation_id` FOREIGN KEY (`ada_accommodation_id`) REFERENCES `education_ecm`.`compliance`.`ada_accommodation`(`ada_accommodation_id`);
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ADD CONSTRAINT `fk_facility_lease_agreement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`facility`.`inspection` ADD CONSTRAINT `fk_facility_inspection_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `education_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ADD CONSTRAINT `fk_facility_hazmat_inventory_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` ADD CONSTRAINT `fk_facility_asset_compliance_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= facility --> curriculum (2 constraint(s)) =========
-- Requires: facility schema, curriculum schema
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ADD CONSTRAINT `fk_facility_space_assignment_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`facility`.`capital_project` ADD CONSTRAINT `fk_facility_capital_project_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);

-- ========= facility --> enrollment (1 constraint(s)) =========
-- Requires: facility schema, enrollment schema
ALTER TABLE `education_ecm`.`facility`.`room_booking` ADD CONSTRAINT `fk_facility_room_booking_recruitment_event_id` FOREIGN KEY (`recruitment_event_id`) REFERENCES `education_ecm`.`enrollment`.`recruitment_event`(`recruitment_event_id`);

-- ========= facility --> finance (15 constraint(s)) =========
-- Requires: facility schema, finance schema
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ADD CONSTRAINT `fk_facility_space_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ADD CONSTRAINT `fk_facility_space_assignment_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`facility`.`room_booking` ADD CONSTRAINT `fk_facility_room_booking_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_finance_vendor_id` FOREIGN KEY (`finance_vendor_id`) REFERENCES `education_ecm`.`finance`.`finance_vendor`(`finance_vendor_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`facility`.`capital_project` ADD CONSTRAINT `fk_facility_capital_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`facility`.`capital_project` ADD CONSTRAINT `fk_facility_capital_project_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`facility`.`capital_project` ADD CONSTRAINT `fk_facility_capital_project_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ADD CONSTRAINT `fk_facility_utility_meter_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ADD CONSTRAINT `fk_facility_utility_meter_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ADD CONSTRAINT `fk_facility_lease_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ADD CONSTRAINT `fk_facility_lease_agreement_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ADD CONSTRAINT `fk_facility_lease_agreement_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);

-- ========= facility --> hr (25 constraint(s)) =========
-- Requires: facility schema, hr schema
ALTER TABLE `education_ecm`.`facility`.`building` ADD CONSTRAINT `fk_facility_building_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`facility`.`room` ADD CONSTRAINT `fk_facility_room_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ADD CONSTRAINT `fk_facility_space_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ADD CONSTRAINT `fk_facility_space_assignment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`facility`.`room_booking` ADD CONSTRAINT `fk_facility_room_booking_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`facility`.`room_booking` ADD CONSTRAINT `fk_facility_room_booking_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`facility`.`room_booking` ADD CONSTRAINT `fk_facility_room_booking_primary_room_employee_id` FOREIGN KEY (`primary_room_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`facility`.`asset` ADD CONSTRAINT `fk_facility_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`facility`.`asset` ADD CONSTRAINT `fk_facility_asset_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`facility`.`capital_project` ADD CONSTRAINT `fk_facility_capital_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ADD CONSTRAINT `fk_facility_space_utilization_survey_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ADD CONSTRAINT `fk_facility_space_utilization_survey_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ADD CONSTRAINT `fk_facility_space_utilization_survey_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ADD CONSTRAINT `fk_facility_accessibility_feature_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ADD CONSTRAINT `fk_facility_hazmat_inventory_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` ADD CONSTRAINT `fk_facility_asset_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`facility`.`floor` ADD CONSTRAINT `fk_facility_floor_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`facility`.`crew` ADD CONSTRAINT `fk_facility_crew_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`facility`.`crew` ADD CONSTRAINT `fk_facility_crew_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`facility`.`crew` ADD CONSTRAINT `fk_facility_crew_supervisor_employee_id` FOREIGN KEY (`supervisor_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= facility --> library (4 constraint(s)) =========
-- Requires: facility schema, library schema
ALTER TABLE `education_ecm`.`facility`.`room` ADD CONSTRAINT `fk_facility_room_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `education_ecm`.`library`.`collection`(`collection_id`);
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ADD CONSTRAINT `fk_facility_space_assignment_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `education_ecm`.`library`.`collection`(`collection_id`);
ALTER TABLE `education_ecm`.`facility`.`room_booking` ADD CONSTRAINT `fk_facility_room_booking_patron_id` FOREIGN KEY (`patron_id`) REFERENCES `education_ecm`.`library`.`patron`(`patron_id`);
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ADD CONSTRAINT `fk_facility_hazmat_inventory_bib_record_id` FOREIGN KEY (`bib_record_id`) REFERENCES `education_ecm`.`library`.`bib_record`(`bib_record_id`);

-- ========= facility --> research (8 constraint(s)) =========
-- Requires: facility schema, research schema
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ADD CONSTRAINT `fk_facility_space_assignment_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`facility`.`asset` ADD CONSTRAINT `fk_facility_asset_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`facility`.`capital_project` ADD CONSTRAINT `fk_facility_capital_project_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ADD CONSTRAINT `fk_facility_space_utilization_survey_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ADD CONSTRAINT `fk_facility_hazmat_inventory_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ADD CONSTRAINT `fk_facility_hazmat_inventory_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);

-- ========= facility --> student (1 constraint(s)) =========
-- Requires: facility schema, student schema
ALTER TABLE `education_ecm`.`facility`.`room_booking` ADD CONSTRAINT `fk_facility_room_booking_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= faculty --> advancement (14 constraint(s)) =========
-- Requires: faculty schema, advancement schema
ALTER TABLE `education_ecm`.`faculty`.`instructor` ADD CONSTRAINT `fk_faculty_instructor_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`faculty`.`instructor` ADD CONSTRAINT `fk_faculty_instructor_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ADD CONSTRAINT `fk_faculty_scholarly_activity_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ADD CONSTRAINT `fk_faculty_scholarly_activity_endowment_id` FOREIGN KEY (`endowment_id`) REFERENCES `education_ecm`.`advancement`.`endowment`(`endowment_id`);
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ADD CONSTRAINT `fk_faculty_scholarly_activity_gift_id` FOREIGN KEY (`gift_id`) REFERENCES `education_ecm`.`advancement`.`gift`(`gift_id`);
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ADD CONSTRAINT `fk_faculty_sabbatical_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ADD CONSTRAINT `fk_faculty_service_assignment_affinity_group_id` FOREIGN KEY (`affinity_group_id`) REFERENCES `education_ecm`.`advancement`.`affinity_group`(`affinity_group_id`);
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ADD CONSTRAINT `fk_faculty_service_assignment_event_id` FOREIGN KEY (`event_id`) REFERENCES `education_ecm`.`advancement`.`event`(`event_id`);
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ADD CONSTRAINT `fk_faculty_advising_assignment_mentorship_match_id` FOREIGN KEY (`mentorship_match_id`) REFERENCES `education_ecm`.`advancement`.`mentorship_match`(`mentorship_match_id`);
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ADD CONSTRAINT `fk_faculty_professional_development_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ADD CONSTRAINT `fk_faculty_endowed_position_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ADD CONSTRAINT `fk_faculty_endowed_position_endowment_id` FOREIGN KEY (`endowment_id`) REFERENCES `education_ecm`.`advancement`.`endowment`(`endowment_id`);
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ADD CONSTRAINT `fk_faculty_external_engagement_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`faculty`.`event_participation` ADD CONSTRAINT `fk_faculty_event_participation_event_id` FOREIGN KEY (`event_id`) REFERENCES `education_ecm`.`advancement`.`event`(`event_id`);

-- ========= faculty --> athletics (1 constraint(s)) =========
-- Requires: faculty schema, athletics schema
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ADD CONSTRAINT `fk_faculty_accreditation_qualification_coach_id` FOREIGN KEY (`coach_id`) REFERENCES `education_ecm`.`athletics`.`coach`(`coach_id`);

-- ========= faculty --> compliance (10 constraint(s)) =========
-- Requires: faculty schema, compliance schema
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ADD CONSTRAINT `fk_faculty_tenure_case_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`faculty`.`credential` ADD CONSTRAINT `fk_faculty_credential_accreditation_standard_id` FOREIGN KEY (`accreditation_standard_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_standard`(`accreditation_standard_id`);
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ADD CONSTRAINT `fk_faculty_annual_review_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ADD CONSTRAINT `fk_faculty_sabbatical_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ADD CONSTRAINT `fk_faculty_accreditation_qualification_accreditation_review_id` FOREIGN KEY (`accreditation_review_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_review`(`accreditation_review_id`);
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ADD CONSTRAINT `fk_faculty_hire_event_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ADD CONSTRAINT `fk_faculty_leave_record_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ADD CONSTRAINT `fk_faculty_external_engagement_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ADD CONSTRAINT `fk_faculty_faculty_training_completion_compliance_training_completion_id` FOREIGN KEY (`compliance_training_completion_id`) REFERENCES `education_ecm`.`compliance`.`compliance_training_completion`(`compliance_training_completion_id`);
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ADD CONSTRAINT `fk_faculty_faculty_training_completion_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `education_ecm`.`compliance`.`training_program`(`training_program_id`);

-- ========= faculty --> curriculum (2 constraint(s)) =========
-- Requires: faculty schema, curriculum schema
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ADD CONSTRAINT `fk_faculty_accreditation_qualification_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ADD CONSTRAINT `fk_faculty_accreditation_qualification_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);

-- ========= faculty --> facility (1 constraint(s)) =========
-- Requires: faculty schema, facility schema
ALTER TABLE `education_ecm`.`faculty`.`instructor` ADD CONSTRAINT `fk_faculty_instructor_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);

-- ========= faculty --> finance (11 constraint(s)) =========
-- Requires: faculty schema, finance schema
ALTER TABLE `education_ecm`.`faculty`.`appointment` ADD CONSTRAINT `fk_faculty_appointment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ADD CONSTRAINT `fk_faculty_department_affiliation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ADD CONSTRAINT `fk_faculty_scholarly_activity_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ADD CONSTRAINT `fk_faculty_annual_review_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ADD CONSTRAINT `fk_faculty_sabbatical_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ADD CONSTRAINT `fk_faculty_service_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ADD CONSTRAINT `fk_faculty_hire_event_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ADD CONSTRAINT `fk_faculty_hire_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`faculty`.`compensation` ADD CONSTRAINT `fk_faculty_compensation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ADD CONSTRAINT `fk_faculty_professional_development_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ADD CONSTRAINT `fk_faculty_endowed_position_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);

-- ========= faculty --> hr (16 constraint(s)) =========
-- Requires: faculty schema, hr schema
ALTER TABLE `education_ecm`.`faculty`.`appointment` ADD CONSTRAINT `fk_faculty_appointment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ADD CONSTRAINT `fk_faculty_tenure_case_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ADD CONSTRAINT `fk_faculty_department_affiliation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ADD CONSTRAINT `fk_faculty_sabbatical_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ADD CONSTRAINT `fk_faculty_sabbatical_sabbatical_provost_employee_id` FOREIGN KEY (`sabbatical_provost_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ADD CONSTRAINT `fk_faculty_accreditation_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ADD CONSTRAINT `fk_faculty_hire_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ADD CONSTRAINT `fk_faculty_hire_event_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ADD CONSTRAINT `fk_faculty_hire_event_recruitment_requisition_id` FOREIGN KEY (`recruitment_requisition_id`) REFERENCES `education_ecm`.`hr`.`recruitment_requisition`(`recruitment_requisition_id`);
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ADD CONSTRAINT `fk_faculty_leave_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ADD CONSTRAINT `fk_faculty_advising_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ADD CONSTRAINT `fk_faculty_professional_development_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ADD CONSTRAINT `fk_faculty_endowed_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ADD CONSTRAINT `fk_faculty_external_engagement_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ADD CONSTRAINT `fk_faculty_faculty_training_completion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ADD CONSTRAINT `fk_faculty_faculty_training_completion_waived_by_user_employee_id` FOREIGN KEY (`waived_by_user_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= faculty --> library (3 constraint(s)) =========
-- Requires: faculty schema, library schema
ALTER TABLE `education_ecm`.`faculty`.`instructor` ADD CONSTRAINT `fk_faculty_instructor_patron_id` FOREIGN KEY (`patron_id`) REFERENCES `education_ecm`.`library`.`patron`(`patron_id`);
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ADD CONSTRAINT `fk_faculty_scholarly_activity_bib_record_id` FOREIGN KEY (`bib_record_id`) REFERENCES `education_ecm`.`library`.`bib_record`(`bib_record_id`);
ALTER TABLE `education_ecm`.`faculty`.`resource_evaluation` ADD CONSTRAINT `fk_faculty_resource_evaluation_electronic_resource_id` FOREIGN KEY (`electronic_resource_id`) REFERENCES `education_ecm`.`library`.`electronic_resource`(`electronic_resource_id`);

-- ========= faculty --> research (2 constraint(s)) =========
-- Requires: faculty schema, research schema
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ADD CONSTRAINT `fk_faculty_scholarly_activity_scholarly_output_id` FOREIGN KEY (`scholarly_output_id`) REFERENCES `education_ecm`.`research`.`scholarly_output`(`scholarly_output_id`);
ALTER TABLE `education_ecm`.`faculty`.`compensation` ADD CONSTRAINT `fk_faculty_compensation_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);

-- ========= faculty --> student (1 constraint(s)) =========
-- Requires: faculty schema, student schema
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ADD CONSTRAINT `fk_faculty_advising_assignment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= faculty --> technology (6 constraint(s)) =========
-- Requires: faculty schema, technology schema
ALTER TABLE `education_ecm`.`faculty`.`instructor` ADD CONSTRAINT `fk_faculty_instructor_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ADD CONSTRAINT `fk_faculty_service_assignment_access_entitlement_id` FOREIGN KEY (`access_entitlement_id`) REFERENCES `education_ecm`.`technology`.`access_entitlement`(`access_entitlement_id`);
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ADD CONSTRAINT `fk_faculty_hire_event_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `education_ecm`.`technology`.`service_request`(`service_request_id`);
ALTER TABLE `education_ecm`.`faculty`.`project_participation` ADD CONSTRAINT `fk_faculty_project_participation_it_project_id` FOREIGN KEY (`it_project_id`) REFERENCES `education_ecm`.`technology`.`it_project`(`it_project_id`);
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` ADD CONSTRAINT `fk_faculty_faculty_application_access_access_entitlement_id` FOREIGN KEY (`access_entitlement_id`) REFERENCES `education_ecm`.`technology`.`access_entitlement`(`access_entitlement_id`);
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` ADD CONSTRAINT `fk_faculty_faculty_application_access_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);

-- ========= finance --> advancement (4 constraint(s)) =========
-- Requires: finance schema, advancement schema
ALTER TABLE `education_ecm`.`finance`.`endowment_distribution` ADD CONSTRAINT `fk_finance_endowment_distribution_endowment_id` FOREIGN KEY (`endowment_id`) REFERENCES `education_ecm`.`advancement`.`endowment`(`endowment_id`);
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`finance`.`customer` ADD CONSTRAINT `fk_finance_customer_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `education_ecm`.`advancement`.`organization`(`organization_id`);
ALTER TABLE `education_ecm`.`finance`.`college_school` ADD CONSTRAINT `fk_finance_college_school_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `education_ecm`.`advancement`.`organization`(`organization_id`);

-- ========= finance --> compliance (9 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ADD CONSTRAINT `fk_finance_ledger_account_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`finance`.`budget_amendment` ADD CONSTRAINT `fk_finance_budget_amendment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`finance`.`finance_vendor` ADD CONSTRAINT `fk_finance_finance_vendor_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`finance`.`endowment_distribution` ADD CONSTRAINT `fk_finance_endowment_distribution_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`finance`.`grant_account` ADD CONSTRAINT `fk_finance_grant_account_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);

-- ========= finance --> curriculum (1 constraint(s)) =========
-- Requires: finance schema, curriculum schema
ALTER TABLE `education_ecm`.`finance`.`budget_amendment` ADD CONSTRAINT `fk_finance_budget_amendment_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);

-- ========= finance --> facility (7 constraint(s)) =========
-- Requires: finance schema, facility schema
ALTER TABLE `education_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`finance`.`budget_amendment` ADD CONSTRAINT `fk_finance_budget_amendment_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `education_ecm`.`facility`.`capital_project`(`capital_project_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `education_ecm`.`facility`.`capital_project`(`capital_project_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ADD CONSTRAINT `fk_finance_purchase_order_line_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `education_ecm`.`facility`.`capital_project`(`capital_project_id`);
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`finance`.`space_allocation` ADD CONSTRAINT `fk_finance_space_allocation_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);

-- ========= finance --> hr (25 constraint(s)) =========
-- Requires: finance schema, hr schema
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ADD CONSTRAINT `fk_finance_ledger_account_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_primary_journal_employee_id` FOREIGN KEY (`primary_journal_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_line` ADD CONSTRAINT `fk_finance_journal_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_line` ADD CONSTRAINT `fk_finance_journal_line_tertiary_journal_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_journal_last_modified_by_user_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`budget_amendment` ADD CONSTRAINT `fk_finance_budget_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ADD CONSTRAINT `fk_finance_purchase_order_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ADD CONSTRAINT `fk_finance_purchase_order_line_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_primary_ar_employee_id` FOREIGN KEY (`primary_ar_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`endowment_distribution` ADD CONSTRAINT `fk_finance_endowment_distribution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`grant_account` ADD CONSTRAINT `fk_finance_grant_account_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_reconciled_by_user_employee_id` FOREIGN KEY (`reconciled_by_user_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`college_school` ADD CONSTRAINT `fk_finance_college_school_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`finance`.`program` ADD CONSTRAINT `fk_finance_program_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`finance`.`program` ADD CONSTRAINT `fk_finance_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= finance --> research (5 constraint(s)) =========
-- Requires: finance schema, research schema
ALTER TABLE `education_ecm`.`finance`.`grant_account` ADD CONSTRAINT `fk_finance_grant_account_award_budget_id` FOREIGN KEY (`award_budget_id`) REFERENCES `education_ecm`.`research`.`award_budget`(`award_budget_id`);
ALTER TABLE `education_ecm`.`finance`.`grant_account` ADD CONSTRAINT `fk_finance_grant_account_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`finance`.`grant_account` ADD CONSTRAINT `fk_finance_grant_account_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `education_ecm`.`research`.`proposal`(`proposal_id`);
ALTER TABLE `education_ecm`.`finance`.`grant_account` ADD CONSTRAINT `fk_finance_grant_account_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_expenditure_id` FOREIGN KEY (`expenditure_id`) REFERENCES `education_ecm`.`research`.`expenditure`(`expenditure_id`);

-- ========= finance --> student (1 constraint(s)) =========
-- Requires: finance schema, student schema
ALTER TABLE `education_ecm`.`finance`.`customer` ADD CONSTRAINT `fk_finance_customer_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= finance --> technology (5 constraint(s)) =========
-- Requires: finance schema, technology schema
ALTER TABLE `education_ecm`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_approval_workflow_id` FOREIGN KEY (`approval_workflow_id`) REFERENCES `education_ecm`.`technology`.`approval_workflow`(`approval_workflow_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_batch` ADD CONSTRAINT `fk_finance_journal_batch_approval_workflow_id` FOREIGN KEY (`approval_workflow_id`) REFERENCES `education_ecm`.`technology`.`approval_workflow`(`approval_workflow_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_batch` ADD CONSTRAINT `fk_finance_journal_batch_approved_by_user_identity_account_id` FOREIGN KEY (`approved_by_user_identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_batch` ADD CONSTRAINT `fk_finance_journal_batch_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_batch` ADD CONSTRAINT `fk_finance_journal_batch_posted_by_user_identity_account_id` FOREIGN KEY (`posted_by_user_identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);

-- ========= hr --> advancement (2 constraint(s)) =========
-- Requires: hr schema, advancement schema
ALTER TABLE `education_ecm`.`hr`.`employee_compensation` ADD CONSTRAINT `fk_hr_employee_compensation_event_id` FOREIGN KEY (`event_id`) REFERENCES `education_ecm`.`advancement`.`event`(`event_id`);
ALTER TABLE `education_ecm`.`hr`.`benefit_enrollment` ADD CONSTRAINT `fk_hr_benefit_enrollment_event_id` FOREIGN KEY (`event_id`) REFERENCES `education_ecm`.`advancement`.`event`(`event_id`);

-- ========= hr --> compliance (1 constraint(s)) =========
-- Requires: hr schema, compliance schema
ALTER TABLE `education_ecm`.`hr`.`training_record` ADD CONSTRAINT `fk_hr_training_record_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `education_ecm`.`compliance`.`training_program`(`training_program_id`);

-- ========= hr --> facility (2 constraint(s)) =========
-- Requires: hr schema, facility schema
ALTER TABLE `education_ecm`.`hr`.`position` ADD CONSTRAINT `fk_hr_position_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`hr`.`recruitment_requisition` ADD CONSTRAINT `fk_hr_recruitment_requisition_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);

-- ========= hr --> finance (6 constraint(s)) =========
-- Requires: hr schema, finance schema
ALTER TABLE `education_ecm`.`hr`.`position` ADD CONSTRAINT `fk_hr_position_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`hr`.`org_unit` ADD CONSTRAINT `fk_hr_org_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`hr`.`payroll_result` ADD CONSTRAINT `fk_hr_payroll_result_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`hr`.`absence_event` ADD CONSTRAINT `fk_hr_absence_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`hr`.`time_entry` ADD CONSTRAINT `fk_hr_time_entry_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`hr`.`payroll_run` ADD CONSTRAINT `fk_hr_payroll_run_journal_batch_id` FOREIGN KEY (`journal_batch_id`) REFERENCES `education_ecm`.`finance`.`journal_batch`(`journal_batch_id`);

-- ========= hr --> student (1 constraint(s)) =========
-- Requires: hr schema, student schema
ALTER TABLE `education_ecm`.`hr`.`job_profile` ADD CONSTRAINT `fk_hr_job_profile_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= hr --> technology (1 constraint(s)) =========
-- Requires: hr schema, technology schema
ALTER TABLE `education_ecm`.`hr`.`onboarding_task` ADD CONSTRAINT `fk_hr_onboarding_task_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);

-- ========= instruction --> billing (6 constraint(s)) =========
-- Requires: instruction schema, billing schema
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_statement_id` FOREIGN KEY (`statement_id`) REFERENCES `education_ecm`.`billing`.`statement`(`statement_id`);
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_tuition_charge_id` FOREIGN KEY (`tuition_charge_id`) REFERENCES `education_ecm`.`billing`.`tuition_charge`(`tuition_charge_id`);
ALTER TABLE `education_ecm`.`instruction`.`instruction_assignment` ADD CONSTRAINT `fk_instruction_instruction_assignment_tuition_charge_id` FOREIGN KEY (`tuition_charge_id`) REFERENCES `education_ecm`.`billing`.`tuition_charge`(`tuition_charge_id`);
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ADD CONSTRAINT `fk_instruction_final_grade_tuition_charge_id` FOREIGN KEY (`tuition_charge_id`) REFERENCES `education_ecm`.`billing`.`tuition_charge`(`tuition_charge_id`);
ALTER TABLE `education_ecm`.`instruction`.`incomplete_contract` ADD CONSTRAINT `fk_instruction_incomplete_contract_tuition_charge_id` FOREIGN KEY (`tuition_charge_id`) REFERENCES `education_ecm`.`billing`.`tuition_charge`(`tuition_charge_id`);
ALTER TABLE `education_ecm`.`instruction`.`instruction_early_alert` ADD CONSTRAINT `fk_instruction_instruction_early_alert_account_hold_id` FOREIGN KEY (`account_hold_id`) REFERENCES `education_ecm`.`billing`.`account_hold`(`account_hold_id`);

-- ========= instruction --> compliance (7 constraint(s)) =========
-- Requires: instruction schema, compliance schema
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_compliance_training_completion_id` FOREIGN KEY (`compliance_training_completion_id`) REFERENCES `education_ecm`.`compliance`.`compliance_training_completion`(`compliance_training_completion_id`);
ALTER TABLE `education_ecm`.`instruction`.`instruction_submission` ADD CONSTRAINT `fk_instruction_instruction_submission_ada_accommodation_id` FOREIGN KEY (`ada_accommodation_id`) REFERENCES `education_ecm`.`compliance`.`ada_accommodation`(`ada_accommodation_id`);
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ADD CONSTRAINT `fk_instruction_slo_assessment_accreditation_standard_id` FOREIGN KEY (`accreditation_standard_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_standard`(`accreditation_standard_id`);
ALTER TABLE `education_ecm`.`instruction`.`grade_change_log` ADD CONSTRAINT `fk_instruction_grade_change_log_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `education_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `education_ecm`.`instruction`.`incomplete_contract` ADD CONSTRAINT `fk_instruction_incomplete_contract_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`instruction`.`instruction_early_alert` ADD CONSTRAINT `fk_instruction_instruction_early_alert_title_ix_case_id` FOREIGN KEY (`title_ix_case_id`) REFERENCES `education_ecm`.`compliance`.`title_ix_case`(`title_ix_case_id`);
ALTER TABLE `education_ecm`.`instruction`.`faculty_training_requirement` ADD CONSTRAINT `fk_instruction_faculty_training_requirement_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `education_ecm`.`compliance`.`training_program`(`training_program_id`);

-- ========= instruction --> curriculum (11 constraint(s)) =========
-- Requires: instruction schema, curriculum schema
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ADD CONSTRAINT `fk_instruction_lms_course_shell_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ADD CONSTRAINT `fk_instruction_lms_course_shell_tertiary_lms_blueprint_course_id` FOREIGN KEY (`tertiary_lms_blueprint_course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`instruction`.`instruction_assignment` ADD CONSTRAINT `fk_instruction_instruction_assignment_map_id` FOREIGN KEY (`map_id`) REFERENCES `education_ecm`.`curriculum`.`map`(`map_id`);
ALTER TABLE `education_ecm`.`instruction`.`instruction_assignment` ADD CONSTRAINT `fk_instruction_instruction_assignment_slo_id` FOREIGN KEY (`slo_id`) REFERENCES `education_ecm`.`curriculum`.`slo`(`slo_id`);
ALTER TABLE `education_ecm`.`instruction`.`rubric` ADD CONSTRAINT `fk_instruction_rubric_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`instruction`.`rubric` ADD CONSTRAINT `fk_instruction_rubric_slo_id` FOREIGN KEY (`slo_id`) REFERENCES `education_ecm`.`curriculum`.`slo`(`slo_id`);
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ADD CONSTRAINT `fk_instruction_slo_assessment_map_id` FOREIGN KEY (`map_id`) REFERENCES `education_ecm`.`curriculum`.`map`(`map_id`);
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ADD CONSTRAINT `fk_instruction_slo_assessment_plo_id` FOREIGN KEY (`plo_id`) REFERENCES `education_ecm`.`curriculum`.`plo`(`plo_id`);
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ADD CONSTRAINT `fk_instruction_slo_assessment_slo_id` FOREIGN KEY (`slo_id`) REFERENCES `education_ecm`.`curriculum`.`slo`(`slo_id`);
ALTER TABLE `education_ecm`.`instruction`.`instruction_early_alert` ADD CONSTRAINT `fk_instruction_instruction_early_alert_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);

-- ========= instruction --> enrollment (5 constraint(s)) =========
-- Requires: instruction schema, enrollment schema
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ADD CONSTRAINT `fk_instruction_lms_course_shell_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ADD CONSTRAINT `fk_instruction_attendance_record_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`instruction`.`grade_appeal_case` ADD CONSTRAINT `fk_instruction_grade_appeal_case_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);

-- ========= instruction --> facility (9 constraint(s)) =========
-- Requires: instruction schema, facility schema
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ADD CONSTRAINT `fk_instruction_section_meeting_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ADD CONSTRAINT `fk_instruction_lms_course_shell_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`instruction`.`instruction_assignment` ADD CONSTRAINT `fk_instruction_instruction_assignment_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ADD CONSTRAINT `fk_instruction_attendance_record_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`instruction`.`incomplete_contract` ADD CONSTRAINT `fk_instruction_incomplete_contract_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);

-- ========= instruction --> faculty (13 constraint(s)) =========
-- Requires: instruction schema, faculty schema
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ADD CONSTRAINT `fk_instruction_section_meeting_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`instruction`.`instruction_assignment` ADD CONSTRAINT `fk_instruction_instruction_assignment_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`instruction`.`instruction_submission` ADD CONSTRAINT `fk_instruction_instruction_submission_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ADD CONSTRAINT `fk_instruction_grade_entry_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ADD CONSTRAINT `fk_instruction_final_grade_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ADD CONSTRAINT `fk_instruction_attendance_record_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ADD CONSTRAINT `fk_instruction_slo_assessment_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`instruction`.`grade_change_log` ADD CONSTRAINT `fk_instruction_grade_change_log_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`instruction`.`incomplete_contract` ADD CONSTRAINT `fk_instruction_incomplete_contract_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`instruction`.`instruction_early_alert` ADD CONSTRAINT `fk_instruction_instruction_early_alert_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`instruction`.`grade_appeal_case` ADD CONSTRAINT `fk_instruction_grade_appeal_case_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);

-- ========= instruction --> finance (3 constraint(s)) =========
-- Requires: instruction schema, finance schema
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`instruction`.`scorm_package` ADD CONSTRAINT `fk_instruction_scorm_package_finance_vendor_id` FOREIGN KEY (`finance_vendor_id`) REFERENCES `education_ecm`.`finance`.`finance_vendor`(`finance_vendor_id`);
ALTER TABLE `education_ecm`.`instruction`.`scorm_package` ADD CONSTRAINT `fk_instruction_scorm_package_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `education_ecm`.`finance`.`purchase_order`(`purchase_order_id`);

-- ========= instruction --> hr (12 constraint(s)) =========
-- Requires: instruction schema, hr schema
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_tertiary_faculty_updated_by_user_employee_id` FOREIGN KEY (`tertiary_faculty_updated_by_user_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`instruction`.`instruction_assignment` ADD CONSTRAINT `fk_instruction_instruction_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ADD CONSTRAINT `fk_instruction_grade_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ADD CONSTRAINT `fk_instruction_attendance_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`instruction`.`rubric` ADD CONSTRAINT `fk_instruction_rubric_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`instruction`.`scorm_package` ADD CONSTRAINT `fk_instruction_scorm_package_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`instruction`.`grade_change_log` ADD CONSTRAINT `fk_instruction_grade_change_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`instruction`.`incomplete_contract` ADD CONSTRAINT `fk_instruction_incomplete_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`instruction`.`instruction_early_alert` ADD CONSTRAINT `fk_instruction_instruction_early_alert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`instruction`.`grade_appeal_case` ADD CONSTRAINT `fk_instruction_grade_appeal_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= instruction --> student (9 constraint(s)) =========
-- Requires: instruction schema, student schema
ALTER TABLE `education_ecm`.`instruction`.`instruction_submission` ADD CONSTRAINT `fk_instruction_instruction_submission_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ADD CONSTRAINT `fk_instruction_grade_entry_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ADD CONSTRAINT `fk_instruction_final_grade_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ADD CONSTRAINT `fk_instruction_attendance_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ADD CONSTRAINT `fk_instruction_slo_assessment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`instruction`.`grade_change_log` ADD CONSTRAINT `fk_instruction_grade_change_log_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`instruction`.`incomplete_contract` ADD CONSTRAINT `fk_instruction_incomplete_contract_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`instruction`.`instruction_early_alert` ADD CONSTRAINT `fk_instruction_instruction_early_alert_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`instruction`.`grade_appeal_case` ADD CONSTRAINT `fk_instruction_grade_appeal_case_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= instruction --> studentlife (10 constraint(s)) =========
-- Requires: instruction schema, studentlife schema
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_llc_program_id` FOREIGN KEY (`llc_program_id`) REFERENCES `education_ecm`.`studentlife`.`llc_program`(`llc_program_id`);
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_student_org_id` FOREIGN KEY (`student_org_id`) REFERENCES `education_ecm`.`studentlife`.`student_org`(`student_org_id`);
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_campus_event_id` FOREIGN KEY (`campus_event_id`) REFERENCES `education_ecm`.`studentlife`.`campus_event`(`campus_event_id`);
ALTER TABLE `education_ecm`.`instruction`.`instruction_assignment` ADD CONSTRAINT `fk_instruction_instruction_assignment_wellness_program_id` FOREIGN KEY (`wellness_program_id`) REFERENCES `education_ecm`.`studentlife`.`wellness_program`(`wellness_program_id`);
ALTER TABLE `education_ecm`.`instruction`.`instruction_submission` ADD CONSTRAINT `fk_instruction_instruction_submission_wellness_participation_id` FOREIGN KEY (`wellness_participation_id`) REFERENCES `education_ecm`.`studentlife`.`wellness_participation`(`wellness_participation_id`);
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ADD CONSTRAINT `fk_instruction_final_grade_studentlife_housing_assignment_id` FOREIGN KEY (`studentlife_housing_assignment_id`) REFERENCES `education_ecm`.`studentlife`.`studentlife_housing_assignment`(`studentlife_housing_assignment_id`);
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ADD CONSTRAINT `fk_instruction_slo_assessment_service_learning_placement_id` FOREIGN KEY (`service_learning_placement_id`) REFERENCES `education_ecm`.`studentlife`.`service_learning_placement`(`service_learning_placement_id`);
ALTER TABLE `education_ecm`.`instruction`.`grade_change_log` ADD CONSTRAINT `fk_instruction_grade_change_log_conduct_case_id` FOREIGN KEY (`conduct_case_id`) REFERENCES `education_ecm`.`studentlife`.`conduct_case`(`conduct_case_id`);
ALTER TABLE `education_ecm`.`instruction`.`instruction_early_alert` ADD CONSTRAINT `fk_instruction_instruction_early_alert_conduct_case_id` FOREIGN KEY (`conduct_case_id`) REFERENCES `education_ecm`.`studentlife`.`conduct_case`(`conduct_case_id`);
ALTER TABLE `education_ecm`.`instruction`.`grade_appeal_case` ADD CONSTRAINT `fk_instruction_grade_appeal_case_conduct_case_id` FOREIGN KEY (`conduct_case_id`) REFERENCES `education_ecm`.`studentlife`.`conduct_case`(`conduct_case_id`);

-- ========= instruction --> technology (11 constraint(s)) =========
-- Requires: instruction schema, technology schema
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ADD CONSTRAINT `fk_instruction_lms_course_shell_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ADD CONSTRAINT `fk_instruction_lms_course_shell_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `education_ecm`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `education_ecm`.`instruction`.`instruction_assignment` ADD CONSTRAINT `fk_instruction_instruction_assignment_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`instruction`.`instruction_assignment` ADD CONSTRAINT `fk_instruction_instruction_assignment_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`instruction`.`rubric` ADD CONSTRAINT `fk_instruction_rubric_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`instruction`.`scorm_package` ADD CONSTRAINT `fk_instruction_scorm_package_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`instruction`.`scorm_package` ADD CONSTRAINT `fk_instruction_scorm_package_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`instruction`.`incomplete_contract` ADD CONSTRAINT `fk_instruction_incomplete_contract_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`instruction`.`incomplete_contract` ADD CONSTRAINT `fk_instruction_incomplete_contract_modified_by_user_identity_account_id` FOREIGN KEY (`modified_by_user_identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`instruction`.`instruction_early_alert` ADD CONSTRAINT `fk_instruction_instruction_early_alert_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);

-- ========= library --> advancement (2 constraint(s)) =========
-- Requires: library schema, advancement schema
ALTER TABLE `education_ecm`.`library`.`library_fund` ADD CONSTRAINT `fk_library_library_fund_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`library`.`collection` ADD CONSTRAINT `fk_library_collection_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);

-- ========= library --> aid (1 constraint(s)) =========
-- Requires: library schema, aid schema
ALTER TABLE `education_ecm`.`library`.`oer_resource` ADD CONSTRAINT `fk_library_oer_resource_coa_budget_id` FOREIGN KEY (`coa_budget_id`) REFERENCES `education_ecm`.`aid`.`coa_budget`(`coa_budget_id`);

-- ========= library --> athletics (2 constraint(s)) =========
-- Requires: library schema, athletics schema
ALTER TABLE `education_ecm`.`library`.`oer_resource` ADD CONSTRAINT `fk_library_oer_resource_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`library`.`collection` ADD CONSTRAINT `fk_library_collection_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);

-- ========= library --> billing (1 constraint(s)) =========
-- Requires: library schema, billing schema
ALTER TABLE `education_ecm`.`library`.`fine` ADD CONSTRAINT `fk_library_fine_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);

-- ========= library --> compliance (10 constraint(s)) =========
-- Requires: library schema, compliance schema
ALTER TABLE `education_ecm`.`library`.`loan` ADD CONSTRAINT `fk_library_loan_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ADD CONSTRAINT `fk_library_electronic_resource_ada_accommodation_id` FOREIGN KEY (`ada_accommodation_id`) REFERENCES `education_ecm`.`compliance`.`ada_accommodation`(`ada_accommodation_id`);
ALTER TABLE `education_ecm`.`library`.`license` ADD CONSTRAINT `fk_library_license_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`library`.`course_reserve` ADD CONSTRAINT `fk_library_course_reserve_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`library`.`oer_resource` ADD CONSTRAINT `fk_library_oer_resource_accreditation_standard_id` FOREIGN KEY (`accreditation_standard_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_standard`(`accreditation_standard_id`);
ALTER TABLE `education_ecm`.`library`.`digital_object` ADD CONSTRAINT `fk_library_digital_object_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`library`.`research_support_request` ADD CONSTRAINT `fk_library_research_support_request_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`library`.`collection_policy_compliance` ADD CONSTRAINT `fk_library_collection_policy_compliance_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`library`.`resource_compliance_verification` ADD CONSTRAINT `fk_library_resource_compliance_verification_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`library`.`service_desk` ADD CONSTRAINT `fk_library_service_desk_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);

-- ========= library --> curriculum (1 constraint(s)) =========
-- Requires: library schema, curriculum schema
ALTER TABLE `education_ecm`.`library`.`oer_resource` ADD CONSTRAINT `fk_library_oer_resource_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);

-- ========= library --> facility (2 constraint(s)) =========
-- Requires: library schema, facility schema
ALTER TABLE `education_ecm`.`library`.`hold_request` ADD CONSTRAINT `fk_library_hold_request_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`library`.`service_desk` ADD CONSTRAINT `fk_library_service_desk_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);

-- ========= library --> faculty (3 constraint(s)) =========
-- Requires: library schema, faculty schema
ALTER TABLE `education_ecm`.`library`.`course_reserve` ADD CONSTRAINT `fk_library_course_reserve_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`library`.`oer_resource` ADD CONSTRAINT `fk_library_oer_resource_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`library`.`digital_object` ADD CONSTRAINT `fk_library_digital_object_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);

-- ========= library --> finance (9 constraint(s)) =========
-- Requires: library schema, finance schema
ALTER TABLE `education_ecm`.`library`.`fine` ADD CONSTRAINT `fk_library_fine_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ADD CONSTRAINT `fk_library_acquisition_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ADD CONSTRAINT `fk_library_acquisition_order_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`library`.`library_fund` ADD CONSTRAINT `fk_library_library_fund_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`library`.`library_fund` ADD CONSTRAINT `fk_library_library_fund_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`library`.`oer_resource` ADD CONSTRAINT `fk_library_oer_resource_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`library`.`digital_object` ADD CONSTRAINT `fk_library_digital_object_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`library`.`research_support_request` ADD CONSTRAINT `fk_library_research_support_request_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`library`.`subscription` ADD CONSTRAINT `fk_library_subscription_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);

-- ========= library --> hr (10 constraint(s)) =========
-- Requires: library schema, hr schema
ALTER TABLE `education_ecm`.`library`.`loan` ADD CONSTRAINT `fk_library_loan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`library`.`loan` ADD CONSTRAINT `fk_library_loan_loan_return_operator_employee_id` FOREIGN KEY (`loan_return_operator_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`library`.`fine` ADD CONSTRAINT `fk_library_fine_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ADD CONSTRAINT `fk_library_acquisition_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`library`.`library_fund` ADD CONSTRAINT `fk_library_library_fund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`library`.`library_fund` ADD CONSTRAINT `fk_library_library_fund_primary_library_employee_id` FOREIGN KEY (`primary_library_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`library`.`course_reserve` ADD CONSTRAINT `fk_library_course_reserve_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`library`.`collection` ADD CONSTRAINT `fk_library_collection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`library`.`research_support_request` ADD CONSTRAINT `fk_library_research_support_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`library`.`subscription` ADD CONSTRAINT `fk_library_subscription_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= library --> instruction (6 constraint(s)) =========
-- Requires: library schema, instruction schema
ALTER TABLE `education_ecm`.`library`.`course_reserve` ADD CONSTRAINT `fk_library_course_reserve_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`library`.`course_reserve` ADD CONSTRAINT `fk_library_course_reserve_lms_course_shell_id` FOREIGN KEY (`lms_course_shell_id`) REFERENCES `education_ecm`.`instruction`.`lms_course_shell`(`lms_course_shell_id`);
ALTER TABLE `education_ecm`.`library`.`oer_resource` ADD CONSTRAINT `fk_library_oer_resource_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`library`.`oer_resource` ADD CONSTRAINT `fk_library_oer_resource_lms_course_shell_id` FOREIGN KEY (`lms_course_shell_id`) REFERENCES `education_ecm`.`instruction`.`lms_course_shell`(`lms_course_shell_id`);
ALTER TABLE `education_ecm`.`library`.`digital_object` ADD CONSTRAINT `fk_library_digital_object_instruction_assignment_id` FOREIGN KEY (`instruction_assignment_id`) REFERENCES `education_ecm`.`instruction`.`instruction_assignment`(`instruction_assignment_id`);
ALTER TABLE `education_ecm`.`library`.`research_support_request` ADD CONSTRAINT `fk_library_research_support_request_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);

-- ========= library --> research (3 constraint(s)) =========
-- Requires: library schema, research schema
ALTER TABLE `education_ecm`.`library`.`oer_resource` ADD CONSTRAINT `fk_library_oer_resource_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`library`.`oer_resource` ADD CONSTRAINT `fk_library_oer_resource_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`library`.`research_support_request` ADD CONSTRAINT `fk_library_research_support_request_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);

-- ========= library --> student (2 constraint(s)) =========
-- Requires: library schema, student schema
ALTER TABLE `education_ecm`.`library`.`course_reserve` ADD CONSTRAINT `fk_library_course_reserve_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`library`.`digital_object` ADD CONSTRAINT `fk_library_digital_object_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= library --> technology (3 constraint(s)) =========
-- Requires: library schema, technology schema
ALTER TABLE `education_ecm`.`library`.`patron` ADD CONSTRAINT `fk_library_patron_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ADD CONSTRAINT `fk_library_electronic_resource_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`library`.`usage_stat` ADD CONSTRAINT `fk_library_usage_stat_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);

-- ========= research --> advancement (4 constraint(s)) =========
-- Requires: research schema, advancement schema
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ADD CONSTRAINT `fk_research_principal_investigator_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ADD CONSTRAINT `fk_research_proposal_personnel_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ADD CONSTRAINT `fk_research_invention_disclosure_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ADD CONSTRAINT `fk_research_scholarly_output_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);

-- ========= research --> athletics (3 constraint(s)) =========
-- Requires: research schema, athletics schema
ALTER TABLE `education_ecm`.`research`.`effort_certification` ADD CONSTRAINT `fk_research_effort_certification_student_athlete_id` FOREIGN KEY (`student_athlete_id`) REFERENCES `education_ecm`.`athletics`.`student_athlete`(`student_athlete_id`);
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ADD CONSTRAINT `fk_research_proposal_personnel_student_athlete_id` FOREIGN KEY (`student_athlete_id`) REFERENCES `education_ecm`.`athletics`.`student_athlete`(`student_athlete_id`);
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ADD CONSTRAINT `fk_research_scholarly_output_student_athlete_id` FOREIGN KEY (`student_athlete_id`) REFERENCES `education_ecm`.`athletics`.`student_athlete`(`student_athlete_id`);

-- ========= research --> billing (3 constraint(s)) =========
-- Requires: research schema, billing schema
ALTER TABLE `education_ecm`.`research`.`research_award` ADD CONSTRAINT `fk_research_research_award_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_tuition_charge_id` FOREIGN KEY (`tuition_charge_id`) REFERENCES `education_ecm`.`billing`.`tuition_charge`(`tuition_charge_id`);
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ADD CONSTRAINT `fk_research_proposal_personnel_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);

-- ========= research --> compliance (17 constraint(s)) =========
-- Requires: research schema, compliance schema
ALTER TABLE `education_ecm`.`research`.`proposal` ADD CONSTRAINT `fk_research_proposal_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`research`.`research_award` ADD CONSTRAINT `fk_research_research_award_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ADD CONSTRAINT `fk_research_principal_investigator_compliance_training_completion_id` FOREIGN KEY (`compliance_training_completion_id`) REFERENCES `education_ecm`.`compliance`.`compliance_training_completion`(`compliance_training_completion_id`);
ALTER TABLE `education_ecm`.`research`.`subaward` ADD CONSTRAINT `fk_research_subaward_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `education_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ADD CONSTRAINT `fk_research_irb_protocol_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ADD CONSTRAINT `fk_research_irb_protocol_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `education_ecm`.`compliance`.`training_program`(`training_program_id`);
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ADD CONSTRAINT `fk_research_iacuc_protocol_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ADD CONSTRAINT `fk_research_iacuc_protocol_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `education_ecm`.`compliance`.`training_program`(`training_program_id`);
ALTER TABLE `education_ecm`.`research`.`effort_certification` ADD CONSTRAINT `fk_research_effort_certification_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ADD CONSTRAINT `fk_research_conflict_of_interest_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ADD CONSTRAINT `fk_research_proposal_personnel_compliance_training_completion_id` FOREIGN KEY (`compliance_training_completion_id`) REFERENCES `education_ecm`.`compliance`.`compliance_training_completion`(`compliance_training_completion_id`);
ALTER TABLE `education_ecm`.`research`.`award_report` ADD CONSTRAINT `fk_research_award_report_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `education_ecm`.`research`.`export_control_review` ADD CONSTRAINT `fk_research_export_control_review_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `education_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `education_ecm`.`compliance`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ADD CONSTRAINT `fk_research_research_training_completion_compliance_training_completion_id` FOREIGN KEY (`compliance_training_completion_id`) REFERENCES `education_ecm`.`compliance`.`compliance_training_completion`(`compliance_training_completion_id`);
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ADD CONSTRAINT `fk_research_research_training_completion_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `education_ecm`.`compliance`.`training_program`(`training_program_id`);

-- ========= research --> curriculum (4 constraint(s)) =========
-- Requires: research schema, curriculum schema
ALTER TABLE `education_ecm`.`research`.`research_award` ADD CONSTRAINT `fk_research_research_award_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ADD CONSTRAINT `fk_research_irb_protocol_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ADD CONSTRAINT `fk_research_iacuc_protocol_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ADD CONSTRAINT `fk_research_scholarly_output_plo_id` FOREIGN KEY (`plo_id`) REFERENCES `education_ecm`.`curriculum`.`plo`(`plo_id`);

-- ========= research --> facility (9 constraint(s)) =========
-- Requires: research schema, facility schema
ALTER TABLE `education_ecm`.`research`.`proposal` ADD CONSTRAINT `fk_research_proposal_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`research`.`research_award` ADD CONSTRAINT `fk_research_research_award_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`research`.`research_award` ADD CONSTRAINT `fk_research_research_award_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ADD CONSTRAINT `fk_research_irb_protocol_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ADD CONSTRAINT `fk_research_iacuc_protocol_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`research`.`award_account` ADD CONSTRAINT `fk_research_award_account_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`research`.`award_account` ADD CONSTRAINT `fk_research_award_account_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);

-- ========= research --> faculty (1 constraint(s)) =========
-- Requires: research schema, faculty schema
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ADD CONSTRAINT `fk_research_principal_investigator_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);

-- ========= research --> finance (4 constraint(s)) =========
-- Requires: research schema, finance schema
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_finance_vendor_id` FOREIGN KEY (`finance_vendor_id`) REFERENCES `education_ecm`.`finance`.`finance_vendor`(`finance_vendor_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `education_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `education_ecm`.`research`.`effort_certification` ADD CONSTRAINT `fk_research_effort_certification_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`research`.`effort_certification` ADD CONSTRAINT `fk_research_effort_certification_grant_expenditure_id` FOREIGN KEY (`grant_expenditure_id`) REFERENCES `education_ecm`.`finance`.`grant_expenditure`(`grant_expenditure_id`);

-- ========= research --> hr (20 constraint(s)) =========
-- Requires: research schema, hr schema
ALTER TABLE `education_ecm`.`research`.`proposal` ADD CONSTRAINT `fk_research_proposal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`proposal` ADD CONSTRAINT `fk_research_proposal_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`research`.`proposal` ADD CONSTRAINT `fk_research_proposal_proposal_org_unit_id` FOREIGN KEY (`proposal_org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`research`.`research_award` ADD CONSTRAINT `fk_research_research_award_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`research`.`research_award` ADD CONSTRAINT `fk_research_research_award_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`award_budget` ADD CONSTRAINT `fk_research_award_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ADD CONSTRAINT `fk_research_principal_investigator_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`subaward` ADD CONSTRAINT `fk_research_subaward_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ADD CONSTRAINT `fk_research_irb_protocol_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ADD CONSTRAINT `fk_research_iacuc_protocol_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`effort_certification` ADD CONSTRAINT `fk_research_effort_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`award_modification` ADD CONSTRAINT `fk_research_award_modification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ADD CONSTRAINT `fk_research_conflict_of_interest_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`award_account` ADD CONSTRAINT `fk_research_award_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ADD CONSTRAINT `fk_research_proposal_personnel_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`award_report` ADD CONSTRAINT `fk_research_award_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ADD CONSTRAINT `fk_research_invention_disclosure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`export_control_review` ADD CONSTRAINT `fk_research_export_control_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`research`.`subrecipient` ADD CONSTRAINT `fk_research_subrecipient_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= research --> instruction (6 constraint(s)) =========
-- Requires: research schema, instruction schema
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ADD CONSTRAINT `fk_research_irb_protocol_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ADD CONSTRAINT `fk_research_iacuc_protocol_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_faculty_assignment_id` FOREIGN KEY (`faculty_assignment_id`) REFERENCES `education_ecm`.`instruction`.`faculty_assignment`(`faculty_assignment_id`);
ALTER TABLE `education_ecm`.`research`.`effort_certification` ADD CONSTRAINT `fk_research_effort_certification_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`research`.`effort_certification` ADD CONSTRAINT `fk_research_effort_certification_faculty_assignment_id` FOREIGN KEY (`faculty_assignment_id`) REFERENCES `education_ecm`.`instruction`.`faculty_assignment`(`faculty_assignment_id`);
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ADD CONSTRAINT `fk_research_scholarly_output_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);

-- ========= research --> library (1 constraint(s)) =========
-- Requires: research schema, library schema
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ADD CONSTRAINT `fk_research_scholarly_output_bib_record_id` FOREIGN KEY (`bib_record_id`) REFERENCES `education_ecm`.`library`.`bib_record`(`bib_record_id`);

-- ========= research --> technology (15 constraint(s)) =========
-- Requires: research schema, technology schema
ALTER TABLE `education_ecm`.`research`.`proposal` ADD CONSTRAINT `fk_research_proposal_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`research`.`proposal` ADD CONSTRAINT `fk_research_proposal_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`research`.`research_award` ADD CONSTRAINT `fk_research_research_award_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ADD CONSTRAINT `fk_research_principal_investigator_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ADD CONSTRAINT `fk_research_irb_protocol_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ADD CONSTRAINT `fk_research_iacuc_protocol_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`research`.`effort_certification` ADD CONSTRAINT `fk_research_effort_certification_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ADD CONSTRAINT `fk_research_conflict_of_interest_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ADD CONSTRAINT `fk_research_proposal_personnel_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ADD CONSTRAINT `fk_research_proposal_personnel_last_modified_by_user_identity_account_id` FOREIGN KEY (`last_modified_by_user_identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`research`.`award_report` ADD CONSTRAINT `fk_research_award_report_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`research`.`export_control_review` ADD CONSTRAINT `fk_research_export_control_review_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `education_ecm`.`technology`.`incident`(`incident_id`);
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ADD CONSTRAINT `fk_research_scholarly_output_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);

-- ========= student --> compliance (15 constraint(s)) =========
-- Requires: student schema, compliance schema
ALTER TABLE `education_ecm`.`student`.`academic_standing` ADD CONSTRAINT `fk_student_academic_standing_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`student`.`degree_progress` ADD CONSTRAINT `fk_student_degree_progress_accreditation_review_id` FOREIGN KEY (`accreditation_review_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_review`(`accreditation_review_id`);
ALTER TABLE `education_ecm`.`student`.`academic_history` ADD CONSTRAINT `fk_student_academic_history_accreditation_standard_id` FOREIGN KEY (`accreditation_standard_id`) REFERENCES `education_ecm`.`compliance`.`accreditation_standard`(`accreditation_standard_id`);
ALTER TABLE `education_ecm`.`student`.`student_test_score` ADD CONSTRAINT `fk_student_student_test_score_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ADD CONSTRAINT `fk_student_transfer_credit_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`student`.`hold` ADD CONSTRAINT `fk_student_hold_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ADD CONSTRAINT `fk_student_cohort_membership_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ADD CONSTRAINT `fk_student_ferpa_consent_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`student`.`residency_classification` ADD CONSTRAINT `fk_student_residency_classification_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ADD CONSTRAINT `fk_student_visa_immigration_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`student`.`graduation_application` ADD CONSTRAINT `fk_student_graduation_application_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `education_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `education_ecm`.`student`.`conduct_record` ADD CONSTRAINT `fk_student_conduct_record_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `education_ecm`.`compliance`.`policy`(`policy_id`);
ALTER TABLE `education_ecm`.`student`.`student_training_completion` ADD CONSTRAINT `fk_student_student_training_completion_compliance_training_completion_id` FOREIGN KEY (`compliance_training_completion_id`) REFERENCES `education_ecm`.`compliance`.`compliance_training_completion`(`compliance_training_completion_id`);
ALTER TABLE `education_ecm`.`student`.`student_training_completion` ADD CONSTRAINT `fk_student_student_training_completion_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `education_ecm`.`compliance`.`training_program`(`training_program_id`);

-- ========= student --> curriculum (6 constraint(s)) =========
-- Requires: student schema, curriculum schema
ALTER TABLE `education_ecm`.`student`.`degree_progress` ADD CONSTRAINT `fk_student_degree_progress_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`student`.`academic_history` ADD CONSTRAINT `fk_student_academic_history_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ADD CONSTRAINT `fk_student_transfer_credit_articulation_agreement_id` FOREIGN KEY (`articulation_agreement_id`) REFERENCES `education_ecm`.`curriculum`.`articulation_agreement`(`articulation_agreement_id`);
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ADD CONSTRAINT `fk_student_transfer_credit_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ADD CONSTRAINT `fk_student_degree_conferral_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);

-- ========= student --> enrollment (14 constraint(s)) =========
-- Requires: student schema, enrollment schema
ALTER TABLE `education_ecm`.`student`.`academic_standing` ADD CONSTRAINT `fk_student_academic_standing_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`student`.`academic_history` ADD CONSTRAINT `fk_student_academic_history_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`student`.`student_test_score` ADD CONSTRAINT `fk_student_student_test_score_enrollment_application_id` FOREIGN KEY (`enrollment_application_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_application`(`enrollment_application_id`);
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ADD CONSTRAINT `fk_student_leave_of_absence_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ADD CONSTRAINT `fk_student_cohort_membership_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`student`.`residency_classification` ADD CONSTRAINT `fk_student_residency_classification_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`student`.`graduation_application` ADD CONSTRAINT `fk_student_graduation_application_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`student`.`advising_note` ADD CONSTRAINT `fk_student_advising_note_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ADD CONSTRAINT `fk_student_student_early_alert_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ADD CONSTRAINT `fk_student_student_sap_evaluation_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`student`.`conduct_record` ADD CONSTRAINT `fk_student_conduct_record_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`student`.`student_enrollment` ADD CONSTRAINT `fk_student_student_enrollment_enrollment_registration_id` FOREIGN KEY (`enrollment_registration_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_registration`(`enrollment_registration_id`);
ALTER TABLE `education_ecm`.`student`.`student_enrollment` ADD CONSTRAINT `fk_student_student_enrollment_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);

-- ========= student --> facility (5 constraint(s)) =========
-- Requires: student schema, facility schema
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ADD CONSTRAINT `fk_student_enrollment_status_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`student`.`conduct_record` ADD CONSTRAINT `fk_student_conduct_record_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ADD CONSTRAINT `fk_student_student_housing_assignment_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`student`.`access_authorization` ADD CONSTRAINT `fk_student_access_authorization_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);

-- ========= student --> faculty (3 constraint(s)) =========
-- Requires: student schema, faculty schema
ALTER TABLE `education_ecm`.`student`.`academic_history` ADD CONSTRAINT `fk_student_academic_history_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`student`.`advising_note` ADD CONSTRAINT `fk_student_advising_note_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`student`.`student_submission` ADD CONSTRAINT `fk_student_student_submission_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);

-- ========= student --> finance (6 constraint(s)) =========
-- Requires: student schema, finance schema
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ADD CONSTRAINT `fk_student_transfer_credit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`student`.`hold` ADD CONSTRAINT `fk_student_hold_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`student`.`advising_note` ADD CONSTRAINT `fk_student_advising_note_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ADD CONSTRAINT `fk_student_student_early_alert_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`student`.`conduct_record` ADD CONSTRAINT `fk_student_conduct_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= student --> hr (11 constraint(s)) =========
-- Requires: student schema, hr schema
ALTER TABLE `education_ecm`.`student`.`academic_standing` ADD CONSTRAINT `fk_student_academic_standing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ADD CONSTRAINT `fk_student_transfer_credit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ADD CONSTRAINT `fk_student_leave_of_absence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ADD CONSTRAINT `fk_student_ferpa_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`student`.`residency_classification` ADD CONSTRAINT `fk_student_residency_classification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`student`.`advising_note` ADD CONSTRAINT `fk_student_advising_note_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ADD CONSTRAINT `fk_student_student_early_alert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ADD CONSTRAINT `fk_student_student_sap_evaluation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ADD CONSTRAINT `fk_student_degree_conferral_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`student`.`checkout` ADD CONSTRAINT `fk_student_checkout_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= student --> instruction (6 constraint(s)) =========
-- Requires: student schema, instruction schema
ALTER TABLE `education_ecm`.`student`.`academic_history` ADD CONSTRAINT `fk_student_academic_history_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`student`.`advising_note` ADD CONSTRAINT `fk_student_advising_note_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`student`.`student_enrollment` ADD CONSTRAINT `fk_student_student_enrollment_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`student`.`student_submission` ADD CONSTRAINT `fk_student_student_submission_instruction_assignment_id` FOREIGN KEY (`instruction_assignment_id`) REFERENCES `education_ecm`.`instruction`.`instruction_assignment`(`instruction_assignment_id`);
ALTER TABLE `education_ecm`.`student`.`student_submission` ADD CONSTRAINT `fk_student_student_submission_instruction_submission_id` FOREIGN KEY (`instruction_submission_id`) REFERENCES `education_ecm`.`instruction`.`instruction_submission`(`instruction_submission_id`);

-- ========= student --> research (5 constraint(s)) =========
-- Requires: student schema, research schema
ALTER TABLE `education_ecm`.`student`.`academic_history` ADD CONSTRAINT `fk_student_academic_history_irb_protocol_id` FOREIGN KEY (`irb_protocol_id`) REFERENCES `education_ecm`.`research`.`irb_protocol`(`irb_protocol_id`);
ALTER TABLE `education_ecm`.`student`.`academic_history` ADD CONSTRAINT `fk_student_academic_history_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ADD CONSTRAINT `fk_student_visa_immigration_export_control_review_id` FOREIGN KEY (`export_control_review_id`) REFERENCES `education_ecm`.`research`.`export_control_review`(`export_control_review_id`);
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ADD CONSTRAINT `fk_student_degree_conferral_scholarly_output_id` FOREIGN KEY (`scholarly_output_id`) REFERENCES `education_ecm`.`research`.`scholarly_output`(`scholarly_output_id`);
ALTER TABLE `education_ecm`.`student`.`participation` ADD CONSTRAINT `fk_student_participation_irb_protocol_id` FOREIGN KEY (`irb_protocol_id`) REFERENCES `education_ecm`.`research`.`irb_protocol`(`irb_protocol_id`);

-- ========= student --> studentlife (1 constraint(s)) =========
-- Requires: student schema, studentlife schema
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ADD CONSTRAINT `fk_student_student_housing_assignment_studentlife_housing_assignment_id` FOREIGN KEY (`studentlife_housing_assignment_id`) REFERENCES `education_ecm`.`studentlife`.`studentlife_housing_assignment`(`studentlife_housing_assignment_id`);

-- ========= student --> technology (11 constraint(s)) =========
-- Requires: student schema, technology schema
ALTER TABLE `education_ecm`.`student`.`academic_history` ADD CONSTRAINT `fk_student_academic_history_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `education_ecm`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `education_ecm`.`student`.`advising_note` ADD CONSTRAINT `fk_student_advising_note_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`student`.`advising_note` ADD CONSTRAINT `fk_student_advising_note_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `education_ecm`.`technology`.`service_request`(`service_request_id`);
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ADD CONSTRAINT `fk_student_student_early_alert_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `education_ecm`.`technology`.`service_request`(`service_request_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `education_ecm`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_modified_by_user_identity_account_id` FOREIGN KEY (`modified_by_user_identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ADD CONSTRAINT `fk_student_student_sap_evaluation_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ADD CONSTRAINT `fk_student_student_sap_evaluation_last_modified_by_user_identity_account_id` FOREIGN KEY (`last_modified_by_user_identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ADD CONSTRAINT `fk_student_degree_conferral_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`student`.`checkout` ADD CONSTRAINT `fk_student_checkout_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `education_ecm`.`technology`.`it_asset`(`it_asset_id`);

-- ========= studentlife --> aid (1 constraint(s)) =========
-- Requires: studentlife schema, aid schema
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ADD CONSTRAINT `fk_studentlife_housing_application_award_package_id` FOREIGN KEY (`award_package_id`) REFERENCES `education_ecm`.`aid`.`award_package`(`award_package_id`);

-- ========= studentlife --> billing (15 constraint(s)) =========
-- Requires: studentlife schema, billing schema
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ADD CONSTRAINT `fk_studentlife_studentlife_housing_assignment_account_hold_id` FOREIGN KEY (`account_hold_id`) REFERENCES `education_ecm`.`billing`.`account_hold`(`account_hold_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ADD CONSTRAINT `fk_studentlife_housing_application_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `education_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ADD CONSTRAINT `fk_studentlife_housing_application_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ADD CONSTRAINT `fk_studentlife_dining_enrollment_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `education_ecm`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ADD CONSTRAINT `fk_studentlife_dining_enrollment_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ADD CONSTRAINT `fk_studentlife_dining_transaction_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ADD CONSTRAINT `fk_studentlife_health_visit_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ADD CONSTRAINT `fk_studentlife_student_org_third_party_contract_id` FOREIGN KEY (`third_party_contract_id`) REFERENCES `education_ecm`.`billing`.`third_party_contract`(`third_party_contract_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `education_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_sponsor_invoice_id` FOREIGN KEY (`sponsor_invoice_id`) REFERENCES `education_ecm`.`billing`.`sponsor_invoice`(`sponsor_invoice_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ADD CONSTRAINT `fk_studentlife_conduct_sanction_account_hold_id` FOREIGN KEY (`account_hold_id`) REFERENCES `education_ecm`.`billing`.`account_hold`(`account_hold_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ADD CONSTRAINT `fk_studentlife_conduct_sanction_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_tuition_charge_id` FOREIGN KEY (`tuition_charge_id`) REFERENCES `education_ecm`.`billing`.`tuition_charge`(`tuition_charge_id`);
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ADD CONSTRAINT `fk_studentlife_wellness_participation_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `education_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ADD CONSTRAINT `fk_studentlife_wellness_participation_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);

-- ========= studentlife --> curriculum (2 constraint(s)) =========
-- Requires: studentlife schema, curriculum schema
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ADD CONSTRAINT `fk_studentlife_llc_program_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);

-- ========= studentlife --> enrollment (17 constraint(s)) =========
-- Requires: studentlife schema, enrollment schema
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ADD CONSTRAINT `fk_studentlife_studentlife_housing_assignment_enrollment_application_id` FOREIGN KEY (`enrollment_application_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_application`(`enrollment_application_id`);
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ADD CONSTRAINT `fk_studentlife_studentlife_housing_assignment_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ADD CONSTRAINT `fk_studentlife_housing_application_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ADD CONSTRAINT `fk_studentlife_housing_application_enrollment_application_id` FOREIGN KEY (`enrollment_application_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_application`(`enrollment_application_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ADD CONSTRAINT `fk_studentlife_dining_enrollment_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ADD CONSTRAINT `fk_studentlife_dining_transaction_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ADD CONSTRAINT `fk_studentlife_counseling_case_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ADD CONSTRAINT `fk_studentlife_event_attendance_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ADD CONSTRAINT `fk_studentlife_conduct_case_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ADD CONSTRAINT `fk_studentlife_wellness_program_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ADD CONSTRAINT `fk_studentlife_wellness_participation_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ADD CONSTRAINT `fk_studentlife_roommate_group_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ADD CONSTRAINT `fk_studentlife_housing_waitlist_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ADD CONSTRAINT `fk_studentlife_housing_waitlist_enrollment_application_id` FOREIGN KEY (`enrollment_application_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_application`(`enrollment_application_id`);
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ADD CONSTRAINT `fk_studentlife_llc_enrollment_enrollment_application_id` FOREIGN KEY (`enrollment_application_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_application`(`enrollment_application_id`);
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ADD CONSTRAINT `fk_studentlife_llc_enrollment_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);

-- ========= studentlife --> facility (10 constraint(s)) =========
-- Requires: studentlife schema, facility schema
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ADD CONSTRAINT `fk_studentlife_residence_hall_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ADD CONSTRAINT `fk_studentlife_dining_transaction_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ADD CONSTRAINT `fk_studentlife_health_visit_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ADD CONSTRAINT `fk_studentlife_counseling_case_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ADD CONSTRAINT `fk_studentlife_housing_waitlist_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ADD CONSTRAINT `fk_studentlife_health_appointment_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_contract` ADD CONSTRAINT `fk_studentlife_housing_contract_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_contract` ADD CONSTRAINT `fk_studentlife_housing_contract_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);

-- ========= studentlife --> faculty (4 constraint(s)) =========
-- Requires: studentlife schema, faculty schema
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ADD CONSTRAINT `fk_studentlife_student_org_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ADD CONSTRAINT `fk_studentlife_llc_program_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ADD CONSTRAINT `fk_studentlife_llc_enrollment_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);

-- ========= studentlife --> finance (16 constraint(s)) =========
-- Requires: studentlife schema, finance schema
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ADD CONSTRAINT `fk_studentlife_studentlife_housing_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ADD CONSTRAINT `fk_studentlife_studentlife_housing_assignment_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ADD CONSTRAINT `fk_studentlife_housing_application_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ADD CONSTRAINT `fk_studentlife_dining_enrollment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ADD CONSTRAINT `fk_studentlife_dining_enrollment_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ADD CONSTRAINT `fk_studentlife_dining_transaction_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ADD CONSTRAINT `fk_studentlife_health_visit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ADD CONSTRAINT `fk_studentlife_health_visit_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ADD CONSTRAINT `fk_studentlife_student_org_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ADD CONSTRAINT `fk_studentlife_student_org_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ADD CONSTRAINT `fk_studentlife_wellness_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ADD CONSTRAINT `fk_studentlife_wellness_program_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ADD CONSTRAINT `fk_studentlife_llc_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= studentlife --> hr (22 constraint(s)) =========
-- Requires: studentlife schema, hr schema
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ADD CONSTRAINT `fk_studentlife_studentlife_housing_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ADD CONSTRAINT `fk_studentlife_housing_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ADD CONSTRAINT `fk_studentlife_dining_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ADD CONSTRAINT `fk_studentlife_health_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ADD CONSTRAINT `fk_studentlife_immunization_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ADD CONSTRAINT `fk_studentlife_counseling_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ADD CONSTRAINT `fk_studentlife_event_attendance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ADD CONSTRAINT `fk_studentlife_conduct_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ADD CONSTRAINT `fk_studentlife_conduct_sanction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ADD CONSTRAINT `fk_studentlife_conduct_sanction_tertiary_conduct_waived_by_staff_employee_id` FOREIGN KEY (`tertiary_conduct_waived_by_staff_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ADD CONSTRAINT `fk_studentlife_cocurricular_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ADD CONSTRAINT `fk_studentlife_cocurricular_record_last_modified_by_staff_employee_id` FOREIGN KEY (`last_modified_by_staff_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ADD CONSTRAINT `fk_studentlife_wellness_participation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ADD CONSTRAINT `fk_studentlife_housing_waitlist_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ADD CONSTRAINT `fk_studentlife_llc_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ADD CONSTRAINT `fk_studentlife_llc_program_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ADD CONSTRAINT `fk_studentlife_llc_program_primary_llc_employee_id` FOREIGN KEY (`primary_llc_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ADD CONSTRAINT `fk_studentlife_llc_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ADD CONSTRAINT `fk_studentlife_health_appointment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= studentlife --> research (1 constraint(s)) =========
-- Requires: studentlife schema, research schema
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_irb_protocol_id` FOREIGN KEY (`irb_protocol_id`) REFERENCES `education_ecm`.`research`.`irb_protocol`(`irb_protocol_id`);

-- ========= studentlife --> student (22 constraint(s)) =========
-- Requires: studentlife schema, student schema
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ADD CONSTRAINT `fk_studentlife_studentlife_housing_assignment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ADD CONSTRAINT `fk_studentlife_housing_application_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ADD CONSTRAINT `fk_studentlife_housing_application_quaternary_housing_roommate_preference_3_student_profile_id` FOREIGN KEY (`quaternary_housing_roommate_preference_3_student_profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ADD CONSTRAINT `fk_studentlife_housing_application_tertiary_housing_roommate_preference_2_student_profile_id` FOREIGN KEY (`tertiary_housing_roommate_preference_2_student_profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ADD CONSTRAINT `fk_studentlife_dining_enrollment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ADD CONSTRAINT `fk_studentlife_dining_transaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ADD CONSTRAINT `fk_studentlife_health_visit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ADD CONSTRAINT `fk_studentlife_immunization_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ADD CONSTRAINT `fk_studentlife_counseling_case_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ADD CONSTRAINT `fk_studentlife_student_org_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ADD CONSTRAINT `fk_studentlife_org_membership_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ADD CONSTRAINT `fk_studentlife_event_attendance_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ADD CONSTRAINT `fk_studentlife_conduct_case_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ADD CONSTRAINT `fk_studentlife_conduct_sanction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ADD CONSTRAINT `fk_studentlife_cocurricular_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ADD CONSTRAINT `fk_studentlife_wellness_participation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ADD CONSTRAINT `fk_studentlife_roommate_group_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ADD CONSTRAINT `fk_studentlife_housing_waitlist_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ADD CONSTRAINT `fk_studentlife_llc_enrollment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ADD CONSTRAINT `fk_studentlife_health_appointment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_contract` ADD CONSTRAINT `fk_studentlife_housing_contract_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= studentlife --> technology (19 constraint(s)) =========
-- Requires: studentlife schema, technology schema
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ADD CONSTRAINT `fk_studentlife_dining_transaction_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `education_ecm`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ADD CONSTRAINT `fk_studentlife_health_visit_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ADD CONSTRAINT `fk_studentlife_immunization_record_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ADD CONSTRAINT `fk_studentlife_counseling_case_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ADD CONSTRAINT `fk_studentlife_student_org_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `education_ecm`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ADD CONSTRAINT `fk_studentlife_org_membership_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `education_ecm`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ADD CONSTRAINT `fk_studentlife_event_attendance_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ADD CONSTRAINT `fk_studentlife_conduct_case_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `education_ecm`.`technology`.`incident`(`incident_id`);
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ADD CONSTRAINT `fk_studentlife_cocurricular_record_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `education_ecm`.`technology`.`service_request`(`service_request_id`);
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ADD CONSTRAINT `fk_studentlife_wellness_participation_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ADD CONSTRAINT `fk_studentlife_wellness_participation_modified_by_user_identity_account_id` FOREIGN KEY (`modified_by_user_identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ADD CONSTRAINT `fk_studentlife_roommate_group_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ADD CONSTRAINT `fk_studentlife_roommate_group_last_modified_by_user_identity_account_id` FOREIGN KEY (`last_modified_by_user_identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ADD CONSTRAINT `fk_studentlife_llc_program_identity_account_id` FOREIGN KEY (`identity_account_id`) REFERENCES `education_ecm`.`technology`.`identity_account`(`identity_account_id`);
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` ADD CONSTRAINT `fk_studentlife_hall_service_provision_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `education_ecm`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `education_ecm`.`studentlife`.`org_application_access` ADD CONSTRAINT `fk_studentlife_org_application_access_enterprise_application_id` FOREIGN KEY (`enterprise_application_id`) REFERENCES `education_ecm`.`technology`.`enterprise_application`(`enterprise_application_id`);

-- ========= technology --> athletics (4 constraint(s)) =========
-- Requires: technology schema, athletics schema
ALTER TABLE `education_ecm`.`technology`.`network_device` ADD CONSTRAINT `fk_technology_network_device_athletic_facility_id` FOREIGN KEY (`athletic_facility_id`) REFERENCES `education_ecm`.`athletics`.`athletic_facility`(`athletic_facility_id`);
ALTER TABLE `education_ecm`.`technology`.`it_project` ADD CONSTRAINT `fk_technology_it_project_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ADD CONSTRAINT `fk_technology_it_service_outage_athletic_facility_id` FOREIGN KEY (`athletic_facility_id`) REFERENCES `education_ecm`.`athletics`.`athletic_facility`(`athletic_facility_id`);
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ADD CONSTRAINT `fk_technology_it_chargeback_team_id` FOREIGN KEY (`team_id`) REFERENCES `education_ecm`.`athletics`.`team`(`team_id`);

-- ========= technology --> compliance (1 constraint(s)) =========
-- Requires: technology schema, compliance schema
ALTER TABLE `education_ecm`.`technology`.`it_risk` ADD CONSTRAINT `fk_technology_it_risk_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `education_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);

-- ========= technology --> facility (2 constraint(s)) =========
-- Requires: technology schema, facility schema
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ADD CONSTRAINT `fk_technology_it_asset_lifecycle_event_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ADD CONSTRAINT `fk_technology_it_asset_lifecycle_event_prior_location_building_id` FOREIGN KEY (`prior_location_building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);

-- ========= technology --> finance (11 constraint(s)) =========
-- Requires: technology schema, finance schema
ALTER TABLE `education_ecm`.`technology`.`it_asset` ADD CONSTRAINT `fk_technology_it_asset_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `education_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `education_ecm`.`technology`.`it_asset` ADD CONSTRAINT `fk_technology_it_asset_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `education_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ADD CONSTRAINT `fk_technology_it_asset_lifecycle_event_finance_vendor_id` FOREIGN KEY (`finance_vendor_id`) REFERENCES `education_ecm`.`finance`.`finance_vendor`(`finance_vendor_id`);
ALTER TABLE `education_ecm`.`technology`.`it_project` ADD CONSTRAINT `fk_technology_it_project_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`technology`.`it_contract` ADD CONSTRAINT `fk_technology_it_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`technology`.`it_contract` ADD CONSTRAINT `fk_technology_it_contract_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`technology`.`it_contract` ADD CONSTRAINT `fk_technology_it_contract_finance_vendor_id` FOREIGN KEY (`finance_vendor_id`) REFERENCES `education_ecm`.`finance`.`finance_vendor`(`finance_vendor_id`);
ALTER TABLE `education_ecm`.`technology`.`it_contract` ADD CONSTRAINT `fk_technology_it_contract_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ADD CONSTRAINT `fk_technology_it_chargeback_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ADD CONSTRAINT `fk_technology_it_chargeback_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ADD CONSTRAINT `fk_technology_it_chargeback_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);

-- ========= technology --> hr (40 constraint(s)) =========
-- Requires: technology schema, hr schema
ALTER TABLE `education_ecm`.`technology`.`it_asset` ADD CONSTRAINT `fk_technology_it_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ADD CONSTRAINT `fk_technology_it_asset_lifecycle_event_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ADD CONSTRAINT `fk_technology_it_asset_lifecycle_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ADD CONSTRAINT `fk_technology_it_asset_lifecycle_event_quaternary_it_custody_transfer_acknowledged_by_employee_id` FOREIGN KEY (`quaternary_it_custody_transfer_acknowledged_by_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ADD CONSTRAINT `fk_technology_it_asset_lifecycle_event_quinary_it_approved_by_employee_id` FOREIGN KEY (`quinary_it_approved_by_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`it_asset_lifecycle_event` ADD CONSTRAINT `fk_technology_it_asset_lifecycle_event_tertiary_it_assigned_to_employee_id` FOREIGN KEY (`tertiary_it_assigned_to_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`identity_account` ADD CONSTRAINT `fk_technology_identity_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`access_entitlement` ADD CONSTRAINT `fk_technology_access_entitlement_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ADD CONSTRAINT `fk_technology_access_provisioning_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ADD CONSTRAINT `fk_technology_access_provisioning_event_quaternary_access_sod_exception_approved_by_employee_id` FOREIGN KEY (`quaternary_access_sod_exception_approved_by_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`access_provisioning_event` ADD CONSTRAINT `fk_technology_access_provisioning_event_tertiary_access_executed_by_employee_id` FOREIGN KEY (`tertiary_access_executed_by_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`service_request` ADD CONSTRAINT `fk_technology_service_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`service_request` ADD CONSTRAINT `fk_technology_service_request_tertiary_service_assigned_technician_employee_id` FOREIGN KEY (`tertiary_service_assigned_technician_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`incident` ADD CONSTRAINT `fk_technology_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`incident` ADD CONSTRAINT `fk_technology_incident_incident_employee_id` FOREIGN KEY (`incident_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`change_request` ADD CONSTRAINT `fk_technology_change_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`cybersecurity_incident` ADD CONSTRAINT `fk_technology_cybersecurity_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`it_project` ADD CONSTRAINT `fk_technology_it_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`it_project` ADD CONSTRAINT `fk_technology_it_project_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`technology`.`it_project` ADD CONSTRAINT `fk_technology_it_project_tertiary_it_business_sponsor_employee_id` FOREIGN KEY (`tertiary_it_business_sponsor_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`it_service` ADD CONSTRAINT `fk_technology_it_service_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`it_service` ADD CONSTRAINT `fk_technology_it_service_primary_it_modified_by_employee_id` FOREIGN KEY (`primary_it_modified_by_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`it_service_outage` ADD CONSTRAINT `fk_technology_it_service_outage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`it_contract` ADD CONSTRAINT `fk_technology_it_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`it_contract` ADD CONSTRAINT `fk_technology_it_contract_primary_it_relationship_manager_employee_id` FOREIGN KEY (`primary_it_relationship_manager_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`it_risk` ADD CONSTRAINT `fk_technology_it_risk_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`it_risk` ADD CONSTRAINT `fk_technology_it_risk_primary_it_employee_id` FOREIGN KEY (`primary_it_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`it_sla_record` ADD CONSTRAINT `fk_technology_it_sla_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ADD CONSTRAINT `fk_technology_it_chargeback_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`it_policy` ADD CONSTRAINT `fk_technology_it_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`it_policy` ADD CONSTRAINT `fk_technology_it_policy_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`it_policy` ADD CONSTRAINT `fk_technology_it_policy_primary_it_employee_id` FOREIGN KEY (`primary_it_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`approval_workflow` ADD CONSTRAINT `fk_technology_approval_workflow_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`technology`.`access_certification` ADD CONSTRAINT `fk_technology_access_certification_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`access_certification` ADD CONSTRAINT `fk_technology_access_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`access_certification` ADD CONSTRAINT `fk_technology_access_certification_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`technology`.`knowledge_article` ADD CONSTRAINT `fk_technology_knowledge_article_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`knowledge_article` ADD CONSTRAINT `fk_technology_knowledge_article_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `education_ecm`.`hr`.`org_unit`(`org_unit_id`);
ALTER TABLE `education_ecm`.`technology`.`knowledge_article` ADD CONSTRAINT `fk_technology_knowledge_article_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);
ALTER TABLE `education_ecm`.`technology`.`knowledge_article` ADD CONSTRAINT `fk_technology_knowledge_article_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `education_ecm`.`hr`.`employee`(`employee_id`);

-- ========= technology --> research (1 constraint(s)) =========
-- Requires: technology schema, research schema
ALTER TABLE `education_ecm`.`technology`.`it_chargeback` ADD CONSTRAINT `fk_technology_it_chargeback_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);

-- ========= technology --> student (1 constraint(s)) =========
-- Requires: technology schema, student schema
ALTER TABLE `education_ecm`.`technology`.`identity_account` ADD CONSTRAINT `fk_technology_identity_account_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

