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
package org.openiam.idm.srvc.synch.ws;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.mule.api.MuleContext;
import org.mule.api.context.MuleContextAware;
import org.mule.module.client.MuleClient;
import org.openiam.idm.srvc.synch.dto.SyncResponse;
import org.openiam.idm.srvc.synch.dto.SynchConfig;
import org.openiam.idm.srvc.synch.service.generic.GenericObjectSynchService;

import javax.jws.WebService;
import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;


/**
 * @author suneet
 *
 */
@WebService(endpointInterface = "org.openiam.idm.srvc.synch.ws.AsynchGenericObjectSynchService",
		targetNamespace = "http://www.openiam.org/service/synch", 
		portName = "AsynchGenericObjectSynchServicePort",
		serviceName = "AsynchGenericObjectSynchService")
public class AsynchGenericObjectSynchServiceImpl implements AsynchGenericObjectSynchService, MuleContextAware {

	protected GenericObjectSynchWebService synchService;
    protected MuleContext muleContext;

    protected static final Log log = LogFactory.getLog(AsynchGenericObjectSynchServiceImpl.class);
    static protected ResourceBundle res = ResourceBundle.getBundle("datasource");

    static String serviceHost = res.getString("openiam.service_base");
    static String serviceContext = res.getString("openiam.idm.ws.path");


    public void startSynchronization(SynchConfig config) {
        log.debug("A-START SYNCH CALLED...................");

        try {

            Map<String, String> msgPropMap = new HashMap<String, String>();
            msgPropMap.put("SERVICE_HOST", serviceHost);
            msgPropMap.put("SERVICE_CONTEXT", serviceContext);


            //Create the client with the context
            MuleClient client = new MuleClient(muleContext);
            client.sendAsync("vm://genericObjectSynchronizationMessage", (SynchConfig) config, msgPropMap);


        } catch (Exception e) {
            log.debug("EXCEPTION:AsynchIdentitySynchService");
            log.error(e);
            //e.printStackTrace();
        }
        log.debug("A-START SYNCH END ---------------------");
    }


    public void setMuleContext(MuleContext ctx) {

        log.debug("** setMuleContext called. **");

        muleContext = ctx;

    }

    public GenericObjectSynchWebService getSynchService() {
        return synchService;
    }

    public void setSynchService(GenericObjectSynchWebService synchService) {
        this.synchService = synchService;
    }
}
