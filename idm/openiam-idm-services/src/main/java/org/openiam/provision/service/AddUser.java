/*
 * Copyright 2009, OpenIAM LLC 
 * This file is part of the OpenIAM Identity and Access Management Suite
 *
 *   OpenIAM Identity and Access Management Suite is free software: 
 *   you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License 
 *   version 3 as published by the Free Software Foundation.
 *
 *   OpenIAM is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   Lesser GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with OpenIAM.  If not, see <http://www.gnu.org/licenses/>. *
 */

/**
 * 
 */
package org.openiam.provision.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openiam.base.SysConfiguration;
import org.openiam.base.ws.ResponseCode;
import org.openiam.base.ws.ResponseStatus;
import org.openiam.exception.EncryptionException;
import org.openiam.idm.srvc.audit.dto.IdmAuditLog;
import org.openiam.idm.srvc.audit.service.AuditHelper;
import org.openiam.idm.srvc.auth.dto.Login;
import org.openiam.idm.srvc.auth.dto.LoginId;
import org.openiam.idm.srvc.auth.login.LoginDataService;
import org.openiam.idm.srvc.continfo.dto.EmailAddress;
import org.openiam.idm.srvc.grp.dto.Group;
import org.openiam.idm.srvc.grp.service.GroupDataService;
import org.openiam.idm.srvc.mngsys.dto.AttributeMap;
import org.openiam.idm.srvc.mngsys.service.ManagedSystemDataService;
import org.openiam.idm.srvc.org.service.OrganizationDataService;
import org.openiam.idm.srvc.policy.dto.Policy;
import org.openiam.idm.srvc.res.service.ResourceDataService;
import org.openiam.idm.srvc.role.dto.Role;
import org.openiam.idm.srvc.role.dto.UserRole;
import org.openiam.idm.srvc.role.service.RoleDataService;
import org.openiam.idm.srvc.user.dto.Supervisor;
import org.openiam.idm.srvc.user.dto.User;
import org.openiam.idm.srvc.user.service.UserDataService;
import org.openiam.provision.dto.ProvisionUser;
import org.openiam.provision.resp.PasswordResponse;
import org.openiam.provision.resp.ProvisionUserResponse;
import org.openiam.script.ScriptIntegration;
import org.openiam.idm.srvc.org.dto.Organization;

/**
 * Helper class that will be called by the DefaultProvisioningService to add users in to the 
 * OpenIAM repository.
 * 
 * @author suneet
 *
 */
public class AddUser {

	protected static final Log log = LogFactory.getLog(AddUser.class);
	
	protected RoleDataService roleDataService;
	protected GroupDataService groupManager;
	protected UserDataService userMgr;
	protected LoginDataService loginManager;
	protected SysConfiguration sysConfiguration;
	protected ResourceDataService resourceDataService;
	protected ManagedSystemDataService managedSysService;
    protected AuditHelper auditHelper;
	protected OrganizationDataService orgManager;
	
	public ProvisionUserResponse createUser(ProvisionUser user, List<IdmAuditLog> logList) {

        ProvisionUserResponse resp = new ProvisionUserResponse();
        resp.setStatus(ResponseStatus.SUCCESS);
		ResponseCode code;
		
		User newUser = userMgr.addUser(user.getUser());
		if (newUser == null || newUser.getUserId() == null) {
			resp.setStatus(ResponseStatus.FAILURE);
			return resp;
		}	
		user.setUserId(newUser.getUserId());
		log.debug("User id=" + newUser.getUserId() + " created in openiam repository");
		
		addSupervisor(user);
		try {
			addPrincipals(user);
		}catch(EncryptionException e) {
			resp.setStatus(ResponseStatus.FAILURE);
			resp.setErrorCode(ResponseCode.FAIL_ENCRYPTION);
			return resp;
		}
		code = addGroups(user, newUser.getUserId(), logList);
		if (code != ResponseCode.SUCCESS) {
			resp.setStatus(ResponseStatus.FAILURE);
			resp.setErrorCode(code);
			return resp;
		}
		code = addRoles(user, newUser.getUserId(), logList);
		if (code != ResponseCode.SUCCESS) {
			resp.setStatus(ResponseStatus.FAILURE);
			resp.setErrorCode(code);
			return resp;
		}
        code = addAffiliations(user, newUser.getUserId(), logList);
		if (code != ResponseCode.SUCCESS) {
			resp.setStatus(ResponseStatus.FAILURE);
			resp.setErrorCode(code);
			return resp;
		}

		
		return resp;
	}
	
