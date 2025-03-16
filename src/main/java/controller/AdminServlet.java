package controller;

import bean.Admin;
import com.alibaba.fastjson.JSON;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.AdminService;
import util.Page;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.stream.Collectors;


@WebServlet("/adminServlet")
public class AdminServlet extends HttpServlet {

    private AdminService adminService = new AdminService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String id = request.getParameter("id");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        Admin admin = new Admin();
        admin.setUsername(username);
        admin.setPassword(password);
        admin.setEmail(email);
        admin.setCreatedTime(new java.sql.Timestamp(System.currentTimeMillis()));
        try {
            if (id == null || id.isEmpty()) {
                adminService.addAdmin(admin);
            } else {
                admin.setId(Integer.parseInt(id));
                adminService.updateAdmin(admin);
            }
        }catch (Exception e) {
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("error");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("getByUsername".equals(action)) {
            String username = (request.getParameter("username"));
            List<Admin> list = adminService.list();
            List<Admin> adminList = list.stream().filter(admin -> admin.getUsername().contains(username)).collect(Collectors.toList());

            String json = JSON.toJSONString(adminList);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(json);
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            Admin admin = new Admin();
            admin.setId(id);
            admin.setUsername(username);
            admin.setPassword(password);
            admin.setEmail(email);
            try {
                adminService.updateAdmin(admin);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            response.sendRedirect("success.jsp");
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            adminService.deleteAdmin(id);
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else if ("list".equals(action)) {
            String pageNo = request.getParameter("pageNo");
            String pageSize = request.getParameter("pageSize");
            String searchInput=request.getParameter("searchInput");
            String sortOrder=request.getParameter("sortOrder");

            Page<Admin> p = adminService.pageList(Integer.valueOf(pageNo), Integer.valueOf(pageSize),searchInput,sortOrder);

            String json = JSON.toJSONString(p);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(json);
        } else if ("getById".equals(action)) {
            String id = request.getParameter("id");
            List<Admin> list = adminService.list();
            //找出一个admin，通过id
            Admin admin = list.stream().filter(a -> a.getId() == Integer.parseInt(id)).findFirst().get();
            String json = JSON.toJSONString(admin);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(json);
        }
    }
}