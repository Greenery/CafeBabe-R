<%@ page language="java" contentType="text/html; charset=utf-8"     pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 

<script type="text/javascript">
<!--


String.prototype.toProperCase = function() 
{
    return this.charAt(0).toUpperCase() + this.substring(1,this.length).toLowerCase();
}


function validateInt(fld) {
   if (isNaN(fld.value)) {
		alert(fld.name + " is not a number");
		return false;
	}
	return true;
}

function showSupervisorDialog(idfield, namefield) {
	var ua = window.navigator.userAgent;
    var msie = ua.indexOf ( "MSIE " );

    if ( msie > 0 ) {	
		dialogReturnValue = window.showModalDialog("user/dialogshell.jsp",null,"dialogWidth:670px;dialogHeight:600px;");
		document.getElementById (idfield).value = dialogReturnValue.id;
		document.getElementById (nameField).value = dialogReturnValue.name;
    }else {
    	dialogReturnValue = window.showModalDialog("user/selsupervisor.jsp",null,"dialogWidth:670px;dialogHeight:600px;");
    	document.getElementById (idfield).value = dialogReturnValue.id;
    	document.getElementById (namefield).value = dialogReturnValue.name;
    }
}


//-->
</script>

<form:form commandName="editUserCmd">

<form:hidden path="user.userId" />
<form:hidden path="addressId" />



