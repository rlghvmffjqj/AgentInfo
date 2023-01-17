package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.EmployeeDao;
import com.secuve.agentInfo.dao.ServerCalendarDao;
import com.secuve.agentInfo.dao.ServerListDao;
import com.secuve.agentInfo.vo.ServerCalendar;
import com.secuve.agentInfo.vo.ServerList;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class ServerListService {
	@Autowired ServerListDao serverListDao;
	@Autowired ServerCalendarDao serverCalendarDao;
	@Autowired EmployeeDao employeeDao;

	public List<String> getSelectInput(String serverListType, String selectInput) {
		return serverListDao.getSelectInput(serverListType, selectInput);
	}

	public List<ServerList> getServerList(ServerList search) {
		return serverListDao.getServerList(serverListSearch(search));
	}

	public int getServerListCount(ServerList search) {
		return serverListDao.getServerListCount(serverListSearch(search));
	}
	
	public ServerList serverListSearch(ServerList search) {
		search.setServerListDivisionArr(search.getServerListDivision().split(","));
		search.setServerListIpArr(search.getServerListIp().split(","));
		search.setServerListStateArr(search.getServerListState().split(","));
		search.setServerListMacArr(search.getServerListMac().split(","));
		search.setServerListAssetNumArr(search.getServerListAssetNum().split(","));
		search.setServerListHostNameArr(search.getServerListHostName().split(","));
		search.setServerListPurposeArr(search.getServerListPurpose().split(","));
		search.setServerListOsArr(search.getServerListOs().split(","));
		search.setServerListServerClassArr(search.getServerListServerClass().split(","));
		search.setServerListRackPositionArr(search.getServerListRackPosition().split(","));
		
		return search;
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}
	
	public String nowDateYMD() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		return formatter.format(now);
	}

	public String insertServerList(ServerList serverList, String employeeId) {
		int count = serverListDao.getServerListAssetNum(serverList.getServerListAssetNumView());
		if(count >= 1) {
			return "AssetNumOverlap";
		}
		if(serverList.getServerListPeriodUseStartView() != "") {
			Date start = new Date(serverList.getServerListPeriodUseStartView().replace('-', '/') + " 00:00");
			if(serverList.getServerListPeriodUseEndView() != "") {
				Date end = new Date(serverList.getServerListPeriodUseEndView().replace('-', '/') + " 00:00");
				int compare = start.compareTo(end);
				if(compare > 0) {
					return "DateOver";
				}
			}
		}
		if(serverList.getServerListPeriodUseStartView() == null || serverList.getServerListPeriodUseStartView() == "") {
			serverList.setServerListPeriodUse(serverList.getServerListPeriodUseEndView());
		} else {
			serverList.setServerListPeriodUse(serverList.getServerListPeriodUseStartView()+" ~ "+serverList.getServerListPeriodUseEndView());
		}
		/* ========== 박범수 연구원 요청 시작 ========= */
		String departmentName = employeeDao.getEmployeeDepartment(employeeId);
		if(departmentName == "QA팀" || departmentName.equals("QA팀")) {
			if(serverList.getServerListStateView() == "장비대여" || serverList.getServerListStateView().equals("장비대여")) {
				if(serverList.getServerListPeriodUseStartView() != "") {
					serverList.setServerCalendarKeyNum(serverListCalendar(serverList, employeeId, "insert", departmentName));
				}
			}
		}
		/* ========== 박범수 연구원 요청 종료 ========= */
		int sucess = serverListDao.insertServerList(serverList);
		
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}
	
	public int serverListCalendar(ServerList serverList, String employeeId, String state, String departmentName) {
		ServerCalendar serverCalendar = new ServerCalendar();
		serverCalendar.setServerCalendarDepartment(departmentName);
		serverCalendar.setServerCalendarKeyNum(serverList.getServerCalendarKeyNum());
		serverCalendar.setServerCalendarStart(serverList.getServerListPeriodUseStartView().replace('-', '/')+" 00:00");
		
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
		if(serverList.getServerListPeriodUseEndView() != "") {
			try {
				Date endtDate = simpleDate.parse(serverList.getServerListPeriodUseEndView());
				java.util.Calendar cal = java.util.Calendar.getInstance();
				cal.setTime(endtDate);
				cal.add(java.util.Calendar.DATE, 1);
				serverCalendar.setServerCalendarEnd(simpleDate.format(cal.getTime()).replace('-', '/')+" 00:00");
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		
		serverCalendar.setServerCalendarContents(serverList.getServerListAssetNumView());
		serverCalendar.setServerCalendarRegistrant(employeeId);
		serverCalendar.setServerCalendarRegistrationDate(nowDate());
		if(state == "insert" || serverCalendar.getServerCalendarKeyNum() == 0) {
			serverCalendarDao.insertServerListServerCalendar(serverCalendar);
		} else if(state == "update") {
			serverCalendarDao.updateServerListServerCalendar(serverCalendar);
		}
		return serverCalendar.getServerCalendarKeyNum();
	}
	
	public String delServerList(int[] chkList, Principal principal) {
		for (int serverListKeyNum : chkList) {
			int sucess = serverListDao.delServerList(serverListKeyNum);
			if (sucess <= 0)
				return "FALSE";
		}
		return "OK";
	}

	public ServerList getServerListOne(int serverListKeyNum) {
		return serverListDao.getServerListOne(serverListKeyNum);
	}

	public String updateServerList(ServerList serverList, String employeeId) {
		int count = serverListDao.getServerListAssetNum(serverList.getServerListAssetNumView());
		String assetNum = serverListDao.getServerListOne(serverList.getServerListKeyNum()).getServerListAssetNum();
		if(assetNum.equals(serverList.getServerListAssetNumView())) {
			count = 0;
		}
		if(count >= 1) {
			return "AssetNumOverlap";
		}
		if(serverList.getServerListPeriodUseStartView() != "") {
			Date start = new Date(serverList.getServerListPeriodUseStartView().replace('-', '/') + " 00:00");
			if(serverList.getServerListPeriodUseEndView() != "") {
				Date end = new Date(serverList.getServerListPeriodUseEndView().replace('-', '/') + " 00:00");
				int compare = start.compareTo(end);
				if(compare > 0) {
					return "DateOver";
				}
			}
		}
		if(serverList.getServerListPeriodUseStartView() == null || serverList.getServerListPeriodUseStartView() == "") {
			serverList.setServerListPeriodUse(serverList.getServerListPeriodUseEndView());
		} else {
			serverList.setServerListPeriodUse(serverList.getServerListPeriodUseStartView()+" ~ "+serverList.getServerListPeriodUseEndView());
		}
		/* ========== 박범수 연구원 요청 시작 ========= */
		String departmentName = employeeDao.getEmployeeDepartment(employeeId);
		if(departmentName == "QA팀" || departmentName.equals("QA팀")) {
			if(serverList.getServerListStateView() == "장비대여" || serverList.getServerListStateView().equals("장비대여")) {
				if(serverList.getServerListPeriodUseStartView() != "") {
					serverList.setServerCalendarKeyNum(serverListCalendar(serverList, employeeId, "update", departmentName));
				}
			}
		}
		/* ========== 박범수 연구원 요청 종료 ========= */
		int sucess = serverListDao.updateServerList(serverList);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public String stateChange(int[] chkList, String stateView) {
		for (int serverListKeyNum : chkList) {
			int sucess = serverListDao.stateChange(serverListKeyNum, stateView);

			if (sucess <= 0) 
				return "FALSE";
		}
		return "OK";
	}

	public List<ServerList> getServerListAll() {
		return serverListDao.getServerListAll();
	}

	public List<ServerList> getServerListSearchAll(ServerList serverList) {
		return serverListDao.getServerListSearchAll(serverListSearch(serverList));
	}

}
