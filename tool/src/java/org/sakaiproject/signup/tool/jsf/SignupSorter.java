/**********************************************************************************
 * $URL: https://source.sakaiproject.org/contrib/signup/branches/2-6-x/tool/src/java/org/sakaiproject/signup/tool/jsf/SignupSorter.java $
 * $Id: SignupSorter.java 64842 2009-11-20 18:52:38Z guangzheng.liu@yale.edu $
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
package org.sakaiproject.signup.tool.jsf;

import java.text.Collator;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

/**
 * *
 * <p>
 * This class will provide sorting logic for Sign-up tool main page.
 * </P>
 * 
 * @author gl256
 * 
 */
public class SignupSorter {

	public static final String TITLE_COLUMN = "titleName";

	public static final String LOCATION_COLUMN = "location";

	public static final String CREATOR_COLUMN = "creator";

	public static final String DATE_COLUMN = "startTime";

	public static final String STATUS_COLUMN = "availability";

	private String sortColumn;

	private boolean sortAscending;

	/* Static comparators */
	public static final Comparator<SignupMeetingWrapper> sortTitleComparator;

	public static final Comparator<SignupMeetingWrapper> sortLocationComparator;

	public static final Comparator<SignupMeetingWrapper> sortOwnerComparator;

	public static final Comparator<SignupMeetingWrapper> sortDateComparator;

	public static final Comparator<SignupMeetingWrapper> sortStatusComparator;
	static {
		sortTitleComparator = new Comparator<SignupMeetingWrapper>() {
			public int compare(SignupMeetingWrapper one, SignupMeetingWrapper another) {
				int comparison = Collator.getInstance().compare(one.getMeeting().getTitle(),
						another.getMeeting().getTitle());
				return comparison == 0 ? sortDateComparator.compare(one, another) : comparison;
			}
		};

		sortLocationComparator = new Comparator<SignupMeetingWrapper>() {
			public int compare(SignupMeetingWrapper one, SignupMeetingWrapper another) {
				int comparison = Collator.getInstance().compare(one.getMeeting().getLocation(),
						another.getMeeting().getLocation());
				return comparison == 0 ? sortDateComparator.compare(one, another) : comparison;
			}
		};

		sortOwnerComparator = new Comparator<SignupMeetingWrapper>() {
			public int compare(SignupMeetingWrapper one, SignupMeetingWrapper another) {
				int comparison = Collator.getInstance().compare(one.getCreator(), another.getCreator());
				return comparison == 0 ? sortDateComparator.compare(one, another) : comparison;
			}
		};

		sortDateComparator = new Comparator<SignupMeetingWrapper>() {
			public int compare(SignupMeetingWrapper one, SignupMeetingWrapper another) {

				Date date1 = one.getMeeting().getStartTime();
				Date date2 = another.getMeeting().getStartTime();

				if (date1 == null)
					return -1;
				int comparison = date1.compareTo(date2);
				if (comparison == 0) {
					return Collator.getInstance().compare(one.getMeeting().getId().toString(), another.getMeeting().getId().toString());
				}
				return comparison;
			}
		};

		sortStatusComparator = new Comparator<SignupMeetingWrapper>() {
			public int compare(SignupMeetingWrapper one, SignupMeetingWrapper another) {
				int comparison = Collator.getInstance().compare(one.getAvailableStatus(), another.getAvailableStatus());
				return comparison == 0 ? sortDateComparator.compare(one, another) : comparison;
			}
		};
	}

	/**
	 * This is a Constructor
	 * 
	 * @param defaultColumn
	 *            A String value, which defines the default sorting column.
	 * @param sortAscending
	 *            A Boolean value, which defines the default sorting direction.
	 */
	public SignupSorter(String defaultColumn, boolean sortAscending) {
		sortColumn = defaultColumn;
		this.sortAscending = sortAscending;
	}

	/**
	 * The Constructor
	 * 
	 */
	public SignupSorter() {
		sortColumn = DATE_COLUMN;
		sortAscending = true;
	}

	/**
	 * This will sort the SignupMeetingWrapper objects list according to user's
	 * seletion.
	 * 
	 * @param list
	 *            A SingupMeetingWrapper object list.
	 */
	public void sort(List<SignupMeetingWrapper> smList) {
		if (smList != null && !smList.isEmpty()) {
			Collections.sort(smList, getComparator());
			if (!this.sortAscending) {
				Collections.reverse(smList);
			}
		}
	}

	/**
	 * Test if it is ascending for sort.
	 * 
	 * @return true if it is ascending direction.
	 */
	public boolean isSortAscending() {
		return sortAscending;
	}

	/**
	 * This is a setter.
	 * 
	 * @param sortAscending
	 *            A boolean value.
	 */
	public void setSortAscending(boolean sortAscending) {
		this.sortAscending = sortAscending;
	}

	/**
	 * This is a getter.
	 * 
	 * @return A current sorting column name.
	 */
	public String getSortColumn() {
		return sortColumn;
	}

	/**
	 * This is a setter.
	 * 
	 * @param sortColumn
	 *            The current sorting column name
	 */
	public void setSortColumn(String sortColumn) {
		this.sortColumn = sortColumn;
	}

	protected Comparator<SignupMeetingWrapper> getComparator() {

		Comparator<SignupMeetingWrapper> comparator;
		if (TITLE_COLUMN.equals(sortColumn)) {
			comparator = sortTitleComparator;
		} else if (LOCATION_COLUMN.equals(sortColumn)) {
			comparator = sortLocationComparator;
		} else if (CREATOR_COLUMN.equals(sortColumn)) {
			comparator = sortOwnerComparator;
		} else if (STATUS_COLUMN.equals(sortColumn)) {
			comparator = sortStatusComparator;
		} else {
			// Default to the sort name
			comparator = sortDateComparator;
		}
		return comparator;
	}

	/**
	 * This is a getter for UI purpose.
	 * 
	 * @return The title column name.
	 */
	public String getTitleColumn() {
		return TITLE_COLUMN;
	}

	/**
	 * This is a getter for UI purpose.
	 * 
	 * @return The creator column name.
	 */
	public String getCreateColumn() {
		return CREATOR_COLUMN;
	}

	/**
	 * This is a getter for UI purpose.
	 * 
	 * @return The event date column name.
	 */
	public String getDateColumn() {
		return DATE_COLUMN;
	}

	/**
	 * This is a getter for UI purpose.
	 * 
	 * @return The event location column name.
	 */
	public String getLocationColumn() {
		return LOCATION_COLUMN;
	}
	
	public String getStatusColumn(){
		return STATUS_COLUMN;
	}
}
