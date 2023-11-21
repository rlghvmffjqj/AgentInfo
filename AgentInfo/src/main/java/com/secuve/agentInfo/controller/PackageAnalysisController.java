package com.secuve.agentInfo.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StreamUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.github.difflib.DiffUtils;
import com.github.difflib.patch.Patch;
import com.github.difflib.text.DiffRow;
import com.github.difflib.text.DiffRowGenerator;
import com.secuve.agentInfo.service.PackageAnalysisService;

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
            @RequestParam("file1") MultipartFile file1,
            @RequestParam("file2") MultipartFile file2) {
		List<String> list = new ArrayList<String>();
        try {
            // 임시 디렉토리에 업로드된 파일 저장
            File uploadedFile1 = packageAnalysisService.saveUploadedFile(file1, "C:\\AgentInfo\\packageAnalysis\\before");
            File uploadedFile2 = packageAnalysisService.saveUploadedFile(file2, "C:\\AgentInfo\\packageAnalysis\\after");

         // 파일 크기가 다른 파일명 조회
            List<String> differentFiles = packageAnalysisService.compareFileSizes(uploadedFile1, uploadedFile2);

            if (differentFiles.isEmpty()) {
            	list.add("크기가 다른 파일이 없습니다.");
                return list;
            } else {
                return differentFiles;
            }

        } catch (IOException e) {
        	list.add("크기가 다른 파일이 없습니다.");
            return list;
        }
	}
	
    @PostMapping(value = "/packageAnalysis/changContentView")
    public String ChangContentView(Model model, String file1, String file2, String fileRute) {
        String fileFullRute1 = "C:\\AgentInfo\\packageAnalysis\\before\\" + file1 + "Folder\\" + fileRute;
        String fileFullRute2 = "C:\\AgentInfo\\packageAnalysis\\after\\" + file2 + "Folder\\" + fileRute;

        List<String> lines1 = new ArrayList<String>();
        List<String> lines2 = new ArrayList<String>();

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

            DiffRowGenerator generator = DiffRowGenerator.create()
                    .showInlineDiffs(true)
                    .inlineDiffByWord(true)
                    .ignoreWhiteSpaces(true)
                    .build();

            Patch<String> patch = DiffUtils.diff(lines1, lines2);
            List<DiffRow> diffRows = generator.generateDiffRows(lines1, lines2);

            // 파일이 누락된 경우 추가 또는 삭제된 라인을 나타내는 정보 추가
            List<DiffRow> modifiedDiffRows = new ArrayList<>();
            for (DiffRow row : diffRows) {
                if (row.getTag() == DiffRow.Tag.DELETE) {
                    modifiedDiffRows.add(new DiffRow(DiffRow.Tag.DELETE, row.getOldLine(), ""));
                } else if (row.getTag() == DiffRow.Tag.INSERT) {
                    modifiedDiffRows.add(new DiffRow(DiffRow.Tag.INSERT, "", row.getNewLine()));
                } else {
                    modifiedDiffRows.add(row);
                }
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
