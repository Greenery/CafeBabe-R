package org.openiam.idm.srvc.synch.service;

import org.mule.api.MuleContext;
import org.openiam.base.ws.Response;
import org.openiam.idm.srvc.synch.dto.SyncResponse;
import org.openiam.idm.srvc.synch.dto.SynchConfig;

import java.util.*;

/**
 * Interface for <code>IdentitySynchService</code>. All synchronization
 * activities are managed through this service.
 */
public interface IdentitySynchService {

	List<SynchConfig> getAllConfig();

	SynchConfig findById(java.lang.String id);

	SynchConfig addConfig(SynchConfig synchConfig);

	SynchConfig updateConfig(SynchConfig synchConfig);

	void removeConfig(String configId);
	
	SyncResponse startSynchronization(SynchConfig config);

    Response testConnection(SynchConfig config);

    public void setMuleContext(MuleContext ctx);

}