alter table action disable trigger all;
alter table action_type disable trigger all;
alter table addr disable trigger all;
alter table addr_part disable trigger all;
alter table addr_part_type disable trigger all;
alter table alert disable trigger all;
alter table alert_type disable trigger all;
alter table alert_type_member disable trigger all;
alter table alert_type_rule disable trigger all;
alter table alerted disable trigger all;
alter table at_type disable trigger all;
alter table at_type_member disable trigger all;
alter table attr_action disable trigger all;
alter table attr_action_meta disable trigger all;
alter table attr_action_val disable trigger all;
alter table attr_category disable trigger all;
alter table attr_category_meta disable trigger all;
alter table attr_category_val disable trigger all;
alter table attr_element_type disable trigger all;
alter table attr_element_type_meta disable trigger all;
alter table attr_element_type_val disable trigger all;
alter table attr_field_type disable trigger all;
alter table attr_field_type_meta disable trigger all;
alter table attr_field_type_val disable trigger all;
alter table attr_grp disable trigger all;
alter table attr_grp_meta disable trigger all;
alter table attr_grp_val disable trigger all;
alter table attr_member disable trigger all;
alter table attr_member_meta disable trigger all;
alter table attr_member_val disable trigger all;
alter table category disable trigger all;
alter table category_member disable trigger all;
alter table class disable trigger all;
alter table contact disable trigger all;
alter table contact_value disable trigger all;
alter table contrib_type_member disable trigger all;
alter table desk disable trigger all;
alter table desk_member disable trigger all;
alter table dest_member disable trigger all;
alter table element_type disable trigger all;
alter table element_type__output_channel disable trigger all;
alter table element_type__site disable trigger all;
alter table element_type_member disable trigger all;
alter table event disable trigger all;
alter table event_attr disable trigger all;
alter table event_type disable trigger all;
alter table event_type_attr disable trigger all;
alter table field_type disable trigger all;
alter table grp disable trigger all;
alter table grp_member disable trigger all;
alter table grp_priv disable trigger all;
alter table job disable trigger all;
alter table job_member disable trigger all;
alter table keyword disable trigger all;
alter table keyword_member disable trigger all;
alter table media disable trigger all;
alter table media__contributor disable trigger all;
alter table media_element disable trigger all;
alter table media_field disable trigger all;
alter table media_fields disable trigger all;
alter table media_instance disable trigger all;
alter table media_member disable trigger all;
alter table media_type disable trigger all;
alter table media_type_ext disable trigger all;
alter table media_type_member disable trigger all;
alter table media_uri disable trigger all;
alter table member disable trigger all;
alter table org disable trigger all;
alter table org_member disable trigger all;
alter table output_channel disable trigger all;
alter table output_channel_include disable trigger all;
alter table output_channel_member disable trigger all;
alter table person disable trigger all;
alter table person_member disable trigger all;
alter table person_org disable trigger all;
alter table pref disable trigger all;
alter table pref_member disable trigger all;
alter table resource disable trigger all;
alter table server disable trigger all;
alter table server_type disable trigger all;
alter table site disable trigger all;
alter table site_member disable trigger all;
alter table source disable trigger all;
alter table source_member disable trigger all;
alter table story disable trigger all;
alter table story__category disable trigger all;
alter table story__contributor disable trigger all;
alter table story_element disable trigger all;
alter table story_field disable trigger all;
alter table story_instance disable trigger all;
alter table story_member disable trigger all;
alter table story_uri disable trigger all;
alter table subelement_type disable trigger all;
alter table template disable trigger all;
alter table template_instance disable trigger all;
alter table template_member disable trigger all;
alter table user_member disable trigger all;
alter table usr disable trigger all;
alter table usr_pref disable trigger all;
alter table workflow disable trigger all;
alter table workflow_member disable trigger all;
alter table server_type__output_channel disable trigger all;
alter table story__output_channel disable trigger all;
alter table story__resource disable trigger all;
alter table job__server_type disable trigger all;
alter table job__resource disable trigger all;

