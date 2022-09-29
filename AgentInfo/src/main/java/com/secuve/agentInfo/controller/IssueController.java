package com.secuve.agentInfo.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import com.secuve.agentInfo.core.FileDownloadView;
import com.secuve.agentInfo.service.IssueService;
import com.secuve.agentInfo.vo.Issue;

@Controller
public class IssueController {
	@Autowired IssueService issueService;
	
	@GetMapping(value = "/issue/issueList")
	public String IssueList(Model model) {
		List<String> issueCustomer = issueService.getSelectInput("issueCustomer");
		List<String> issueTitle = issueService.getSelectInput("issueTitle");
		List<String> issueTosms = issueService.getSelectInput("issueTosms");
		List<String> issueTosrf = issueService.getSelectInput("issueTosrf");
		List<String> issuePortal = issueService.getSelectInput("issuePortal");
		List<String> issueJava = issueService.getSelectInput("issueJava");
		List<String> issueWas = issueService.getSelectInput("issueWas");
		
		model.addAttribute("issueCustomer", issueCustomer);
		model.addAttribute("issueTitle", issueTitle);
		model.addAttribute("issueTosms", issueTosms);
		model.addAttribute("issueTosrf", issueTosrf);
		model.addAttribute("issuePortal", issuePortal);
		model.addAttribute("issueJava", issueJava);
		model.addAttribute("issueWas", issueWas);
		
		return "issue/IssueList";
	}
	
