package controller;


import bean.Role;
import com.alibaba.fastjson.JSON;
import dao.RoleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.Page;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/roleServlet")
public class RoleController extends HttpServlet {
    private RoleDAO roleDAO = new RoleDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


  String roleName = request.getParameter("roleName");
        String description = request.getParameter("description");
        Role role = new Role();

        role.setRoleName(roleName);
        role.setDescription(description);
        role.setCreatedTime(new Timestamp(System.currentTimeMillis()));
        String id = request.getParameter("id");
        try {
            if (id != null && !id.isEmpty()) {
                role.setId(Integer.parseInt(id));
                roleDAO.updateRole(role);
            } else {
                roleDAO.addRole(role);
            }
        }catch (Exception e) {
            e.printStackTrace();
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("error");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("getById".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Role role = null;
            try {
                role = roleDAO.getRoleById(id);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            String json = JSON.toJSONString(role);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(json);
        } else if ("update".equals(action)) {

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            roleDAO.deleteRole(id);
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else if ("list".equals(action)) {
            String pageNo = request.getParameter("pageNo");
            String pageSize = request.getParameter("pageSize");
            String searchInput=request.getParameter("searchInput");
            String sortOrder=request.getParameter("sortOrder");

            Page<Role> p = roleDAO.getAllRolesPage(Integer.valueOf(pageNo), Integer.valueOf(pageSize),sortOrder);

            String json = JSON.toJSONString(p);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(json);
        }else if ("getByUsername".equals(action)){
            String username = (request.getParameter("username"));
            List<Role> collect = roleDAO.getAllRoles().stream().filter(role -> role.getRoleName().contains(username)).collect(Collectors.toList());
            String json = JSON.toJSONString(collect);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(json);

        }
    }
}