delete from action where id > 0;
delete from action_type where id > 5;
delete from addr where id > 0;
delete from addr_part where id > 0;
delete from addr_part_type where id > 5;
delete from alert where id > 0;
delete from alert_type where id > 0;
delete from alert_type_member where id > 0;
delete from alert_type_rule where id > 0;
delete from alerted where id > 0;
delete from at_type where id > 0;
delete from at_type_member where id > 0;
delete from attr_action where id > 0;
delete from attr_action_meta where id > 0;
delete from attr_action_val where id > 0;
delete from attr_category where id > 0;
delete from attr_category_meta where id > 0;
delete from attr_category_val where id > 0;
delete from attr_element_type where id > 0;
delete from attr_element_type_meta where id > 0;
delete from attr_element_type_val where id > 0;
delete from attr_field_type where id > 0;
delete from attr_field_type_meta where id > 0;
delete from attr_field_type_val where id > 0;
delete from attr_grp where id > 1;
delete from attr_grp_meta where id > 9;
delete from attr_grp_val where id > 2;
delete from attr_member where id > 0;
delete from attr_member_meta where id > 0;
delete from attr_member_val where id > 0;
delete from category where id > 1;
delete from category_member where id > 2;
delete from class where id > 81;
delete from contact where id > 14;
delete from contact_value where id > 0;
delete from contrib_type_member where id > 3;
delete from desk where id > 107;
delete from desk_member where id > 127;
delete from dest_member where id > 0;
delete from element_type where id > 13;
delete from element_type__output_channel where id > 14;
delete from element_type__site where id > 1029;
delete from element_type_member where id > 23;
delete from event where id > 515;
delete from event_attr where id > 0;
delete from event_type where id > 1176;
delete from event_type_attr where id > 1062;
delete from field_type where id > 24;
delete from grp where id > 205;
delete from grp_member where id > 705;
delete from grp_priv where id > 60;
delete from job where id > 0;
delete from job_member where id > 0;
delete from keyword where id > 0;
delete from keyword_member where id > 0;
delete from media where id > 0;
delete from media__contributor where id > 0;
delete from media_element where id > 0;
delete from media_field where id > 0;
delete from media_fields where id > 4;
delete from media_instance where id > 0;
delete from media_member where id > 0;
delete from media_type where id > 92;
delete from media_type_ext where id > 131;
delete from media_type_member where id > 892;
delete from media_uri where id > 0;
delete from member where id > 904;
delete from org where id > 1;
delete from org_member where id > 1;
delete from output_channel where id > 1;
delete from output_channel_include where id > 0;
delete from output_channel_member where id > 1;
delete from person where id > 0;
delete from person_member where id > 0;
delete from person_org where id > 0;
delete from pref where id > 18;
delete from pref_member where id > 18;
delete from resource where id > 0;
delete from server where id > 0;
delete from server_type where id > 0;
delete from site where id > 100;
delete from site_member where id > 1;
delete from source where id > 1;
delete from source_member where id > 1;
delete from story where id > 0;
delete from story__category where id > 0;
delete from story__contributor where id > 0;
delete from story_element where id > 0;
delete from story_field where id > 0;
delete from story_instance where id > 0;
delete from story_member where id > 0;
delete from story_uri where id > 0;
delete from subelement_type where id > 10;
delete from template where id > 515;
delete from template_instance where id > 514;
delete from template_member where id > 526;
delete from user_member where id > 1;
delete from usr where id > 0;
delete from usr_pref where id > 0;
delete from workflow where id > 103;
delete from workflow_member where id > 3;
delete from server_type__output_channel;
delete from story__output_channel;
delete from story__resource;
delete from job__server_type;
delete from job__resource;

