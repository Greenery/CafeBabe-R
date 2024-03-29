package org.openiam.selfsrvc.hire;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Date;
import java.util.Map;
import java.util.Set;
import java.text.SimpleDateFormat;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.openiam.idm.srvc.user.dto.*;
import org.openiam.selfsrvc.IdToObjectHelper;
import org.openiam.selfsrvc.usradmin.DelegationFilterHelper;
import org.springframework.validation.BindException;
import org.springframework.validation.Errors;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractWizardFormController;
import org.springframework.beans.propertyeditors.CustomDateEditor;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openiam.base.ws.ResponseStatus;
import org.openiam.idm.srvc.cd.dto.ReferenceData;
import org.openiam.idm.srvc.cd.service.ReferenceDataService;
import org.openiam.idm.srvc.continfo.dto.Address;
import org.openiam.idm.srvc.continfo.dto.ContactConstants;
import org.openiam.idm.srvc.continfo.dto.EmailAddress;
import org.openiam.idm.srvc.continfo.dto.Phone;
import org.openiam.idm.srvc.user.service.UserDataService;
import org.openiam.idm.srvc.user.ws.UserDataWebService;
import org.openiam.idm.srvc.user.ws.UserResponse;
import org.openiam.idm.srvc.audit.dto.IdmAuditLog;
import org.openiam.idm.srvc.audit.ws.IdmAuditLogWebDataService;
import org.openiam.idm.srvc.auth.dto.LoginId;
import org.openiam.idm.srvc.auth.dto.Login;
import org.openiam.idm.srvc.auth.login.LoginDataService;
import org.openiam.idm.srvc.grp.dto.Group;
import org.openiam.idm.srvc.grp.ws.GroupDataWebService;
import org.openiam.idm.srvc.org.dto.Organization;
import org.openiam.idm.srvc.org.service.OrganizationDataService;

import org.openiam.idm.srvc.policy.service.PolicyDataService;
import org.openiam.idm.srvc.prov.request.dto.ProvisionRequest;
import org.openiam.idm.srvc.prov.request.dto.ProvisioningConstants;
import org.openiam.idm.srvc.prov.request.dto.RequestUser;
import org.openiam.idm.srvc.prov.request.service.RequestDataService;
import org.openiam.idm.srvc.prov.request.ws.RequestWebService;
import org.openiam.idm.srvc.res.dto.Resource;
import org.openiam.idm.srvc.res.service.ResourceDataService;
import org.openiam.idm.srvc.role.dto.Role;
import org.openiam.idm.srvc.role.dto.RoleId;
import org.openiam.idm.srvc.role.ws.RoleDataWebService;

import org.openiam.idm.srvc.secdomain.service.SecurityDomainDataService;
import org.openiam.idm.srvc.loc.dto.Location;
import org.openiam.idm.srvc.loc.ws.LocationDataWebService;
import org.openiam.idm.srvc.menu.ws.NavigatorDataWebService;
import org.openiam.idm.srvc.mngsys.dto.ManagedSys;
import org.openiam.idm.srvc.mngsys.service.ManagedSystemDataService;
import org.openiam.provision.dto.ProvisionUser;
import org.openiam.provision.resp.ProvisionUserResponse;
import org.openiam.provision.service.ProvisionService;
import org.openiam.selfsrvc.pswd.PasswordConfiguration;
import com.thoughtworks.xstream.XStream;


/**
 * Controller for the NewUserNoAppController form. This New User form does not have an approval step. The user is created automatically.
 * @author suneet
 *
 */
public class NewUserNoAppController extends AbstractWizardFormController {

	protected GroupDataWebService groupManager;
	protected RoleDataWebService roleDataService;	
	protected ResourceDataService resourceDataService;
	protected SecurityDomainDataService secDomainService;
	protected OrganizationDataService orgManager;
	protected LocationDataWebService locationService;
	protected NavigatorDataWebService navigatorDataService;
	protected ManagedSystemDataService managedSysService;
	protected UserDataWebService userMgr;
	
	protected RequestWebService provRequestService;
	
	protected ReferenceDataService refDataService;
	protected PasswordConfiguration configuration;
	protected PolicyDataService policyDataService;
	
	protected ProvisionService provisionService;
	protected IdmAuditLogWebDataService auditService;
    protected Boolean emailCredentialsToUser;
    private IdToObjectHelper listToObject;

	String defaultDomainId;
	String menuGroup;
	
	private static final Log log = LogFactory.getLog(NewUserNoAppController.class);

	
	public NewUserNoAppController() {
		super();
	}

	/* ----- overridden methods from the springframework ----------------- */

