package dao.impl;

import dao.PictureDao;
import model.Picture;
import util.DataBaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PictureDaoImpl implements PictureDao {
    @Override
    public List<Picture> getAllPictures(int page, int size, String orderColumn, String orderDir) throws Exception {
        List<Picture> pictures = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DataBaseUtil.getConnection();

            // 确保 orderColumn 和 orderDir 不为 null
            if (orderColumn == null || orderColumn.isEmpty()) {
                orderColumn = "id"; // 默认排序列
            }
            if (orderDir == null || orderDir.isEmpty() || (!"ASC".equalsIgnoreCase(orderDir) && !"DESC".equalsIgnoreCase(orderDir))) {
                orderDir = "ASC"; // 默认排序方向
            }

            String sql = "SELECT * FROM pictures ORDER BY " + orderColumn + " " + orderDir + " LIMIT ?, ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, (page - 1) * size);
            ps.setInt(2, size);
            rs = ps.executeQuery();

            while (rs.next()) {
                Picture picture = new Picture();
                picture.setId(rs.getInt("id"));
                picture.setCategory(rs.getString("category"));
                picture.setCover(rs.getString("cover"));
                picture.setName(rs.getString("name"));
                picture.setTags(rs.getString("tags"));
                picture.setUpdateTime(rs.getString("updateTime"));
                picture.setStatus(rs.getBoolean("status"));
                pictures.add(picture);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 关闭资源
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return pictures;
    }

    @Override
    public int getTotalCount() throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int count = 0;

        try {
            conn = DataBaseUtil.getConnection();
            String sql = "SELECT COUNT(*) FROM pictures";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } finally {
            DataBaseUtil.close(rs, ps, conn);
        }
        return count;
    }

    @Override
    public void addPicture(Picture picture) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DataBaseUtil.getConnection();
            String sql = "INSERT INTO pictures (category, cover, name, tags, updateTime, status) VALUES (?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, picture.getCategory());
            ps.setString(2, picture.getCover());
            ps.setString(3, picture.getName());
            ps.setString(4, picture.getTags());
            ps.setString(5, picture.getUpdateTime());
            ps.setBoolean(6, picture.isStatus());
            ps.executeUpdate();
        } finally {
            DataBaseUtil.close(null, ps, conn);
        }
    }

    @Override
    public void updatePicture(Picture picture) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DataBaseUtil.getConnection();
            String sql = "UPDATE pictures SET category = ?, cover = ?, name = ?, tags = ?, updateTime = ?, status = ? WHERE id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, picture.getCategory());
            ps.setString(2, picture.getCover());
            ps.setString(3, picture.getName());
            ps.setString(4, picture.getTags());
            ps.setString(5, picture.getUpdateTime());
            ps.setBoolean(6, picture.isStatus());
            ps.setInt(7, picture.getId());
            ps.executeUpdate();
        } finally {
            DataBaseUtil.close(null, ps, conn);
        }
    }

    @Override
    public void deletePicture(int id) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DataBaseUtil.getConnection();
            String sql = "DELETE FROM pictures WHERE id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } finally {
            DataBaseUtil.close(null, ps, conn);
        }
    }

    @Override
    public void updatePictureStatus(int id, boolean status) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DataBaseUtil.getConnection();
            String sql = "UPDATE pictures SET status = ? WHERE id = ?";
            ps = conn.prepareStatement(sql);
            ps.setBoolean(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        } finally {
            DataBaseUtil.close(null, ps, conn);
        }
    }

    @Override
    public Picture getPictureById(int id) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Picture picture = null;

        try {
            conn = DataBaseUtil.getConnection();
            String sql = "SELECT * FROM pictures WHERE id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                picture = new Picture();
                picture.setId(rs.getInt("id"));
                picture.setCategory(rs.getString("category"));
                picture.setCover(rs.getString("cover"));
                picture.setName(rs.getString("name"));
                picture.setTags(rs.getString("tags"));
                picture.setUpdateTime(rs.getString("updateTime"));
                picture.setStatus(rs.getBoolean("status"));
            }
        } finally {
            DataBaseUtil.close(rs, ps, conn);
        }
        return picture;
    }

    @Override
    public List<Picture> searchPictures(String query, int page, int size, String orderColumn, String orderDir) throws Exception {
        List<Picture> pictures = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        // 确保 orderColumn 和 orderDir 不为 null
        if (orderColumn == null || orderColumn.isEmpty()) {
            orderColumn = "id"; // 默认排序列
        }
        if (orderDir == null || orderDir.isEmpty() || (!"ASC".equalsIgnoreCase(orderDir) && !"DESC".equalsIgnoreCase(orderDir))) {
            orderDir = "ASC"; // 默认排序方向
        }
        try {
            conn = DataBaseUtil.getConnection();
            String sql = "SELECT * FROM pictures WHERE id LIKE ? OR category LIKE ? OR name LIKE ? ORDER BY " + orderColumn + " " + orderDir + " LIMIT ?, ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");
            ps.setString(3, "%" + query + "%");
            ps.setInt(4, (page - 1) * size);
            ps.setInt(5, size);
            rs = ps.executeQuery();

            while (rs.next()) {
                Picture picture = new Picture();
                picture.setId(rs.getInt("id"));
                picture.setCategory(rs.getString("category"));
                picture.setCover(rs.getString("cover"));
                picture.setName(rs.getString("name"));
                picture.setTags(rs.getString("tags"));
                picture.setUpdateTime(rs.getString("updateTime"));
                picture.setStatus(rs.getBoolean("status"));
                pictures.add(picture);
            }
        } finally {
            DataBaseUtil.close(rs, ps, conn);
        }
        return pictures;
    }

    @Override
    public int getSearchTotalCount(String query) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int count = 0;

        try {
            conn = DataBaseUtil.getConnection();
            String sql = "SELECT COUNT(*) FROM pictures WHERE id LIKE ? OR category LIKE ? OR name LIKE ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");
            ps.setString(3, "%" + query + "%");
            rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } finally {
            DataBaseUtil.close(rs, ps, conn);
        }
        return count;
    }


} 