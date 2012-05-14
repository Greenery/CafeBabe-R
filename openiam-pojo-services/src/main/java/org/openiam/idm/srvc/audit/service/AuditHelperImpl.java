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
package org.openiam.idm.srvc.audit.service;

import org.openiam.idm.srvc.audit.dto.IdmAuditLog;
import org.openiam.idm.srvc.audit.service.IdmAuditLogDataService;

import java.util.List;

/**
 * Helper class that other modules can use to simplify the audit logging process.
 * This class will validate the log against the audit policy and then log the event.
 * @author suneet
 *
 */
public class AuditHelperImpl implements AuditHelper {
	
	IdmAuditLogDataService auditDataService;
	
	/**
	 * Logs the event through the audit log service. Returns the logId.
	 * @param log
	 * @return
	 */
	public IdmAuditLog logEvent(IdmAuditLog log) {
		auditDataService.addLog(log);
		return log;
		
	}

	public void logEventListEvent(List<IdmAuditLog> logList) {
		if (logList  == null || logList.isEmpty()) {
			return ;
		}
		int ctr = 0;
		String linkedLogId = null;
		
		for ( IdmAuditLog log : logList) {
			if (linkedLogId != null) {
				log.setLinkedLogId(linkedLogId);
				log.setLinkSequence(ctr);
			}
			
			String logId = logEvent(log).getLogId();
			if (ctr == 0 ) {
				linkedLogId = logId;
			}
			ctr++;
		}
		
	}
	
	/**
	 * Logs the event through the audit log service. Returns the logId.
	 * @param action
	 * @param domainId
	 * @param principal
	 * @param srcSystem
	 * @param userId
	 * @param targetSystem
	 * @param objectType
	 * @param objectId
	 * @param actionStatus
	 * @param linkedLogId
	 * @param attrName
	 * @param attrValue
	 * @return
	 */
	public IdmAuditLog addLog(String action,String domainId, String principal, 
			String srcSystem, String userId, String targetSystem, String objectType,  
			String objectId, String objectName,
			String actionStatus, String linkedLogId, String attrName, String attrValue,
			String requestId, String reason, String sessionId,
            String reasonDetail) {

		IdmAuditLog log = new IdmAuditLog();
		log.setObjectId(objectId);
		log.setObjectTypeId(objectType);
		log.setActionId(action);
		log.setActionStatus(actionStatus);
		log.setDomainId(domainId);
		log.setUserId(userId);
		log.setPrincipal(principal);
		log.setLinkedLogId(linkedLogId);
		log.setSrcSystemId(srcSystem);
		log.setTargetSystemId(targetSystem);
		log.setCustomAttrname1(attrName);
		log.setCustomAttrvalue1(attrValue);
		log.setRequestId(requestId);
		log.setReason(reason);
		log.setSessionId(sessionId);
        log.setReasonDetail(reasonDetail);
		
		return logEvent(log);
		
	}

    public IdmAuditLog addLog(String action,String requestorDomainId, String requestorPrincipal,
			String srcSystem, String userId, String targetSystem, String objectType,
			String objectId, String objectName,
			String actionStatus, String linkedLogId, String attrName, String attrValue,
			String requestId, String reason, String sessionId,
            String reasonDetail,
            String requestIP, String targetPrincipal, String targetUserDomain) {

		IdmAuditLog log = new IdmAuditLog();
		log.setObjectId(objectId);
		log.setObjectTypeId(objectType);
		log.setActionId(action);
		log.setActionStatus(actionStatus);
		log.setDomainId(requestorDomainId);
		log.setUserId(userId);
		log.setPrincipal(requestorPrincipal);
		log.setLinkedLogId(linkedLogId);
		log.setSrcSystemId(srcSystem);
		log.setTargetSystemId(targetSystem);
		log.setCustomAttrname1(attrName);
		log.setCustomAttrvalue1(attrValue);
		log.setRequestId(requestId);
		log.setReason(reason);
		log.setSessionId(sessionId);
        log.setReasonDetail(reasonDetail);
        log.setHost(requestIP);
        log.setCustomAttrname3("TARGET_IDENTITY");
        log.setCustomAttrvalue3(targetPrincipal);
        log.setCustomAttrname4("TARGET_DOMAIN");
        log.setCustomAttrvalue4(targetUserDomain);

		return logEvent(log);

	}

    public IdmAuditLog createLogObject(String action,String domainId, String principal,
			String srcSystem, String userId, String targetSystem, String objectType,
			String objectId, String objectName,
			String actionStatus, String linkedLogId, String attrName, String attrValue,
			String requestId, String reason, String sessionId,
            String reasonDetail,
            String resourceName,
            String requestIP, String targetPrincipal, String targetUserDomain) {


		IdmAuditLog log = new IdmAuditLog();
		log.setObjectId(objectId);
		log.setObjectTypeId(objectType);
		log.setActionId(action);
		log.setActionStatus(actionStatus);
		log.setDomainId(domainId);
		log.setUserId(userId);
		log.setPrincipal(principal);
		log.setLinkedLogId(linkedLogId);
		log.setSrcSystemId(srcSystem);
		log.setTargetSystemId(targetSystem);
		log.setCustomAttrname1(attrName);
		log.setCustomAttrvalue1(attrValue);
		log.setRequestId(requestId);
		log.setReason(reason);
		log.setSessionId(sessionId);
        log.setReasonDetail(reasonDetail);
        log.setResourceName(resourceName);

        log.setHost(requestIP);
        log.setCustomAttrname3("TARGET_IDENTITY");
        log.setCustomAttrvalue3(targetPrincipal);
        log.setCustomAttrname4("TARGET_DOMAIN");
        log.setCustomAttrvalue4(targetUserDomain);

        return log;


	}

    public void persistLogList(List<IdmAuditLog> logList, String requestId, String sessionId) {

        for ( IdmAuditLog log : logList) {
            if (requestId != null) {
                log.setRequestId(requestId);
            }
            if (sessionId != null) {
                log.setSessionId(sessionId);
            }

            if (log.getLinkedLogId() == null || log.getLinkedLogId().length() ==0)  {
                log.setLinkedLogId("NA");
            }

            logEvent(log);
        }
    }



	public IdmAuditLogDataService getAuditDataService() {
		return auditDataService;
	}

	public void setAuditDataService(IdmAuditLogDataService auditDataService) {
		this.auditDataService = auditDataService;
	}
}