set define off;

insert into SECURITY_DOMAIN (DOMAIN_ID, NAME, STATUS, LOGIN_MODULE, AUTH_SYS_ID) values('IDM','IDM','ON-LINE', null,'0');
insert into SECURITY_DOMAIN (DOMAIN_ID, NAME, STATUS, LOGIN_MODULE, AUTH_SYS_ID) values('USR_SEC_DOMAIN','DEFAULT DOMAIN','ON-LINE', null,'0');

update SECURITY_DOMAIN
 SET AUTHENTICATION_POLICY='4001',
     PASSWORD_POLICY='4000',
	 AUDIT_POLICY='4002';

insert into SERVICE (SERVICE_ID, SERVICE_NAME, STATUS) values('USR_SEC_DOMAIN','USER SECURITY DOMAIN','ON-LINE');

insert into LANGUAGE (LANGUAGE_CD, LANGUAGE) VALUES ('en','English');
insert into LANGUAGE (LANGUAGE_CD, LANGUAGE) VALUES ('fr','French');
insert into LANGUAGE (LANGUAGE_CD, LANGUAGE) VALUES ('es','Spanish');
insert into LANGUAGE (LANGUAGE_CD, LANGUAGE) VALUES ('de','German');
insert into LANGUAGE (LANGUAGE_CD, LANGUAGE) VALUES ('it','Italian');
insert into LANGUAGE (LANGUAGE_CD, LANGUAGE) VALUES ('nl','Dutch');
insert into LANGUAGE (LANGUAGE_CD, LANGUAGE) VALUES ('pt','Portugese');

insert into METADATA_TYPE(TYPE_ID, DESCRIPTION) values('OrgOpenIAM','OpenIAM');
insert into METADATA_TYPE(TYPE_ID, DESCRIPTION, SYNC_MANAGED_SYS) values('divisionType','Division', 0);
insert into METADATA_TYPE(TYPE_ID, DESCRIPTION, SYNC_MANAGED_SYS) values('departmentType','Department', 0);
insert into METADATA_TYPE(TYPE_ID, DESCRIPTION, SYNC_MANAGED_SYS) values('MANAGED_SYS','Managed System', 0);
insert into METADATA_TYPE(TYPE_ID, DESCRIPTION, SYNC_MANAGED_SYS) values('SYS_ACTION','System Actions', 0);
insert into METADATA_TYPE(TYPE_ID, DESCRIPTION, SYNC_MANAGED_SYS) values('AUTH_REPO','Authentication Repository', 0);
insert into METADATA_TYPE(TYPE_ID, DESCRIPTION, SYNC_MANAGED_SYS) values('WEBSERVICE','Web Service', 0);
insert into METADATA_TYPE(TYPE_ID, DESCRIPTION, SYNC_MANAGED_SYS) values('WEBSERVICE_OP','Web Service Operation', 0);
insert into METADATA_TYPE(TYPE_ID, DESCRIPTION, SYNC_MANAGED_SYS) values('NO-PROVISION-APP','Un-Provisionable Apps', 0);


insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name) values ('401','MANAGED_SYS','SUBMIT_USER_TO_CONNECTOR');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name) values ('402','MANAGED_SYS','INCLUDE_IN_PASSWORD_SYNC');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name) values ('406','MANAGED_SYS','TABLE_NAME');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name) values ('405','MANAGED_SYS','INCLUDE_IN_SYNC');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name) values ('406','MANAGED_SYS','ON_DELETE');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name) values ('407','MANAGED_SYS','GROUP_MEMBERSHIP_ENABLED');

insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name) values ('411','AUTH_REPO','HOST_URL');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name) values ('412','AUTH_REPO','BASE_DN');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name) values ('413','AUTH_REPO','HOST_LOGIN ID');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name) values ('421','AUTH_REPO','PASSWORD');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name) values ('415','AUTH_REPO','COMMUNICATION_PROTOCOL');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name) values ('416','AUTH_REPO','OBJECT_CLASS');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name) values ('418','AUTH_REPO','SEARCH_ATTRIBUTE');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name) values ('419','AUTH_REPO','MANAGED_SYS_ID');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name) values ('420','AUTH_REPO','DN_ATTRIBUTE');

insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name) values ('430','WEBSERVICE','END_POINT');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name) values ('440','WEBSERVICE_OP','OPERATION_NAME');

insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name) values ('450','NO-PROVISION-APP','URL');


insert into CATEGORY (category_id, parent_id, category_name, show_list) values ('ROLE_TYPE', 'ROOT', 'ROLE Types',0);
insert into CATEGORY (category_id, parent_id, category_name, show_list) values ('GROUP_TYPE', 'ROOT', 'GROUP Types',0);
insert into CATEGORY (category_id, parent_id, category_name, show_list) values ('ORG_TYPE', 'ROOT', 'ORGANIZATION Types',0);
insert into CATEGORY_TYPE (category_id, type_id) values('ORG_TYPE','divisionType');
insert into CATEGORY_TYPE (category_id, type_id) values('ORG_TYPE','departmentType');

insert into METADATA_TYPE(TYPE_ID, DESCRIPTION,SYNC_MANAGED_SYS) values('SystemAccount','System Account type',1);
insert into METADATA_TYPE(TYPE_ID, DESCRIPTION,SYNC_MANAGED_SYS) values('InetOrgPerson','InetOrgPerson user type',1);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,SELF_EDITABLE, SELF_VIEWABLE, UI_TYPE,UI_OBJECT_SIZE) values ('101','InetOrgPerson', 'Display Name',1,1,'TEXT','size=20');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,SELF_EDITABLE, SELF_VIEWABLE, UI_TYPE,UI_OBJECT_SIZE) values ('104','InetOrgPerson', 'Preferred Language',1,1,'TEXT','size=20');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,SELF_EDITABLE, SELF_VIEWABLE, UI_TYPE,UI_OBJECT_SIZE) values ('105','InetOrgPerson', 'VehicleLicense',1,1,'TEXT','size=20');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,SELF_EDITABLE, SELF_VIEWABLE, UI_TYPE,UI_OBJECT_SIZE) values ('106','InetOrgPerson', 'Given Name',1,1,'TEXT','size=20');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,SELF_EDITABLE, SELF_VIEWABLE, UI_TYPE,UI_OBJECT_SIZE) values ('107','InetOrgPerson', 'LabeledURI',1,1,'TEXT','size=20');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,SELF_EDITABLE, SELF_VIEWABLE, UI_TYPE,UI_OBJECT_SIZE) values ('108','InetOrgPerson', 'Initials',1,1,'TEXT','size=20');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,SELF_EDITABLE, SELF_VIEWABLE, UI_TYPE,UI_OBJECT_SIZE) values ('110','InetOrgPerson', 'BusinessCategory',1,1,'TEXT','size=20');

insert into METADATA_TYPE(TYPE_ID, DESCRIPTION,SYNC_MANAGED_SYS) values('Contractor','Contractor user type',1);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,SELF_EDITABLE, SELF_VIEWABLE, UI_TYPE,UI_OBJECT_SIZE) values ('131','Contractor', 'Display Name',1,1,'TEXT','size=20');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,SELF_EDITABLE, SELF_VIEWABLE, UI_TYPE,UI_OBJECT_SIZE) values ('134','Contractor', 'Preferred Language',1,1,'TEXT','size=20');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,SELF_EDITABLE, SELF_VIEWABLE, UI_TYPE,UI_OBJECT_SIZE) values ('135','Contractor', 'VehicleLicense',1,1,'TEXT','size=20');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,SELF_EDITABLE, SELF_VIEWABLE, UI_TYPE,UI_OBJECT_SIZE) values ('136','Contractor', 'Given Name',1,1,'TEXT','size=20');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,SELF_EDITABLE, SELF_VIEWABLE, UI_TYPE,UI_OBJECT_SIZE) values ('137','Contractor', 'LabeledURI',1,1,'TEXT','size=20');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,SELF_EDITABLE, SELF_VIEWABLE, UI_TYPE,UI_OBJECT_SIZE) values ('138','Contractor', 'Initials',1,1,'TEXT','size=20');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,SELF_EDITABLE, SELF_VIEWABLE, UI_TYPE,UI_OBJECT_SIZE) values ('260','Contractor', 'BusinessCategory',1,1,'TEXT','size=20');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,SELF_EDITABLE, SELF_VIEWABLE, UI_TYPE,UI_OBJECT_SIZE) values ('261','Contractor', 'StartDate',1,1,'TEXT','size=20');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,SELF_EDITABLE, SELF_VIEWABLE, UI_TYPE,UI_OBJECT_SIZE) values ('262','Contractor', 'EndDate',1,1,'TEXT','size=20');


insert into METADATA_TYPE(TYPE_ID, DESCRIPTION) values('DIRECTORY','Directory');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name) values ('140','DIRECTORY', 'Display Name');


insert into METADATA_TYPE(TYPE_ID, DESCRIPTION) values('FILE','File');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name) values ('150','FILE', 'Display Name');


insert into METADATA_TYPE(TYPE_ID, DESCRIPTION) values('URL','URL');
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name) values ('160','URL', 'Display Name');

insert into METADATA_TYPE(TYPE_ID, DESCRIPTION,SYNC_MANAGED_SYS) values('LdapOrgPerson','LdapOrgPerson User type',1);
insert into METADATA_TYPE(TYPE_ID, DESCRIPTION,SYNC_MANAGED_SYS) values('ADUser','AD User type',1);
insert into METADATA_TYPE(TYPE_ID, DESCRIPTION,SYNC_MANAGED_SYS) values('ADGroup','AD User type',1);

insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('300','LdapOrgPerson', 'name','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('301','LdapOrgPerson', 'distinguishedName','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('302','LdapOrgPerson', 'objectclass','',1,1);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('303','LdapOrgPerson', 'aliasedObjectName','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('304','LdapOrgPerson', 'cn','',0,1);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('305','LdapOrgPerson', 'sn','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('306','LdapOrgPerson', 'serialNumber','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('307','LdapOrgPerson', 'c','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('308','LdapOrgPerson', 'l','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('309','LdapOrgPerson', 'st','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('310','LdapOrgPerson', 'street','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('311','LdapOrgPerson', 'o','',0,1);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('312','LdapOrgPerson', 'ou','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('313','LdapOrgPerson', 'title','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('314','LdapOrgPerson', 'description','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('341','LdapOrgPerson', 'givenName','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('342','LdapOrgPerson', 'initials','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('348','LdapOrgPerson', 'uid','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('349','LdapOrgPerson', 'mail','',0,0);

insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('315','LdapOrgPerson', 'businessCategory','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('316','LdapOrgPerson', 'postalAddress','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('317','LdapOrgPerson', 'postalCode','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('318','LdapOrgPerson', 'postOfficeBox','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('319','LdapOrgPerson', 'physicalDeliveryOfficeName','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('320','LdapOrgPerson', 'telephoneNumber','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('321','LdapOrgPerson', 'telexNumber','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('322','LdapOrgPerson', 'teletexTerminalIdentifier','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('323','LdapOrgPerson', 'facsimileTelephoneNumber','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('324','LdapOrgPerson', 'x121Address','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('325','LdapOrgPerson', 'internationaliSDNNumber','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('326','LdapOrgPerson', 'registeredAddress','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('327','LdapOrgPerson', 'destinationIndicator','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('328','LdapOrgPerson', 'preferredDeliveryMethod','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('329','LdapOrgPerson', 'presentationAddress','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('330','LdapOrgPerson', 'supportedApplicationContext','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('331','LdapOrgPerson', 'member','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('332','LdapOrgPerson', 'owner','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('333','LdapOrgPerson', 'roleOccupant','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('334','LdapOrgPerson', 'seeAlso','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('335','LdapOrgPerson', 'userPassword','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('336','LdapOrgPerson', 'userCertificate','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('337','LdapOrgPerson', 'cACertificate','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('338','LdapOrgPerson', 'authorityRevocationList','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('339','LdapOrgPerson', 'certificateRevocationList','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('340','LdapOrgPerson', 'crossCertificatePair','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('343','LdapOrgPerson', 'generationQualifier','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('344','LdapOrgPerson', 'x500UniqueIdentifier','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('346','LdapOrgPerson', 'uniqueMember','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('347','LdapOrgPerson', 'houseIdentifier','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('350','LdapOrgPerson', 'ref','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('351','LdapOrgPerson', 'referral','',0,0);
insert into METADATA_ELEMENT(metadata_id, type_id, attribute_name,DESCRIPTION,MULTI_VALUE,REQUIRED) values ('352','LdapOrgPerson', 'krbName','',0,0);




insert into METADATA_TYPE(TYPE_ID, DESCRIPTION) values('AD_Connector','Active Directory Connector');
insert into METADATA_TYPE(TYPE_ID, DESCRIPTION) values('LDAP_Connector','LDAP Connector');
insert into METADATA_TYPE(TYPE_ID, DESCRIPTION) values('RDBMS_Connector','RDBMS Connector');

insert into METADATA_TYPE(TYPE_ID, DESCRIPTION) values('SOAP_Connector','SOAP Connector');
insert into METADATA_TYPE(TYPE_ID, DESCRIPTION) values('SCRIPT_Connector','Script Connector');
insert into METADATA_TYPE(TYPE_ID, DESCRIPTION) values('GOOGLE_Connector','GOOGLE APPS Connector');

UPDATE METADATA_TYPE
SET ACTIVE = 1, SYNC_MANAGED_SYS = 1;

insert into COMPANY(company_id, company_name, status, type_ID, DOMAIN_NAME, CLASSIFICATION) values('100','OpenIAM', 'ACTIVE', 'OrgOpenIAM','openiam.com', 'ORGANIZATION');
insert into COMPANY(company_id, company_name, status, type_ID, CLASSIFICATION, PARENT_ID ) values('101','Sales', 'ACTIVE', 'departmentType', 'DEPARTMENT', '100');
insert into COMPANY(company_id, company_name, status, type_ID, CLASSIFICATION, PARENT_ID) values('102','Finance', 'ACTIVE', 'departmentType', 'DEPARTMENT', '100');
insert into COMPANY(company_id, company_name, status, type_ID, CLASSIFICATION, PARENT_ID) values('103','Customer Service', 'ACTIVE', 'departmentType', 'DEPARTMENT', '100');
insert into COMPANY(company_id, company_name, status, type_ID, CLASSIFICATION, PARENT_ID) values('104','IT', 'ACTIVE', 'departmentType', 'DEPARTMENT', '100');



insert into CATEGORY(CATEGORY_ID, PARENT_ID, CATEGORY_NAME, SHOW_LIST) VALUES('ROOT','', 'ROOT',0);
insert into CATEGORY(CATEGORY_ID, PARENT_ID, CATEGORY_NAME, SHOW_LIST) VALUES('ACL','', 'ACL Root',0);
insert into CATEGORY(CATEGORY_ID, PARENT_ID, CATEGORY_NAME, SHOW_LIST) VALUES('WebSite','', 'ACL',0);
insert into CATEGORY(CATEGORY_ID, PARENT_ID, CATEGORY_NAME, SHOW_LIST) VALUES('Application','', 'ACL',0);
insert into CATEGORY (category_id, parent_id, category_name, show_list) values ('USER_TYPE', 'ROOT', 'User Types',0);
insert into CATEGORY (category_id, parent_id, category_name, show_list,  DISPLAY_ORDER) values ('MANAGED_SYS_TYPE', 'ROOT', 'Managed System Types',0,0);

insert into CATEGORY (category_id, parent_id, category_name, show_list, DISPLAY_ORDER) values ('CONNECTOR_TYPE', 'ROOT', 'Provisioning Connectors',0,0);


insert into CATEGORY_TYPE (category_id, type_ID) values('USER_TYPE','InetOrgPerson');
insert into CATEGORY_TYPE (category_id, type_ID) values('USER_TYPE','Contractor');
insert into CATEGORY_TYPE (category_id, type_ID) values('USER_TYPE','SystemAccount');

insert into CATEGORY_TYPE (category_id, type_ID) values('CONNECTOR_TYPE','AD_Connector');
insert into CATEGORY_TYPE (category_id, type_ID) values('CONNECTOR_TYPE','LDAP_Connector');
insert into CATEGORY_TYPE (category_id, type_ID) values('CONNECTOR_TYPE','RDBMS_Connector');
insert into CATEGORY_TYPE (category_id, type_ID) values('CONNECTOR_TYPE','SOAP_Connector');
insert into CATEGORY_TYPE (category_id, type_ID) values('CONNECTOR_TYPE','SCRIPT_Connector');

insert into CATEGORY_TYPE (category_id, type_ID) values('ACL','DIRECTORY');
insert into CATEGORY_TYPE (category_id, type_id) values('ACL','FILE');
insert into CATEGORY_TYPE (category_id, type_id) values('ACL','URL');

insert into CATEGORY_TYPE (category_id, type_ID) values('MANAGED_SYS_TYPE','LdapOrgPerson');
insert into CATEGORY_TYPE (category_id, type_ID) values('MANAGED_SYS_TYPE','ADUser');
insert into CATEGORY_TYPE (category_id, type_ID) values('MANAGED_SYS_TYPE','ADGroup');


update CATEGORY
SET DISPLAY_ORDER = 0, SHOW_LIST = 0
WHERE DISPLAY_ORDER IS NULL OR SHOW_LIST IS NULL;


INSERT INTO ROLE (ROLE_ID,SERVICE_ID,ROLE_NAME) VALUES ('SUPER_SEC_ADMIN','IDM','Super Security Admin');
INSERT INTO ROLE (ROLE_ID,SERVICE_ID,ROLE_NAME) VALUES ('SEC_ADMIN','IDM','Security Admin');
INSERT INTO ROLE (ROLE_ID,SERVICE_ID,ROLE_NAME) VALUES ('END_USER','USR_SEC_DOMAIN','End User');


INSERT INTO ROLE (ROLE_ID,SERVICE_ID,ROLE_NAME) VALUES ('HR','USR_SEC_DOMAIN','Human Resource');
INSERT INTO ROLE (ROLE_ID,SERVICE_ID,ROLE_NAME) VALUES ('MANAGER','USR_SEC_DOMAIN','Manager');
INSERT INTO ROLE (ROLE_ID,SERVICE_ID,ROLE_NAME) VALUES ('SECURITY_MANAGER','USR_SEC_DOMAIN','Security Manager');
INSERT INTO ROLE (ROLE_ID,SERVICE_ID,ROLE_NAME) VALUES ('SEC_ADMIN','USR_SEC_DOMAIN','Security Admin');

insert into GRP (GRP_id, grp_name)   values('SUPER_SEC_ADMIN_GRP','Super Admin Group');
insert into GRP (grp_id, grp_name)   values('SEC_ADMIN_GRP','Sec Admin Group');
insert into GRP (grp_id, grp_name)   values('END_USER_GRP','End User Group');

insert into GRP (grp_id, grp_name)   values('HR_GRP','HR Group');
insert into GRP (grp_id, grp_name)   values('MNGR_GRP','Manager Group');
insert into GRP (grp_id, grp_name)   values('SECURITY_GRP','Security Group');

insert into USERS (user_id,first_name, last_name, STATUS, COMPANY_ID ) values('3000','sys','','ACTIVE','100');
insert into USERS (user_id,first_name, last_name, STATUS, COMPANY_ID ) values('3001','sys2','','ACTIVE','100');
insert into USERS (user_id,first_name, last_name, STATUS, COMPANY_ID  ) values('3006','Scott','Nelson','ACTIVE','100');

insert into USERS (user_id,first_name, last_name, STATUS, COMPANY_ID  ) values('3007','HR','User','ACTIVE','100');
insert into USERS (user_id,first_name, last_name, STATUS, COMPANY_ID  ) values('3008','Hiring','Manager','ACTIVE','100');
insert into USERS (user_id,first_name, last_name, STATUS, COMPANY_ID  ) values('3009','Security','Manager','ACTIVE','100');



insert into USER_GRP (USER_GRP_ID, grp_id, user_id) 	values('1000','SUPER_SEC_ADMIN_GRP','3000');
insert into USER_GRP (USER_GRP_ID,grp_id, user_id) 	values('1001','SUPER_SEC_ADMIN_GRP','3001');
insert into USER_GRP (USER_GRP_ID,grp_id, user_id) 	values('1002','END_USER_GRP','3006');

insert into USER_GRP (USER_GRP_ID,grp_id, user_id) 	values('1003','HR_GRP','3007');
insert into USER_GRP (USER_GRP_ID,grp_id, user_id) 	values('1004','MNGR_GRP','3008');
insert into USER_GRP (USER_GRP_ID,grp_id, user_id) 	values('1005','SECURITY_GRP','3009');

INSERT INTO GRP_ROLE(ROLE_ID,GRP_ID, SERVICE_ID) VALUES ('SUPER_SEC_ADMIN','SUPER_SEC_ADMIN_GRP', 'IDM');
INSERT INTO GRP_ROLE(ROLE_ID,GRP_ID, SERVICE_ID) VALUES ('END_USER','END_USER_GRP', 'USR_SEC_DOMAIN');

INSERT INTO GRP_ROLE(ROLE_ID,GRP_ID, SERVICE_ID) VALUES ('HR','HR_GRP', 'USR_SEC_DOMAIN');
INSERT INTO GRP_ROLE(ROLE_ID,GRP_ID, SERVICE_ID) VALUES ('MANAGER','MNGR_GRP', 'USR_SEC_DOMAIN');
INSERT INTO GRP_ROLE(ROLE_ID,GRP_ID, SERVICE_ID) VALUES ('SECURITY_MANAGER','SECURITY_GRP', 'USR_SEC_DOMAIN');


insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('ROOT', NULL ,'Root','Root', null, 'en',0);

insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('IDM','ROOT','Identity','IDENTITY MANAGER','security/index.jsp', 'en',1);

insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('IDMAN','IDM','User Admin','User Admin','idman/index.jsp', 'en',1);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('ACC_CONTROL','IDM','Access Control','Access Control','access/accessIndex.do', 'en',2);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, active, display_order) values('PROVISIONING','IDM','Provisioning','Provisioning','prov/provIndex.do', 'en',1,3);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, active, display_order) values('SECURITY_POLICY','IDM','Policy','Policy','security/policy.do?method=init&nav=reset', 'en',1,4);

insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('ADMIN','IDM','Administration','Administration','admin/index.jsp', 'en',6);

insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('USER','IDMAN','User','User','menunav.do', 'en',1);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('ORG','IDMAN','Organization','Organization','orglist.cnt', 'en',2);



insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('QUERYUSER','USER','Query','Query User','idman/userSearch.do?action=view', 'en',1);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('ADDUSER','USER','Add','Add User','newUser.cnt', 'en',2);

insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('USERSUMMARY','QUERYUSER','User Details','User Details','editUser.cnt', 'en',1);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('USERATTR','QUERYUSER','Ext Attributes','Ext Attributes','userAttr.cnt', 'en',2);

insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('USERIDENTITY','QUERYUSER','Identities','User Identities','userIdentity.cnt', 'en',3);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('USERGROUP','QUERYUSER','Group','User Groups','userGroup.cnt', 'en',4);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('USERROLE','QUERYUSER','Role','User Role','userRole.cnt', 'en',5);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('USERORG','QUERYUSER','Affiliations','Affiliations','userOrg.cnt', 'en',6);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('USERHISTORY','QUERYUSER','History','User History','userHistory.cnt', 'en',7);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('USERPSWDRESET','QUERYUSER','Password Reset','Password Reset','resetPassword.cnt', 'en',8);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('DELG_FILTER','QUERYUSER','Delegation Filter','Delegation Filter','userDelegationFilter.cnt', 'en',8);



insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, active, display_order) values('SECURITY_GROUP','ACC_CONTROL','Group','Group','grouplist.cnt', 'en',1,1);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, active, display_order) values('SECURITY_ROLE','ACC_CONTROL','Role','Role','rolelist.cnt', 'en',1,2);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, active, display_order) values('SECURITY_RES','ACC_CONTROL','Resource','Resource','resourcelist.cnt', 'en',1,3);


insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('RESSUMMARY','SECURITY_RES','Resource Details','Resource Details','resourceDetail.cnt', 'en',1);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('RESPOLICYMAP','SECURITY_RES','Policy Map','Policy Map','resourceMap.cnt', 'en',2);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('RESAPPROVER','SECURITY_RES','Approval Flow','Approval Flow','resApprovalFlow.cnt', 'en',3);

/* ROLE MENU */

insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('ROLE_SUMMARY','SECURITY_ROLE','Detail','Role Details','roleDetail.cnt', 'en',1);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('ROLE_RESMAP','SECURITY_ROLE','Resource Map','Resource Map','roleResource.cnt', 'en',2);

	
/* Provisioning MENU options */

insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('PROVCONNECT','PROVISIONING','Connectors','Provisioning Connectors','connectorList.cnt', 'en',3);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('MNGSYS','PROVISIONING','Managed Resource','Managed Connections','managedSysList.cnt', 'en',4);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('SYNCUSER','PROVISIONING','Sychronization','Synchronization','syncUser.cnt', 'en',3);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('SYNCLOG','PROVISIONING','LOG Viewer','LOG Viewer','syncExecLog.cnt', 'en',4);


insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('SYNCDETAIL','SYNCUSER','Configuration','Configuration','syncConfiguration.cnt', 'en',1);


/* Admin MENU options */
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('SECDOMAIN','ADMIN','Security Domain','Security Domain','secDomainList.cnt', 'en',1);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('LOCATION','ADMIN','Location','Location','locationList.cnt', 'en',3);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('CHALLENGE','ADMIN','Challenge Quest','Challenge Quest','challengeQuestList.cnt', 'en',6);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('BATCH_PROC','ADMIN','Batch Processes','Batch Processes','batchList.cnt', 'en',6);



/* Self Service MENU options */
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, display_order) values('SELFSERVICE', 'ROOT' ,'SELF SERVICE','SELF SERVICE','', 'en',0);

insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, display_order, PUBLIC_URL) values('ACCESSCENTER','SELFSERVICE', 'Access Management Center', 'Access Management Center', null, 'en', '1',0);

insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, display_order, PUBLIC_URL) values('REQINBOX', 'ACCESSCENTER' , 'In-Box','In-Box','myPendingRequest.selfserve', 'en','3',0);

insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, display_order, PUBLIC_URL) values('MANAGEREQ', 'ACCESSCENTER' , 'Request History','Request History','requestList.selfserve', 'en','4',0);

insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, display_order, PUBLIC_URL) values('NEWUSER','ACCESSCENTER','New User', 'New User', 'newHire.selfserve', 'en', '6',0);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, display_order, PUBLIC_URL) values('NEWUSER-NOAPPRV','ACCESSCENTER','New User-NO Approver', 'New User-No Approver', 'newUserNoApp.selfserve', 'en', '7',0);

insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, display_order, PUBLIC_URL) values('SELFCENTER','SELFSERVICE','Self Service Center', 'Self Service Center', null, 'en', '2',0);

insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, display_order, PUBLIC_URL) values('DIRECTORY','SELFCENTER','Directory Lookup', 'Directory Lookup', 'pub/directory.do?method=view', 'en', '1',1);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, display_order, PUBLIC_URL) values('CHNGPSWD','SELFCENTER', 'Change Password', 'Change Password', 'passwordChange.selfserve', 'en', '3',0);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, display_order, PUBLIC_URL) values('IDQUEST','SELFCENTER', 'Challenge Response', 'Challenge Response', 'identityQuestion.selfserve', 'en', '4',0);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, display_order, PUBLIC_URL) values('PROFILE','SELFCENTER', 'Edit Your Profile', 'Edit Your Profile', 'profile.selfserve', 'en', '6',0);

insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER, PUBLIC_URL) values('SELF_QUERYUSER','ACCESSCENTER','Manage User','Manage User','idman/userSearch.do?action=view', 'en',1,0);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('SELF_USERSUMMARY','SELF_QUERYUSER','User Details','User Details','editUser.selfserve', 'en',1);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('SELF_USERIDENTITY','SELF_QUERYUSER','Identities','User Identities','userIdentity.selfserve', 'en',2);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('SELF_USERGROUP','SELF_QUERYUSER','Group','User Groups','userGroup.selfserve', 'en',3);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('SELF_USERROLE','SELF_QUERYUSER','Role','User Role','userRole.selfserve', 'en',4);
insert into MENU (menu_id, menu_group, menu_name,menu_desc,url,LANGUAGE_CD, DISPLAY_ORDER) values('SELF_USERPSWDRESET','SELF_QUERYUSER','Password Reset','Password Reset','resetPassword.selfserve', 'en',7);




INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('BATCH_PROC','SUPER_SEC_ADMIN','IDM');




/* service admin role */

INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('IDMAN','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('SECURITY_POLICY','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('ACC_CONTROL','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('PROVISIONING','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('ADMIN','SUPER_SEC_ADMIN','IDM');



INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('SECDOMAIN','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('METADATA','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('LOCATION','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('ORGPOLICY','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('SYSNOTIFICATION','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('CHALLENGE','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('REFDATA','SUPER_SEC_ADMIN','IDM');


INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('ORG','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('USER','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('SYNCUSER','SUPER_SEC_ADMIN','IDM');

INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('SYNCDETAIL','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('SYNCLOG','SUPER_SEC_ADMIN','IDM');


INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('QUERYUSER','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('ADDUSER','SUPER_SEC_ADMIN','IDM');


INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('USERSUMMARY','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('USERIDENTITY','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('USERGROUP','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('USERROLE','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('USERHISTORY','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('USERPSWDRESET','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('DELG_FILTER','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('USERATTR','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('USERORG','SUPER_SEC_ADMIN','IDM');

INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('RESSUMMARY','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('RESPOLICYMAP','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('RESAPPROVER','SUPER_SEC_ADMIN','IDM');


INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('ROLE_SUMMARY','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('ROLE_RESMAP','SUPER_SEC_ADMIN','IDM');


INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('SECURITY_GROUP','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('SECURITY_ROLE','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('SECURITY_RES','SUPER_SEC_ADMIN','IDM');

INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('PROVCONNECT','SUPER_SEC_ADMIN','IDM');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('MNGSYS','SUPER_SEC_ADMIN','IDM');


INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID,SERVICE_ID) VALUES('IDSYNC','SUPER_SEC_ADMIN','IDM');

INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('SELFSERVICE','END_USER','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('ACCESSCENTER','END_USER','USR_SEC_DOMAIN');


INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('REQINBOX','END_USER','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('MANAGEREQ','END_USER','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('SELFCENTER','END_USER','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('DIRECTORY','END_USER','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('CHNGPSWD','END_USER','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('IDQUEST','END_USER','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('PROFILE','END_USER','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('REPORTINC','END_USER','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('CONTADMIN','END_USER','USR_SEC_DOMAIN');

INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('NEWUSER','END_USER','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('NEWUSER-NOAPPRV','END_USER','USR_SEC_DOMAIN');



INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('REQINBOX','SEC_ADMIN','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('MANAGEREQ','SEC_ADMIN','USR_SEC_DOMAIN');

INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('SELF_USERSUMMARY','HELPDESK','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('SELF_USERIDENTITY','HELPDESK','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('SELF_USERGROUP','HELPDESK','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('SELF_USERROLE','HELPDESK','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('SELF_USERPSWDRESET','HELPDESK','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('SELF_QUERYUSER','HELPDESK','USR_SEC_DOMAIN');

INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('SELFSERVICE','HELPDESK','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('ACCESSCENTER','HELPDESK','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('MANAGEREQ','HELPDESK','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('SELFCENTER','HELPDESK','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('DIRECTORY','HELPDESK','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('CHNGPSWD','HELPDESK','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('IDQUEST','HELPDESK','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('PROFILE','HELPDESK','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('CREATEREQ','HELPDESK','USR_SEC_DOMAIN');
INSERT INTO PERMISSIONS(MENU_ID,ROLE_ID, SERVICE_ID) VALUES('NEWUSER','HELPDESK','USR_SEC_DOMAIN');

insert into USERS (user_id,first_name, last_name, STATUS, COMPANY_ID  ) values('3010','Help','Desk','ACTIVE','100');


INSERT INTO ROLE (ROLE_ID,SERVICE_ID,ROLE_NAME) VALUES ('HELPDESK','USR_SEC_DOMAIN','Help Desk');
INSERT INTO USER_ROLE (USER_ROLE_ID, SERVICE_ID, ROLE_ID, USER_ID, STATUS) VALUES('101','USR_SEC_DOMAIN','HELPDESK','3010','ACTIVE');


insert into LOGIN(SERVICE_ID, LOGIN, MANAGED_SYS_ID, USER_ID, PASSWORD,RESET_PWD, IS_LOCKED, AUTH_FAIL_COUNT) VALUES('IDM','sysadmin','0','3000','b83a81d1b3f5f209a70ec02c3d7f7fc5',0,0,0);
insert into LOGIN(SERVICE_ID, LOGIN, MANAGED_SYS_ID, USER_ID, PASSWORD,RESET_PWD, IS_LOCKED, AUTH_FAIL_COUNT) VALUES('USR_SEC_DOMAIN','sysadmin','0','3000','b83a81d1b3f5f209a70ec02c3d7f7fc5',0,0,0);

insert into LOGIN(SERVICE_ID, LOGIN, MANAGED_SYS_ID, USER_ID, PASSWORD,RESET_PWD, IS_LOCKED, AUTH_FAIL_COUNT) VALUES('IDM','sysadmin2','0','3001','b83a81d1b3f5f209a70ec02c3d7f7fc5',0,0,0);
insert into LOGIN(SERVICE_ID, LOGIN, MANAGED_SYS_ID, USER_ID, PASSWORD,RESET_PWD, IS_LOCKED, AUTH_FAIL_COUNT) VALUES('USR_SEC_DOMAIN','snelson','0','3006','b83a81d1b3f5f209a70ec02c3d7f7fc5',0,0,0);

insert into LOGIN(SERVICE_ID, LOGIN, MANAGED_SYS_ID, USER_ID, PASSWORD,RESET_PWD, IS_LOCKED, AUTH_FAIL_COUNT) VALUES('USR_SEC_DOMAIN','hrmanager','0','3007','b83a81d1b3f5f209a70ec02c3d7f7fc5',0,0,0);
insert into LOGIN(SERVICE_ID, LOGIN, MANAGED_SYS_ID, USER_ID, PASSWORD,RESET_PWD, IS_LOCKED, AUTH_FAIL_COUNT) VALUES('USR_SEC_DOMAIN','manager','0','3008','b83a81d1b3f5f209a70ec02c3d7f7fc5',0,0,0);
insert into LOGIN(SERVICE_ID, LOGIN, MANAGED_SYS_ID, USER_ID, PASSWORD,RESET_PWD, IS_LOCKED, AUTH_FAIL_COUNT) VALUES('USR_SEC_DOMAIN','secmanager','0','3009','b83a81d1b3f5f209a70ec02c3d7f7fc5',0,0,0);
insert into LOGIN(SERVICE_ID, LOGIN, MANAGED_SYS_ID, USER_ID, PASSWORD,RESET_PWD, IS_LOCKED, AUTH_FAIL_COUNT) VALUES('USR_SEC_DOMAIN','helpdesk','0','3010','b83a81d1b3f5f209a70ec02c3d7f7fc5',0,0,0);


update LOGIN set reset_pwd = 0, is_locked = 0;


INSERT INTO AUTH_STATE(USER_ID, TOKEN, AUTH_STATE, AA, EXPIRATION) values('3000', NULL,0,'OPENIAM',0);
INSERT INTO AUTH_STATE(USER_ID, TOKEN, AUTH_STATE, AA, EXPIRATION) values('3001', NULL,0,'OPENIAM',0);
INSERT INTO AUTH_STATE(USER_ID, TOKEN, AUTH_STATE, AA, EXPIRATION) values('3006', NULL,0,'OPENIAM',0);

INSERT INTO AUTH_STATE(USER_ID, TOKEN, AUTH_STATE, AA, EXPIRATION) values('3007', NULL,0,'OPENIAM',0);
INSERT INTO AUTH_STATE(USER_ID, TOKEN, AUTH_STATE, AA, EXPIRATION) values('3008', NULL,0,'OPENIAM',0);
INSERT INTO AUTH_STATE(USER_ID, TOKEN, AUTH_STATE, AA, EXPIRATION) values('3009', NULL,0,'OPENIAM',0);

/* Sequence Gen*/
insert into SEQUENCE_GEN (ATTRIBUTE, NEXT_ID) VALUES('USER_ID', '4000');
insert into SEQUENCE_GEN (ATTRIBUTE, NEXT_ID) VALUES('PHONE_ID', '2000');
insert into SEQUENCE_GEN (ATTRIBUTE, NEXT_ID) VALUES('ADDRESS_ID', '2000');
insert into SEQUENCE_GEN (ATTRIBUTE, NEXT_ID) VALUES('EMAIL_ID', '2000');
insert into SEQUENCE_GEN (ATTRIBUTE, NEXT_ID) VALUES('USER_ATTR_ID', '2000');
insert into SEQUENCE_GEN (ATTRIBUTE, NEXT_ID) VALUES('PWD_LOGIN_ID', '2000');
insert into SEQUENCE_GEN (attribute, next_id)	values('RELATION_SET_ID','1000');
insert into SEQUENCE_GEN (attribute, next_id)	values('RELATIONSHIP_ID','1000');

insert into SEQUENCE_GEN (attribute, next_id)	values('METADATA_ID','3000');
insert into SEQUENCE_GEN (attribute, next_id)	values('METADATA_VALUE_ID','2000');
insert into SEQUENCE_GEN (attribute, next_id)	values('METADATA_ELEMENT_ID','2000');

insert into SEQUENCE_GEN (attribute, next_id)	values('CATEGORY_ID','3000');

insert into SEQUENCE_GEN (attribute, next_id)	values('COMPANY_ID','2000');
insert into SEQUENCE_GEN (attribute, next_id)	values('COMPANY_ATTR_ID','2000');
insert into SEQUENCE_GEN (attribute, next_id)	values('ATTACHMENT_ID','2000');

insert into SEQUENCE_GEN (attribute, next_id)	values('IMAGE_ID','2000');
insert into SEQUENCE_GEN (attribute, next_id)	values('ROLE_ID','1003');
insert into SEQUENCE_GEN (attribute, next_id)	values('GRP_ID','4105');
insert into SEQUENCE_GEN (attribute, next_id)	values('GRP_ATTR_ID','1000');
insert into SEQUENCE_GEN (attribute, next_id)	values('MENU_ID','5000');
insert into SEQUENCE_GEN (attribute, next_id)	values('POLICY_ID','5000');
insert into SEQUENCE_GEN (attribute, next_id)	values('POLICY_ATTR_ID','6004');
insert into SEQUENCE_GEN (attribute, next_id)	values('POLICY_MEMBER_ID',6000);

INSERT INTO SEQUENCE_GEN (ATTRIBUTE,NEXT_ID) 	VALUES('TYPE_ID','1013');
insert into SEQUENCE_GEN (attribute, next_id)	values('PARENT_ID','1018');
insert into SEQUENCE_GEN (attribute, next_id)	values('ENTITLEMENT_ID','1003');
insert into SEQUENCE_GEN (attribute,next_id)  values('BOARD_PROPERTY_ID','2004');
insert into SEQUENCE_GEN (attribute,next_id)  values('RESOURCE_ID','2004');
insert into SEQUENCE_GEN (attribute, next_id)	values('ITEM_ID','1000');
insert into SEQUENCE_GEN (attribute, next_id) values('COMPONENT_ID','1000');
insert into SEQUENCE_GEN (attribute, next_id) values('ACCOUNT_ID','1000');
insert into SEQUENCE_GEN (attribute, next_id) values ('RESOURCE_TYPE_ID', '1001');
insert into SEQUENCE_GEN (attribute, next_id) values ('RESOURCE_PROP_ID', '1001');
insert into SEQUENCE_GEN (attribute, next_id) values ('PRIVILEGE_ID', '1001');
insert into SEQUENCE_GEN (attribute, next_id) values('SERVICE_ID','1000');
insert into SEQUENCE_GEN (attribute, next_id) values('DOMAIN_ID','1000');

insert into SEQUENCE_GEN (attribute, next_id) values ('ACCESS_LOG_ID', '1001');
insert into SEQUENCE_GEN (attribute, next_id) values ('NOTE_ID', '1001');

insert into SEQUENCE_GEN (attribute, next_id) values ('QUESTION_ID', '1001');
insert into SEQUENCE_GEN (attribute, next_id) values ('ANSWER_ID', '1001');
insert into SEQUENCE_GEN (attribute, next_id) values ('GRP_ROLE_ID','200');

insert into SEQUENCE_GEN (attribute, next_id) values ('ORG_STRUCTURE_ID','200');
insert into SEQUENCE_GEN (attribute, next_id) values ('LOGIN_ATTR_ID','200');
insert into SEQUENCE_GEN (attribute, next_id) values ('USER_ROLE_ID','200');
insert into SEQUENCE_GEN (attribute, next_id) values ('USER_GRP_ID','200');
insert into SEQUENCE_GEN (attribute, next_id) values ('CONNECTOR_ID','100');
insert into SEQUENCE_GEN (attribute, next_id) values ('MANAGED_SYS_ID','100');



insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'USER', 'PENDING_START_DATE','en','String','PENDING_START_DATE','100', 'IDM');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'USER', 'PENDING_APPROVAL','en','String','PENDING_APPROVAL','100', 'IDM');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'USER', 'ACTIVE','en','String','ACTIVE','100', 'IDM');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'USER', 'INACTIVE','en','String','INACTIVE','100', 'IDM');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'USER', 'DELETED','en','String','DELETED','100', 'IDM');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'USER', 'APPROVAL_DECLINED','en','String','APPROVAL_DECLINED','100', 'IDM');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'USER', 'PENDING_USER_VALIDATION','en','String','PENDING_USER_VALIDATION','100', 'IDM');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'USER', 'PENDING_INITIAL_LOGIN','en','String','PENDING_INITIAL_LOGIN','100', 'IDM');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'USER', 'LEAVE','en','String','LEAVE','100', 'IDM');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'USER', 'TERMINATE','en','String','TERMINATE','100', 'IDM');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'USER', 'RETIRED','en','String','RETIRED','100', 'IDM');


insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'USER_2ND_STATUS', 'LOCKED','en','String','LOCKED','100', 'IDM');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'USER_2ND_STATUS', 'LOCKED_ADMIN','en','String','LOCKED_ADMIN','100', 'IDM');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'USER_2ND_STATUS', 'DISABLED','en','String','DISABLED','100', 'IDM');

insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'OPERATION', 'DL','en','String','DELETE','100', 'IDM');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'OPERATION', 'RJ','en','String','REJECT','100', 'IDM');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'OPERATION', 'BL','en','String','DISABLE','100', 'IDM');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'OPERATION', 'UB','en','String','UN-DISABLE','100', 'IDM');


insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'SERVICE_STATUS', 'READY','en','String','READY','100', 'IDM');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'SERVICE_STATUS', 'OFF-LINE','en','String','OFF-LINE','100', 'IDM');



insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'SERVICE_TYPE', 'AD','en','String','ACTIVE DIRECTORY','100', 'IDM');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'SERVICE_TYPE', 'LDAP','en','String','LDAP','100', 'IDM');

/* JOB CODES*/

insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'JOB_CODE', 'MANAGER','en','String','MANAGER','100', 'USR_SEC_DOMAIN');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'JOB_CODE', 'SECURITY MANAGER','en','String','SECURITY MANAGER','100', 'USR_SEC_DOMAIN');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'JOB_CODE', 'SERVICE REP','en','String','SERVICE REP','100', 'USR_SEC_DOMAIN');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'JOB_CODE', 'SALES REP','en','String','SALES REP','100', 'USR_SEC_DOMAIN');

/* USER EMPLOYMENT TYPE*/
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'USER_TYPE', 'PERM FULL TIME','en','String','PERMANENT FULL TIME','100', 'USR_SEC_DOMAIN');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'USER_TYPE', 'PERM PART TIME','en','String','PERMANENT PART TIME','100', 'USR_SEC_DOMAIN');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'USER_TYPE', 'CONTRACTOR','en','String','CONTRACTOR','100', 'USR_SEC_DOMAIN');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'USER_TYPE', 'VENDOR','en','String','VENDOR','100', 'USR_SEC_DOMAIN');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'USER_TYPE', 'AFFILIATE','en','String','AFFILIATE','100', 'USR_SEC_DOMAIN');
insert into STATUS ( CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values( 'USER_TYPE', 'SYS ACCOUNT','en','String','SYSTEM ACCOUNT','100', 'USR_SEC_DOMAIN');


insert into STATUS (CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values('OBJECT_TYPE', 'ACCNT','en','String','Account','100', 'IDM');
insert into STATUS (CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values('OBJECT_TYPE', 'ADMIN','en','String','Administrator','100', 'IDM');
insert into STATUS (CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values('OBJECT_TYPE', 'ADMGP','en','String','Admin Group','100', 'IDM');
insert into STATUS (CODE_GROUP, status_cd, LANGUAGE_CD, status_type, description, COMPANY_OWNER_ID, SERVICE_ID) values('OBJECT_TYPE', 'ATTR','en','String','Attribute','100', 'IDM');


/* locations */
insert into LOCATION(LOCATION_ID, NAME, COUNTRY, BLDG_NUM, ADDRESS1, CITY, STATE, POSTAL_CD) VALUES ('100', 'HQ', 'US', '111' ,'MAIN ST', 'MY TOWN', 'NY', '12345');
insert into LOCATION(LOCATION_ID, NAME, COUNTRY, BLDG_NUM, ADDRESS1, CITY, STATE, POSTAL_CD) VALUES ('101', 'BRANCH', 'US', '112' ,'Next ST', 'MY TOWN', 'CT', '67890');


/* POLICY ENTRIES */

insert into POLICY_DEF(POLICY_DEF_ID, NAME, DESCRIPTION, POLICY_TYPE, LOCATION_TYPE) VALUES ('100','PASSWORD POLICY','Out of the box Password Policy', '2','DB' );

INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('110','100','PWD_HIST_VER','Password history versions', null,'org.openiam.idm.srvc.pswd.rule.PasswordHistoryRule', 'PSWD_COMPOSITION');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('111','100','PWD_EXPIRATION','Password expiration', null, '', '');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('141','100','PWD_EXPIRATION_ON_RESET','Password expiration time on reset', null, '', '');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('133','100','PWD_EXP_GRACE','Password expiration grace period', null, '',null);
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('134','100','CHNG_PSWD_ON_RESET','Change Password after reset', null, '', null);
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('135','100','INITIAL_PSWD_FIXED','Is the initial password rule based?', null, '' ,null);
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('136','100','INITIAL_PSWD_VALUE','Value of the initial password', null, '' ,null);
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION,OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP)  VALUES('112','100','PWD_LEN','Password length','RANGE', 'org.openiam.idm.srvc.pswd.rule.PasswordLengthRule', 'PSWD_COMPOSITION');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('113','100','NUMERIC_CHARS','Numeric characters(Min-Max)','RANGE','org.openiam.idm.srvc.pswd.rule.NumericCharRule', 'PSWD_COMPOSITION');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('114','100','UPPERCASE_CHARS','Uppercase characters(Min-Max)','RANGE','org.openiam.idm.srvc.pswd.rule.UpperCaseRule', 'PSWD_COMPOSITION');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('115','100','LOWERCASE_CHARS','Lowercase characters(Min-Max)','RANGE','org.openiam.idm.srvc.pswd.rule.LowerCaseRule', 'PSWD_COMPOSITION');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('116','100','NON_ALPHA_CHARS','Non-alpha numeric symbols(Min-Max)','RANGE','org.openiam.idm.srvc.pswd.rule.NonAlphaNumericRule', 'PSWD_COMPOSITION');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('117','100','ALPHA_CHARS','Alpha character(Min-Max)','RANGE','org.openiam.idm.srvc.pswd.rule.AlphaCharRule', 'PSWD_COMPOSITION');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('120','100','DICTIONARY_CHECK','Dictionary Check','boolean','', '');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('121','100','PWD_LOGIN','Reject password = Login Id','boolean','org.openiam.idm.srvc.pswd.rule.PasswordNotPrincipalRule', 'PSWD_COMPOSITION');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('122','100','PWD_NAME','Reject password = First / Last name','boolean','org.openiam.idm.srvc.pswd.rule.PasswordNotNameRule', 'PSWD_COMPOSITION');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('123','100','VOWELS_IN_PWD','Reject Password containing vowels ','boolean','', 'PSWD_COMPOSITION');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('124','100','REJECT_NUM_START','Reject passwords that begin or end with a numeric character','boolean', '', 'PSWD_COMPOSITION');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('125','100','HAS_NUMERIC_AT','Password to contain numeric chars at following positions', null,'', 'PSWD_COMPOSITION');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('126','100','HAS_ALPHA_NUM_AT','Password to contain alpha numeric chars at following positions', null,'', 'PSWD_COMPOSITION');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('128','100','FORCE_NON_ALPHA_NUM_AT','Force password to contain non-alpha numeric chars at following positions', null,'', 'PSWD_COMPOSITION');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('129','100','PWD_EXP_WARN','Days to password expiration warning', null,null, 'MISC');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('130','100','QUEST_COUNT','Number of questions to display', null, null, null);
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('131','100','QUEST_SRC','Source of questions', null,null, 'SELFSERVE');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('132','100','QUEST_LIST','Question list', null,null, 'SELFSERVE');

INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('138','100','PWD_EQ_PWD','RejectPassword Equals password', null,'org.openiam.idm.srvc.pswd.rule.PasswordNotPasswordRule', 'PSWD_COMPOSITION');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('139','100','RESET_BY_USER','Reject reset by user', null,'org.openiam.idm.srvc.pswd.rule.ChangePasswordByUserRule', 'PSWD_COMPOSITION');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('140','100','RESET_PER_TIME','Reset allowed per time unit', null,'org.openiam.idm.srvc.pswd.rule.PasswordChangesFrequencyRule', 'PSWD_COMPOSITION');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('142','100','PASSWORD_CHANGE_ALLOWED','Determines if a you are allowed to change the password', null,'org.openiam.idm.srvc.pswd.rule.PasswordChangeAllowedRule', 'PSWD_COMPOSITION');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('170','100','REJECT_CHARS_IN_PSWD','Characters not allowed in a password', null,'org.openiam.idm.srvc.pswd.rule.RejectCharactersRule', 'PSWD_COMPOSITION');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION, OPERATION, POLICY_PARAM_HANDLER,PARAM_GROUP) VALUES('171','100','QUEST_ANSWER_CORRECT','Number of answers that are required to be correct', null, null, null);


/* Authentication Policy */
insert into POLICY_DEF(POLICY_DEF_ID, NAME, DESCRIPTION, POLICY_TYPE, LOCATION_TYPE) VALUES ('103','AUTHENTICATION POLICY','Out of the box Authentication Policy', '4','DB' );
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION) VALUES('157','103','FAILED_AUTH_COUNT','Failed Authentication Attempts');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION) VALUES('151','103','AUTO_UNLOCK_TIME','UnLock account in n minutes');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION) VALUES('152','103','TOKEN_TYPE','SSO Token Type');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION) VALUES('159','103','TOKEN_LIFE','SSO Token Type Life');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION) VALUES('153','103','LOGIN_MODULE_SEL_POLCY','Policy to select the login module');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION) VALUES('154','103','SUCCESS_URL','URL to forward on authn success');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION) VALUES('155','103','FAIL_URL','URL to forward on authn fail');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION) VALUES('158','103','DEFAULT_LOGIN_MOD','Default Login Module');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION) VALUES('162','103','TOKEN_ISSUER','Issuer of the SSO Token');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION) VALUES('163','103','LOGIN_MOD_TYPE','Type of authentication module');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION) VALUES('164','103','AUTH_REPOSITORY','Authentication Repository');

INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION) VALUES('179','103','HOST_URL','URL of the host system');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION) VALUES('172','103','HOST_LOGIN','Login to the host');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION) VALUES('173','103','HOST_PASSWORD','Password to the host');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION) VALUES('174','103','BASEDN','Type of authentication module');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION) VALUES('175','103','PROTOCOL','Protocol');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION) VALUES('176','103','KEY_ATTRIBUTE','Name of the Primary Key Attribute');
INSERT INTO POLICY_DEF_PARAM (DEF_PARAM_ID, POLICY_DEF_ID, NAME, DESCRIPTION) VALUES('178','103','MANAGED_SYS_ID','Managed system Id');


insert into POLICY_DEF(POLICY_DEF_ID, NAME, DESCRIPTION, POLICY_TYPE, LOCATION_TYPE) VALUES ('104','ATTRIBUTE POLICY','Attribute value policies.', '5','DB' );


update POLICY_DEF_PARAM
	set repeats = 0
where repeats is null;

insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY) VALUES ('4000','100', 'Default Pswd Policy', 'Default Password Policy', 1,sysdate, '3000');

insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY) VALUES ('4001','103', 'Default Authn Policy', 'Default Authentication Policy', 1,sysdate, '3000');


/* Default Authn policy param */
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION,VALUE1)VALUES ('4101','151', '4001', 'AUTO_UNLOCK_TIME', '','30');
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION,VALUE1)VALUES ('4102','152', '4001', 'TOKEN_TYPE', '','OPENIAM_TOKEN');
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION,VALUE1)VALUES ('4103','153', '4001', 'LOGIN_MODULE_SEL_POLCY', '','');
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION,VALUE1)VALUES ('4104','154', '4001', 'SUCCESS_URL', '','');
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION,VALUE1)VALUES ('4105','155', '4001', 'FAIL_URL', '','');
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION,VALUE1)VALUES ('4107','157', '4001', 'FAILED_AUTH_COUNT', '','3');
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION,VALUE1)VALUES ('4108','158', '4001', 'DEFAULT_LOGIN_MOD', '','org.openiam.idm.srvc.auth.spi.DefaultLoginModule');
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION,VALUE1)VALUES ('4109','159', '4001', 'TOKEN_LIFE', '','30');
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION,VALUE1)VALUES ('4110','162', '4001', 'TOKEN_ISSUER', '','openiam');
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION,VALUE1)VALUES ('4111','163', '4001', 'LOGIN_MOD_TYPE', '','1');
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION,VALUE1)VALUES ('4112','164', '4001', 'AUTH_REPOSITORY', '',null);