	private void addSupervisor(ProvisionUser u) {
		Supervisor supervisor = u.getSupervisor();
		if (supervisor != null && supervisor.getSupervisor() != null) {
			supervisor.setEmployee(u.getUser());
			userMgr.addSupervisor(supervisor);
		}		
	}
	private void addPrincipals(ProvisionUser u) throws EncryptionException {
	 	List<Login> principalList = u.getPrincipalList();
	 	if (principalList != null && !principalList.isEmpty()) {
	 		for (Login lg: principalList) {
	 			lg.setFirstTimeLogin(1);
	 			lg.setIsLocked(0);
	 			lg.setCreateDate(new Date(System.currentTimeMillis()));
	 			lg.setUserId(u.getUserId());
	 			lg.setStatus("ACTIVE");
	 			// encrypt the password
	 			if (lg.getPassword() != null) {
	 				String pswd = lg.getPassword();
	 				lg.setPassword(loginManager.encryptPassword(pswd));
	 			}
	 			loginManager.addLogin(lg);
	 		}
	 	}
	 	
	}
	
	private ResponseCode addGroups(ProvisionUser user, String newUserId, List<IdmAuditLog> logList) {
		List<Group> groupList = user.getMemberOfGroups();

		if (groupList != null) {
			for ( Group g : groupList) {
				// check if the group id is valid
				if (g.getGrpId() == null) {
					return ResponseCode.GROUP_ID_NULL;
				}
				if ( groupManager.getGroup(g.getGrpId()) == null)  {
					if (g.getGrpId() == null) {
						return ResponseCode.GROUP_ID_NULL;
					}				
				}
				groupManager.addUserToGroup(g.getGrpId(), newUserId);
                // add to audit log
                 logList.add( auditHelper.createLogObject("ADD GROUP", user.getRequestorDomain(), user.getRequestorLogin(),
                    "IDM SERVICE", user.getCreatedBy(), "0", "USER", user.getUserId(),
                    null, "SUCCESS", null, "USER_STATUS",
                    user.getUser().getStatus().toString(),
                    null, null, user.getSessionId(), null, g.getGrpName(),
                    user.getRequestClientIP(), null, null) );

			}
		}	
		return ResponseCode.SUCCESS;
	}



	private ResponseCode addRoles(ProvisionUser user, String newUserId, List<IdmAuditLog> logList) {
		List<Role> roleList = user.getMemberOfRoles();
		log.debug("Role list = " + roleList);
		if (roleList != null && roleList.size() > 0) {
			for (Role r: roleList) {
				// check if the roleId is valid
				if (r.getId().getServiceId() == null || r.getId().getRoleId() == null) {
					return ResponseCode.ROLE_ID_NULL;			
				}
				if (roleDataService.getRole(r.getId().getServiceId(), r.getId().getRoleId()) == null ) {
					return ResponseCode.ROLE_ID_INVALID;			
				}

				UserRole ur = new UserRole(newUserId, r.getId().getServiceId(), r.getId().getRoleId());

				if ( r.getStartDate() != null) {
					ur.setStartDate(r.getStartDate());
				}
				if ( r.getEndDate() != null ) {
					ur.setEndDate(r.getEndDate());
				}
				roleDataService.assocUserToRole(ur);


                logList.add( auditHelper.createLogObject("ADD ROLE", user.getRequestorDomain(), user.getRequestorLogin(),
                    "IDM SERVICE", user.getCreatedBy(), "0", "USER", user.getUserId(),
                    null, "SUCCESS", null, "USER_STATUS",
                    user.getUser().getStatus().toString(),
                    "NA", null, user.getSessionId(), null, ur.getRoleId(),
                        user.getRequestClientIP(), null, null) );


			}
		}	
		return ResponseCode.SUCCESS;
	}


    private ResponseCode addAffiliations(ProvisionUser user, String newUserId, List<IdmAuditLog> logList) {
		List<Organization> affiliationList = user.getUserAffiliations();
		log.debug("addAffiliations:Affiliation List list = " + affiliationList);
		if (affiliationList != null && affiliationList.size() > 0) {
			for (Organization org: affiliationList) {
				// check if the roleId is valid
                if (org.getOrgId() == null) {
                    return ResponseCode.OBJECT_ID_INVALID;
                }
                orgManager.addUserToOrg(org.getOrgId(), user.getUserId());

                logList.add( auditHelper.createLogObject("ADD AFFILIATION", user.getRequestorDomain(), user.getRequestorLogin(),
                    "IDM SERVICE", user.getCreatedBy(), "0", "USER", user.getUserId(),
                    null, "SUCCESS", null, "USER_STATUS",
                    user.getUser().getStatus().toString(),
                    "NA", null, user.getSessionId(), null, org.getOrganizationName(),
                        user.getRequestClientIP(), null, null) );


			}
		}
		return ResponseCode.SUCCESS;
	}

