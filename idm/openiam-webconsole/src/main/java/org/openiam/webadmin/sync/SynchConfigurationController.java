package org.openiam.webadmin.sync;


import java.util.HashMap;
import java.util.List;
import java.util.Date;
import java.util.Map;
import java.text.SimpleDateFormat;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.openiam.base.ws.Response;
import org.openiam.webadmin.sync.notuser.SynchOrg;
import org.openiam.webadmin.sync.notuser.SynchRole;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.springframework.web.servlet.view.RedirectView;
import org.springframework.beans.propertyeditors.CustomDateEditor;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openiam.base.ws.ResponseStatus;
import org.openiam.idm.srvc.batch.service.BatchDataService;
import org.openiam.idm.srvc.batch.dto.BatchTask;

import org.openiam.idm.srvc.synch.dto.SyncResponse;
import org.openiam.idm.srvc.synch.dto.SynchConfig;
import org.openiam.idm.srvc.synch.ws.AsynchIdentitySynchService;
import org.openiam.idm.srvc.synch.ws.IdentitySynchWebService;
import org.openiam.idm.srvc.synch.ws.SynchConfigResponse;
import org.openiam.idm.srvc.menu.dto.Menu;
import org.openiam.idm.srvc.menu.ws.NavigatorDataWebService;
import org.openiam.idm.srvc.mngsys.dto.ManagedSys;
import org.openiam.idm.srvc.mngsys.service.ManagedSystemDataService;
import org.openiam.webadmin.admin.AppConfiguration;


/**
 * Controller for the new hire form.
 * @author suneet
 *
 */
public class SynchConfigurationController extends SimpleFormController {


	protected String redirectView; 	

	protected ManagedSystemDataService managedSysService;
	protected IdentitySynchWebService synchConfig;
	protected AppConfiguration configuration;
	private static final Log log = LogFactory.getLog(SynchConfigurationController.class);
	protected NavigatorDataWebService navigationDataService;
	protected BatchDataService batchDataService;
	protected AsynchIdentitySynchService asychSynchConfig;

    // temp solution used to load Org and Role objects
    protected SynchOrg loadOrg;
    protected SynchRole loadRole;


	
	public SynchConfigurationController() {
		super();
	}
	

	@Override
	protected void initBinder(HttpServletRequest request,
			ServletRequestDataBinder binder) throws Exception {
		
		SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
		df.setLenient(false);
		
		binder.registerCustomEditor(Date.class, new CustomDateEditor(df,true) );
		
	}
	


	
	protected Object formBackingObject(HttpServletRequest request) 			throws Exception {
		
		SynchConfigurationCommand cmd = new SynchConfigurationCommand();

		HttpSession session =  request.getSession();
		String userId = (String)session.getAttribute("userId");
		
		String configId = request.getParameter("objId");
		if (configId != null && configId.length() > 0) {
			SynchConfig config = synchConfig.findById(configId).getConfig();
			cmd.setSyncConfig(config);
			request.setAttribute("objId",config.getSynchConfigId());
	
		
			String menuGrp = request.getParameter("menugrp");
			List<Menu> level3MenuList =  navigationDataService.menuGroupByUser(menuGrp, userId, "en").getMenuList();
			request.setAttribute("menuL3", level3MenuList);	
		}	
		
		return cmd;
	}






