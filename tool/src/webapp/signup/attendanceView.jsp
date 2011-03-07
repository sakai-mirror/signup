<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>

<f:view locale="#{UserLocale.locale}">
	<jsp:useBean id="msgs" class="org.sakaiproject.util.ResourceLoader" scope="session">
	   <jsp:setProperty name="msgs" property="baseName" value="messages"/>
	</jsp:useBean>
	<sakai:view_container title="Signup Tool">
		<style type="text/css">
				@import url("/sakai-signup-tool/css/signupStyle.css");
		</style>
		<script TYPE="text/javascript" LANGUAGE="JavaScript" src="/sakai-signup-tool/js/signupScript.js"></script>	
		<script typr="text/javascript" src="/library/js/jquery.js"></script>	
    <script type="text/javascript">
        $(document).ready(function(){
            sakai.setupSelectList('attendanceList', 'selectAll', 'selectedSelected');
            sakai.setupPrintPreview();
            $('a.print-window').click(function(){
                var w = window.open(this.href, 'printwindow', 'width=600,height=400,scrollbars=yes,resizable=yes');
                w.focus();
                return false;
            });
        });
    </script>
			<ul class="navIntraTool actionToolbar">
				<li class="firstToolBarItem" role="menuitem"><span><a class="print-window" href="#"><h:outputText value="#{msgs.print_friendly}"  /></a></span></li>
			</ul>
		 <sakai:view_content>
			<%--// Savitha: I copied and edited an existing JSP to create this one. All the string literals are in the bundle and referenced here
					I will leave comments where things need to be wired --%>

			<%--//TODO: the value and conditions for the generic error messages will need to change--%>
			<h:outputText value="#{msgs.event_error_alerts} #{errorMessageUIBean.errorMessage}" styleClass="alertMessage" escape="false" rendered="#{errorMessageUIBean.error}"/> 
			<h:form id="attendanceView">
				
				<%--//TODO: attend.event.title below needs to resolve to the event title--%>
			 	<h3><h:outputText value="#{msgs.attend_view_title}" /><h:outputText value="#{AttendanceSignupBean.meetingWrapper.meeting.title}" styleClass="highlight"/></h3>
				
				

				<%--//TODO: this datatable needs to be bound to the participants for an event 
					the value, binding attributes need to reflect this--%>
				 	<t:dataTable 
				 		id="attendanceList"
				 		value="#{SignupMeetingsBean.signupMeetings}"
				 		binding="#{SignupMeetingsBean.meetingTable}"
				 		var="wrapper" style="width:35em;" 
				 		rowId="#{wrapper.recurId}"
				 		rowClasses="oddRow,evenRow"
				 		styleClass="listHier lines centerlines">
	
						<t:column>
							<f:facet name="header" >
									<%--//TODO: doing the select-all client side, need to test 
									<h:outputText value="<input type="checkbox" id="selectAll" name="selectAll" /><label for="selectAll">" escape="false"/> --%>
										<h:outputText value="#{msgs.attend_view_select_all}" escape="false" />
									<h:outputText value="</label>" escape="false" />
							</f:facet>
							<h:panelGroup>
									<%--//TODO: selectBooleanCheckbox below needs to be bound to attendees --%>
									<%--//TODO: selectBooleanCheckbox below needs to be bound to attendees --%>
									<h:selectBooleanCheckbox value="#{wrapper.selected}"/>
									<h:outputText value="#{attend.attendee}" />
							</h:panelGroup>
						</t:column>
					</t:dataTable>
	 
          <sakai:button_bar>
              <h:commandButton action="#{AttendanceSignupBean.doSave}"   value="#{msgs.next_button}" />
              <h:commandButton action="#{AttendanceSignupBean.doCancel}" value="#{msgs.cancel_button}" /> 
          </sakai:button_bar>
          
				
			 </h:form>
  		</sakai:view_content>	
	</sakai:view_container>
</f:view> 
