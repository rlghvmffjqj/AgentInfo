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

import com.secuve.agentInfo.service.PackagesService;
import com.secuve.agentInfo.vo.Packages;

@Component
public class PackagesSchedule extends QuartzJobBean {
    @Autowired PackagesService packagesService;

	@Override
	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		List<Packages> list = packagesService.getPackagesAll();
		
		String[] columnList = {"고객사 명", "사업명", "망 구분", "요청일자", "전달일자", "상태", "패키지 종류", "일반/커스텀", "Agent ver", "패키지명", "담당자", "OS종류", "패키지 상세버전", "Agent OS", "기존/신규", "요청 제품구분", "전달 방법", "비고", "상태 변경 의견"};
		
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
		    for(Packages packages : list){
		    	row=sheet.createRow(i);
	        	i++;
		        if(columnList !=null &&columnList.length >0){
			        cell=row.createCell(0);
			        cell.setCellValue((packages.getCustomerName()));
			        cell=row.createCell(1);
			        cell.setCellValue((packages.getBusinessName()));
			        cell=row.createCell(2);
			        cell.setCellValue((packages.getNetworkClassification()));
			        cell=row.createCell(3);
			        cell.setCellValue((packages.getRequestDate()));
			        cell=row.createCell(4);
			        cell.setCellValue((packages.getDeliveryData()));
			        cell=row.createCell(5);
			        cell.setCellValue((packages.getState()));
			        cell=row.createCell(6);
			        cell.setCellValue((packages.getManagementServer()));
			        cell=row.createCell(7);
			        cell.setCellValue((packages.getGeneralCustom()));
			        cell=row.createCell(8);
			        cell.setCellValue((packages.getAgentVer()));
			        cell=row.createCell(9);
			        cell.setCellValue((packages.getPackageName()));
			        cell=row.createCell(10);
			        cell.setCellValue((packages.getManager()));
			        cell=row.createCell(11);
			        cell.setCellValue((packages.getOsType()));
			        cell=row.createCell(12);
			        cell.setCellValue((packages.getOsDetailVersion()));
			        cell=row.createCell(13);
			        cell.setCellValue((packages.getAgentOS()));
			        cell=row.createCell(14);
			        cell.setCellValue((packages.getExistingNew()));
			        cell=row.createCell(15);
			        cell.setCellValue((packages.getRequestProductCategory()));
			        cell=row.createCell(16);
			        cell.setCellValue((packages.getDeliveryMethod()));
			        cell=row.createCell(17);
			        cell.setCellValue((packages.getNote()));
			        cell=row.createCell(18);
			        cell.setCellValue((packages.getStatusComment()));
		        }
		    }
		}
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH시mm분ss초");
		String nowDate = formatter.format(now); 

		FileOutputStream fileoutputstream;
		try {
			String localIp = InetAddress.getLocalHost().getHostAddress();
			if(localIp.equals("172.16.100.90")) {
				fileoutputstream = new FileOutputStream("C:/AgentInfo/packagesBackUP/packages-"+nowDate+".csv");
			} else {
				fileoutputstream = new FileOutputStream("D:/PackagesBackUp/packages-"+nowDate+".csv");
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

