package service;

import bean.Admin;
import dao.AdminDAO;
import util.Page;

import java.sql.SQLException;
import java.util.List;

public class AdminService {

    private AdminDAO adminDAO = new AdminDAO();

    public void addAdmin(Admin admin) throws SQLException {
        adminDAO.addAdmin(admin);
    }

    public Admin getAdminById(String username) {
        return adminDAO.getAdminById(username);
    }

    public void updateAdmin(Admin admin) throws SQLException {
        adminDAO.updateAdmin(admin);
    }

    public void deleteAdmin(int id) {
        adminDAO.deleteAdmin(id);
    }

    public List<Admin> list() {
        return adminDAO.list();
    }
    public Page<Admin> pageList(Integer pageNo,Integer pageSize,String searchInput,String sortOrder) {
        return adminDAO.pageList(pageNo,pageSize,searchInput,sortOrder);
    }
}