package controller;/**
 * @Author: wuLong
 * @Date: 2024/12/15/7:48 下午
 * @Description:
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

import com.alibaba.fastjson.JSON;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Picture;
import service.PictureService;
import service.impl.PictureServiceImpl;

@WebServlet("/PictureController")
public class PictureController extends HttpServlet {
    private PictureService pictureService = new PictureServiceImpl();

    /**
     * 分页查询
     * @param request an {@link HttpServletRequest} object that contains the request the client has made of the servlet
     *
     * @param response an {@link HttpServletResponse} object that contains the response the servlet sends to the client
     *
     * @throws ServletException
     * @throws IOException
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String action = request.getParameter("action");
            if ("get".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Picture picture = pictureService.getPictureById(id);
                if (picture != null) {
                    String json = JSON.toJSONString(picture);
                    out.print(json);
                } else {
                    out.print("{\"error\":\"图片不存在\"}");
                }
            } else {
                int page = 1;
                int size = 10;
                String pageParam = request.getParameter("page");
                String sizeParam = request.getParameter("size");
                String query = request.getParameter("query");
                String orderColumn = request.getParameter("orderColumn");
                String orderDir = request.getParameter("orderDir");

                if (pageParam != null && !pageParam.isEmpty()) {
                    page = Integer.parseInt(pageParam);
                }
                if (sizeParam != null && !sizeParam.isEmpty()) {
                    size = Integer.parseInt(sizeParam);
                }

                List<Picture> pictures;
                int totalCount;

                if (query != null && !query.isEmpty()) {
                    pictures = pictureService.searchPictures(query, page, size, orderColumn, orderDir);
                    totalCount = pictureService.getSearchTotalCount(query);
                } else {
                    pictures = pictureService.getAllPictures(page, size, orderColumn, orderDir);
                    totalCount = pictureService.getTotalCount();
                }

                String json = JSON.toJSONString(pictures);
                out.print("{\"totalCount\":" + totalCount + ", \"pictures\":" + json + "}");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 添加或更新图片或删除
     * @param request an {@link HttpServletRequest} object that contains the request the client has made of the servlet
     *
     * @param response an {@link HttpServletResponse} object that contains the response the servlet sends to the client
     *
     * @throws ServletException
     * @throws IOException
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            if ("add".equals(action)) {
                String name = request.getParameter("name");
                // 检查是否存在相同名称的图片
                if (pictureService.isNameExists(name)) {
                    out.print("{\"error\":\"图片名称已存在，添加失败\"}");
                    return;
                }

                Picture picture = new Picture();
                picture.setCategory(request.getParameter("category"));
                picture.setCover(request.getParameter("cover"));
                picture.setName(name);
                picture.setTags(request.getParameter("tags"));
                picture.setUpdateTime(LocalDateTime.now().toString());
                picture.setStatus(Boolean.parseBoolean(request.getParameter("status")));
                pictureService.addPicture(picture);
                out.print("{\"success\":true}");
            } else if ("update".equals(action)) {
                Picture picture = new Picture();
                picture.setId(Integer.parseInt(request.getParameter("id")));
                picture.setCategory(request.getParameter("category"));
                picture.setCover(request.getParameter("cover"));
                picture.setName(request.getParameter("name"));
                picture.setTags(request.getParameter("tags"));
                picture.setUpdateTime(LocalDateTime.now().toString());
                picture.setStatus(Boolean.parseBoolean(request.getParameter("status")));
                pictureService.updatePicture(picture);
                out.print("{\"success\":true}");
            } else if ("delete".equals(action)) {
                String[] ids = request.getParameter("ids").split(",");
                for (String id : ids) {
                    pictureService.deletePicture(Integer.parseInt(id));
                }
                out.print("{\"success\":true}");
            } else if ("updateStatus".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean status = Boolean.parseBoolean(request.getParameter("status"));
                pictureService.updatePictureStatus(id, status);
                out.print("{\"success\":true}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"error\":\"操作失败\"}");
        }
    }
}