select setval('seq_at_type', 1024);
select setval('seq_at_type_member', 1024);
select setval('seq_media', 1024);
select setval('seq_media_instance', 1024);
select setval('seq_media__contributor', 1024);
select setval('seq_media_member', 1024);
select setval('seq_media_fields', 1024);
select setval('seq_media_uri', 1024);
select setval('seq_story', 1024);
select setval('seq_story_instance', 1024);
select setval('seq_story__category', 1024);
select setval('seq_story__contributor', 1024);
select setval('seq_story_uri', 1024);
select setval('seq_template', 1024);
select setval('seq_template_instance', 1024);
select setval('seq_template_member', 1024);
select setval('seq_category', 1024);
select setval('seq_category_member', 1024);
select setval('seq_attr_category', 1024);
select setval('seq_attr_category_val', 1024);
select setval('seq_attr_category_meta', 1024);
select setval('seq_contact', 1024);
select setval('seq_contact_value', 1024);
select setval('seq_story_element', 1024);
select setval('seq_media_element', 1024);
select setval('seq_story_field', 1024);
select setval('seq_media_field', 1024);
select setval('seq_element_type', 1024);
select setval('seq_subelement_type', 1024);
select setval('seq_element_type__output_channel', 1024);
select setval('seq_element__language', 1024);
select setval('seq_element_type_member', 1024);
select setval('seq_attr_element_type', 1024);
select setval('seq_attr_element_type_val', 1024);
select setval('seq_attr_element_type_meta', 1024);
select setval('seq_element_type__site', 1024);
select setval('seq_field_type', 1024);
select setval('seq_attr_field_type', 1024);
select setval('seq_attr_field_type_val', 1024);
select setval('seq_attr_field_type_meta', 1024);
select setval('seq_keyword', 1024);
select setval('seq_keyword_member', 1024);
select setval('seq_org', 1024);
select setval('seq_addr', 1024);
select setval('seq_addr_part', 1024);
select setval('seq_addr_part_type', 1024);
select setval('seq_person_org', 1024);
select setval('seq_source', 1024);
select setval('seq_output_channel', 1024);
select setval('seq_output_channel_include', 1024);
select setval('seq_output_channel_member', 1024);
select setval('seq_person', 1024);
select setval('seq_person_member', 1024);
select setval('seq_site_member', 1024);
select setval('seq_workflow', 1024);
select setval('seq_workflow_member', 1024);
select setval('seq_desk', 1024);
select setval('seq_desk_member', 1024);
select setval('seq_action', 1024);
select setval('seq_attr_action', 1024);
select setval('seq_attr_action_val', 1024);
select setval('seq_attr_action_meta', 1024);
select setval('seq_action_type', 1024);
select setval('seq_resource', 1024);
select setval('seq_server', 1024);
select setval('seq_server_type', 1024);
select setval('seq_dest_member', 1024);
select setval('seq_alert', 1024);
select setval('seq_alert_type', 1024);
select setval('seq_alert_type_rule', 1024);
select setval('seq_alerted', 1024);
select setval('seq_class', 1024);
select setval('seq_event', 1024);
select setval('seq_event_attr', 1024);
select setval('seq_event_type', 1024);
select setval('seq_event_type_attr', 1024);
select setval('seq_grp', 1024);
select setval('seq_alert_type_member', 1024);
select setval('seq_contrib_type_member', 1024);
select setval('seq_org_member', 1024);
select setval('seq_grp_member', 1024);
select setval('seq_member', 1024);
select setval('seq_story_member', 1024);
select setval('seq_attr_member', 1024);
select setval('seq_attr_member_val', 1024);
select setval('seq_attr_member_meta', 1024);
select setval('seq_source_member', 1024);
select setval('seq_user_member', 1024);
select setval('seq_attr_grp', 1024);
select setval('seq_attr_grp_val', 1024);
select setval('seq_attr_grp_meta', 1024);
select setval('seq_job', 1024);
select setval('seq_job_member', 1024);
select setval('seq_media_type', 1024);
select setval('seq_media_type_ext', 1024);
select setval('seq_media_type_member', 1024);
select setval('seq_pref', 1024);
select setval('seq_usr_pref', 1024);
select setval('seq_pref_member', 1024);
select setval('seq_priv', 1024);

