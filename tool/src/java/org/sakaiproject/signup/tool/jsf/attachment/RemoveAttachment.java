/**********************************************************************************
 * $URL: https://source.sakaiproject.org/contrib/signup/branches/2-6-x/tool/src/java/org/sakaiproject/signup/tool/jsf/attachment/RemoveAttachment.java $
 * $Id: RemoveAttachment.java 64842 2009-11-20 18:52:38Z guangzheng.liu@yale.edu $
***********************************************************************************
 *
 * Copyright (c) 2007, 2008, 2009 Yale University
 * 
 * Licensed under the Educational Community License, Version 1.0 (the "License"); 
 * you may not use this file except in compliance with the License. 
 * You may obtain a copy of the License at
 * 
 *      http://www.opensource.org/licenses/ecl1.php
 * 
 * Unless required by applicable law or agreed to in writing, software 
 * distributed under the License is distributed on an "AS IS" BASIS, 
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
 * See the License for the specific language governing permissions and 
 * limitations under the License.
 *   
 * See the LICENSE.txt distributed with this file.
 *
 **********************************************************************************/
package org.sakaiproject.signup.tool.jsf.attachment;

import java.util.Iterator;
import java.util.List;

import org.sakaiproject.exception.PermissionException;
import org.sakaiproject.signup.logic.SignupMeetingService;
import org.sakaiproject.signup.model.SignupAttachment;
import org.sakaiproject.signup.model.SignupMeeting;
import org.sakaiproject.signup.tool.jsf.organizer.action.SignupAction;
import org.sakaiproject.signup.tool.util.Utilities;
import org.springframework.dao.OptimisticLockingFailureException;

/**
 * <p>
 * This class will provide business logic for 'Remove Attachment' action by user.
 * </P>
 */
public class RemoveAttachment extends SignupAction {

	/**
	 * Constructor
	 * 
	 * @param signupMeetingService
	 *            a SignupMeetingService object.
	 * @param currentUserId
	 *            an unique sakai internal user id.
	 * @param currentSiteId
	 *            an unique sakai site id.
	 */
	public RemoveAttachment(SignupMeetingService signupMeetingService, String currentUserId, String currentSiteId,
			boolean isOrganizer) {
		super(currentUserId, currentSiteId, signupMeetingService, isOrganizer);
	}

	public void removeAttachment(SignupMeeting meeting, SignupAttachment remAttach){
		try {
			if(meeting ==null || meeting.getId() ==null)
				return;
			
			handleVersion(meeting, remAttach);
		} catch (PermissionException pe) {
			logger.warn(Utilities.rb.getString("no.permissoin.do_it"));
		}catch (Exception e){
			logger.warn(e.getMessage());
		}
	}

	/**
	 * Check if the pre-condition is still satisfied for continuing the update
	 * process after retrieving the up-to-dated data. This process is a
	 * concurrency process.
	 * 
	 * @param meeting
	 *            a SignupMeeting object.
	 * @param SignupAttachment
	 *            a SignupAttachment object.
	 * @throws Exception
	 *             throw if anything goes wrong.
	 */
	public void actionsForOptimisticVersioning(SignupMeeting meeting, SignupAttachment remAttach)
			throws Exception {
		prepareRemoveAttachment(meeting, remAttach);
	}

	/**
	 * Give it a number of tries to update the event/meeting object into DB
	 * storage if this still satisfy the pre-condition regardless some changes
	 * in DB storage
	 * 
	 * @param meeting
	 *            a SignupMeeting object.
	 * @param SignupAttachment
	 *            a SignupAttachment object.
	 * @throws Exception
	 *             throw if anything goes wrong.
	 */
	private void handleVersion(SignupMeeting meeting, SignupAttachment remAttach) throws Exception {
		for (int i = 0; i < MAX_NUMBER_OF_RETRY; i++) {
			try {
				meeting = signupMeetingService.loadSignupMeeting(meeting.getId(), userId, siteId);
				actionsForOptimisticVersioning(meeting, remAttach);
				signupMeetingService.updateSignupMeeting(meeting, isOrganizer);
			} catch (OptimisticLockingFailureException oe) {
				// don't do any thing
			}
		}
		throw new Exception("It's already removed");
	}

	private void prepareRemoveAttachment(SignupMeeting meeting, SignupAttachment remAttach) throws Exception {
		List<SignupAttachment> attachList = meeting.getSignupAttachments();
		boolean found = false;
		if(attachList !=null){
			for (Iterator iter = attachList.iterator(); iter.hasNext();) {
				SignupAttachment a = (SignupAttachment) iter.next();
				if(a.getResourceId().equals(remAttach.getResourceId())){
					iter.remove();
					found = true;
				}
			}
		}
		
		if (!found) {
			throw new Exception("It's already removed");
		}
	}

}
