<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t" %>

<f:view>
	<f:loadBundle basename="messages" var="msgs"/>
	<sakai:view_container title="Signup Tool">
		<style type="text/css">
			@import url("/sakai-signup-tool/css/signupStyle.css");
		</style>	
		
		<sakai:view_content>
			<h:outputText value="#{msgs.event_error_alerts} #{errorMessageUIBean.errorMessage}" styleClass="alertMessage" escape="false" rendered="#{errorMessageUIBean.error}"/>      			
			<h:form id="meeting">
		 		<sakai:view_title value="#{msgs.cancel_timeslot}"/>
				<sakai:doc_section>
					<h:outputText value="#{msgs.confirm_cancel}"/>
				</sakai:doc_section>
				<sakai:messages />
				
				<sakai:button_bar>
					<sakai:button_bar_item id="cancelTimeslot" action="#{OrganizerSignupMBean.cancelTimeslot}" value="#{msgs.cancel_timeslot_button}"/> 			
					<sakai:button_bar_item id="cancel" action="organizerMeeting" value="#{msgs.cancel_button}"  immediate="true"/>  
                </sakai:button_bar>
				
			</h:form>
		</sakai:view_content>
	</sakai:view_container>
	
</f:view>		