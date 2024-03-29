<%@ page language="java" contentType="text/html; charset=utf-8"     pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 


		<table  width="1100pt">
			<tr>
				<td>
					<table width="100%">
						<tr>
							<td class="pageTitle" width="70%">
								<h2 class="contentheading">User Management - History</h2>
						</td>
						</tr>
					</table>
			</td>
				<tr>
				<td>		

	<table width="1100pt">
			<tr>
				<td align="center" height="100%">
			     <fieldset class="userform" >
						<legend>USER - AUDIT LOG (${numOfDays} DAY SNAPSHOT)</legend>
	
		<table class="resourceTable" cellspacing="2" cellpadding="2" width="100%" >	
    			<tr class="header">
    				<th>DATE</td>
    				<th>ACTION</td>
    				<th>ACTION STATUS</td>
                    <th>RES/ROLE</td>
    				<th>REASON</td>
    				<th>REQ PRINCIPAL</td>
                    <th>TARGET PRINCIPAL</td>
    			</tr>
		      <c:forEach items="${auditLog}" var="log" >
		  
				<tr>
					<td class="tableEntry"><fmt:formatDate type="both" value="${log.actionDatetime}" /></td>
					<td class="tableEntry">${log.actionId}</td>
					<td class="tableEntry">${log.actionStatus}</td>
                    <td class="tableEntry">${log.resourceName}</td>
					<td class="tableEntry">${log.reason}</td>
					<td class="tableEntry">${log.principal}</td>
                    <td class="tableEntry">${log.customAttrvalue3}</td>
				</tr>
				
			</c:forEach>
			</table>
 	</td>	
	</tr>    
   
</table>

	</td>
 </tr>
</table>

