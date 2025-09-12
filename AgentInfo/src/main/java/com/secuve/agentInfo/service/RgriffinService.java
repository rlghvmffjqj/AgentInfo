package com.secuve.agentInfo.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.RgriffinDao;
import com.secuve.agentInfo.vo.Rgriffin;

@Service
public class RgriffinService {
	@Autowired RgriffinDao rgriffinDao;

	public String licenseInsert(Rgriffin license) {
		int success = rgriffinDao.licenseInsert(license);
		if(success > 0) {
			return "OK";
		} else {
			return "FALSE";
		}
	}
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public List<Rgriffin> getLicenseList(Rgriffin search) {
		 return rgriffinDao.getLicenseList(search);
	}

	public int getLicenseListCount(Rgriffin search) {
		return rgriffinDao.getLicenseListCount(search);
	}

	public String delLicense(int[] chkList, Principal principal) {
		for (int rgriffinKeyNum : chkList) {
			int success = rgriffinDao.delLicense(rgriffinKeyNum);

			// 로그 기록
			if (success > 0) {
			} else if (success <= 0) {
				return "FALSE";
			}
		}
		return "OK";
	}

	public Rgriffin getLicenseOne(int rgriffinKeyNum) {
		return rgriffinDao.getLicenseOne(rgriffinKeyNum);
	}

	public String updateLicense(Rgriffin license, Principal principal) {
		int success = rgriffinDao.updateLicense(license);
		if(success > 0) {
			return "OK";
		} else {
			return "FALSE";
		}
	}

	public List<Object> listAll(Rgriffin license) {
		return rgriffinDao.listAll(license);
	}

	public String licenseIssuance(Rgriffin license) throws IOException {
        String jarPath = "C:\\License\\LicenseGenerator-0.0.1.jar";

        String[] command = {
                "java",
                "-jar",
                jarPath,
                license.getRgriffinCompanyView(),
                license.getRgriffinCategoryView(),
                license.getRgriffinExpireView(),
                license.getRgriffinQuantityView(),
                license.getRgriffinRgmsidView(),
                license.getRgriffinPasswordView()
        };
        boolean isSuccess = false;

        try {
            ProcessBuilder pb = new ProcessBuilder(command);

            pb.directory(new File("C:\\License"));
            pb.redirectErrorStream(true); // 표준 오류와 표준 출력 합치기

            Process process = pb.start();

            try (BufferedReader reader = new BufferedReader(
                    new InputStreamReader(process.getInputStream(), "UTF-8"))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    System.out.println("[LicenseGenerator] " + line);
                    
                    // 로그에서 실패 메시지 감지
                    if (line.contains("Make Signature Fail") || line.contains("ERROR")) {
                        isSuccess = false;
                    }

                    // 로그에서 성공 메시지 감지
                    if (line.contains("licenseFilePath")) {
                        isSuccess = true;
                    }
                }
            }

            int exitCode = process.waitFor();
            System.out.println("LicenseGenerator 종료 코드: " + exitCode);
            File licenseFile = new File("C:\\License\\backup\\"+license.getRgriffinCompanyView()+".json");
            
            if (isSuccess && !licenseFile.exists()) {
                System.out.println("라이선스 파일이 존재하지 않아 발급 실패로 간주");
                isSuccess = false;
            }

        } catch (Exception e) {
            e.printStackTrace();
            isSuccess = false;
        }
        if(isSuccess) {
        	String fileName = license.getRgriffinCompanyView() + ".json";
            String filePath = "C:\\License\\backup\\" + fileName;
            File file = new File(filePath);
            
            if (file.exists()) {
            	license.setRgriffinContent(new String(Files.readAllBytes(file.toPath()), StandardCharsets.UTF_8));
            }
            file = new File("C:\\License\\License.json");
            if (file.exists()) {
                file.delete();
            }
        	return licenseInsert(license);
        }
        return "FALSE";
    }

	public String downLoadCheck(int[] chkList) {
		Rgriffin rgriffin = rgriffinDao.getLicenseOne(chkList[0]);
		if("".equals(rgriffin.getRgriffinContent()) || rgriffin.getRgriffinContent() == "") {
			return "FALSE";
		}
		return "OK";
	}


}
