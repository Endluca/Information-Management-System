package service.impl;

import dao.PictureDao;
import dao.impl.PictureDaoImpl;
import model.Picture;
import service.PictureService;
import util.DataBaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

public class PictureServiceImpl implements PictureService {
    private PictureDao pictureDao = new PictureDaoImpl();

    @Override
    public List<Picture> getAllPictures(int page, int size, String orderColumn, String orderDir) throws Exception {
        return pictureDao.getAllPictures(page, size,orderColumn,orderDir);
    }

    @Override
    public int getTotalCount() throws Exception {
        return pictureDao.getTotalCount();
    }

    @Override
    public void addPicture(Picture picture) throws Exception {
        pictureDao.addPicture(picture);
    }

    @Override
    public void updatePicture(Picture picture) throws Exception {
        pictureDao.updatePicture(picture);
    }

    @Override
    public void deletePicture(int id) throws Exception {
        pictureDao.deletePicture(id);
    }

    @Override
    public void updatePictureStatus(int id, boolean status) throws Exception {
        pictureDao.updatePictureStatus(id, status);
    }

    @Override
    public Picture getPictureById(int id) throws Exception {
        return pictureDao.getPictureById(id);
    }

    @Override
    public List<Picture> searchPictures(String query, int page, int size, String orderColumn, String orderDir) throws Exception {
        return pictureDao.searchPictures(query, page, size,orderColumn,orderDir);
    }

    @Override
    public int getSearchTotalCount(String query) throws Exception {
        return pictureDao.getSearchTotalCount(query);
    }
    @Override
    public boolean isNameExists(String name) throws Exception {
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            boolean exists = false;

            try {
                conn = DataBaseUtil.getConnection();
                String sql = "SELECT COUNT(*) FROM pictures WHERE name = ?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, name);
                rs = ps.executeQuery();

                if (rs.next()) {
                    exists = rs.getInt(1) > 0;
                }
            } finally {
                DataBaseUtil.close(rs, ps, conn);
            }
            return exists;
        }
} 