USE openiam;

/* USED AS LOGICAL GROUPING FOR RESOURCES */

insert into PROVISION_CONNECTOR(CONNECTOR_ID, NAME, METADATA_TYPE_ID, SERVICE_URL,SERVICE_NAMESPACE, SERVICE_PORT,CONNECTOR_INTERFACE) VALUES ('55','NATIVE Active Directory CONNECTOR', 'LDAP_Connector','localhost/OpenIAM/OpenIamADConnector.svc','http://www.openiam.org/service/connector', 'NA','REMOTE' );
INSERT INTO MANAGED_SYS (MANAGED_SYS_ID, NAME, DESCRIPTION, STATUS, CONNECTOR_ID, DOMAIN_ID, HOST_URL, PORT, COMM_PROTOCOL, RESOURCE_ID) VALUES('104','Active Directory Connector', 'Active Directory 2008', 'ACTIVE', '55', 'USR_SEC_DOMAIN', '', null,'CLEAR', '104'   );
insert into RES (RESOURCE_ID, RESOURCE_TYPE_ID,NAME, DISPLAY_ORDER, MANAGED_SYS_ID ) VALUES ('104', 'MANAGED_SYS', 'Active Directory', 3, '104');

insert into MNG_SYS_OBJECT_MATCH(OBJECT_SEARCH_ID, MANAGED_SYS_ID, OBJECT_TYPE, MATCH_METHOD, SEARCH_FILTER, BASE_DN, SEARCH_BASE_DN ,KEY_FIELD) VALUES('104', '104', 'USER', 'BASE_DN', '(&(objectclass=user)(?))','OU=Users,OU=OpenIAM,DC=ocgov,DC=dev','OU=Users,OU=OpenIAM,DC=ocgov,DC=dev','CN');


/* ACTIVE DIR Attributes*/
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4632','104', 'ad-CN', 'CN', 1,curdate(), '3000', '','provision/ad/adCN.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4630','104', 'ad-sAMAccountName', 'sAMAccountName', 1,curdate(), '3000', '','provision/ad/sAMAccountName.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4631','104', 'ad-givenName', 'givenName', 1,curdate(), '3000', '','provision/ad/sAMAccountName.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4633','104', 'ad-ou', 'ou', 1,curdate(), '3000', '','provision/ad/ou.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4634','104', 'ad-objectclass', 'objectclass', 1,curdate(), '3000', '','provision/ad/objectclass.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4635','104', 'ad-profilePath', 'profilePath', 1,curdate(), '3000', '','provision/ad/profilePath.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4636','104', 'ad-homeDirectory', 'homeDirectory', 1,curdate(), '3000', '','provision/ad/homeDirectory.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4637','104', 'ad-homeDrive', 'homeDrive', 1,curdate(), '3000', '','provision/ad/homeDrive.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4639','104', 'ad-scriptPath', 'scriptPath', 1,curdate(), '3000', '','provision/ad/scriptPath.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4640','104', 'ad-company', 'company', 1,curdate(), '3000', '','provision/ad/company.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4642','104', 'ad-initials', 'initials', 1,curdate(), '3000', '','provision/ad/initials.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4643','104', 'ad-department', 'department', 1,curdate(), '3000', '','provision/ad/department.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4644','104', 'ad-telephoneNumber', 'telephoneNumber', 1,curdate(), '3000', '','provision/ad/telephoneNumber.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4645','104', 'ad-title', 'title', 1,curdate(), '3000', '','provision/ad/title.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4646','104', 'ad-unicodePwd', 'unicodePwd', 1,curdate(), '3000', '','provision/ad/unicodePwd.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4647','104', 'ad-AccountDisabled', 'AccountDisabled', 1,curdate(), '3000', '','provision/ad/accountDisabled.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4648','104', 'ad-CN-native', 'CN', 1,curdate(), '3000', '','provision/ad/cnNative.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4649','104', 'ad-userPrincipalName', 'CN', 1, '3000', '','provision/ad/userPrincipalName.groovy');
insert into POLICY (POLICY_ID, POLICY_DEF_ID, NAME, DESCRIPTION, STATUS, CREATE_DATE, CREATED_BY, RULE,  RULE_SRC_URL) VALUES ('4660','104', 'ad-userGroup', 'AD Group Membership', 1,curdate(), '3000', '','provision/ad/userGroup.groovy');



/* MAP FOR AD 2008 */

INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('601', '104', '104','PRINCIPAL', 'CN', '4648');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('602', '104', '104','USER', 'sAMAccountName', '4630');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('603', '104', '104','USER', 'sn', '4506');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('604', '104', '104','USER', 'givenName', '4631');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('605', '104', '104','USER', 'displayName', '4517');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('606', '104', '104','USER', 'ou', '4633');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('607', '104', '104','USER', 'objectclass', '4634');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('608', '104', '104','USER', 'profilePath', '4635');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('609', '104', '104','USER', 'homeDirectory', '4636');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('610', '104', '104','USER', 'homeDrive', '4637');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('611', '104', '104','USER', 'scriptPath', '4639');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('612', '104', '104','USER', 'company', '4640');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('613', '104', '104','USER', 'initials', '4642');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('614', '104', '104','USER', 'department', '4643');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('615', '104', '104','USER', 'telephoneNumber', '4644');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('616', '104', '104','USER', 'title', '4645');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('617', '104', '104','USER', 'unicodePwd', '4646');
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('618', '104', '104','USER', 'AccountDisabled', '4647')
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID) VALUES ('619', '104', '104','USER', 'userPrincipalName', '4649')
INSERT INTO ATTRIBUTE_MAP(ATTRIBUTE_MAP_ID, MANAGED_SYS_ID, RESOURCE_ID, MAP_FOR_OBJECT_TYPE, ATTRIBUTE_NAME, ATTRIBUTE_POLICY_ID, STATUS,DATA_TYPE) VALUES ('620', '104', '104','USER', 'uniqueMember', '4660', 'IN-ACTIVE', 'memberOf');










commit;