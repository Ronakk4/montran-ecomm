package com.capstone.controller;

import com.capstone.dto.SellerOrderDTO;
import com.capstone.dto.OrderItemDTO;
import com.capstone.service.OrderService;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

@Controller
public class ExportController {

    @Autowired
    private OrderService orderService;

    @GetMapping("/seller/orders/excel")
    public void downloadSellerOrdersExcel(@RequestParam("sellerId") Long sellerId,
                                          HttpServletResponse response) throws IOException {

        List<SellerOrderDTO> orders = orderService.getOrdersForSeller(sellerId);

        try (XSSFWorkbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Orders");

            // Header
            Row headerRow = sheet.createRow(0);
            headerRow.createCell(0).setCellValue("Order ID");
            headerRow.createCell(1).setCellValue("Order Date");
            headerRow.createCell(2).setCellValue("Shipping Address");
            headerRow.createCell(3).setCellValue("Status");
            headerRow.createCell(4).setCellValue("Total Amount");

            int rowNum = 1;
            for (SellerOrderDTO order : orders) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(order.getOrderId());

                row.createCell(1).setCellValue(order.getOrderDate() != null
                        ? order.getOrderDate().toString()
                        : "");

                // sanitize to avoid illegal characters
                String address = order.getShippingAddress() != null
                        ? order.getShippingAddress().replaceAll("\\p{Cntrl}", "")
                        : "";
                row.createCell(2).setCellValue(address);

                String status = order.getStatus() != null
                        ? order.getStatus().replaceAll("\\p{Cntrl}", "")
                        : "";
                row.createCell(3).setCellValue(status);
                String  o

                row.createCell(4).setCellValue(order.getTotalAmount());
            }

            // Set response headers BEFORE writing
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment; filename=\"orders.xlsx\"");

            try (ServletOutputStream	 out = response.getOutputStream()) {
                workbook.write(out);
                out.flush();
            }
        }
    }
}