	@ResponseBody
	@PostMapping(value = "/issue")
	public Map<String, Object> Issue(Issue search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<Issue> list = new ArrayList<>(issueService.getIssueList(search));

		int totalCount = issueService.getIssueListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@GetMapping(value = "/issue/issueWrite")
	public String ExistingNew(Model model) {
		ArrayList<Issue> issueList = new ArrayList<Issue>();
		Issue issue = new Issue();
		issue.setIssueKeyNum(0);
		issueList.add(issue);
		model.addAttribute("issue",issueList);
		model.addAttribute("issueTitle", issue);
		model.addAttribute("viewType", "insert");
		return "issue/IssueView";
	}
	
	@ResponseBody
	@PostMapping(value = "/issue/issueSave")
	public Map IssueSave(Issue issue, Principal principal) {
		issue.setIssueRegistrant(principal.getName());
		issue.setIssueRegistrationDate(issueService.nowDate());
		
		Map result = issueService.insertIssue(issue, principal);
		return result;
	}
	
	@ResponseBody
	@PostMapping(value = "/issue/delete")
	public String IssueDelete(@RequestParam int[] chkList) {
		return issueService.delIssue(chkList);
	}
	
	@ResponseBody
	@PostMapping(value = "/issue/update")
	public Map IssueUpdate(Issue issue, Principal principal) {
		issue.setIssueModifier(principal.getName());
		issue.setIssueModifiedDate(issueService.nowDate());
		
		Map result = issueService.updateIssue(issue, principal);
		return result;
	}
	
	@ResponseBody
	@PostMapping(value = "/issue/copy")
	public Map IssueCopy(Issue issue, Principal principal) {
		issue.setIssueModifier(principal.getName());
		issue.setIssueModifiedDate(issueService.nowDate());
		
		Map result = issueService.copyIssue(issue, principal);
		return result;
	}
	
	@GetMapping(value = "/issue/updateView")
	public String UpdateView(Model model, int issueKeyNum) {
		Issue issueTitle = issueService.getIssueOneTitle(issueKeyNum);
		ArrayList<Issue> issue = new ArrayList<>(issueService.getIssueOne(issueKeyNum));
		
		model.addAttribute("viewType", "update");
		model.addAttribute("issueTitle", issueTitle);
		model.addAttribute("issue",issue);
		return "issue/IssueView";
	}
	
	@GetMapping(value = "/issue/copyView")
	public String CopyView(Model model, int issueKeyNum) {
		Issue issueTitle = issueService.getIssueOneTitle(issueKeyNum);
		ArrayList<Issue> issue = new ArrayList<>(issueService.getIssueOne(issueKeyNum));
		
		model.addAttribute("viewType", "copy");
		model.addAttribute("issueTitle", issueTitle);
		model.addAttribute("issue",issue);
		return "issue/IssueView";
	}
	
	@RequestMapping(value = "/issue/pdfDownload", method = RequestMethod.GET)
	public void downloadPdf() {
		StringBuilder body = new StringBuilder();
		 
		String header = "<!DOCTYPE html>";
			header += "<html lang='en' class=' js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths'>";
			header += "<head>";
			header += "<style>";
			header += "table {";
			header += "width: 100%;";
			header += "border-top: 1px solid #444444;";
			header += "border-collapse: collapse;";
			header += "}";
			header += "th, td {";
			header += "border-bottom: 1px solid #444444;";
			header += "border-left: 1px solid #444444;";
			header += "padding: 3px;";
			header += "}";
			header += "th:first-child, td:first-child {";
			header += "border-left: none;";
			header += "}";
			header += "</style>";
			header += "</head>";
		                
		String middle = "<div>";
			middle += "<div style='margin-bottom: 5px;'>";
			middle += "<div style='text-align:left; float:left'><inputtype='text' style='width:400px' id='issueDivision' name='issueDivision' placeholder='제목'></div>";
			middle += "<div style='text-align:right;'></div>";
			middle += "</div>";
			middle += "<table style='width:100%'>";
			middle += "<tbody>";
			middle += "<tr>";
			middle += "<td style='hight:10px'>OS</td>";
			middle += "<td><inputtype='text' id='issueOs' name='issueOs' placeholder='OS'></td>";
			middle += "<td></td>";
			middle += "<td></td>";
			middle += "</tr>";
			middle += "<tr>";
			middle += "<td>대항목</td>";
			middle += "<td><inputtype='text' id='issueAward' name='issueAward' placeholder='대항목'></td>";
			middle += "<td>중학목</td>";
			middle += "<td><inputtype='text' id='issueMiddle' name='issueMiddle' placeholder='중항목'></td>";
			middle += "</tr>";
			middle += "<tr>";
			middle += "<td>소항목1</td>";
			middle += "<td><inputtype='text' id='issueUnder1' name='issueUnder1' placeholder='소항목1'></td>";
			middle += "<td>소항목2</td>";
			middle += "<td><inputtype='text' id='issueUnder2' name='issueUnder2' placeholder='소항목2'></td>";
			middle += "</tr>";
			middle += "<tr>";
			middle += "<td>결함번호</td>";
			middle += "<td><inputtype='text' id='issueFlawNum' name='issueFlawNum' placeholder='결함번호'></td>";
			middle += "<td>영향도</td>";
			middle += "<td><inputtype='text' id='issueEffect' name='issueEffect' placeholder='영향도'></td>";
			middle += "</tr>";
			middle += "<tr>";
			middle += "<td>테스트 결과</td>";
			middle += "<td><inputtype='text' id='issueTextResult' name='issueTextResult' placeholder='테스트 결과'></td>";
			middle += "<td>적용여부</td>";
			middle += "<td><inputtype='text' id='issueApplyYn' name='issueApplyYn' placeholder='적용 여부'></td>";
			middle += "</tr>";
			middle += "<tr>";
			middle += "<td>확인내용</td>";
			middle += "<td colspan='3'><inputtype='text' id='issueConfirm' name='issueConfirm' placeholder='확인 내용'></td>";
			middle += "</tr>";
			middle += "<tr>";
			middle += "<td>장애내용</td>";
			middle += "<td colspan='3'><p><img style=\"width: 1000px;\" src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAA+gAAAPoCAMAAAB6fSTWAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA2ZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDo5MjhFQkZCMERFMzdFRDExOUZBNTg1RkQ2MjlCRkVENyIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDowNURDRDUwNjM3REYxMUVEQTI2QkJFRTJENjI4OTMzOSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDowNURDRDUwNTM3REYxMUVEQTI2QkJFRTJENjI4OTMzOSIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M2IChXaW5kb3dzKSI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjkyOEVCRkIwREUzN0VEMTE5RkE1ODVGRDYyOUJGRUQ3IiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjkyOEVCRkIwREUzN0VEMTE5RkE1ODVGRDYyOUJGRUQ3Ii8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+pD5jhQAAAv1QTFRFHx8fX19ff39/v7+/AQEBAgICAwMDBgYG/f399fX1+fn59PT0Dw8P8/PzFRUVBAQE+Pj4KCgo9/f39vb2DAwM+vr68PDwEBAQ+/v7wMDAERERHh4eEhISBwcH7+/vYGBgTExM7e3tCgoKtLS0YWFhDg4OCQkJu7u7REREBQUFLS0tHBwcwsLCCAgIGBgYycnJQkJC29vb0tLSCwsLm5ub6urq/Pz8YmJiPj4+Ozs7IyMjwcHBra2to6OjPDw8FBQUcnJyz8/PzMzMaWlp4+Pj09PTPT097Ozsn5+fKioqJCQk5OTktbW1qqqqh4eHSEhIvb29ExMT3NzcmpqamJiYiIiIfn5+Nzc36+vrIiIit7e3cXFxeHh4lpaWODg45ubm8fHxsbGxcHBwDQ0N5+fn4eHh1NTU7u7umZmZaGholJSUdnZ2xcXFc3NzQ0NDb29vLi4u19fXFhYW1tbW0NDQ3d3drq6uPz8/s7Ozw8PDLy8vY2NjhISEXV1dp6enyMjIGRkZNjY2OTk5hoaGenp6Tk5OS0tLRUVFW1tbGhoa1dXVzs7O39/fubm56OjopKSkd3d3ZmZm5eXl2traUVFR3t7epqamKSkppaWlFxcXe3t7a2trq6urLCwsurq6jo6OsrKyuLi4ampqICAgdXV1Wlpa8vLy4ODgNDQ0MzMzeXl50dHRr6+vSUlJiYmJrKysioqKISEhfX19Ojo6QUFB6enpoqKixsbGx8fHvLy8KysrdHR0zc3NQEBAtra2RkZGk5OTV1dXSkpKlZWVnJycsLCw2NjYnp6eJycnbW1tqamphYWFj4+PVVVVMDAwgoKCXFxcUFBQfHx8R0dHjY2NZ2dnZWVlXl5eJiYmbm5uvr6+WVlZNTU1TU1NgICAWFhYGxsbkpKS2dnZT09PHR0dysrKbGxsnZ2dVlZWMjIyi4uLZGRkl5eXjIyMUlJSkJCQVFRUU1NTMTEx4uLigYGBJSUloaGhkZGRoKCgy8vLg4ODxMTEqKioAAAA////u/j3pwAAAP90Uk5T//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////8AZvyKWQAAQAZJREFUeNrsnXV4F8f6tynEhYSEhCQESLDgUtwKFHd3l+JeCrS4FWjxUqy0tAXq7u7u7n4q57TH3Xavtz3n7e9UITwzu9+Znfv+i7+4Rj73Zr+zM8+U8QEg8pRhCAAQHQAQHQAQHQAQHQAQHQAQHQAQHQAQHQDRAQDRAQDRAQDRAQDRAQDRAQDRAQDRARAdABAdABAdABAdABAdABAdABAdABAdANEBANEBANEBANEBANEBANEBANEBANEBANEBEB0AEB0AEB0AEB0AEB0AEB0AEB0AEB0A0QEA0QEA0QEA0QEA0QEA0QEA0QEA0QEQHQAQHQAQHcwjefd5c/ruf3TYwU673v1DnTpXX9171KhBBQVTvP9jSkHBoFGjel99dZ06f3h3V6eDwx7d33fOebuTGTtEB5NJ6dr40if7d1p5/dq3FiV6YhIXvbX2+pVj+n9xaeOuKYwqooMhf7vPvOSxsjU33dPRC4CO92yqWfaxbWfydx7RITZUve/QDZcXLSj0QqFwQVGXGw7dV5VxR3QIyfDP9pc9dlVIgv9I+KuOld3/Gb4jOgRH15KPZ97WyDOANXWeHtqgBzOC6KD3r3j+ozNPK/AM40CTy3+dP5HZQXRQZ+uS4Rtv9swlru3vVzwwlXlCdBA73m/npkLPChoNuObQVmYM0eHkuKLc+o2NPMtotHF9uSuYO0SH0pA07YtdCxI8S0mo98YX05KYRUSH45B31w3npnnWk3buDXflMZuIDj9BZrsXNzXzIkOzTS+2y2RWER2+Q0q5W1o39CJHw9a3vMN+eUSH/zDtuUeaeZGl2SOHpzHHiO4423dU2+JFni3VdmxnrhHdUVo2mP1CnOcIcS/MbtCSOUd01yhedazQc4zCY6uKmXlEd4eFNy3N8JwkY+lNZzL/iO4ASQ0mt/Wcpu3kBuyoQfRI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\" data-filename=\"minus.png\"><br></p></td>";
			middle += "</tr>";
			middle += "<tr>";
			middle += "<td>비고</td>";
			middle += "<td colspan='3'><inputtype='text' id='issueNote' name='issueNote' placeholder='비고'></td>";
			middle += "</tr>";
			middle += "</tbody>";
			middle += "</table>";
			middle += "</div>";

		String footer = "	<div class='footer' style='width: 780px;height: 60px;padding: 20px;text-align: center;font-size: 0.75em; margin: auto;'>"
		                + "	본 메일은 발신전용 입니다. 자세한 사항은 홈페이지를 확인해 주시기 바랍니다.	" + "	</div>" + "</body>" + "</html>";
		                
		body.append(header);
		body.append(middle);
		body.append(footer);

		String BODY = body.toString();

		// html to pdf
		try {
			issueService.makepdf(BODY, "C:\\AgentInfo\\font\\test.pdf");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/issue/pdfView", method = RequestMethod.POST)
	public String PdfView(Model model, int issueKeyNum) {
		Issue issueTitle = issueService.getIssueOneTitle(issueKeyNum);
		ArrayList<Issue> issue = new ArrayList<>(issueService.getIssueOne(issueKeyNum));
		
		model.addAttribute("viewType", "update");
		model.addAttribute("issueTitle", issueTitle);
		model.addAttribute("issue",issue);
		return "issue/PdfView";
	}
	
	@ResponseBody
	@PostMapping(value = "/issue/pdf")
	public String PDF(String jsp, String issueCustomer, String issueTitle, String issueDate, Principal principal, Model model) {
		StringBuilder html = new StringBuilder();
		String body = jsp;
		
		html.append(body);
		String filePath = "C:\\AgentInfo\\IssueDownload";
		String fileName = issueCustomer + "_" + issueTitle + "_" + issueDate + ".pdf";

		String BODY = body.toString();

		// html to pdf
		try {
			issueService.makepdf(BODY, filePath + "\\" + fileName);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "FALSE";
		}
		return "OK"; 
	}
	
	@GetMapping(value = "/issue/fileDownload")
	public View FileDownload(@RequestParam String fileName, Model model) throws Exception {
		String filePath = "C:\\AgentInfo\\IssueDownload";
		model.addAttribute("fileUploadPath", filePath);          // 파일 경로    
		model.addAttribute("filePhysicalName", "/"+fileName);    // 파일 이름    
		model.addAttribute("fileLogicalName", fileName);  		 // 출력할 파일 이름
	
		return new FileDownloadView();
	}
	
	@ResponseBody
	@PostMapping(value = "/issue/fileDelete")
	public String FileDelete(String fileName, Principal principal, Model model) {
		//파일 경로 지정
		String path = "C:\\AgentInfo\\IssueDownload";
				
		//현재 게시판에 존재하는 파일객체를 만듬
		File file = new File(path + "\\" + fileName);
			
		if(file.exists()) { // 파일이 존재하면
			file.delete(); // 파일 삭제
			return "OK"; 
		}
		return "NotFile";
	}
}