/* Default Password policy param */
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION,VALUE1)VALUES ('4000','116', '4000', 'NON_ALPHA_CHARS', 'RANGE',null);
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION,VALUE1)VALUES ('4001','131', '4000', 'QUEST_SRC', '','USER');
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION,VALUE1)VALUES ('4004','117', '4000', 'ALPHA_CHARS', 'RANGE','');
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION, VALUE1) VALUES ('4007', '114', '4000', 'UPPERCASE_CHARS', 'RANGE', null);
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION, VALUE1) VALUES ('4008', '113', '4000', 'NUMERIC_CHARS', 'RANGE', 1);
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION, VALUE1) VALUES ('4010', '122', '4000', 'PWD_NAME', 'boolean', null);
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION, VALUE1,VALUE2) VALUES ('4011', '112', '4000', 'PWD_LEN', 'RANGE', 8,12);
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION, VALUE1) VALUES ('4012', '120', '4000', 'DICTIONARY_CHECK', 'boolean', null);
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION, VALUE1) VALUES ('4013', '110', '4000', 'PWD_HIST_VER', null, 6);
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION, VALUE1) VALUES ('4015', '132', '4000', 'QUEST_LIST', null, null);
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION, VALUE1) VALUES ('4016', '130', '4000', 'QUEST_COUNT', null, 3);
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION, VALUE1) VALUES ('4017', '121', '4000', 'PWD_LOGIN', 'boolean', null);
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION, VALUE1) VALUES ('4019', '115', '4000', 'LOWERCASE_CHARS', 'RANGE', null);
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION, VALUE1) VALUES ('4020', '129', '4000', 'PWD_EXP_WARN', null, 2);
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION, VALUE1) VALUES ('4023', '111', '4000', 'PWD_EXPIRATION', null, 90);
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION, VALUE1) VALUES ('4054', '141', '4000', 'PWD_EXPIRATION_ON_RESET', null, 2);
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION, VALUE1) VALUES ('4050', '133', '4000', 'PWD_EXP_GRACE', null, 1);
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION, VALUE1) VALUES ('4051', '134', '4000', 'CHNG_PSWD_ON_RESET', null, 1);

insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION, VALUE1) VALUES ('4052', '135', '4000', 'INITIAL_PSWD_FIXED', null, 1);
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION, VALUE1) VALUES ('4053', '136', '4000', 'INITIAL_PSWD_VALUE', null, 'passwd00');
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION, VALUE1) VALUES ('4055', '142', '4000', 'PASSWORD_CHANGE_ALLOWED', null, 1);
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION, VALUE1) VALUES ('4056', '170', '4000', 'REJECT_CHARS_IN_PSWD', null, '<>');
insert into POLICY_ATTRIBUTE (POLICY_ATTR_ID, DEF_PARAM_ID, POLICY_ID, NAME, OPERATION, VALUE1) VALUES ('4057', '171', '4000', 'QUEST_ANSWER_CORRECT', null, 3);

INSERT INTO POLICY_OBJECT_ASSOC (POLICY_OBJECT_ID, POLICY_ID, ASSOCIATION_LEVEL, ASSOCIATION_VALUE) VALUES ('1100', '4000', 'GLOBAL', 'GLOBAL');


insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE, RULE_SRC_URL) VALUES ('4501','104', 'cn', 'commonName', 1,sysdate, '3000', '','provision/cn.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE, RULE_SRC_URL) VALUES ('4502','104', 'mail', 'email address', 1,sysdate, '3000', '','provision/mail.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE, RULE_SRC_URL) VALUES ('4540','104', 'userDefineEmail', 'email address', 1,sysdate, '3000', '','provision/emailUserDefined.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4503','104', 'o', 'organization name', 1,sysdate, '3000', '','provision/o.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4504','104', 'ou', 'organizationalUnitName', 1,sysdate, '3000', '','provision/ou.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4505','104', 'postalCode', 'commonName', 1,sysdate, '3000', '','provision/postalCode.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4506','104', 'sn', 'surname', 1,sysdate, '3000', '','provision/sn.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4507','104', 'st', 'stateOrProvinceName', 1,sysdate, '3000', '','provision/st.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4508','104', 'street', 'streetAddress', 1,sysdate, '3000', '','provision/street.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4509','104', 'userPassword', 'password', 1,sysdate, '3000', '','provision/userPassword.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4510','104', 'postalAddress', 'postalAddress', 1,sysdate, '3000', '','provision/postalAddress.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4511','104', 'telephoneNumber', 'Primary Telephone', 1,sysdate, '3000', '','provision/telephone.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4512','104', 'facsimileTelephoneNumber', 'Fax', 1,sysdate, '3000', '','provision/fax.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4513','104', 'mobile', 'mobileTelephoneNumber', 1,sysdate, '3000', '','provision/mobile.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4514','104', 'gn', 'givenName', 1,sysdate, '3000', '','provision/gn.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4515','104', 'uid', 'User Id', 1,sysdate, '3000', '','provision/uid.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4516','104', 'departmentCD', 'Department Code', 1,sysdate, '3000', '','provision/deptcd.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4517','104', 'displayName', 'Display Name', 1,sysdate, '3000', '','provision/displayName.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4518','104', 'employeeType', 'Employee Type', 1,sysdate, '3000', '','provision/employeeType.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4519','104', 'initials', 'Intials', 1,sysdate, '3000', '','provision/initials.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4521','104', 'objectclass', 'Department Number', 1,sysdate, '3000', '','provision/objectclass.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4522','104', 'title', 'Title', 1,sysdate, '3000', '','provision/title.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4541','104', 'dob', 'Date of Birth', 1,sysdate, '3000', '','provision/dob.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4542','104', 'middleInit', 'Middle Initial', 1,sysdate, '3000', '','provision/middleInit.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4543','104', 'employeeId', 'Employee ID', 1,sysdate, '3000', '','provision/employeeId.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4544','104', 'userDefinedPassword', 'Password By User', 1,sysdate, '3000', '','provision/userDefPassword.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4545','104', 'userRole', 'Role Membership', 1,sysdate, '3000', '','provision/userRole.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4546','104', 'userGroup', 'Group Membership', 1,sysdate, '3000', '','provision/userGroup.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4547','104', 'isEnabled', 'Is the User Enabled', 1,sysdate, '3000', '','provision/isEnabled.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4548','104', 'GUID', 'GUID', 1,sysdate, '3000', '','provision/guid.groovy');