<table width="620" border="0" cellspacing="2" cellpadding="1" align="center"> 
	<tr>
      <td colspan="4" class="title">         
          <strong>Edit User Information</strong>
      </td>
      <td colspan="2" class="text" align="right">         
          <font size="1" color="red">*</font> Required         
      </td>
   </tr>
   
   <tr>
 		<td colspan="6" align="center" bgcolor="8397B4" >
 		  <font></font>
 		</td>
  </tr> 
   <tr>
       <td class="plaintext" align="right"></td>
       <td class="plaintext" colspan="3">
			<font color="red"></font>
       </td>
    </tr>
   <tr class="normaltext">
       <td class="normaltext" align="right">First Name<font color="red">*</font></td>
       <td>
			<form:input path="user.firstName" size="40" maxlength="40" onchange="firstName.value = firstName.value.toProperCase();" />  
			<br><form:errors path="user.firstName" cssClass="error" />     
		</td>
	   <td class="normaltext" align="right">Middle</td>
	   <td>
			<form:input path="user.middleInit" size="10" maxlength="10"  onchange="middleName.value = middleName.value.toProperCase();" />
	  </td>
       <td class="normaltext" align="right">Last Name<font color="red">*</font></td>
       <td>
			<form:input path="user.lastName" size="40" maxlength="40" onchange="lastName.value = lastName.value.toProperCase();" /> 
			<form:errors path="user.lastName" cssClass="error" />   
		</td>
		
    </tr>
   <tr class="normaltext">
	  <td class="normaltext" align="right">Nickname</td>
	  <td>
			<form:input path="user.nickname" size="20"  maxlength="20"  onchange="nickname.value = nickname.value.toProperCase();" />
       </td>
	   <td class="normaltext" align="right">Maiden Name</td>
	   <td>
			<form:input path="user.maidenName" size="20" maxlength="20"  onchange="maiden.value = maiden.value.toProperCase();"   />
	  </td>
	  <td class="normaltext" align="right">Suffix</td>
	  <td>
			<form:input path="user.suffix" size="20"  maxlength="20"  onchange="suffix.value = suffix.value.toProperCase();" />
       </td>
    </tr>
        <tr class="normaltext">
		 <td align="right">Organization</td>
		 <td valign="middle">
		   <form:select path="user.companyId" multiple="false">
              <form:option value="" label="-Please Select-"/>
              <form:options items="${orgList}" itemValue="orgId" itemLabel="organizationName"/>
          </form:select>  
          <BR><form:errors path="user.companyId" cssClass="error" />   
          
		 </td>

        <td align="right">Department</td>
        <td >
           <form:select path="user.deptCd" multiple="false">
              <form:option value="" label="-Please Select-"/>            
              <form:options items="${deptList}" itemValue="orgId" itemLabel="organizationName"/>
          </form:select>     
          <form:errors path="user.deptCd" cssClass="error" />  

        </td>
		<td align="right">Division</td>
        <td >
           <form:select path="user.division" multiple="false">
              <form:option value="" label="-Please Select-"/>
              <form:options items="${divList}" itemValue="orgId" itemLabel="organizationName"/>
          </form:select>                    
        </td>
     </tr>  
    <tr class="normaltext">
         <td align="right">Functional Title</td>
         <td> 
         	<form:input path="user.title" size="40" /> 
         	<BR><form:errors path="user.title" cssClass="error" />  
         </td>
		<td algn="right">Job Code:</td>
        <td>
               <form:select path="user.jobCode">
               		 <form:option value="" label="-Please Select-"/>
	              	  <c:forEach items="${jobCodeList}" var="jobCode">
		                <form:option value="${jobCode.id.statusCd}" label="${jobCode.description}" />
		              </c:forEach>
          		</form:select>         		
        </td>
			<td align="right">Classification</td>
        	<td><form:input path="user.classification" size="40" /> </td>
     </tr>
 
     <tr class="normaltext">
         <td align="right">Employee Id</td>
         <td> 
         	<form:input path="user.employeeId" size="40" /> 
         </td>
		<td algn="right">User Type Ind:</td>
        <td><form:input path="user.userTypeInd" size="30" />       		
        </td>
			<td align="right">Employment Type</td>
        	<td>
	            <form:select path="user.employeeType">
	            	  <form:option value="-" label="-Please Select-"/>
	                  <c:forEach items="${userTypeList}" var="userType">
		                <form:option value="${userType.id.statusCd}" label="${userType.description}" />
		              </c:forEach>
          		</form:select>
          		<BR><form:errors path="user.employeeType" cssClass="error" />  
		</td>
     </tr>

    <tr >
		 <td class="plaintext"  align="right">Supervisor
		 </td>
         <td class="plaintext" colspan="3" >
         	<form:hidden path="supervisorId" />
            <form:input path="supervisorName" size="40" readonly="true" /> <a href="javascript:showSupervisorDialog('supervisorId', 'supervisorName' );">Select Supervisor</a>

		</td>
		<td class="plaintext"  align="right" colspan="2"></td>

    </tr>   
    <tr >
		 <td class="plaintext"  align="right">Alternate Contact</td>
         <td class="plaintext" colspan="3">
         	<form:hidden path="user.alternateContactId" />
            <form:input path="alternateContactName" size="40" readonly="true" /> <a href="javascript:showSupervisorDialog('user.alternateContactId', 'alternateContactName' );">Select Alternate</a>

		</td>
		<td class="plaintext"  align="right" colspan="2"></td>
    </tr>
    <tr class="normaltext">
   		<td   align="right">DOB<br>(MM/dd/yyyy)</td>
        <td  ><form:input path="user.birthdate" size="20" /><br>
        	<font color="red"><form:errors path="user.birthdate" /></font>
        </td>
    

		<td    align="right">Gender<font color="red">*</font></td>
        <td  colspan="3"  class="tdlightnormal">
	            <form:select path="user.sex">
				  <form:option value="" label="-Please Select-"  />
	              <form:option value="M" label="Male" />
				  <form:option value="F" label="Female" />
				  <form:option value="D" label="Declined to State" />
          		</form:select>
          		<br><form:errors path="user.sex" cssClass="error" />  
		</td>
    </tr>
       <tr class="normaltext">
		 <td    align="right">Start Date</td>
		<td  ><form:input path="user.startDate" size="20" /><br>
        	<font color="red"><form:errors path="user.startDate" /></font>
        </td>
		
		
		<td    align="right">Last Date</td>
		<td colspan="3"><form:input path="user.lastDate" size="20" /><br>
        	<font color="red"><form:errors path="user.lastDate" /></font>
        </td>
    </tr>  
 
     <tr class="normaltext">
		 <td align="right">User Status</td>
		<td><form:input path="user.status" size="20" readonly="true"/>
	

        </td>
		
		
		<td    align="right">Secondary Status</td>
		<td colspan="3"><form:input path="user.secondaryStatus" size="20" readonly="true" />
			
        </td>
    </tr>
    <tr  class="normaltext" >
		 <td align="right">Show in Search</td>
         <td>
                 <form:select path="user.showInSearch">
				  <form:option value="0" label="0"  />
	              <form:option value="1" label="1" />
				  <form:option value="2" label="2" />
				  <form:option value="3" label="3"  />
	              <form:option value="4" label="4" />
				  <form:option value="5" label="5" />
          		</form:select>
		</td>
		 <td class="plaintext"  align="right"></td>
         <td class="plaintext" >

		</td>
		<td class="plaintext"  align="right" colspan="2"></td>

    </tr>
    <tr>
        <td colspan="6"><form:errors path="attributeList" cssClass="error" /> </td>
    </tr>

       <c:forEach items="${editUserCmd.attributeList}" var="userAttr" varStatus="attr">

       <tr>

           <td  align="right">${editUserCmd.attributeList[attr.index].name}
               <c:if test="${editUserCmd.attributeList[attr.index].required == true}" >
                   <font color="red">*</font>
               </c:if>
               <form:hidden path="attributeList[${attr.index}].id" />
               <form:hidden path="attributeList[${attr.index}].userId" />
               <form:hidden path="attributeList[${attr.index}].name" />
               <form:hidden path="attributeList[${attr.index}].attrGroup"  />
               <form:hidden path="attributeList[${attr.index}].metadataElementId"  />
               <form:hidden path="attributeList[${attr.index}].required"  />
           </td>
           <td  colspan="5"><form:input path="attributeList[${attr.index}].value" size="50" maxlength="50" />
           </td>


       </tr>

   </c:forEach>



   <tr class="normaltext">
   	<td colspan="6" class="tddark" align="center">Contact Information</td>
   </tr>
  <tr class="normaltext">
       <td   align="right">Building Name</td>
       <td  > 
       	   <form:select path="user.locationCd" multiple="false" >
              <form:option value="" label="-Please Select-"/>
              <c:forEach items="${locationAry}" var="location">
                <form:option value="${location.locationId}" label="${location.name}" />
              </c:forEach>
          </form:select>  

       </td>
       <td   align="right"  colspan="4" rowspan="5">
       			<table class="resourceTable" cellspacing="2" cellpadding="2" >
                      <tr class="header">
                            <td colspa="4" ><b>Phone Numbers</b></td>
                     </tr>
                      <tr class="header">
                            <td>Label</td>
                            <td>Area CD</td>
                            <td>Phone Number</td>
                            <td>Extension</td>
                           <td>Default</td>
                     </tr>
                          <c:forEach items="${editUserCmd.phoneList}" var="phone" varStatus="ph">

                          <tr>
                                <td class="tableEntry"><form:hidden path="phoneList[${ph.index}].phoneId" />
                                    <form:hidden path="phoneList[${ph.index}].parentId" />
                                    <form:hidden path="phoneList[${ph.index}].parentType" />
                                    <form:input path="phoneList[${ph.index}].name" maxlength="50" readonly="true" />
                                </td>
                              <td class="tableEntry"> <form:input path="phoneList[${ph.index}].areaCd" size="5" maxlength="5" />  </td>
                              <td class="tableEntry"> <form:input path="phoneList[${ph.index}].phoneNbr" size="15" maxlength="10"  />  </td>
                               <td class="tableEntry"> <form:input path="phoneList[${ph.index}].phoneExt" size="10" maxlength="5"  /> </td>
                              <td class="tableEntry">
                                  <form:select path="phoneList[${ph.index}].isDefault">
                                      <form:option value="0" label="No"/>
                                      <form:option value="1" label="Yes"/>
                                </form:select>
                              </td>

                          </tr>
                      </c:forEach>
                  </table>
       
       </td>

   </tr>
  <tr class="normaltext">
       <td   align="right">Bldg Num - Address</td>
       <td  ><form:input path="user.bldgNum" size="5"  /> <form:input path="user.address1" size="20"  /></td>

   </tr>
  <tr class="normaltext">
       <td   align="right"></td>
       <td  ><form:input path="user.address2" size="30"  /></td>

   </tr>
 	<tr class="normaltext">
       <td   align="right">City</td>
       <td  ><form:input path="user.city" size="30"  /></td>

   </tr>
     
 <tr class="normaltext">
       <td   align="right">State</td>
       <td  ><form:input path="user.state" size="30"  /></td>

   </tr> 

  <tr class="normaltext">
       <td   align="right">Zip Code</td>
       <td  ><form:input path="user.postalCd" size="30" maxlength="10"  /></td>

   </tr>

  <tr class="normaltext">
       <td   align="right">Corporate Email-1</td>
       <td   colspan="5"><form:input path="email1" size="40" maxlength="50"  />
       <form:hidden path="email1Id" />
       <form:hidden path="email2Id" />
       <form:hidden path="email3Id" />