	/**
	 * Builds the list of principals from the policies that we have defined in the groovy scripts.
	 * @param user
	 * @param bindingMap
	 * @param se
	 */
	public void buildPrimaryPrincipal( ProvisionUser user, 
			Map<String, Object> bindingMap, 
			ScriptIntegration se) {

 		List<Login> principalList = new ArrayList<Login>();
 		List<AttributeMap> policyAttrMap = this.managedSysService.getResourceAttributeMaps(sysConfiguration.getDefaultManagedSysId());
 		//List<AttributeMap> policyAttrMap = resourceDataService.getResourceAttributeMaps(sysConfiguration.getDefaultManagedSysId());
 		
 		log.debug("Building primary identity. "); 
 		
 		if (policyAttrMap != null) {
 			
 			log.debug("- policyAttrMap IS NOT null");
 			
 			Login primaryIdentity = new Login();
 			LoginId primaryID = new LoginId();
 			EmailAddress primaryEmail = new EmailAddress();
 			
 			// init values
 			primaryID.setDomainId(sysConfiguration.getDefaultSecurityDomain());
 			primaryID.setManagedSysId(sysConfiguration.getDefaultManagedSysId());
 			
 			try {
				for (  AttributeMap attr : policyAttrMap ) {
					Policy policy = attr.getAttributePolicy();
					String url = policy.getRuleSrcUrl();
					if (url != null) {
						String output = (String)se.execute(bindingMap, url);
						String objectType = attr.getMapForObjectType();
						if (objectType != null) {
							if (objectType.equalsIgnoreCase("PRINCIPAL")) {
								if (attr.getAttributeName().equalsIgnoreCase("PRINCIPAL")) {
									primaryID.setLogin(output);
								}
								if (attr.getAttributeName().equalsIgnoreCase("PASSWORD")) {
									primaryIdentity.setPassword(output);
								}
								if (attr.getAttributeName().equalsIgnoreCase("DOMAIN")) {
									primaryID.setDomainId(output);
								}
							}
							if (objectType.equals("EMAIL")) {
								primaryEmail.setEmailAddress(output);
								primaryEmail.setIsDefault(1);
							}
						}
					}
				}
	 			}catch(Exception e) {
 				log.error(e);
 			}
			primaryIdentity.setId(primaryID);
			principalList.add(primaryIdentity);
			user.setPrincipalList(principalList);
			user.getEmailAddress().add(primaryEmail);
 			
 		}else {
 			log.debug("- policyAttrMap IS null");
 		}

		
	}

    /**
     * when a request already contains an identity and password has not been setup, this method generates a password 
     * based on our rules.
     * @param user
     * @param bindingMap
     * @param se
     */
    public void setPrimaryIDPassword( ProvisionUser user,
                                       Map<String, Object> bindingMap,
                                       ScriptIntegration se) {
        
        
        // this method should only be the called if the request already contains 1 or more identities

        List<Login> principalList = user.getPrincipalList();
        List<AttributeMap> policyAttrMap = this.managedSysService.getResourceAttributeMaps(sysConfiguration.getDefaultManagedSysId());
        //List<AttributeMap> policyAttrMap = resourceDataService.getResourceAttributeMaps(sysConfiguration.getDefaultManagedSysId());

        log.debug("setPrimaryIDPassword() ");

        if (policyAttrMap != null) {

            log.debug("- policyAttrMap IS NOT null");

            Login primaryIdentity =  user.getPrimaryPrincipal(sysConfiguration.getDefaultManagedSysId());

          //  Login primaryIdentity = new Login();
          //  LoginId primaryID = new LoginId();
         //   EmailAddress primaryEmail = new EmailAddress();

            // init values
        //    primaryID.setDomainId(sysConfiguration.getDefaultSecurityDomain());
        //    primaryID.setManagedSysId(sysConfiguration.getDefaultManagedSysId());

            try {
                for (  AttributeMap attr : policyAttrMap ) {
                    Policy policy = attr.getAttributePolicy();
                    String url = policy.getRuleSrcUrl();
                    if (url != null) {
                        String output = (String)se.execute(bindingMap, url);
                        String objectType = attr.getMapForObjectType();
                        if (objectType != null) {
                            if (objectType.equalsIgnoreCase("PRINCIPAL")) {

                                if (attr.getAttributeName().equalsIgnoreCase("PASSWORD")) {
                                    primaryIdentity.setPassword(output);
                                }

                            }

                        }
                    }
                }
            }catch(Exception e) {
                log.error(e);
            }
            //primaryIdentity.setId(primaryID);
            //principalList.add(primaryIdentity);
            user.setPrincipalList(principalList);
            //user.getEmailAddress().add(primaryEmail);

        }else {
            log.debug("- policyAttrMap IS null");
        }


    }

