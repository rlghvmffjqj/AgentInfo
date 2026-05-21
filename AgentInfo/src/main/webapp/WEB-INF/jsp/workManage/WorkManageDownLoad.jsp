<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html style="height: 100%; background: aliceblue;">
<head>
    <meta charset="utf-8" />
    <%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>

    <title>패키지 다운로드+</title>
    <style>

        body {
            margin: 0;
            padding: 0;
            background-color: #f4f6f9;
            font-family: 'Malgun Gothic', sans-serif;
        }

        .download-wrap {
            width: 900px;
            margin: 60px auto;
        }

        .download-title {
            font-size: 30px;
            font-weight: bold;
            color: #2f5597;
            margin-bottom: 10px;
        }

        .download-sub-title {
            color: #666;
            margin-bottom: 35px;
        }

        .package-card {
            background: #ffffff;
            border-radius: 12px;
            padding: 22px;
            margin-bottom: 18px;
            border: 1px solid #e5e7eb;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);

            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .package-left {
            display: flex;
            flex-direction: column;
        }

        .package-type {
            font-size: 13px;
            font-weight: bold;
            color: #2f5597;
            margin-bottom: 6px;
        }

        .package-name {
            font-size: 18px;
            font-weight: bold;
            color: #222;
        }

        .package-size {
            font-size: 13px;
            color: #888;
            margin-top: 6px;
        }

        .download-btn {
            border: 0;
            background: #2f5597;
            color: white;
            padding: 12px 26px;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.2s;
        }

        .download-btn:hover {
            background: #1f3f73;
        }

        .info-box {
            margin-top: 35px;
            padding: 20px;
            background: white;
            border-radius: 12px;
            border: 1px solid #e5e7eb;
        }

        .info-title {
            font-weight: bold;
            color: #2f5597;
            margin-bottom: 15px;
        }

        .info-content {
            line-height: 1.8;
            color: #444;
        }

        .footer-text {
            margin-top: 25px;
            font-size: 12px;
            color: #999;
            text-align: center;
        }

    </style>

</head>

<body style="background: aliceblue;">

    <div class="download-wrap">
        <div class="download-title">
            패키지 다운로드
        </div>
        <div class="download-sub-title">
            요청된 패키지 파일을 다운로드할 수 있습니다.
        </div>
        
        <c:if test="${not empty workManage.workManagePackageFileOne}">
            <div class="package-card">
                <div class="package-left">
                    <div class="package-type">
                        ${workManage.workManageProductTypeOne}
                    </div>
                    <div class="package-name">
                        ${workManage.workManagePackageNameOne}
                    </div>
                    <div class="package-size">
                        1.2 MB
                    </div>
                </div>
                <button class="download-btn">
                    다운로드
                </button>
            </div>
        </c:if>

        <c:if test="${not empty workManage.workManagePackageFileTwo}">
            <div class="package-card">
                <div class="package-left">
                    <div class="package-type">
                        ${workManage.workManageProductTypeTwo}
                    </div>
                    <div class="package-name">
                        ${workManage.workManagePackageNameTwo}
                    </div>
                    <div class="package-size">
                        1.2 MB
                    </div>
                </div>
                <button class="download-btn">
                    다운로드
                </button>
            </div>
        </c:if>

        <c:if test="${not empty workManage.workManagePackageFileThree}">
            <div class="package-card">
                <div class="package-left">
                    <div class="package-type">
                        ${workManage.workManageProductTypeThree}
                    </div>
                    <div class="package-name">
                        ${workManage.workManagePackageNameThree}
                    </div>
                    <div class="package-size">
                        1.2 MB
                    </div>
                </div>
                <button class="download-btn">
                    다운로드
                </button>
            </div>
        </c:if>

        <c:if test="${not empty workManage.workManagePackageFileFour}">
            <div class="package-card">
                <div class="package-left">
                    <div class="package-type">
                        ${workManage.workManageProductTypeFour}
                    </div>
                    <div class="package-name">
                        ${workManage.workManagePackageNameFour}
                    </div>
                    <div class="package-size">
                        1.2 MB
                    </div>
                </div>
                <button class="download-btn">
                    다운로드
                </button>
            </div>
        </c:if>
        

        <div class="info-box">
            <div class="info-title">
                테스트 정보
            </div>

            <div class="info-content">

                <b>고객사</b> : ${workManage.workManageCustomer}<br>
                <b>엔지니어</b> : ${workManage.workManageEngineer}<br>
                <b>테스트 일정</b> : ${workManage.workManageTestScheduleStart} ~ ${workManage.workManageTestScheduleEnd}<br><br>
                ${workManage.workManageDetailNote}
            </div>
        </div>

        <div class="footer-text">
            패키지는 일정 시간이 지나면 삭제됩니다.
        </div>
    </div>
</body>
</html>