package org.openiam.selfsrvc.login;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openiam.base.ws.ResponseStatus;
import org.openiam.exception.AuthenticationException;
import org.openiam.idm.srvc.auth.dto.AuthenticationRequest;
import org.openiam.idm.srvc.auth.service.AuthenticationConstants;
import org.openiam.idm.srvc.auth.service.AuthenticationService;
import org.openiam.idm.srvc.auth.ws.AuthenticationResponse;

import org.springframework.validation.Validator;
import org.springframework.validation.Errors;

import org.openiam.idm.srvc.auth.dto.Subject;
import org.openiam.selfsrvc.pswd.PasswordConfiguration;

import java.net.InetAddress;
import java.net.UnknownHostException;


public class LoginValidator implements Validator {

	protected AuthenticationService authenticate;
	protected String securityDomain;
	protected PasswordConfiguration configuration;
	
	private static final Log log = LogFactory.getLog(LoginValidator.class);

	public boolean supports(Class cls) {
		 return LoginCommand.class.equals(cls);
	}

	public void validate(Object cmd, Errors err) {
		// TODO Auto-generated method stub
		boolean required = true;
		
		log.debug("LoginValidator:validate");
		
		LoginCommand loginCmd =  (LoginCommand) cmd;
		
		if (loginCmd.getPrincipal() == null || loginCmd.getPrincipal().length() == 0 ) {
			err.rejectValue("principal","required");
			required = false;
		}
		if (loginCmd.getPassword() == null || loginCmd.getPassword().length() == 0 ) {
			err.rejectValue("password","required");
			required = false;
		}
		
		if (!required) {
			return;
		}
		
		String nodeIP = null;

        try {
            InetAddress addr = InetAddress.getLocalHost();


            nodeIP = addr.getHostAddress();


        } catch (UnknownHostException e) {
              e.printStackTrace();
        }



		// authenticate the user

        AuthenticationRequest authReq = new AuthenticationRequest(securityDomain, loginCmd.getPrincipal().trim(),
                loginCmd.getPassword(), loginCmd.getClientIP(), nodeIP);
        AuthenticationResponse resp = authenticate.login(authReq);
		
		if (resp.getStatus() == ResponseStatus.SUCCESS ) {			
			loginCmd.setSubject(resp.getSubject());	
			return;
		}
		// error in authentication
		int errCode = resp.getAuthErrorCode();
		switch (errCode) {
		case AuthenticationConstants.RESULT_INVALID_DOMAIN:
			err.rejectValue("principal","servicenotvalid");
			break;
		case AuthenticationConstants.RESULT_INVALID_LOGIN:
			err.rejectValue("principal","invalid");
			break;
		case AuthenticationConstants.RESULT_INVALID_PASSWORD:
			err.rejectValue("password","invalid");
			break;
		case AuthenticationConstants.RESULT_INVALID_USER_STATUS:
			err.rejectValue("principal","status");
			break;
		case AuthenticationConstants.RESULT_LOGIN_DISABLED:
			err.rejectValue("principal","disabled");
			break;
		case AuthenticationConstants.RESULT_LOGIN_LOCKED:
			err.rejectValue("principal","locked");
			break;
		case AuthenticationConstants.RESULT_PASSWORD_EXPIRED:
			err.rejectValue("principal","expired");
			break;
		case AuthenticationConstants.RESULT_SERVICE_NOT_FOUND:
			err.rejectValue("principal","servicenotfound");
			break;
		case AuthenticationConstants.RESULT_INVALID_CONFIGURATION:
			err.rejectValue("principal","configuration");
			break;
		default:
			err.rejectValue("principal","invalid");
		}
		
		
	}

	public AuthenticationService getAuthenticate() {
		return authenticate;
	}

	public void setAuthenticate(AuthenticationService authenticate) {
		this.authenticate = authenticate;
	}

	public String getSecurityDomain() {
		return securityDomain;
	}

	public void setSecurityDomain(String securityDomain) {
		this.securityDomain = securityDomain;
	}


	public PasswordConfiguration getConfiguration() {
		return configuration;
	}

	public void setConfiguration(PasswordConfiguration configuration) {
		this.configuration = configuration;
		this.securityDomain = configuration.getDefaultSecurityDomain();
	}	
	
}

