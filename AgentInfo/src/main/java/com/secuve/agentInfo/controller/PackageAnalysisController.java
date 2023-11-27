package com.secuve.agentInfo.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.github.difflib.text.DiffRow;
import com.github.difflib.text.DiffRowGenerator;
import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.PackageAnalysisService;
import com.secuve.agentInfo.vo.DiffInfo;

@Controller
public class PackageAnalysisController {
	@Autowired PackageAnalysisService packageAnalysisService;
	@Autowired FavoritePageService favoritePageService;
	
	@GetMapping(value = "/packageAnalysis/packageAnalysisUpload")
	public String PackageAnalysisUpload(Model model) {
		return "/packageAnalysis/PackageAnalysisUpload";
	}
	
	@ResponseBody
	@PostMapping("/packageAnalysis/analysis")
    public List<String> compareFiles(
    		@RequestParam(value = "file1", required = true) MultipartFile file1,
            @RequestParam(value = "file2", required = true) MultipartFile file2,
            @RequestParam(value = "file3", required = false) MultipartFile file3,
            @RequestParam(value = "file4", required = false) MultipartFile file4, 
            Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "패키지 분석");
		
		List<String> list = new ArrayList<String>();
		List<String> differentFiles =  new ArrayList<String>();
        try {
            // 임시 디렉토리에 업로드된 파일 저장
            File uploadedFile1 = packageAnalysisService.saveUploadedFile(file1, "C:\\AgentInfo\\packageAnalysis\\existing");
            File uploadedFile2 = packageAnalysisService.saveUploadedFile(file2, "C:\\AgentInfo\\packageAnalysis\\package1");
            if (file3 != null) {
            	File uploadedFile3 = packageAnalysisService.saveUploadedFile(file3, "C:\\AgentInfo\\packageAnalysis\\package2");
            	differentFiles.addAll(packageAnalysisService.compareFileSizes(uploadedFile1, uploadedFile3));
            }
            if (file4 != null) {
            	File uploadedFile4 = packageAnalysisService.saveUploadedFile(file4, "C:\\AgentInfo\\packageAnalysis\\package3");
            	differentFiles.addAll(packageAnalysisService.compareFileSizes(uploadedFile1, uploadedFile4));
            }

         // 파일 크기가 다른 파일명 조회
            differentFiles.addAll(packageAnalysisService.compareFileSizes(uploadedFile1, uploadedFile2));
            
            List<String> uniqueList = packageAnalysisService.removeDuplicates(differentFiles);

            if (differentFiles.isEmpty()) {
            	list.add("크기가 다른 파일이 없습니다.");
                return list;
            } else {
                return uniqueList;
            }

        } catch (IOException e) {
        	list.add("크기가 다른 파일이 없습니다.");
            return list;
        }
	}
	
	@PostMapping(value = "/packageAnalysis/packageAnalysisResult")
	public String packageAnalysisResult(
	        @RequestParam(value = "file1", required = true) String file1,
	        @RequestParam(value = "file2", required = true) String file2,
	        @RequestParam(value = "file3", required = true) String file3,
	        @RequestParam(value = "file4", required = true) String file4,
	        Model model,
	        @RequestParam(value = "fileRute") String fileRute) {

	    List<String> lines1 = packageAnalysisService.readLines(packageAnalysisService.buildFilePath("existing", file1, fileRute));
	    List<String> lines2 = packageAnalysisService.readLines(packageAnalysisService.buildFilePath("package1", file2, fileRute));
	    List<String> lines3 = packageAnalysisService.readLines(packageAnalysisService.buildFilePath("package2", file3, fileRute));
	    List<String> lines4 = packageAnalysisService.readLines(packageAnalysisService.buildFilePath("package3", file4, fileRute));

	    DiffRowGenerator generator = DiffRowGenerator.create()
	            .showInlineDiffs(true)
	            .inlineDiffByWord(true)
	            .ignoreWhiteSpaces(true)
	            .build();

	    List<DiffRow> diffRows1 = generator.generateDiffRows(lines1, lines2);
	    List<DiffRow> diffRows2 = generator.generateDiffRows(lines1, lines3);
	    List<DiffRow> diffRows3 = generator.generateDiffRows(lines1, lines4);

	    List<DiffInfo> modifiedDiffRows = packageAnalysisService.createModifiedDiffRows(diffRows1, diffRows2, diffRows3);

	    model.addAttribute("diffRows", modifiedDiffRows);
	    model.addAttribute("fileRute", fileRute);

	    return "/packageAnalysis/PackageAnalysisResult";
	}
    
    @Async
	@Scheduled(cron="0 0 1 * * ?")
	public void cronScheduler() throws IOException {
    	packageAnalysisService.fileFolderDelete("C:\\AgentInfo\\packageAnalysis\\existing","existing");
    	packageAnalysisService.fileFolderDelete("C:\\AgentInfo\\packageAnalysis\\package1","package1");
    	packageAnalysisService.fileFolderDelete("C:\\AgentInfo\\packageAnalysis\\package2","package2");
    	packageAnalysisService.fileFolderDelete("C:\\AgentInfo\\packageAnalysis\\package3","package3");
    }
    
}
