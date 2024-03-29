package org.openiam.webadmin.res;

/*
 * Copyright 2009, OpenIAM LLC 
 * This file is part of the OpenIAM Identity and Access Management Suite
 *
 *   OpenIAM Identity and Access Management Suite is free software: 
 *   you can redistribute it and/or modify
 *   it under the terms of the Lesser GNU General Public License 
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


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openiam.idm.srvc.menu.dto.Menu;
import org.openiam.idm.srvc.menu.ws.NavigatorDataWebService;
import org.openiam.idm.srvc.mngsys.dto.AttributeMap;
import org.openiam.idm.srvc.mngsys.service.ManagedSystemDataService;
import org.openiam.idm.srvc.policy.dto.Policy;
import org.openiam.idm.srvc.policy.dto.PolicyConstants;
import org.openiam.idm.srvc.policy.service.PolicyDataService;
import org.openiam.idm.srvc.res.dto.Resource;
import org.openiam.idm.srvc.res.service.ResourceDataService;
import org.openiam.webadmin.util.AuditHelper;
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
 * Controller to manage connectivity information for a managed system
 *
 * @author suneet
 */
public class AttributeMapController  extends CancellableFormController {


    private static final Log log = LogFactory.getLog(AttributeMapController.class);

    private ResourceDataService resourceDataService;
    private NavigatorDataWebService navigationDataService;
    private PolicyDataService policyDataService;
    private String redirectView;
    private ManagedSystemDataService managedSysService;
    private AuditHelper auditHelper;


    public AttributeMapController() {
        super();
    }

    @Override
   protected ModelAndView onCancel(Object command) throws Exception {
       return new ModelAndView(new RedirectView(getCancelView(),true));
   }

