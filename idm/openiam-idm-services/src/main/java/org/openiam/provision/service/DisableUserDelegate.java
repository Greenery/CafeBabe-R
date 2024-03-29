package org.openiam.provision.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.mule.api.MuleContext;
import org.openiam.base.SysConfiguration;
import org.openiam.base.id.UUIDGen;
import org.openiam.base.ws.Response;
import org.openiam.base.ws.ResponseCode;
import org.openiam.base.ws.ResponseStatus;
import org.openiam.exception.EncryptionException;
import org.openiam.exception.ObjectNotFoundException;
import org.openiam.idm.srvc.audit.dto.IdmAuditLog;
import org.openiam.idm.srvc.audit.service.AuditHelper;
import org.openiam.idm.srvc.auth.dto.Login;
import org.openiam.idm.srvc.auth.login.LoginDataService;
import org.openiam.idm.srvc.grp.service.GroupDataService;
import org.openiam.idm.srvc.mngsys.dto.ManagedSys;
import org.openiam.idm.srvc.mngsys.service.ManagedSystemDataService;
import org.openiam.idm.srvc.pswd.dto.Password;
import org.openiam.idm.srvc.pswd.dto.PasswordValidationCode;
import org.openiam.idm.srvc.res.dto.Resource;
import org.openiam.idm.srvc.role.service.RoleDataService;
import org.openiam.idm.srvc.user.dto.User;
import org.openiam.idm.srvc.user.dto.UserStatusEnum;
import org.openiam.idm.srvc.user.service.UserDataService;
import org.openiam.spml2.msg.PSOIdentifierType;
import org.openiam.spml2.msg.password.SetPasswordRequestType;
import org.openiam.spml2.msg.suspend.ResumeRequestType;
import org.openiam.spml2.msg.suspend.SuspendRequestType;


/**
 * Class to handle the Disable User operation
 * @author suneet shah
 *
 */
public class DisableUserDelegate {


	protected UserDataService userMgr;
	protected AuditHelper auditHelper;
	protected SysConfiguration sysConfiguration;
	protected LoginDataService loginManager;
	protected ManagedSystemDataService managedSysService;
	protected ConnectorAdapter connectorAdapter;
	protected RemoteConnectorAdapter remoteConnectorAdapter;	
	

	protected static final Log log = LogFactory.getLog(DisableUserDelegate.class);