	@Override
	protected void initBinder(HttpServletRequest request,
			ServletRequestDataBinder binder) throws Exception {
		
		binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("MM/dd/yyyy"),true) );
	}
	
	@Override
	protected void validatePage(Object command, Errors errors, int page) {
		log.debug("Validate page:" + page);
		NewUserNoAppValidator validator = (NewUserNoAppValidator)getValidator();
		switch (page) {
		case 0: 
			validator.validateNewHireForm(command, errors);
			break;
		case 1:
			//validator.validateUnlockVerifyIdentity(command, errors);
			break;
		}
		
	}

	protected ModelAndView processCancel(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors)
			throws Exception {
		
		Map model = new HashMap();   
        model.put("message", "Request to reset the password has been canceled");   
        return new ModelAndView("pub/cancel");   
        
	}
	
	
	@Override
	protected Object formBackingObject(HttpServletRequest request) 			throws Exception {
				
		NewUserNoAppCommand cmd = new NewUserNoAppCommand();
		//cmd.setResourceList(resourceList);
		
		return cmd;
	}
	
	@Override
	protected Map referenceData(HttpServletRequest request, int page) throws Exception {
		switch (page) {
		case 0:
			return loadUserInformation(request);
		case 1:
			return loadAppInformation(request);
		}
		return null;
	}

	
	protected ModelAndView processFinish(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException arg3)
			throws Exception {
		
		log.info("In processFinish..");
		
		NewUserNoAppCommand newHireCmd =(NewUserNoAppCommand)command;
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");

		User user = newHireCmd.getUser();
		prepareObject(user, userId);
		
	
		log.info("User=" + user);
		
       ProvisionUser pUser = new ProvisionUser(user);
        if (newHireCmd.getSupervisorId() != null && newHireCmd.getSupervisorId().length() > 0) {
        	User supervisorUser = new User(newHireCmd.getSupervisorId());
        	Supervisor sup = new Supervisor();
    		sup.setSupervisor(supervisorUser);
    		sup.setStatus("ACTIVE");
    		sup.setSupervisor(supervisorUser);
    		pUser.setSupervisor(sup);
        }

        setEmail(newHireCmd, pUser);
        setPhone(newHireCmd, pUser);
   
        /* should be created by the service based on the policies */
    //    pUser.setPrincipalList(getPrincipalList(newHireCmd,user));
        
        if (newHireCmd.getGroup() != null && !newHireCmd.getGroup().isEmpty()) {
        	pUser.setMemberOfGroups(getGroupList(newHireCmd, user));
        }
        if (newHireCmd.getRole() != null && !newHireCmd.getRole().isEmpty()) {
        	pUser.setMemberOfRoles(getRoleList(newHireCmd, user));
        }

        pUser.setEmailCredentialsToNewUsers(emailCredentialsToUser);
        
        log.info("User created. New User Id: " + user.getUserId());
        
        
        this.provisionService.addUser(pUser);
        
    
		
        // log the request
		IdmAuditLog log = new IdmAuditLog( "REQUEST-APPROVAL", "NEW HIRE", "SUCCESS", null, configuration.getDefaultSecurityDomain(),
				userId,  (String)request.getSession().getAttribute("login"), 
				null,
				request.getRemoteAddr());
        log.setReqUrl(request.getRequestURL().toString());
		log.setSessionId(request.getSession().getId());
		auditService.addLog(log);
              
  
	    return new ModelAndView("pub/confirm");   
	        
	}
	
	/*-------------         Helper methods         ---------------------------*/


    private void setEmail(NewUserNoAppCommand cmd, ProvisionUser pUser) {

        String email = cmd.getEmail1();
        String emailId = cmd.getEmail1Id();
        if (email != null && email.length() > 0) {
            EmailAddress em = buildEmail(emailId, email,"EMAIL1");
            pUser.getEmailAddress().add(em);
            pUser.setEmail(email);
        }



    }

    private void setPhone(NewUserNoAppCommand cmd, ProvisionUser usr) {
        //	Set<Phone> phSet = usr.getPhone();

        // add obbject


        Phone ph = buildPhone( usr, "DESK PHONE", cmd.getWorkAreaCode(), cmd.getWorkPhone());
        if (cmd.getWorkPhoneId() != null && cmd.getWorkPhoneId().length() > 0 ) {
            ph.setPhoneId(cmd.getWorkPhoneId());
        }
        usr.getPhone().add(ph);


        ph = buildPhone( usr, "FAX", cmd.getFaxAreaCode(), cmd.getFaxPhone() );
        if (cmd.getFaxPhoneId() != null && cmd.getFaxPhoneId().length() > 0 ) {
            ph.setPhoneId(cmd.getFaxPhoneId());
        }
        usr.getPhone().add(ph);



    }

    private EmailAddress buildEmail(String emailId, String email, String name) {
        EmailAddress em = new EmailAddress();
        em.setEmailAddress(email);
        if (emailId != null && emailId.length() > 0) {
            em.setEmailId(emailId);
        }
        em.setParentType(ContactConstants.PARENT_TYPE_USER);
        em.setName(name);
        return em;
    }

    private Phone buildPhone( ProvisionUser usr, String name,
                              String areaCode, String phone) {
        Phone ph = new Phone();

        ph.setAreaCd(areaCode);
        ph.setPhoneNbr(phone);
        ph.setDescription(name);
        ph.setParentType(ContactConstants.PARENT_TYPE_USER);
        ph.setName(name);
        ph.setParentId(usr.getUserId());

        return ph;
    }



	private List<Group> getGroupList(NewUserNoAppCommand newHireCmd, User user) {
		List<Group> groupList = new ArrayList<Group>();
		String groupId = newHireCmd.getGroup();
		Group g = new Group();
		g.setGrpId(groupId);
		groupList.add(g);
		return groupList;
	}
	private List<Role> getRoleList(NewUserNoAppCommand newHireCmd, User user) {
		List<Role> roleList = new ArrayList<Role>();
		String roleId = newHireCmd.getRole();
		RoleId id = new RoleId(configuration.getDefaultSecurityDomain() , roleId);
		Role r = new Role();
		r.setId(id);
		roleList.add(r);
		
		return roleList;
	}

     private List<Organization> getFilteredList(List<String> idList, List<Organization> orgList) {
        System.out.println("Building filter org list");

        if (orgList == null) {
            return null;
        }
        if (idList == null) {
            return orgList;
        }

        List<Organization> newOrgList = new ArrayList<Organization>();
        for (Organization org : orgList) {

            if (idList.contains( org.getOrgId())) {

                newOrgList.add(org);
            }else {

            }
        }
        System.out.println("Org List =" + newOrgList);
        return newOrgList;

    }


	
	protected Map loadUserInformation(HttpServletRequest request) {
		log.info("referenceData called.");
		
		HttpSession session =  request.getSession();
        User usr = (User)session.getAttribute("userObj");

        List<Organization> orgList = null;
        List<Organization> divList = null;
        List<Organization> deptList = null;
        List<Role> roleList = null;
        List<Group> groupList =null;

        if (usr.getDelAdmin() != null && usr.getDelAdmin().intValue() == 1) {
            Map<String, UserAttribute> attrMap = usr.getUserAttributes();

            orgList =  getFilteredList(DelegationFilterHelper.getOrgIdFilterFromString(attrMap), orgManager.getOrganizationList(null,"ACTIVE")) ;

            divList =  getFilteredList(DelegationFilterHelper.getDivisionFilterFromString(attrMap), orgManager.allDivisions(null) ) ;

            deptList =  getFilteredList(DelegationFilterHelper.getDeptFilterFromString(attrMap), orgManager.allDepartments(null) ) ;

            groupList =  listToObject.groupList(attrMap);

            // filter the role
            List<String> roleIdList = DelegationFilterHelper.getRoleFilterFromString(attrMap);
            List<Role> completeRoleList =  roleDataService.getAllRoles().getRoleList();


            if (roleIdList == null) {
                roleList = completeRoleList;
            }else {
                // apply filter
                roleList = new ArrayList<Role>();
                for (Role r : completeRoleList) {

                    System.out.println("Role id = " + r.getId().getRoleId());

                    if (roleIdList.contains(r.getId().getServiceId() + "*" + r.getId().getRoleId())) {

                       System.out.println("Role found and added to roleList");
                       roleList.add(r);
                    }
                }
            }



        }else {
            orgList = orgManager.getTopLevelOrganizations();
            // get the divisions
            divList = orgManager.allDivisions(null);
            // load the department list
            deptList = orgManager.allDepartments(null);

            roleList = roleDataService.getAllRoles().getRoleList();

            groupList = groupManager.getAllGroups().getGroupList();

        }


		
		// get the list of job codes
		List<ReferenceData> jobCodeList = refDataService.getRefByGroup("JOB_CODE", "en");
		
		// get the list of user type codes
		List<ReferenceData> userTypeList = refDataService.getRefByGroup("USER_TYPE", "en");
		
		// get location list and the address for the user
		Location[] locationAry = locationService.allLocations().getLocationAry();
		
		Map model = new HashMap();
		model.put("orgList",orgList);
		model.put("divList",divList);
		model.put("deptList",deptList);
		model.put("groupList",groupList);
		model.put("roleList", roleList);
		model.put("jobCodeList",jobCodeList);
		model.put("userTypeList", userTypeList);
		model.put("locationAry", locationAry);
		
		return model;
		
	}
	protected Map loadAppInformation(HttpServletRequest request) {
		Map model = new HashMap();
		
		List<Resource> resourceList = resourceDataService.getResourcesByType(this.configuration.getManagedSystemType());
		model.put("resourceList", resourceList);
		
		//List<Role> roleList = roleDataService.getAllRoles().getRoleList();
		//model.put("appRoleList", roleList);		
		
		return model;
		
	}
	
	private void prepareObject(User user, String userId) {
		// need userId to be null so that persistence layer will generate a uid for the user
		user.setUserId(null);
		user.setCreateDate(new Date(System.currentTimeMillis()));
		user.setCreatedBy(userId);
		user.setStatus(UserStatusEnum.PENDING_INITIAL_LOGIN);
		
	}
	


	public String getDefaultDomainId() {
		return defaultDomainId;
	}


	public void setDefaultDomainId(String defaultDomainId) {
		this.defaultDomainId = defaultDomainId;
	}



	public String getMenuGroup() {
		return menuGroup;
	}


	public void setMenuGroup(String menuGroup) {
		this.menuGroup = menuGroup;
	}




	public OrganizationDataService getOrgManager() {
		return orgManager;
	}


	public void setOrgManager(OrganizationDataService orgManager) {
		this.orgManager = orgManager;
	}




	public ReferenceDataService getRefDataService() {
		return refDataService;
	}


	public void setRefDataService(ReferenceDataService refDataService) {
		this.refDataService = refDataService;
	}


	public PasswordConfiguration getConfiguration() {
		return configuration;
	}


	public void setConfiguration(PasswordConfiguration configuration) {
		this.configuration = configuration;
	}


	public ResourceDataService getResourceDataService() {
		return resourceDataService;
	}


	public void setResourceDataService(ResourceDataService resourceDataService) {
		this.resourceDataService = resourceDataService;
	}


	public PolicyDataService getPolicyDataService() {
		return policyDataService;
	}


	public void setPolicyDataService(PolicyDataService policyDataService) {
		this.policyDataService = policyDataService;
	}


	public SecurityDomainDataService getSecDomainService() {
		return secDomainService;
	}


	public void setSecDomainService(SecurityDomainDataService secDomainService) {
		this.secDomainService = secDomainService;
	}


	public ProvisionService getProvisionService() {
		return provisionService;
	}


	public void setProvisionService(ProvisionService provisionService) {
		this.provisionService = provisionService;
	}


	public GroupDataWebService getGroupManager() {
		return groupManager;
	}


	public void setGroupManager(GroupDataWebService groupManager) {
		this.groupManager = groupManager;
	}


	public RoleDataWebService getRoleDataService() {
		return roleDataService;
	}


	public void setRoleDataService(RoleDataWebService roleDataService) {
		this.roleDataService = roleDataService;
	}


	public LocationDataWebService getLocationService() {
		return locationService;
	}


	public void setLocationService(LocationDataWebService locationService) {
		this.locationService = locationService;
	}


	public NavigatorDataWebService getNavigatorDataService() {
		return navigatorDataService;
	}


	public void setNavigatorDataService(NavigatorDataWebService navigatorDataService) {
		this.navigatorDataService = navigatorDataService;
	}

	public IdmAuditLogWebDataService getAuditService() {
		return auditService;
	}

	public void setAuditService(IdmAuditLogWebDataService auditService) {
		this.auditService = auditService;
	}



	public ManagedSystemDataService getManagedSysService() {
		return managedSysService;
	}

	public void setManagedSysService(ManagedSystemDataService managedSysService) {
		this.managedSysService = managedSysService;
	}

	public UserDataWebService getUserMgr() {
		return userMgr;
	}

	public void setUserMgr(UserDataWebService userMgr) {
		this.userMgr = userMgr;
	}

	public RequestWebService getProvRequestService() {
		return provRequestService;
	}

	public void setProvRequestService(RequestWebService provRequestService) {
		this.provRequestService = provRequestService;
	}


    public Boolean getEmailCredentialsToUser() {
        return emailCredentialsToUser;
    }

    public void setEmailCredentialsToUser(Boolean emailCredentialsToUser) {
        this.emailCredentialsToUser = emailCredentialsToUser;
    }

    public IdToObjectHelper getListToObject() {
        return listToObject;
    }

    public void setListToObject(IdToObjectHelper listToObject) {
        this.listToObject = listToObject;
    }
}
