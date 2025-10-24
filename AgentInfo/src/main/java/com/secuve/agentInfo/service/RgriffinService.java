package com.secuve.agentInfo.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.RgriffinDao;
import com.secuve.agentInfo.vo.LogGriffin;
import com.secuve.agentInfo.vo.Rgriffin;
import com.secuve.agentInfo.vo.SendMailSetting;

@Service
public class RgriffinService {
	@Autowired RgriffinDao rgriffinDao;
	@Autowired MailSendService mailSendService;

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

	public String individualMailSend(int licenseKeyNum) {
		SendMailSetting sendMailSetting = mailSendService.getTargetSetting("rgriffin");
		List<String> toList = new ArrayList<>();
		String[] cc = sendMailSetting.getSendMailSettingIssuance().split(",");
		Rgriffin rgriffin = rgriffinDao.getLicenseOne(licenseKeyNum); 
		
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("licenseManager", sendMailSetting.getSendMailSettingManager());
		paramMap.put("cc", sendMailSetting.getSendMailSettingIssuance());
		try {
			if("on".equals(sendMailSetting.getSendMailSettingRequester()) && !"".equals(rgriffin.getRequesterId()) && rgriffin.getRequesterId() != null) {
				toList.add(rgriffin.getRequesterId());
			}
			if("on".equals(sendMailSetting.getSendMailSettingSalesManager()) && !"".equals(rgriffin.getSalesManagerId()) && rgriffin.getSalesManagerId() != null) {
				toList.add(rgriffin.getSalesManagerId());
			}
			long remainingDays = mailSendService.getRemainingDays(rgriffin.getRgriffinExpire());
			paramMap.put("licenseSubject", sendMailSetting.getSendMailSettingSubject());
			String mailContent =
					"[라이선스 만료 안내]<br><br>"
					+ "담당 고객에서 사용 중인 rGRIFFIN 라이선스의 만료일이 "+remainingDays+"일 남았음을 알려드립니다.<br>"
					+ "서비스 중단이 발생하지 않도록 만료 전에 갱신 절차를 진행해주시기 바랍니다.<br><br>"
					+ "- 고객사 명 : "+rgriffin.getRgriffinCompany()+"<br>"
					+ "- 카테고리 명 : "+rgriffin.getRgriffinCategory()+"<br>"
					+ "- 라이선스 명 : rGRIFFIN <br>"
					+ "- 만료 예정일 : "+rgriffin.getRgriffinExpire()+"<br>"
					+ "- 남은 기간 : "+remainingDays+"일<br><br>"
					+ "관련 문의는 시스템 관리자(litsong@secuve.com)에게 연락해주시기 바랍니다.<br><br>"
					+ "※ 본 메일은 시스템에서 자동으로 발송되었습니다. 회신하지 마십시오.";
			paramMap.put("text", mailContent);
			mailSendService.mailSendPeriodScheduleJob(paramMap, toList, cc);
		} catch (Exception e) {
			e.printStackTrace(); // 로그용
	        return "FALSE";
		}
		return "OK";
	}


}
