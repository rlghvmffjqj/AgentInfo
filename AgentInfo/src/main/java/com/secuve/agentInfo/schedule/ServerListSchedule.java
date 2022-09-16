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

import com.secuve.agentInfo.service.ServerListService;
import com.secuve.agentInfo.vo.ServerList;

@Component
public class ServerListSchedule  extends QuartzJobBean {
	@Autowired ServerListService serverListService;
	
	@Override
	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		List<ServerList> list = serverListService.getServerListAll();
		
		String[] columnList = {"서버 타입", "구분", "IP", "상태"};
		
		//1차로 workbook을 생성 
		HSSFWorkbook workbook=new HSSFWorkbook();

		//2차는 sheet생성 
		HSSFSheet sheet=workbook.createSheet("서버 목록");

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
		    for(ServerList serverList : list){
		    	row=sheet.createRow(i);
	        	i++;
		        if(columnList !=null &&columnList.length >0){
			        cell=row.createCell(0);
			        cell.setCellValue((translation(serverList.getServerListType())));
			        cell=row.createCell(1);
			        cell.setCellValue((serverList.getServerListDivision()));
			        cell=row.createCell(2);
			        cell.setCellValue((serverList.getServerListIp()));
			        cell=row.createCell(3);
			        cell.setCellValue((serverList.getServerListState()));
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
				fileoutputstream = new FileOutputStream("D:/ServerListBackUp/serverList-"+nowDate+".csv");
			} else {
				fileoutputstream = new FileOutputStream("C:/AgentInfo/ServerListBackUP/serverList-"+nowDate+".csv");
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
	
	public String translation(String serverListType) {
		if(serverListType.equals("externalEquipment")) {
			return "외부망";
		} else if(serverListType.equals("internalEquipment")) {
			return "내부망";
		} else {
			return "Hyper-V";
		}
	}
}