	@Override
	protected ModelAndView onSubmit(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors)
			throws Exception {

        System.out.println("onSubmit called in SynchConfigurationController...");

		SynchConfigResponse resp = null;
		
		SynchConfigurationCommand cmd = (SynchConfigurationCommand)command;
		SynchConfig config =  cmd.getSyncConfig();
	
		String btn = request.getParameter("btn");
		String configId = config.getSynchConfigId();

		if (btn != null && btn.equalsIgnoreCase("Delete")) {
			
			synchConfig.removeConfig(configId);	
			
			// remove the synch job that is linked to it.
			String name = "Synch:" + configId;
			// check if a batch object for this already exists
			BatchTask task =  batchDataService.getTaskByName(name);
			if (task != null) {
				batchDataService.removeBatchTask(task.getTaskId());
			}
			
	        ModelAndView mav = new ModelAndView("/deleteconfirm");
	        mav.addObject("msg", "Configuration has been successfully deleted.");
	        return mav;

		}

		
		if (config.getSynchConfigId() == null || 
				(config.getSynchConfigId() != null && config.getSynchConfigId().length() == 0)) {
			config.setSynchConfigId(null);
			resp = synchConfig.addConfig(config);
		}else {
			resp = synchConfig.updateConfig(config);
		}

        //Test connection after updating the configuration, but before setting up the batch task.
        //If the connection fails, there wont be a batch job that tries the connection over and over again.
        if (btn != null && btn.equalsIgnoreCase("Test Connection")) {
            Response testResponse =  synchConfig.testConnection(config);

            ModelAndView mav = new ModelAndView("/sync/testconnect");

            if (testResponse.getStatus() == ResponseStatus.FAILURE) {
                mav.addObject("msg", "Connection Failed.");
                mav.addObject("error", testResponse.getErrorText());

            } else {
                mav.addObject("msg", "Connection Successful.");
            }
            return mav;

        }
		
		// update the batch synchronization settings
		SynchConfig c = resp.getConfig();
		if (c != null) {
			String name = "Synch:" + c.getSynchConfigId();
			// check if a batch object for this already exists
			BatchTask task =  batchDataService.getTaskByName(name);
			if (task == null) {
				task = new BatchTask();
				task.setTaskName(name);
				task.setTaskId(null);
				task.setParam1(c.getSynchConfigId());
				task.setTaskUrl("batch/synchronization.groovy");
			}
			if (c.getSynchFrequency() == null || c.getSynchFrequency().length() == 0) {
				task.setFrequencyUnitOfMeasure(null);
				task.setEnabled(0);
			}else{
				task.setFrequencyUnitOfMeasure(c.getSynchFrequency());
				task.setEnabled(1);
			}
			if (task.getTaskId() == null) {
				this.batchDataService.addBatchTask(task);
			}else {
				batchDataService.upateBatchTask(task);
			}
		}

        if (btn != null && btn.equalsIgnoreCase("Sync Now")) {
            // check the object type you want to synch and
            System.out.println("Synch object=" + config.getProcessRule());
            System.out.println("Synch adapter= " + config.getSynchAdapter());

            if (!config.getProcessRule().equalsIgnoreCase("USER") && config.getSynchAdapter().equalsIgnoreCase("CSV")) {
                // temp hack to be able to Org and role objects from a csv file
                if (config.getProcessRule().equalsIgnoreCase("ROLE")) {
                    loadRole.synch(config);

                }
                if (config.getProcessRule().equalsIgnoreCase("ORG")) {
                    loadOrg.synch(config);

                }

                return new ModelAndView(new RedirectView(redirectView, true));

            }


			config.setSynchAdapter( cmd.getSyncConfig().getSynchAdapter() );
			asychSynchConfig.startSynchronization(config);

	        return new ModelAndView(new RedirectView(redirectView, true));

		}
		
		
	
		return new ModelAndView(new RedirectView(redirectView, true));


        
	}

	@Override
	protected Map referenceData(HttpServletRequest request) throws Exception {
		ManagedSys[] sysAry = managedSysService.getManagedSysByDomain(configuration.getDefaultSecurityDomain());
		Map model = new HashMap();
		model.put("sysAry", sysAry);
		
		return model;
	}
	

	public String getRedirectView() {
		return redirectView;
	}


	public void setRedirectView(String redirectView) {
		this.redirectView = redirectView;
	}


	public IdentitySynchWebService getSynchConfig() {
		return synchConfig;
	}


	public void setSynchConfig(IdentitySynchWebService synchConfig) {
		this.synchConfig = synchConfig;
	}




	public AppConfiguration getConfiguration() {
		return configuration;
	}


	public void setConfiguration(AppConfiguration configuration) {
		this.configuration = configuration;
	}


	public NavigatorDataWebService getNavigationDataService() {
		return navigationDataService;
	}


	public void setNavigationDataService(
			NavigatorDataWebService navigationDataService) {
		this.navigationDataService = navigationDataService;
	}


	public ManagedSystemDataService getManagedSysService() {
		return managedSysService;
	}


	public void setManagedSysService(ManagedSystemDataService managedSysService) {
		this.managedSysService = managedSysService;
	}


	public BatchDataService getBatchDataService() {
		return batchDataService;
	}


	public void setBatchDataService(BatchDataService batchDataService) {
		this.batchDataService = batchDataService;
	}


	public AsynchIdentitySynchService getAsychSynchConfig() {
		return asychSynchConfig;
	}


	public void setAsychSynchConfig(AsynchIdentitySynchService asychSynchConfig) {
		this.asychSynchConfig = asychSynchConfig;
	}


    public SynchOrg getLoadOrg() {
        return loadOrg;
    }

    public void setLoadOrg(SynchOrg loadOrg) {
        this.loadOrg = loadOrg;
    }

    public SynchRole getLoadRole() {
        return loadRole;
    }

    public void setLoadRole(SynchRole loadRole) {
        this.loadRole = loadRole;
    }
}
