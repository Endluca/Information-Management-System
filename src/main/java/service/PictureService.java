package service;

import model.Picture;
import java.util.List;

public interface PictureService {
    List<Picture> getAllPictures(int page, int size, String orderColumn, String orderDir) throws Exception;
    int getTotalCount() throws Exception;
    void addPicture(Picture picture) throws Exception;
    void updatePicture(Picture picture) throws Exception;
    void deletePicture(int id) throws Exception;
    void updatePictureStatus(int id, boolean status) throws Exception;
    Picture getPictureById(int id) throws Exception;
    List<Picture> searchPictures(String query, int page, int size, String orderColumn, String orderDir) throws Exception;
    int getSearchTotalCount(String query) throws Exception;
    boolean isNameExists(String name) throws Exception;
}