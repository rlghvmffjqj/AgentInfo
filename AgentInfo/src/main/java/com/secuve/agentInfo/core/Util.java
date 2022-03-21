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

//import com.secuve.tosms.base.core.CApplicationContextHolder;

// �������
// - �Ϻ��� ��� ȯ�濡���� CSV ���� ���� �ٿ�ε� �� �� encoding �߰� (ja ==> MS932)

public class Util {


	// ����2003   65536
	// ����2007 1048576
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

//	public static ModelAndView createResultView(String output, String url, HttpServletRequest request) {
//		boolean flag = false;
//
//		Scanner sc = new Scanner(output);
//		String line;
//
//		while (sc.hasNextLine()) {
//			line = sc.nextLine();
//			if (line.length() == 0 || line.startsWith("#"))
//				continue; // SKIP
//
//			if (line.startsWith("OK"))
//				flag = true;
//			else
//				flag = false;
//		}
//
//		ModelAndView view = new ModelAndView();
//		view.setViewName("Common/ScriptResult");
//
//		// TODO: output �� ������� ��
//		if (flag)
//			view.addObject("result", Util.getMessage(request, "result.success"));
//		else
//			view.addObject("result", Util.getMessage(request, "result.fail"));
//
//		view.addObject("url", url);
//
//		return view;
//	}

//	public static String createResultViewMsg(String msg, String url, Model model, HttpServletRequest request) {
//		model.addAttribute("result", Util.getMessage(request, msg));
//		model.addAttribute("url", url);
//
//		return "Common/ScriptResult";
//	}

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

	// �׸��� �����͸� CSV ���Ϸ� ���
	//
	// �׸����� ��ü �÷� �߿��� columns �� ���Ե� �÷��� ���Ϸ� ���
	// �÷����� �ѱ۷� ����ϱ� ���ؼ� �� �÷��� �´� �ѱ� ����� headers ����
//	public static void exportCsv(HttpServletResponse response, String filename, List<Map<String, Object>> list, String[] columns, String[] headers) throws Exception {
//		if ( list.size() > MAX_EXPORT_ROWS ) {
//			System.out.println("Max number of rows exceeded. ["+MAX_EXPORT_ROWS+"]");
//			return;
//		}
//		
//		String encoding = getDefaultFileEncoding();
//
//		File file = File.createTempFile("~export-", ".csv");
//		System.out.println("### createFile: " + file.getPath());
//		try {
//			// ������� ��ü ����Ʈ�� �ӽ� ���Ϸ� ����
//			// /sw/tomcat/temp/~export-xxxxxxxxxxx.csv
//			// d:\tomcat\temp\~export-xxxxxxxxxxx.csv
//			writeCsvFileFromMap(file.getPath(), encoding, list, columns, headers);
//			
//			// �ϼ��� �ӽ� ������ ����ڿ��� �ٿ�ε�
//			downloadFile(response, file.getPath(), filename);
//			
//		} catch (Exception e) {
//			System.out.println(e);
//			
//		} finally {
//			// �ӽ����� ���� �Ϸ� �� ����
//			System.out.println("### deleteFile: " + file.getPath());
//			file.delete();
//		}
//	}

	// ����Ʈ�� Map �� �ƴ϶� Bean ��ü�� ��� ���
//	public static void exportCsvFromObject(HttpServletResponse response, String filename, List<Object> list, String[] columns, String[] headers) throws Exception {
//		if ( list.size() > MAX_EXPORT_ROWS ) {
//			System.out.println("Max number of rows exceeded. ["+MAX_EXPORT_ROWS+"]");
//			return;
//		}
//		
//		String encoding = getDefaultFileEncoding();
//		
//		File file = File.createTempFile("~export-", ".csv");
//		System.out.println("### createFile: " + file.getPath());
//		try {
//			writeCsvFileFromObject(file.getPath(), encoding, list, columns, headers);
//			downloadFile(response, file.getPath(), filename);
//		} finally {
//			file.delete();
//			System.out.println("### deleteFile: " + file.getPath());
//		}
//	}
	
