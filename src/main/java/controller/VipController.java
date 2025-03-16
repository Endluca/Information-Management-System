package controller;


import bean.Vip;
import com.alibaba.fastjson.JSON;
import dao.VipDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.Page;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/vipServlet")
public class VipController extends HttpServlet {
    private VipDAO vipDAO = new VipDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       /* id          int auto_increment
        primary key,
        username    varchar(255)                        null,
        gender      varchar(255)                        null,
        phone       varchar(255)                        null,
        email       varchar(255)                        null,
        address     varchar(255)                        null,
        createdTime timestamp default CURRENT_TIMESTAMP null
*/
        String id = request.getParameter("id");
        String username = request.getParameter("username");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        Vip vip = new Vip();
        vip.setUsername(username);
        vip.setGender(gender);
        vip.setPhone(phone);
        vip.setEmail(email);
        vip.setAddress(address);
        vip.setCreatedTime(new Timestamp(System.currentTimeMillis()));
        // 查询当前用户名是否存在
        boolean flag = vipDAO.isExistByUsername(username);
        if (flag) {//存在
            response.setCharacterEncoding("UTF-8");
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(JSON.toJSONString(username+"已经存在！"));
            return;
        }
        try {
            if (id != null && !id.isEmpty()) {
                vip.setId(Integer.parseInt(id));
                vipDAO.updateVip(vip);
            } else {
                vipDAO.addVip(vip);
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
        if ("getById".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Vip vip = vipDAO.getVipById(id);
            String json = JSON.toJSONString(vip);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(json);
        } else if ("update".equals(action)) {

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            vipDAO.deleteVipByIsDeleted(id);
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }else if ("delete2".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            vipDAO.deleteVip(id);
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else if ("list".equals(action)) {
            String pageNo = request.getParameter("pageNo");
            String pageSize = request.getParameter("pageSize");
            String searchInput=request.getParameter("searchInput");
            String sortOrder=request.getParameter("sortOrder");
            Page<Vip> p = vipDAO.getAllVipsPage(Integer.valueOf(pageNo), Integer.valueOf(pageSize),searchInput,sortOrder);
            //List<Vip> list = vipDAO.getAllVips();
            String json = JSON.toJSONString(p);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(json);
        }else if ("getByUsername".equals(action)){
            String username = (request.getParameter("username"));
            List<Vip> collect = vipDAO.getAllVips().stream().filter(vip -> vip.getUsername().contains(username)).collect(Collectors.toList());
            String json = JSON.toJSONString(collect);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(json);
        } else if ("deletedList".equals(action)) {
            String pageNo = request.getParameter("pageNo");
            String pageSize = request.getParameter("pageSize");
            String searchInput=request.getParameter("searchInput");

            Page<Vip> p = vipDAO.getAllVips2Page(Integer.valueOf(pageNo), Integer.valueOf(pageSize),searchInput);

            //List<Vip> allVips = vipDAO.getAllVips2();
            //List<Vip> collect = allVips.stream().filter(vip -> !vip.getIsDeleted().equals("否")).collect(Collectors.toList());
            String json = JSON.toJSONString(p);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(json);
        } else if ("getByUsernameDeleted".equals(action)) {
            String username = (request.getParameter("username"));
           List<Vip> allVips = vipDAO.getAllVips2();
            List<Vip> result = allVips.stream().filter(vip -> vip.getIsDeleted().equals("yes") && vip.getUsername().contains(username)).collect(Collectors.toList());

            String json = JSON.toJSONString(result);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(json);
        }
    }
}