    protected void initBinder(HttpServletRequest request,
                              ServletRequestDataBinder binder) throws Exception {

        binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("MM/dd/yyyy"), true));

    }

    protected Map referenceData(HttpServletRequest request) throws Exception {

        List<Policy> attrPolicyAry = policyDataService.getAllPolicies(PolicyConstants.ATTRIBUTE_POLICY);


        Map model = new HashMap();
        model.put("attrPolicyAry", attrPolicyAry);


        return model;
    }

    @Override
    protected Object formBackingObject(HttpServletRequest request)
            throws Exception {

        String mode = request.getParameter("mode");
        if (mode != null && mode.equalsIgnoreCase("1")) {
            request.setAttribute("msg", "Information has been successfully updated.");
        }

        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        String resId = request.getParameter("objId");

        if (resId != null && resId.length() > 0) {
            request.setAttribute("objId", resId);
        } else {
            resId = request.getParameter("resId");
            request.setAttribute("objId", resId);
        }

        String menuGrp = request.getParameter("menugrp");

        Resource res = resourceDataService.getResource(resId);

        List<AttributeMap> attrMap = this.managedSysService.getResourceAttributeMaps(resId);
        if (attrMap == null) {

            attrMap = new ArrayList<AttributeMap>();
        }

        if (isPrincipalMissing(attrMap)) {
            request.setAttribute("msgPrincipal", "Policy map must contain atleast 1 row where the Object Type is 'Principal'");
        }

        AttributeMap newMap = new AttributeMap();
        newMap.setAttributeMapId("NEW");
        newMap.setResourceId(resId);
        newMap.setAttributeName("**ENTER ATTRIBUTE NAME**");
        newMap.setStatus("ACTIVE");
        Policy attrPolicy = new Policy();
        attrPolicy.setPolicyId("");
        newMap.setAttributePolicy(attrPolicy);
        attrMap.add(newMap);


        List<Menu> level3MenuList = navigationDataService.menuGroupByUser(menuGrp, userId, "en").getMenuList();
        request.setAttribute("menuL3", level3MenuList);


        AttributeMapCommand cmd = new AttributeMapCommand();
        cmd.setAttrMapList(attrMap);
        cmd.setResourceName(res.getName());
        cmd.setResId(resId);
        cmd.setManagedSysId(res.getManagedSysId());

        return cmd;
    }


    /**
     * Check if our list of AttributeMaps contains row for the principal
     * @param attrMap
     * @return
     */
    protected boolean isPrincipalMissing(List<AttributeMap> attrMap) {
        

        if (!attrMap.isEmpty()) {
            for (AttributeMap mapObj : attrMap) {
                if ("PRINCIPAL".equalsIgnoreCase(mapObj.getMapForObjectType())) {
                    return false;
                }
            }
        }
        
        return true;
        
    }

    @Override
    protected ModelAndView onSubmit(HttpServletRequest request,
                                    HttpServletResponse response, Object command, BindException errors)
            throws Exception {

        log.info("onSubmit called");

        AttributeMapCommand attrMapCmd = (AttributeMapCommand) command;
        String resId = attrMapCmd.getResId();

        String userId = (String)request.getSession().getAttribute("userId");
		String domainId = (String)request.getSession().getAttribute("domainid");
		String login = (String)request.getSession().getAttribute("login");

         Resource res = resourceDataService.getResource(resId);

        //ManagedSys sys;

        String btn = request.getParameter("btn");
        if (btn.equalsIgnoreCase("Delete")) {
            List<AttributeMap> attrMap = attrMapCmd.getAttrMapList();
            if (attrMap != null) {

                for (AttributeMap a : attrMap) {
                    if (a.getSelected()) {
                        String mapId = a.getAttributeMapId();
                        if (!mapId.equalsIgnoreCase("NEW")) {
                            this.managedSysService.removeAttributeMap(mapId);

                            auditHelper.addLog("MODIFY", domainId,	login,
                                "WEBCONSOLE", userId, "0", "RESOURCE", resId,
                                null,   "SUCCESS", null,  "DELETE POLICY-MAP",
                                 a.getAttributeName(), null, null,
                                 res.getName(), request.getRemoteHost());
                        }
                    }
                }

            }
        } else {


            List<AttributeMap> attrMap = attrMapCmd.getAttrMapList();

            if (attrMap != null) {

                for (AttributeMap a : attrMap) {
                    if (a.getAttributeMapId() == null || a.getAttributeMapId().equalsIgnoreCase("NEW")) {
                        // new
                        if (a.getAttributePolicy().getPolicyId() != null && a.getAttributePolicy().getPolicyId().length() > 0) {
                            a.setAttributeMapId(null);
                            a.setResourceId(resId);
                            a.setManagedSysId(attrMapCmd.getManagedSysId());
                            this.managedSysService.addAttributeMap(a);

                            auditHelper.addLog("MODIFY", domainId,	login,
                                 "WEBCONSOLE", userId, "0", "RESOURCE", resId,
                                 null,   "SUCCESS", null,  "ADD POLICY-MAP",
                                 a.getAttributeName(), null, null,
                                 res.getName(), request.getRemoteHost());

                        }
                    } else {
                        // update
                        a.setResourceId(resId);
                        managedSysService.updateAttributeMap(a);

                        auditHelper.addLog("MODIFY", domainId,	login,
                             "WEBCONSOLE", userId, "0", "RESOURCE", resId,
                             null,   "SUCCESS", null,  "MODIFY POLICY-MAP",
                              a.getAttributeName(), null, null,
                              res.getName(), request.getRemoteHost());

                    }
                }

            }
        }
        log.info("refreshing attr list for resourceId=" + resId);
        String view = redirectView + "&menuid=RESPOLICYMAP&menugrp=SECURITY_RES&objId=" + resId;
        log.info("redirecting to=" + view);

        return new ModelAndView(new RedirectView(view, true));


    }


    public ResourceDataService getResourceDataService() {
        return resourceDataService;
    }

    public void setResourceDataService(ResourceDataService resourceDataService) {
        this.resourceDataService = resourceDataService;
    }

    public NavigatorDataWebService getNavigationDataService() {
        return navigationDataService;
    }

    public void setNavigationDataService(
            NavigatorDataWebService navigationDataService) {
        this.navigationDataService = navigationDataService;
    }

    public PolicyDataService getPolicyDataService() {
        return policyDataService;
    }

    public void setPolicyDataService(PolicyDataService policyDataService) {
        this.policyDataService = policyDataService;
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

    public AuditHelper getAuditHelper() {
        return auditHelper;
    }

    public void setAuditHelper(AuditHelper auditHelper) {
        this.auditHelper = auditHelper;
    }
}
