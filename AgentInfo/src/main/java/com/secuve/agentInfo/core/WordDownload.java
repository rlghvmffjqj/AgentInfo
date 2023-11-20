package com.secuve.agentInfo.core;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigInteger;
import java.util.List;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.util.Units;

import javax.xml.bind.DatatypeConverter;

import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFPicture;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STMerge;
import org.springframework.stereotype.Service;
import org.w3c.tidy.Tidy;

import com.secuve.agentInfo.vo.FunctionTestSetting;

@Service
public class WordDownload {
    public static void makeWord(List<FunctionTestSetting> functionTestSettingList, String dest) throws Exception {
    	try {
            // Create a new Word document
            XWPFDocument document = new XWPFDocument();
            
            // Create a paragraph
            XWPFParagraph paragraph = document.createParagraph();

            // Create a run
            XWPFRun run = paragraph.createRun();

            // Create a table
            XWPFTable table = document.createTable();

            // Create first row
            XWPFTableRow row1 = table.getRow(0);
            row1.getCell(0).setText("대항목");
            row1.addNewTableCell().setText("");
            row1.addNewTableCell().setText("중항목");
            row1.addNewTableCell().setText("");

            // Create second row
            XWPFTableRow row2 = table.createRow();
            row2.getCell(0).setText("소항목");
            row2.getCell(1).setText("");
            row2.getCell(2).setText("테스트 결과");
            row2.getCell(3).setText("");
            
            XWPFTableRow row3 = table.createRow();
            row3.getCell(0).setText("사전 테스트 준비");
            row3.getCell(1).setText("");
            row3.getCell(2).setText("");
            row3.getCell(3).setText("");
            
            mergeCellsHorizontally(row3, 1, 2);
            mergeCellsHorizontally(row3, 2, 3);
            
            XWPFTableRow row4 = table.createRow();
            row4.getCell(0).setText("테스트 절차");
            row4.getCell(1).setText("");
            addImageToCell(row4.getCell(1), functionTestSettingList.get(1).getFunctionTestSettingDetailMethod());
            row4.getCell(2).setText("");
            row4.getCell(3).setText("");
            
            mergeCellsHorizontally(row4, 1, 2);
            mergeCellsHorizontally(row4, 2, 3);
            
            XWPFTableRow row5 = table.createRow();
            row5.getCell(0).setText("예상 테스트 결과");
            row5.getCell(1).setText("");
            row5.getCell(2).setText("");
            row5.getCell(3).setText("");
            
            mergeCellsHorizontally(row5, 1, 2);
            mergeCellsHorizontally(row5, 2, 3);
            
            XWPFTableRow row6 = table.createRow();
            row6.getCell(0).setText("테스트 결과");
            row6.getCell(1).setText("");
            row6.getCell(2).setText("");
            row6.getCell(3).setText("");
            
            mergeCellsHorizontally(row6, 1, 2);
            mergeCellsHorizontally(row6, 2, 3);
            
            
            XWPFTableRow row7 = table.createRow();
            row7.getCell(0).setText("비고");
            row7.getCell(1).setText("");
            row7.getCell(2).setText("");
            row7.getCell(3).setText("");
            
            mergeCellsHorizontally(row7, 1, 2);
            mergeCellsHorizontally(row7, 2, 3);
            
            
            // Set column widths
            setColumnWidths(table, 3f, 3f, 3f, 3f);

            // Set table width to 100%
            //table.setWidth("100%");

            // Save the document to a file
            FileOutputStream out = new FileOutputStream(dest);
            document.write(out);
            out.close();

            System.out.println("Word document created successfully!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private static void addImageToCell(XWPFTableCell cell, String htmlImageCode) throws IOException, InvalidFormatException {
        byte[] imageData = extractImageDataFromHtml(htmlImageCode);

        int imageType = XWPFDocument.PICTURE_TYPE_PNG;

        int imageWidth = 100; // 이미지 폭 조절
        int imageHeight = 100; // 이미지 높이 조절

        // 이미지를 바이트 배열로 추가
        XWPFPicture picture = cell.addParagraph().createRun().addPicture(new ByteArrayInputStream(imageData), imageType, "image.png", Units.toEMU(imageWidth), Units.toEMU(imageHeight));
    }

    private static byte[] extractImageDataFromHtml(String htmlImageCode) {
        // HTML 코드에서 이미지 데이터 추출 (Base64로 인코딩된 이미지로 가정)
        String base64ImageData = htmlImageCode.substring(htmlImageCode.indexOf(",") + 1);
        return DatatypeConverter.parseBase64Binary(base64ImageData);
    }

    // Method to merge cells horizontally in a table
    private static void mergeCellsHorizontally(XWPFTableRow row, int fromCol, int toCol) {
        for (int colIndex = fromCol; colIndex <= toCol; colIndex++) {
            XWPFTableCell cell = row.getCell(colIndex);
            
            if (colIndex == fromCol) {
                // The first cell in the merged range retains its content
                cell.getCTTc().addNewTcPr().addNewHMerge().setVal(STMerge.RESTART);
            } else {
                // Cells in the merged range are set to empty
                cell.getCTTc().addNewTcPr().addNewHMerge().setVal(STMerge.CONTINUE);
                cell.setText("");
            }
        }
    }
    
    // Method to set column widths in a table
    private static void setColumnWidths(XWPFTable table, float... widths) {
        for (int i = 0; i < widths.length; i++) {
            table.getRow(0).getCell(i).getCTTc().addNewTcPr().addNewTcW().setW(BigInteger.valueOf((long)(widths[i] * 1440)));
        }
    }
}
