package com.secuve.agentInfo.service;

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
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import org.benf.cfr.reader.api.CfrDriver;
import org.benf.cfr.reader.api.OutputSinkFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StreamUtils;
import org.springframework.web.multipart.MultipartFile;

import com.secuve.agentInfo.dao.PackageAnalysisDao;

@Service
public class PackageAnalysisService {
	@Autowired
	PackageAnalysisDao packageAnalysisDao;
	
	public File saveUploadedFile(MultipartFile file, String tempDir) throws IOException {
        String originalFileName = file.getOriginalFilename();
        File destFile = new File(tempDir + File.separator + originalFileName);
        file.transferTo(destFile);
        extractAndSaveFile(destFile, tempDir);
        return destFile;
    }

	public List<String> compareFileSizes(File file1, File file2) throws IOException {
        List<String> differentFiles = new ArrayList<>();

        Map<String, String> fileSizes1 = getFileSizes(file1);
        Map<String, String> fileSizes2 = getFileSizes(file2);
        
        for (String fileName : fileSizes2.keySet()) {
            if (fileSizes1.containsKey(fileName)) {
                String size1 = fileSizes1.get(fileName);
                String size2 = fileSizes2.get(fileName);

                if (!size1.equals(size2)) {
                	if(!fileName.contains("$")) {
                		if(fileName.contains(".class"))
                			fileName = fileName.replace(".class", ".java");
                		differentFiles.add(fileName);
                	}
                }
            } else {
            	if(fileName.contains(".class"))
        			fileName = fileName.replace(".class", ".java");
            	differentFiles.add(fileName);
            }
        }
        
        for (String fileName : fileSizes1.keySet()) {
            if (!fileSizes2.containsKey(fileName)) {
            	if(fileName.contains(".class"))
        			fileName = fileName.replace(".class", ".java");
            	differentFiles.add(fileName);
            }
        }

        return differentFiles;
    }

    private static final int BUFFER_SIZE = 1024;
    public Map<String, String> getFileSizes(File warFile) throws IOException {
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
    
    public static String calculateFileHash(InputStream inputStream, byte[] buffer) throws Exception {
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

                    if (entryName.endsWith(".class")) {
                        decompileAndSaveClassFile(entryFile, route);
                    } 
	                
                    
                }

                zipInputStream.closeEntry();
            }
        } catch (Exception e) {
			System.out.println(e);
		}
    }
    
    private static void decompileAndSaveClassFile(File classFile, String route) throws IOException {
        String outputPath = classFile.getPath().replace(".class", ".java");

        // Use CFR to decompile the class file
        CfrDriver cfr = new CfrDriver.Builder().withOutputSink(new FileOutputSinkFactory(new File(outputPath))).build();
        List<String> arguments = new ArrayList<>();
        arguments.add(classFile.getAbsolutePath());

        try {
            cfr.analyse(arguments);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private static class FileOutputSinkFactory implements OutputSinkFactory {
        private final File outputFile;

        public FileOutputSinkFactory(File outputFile) {
            this.outputFile = outputFile;
        }

        @Override
        public List<SinkClass> getSupportedSinks(SinkType sinkType, Collection<SinkClass> collection) {
            return null;
        }

        @Override
        public <T> Sink<T> getSink(SinkType sinkType, SinkClass sinkClass) {
            return new FileSink<>(outputFile);
        }

        private static class FileSink<T> implements Sink<T> {
            private final File outputFile;

            public FileSink(File outputFile) {
                this.outputFile = outputFile;
            }

            @Override
            public void write(T t) {
                try {
                    Files.write(Paths.get(outputFile.toURI()), t.toString().getBytes());
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }


}
