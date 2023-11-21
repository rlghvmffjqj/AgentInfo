package com.secuve.agentInfo.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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
            File uploadedFile1 = saveUploadedFile(file1, "C:\\AgentInfo\\packageAnalysis\\before");
            File uploadedFile2 = saveUploadedFile(file2, "C:\\AgentInfo\\packageAnalysis\\after");

         // 파일 크기가 다른 파일명 조회
            List<String> differentFiles = compareFileSizes(uploadedFile1, uploadedFile2);

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
	
	private File saveUploadedFile(MultipartFile file, String tempDir) throws IOException {
        String originalFileName = file.getOriginalFilename();
        File destFile = new File(tempDir + File.separator + originalFileName);
        file.transferTo(destFile);
        extractAndSaveFile(destFile, tempDir);
        return destFile;
    }

    private List<String> compareFileSizes(File file1, File file2) throws IOException {
        List<String> differentFiles = new ArrayList<>();

        Map<String, Long> fileSizes1 = getFileSizes(file1);
        Map<String, Long> fileSizes2 = getFileSizes(file2);
        
        for (String fileName : fileSizes2.keySet()) {
            if (fileSizes1.containsKey(fileName)) {
                long size1 = fileSizes1.get(fileName);
                long size2 = fileSizes2.get(fileName);

                if (size1 != size2) {
                    differentFiles.add(fileName);
                }
            } else {
            	differentFiles.add(fileName);
            }
        }
        
        for (String fileName : fileSizes1.keySet()) {
            if (!fileSizes2.containsKey(fileName)) {
            	differentFiles.add(fileName);
            }
        }

        return differentFiles;
    }

    private Map<String, Long> getFileSizes(File warFile) throws IOException {
        Map<String, Long> fileSizes = new HashMap<>();

        try (ZipInputStream zipInputStream = new ZipInputStream(new FileInputStream(warFile))) {
            ZipEntry entry;
            byte[] buffer = new byte[1024];
            
            while ((entry = zipInputStream.getNextEntry()) != null) {
                if (!entry.isDirectory()) {
                    if (entry.getSize() == -1) {
                        // Size is unknown, decompress to calculate size
                        ByteArrayOutputStream baos = new ByteArrayOutputStream();
                        int len;
                        while ((len = zipInputStream.read(buffer)) > 0) {
                            baos.write(buffer, 0, len);
                        }
                        fileSizes.put(entry.getName(), (long) baos.size());
                    } else {
                        // Size is known, use it directly
                        fileSizes.put(entry.getName(), entry.getSize());
                    }
                }
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        return fileSizes;
    }
    
    public void extractAndSaveFile(File  file, String tempDir) throws IOException {
    	try (ZipInputStream zipInputStream = new ZipInputStream(Files.newInputStream(file.toPath()))) {
            String route = tempDir + File.separator + file.getName() + "Folder";
            Path path = Paths.get(route);
            try {
                // Use Files.createDirectories to create the directory and its parent directories if they don't exist
                Files.createDirectories(path);
            } catch (IOException e) {
                System.out.println(e);
            }

            ZipEntry entry;
            while ((entry = zipInputStream.getNextEntry()) != null) {
                String entryName = entry.getName();
                File entryFile = new File(tempDir + File.separator + file.getName() + "Folder", entryName);

                if (entry.isDirectory()) {
                    entryFile.mkdirs();
                } else {
                    // Check if the parent directory exists before creating the file
                    File parentDir = entryFile.getParentFile();
                    if (!parentDir.exists()) {
                        Files.createDirectories(parentDir.toPath());
                    }

                    try (FileOutputStream fos = new FileOutputStream(entryFile)) {
                        StreamUtils.copy(zipInputStream, fos);
                    } catch (Exception e) {
                        System.out.println(e);
                    }
                }

                zipInputStream.closeEntry();
            }
        } catch (Exception e) {
			System.out.println(e);
		}
    }
    
    @PostMapping(value = "/packageAnalysis/changContentView")
	public String ChangContentView(Model model, String file1, String file2, String fileRute) {
    	String fileFullRute1 = "C:\\AgentInfo\\packageAnalysis\\before\\"+file1+"Folder\\"+fileRute;
    	String fileFullRute2 = "C:\\AgentInfo\\packageAnalysis\\after\\"+file2+"Folder\\"+fileRute;
    	
    	try {
            List<String> lines1 = Files.readAllLines(new File(fileFullRute1).toPath());
            List<String> lines2 = Files.readAllLines(new File(fileFullRute2).toPath());

            DiffRowGenerator generator = DiffRowGenerator.create()
                    .showInlineDiffs(true)
                    .inlineDiffByWord(true)
                    .ignoreWhiteSpaces(true)
                    .build();

            Patch<String> patch = DiffUtils.diff(lines1, lines2);
            List<DiffRow> diffRows = generator.generateDiffRows(lines1, lines2);
            model.addAttribute("diffRows", diffRows);

            // 이제 diffRows를 JSP에 전달하고, JSP에서 변경된 부분을 표시
        } catch (IOException e) {
            e.printStackTrace();
        }
    	return "/packageAnalysis/ChangContentView";
    }
    
}
