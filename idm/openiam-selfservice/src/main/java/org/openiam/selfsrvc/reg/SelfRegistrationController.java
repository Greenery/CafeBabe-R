package org.openiam.selfsrvc.reg;


import com.thoughtworks.xstream.XStream;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openiam.idm.srvc.auth.ws.LoginDataWebService;
import org.openiam.idm.srvc.cd.dto.ReferenceData;
import org.openiam.idm.srvc.cd.service.ReferenceDataService;
import org.openiam.idm.srvc.continfo.dto.Address;
import org.openiam.idm.srvc.continfo.dto.ContactConstants;
import org.openiam.idm.srvc.continfo.dto.EmailAddress;
import org.openiam.idm.srvc.continfo.dto.Phone;
import org.openiam.idm.srvc.grp.dto.Group;
import org.openiam.idm.srvc.grp.ws.GroupDataWebService;
import org.openiam.idm.srvc.loc.dto.Location;
import org.openiam.idm.srvc.loc.ws.LocationDataWebService;
import org.openiam.idm.srvc.menu.ws.NavigatorDataWebService;
import org.openiam.idm.srvc.mngsys.dto.ApproverAssociation;
import org.openiam.idm.srvc.mngsys.service.ManagedSystemDataService;
import org.openiam.idm.srvc.msg.dto.NotificationParam;
import org.openiam.idm.srvc.msg.dto.NotificationRequest;
import org.openiam.idm.srvc.msg.service.MailService;
import org.openiam.idm.srvc.org.dto.Organization;
import org.openiam.idm.srvc.org.service.OrganizationDataService;
import org.openiam.idm.srvc.policy.service.PolicyDataService;
import org.openiam.idm.srvc.prov.request.dto.ProvisionRequest;
import org.openiam.idm.srvc.prov.request.dto.ProvisioningConstants;
import org.openiam.idm.srvc.prov.request.dto.RequestApprover;
import org.openiam.idm.srvc.prov.request.dto.RequestUser;
import org.openiam.idm.srvc.prov.request.ws.RequestWebService;
import org.openiam.idm.srvc.res.dto.Resource;
import org.openiam.idm.srvc.res.service.ResourceDataService;
import org.openiam.idm.srvc.role.dto.Role;
import org.openiam.idm.srvc.role.dto.RoleId;
import org.openiam.idm.srvc.role.ws.RoleDataWebService;
import org.openiam.idm.srvc.secdomain.service.SecurityDomainDataService;
import org.openiam.idm.srvc.user.dto.DelegationFilterSearch;
import org.openiam.idm.srvc.user.dto.Supervisor;
import org.openiam.idm.srvc.user.dto.User;
import org.openiam.idm.srvc.user.dto.UserStatusEnum;
import org.openiam.idm.srvc.user.ws.UserDataWebService;
import org.openiam.provision.dto.ProvisionUser;
import org.openiam.provision.service.ProvisionService;
import org.openiam.selfsrvc.hire.NewHireCommand;
import org.openiam.selfsrvc.pswd.PasswordConfiguration;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.CancellableFormController;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * Controller for the new hire form.
 *
 * @author suneet
 */
public class SelfRegistrationController extends CancellableFormController {

    protected LoginDataWebService loginManager;
    protected GroupDataWebService groupManager;
    protected RoleDataWebService roleDataService;
    protected MailService mailService;
    protected NavigatorDataWebService navigatorDataService;
    protected RequestWebService provRequestService;
    protected OrganizationDataService orgManager;
    protected LocationDataWebService locationService;

    protected ReferenceDataService refDataService;
    protected PasswordConfiguration configuration;
    protected ResourceDataService resourceDataService;
    protected PolicyDataService policyDataService;
    protected SecurityDomainDataService secDomainService;
    protected ManagedSystemDataService managedSysService;

    protected ProvisionService provisionService;

    String defaultDomainId;
    String menuGroup;


    UserDataWebService userMgr;
    protected String requestType;


    public UserDataWebService getUserMgr() {
        return userMgr;
    }


    public void setUserMgr(UserDataWebService userMgr) {
        this.userMgr = userMgr;
    }


    private static final Log log = LogFactory.getLog(SelfRegistrationController.class);


    public SelfRegistrationController() {
        super();
    }


