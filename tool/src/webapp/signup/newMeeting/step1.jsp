<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t" %>


<f:view locale="#{UserLocale.localeExcludeCountryForIE}">
	<jsp:useBean id="msgs" class="org.sakaiproject.util.ResourceLoader" scope="session">
	   <jsp:setProperty name="msgs" property="baseName" value="messages"/>
	</jsp:useBean>
    <sakai:view_container title="Signup Tool">
        <style type="text/css">
            @import url("/sakai-signup-tool/css/signupStyle.css");
        </style>
          
        <script TYPE="text/javascript" LANGUAGE="JavaScript" src="/sakai-signup-tool/js/signupScript.js"></script>
        <script TYPE="text/javascript" LANGUAGE="JavaScript" src="/sakai-signup-tool/js/newMeetingStep1.js"></script>                 
        <sakai:view_content>
     		<h:outputText value="#{msgs.event_error_alerts} #{errorMessageUIBean.errorMessage}" styleClass="alertMessage" escape="false" rendered="#{errorMessageUIBean.error}"/>

            <h:form id="meeting" >              
                 <sakai:view_title value="#{msgs.create_new_event} #{msgs.basic}"/>
                <sakai:doc_section>
                    <h:panelGrid columns="1" styleClass="instruction" style="background:#fff;">
                        <h:outputText value="#{msgs.create_instruction} " escape="false" />                      
                        <h:panelGroup>                           
                            <h:outputText value="#{msgs.star_character}" style="color:#B11;" />
                            <h:outputText value="&nbsp;#{msgs.required2}" escape="false" />
                        </h:panelGroup>
                        <h:outputText value="&nbsp;" escape="false" />
                    </h:panelGrid>
                </sakai:doc_section>
          	      
	        	<h:panelGrid columns="2" columnClasses="titleColumn,valueColumn" onmouseover="delayedRecalculateDateTime();">               
		                    <h:panelGroup styleClass="titleText" >
		                        <h:outputText value="#{msgs.star_character}" style="color:#B11;"/>
		                        <h:outputText value="#{msgs.event_name}"   escape="false"/>            
		                    </h:panelGroup>                
		                    <h:panelGroup>                    
		                        <h:inputText id="name" size="40" value="#{NewSignupMeetingBean.signupMeeting.title}" styleClass="editText" required="true"  >
		                        <f:validator validatorId="Signup.EmptyStringValidator"/>
		                        <f:validateLength maximum="255" />
		                        </h:inputText>
		                        <h:message for="name" errorClass="alertMessageInline"/>
		                    </h:panelGroup> 
		                                   
		                    <h:panelGroup styleClass="titleText">
		                        <h:outputText value="#{msgs.star_character}"  style="color:#B11;"/>
		                        <h:outputText value="#{msgs.event_location}" />
		                    </h:panelGroup>                                                   
		                    <h:panelGroup>
		                        <h:inputText id="location" size="40" value="#{NewSignupMeetingBean.signupMeeting.location}" styleClass="editText" required="true" >
		                            <f:validator validatorId="Signup.EmptyStringValidator"/>
		                            <f:validateLength maximum="255" />
		                        </h:inputText>
		                        <h:message for="location" errorClass="alertMessageInline"/>
		                    </h:panelGroup>                           
		                
		                    <h:outputText value="#{msgs.event_description}" styleClass="titleText"  escape="false"/>
		                    <sakai:rich_text_area value="#{NewSignupMeetingBean.signupMeeting.description}"  width="720" height="180" rows="8" columns="80" />
		       
		         			<h:outputText value="" escape="false" />
		         			<h:panelGrid columns="1">
		         				<t:dataTable value="#{NewSignupMeetingBean.attachments}" var="attach" rendered="#{!NewSignupMeetingBean.attachmentsEmpty}">
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
		         				
		         				<h:commandButton action="#{NewSignupMeetingBean.addRemoveAttachments}" value="#{msgs.add_attachments}" rendered="#{NewSignupMeetingBean.attachmentsEmpty}"/>		
		         				<h:commandButton action="#{NewSignupMeetingBean.addRemoveAttachments}" value="#{msgs.add_remove_attachments}" rendered="#{!NewSignupMeetingBean.attachmentsEmpty}"/>		         			
		         			</h:panelGrid>
		         			
		             		<h:panelGroup styleClass="titleText">
								<h:outputText value="#{msgs.star_character}" style="color:#B11;" />
								<h:outputText value="#{msgs.event_start_time}"  escape="false"/>
							</h:panelGroup>	
		        			<h:panelGroup styleClass="editText">
		        						<t:inputDate id="startTime" type="both"  ampm="true" value="#{NewSignupMeetingBean.signupMeeting.startTime}"
		        							 style="color:black;" popupCalendar="true" onkeyup="setEndtimeMonthDateYear();getSignupDuration();return false;"/>
										<h:message for="startTime" errorClass="alertMessageInline"/>
							</h:panelGroup>
							
							<h:panelGroup styleClass="titleText">
								<h:outputText value="#{msgs.star_character}" style="color:#B11;" />					
								<h:outputText value="#{msgs.event_end_time}" escape="false"/>
							</h:panelGroup>
		        			<h:panelGroup styleClass="editText">
		        						<t:inputDate id="endTime" type="both" ampm="true" value="#{NewSignupMeetingBean.signupMeeting.endTime}" style="color:black;" popupCalendar="true" 
		        							onkeyup="getSignupDuration();return false;"/>
										<h:message for="endTime" errorClass="alertMessageInline"/>
							</h:panelGroup>
							
		                 	         
		                     <h:panelGroup>
		                     	<h:outputText value="#{msgs.star_character}" style="color:#B11;" />  
		                     	<h:outputText styleClass="titleText" value="#{msgs.event_recurrence}"  />  
		                     </h:panelGroup>                          
		                     <h:panelGroup>                            
		                            <h:selectOneMenu id="recurSelector" value="#{NewSignupMeetingBean.repeatType}" styleClass="titleText" onchange="isShowCalendar(value); return false;">
		                                <f:selectItem itemValue="no_repeat" itemLabel="#{msgs.label_once}"/>
		                                <f:selectItem itemValue="daily" itemLabel="#{msgs.label_daily}"/>
		                                <f:selectItem itemValue="wkdays_mon-fri" itemLabel="#{msgs.label_weekdays}"/>
		                                <f:selectItem itemValue="weekly" itemLabel="#{msgs.label_weekly}"/>
		                                <f:selectItem itemValue="biweekly" itemLabel="#{msgs.label_biweekly}"/>                           
		                             </h:selectOneMenu>
		                            
			                         <h:panelGroup id="utilCalendar" style="margin-left:35px;">
			                           <h:panelGrid columns="2" >
			                               <h:outputText value="#{msgs.event_end_after}" style="margin-left:5px" />
			                           
				                           <h:panelGrid columns="2">
				                            	<h:selectOneRadio id="recurNumDateChoice" value="#{NewSignupMeetingBean.recurLengthChoice}" styleClass="titleText" layout="pageDirection" >
					                                <f:selectItem itemValue="0" />
					                                <f:selectItem itemValue="1" />
				                               </h:selectOneRadio>
				                               <h:panelGrid columns="1">
					                                <h:panelGroup id="numOfRepeat" style="margin-left:3px;">
						                                <h:inputText id="numRepeat"  value="#{NewSignupMeetingBean.occurrences}" maxlength="2" size="1" onkeyup="validateRecurNum();" styleClass="untilCalendar" /> 
						                                <h:outputText value="#{msgs.event_occurrences}" style="margin-left:10px" />
					                		        </h:panelGroup>
					                                <h:panelGroup id="endOfDate" style="margin-left:3px;">
						                            	 <!-- t:inputCalendar id="ex" value=""  renderAsPopup="true" monthYearRowClass="" renderPopupButtonAsImage="true" dayCellClass=""   styleClass="untilCalendar"/ -->             					
						                                <t:inputDate id="until" type="date"  value="#{NewSignupMeetingBean.repeatUntil}"  popupCalendar="true"   styleClass="untilCalendar"/>
						                		        <h:message for="until" errorClass="alertMessageInline" style="margin-left:10px" /> 
					                		        </h:panelGroup>
				                		        </h:panelGrid>
				                		      </h:panelGrid> 
				                		     </h:panelGrid>
			                       </h:panelGroup>
		                                              
		                	 </h:panelGroup>
		                	 
				    		<%-- signup begin_deadline --%>
		                    <h:panelGroup styleClass="signupBDeadline" id="signup_beginDeadline_1">              
		                    	<h:outputText value="#{msgs.event_signup_begins}" escape="false" styleClass="titleText"/>
		                    </h:panelGroup>
		                    <h:panelGroup styleClass="signupBDeadline" id="signup_beginDeadline_2">
		                       		 <h:inputText id="signupBegins" value="#{NewSignupMeetingBean.signupBegins}" size="2" required="true">
		                            	<f:validateLongRange minimum="0" maximum="99999"/>
		                        	</h:inputText>
		                        	<h:selectOneMenu id="signupBeginsType" value="#{NewSignupMeetingBean.signupBeginsType}" onchange="isSignUpBeginStartNow(value);" style="padding-left:5px; margin-right:5px">
		                            	<f:selectItem itemValue="minutes" itemLabel="#{msgs.label_minutes}"/>
		                            	<f:selectItem itemValue="hours" itemLabel="#{msgs.label_hours}"/>
		                            	<f:selectItem itemValue="days" itemLabel="#{msgs.label_days}"/>
		                            	<f:selectItem itemValue="startNow" itemLabel="#{msgs.label_startNow}"/>
		                        	</h:selectOneMenu>
		                        	<h:outputText value="#{msgs.before_event_start}" escape="false" style="margin-left:18px"/>
		                        	<h:message for="signupBegins" errorClass="alertMessageInline" />
		                    </h:panelGroup>
		                
		                   <h:panelGroup styleClass="signupBDeadline" id="signup_beginDeadline_3">
		                    <h:outputText value="#{msgs.event_signup_deadline2}" escape="false" styleClass="titleText"/>
		                   </h:panelGroup>
		                    <h:panelGroup styleClass="signupBDeadline" id="signup_beginDeadline_4">
		                        <h:inputText id="signupDeadline" value="#{NewSignupMeetingBean.deadlineTime}" size="2" required="true">
		                            <f:validateLongRange minimum="0" maximum="99999"/>
		                        </h:inputText>
		                        <h:selectOneMenu value="#{NewSignupMeetingBean.deadlineTimeType}" style="padding-left:5px; margin-right:5px">
		                            <f:selectItem itemValue="minutes" itemLabel="#{msgs.label_minutes}"/>
		                            <f:selectItem itemValue="hours" itemLabel="#{msgs.label_hours}"/>
		                            <f:selectItem itemValue="days" itemLabel="#{msgs.label_days}"/>
		                        </h:selectOneMenu>                
		                        <h:outputText value="#{msgs.before_event_end}" escape="false" style="margin-left:18px"/>
		                        <h:message for="signupDeadline" errorClass="alertMessageInline" />
		                    </h:panelGroup>
	                 
                			<%-- display site/groups --%>
				            <h:panelGroup styleClass="titleText" style="margin-top:5px">
				            	<h:outputText value="#{msgs.star_character}"  style="color:#B11;"/>
				            	<h:outputText value ="#{msgs.event_publish_to}" />
				            </h:panelGroup>	                   
				            <h:panelGrid  columns="1" styleClass="meetingGpsSitesTable" style="">                    
				                    <h:panelGroup>
				                        <h:selectBooleanCheckbox id="siteSelection" value="#{NewSignupMeetingBean.currentSite.selected}" disabled="#{!NewSignupMeetingBean.currentSite.allowedToCreate}"
				                            onclick="currentSiteSelection();"/>
				                        <h:outputText value="#{NewSignupMeetingBean.currentSite.signupSite.title}" styleClass="longtext"/>
				                   		<h:outputText value="#{msgs.event_current_site}" style="margin-left:3px" escape="false"/>
				                   
				                    </h:panelGroup>
				                    <h:dataTable id="currentSiteGroups" value="#{NewSignupMeetingBean.currentSite.signupGroupWrappers}" var="currentGroup" styleClass="meetingTypeTable">
				                        <h:column>
				                            <h:panelGroup>
				                                <h:selectBooleanCheckbox id="groupSelection" value="#{currentGroup.selected}" disabled="#{!currentGroup.allowedToCreate}"/>
				                                <h:outputText value="#{currentGroup.signupGroup.title}" styleClass="longtext"/>
				                            </h:panelGroup>
				                        </h:column>
				                    </h:dataTable>
				                   
				                    <h:panelGroup>
										<h:outputText value="<span id='imageOpen_otherSites' style='display:none'>"  escape="false"/>
				   	    					<h:graphicImage value="/images/minus.gif"  alt="open" style="border:none;cursor:pointer;" styleClass="openCloseImageIcon" onclick="showDetails('imageOpen_otherSites','imageClose_otherSites','otherSites');" />
				   	    				<h:outputText value="</span>" escape="false" />
				   	    			
				   	    				<h:outputText value="<span id='imageClose_otherSites'>"  escape="false"/>
				   	    					<h:graphicImage value="/images/plus.gif" alt="close" style="border:none;cursor:pointer;" styleClass="openCloseImageIcon" onclick="showDetails('imageOpen_otherSites','imageClose_otherSites','otherSites');"/>
				   	    				<h:outputText value="</span>" escape="false" />
				                        <h:outputLabel value="#{msgs.event_other_sites}" style='font-weight:bold;cursor:pointer;' onmouseover='style.color=\"blue\"' onmouseout='style.color=\"black\"' onclick="showDetails('imageOpen_otherSites','imageClose_otherSites','otherSites');"/>
				                    </h:panelGroup>   
				                    <h:panelGroup>
				                        <h:outputText value="<div id='otherSites' style='display:none'>" escape="false"/>   
				                        <h:dataTable id="userSites" value="#{NewSignupMeetingBean.otherSites}" var="site" styleClass="meetingTypeTable" style="left:1px;">
				                        
				                            <h:column>
				                                <h:panelGroup>
				                                    <h:selectBooleanCheckbox id="otherSitesSelection" value="#{site.selected}" disabled="#{!site.allowedToCreate}" onclick="otherUserSitesSelection();"/>
				                                    <h:outputText value="#{site.signupSite.title}" styleClass="editText" escape="false"/>
				                                </h:panelGroup>
				                                <h:dataTable id="userGroups" value="#{site.signupGroupWrappers}" var="group" styleClass="meetingTypeTable">
				                                    <h:column>
				                                        <h:panelGroup>
				                                            <h:selectBooleanCheckbox id="otherGroupsSelection" value="#{group.selected}" disabled="#{!group.allowedToCreate}" onclick=""/>
				                                            <h:outputText value="#{group.signupGroup.title}" styleClass="longtext"/>
				                                        </h:panelGroup>
				                                    </h:column>
				                               
				                                </h:dataTable>
				                            </h:column>
				                        </h:dataTable>
				                        <h:outputText value="</div>" escape="false" />
				                    </h:panelGroup>   				                        
				          	</h:panelGrid>
				          	
			 				<%-- handle meeting types --%>
				           	<h:panelGroup styleClass="titleText">
				           			<h:outputText value="#{msgs.star_character}"  style="color:#B11;"/>
				            		<h:outputText value ="#{msgs.event_type_title}" />
				           	</h:panelGroup>	
				            <h:panelGrid columns="2" columnClasses="miCol1,miCol2" >                
					                   <h:panelGroup id="radios" styleClass="rs">                  
					                        <h:selectOneRadio id="meetingType" value="#{NewSignupMeetingBean.signupMeeting.meetingType}"  valueChangeListener="#{NewSignupMeetingBean.processSelectedType}" onclick="switMeetingType(value);" layout="pageDirection" styleClass="rs" >
					                          	<f:selectItems value="#{NewSignupMeetingBean.meetingTypeRadioBttns}"/>                	                      	         	 
					                 	   </h:selectOneRadio> 
					                   </h:panelGroup>
				                      
					               	   <h:panelGrid columns="1" columnClasses="miCol1">       
					               			<%-- multiple: --%>           
						               				<h:panelGroup>            
						                        		<h:outputText value="<div id='multiple' styleClass='mi' >" escape="false"/>
						                           
								                        	<h:panelGrid columns="2" id="mutipleCh" styleClass="mi" columnClasses="miCol1,miCol2">                                                
											                        <h:outputText value="#{msgs.event_num_slot_avail_for_signup}" />
												                    <h:inputText  id="numberOfSlot" value="#{NewSignupMeetingBean.numberOfSlots}" size="2" styleClass="editText" onkeyup="getSignupDuration();return false;" style="margin-left:12px" />
											                        <h:outputText value="#{msgs.event_num_participant_per_timeslot}" styleClass="titleText" escape="false"/>                    
													                <h:inputText id="numberOfAttendees" value="#{NewSignupMeetingBean.numberOfAttendees}" styleClass="editText" size="2" style="margin-left:12px" onkeyup="validateAttendee();return false;" />
											                    	<h:outputText value="#{msgs.event_duration_each_timeslot_not_bold}" styleClass="titleText" escape="false"/>
																	<h:inputText id='currentTimeslotDuration' value="0" styleClass='longtext_red' size="2" onkeyup="this.blur();" style="margin-left:12px" onmouseup="this.blur();" />             
								                			</h:panelGrid>          
						                         
						                        		<h:outputText value="</div>" escape="false" />
						                			</h:panelGroup>                                
					               
						            				<%-- single: --%>
						               
								                	<h:panelGroup>                
								                        <h:outputText value="<div id='single' style='display:none' styleClass='si' >" escape="false"/>
								                       
									                        <h:panelGrid columns="2" rendered="true" styleClass="si" columnClasses="miCol1,miCol2">                
												                    <h:selectOneRadio id="groupSubradio" value="#{NewSignupMeetingBean.unlimited}" valueChangeListener="#{NewSignupMeetingBean.processGroup}" onclick="switchSingle(value)" styleClass="meetingRadioBtn" layout="pageDirection">
												                        <f:selectItem itemValue="#{false}" itemLabel="#{msgs.tab_max_attendee}"/>                    
												                        <f:selectItem itemValue="#{true}" itemLabel="#{msgs.unlimited_num_attendee}"/>                            
												                    </h:selectOneRadio>
												                                    
										                   			<h:panelGrid columns="1">       
												                     	<h:panelGroup rendered="true" styleClass="meetingMaxAttd">                      
												                            <h:inputText id="maxAttendee" value="#{NewSignupMeetingBean.maxOfAttendees}" size="2" styleClass="editText" onkeyup="validateParticipants();return false;"/>	                                 
												                        </h:panelGroup>
										                        		<h:outputText value="&nbsp;" styleClass="titleText" escape="false"/>
										                    		</h:panelGrid>
									                		</h:panelGrid>                    
								                        <h:outputText value="</div>" escape="false" />                
								                	</h:panelGroup>
							                                       
					                 				<h:outputText id="announ" value="&nbsp;" style='display:none' styleClass="titleText" escape="false"/>
					              		</h:panelGrid>
				              
				              </h:panelGrid> 
				              
				              <h:outputText id="userDefTsChoice_1" value="" style="display:none;"/>
				              <h:panelGroup id="userDefTsChoice_2" style="display:none;" styleClass="longtext" >
				              		<h:panelGrid style="margin:-10px 0px 0px 25px;">
				              			<h:panelGroup>
											<h:selectBooleanCheckbox id="userDefTsChoice" value="#{NewSignupMeetingBean.userDefinedTS}" onclick="userDefinedTsChoice();" />
											<h:outputText value="#{msgs.label_custom_timeslots}"  escape="false"/>
										</h:panelGroup>
										<h:panelGroup id="createEditTS" style="display:none;padding-left:35px;">
											<h:commandLink id="createTS" action="#{NewSignupMeetingBean.createUserDefTimeSlots}" rendered="#{!NewSignupMeetingBean.userDefineTimeslotBean.userEverCreateCTS}">
												<h:graphicImage value="/images/cal.gif" alt="close" style="border:none;cursor:pointer; padding-right:5px;" styleClass="openCloseImageIcon" />
												<h:outputText value="#{msgs.label_create_timeslots}" escape="false" styleClass="activeTag"/>
											</h:commandLink>
											<h:panelGroup rendered="#{NewSignupMeetingBean.userDefineTimeslotBean.userEverCreateCTS}">
												<h:commandLink action="#{NewSignupMeetingBean.editUserDefTimeSlots}" >
													<h:graphicImage value="/images/cal.gif" alt="close" style="border:none;cursor:pointer; padding-right:5px;" styleClass="openCloseImageIcon" />
													<h:outputText value="#{msgs.label_edit_timeslots}" escape="false" styleClass="activeTag"/>
												</h:commandLink>
											</h:panelGroup>
											
										</h:panelGroup>	
									</h:panelGrid>	
							  </h:panelGroup>              
		        	</h:panelGrid>
		        	
		          
	                <h:panelGrid style="margin-top:10px">   
		                <h:inputHidden value="step1" binding="#{NewSignupMeetingBean.currentStepHiddenInfo}"/>
		                <sakai:button_bar>
		                    <h:commandButton id="goNextPage"  onclick="validateMeetingType()" action="#{NewSignupMeetingBean.goNext}" actionListener="#{NewSignupMeetingBean.validateNewMeeting}"   value="#{msgs.next_button}"/>
		                    
		                    <h:commandButton id="Cancel" action="#{NewSignupMeetingBean.processCancel}" value="#{msgs.cancel_button}"  immediate="true"/> 
		                </sakai:button_bar>
	            	</h:panelGrid>           
              </h:form>
          </sakai:view_content> 
    </sakai:view_container>
     <f:verbatim>
    	<script>
	         //initialization of the page
			 initialLayoutsSetup();
	         otherUserSitesSelection();
	         replaceCalendarImageIcon(); 
	         userDefinedTsChoice();   
		</script>
    </f:verbatim>
</f:view>

        