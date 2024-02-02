package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.ServiceControlService;
import com.secuve.agentInfo.vo.ServiceControl;
import com.secuve.agentInfo.vo.ServiceControlHost;

@Controller
public class ServiceControlController {
	@Autowired ServiceControlService serviceControlService;
	@Autowired FavoritePageService favoritePageService;
	
	@GetMapping(value = "/serviceControl/list")
	public String ServiceControl(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "서비스 제어");
		List<String> serviceControlPurpose = serviceControlService.getServiceControlValue("serviceControlPurpose");
		List<String> serviceControlIp = serviceControlService.getServiceControlValue("serviceControlIp");
		model.addAttribute("serviceControlPurpose", serviceControlPurpose);
		model.addAttribute("serviceControlIp", serviceControlIp);
		return "serviceControl/ServiceControlList";
	}
	
	@ResponseBody
	@PostMapping(value = "/serviceControl")
	public Map<String, Object> ServiceControl(ServiceControl search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<ServiceControl> list = new ArrayList<>(serviceControlService.getServiceControlList(search));

		int totalCount = serviceControlService.getServiceControlListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@PostMapping(value = "/serviceControl/insertView")
	public String ServiceControlType(Model model) {
		return "/serviceControl/ServerTypeSelect";
	}
	
	@ResponseBody
	@PostMapping(value = "/serviceControl/insert")
	public String ServiceControlInsert(Principal principal, ServiceControl serviceControl) throws ParseException {
		return serviceControlService.serviceControlManagerInsert(serviceControl);
	}
	
	@ResponseBody
	@PostMapping(value = "/serviceControl/delete")
	public String ServiceControlDelete(@RequestParam int[] chkList, Principal principal) {
		return serviceControlService.delServiceControl(chkList, principal);
	}
	
	@ResponseBody
	@PostMapping(value = "/serviceControl/synchronization")
	public String ServiceControlSynchronization() {
		return serviceControlService.serviceControlSynchronization();
	}
	
	@PostMapping(value = "/serviceControl/managerUpdateView")
	public String ServiceControlManagerView(Model model, String serviceControlIp) {
		model.addAttribute("serviceControl",serviceControlService.getServiceControlIpOne(serviceControlIp));
		return "/serviceControl/serverTypeView/ServiceControlManagerView";
	}
	
	@PostMapping(value = "/serviceControl/dbUpdateView")
	public String ServiceControlDBView(Model model, String serviceControlIp) {
		model.addAttribute("serviceControl",serviceControlService.getServiceControlIpOne(serviceControlIp));
		return "/serviceControl/serverTypeView/ServiceControlDBView";
	}
	
	@PostMapping(value = "/serviceControl/hostUpdateView")
	public String ServiceControlHostView(Model model, String serviceControlIp) {
		List<ServiceControlHost> serviceControlHostList = new ArrayList<ServiceControlHost>();
		try {
			serviceControlHostList = serviceControlService.getHyperVList(serviceControlIp);
		} catch (Exception e) {}
		model.addAttribute("serviceControlHostList", serviceControlHostList);
		model.addAttribute("serviceControl",serviceControlService.getServiceControlIpOne(serviceControlIp));
		return "/serviceControl/serverTypeView/ServiceControlHostView";
	}
	
	@ResponseBody
	@PostMapping(value = "/serviceControl/executionChange")
	public String ExecutionChange(ServiceControl serviceControl) {
		serviceControlService.executionChange(serviceControl);
		//serviceControlService.serviceControlSynchronization();
		return "OK";
	}
	
	@PostMapping(value = "/serviceControl/logInquiryView")
	public String LogInquiryView(ServiceControl serviceControl, Model model) {
		String logInquiry = serviceControlService.getLogInquiry(serviceControl);
		logInquiry = logInquiry.replaceAll("\\\\n", "<br>");
		logInquiry = logInquiry.replaceAll("\\\\t", "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
		model.addAttribute("serviceControlIp", serviceControl.getServiceControlIp());
		model.addAttribute("serviceControlLog", logInquiry);
		return "/serviceControl/LogInquiryView";
	}
	
	@ResponseBody
	@PostMapping(value = "/serviceControl/update")
	public String ServiceControlUpdate(ServiceControl serviceControl) {
		return serviceControlService.setServiceControlUpdate(serviceControl);
	}
	
	@PostMapping(value = "/serviceControl/routeSettingView")
	public String routeSettingView(String serviceControlIp, Model model) {
		model.addAttribute("serviceControl", serviceControlService.getServiceControlIpOne(serviceControlIp));
		return "/serviceControl/RouteSettingView";
	}
	
	@ResponseBody
	@PostMapping(value = "/serviceControl/routeSetting")
	public String RouteSetting(ServiceControl serviceControl) {
		return serviceControlService.setRouteSetting(serviceControl);
	}
	
	@PostMapping(value = "/serviceControl/serviceControlManager")
	public String ServiceControlManager(String serviceControlServerType, Model model) {
		model.addAttribute("serviceControlServerType", serviceControlServerType);
		return "/serviceControl/serverTypeAdd/ServiceControlManager";
	}
	
	@PostMapping(value = "/serviceControl/serviceControlHost")
	public String ServiceControlHost(String serviceControlServerType, Model model) {
		model.addAttribute("serviceControlServerType", serviceControlServerType);
		return "/serviceControl/serverTypeAdd/ServiceControlHost";
	}
	
	@PostMapping(value = "/serviceControl/serviceControlDB")
	public String ServiceControlDB(String serviceControlServerType, Model model) {
		model.addAttribute("serviceControlServerType", serviceControlServerType);
		return "/serviceControl/serverTypeAdd/ServiceControlDB";
	}
	
	@ResponseBody
	@PostMapping(value = "/serviceControl/hostRunModChange")
	public String HostRunModChange(ServiceControlHost serviceControlHost) {
		return serviceControlService.hostRunModChange(serviceControlHost);
	}
}
