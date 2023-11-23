package com.secuve.agentInfo.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.github.difflib.text.DiffRow;
import com.github.difflib.text.DiffRowGenerator;
import com.secuve.agentInfo.service.PackageAnalysisService;
import com.secuve.agentInfo.vo.DiffInfo;

@Controller
public class PackageAnalysisController {
	@Autowired PackageAnalysisService packageAnalysisService;
	
	@GetMapping(value = "/packageAnalysis/upload")
	public String upload(Model model) {
		return "/packageAnalysis/Upload";
	}
	
	@ResponseBody
	@PostMapping("/packageAnalysis/analysis")
    public List<String> compareFiles(
    		@RequestParam(value = "file1", required = true) MultipartFile file1,
            @RequestParam(value = "file2", required = true) MultipartFile file2,
            @RequestParam(value = "file3", required = false) MultipartFile file3,
            @RequestParam(value = "file4", required = false) MultipartFile file4) {
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
	
    @PostMapping(value = "/packageAnalysis/changContentView")
    public String ChangContentView(@RequestParam(value = "file1", required = true) String file1,
            @RequestParam(value = "file2", required = true) String file2,
            @RequestParam(value = "file3", required = true) String file3,
            @RequestParam(value = "file4", required = true) String file4, Model model, String fileRute) {
        String fileFullRute1 = "C:\\AgentInfo\\packageAnalysis\\existing\\" + file1 + "Folder\\" + fileRute;
        String fileFullRute2 = "C:\\AgentInfo\\packageAnalysis\\package1\\" + file2 + "Folder\\" + fileRute;
        String fileFullRute3 = "C:\\AgentInfo\\packageAnalysis\\package2\\" + file3 + "Folder\\" + fileRute;
        String fileFullRute4 = "C:\\AgentInfo\\packageAnalysis\\package3\\" + file4 + "Folder\\" + fileRute;

        List<String> lines1 = new ArrayList<String>();
        List<String> lines2 = new ArrayList<String>();
        List<String> lines3 = new ArrayList<String>();
        List<String> lines4 = new ArrayList<String>();

        try {
            try {
                lines1 = Files.readAllLines(new File(fileFullRute1).toPath());
            } catch (Exception e) {
                lines1.add("");
            }
            try {
                lines2 = Files.readAllLines(new File(fileFullRute2).toPath());
            } catch (Exception e) {
                lines2.add("");
            }
            try {
                lines3 = Files.readAllLines(new File(fileFullRute3).toPath());
            } catch (Exception e) {
                lines3.add("");
            }
            try {
                lines4 = Files.readAllLines(new File(fileFullRute4).toPath());
            } catch (Exception e) {
                lines4.add("");
            }

            DiffRowGenerator generator = DiffRowGenerator.create()
                    .showInlineDiffs(true)
                    .inlineDiffByWord(true)
                    .ignoreWhiteSpaces(true)
                    .build();

            //Patch<String> patch = DiffUtils.diff(lines1, lines2);
            List<DiffRow> diffRows1 = generator.generateDiffRows(lines1, lines2);
            List<DiffRow> diffRows2 = generator.generateDiffRows(lines1, lines3);
            List<DiffRow> diffRows3 = generator.generateDiffRows(lines1, lines4);

            List<DiffInfo> modifiedDiffRows = new ArrayList<>();

            DiffInfo diffInfo;
	         for (int i = 0; i < Math.max(diffRows1.size(), Math.max(diffRows2.size(), diffRows3.size())); i++) {
	        	 diffInfo = new DiffInfo();
	             if (i < diffRows1.size()) {
	                 DiffRow row1 = diffRows1.get(i);
	                 if (row1.getTag() == DiffRow.Tag.DELETE) {
	                	 DiffRow diff = new DiffRow(DiffRow.Tag.DELETE, row1.getOldLine(), "");
	                     diffInfo.setTag1(diff.getTag());
	                     diffInfo.setOldLine1(diff.getOldLine());
	                     diffInfo.setNewLine1(diff.getNewLine());
	                 } else if (row1.getTag() == DiffRow.Tag.INSERT) {
	                	 DiffRow diff = new DiffRow(DiffRow.Tag.INSERT, "", row1.getNewLine());
	                	 diffInfo.setTag1(diff.getTag());
	                     diffInfo.setOldLine1(diff.getOldLine());
	                     diffInfo.setNewLine1(diff.getNewLine());
	                 } else {
	                	 DiffRow diff = row1;
	                	 diffInfo.setTag1(diff.getTag());
	                     diffInfo.setOldLine1(diff.getOldLine());
	                     diffInfo.setNewLine1(diff.getNewLine());
	                 }
	             }
	
	             if (i < diffRows2.size()) {
	                 DiffRow row2 = diffRows2.get(i);
	                 if (row2.getTag() == DiffRow.Tag.DELETE) {
	                	 DiffRow diff = new DiffRow(DiffRow.Tag.DELETE, row2.getOldLine(), "");
	                	 diffInfo.setTag2(diff.getTag());
	                	 diffInfo.setOldLine2(diff.getOldLine());
	                     diffInfo.setNewLine2(diff.getNewLine());
	                 } else if (row2.getTag() == DiffRow.Tag.INSERT) {
	                	 DiffRow diff = new DiffRow(DiffRow.Tag.INSERT, "", row2.getNewLine());
	                	 diffInfo.setTag2(diff.getTag());
	                	 diffInfo.setOldLine2(diff.getOldLine());
	                     diffInfo.setNewLine2(diff.getNewLine());
	                 } else {
	                	 DiffRow diff = row2;
	                	 diffInfo.setTag2(diff.getTag());
	                	 diffInfo.setOldLine2(diff.getOldLine());
	                     diffInfo.setNewLine2(diff.getNewLine());
	                 }
	             }
	
	             if (i < diffRows3.size()) {
	                 DiffRow row3 = diffRows3.get(i);
	                 if (row3.getTag() == DiffRow.Tag.DELETE) {
	                	 DiffRow diff = new DiffRow(DiffRow.Tag.DELETE, row3.getOldLine(), "");
	                	 diffInfo.setTag3(diff.getTag());
	                	 diffInfo.setOldLine3(diff.getOldLine());
	                     diffInfo.setNewLine3(diff.getNewLine());
	                 } else if (row3.getTag() == DiffRow.Tag.INSERT) {
	                	 DiffRow diff = new DiffRow(DiffRow.Tag.INSERT, "", row3.getNewLine());
	                	 diffInfo.setTag3(diff.getTag());
	                	 diffInfo.setOldLine3(diff.getOldLine());
	                     diffInfo.setNewLine3(diff.getNewLine());
	                 } else {
	                	 DiffRow diff = row3;
	                	 diffInfo.setTag3(diff.getTag());
	                	 diffInfo.setOldLine3(diff.getOldLine());
	                     diffInfo.setNewLine3(diff.getNewLine());
	                 }
	             }
	             modifiedDiffRows.add(diffInfo);
	         }

            model.addAttribute("diffRows", modifiedDiffRows);
            model.addAttribute("fileRute",fileRute);

            // 이제 modifiedDiffRows를 JSP에 전달하고, JSP에서 변경된 부분을 표시
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/packageAnalysis/ChangContentView";
    }
    
}
