<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%-- This file generated by Sakai App Builder --%>

<f:view locale="#{UserLocale.locale}">
	<jsp:useBean id="msgs" class="org.sakaiproject.util.ResourceLoader" scope="session">
	   <jsp:setProperty name="msgs" property="baseName" value="messages"/>
	</jsp:useBean>
	<sakai:view_container title="Signup Tool">
		<style type="text/css">
			@import url("/sakai-signup-tool/css/signupStyle.css");
		</style>
		<style type="text/css" media="print">
				@import url("/sakai-signup-tool/css/print.css");
		</style>
		<script TYPE="text/javascript" LANGUAGE="JavaScript" src="/sakai-signup-tool/js/signupScript.js"></script>
		<script TYPE="text/javascript" LANGUAGE="JavaScript" src="/sakai-signup-tool/js/jquery.js"></script>
			
		<h:form id="signupMeeting">
			<sakai:tool_bar>
				<sakai:tool_bar_item value="#{msgs.event_pageTop_link_for_download}" action="#{DownloadEventBean.downloadOneEvent}" />
				<h:outputLink id="print" value="javascript:window.print();" style="vertical-align:bottom;">
					<h:graphicImage url="/images/printer.png"
							alt="#{msgs.print_friendly}" title="#{msgs.print_friendly}" />
					<h:outputText value="#{msgs.print_event}" escape="false"/>
				</h:outputLink>
			</sakai:tool_bar>
		</h:form>
		
		<sakai:view_content>
			<h:outputText value="#{msgs.event_error_alerts} #{errorMessageUIBean.errorMessage}"
				styleClass="alertMessage" escape="false"
				rendered="#{errorMessageUIBean.error}" />

			<h:form id="meeting">
				<sakai:view_title value="#{msgs.event_participant_view_page_title}" />

				<sakai:messages />

				<%-- show title only when collapsed --%>
				<h:panelGrid id="showMeetingTitleOnly" columns="2" columnClasses="titleColumn,valueColumn" styleClass="orgShowTitleOnly">
							<h:outputText value="#{msgs.event_name}" styleClass="titleText" escape="false"/>
								<h:panelGroup>
									<h:panelGroup rendered="#{AttendeeSignupMBean.meetingWrapper.meeting.recurrenceId !=null}">
										<h:graphicImage title="#{msgs.event_tool_tips_recurrence}" value="/images/recurrence.gif"  alt="recurrence" style="border:none" />
										<h:outputText value="&nbsp;" escape="false"/>
									</h:panelGroup>
								<h:outputText value="#{AttendeeSignupMBean.meetingWrapper.meeting.title}" styleClass="longtext"/>
							</h:panelGroup>
				</h:panelGrid>
				
				<%-- show all meeting details when expanded --%>
				<h:panelGroup id="meetingInfoDetails">
						<h:panelGrid columns="2" columnClasses="titleColumn,valueColumn">
							<h:outputText value="#{msgs.event_name}" styleClass="titleText" escape="false"/>
							<h:panelGroup>
								<h:panelGroup rendered="#{AttendeeSignupMBean.meetingWrapper.meeting.recurrenceId !=null}">
									<h:graphicImage title="#{msgs.event_tool_tips_recurrence}" value="/images/recurrence.gif"  alt="recurrence" style="border:none" />
									<h:outputText value="&nbsp;" escape="false"/>
								</h:panelGroup>
								<h:outputText value="#{AttendeeSignupMBean.meetingWrapper.meeting.title}" styleClass="longtext" />
							</h:panelGroup>
		
							<h:outputText value="#{msgs.event_organizer}" styleClass="titleText" escape="false"/>
							<h:outputText value="#{AttendeeSignupMBean.meetingWrapper.creator}"
								styleClass="longtext" />
		
							<h:outputText value="#{msgs.event_location}" styleClass="titleText" escape="false"/>
							<h:outputText
								value="#{AttendeeSignupMBean.meetingWrapper.meeting.location}"
								styleClass="longtext" />
		
							<h:outputText value="#{msgs.event_date}" styleClass="titleText" escape="false"/>
							<h:panelGroup>
								<h:outputText
									value="#{AttendeeSignupMBean.meetingWrapper.meeting.startTime}" styleClass="longtext">
									<f:convertDateTime pattern="EEEEEEEE, " />
								</h:outputText>
								<h:outputText
									value="#{AttendeeSignupMBean.meetingWrapper.meeting.startTime}" styleClass="longtext">
									<f:convertDateTime dateStyle="long"/>
								</h:outputText>
							</h:panelGroup>
							
							<h:outputText value="#{msgs.event_time_period}" styleClass="titleText" escape="false"/>
							<h:panelGroup>
								<h:outputText value="#{AttendeeSignupMBean.meetingWrapper.meeting.startTime}">
									<f:convertDateTime pattern="h:mm a" />
								</h:outputText>
								<h:outputText value="#{AttendeeSignupMBean.meetingWrapper.meeting.startTime}" rendered="#{AttendeeSignupMBean.meetingWrapper.meeting.meetingCrossDays}">
										<f:convertDateTime pattern=", EEEEEEEE" />
								</h:outputText>	
								<h:outputText value="#{msgs.timeperiod_divider}" escape="false"/>
								<h:outputText value="#{AttendeeSignupMBean.meetingWrapper.meeting.endTime}">
									<f:convertDateTime pattern="h:mm a" />
								</h:outputText>
								<h:outputText value="#{AttendeeSignupMBean.meetingWrapper.meeting.endTime}" rendered="#{AttendeeSignupMBean.meetingWrapper.meeting.meetingCrossDays}" >
										<f:convertDateTime pattern=", EEEEEEEE, " />
								</h:outputText>	
								<h:outputText value="#{AttendeeSignupMBean.meetingWrapper.meeting.endTime}" rendered="#{AttendeeSignupMBean.meetingWrapper.meeting.meetingCrossDays}" >
										<f:convertDateTime dateStyle="long"/>
								</h:outputText>	
							</h:panelGroup>	
		
							<h:outputText value="#{msgs.event_signup_start}" style="white-space: nowrap;" styleClass="titleText" rendered="#{!AttendeeSignupMBean.announcementType}" escape="false"/>
							<h:panelGroup rendered="#{!AttendeeSignupMBean.announcementType}">
								<h:outputText value="#{AttendeeSignupMBean.meetingWrapper.meeting.signupBegins}" styleClass="longtext">
									<f:convertDateTime pattern="EEEEEEEE, " />
								</h:outputText>
								<h:outputText value="#{AttendeeSignupMBean.meetingWrapper.meeting.signupBegins}" styleClass="longtext">
									<f:convertDateTime dateStyle="long" />
								</h:outputText>
								<h:outputText value="#{AttendeeSignupMBean.meetingWrapper.meeting.signupBegins}" styleClass="longtext">
									<f:convertDateTime pattern=", h:mm a" />
								</h:outputText>
							</h:panelGroup>
		
							<h:outputText value="#{msgs.event_signup_deadline}" style="white-space: nowrap;" styleClass="titleText" rendered="#{!AttendeeSignupMBean.announcementType}" escape="false"/>
							<h:panelGroup rendered="#{!AttendeeSignupMBean.announcementType}">
								<h:outputText value="#{AttendeeSignupMBean.meetingWrapper.meeting.signupDeadline}" styleClass="longtext">
									<f:convertDateTime pattern="EEEEEEEE, " />
								</h:outputText>
								<h:outputText value="#{AttendeeSignupMBean.meetingWrapper.meeting.signupDeadline}" styleClass="longtext">
									<f:convertDateTime dateStyle="long" />
								</h:outputText>
								<h:outputText value="#{AttendeeSignupMBean.meetingWrapper.meeting.signupDeadline}" styleClass="longtext">
									<f:convertDateTime pattern=", h:mm a" />
								</h:outputText>
							</h:panelGroup>
							
							<h:outputText value="#{msgs.event_status}" styleClass="titleText" rendered="#{AttendeeSignupMBean.meetingWrapper.meeting.passedDeadline || !AttendeeSignupMBean.meetingWrapper.meeting.startToSignUp}" escape="false"/>
							<h:outputText value="#{msgs.event_not_start_signup_process}" styleClass="longtext" escape="false"  rendered="#{!AttendeeSignupMBean.meetingWrapper.meeting.startToSignUp}"/>
							<h:outputText value="#{msgs.event_passed_deadline}" styleClass="longtext" escape="false"  rendered="#{AttendeeSignupMBean.meetingWrapper.meeting.passedDeadline && !AttendeeSignupMBean.meetingWrapper.meeting.meetingExpired}"/>
							<h:outputText value="#{msgs.event_isOver}" styleClass="longtext" escape="false"  rendered="#{AttendeeSignupMBean.meetingWrapper.meeting.meetingExpired && AttendeeSignupMBean.meetingWrapper.meeting.passedDeadline}"/>
							
							<%-- display published site/groups --%>
							<h:outputText value="#{msgs.event_publish_to}" escape="false"  styleClass="titleText"/>
								<h:panelGrid columns="1" styleClass="published_siteGroupTable">
										<h:panelGroup >	
						   	    				<h:outputLabel  id="imageOpen_publishedSiteGroup" style="display:none" styleClass="activeTag" onclick="showDetails('meeting:imageOpen_publishedSiteGroup','meeting:imageClose_publishedSiteGroup','meeting:publishedSiteGroups');">
							   	    				<h:graphicImage value="/images/open.gif"  alt="open" style="border:none" />
							   	    				<h:outputText value="#{msgs.event_hide_site_group_detail}" escape="false" />
						   	    				</h:outputLabel>
						   	    				<h:outputLabel id="imageClose_publishedSiteGroup" styleClass="activeTag" onclick="showDetails('meeting:imageOpen_publishedSiteGroup','meeting:imageClose_publishedSiteGroup','meeting:publishedSiteGroups');">
						   	    					<h:graphicImage value="/images/closed.gif" alt="close" style="border:none" />
						   	    					<h:outputText value="#{msgs.event_show_site_group_detail}" escape="false" />
						   	    				</h:outputLabel>
							            </h:panelGroup>
							            <h:panelGroup id="publishedSiteGroups" style="display:none">
												<h:dataTable id="userSites" value="#{AttendeeSignupMBean.meetingWrapper.meeting.signupSites}" var="site"  styleClass="published_sitegroup">
													<h:column>
														<h:outputText value="#{site.title} #{msgs.event_site_level}" rendered="#{site.siteScope}" styleClass="published_sitetitle" escape="false"/>
														<h:panelGroup rendered="#{!site.siteScope}">
															<h:outputText value="#{site.title} #{msgs.event_group_level}" styleClass="published_sitetitle" escape="false"/>
															<h:dataTable id="userGroups" value="#{site.signupGroups}" var="group" styleClass="published_sitegroup">
																<h:column>
																		<h:outputText value=" - #{group.title}" escape="false" styleClass="published_grouptitle"/>
																</h:column>
															</h:dataTable>
														</h:panelGroup>							
													</h:column>
												</h:dataTable>
										</h:panelGroup>
								</h:panelGrid>
								<%-- end of display published site/groups --%>
							
							<h:outputText value="#{msgs.event_description}" styleClass="titleText" escape="false"/>
							<h:outputText
								value="#{AttendeeSignupMBean.meetingWrapper.meeting.description}"
								escape="false" styleClass="longtext" />
								
							<h:outputText  value="#{msgs.attachments}" styleClass="titleText" escape="false" rendered="#{!AttendeeSignupMBean.meetingWrapper.emptyEventMainAttachment}"/>
			         			<h:panelGrid columns="1" rendered="#{!AttendeeSignupMBean.meetingWrapper.emptyEventMainAttachment}">
			         				<t:dataTable value="#{AttendeeSignupMBean.meetingWrapper.eventMainAttachments}" var="attach" >
			         					<t:column>
	        								<%@ include file="/signup/common/mimeIcon.jsp" %>
	      								</t:column>
			         					<t:column>
			         						<h:outputLink  value="#{attach.location}" target="new_window">
			         							<h:outputText value="#{attach.filename}"/>
			         						</h:outputLink>
			         					</t:column>
			         					<t:column>
			         						<h:outputText escape="false" value="(#{attach.fileSize}kb)" rendered="#{!attach.isLink}"/>
			         					</t:column>
			         				</t:dataTable>			         				
				         		</h:panelGrid>	
								
							<h:outputText value="&nbsp;" escape="false"/>
							<h:outputText value="&nbsp;" escape="false"/>
						</h:panelGrid>
				</h:panelGroup>
				
				<%-- control expand-collapse --%>
				<h:panelGrid  columns="1" rendered="#{!AttendeeSignupMBean.announcementType}" columnClasses="alignRightColumn" styleClass="emailTable">																		
						<h:panelGroup>	
		   	    				<h:outputLabel  id="imageOpen_meetingInfoDetail"  styleClass="activeTag" onclick="showDetails('meeting:imageOpen_meetingInfoDetail','meeting:imageClose_meetingInfoDetail','meeting:meetingInfoDetails');setMeetingCollapseInfo(true);">
			   	    				<h:graphicImage value="/images/openTop.gif"  alt="open" title="#{msgs.event_tool_tips_hide_details}" style="border:none; vertical-align: bottom;" styleClass="openCloseImageIcon" />
			   	    				<h:outputText value="#{msgs.event_hide_meetingIfo_detail}" escape="false" />
		   	    				</h:outputLabel>
		   	    				<h:outputLabel id="imageClose_meetingInfoDetail" style="display:none" styleClass="activeTag" onclick="showDetails('meeting:imageOpen_meetingInfoDetail','meeting:imageClose_meetingInfoDetail','meeting:meetingInfoDetails');setMeetingCollapseInfo(false);">
		   	    					<h:graphicImage value="/images/closed.gif" alt="close" title="#{msgs.event_tool_tips_show_details}" style="border:none" styleClass="openCloseImageIcon" />
		   	    					<h:outputText value="#{msgs.event_show_meetingIfo_detail}" escape="false" />
		   	    				</h:outputLabel>
		   	    				<h:inputHidden id="meetingInfoCollapseExpand" value="#{AttendeeSignupMBean.collapsedMeetingInfo}"/>
			            </h:panelGroup>				
				</h:panelGrid>
								
				<h:panelGrid rendered="#{AttendeeSignupMBean.meetingWrapper.meeting.meetingType =='announcement'}" columns="1" styleClass="annoncement">
					<h:outputText value="#{msgs.event_is_open_session}" escape="false" />
				</h:panelGrid>
				
				<h:dataTable id="timeslots" value="#{AttendeeSignupMBean.timeslotWrappers}"
					binding="#{AttendeeSignupMBean.timeslotWrapperTable}" var="timeSlotWrapper"
					rendered="#{AttendeeSignupMBean.meetingWrapper.meeting.meetingType !='announcement'}"
					columnClasses="attendeeSignupTSCol,attendeeSignupAvailCol,attendeeInfoCol,attendeeSignupCol,attendeeSignupCol"
					rowClasses="oddRow,evenRow"
					styleClass="signupTable" style="width: 98%">
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.tab_time_slot}" />
						</f:facet>
						<h:panelGroup>
							<h:graphicImage value="/images/spacer.gif" width="15" height="13" alt="spacer" style="border:none" rendered="#{!timeSlotWrapper.timeSlot.locked && !timeSlotWrapper.timeSlot.canceled && AttendeeSignupMBean.meetingWrapper.atleastOneTimeslotLockedOrCanceled}"/>
							<h:graphicImage value="/images/lock.gif"  alt="#{msgs.event_tool_tip_ts_locked}" title="#{msgs.event_tool_tip_ts_locked}" style="border:none" rendered="#{timeSlotWrapper.timeSlot.locked && !timeSlotWrapper.timeSlot.canceled}"/>
							<h:graphicImage value="/images/cancelled.gif"  alt="#{msgs.event_tool_tip_ts_cancelled}" title="#{msgs.event_tool_tip_ts_cancelled}" style="border:none" rendered="#{timeSlotWrapper.timeSlot.canceled}"/>							
							<h:outputText value="#{timeSlotWrapper.timeSlot.startTime}"
								styleClass="longtext">
								<f:convertDateTime pattern="h:mm a"/>
							</h:outputText>
							<h:outputText value="#{timeSlotWrapper.timeSlot.startTime}" rendered="#{AttendeeSignupMBean.meetingWrapper.meeting.meetingCrossDays}">
								<f:convertDateTime pattern=", EEE" />
							</h:outputText>	
							<h:outputText value="#{msgs.timeperiod_divider}" escape="false"
								styleClass="longtext" />
							<h:outputText value="#{timeSlotWrapper.timeSlot.endTime}"
								styleClass="longtext">
								<f:convertDateTime pattern="h:mm a"/>
							</h:outputText>
							<h:outputText value="#{timeSlotWrapper.timeSlot.endTime}" rendered="#{AttendeeSignupMBean.meetingWrapper.meeting.meetingCrossDays}">
								<f:convertDateTime pattern=", EEE" />
						</h:outputText>	
						</h:panelGroup>
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.tab_event_available_slots}" escape="false"/>
						</f:facet>
						<h:panelGroup rendered="#{timeSlotWrapper.timeSlot.locked && !timeSlotWrapper.timeSlot.canceled}">				
							<h:outputText  value="#{msgs.event_locked}" escape="false" />
						</h:panelGroup>
						<h:panelGroup rendered="#{timeSlotWrapper.timeSlot.canceled}">
							<h:outputText styleClass="attendee_canceled" value="#{msgs.event_canceled}" escape="false" />
						</h:panelGroup>
						<h:panelGroup rendered="#{!timeSlotWrapper.timeSlot.locked && !timeSlotWrapper.timeSlot.canceled}">
								<h:panelGroup rendered="#{!timeSlotWrapper.timeSlot.unlimitedAttendee}">
										<h:outputText value="#{timeSlotWrapper.availability}"
											rendered="#{timeSlotWrapper.availability >0}" styleClass="longtext"/>
										<h:outputText value="#{msgs.event_ts_availability_none}"
											rendered="#{timeSlotWrapper.availability <= 0 && timeSlotWrapper.numberOnWaitingList ==0}" styleClass="longtext"/>
										<h:outputText
											value="#{msgs.event_ts_availability_none} <br>"
											rendered="#{timeSlotWrapper.numberOnWaitingList >0}"
											escape="false"  styleClass="longtext"/>
										<h:outputText
											value="#{timeSlotWrapper.numberOnWaitingList} #{msgs.event_on_waiting}"
											rendered="#{timeSlotWrapper.numberOnWaitingList >0}"
											escape="false"  styleClass="longtext"/>
								</h:panelGroup>
								<h:panelGroup rendered="#{timeSlotWrapper.timeSlot.unlimitedAttendee}">
										<h:outputText value="#{msgs.event_unlimited}" styleClass="longtext"/>									
								</h:panelGroup>
						</h:panelGroup>
					</h:column>
					
					<h:column>		   
							<f:facet name="header">
								<h:outputText value="#{msgs.tab_event_signed_attendee}" escape="false"/>
							</f:facet>
							<h:panelGroup rendered="#{timeSlotWrapper.timeSlot.displayAttendees}">
					   			<h:dataTable id="peopleOnSignup" value="#{timeSlotWrapper.attendeeWrappers}" var="attendeeWrapper" columnClasses="signedUpList">
					   				<h:column>
					   					<h:outputText value="#{attendeeWrapper.displayName}" rendered="#{attendeeWrapper.signupAttendee.attendeeUserId !=null}" title="#{msgs.event_tool_tip_on_signuplist}"/>			
					   				</h:column>				   		
					   			</h:dataTable>
					   			<h:dataTable id="peopleOnWaiting" value="#{timeSlotWrapper.waitingList}" var="attendeeWrapper" rendered="#{timeSlotWrapper.sizeOfWaitingList >0}"  styleClass="peopleOnListTable" columnClasses="waitingList">
					   				<h:column>
					   					<h:outputText value="#{attendeeWrapper.displayName}" rendered="#{attendeeWrapper.signupAttendee.attendeeUserId !=null}" title="#{msgs.event_tool_tip_on_waitinglist}"/>   					
					   				</h:column>				   		
					   			</h:dataTable>
					   		</h:panelGroup>	
					   		<h:outputText value="#{msgs.event_show_no_attendee_info}" escape="false"  rendered="#{!timeSlotWrapper.timeSlot.displayAttendees}"/>
				   	</h:column>
					

					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.tab_event_your_status}" escape="false"/>
						</f:facet>
						<h:outputText value="#{msgs.event_sign_up}"
							title="#{msgs.event_tool_tip_you_signed_up}"
							rendered="#{timeSlotWrapper.currentUserSignedUp}"
							styleClass="attendee_status" />
						<h:outputText value="#{msgs.event_on_waiting_list}"
							title="#{msgs.event_tool_tip_you_ranking_num} #{timeSlotWrapper.rankingOnWaiting}"
							rendered="#{timeSlotWrapper.currentUserOnWaitingList}"
							styleClass="attendee_status" />
					</h:column>

					<h:column rendered="#{!AttendeeSignupMBean.meetingWrapper.meeting.meetingExpired && AttendeeSignupMBean.meetingWrapper.meeting.permission.attend}">
						<f:facet name="header">
							<h:outputText value="#{msgs.tab_event_action}" escape="false"/>
						</f:facet>
						<sakai:button_bar_item id="addMe" styleClass="actButton"
							action="#{AttendeeSignupMBean.attendeeSignup}" value="#{msgs.event_button_signup}"
							rendered="#{timeSlotWrapper.availableForSignup && !timeSlotWrapper.currentUserSignedUp}"
							disabled="#{!AttendeeSignupMBean.meetingWrapper.meeting.startToSignUp || AttendeeSignupMBean.currentUserSignedup || timeSlotWrapper.currentUserSignedUp ||timeSlotWrapper.timeSlot.locked || timeSlotWrapper.timeSlot.canceled ||AttendeeSignupMBean.meetingWrapper.meeting.passedDeadline}" />
						<sakai:button_bar_item id="Cancel" styleClass="actButton"
							action="#{AttendeeSignupMBean.attendeeCancelSignup}" value="#{msgs.participant_cancel_button}"
							rendered="#{timeSlotWrapper.currentUserSignedUp }" 
							disabled="#{timeSlotWrapper.timeSlot.canceled}"/>
						<sakai:button_bar_item id="addMeOnWaitingList" styleClass="actButton"
							action="#{AttendeeSignupMBean.attendeeAddToWaitingList}" value="#{msgs.add_waitlist_button}" title="#{msgs.tool_tip_add_waitlist}"
							rendered="#{!timeSlotWrapper.currentUserOnWaitingList && !timeSlotWrapper.availableForSignup && !timeSlotWrapper.currentUserSignedUp}" 
							disabled="#{!AttendeeSignupMBean.meetingWrapper.meeting.allowWaitList || !AttendeeSignupMBean.meetingWrapper.meeting.startToSignUp || timeSlotWrapper.timeSlot.locked || timeSlotWrapper.timeSlot.canceled ||AttendeeSignupMBean.meetingWrapper.meeting.passedDeadline}"/>
						<sakai:button_bar_item id="CancelWaitingList" styleClass="actButton"
							action="#{AttendeeSignupMBean.attendeeRemoveFromWaitingList}" value="#{msgs.remove_waitlist_button}"
							rendered="#{timeSlotWrapper.currentUserOnWaitingList}" 
							disabled="#{timeSlotWrapper.timeSlot.canceled}"/>
					</h:column>

				</h:dataTable>


				<sakai:button_bar>
					<sakai:button_bar_item styleClass="actButton" id="goBack"
						action="listMeetings" value="#{msgs.goback_button}" />
				</sakai:button_bar>

			</h:form>
		</sakai:view_content>
	</sakai:view_container>
	
	<f:verbatim>
		<script>
			var hiddenInputCollapeMInfo =document.getElementById("meeting:meetingInfoCollapseExpand");
			var showMInfoTitleTag =document.getElementById("meeting:showMeetingTitleOnly");
			//initialize
			initMeetingInfoDetail();
			
			function initMeetingInfoDetail(){
				var collapseMInfoTag =document.getElementById("meeting:meetingInfoDetails");				
				if(collapseMInfoTag && hiddenInputCollapeMInfo && hiddenInputCollapeMInfo.value == 'true'){
					collapseMInfoTag.style.display="none";
					showMInfoTitleTag.style.display="";
					//reverse the default:show when page refreshed
					showDetails('meeting:imageOpen_meetingInfoDetail','meeting:imageClose_meetingInfoDetail');
				}else{
					collapseMInfoTag.style.display="";
					showMInfoTitleTag.style.display="none";
				}	
			}
			
			function setMeetingCollapseInfo(val){				
				hiddenInputCollapeMInfo.value=val;
				if(val)				  
				  	showMInfoTitleTag.style.display="";
				 else
				  	showMInfoTitleTag.style.display="none";				  
			}
			
			//just introduce jquery slideUp/Down visual effect to overwrite top function
			function switchShowOrHide(tag){
				if(tag){
					if(tag.style.display=="none")
						$(tag).slideDown("fast");
					else
						$(tag).slideUp("fast");
				}
			}								
		</script>
	</f:verbatim>
</f:view>
