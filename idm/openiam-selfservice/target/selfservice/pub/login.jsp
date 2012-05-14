<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<% 

%>

			<div class="block">
				<div class="wrap">
					<h1 class="logo"><a href="#">OpenIAM</a></h1>
				
				
				<form:form commandName="loginCmd">
					 
							<label for="t-1">Enter Login ID:<span>*</span></label>
							<form:input path="principal" size="40" maxlength="40" />
     					<form:errors path="principal" cssClass="error" />
     	
							<label for="t-2">Enter Password:<span>*</span></label>
							<form:password path="password" size="40" maxlength="40" />
    					<form:errors path="password" cssClass="error" />
			
							<div class="button">
								<input type="reset" value="Reset" />
							</div>
							<div class="button">
								<input type="submit" value="Login" />
							</div>
						</fieldset>
					</form:form>	
				</div>
			</div>