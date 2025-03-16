package controller;

import bean.Admin;
import dao.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private AdminDAO adminDAO = new AdminDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Integer errorCount = (Integer) request.getSession().getAttribute("errorCount");
        if (errorCount == null) {
            errorCount = 0;
        }

        Admin admin = adminDAO.login(username, password);

        if (admin == null) {
            errorCount++;
            request.getSession().setAttribute("errorCount", errorCount);
            request.setAttribute("errorMessage", "用户名或密码错误！");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.getSession().setAttribute("admin", admin);
            request.getSession().setAttribute("errorCount", 0); // 登录成功后重置错误次数
            response.sendRedirect("index.jsp");
        }
    }

}
