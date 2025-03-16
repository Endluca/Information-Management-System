package dao;

import bean.Admin;
import util.DataBaseUtil;
import util.Page;
import util.StrUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {


    public void addAdmin(Admin admin) throws SQLException {
        String sql = "INSERT INTO admin (username, password, email) VALUES (?,?,?)";
        try (
                Connection connection = DataBaseUtil.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, admin.getUsername());
            preparedStatement.setString(2, admin.getPassword());
            preparedStatement.setString(3, admin.getEmail());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public Admin getAdminById(String username) {
        //like 模糊查询
        String sql = "SELECT * FROM admin WHERE username LIKE ?";

        try (Connection connection = DataBaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, username);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    Admin admin = new Admin();
                    admin.setId(resultSet.getInt("id"));
                    admin.setUsername(resultSet.getString("username"));
                    admin.setPassword(resultSet.getString("password"));
                    admin.setEmail(resultSet.getString("email"));
                    admin.setCreatedTime(resultSet.getTimestamp("created_Time"));
                    return admin;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateAdmin(Admin admin) throws SQLException {

        String sql = "UPDATE admin SET username =?, password =?, email =? WHERE id =?";
        try (Connection connection = DataBaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, admin.getUsername());
            preparedStatement.setString(2, admin.getPassword());
            preparedStatement.setString(3, admin.getEmail());
            preparedStatement.setInt(4, admin.getId());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public void deleteAdmin(int id) {

        String sql = "DELETE FROM admin WHERE id =?";
        try (Connection connection = DataBaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, id);

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Admin> list() {
        String sql = "select * from admin";
        ArrayList<Admin> list = new ArrayList<>();
        try (Connection connection = DataBaseUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                resultSet.getInt("id");
                resultSet.getString("username");
                resultSet.getString("password");
                resultSet.getString("email");
                resultSet.getTimestamp("created_Time");
                Admin admin = new Admin();
                admin.setId(resultSet.getInt("id"));
                admin.setUsername(resultSet.getString("username"));
                admin.setPassword(resultSet.getString("password"));
                admin.setEmail(resultSet.getString("email"));
                admin.setCreatedTime(resultSet.getTimestamp("created_Time"));
                list.add(admin);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    public Page<Admin> pageList(Integer pageNo, Integer pageSize,String searchInput,String sortOrder) {
        Page p=new Page().setPageNo(pageNo).setPageSize(pageSize);

        String sqlCount = "select count(1) num from admin where 1=1 "+(StrUtil.isBlank(searchInput)?"":" and username like '%"+searchInput+"%' ");
        String sqlSelect = "select * from admin where 1=1 "+(StrUtil.isBlank(searchInput)?"":" and username like '%"+searchInput+"%' ");
        System.out.println(sqlSelect);
        if("1".equals(sortOrder)) {
            sqlSelect = sqlSelect + " order by id desc";
        }else{
            sqlSelect = sqlSelect + " order by id asc";
        }
        sqlSelect+=String.format(" limit %s,%s",(pageNo-1)*pageSize,pageSize);
        Connection connection=null;
        try {
            connection = DataBaseUtil.getConnection();
            PreparedStatement preparedStatementCount = connection.prepareStatement(sqlCount);
            PreparedStatement preparedStatementSelect = connection.prepareStatement(sqlSelect);


            ResultSet resultSetCount = preparedStatementCount.executeQuery();
            while (resultSetCount.next()) {
                int totalPage = resultSetCount.getInt("num");
                p.setTotalRow(totalPage);

            }

            List<Admin> list = new ArrayList<>();
            ResultSet resultSet = preparedStatementSelect.executeQuery();

            while (resultSet.next()) {
                resultSet.getInt("id");
                resultSet.getString("username");
                resultSet.getString("password");
                resultSet.getString("email");
                resultSet.getTimestamp("created_Time");
                Admin admin = new Admin();
                admin.setId(resultSet.getInt("id"));
                admin.setUsername(resultSet.getString("username"));
                admin.setPassword(resultSet.getString("password"));
                admin.setEmail(resultSet.getString("email"));
                admin.setCreatedTime(resultSet.getTimestamp("created_Time"));
                list.add(admin);
            }
            p.setList(list);

            if(p.getTotalRow()%pageSize==0){
                p.setTotalPage(p.getTotalRow()/pageSize);
            }else{
                p.setTotalPage(p.getTotalRow()/pageSize+1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            try {
                if (connection!= null) {
                    // 将连接返回给连接池
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return p;

    }


    public Admin login(String username, String password) {
        String sql = "SELECT * FROM admin WHERE username = ? AND password = ?";
        Admin admin = null;
        try (
                Connection connection = DataBaseUtil.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                admin = new Admin();
                admin.setId(resultSet.getInt("id"));
                admin.setUsername(resultSet.getString("username"));
                admin.setPassword(resultSet.getString("password"));
                admin.setEmail(resultSet.getString("email"));
                admin.setCreatedTime(resultSet.getTimestamp("created_Time"));

            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return admin;
    }

//    public static void main(String[] args) {
//        AdminDAO adminDAO = new AdminDAO();
//        System.out.println(adminDAO.login("qwe", "123456"));
//    }
}