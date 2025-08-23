package com.capstone.controller;

import com.capstone.dto.OrderDTO;
import com.capstone.dto.OrderItemDTO;
import com.capstone.service.OrderService;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;

@Controller
public class PdfController {

    @Autowired
    private OrderService orderService;

    @GetMapping("api/buyer/orders/{orderId}/pdf")
    public void downloadOrderPdf(@PathVariable("orderId") Long orderId,
                                 HttpServletResponse response) {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition",
                "attachment; filename=order-" + orderId + ".pdf");

        try {
            OrderDTO order = orderService.getOrderDTO(orderId);
            Document document = new Document(PageSize.A4, 40, 40, 40, 40);
            OutputStream out = response.getOutputStream();
            PdfWriter.getInstance(document, out);
            document.open();

            if (order == null) {
                document.add(new Paragraph("No order found for ID: " + orderId));
                document.close();
                return;
            }

            // Header
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16);
            document.add(new Paragraph("Order #" + order.getOrderId(), titleFont));
           document.add(new Paragraph("Name : "+order.getBuyerName() ,titleFont ));
            document.add(new Paragraph("Status: " + order.getStatus()));
            document.add(new Paragraph("Date: " + order.getOrderDate()));
            document.add(new Paragraph("Shipping: " + order.getShippingAddress()));
            document.add(new Paragraph("Total: ₹" + order.getTotalAmount()));
            document.add(new Paragraph(" "));

            // Products table
            PdfPTable table = new PdfPTable(4);
            table.setWidthPercentage(100);
            table.addCell("Product");
            table.addCell("Quantity");
            table.addCell("Seller");
            table.addCell("Price");
            
            for (OrderItemDTO item : order.getItems()) {
                table.addCell(item.getProductName());
                table.addCell(String.valueOf(item.getQuantity()));
                table.addCell(item.getSellerName());
                table.addCell("₹" + item.getPrice());
            }

            document.add(table);
            document.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
