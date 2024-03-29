<%@ page language="java" contentType="text/html; charset=utf-8"     pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 



        
		<table  width="700pt">
			<tr>
				<td>
					<table width="100%">
					   <tr>
					 		<td align="center" class="msg">
					 		  <b>${msg}</b>
					 		</td>
					  </tr>  

						<tr>
							<td class="pageTitle" width="70%">
								<h2 class="contentheading">Connection Details</h2>
						</td>
						</tr>
					</table>
			</td>
		</tr>        
<form:form commandName="managedSysConnectionCmd">
<form:hidden path="domainId" />
<form:hidden path="objectSearchId" />

		<table width="700pt"  class="bodyTable" height="100%" >
				<tr>
					<td>    
							<fieldset class="userformSearch" >
							<legend>EDIT CONNECTION DETAILS</legend>
				
					<table class="fieldsetTable"  width="100%" >
   
          <tr>
			  		<td>Managed Resource Id</td>
            <td><form:input path="managedSysId" size="32" maxlength="32" readonly="true" /></td>
          </tr>
          <tr>
              <td>Resource Name<font color="red">*</font></td>
			  			<td><form:input path="name" size="40" maxlength="40"  /><br>
			  <form:errors path="name" cssClass="error" /></td>
		  </tr>
          <tr>
			  <td>Description</td>
              <td><form:input path="description" size="40" maxlength="40" /></td>
          </tr>
          <tr>
              <td >Resource Type<font color="red">*</font></td>
			  <td>
			  		<form:select path="resourceType">
			  			<form:option value="-"  label="-Select a value" />
			  			<form:option value="MANAGED_SYS" label="Managed Systems" />
			  			<form:option value="SYS_FORMS"  label="System Forms"/>
			  			<form:option value="OTHER_NONPROV" label="Other Non-Provisionable Resource" /> 
		            </form:select><br>
		            <form:errors path="resourceType" cssClass="error" />
			  </td>
		  </tr>
		   
          <tr>
              <td>Status</td>
			  <td><form:select path="status">
	              <form:option value="ACTIVE" />
	              <form:option value="IN-ACTIVE" />
          		</form:select>
			  </td>
		  </tr>
          <tr>
              <td>Connector<font color="red">*</font></td>
			  		 <td>
			  		<form:select path="connectId">
			  			<form:option value="-"  label="-Select a value" />
			  			<form:options items="${connectors}" itemValue="connectorId" itemLabel="name"  />
		            </form:select><br>
		            <form:errors path="connectId" cssClass="error" />
			  </td>
		  </tr>
          <tr>
			  		<td>Host URL:Port</td>
            <td><form:input path="hostUrl" size="60" maxlength="80" /> : <form:input path="port" size="10" maxlength="10" /></td>
          </tr>
          <tr>
              <td>Communication Protocol</td>
			  			<td><form:select path="commProtocol">
		              <form:option value="-Select a value" />
		              <form:option value="SSL" />
		              <form:option value="CLEAR" />
	              </form:select>
			  </td>
		  </tr>
          <tr>
		    <td>JDBC Driver URL</td>
            <td><form:input path="driverUrl" size="60" maxlength="100" /> </td>
          </tr>
          <tr>
		    <td>Connection String</td>
            <td><form:input path="connectionString" size="60" maxlength="100" /></td>
          </tr>



          <tr>
			  		<td>Login Id</td>
            <td><form:input path="userId" size="50" maxlength="100" /><br>
		            <form:errors path="userId" cssClass="error" /></td>
          </tr>
          <tr>
			  <td>Password</td>
              <td><form:password path="pswd" size="50" maxlength="100" showPassword="true" /><br>
		            <form:errors path="pswd" cssClass="error" /></td>
          </tr>
 
          <tr>
			  		<td>Object Primary Key</td>
            <td><form:input path="keyField" size="50" maxlength="40" /></td>
          </tr>
          <tr>
			 		 	<td>Base DN</td>
            <td><form:input path="baseDn" size="50" maxlength="100" /></td>
          </tr>          
          <tr>
			  		<td>Search Base DN</td>
            <td><form:input path="searchBaseDn" size="50" maxlength="100" /></td>
          </tr>  
          <tr>
			  <td>Search Filter</td>
              <td><form:input path="searchFilter" size="50" maxlength="100" /></td>
          </tr>    

          <tr>
			  		<td> Is Primary Repository?</td>
            <td><form:checkbox path="primaryRepository" value="1" /></td>
          </tr>  
          <tr>
			  <td >Secondary Repository</td>
              <td  >
              		<form:select path="secondaryRepositoryId">
			  			<form:option value=""  label="-Select a value" />
			  			<form:options items="${systems}" itemValue="managedSysId" itemLabel="name"  />
		            </form:select>
              </td>
          </tr>
          <tr>
			  <td >Always Update Secondary</td>
              <td ><form:checkbox path="updateSecondary" value="1" /></td>
          </tr>

        <tr>
            <td>Target System Type</td>
            <td>
                <form:select path="handler1">
                    <form:option value=""  label="-Select a value" />
                    <form:option value="LDAP"  label="LDAP" />
                    <form:option value="ACTIVE_DIRECTORY"  label="ACTIVE DIRECTORY" />
                </form:select>
                <i>Optional - Select a system to leverage functionality in the connector for that system.</i>
                </td>
        </tr>


        <tr>
            <td>Add Object Rule</td>
            <td><form:input path="addHandler" size="50" maxlength="100" /></td>
        </tr>
        <tr>
            <td>Modify Object Rule</td>
            <td><form:input path="modifyHandler" size="50" maxlength="100" /></td>
        </tr>
        <tr>
            <td>Delete Object Rule</td>
            <td><form:input path="deleteHandler" size="50" maxlength="100" /></td>
        </tr>
        <tr>
            <td>Password Rule</td>
            <td><form:input path="passwordHandler" size="50" maxlength="100" /></td>
        </tr>
        <tr>
            <td>Suspend Object Rule</td>
            <td><form:input path="suspendHandler" size="50" maxlength="100" /></td>
        </tr>
      <!--
      create a screen that is unique for each connector instead of one generic screen
        <tr>
            <td>Custom Rule 1</td>
            <td><form:input path="handler2" size="50" maxlength="100" /></td>
        </tr>
        <tr>
            <td>Custom Rule 2</td>
            <td><form:input path="handler3" size="50" maxlength="100" /></td>
        </tr>
        <tr>
            <td>Custom Rule 3</td>
            <td><form:input path="handler4" size="50" maxlength="100" /></td>
        </tr>
        <tr>
            <td>Custom Rule 4</td>
            <td><form:input path="handler5" size="50" maxlength="100" /></td>
        </tr>
       -->
	</table>
          <tr class="buttonRow">
              <td  align="right">
              <c:if test="${managedSysConnectionCmd.managedSysId != null}" >
              	<input type="submit" name="btn" value="Test Connection"> 
              	<input type="submit" name="btn" value="Delete">
              </c:if>
              <input type="submit" name="btn" value="Save"> </td>
          </tr>
</table>

</form:form>
</TD>
</TR>
</TABLE>


