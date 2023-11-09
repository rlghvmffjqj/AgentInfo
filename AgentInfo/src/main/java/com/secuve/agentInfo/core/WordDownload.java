package com.secuve.agentInfo.core;

import java.io.FileOutputStream;
import java.math.BigInteger;

import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STMerge;
import org.springframework.stereotype.Service;

@Service
public class WordDownload {
    public static void makeWord(String BODY, String dest) throws Exception {
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
            row1.getCell(0).setText("Column 1");
            row1.addNewTableCell().setText("Column 2");
            row1.addNewTableCell().setText("Column 3");

            // Create second row
            XWPFTableRow row2 = table.createRow();
            row2.getCell(0).setText("Data 1");
            row2.getCell(1).setText("Data 2");
            row2.getCell(2).setText("Data 3");

            // Merge cells in the second row
            mergeCellsHorizontally(row2, 0, 1);
            mergeCellsHorizontally(row2, 1, 2);
            
            XWPFTableRow row3 = table.createRow();
            row3.getCell(0).setText("Data 1");
            row3.getCell(1).setText("Data 2");
            row3.getCell(2).setText("Data 3");
            
            mergeCellsHorizontally(row3, 0, 1);
            mergeCellsHorizontally(row3, 1, 2);
            
            // Set column widths
            setColumnWidths(table, 3f, 3f, 3f);

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