/* ACTIVE DIR Attributes*/
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4530','104', 'sAMAccountName', 'sAMAccountName', 1,sysdate, '3000', '','provision/ad/sAMAccountName.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4531','104', 'userPrincipalName', 'userPrincipalName', 1,sysdate, '3000', '','provision/ad/userPrincipalName.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4532','104', 'adCN', 'adCN', 1,sysdate, '3000', '','provision/ad/adCN.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4533','104', 'AccountDisabled', 'AccountDisabled', 1,sysdate, '3000', '','provision/ad/accountDisabled.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4534','104', 'profilePath', 'profilePath', 1,sysdate, '3000', '','provision/ad/profilePath.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4535','104', 'homeDirectory', 'homeDirectory', 1,sysdate, '3000', '','provision/ad/homeDirectory.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4536','104', 'homeDrive', 'homeDrive', 1,sysdate, '3000', '','provision/ad/homeDrive.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4537','104', 'scriptPath', 'scriptPath', 1,sysdate, '3000', '','provision/ad/scriptPath.groovy');



INSERT INTO POLICY(POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS,RULE_SRC_URL) VALUES('4562', '104', 'principal', 'PRIMARY_PRINICPAL', '1','provision/primary_principal.groovy');
INSERT INTO POLICY(POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS,RULE_SRC_URL) VALUES('4563', '104', 'password', 'PRIMARY_PASSWORD', '1','provision/primary_pswd.groovy');
INSERT INTO POLICY(POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS,RULE_SRC_URL) VALUES('4564', '104', 'emailAddress', 'PRIMARY_EMAIL', '1','provision/primary_email.groovy');
INSERT INTO POLICY(POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS,RULE_SRC_URL) VALUES('4565', '104', 'domain', 'PRIMARY_DOMAIN', '1','provision/primaryDomain.groovy');

/* Google Apps */
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4600','104', 'userName', 'Google User Name', 1,sysdate, '3000', '','provision/gapps/gappsUid.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4601','104', 'firstName', 'Google Fist Name', 1,sysdate, '3000', '','provision/gapps/gappsFirstName.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4602','104', 'lastName', 'Google Last Name', 1,sysdate, '3000', '','provision/gapps/gappsLastName.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4603','104', 'password', 'Google Password', 1,sysdate, '3000', '','provision/gapps/gappsPassword.groovy');


