<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai"%>

<f:view locale="#{UserLocale.locale}">
	<jsp:useBean id="msgs" class="org.sakaiproject.util.ResourceLoader"
		scope="session">
		<jsp:setProperty name="msgs" property="baseName" value="messages" />
	</jsp:useBean>
	<sakai:view_container title="Signup Tool">
		<style type="text/css">
@import url("/sakai-signup-tool/css/signupStyle.css");
</style>
		<script TYPE="text/javascript" LANGUAGE="JavaScript"
			src="/sakai-signup-tool/js/signupScript.js"></script>
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
			<li class="firstToolBarItem" role="menuitem"><span><a
				class="print-window" href="#"><h:outputText
				value="#{msgs.print_friendly}" /></a></span></li>
		</ul>
		<sakai:view_content>
			<%--// Savitha: I copied and edited an existing JSP to create this one. All the string literals are in the bundle and referenced here
					I will leave comments where things need to be wired --%>

			<%--//TODO: the value and conditions for the generic error messages will need to change--%>
			<h:outputText
				value="#{msgs.event_error_alerts} #{errorMessageUIBean.errorMessage}"
				styleClass="alertMessage" escape="false"
				rendered="#{errorMessageUIBean.error}" />
			<h:form id="attendanceView">

				<%--//TODO: attend.event.title below needs to resolve to the event title--%>
				<h3><h:outputText value="#{msgs.attend_view_title}" /><h:outputText
					value="#{AttendanceSignupBean.meetingWrapper.meeting.title}"
					styleClass="highlight" /></h3>



				<%--//TODO: this datatable needs to be bound to the participants for an event 
					the value, binding attributes need to reflect this--%>
				<h:dataTable id="attendanceList"
					value="#{AttendanceSignupBean.timeslotWrappers}"
					binding="#{AttendanceSignupBean.timeslotWrapperTable}"
					var="timeSlotWrapper" style="width:35em;"
					rowClasses="oddRow,evenRow" styleClass="listHier lines centerlines">

					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.tab_time_slot}"
								style="padding-left:15px;" />
						</f:facet>
						<h:panelGroup id="timeslot">
							<h:outputText value="#{timeSlotWrapper.timeSlot.startTime}">
								<f:convertDateTime pattern="h:mm a" />
							</h:outputText>
							<h:outputText value="#{timeSlotWrapper.timeSlot.startTime}"
								rendered="#{AttendanceSignupBean.meetingWrapper.meeting.meetingCrossDays}">
								<f:convertDateTime pattern=", EEE" />
							</h:outputText>
							<h:outputText value="#{msgs.timeperiod_divider}" escape="false" />
							<h:outputText value="#{timeSlotWrapper.timeSlot.endTime}">
								<f:convertDateTime pattern="h:mm a" />
							</h:outputText>
							<h:outputText value="#{timeSlotWrapper.timeSlot.endTime}"
								rendered="#{AttendanceSignupBean.meetingWrapper.meeting.meetingCrossDays}">
								<f:convertDateTime pattern=", EEE, " />
							</h:outputText>
							<h:outputText value="#{timeSlotWrapper.timeSlot.endTime}"
								rendered="#{AttendanceSignupBean.meetingWrapper.meeting.meetingCrossDays}">
								<f:convertDateTime dateStyle="short" />
							</h:outputText>
						</h:panelGroup>
					</h:column>


					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.tab_attendees}" />
						</f:facet>

						<h:panelGroup rendered="#{timeSlotWrapper.timeSlot.canceled}">
							<h:outputText value="#{msgs.event_canceled}" escape="false"
								styleClass="organizer_canceled" />
						</h:panelGroup>
						<h:panelGroup rendered="#{!timeSlotWrapper.timeSlot.canceled}">
							<h:dataTable id="availableSpots"
								value="#{timeSlotWrapper.attendeeWrappers}"
								var="attendeeWrapper">
								<h:column>
									<h:panelGroup>
										<h:selectBooleanCheckbox value="true" />
										<h:outputText value="#{attendeeWrapper.displayName}"
											rendered="#{attendeeWrapper.signupAttendee.attendeeUserId !=null}" />
									</h:panelGroup>
								</h:column>
							</h:dataTable>
						</h:panelGroup>
					</h:column>

				</h:dataTable>

				<sakai:button_bar>
					<h:commandButton action="#{AttendanceSignupBean.doSave}"
						value="#{msgs.save_button}" />
					<h:commandButton action="#{AttendanceSignupBean.doCancel}"
						value="#{msgs.cancel_button}" />
				</sakai:button_bar>
			</h:form>
		</sakai:view_content>
	</sakai:view_container>
</f:view>
