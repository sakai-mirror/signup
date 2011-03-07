package org.sakaiproject.signup.tool.jsf.organizer;

import javax.faces.component.UIData;

import org.sakaiproject.signup.logic.Permission;
import org.sakaiproject.signup.tool.jsf.SignupMeetingWrapper;
import org.sakaiproject.signup.tool.jsf.SignupUIBaseBean;

/**
 * <p>
 * This JSF UIBean class will handle information exchanges between Organizer's
 * event/meeting attendance view page:<b>attendanceView.jsp</b> and backbone system. It
 * provides all the necessary business logic
 * 
 * </P>
 */
public class AttendanceSignupBean extends SignupUIBaseBean{
	
	private UIData timeslotWrapperTable;
	
	/**
	 * This will initialize all the wrapper objects such as
	 * SignupMeetingWrapper, SignupTimeslotWrapper etc.
	 * 
	 * @param meetingWrapper
	 *            a SignupMeetingWrapper object.
	 */
	public void init(SignupMeetingWrapper meetingWrapper) throws Exception {
	
		setMeetingWrapper(meetingWrapper);
		super.updateTimeSlotWrappers(meetingWrapper);

	}
	
	/**
	 * This is a setter.
	 * 
	 * @param meetingWrapper
	 *            a SignupMeetingWrapper object.
	 */
	public void setMeetingWrapper(SignupMeetingWrapper meetingWrapper) {
		this.meetingWrapper = meetingWrapper;
	}
	
	public UIData getTimeslotWrapperTable() {
		return timeslotWrapperTable;
	}

	public void setTimeslotWrapperTable(UIData timeslotWrapperTable) {
		this.timeslotWrapperTable = timeslotWrapperTable;
	}
	
	/**
	 * This is a JSF action call method by UI to save the attendance
	 * 
	 * @return an action outcome string.
	 */
	public String doSave() {
		return ATTENDEE_MEETING_PAGE_URL;
	}
	
	/**
	 * This is a JSF action call method by UI to cancel the attendance changes
	 * 
	 * @return an action outcome string.
	 */
	public String doCancel() {
		return ATTENDEE_MEETING_PAGE_URL;
	}
	
	

}
