/**********************************************************************************
 * $URL: https://source.sakaiproject.org/contrib/signup/branches/2-6-x/tool/src/java/org/sakaiproject/signup/tool/jsf/RealmItem.java $
 * $Id: RealmItem.java 59188 2009-03-23 15:42:38Z guangzheng.liu@yale.edu $
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
 **********************************************************************************/
package org.sakaiproject.signup.tool.jsf;

/**
 * <p>
 * This is a class for JSF UI. It holds the necessary information for permission
 * editing.
 * </P>
 */
public class RealmItem {
	private String siteTitle;

	private String groupTitle;

	private String refId;

	private boolean siteLevel;

	private boolean isAllowedUpd = true;

	/**
	 * Constructor
	 * 
	 * @param siteTitle
	 *            name of the site
	 * @param groupTitle
	 *            name of the group
	 * @param refId
	 *            reference Id to the realm
	 * @param isSiteLevel
	 *            true if this realm scope is a site scope
	 */
	public RealmItem(String siteTitle, String groupTitle, String refId, boolean isSiteLevel) {
		this.siteTitle = siteTitle;
		this.groupTitle = groupTitle;
		this.refId = refId;
		this.siteLevel = isSiteLevel;
	}

	/**
	 * This is a getter method for UI
	 * 
	 * @return the name of the site
	 */
	public String getSiteTitle() {
		return siteTitle;
	}

	/**
	 * This is a getter method for UI
	 * 
	 * @return the name of the group
	 */
	public String getGroupTitle() {
		return groupTitle;
	}

	/**
	 * This gives the Reference Id for the realm
	 * 
	 * @return a reference Id string
	 */
	public String getRefId() {
		return refId;
	}

	/**
	 * This is a getter method for UI
	 * 
	 * @return true if it is a site scope level
	 */
	public boolean isSiteLevel() {
		return siteLevel;
	}

	/**
	 * Checks if current user is allowed to update
	 * 
	 * @return true if the user is allowed to update
	 */
	public boolean isAllowedUpd() {
		return isAllowedUpd;
	}

	/**
	 * This is a setter method
	 * 
	 * @param allowedUpd
	 *            a boolean value
	 */
	public void setAllowedUpd(boolean allowedUpd) {
		this.isAllowedUpd = allowedUpd;
	}

}
