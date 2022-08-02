package com.secuve.agentInfo.schedule;

import java.io.FileOutputStream;
import java.io.IOException;
import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Component;

import com.secuve.agentInfo.service.EmployeeService;
import com.secuve.agentInfo.vo.Employee;

@Component
public class EmployeeSchedule extends QuartzJobBean {
	@Autowired EmployeeService employeeService;

	@Override
	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		List<Employee> list = employeeService.getEmployeeAll();
		
		String[] columnList = {"사원 번호", "부서명", "부서 풀경로", "상위 부서", "타입", "직급", "사원 이름", "전화번호", "이메일", "상태", "마지막 로그인 시간"};
		
		//1차로 workbook을 생성 
		HSSFWorkbook workbook=new HSSFWorkbook();

		//2차는 sheet생성 
		HSSFSheet sheet=workbook.createSheet("패키지");

		//엑셀의 행 
		HSSFRow row=null;

		//엑셀의 셀 
		HSSFCell cell=null;

		//임의의 DB데이터 조회 
		if(list !=null &&list.size() >0){
			row=sheet.createRow(0);
			for(int num = 0; num < columnList.length; num++) {
				cell=row.createCell(num);
				cell.setCellValue(columnList[num]);
			}
			int i=1;
		    for(Employee employee : list){
		    	row=sheet.createRow(i);
	        	i++;
		        if(columnList !=null &&columnList.length >0){
			        cell=row.createCell(0);
			        cell.setCellValue((employee.getEmployeeId()));
			        cell=row.createCell(1);
			        cell.setCellValue((employee.getDepartmentName()));
			        cell=row.createCell(2);
			        cell.setCellValue((employee.getDepartmentFullPath()));
			        cell=row.createCell(3);
			        cell.setCellValue((employee.getDepartmentParentPath()));
			        cell=row.createCell(4);
			        cell.setCellValue((employee.getEmployeeType()));
			        cell=row.createCell(5);
			        cell.setCellValue((employee.getEmployeeRank()));
			        cell=row.createCell(6);
			        cell.setCellValue((employee.getEmployeeName()));
			        cell=row.createCell(7);
			        cell.setCellValue((employee.getEmployeePhone()));
			        cell=row.createCell(8);
			        cell.setCellValue((employee.getEmployeeEmail()));
			        cell=row.createCell(9);
			        cell.setCellValue((employee.getEmployeeStatus()));
			        cell=row.createCell(10);
			        cell.setCellValue((employee.getLastLogin()));
		        }
		    }
		}
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH시mm분ss초");
		String nowDate = formatter.format(now); 

		FileOutputStream fileoutputstream;
		try {
			String localIp = InetAddress.getLocalHost().getHostAddress();
			if(localIp.equals("172.16.50.80")) {
				fileoutputstream = new FileOutputStream("D:/EmployeeBackUp/employee-"+nowDate+".csv");
			} else {
				fileoutputstream = new FileOutputStream("C:/AgentInfo/EmployeeBackUP/employee-"+nowDate+".csv");
			}
			
			//파일을 쓴다
			workbook.write(fileoutputstream);

			//필수로 닫아주어야함 
			fileoutputstream.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
