package com.secuve.agentInfo.core;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.util.List;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
//import org.apache.commons.lang.StringUtils;
//import org.apache.commons.lang.SystemUtils;
//import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.springframework.ui.Model;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

public class Util {

	public static final int MAX_EXPORT_ROWS = 65535;

	public static ModelAndView createResultView(String output, String url) {
		boolean flag = false;

		Scanner sc = new Scanner(output);
		String line;

		while (sc.hasNextLine()) {
			line = sc.nextLine();
			if (line.length() == 0 || line.startsWith("#"))
				continue; // SKIP

			if (line.startsWith("OK"))
				flag = true;
			else
				flag = false;
		}

		ModelAndView view = new ModelAndView();
		view.setViewName("Common/ScriptResult");

		if (flag)
			view.addObject("result", "OK");
		else {
			view.addObject("result", "FAIL");
			view.addObject("output", "\\r\\n" + JavascriptEscape(output));
		}
		view.addObject("url", url);

		return view;
	}

	public static String createConfirmView(String yesUrl, String noUrl, Model model) {
		model.addAttribute("yesUrl", yesUrl);
		model.addAttribute("noUrl", noUrl);
		return "Common/ScriptResult2";
	}

	public static String JavascriptEscape(String str) {
		str = str.replace("'", "\\'");
		str = str.replace(";", "\\;");
		str = str.replace(System.getProperty("line.separator"), "\\r\\n");

		return str;
	}

	public static void exportExcelFile(HttpServletResponse response, String filename, List<Object> list, String[] columns, String[] headers) throws Exception {
		if ( list.size() > MAX_EXPORT_ROWS ) {
			System.out.println("Max number of rows exceeded. ["+MAX_EXPORT_ROWS+"]");
			return;
		}
		
		File file = File.createTempFile("~export-", ".xls");
		System.out.println("### createFile: " + file.getPath());
		try {
			writeExcelFileFromObject(file.getPath(), list, columns, headers);
			downloadFile(response, file.getPath(), filename);
		} finally {
			file.delete();
			System.out.println("### deleteFile: " + file.getPath());
		}
	}

	private static boolean writeExcelFileFromObject(String filepath, List<Object> list, String[] columns, String[] headers) {
		HSSFWorkbook wb = new HSSFWorkbook();
		Sheet sheet1 = wb.createSheet("sheet1");

		Row row = null;
		Cell cell = null;

		row = sheet1.createRow(0);
		for (int i=0; i < headers.length; i++)
		{
			String header = headers[i];

			cell = row.createCell(i);
			cell.setCellValue(header);
		}

		String key, value;
		for (int j=0; j < list.size(); j++)
		{
			Object bean = list.get(j);

			row = sheet1.createRow(j+1);
			for (int i = 0; i < columns.length; i++)
			{
				key = columns[i];

				try {
					value = BeanUtils.getSimpleProperty(bean, key);
				} catch (Exception e) {
					value = "";
				}

				cell = row.createCell(i);
				cell.setCellValue(value);
			}
		}

		for (int i=0; i < headers.length; i++)
		{
			sheet1.autoSizeColumn(i);
		}

		BufferedOutputStream fout = null;
		try {
			fout = new BufferedOutputStream(new FileOutputStream(filepath));
			
			wb.write(fout);
			
			return true;
			
		} catch (IOException e) {
			System.out.println(e);
		} finally {
			IOUtils.closeQuietly(fout);
		}
		
		return false;
	}

	public static String getCookie(String name, String defaultValue) {
		ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpServletRequest request = attr.getRequest();
		
		Cookie cookie = WebUtils.getCookie(request, name);
		if ( cookie != null ) {
			return cookie.getValue();
		}
		
		return defaultValue;
	}
	
	public static boolean saveFile(String filepath, byte[] bytes) {
		try {
			FileUtils.writeByteArrayToFile(new File(filepath), bytes);
			return true;

		} catch (IOException e) {
			System.out.println(e);
			return false;
		}
	}
	
	public static boolean downloadFile(
			HttpServletResponse response, 
			String localFilePath, 
			String remoteFileName) {

		ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpServletRequest request = attr.getRequest();
		
		String encodeFileName = "";

		try {
			String userAgent = request.getHeader("User-Agent");
			// Chrome
			if ( userAgent.contains("Chrome")) {
				encodeFileName = new String(remoteFileName.getBytes("UTF-8"), "ISO-8859-1");
			} 
			// Firefox
			else if ( userAgent.contains("Firefox") ) {
				encodeFileName = new String(remoteFileName.getBytes("UTF-8"), "ISO-8859-1");
			}
			else {
				encodeFileName = URLEncoder.encode(remoteFileName, "UTF-8");
				encodeFileName = encodeFileName.replaceAll("\\+", "%20");
			} 
		} catch (UnsupportedEncodingException e) {
		}

		
		File file = new File(localFilePath);
		if ( file.exists() == false ) {
			System.out.println("File not found. " + localFilePath);
			return false;
		}
		
		response.setContentType("application/octet-stream");
		response.setContentLength((int)file.length());
		response.setHeader("Content-Disposition", "attachment; filename=\"" + encodeFileName + "\";");

		BufferedInputStream fin = null;
		OutputStream fout = null;
		try {
			fin = new BufferedInputStream(new FileInputStream(localFilePath));
			fout = response.getOutputStream();
			
			org.springframework.util.FileCopyUtils.copy(fin, fout);
			
			return true;

		} catch (IOException e) {
			System.out.println(e);
		}

		return false;
	}


	public static String[] getNumberList(int from, int to) {
		String[] arrStr = new String[to - from + 1];

		for (int i = from; i <= to; i++) {
			arrStr[i] = String.format("%02d", i);
		}

		return arrStr;
	}

	public static String getHostname() {
		String hostname = "";

		try {
			hostname = InetAddress.getLocalHost().getHostName();
		} catch (UnknownHostException e) {
			hostname = e.getMessage(); // host = "hostname: hostname"
			if ( hostname != null ) {
				int colon = hostname.indexOf(':');
				if ( colon>0 ) {
					return hostname.substring(0, colon); // Dangerous, this is JVM dependant code.
				}
			}

			e.printStackTrace();
		}

		return hostname;
	}

	// Exception Stack Trace �� ���ڿ��� ��ȯ�ϱ�
	public static String getStackTraceString(StackTraceElement[] arrElement)
	{
		String stackTraceString = "";
		for (StackTraceElement element: arrElement){
			stackTraceString += element.toString() + "\n";
		}
		return stackTraceString;

	}
	
	public static boolean xssFindToString(String str) {
		boolean ret = false;
		Pattern pattern = Pattern.compile(getXssFromat());
		Matcher matcher = pattern.matcher(str);
		
		if(matcher.find()) {
			ret = true;
		}
		
		return ret;
	}
	
	private static String getXssFromat() {
		return "<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>";
	}
}