<%@ page language="java" contentType="text/html; charset=utf-8"     pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String mode = (String)request.getAttribute("mode");

%>
		<table  width="700pt">
			<tr>
				<td>
					<table width="100%">
						<tr>
							<td class="pageTitle" width="90%">
								<h2 class="contentheading">Group Manager</h2>
						</td>
						</tr>
					</table>
			</td>
		</tr>
            <% if ("1".equals(mode)) { %>
            <tr>
                <td><font color="red">The information has been successfully saved.<br>
                    To exit this screen press [Cancel}</font>
                </td>
            </tr>
            <% } %>

<form:form commandName="groupDetailCmd">
		<table width="700pt"  class="bodyTable" height="100%" >
				<tr>
					<td>    
							<fieldset class="userformSearch" >
							<legend>ORGANIZATION DETAILS</legend>
				
					<table class="fieldsetTable"  width="100%" >
	
				
          <tr>
			  <td>Group ID</td>
              <td><form:input path="group.grpId" size="32" maxlength="32" readonly="true" /></td>
          </tr>
          <tr>
              <td>Name<font color="red">*</font></td>
			  <td><form:input path="group.grpName" size="40" maxlength="40"  /><br>
			  <form:errors path="group.grpName" cssClass="error" /></td>
		  </tr>
          <tr>
			  <td>Description</td>
              <td><form:input path="group.description" size="40" maxlength="80" /></td>
          </tr>
          <tr>
              <td>Group Type</td>
			  <td>
			  		<form:select path="group.metadataTypeId">
			  			<form:option value=""  label="-Select a value" />
			  			<form:options items="${groupDetailCmd.typeList}" itemValue="metadataTypeId" itemLabel="description"  />
		            </form:select>
			  </td>
		  </tr>
          <tr>
              <td>Group Class</td>
			  <td><form:input path="group.groupClass" size="40" maxlength="40" />
			  </td>
		  </tr>   
		  <tr>
              <td>Group Status</td>
			  <td>
			  		<form:select path="group.status">
			  			<form:option value=""  label="-Select a value" />
			  			<form:option value="ACTIVE"  label="ACTIVE" />
			  			<form:option value="DELETED"  label="DELETED" />
			  			<form:option value="PENDING_APPROVAL"  label="PENDING APPROVAL" />
		            </form:select>
			  </td>
		  </tr>	
          <tr>
              <td>Parent Group</td>
			  			<td><form:input path="group.parentGrpId" size="32" readonly="true"  /> 
							  <c:if test="${groupDetailCmd.group.parentGrpId != null}" >
							  <a href="groupDetail.cnt?groupId=${groupDetailCmd.group.parentGrpId}">View</a>
							  </c:if>
			  			</td>
		  </tr>
          <tr>
              <td>Organization</td>
			 				<td>
			  		<form:select path="group.companyId">
			  			<form:option value=""  label="-Select a value" />
			  			<form:options items="${groupDetailCmd.orgList}" itemValue="orgId" itemLabel="organizationName"  />
		            </form:select><br>
		           
			  </td>
		  </tr>
          <tr>
              <td>Group Owner</td>
			  <td>
			  		<form:input path="group.ownerId" size="40" maxlength="40" />
			  </td>
		  </tr>
          <tr>
              <td>Inherit From Parent</td>
			  <td>
			  		<form:select path="group.inheritFromParent">
			  			<form:option value=""  label="-Select a value" />
			  			<form:option value="0"  label="NO" />
			  			<form:option value="1"  label="YES" />
		            </form:select>
			  </td>
		  </tr>

                        <tr>
                            <td colspan="2">

                                <table width="600pt" >
                                    <tr>
                                        <td align="center" height="100%">
                                            <fieldset class="userform" >
                                                <legend>CUSTOM ATTRIBUTES </legend>
                                                <table class="resourceTable" cellspacing="2" cellpadding="2" width="600pt">

                                                    <tr class="header">
                                                        <th>Name</th>
                                                        <th>Value</th>
                                                    </tr>

                                                    <c:if test="${groupDetailCmd.attributeList != null}" >
                                                        <c:forEach items="${groupDetailCmd.attributeList}" var="attributeList" varStatus="attr">
                                                            <tr>
                                                                <td><form:input path="attributeList[${attr.index}].name" size="20"  />

                                                                    <form:hidden path="attributeList[${attr.index}].id" />
                                                                    <form:hidden path="attributeList[${attr.index}].groupId" />
                                                                </td>
                                                                <td>
                                                                    <form:input path="attributeList[${attr.index}].value" size="40" maxlength="200" /> </td>
                                                            </tr>

                                                        </c:forEach>
                                                    </c:if>
                                                    <tr>
                                                        <td colspan="2"><i>To remove a custom attribute, leave the name blank</i><br>
                                                            <i>To add a new row, click on SAVE first. A new row will be added.</i></td>
                                                    </tr>
                                                </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>



  
          <tr class="buttonRow">
              <td colspan="2" align="right">
              <c:if test="${groupDetailCmd.group.grpId != null}" >
              <a href="groupDetail.cnt?parentGroupId=${groupDetailCmd.group.grpId}">New Child Group</a> 
              	<input type="submit" name="btn" value="Delete" onclick="return confirm('Are you sure you want to delete this Group');">
              </c:if>
              <input type="submit" name="btn" value="Save"> <input type="submit" name="_cancel" value="Cancel" /></td>
          </tr>
</table>
</form:form>
</TD>
</TR>
</TABLE>

<c:if test="${groupDetailCmd.childGroup != null}" >
<table width="600pt" >
			<tr>
				<td align="center" height="100%">
			     <fieldset class="userform" >
						<legend>CHILD GROUPS </legend>
						<table class="resourceTable" cellspacing="2" cellpadding="2" width="600pt">	
	<tr class="header">
		<th>Name</th>
		<th>Description</th>
		<th>Status</th>
	</tr>	
	<c:forEach items="${groupDetailCmd.childGroup}" var="group">
		<tr>

			<td class="tableEntry"><a href="groupDetail.cnt?groupId=${group.grpId}">${group.grpName}</a></td>
			<td class="tableEntry">${group.description}</td>
			<td class="tableEntry">${group.status}</td>
		</tr>
	</c:forEach>
</table>
</td>
</tr>
</table>
</c:if>
 </td>
</tr>
</table>
