package com.user.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import com.DAO.BookDAOimpl;
import com.DB.DBconnect;
import com.entity.BookDtls;


public class PDFDownloadServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            BookDAOimpl bookDAO = new BookDAOimpl(DBconnect.getConn());
            BookDtls book = bookDAO.getBookById(bookId);
            
            if (book != null && book.getPdfFile() != null) {
                String pdfFileName = book.getPdfFile();
                String pdfPath = getServletContext().getRealPath("") + "pdf" + File.separator + pdfFileName;
                
                File pdfFile = new File(pdfPath);
                if (pdfFile.exists()) {
                    // Set response headers
                    response.setContentType("application/pdf");
                    response.setHeader("Content-Disposition", 
                            "attachment; filename=\"" + pdfFileName + "\"");
                    response.setContentLength((int) pdfFile.length());
                    
                    // Stream the PDF file
                    FileInputStream in = new FileInputStream(pdfFile);
                    OutputStream out = response.getOutputStream();
                    
                    byte[] buffer = new byte[4096];
                    int bytesRead;
                    while ((bytesRead = in.read(buffer)) != -1) {
                        out.write(buffer, 0, bytesRead);
                    }
                    
                    in.close();
                    out.flush();
                    out.close();
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "PDF file not found");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Book or PDF not available");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Download failed");
        }
    }
}