package com.admin.servlet;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import com.DAO.BookDAOimpl;
import com.DB.DBconnect;
import com.entity.BookDtls;


@MultipartConfig
public class BooksAdd extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String bookName = req.getParameter("bname");
            String author = req.getParameter("author");
            String price = req.getParameter("price");
            String categories = req.getParameter("btype");
            String status = req.getParameter("bstatus");

            // Image file handling
            Part imagePart = req.getPart("bimg");
            String imageFileName = imagePart.getSubmittedFileName();

            // PDF file handling
            Part pdfPart = req.getPart("bpdf");
            String pdfFileName = null;
            if (pdfPart != null && pdfPart.getSize() > 0) {
                pdfFileName = pdfPart.getSubmittedFileName();
            }

            BookDtls b = new BookDtls(bookName, author, price, categories, status, imageFileName, "admin@gmail.com", pdfFileName);

            BookDAOimpl dao = new BookDAOimpl(DBconnect.getConn());
            boolean f = dao.addBooks(b);

            HttpSession session = req.getSession();

            if(f) {
                // Save image file
                String imagePath = getServletContext().getRealPath("") + "book";
                File imageDir = new File(imagePath);
                if (!imageDir.exists()) {
                    imageDir.mkdirs();
                }
                imagePart.write(imagePath + File.separator + imageFileName);

                // Save PDF file if exists
                if (pdfFileName != null) {
                    String pdfPath = getServletContext().getRealPath("") + "pdf";
                    File pdfDir = new File(pdfPath);
                    if (!pdfDir.exists()) {
                        pdfDir.mkdirs();
                    }
                    pdfPart.write(pdfPath + File.separator + pdfFileName);
                }

                session.setAttribute("succMsg", "Book Added Successfully");
                resp.sendRedirect("admin/add_book.jsp");
            } else {
                session.setAttribute("failedMsg", "Something wrong on Server");
                resp.sendRedirect("admin/add_book.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}