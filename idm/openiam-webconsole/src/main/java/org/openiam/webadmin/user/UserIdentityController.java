package org.openiam.webadmin.user;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Date;
import java.util.Map;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.CancellableFormController;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.springframework.web.servlet.view.RedirectView;
import org.springframework.beans.propertyeditors.CustomDateEditor;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openiam.base.AttributeOperationEnum;
import org.openiam.base.ws.ResponseStatus;
import org.openiam.idm.srvc.auth.dto.Login;
import org.openiam.idm.srvc.auth.ws.LoginDataWebService;
import org.openiam.idm.srvc.grp.dto.Group;
import org.openiam.idm.srvc.grp.ws.GroupListResponse;
import org.openiam.idm.srvc.menu.dto.Menu;
import org.openiam.idm.srvc.menu.ws.NavigatorDataWebService;
import org.openiam.idm.srvc.mngsys.dto.ManagedSys;
import org.openiam.idm.srvc.mngsys.service.ManagedSystemDataService;
import org.openiam.idm.srvc.user.dto.User;
import org.openiam.idm.srvc.user.ws.UserDataWebService;
import org.openiam.idm.srvc.user.ws.UserResponse;
import org.openiam.provision.dto.ProvisionUser;
import org.openiam.provision.service.ProvisionService;


public class UserIdentityController extends CancellableFormController {


	protected UserDataWebService userMgr;
	protected LoginDataWebService loginManager;
	
	protected ProvisionService provRequestService; 
	protected NavigatorDataWebService navigationDataService;
	protected String redirectView;
	private ManagedSystemDataService managedSysService; 
	
	
	private static final Log log = LogFactory.getLog(UserIdentityController.class);

	
	public UserIdentityController() {
		super();
	}
	

	@Override
	protected void initBinder(HttpServletRequest request,
			ServletRequestDataBinder binder) throws Exception {
		
		binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("MM/dd/yyyy"),true) );
		
	}

            @Override
      protected ModelAndView onCancel(Object command) throws Exception {
          return new ModelAndView(new RedirectView(getCancelView(),true));
      }

	
	
	@Override
	protected Map referenceData(HttpServletRequest request) throws Exception {
		log.info("refernceData called.");
		
		Map<Object, Object> dataMap = new HashMap<Object, Object>();
			
		return dataMap;
		

	}
	


	@Override
	protected Object formBackingObject(HttpServletRequest request)		throws Exception {
		
		
		
		UserIdentityCommand idCmd = new UserIdentityCommand();
		
		HttpSession session =  request.getSession();
		String userId = (String)session.getAttribute("userId");
		
		String menuGrp = request.getParameter("menugrp");
		String personId = request.getParameter("personId");
		
		idCmd.setPerId(personId);
		
		// get the level 3 menu
		List<Menu> level3MenuList =  navigationDataService.menuGroupByUser(menuGrp, userId, "en").getMenuList();
		request.setAttribute("menuL3", level3MenuList);	
		request.setAttribute("personId", personId);		
		
		// get the list of systems
		ManagedSys[] sysAry =  managedSysService.getAllManagedSys();
		
		List<Login> principalList = loginManager.getLoginByUser(personId).getPrincipalList();
		if (principalList != null) {
			updatePrincipalWithSystemName( principalList, sysAry);
			idCmd.setPrincipalList(  principalList);
		}
		
		return idCmd;
		
	}
	
	private  void updatePrincipalWithSystemName(List<Login> principalList, ManagedSys[] sysAry ) {
		if (sysAry == null) {
			return;
		}
		for (Login l  : principalList) {
			// find the managedsys to get its name
			for ( ManagedSys m : sysAry) {
				
				if (m.getManagedSysId().equalsIgnoreCase(l.getId().getManagedSysId())) {
					l.setManagedSysName(m.getName());
				}
				
			}
		}
		
	}

		
	
	@Override
	protected ModelAndView onSubmit(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors) throws Exception {
	
		User usr = null;
		
		System.out.println("UserIdentityController: onSubmit");
		
		UserIdentityCommand identityCmd =(UserIdentityCommand)command;
		
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");
		
		// get the current user object
		String personId = identityCmd.getPerId();

		
		UserResponse usrResp =  userMgr.getUserWithDependent(personId, true);
		if (usrResp.getStatus() == ResponseStatus.SUCCESS ) {
			usr = usrResp.getUser();
		}
		ProvisionUser pUser = new ProvisionUser(usr);
		
		List<Login> loginList = identityCmd.getPrincipalList();
		// update this with the delete flag if one exists
		if (loginList != null) {
			for (Login lg: loginList) {
				if (lg.isSelected()) {
					lg.setOperation(AttributeOperationEnum.DELETE);

                    System.out.println("Identity marked for deletion: " + lg.getId());
				}
				// decrypt the password so that it does not fail in the modify operation
				if (lg.getPassword() != null) {
					lg.setPassword( (String)loginManager.decryptPassword(lg.getPassword()).getResponseValue());
				}
			}
		}
		pUser.setPrincipalList(loginList);

        String login = (String)session.getAttribute("login");
        String domain = (String)session.getAttribute("domainId");
        pUser.setRequestClientIP(request.getRemoteHost());
        pUser.setRequestorLogin(login);
        pUser.setRequestorDomain(domain);
		
		provRequestService.modifyUser(pUser);
		
		return new ModelAndView(new RedirectView(redirectView+"&mode=1", true));

	}


	public void setProvRequestService(ProvisionService provRequestService) {
		this.provRequestService = provRequestService;
	}


	public ProvisionService getProvRequestService() {
		return provRequestService;
	}


	public NavigatorDataWebService getNavigationDataService() {
		return navigationDataService;
	}


	public void setNavigationDataService(
			NavigatorDataWebService navigationDataService) {
		this.navigationDataService = navigationDataService;
	}


	public LoginDataWebService getLoginManager() {
		return loginManager;
	}


	public void setLoginManager(LoginDataWebService loginManager) {
		this.loginManager = loginManager;
	}


	public UserDataWebService getUserMgr() {
		return userMgr;
	}


	public void setUserMgr(UserDataWebService userMgr) {
		this.userMgr = userMgr;
	}


	public String getRedirectView() {
		return redirectView;
	}


	public void setRedirectView(String redirectView) {
		this.redirectView = redirectView;
	}


	public ManagedSystemDataService getManagedSysService() {
		return managedSysService;
	}


	public void setManagedSysService(ManagedSystemDataService managedSysService) {
		this.managedSysService = managedSysService;
	}




	
}