/* USED AS LOGICAL GROUPING FOR RESOURCES */
INSERT INTO CATEGORY(CATEGORY_ID,CATEGORY_NAME) VALUES('SECURITY','SECURITY');

insert into IDENTITY_QUEST_GRP(IDENTITY_QUEST_GRP_ID, NAME, STATUS, COMPANY_OWNER_ID, CREATE_DATE) VALUES ('GLOBAL','GLOBAL IDENTITY QUESTIONS', 'ACTIVE', 'GLOBAL', sysdate);
INSERT INTO IDENTITY_QUESTION(IDENTITY_QUESTION_ID, IDENTITY_QUEST_GRP_ID, QUESTION_TEXT, REQUIRED) VALUES('200','GLOBAL','What are the last four digits of your social security number?',1);
INSERT INTO IDENTITY_QUESTION(IDENTITY_QUESTION_ID, IDENTITY_QUEST_GRP_ID, QUESTION_TEXT, REQUIRED) VALUES('209','GLOBAL','What are the last four digits of your drivers license?',1);
INSERT INTO IDENTITY_QUESTION(IDENTITY_QUESTION_ID, IDENTITY_QUEST_GRP_ID, QUESTION_TEXT, REQUIRED) VALUES('201','GLOBAL','What is your mothers maiden name?',1);
INSERT INTO IDENTITY_QUESTION(IDENTITY_QUESTION_ID, IDENTITY_QUEST_GRP_ID, QUESTION_TEXT, REQUIRED) VALUES('202','GLOBAL','Where did you go to school?',1);
INSERT INTO IDENTITY_QUESTION(IDENTITY_QUESTION_ID, IDENTITY_QUEST_GRP_ID, QUESTION_TEXT, REQUIRED) VALUES('203','GLOBAL','What is your pets name?',0);
INSERT INTO IDENTITY_QUESTION(IDENTITY_QUESTION_ID, IDENTITY_QUEST_GRP_ID, QUESTION_TEXT, REQUIRED) VALUES('204','GLOBAL','What is your favorite food?',0);
INSERT INTO IDENTITY_QUESTION(IDENTITY_QUESTION_ID, IDENTITY_QUEST_GRP_ID, QUESTION_TEXT, REQUIRED) VALUES('205','GLOBAL','What is your favorite color?',0);
INSERT INTO IDENTITY_QUESTION(IDENTITY_QUESTION_ID, IDENTITY_QUEST_GRP_ID, QUESTION_TEXT, REQUIRED) VALUES('206','GLOBAL','Which city were you born in?',0);
INSERT INTO IDENTITY_QUESTION(IDENTITY_QUESTION_ID, IDENTITY_QUEST_GRP_ID, QUESTION_TEXT, REQUIRED) VALUES('207','GLOBAL','What is your favorite sport?',0);
INSERT INTO IDENTITY_QUESTION(IDENTITY_QUESTION_ID, IDENTITY_QUEST_GRP_ID, QUESTION_TEXT, REQUIRED) VALUES('210','GLOBAL','What is the name of your favorite school?',0);
INSERT INTO IDENTITY_QUESTION(IDENTITY_QUESTION_ID, IDENTITY_QUEST_GRP_ID, QUESTION_TEXT, REQUIRED) VALUES('211','GLOBAL','What is the name of your first pet',0);
INSERT INTO IDENTITY_QUESTION(IDENTITY_QUESTION_ID, IDENTITY_QUEST_GRP_ID, QUESTION_TEXT, REQUIRED) VALUES('212','GLOBAL','What is the name of your favorite movie, play or song?',0);
INSERT INTO IDENTITY_QUESTION(IDENTITY_QUESTION_ID, IDENTITY_QUEST_GRP_ID, QUESTION_TEXT, REQUIRED) VALUES('213','GLOBAL','What is the title of your favorite book?',0);
INSERT INTO IDENTITY_QUESTION(IDENTITY_QUESTION_ID, IDENTITY_QUEST_GRP_ID, QUESTION_TEXT, REQUIRED) VALUES('214','GLOBAL','What is the name of your first boy or girl friend?',0);
INSERT INTO IDENTITY_QUESTION(IDENTITY_QUESTION_ID, IDENTITY_QUEST_GRP_ID, QUESTION_TEXT, REQUIRED) VALUES('215','GLOBAL','What is the name of your favorite school teacher?',0);
INSERT INTO IDENTITY_QUESTION(IDENTITY_QUESTION_ID, IDENTITY_QUEST_GRP_ID, QUESTION_TEXT, REQUIRED) VALUES('216','GLOBAL','What is the year and nick name of your first car (Year-Name)?',0);
INSERT INTO IDENTITY_QUESTION(IDENTITY_QUESTION_ID, IDENTITY_QUEST_GRP_ID, QUESTION_TEXT, REQUIRED) VALUES('217','GLOBAL','Where did you meet you significant other?',0);
INSERT INTO IDENTITY_QUESTION(IDENTITY_QUESTION_ID, IDENTITY_QUEST_GRP_ID, QUESTION_TEXT, REQUIRED) VALUES('218','GLOBAL','What is the type and name of your first pet (Type-Name)?',0);

insert into PROVISION_CONNECTOR(CONNECTOR_ID, NAME, METADATA_TYPE_ID, SERVICE_URL,SERVICE_NAMESPACE, SERVICE_PORT) VALUES ('51','LDAP CONNECTOR', 'LDAP_Connector','localhost:8080/openiam-idm-esb/idmsrvc/LDAPConnectorService','http://www.openiam.org/service/connector', 'LDAPConnectorServicePort' );
insert into PROVISION_CONNECTOR(CONNECTOR_ID, NAME, METADATA_TYPE_ID, SERVICE_URL,SERVICE_NAMESPACE, SERVICE_PORT) VALUES ('54','Google Apps CONNECTOR', 'GOOGLE_Connector','localhost:8080/openiam-idm-esb/idmsrvc/GoogleAppsConnectorService','http://www.openiam.org/service/connector', 'GoogleAppsConnectorServicePort' );
insert into PROVISION_CONNECTOR(CONNECTOR_ID, NAME, METADATA_TYPE_ID, SERVICE_URL,SERVICE_NAMESPACE, SERVICE_PORT) VALUES ('55','Active Directory 2003 CONNECTOR', 'LDAP_Connector','http://localhost/ServiceHost/ActiveDirectoryConnector.svc','http://www.openiam.org/service/connector', 'NA' );
insert into PROVISION_CONNECTOR(CONNECTOR_ID, NAME, METADATA_TYPE_ID, SERVICE_URL,SERVICE_NAMESPACE, SERVICE_PORT) VALUES ('61','Application Tables CONNECTOR', 'DB_Connector','localhost:8080/openiam-idm-esb/idmsrvc/ApplicationTablesConnector','http://www.openiam.org/service/connector', 'NA' );



INSERT INTO MANAGED_SYS (MANAGED_SYS_ID, NAME, DESCRIPTION, STATUS, CONNECTOR_ID, DOMAIN_ID, HOST_URL, PORT, COMM_PROTOCOL, RESOURCE_ID) VALUES('0','OPENIAM', 'Primary IDENTITY', 'ACTIVE', null, 'USR_SEC_DOMAIN', null, null, null, '0'   );
INSERT INTO MANAGED_SYS (MANAGED_SYS_ID, NAME, DESCRIPTION, STATUS, CONNECTOR_ID, DOMAIN_ID, HOST_URL, PORT, COMM_PROTOCOL, RESOURCE_ID) VALUES('101','OPENIAM_LDAP', 'Primary Directory', 'ACTIVE', '51', 'USR_SEC_DOMAIN', 'ldap://localhost','389', 'SSL', '101'   );
INSERT INTO MANAGED_SYS (MANAGED_SYS_ID, NAME, DESCRIPTION, STATUS, CONNECTOR_ID, DOMAIN_ID, HOST_URL, PORT, COMM_PROTOCOL, RESOURCE_ID) VALUES('103','Google Apps Connector', 'Google Apps Connector', 'ACTIVE', '54', 'USR_SEC_DOMAIN', '', null,'CLEAR', '103'   );
INSERT INTO MANAGED_SYS (MANAGED_SYS_ID, NAME, DESCRIPTION, STATUS, CONNECTOR_ID, DOMAIN_ID, HOST_URL, PORT, COMM_PROTOCOL, RESOURCE_ID) VALUES('104','Active Directory Connector', 'Active Directory 2003', 'ACTIVE', '55', 'USR_SEC_DOMAIN', '', null,'CLEAR', '104'   );



INSERT INTO MANAGED_SYS (MANAGED_SYS_ID, NAME, DESCRIPTION, STATUS, CONNECTOR_ID, DOMAIN_ID,   RESOURCE_ID) VALUES('200','SELFSERVICE_NEWHIRE', 'New Hire Form', 'ACTIVE', null, null,  '200'   );
INSERT INTO MANAGED_SYS (MANAGED_SYS_ID, NAME, DESCRIPTION, STATUS, CONNECTOR_ID, DOMAIN_ID,   RESOURCE_ID) VALUES('201','SELFSERVICE_CREATEREQUEST', 'Create Request Form', 'ACTIVE', null, null,  '201'   );
INSERT INTO MANAGED_SYS (MANAGED_SYS_ID, NAME, DESCRIPTION, STATUS, CONNECTOR_ID, DOMAIN_ID,   RESOURCE_ID) VALUES('202','SELFSERVICE_PROFILE', 'Profile Form', 'ACTIVE', null, null,  '202'   );


INSERT INTO RESOURCE_TYPE (RESOURCE_TYPE_ID, DESCRIPTION, METADATA_TYPE_ID, PROVISION_RESOURCE) VALUES('AUTH_REPO', 'Authentication Repository', 'AUTH_REPO', null);
INSERT INTO RESOURCE_TYPE (RESOURCE_TYPE_ID, DESCRIPTION, METADATA_TYPE_ID, PROVISION_RESOURCE) VALUES('MANAGED_SYS', 'Managed Systems', 'MANAGED_SYSTEM', 1);
INSERT INTO RESOURCE_TYPE (RESOURCE_TYPE_ID, DESCRIPTION, METADATA_TYPE_ID, PROVISION_RESOURCE) VALUES('SYS_ACTION', 'System Action', 'SYS_ACTION', 0);
INSERT INTO RESOURCE_TYPE (RESOURCE_TYPE_ID, DESCRIPTION, METADATA_TYPE_ID, PROVISION_RESOURCE) VALUES('OTHER_NONPROV', 'Non-Provisionable Resource', 'MANAGED_SYSTEM', 0);
INSERT INTO RESOURCE_TYPE (RESOURCE_TYPE_ID, DESCRIPTION, METADATA_TYPE_ID, PROVISION_RESOURCE) VALUES('WEBSERVICE', 'Web Services', 'WEBSERVICE', 0);
INSERT INTO RESOURCE_TYPE (RESOURCE_TYPE_ID, DESCRIPTION, METADATA_TYPE_ID, PROVISION_RESOURCE) VALUES('NO-PROVISION-APP', 'Un-provisionable Apps', 'NO-PROVISION-APP', 0);