	// ����Ʈ�� Map �� �ƴ϶� Bean ��ü�� ��� ���
	public static void exportExcelFile(HttpServletResponse response, String filename, List<Object> list, String[] columns, String[] headers) throws Exception {
		// ��������(.xls) �� ���ڵ� ������ �ʿ����.
		
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

//	private static boolean writeCsvFileFromMap(String filepath, String encoding, List<Map<String, Object>> list, String[] columns, String[] headers) {
//		BufferedWriter fout = null;
//		
//		try {
//			fout = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filepath), encoding));
//			fout.write(Str.toCSV(headers));
//			fout.write("\r\n");
//	
//			String[] values = new String[columns.length];
//			String key, value;
//			for (Map<String, Object> item : list) 
//			{
//				for (int i = 0; i < columns.length; i++) 
//				{
//					key = columns[i];
//					if (item.containsKey(key)) {
//						value = item.get(key).toString();
//					} else {
//						value = "";
//					}
//	
//					values[i] = value;
//				}
//	
//				fout.write(Str.toCSV(values));
//				fout.write("\r\n");
//			}
//			
//			return true;
//			
//		} catch (Exception e) {
//			System.out.println(e);
//		} finally {
//			IOUtils.closeQuietly(fout);
//		}
//		
//		return false;
//	}
	
	// ����Ʈ�� Map �� �ƴ϶� Bean ��ü�� ��� ���
//	private static boolean writeCsvFileFromObject(String filepath, String encoding, List<Object> list, String[] columns, String[] headers) {
//		BufferedWriter fout = null;
//		
//		try {
//			fout = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filepath), encoding));
//			
//			fout.write(Str.toCSV(headers));
//			fout.write("\r\n");
//	
//			String[] values = new String[columns.length];
//			String key, value;
//			for (Object bean : list) 
//			{
//				for (int i = 0; i < columns.length; i++) 
//				{
//					key = columns[i];
//					try {
//						value = BeanUtils.getSimpleProperty(bean, key);
//					} catch (Exception e) {
//						value = "";
//					}
//
//					values[i] = value;
//				}
//	
//				fout.write(Str.toCSV(values));
//				fout.write("\r\n");
//			}
//			
//			return true;
//			
//		} catch (Exception e) {
//			System.out.println(e);
//		} finally {
//			IOUtils.closeQuietly(fout);
//		}
//		
//		return false;
//	}

	private static boolean writeExcelFileFromObject(String filepath, List<Object> list, String[] columns, String[] headers) {

		HSSFWorkbook wb = new HSSFWorkbook();
		Sheet sheet1 = wb.createSheet("sheet1");

		// �� ���� ��������
		Row row = null;
		Cell cell = null;

		// ��� ����
		row = sheet1.createRow(0);
		for (int i=0; i < headers.length; i++)
		{
			String header = headers[i];

			cell = row.createCell(i);
			cell.setCellValue(header);
		}

		// ���� ����
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

		// ��ü ������ �ε� �� �� �÷��� ���� ũ�⿡ �°� �� ����
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
	
	// ����� ���� ���ڵ� ����
	// ����ڰ� ������ ��� ������ ���� �����Ѵ�. (cookies['lang'])
//	public static String getDefaultFileEncoding() {
//		String lang = getCookie("lang", "ko");
//		
//		String encoding = "";
//
//		if ( lang.startsWith("ko") ) {
//			encoding = "MS949";
//		} else if ( lang.startsWith("ja") ) {
//			encoding = "MS932";
//		} else {
//			encoding = "UTF-8";
//		}
//		System.out.println("### defaultFileEncoding: lang="+lang+", encoding="+encoding);
//		return encoding;
//	}
	

	// Spring Application Context ��������
	//
	// RequestContextHolder �� �̿��ؼ� request ��ü�� ������� �ʰ� Spring Containter �� beans ��ü ��������
	// ���� autowired �� ������� �ʰ� ���� �ҽ����� Spring Containter �� ������ �� ���
	//
	// �α��� �� ���¶�� RequestContextHolder ���� request �� �̿��ؼ� WebApplicationContext �� ����
	// �α��� ���� ���� ���� (��: �����ٷ� ����)�� ��� �ʱ� CApplicationContextHolder �� ���ؼ� ����
//	public static ApplicationContext getApplicationContext() {
//		ServletRequestAttributes attrs = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
//		if (attrs != null) {
//			HttpServletRequest request = attrs.getRequest();
//			HttpSession session = request.getSession();
//			ServletContext sc = session.getServletContext();
//			return WebApplicationContextUtils.getWebApplicationContext(sc);
//		} else {
//			return CApplicationContextHolder.getApplicationContext();
//		}
//	}

	// ����ڰ� ������ ����(���̳ʸ� ������)�� ���Ϸ� ����
	public static boolean saveFile(String filepath, byte[] bytes) {
		try {
			FileUtils.writeByteArrayToFile(new File(filepath), bytes);
			return true;

		} catch (IOException e) {
			System.out.println(e);
			return false;
		}
	}
	
	// 20140401 ���� �ٿ�ε� �ҽ� ����
	// ���̳ʸ��� �ؽ�Ʈ���� �������� ����ϴ� �ҽ�
	// ���� ������ �״�� �ٿ�ε� �Ǳ� ������ �ؽ�Ʈ ������ ������ �ؽ�Ʈ ���ڵ��� ����.
	//
	// 20150423 Content-Length �� ����
	// ����� Content-Length �� �������� ������ Transfer-Encoding: chunked �� ���۵� ���ɼ��� �ְ�
	// �̶� ������ ���ڿ� ���ڵ��� ���� �� �ִ�.
	//
	// 20150810 Content-Disposition: filename �� �ѱ��� ���Ե� ��� �������� ���� �ٸ��� ó���������.
	//
	public static boolean downloadFile(
			HttpServletResponse response, 
			String localFilePath, 
			String remoteFileName) {

		ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpServletRequest request = attr.getRequest();
		
		// Content-Disposition: ����� filename UTF-8 ���ڵ� ���
		// http://egloos.zum.com/aretias/v/702775
		// http://stackoverflow.com/questions/93551/how-to-encode-the-filename-parameter-of-content-disposition-header-in-http
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
			// Internet Explorer (IE 11 �������� User-Agent ������� MSIE ��� ���ڿ��� ��������) 
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
			
			// 20130305 Spring Framework �� FileCopyUtils.copy �� �ҽ� ����
			// [����] apache commons IOUtils.copy �� ����ϸ� 0 byte ������ �����ȴ�??
			org.springframework.util.FileCopyUtils.copy(fin, fout);
			
			return true;

		} catch (IOException e) {
			System.out.println(e);
		}

		// FileCopyUtils.copy() �ҽ����ο� out.flush(); finally {in.close(), out.close();} ��� ó���Ǿ� �ִ�.
		return false;
	}
	
	// �Է�: virtaulPath �� "/" �� ����. (���н� ���ϰ�� ��Ģ)
	// ���: ���丮 ���� "/" �Ǵ� "\" �� �����ؼ� ����
	//
	// Tomcat 7.0
	// virtualPath: "files/patch"
	// realPath(Windows): "D:\Tomcat\webapps\TOSMS\files\patch"
	// realPath(Unix): "/home/sw/apache-tomcat-7.0.30/webapps/TOSMS/files/patch"
	//
	// Tomcat 8.0
	// virtualPath: "/files/patch"
	// realPath(Windows): "D:\Tomcat\webapps\TOSMS\files\patch\"
	// realPath(Unix): "/home/sw/apache-tomcat-8.0.21/webapps/TOSMS/files/patch/"
	//
//	public static String getRealPath(HttpServletRequest request, String virtualPath) {
//
//		assert(virtualPath.startsWith("/"));
//		
//		String realPath = request.getSession().getServletContext().getRealPath(virtualPath);
//		
//		// Tomcat 8.0 ����� realPath ���� ������ "/" �� ���� 
//		if ( realPath.endsWith(SystemUtils.FILE_SEPARATOR) ) {
//			realPath = StringUtils.chomp(realPath, SystemUtils.FILE_SEPARATOR);
//		}
//		
//		return realPath;
//	}


	public static String[] getNumberList(int from, int to) {
		String[] arrStr = new String[to - from + 1];

		for (int i = from; i <= to; i++) {
			arrStr[i] = String.format("%02d", i);
		}

		return arrStr;
	}

	// Spring resource messages ���� ������ ID �� ���ڿ� ��ȸ
//	public static String getMessage(HttpServletRequest request, String id)
//	{
//		Cookie c = WebUtils.getCookie(request, "lang");
//		String lang;
//		if ( c != null ) {
//			lang = c.getValue();
//		} else {
//			lang = "en";
//		}
//
//		Locale locale = new Locale(lang);
//		
//		try {
//			WebApplicationContext context = RequestContextUtils.getWebApplicationContext(request);
//			return context.getMessage(id, null, locale);
//		} catch (Exception e) {
//			System.out.println("Resource not found. "+ id + " " + e);
//		}
//		
//		return id;
//	}

//	public static String getMessage(int errorCode)
//	{
//		String strErrorCode = String.format("0x%08X", errorCode);
//		return getMessage(strErrorCode);
//	}
//	
//	// Spring resource messages ���� ������ ID �� ���ڿ� ��ȸ (request ��ü�� �������)
//	public static String getMessage(String id)
//	{
//		// ���� request ���� cookie ���� �������ų�
//		// ������ �������� ������ �⺻������ "en"
//		String lang = getCookie("lang", "en");
//		Locale locale = new Locale(lang);
//
//		try {
//			ApplicationContext context = getApplicationContext();
//			return context.getMessage(id, null, locale);
//		} catch (Exception e) {
//			System.out.println("Resource not found. "+ id + " " + e);
//		}
//		
//		return "["+id+"]";
//	}

	// WebApplication �� �������� �ý����� ȣ��Ʈ�� ��ȸ
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




