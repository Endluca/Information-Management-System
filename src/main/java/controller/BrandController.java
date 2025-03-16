package controller;

import bean.Admin;
import bean.Brand;
import com.alibaba.fastjson.JSON;
import dao.BrandDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.Page;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/brandServlet")
public class BrandController extends HttpServlet {

    private BrandDAO brandDAO = new BrandDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String brandName = request.getParameter("brand_name");
        String description = request.getParameter("description");
        int sort = Integer.parseInt(request.getParameter("sort"));
        Brand brand = new Brand();

        brand.setBrandName(brandName);
        brand.setDescription(description);
        brand.setSort(sort);
        String id = request.getParameter("id");
        try {
            if (id != null && !id.isEmpty()) {
                brand.setId(Integer.parseInt(id));
                brandDAO.updateBrand(brand);
            } else {
                brandDAO.addBrand(brand);
            }
        } catch (Exception e) {
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("error");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            String action = request.getParameter("action");
            if ("update".equals(action)) {
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    int sort = Integer.parseInt(request.getParameter("sort"));
                    String brandName = request.getParameter("brand_name");
                    String description = request.getParameter("description");

                    Brand brand = new Brand();
                    brand.setId(id);
                    brand.setSort(sort);
                    brand.setBrandName(brandName);
                    brand.setDescription(description);


                    response.sendRedirect("success.jsp"); // 确保这个页面存在
                } catch (NumberFormatException e) {
                    // 处理数字格式错误，可能是 id 或 sort 不是数字
                    response.setContentType("application/json");
                    PrintWriter out = response.getWriter();
                    out.print("{\"error\":\"Invalid number format for id or sort\"}");
                }
            } else if ("getById".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Brand brand = brandDAO.getBrandById(id);
                String json = JSON.toJSONString(brand);
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.print(json);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                brandDAO.deleteBrand(id);
                request.getRequestDispatcher("index.jsp").forward(request, response);
            } else if ("list".equals(action)) {
                String pageNo = request.getParameter("pageNo");
                String pageSize = request.getParameter("pageSize");
                String searchInput = request.getParameter("searchInput");
                String sortOrder = request.getParameter("sortOrder");
                Page<Brand> allBrandsPage = brandDAO.getAllBrandsPage(Integer.valueOf(pageNo), Integer.valueOf(pageSize), searchInput, sortOrder);


                //List<Brand> list = brandDAO.getAllBrands();
                String json = JSON.toJSONString(allBrandsPage);
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.print(json);
            } else if ("getByBrandName".equals(action)) {
                String brandName = request.getParameter("brandName");
                List<Brand> collect = brandDAO.getAllBrands().stream().filter(brand -> brand.getBrandName().contains(brandName)).collect(Collectors.toList());
                String json = JSON.toJSONString(collect);
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.print(json);
            }
        }
    }