insert into RES (RESOURCE_ID, RESOURCE_TYPE_ID,NAME, DISPLAY_ORDER) VALUES ('0', 'MANAGED_SYS', 'OPENIAM', 1);
insert into RES (RESOURCE_ID, RESOURCE_TYPE_ID,NAME, DISPLAY_ORDER, MANAGED_SYS_ID ) VALUES ('101', 'MANAGED_SYS', 'LDAP', 2, '101');
insert into RES (RESOURCE_ID, RESOURCE_TYPE_ID,NAME, DISPLAY_ORDER, MANAGED_SYS_ID ) VALUES ('103', 'MANAGED_SYS', 'Google App Con', 3, '103');
insert into RES (RESOURCE_ID, RESOURCE_TYPE_ID,NAME, DISPLAY_ORDER, MANAGED_SYS_ID ) VALUES ('104', 'MANAGED_SYS', 'Active Dir 2003 Con', 3, '104');


insert into RES (RESOURCE_ID, RESOURCE_TYPE_ID,NAME, DISPLAY_ORDER, DESCRIPTION) VALUES ('252', 'SYS_ACTION', 'SELFSERVICE_TERMINATE', 3,'TERMINATE USER');
insert into RES (RESOURCE_ID, RESOURCE_TYPE_ID,NAME, DISPLAY_ORDER, DESCRIPTION) VALUES ('253', 'SYS_ACTION', 'SELFSERVICE_CHANGEROLE', 4,'CHANGE USER ROLE');
insert into RES (RESOURCE_ID, RESOURCE_TYPE_ID,NAME, DISPLAY_ORDER, DESCRIPTION) VALUES ('254', 'SYS_ACTION', 'SELFSERVICE_NEWUSER', 5, 'NEW USER');
insert into RES (RESOURCE_ID, RESOURCE_TYPE_ID,NAME, DISPLAY_ORDER, DESCRIPTION) VALUES ('255', 'SYS_ACTION', 'SELFSERVICE_SELFREGISTER', 5, 'SELF REGISTRATION');


/* Indicates that the user object should not be sent to the AD and LDAP connectors */
insert into RESOURCE_PROP(RESOURCE_PROP_ID, RESOURCE_ID, NAME, PROP_VALUE) VALUES ('200', '101','INCLUDE_USER_OBJECT', 'N');


insert into RESOURCE_PROP(RESOURCE_PROP_ID, RESOURCE_ID, NAME, PROP_VALUE) VALUES ('202', '101','PRINCIPAL_NAME', 'uid');
insert into RESOURCE_PROP(RESOURCE_PROP_ID, RESOURCE_ID, NAME, PROP_VALUE) VALUES ('203', '101','PRINCIPAL_PASSWORD', 'userPassword');
insert into RESOURCE_PROP(RESOURCE_PROP_ID, RESOURCE_ID, NAME, PROP_VALUE) VALUES ('204', '101','INCLUDE_IN_PASSWORD_SYNC', 'Y');
insert into RESOURCE_PROP(RESOURCE_PROP_ID, RESOURCE_ID, NAME, PROP_VALUE) VALUES ('205', '101','ON_DELETE', 'DELETE');
insert into RESOURCE_PROP(RESOURCE_PROP_ID, RESOURCE_ID, NAME, PROP_VALUE) VALUES ('206', '101','GROUP_MEMBERSHIP_ENABLED', 'Y');



INSERT INTO APPROVER_ASSOC(APPROVER_ASSOC_ID, REQUEST_TYPE, APPROVER_LEVEL, ASSOCIATION_TYPE)  VALUES ('100', 'NEW_HIRE', 1, 'SUPERVISOR');
INSERT INTO APPROVER_ASSOC(APPROVER_ASSOC_ID, REQUEST_TYPE, APPROVER_LEVEL, ASSOCIATION_TYPE, APPROVER_USER_ID)  VALUES ('101', '254', 1, 'USER','3000');


insert into MNG_SYS_OBJECT_MATCH(OBJECT_SEARCH_ID, MANAGED_SYS_ID, OBJECT_TYPE, MATCH_METHOD, SEARCH_FILTER, BASE_DN, SEARCH_BASE_DN ,KEY_FIELD) VALUES('100', '101', 'USER', 'BASE_DN', '(&(objectclass=inetOrgPerson)(?))','ou=people,dc=openiam,dc=org','dc=openiam,dc=org','uid');

/* MAP FOR openiam repository */
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('230', '0', '0','PRINCIPAL', 'PRINCIPAL', '4562');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('231', '0', '0','PRINCIPAL', 'PASSWORD', '4563');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('232', '0', '0','EMAIL', 'EMAIL', '4564');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('233', '0', '0','PRINCIPAL', 'DOMAIN', '4565');

/* MAP FOR LDAP */

INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('201', '101', '101','USER', 'cn', '4501');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('202', '101', '101','USER', 'mail', '4502');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('203', '101', '101','USER', 'o', '4503');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('204', '101', '101','USER', 'ou', '4504');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('205', '101', '101','USER', 'postalCode', '4505');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('206', '101', '101','USER', 'sn', '4506');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('207', '101', '101','USER', 'st', '4507');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('208', '101', '101','USER', 'street', '4508');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('209', '101', '101','USER', 'userPassword', '4509');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('210', '101', '101','USER', 'postalAddress', '4510');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('211', '101', '101','USER', 'telephoneNumber', '4511');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('212', '101', '101','USER', 'facsimileTelephoneNumber', '4512');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('213', '101', '101','USER', 'mobileTelephoneNumber', '4513');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('215', '101', '101','PRINCIPAL', 'uid', '4515');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('216', '101', '101','USER', 'departmentNumber', '4516');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('217', '101', '101','USER', 'displayName', '4517');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('218', '101', '101','USER', 'employeeType', '4518');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('221', '101', '101','USER', 'objectclass', '4521');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('222', '101', '101','USER', 'title', '4522');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('223', '101', '101','USER', 'givenName', '4514');

/* MAP FOR GOOGLE APPS*/
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('400', '103', '103','PRINCIPAL', 'userName', '4600');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('401', '103', '103','USER', 'firstName', '4601');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('402', '103', '103','USER', 'lastName', '4602');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('403', '103', '103','USER', 'password', '4603');

/* MAP FOR AD 2003 AND EXCHANGE 2003 */
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('301', '104', '104','PRINCIPAL', 'cn', '4532');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('302', '104', '104','USER', 'sn', '4506');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('303', '104', '104','USER', 'givenName', '4514');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('314', '104', '104','USER', 'displayName', '4517');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('305', '104', '104','USER', 'userPassword', '4509');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('306', '104', '104','USER', 'sAMAccountName', '4530');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('307', '104', '104','USER', 'userPrincipalName', '4531');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('308', '104', '104','USER', 'initials', '4519');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('309', '104', '104','USER', 'title', '4522');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('310', '104', '104','USER', 'AccountDisabled', '4533');

INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('311', '104', '104','USER', 'profilePath', '4534');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('312', '104', '104','USER', 'homeDirectory', '4535');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('313', '104', '104','USER', 'homeDrive', '4536');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('315', '104', '104','USER', 'scriptPath', '4537');


/* Batch Tasks */
insert into BATCH_CONFIG(TASK_ID, TASK_NAME, FREQUENCY_UNIT_OF_MEASURE, ENABLED, TASK_URL, EXECUTION_ORDER) VALUES('100','ACCOUNT_LOCKED_NOTIFICATION', 'MINUTE','0','batch/accountLockedNotification.groovy','2');
insert into BATCH_CONFIG(TASK_ID, TASK_NAME, FREQUENCY_UNIT_OF_MEASURE, ENABLED, TASK_URL, EXECUTION_ORDER) VALUES('101','INACTIVE_USER', 'NIGHTLY','0','batch/inactiveUser.groovy','1');
insert into BATCH_CONFIG(TASK_ID, TASK_NAME, FREQUENCY_UNIT_OF_MEASURE, ENABLED, TASK_URL, EXECUTION_ORDER) VALUES('102','PASSWORD_NEAR_EXP', 'NIGHTLY','0','batch/passwordNearExpNotification.groovy','2');
insert into BATCH_CONFIG(TASK_ID, TASK_NAME, FREQUENCY_UNIT_OF_MEASURE, ENABLED, TASK_URL, EXECUTION_ORDER) VALUES('107','PASSWORD_EXPIRED', 'NIGHTLY','0','batch/passwordExpiredNotification.groovy','4');
insert into BATCH_CONFIG(TASK_ID, TASK_NAME, FREQUENCY_UNIT_OF_MEASURE, ENABLED, TASK_URL, EXECUTION_ORDER) VALUES('103','TERMINATE_EXP_ACCT', 'NIGHTLY','0','batch/terminateOnExpiration.groovy','3');
insert into BATCH_CONFIG(TASK_ID, TASK_NAME, FREQUENCY_UNIT_OF_MEASURE, ENABLED, TASK_URL, EXECUTION_ORDER) VALUES('104','AUTO_UNLOCK', 'MINUTE','0','batch/autoUnlock.groovy','1');

insert into BATCH_CONFIG(TASK_ID, TASK_NAME, FREQUENCY_UNIT_OF_MEASURE, ENABLED, TASK_URL, EXECUTION_ORDER) VALUES('105','RESET_PSWD_CHNG_COUNT', 'MINUTE','0','batch/resetPasswordChangeCount.groovy','2');
insert into BATCH_CONFIG(TASK_ID, TASK_NAME, FREQUENCY_UNIT_OF_MEASURE, ENABLED, TASK_URL, EXECUTION_ORDER) VALUES('106','PUBLISH_AUDIT_EVENT', 'NIGHTLY','0','batch/publishAuditEvent.groovy','3');
insert into BATCH_CONFIG(TASK_ID, TASK_NAME, FREQUENCY_UNIT_OF_MEASURE, ENABLED, TASK_URL, EXECUTION_ORDER) VALUES('108','PROV_ON_STARTDATE', 'NIGHTLY','0','batch/provisionOnStartDate.groovy','4');

commit;