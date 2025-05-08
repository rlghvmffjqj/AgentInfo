package com.secuve.agentInfo.core;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itextpdf.html2pdf.ConverterProperties;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.html2pdf.resolver.font.DefaultFontProvider;
import com.itextpdf.io.font.FontProgram;
import com.itextpdf.io.font.FontProgramFactory;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.AreaBreak;
import com.itextpdf.layout.element.IBlockElement;
import com.itextpdf.layout.element.IElement;
import com.itextpdf.layout.font.FontProvider;

@Service
public class PDFDownlod {
    public void makepdf(String BODY, String dest) throws Exception {
        // 한국어를 표시하기 위해 폰트 경로 지정
        String FONT = "C:\\AgentInfo\\font\\NanumBarunGothic.ttf";
        
        // ConverterProperties: HTML 변환 속성 설정
        ConverterProperties properties = new ConverterProperties();
        FontProvider fontProvider = new DefaultFontProvider(false, false, false);
        
        // 지정한 폰트를 폰트 공급자에 추가
        FontProgram fontProgram = FontProgramFactory.createFont(FONT);
        fontProvider.addFont(fontProgram);
        properties.setFontProvider(fontProvider);

        // HTML을 PDF로 변환하여 IElement 목록을 얻음
        List<IElement> elements = HtmlConverter.convertToElements(BODY, properties);
        
        // PDF 문서 생성 및 크기 조정
        PdfDocument pdf = new PdfDocument(new PdfWriter(dest));
        Document document = new Document(pdf);
        document.setMargins(50, 30, 50, 30); // 페이지 여백 설정 (상, 우, 하, 좌)
        
        // 변환된 IElement 목록을 문서에 추가
        for (IElement element : elements) {
            // HtmlPageBreak를 IBlockElement로 캐스팅할 수 없으므로, 직접 추가
            if (element instanceof IBlockElement) {
                document.add((IBlockElement) element);
            } else {
                // HtmlPageBreak인 경우 처리
                document.add((AreaBreak) element);  // 기본적으로 IElement로 추가
            }
        }
        
        document.close(); // 문서 닫기
    }
}
