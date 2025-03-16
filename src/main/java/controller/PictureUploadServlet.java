package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/uploadPicture")
@MultipartConfig
public class PictureUploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 服务器存储图片的路径
    private static final String UPLOAD_DIRECTORY = "/uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 创建文件保存的目录
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        try {
            // 获取上传的文件
            Part filePart = request.getPart("file");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String filePath = uploadPath + File.separator + fileName;
            File storeFile = new File(filePath);

            // 保存文件到硬盘
            filePart.write(filePath);

            // 输出上传后的文件 URL
            String fileUrl = request.getContextPath() + UPLOAD_DIRECTORY + "/" + fileName;
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write("{\"fileUrl\": \"" + fileUrl + "\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"error\": \"File upload failed\"}");
        }
    }
}