</td>  

   </tr>
  <tr class="normaltext">
       <td   align="right">Personal Email</td>
       <td   colspan="5"><form:input path="email2" size="40" maxlength="50"  /></td>
   </tr>

 
  <tr>
 
  	<td class="normaltext" colspan="2">

  	</td>
    <td colspan="4" align="right"> 
   <c:if test="${user.status != 'ACTIVE'}" >
 <input type="submit" name="saveBtn" value="ACTIVE"/>
	</c:if>	    
    <c:if test="${user.status != 'DELETED'}" >
 <input type="submit" name="saveBtn" value="DELETE"/> | 
	</c:if>
   <input type="submit" name="saveBtn" value="DISABLE"/> <input type="submit" name="saveBtn" value="ENABLE"/>

 
    	  | <input type="submit" name="saveBtn" value="Submit"/>   <input type="submit" name="_cancel" value="Cancel" />
    </td>
  </tr>


</table>

<table>
	<tr>
		<td colspan="3" class="title">Active Password Policy for User:${editUserCmd.policyName}</td>
	</tr>
	   <tr>
 		<td colspan="3" align="center" bgcolor="8397B4" >
 		  <font></font>
 		</td>
 	</tr>
 	 <c:if test="${editUserCmd.passwordPolicyAttr != null}" >
 	 	 <c:forEach items="${editUserCmd.passwordPolicyAttr}" var="passwordPolicyAttr" varStatus="attr">
			 	<tr>
			 		<td class="normaltext">${passwordPolicyAttr.name}</td>
		 			<td class="normaltext">${passwordPolicyAttr.value1}</td>
	 				<td class="normaltext">${passwordPolicyAttr.value2}</td>
			 	</tr>
 		</c:forEach>
 	</c:if>

  </tr> 
	
</table>

</form:form>