	public Response disableUser(String userId, boolean operation, String requestorId, MuleContext muleContext) {
		log.debug("----disableUser called.------");
		log.debug("operation code=" + operation);
		
		Response response = new Response(ResponseStatus.SUCCESS);
		
		String requestId = "R" + UUIDGen.getUUID();
		String strOperation = null;
	
		if (userId == null) {
			response.setStatus(ResponseStatus.FAILURE);
			response.setErrorCode(ResponseCode.USER_NOT_FOUND);	
			return response;
		}
		User usr = this.userMgr.getUserWithDependent(userId, false);

		if (usr == null) {
            auditHelper.addLog(strOperation, sysConfiguration.getDefaultSecurityDomain(), null,
				"IDM SERVICE", requestorId, "IDM", "USER",
				userId, null,  "FAILURE", null,  null,
				null, requestId, null, null, null);

			response.setStatus(ResponseStatus.FAILURE);
			response.setErrorCode(ResponseCode.USER_NOT_FOUND);	
			return response;			
		}
		// disable the user in OpenIAM		
		if (operation) {
			usr.setSecondaryStatus(UserStatusEnum.DISABLED);
			strOperation = "DISABLE";
		}else {
			// enable an account that was previously disabled.
			usr.setSecondaryStatus(null);
			strOperation = "ENABLE";
		}
		userMgr.updateUserWithDependent(usr,false);

        Login lRequestor = loginManager.getPrimaryIdentity(requestorId);
        Login lTargetUser = loginManager.getPrimaryIdentity(userId);

        if (lRequestor != null && lTargetUser != null) {
			
            auditHelper.addLog(strOperation, lRequestor.getId().getDomainId(), lRequestor.getId().getLogin(),
                    "IDM SERVICE", requestorId, "IDM", "USER",
                    usr.getUserId(), null,  "SUCCESS", null,  null,
                    null, requestId, null, null, null,
                    null, lTargetUser.getId().getLogin(), lTargetUser.getId().getDomainId() );
        }else {
            log.debug("Unable to log disable operation. Of of the following is null:");
            log.debug("Requestor identity=" + lRequestor);
            log.debug("Target identity=" + lTargetUser);
        }
		// disable the user in the managed systems
		

		// typical sync
		List<Login> principalList = loginManager.getLoginByUser(usr.getUserId());
		if (principalList != null) {
			log.debug("PrincipalList size =" + principalList.size());
			for ( Login lg : principalList) {
				// get the managed system for the identity - ignore the managed system id that is linked to openiam's repository
				log.debug("-diabling managed system=" + lg.getId().getLogin() + " - " + lg.getId().getManagedSysId() ) ;
				
				if (!lg.getId().getManagedSysId().equalsIgnoreCase(sysConfiguration.getDefaultManagedSysId())) {
					String managedSysId = lg.getId().getManagedSysId();
					// update the target system
					ManagedSys mSys = managedSysService.getManagedSys(managedSysId);
					
					if (operation) {
						// suspend		
						log.debug("preparing suspendRequest object");
						
		            	SuspendRequestType suspendReq = new SuspendRequestType();
		                PSOIdentifierType idType = new PSOIdentifierType(lg.getId().getLogin(),null, managedSysId );
		                suspendReq.setPsoID(idType);
		                suspendReq.setRequestID(requestId);
		                connectorAdapter.suspendRequest(mSys, suspendReq,muleContext);
		                
		                
					}else {
						// resume - re-enable
						log.debug("preparing resumeRequest object");

                        // reset flags that go with this identiy
                        lg.setAuthFailCount(0);
                        lg.setIsLocked(0);
                        lg.setPasswordChangeCount(0);
                        loginManager.updateLogin(lg);



						
		            	ResumeRequestType resumeReq = new ResumeRequestType();
		                PSOIdentifierType idType = new PSOIdentifierType(lg.getId().getLogin(),null, managedSysId );
		                resumeReq.setPsoID(idType);
		                resumeReq.setRequestID(requestId);
		                connectorAdapter.resumeRequest(mSys, resumeReq,muleContext);
					}
                    
                    String domainId = null;
                    String loginId = null;
                    if (lRequestor.getId() != null) {
                       domainId = lRequestor.getId().getDomainId();
                       loginId = lRequestor.getId().getLogin();
                    }
                    
	        		auditHelper.addLog(strOperation + " IDENTITY", domainId, loginId,
	        				"IDM SERVICE", requestorId, "IDM", "USER",
	        				null, null,  "SUCCESS", requestId,  null, 
	        				null, requestId, null, null, null,
                            null, lg.getId().getLogin(), lg.getId().getDomainId());
				}else {
                    lg.setAuthFailCount(0);
                    lg.setIsLocked(0);
                    lg.setPasswordChangeCount(0);
                    loginManager.updateLogin(lg);
                }
			}
		}
		response.setStatus(ResponseStatus.SUCCESS);
		return response;

		
	}

	

	public UserDataService getUserMgr() {
		return userMgr;
	}


	public void setUserMgr(UserDataService userMgr) {
		this.userMgr = userMgr;
	}


	public AuditHelper getAuditHelper() {
		return auditHelper;
	}


	public void setAuditHelper(AuditHelper auditHelper) {
		this.auditHelper = auditHelper;
	}



	public SysConfiguration getSysConfiguration() {
		return sysConfiguration;
	}



	public void setSysConfiguration(SysConfiguration sysConfiguration) {
		this.sysConfiguration = sysConfiguration;
	}


	public LoginDataService getLoginManager() {
		return loginManager;
	}


	public void setLoginManager(LoginDataService loginManager) {
		this.loginManager = loginManager;
	}


	public ManagedSystemDataService getManagedSysService() {
		return managedSysService;
	}


	public void setManagedSysService(ManagedSystemDataService managedSysService) {
		this.managedSysService = managedSysService;
	}

	public ConnectorAdapter getConnectorAdapter() {
		return connectorAdapter;
	}


	public void setConnectorAdapter(ConnectorAdapter connectorAdapter) {
		this.connectorAdapter = connectorAdapter;
	}



	public RemoteConnectorAdapter getRemoteConnectorAdapter() {
		return remoteConnectorAdapter;
	}



	public void setRemoteConnectorAdapter(
			RemoteConnectorAdapter remoteConnectorAdapter) {
		this.remoteConnectorAdapter = remoteConnectorAdapter;
	}
	
}
