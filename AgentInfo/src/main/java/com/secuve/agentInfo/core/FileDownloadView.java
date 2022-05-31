package com.secuve.agentInfo.core;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

@Component
public class FileDownloadView extends AbstractView {
	
	/**
	 * 파일 다운로드
	 * 파일 경로, 파일 이름, 다운로드 받을 파일 명 Model로 전달 받음
	 * 중요) AbstractView 상속
	 */
	@Override
	protected void renderMergedOutputModel(Map<String, Object> fileMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String fileUploadPath = (String) fileMap.get("fileUploadPath");
		String filePhysicalName = (String) fileMap.get("filePhysicalName");
		String fileLogicalName = (String) fileMap.get("fileLogicalName");

		File file = new File(fileUploadPath + filePhysicalName);

		String userAgent = request.getHeader("User-Agent");
		int contentLength = (int) file.length();

		boolean ie = userAgent.indexOf("MSIE") > -1;

		if (ie == true) {
			fileLogicalName = URLEncoder.encode(fileLogicalName, "UTF-8");
		} else {
			fileLogicalName = new String(fileLogicalName.getBytes("UTF-8"), "ISO-8859-1");
		}

		response.setContentType(response.getContentType());
		response.setContentLength(contentLength);
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileLogicalName + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");

		OutputStream out = response.getOutputStream();
		FileInputStream fis = null;

		try {
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
			out.flush();
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (IOException ioe) {
				}
			}
			if (out != null) {
				try {
					out.close();
				} catch (IOException ioe) {
				}
			}
		}
	}
}