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

import com.secuve.agentInfo.dao.License5Dao;
import com.secuve.agentInfo.vo.License5;

@Component
public class License5Schedule  extends QuartzJobBean {
	@Autowired License5Dao license5Dao;
	
	@Override
	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		License5 license = new License5();
		license.setLicenseState("issued");
		List<License5> list = license5Dao.getLicenseListAll(license);
		
		String[] columnList = {"","구분","고객사명","사업명","추가정보","시작일","만료일", "일련번호","MAC주소","제품유형","iGRIFFIN Agent 수량","TOS 5.0 Agent 수량","TOS 2.0 Agent 수량","DBMS 수량","Network 수량","AIX(OS) 수량","HPUX(OS) 수량","Solaris(OS) 수량","Linux(OS) 수량","Windows(OS) 수량","관리서버 OS","관리서버 DBMS","국가","제품버전","라인선스 파일명","요청자"};
		
		//1차로 workbook을 생성 
		HSSFWorkbook workbook=new HSSFWorkbook();

		//2차는 sheet생성 
		HSSFSheet sheet=workbook.createSheet("라이선스5");

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
		    for(License5 license5 : list){
		    	row=sheet.createRow(i);
	        	i++;
		        if(columnList !=null &&columnList.length >0){
		        	cell=row.createCell(0);
				    cell.setCellValue((""));
			        cell=row.createCell(1);
			        cell.setCellValue((license5.getLicenseType()));
			        cell=row.createCell(2);
			        cell.setCellValue((license5.getCustomerName()));
			        cell=row.createCell(3);
			        cell.setCellValue((license5.getBusinessName()));
			        cell=row.createCell(4);
			        cell.setCellValue((license5.getAdditionalInformation()));
			        cell=row.createCell(5);
			        cell.setCellValue((license5.getIssueDate()));
			        cell=row.createCell(6);
			        cell.setCellValue((license5.getExpirationDays()));
			        cell=row.createCell(7);
			        cell.setCellValue((license5.getSerialNumber()));
			        cell=row.createCell(8);
			        cell.setCellValue((license5.getMacAddress()));
			        cell=row.createCell(9);
			        cell.setCellValue((license5.getProductType()));
			        cell=row.createCell(10);
			        cell.setCellValue((license5.getIgriffinAgentCount()));
			        cell=row.createCell(11);
			        cell.setCellValue((license5.getTos5AgentCount()));
			        cell=row.createCell(12);
			        cell.setCellValue((license5.getTos2AgentCount()));
			        cell=row.createCell(13);
			        cell.setCellValue((license5.getDbmsCount()));
			        cell=row.createCell(14);
			        cell.setCellValue((license5.getNetworkCount()));
			        cell=row.createCell(15);
			        cell.setCellValue((license5.getAixCount()));
			        cell=row.createCell(16);
			        cell.setCellValue((license5.getHpuxCount()));
			        cell=row.createCell(17);
			        cell.setCellValue((license5.getSolarisCount()));
			        cell=row.createCell(18);
			        cell.setCellValue((license5.getLinuxCount()));
			        cell=row.createCell(19);
			        cell.setCellValue((license5.getWindowsCount()));
			        cell=row.createCell(20);
			        cell.setCellValue((license5.getManagerOsType()));
			        cell=row.createCell(21);
			        cell.setCellValue((license5.getManagerDbmsType()));
			        cell=row.createCell(22);
			        cell.setCellValue((license5.getCountry()));
			        cell=row.createCell(23);
			        cell.setCellValue((license5.getProductVersion()));
			        cell=row.createCell(24);
			        cell.setCellValue((license5.getLicenseFilePath()));
			        cell=row.createCell(25);
			        cell.setCellValue((license5.getRequester()));
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
				fileoutputstream = new FileOutputStream("C:/AgentInfo/license5BackUP/license5-"+nowDate+".csv");
			} else {
				fileoutputstream = new FileOutputStream("D:/license5BackUp/license5-"+nowDate+".csv");
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