    @Override
    protected void initBinder(HttpServletRequest request,
                              ServletRequestDataBinder binder) throws Exception {

        binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("MM/dd/yyyy"), true));
    }

    @Override
    protected ModelAndView onCancel(Object command) throws Exception {
        // return super.onCancel(command);    //To change body of overridden methods use File | Settings | File Templates.
        return new ModelAndView(new RedirectView(this.getCancelView(), true));
    }




    private List<Group> getGroupList(SelfRegistrationCommand newHireCmd, User user) {
        List<Group> groupList = new ArrayList<Group>();
        String groupId = newHireCmd.getGroup();
        Group g = new Group();
        g.setGrpId(groupId);
        groupList.add(g);
        return groupList;
    }

    private List<Role> getRoleList(SelfRegistrationCommand newHireCmd, User user) {

           List<Role> roleList = new ArrayList<Role>();
           String cmdRole = newHireCmd.getRole();


           StringTokenizer rl = new StringTokenizer(cmdRole, ",");
           while (rl.hasMoreTokens()) {

               String roleElement = rl.nextToken();

               /* parse the role */
               String domainId = null;
               String roleId = null;

               StringTokenizer st = new StringTokenizer(roleElement, "*");
               if (st.hasMoreTokens()) {
                   domainId = st.nextToken();
               }
               if (st.hasMoreElements()) {
                   roleId = st.nextToken();
               }
               RoleId id = new RoleId(domainId , roleId);
               Role r = new Role();
               r.setId(id);
               roleList.add(r);
           }

           return roleList;

       }



    @Override
    protected ModelAndView onSubmit(HttpServletRequest request,
                                    HttpServletResponse response, Object command, BindException errors)
            throws Exception {

        log.info("In processFinish..");

        SelfRegistrationCommand newHireCmd = (SelfRegistrationCommand) command;
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        User user = newHireCmd.getUser();
        prepareObject(user, userId);

        log.info("User=" + user);

        ProvisionUser pUser = new ProvisionUser(user);

        setEmail(newHireCmd, pUser);
        setAddress(newHireCmd, pUser);
        setPhone(newHireCmd, pUser);




        if (newHireCmd.getGroup() != null && !newHireCmd.getGroup().isEmpty()) {
            pUser.setMemberOfGroups(getGroupList(newHireCmd, user));
        }
        if (newHireCmd.getRole() != null && !newHireCmd.getRole().isEmpty()) {
            pUser.setMemberOfRoles(getRoleList(newHireCmd, user));
        }


        // create the request 
        log.info("User created. New User Id: " + user.getUserId());


        /* serialize the object into xml */
        String userAsXML = toXML(pUser);
        log.info("pUser serialized to XML:" + userAsXML);

        ProvisionRequest pReq = createRequest(userId, user, userAsXML, pUser);

        //
        // send a notification to the approver

        //

        ModelAndView mav = new ModelAndView(getSuccessView());
        mav.addObject("newHireCmd", newHireCmd);


        return mav;

    }


    private String toXML(ProvisionUser pUser) {
        XStream xstream = new XStream();
        return xstream.toXML(pUser);

    }

    private ProvisionRequest createRequest(String userId, User usr, String asXML, ProvisionUser pUser) {

        String approverId = null;

        Resource newUserResource = resourceDataService.getResource(requestType);

        Date curDate = new Date(System.currentTimeMillis());


        ProvisionRequest req = new ProvisionRequest();
        req.setRequestorId("ANONYMOUS");
        req.setStatus("PENDING");
        req.setStatusDate(curDate);
        req.setRequestDate(curDate);
        req.setRequestType(newUserResource.getResourceId());
        req.setRequestReason(newUserResource.getDescription() + " FOR:" + usr.getFirstName() + " " + usr.getLastName());

        if (usr.getCompanyId() != null && usr.getCompanyId().length() > 0) {
            req.setRequestForOrgId(usr.getCompanyId());
        }

        req.setRequestXML(asXML);


        //req.setManagedResourceId(managedResource.getManagedSysId());

        // add a user to the request - this is the person in the New Hire
        Set<RequestUser> reqUserSet = req.getRequestUsers();
        RequestUser reqUser = new RequestUser();
        reqUser.setFirstName(usr.getFirstName());
        reqUser.setLastName(usr.getLastName());
        reqUserSet.add(reqUser);

        String approverRole = null;
        String userOrg = null;
        int applyDelegationFilter = 0;

        // add the approver to the request object.
        List<ApproverAssociation> apList = managedSysService.getApproverByRequestType(requestType, 1);
        if (apList != null) {

            for (ApproverAssociation ap : apList)  {
                String approverType;
                String roleDomain = null;

                if (ap != null) {
                    approverType = ap.getAssociationType();
                    System.out.println("Approver =" + ap.getApproverRoleId());

                    if ( ap.getAssociationType().equalsIgnoreCase("SUPERVISOR")) {
                        Supervisor supVisor = pUser.getSupervisor();
                        approverId = supVisor.getSupervisor().getUserId();


                    } else if ( ap.getAssociationType().equalsIgnoreCase("ROLE")) {
                        approverId = ap.getApproverRoleId();
                        roleDomain = ap.getApproverRoleDomain();

                        approverRole = ap.getApproverRoleId();
                        if (ap.getApplyDelegationFilter() != null) {
                            applyDelegationFilter = ap.getApplyDelegationFilter().intValue();
                        }
                        if (usr.getCompanyId() != null) {
                            userOrg = usr.getCompanyId();
                        }


                    } else {
                        approverId = ap.getApproverUserId();
                    }


                    RequestApprover reqApprover = new RequestApprover(approverId, ap.getApproverLevel(),
                            ap.getAssociationType(), "PENDING");
                    reqApprover.setApproverType(approverType);
                    reqApprover.setRoleDomain(roleDomain);

                    req.getRequestApprovers().add(reqApprover);
                }

            }
        }

        provRequestService.addRequest(req);

        notifyApprover(req, reqUser,  usr, approverRole, userOrg, applyDelegationFilter);

        return req;


    }


    private void notifyApprover(ProvisionRequest pReq, RequestUser reqUser,  User usr,
                                String approverRole, String userOrg, int  applyDelegationFilter) {


        Set<RequestApprover> approverList =  pReq.getRequestApprovers();
        for ( RequestApprover ra : approverList) {

            if (! ra.getApproverType().equalsIgnoreCase("ROLE")) {

                NotificationRequest request = new NotificationRequest();
                request.setUserId( ra.getApproverId());
                request.setNotificationType("NEW_PENDING_REQUEST");

                request.getParamList().add(new NotificationParam("REQUEST_ID", pReq.getRequestId()));

                request.getParamList().add(new NotificationParam("REQUEST_REASON", pReq.getRequestReason()));
                request.getParamList().add(new NotificationParam("REQUESTOR", usr.getFirstName() + " " + usr.getLastName()));
                request.getParamList().add(new NotificationParam("TARGET_USER", reqUser.getFirstName() + " " + reqUser.getLastName()));


                mailService.sendNotification(request);
            }else {
                // approverType is ROLE
                // get
                DelegationFilterSearch search = new DelegationFilterSearch();
                search.setRole(approverRole);
                search.setDelAdmin(applyDelegationFilter);
                search.setOrgFilter("%" + userOrg + "%");



                List<User> roleApprovers =  userMgr.searchByDelegationProperties(search).getUserList();



                if (roleApprovers != null && !roleApprovers.isEmpty()) {
                    for (User u :roleApprovers) {
                       NotificationRequest request = new NotificationRequest();
                        // one of the approvers
                        request.setUserId( u.getUserId()) ;
                        request.setNotificationType("NEW_PENDING_REQUEST");

                        request.getParamList().add(new NotificationParam("REQUEST_ID", pReq.getRequestId()));

                        request.getParamList().add(new NotificationParam("REQUEST_REASON", pReq.getRequestReason()));
                        request.getParamList().add(new NotificationParam("REQUESTOR", usr.getFirstName() + " " + usr.getLastName()));
                        request.getParamList().add(new NotificationParam("TARGET_USER", reqUser.getFirstName() + " " + reqUser.getLastName()));


                        mailService.sendNotification(request);

                    }

                }

            }

        }



    }


    @Override
    protected Map referenceData(HttpServletRequest request) throws Exception {

        String rMenu = request.getParameter("hideRMenu");
        String header = request.getParameter("hideHeader");

        if (rMenu != null && rMenu.length() > 0) {
            request.setAttribute("hideRMenu", "1");
        }
        if (header != null && header.length() > 0) {
            request.setAttribute("hideHeader", "1");
        }

        return loadUserInformation(request);
    }

    protected Map loadUserInformation(HttpServletRequest request) {
        log.info("referenceData called.");

        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        // get the organizations
        List<Organization> orgList = orgManager.getOrganizationList(null, "ACTIVE");
        // get the divisions
        List<Organization> divList = orgManager.allDivisions(configuration.getParentOrgId());
        // load the department list
        List<Organization> deptList = orgManager.allDepartments(configuration.getParentOrgId());


        // get the list of groups that this user belongs to
        List<Group> groupList = groupManager.getAllGroups().getGroupList();
        // get the list of roles that this user belongs to
        List<Role> roleList = roleDataService.getAllRoles().getRoleList();


        // get the list of job codes
        List<ReferenceData> jobCodeList = refDataService.getRefByGroup("JOB_CODE", "en");

        // get the list of user type codes
        List<ReferenceData> userTypeList = refDataService.getRefByGroup("USER_TYPE", "en");

        // get location list and the address for the user
        Location[] locationAry = locationService.allLocations().getLocationAry();

        Map model = new HashMap();
        model.put("orgList", orgList);
        model.put("divList", divList);
        model.put("deptList", deptList);
        model.put("groupList", groupList);
        model.put("roleList", roleList);
        //model.put("managerList",managerList);
        model.put("jobCodeList", jobCodeList);
        model.put("userTypeList", userTypeList);
        model.put("locationAry", locationAry);

        return model;

    }

    private void prepareObject(User user, String userId) {
        // need userId to be null so that persistence layer will generate a uid for the user
        user.setUserId(null);
        user.setCreateDate(new Date(System.currentTimeMillis()));
        user.setCreatedBy(userId);
        user.setStatus(UserStatusEnum.PENDING_APPROVAL);

    }



    private void createRequest(String userId, User usr) {
        ProvisionRequest req = new ProvisionRequest();
        req.setRequestorId(userId);
        req.setStatus("PENDING_APPROVAL");
        req.setStatusDate(new Date(System.currentTimeMillis()));
        req.setRequestDate(new Date(System.currentTimeMillis()));
        req.setRequestType(ProvisioningConstants.NEW_HIRE);


        provRequestService.addRequest(req);

        // add a user to the request - this is the person in the New Hire
        Set<RequestUser> reqUserSet = req.getRequestUsers();

        RequestUser reqUser = new RequestUser();
        reqUser.setUserId(usr.getUserId());
        reqUser.setFirstName(usr.getFirstName());
        reqUser.setLastName(usr.getLastName());
        reqUser.setRequestId(req.getRequestId());
        reqUserSet.add(reqUser);

        provRequestService.updateRequest(req);

    }



    private void setEmail(SelfRegistrationCommand cmd, ProvisionUser pUser) {

            String email = cmd.getEmail1();
            String emailId = cmd.getEmail1Id();
            if (email != null && email.length() > 0) {
                EmailAddress em = buildEmail(emailId, email,"EMAIL1");
                log.info("EmailId 1 = " + em.getEmailId());
                pUser.getEmailAddress().add(em);
                pUser.setEmail(email);
            }
            email = cmd.getEmail2();
            emailId = cmd.getEmail2Id();
            if (email != null && email.length() > 0) {
                EmailAddress em = buildEmail(emailId, email, "EMAIL2");
                log.info("EmailId 2 = " + em.getEmailId());
                pUser.getEmailAddress().add(em);
            }
            email = cmd.getEmail3();
            emailId = cmd.getEmail3Id();
            if (email != null && email.length() > 0) {
                EmailAddress em = buildEmail(emailId, email, "EMAIL3");
                pUser.getEmailAddress().add(em);
            }


        }

    private void setPhone(SelfRegistrationCommand cmd, ProvisionUser usr) {
	//	Set<Phone> phSet = usr.getPhone();

 	// add obbject


		Phone ph = buildPhone( usr, "DESK PHONE", cmd.getWorkAreaCode(), cmd.getWorkPhone());
		if (cmd.getWorkPhoneId() != null && cmd.getWorkPhoneId().length() > 0 ) {
			ph.setPhoneId(cmd.getWorkPhoneId());
		}
        usr.setAreaCd(ph.getAreaCd());
        usr.setPhoneNbr(ph.getPhoneNbr());
		usr.getPhone().add(ph);

		ph = buildPhone( usr, "CELL PHONE", cmd.getCellAreaCode(), cmd.getCellPhone());
		log.info("CELL PHONE: " + cmd.getCellPhoneId());
		if (cmd.getCellPhoneId() != null && cmd.getCellPhoneId().length() > 0 ) {
			ph.setPhoneId(cmd.getCellPhoneId());
		}
		usr.getPhone().add(ph);

		ph = buildPhone( usr, "FAX", cmd.getFaxAreaCode(), cmd.getFaxPhone() );
		if (cmd.getFaxPhoneId() != null && cmd.getFaxPhoneId().length() > 0 ) {
			ph.setPhoneId(cmd.getFaxPhoneId());
		}
		usr.getPhone().add(ph);

		ph = buildPhone( usr, "HOME PHONE", cmd.getHomePhoneAreaCode(), cmd.getHomePhoneNbr() );
		if (cmd.getHomePhoneIdr() != null && cmd.getHomePhoneIdr().length() > 0 ) {
			ph.setPhoneId(cmd.getHomePhoneIdr());
		}
		usr.getPhone().add(ph);

		ph = buildPhone( usr, "ALT CELL PHONE", cmd.getAltCellAreaCode(), cmd.getAltCellNbr() );
		if (cmd.getAltCellNbrId() != null && cmd.getAltCellNbrId().length() > 0 ) {
			ph.setPhoneId(cmd.getAltCellNbrId());
		}
		usr.getPhone().add(ph);

		ph = buildPhone( usr, "PERSONAL PHONE", cmd.getPersonalAreaCode(), cmd.getPersonalNbr() );
		if (cmd.getPersonalNbrId() != null && cmd.getPersonalNbrId().length() > 0 ) {
			ph.setPhoneId(cmd.getPersonalNbrId());
		}
		usr.getPhone().add(ph);


	}

    private void setAddress(SelfRegistrationCommand cmd, ProvisionUser pUser) {
		log.info("setAddress called.");

		Address adr = new Address();

		adr.setAddress1(cmd.getUser().getAddress1());
		adr.setAddress2(cmd.getUser().getAddress2());
		adr.setBldgNumber(cmd.getUser().getBldgNum());
		adr.setCity(cmd.getUser().getCity());
		adr.setCountry(cmd.getUser().getCountry());
		adr.setState(cmd.getUser().getState());
		adr.setStreetDirection(cmd.getUser().getStreetDirection());
		adr.setName("DEFAULT ADR");
		adr.setParentId(pUser.getUser().getUserId());
		adr.setParentType(ContactConstants.PARENT_TYPE_USER);
		adr.setPostalCd(cmd.getUser().getPostalCd());
		pUser.getAddresses().add(adr);



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





    public MailService getMailService() {
        return mailService;
    }


    public void setMailService(MailService mailService) {
        this.mailService = mailService;
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


    public LoginDataWebService getLoginManager() {
        return loginManager;
    }


    public void setLoginManager(LoginDataWebService loginManager) {
        this.loginManager = loginManager;
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


    public NavigatorDataWebService getNavigatorDataService() {
        return navigatorDataService;
    }


    public void setNavigatorDataService(NavigatorDataWebService navigatorDataService) {
        this.navigatorDataService = navigatorDataService;
    }


    public RequestWebService getProvRequestService() {
        return provRequestService;
    }


    public void setProvRequestService(RequestWebService provRequestService) {
        this.provRequestService = provRequestService;
    }


    public LocationDataWebService getLocationService() {
        return locationService;
    }


    public void setLocationService(LocationDataWebService locationService) {
        this.locationService = locationService;
    }

    public ManagedSystemDataService getManagedSysService() {
        return managedSysService;
    }

    public void setManagedSysService(ManagedSystemDataService managedSysService) {
        this.managedSysService = managedSysService;
    }

    public String getRequestType() {
        return requestType;
    }

    public void setRequestType(String requestType) {
        this.requestType = requestType;
    }
}