    /**
     * If the user has selected roles that are in multiple domains, we need to make sure that they identities for
     * each of these domains
     * @param primaryIdentity
     * @param roleList
     */
    public void validateIdentitiesExistforSecurityDomain(Login primaryIdentity, List<Role> roleList) {
        if (roleList == null || roleList.isEmpty()) {
            return;
        }

        List<Login> identityList = loginManager.getLoginByUser(primaryIdentity.getUserId());

        for (Role r : roleList) {

                String secDomain = r.getId().getServiceId();
                if (!identityInDomain(secDomain,identityList)) {
                    addIdentity(secDomain, primaryIdentity);
                }

        }

    }

    private boolean identityInDomain(String secDomain, List<Login> identityList) {
        for (Login l : identityList) {
            if ( l.getId().getDomainId().equalsIgnoreCase(secDomain)) {
                return true;
            }

        }
        return false;

    }

    private void addIdentity(String secDomain, Login primaryIdentity) {
        if ( loginManager.getLoginByManagedSys(secDomain,primaryIdentity.getId().getLogin(), primaryIdentity.getId().getManagedSysId()) == null ){

            LoginId id = new LoginId(secDomain,primaryIdentity.getId().getLogin(), primaryIdentity.getId().getManagedSysId());

            Login newLg = new Login();

            newLg.setId(id);
            newLg.setAuthFailCount(0);
            newLg.setFirstTimeLogin(primaryIdentity.getFirstTimeLogin());
            newLg.setIsLocked(primaryIdentity.getIsLocked());
            newLg.setLastAuthAttempt(primaryIdentity.getLastAuthAttempt());
            newLg.setGracePeriod(primaryIdentity.getGracePeriod());
            newLg.setManagedSysName(primaryIdentity.getManagedSysName());
            newLg.setPassword(primaryIdentity.getPassword());
            newLg.setPasswordChangeCount(primaryIdentity.getPasswordChangeCount());
            newLg.setStatus(primaryIdentity.getStatus());
            newLg.setIsLocked(primaryIdentity.getIsLocked());
            newLg.setOrigPrincipalName(primaryIdentity.getOrigPrincipalName());
            newLg.setUserId(primaryIdentity.getUserId());
            newLg.setResetPassword(primaryIdentity.getResetPassword());


            log.debug("Adding identity = " + newLg);

            loginManager.addLogin(newLg);
        }


    }

	                       
	public RoleDataService getRoleDataService() {
		return roleDataService;
	}
	public void setRoleDataService(RoleDataService roleDataService) {
		this.roleDataService = roleDataService;
	}
	public GroupDataService getGroupManager() {
		return groupManager;
	}
	public void setGroupManager(GroupDataService groupManager) {
		this.groupManager = groupManager;
	}
	public UserDataService getUserMgr() {
		return userMgr;
	}
	public void setUserMgr(UserDataService userMgr) {
		this.userMgr = userMgr;
	}
	public LoginDataService getLoginManager() {
		return loginManager;
	}
	public void setLoginManager(LoginDataService loginManager) {
		this.loginManager = loginManager;
	}

	public SysConfiguration getSysConfiguration() {
		return sysConfiguration;
	}

	public void setSysConfiguration(SysConfiguration sysConfiguration) {
		this.sysConfiguration = sysConfiguration;
	}

	public ResourceDataService getResourceDataService() {
		return resourceDataService;
	}

	public void setResourceDataService(ResourceDataService resourceDataService) {
		this.resourceDataService = resourceDataService;
	}

	public ManagedSystemDataService getManagedSysService() {
		return managedSysService;
	}

	public void setManagedSysService(ManagedSystemDataService managedSysService) {
		this.managedSysService = managedSysService;
	}

    public AuditHelper getAuditHelper() {
        return auditHelper;
    }

    public void setAuditHelper(AuditHelper auditHelper) {
        this.auditHelper = auditHelper;
    }

    public OrganizationDataService getOrgManager() {
        return orgManager;
    }

    public void setOrgManager(OrganizationDataService orgManager) {
        this.orgManager = orgManager;
    }
}
