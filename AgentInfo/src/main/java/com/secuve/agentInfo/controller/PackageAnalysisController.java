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

        Map<String, String> fileSizes1 = getFileSizes(file1);
        Map<String, String> fileSizes2 = getFileSizes(file2);
        
        for (String fileName : fileSizes2.keySet()) {
            if (fileSizes1.containsKey(fileName)) {
                String size1 = fileSizes1.get(fileName);
                String size2 = fileSizes2.get(fileName);

                if (!size1.equals(size2)) {
                	if(!fileName.contains("$"))
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

    private static final int BUFFER_SIZE = 1024;
    private Map<String, String> getFileSizes(File warFile) throws IOException {
    	Map<String, String> fileHashes = new HashMap<String, String>();
    	try {
            fileHashes = getFileHashes(warFile);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return fileHashes;
    }
    
    public static Map<String, String> getFileHashes(File warFile) throws IOException {
        Map<String, String> fileHashes = new HashMap<>();

        try (ZipInputStream zipInputStream = new ZipInputStream(new FileInputStream(warFile))) {
            ZipEntry entry;
            byte[] buffer = new byte[BUFFER_SIZE];
            
            while ((entry = zipInputStream.getNextEntry()) != null) {
                if (!entry.isDirectory()) {
                    // 각 파일의 해시 값을 계산합니다.
                    String hash = calculateFileHash(zipInputStream, buffer);
                    fileHashes.put(entry.getName(), hash);
                }
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        return fileHashes;
    }
    
    private static String calculateFileHash(InputStream inputStream, byte[] buffer) throws Exception {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        int len;
        
        while ((len = inputStream.read(buffer)) > 0) {
            digest.update(buffer, 0, len);
        }

        // 바이트 배열을 16진수 문자열로 변환합니다.
        StringBuilder hashStringBuilder = new StringBuilder();
        for (byte b : digest.digest()) {
            hashStringBuilder.append(String.format("%02x", b));
        }

        return hashStringBuilder.toString();
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