alter table action enable trigger all;
alter table action_type enable trigger all;
alter table addr enable trigger all;
alter table addr_part enable trigger all;
alter table addr_part_type enable trigger all;
alter table alert enable trigger all;
alter table alert_type enable trigger all;
alter table alert_type_member enable trigger all;
alter table alert_type_rule enable trigger all;
alter table alerted enable trigger all;
alter table at_type enable trigger all;
alter table at_type_member enable trigger all;
alter table attr_action enable trigger all;
alter table attr_action_meta enable trigger all;
alter table attr_action_val enable trigger all;
alter table attr_category enable trigger all;
alter table attr_category_meta enable trigger all;
alter table attr_category_val enable trigger all;
alter table attr_element_type enable trigger all;
alter table attr_element_type_meta enable trigger all;
alter table attr_element_type_val enable trigger all;
alter table attr_field_type enable trigger all;
alter table attr_field_type_meta enable trigger all;
alter table attr_field_type_val enable trigger all;
alter table attr_grp enable trigger all;
alter table attr_grp_meta enable trigger all;
alter table attr_grp_val enable trigger all;
alter table attr_member enable trigger all;
alter table attr_member_meta enable trigger all;
alter table attr_member_val enable trigger all;
alter table category enable trigger all;
alter table category_member enable trigger all;
alter table class enable trigger all;
alter table contact enable trigger all;
alter table contact_value enable trigger all;
alter table contrib_type_member enable trigger all;
alter table desk enable trigger all;
alter table desk_member enable trigger all;
alter table dest_member enable trigger all;
alter table element_type enable trigger all;
alter table element_type__output_channel enable trigger all;
alter table element_type__site enable trigger all;
alter table element_type_member enable trigger all;
alter table event enable trigger all;
alter table event_attr enable trigger all;
alter table event_type enable trigger all;
alter table event_type_attr enable trigger all;
alter table field_type enable trigger all;
alter table grp enable trigger all;
alter table grp_member enable trigger all;
alter table grp_priv enable trigger all;
alter table job enable trigger all;
alter table job_member enable trigger all;
alter table keyword enable trigger all;
alter table keyword_member enable trigger all;
alter table media enable trigger all;
alter table media__contributor enable trigger all;
alter table media_element enable trigger all;
alter table media_field enable trigger all;
alter table media_fields enable trigger all;
alter table media_instance enable trigger all;
alter table media_member enable trigger all;
alter table media_type enable trigger all;
alter table media_type_ext enable trigger all;
alter table media_type_member enable trigger all;
alter table media_uri enable trigger all;
alter table member enable trigger all;
alter table org enable trigger all;
alter table org_member enable trigger all;
alter table output_channel enable trigger all;
alter table output_channel_include enable trigger all;
alter table output_channel_member enable trigger all;
alter table person enable trigger all;
alter table person_member enable trigger all;
alter table person_org enable trigger all;
alter table pref enable trigger all;
alter table pref_member enable trigger all;
alter table resource enable trigger all;
alter table server enable trigger all;
alter table server_type enable trigger all;
alter table site enable trigger all;
alter table site_member enable trigger all;
alter table source enable trigger all;
alter table source_member enable trigger all;
alter table story enable trigger all;
alter table story__category enable trigger all;
alter table story__contributor enable trigger all;
alter table story_element enable trigger all;
alter table story_field enable trigger all;
alter table story_instance enable trigger all;
alter table story_member enable trigger all;
alter table story_uri enable trigger all;
alter table subelement_type enable trigger all;
alter table template enable trigger all;
alter table template_instance enable trigger all;
alter table template_member enable trigger all;
alter table user_member enable trigger all;
alter table usr enable trigger all;
alter table usr_pref enable trigger all;
alter table workflow enable trigger all;
alter table workflow_member enable trigger all;
alter table server_type__output_channel enable trigger all;
alter table story__output_channel enable trigger all;
alter table story__resource enable trigger all;
alter table job__server_type enable trigger all;
alter table job__resource enable trigger all;